Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29F943DB66
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 08:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhJ1Gpp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 02:45:45 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:45939 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229694AbhJ1Gpo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 02:45:44 -0400
Received: from [192.168.0.2] (ip5f5aef59.dynamic.kabel-deutschland.de [95.90.239.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1688E61E64846;
        Thu, 28 Oct 2021 08:43:17 +0200 (CEST)
Message-ID: <a9ab1f26-69f6-9f31-8ffb-14a7bfa21505@molgen.mpg.de>
Date:   Thu, 28 Oct 2021 08:43:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v7 1/2] ice: reduce time to read Option ROM CIVD data
Content-Language: en-US
To:     Jacob Keller <jacob.e.keller@intel.com>
References: <20211027232255.669167-1-jacob.e.keller@intel.com>
Cc:     Anthony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org, linux-pci@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20211027232255.669167-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Cc: +linux-pci for ideas how to work with Option ROMs]

Dear Jacob,


On 28.10.21 01:22, Jacob Keller wrote:
> During probe and device reset, the ice driver reads some data from the
> NVM image as part of ice_init_nvm. Part of this data includes a section
> of the Option ROM which contains version information.
> 
> The function ice_get_orom_civd_data is used to locate the '$CIV' data
> section of the Option ROM.
> 
> Timing of ice_probe and ice_rebuild indicate that the
> ice_get_orom_civd_data function takes about 10 seconds to finish
> executing.
> 
> The function locates the section by scanning the Option ROM every 512
> bytes. This requires a significant number of NVM read accesses, since
> the Option ROM bank is 500KB. In the worst case it would take about 1000
> reads. Worse, all PFs serialize this operation during reload because of
> acquiring the NVM semaphore.
> 
> The CIVD section is located at the end of the Option ROM image data.
> Unfortunately, the driver has no easy method to determine the offset
> manually. Practical experiments have shown that the data could be at
> a variety of locations, so simply reversing the scanning order is not
> sufficient to reduce the overall read time.
> 
> Instead, copy the entire contents of the Option ROM into memory. This
> allows reading the data using 4Kb pages instead of 512 bytes at a time.
> This reduces the total number of firmware commands by a factor of 8. In
> addition, reading the whole section together at once allows better
> indication to firmware of when we're "done".
> 
> Re-write ice_get_orom_civd_data to allocate virtual memory to store the
> Option ROM data. Copy the entire OptionROM contents at once using

Option ROM

> ice_read_flash_module. Finally, use this memory copy to scan for the
> '$CIV' section.
> 
> This change significantly reduces the time to read the Option ROM CIVD
> section from ~10 seconds down to ~1 second. This has a significant
> impact on the total time to complete a driver rebuild or probe.

Thank you for taking up the challenge and looking into this, and for 
decreasing the time.

OT: Out of curiosity, how does it work on UEFI systems without using 
Compatibility System Mode (CSM) and just “EFI drivers”?

> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Changes since v6
> * fix a memory leak
> 
> Changes since v5
> * new patch
> 
>   drivers/net/ethernet/intel/ice/ice_nvm.c | 48 ++++++++++++++++++------
>   1 file changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
> index 941bfce97bf4..c5a39aa8ac94 100644
> --- a/drivers/net/ethernet/intel/ice/ice_nvm.c
> +++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
> @@ -619,7 +619,7 @@ static int
>   ice_get_orom_civd_data(struct ice_hw *hw, enum ice_bank_select bank,
>   		       struct ice_orom_civd_info *civd)
>   {
> -	struct ice_orom_civd_info tmp;
> +	u8 *orom_data;

I know the function names use orom, but oprom is already used in other 
subsystems.

>   	int status;
>   	u32 offset;
>   
> @@ -627,36 +627,60 @@ ice_get_orom_civd_data(struct ice_hw *hw, enum ice_bank_select bank,
>   	 * The first 4 bytes must contain the ASCII characters "$CIV".
>   	 * A simple modulo 256 sum of all of the bytes of the structure must
>   	 * equal 0.
> +	 *
> +	 * The exact location is unknown and varies between images but is
> +	 * usually somewhere in the middle of the bank. We need to scan the
> +	 * Option ROM bank to locate it.
> +	 *
> +	 * It's significantly faster to read the entire Option ROM up front
> +	 * using the maximum page size, than to read each possible location
> +	 * with a separate firmware command.
>   	 */
> +	orom_data = vzalloc(hw->flash.banks.orom_size);
> +	if (!orom_data)
> +		return -ENOMEM;
> +
> +	status = ice_read_flash_module(hw, bank, ICE_SR_1ST_OROM_BANK_PTR, 0,
> +				       orom_data, hw->flash.banks.orom_size);
> +	if (status) {
> +		ice_debug(hw, ICE_DBG_NVM, "Unable to read Option ROM data\n");
> +		return status;
> +	}
> +
> +	/* Scan the memory buffer to locate the CIVD data section */
>   	for (offset = 0; (offset + 512) <= hw->flash.banks.orom_size; offset += 512) {
> +		struct ice_orom_civd_info *tmp;
>   		u8 sum = 0, i;
>   
> -		status = ice_read_flash_module(hw, bank, ICE_SR_1ST_OROM_BANK_PTR,
> -					       offset, (u8 *)&tmp, sizeof(tmp));
> -		if (status) {
> -			ice_debug(hw, ICE_DBG_NVM, "Unable to read Option ROM CIVD data\n");
> -			return status;
> -		}
> +		tmp = (struct ice_orom_civd_info *)&orom_data[offset];
>   
>   		/* Skip forward until we find a matching signature */
> -		if (memcmp("$CIV", tmp.signature, sizeof(tmp.signature)) != 0)
> +		if (memcmp("$CIV", tmp->signature, sizeof(tmp->signature)) != 0)
>   			continue;
>   
> +		ice_debug(hw, ICE_DBG_NVM, "Found CIVD section at offset %u\n",
> +			  offset);
> +
>   		/* Verify that the simple checksum is zero */
> -		for (i = 0; i < sizeof(tmp); i++)
> +		for (i = 0; i < sizeof(*tmp); i++)
>   			/* cppcheck-suppress objectIndex */
> -			sum += ((u8 *)&tmp)[i];
> +			sum += ((u8 *)tmp)[i];
>   
>   		if (sum) {
>   			ice_debug(hw, ICE_DBG_NVM, "Found CIVD data with invalid checksum of %u\n",
>   				  sum);
> -			return -EIO;
> +			goto err_invalid_checksum;
>   		}
>   
> -		*civd = tmp;
> +		*civd = *tmp;
> +		vfree(orom_data);
>   		return 0;
>   	}
>   
> +	ice_debug(hw, ICE_DBG_NVM, "Unable to locate CIVD data within the Option ROM\n");
> +
> +err_invalid_checksum:
> +	vfree(orom_data);
>   	return -EIO;
>   }

Please excuse my ignorance. I would have though, that the system 
firmware already put that Option ROM into memory. There is a function 
`pci_map_biosrom()` declared in `arch/x86/include/asm/probe_roms.h` and 
implemented in `arch/x86/kernel/probe_roms.c`, which might be used?


Kind regards,

Paul

