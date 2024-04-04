Return-Path: <linux-pci+bounces-5746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B112898F13
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 21:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64BDFB26724
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 19:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866C513440F;
	Thu,  4 Apr 2024 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSocWpXC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E441339A5
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259186; cv=none; b=RINCTn4WvmU/6LWxtuG5F1tO3Oj8d5nZ6Y4p0+sB+UG3VufhwX2dHK77xXWLEzYeNbuGFUmPDelsBL62xfc5vSEGKVToBpnG7Ww5joEmrgZhxJ3X5fpEVUuCbGmWWjdeg+8LnnAv/Y5wDqH3kH0IXNKDDT09Qklaek15a6o4nLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259186; c=relaxed/simple;
	bh=ajZ90yRc5Tz6OPIYWAsJpZKvzBgybsZEr///3J1Hwyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIYYVTl4AoarXvRx0E/ZBL5bZM4NOYtwi4feY7k8lY7sTdXDCuf3tDr47FOygq7N2ipnjTnc5uCtge0WcM7JS2aQBBq14QaP0REOulxdBXCOmUlnpMUXhwz0d2PGV4QlPp7fzOP2+/FOoK/9DF6DQoT7QelsAdc4Tm2gBqxnhtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XSocWpXC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4a387ff7acso179110466b.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2024 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712259183; x=1712863983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1tiEAhwTkxloRxJIASXYXllw3I4vhuW1cShQ54JYZ2M=;
        b=XSocWpXCX5Et00uzuca8EFe5jEhvZnLhimoNDDLWLrjE68udbDkU/TA9BqCnqvhIyq
         ES/3r7sxF75xzuFLkYHu/5HFxuLCU6XHx2JOI09aGHA3ELE2ga+NsN1ztnQduNwkZbix
         QBbTm79rpGMtE9642+mridV5D7i176TR/rWZU0jpKBPPufTiaW/bVm7U8Sa31zBaQbOL
         DBbiVxkYFwcY+E+IId59iOTKF2gNeWvtmgOY6ieL2GmXaF3xBDbPTZ8LJ89HXtm4zVHX
         GNuIvKKuk+61GpamVIvK5M7B3S69bL6J5AEJ1qbuP6WyYTpVd9qr38ZLNXV+zc/1YOiu
         R9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712259183; x=1712863983;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tiEAhwTkxloRxJIASXYXllw3I4vhuW1cShQ54JYZ2M=;
        b=u6F0FGT9fS6qCjG1XuQD6UdLrhRqvJjO3Z5pqc4JtoTP/5KozL3HbrFe7jNx+QPMCQ
         MqItfzfI5tlFD5rENezJ8S6P8PbN3bzGIhYfC5l9VPVM57svGJHMeE0+y7qGnWNj+VBl
         tRZf2ds5XNS4H1sWaWVrKoeIcE4wrK7D1Awm+jIHPHDeHcKF8VkagrDKpfUwJBIllahw
         q7sgws9EOJKet/W4cmAr1djCTikjkL2KN1LaSy41wgaBY3W2ID9eXxeUgpfZT2UCGdCA
         nayziciOkxI3ruMCuvD67toOZnEsj+rnZr4l3GQx+h7wqKwizubsRYU0+sEt1RjFHpLB
         hqpw==
X-Forwarded-Encrypted: i=1; AJvYcCW57S8cSkfU4AUG5CFpSMucG6bZG/YusUhd3s5sgM7omrbOs6/n30LXR7h0hZ6J0sH31P+6Eqw2NzovijvLSlUqh+93k4NC2+aY
X-Gm-Message-State: AOJu0YzFxos77Q27SvVjnCWPE3xiKkJlE+NQgNOTxSnPufOqgvcAn9G0
	Zv3OfkGufMOP3WkFaPCGQprHZNfyxP/Bqcpnhpl+ih9bw9bztkqLsq1sIXbIv+g=
X-Google-Smtp-Source: AGHT+IHvLAPed3PTazZZBeLD7z3mNzR8LTTOns6qY8p+UpFbuUg07LPVpScN8HcGbkdWhresxJ2NJA==
X-Received: by 2002:a17:906:c14b:b0:a51:a20b:8f23 with SMTP id dp11-20020a170906c14b00b00a51a20b8f23mr24351ejc.18.1712259182925;
        Thu, 04 Apr 2024 12:33:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709060f4800b00a46d049ff63sm9305623ejj.21.2024.04.04.12.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 12:33:02 -0700 (PDT)
Message-ID: <bf7b3b80-764f-4d80-95cd-e547bf767200@linaro.org>
Date: Thu, 4 Apr 2024 21:33:00 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] PCI: Add Qualcomm PCIe ECAM root complex driver
To: Mayank Rana <quic_mrana@quicinc.com>, linux-pci@vger.kernel.org,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 andersson@kernel.org, manivannan.sadhasivam@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
 quic_nkela@quicinc.com, quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
 quic_nitegupt@quicinc.com
References: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
 <1712257884-23841-3-git-send-email-quic_mrana@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1712257884-23841-3-git-send-email-quic_mrana@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 21:11, Mayank Rana wrote:
> On some of Qualcomm platform, firmware configures PCIe controller into
> ECAM mode allowing static memory allocation for configuration space of
> supported bus range. Firmware also takes care of bringing up PCIe PHY
> and performing required operation to bring PCIe link into D0. Firmware
> also manages system resources (e.g. clocks/regulators/resets/ bus voting).
> Hence add Qualcomm PCIe ECAM root complex driver which enumerates PCIe
> root complex and connected PCIe devices. Firmware won't be enumerating
> or powering up PCIe root complex until this driver invokes power domain
> based notification to bring PCIe link into D0/D3cold mode.


...

> +
> +static int qcom_pcie_ecam_suspend_noirq(struct device *dev)
> +{
> +	return pm_runtime_put_sync(dev);
> +}
> +
> +static int qcom_pcie_ecam_resume_noirq(struct device *dev)
> +{
> +	return pm_runtime_get_sync(dev);
> +}
> +
> +static int qcom_pcie_ecam_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct qcom_msi *msi;
> +	int ret;
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "fail to enable pcie controller: %d\n", ret);
> +		return ret;
> +	}
> +
> +	msi = qcom_msi_init(dev);
> +	if (IS_ERR(msi)) {
> +		pm_runtime_put_sync(dev);
> +		return PTR_ERR(msi);
> +	}
> +
> +	ret = pci_host_common_probe(pdev);
> +	if (ret) {
> +		dev_err(dev, "pci_host_common_probe() failed:%d\n", ret);

Don't print function name, but instead say something useful. Above error
message is so not useful that just drop it.

> +		qcom_msi_deinit(msi);
> +		pm_runtime_put_sync(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops qcom_pcie_ecam_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_ecam_suspend_noirq,
> +				qcom_pcie_ecam_resume_noirq)
> +};
> +
> +static const struct pci_ecam_ops qcom_pcie_ecam_ops = {
> +	.pci_ops	= {
> +		.map_bus	= pci_ecam_map_bus,
> +		.read		= pci_generic_config_read,
> +		.write		= pci_generic_config_write,
> +	}
> +};
> +
> +static const struct of_device_id qcom_pcie_ecam_of_match[] = {
> +	{
> +		.compatible	= "qcom,pcie-ecam-rc",
> +		.data		= &qcom_pcie_ecam_ops,

Why do you have ops/match data for generic compatible?

Best regards,
Krzysztof


