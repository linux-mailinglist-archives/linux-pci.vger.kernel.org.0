Return-Path: <linux-pci+bounces-41210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DEEC5B7AC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 07:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B12C7354032
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 06:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4BA2E2851;
	Fri, 14 Nov 2025 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=erdfelt.com header.i=@erdfelt.com header.b="Er6siCs6"
X-Original-To: linux-pci@vger.kernel.org
Received: from out.bound.email (out.bound.email [141.193.244.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E87D2E2DD6
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.193.244.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100801; cv=none; b=rE+W76GfTJ26TJfLG2I5Kn7pCoz5U3qZNPaYvAwUaLWf7jWRZEdKo1OW8QLZ9NyRTE6fzLVa7+wPhTqBrGtHo5vh/jvdKKheB/53rPAMX7Vd8VNRZHevDP9av8WBz7Nrle6VycPqsgrYxJzZ73aB2WeLJa81ZNwd+vDMYvCnlXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100801; c=relaxed/simple;
	bh=vxgjB0dE+LltGUhpGtE0g2G6K8pcfjlEs5MgaLfwdRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7W74wg70PL4RCY34dX5ZIa+dp2e39ATohGa7vXA8nxCBXL+I5vKM/gs1DHQFlKMODqvO9Z6hOG6Rg8MiZUMdY17f+T1uPWnO/LH9uZ5oDevs9TWz7rOGBS2qAFj5jGPPRJq+VgnP/3sqxmVYHGvJSOvhbHznFPrw40ZjHh6DFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=erdfelt.com; spf=pass smtp.mailfrom=erdfelt.com; dkim=pass (1024-bit key) header.d=erdfelt.com header.i=@erdfelt.com header.b=Er6siCs6; arc=none smtp.client-ip=141.193.244.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=erdfelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=erdfelt.com
Received: from mail.sventech.com (localhost [127.0.0.1])
	by out.bound.email (Postfix) with ESMTP id 084388A3183;
	Thu, 13 Nov 2025 22:05:06 -0800 (PST)
Received: by mail.sventech.com (Postfix, from userid 1000)
	id E36AA16002A7; Thu, 13 Nov 2025 22:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=erdfelt.com;
	s=default; t=1763100305;
	bh=FLPhWREcGas7h61JNtnMUud1rXfGhd1AOpj3u+wNcjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Er6siCs663+JDJeYDjYQqeIxP4BezsNSAdtqW3SXX+XS+mYUu0M2tFcgoJt0rYJDc
	 XJag0ix53jzhR/ca26+GsG/BAPOMmZVAitu576jDVQ8zQhgq6FJVlvTBQ5TqUQaA8F
	 YbwEgKZBOI0p7eBXFFYNbgx2iyiaDwqpvJ6oLcx0=
Date: Thu, 13 Nov 2025 22:05:05 -0800
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Alex Elder <elder@riscstar.com>
Cc: dlan@gentoo.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, ziyao@disroot.org, aurelien@aurel32.net,
	mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
	shradha.t@samsung.com, inochiama@gmail.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, christian.bruel@foss.st.com,
	thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
	guodong@riscstar.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Message-ID: <20251114060505.GA25077@sventech.com>
References: <20251113214540.2623070-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113214540.2623070-1-elder@riscstar.com>
User-Agent: Mutt/1.11.4 (2019-03-13)

On Thu, Nov 13, 2025, Alex Elder <elder@riscstar.com> wrote:
> This series introduces a PHY driver and a PCIe driver to support PCIe
> on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
> Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
> PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
> one PCIe lane, and the other two ports each have two lanes.  All PCIe
> ports operate at 5 GT/second.
> 
> The PCIe PHYs must be configured using a value that can only be
> determined using the combo PHY, operating in PCIe mode.  To allow
> that PHY to be used for USB, the needed calibration step is performed
> by the PHY driver automatically at probe time.  Once this step is done,
> the PHY can be used for either PCIe or USB.
> 
> The driver supports 256 MSIs, and initially does not support PCI INTx
> interrupts.  The hardware does not support MSI-X.
> 
> Version 6 of this series addresses a few comments from Christophe
> Jaillet, and improves a workaround that disables ASPM L1.  The two
> people who had reported errors on earlier versions of this code have
> confirmed their NVMe devices now work when configured with the default
> RISC-V kernel configuration.

I've tested this latest patchset on my Orange Pi RV2 board. This
patchset now works with the Intel 600p NVME SSD I had previously had
troublw with. Thanks!

Tested-by: Johannes Erdfelt <johannes@erdfelt.com>

JE


