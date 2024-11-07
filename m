Return-Path: <linux-pci+bounces-16277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91019C0D27
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 18:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1862E1C2281E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 17:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B38212D27;
	Thu,  7 Nov 2024 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PRR4YdW8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AEA1922F5;
	Thu,  7 Nov 2024 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001564; cv=none; b=aJAGuz/IJesJu5MRHwluIT4bI1wr+sUPlKiIdUjmlgJcWMYnx+NoECHeJjzvFc3blytz0X/wT9CUMkB8JqYCfZCsnX+NmxllRZJrcRN0k5KHRaW2BoOl/ctPABJttKXgqhuYplw94nS7PQN5ttQFDoQGDediOy7P8SQEC6fsuqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001564; c=relaxed/simple;
	bh=990WymFtFuY3Lz0BaB8FYNRJv0S92EJSQT8b7B/4NpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uZVbpZ23wSxnCDe4jGqGs+woef7PO81sicdFhY98vKz1sbMjanwcj8+LrAATCb9JNpnsuPHglC5Ydg6e70TGidq6Gzc46yyUPFwRz0Y3zN9xTS50QLVS8VTfpYwnscEWLRpm/syYbrZjBLglo5JRFSX6nWMd+vy+9UIjP4ytx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PRR4YdW8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HLaRt022083;
	Thu, 7 Nov 2024 17:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Weey5qQzj6+LWDZBt5gOARQNS8yki2lQrekpBvAmHfk=; b=PRR4YdW8eFIEGijD
	yV8V+a2qEAsif02A+qsNNIZorogbDHlEjaYvoJjnq4czns1nOM9F6TgbxUkNoth+
	rgiwDhc+yRU8ETaqWKLaKgVa8lJWmoYmVt/ZrNb/sJ2KuP8IajLVuYaJNhbhlIwD
	5TDkVnzq3MgUcGzVm9HHWUmO7RasjjdG7hvkIUBjWXi+HXXg4lK1vXu5JOPlExWf
	dNaDEOFd8Jjyd7k7eUkWBszeCByZx+F8Xwy89iiP+BuxI7a6uvfcQDYPwIECGRMg
	rZBdTc1miT9P3ouezz/QXh8Ha7CkpXFzz0gVnQnWteA+BJ64ZM2oVNZNpbmHWpTY
	mnHpUw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42r3c1d8e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 17:45:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A7HjcOq022056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 17:45:38 GMT
Received: from [10.110.112.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 7 Nov 2024
 09:45:37 -0800
Message-ID: <7cfc0657-e8f4-45a8-95e2-668476ffce17@quicinc.com>
Date: Thu, 7 Nov 2024 09:45:37 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] PCI: qcom: Add Qualcomm SA8255p based PCIe root
 complex functionality
To: <neil.armstrong@linaro.org>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <will@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_krichai@quicinc.com>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
 <20241106221341.2218416-5-quic_mrana@quicinc.com>
 <a1f03a33-22b2-4023-8185-d15abc72bc8a@linaro.org>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <a1f03a33-22b2-4023-8185-d15abc72bc8a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YMQHitao4muXWLKMZOY8CsBJaoxnk0Xy
X-Proofpoint-ORIG-GUID: YMQHitao4muXWLKMZOY8CsBJaoxnk0Xy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 clxscore=1011
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070138



On 11/7/2024 12:45 AM, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 06/11/2024 23:13, Mayank Rana wrote:
>> On SA8255p ride platform, PCIe root complex is firmware managed as well
>> configured into ECAM compliant mode. This change adds functionality to
>> enable resource management (system resource as well PCIe controller and
>> PHY configuration) through firmware, and enumerating ECAM compliant root
>> complex.
>>
>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig     |   1 +
>>   drivers/pci/controller/dwc/pcie-qcom.c | 116 +++++++++++++++++++++++--
>>   2 files changed, 108 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig 
>> b/drivers/pci/controller/dwc/Kconfig
>> index b6d6778b0698..0fe76bd39d69 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -275,6 +275,7 @@ config PCIE_QCOM
>>       select PCIE_DW_HOST
>>       select CRC8
>>       select PCIE_QCOM_COMMON
>> +    select PCI_HOST_COMMON
>>       help
>>         Say Y here to enable PCIe controller support on Qualcomm SoCs. 
>> The
>>         PCIe controller uses the DesignWare core plus Qualcomm-specific
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c 
>> b/drivers/pci/controller/dwc/pcie-qcom.c
>> index ef44a82be058..2cb74f902baf 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -21,7 +21,9 @@
>>   #include <linux/limits.h>
>>   #include <linux/init.h>
>>   #include <linux/of.h>
>> +#include <linux/of_pci.h>
>>   #include <linux/pci.h>
>> +#include <linux/pci-ecam.h>
>>   #include <linux/pm_opp.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/platform_device.h>
>> @@ -254,10 +256,12 @@ struct qcom_pcie_ops {
>>     * @ops: qcom PCIe ops structure
>>     * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable 
>> cache
>>     * snooping
>> +  * @firmware_managed: Set if PCIe root complex is firmware managed
>>     */
>>   struct qcom_pcie_cfg {
>>       const struct qcom_pcie_ops *ops;
>>       bool override_no_snoop;
>> +    bool firmware_managed;
>>       bool no_l0s;
>>   };
>> @@ -1415,6 +1419,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>>       .no_l0s = true,
>>   };
>> +static const struct qcom_pcie_cfg cfg_fw_managed = {
>> +    .firmware_managed = true,
>> +};
>> +
>>   static const struct dw_pcie_ops dw_pcie_ops = {
>>       .link_up = qcom_pcie_link_up,
>>       .start_link = qcom_pcie_start_link,
>> @@ -1566,6 +1574,51 @@ static irqreturn_t 
>> qcom_pcie_global_irq_thread(int irq, void *data)
>>       return IRQ_HANDLED;
>>   }
>> +static void qcom_pci_free_msi(void *ptr)
>> +{
>> +    struct dw_pcie_rp *pp = (struct dw_pcie_rp *)ptr;
>> +
>> +    if (pp && pp->has_msi_ctrl)
>> +        dw_pcie_free_msi(pp);
>> +}
>> +
>> +static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
>> +{
>> +    struct device *dev = cfg->parent;
>> +    struct dw_pcie_rp *pp;
>> +    struct dw_pcie *pci;
>> +    int ret;
>> +
>> +    pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
>> +    if (!pci)
>> +        return -ENOMEM;
>> +
>> +    pci->dev = dev;
>> +    pp = &pci->pp;
>> +    pci->dbi_base = cfg->win;
>> +    pp->num_vectors = MSI_DEF_NUM_VECTORS;
>> +
>> +    ret = dw_pcie_msi_host_init(pp);
>> +    if (ret)
>> +        return ret;
>> +
>> +    pp->has_msi_ctrl = true;
>> +    dw_pcie_msi_init(pp);
>> +
>> +    ret = devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
>> +    return ret;
>> +}
>> +
>> +/* ECAM ops */
>> +const struct pci_ecam_ops pci_qcom_ecam_ops = {
>> +    .init        = qcom_pcie_ecam_host_init,
>> +    .pci_ops    = {
>> +        .map_bus    = pci_ecam_map_bus,
>> +        .read        = pci_generic_config_read,
>> +        .write        = pci_generic_config_write,
>> +    }
>> +};
>> +
>>   static int qcom_pcie_probe(struct platform_device *pdev)
>>   {
>>       const struct qcom_pcie_cfg *pcie_cfg;
>> @@ -1580,11 +1633,52 @@ static int qcom_pcie_probe(struct 
>> platform_device *pdev)
>>       char *name;
>>       pcie_cfg = of_device_get_match_data(dev);
>> -    if (!pcie_cfg || !pcie_cfg->ops) {
>> -        dev_err(dev, "Invalid platform data\n");
>> +    if (!pcie_cfg) {
>> +        dev_err(dev, "No platform data\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!pcie_cfg->firmware_managed && !pcie_cfg->ops) {
>> +        dev_err(dev, "No platform ops\n");
>>           return -EINVAL;
>>       }
>> +    pm_runtime_enable(dev);
>> +    ret = pm_runtime_get_sync(dev);
>> +    if (ret < 0)
>> +        goto err_pm_runtime_put;
>> +
>> +    if (pcie_cfg->firmware_managed) {
>> +        struct pci_host_bridge *bridge;
>> +        struct pci_config_window *cfg;
>> +
>> +        bridge = devm_pci_alloc_host_bridge(dev, 0);
>> +        if (!bridge) {
>> +            ret = -ENOMEM;
>> +            goto err_pm_runtime_put;
>> +        }
>> +
>> +        of_pci_check_probe_only();
>> +        /* Parse and map our Configuration Space windows */
>> +        cfg = gen_pci_init(dev, bridge, &pci_qcom_ecam_ops);
>> +        if (IS_ERR(cfg)) {
>> +            ret = PTR_ERR(cfg);
>> +            goto err_pm_runtime_put;
>> +        }
>> +
>> +        bridge->sysdata = cfg;
>> +        bridge->ops = (struct pci_ops *)&pci_qcom_ecam_ops.pci_ops;
>> +        bridge->msi_domain = true;
>> +
>> +        ret = pci_host_probe(bridge);
>> +        if (ret) {
>> +            dev_err(dev, "pci_host_probe() failed:%d\n", ret);
>> +            goto err_pm_runtime_put;
>> +        }
>> +
>> +        return ret;
>> +    }
>> +
>>       pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>>       if (!pcie)
>>           return -ENOMEM;
>> @@ -1593,11 +1687,6 @@ static int qcom_pcie_probe(struct 
>> platform_device *pdev)
>>       if (!pci)
>>           return -ENOMEM;
>> -    pm_runtime_enable(dev);
>> -    ret = pm_runtime_get_sync(dev);
>> -    if (ret < 0)
>> -        goto err_pm_runtime_put;
>> -
>>       pci->dev = dev;
>>       pci->ops = &dw_pcie_ops;
>>       pp = &pci->pp;
>> @@ -1739,9 +1828,13 @@ static int qcom_pcie_probe(struct 
>> platform_device *pdev)
>>   static int qcom_pcie_suspend_noirq(struct device *dev)
>>   {
>> -    struct qcom_pcie *pcie = dev_get_drvdata(dev);
>> +    struct qcom_pcie *pcie;
>>       int ret = 0;
>> +    if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8255p"))
> 
> Can't you use if (pcie_cfg->firmware_managed) here instead ?
yes, although with firmware managed mode, struct qcom_pcie *pcie is not 
allocated, and just
to get access to pcie_cfg for this check, I took this approach. I am 
thiking to do allocating struct qcom_pcie *pcie and using it in future 
if we need more other related functionality which needs usage of this 
structure for functionality like global interrupt etc.

Although if you still prefer to allocate struct qcom_pcie based memory 
to access pcie_cfg, then I can consider to update in next patchset. 
Please suggest.
>> +        return 0;
>> +
>> +    pcie = dev_get_drvdata(dev);
>>       /*
>>        * Set minimum bandwidth required to keep data path functional 
>> during
>>        * suspend.
>> @@ -1795,9 +1888,13 @@ static int qcom_pcie_suspend_noirq(struct 
>> device *dev)
>>   static int qcom_pcie_resume_noirq(struct device *dev)
>>   {
>> -    struct qcom_pcie *pcie = dev_get_drvdata(dev);
>> +    struct qcom_pcie *pcie;
>>       int ret;
>> +    if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8255p"))
> 
> Ditto
> 
>> +        return 0;
>> +
>> +    pcie = dev_get_drvdata(dev);
>>       if (pm_suspend_target_state != PM_SUSPEND_MEM) {
>>           ret = icc_enable(pcie->icc_cpu);
>>           if (ret) {
>> @@ -1830,6 +1927,7 @@ static const struct of_device_id 
>> qcom_pcie_match[] = {
>>       { .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
>>       { .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>>       { .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>> +    { .compatible = "qcom,pcie-sa8255p", .data = &cfg_fw_managed },
>>       { .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
>>       { .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_34_0},
>>       { .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
> 
> Thanks,
> Neil

Regards,
Mayank

