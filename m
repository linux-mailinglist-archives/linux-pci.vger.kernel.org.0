Return-Path: <linux-pci+bounces-1603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7928821FE5
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 18:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC071F22ADE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442EC14F97;
	Tue,  2 Jan 2024 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4kAblgj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211AC14F95;
	Tue,  2 Jan 2024 17:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852C1C433C8;
	Tue,  2 Jan 2024 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704215147;
	bh=ALfFTnYOzFxt2eedYpxx3aMSnv8osOGB3dsTiOOMln4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4kAblgjzJnK7EHbBBctR+s+BfA646q3sfa9WvMw+cLW/R61ewdYFsC2DzbvHEmhb
	 udrKXqm37dVG70e6j/rIi3eL4pj2/Wu+VagnHIvMYbYzORqXYZFWYtBgd8FwNobriA
	 2DgGt5zK5slNqXRoew5wiAQg5a3V576E6VsNhWXcAgOrX5U8OVfkE62p8oEges3Gb7
	 Qu5fsJM8RDp69AhqTUEVu0EmYrF/esZ1bNPFTuYx+iDWFiPmDF2Z/hfn5UfAFWqGWZ
	 UHLvdTt/QG4Rm1yukCZTaJD+ovSSTZ3k5cloem5oUO6OAM+MU7zqHjNQN3GWrhN776
	 rPpDBY9+O2X4A==
Date: Tue, 2 Jan 2024 22:35:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Vinod Koul <vkoul@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] PCI: qcom: Read back PARF_LTSSM register
Message-ID: <20240102170529.GE4917@thinkpad>
References: <20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org>
 <20231227-topic-8280_pcie-v1-3-095491baf9e4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227-topic-8280_pcie-v1-3-095491baf9e4@linaro.org>

On Wed, Dec 27, 2023 at 11:17:21PM +0100, Konrad Dybcio wrote:
> To ensure write completion, read the PARF_LTSSM register after setting
> the LTSSM enable bit before polling for "link up".
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

I'd consider this as a bug since if the LTSSM write gets cached in Write Buffer,
then the polling time becomes wrong in dw_pcie_wait_for_link(), leading to
false link_up failure.

Although both of the write/read (LTSSM in qcom_pcie_2_3_2_ltssm_enable(), and
PCI_EXP_LNKSTA in qcom_pcie_link_up()) belong to PCIe domain, they belong to
different regions (PARF, DBI). So I'm not sure we can safely ignore the write
completion issue. So,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index a02dc197c495..3d77269e70da 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -540,6 +540,7 @@ static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
>  	val = readl(pcie->parf + PARF_LTSSM);
>  	val |= LTSSM_EN;
>  	writel(val, pcie->parf + PARF_LTSSM);
> +	readl(pcie->parf + PARF_LTSSM);
>  }
>  
>  static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

