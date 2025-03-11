Return-Path: <linux-pci+bounces-23459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 655F8A5CE2D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 19:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654043BB71A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 18:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7920263C72;
	Tue, 11 Mar 2025 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="STin7XQn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1A11DE3CE;
	Tue, 11 Mar 2025 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718566; cv=none; b=kfG32i4rq4AqC8hdQapfb//MyVQdNEx+H/Z+sHm4nCHLzX8Srg9DBdom+tDDp/+jX71WAa/9O/WYelBKTPFetPFYu0Cxema5iQqUMMtsicWP0Mkwleq5opa6ziCrLZznKSDMd+a8PqeRW5htYbUwm9A2qnER80Coy5m4sd56tyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718566; c=relaxed/simple;
	bh=1Zs79vm+geXh89jVLr/XC7Yto+fPTI4LB2QaXVXsMKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM03HnDld3SxALCcO8y5K7KMHG+a2hT2w8/9WNBprBZoA9+VV52KGSD2/YB+B6xOQknufqiBu93iZyslWupwIQ+//6TwV+UPPbEjud0R3fLakCHXSmQzaley1OhYUYBgbBCwDDCXyMMthEZgaPuZeswze7Weqqi9Adj9NmxBCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=STin7XQn; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7A6E7452C6;
	Tue, 11 Mar 2025 19:42:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741718563;
	bh=1Zs79vm+geXh89jVLr/XC7Yto+fPTI4LB2QaXVXsMKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STin7XQnP1wfImMEcOkXBWU8ecjeODeKXaJgQbbmF0egx08lUWEmz7r+lRj1w+vrk
	 2Rj06xgqRevizoDu4GLz0/8X1GXDSdtaMhRa/8Zc6mfRX/xun46ACjz7PDHovVZ3JQ
	 6k1oYklYtdI+GrPSexRK2wFWaEP46J7h0ib0QDdvB/Pfvw1dTs447nfAXDT7aZpUq7
	 LKUX93SoAWonXLgHGC0IRHS6NyVlztsfn2zT+JoL/59/ncavhQOZYtqbLCwU9Ylzx+
	 cQaP31se7toe864C96DE1TIeXm0Ns0282dESfJj5wuaG7p/4X+balgPfLtxDrZpE18
	 EWKIjBUhanBVw==
Date: Tue, 11 Mar 2025 19:42:42 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <Z9CEIlXoQJ-A0t-d@8bytes.org>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>

Hi Robin,

On Fri, Feb 28, 2025 at 03:46:33PM +0000, Robin Murphy wrote:
> +	/*
> +	 * And if we do now see any replay calls, they would indicate someone
> +	 * misusing the dma_configure path outside bus code.
> +	 */
> +	if (dev->driver)
> +		dev_WARN(dev, "late IOMMU probe at driver bind, something fishy here!\n");

This warning triggers on my workstation (with an AMD IOMMU), any ideas?

 ------------[ cut here ]------------
 reg-dummy reg-dummy: late IOMMU probe at driver bind, something fishy here!
 WARNING: CPU: 0 PID: 1 at drivers/iommu/iommu.c:449 __iommu_probe_device+0x10b/0x510
 Modules linked in:

 CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6-iommu-next+ #1 1d691d7aebf343bde741cf4c8610d78a2ea2d2d9
 Hardware name: System manufacturer System Product Name/PRIME X470-PRO, BIOS 5406 11/13/2019
 RIP: 0010:__iommu_probe_device+0x10b/0x510
 Code: 68 00 74 28 48 8b 6b 50 48 85 ed 75 03 48 8b 2b 48 89 df e8 87 71 06 00 48 89 ea 48 c7 c7 90 dd 2c 8b 48 89 c6 e8 35 83 77 ff <0f> 0b 49 8b bd a8 00 00 00 e8 77 ab 85 ff 84 c0 0f 84 ad 01 00 00
 RSP: 0018:ffffafba00047c58 EFLAGS: 00010282
 RAX: 0000000000000000 RBX: ffffa00481301c10 RCX: 0000000000000003
 RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000001
 RBP: ffffa00480ffaee0 R08: 0000000000000000 R09: ffffafba00047ae8
 R10: ffffa0135e93ffa8 R11: 0000000000000003 R12: ffffafba00047d18
 R13: ffffffff8adac1a0 R14: 0000000000000000 R15: ffffa004802c5800
 FS:  0000000000000000(0000) GS:ffffa0135ea00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffa00baca01000 CR3: 000000082b838000 CR4: 00000000003506f0
 Call Trace:
  <TASK>
  ? __iommu_probe_device+0x10b/0x510
  ? __warn.cold+0x93/0xf7
  ? __iommu_probe_device+0x10b/0x510
  ? report_bug+0xff/0x140
  ? prb_read_valid+0x1b/0x30
  ? handle_bug+0x58/0x90
  ? exc_invalid_op+0x17/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? __iommu_probe_device+0x10b/0x510
  ? __iommu_probe_device+0x10b/0x510
  ? __pfx_probe_iommu_group+0x10/0x10
  probe_iommu_group+0x28/0x50
  bus_for_each_dev+0x7e/0xd0
  iommu_device_register+0xee/0x260
  iommu_go_to_state+0xa2a/0x1970
  ? srso_return_thunk+0x5/0x5f
  ? blake2s_update+0x68/0x160
  ? __pfx_pci_iommu_init+0x10/0x10
  amd_iommu_init+0x14/0x50
  ? __pfx_pci_iommu_init+0x10/0x10
  pci_iommu_init+0x12/0x40
  do_one_initcall+0x46/0x300
  kernel_init_freeable+0x23d/0x2a0
  ? __pfx_kernel_init+0x10/0x10
  kernel_init+0x1a/0x140
  ret_from_fork+0x34/0x50
  ? __pfx_kernel_init+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 ---[ end trace 0000000000000000 ]---


