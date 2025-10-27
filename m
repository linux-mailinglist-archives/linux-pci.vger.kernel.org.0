Return-Path: <linux-pci+bounces-39446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D11C0EF55
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 16:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAA274EDFFE
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CFE30ACE3;
	Mon, 27 Oct 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVOWppG5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC53002D3;
	Mon, 27 Oct 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578461; cv=none; b=GyQE+ZK9w5YiJSVMzYba3Z94o+3NUFpcVZ3nDLonrl4+a9mZ7jV8UgOEFXlyTwV/c0+5gHY3ifHKyB+qM4Vy2fy2U38F4SLE+6ulPUh6T6t+fg1jgToiBHRjT3F9McK0LEfAt/D81EdLFgUzQQe8xWdxk7ZdXZ0pYvvVp3A1mZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578461; c=relaxed/simple;
	bh=C2tW+uyuq7ln9FLT2ekF9vYvoP/opSF+yMWMBdr1DcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIQpp9lXH8AJSeGw/dOcZmVXRC7STQvJ1O5ZFGNbHqNliVoa2kbWEg73eLAPOEfMY1ag2lbegdHlZKrE2JgxFFaHQmtBakhFOJ1Nmahp+S+3lnK7b9JurmtmzODjDwg1eOrPOk5lMslEM+jVEHGJadWuZlVJBVAcMivcD1T2KsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVOWppG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09E3C4CEF1;
	Mon, 27 Oct 2025 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761578461;
	bh=C2tW+uyuq7ln9FLT2ekF9vYvoP/opSF+yMWMBdr1DcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BVOWppG5qhQ5rLMy1yDGfZoV1dONsaZdrOX2X8E1LmslIyxR/M+tpcozL362Mgdzr
	 dcLm6Zvl9ScwLtkI8cWJAXHZb5YTUE0veojinu0fUpkqLtrPmVXXn4kDfDZR7eOW/O
	 QgSAWrjVNAzR1p66dG2ae47cEYPTyMN+dE2nHTwjAGld78zIaq+w1jb7o+GdcVZH2w
	 YrJ0cQauPL/lIq1tLwMSCpBbIp/fe4ok0LBkV872/KuPgRTtJZavfp1qcrMNbs6NUK
	 0O/Sx6McPu8krr4IAPVj32ax8Q2IbqcEVwamX4L3SazchBit4YexCNKg0W7sdDo29N
	 mo/b1sos20orA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev,
	imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 0/4] pci: endpoint: vntb: add MSI doorbell support
Date: Mon, 27 Oct 2025 20:50:48 +0530
Message-ID: <176157831202.16688.18216264846233563153.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015-vntb_msi_doorbell-v6-0-9230298b1910@nxp.com>
References: <20251015-vntb_msi_doorbell-v6-0-9230298b1910@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 15 Oct 2025 11:27:27 -0400, Frank Li wrote:
> Since commit 1c3b002c6bf68 PCI: endpoint: Add RC-to-EP doorbell support
> using platform MSI controller, PCI EP can get notification from Host.
> 
> VNTB use this feature to reduce ping latency.
> 
> The first patch impove epf core API to allow set any MMIO address to specfic
> bar.
> 
> [...]

I've done some minor code cleanups and applied the series to pci/endpoint.
Please check the commits to make sure I didn't mess up like last time. Thanks!

[1/4] PCI: endpoint: Rename aligned_size to mem_size
      commit: 483768846d66c04354898f00bcdaad58a3763be2
[2/4] PCI: endpoint: Add helper function pci_epf_get_bar_required_size()
      commit: f71e2b67b51dcb2fd8c6d566230f17a735770bee
[3/4] PCI: endpoint: Add API pci_epf_assign_bar_space()
      commit: 0bfc6758f213a701bd662982de86f0032b51f18c
[4/4] PCI: endpoint: pci-epf-vntb: Add MSI doorbell support
      commit: dc693d60664470ec47188c328055d80e8ce7ea44

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

