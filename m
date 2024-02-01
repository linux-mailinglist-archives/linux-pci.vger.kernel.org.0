Return-Path: <linux-pci+bounces-2918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8521384557A
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 11:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66AF1C233EC
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE203A1C2;
	Thu,  1 Feb 2024 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6JKkdPY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F02747F;
	Thu,  1 Feb 2024 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783711; cv=none; b=nCnhCQQByXev/+8i29k/vN42l0f0vjx1wBgiFue6npndC2yLsoIf/VbO+uBzqkj8nB2+KHd/3+HYme69S9Q/F44dzFmNACBJrmnVJWtIgWaaQe9J2omPAP+CNhIZ2KYJrODYJAoDb16G/pr9dIJdx2LOKM22EWFe7fYq1amc0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783711; c=relaxed/simple;
	bh=Bb1rYm9y/hSa3JbuBT1OhhXmxnhnEzNS0Vs6wyeIOyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4i8p0qv1Xu+jBxBLnF/iXJqXt3wo+AG6z8orHi2+GlHndpNhvGiu8G5uUewkYPTmayBAowRhdPsgNQ4h9eE3BDoQ9qXIpgHnMpZA7AAuwuLa9MNg9UmXkGl3+bsZdgDDgYGgVWAzJMBNtT5ZYpY8raMnx1wuxszERu9pGt7QII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6JKkdPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5642EC43394;
	Thu,  1 Feb 2024 10:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706783711;
	bh=Bb1rYm9y/hSa3JbuBT1OhhXmxnhnEzNS0Vs6wyeIOyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6JKkdPYUrZVOFe2NKrIVbNs4kvuubA0Mzz5CQHvjyen/csbYWeZR++BVNFwtT7ET
	 HRpHqJl51i4FU3eNDoo80SfF/bzLHRRzBJubnNFbngJy06l6lr3PEYwKLm75eh6nVq
	 6ZST4KfYGCnCpiWszKFhG8rAPlYOqwyKbIxN5Fj18VetLeVEHrOZhoxr9lmMgGfb5o
	 UOKp5bXfZvKOCHrUmkPM7/0BMBELHQ6ia8HSqFUarT/UtmyTWVIPxkYzwd7UgHCpq0
	 IrGx0YlJealEG+ekOryOvM+9j4ejRt7mPEHH/AORnRj8dYCRcHSqlFR8S7wCTpShqD
	 8bNzOkdebEndg==
Date: Thu, 1 Feb 2024 11:35:04 +0100
From: Niklas Cassel <cassel@kernel.org>
To: =?utf-8?B?0JLQuNGC0LDQu9C40Lkg0KHQvtC70L7QvNC+0L3QvtCy?= <solomonov.v@gmail.com>
Cc: Daniel Drake <drake@endlessos.org>, Jian-Hong Pan <jhp@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@endlessos.org
Subject: Re: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS
 B1400CEAE
Message-ID: <Zbtz2G+OHvm/WB4b@x1-carbon>
References: <20240130095933.14158-1-jhp@endlessos.org>
 <20240130101335.GU2543524@black.fi.intel.com>
 <CAPpJ_ef4KuZzBaMupH-iW0ricyY_9toa7A4rB2vyeaFu7ROiDA@mail.gmail.com>
 <Zbonprq/1SircQon@x1-carbon>
 <CAD8Lp47SH+xcCbZ9qdRwrk2KOHNoHUE5AMieVHoSMbVsMrdiNg@mail.gmail.com>
 <ZbrNLxHL03R66PxQ@x1-carbon>
 <CADMpKLrNmmQ3PRTsiDXWBQ6iiJ9F+93xEk6HpuuK4Ev=n-i7wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADMpKLrNmmQ3PRTsiDXWBQ6iiJ9F+93xEk6HpuuK4Ev=n-i7wA@mail.gmail.com>

On Thu, Feb 01, 2024 at 06:50:53AM +0300, Виталий Соломонов wrote:
> Hello Daniel, Niklas
> 
> I assume that both of these logs are from the same kernel binary.
> > Does this kernel binary have the Tiger Lake LPM enablement patch included?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=104ff59af73aba524e57ae0fef70121643ff270e
> 
> Yes, it's the same kernel binary with applied patch.
> 
> 
> 
> > Could you please try to set:
> > CONFIG_SATA_MOBILE_LPM_POLICY=3
> > and enable VMD again, and see if that makes you able to detect the SATA
> > drive even with VMD enabled.
> >
>  With this policy settings my laptop was able to mount lvm volumes (/ and
> /boot) on SSD (/dev/nvme), and stuck on mounting HDD volumes (/home)
> dmesg: https://bugzilla.kernel.org/attachment.cgi?id=305804
> journalctl: https://bugzilla.kernel.org/attachment.cgi?id=305805

Just to clarify, in this latest log VMD_on_LPM_3_dmesg:
[    0.957793] ahci 10000:e0:17.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[    0.957796] ahci 10000:e0:17.0: flags: 64bit ncq sntf pm clo only pio slum part deso sadm sds 
[    0.957982] ata1: SATA max UDMA/133 abar m2048@0x82102000 port 0x82102100 irq 142 lpm-pol 4
[    1.271254] ata1: SATA link down (SStatus 4 SControl 300)

We still don't get any link up, so LPM policy == 3 did no difference.

I guess someone at Intel needs to debug why we don't get a link up with
VMD enabled, since AFAICT, having VMD enabled is like adding an extra HW layer:
libata -> Intel VMD -> Intel AHCI controller
instead of the normal
libata -> Intel AHCI controller

Since it works when talking to the AHCI controller directly, the question
is if it is VMD not following the spec, or if it libata that is not following
the spec (and we are just lucky that it works when talking to the Intel AHCI
controller directly).


Kind regards,
Niklas

