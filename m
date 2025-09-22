Return-Path: <linux-pci+bounces-36637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AB0B8F7FD
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 10:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E59B7AFC7C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DC82FDC40;
	Mon, 22 Sep 2025 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1or6x71"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC7A2FDC35;
	Mon, 22 Sep 2025 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529582; cv=none; b=HISnACxm2NQkLydUIkkvIeAK7wib83S0VmNIuOPoPI/9jo60/Z42WbXF0fiZHPn0MwsJ+lNodr9xhDhX9oEVJTfUtCvAsKF4e0A/F1AjpiM2oRcP0Y8+nFXT/d2ggE9nDcUae6Rk/Vta8dS9dViIRw0YIjHnjMwp+a/TWwYCUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529582; c=relaxed/simple;
	bh=iWtix78nYDZYMD+U2a6eSVd9K/58kNpJXIaJTZ1nn0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5XyTj3sX7cMBTuuXBRLevT6Caag6RMZf6vD+zQCXOZgLwPWI98qY6QHUVgbDFCe/R56VSFcwzNUdcA8aKoCd1684SgT/UNnzbzpTVMz41/2krNxDaNsjJdSADkYlnSJy2bEgJVJYeEyTcUSo3beGxVunI9hQ8XRnvOzJNhgleY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1or6x71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03796C4CEF0;
	Mon, 22 Sep 2025 08:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529581;
	bh=iWtix78nYDZYMD+U2a6eSVd9K/58kNpJXIaJTZ1nn0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C1or6x71jBs1XtYbAnjOxV5JkM5KIpJjYhihwE1WvkcHy406/8hEwW9YTEcDzGcxh
	 2WObbfnBRx67JLgV6G8catCybuOaW8qQQKQMUCJ+Du9HklsshamqXe+KoJCF7wcLVI
	 MNH4qYb2jNrA1eQvsrw4sk5b90OY3fqyWRu5JDD7c/FBXYQ2fkxodcfWgCrtBp+lpD
	 AoV5SSmh641jlDI1at+CH5VbphxUDkROYBJTJFor5PtDoyWxkwwJEWUtQb5L3FeE4s
	 4/mmLyL9oXjXfbjhX4jThyWOlmZ0aj+nAMQAbcgeTU5w6rZJvH6f3elE5TaQg5qBhg
	 96LUJT/51Q40w==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	christian.bruel@foss.st.com,
	quic_wenbyao@quicinc.com,
	inochiama@gmail.com,
	mayank.rana@oss.qualcomm.com,
	thippeswamy.havalige@amd.com,
	shradha.t@samsung.com,
	cassel@kernel.org,
	kishon@kernel.org,
	sergio.paracuellos@gmail.com,
	18255117159@163.com,
	rongqianfeng@vivo.com,
	jirislaby@kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH v3 0/4] PCI: Keystone: Enable loadable module support
Date: Mon, 22 Sep 2025 13:56:08 +0530
Message-ID: <175852954905.18749.5091036983349477093.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250922071222.2814937-1-s-vadapalli@ti.com>
References: <20250922071222.2814937-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 22 Sep 2025 12:42:12 +0530, Siddharth Vadapalli wrote:
> This series enables support for the 'pci-keystone.c' driver to be built
> as a loadable module. The motivation for the series is that PCIe is not
> a necessity for booting Linux due to which the 'pci-keystone.c' driver
> does not need to be built-in.
> 
> Series is based on commit
> dc72930fe22e Merge branch 'pci/misc'
> of pci/next.
> 
> [...]

Applied, thanks!

[1/4] PCI: Export pci_get_host_bridge_device() for use by pci-keystone
      commit: c514ba0fa8938ae09370beecb77257868c1568a7
[2/4] PCI: dwc: Export dw_pcie_allocate_domains() and dw_pcie_ep_raise_msix_irq()
      commit: db9ff606a5535aee94bf41682f03aba500ff3ad6
[3/4] PCI: keystone: Exit ks_pcie_probe() for invalid mode
      commit: 76d23c87a3e06af003ae3a08053279d06141c716
[4/4] PCI: keystone: Add support to build as a loadable module
      commit: e82d56b5f3844189f2b2240b1c3eaeeafc8f1fd2

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

