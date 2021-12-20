Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CEC47A8C3
	for <lists+linux-pci@lfdr.de>; Mon, 20 Dec 2021 12:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhLTLd2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 06:33:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39378 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhLTLd2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Dec 2021 06:33:28 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E145C1EC04FB;
        Mon, 20 Dec 2021 12:33:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640000003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jv+2cS0MSX4C7Q59qd+/K7GaVEGKkT4ISPl0b+0VegM=;
        b=DCNSfpXDKeCmT3FnkTTPZPy28zudgBGLDmHqkUkYreYcHaEbUXS9DFvafxTvn7LYQDrZd7
        lMjytgDAV+HLGvPLBzdzpiD2KfOdfrTC++p/LalN7L5QXYf/Fs0qrwxR+TYuTKTPTmy0+n
        RY10VAKFcNP89qsY5QjY3BEU/U7YS94=
Date:   Mon, 20 Dec 2021 12:33:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        intel-gfx@lists.freedesktop.org, x86@kernel.org,
        linux-pci@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Intel-gfx] [PATCH V3] drm/i915/adl-n: Enable ADL-N platform
Message-ID: <YcBqBgnRVgyzUqUE@zn.tnic>
References: <20211210051802.4063958-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <87r1ab1huq.fsf@intel.com>
 <20211219084921.lgd47srpzepspdpv@ldmartin-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211219084921.lgd47srpzepspdpv@ldmartin-desk2>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 19, 2021 at 12:49:21AM -0800, Lucas De Marchi wrote:
> > I note not all such changes in git log have your acks recorded, though
> > most do. Do you want us to be more careful about Cc'ing you for acks on
> > PCI ID changes every time going forward?
> 
> That's what Borislav asked in
> https://lore.kernel.org/all/20200520093025.GD1457@zn.tnic/

Right, I guess in the interest of not holding you guys up, if the patch
is only a trivial oneliner like below adding a GPU generation to the
list of quirks, you can only Cc x86@kernel.org so that we're aware and
proceed with it further without our ACK.

More involved stuff would need normal review, ofc.

Thx.

> > > diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> > > index fd2d3ab38ebb..1ca3a56fdc2d 100644
> > > --- a/arch/x86/kernel/early-quirks.c
> > > +++ b/arch/x86/kernel/early-quirks.c
> > > @@ -554,6 +554,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
> > >  	INTEL_RKL_IDS(&gen11_early_ops),
> > >  	INTEL_ADLS_IDS(&gen11_early_ops),
> > >  	INTEL_ADLP_IDS(&gen11_early_ops),
> > > +	INTEL_ADLN_IDS(&gen11_early_ops),
> > >  	INTEL_RPLS_IDS(&gen11_early_ops),
> > >  };
> > > 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
