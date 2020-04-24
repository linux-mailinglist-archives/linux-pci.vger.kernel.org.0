Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658031B820D
	for <lists+linux-pci@lfdr.de>; Sat, 25 Apr 2020 00:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgDXWar (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 18:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgDXWar (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 18:30:47 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB2E920728;
        Fri, 24 Apr 2020 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587767446;
        bh=cNN6iiMGHRHen8J7djGfutgW7tXEaz+rxHfeFStZdFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1D20Ac7F6FrMtcddUsy0oiRXQ/Vdbq7r3TSNm8viIFeBLUAV2bWrRu5s3xmteYToB
         S/VMA5LaHlNqgaNJxF4HP+XLbMFMKomKyge78gUleB5HRn/zQEZkUMV2CJguGNRX++
         5hXLWCEo5+6hFWk14uctvDsmUybX/jtrBVqd2S+k=
Date:   Fri, 24 Apr 2020 17:30:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Cc:     bjorn@helgaas.com, yangyicong@hisilicon.com,
        skhan@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] pci: Make return value of pcie_capability_read*()
 consistent
Message-ID: <20200424223044.GA211293@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424142711.2557-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Saheed,

On Fri, Apr 24, 2020 at 04:27:11PM +0200, Bolarinwa Olayemi Saheed wrote:
> pcie_capability_read*() could return 0, -EINVAL, or any of the
> PCIBIOS_* error codes (which are positive).
> This is behaviour is now changed to return only PCIBIOS_* error
> codes on error.
> This is consistent with pci_read_config_*(). Callers can now have
> a consistent way for checking which error has occurred.
> 
> An audit of the callers of this function was made and no case was found
> where there is need for a change within the caller function or their
> dependencies down the heirarchy.
> Out of all caller functions discovered only 8 functions either persist the
> return value of pcie_capability_read*() or directly pass on the return
> value.
> 
> 1.) "./drivers/infiniband/hw/hfi1/pcie.c" :
> => pcie_speeds() line-306
> 
> 	if (ret) {
> 		dd_dev_err(dd, "Unable to read from PCI config\n");
> 		return ret;
> 	}
> 
> remarks: The variable "ret" is the captured return value.
>          This function passes on the return value. The return value was
> 	 store only by hfi1_init_dd() line-15076 in
>          ./drivers/infiniband/hw/hfi1/chip.c and it behave the same on all
> 	 errors. So this patch will not require a change in this function.

Thanks for the analysis, but I don't think it's quite complete.
Here's the call chain I see:

  local_pci_probe
    pci_drv->probe(..)
      init_one                        # hfi1_pci_driver.probe method
        hfi1_init_dd
          pcie_speeds
            pcie_capability_read_dword

If pcie_capability_read_dword() returns any non-zero value, that value
propagates all the way up and is eventually returned by init_one().
init_one() id called by local_pci_probe(), which interprets:

  < 0 as failure
    0 as success, and
  > 0 as "success but warn"

So previously an error from pcie_capability_read_dword() could cause
either failure or "success but warn" for the probe method, and after
this patch those errors will always cause "success but warn".

The current behavior is definitely a bug: if
pci_bus_read_config_word() returns PCIBIOS_BAD_REGISTER_NUMBER, that
causes pcie_capability_read_dword() to also return
PCIBIOS_BAD_REGISTER_NUMBER, which will lead to the probe succeeding
with a warning, when it should fail.

I think the fix is to make pcie_speeds() call pcibios_err_to_errno():

  ret = pcie_capability_read_dword(...);
  if (ret) {
    dd_dev_err(...);
    return pcibios_err_to_errno(ret);
  }

That could be its own separate preparatory patch before this
adjustment to pcie_capability_read_dword().

I didn't look at the other cases below, so I don't know whether they
are similar hidden problems.

> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 79c4a2ef269a..f0baab635b66 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -402,6 +402,10 @@ static bool pcie_capability_reg_implemented(struct pci_dev *dev, int pos)
>   * Note that these accessor functions are only for the "PCI Express
>   * Capability" (see PCIe spec r3.0, sec 7.8).  They do not apply to the
>   * other "PCI Express Extended Capabilities" (AER, VC, ACS, MFVC, etc.)
> + *
> + * On error, this function returns a PCIBIOS_* error code,
> + * you may want to use pcibios_err_to_errno()(include/linux/pci.h)
> + * to convert to a non-PCI code.
>   */
>  int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>  {
> @@ -409,7 +413,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>  
>  	*val = 0;
>  	if (pos & 1)
> -		return -EINVAL;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
>  	if (pcie_capability_reg_implemented(dev, pos)) {
>  		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
> @@ -444,7 +448,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
>  
>  	*val = 0;
>  	if (pos & 3)
> -		return -EINVAL;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
>  	if (pcie_capability_reg_implemented(dev, pos)) {
>  		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);

We need to make similar changes to pcie_capability_write_word() and
pcie_capability_write_dword(), of course.  I think it makes sense to
do them all in the same patch, since it's logically the same change
and all these functions should be consistent with each other.

Thanks for your work so far!  I know it's tedious and painful.  But
cleaning this up will make things a little bit less painful for those
who come after us :)

Bjorn
