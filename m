Return-Path: <linux-pci+bounces-17731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B449E5187
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 10:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1171662F8
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C213D1D516A;
	Thu,  5 Dec 2024 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtNdUOId"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BB318FC70;
	Thu,  5 Dec 2024 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391579; cv=none; b=Bph5u7hPZMH5jVvqztoeZUwpE9/124k6kHQQMniMSPfvIQQokrr8T7cSwTgyn4ynkjiWaOGAL937hcSo7hrlr6Z8NhGKrI7wcxa5W5usp6sF1MRuNi6rlrJhDie0nNSIlsmOHz1c3NT45ZArGylYo562fZbpCEAHCQw1Ylrd6aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391579; c=relaxed/simple;
	bh=gJ77VvLJHaFsY3mn/n397kmuNme7qH9uocwG3rnFPmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J85BCEmFmxifWzZyYUL4fbLUJ0Y4VrTSAVlWMjDGgcIzP/L1nhZ19oYzm+Ewrq7m17x2ltZnDFW9nhJSuJjNJywZtaPsD3n7TBpfpu6SPSM6vrG12Rf25Mq6qRzAIpLYLEKcfo3Iq86LLVCqIyhQb+cKBJ18TtfqgnqhdOLs/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtNdUOId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887C9C4CED1;
	Thu,  5 Dec 2024 09:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733391579;
	bh=gJ77VvLJHaFsY3mn/n397kmuNme7qH9uocwG3rnFPmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OtNdUOIdJL0Oi9KyWIfbR3RM3C7OsLnLciwlMmGMCc383wop7/gcfXEOr/p4oenK3
	 BqPzcd9GNVJPBJM4xIh+3mBcGUJJIu3xTXw34JCBpJ9JMd7/VThPXMBY0m586FOZ0M
	 z/uh7u1/t3ZN+1bbGyRBkW1ti7jjVTNLzqf1iMRp0CI0+1+PqqtEHCLpJXhX8gTxhf
	 7nzA9Z6CakN9C4BNSplYbCMJ7Q0EAzetyl/Fb7NGK19rkn+kWApo8LmFuE+GBmJeBM
	 f556b0/78MAnWAIArkxaHUH1Hk/tBu4RpHIcSslT9BC7L+/mX1iGvKMO5+B88DrytO
	 zVZgRCqHj8d0Q==
Date: Thu, 5 Dec 2024 10:39:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 2/6] phy: qcom: Introduce PCIe UNIPHY 28LP driver
Message-ID: <gawyxbgql7pru43e6rz4luhefaayrwiw3fplzj3k5cahzkppzr@uhuemcq5djw7>
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-3-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204113329.3195627-3-quic_varada@quicinc.com>

On Wed, Dec 04, 2024 at 05:03:25PM +0530, Varadarajan Narayanan wrote:
> +	return 0;
> +}
> +
> +static struct platform_driver qcom_uniphy_pcie_driver = {
> +	.probe		= qcom_uniphy_pcie_probe,
> +	.driver		= {
> +		.name	= "qcom-uniphy-pcie",
> +		.owner	= THIS_MODULE,

Srsly, upstreaming 10 year old code? No one figured out to fix 10 year
old code before sending it upstream or entirely drop it and use new code
as template?

NAK

Best regards,
Krzysztof


