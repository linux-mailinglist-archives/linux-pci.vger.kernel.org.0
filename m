Return-Path: <linux-pci+bounces-319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE9980035B
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 06:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9EB9B21024
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 05:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B378C17;
	Fri,  1 Dec 2023 05:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5SIO7L3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D5B883B;
	Fri,  1 Dec 2023 05:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F47C433C9;
	Fri,  1 Dec 2023 05:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701409998;
	bh=PjqPb511ws4okVmdJfgOF6OoXYOFE+we11wjlLHkrwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l5SIO7L35M/feZxylEJcLbwmAfv9nDIkZdr7wp9zag0UmZuc7g9kB70PvjS5qmwAQ
	 THSLnho/tjROsSocd2Ko7u2kc3zI43/o9+XatmAv54yRfI3dG7nWmrePnk5WdMVPTx
	 3KzOddMcr2R+yDXJIQo6AsE8YRxLK2erni5iUurZcpJ34nxw+aHLT7S5lea8b7yiwp
	 EtsVaVMasDliq2wQdfmGMCNOKDOaPNYNq9Q4cERWRRv79wtT1rWcuJdf1x3S2XLne0
	 QCo6S1IIRu0GvZilFTbFtVMWfq6Qo56GeAgGIuMuxGl70eR5fLf3DSfiHlhhipMNxr
	 2UOEUq+2iUlcg==
Date: Fri, 1 Dec 2023 11:22:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	konrad.dybcio@linaro.org, robh+dt@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	dmitry.baryshkov@linaro.org, robh@kernel.org,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_parass@quicinc.com, quic_schintav@quicinc.com,
	quic_shijjose@quicinc.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v8 3/5] PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the
 function names
Message-ID: <20231201055258.GH4009@thinkpad>
References: <1699669982-7691-1-git-send-email-quic_msarkar@quicinc.com>
 <1699669982-7691-4-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1699669982-7691-4-git-send-email-quic_msarkar@quicinc.com>

On Sat, Nov 11, 2023 at 08:02:59AM +0530, Mrinmay Sarkar wrote:
> Without the prefix, the function name would appear as
> "/sys/kernel/config/functions/{sdx55/sm8450}". This will be a problem if
> multiple functions are supported for this endpoint device.
> 
> So let's add the "pci_epf_mhi_" prefix to identify _this_ function
> uniquely. Even though it is an ABI breakage, this driver is not used
> anywhere outside Qcom and myself to my knowledge. So it safe to change
> the function name.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Since I authored this patch and shared it with you, the authorship needs to be
preserved. If you just apply the patch using 'git am' it would do the right
thing.

- Mani

> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index b7b9d3e..5b0515a 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -677,8 +677,8 @@ static int pci_epf_mhi_probe(struct pci_epf *epf,
>  }
>  
>  static const struct pci_epf_device_id pci_epf_mhi_ids[] = {
> -	{ .name = "sdx55", .driver_data = (kernel_ulong_t)&sdx55_info },
> -	{ .name = "sm8450", .driver_data = (kernel_ulong_t)&sm8450_info },
> +	{ .name = "pci_epf_mhi_sdx55", .driver_data = (kernel_ulong_t)&sdx55_info },
> +	{ .name = "pci_epf_mhi_sm8450", .driver_data = (kernel_ulong_t)&sm8450_info },
>  	{},
>  };
>  
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

