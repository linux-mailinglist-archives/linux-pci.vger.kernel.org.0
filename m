Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F35E7D93C2
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 11:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbjJ0Jco (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 05:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345614AbjJ0Jch (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 05:32:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CFC11F;
        Fri, 27 Oct 2023 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698399154; x=1729935154;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+AOCww2g2ORukZIWy/CuUf+TR2KpuFLjfTzg/hAqCA0=;
  b=LE3/HYaDySfwwF2ZZN/TOOhnVfj/RErFtP919QTb+OlWBS+4T+IsYMRb
   FH6Maafq2R+sncRAlHRirsLs27AWoCSNKiw0hl2g8vRfbK35zhWZ8IY7Q
   X+tjMyFUyDF0ERbiKVHgFcWHNofDNtZmtxIXkauJxlw9J97+pFXl1Ifr4
   Yys/Da72JB+mseBTjp1rok4iDSG+CamfzSDZLdmz377LZgiHGgNdsdki9
   49t46UrptavB2oF19PaktXISFZowBrhfHWw4Rmk0gJ3SD6shD/ocfhzKX
   mMOGz5UNYsWVYyo/lKwFbi2TndEloe7OK4++zaL9taSgm1E117jCdIpqS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="367951408"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="367951408"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 02:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="788782318"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="788782318"
Received: from scoltan-mobl.ger.corp.intel.com ([10.252.33.159])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 02:32:31 -0700
Date:   Fri, 27 Oct 2023 12:32:28 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86/PCI: Name PCI BIOS error code & use
 FIELD_GET()
In-Reply-To: <476692ae-81e5-4b65-93e9-eb303bc4b80d@intel.com>
Message-ID: <40e4acda-cf3f-1852-8064-c46b578553c@linux.intel.com>
References: <20231026125453.25767-1-ilpo.jarvinen@linux.intel.com> <476692ae-81e5-4b65-93e9-eb303bc4b80d@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-774251317-1698399153=:2740"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-774251317-1698399153=:2740
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 26 Oct 2023, Dave Hansen wrote:

> TOn 10/26/23 05:54, Ilpo Järvinen wrote:
> > PCI BIOS returns error code in AH register when carry flag is set. The
> > extraction of the error code is currently set of masking and shifting
> > which makes the code harder to understand than it needs to be.
> 
> That's a really convoluted way of saying that "The error code is in the
> high 8 bits of EAX".  The fact that 'AH' is an alias for the same

"high 8 bits" should odd to me since AH is not exactly at the highest end 
of eax register. But I'll try to figure out something along the lines of 
your suggestion.

> logical thing or that BIOS doesn't fill it in when !CF are rather
> irrelevant to this patch.  In fact, that makes this changelog actively
> confusing because there's no carry flag logic to be seen.  'eax' (the
> variable) universally has a valid error code, it's just zero when
> there's no error.
> 
> > Name the PCI BIOS error code with a define and use FIELD_GET() to
> > access it to improve code readability.
> > 
> > In addition, rely on implicit cast to int and replace zero test
> > with PCIBIOS_SUCCESSFUL.
> 
> It would be really nice if this was something like:
> 
> 	Subject: x86/PCI: Clean up open-coded error code mangling
> 
> That makes it clear that this is a cleanup.  It's kinda obvious from the
> code that it uses FIELD_GET().  You don't need to tell us in the subject.

Okay, I'll try to adapt the rest of the changelog to your suggestions
and make other changes you suggested.

-- 
 i.


> >  arch/x86/pci/pcbios.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
> > index 4f15280732ed..0515e0c05e10 100644
> > --- a/arch/x86/pci/pcbios.c
> > +++ b/arch/x86/pci/pcbios.c
> > @@ -3,6 +3,8 @@
> >   * BIOS32 and PCI BIOS handling.
> >   */
> >  
> > +#include <linux/bits.h>
> > +#include <linux/bitfield.h>
> >  #include <linux/pci.h>
> >  #include <linux/init.h>
> >  #include <linux/slab.h>
> > @@ -29,6 +31,12 @@
> >  #define PCIBIOS_HW_TYPE1_SPEC		0x10
> >  #define PCIBIOS_HW_TYPE2_SPEC		0x20
> >  
> > +/*
> > + * Returned in EAX:
> > + * - AH: return code
> > + */
> > +#define PCIBIOS_RETURN_CODE			GENMASK(15, 8)
> > +
> >  int pcibios_enabled;
> >  
> >  /* According to the BIOS specification at:
> > @@ -154,7 +162,7 @@ static int __init check_pcibios(void)
> >  			: "memory");
> >  		local_irq_restore(flags);
> >  
> > -		status = (eax >> 8) & 0xff;
> > +		status = FIELD_GET(PCIBIOS_RETURN_CODE, eax);
> 
> Nit: This:
> 
> 	FIELD_GET(PCIBIOS_RETURN_CODE, foo)
> 
> pattern is repeated for *EVERY* use of PCIBIOS_RETURN_CODE.  This would
> actually look nicer if you just did a helper like:
> 
> 	static inline u32 get_return_code(u32 eax)
> 	{
> 		return FIELD_GET(PCIBIOS_RETURN_CODE, eax);
> 	}
> 
> although I'm not 100% sure what types you actually want there.
>
> >  		hw_mech = eax & 0xff;
> >  		major_ver = (ebx >> 8) & 0xff;
> >  		minor_ver = ebx & 0xff;
> > @@ -227,7 +235,7 @@ static int pci_bios_read(unsigned int seg, unsigned int bus,
> >  
> >  	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
> >  
> > -	return (int)((result & 0xff00) >> 8);
> > +	return FIELD_GET(PCIBIOS_RETURN_CODE, result);
> >  }
> >  
> >  static int pci_bios_write(unsigned int seg, unsigned int bus,
> > @@ -269,7 +277,7 @@ static int pci_bios_write(unsigned int seg, unsigned int bus,
> >  
> >  	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
> >  
> > -	return (int)((result & 0xff00) >> 8);
> > +	return FIELD_GET(PCIBIOS_RETURN_CODE, result);
> >  }
> 
> For a cleanup like this, it's also nice to add the blurb:
> 
> 	"No functional changes intended."
> 
> Or even (if it's true):
> 
> 	"New code compiles the exact same code as the old code."
> 



--8323329-774251317-1698399153=:2740--
