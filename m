Return-Path: <linux-pci+bounces-24756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621D7A7158E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 12:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC282189D02C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 11:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329CA1DDD1;
	Wed, 26 Mar 2025 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="tL8x4PYg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C811A072C
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742987654; cv=none; b=qZ81P5pTovSmC2+reHp5C5HfBk2qJcoQ+caeH4gvwZG86NPXFZ7N6Y/INJsjMWbecbW88Q/mK0Ae5t0KN6rsHIPFtIS2BneuVm5vWVVwQCRFlrbx8TXJ9aj1L8HRuTtwmOpKOlH3w6KSqEuab6oH8wQ8owUXKrhCfNA3jELnh4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742987654; c=relaxed/simple;
	bh=VIkRnQ0PYF7WWQaTVB3vIm3wQp7Z3qsq/NYuSkwmXVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drC4TPs/cIBiTzHVBigaw1hg6GRFZHEB1PRoTRqOIzEkNW9ZsGq8GXe9Hr8njsqvnQYJ+SyuV/Ub2RhFOY+0cAhk0TtU0BTJ2vZz5VhGs5pNfMLT5B/bvSkREfXudu27qz5bhzjdcIZJxqMPHgLFJ0uwDi5M0aEHR0Srtz6QeKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=tL8x4PYg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ed1ac116e3so3103063a12.3
        for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1742987650; x=1743592450; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1DMxTj9W79Y/bQ7a4BC76DwUnfHWXcWHC6BQFkffiQ=;
        b=tL8x4PYgbwZ+e/mr6SlJNttWcJhf//3YCYxRypxzHwIRglY7/oIGRazDA56rHJodVB
         4wiQEi/iT3xu2ZHa3PFYBB2vkr7KEeq7WU15bekUOA6dtBNuK6RIBSVGrgy+JZ4pshWh
         bqzmuQxwUpZPbjc5/lSSg0TlCOxI3uOSViYpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742987650; x=1743592450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1DMxTj9W79Y/bQ7a4BC76DwUnfHWXcWHC6BQFkffiQ=;
        b=O5hpxWY84x8Sa4bPgx3ppObOjl0p1H1hVIWqQPXb05hiHVmlBybIiC5Efyib9HmHfA
         s/rOKIudJN1NcduE89voB9UutTOnMYWcqVfjSTbC4V8nWKY2UVEp7COFMYUV3pe1WLaO
         5feJQ77QrVCzY0EfNWVZ/MtmqCpAGFeMEgqhZqHuQ9n6ZGV4a9PZeX9OET9oyzd9OWCu
         8YV94tZ622M80aAgu5o7+SjVQqQ+9q29y53iL6H56n5157YwHK+gZDK1Z8bmTxqOGv+3
         E2eKKWP09oBisNArQ4wTPKP7KcAJCJBVLD8zHQSVgOogIYr9FTXbrfQ7lSwqyZEkCmUl
         kAAw==
X-Forwarded-Encrypted: i=1; AJvYcCUM9BJmLZF1vXAtHtTc94cMLmtqxlaH/QLHu0Dci5MLhNq//a/D0OfWDMqxHLdcHPtSUHxuQvvll9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3rfRoL4aY9imMMFmNJItgcLsWJhpbZZrkkFTR0VaQRrFvgHvF
	L+NE3lLoJ9ZtHrbfXWihV2PDudQhZFSGLG1/6VgDY2c0uz+BSoaBJ50rnxBJZxw=
X-Gm-Gg: ASbGncvaDWd5D4jwU4StkfXeWUFCLNuNmmSNkrsPh8TVRycjKojZMrs1Z/XkvrFG3+F
	AcbIwdjhpjuNU+mCDcC+b7L2SXzCOeg6ve1aeTGCDEnAQgt9PnMLXD6evpFm/rOwD9GSJDj/8BD
	TNZTCG/baLrIQoTcPCQzbQUi0mzBoGd2wfgewJ81SI8fJ4k6Dd17az7+jtzvqXBg7ooy5Nc91Ec
	EVaC0v8N6Jsd45hnILhb8dYIELAilMROcnMl6pLl3cwuhcmpW7Ppc86+W9+jXQdzb11U2/teTE3
	SSQZktzW0Kwp6CMSyjDdluhz0pPPUosEZVsZfMJKmW2g7Knzeg==
X-Google-Smtp-Source: AGHT+IH0Jg9Mrd0b7FGaEKEhOFjXfX9lAmyt6lVJIoo5kD62q1WqzTmjAHiwoMhyh1JPCuA41d2BtQ==
X-Received: by 2002:a17:907:7289:b0:abf:a387:7e35 with SMTP id a640c23a62f3a-ac3f280cac7mr2218889366b.53.1742987650254;
        Wed, 26 Mar 2025 04:14:10 -0700 (PDT)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac3efbcf5fdsm1015676866b.124.2025.03.26.04.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 04:14:09 -0700 (PDT)
Date: Wed, 26 Mar 2025 12:14:09 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI
 domain flag
Message-ID: <Z-PhgWQMHjxbac3b@macbook.local>
References: <20250219092059.90850-1-roger.pau@citrix.com>
 <20250219092059.90850-4-roger.pau@citrix.com>
 <20250326110455.GAZ-PfV3kOiQw97fDj@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326110455.GAZ-PfV3kOiQw97fDj@fat_crate.local>

On Wed, Mar 26, 2025 at 12:04:55PM +0100, Borislav Petkov wrote:
> + Linus so that he can whack it before it spreads any further.
> 
> On Wed, Feb 19, 2025 at 10:20:57AM +0100, Roger Pau Monne wrote:
> > Setting pci_msi_ignore_mask inhibits the toggling of the mask bit for both
> > MSI and MSI-X entries globally, regardless of the IRQ chip they are using.
> > Only Xen sets the pci_msi_ignore_mask when routing physical interrupts over
> > event channels, to prevent PCI code from attempting to toggle the maskbit,
> > as it's Xen that controls the bit.
> > 
> > However, the pci_msi_ignore_mask being global will affect devices that use
> > MSI interrupts but are not routing those interrupts over event channels
> > (not using the Xen pIRQ chip).  One example is devices behind a VMD PCI
> > bridge.  In that scenario the VMD bridge configures MSI(-X) using the
> > normal IRQ chip (the pIRQ one in the Xen case), and devices behind the
> > bridge configure the MSI entries using indexes into the VMD bridge MSI
> > table.  The VMD bridge then demultiplexes such interrupts and delivers to
> > the destination device(s).  Having pci_msi_ignore_mask set in that scenario
> > prevents (un)masking of MSI entries for devices behind the VMD bridge.
> > 
> > Move the signaling of no entry masking into the MSI domain flags, as that
> > allows setting it on a per-domain basis.  Set it for the Xen MSI domain
> > that uses the pIRQ chip, while leaving it unset for the rest of the
> > cases.
> > 
> > Remove pci_msi_ignore_mask at once, since it was only used by Xen code, and
> > with Xen dropping usage the variable is unneeded.
> > 
> > This fixes using devices behind a VMD bridge on Xen PV hardware domains.
> > 
> > Albeit Devices behind a VMD bridge are not known to Xen, that doesn't mean
> > Linux cannot use them.  By inhibiting the usage of
> > VMD_FEAT_CAN_BYPASS_MSI_REMAP and the removal of the pci_msi_ignore_mask
> > bodge devices behind a VMD bridge do work fine when use from a Linux Xen
> > hardware domain.  That's the whole point of the series.
> > 
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Juergen Gross <jgross@suse.com>
> 
> Did anyone actually test this on a normal KVM guest?

Sorry, not on KVM, I've tested on Xen and native.  It also seems to be
somewhat tied to the Kconfig, as I couldn't reproduce it with my
Kconfig, maybe didn't have the required VirtIO options enabled.

It's fixed by:

https://lore.kernel.org/xen-devel/87v7rxzct0.ffs@tglx/

Waiting for Thomas to formally sent that.

Thanks, Roger.

