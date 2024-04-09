Return-Path: <linux-pci+bounces-5949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A5A89DE3D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 17:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A8F1F25DBF
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 15:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B89313C80B;
	Tue,  9 Apr 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgWguIoP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8EE13C800;
	Tue,  9 Apr 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675232; cv=none; b=o56TlAcubow9b0cWHWvpf6O2f540awmFz5v3Oy3wsKuzNcMm6RGdOnl3W5Vwro0QE1iVjR1+2xljGLrTws7bJRNeM8A92uttGCkxBwDC9dm/99hiUQFVa1HylyYZ9j+ox6Kd4XyPYzJuMyQCF8xoeooohEUAQ9g4piFaWtNXYB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675232; c=relaxed/simple;
	bh=UI4DdX3zkv0IR14xJ19mTtofNIARX96E6JHAMnPik3k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gbRH+TZuF4lThttqGqReHgVb3ybVs14qf38Mew8Fp7u0GCyWfzHK1xi8ks+itKasCVi65jx0rDBn9Ru1RPEaZLKMwYLj/sWyLRK3LCBMoHNfzVBdHqSl8QRkPjtZTfIW1IuXdh1Rvn+3YADolPy3CZZBFkyC8LcS4TAGm0zmXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgWguIoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E27C433C7;
	Tue,  9 Apr 2024 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712675232;
	bh=UI4DdX3zkv0IR14xJ19mTtofNIARX96E6JHAMnPik3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KgWguIoPQ/tksjX/+qv2DmE54YmB689iMFlJROavHIpDMgNQU/MpjnTI1ftpfCIZW
	 bRC4lN6q6nZEQVyeNWFqtRUZ18kZPPOKdTchIFEBgVq+cyHHzWPNPXpxBvlbSEpE/S
	 qTpK5EF/f9l4l+mRShmJCCFahgIFPfENT8me09wfqDu9ayw8A2iQg7zqVlAN6/3HVj
	 HHhKjBJk/EhZj5LPVwecQBjRfgzzMjC3XMaCT9cw+omBLxVfSH4G8KzZuFoi/EVSlb
	 mrpFuFj+lTqUKvp+7l+Hte00bBuYv1oUvWHWFNknvqCYIeFHITXEYpxMVnkyYYOtPn
	 OXNr54vx9UX0Q==
Date: Tue, 9 Apr 2024 10:07:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, johan+linaro@kernel.org,
	bmasney@redhat.com, djakov@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v10 5/6] PCI: Bring the PCIe speed to MBps logic to new
 pcie_link_speed_to_mbps()
Message-ID: <20240409150709.GA2076210@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409-opp_support-v10-5-1956e6be343f@quicinc.com>

On Tue, Apr 09, 2024 at 03:43:23PM +0530, Krishna chaitanya chundru wrote:
> Bring the switch case in pcie_link_speed_mbps() to new function to
> the header file so that it can be used in other places like
> in controller driver.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>

Unnecessary.  Not every code review comment needs to be acknowledged
in the commit log :)

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c | 19 +------------------
>  drivers/pci/pci.h | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e5f243dd4288..40487b86a75e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5922,24 +5922,7 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
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
> index 17fed1846847..4de10087523e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -290,6 +290,28 @@ void pci_bus_put(struct pci_bus *bus);
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

