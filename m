Return-Path: <linux-pci+bounces-1734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8FE825FB7
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 14:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6009028272D
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 13:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2314810F2;
	Sat,  6 Jan 2024 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAPouwFl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC27460
	for <linux-pci@vger.kernel.org>; Sat,  6 Jan 2024 13:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E25DC433C8;
	Sat,  6 Jan 2024 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704548692;
	bh=LGTgxqxOygh5aZyaHTVaAXCaHAb1TgYqmHjpgTu+vxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAPouwFlk2AbtAYvTqNWM0ye8BbaDcT7xGzym7PBoOLzwOY01g0dbHaOfyl5U/BNR
	 YXSzMXUKnqOvEGTN+x5lXvyX/lomuZ70V7HTwONzIXivr058OTvzcQ4a4s8B2loMjO
	 scyethOCVcql1VB6e7hnjRNtdD7t6+pMun9zSY2iDjlul5dDd7ibTyqTV+TC+gRxsp
	 fLLMYwxpLWti6fImpFnWstKl7PKokfMc0lTujk8SbKx0zhO+BDmRVGMMppps7YXf/b
	 AfQNSJRqi/n6/VMk8anE6dG5uSBdmKEvDjkjKVed661CiW40B2LIJRp1bMxKBcOXbq
	 iqNDmV8KwOxFw==
Date: Sat, 6 Jan 2024 22:44:50 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
Cc: Michal Simek <michal.simek@amd.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: xilinx-xdma: Fix uninitialized symbols in
 xilinx_pl_dma_pcie_setup_irq()
Message-ID: <20240106134450.GB3450972@rocinante>
References: <20240106133433.41130-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106133433.41130-1-kwilczynski@kernel.org>

Hello,

> The error paths that follow calls to the devm_request_irq() functions
> within the xilinx_pl_dma_pcie_setup_irq() reference an uninitialized
> symbol each that also so happens to be incorrect.
> 
> Thus, fix this omission and reference the correct variable when invoking
> a given dev_err() function following an error.
> 
> This problem was found using smatch via the 0-DAY CI Kernel Test service:
> 
>   drivers/pci/controller/pcie-xilinx-dma-pl.c:638 xilinx_pl_dma_pcie_setup_irq() error: uninitialized symbol 'irq'.
>   drivers/pci/controller/pcie-xilinx-dma-pl.c:645 xilinx_pl_dma_pcie_setup_irq() error: uninitialized symbol 'irq'.

We need to get this fixed, so I applied this change to controller/xilinx,
as I would like to ensure that it will be included with the rest of the
changes for the 6.8 release

[1/1] PCI: xilinx-xdma: Fix uninitialized symbols in xilinx_pl_dma_pcie_setup_irq()
      https://git.kernel.org/pci/pci/c/7aa5f8fcd6d9

	Krzysztof

