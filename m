Return-Path: <linux-pci+bounces-18335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 491C89EFC1C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 20:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD26118847B0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 19:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6818190664;
	Thu, 12 Dec 2024 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnBdrybr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA93E18CBFB;
	Thu, 12 Dec 2024 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030773; cv=none; b=Hpm7MfOIa3p3FBB0gdximEPyDkwty5ipMzXr4BbSq9D33YxPiBClwqjB7l+H54tD+ZRnn0j6u2OYunvpqHEf+GcFORr5PTfUfiQNaZ8nrZdNN8+bRB7TJxgMu+dREfIerKAfk8SajpCgGWz06YB1p4Xu4Yd0kfuRZpXBVxxUZx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030773; c=relaxed/simple;
	bh=N+EJbicTSJqYwAn+hAWPtB4u/8m+fF3kJ4QK3LRp2GM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QCO7jsjxPyCyX6/7oAYuXPCQtME9IYZktVczJVnlkI1C8MkzzH7fBn34ErLZLEcyw/dnIe6rkNdcfkeUFsPSH5l8edgumBCtaGMsR/Jw29TN5OjyGjIdfmwD2OcmOAPtnHztQSVNKCGXpYi/Vius0IExDTbjqXZmRrrTu6WXm/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnBdrybr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9A7C4CED0;
	Thu, 12 Dec 2024 19:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734030773;
	bh=N+EJbicTSJqYwAn+hAWPtB4u/8m+fF3kJ4QK3LRp2GM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PnBdrybrDBCuwdp0AJl0uUhutNvE+TcCMs0jCAfzCfEGcmOQ0zk/x4He2VHTX3WA7
	 o7iuxK9rUl4MXncgf7kJFhfu0ldF7H8rHXlOCzPQs4Y0LZymiqY7JIAj44Yi8GifXk
	 nqLwqV6PHVnI0dHDtlX6nsq+VNVANv8CSjNNdfR3G4LnrMgnFODPW7WeDxIkd4m/By
	 wXS3p0xJYg5i0gum6ZgXLG2kBx9QrdZtuFX4pwIbVfX72J6sMs9o30BnYc7ebQOVyO
	 O5kbEK5zGsicezyLKbU4EIYwu8u5qGJcuFjOP1qASTcn8y8oid5mkVoMCiYZ5x6z1H
	 5UyjO4zOWWswg==
Date: Thu, 12 Dec 2024 13:12:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] PCI: endpoint: fix bug for 2 APIs and simplify 1
 API
Message-ID: <20241212191251.GA3358574@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-pci-epc-core_fix-v3-0-4d86dd573e4b@quicinc.com>

On Tue, Dec 10, 2024 at 10:00:17PM +0800, Zijun Hu wrote:
> This patch series is to fix bug for APIs
> - devm_pci_epc_destroy().
> - pci_epf_remove_vepf().
> 
> and simplify APIs below:
> - pci_epc_get().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Applied to pci/endpoint for v6.14, thanks!

> ---
> Changes in v3:
> - Remove stable tag of patch 1/3
> - Add one more patch 3/3
> - Link to v2: https://lore.kernel.org/all/20241102-pci-epc-core_fix-v2-0-0785f8435be5@quicinc.com
> 
> Changes in v2:
> - Correct tile and commit message for patch 1/2.
> - Add one more patch 2/2 to simplify API pci_epc_get().
> - Link to v1: https://lore.kernel.org/r/20241020-pci-epc-core_fix-v1-1-3899705e3537@quicinc.com
> 
> ---
> Zijun Hu (3):
>       PCI: endpoint: Fix that API devm_pci_epc_destroy() fails to destroy the EPC device
>       PCI: endpoint: Simplify API pci_epc_get() implementation
>       PCI: endpoint: Fix API pci_epf_add_vepf() returning -EBUSY error
> 
>  drivers/pci/endpoint/pci-epc-core.c | 23 +++++++----------------
>  drivers/pci/endpoint/pci-epf-core.c |  1 +
>  2 files changed, 8 insertions(+), 16 deletions(-)
> ---
> base-commit: 11066801dd4b7c4d75fce65c812723a80c1481ae
> change-id: 20241020-pci-epc-core_fix-a92512fa9d19
> 
> Best regards,
> -- 
> Zijun Hu <quic_zijuhu@quicinc.com>
> 

