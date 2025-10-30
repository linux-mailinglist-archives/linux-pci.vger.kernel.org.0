Return-Path: <linux-pci+bounces-39840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6EDC218E2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 18:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A55189F1B9
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F93533EAEF;
	Thu, 30 Oct 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="se09qJUR"
X-Original-To: linux-pci@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C2A36CA6A;
	Thu, 30 Oct 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846614; cv=none; b=CNDZ8hBz9XkUUoEYJXAqW2jWCFiC0T9mDrvsCOZdMpW95xsruUjNBVitncZv025pjnn3BJPbREmqJerGRTRLySPw2P4IlM9SQpeT+0cDPSBWdPzDtx9Dpwwi/Vf2Dob5VlbaMXk217S0K3/KzJ3JMqY2wuBXCD6iKXfoe64udr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846614; c=relaxed/simple;
	bh=iyoMxK1enzWryQx2WcAmoYKpgr0zkQbPo+SYtQtPqcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyy8viKUfBEncYCeSczzn7RRoayna2SFp80ZgxAvGCXKDUZVeZ8/mUHV8bllgVj1fFwoTTcqEmTd6Q3XUJB+2aTmO1Z6zThwfmEOm4RBzc2uBjRmwxsb4zY3G9mkILpoc/MATmrlF1JtjqOwrBl5/WFyGh4xQP32k1hnV1+SJHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=se09qJUR; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=JSgLBP4N8SNl1gTOFG6TDDGGZeq/ZcICS9giX00KL1s=; b=se09qJUR+afv9LNen0zoku4b/N
	sK1LMhglahuW/MrFGN+kga6O0ok8UDIwm1bX0WRn7t+GXuXg/TLvNS2gr1fKj6qsaGcaIQK/jdbA9
	0QCH0cLX7eh7V1Hzx0M64sme0FCudCaCA+UE5/9Dqyfg/CXO99w4Nac3l70T0xzQTCIPHlWgDC2/n
	rxGbQpS0ePc8qNiReX2L0XfHkEIvYKOQDYDd0dgCSmLHzTijJ8RxKrRIjzGw8GQB6CU4fcwwxkR6q
	k5cgghZuOt3rvmV/Kl+TWKXkX7BzRHnQevSb+mII+Bi4FWnYTmmkIjHzXl1gdK6zAhq0HLUPOwgZw
	EXG45G+A==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1vEWmI-00000002ZzI-1jJy;
	Thu, 30 Oct 2025 18:49:38 +0100
Date: Thu, 30 Oct 2025 18:49:37 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Johannes Erdfelt <johannes@erdfelt.com>,
	Alex Elder <elder@riscstar.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, p.zabel@pengutronix.de, christian.bruel@foss.st.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com, namcao@linutronix.de,
	thippeswamy.havalige@amd.com, inochiama@gmail.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Message-ID: <aQOlMcI9jTdd7QNb@aurel32.net>
Mail-Followup-To: Manivannan Sadhasivam <mani@kernel.org>,
	Johannes Erdfelt <johannes@erdfelt.com>,
	Alex Elder <elder@riscstar.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, p.zabel@pengutronix.de, christian.bruel@foss.st.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com, namcao@linutronix.de,
	thippeswamy.havalige@amd.com, inochiama@gmail.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013153526.2276556-1-elder@riscstar.com>
 <aPEhvFD8TzVtqE2n@aurel32.net>
 <92ee253f-bf6a-481a-acc2-daf26d268395@riscstar.com>
 <aQEElhSCRNqaPf8m@aurel32.net>
 <20251028184250.GM15521@sventech.com>
 <82848c80-15e0-4c0e-a3f6-821a7f4778a5@riscstar.com>
 <20251028204832.GN15521@sventech.com>
 <5kwbaj2eqr4imcaoh6otqo7huuraqhodxh4dbwc33vqpi5j5yq@ueufnqetrg2m>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5kwbaj2eqr4imcaoh6otqo7huuraqhodxh4dbwc33vqpi5j5yq@ueufnqetrg2m>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi Mani,

On 2025-10-30 22:11, Manivannan Sadhasivam wrote:
> + Aurelien
> 
> On Tue, Oct 28, 2025 at 01:48:32PM -0700, Johannes Erdfelt wrote:
> > On Tue, Oct 28, 2025, Alex Elder <elder@riscstar.com> wrote:
> > > On 10/28/25 1:42 PM, Johannes Erdfelt wrote:
> > > > I have been testing this patchset recently as well, but on an Orange Pi
> > > > RV2 board instead (and an extra RV2 specific patch to enable power to
> > > > the M.2 slot).
> > > > 
> > > > I ran into the same symptoms you had ("QID 0 timeout" after about 60
> > > > seconds). However, I'm using an Intel 600p. I can confirm my NVME drive
> > > > seems to work fine with the "pcie_aspm=off" workaround as well.
> > > 
> > > I don't see this problem, and haven't tried to reproduce it yet.
> > > 
> > > Mani told me I needed to add these lines to ensure the "runtime
> > > PM hierarchy of PCIe chain" won't be "broken":
> > > 
> > > 	pm_runtime_set_active()
> > > 	pm_runtime_no_callbacks()
> > > 	devm_pm_runtime_enable()
> > > 
> > > Just out of curiosity, could you try with those lines added
> > > just before these assignments in k1_pcie_probe()?
> > > 
> > > 	k1->pci.dev = dev;
> > > 	k1->pci.ops = &k1_pcie_ops;
> > > 	dw_pcie_cap_set(&k1->pci, REQ_RES);
> > > 
> > > I doubt it will fix what you're seeing, but at the moment I'm
> > > working on something else.
> > 
> > Unfortunately there is no difference with the runtime PM hierarchy
> > additions.
> > 
> 
> These are not supposed to fix the issues you were facing. I discussed with Alex
> offline and figured out that L1 works fine on his BPI-F3 board with a NVMe SSD.
> 
> And I believe, Aurelien is also using that same board, but with different
> SSDs. But what is puzzling me is, L1 is breaking Aurelien's setup with 3 SSDs
> from different vendors. It apparently works fine on Alex's setup. So it somehow
> confirms that Root Port supports and behaves correctly with L1. But at the same
> time, I cannot just say without evidence that L1 is broken on all these SSDs
> that you and Aurelien tested with.

It could be that we have different revision of the BPI-F3 board, it's 
not impossible that I got an early-ish version. That said I just 
visually checked the PCB against the schematics, and the devices on the 
CLKREQN line appear to be installed.

If someone has contacts to check what changes have been done between the 
different board revision, that could help. Or same if there are 
different revisions of the SpacemiT K1 chip.

> So until that is figured out, I've asked Alex to disable L1 CAP in the
> controller driver. So in the next version of this series, your SSDs should work
> out of the box.

Thanks, that sounds good.

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

