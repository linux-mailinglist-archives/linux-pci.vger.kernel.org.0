Return-Path: <linux-pci+bounces-4461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDE08708A6
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 18:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE791C20E0D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 17:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA556166C;
	Mon,  4 Mar 2024 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEq2h2Vj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECCF612F6;
	Mon,  4 Mar 2024 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574709; cv=none; b=AYBbMq/u81Ht8r5ATOfPiQFL8YL9PoCE9Te+TFgFSCJZXPVT3aJ5mX8Zroe4+defwEAjueLtQr49WRzyEl01v9hjYGFknsOg2dGDaEaztT/pIvdx9UJjBbUaizk4imrwEDXGwdz9ySObbGbP7Zlu3dR7o3OptgYnPbOBgsqWhu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574709; c=relaxed/simple;
	bh=Z52pfYinDoHJZm+lCg1dFpAvhbY2OsPTMdyq/V4PCn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6aGHLvgLyMHXvPKbvunlv9PW7bUBlwJVN7PUUzVIH3A+ZmyeiYtiUKkHe/UUWLUF55ohpnSgYPppBon5k6zcmlILDiizDf01KMor8fgWojhJmbaTv56ulG1A96BdgHCq+ri1c03ugJ5qxzXS69m8oBfBM0nMh4fQ2ZQ1rvJUjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEq2h2Vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7D4C433C7;
	Mon,  4 Mar 2024 17:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709574708;
	bh=Z52pfYinDoHJZm+lCg1dFpAvhbY2OsPTMdyq/V4PCn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XEq2h2Vjg3QUuaSWCOG2DfuRmf/FeXU4kQbkQnZCf0mAPTcBRtM49DTLOZEWD5owB
	 wJ/+ePZTYFZMRPs3oauD2X8jnwx3y5v/nyZSpMT2xsskGL4acIuRJoZsP3a0XglDBy
	 FNKXHkg2OQYnwFUIQUCeHBQIRZud1hAJmsbRfitBicVAd3blAiN4XHdDdM8uF/zxd2
	 jRzo95NU/XaY+lICYiLsWPObNRx3wsqIpNacsUaeKh+OealHGR/guHmFFDsTK7sNaP
	 Nvrz7jtCwz7dUvM8AidVok0AS3voTPLbvLDoL41Lx4GSi06c1Do+lqebeylWsD+253
	 Y5hRcjElDodNg==
Date: Mon, 4 Mar 2024 23:21:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vireshk@kernel.org,
	quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
	quic_nitegupt@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v8 6/7] PCI: Bring the PCIe speed to MBps logic to new
 pcie_link_speed_to_mbps()
Message-ID: <20240304175136.GD31079@thinkpad>
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
 <20240302-opp_support-v8-6-158285b86b10@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240302-opp_support-v8-6-158285b86b10@quicinc.com>

On Sat, Mar 02, 2024 at 09:30:00AM +0530, Krishna chaitanya chundru wrote:
> Bring the switch case in pcie_link_speed_mbps() to new function to
> the header file so that it can be used in other places like
> in controller driver.
> 

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/pci.c | 19 +------------------
>  drivers/pci/pci.h | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d8f11a078924..b441ab862a8d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6309,24 +6309,7 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
>  	if (err)
>  		return err;
>  
> -	switch (to_pcie_link_speed(lnksta)) {
> -	case PCIE_SPEED_2_5GT:
> -		return 2500;
> -	case PCIE_SPEED_5_0GT:
> -		return 5000;
> -	case PCIE_SPEED_8_0GT:
> -		return 8000;
> -	case PCIE_SPEED_16_0GT:
> -		return 16000;
> -	case PCIE_SPEED_32_0GT:
> -		return 32000;
> -	case PCIE_SPEED_64_0GT:
> -		return 64000;
> -	default:
> -		break;
> -	}
> -
> -	return -EINVAL;
> +	return pcie_link_speed_to_mbps(to_pcie_link_speed(lnksta));
>  }
>  EXPORT_SYMBOL(pcie_link_speed_mbps);
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2336a8d1edab..40403783229f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -282,6 +282,28 @@ void pci_bus_put(struct pci_bus *bus);
>  	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
>  	 0)
>  
> +static inline int pcie_link_speed_to_mbps(enum pci_bus_speed speed)
> +{
> +	switch (speed) {
> +	case PCIE_SPEED_2_5GT:
> +		return 2500;
> +	case PCIE_SPEED_5_0GT:
> +		return 5000;
> +	case PCIE_SPEED_8_0GT:
> +		return 8000;
> +	case PCIE_SPEED_16_0GT:
> +		return 16000;
> +	case PCIE_SPEED_32_0GT:
> +		return 32000;
> +	case PCIE_SPEED_64_0GT:
> +		return 64000;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  const char *pci_speed_string(enum pci_bus_speed speed);
>  enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>  enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
> 
> -- 
> 2.42.0
> 

-- 
மணிவண்ணன் சதாசிவம்

