Return-Path: <linux-pci+bounces-35194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E9B3D29D
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 13:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC50F17A206
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 11:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4FE1E5718;
	Sun, 31 Aug 2025 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bp+g97dC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F928F5;
	Sun, 31 Aug 2025 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756640914; cv=none; b=f3VQi66K2vSOOM3t6Oc3QAgVRFFNu++YcO2FTB6wZhz+FUuvAA2ubdFd6cBhlj+AqZERVbUQZRp5JzN4b4pWHa3Itg5PqQBv/orvbq5qzZkejnQCR6bwq5rKqK7EIQC9M0LMp36ncFQJ/853yOMFqYp+bfX4YWn0AMtl4yfAcPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756640914; c=relaxed/simple;
	bh=15ytesglya7+FRpo/qHWnOIxqe9nWdvalbomNJMS2R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuOsBurDU3kW1lWU9VIDRbh6jCk74ghokf6EygRRIUuK4eVIDjlYL5edulZcNFXa6cCavNk+bgKChmIkL6e38jzZ9++hk8W/2Uty/lLMmGSyygdTKyVCtgXvhf2/73xf45M/IcDEpQLYaWC1gvtZdYGEsuspD9/c+LVCm4yckqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bp+g97dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846D2C4CEED;
	Sun, 31 Aug 2025 11:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756640913;
	bh=15ytesglya7+FRpo/qHWnOIxqe9nWdvalbomNJMS2R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bp+g97dCeKP2Qwqno8SkhNnLB6t1FUU7YXhIgCGeMznzNqlgR2HBFlK/3ke6B8Q6R
	 b6S05hPv5hkC7aJrwoU7a0zmkpQ80lcXI5gEG1iwE7MCfQFmTGAxAkXQOqhEPt5qTQ
	 rT4Q8mewxrCUGeV6jY9lm/crVysijHtS9wypK4kXpONqqkV1qe7Pxi0IlYGxF4E/JX
	 VDqkSoJN1VoXLL3/C028qMhlCFKh1XhIjLV94w5IQrZjFVtg+Kh690DDYao7UWkoPh
	 27begywPYwzoQLmE8pIw7UwoDZnPlffQYakm+YTJrUBO2CpV2RyNTdut5Q85HMiHCx
	 HW8OuQOvvjICg==
Date: Sun, 31 Aug 2025 17:18:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com, mmareddy@quicinc.com
Subject: Re: [PATCH v8 2/5] PCI: dwc: Add support for ELBI resource mapping
Message-ID: <ymsoyadz2gkura5evnex3m6jeeyzlcmcssdyuvddl25o5ci4bo@6ie4z5tgnpvz>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
 <20250828-ecam_v4-v8-2-92a30e0fa02d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250828-ecam_v4-v8-2-92a30e0fa02d@oss.qualcomm.com>

On Thu, Aug 28, 2025 at 01:04:23PM GMT, Krishna Chaitanya Chundru wrote:
> External Local Bus Interface(ELBI) registers are optional registers in
> DWC IPs having vendor specific registers.
> 
> Since ELBI register space is applicable for all DWC based controllers,
> move the resource get code to DWC core and make it optional.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++++
>  drivers/pci/controller/dwc/pcie-designware.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 89aad5a08928cc29870ab258d33bee9ff8f83143..4684c671a81bee468f686a83cc992433b38af59d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -167,6 +167,15 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>  		}
>  	}
>  
> +	if (!pci->elbi_base) {

Why this check is needed? Are we expecting any DWC glue drivers to supply
'dw_pcie::elbi_base' on their own?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

