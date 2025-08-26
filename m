Return-Path: <linux-pci+bounces-34704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143E4B35398
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 07:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C6324498C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 05:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061F22F1FDF;
	Tue, 26 Aug 2025 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdCfstlY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC690284678;
	Tue, 26 Aug 2025 05:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187678; cv=none; b=ntOqgBlReNyheX8lz+BVNq7XA7PVoK8iZ6GYBvYPi6WC2inanDjlQvLoftu+BaUBY+OEccdGccAjBWjvL7zLPxuN07pfMbUUyAz3zCkROr4vN5+yEKP7JnlZlMLmBTkEQYck816LyFn6HXvRahBGKYofcslE7S4yfPDue4GZEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187678; c=relaxed/simple;
	bh=mDCo2e5iajiOGDQorlkOT7JbhHy60rx+m/owKkvEKkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaeEy7gWEFGs8+dhEc/ThkYKliHXSr8fTCvGe2EHhOTl/FeUZZ3FXivB7DicG4QHIeSG5T3oo8UJNred4/J4ePbYxr7UlA4kGNVlEJgfDHcAx/CjirYxJMGGZV0xIGYjUNpgq7dnvXNcvrFxBo81saGsShQqvPrkzTbvNpDUmWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdCfstlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B66BC4CEF1;
	Tue, 26 Aug 2025 05:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756187678;
	bh=mDCo2e5iajiOGDQorlkOT7JbhHy60rx+m/owKkvEKkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdCfstlYzoWuk+eqzBYLbfMOWOEgtpETEheP4R+ALiWMSS88MUkEedmPpWaqlYAFu
	 8lfYQSf9pN1cblwV7SEqEWwq5GqRGppe7QcVlXwD4ZQj1MkRQdLdmqWm6RSOwWoQ3N
	 Ry3OEFb5NUhkxwus/ZOWMChNTrMq/ioVvGELxHW7fawdwwtvqgRtTIW0GFbDyzIJTj
	 jk3zFdQG2oF9vlhJUtx9aIFqHut9x2Ky2lMSNvNEnB5TCEcJHMkVroA5e/XwvVeMQx
	 cXP1Cax+e+TjnPIQ943ZQ8CEACKAwa57XpzBimqumZJERFdVic1Tr1zkTx2NVAk6H1
	 z20cVNXZtvchQ==
Date: Tue, 26 Aug 2025 11:24:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 7/7] PCI: qcom: Use frequency and level based OPP
 lookup
Message-ID: <wuavhpbdx6onb6m7xxkztifyigcmhjevzs5ihjof75zksk7rui@4nixiuioyqeb>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <20250820-opp_pcie-v4-7-273b8944eed0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820-opp_pcie-v4-7-273b8944eed0@oss.qualcomm.com>

On Wed, Aug 20, 2025 at 01:58:53PM GMT, Krishna Chaitanya Chundru wrote:
> PCIe supports multiple data rates that may operate at the same clock
> frequency by varying the link width. In such cases, frequency alone
> is insufficient to identify the correct OPP. 

You need to reword the description. It mostly sounds like you want to select OPP
based on freq and link width instead of freq and data rate due to that fact that
you used 'link width' as the differentiating factor in the first sentence.

>Use the newly introduced
> dev_pm_opp_find_key_exact() API to match both frequency and
> level when selecting an OPP, here level indicates PCIe data rate.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..4f40fc7b828483419b87057c53e2f754811bdda0 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1555,6 +1555,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  {
>  	u32 offset, status, width, speed;
>  	struct dw_pcie *pci = pcie->pci;
> +	struct dev_pm_opp_key key;
>  	unsigned long freq_kbps;
>  	struct dev_pm_opp *opp;
>  	int ret, freq_mbps;
> @@ -1582,8 +1583,10 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  			return;
>  
>  		freq_kbps = freq_mbps * KILO;
> -		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
> -						 true);
> +		key.freq = freq_kbps * width;
> +		key.level = speed;
> +		key.bw = 0;
> +		opp = dev_pm_opp_find_key_exact(pci->dev, key, true);

As Neil said, this needs to work with older DTs too where there were no 'level'
properties.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

