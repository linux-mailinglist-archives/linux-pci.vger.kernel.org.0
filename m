Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74EE7D879D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 19:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJZRhQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 13:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjJZRhP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 13:37:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF4AC1;
        Thu, 26 Oct 2023 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698341833; x=1729877833;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=cl5/LajLNSDSOEtMV0PeiV32fYKRt6KSlcH7pwaTNQg=;
  b=Vla/bR2qTplXL3oGQkTJKLW3zfD6m8jjFNFI6ksXqtJr/eiHuy4asBDR
   0Kdd13/SfruUvf9PkOBTVeHwDn7hZTBoji/nZ0JCObzkSBmy/xaLD4FYg
   N2Qj5+g1bwn3DuTS8Vn/8be0H0UlbvPugiDD3ng7ynwKzv+h/4wF20Er4
   zXEcejJmIwDoqX9XQXvOTakqBk4wYjq7TBTVEsj8+k4LrCVbeToIYMxTY
   FlbQpB2NDvexV+i45MoGTyKsXEoUpii34nfrfuj6/oy3TT9qNoWer6BGE
   Yo21Y7jJllLX4TSz/XyE9AibvOGfrhvo5pBKC2ouNKkDdLx2tmCNQg5CQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="367821401"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="367821401"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 10:37:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="932813193"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="932813193"
Received: from pjmartin-mobl2.amr.corp.intel.com (HELO [10.209.32.248]) ([10.209.32.248])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 10:37:12 -0700
Message-ID: <476692ae-81e5-4b65-93e9-eb303bc4b80d@intel.com>
Date:   Thu, 26 Oct 2023 10:37:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/PCI: Name PCI BIOS error code & use FIELD_GET()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231026125453.25767-1-ilpo.jarvinen@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20231026125453.25767-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

TOn 10/26/23 05:54, Ilpo Järvinen wrote:
> PCI BIOS returns error code in AH register when carry flag is set. The
> extraction of the error code is currently set of masking and shifting
> which makes the code harder to understand than it needs to be.

That's a really convoluted way of saying that "The error code is in the
high 8 bits of EAX".  The fact that 'AH' is an alias for the same
logical thing or that BIOS doesn't fill it in when !CF are rather
irrelevant to this patch.  In fact, that makes this changelog actively
confusing because there's no carry flag logic to be seen.  'eax' (the
variable) universally has a valid error code, it's just zero when
there's no error.

> Name the PCI BIOS error code with a define and use FIELD_GET() to
> access it to improve code readability.
> 
> In addition, rely on implicit cast to int and replace zero test
> with PCIBIOS_SUCCESSFUL.

It would be really nice if this was something like:

	Subject: x86/PCI: Clean up open-coded error code mangling

That makes it clear that this is a cleanup.  It's kinda obvious from the
code that it uses FIELD_GET().  You don't need to tell us in the subject.

>  arch/x86/pci/pcbios.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
> index 4f15280732ed..0515e0c05e10 100644
> --- a/arch/x86/pci/pcbios.c
> +++ b/arch/x86/pci/pcbios.c
> @@ -3,6 +3,8 @@
>   * BIOS32 and PCI BIOS handling.
>   */
>  
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> @@ -29,6 +31,12 @@
>  #define PCIBIOS_HW_TYPE1_SPEC		0x10
>  #define PCIBIOS_HW_TYPE2_SPEC		0x20
>  
> +/*
> + * Returned in EAX:
> + * - AH: return code
> + */
> +#define PCIBIOS_RETURN_CODE			GENMASK(15, 8)
> +
>  int pcibios_enabled;
>  
>  /* According to the BIOS specification at:
> @@ -154,7 +162,7 @@ static int __init check_pcibios(void)
>  			: "memory");
>  		local_irq_restore(flags);
>  
> -		status = (eax >> 8) & 0xff;
> +		status = FIELD_GET(PCIBIOS_RETURN_CODE, eax);

Nit: This:

	FIELD_GET(PCIBIOS_RETURN_CODE, foo)

pattern is repeated for *EVERY* use of PCIBIOS_RETURN_CODE.  This would
actually look nicer if you just did a helper like:

	static inline u32 get_return_code(u32 eax)
	{
		return FIELD_GET(PCIBIOS_RETURN_CODE, eax);
	}

although I'm not 100% sure what types you actually want there.

>  		hw_mech = eax & 0xff;
>  		major_ver = (ebx >> 8) & 0xff;
>  		minor_ver = ebx & 0xff;
> @@ -227,7 +235,7 @@ static int pci_bios_read(unsigned int seg, unsigned int bus,
>  
>  	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
>  
> -	return (int)((result & 0xff00) >> 8);
> +	return FIELD_GET(PCIBIOS_RETURN_CODE, result);
>  }
>  
>  static int pci_bios_write(unsigned int seg, unsigned int bus,
> @@ -269,7 +277,7 @@ static int pci_bios_write(unsigned int seg, unsigned int bus,
>  
>  	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
>  
> -	return (int)((result & 0xff00) >> 8);
> +	return FIELD_GET(PCIBIOS_RETURN_CODE, result);
>  }

For a cleanup like this, it's also nice to add the blurb:

	"No functional changes intended."

Or even (if it's true):

	"New code compiles the exact same code as the old code."

