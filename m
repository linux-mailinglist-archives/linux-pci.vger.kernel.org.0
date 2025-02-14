Return-Path: <linux-pci+bounces-21509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420A6A364DE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF2B3B29D4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E02267B11;
	Fri, 14 Feb 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjRAuiuS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED33626869A
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554856; cv=none; b=cL2iVLPsGXL++25sTztFgKjK5PdixcGMSGQGZmFOnbpcTrMAG+a1nHxd30x8mLGxCu7mgj/5PpGMpUexWziLqSVp98Lm/cTzL//5Q/jKqvtWrYZKrC5TmEHS6+NjrDFcXVICSn/yhSQ33k/lggGU+15t61QuhnSfq8AiJguukKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554856; c=relaxed/simple;
	bh=HarqFzddhCSp9oWsiFeGEfCDmgdDzfkt6blD8yhGObY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBWungxvj6Czmn6OEuXVRAezE+KLZp7OaJDGCDqUIAYoG/9F8PhBcF7Md25UAcHT1QEdjaewF6JwnNRWV3ZMOW4cg3siqqNg2NBQmdU8G+NSqwZPbW4Nes9PSX25Bbz91NSO3pozI4ASzkXXF5y2dY4A0asAR7jI3cVgds0keww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IjRAuiuS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22101839807so8406125ad.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739554854; x=1740159654; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SL3H0DuOiIRBzcq9keabamHJlGFq0GX85r7ZwTWY1oc=;
        b=IjRAuiuSniSVvxLiIOpQzwqZQpStw2jVJe0M0GCzwG038ByBKJvDtPFc+JuFAf/gB1
         HvWCmE6x0SM9TNTksgfH+mdWZAl39FCPCbC08YHCIvY7FtGusNXlmrbK+j1t1feMTo8b
         eq+5w1KFgGw5QdklNsvuPyYbYlNGogfWH4mq5QU668GnTuWtgnqeJf205q4feGlvIGY7
         JgERQv645ZjwKyOUSpvUA3vyl1LEJdAB1D3Mb74b3aB96sPU/CftNCpMMk/LNbaCmjZx
         2E3KPGWEBXj8WBq0EYn4cOrNmKz7dWzWQV/o/niAL4B4k/bBnFxeGfdmDuO3c2XDg0Uc
         7gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554854; x=1740159654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SL3H0DuOiIRBzcq9keabamHJlGFq0GX85r7ZwTWY1oc=;
        b=p82MCadkL+ClwSRawgDHzNxgqbLOWt+MQNkdHottPyjuNZibWz26B7Te/7+FBO4tsZ
         GVrsBD0ofzNmfU2M1OPJ4U3OiGq/o+nWlI8/H+q4TpDA7/2HqLpFLKHlJMD+uymHebaU
         clad1N7fvHkiDUE7cP8FKWrWtp+rPK1AVvc+takB7iAriKQn7aWf3W9hCXlNXf2Q4OZ/
         IBQE7sGiGgEJRMf1dyMtbeKszWegvRcMDDQvzKM3sqf6hFvYmhCMyL6PYIPJtA1hTXz6
         MoxhRMMB92/1eiyQ0fcq4njVTlYHL17dNIOuNdiLqy/6LYrQE0v6euGQuo41PIUtwH0S
         utAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNogBXJxxsuCVqukCc2Qd3MJm5CB8DvAmsJBRplj/UynWHsCJP+frf7TGQlBQP2osklmx/8vZ1pMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKwR8uKB87wwENvthjzCqjhlXLS1HD3UJqYo9GQ7El/Aw5B1tO
	/nIv+m911rfA40QjArKBDJP26sfgVIn9XEdqzdsksdfSUMMXexDI3tJawj/UqQ==
X-Gm-Gg: ASbGncs9GTNnx7reezNEuwf30QEmtxmLTjbZiypyZvJHcpNWLZNh6488Oz8c/ct9zES
	bm+2UdwGB2/PRJ1yWFkkKiWLyANmWfc0ndVDyA62FY9WjyOMy8c55DAc/JcMTz2v/lYnVlCqRIy
	zSiVGnQgE5dPkg3smDXGxInXsaqW+HzmaeFogmVbdKvkAIbKyqZA+4g85xoRqqwZzyLHZpktfih
	uBDxdsqRcyD27/EI48ZOG/+3Ai13k7IezXpWu4RG2GZLSitD18SvsfAXuye7MHdkDR2oLI1xvgN
	4xZj4+8Z+624Av0kWXsytH5Uzqw=
X-Google-Smtp-Source: AGHT+IFh0sbLUMbF5mJTepHDsyslk02Txh0BE7kYA1Ix9Jnaoqm96HhvZ/9FCnIuMaCAHju+TzXWhg==
X-Received: by 2002:a05:6a00:3c84:b0:730:9a85:c940 with SMTP id d2e1a72fcca58-732618fa927mr321487b3a.20.1739554854197;
        Fri, 14 Feb 2025 09:40:54 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242549d01sm3528978b3a.14.2025.02.14.09.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:40:53 -0800 (PST)
Date: Fri, 14 Feb 2025 23:10:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 0/7] PCI: endpoint: Allow EPF drivers to configure the
 size of Resizable BARs
Message-ID: <20250214174047.6zrpuvtgrbxw333t@thinkpad>
References: <20250131182949.465530-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250131182949.465530-9-cassel@kernel.org>

On Fri, Jan 31, 2025 at 07:29:49PM +0100, Niklas Cassel wrote:
> The PCI endpoint framework currently does not support resizable BARs.
> 
> Add a new BAR type BAR_RESIZABLE, so that EPC drivers can support resizable
> BARs properly.
> 
> For a resizable BAR, we will only allow a single supported size.
> This is by design, as we do not need/want the complexity of the host side
> resizing our resizable BAR.
> 
> In the DWC driver specifically, the DWC driver currently handles resizable
> BARs using an ugly hack where a resizable BAR is force set to a fixed size
> BAR with 1 MB size if detected. This is bogus, as a resizable BAR can be
> configured to sizes other than 1 MB.
> 
> With these changes, an EPF driver will be able to call pci_epc_set_bar()
> to configure a resizable BAR to an arbitrary size, just like for
> BAR_PROGRAMMABLE. Thus, DWC based EPF drivers will no longer be forced to
> a bogus 1 MB forced size for resizable BARs.
> 
> 
> Tested/verified on a Radxa Rock 5b (rk3588) by:
> -Modifying pci-epf-test.c to request BAR sizes that are larger than 1 MB:
>  -static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
>  +static size_t bar_size[] = { SZ_1M, SZ_1M, SZ_2M, SZ_2M, SZ_4M, SZ_4M };
>  (Make sure to set CONFIG_CMA_ALIGNMENT=10 such that dma_alloc_coherent()
>   calls are aligned even for allocations larger than 1 MB.)
> -Rebooting the host to make sure that the DWC EP driver configures the BARs
>  correctly after receiving a link down event.
> -Modifying EPC features to configure a BAR as 64-bit, to make sure that we
>  handle 64-bit BARs correctly.
> -Modifying the DWC EP driver to set a size larger than 2 GB, to make sure
>  we handle BAR sizes larger than 2 GB (for 64-bit BARs) correctly.
> -Running the consecutive BAR test in pci_endpoint_test.c to make sure that
>  the address translation works correctly.
> 

I took the liberty since this series is mostly related to endpoint and applied
to pci/endpoint!

- Mani

> 
> Changes since V3:
> -Picked up tags.
> -Addressed comments from Mani.
> 
> 
> Kind regards,
> Niklas
> 
> Niklas Cassel (7):
>   PCI: endpoint: Allow EPF drivers to configure the size of Resizable
>     BARs
>   PCI: endpoint: Add pci_epc_bar_size_to_rebar_cap()
>   PCI: dwc: ep: Move dw_pcie_ep_find_ext_capability()
>   PCI: dwc: endpoint: Allow EPF drivers to configure the size of
>     Resizable BARs
>   PCI: keystone: Describe Resizable BARs as Resizable BARs
>   PCI: keystone: Specify correct alignment requirement
>   PCI: dw-rockchip: Describe Resizable BARs as Resizable BARs
> 
>  drivers/pci/controller/dwc/pci-keystone.c     |   6 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   | 218 +++++++++++++++---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c |  22 +-
>  drivers/pci/endpoint/pci-epc-core.c           |  31 +++
>  drivers/pci/endpoint/pci-epf-core.c           |   4 +
>  include/linux/pci-epc.h                       |   5 +
>  6 files changed, 239 insertions(+), 47 deletions(-)
> 
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

