Return-Path: <linux-pci+bounces-16318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89DE9C1A57
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 11:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FCE1B22046
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 10:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BFD1E25E0;
	Fri,  8 Nov 2024 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNd4qUvU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152501BD9D8
	for <linux-pci@vger.kernel.org>; Fri,  8 Nov 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731061379; cv=none; b=dhUs+L/w4I2yv4r2KqBwmuWejo575KE2K4bVibxI7WuQes+gTByBVywIlLI0Y6nnqalCrqxn4nKOGc4M2RK8KFQKEy7Kjny9w0w7f/zEm2R3LJd4qQqGH63rE1PNuv5ocaj3PDI99t1s56YhtjyfEZPEp19shvB2SxLUgafzDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731061379; c=relaxed/simple;
	bh=2XSVJ7MRTDYMhaOEh1VDyoXnJKjt44IvmM+Bblei2CE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XUkpoknmAC7+sgN4CiSOCvHrCuNDpu/4sCjUW8H3t/BMZHiOttPsKLj3F6VvQ+M7mu9gh1VIjjfXV5SerespcSptBY6mG+EkXeRo2HNW1Setx15UUXGFPnIZPXNs635ShAxGoWKmUGw/RsYrOoTMkvyBbGoV7Szc29xm6e0gn58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jNd4qUvU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so1354259f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 08 Nov 2024 02:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731061375; x=1731666175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5/7vgXiVWHft41t+5SnbWXBDVF//wXy8Ork/OVe6xM=;
        b=jNd4qUvUWp9LPx7AgDqEn2YYEkCOq2LKnjPZJT3wihviHPkdxwMlaz3ov0KW7R0px/
         r+93jCYp5XR8RcOtJl/5TWwte3bDZ1Fn01b5NBomqsZUtB8ZIuoTV15GYNOBolWKm5yJ
         F8m55G9eNKkUi71cokU8UdpfhBLq5Yzua2zLrbAl2wLJMdVc6k7aLmdZBNntEfHz8Pjc
         1f/v6vhF+afx+J1NvfDD4X26EaWa8kk7X50ZN/IreH+l8uSWOEKPPMOBPFCSX+9H5ZOn
         uyywsXYu7VySfQL0vj+TI0bTMF1nJMFF7FNbS9OX8BbLKym6vjRdoyBzPKL+4SiDEDyh
         fBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731061375; x=1731666175;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d5/7vgXiVWHft41t+5SnbWXBDVF//wXy8Ork/OVe6xM=;
        b=DP85uSERp/K1krEa1R5uuky5mH8aGSbcuAlHh/yQyERh9V+Qz1jEUw8ha0anNM3u30
         5Isa2CDc0fNk2GK4LXYergkPPc2pMqluoXtzuOY7OnINUa40bDUMUkfShhKEyrWoM+rn
         z+Es64ux7Y0lAQsJnt3ypP5IDG/wnbqbRQLAEBEYsLizUR5xlbJBSZK5MSY716ih1YnS
         vDHcf/XAMvA3nfCmOOJMs9km31AvAyI5sXx2FcvLUFHRcsrxX0DIrNUneAh40mmAxQ9P
         xTrC/4rIm+Lou17C+oRtnrd4Kq8F9XDPv9niZ/s9V19ByatOnZbvIV6HNPqcZtiYNvxk
         vsug==
X-Gm-Message-State: AOJu0YxmJlbwrKKFLDLXqhZ6ds/OUBI7dLLq7Hsis7ibwE41/MGdEy2S
	2vCMUb2Nz4C7F7iT9cfILYrL3nzHnj2fsDsIn8jhu9ivQJAbUKNG4bjv1RVCjMA=
X-Google-Smtp-Source: AGHT+IFobP8XLxwPTAvv6JZbrKXqmGWSnKxS/agpTk5Grqdj3cevU1nFc4cgLboS4JThUKNPgo0nfQ==
X-Received: by 2002:a5d:64e5:0:b0:37d:41cd:ba4e with SMTP id ffacd0b85a97d-381f1852777mr1996931f8f.48.1731061375336;
        Fri, 08 Nov 2024 02:22:55 -0800 (PST)
Received: from [172.16.23.252] ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99681csm4253706f8f.49.2024.11.08.02.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 02:22:54 -0800 (PST)
Message-ID: <dffb4a49-9295-4ce3-af96-802f10c600e1@linaro.org>
Date: Fri, 8 Nov 2024 11:22:52 +0100
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
 <a1f03a33-22b2-4023-8185-d15abc72bc8a@linaro.org>
 <7cfc0657-e8f4-45a8-95e2-668476ffce17@quicinc.com>
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
In-Reply-To: <7cfc0657-e8f4-45a8-95e2-668476ffce17@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/11/2024 18:45, Mayank Rana wrote:
> 
> 
> On 11/7/2024 12:45 AM, neil.armstrong@linaro.org wrote:
>> Hi,
>>
>> On 06/11/2024 23:13, Mayank Rana wrote:
>>> On SA8255p ride platform, PCIe root complex is firmware managed as well
>>> configured into ECAM compliant mode. This change adds functionality to
>>> enable resource management (system resource as well PCIe controller and
>>> PHY configuration) through firmware, and enumerating ECAM compliant root
>>> complex.
>>>
>>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>>> ---
>>>   drivers/pci/controller/dwc/Kconfig     |   1 +
>>>   drivers/pci/controller/dwc/pcie-qcom.c | 116 +++++++++++++++++++++++--
>>>   2 files changed, 108 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>>> index b6d6778b0698..0fe76bd39d69 100644
>>> --- a/drivers/pci/controller/dwc/Kconfig
>>> +++ b/drivers/pci/controller/dwc/Kconfig
>>> @@ -275,6 +275,7 @@ config PCIE_QCOM
>>>       select PCIE_DW_HOST
>>>       select CRC8
>>>       select PCIE_QCOM_COMMON
>>> +    select PCI_HOST_COMMON
>>>       help
>>>         Say Y here to enable PCIe controller support on Qualcomm SoCs. The
>>>         PCIe controller uses the DesignWare core plus Qualcomm-specific
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index ef44a82be058..2cb74f902baf 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -21,7 +21,9 @@
>>>   #include <linux/limits.h>
>>>   #include <linux/init.h>
>>>   #include <linux/of.h>
>>> +#include <linux/of_pci.h>
>>>   #include <linux/pci.h>
>>> +#include <linux/pci-ecam.h>
>>>   #include <linux/pm_opp.h>
>>>   #include <linux/pm_runtime.h>
>>>   #include <linux/platform_device.h>
>>> @@ -254,10 +256,12 @@ struct qcom_pcie_ops {
>>>     * @ops: qcom PCIe ops structure
>>>     * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
>>>     * snooping
>>> +  * @firmware_managed: Set if PCIe root complex is firmware managed
>>>     */
>>>   struct qcom_pcie_cfg {
>>>       const struct qcom_pcie_ops *ops;
>>>       bool override_no_snoop;
>>> +    bool firmware_managed;
>>>       bool no_l0s;
>>>   };
>>> @@ -1415,6 +1419,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>>>       .no_l0s = true,
>>>   };
>>> +static const struct qcom_pcie_cfg cfg_fw_managed = {
>>> +    .firmware_managed = true,
>>> +};
>>> +
>>>   static const struct dw_pcie_ops dw_pcie_ops = {
>>>       .link_up = qcom_pcie_link_up,
>>>       .start_link = qcom_pcie_start_link,
>>> @@ -1566,6 +1574,51 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>>>       return IRQ_HANDLED;
>>>   }
>>> +static void qcom_pci_free_msi(void *ptr)
>>> +{
>>> +    struct dw_pcie_rp *pp = (struct dw_pcie_rp *)ptr;
>>> +
>>> +    if (pp && pp->has_msi_ctrl)
>>> +        dw_pcie_free_msi(pp);
>>> +}
>>> +
>>> +static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
>>> +{
>>> +    struct device *dev = cfg->parent;
>>> +    struct dw_pcie_rp *pp;
>>> +    struct dw_pcie *pci;
>>> +    int ret;
>>> +
>>> +    pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
>>> +    if (!pci)
>>> +        return -ENOMEM;
>>> +
>>> +    pci->dev = dev;
>>> +    pp = &pci->pp;
>>> +    pci->dbi_base = cfg->win;
>>> +    pp->num_vectors = MSI_DEF_NUM_VECTORS;
>>> +
>>> +    ret = dw_pcie_msi_host_init(pp);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    pp->has_msi_ctrl = true;
>>> +    dw_pcie_msi_init(pp);
>>> +
>>> +    ret = devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
>>> +    return ret;
>>> +}
>>> +
>>> +/* ECAM ops */
>>> +const struct pci_ecam_ops pci_qcom_ecam_ops = {
>>> +    .init        = qcom_pcie_ecam_host_init,
>>> +    .pci_ops    = {
>>> +        .map_bus    = pci_ecam_map_bus,
>>> +        .read        = pci_generic_config_read,
>>> +        .write        = pci_generic_config_write,
>>> +    }
>>> +};
>>> +
>>>   static int qcom_pcie_probe(struct platform_device *pdev)
>>>   {
>>>       const struct qcom_pcie_cfg *pcie_cfg;
>>> @@ -1580,11 +1633,52 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>>       char *name;
>>>       pcie_cfg = of_device_get_match_data(dev);
>>> -    if (!pcie_cfg || !pcie_cfg->ops) {
>>> -        dev_err(dev, "Invalid platform data\n");
>>> +    if (!pcie_cfg) {
>>> +        dev_err(dev, "No platform data\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (!pcie_cfg->firmware_managed && !pcie_cfg->ops) {
>>> +        dev_err(dev, "No platform ops\n");
>>>           return -EINVAL;
>>>       }
>>> +    pm_runtime_enable(dev);
>>> +    ret = pm_runtime_get_sync(dev);
>>> +    if (ret < 0)
>>> +        goto err_pm_runtime_put;
>>> +
>>> +    if (pcie_cfg->firmware_managed) {
>>> +        struct pci_host_bridge *bridge;
>>> +        struct pci_config_window *cfg;
>>> +
>>> +        bridge = devm_pci_alloc_host_bridge(dev, 0);
>>> +        if (!bridge) {
>>> +            ret = -ENOMEM;
>>> +            goto err_pm_runtime_put;
>>> +        }
>>> +
>>> +        of_pci_check_probe_only();
>>> +        /* Parse and map our Configuration Space windows */
>>> +        cfg = gen_pci_init(dev, bridge, &pci_qcom_ecam_ops);
>>> +        if (IS_ERR(cfg)) {
>>> +            ret = PTR_ERR(cfg);
>>> +            goto err_pm_runtime_put;
>>> +        }
>>> +
>>> +        bridge->sysdata = cfg;
>>> +        bridge->ops = (struct pci_ops *)&pci_qcom_ecam_ops.pci_ops;
>>> +        bridge->msi_domain = true;
>>> +
>>> +        ret = pci_host_probe(bridge);
>>> +        if (ret) {
>>> +            dev_err(dev, "pci_host_probe() failed:%d\n", ret);
>>> +            goto err_pm_runtime_put;
>>> +        }
>>> +
>>> +        return ret;
>>> +    }
>>> +
>>>       pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>>>       if (!pcie)
>>>           return -ENOMEM;
>>> @@ -1593,11 +1687,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>>       if (!pci)
>>>           return -ENOMEM;
>>> -    pm_runtime_enable(dev);
>>> -    ret = pm_runtime_get_sync(dev);
>>> -    if (ret < 0)
>>> -        goto err_pm_runtime_put;
>>> -
>>>       pci->dev = dev;
>>>       pci->ops = &dw_pcie_ops;
>>>       pp = &pci->pp;
>>> @@ -1739,9 +1828,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>>   static int qcom_pcie_suspend_noirq(struct device *dev)
>>>   {
>>> -    struct qcom_pcie *pcie = dev_get_drvdata(dev);
>>> +    struct qcom_pcie *pcie;
>>>       int ret = 0;
>>> +    if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8255p"))
>>
>> Can't you use if (pcie_cfg->firmware_managed) here instead ?
> yes, although with firmware managed mode, struct qcom_pcie *pcie is not allocated, and just
> to get access to pcie_cfg for this check, I took this approach. I am thiking to do allocating struct qcom_pcie *pcie and using it in future if we need more other related functionality which needs usage of this structure for functionality like global interrupt etc.
> 
> Although if you still prefer to allocate struct qcom_pcie based memory to access pcie_cfg, then I can consider to update in next patchset. Please suggest.

I understand, but running of_device_is_compatible() in runtime PM is not something we should do,
so either allocate pcie_cfg, or add a firmware_managed bool to qcom_pcie copied from pcie_cfg,
or move runtime pm callbacks in qcom_pcie_ops and don't declare any in cfg_fw_managed->ops.

I think the latter would be more scalable so we could add runtime pm variant handling
for each IP versions. But it may be quite quite useless for now.

I'll leave Mani comment on that.

Neil


>>> +        return 0;
>>> +
>>> +    pcie = dev_get_drvdata(dev);
>>>       /*
>>>        * Set minimum bandwidth required to keep data path functional during
>>>        * suspend.
>>> @@ -1795,9 +1888,13 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>>   static int qcom_pcie_resume_noirq(struct device *dev)
>>>   {
>>> -    struct qcom_pcie *pcie = dev_get_drvdata(dev);
>>> +    struct qcom_pcie *pcie;
>>>       int ret;
>>> +    if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8255p"))
>>
>> Ditto
>>
>>> +        return  0;
>>> +
>>> +    pcie = dev_get_drvdata(dev);
>>>       if (pm_suspend_target_state != PM_SUSPEND_MEM) {
>>>           ret = icc_enable(pcie->icc_cpu);
>>>           if (ret) {
>>> @@ -1830,6 +1927,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>>>       { .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
>>>       { .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>>>       { .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>>> +    { .compatible = "qcom,pcie-sa8255p", .data = &cfg_fw_managed },
>>>       { .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
>>>       { .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_34_0},
>>>       { .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
>>
>> Thanks,
>> Neil
> 
> Regards,
> Mayank


