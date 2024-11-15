Return-Path: <linux-pci+bounces-16924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9999CF3EC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 19:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FDD1F228A0
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967C91850B5;
	Fri, 15 Nov 2024 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fAIj0i3o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF017E44A;
	Fri, 15 Nov 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695317; cv=none; b=lhSBL5ovngnElQ1SFuWiCbiMbgxSK+K77nvWusUsbBbGvUe914KD7Tko8U7D+V1H5k7BuUPAcWIGzjYisPjIQfUdy9APYVK4MFbJ4nl+kLDhU/+bTLgweQ3/yysTnlsfnLl+bU++upztH/9Y+DBkFC2avkYXR7t+ZHOYBfiX2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695317; c=relaxed/simple;
	bh=DbByaAvx0WGhipw5n/nF2R2p32ooHodChKw7Fn5wosU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ezs6+p7lqB6pMC2/Nkac129usniRreefdcM2a2rne/bKbJt0BanATll7CoZUI2Hp8BQ1Q+Sohe+Xaspt094UaTZo/5exMneJl7cK1AHzNTt3gymhXxoP49PhociGF5dP0BDufJ2NBQTmXZIIgGUCyQL2Mk35nnb1K9QCblnvqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fAIj0i3o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF9DmJM004981;
	Fri, 15 Nov 2024 18:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9zrFo39ldbyieA4xaDasaYQGlrr6AVLzae89+uLqdcg=; b=fAIj0i3oZ2FAMOYb
	Bm1X1ZN7zOZJner8+xtHoaqtYce/Z/bMbEHJAllF8B+eqwyHdFm31OBNXq3J5rHd
	K3VvMknV8CmzRil8TG1ZB9TeVR0SzcedrZwgOGXpwpdZMEENoMLDpjnjMaRDjWLd
	Hbz/j41nFQ+5cp8zvs8Jb8P7hD69nL33vhKQqG/jSYMaOS3I6A2p63qDi4gtmm+1
	NFMlm/qeiETuMdym1UKkCQmxEvI276WvsKKAB6GTy3PGlkDI2SoKP150YmS+8yaT
	kbuyvOi0gCvmATYBzYVswCaTOLYpS3px9IR2UByZ2EHk6oeM2nd/AhCCjjNS2goa
	UuDhjQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42x3g0sffq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 18:28:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFISQuf031291
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 18:28:26 GMT
Received: from [10.110.68.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 15 Nov
 2024 10:28:24 -0800
Message-ID: <f039e0ca-7c80-4495-bc67-ddca62774447@quicinc.com>
Date: Fri, 15 Nov 2024 10:28:23 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] PCI: qcom: Add Qualcomm SA8255p based PCIe root
 complex functionality
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <jingoohan1@gmail.com>, <will@kernel.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzk@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_krichai@quicinc.com>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
 <20241106221341.2218416-5-quic_mrana@quicinc.com>
 <20241115112504.anaatuqitdvjubyx@thinkpad>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20241115112504.anaatuqitdvjubyx@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8ttkHOgydWo10QRJYFSK0zfIIpQIzPyy
X-Proofpoint-GUID: 8ttkHOgydWo10QRJYFSK0zfIIpQIzPyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150155



On 11/15/2024 3:25 AM, Manivannan Sadhasivam wrote:
> On Wed, Nov 06, 2024 at 02:13:41PM -0800, Mayank Rana wrote:
>> On SA8255p ride platform, PCIe root complex is firmware managed as well
>> configured into ECAM compliant mode. This change adds functionality to
>> enable resource management (system resource as well PCIe controller and
>> PHY configuration) through firmware, and enumerating ECAM compliant root
>> complex.
>>
>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig     |   1 +
>>   drivers/pci/controller/dwc/pcie-qcom.c | 116 +++++++++++++++++++++++--
>>   2 files changed, 108 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index b6d6778b0698..0fe76bd39d69 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -275,6 +275,7 @@ config PCIE_QCOM
>>   	select PCIE_DW_HOST
>>   	select CRC8
>>   	select PCIE_QCOM_COMMON
>> +	select PCI_HOST_COMMON
>>   	help
>>   	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
>>   	  PCIe controller uses the DesignWare core plus Qualcomm-specific
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index ef44a82be058..2cb74f902baf 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -21,7 +21,9 @@
>>   #include <linux/limits.h>
>>   #include <linux/init.h>
>>   #include <linux/of.h>
>> +#include <linux/of_pci.h>
>>   #include <linux/pci.h>
>> +#include <linux/pci-ecam.h>
>>   #include <linux/pm_opp.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/platform_device.h>
>> @@ -254,10 +256,12 @@ struct qcom_pcie_ops {
>>     * @ops: qcom PCIe ops structure
>>     * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
>>     * snooping
>> +  * @firmware_managed: Set if PCIe root complex is firmware managed
> 
> ecam_compliant?
I assume you mean to update as Set if ECAM compliant PCIe root complex 
is firmware manage
>>     */
>>   struct qcom_pcie_cfg {
>>   	const struct qcom_pcie_ops *ops;
>>   	bool override_no_snoop;
>> +	bool firmware_managed;
>>   	bool no_l0s;
>>   };
>>   
>> @@ -1415,6 +1419,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>>   	.no_l0s = true,
>>   };
>>   
>> +static const struct qcom_pcie_cfg cfg_fw_managed = {
> 
> cfg_ecam?
Putting more emphasize on fw_managed as don't want to conflict with new 
work in progress (krishna is working on it)
to make Qualcomm PCIe root complex as ECAM compliant (non firmware 
managed one). are you OK with using cfg_ecam_fw_managed ?

>> +	.firmware_managed = true,
>> +};
>> +
>>   static const struct dw_pcie_ops dw_pcie_ops = {
>>   	.link_up = qcom_pcie_link_up,
>>   	.start_link = qcom_pcie_start_link,
>> @@ -1566,6 +1574,51 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> +static void qcom_pci_free_msi(void *ptr)
>> +{
>> +	struct dw_pcie_rp *pp = (struct dw_pcie_rp *)ptr;
>> +
>> +	if (pp && pp->has_msi_ctrl)
>> +		dw_pcie_free_msi(pp);
>> +}
>> +
>> +static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
>> +{
>> +	struct device *dev = cfg->parent;
>> +	struct dw_pcie_rp *pp;
>> +	struct dw_pcie *pci;
>> +	int ret;
>> +
>> +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
>> +	if (!pci)
>> +		return -ENOMEM;
>> +
>> +	pci->dev = dev;
>> +	pp = &pci->pp;
>> +	pci->dbi_base = cfg->win;
>> +	pp->num_vectors = MSI_DEF_NUM_VECTORS;
>> +
>> +	ret = dw_pcie_msi_host_init(pp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pp->has_msi_ctrl = true;
>> +	dw_pcie_msi_init(pp);
>> +
>> +	ret = devm_add_action_or_reset(dev, qcom_pci_free_msi, pp);
> 
> return devm_add_action_or_reset()...
Done.

>> +	return ret;
>> +}
>> +
>> +/* ECAM ops */
>> +const struct pci_ecam_ops pci_qcom_ecam_ops = {
>> +	.init		= qcom_pcie_ecam_host_init,
>> +	.pci_ops	= {
>> +		.map_bus	= pci_ecam_map_bus,
>> +		.read		= pci_generic_config_read,
>> +		.write		= pci_generic_config_write,
>> +	}
>> +};
>> +
>>   static int qcom_pcie_probe(struct platform_device *pdev)
>>   {
>>   	const struct qcom_pcie_cfg *pcie_cfg;
>> @@ -1580,11 +1633,52 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   	char *name;
>>   
>>   	pcie_cfg = of_device_get_match_data(dev);
>> -	if (!pcie_cfg || !pcie_cfg->ops) {
>> -		dev_err(dev, "Invalid platform data\n");
>> +	if (!pcie_cfg) {
>> +		dev_err(dev, "No platform data\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!pcie_cfg->firmware_managed && !pcie_cfg->ops) {
>> +		dev_err(dev, "No platform ops\n");
>>   		return -EINVAL;
>>   	}
>>   
>> +	pm_runtime_enable(dev);
>> +	ret = pm_runtime_get_sync(dev);
>> +	if (ret < 0)
>> +		goto err_pm_runtime_put;
>> +
>> +	if (pcie_cfg->firmware_managed) {
>> +		struct pci_host_bridge *bridge;
>> +		struct pci_config_window *cfg;
>> +
>> +		bridge = devm_pci_alloc_host_bridge(dev, 0);
>> +		if (!bridge) {
>> +			ret = -ENOMEM;
>> +			goto err_pm_runtime_put;
>> +		}
>> +
>> +		of_pci_check_probe_only();
> 
> You haven't defined the "linux,pci-probe-only" property in DT. So if everything
> works fine, then you can leave this call.
ok will review more and update accordingly.

>> +		/* Parse and map our Configuration Space windows */
>> +		cfg = gen_pci_init(dev, bridge, &pci_qcom_ecam_ops);
>> +		if (IS_ERR(cfg)) {
>> +			ret = PTR_ERR(cfg);
>> +			goto err_pm_runtime_put;
>> +		}
>> +
>> +		bridge->sysdata = cfg;
>> +		bridge->ops = (struct pci_ops *)&pci_qcom_ecam_ops.pci_ops;
>> +		bridge->msi_domain = true;
>> +
>> +		ret = pci_host_probe(bridge);
> 
> return pci_host_probe()...
need to perform pm_runtime_put_sync() and pm_runtime_disable() in 
failure case.
Hence checking error here and doing goto err_pm_runtime_put
>> +		if (ret) {
>> +			dev_err(dev, "pci_host_probe() failed:%d\n", ret);
>> +			goto err_pm_runtime_put;
>> +		}
>> +
>> +		return ret;
>> +	}
>> +
>>   	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>>   	if (!pcie)
>>   		return -ENOMEM;
>> @@ -1593,11 +1687,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   	if (!pci)
>>   		return -ENOMEM;
>>   
>> -	pm_runtime_enable(dev);
>> -	ret = pm_runtime_get_sync(dev);
>> -	if (ret < 0)
>> -		goto err_pm_runtime_put;
>> -
>>   	pci->dev = dev;
>>   	pci->ops = &dw_pcie_ops;
>>   	pp = &pci->pp;
>> @@ -1739,9 +1828,13 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   
>>   static int qcom_pcie_suspend_noirq(struct device *dev)
>>   {
>> -	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>> +	struct qcom_pcie *pcie;
>>   	int ret = 0;
>>   
>> +	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8255p"))
>> +		return 0;
> 
> How about bailing out if dev_get_drvdata() returns NULL?
Done

Regards,
Mayank
> - Mani
> 

