Return-Path: <linux-pci+bounces-37135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B723EBA526E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 23:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEAD188D5F2
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 21:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BB2274FE3;
	Fri, 26 Sep 2025 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1iLqnk8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A88834;
	Fri, 26 Sep 2025 21:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920627; cv=none; b=dfpBlw7okbgivdLWOuuz+Q/Kl+J+z/gC1UdQaLOYvbLL0HpCIRcSngKIUxuhHRVHI2q3N5W6y+9LeO4IwnkAhLt/XiBzznNMy3oRbuaYF0RczLzxlX0AGQq7LxVnI15sWLU7OJLDU/gmaP0cgESpuzC5hNoc+hNnOfzXr0MRZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920627; c=relaxed/simple;
	bh=QX0AoWNfzlMuR3VFQA1qd0mbdaWkqIiQQy5wfM0tvEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kt/sdIGm8eYdEv0Shzty3ZntLbDXJqPq1eXnwW9qcibjC4oAe0NHAOXjKM6d4La3cGwDW4qZ8KzwUTbBnvc54cYvLkUNRuCDEDwSCF7rb/nyLYSAn1TePFqBcD6qk4iggVxLF4zVg2eNJzE/N5hVocCCfevLCXBwTuDL2L8yUqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1iLqnk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB1AC4CEF4;
	Fri, 26 Sep 2025 21:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758920626;
	bh=QX0AoWNfzlMuR3VFQA1qd0mbdaWkqIiQQy5wfM0tvEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=K1iLqnk8qYI4QmhvkINvOGG6bCUZZ+ajJ3fsUeXwVtcP9KhYZNB1o6tviTMi7EBij
	 k4RIM4mk06PmS1Mq2AJIowFYuwXaH+4GgEz96+hK/ChnAHW2mKod+CxJ3CVV0IpLe2
	 rZPYBIe5X+VBo1k8Sgqv1jd0M2TQhpkJFkavgKQZcQ7XyZuoUvlj5Kv1Ctt1Dwl5oo
	 d8lgnNBj1/jYxqkOIb+QQ97TbIOiNfLhQBRUbtwPUcDRKBby9K1b8B+vPycBWIDbY0
	 SfPAYzWp9EJL7u1NE/+8qw1aghU+EO79pft8P5og3/7Sz4s+D+FiHa1x2GpwusD9zO
	 ia75mI7kSKhkw==
Date: Fri, 26 Sep 2025 16:03:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: dwc: Support 16-lane operation
Message-ID: <20250926210345.GA2267761@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-topic-pcie_16ln-v1-1-c249acc18790@oss.qualcomm.com>

On Fri, Sep 26, 2025 at 02:22:45PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Some hosts support 16 lanes of PCIe. Make num-lanes accept that number.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Applied to pci/controller/dwc, hoping for v6.18.

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 3 +++
>  drivers/pci/controller/dwc/pcie-designware.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index fce15582c22a93167c6f03c0e3ae74f3d0e68b1a..1d7c2b27005f757d272fe78c4df48daa6628f0a3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -774,6 +774,9 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  	case 8:
>  		plc |= PORT_LINK_MODE_8_LANES;
>  		break;
> +	case 16:
> +		plc |= PORT_LINK_MODE_16_LANES;
> +		break;
>  	default:
>  		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
>  		return;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index a333ab0b0bbd8c2fc0ee32a5619696178c6b7aa2..ae11a78cc5b9a4202794cfa515e1ee496a4f47c2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -90,6 +90,7 @@
>  #define PORT_LINK_MODE_2_LANES		PORT_LINK_MODE(0x3)
>  #define PORT_LINK_MODE_4_LANES		PORT_LINK_MODE(0x7)
>  #define PORT_LINK_MODE_8_LANES		PORT_LINK_MODE(0xf)
> +#define PORT_LINK_MODE_16_LANES		PORT_LINK_MODE(0x1f)
>  
>  #define PCIE_PORT_LANE_SKEW		0x714
>  #define PORT_LANE_SKEW_INSERT_MASK	GENMASK(23, 0)
> 
> ---
> base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> change-id: 20250926-topic-pcie_16ln-8b505b7909f4
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 

