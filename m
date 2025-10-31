Return-Path: <linux-pci+bounces-39892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B64C23531
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 07:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E14440810A
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 06:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C6D2EA732;
	Fri, 31 Oct 2025 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDDA7osP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ECC2E7F29;
	Fri, 31 Oct 2025 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891032; cv=none; b=SO+d4LCrJQonTyTcBMfFpObhiJ2n4hy6UcHDdxCG+SqTYZUzaOD/VB+c0wKEl4vVRPPlGxfr56UeraYUELJvszPwbG4IUx89V9jY19VK/rHQbA4v4vwbiWzsXhzfjiN+XQLvWH3Fe2LWxLBWKZ3qgNmaYOr+3MT1UuydDCoyXy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891032; c=relaxed/simple;
	bh=mtI0bJgcONn/+JNea1wnkILdIZmOmfcP/gzxeMrjXJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F53REGcIjse+lzScrGJaG41+qBZvJEGExd3Up0yrCxL//C0nyMlvlfqQFoRWJeElCSrmJR6oQm6SYHUrdSh2llISjDfKDnASfGeTovokMgd1xXYiA3TBovNe2OTlFzRp/1ZWraXfQW2aY1UBXuIRIm+BSGw07E6ZeruOrSfF4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDDA7osP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6449CC4CEF1;
	Fri, 31 Oct 2025 06:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891032;
	bh=mtI0bJgcONn/+JNea1wnkILdIZmOmfcP/gzxeMrjXJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDDA7osPfNKJWxC6aUuvy+jowSUofyqimpL1QvPRJtDoh9joXUz9Z8pp/KYkh+boq
	 TTVrkev+wIydtYDHxM68tfxTbDC0ODJHJPAxIdhsnYjMB8pTb3Ak0EjP+uD5U4DkiO
	 jH19GobKrGOs6SyL56fIa0CDMZMsnivg+4JIRe+Pr6EudiD8BGkYp3q+ROhMzGr/KF
	 sDNnYKqGRoVGXAbpSqe/jaBMfbuxrvMTDRE70DoBg9zVvGJKdqU1vG3PUJuRec39gb
	 j/zSkPyOOih0ERHsQyiULHVo0xgh4JRnAzngtYMf5ZAVbqMx09OWcaCYBdkLjcQgpE
	 iwi5wZpI9EtkA==
Date: Fri, 31 Oct 2025 11:40:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Johannes Erdfelt <johannes@erdfelt.com>, 
	Alex Elder <elder@riscstar.com>, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de, 
	christian.bruel@foss.st.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, 
	qiang.yu@oss.qualcomm.com, namcao@linutronix.de, thippeswamy.havalige@amd.com, 
	inochiama@gmail.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, spacemit@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Message-ID: <ywr66wfkfay3xse77mb7ddbga5nced4yg7dapiybj3p2yp2an2@7zsaj5one5in>
References: <20251013153526.2276556-1-elder@riscstar.com>
 <aPEhvFD8TzVtqE2n@aurel32.net>
 <92ee253f-bf6a-481a-acc2-daf26d268395@riscstar.com>
 <aQEElhSCRNqaPf8m@aurel32.net>
 <20251028184250.GM15521@sventech.com>
 <82848c80-15e0-4c0e-a3f6-821a7f4778a5@riscstar.com>
 <20251028204832.GN15521@sventech.com>
 <5kwbaj2eqr4imcaoh6otqo7huuraqhodxh4dbwc33vqpi5j5yq@ueufnqetrg2m>
 <aQOlMcI9jTdd7QNb@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQOlMcI9jTdd7QNb@aurel32.net>

On Thu, Oct 30, 2025 at 06:49:37PM +0100, Aurelien Jarno wrote:
> Hi Mani,
> 
> On 2025-10-30 22:11, Manivannan Sadhasivam wrote:
> > + Aurelien
> > 
> > On Tue, Oct 28, 2025 at 01:48:32PM -0700, Johannes Erdfelt wrote:
> > > On Tue, Oct 28, 2025, Alex Elder <elder@riscstar.com> wrote:
> > > > On 10/28/25 1:42 PM, Johannes Erdfelt wrote:
> > > > > I have been testing this patchset recently as well, but on an Orange Pi
> > > > > RV2 board instead (and an extra RV2 specific patch to enable power to
> > > > > the M.2 slot).
> > > > > 
> > > > > I ran into the same symptoms you had ("QID 0 timeout" after about 60
> > > > > seconds). However, I'm using an Intel 600p. I can confirm my NVME drive
> > > > > seems to work fine with the "pcie_aspm=off" workaround as well.
> > > > 
> > > > I don't see this problem, and haven't tried to reproduce it yet.
> > > > 
> > > > Mani told me I needed to add these lines to ensure the "runtime
> > > > PM hierarchy of PCIe chain" won't be "broken":
> > > > 
> > > > 	pm_runtime_set_active()
> > > > 	pm_runtime_no_callbacks()
> > > > 	devm_pm_runtime_enable()
> > > > 
> > > > Just out of curiosity, could you try with those lines added
> > > > just before these assignments in k1_pcie_probe()?
> > > > 
> > > > 	k1->pci.dev = dev;
> > > > 	k1->pci.ops = &k1_pcie_ops;
> > > > 	dw_pcie_cap_set(&k1->pci, REQ_RES);
> > > > 
> > > > I doubt it will fix what you're seeing, but at the moment I'm
> > > > working on something else.
> > > 
> > > Unfortunately there is no difference with the runtime PM hierarchy
> > > additions.
> > > 
> > 
> > These are not supposed to fix the issues you were facing. I discussed with Alex
> > offline and figured out that L1 works fine on his BPI-F3 board with a NVMe SSD.
> > 
> > And I believe, Aurelien is also using that same board, but with different
> > SSDs. But what is puzzling me is, L1 is breaking Aurelien's setup with 3 SSDs
> > from different vendors. It apparently works fine on Alex's setup. So it somehow
> > confirms that Root Port supports and behaves correctly with L1. But at the same
> > time, I cannot just say without evidence that L1 is broken on all these SSDs
> > that you and Aurelien tested with.
> 
> It could be that we have different revision of the BPI-F3 board, it's 
> not impossible that I got an early-ish version. That said I just 
> visually checked the PCB against the schematics, and the devices on the 
> CLKREQN line appear to be installed.
> 

CLKREQ# is only needed for L1 PM Substates (L1.1 and L1.2). In other ASPM states
(L0s and L1), REFCLK is supposed to be ON. So those don't need CLKREQ# assertion
by the endpoint.

The L1 issue you are facing could be due to the board routing issue also. I'm
just speculating here.

> If someone has contacts to check what changes have been done between the 
> different board revision, that could help. Or same if there are 
> different revisions of the SpacemiT K1 chip.
> 

I hope Alex can get this information.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

