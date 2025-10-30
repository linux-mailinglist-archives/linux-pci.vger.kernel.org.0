Return-Path: <linux-pci+bounces-39833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 799D4C213EE
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 17:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F7263502D4
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318DE2DF71D;
	Thu, 30 Oct 2025 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFfTgDYU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37F82DE1E0;
	Thu, 30 Oct 2025 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842484; cv=none; b=sKJWyP1goZ8K419qGaWpujAqngRnjsfL9m1fabaa5xZd2ICEFsZKGPf0JXCDplvhUV5SCSJor8/l4vyA7ZmnfRotu3xp/OwEF3BWKMhx/8THoBcXXmp+DICSdso+JhHVINquBfs53aKG/MZICANSQ4wW6epc/qigWnQ3hGkZCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842484; c=relaxed/simple;
	bh=aIoUwknKACszK3iv7HnkpaK0g2nYzhodMj6uyK4R4cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVnbuwrPva/HQJQ0JlIpWyhASuXiLTfCFI9oTZWi5nLzR6o6XG9L4lTSgoFA3VqFBTx6p1H1K2mykEola3u3PPiOi41DCFLhymS0TiSy47NU0ULVl91KcT+57qIbPGsmisgcpMEIMbNQJal/14xJiq8djGxckcZnzDgX9eVpblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFfTgDYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17F5C4CEF1;
	Thu, 30 Oct 2025 16:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761842483;
	bh=aIoUwknKACszK3iv7HnkpaK0g2nYzhodMj6uyK4R4cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFfTgDYUwwtk9a3MXmhN+C5QZeQcKowOvQ7JtdxMp86xa7GEim8ms4eA76JdlZfHS
	 eFhBevKSCYCx6yMiJ4R3yNh1fEKAOckpxYlBhI00S+GuEHbN3tDMHcHFjIQ1269XM1
	 0162sMPeIP15mj38QzG6640TZdgvl0DyZO+zAfpQ7ma2P8O29xh8ZpHLOZ/sL32xe0
	 iqWWZ9MUG/8ewMu0jydmDJAMYeZyKtiWVz81dJNlG9Bj+piDGu94CB0PcteyGg6uJe
	 yPXStu00GL1l1YREbznHaQFRp4m3fyjHtsoP+kDTeTeOt9XtrZbecyLXwkT6Ds1J5w
	 cFFbUk6PUfVZg==
Date: Thu, 30 Oct 2025 22:11:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Johannes Erdfelt <johannes@erdfelt.com>, 
	Aurelien Jarno <aurelien@aurel32.net>
Cc: Alex Elder <elder@riscstar.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org, 
	guodong@riscstar.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, p.zabel@pengutronix.de, christian.bruel@foss.st.com, 
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com, 
	namcao@linutronix.de, thippeswamy.havalige@amd.com, inochiama@gmail.com, 
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Message-ID: <5kwbaj2eqr4imcaoh6otqo7huuraqhodxh4dbwc33vqpi5j5yq@ueufnqetrg2m>
References: <20251013153526.2276556-1-elder@riscstar.com>
 <aPEhvFD8TzVtqE2n@aurel32.net>
 <92ee253f-bf6a-481a-acc2-daf26d268395@riscstar.com>
 <aQEElhSCRNqaPf8m@aurel32.net>
 <20251028184250.GM15521@sventech.com>
 <82848c80-15e0-4c0e-a3f6-821a7f4778a5@riscstar.com>
 <20251028204832.GN15521@sventech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028204832.GN15521@sventech.com>

+ Aurelien

On Tue, Oct 28, 2025 at 01:48:32PM -0700, Johannes Erdfelt wrote:
> On Tue, Oct 28, 2025, Alex Elder <elder@riscstar.com> wrote:
> > On 10/28/25 1:42 PM, Johannes Erdfelt wrote:
> > > I have been testing this patchset recently as well, but on an Orange Pi
> > > RV2 board instead (and an extra RV2 specific patch to enable power to
> > > the M.2 slot).
> > > 
> > > I ran into the same symptoms you had ("QID 0 timeout" after about 60
> > > seconds). However, I'm using an Intel 600p. I can confirm my NVME drive
> > > seems to work fine with the "pcie_aspm=off" workaround as well.
> > 
> > I don't see this problem, and haven't tried to reproduce it yet.
> > 
> > Mani told me I needed to add these lines to ensure the "runtime
> > PM hierarchy of PCIe chain" won't be "broken":
> > 
> > 	pm_runtime_set_active()
> > 	pm_runtime_no_callbacks()
> > 	devm_pm_runtime_enable()
> > 
> > Just out of curiosity, could you try with those lines added
> > just before these assignments in k1_pcie_probe()?
> > 
> > 	k1->pci.dev = dev;
> > 	k1->pci.ops = &k1_pcie_ops;
> > 	dw_pcie_cap_set(&k1->pci, REQ_RES);
> > 
> > I doubt it will fix what you're seeing, but at the moment I'm
> > working on something else.
> 
> Unfortunately there is no difference with the runtime PM hierarchy
> additions.
> 

These are not supposed to fix the issues you were facing. I discussed with Alex
offline and figured out that L1 works fine on his BPI-F3 board with a NVMe SSD.

And I believe, Aurelien is also using that same board, but with different
SSDs. But what is puzzling me is, L1 is breaking Aurelien's setup with 3 SSDs
from different vendors. It apparently works fine on Alex's setup. So it somehow
confirms that Root Port supports and behaves correctly with L1. But at the same
time, I cannot just say without evidence that L1 is broken on all these SSDs
that you and Aurelien tested with.

So until that is figured out, I've asked Alex to disable L1 CAP in the
controller driver. So in the next version of this series, your SSDs should work
out of the box.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

