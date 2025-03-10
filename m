Return-Path: <linux-pci+bounces-23289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C3EA58E4C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B24416936E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 08:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D662236EB;
	Mon, 10 Mar 2025 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQPa0jwa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D1B1D5142;
	Mon, 10 Mar 2025 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595901; cv=none; b=Re6IR3jfF1rUH3L0T2w3AMhuWGy7EHFwIGQJWsLfPVkDG9H79dxFWAqfpzvp7sLgXwH6YlD53pQyFIUqOr0zZ1w/A39HyiBxVpKYqpeYFywg4bcoj0Rc0ScC3bVtzsh3AcPLdRuhuFIF9oFhngpRnry2uPwcPOj1Vh65SWZ6Z14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595901; c=relaxed/simple;
	bh=r4/JPIW6MjEsja8Y5IUSOTA1XlmLtgY4IVJWbznTO8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfOi5V44Wtua0JDhIZRSc/sP1wXRiox8ccKniyN9x+2pgIhwy3B2XXhSQjFUnAuYXpNIMa8n9tLrxta+/IYJU+HSPX6G6cS22sB5iX8TG9zcF8T2U6EWQZ6CeeDak0n07LIhQ/d1Nyt93EYzwiqCTkNQd2ZLGvFDH/Jhz7tCC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQPa0jwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975F8C4CEE5;
	Mon, 10 Mar 2025 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741595900;
	bh=r4/JPIW6MjEsja8Y5IUSOTA1XlmLtgY4IVJWbznTO8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQPa0jwa5JqeaOt1cjSzr9z9tpr6jtYK1lHAYg7b2vRUcDnms7auuiuqdV8wBH7Xw
	 EUS+AxlHGWEr34gVfJqpD0xFC8dR0GxmbvkLy3kMHkQqTRjE20B6D6s4Ulm3bgHS1O
	 /16bQ9BxGC3AfCIVZZIXwH4GcmmAlZvTMornvlaKpUh/wLh0NQklS3OkyHyUu7NipP
	 irHVymfYyhvT+o2bZfh8DdKZWp3HzLdEC8JbxPzMpxtG15IBczR8tNqdPSaOtBVVAc
	 ZkEDX6ZaQtlhe8Kj4XfP8XbPRvnB65IdhHEG0SV4z7NBjSMycqZ8xV9d9J1GLmrZj+
	 Tigqn6u37+9TQ==
Date: Mon, 10 Mar 2025 09:38:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org, abel.vesa@linaro.org, 
	quic_qianyu@quicinc.com, quic_krichai@quicinc.com, johan+linaro@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 2/4] arm64: dts: qcom: qcs615: enable pcie
Message-ID: <20250310-neon-wealthy-sheep-2da4cd@krzk-bin>
References: <20250310065613.151598-1-quic_ziyuzhan@quicinc.com>
 <20250310065613.151598-3-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250310065613.151598-3-quic_ziyuzhan@quicinc.com>

On Mon, Mar 10, 2025 at 02:56:11PM +0800, Ziyue Zhang wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Add configurations in devicetree for PCIe0, including registers, clocks,
> interrupts and phy setting sequence.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 142 +++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> index f4abfad474ea..282072084435 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> @@ -1001,6 +1001,148 @@ mmss_noc: interconnect@1740000 {
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> +	pcie: pcie@1c08000 {

Incorrect indentation (I am not going to look at anything else here).

Binding wasn't tested (you expect community to be the tools), this has
obvious style issue, so I really do not believe you performed internal
review.

Quality of patches recently coming from quicinc is really poor. That's
one more example. I raised it internally and it seems it reaches people
slow, so here you have a public nagging.

Do the internal review before you post.

Best regards,
Krzysztof


