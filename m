Return-Path: <linux-pci+bounces-44680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB1D1B7D9
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 22:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F171130019D4
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 21:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682C2344055;
	Tue, 13 Jan 2026 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVL0x7JG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000F2DC34E;
	Tue, 13 Jan 2026 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341365; cv=none; b=TRSvVl6DSwvc6FT+IPPYT/qA1TTsij/SIc+ph2jOSRC/TrlViuMHZjI8nd+ftsCI+ugM8f6aYPtEVnJ+cxTQQs6/zNeG/GTpOO62m2nQaunE9TwnaqoU6RXDZSu8SbG4yw1tLeHNluKvlz+kKO1F2oNZz63O1Qn2wnvVSaHFEKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341365; c=relaxed/simple;
	bh=nTh7fFqg/LT3f9MdXlSs711AfVqGFXu1moivv8qFk5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PnsZR0+nEDcZ+hs+npbV5VaqsNgPsVAldS44U6xrirsg7r0fDJoi0Go5zXOsJSYrgu16+XTyFJfRTdpf0En/j1Wy9rejZnCBQ4ssdL4z8BVEjQ4blwtF72L3KwKPmgi5SZkQC70/lCtlI2Y2dhudlwAs9/G4nhIQTcYpP9zTFMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVL0x7JG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE4AC116C6;
	Tue, 13 Jan 2026 21:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768341365;
	bh=nTh7fFqg/LT3f9MdXlSs711AfVqGFXu1moivv8qFk5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KVL0x7JGjD1UDylwCNvsq33YOeWSQBFTiC0+Ys1LNYVg3J074Acwc7UY/GnO/DNyq
	 bJLC0dA+r3nyYWkHrnmVPpipU6qBFuHkj2OMXLTlhXXEzWkPR6A2q5u1TOqw1AFKVu
	 8qyG6Y41DcW1nKub4hyAYH2bmHsXswKGrL7ifknyOCEXV9TXlmfQ4seB+DEuXruxFn
	 YuroqYs2OUBOVmiy0BbTxnvQyW6Mq7lOVI8NcKftIPjl4yAPCvM0Ii9XYkM1p22XWQ
	 zD47bg2Mj+wKYHbFE5Cor0+hKEq+Lm7VChI96RChOIkk4o0RtwZ6TccRsGnMDLKkbT
	 rRiTy9Wd4sQ/A==
Date: Tue, 13 Jan 2026 15:56:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: huyuye <huyuye812@163.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Robert Moore <robert.moore@intel.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	dai.hualiang@zte.com.cn, deng.weixian@zte.com.cn,
	guo.chang2@zte.com.cn, liu.qingtao2@zte.com.cn,
	wu.jiabao@zte.com.cn, lin.yongchun@zte.com.cn, hu.yuye@zte.com.cn,
	zhang.longxiang@zte.com.cn, zuo.jiang@zte.com.cn,
	li.kunpeng@zte.com.cn
Subject: Re: [PATCH v2] ACPI: pci_root: Clear the acpi dependencies after PCI
 root bridge initialization on RISC-V
Message-ID: <20260113215603.GA781891@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112141630.2869-1-huyuye812@163.com>

On Mon, Jan 12, 2026 at 10:16:29PM +0800, huyuye wrote:
> Hi Rafael,
> Thank you for your thorough review and valuable comments on v1.
> I've updated the patch as follows:
> 1. Removed the redundant #ifdef CONFIG_ACPI and if (!acpi_disabled) 
> guard as you pointed out. The entire code block indeed already depends
> on CONFIG_ACPI at a higher level, making the inner guard unnecessary.
> 2. Moved acpi_dev_clear_dependencies to RISC-V specific architecture 
> code (driver/acpi/riscv/acpi_pci.c). This ensures that ACPI dependency
> clearing is handled within the appropriate architectural context.
> 
> Best regards

This really should have the commit log here, as it did in the original
post [1].

> Signed-off-by: huyuye <huyuye812@163.com> 
> ---

And the description of the changes from v1 to v2 can go here, after
the "---" since it doesn't need to be part of the permanent git
history; see [2].

[1] https://lore.kernel.org/r/20251203140716.3065-1-huyuye812@163.com
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.18#n784

