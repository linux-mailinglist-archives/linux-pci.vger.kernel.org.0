Return-Path: <linux-pci+bounces-19654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA53A0B480
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 11:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6865C164CE9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472662045AC;
	Mon, 13 Jan 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="gD/5D8Cv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB2421ADD9
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763963; cv=none; b=kqHqVVJbcZdM3rYrhLxYzy1smp0A31RbJ+eYzFHT2yWMMuUENMMPVw8w35wLTwNrsmTX2EtRPZJqWMGfN+KlF2G1BM7fuGZRV+JL1BH1nBa5kfqPrhl7t3KAsVzFeI1H8dwproBf5nb/XkkRiGB6d2YF/tKAu7QBNOOgml8RvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763963; c=relaxed/simple;
	bh=UOoxma2oUJcoVW1r0RFcn4AsS8GIyIKK93nJWMYqgJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzbeEK8Xd/tAcLF170pL5L0VRcZLZpXlOYILn3oWebg/HpaxUEw0o915T9fE2hQ6zj/5ZDCWAk3hH4GJlR4y7miCCr/a4vHgBVvh0Hnk4PkN4cOAW2Z0uu0LkGF8b/BubSZAAddyC7AffUPUMtAWHa6+9NCwY2MqOjYsSpYeRwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=gD/5D8Cv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso7389060a12.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 02:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1736763960; x=1737368760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=925HmCk6HSMWdjeEYYDzVrquNKNAs9H/T8Q5GhNYCxE=;
        b=gD/5D8CvrpkA6i/aB+qximIrfqWwPoVkgll+S8SVP6AJetMBADVtSu6DKyLI9vWzLH
         ptYSw7NhSg/hl/4XIhRytLX6MMFsrnTAGWYU0Up6tp0BQewEOOb0Pta0hz9YjdvBAt7I
         UK1rNrJOmHUf6Uy6qYGidFa/PJ7fIY9xgJjEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736763960; x=1737368760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=925HmCk6HSMWdjeEYYDzVrquNKNAs9H/T8Q5GhNYCxE=;
        b=TY0HaEnnKbRTMCOe4rTZ0fNiJrjN0AJEZZW1T2e0Y+SpHn9MfbYyafNsom3AlCe271
         iYwTYeJ+CbaJQBHR+FlbweKdD6Jxdeovse6VO6tdzwmPizwezSr5LgU8vYkJDjjf2oqY
         e1b1rfEWy0svZAzHwEIBcyl7ZKHcXptGGSkAPpU/4CB5vypSU2G9AzdX39JR9MlBfnLF
         t3QtluSqiWGZFTqFVDwMp/dOvwYXwI3Qxqj6nj5Q3c0tQ3DHzCYd55xg6nrkKOovN7Oh
         xJ8Db6i2eGc4Y8jaG7ZlYN17HRulGZL/xqi6bam8OTbj3CPbIVMKVPVgG2KjF7bM70La
         H44w==
X-Forwarded-Encrypted: i=1; AJvYcCXCxQ5zohp/Vg8OeIvRuWF9UE1WhsoawLfuPk1aJPza6jsshwJrMt2lOH/8Iez9DuoRp+XoAC6oqP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0gaWOAVwbftO5pb6gR8jvu2Ixq/hPFJv1el/3oOLWxKPeiafQ
	OoTxQaoGli1Fchpp2urkgvb3qcRwYVSmMxnFj2y6OAZm8x5VuSE1PdIUHiIFbLE=
X-Gm-Gg: ASbGncv9fb5W/t6kRzBRWLZ0jsqaHs1CQLywN3yfz9EgCTXjIvTyONeBhmyi0lqFGAR
	HiE/NQxFP6C1kihaRM845arvexsfutlYyKvo5jxa7lSyUKAwhyh45fxpmiK3mnwKdbQqSKbSrkH
	qM3Crx/CFLmIXcOibAEl0SUdiWVqb2Khow5mcsZGW12s2B1VSUbJ8yRCb7eTK8tTXw9A+GGnPM4
	Q/gWZHvMAvCTwK7V8LIwOquI5+ESTh90iGnekfSDnX0mIfMz925TMhqsfb78Q==
X-Google-Smtp-Source: AGHT+IFqQfQXn4x8tYwm9aCoWhJeQj7jQKe/nY36w28hVZGBm5avVQz2Sjl6V/fPorhg+0bEmX3Ptg==
X-Received: by 2002:a05:6402:5006:b0:5d0:e3fa:17ca with SMTP id 4fb4d7f45d1cf-5d972e17902mr18117568a12.15.1736763959654;
        Mon, 13 Jan 2025 02:25:59 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99046a05asm4788651a12.67.2025.01.13.02.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 02:25:59 -0800 (PST)
Date: Mon, 13 Jan 2025 11:25:58 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/3] pci/msi: remove pci_msi_ignore_mask
Message-ID: <Z4TqNn_RSwGX1TQn@macbook.local>
References: <20250110140152.27624-4-roger.pau@citrix.com>
 <20250110223057.GA318711@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110223057.GA318711@bhelgaas>

On Fri, Jan 10, 2025 at 04:30:57PM -0600, Bjorn Helgaas wrote:
> Match subject line style again.
> 
> On Fri, Jan 10, 2025 at 03:01:50PM +0100, Roger Pau Monne wrote:
> > Setting pci_msi_ignore_mask inhibits the toggling of the mask bit for both MSI
> > and MSI-X entries globally, regardless of the IRQ chip they are using.  Only
> > Xen sets the pci_msi_ignore_mask when routing physical interrupts over event
> > channels, to prevent PCI code from attempting to toggle the maskbit, as it's
> > Xen that controls the bit.
> > 
> > However, the pci_msi_ignore_mask being global will affect devices that use MSI
> > interrupts but are not routing those interrupts over event channels (not using
> > the Xen pIRQ chip).  One example is devices behind a VMD PCI bridge.  In that
> > scenario the VMD bridge configures MSI(-X) using the normal IRQ chip (the pIRQ
> > one in the Xen case), and devices behind the bridge configure the MSI entries
> > using indexes into the VMD bridge MSI table.  The VMD bridge then demultiplexes
> > such interrupts and delivers to the destination device(s).  Having
> > pci_msi_ignore_mask set in that scenario prevents (un)masking of MSI entries
> > for devices behind the VMD bridge.
> > 
> > Move the signaling of no entry masking into the MSI domain flags, as that
> > allows setting it on a per-domain basis.  Set it for the Xen MSI domain that
> > uses the pIRQ chip, while leaving it unset for the rest of the cases.
> > 
> > Remove pci_msi_ignore_mask at once, since it was only used by Xen code, and
> > with Xen dropping usage the variable is unneeded.
> > 
> > This fixes using devices behind a VMD bridge on Xen PV hardware domains.
> 
> Wrap to fit in 75 columns.
> 
> The first two patches talk about devices behind VMD not being usable
> for Xen, but this one says they now work.

Sorry, let me try to clarify:

Devices behind a VMD bridge are not known to Xen, however that doesn't
mean Linux cannot use them.  That's what this series achieves.  By
inhibiting the usage of VMD_FEAT_CAN_BYPASS_MSI_REMAP and the removal
of the pci_msi_ignore_mask bodge devices behind a VMD bridge do work
fine when use from a Linux Xen hardware domain.  That's the whole
point of the series.

> But this doesn't undo the
> code changes or comments added by the first two, so the result is a
> bit confusing (probably because I know nothing about Xen).

All patches are needed.  There's probably some confusion about devices
behind a VMD bridge not being known by Xen vs not being usable by
Linux running under Xen as a hardware domain.

With all three patches applied devices behind a VMD bridge work under
Linux with Xen.

Thanks, Roger.

