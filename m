Return-Path: <linux-pci+bounces-16209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99E09C0055
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 09:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892CE283331
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 08:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ABD1DF985;
	Thu,  7 Nov 2024 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sK8os7CO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605641DED57
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969112; cv=none; b=kMZvoKfZkqyjKFM/qtP83MYcMT0xQJQ1Ini6AGrNF5C4ffF1yK99azaRakUtHR9MThAHW3RrO20u9DEc5FMy3f743zfm6O30r1KyY7QHVuxXPun+3WL1/OuZuuYuHB4IuOJUwxhstqTS/Qt1Q/8u1dDACzJcjs3gV1GWCXO589E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969112; c=relaxed/simple;
	bh=YmdxF7vbu8dJM4MGBbkY7vzPYBSxi5Z267Sqc1A988I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hB2bn/lxBvxF/VUhYPIvGSk5IQ3ym8v3/t/ctgb16kjTa5+rG627Q6HbiPrTdAbgvoyCWVsxCQblEPkkPOkNRRZiJb4AAR4H2n7GgTRZZjGwAXrpURvfPpT9IJY3xjKLu3SjkpmSKz/Zb1tc5pgs2VClocilyLlzfbz5s1pADPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sK8os7CO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so8129105e9.2
        for <linux-pci@vger.kernel.org>; Thu, 07 Nov 2024 00:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730969108; x=1731573908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ptk/prbXj2qZpsXfE6umlu//+z1stLb6ou6X7W8u0q8=;
        b=sK8os7COJauabbfX/hui0HPiHWLzXQd0aFalbUph2+0ik6FBVQlPVEtB9xonOoaHuQ
         wBHM1PvM8zsvKlmQjYI+QL1g6n44vl36sV8G3dqKGpSdbbbDh3ammH8FSoCLvZyqb4BT
         uruiZqPbrTOoh3sw08zT/0K5GYLMP/p4AstJMSeqDF930JLcwBaMQuZLC3pxNb7EcaTN
         eU7tBwjcVfqWX2oufpsrenPLUUA1VyJapu15QUUnKEe9xqsVUNxHVCTUKbKIhdwUITOX
         oFMJbv6ypdojN8+U9JzLbgfnuqb6leysvnUqGKNsl5is1EgBhGf9leQ+z8x4blNP5VWD
         gdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730969108; x=1731573908;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ptk/prbXj2qZpsXfE6umlu//+z1stLb6ou6X7W8u0q8=;
        b=W045p28K6rQya1NPVIFWPEUXwdho7cN4TAL4P7zLn6046weuXewh7FR9GqBgMYRLtE
         PsjS/vIHuCdkJejb/P8Z8tInXUEFLAvJPVfNXypZ125rM/8q7FncdU/h1cUUFH71fX8h
         mBL6rFHsL/ZnnGm90jHbIMtyIrioC7H//u0C/ggaxL+gBM1qbN53T/SwSQyBiQ/XdbA1
         7j65xgz8exgqWKfhSKJNHv6dJtC4YWtS31buDfo1bV4r3X/Y09MMIDwIUX9Ll9ZUNdGQ
         q9CGcE1sP/GQX/xjD7X/CTG7HQRLvP4UqOaEVJgvXWAzxzkAjkFLWi3r62ZJ+rCBMA01
         KUPg==
X-Gm-Message-State: AOJu0Yz0H+z+CGVtP9ruPKRcV4hcG4Lrz85fXufrIaYd6rAsFYsg76hd
	zDq5AeeMo+iKA/MbeVWN2B/9iBNs452II9d5sOSEebQyDISWFz12TAzyNyEDTQQ=
X-Google-Smtp-Source: AGHT+IF0iK8ZjS53YGkJV1UqpdJmYPay52KWYJpFa25L7QQvig5tLM86CqKdyPC9HssVdqkQsGoQwg==
X-Received: by 2002:a05:600c:3148:b0:431:557e:b40c with SMTP id 5b1f17b1804b1-4328327ce1fmr236778325e9.27.1730969107679;
        Thu, 07 Nov 2024 00:45:07 -0800 (PST)
Received: from [172.16.23.252] ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b3fesm15331845e9.17.2024.11.07.00.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 00:45:07 -0800 (PST)
Message-ID: <a1f03a33-22b2-4023-8185-d15abc72bc8a@linaro.org>
Date: Thu, 7 Nov 2024 09:45:06 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 4/4] PCI: qcom: Add Qualcomm SA8255p based PCIe root
 complex functionality
To: Mayank Rana <quic_mrana@quicinc.com>, jingoohan1@gmail.com,
 manivannan.sadhasivam@linaro.org, will@kernel.org, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com, krzk@kernel.org
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_krichai@quicinc.com
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
 <20241106221341.2218416-5-quic_mrana@quicinc.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20241106221341.2218416-5-quic_mrana@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 06/11/2024 23:13, Mayank Rana wrote:
> On SA8255p ride platform, PCIe root complex is firmware managed as well
> configured into ECAM compliant mode. This change adds functionality to
> enable resource management (system resource as well PCIe controller and
> PHY configuration) through firmware, and enumerating ECAM compliant root
> complex.
> 
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>   drivers/pci/controller/dwc/Kconfig     |   1 +
>   drivers/pci/controller/dwc/pcie-qcom.c | 116 +++++++++++++++++++++++--
>   2 files changed, 108 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b6d6778b0698..0fe76bd39d69 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -275,6 +275,7 @@ config PCIE_QCOM
>   	select PCIE_DW_HOST
>   	select CRC8
>   	select PCIE_QCOM_COMMON
> +	select PCI_HOST_COMMON
>   	help
>   	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
>   	  PCIe controller uses the DesignWare core plus Qualcomm-specific
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ef44a82be058..2cb74f902baf 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -21,7 +21,9 @@
>   #include <linux/limits.h>
>   #include <linux/init.h>
>   #include <linux/of.h>
> +#include <linux/of_pci.h>
>   #include <linux/pci.h>
> +#include <linux/pci-ecam.h>
>   #include <linux/pm_opp.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/platform_device.h>
> @@ -254,10 +256,12 @@ struct qcom_pcie_ops {
>     * @ops: qcom PCIe ops structure
>     * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
>     * snooping
> +  * @firmware_managed: Set if PCIe root complex is firmware managed
>     */
>   struct qcom_pcie_cfg {
>   	const struct qcom_pcie_ops *ops;
>   	bool override_no_snoop;
> +	bool firmware_managed;
>   	bool no_l0s;
>   };
>   
> @@ -1415,6 +1419,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>   	.no_l0s = true,
>   };
>   
> +static const struct qcom_pcie_cfg cfg_fw_managed = {
> +	.firmware_managed = true,
> +};
> +
>   static const struct dw_pcie_ops dw_pcie_ops = {
>   	.link_up = qcom_pcie_link_up,
>   	.start_link = qcom_pcie_start_link,
> @@ -1566,6 +1574,51 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>   	return IRQ_HANDLED;
>   }
>   
> +static void qcom_pci_free_msi(void *ptr)
> +{
> +	struct dw_pcie_rp *pp = (struct dw_pcie_rp *)ptr;
> +
> +	if (pp && pp->has_msi_ctrl)
> +		dw_pcie_free_msi(pp);
> +}
> +
> +static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct dw_pcie_rp *pp;
> +	struct dw_pcie *pci;
> +	int ret;
> +
> +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> +	if (!pci)
> +		return -ENOMEM;
> +
> +	pci->dev = dev;
> +	pp = &pci->pp;
> +	pci->dbi_base = cfg->win;
> +	pp->num_vectors = MSI_DEF_NUM_VECTORS;
> +
> +	ret = dw_pcie_msi_host_init(pp);
> +	if (ret)
> +		return ret;
> +
> +	pp->has_msi_ctrl = true;
> +	dw_pcie_msi_init(pp);
> +
> +	ret = devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
> +	return ret;
> +}
> +
> +/* ECAM ops */
> +const struct pci_ecam_ops pci_qcom_ecam_ops = {
> +	.init		= qcom_pcie_ecam_host_init,
> +	.pci_ops	= {
> +		.map_bus	= pci_ecam_map_bus,
> +		.read		= pci_generic_config_read,
> +		.write		= pci_generic_config_write,
> +	}
> +};
> +
>   static int qcom_pcie_probe(struct platform_device *pdev)
>   {
>   	const struct qcom_pcie_cfg *pcie_cfg;
> @@ -1580,11 +1633,52 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   	char *name;
>   
>   	pcie_cfg = of_device_get_match_data(dev);
> -	if (!pcie_cfg || !pcie_cfg->ops) {
> -		dev_err(dev, "Invalid platform data\n");
> +	if (!pcie_cfg) {
> +		dev_err(dev, "No platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!pcie_cfg->firmware_managed && !pcie_cfg->ops) {
> +		dev_err(dev, "No platform ops\n");
>   		return -EINVAL;
>   	}
>   
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0)
> +		goto err_pm_runtime_put;
> +
> +	if (pcie_cfg->firmware_managed) {
> +		struct pci_host_bridge *bridge;
> +		struct pci_config_window *cfg;
> +
> +		bridge = devm_pci_alloc_host_bridge(dev, 0);
> +		if (!bridge) {
> +			ret = -ENOMEM;
> +			goto err_pm_runtime_put;
> +		}
> +
> +		of_pci_check_probe_only();
> +		/* Parse and map our Configuration Space windows */
> +		cfg = gen_pci_init(dev, bridge, &pci_qcom_ecam_ops);
> +		if (IS_ERR(cfg)) {
> +			ret = PTR_ERR(cfg);
> +			goto err_pm_runtime_put;
> +		}
> +
> +		bridge->sysdata = cfg;
> +		bridge->ops = (struct pci_ops *)&pci_qcom_ecam_ops.pci_ops;
> +		bridge->msi_domain = true;
> +
> +		ret = pci_host_probe(bridge);
> +		if (ret) {
> +			dev_err(dev, "pci_host_probe() failed:%d\n", ret);
> +			goto err_pm_runtime_put;
> +		}
> +
> +		return ret;
> +	}
> +
>   	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>   	if (!pcie)
>   		return -ENOMEM;
> @@ -1593,11 +1687,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   	if (!pci)
>   		return -ENOMEM;
>   
> -	pm_runtime_enable(dev);
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0)
> -		goto err_pm_runtime_put;
> -
>   	pci->dev = dev;
>   	pci->ops = &dw_pcie_ops;
>   	pp = &pci->pp;
> @@ -1739,9 +1828,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   
>   static int qcom_pcie_suspend_noirq(struct device *dev)
>   {
> -	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +	struct qcom_pcie *pcie;
>   	int ret = 0;
>   
> +	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8255p"))

Can't you use if (pcie_cfg->firmware_managed) here instead ?

> +		return 0;
> +
> +	pcie = dev_get_drvdata(dev);
>   	/*
>   	 * Set minimum bandwidth required to keep data path functional during
>   	 * suspend.
> @@ -1795,9 +1888,13 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>   
>   static int qcom_pcie_resume_noirq(struct device *dev)
>   {
> -	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +	struct qcom_pcie *pcie;
>   	int ret;
>   
> +	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8255p"))

Ditto

> +		return 0;
> +
> +	pcie = dev_get_drvdata(dev);
>   	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
>   		ret = icc_enable(pcie->icc_cpu);
>   		if (ret) {
> @@ -1830,6 +1927,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>   	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
>   	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>   	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
> +	{ .compatible = "qcom,pcie-sa8255p", .data = &cfg_fw_managed },
>   	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
>   	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_34_0},
>   	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },

Thanks,
Neil

