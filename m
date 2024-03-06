Return-Path: <linux-pci+bounces-4582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8037C873BAC
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 17:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BBB1F254FD
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A7613E7DA;
	Wed,  6 Mar 2024 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZwh0PG2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EF5134435
	for <linux-pci@vger.kernel.org>; Wed,  6 Mar 2024 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741101; cv=none; b=BBHX2naLz6RC9/4v7uAYHqF+mJrSkFdgiIWLGQWCnRrK3ECECI2EYBHkW8yP6x11Jlpl7OGL8pYuMk0j3CtQbE1XQGO6mLGap1WDZHLZOgk9JdVmbgYkt2wyY6D8Lo3TKYjkXzz7HkHGs7U6zI+qSW7YchCA00AcetK1pPFwqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741101; c=relaxed/simple;
	bh=qJqn2t33ziNLqJaNqWLQR+RQUrZJ9Q1Wg9M0G2Wujow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TuV2hw0hABI8OSXMqWyBhf0JDQaiMw10BrZnV9Dl6VMbel3wSWlrIXGB5043fET5m3JiDB2B3XfqZHPHc+2gNVdZiQY1fXR1LE4zu6H0yLovLeLgn4S2qopogMJ5SEVMQrPIj2ltockU3HhSXCyOozGtw+i+/pyFULLBcnUOhz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sZwh0PG2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51364c3d5abso734533e87.2
        for <linux-pci@vger.kernel.org>; Wed, 06 Mar 2024 08:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709741097; x=1710345897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3Em7UItCjPwZRzaG7YmB02NOB/4tpF64hDrpjvvxgA=;
        b=sZwh0PG26VS7UKngJSw2Z1uLDNorlfJBfxPqWrHAW6mOVf9ckj5goLxNWU7pwiHdj2
         gdOdAKGtFwtSq2Z2bkHljARguo/6aO4dvHcuctdAVC4lPCMmqcBCm8thjURL63svTyEm
         wwd1RRJh3BBLLy9+lDuPk7BlrQQkB4zCPwjLo0yZ7nw7S3TtbTK4khUSDCjnnV1hvacT
         HKLLTaob2W++ioe7iqsDBswtW13M6u/EGYFkKInf+HADpmPf2oOwqsnes8ChBsceJJ9k
         U4Z9hnEyFUzPwU8oGGNlRpxhRyUPpRo9vHxw+Yu/0Lc040/h2ZBWiaw6yXYeRAac+cRN
         AuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709741097; x=1710345897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3Em7UItCjPwZRzaG7YmB02NOB/4tpF64hDrpjvvxgA=;
        b=A7aW/g7dvUdEkqMjpMnn1K5QxEulSaG1vzKNFcLGG5jA0Ws/2BeRbPNbghI2LmQ8JF
         eyDNqbUqnjku1o6raFYIUWShUpLxIrQdZ1c356tfNVBRQMN/AMamk6+yNhbQ4oxIxeiJ
         UXapMJoQwKi5E4Bosxn5gVGRfjneO98z0DCWSHu3xh9AgPSsj3rPOseil5aYU6ea4JNE
         ecolBYV7bHKhBZsC0dbyKWzMXoxS1Lhs0EyIanigK0paV1eMiDa5ljdzplFEYhGG5Wwy
         1x4C2ghe0QFMz+UBib07Kvj3kGSoohUoy1U9g/uCY0MXKHv0v3eqesFS4nzdhRgc7dkH
         F6YA==
X-Forwarded-Encrypted: i=1; AJvYcCWl9mQ72nz8nWCbmVB0u1xqtSPvk8mQlxAhek3BCZJ+nKJZW1Zg7m74NIeolNACDbSjBFQAfTalNtIO+n5wPcgmNkf9oE+zXei3
X-Gm-Message-State: AOJu0YyQaBhq963oScj+WDCbNnNvAwllcWO2uDlp4OolH6s7bjmsga6S
	K/LjWWxvwRh0ReWXFv2QY0OJGfXAx6SCQ2dj8z/wfc4ZOSoc1VgX8l6GG3nOEyI=
X-Google-Smtp-Source: AGHT+IHVjIGcEqPTmvvZBQtsS+b92ouhmaVQL/wERCVqJwHl9wVNWdOOixJygjxv2Ll+Vjjs6MLJ3Q==
X-Received: by 2002:a05:6512:4888:b0:513:6108:60a3 with SMTP id eq8-20020a056512488800b00513610860a3mr1264269lfb.45.1709741097177;
        Wed, 06 Mar 2024 08:04:57 -0800 (PST)
Received: from [87.246.221.128] (netpanel-87-246-221-128.pol.akademiki.lublin.pl. [87.246.221.128])
        by smtp.gmail.com with ESMTPSA id cf10-20020a056512280a00b005133fa4bc1asm1756818lfb.211.2024.03.06.08.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 08:04:56 -0800 (PST)
Message-ID: <4bd2e661-8e1e-41ff-9b7f-917bb92a196d@linaro.org>
Date: Wed, 6 Mar 2024 17:04:54 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] arm64: dts: qcom: sm8450: Add interconnect path to
 PCIe node
Content-Language: en-US
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
 Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 vireshk@kernel.org, quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
 quic_nitegupt@quicinc.com, quic_parass@quicinc.com
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
 <20240302-opp_support-v8-2-158285b86b10@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240302-opp_support-v8-2-158285b86b10@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/2/24 04:59, Krishna chaitanya chundru wrote:
> Add pcie-mem & cpu-pcie interconnect path to the PCIe nodes.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 01e4dfc4babd..6b1d2e0d9d14 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -1781,6 +1781,10 @@ pcie0: pcie@1c00000 {
>   					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>   					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>   
> +			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,

Please use QCOM_ICC_TAG_ALWAYS.

> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;

And this path could presumably be demoted to QCOM_ICC_TAG_ACTIVE_ONLY?

Konrad

