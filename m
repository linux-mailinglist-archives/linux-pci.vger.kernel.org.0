Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3507803C8
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 04:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbjHRC0v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 22:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346965AbjHRC0W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 22:26:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6A73A80;
        Thu, 17 Aug 2023 19:26:21 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37I1lomQ028864;
        Fri, 18 Aug 2023 02:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4ZqXEQDnvAq9SQAzKPTdMAUaCsha47dI0KW5KaYMHdU=;
 b=eBt4ULRSbX/QWiBSLly+iLSqD/qeXsw+YrtslAD/ZHkgmp8456tKKisHfrKAe4IXmGRi
 6zg1uuHKgmv8LIp+hlH2kLzx1/i7zkUhwVBC12WYpClVApdxT9EvbP1YAX40PD97aw3v
 7f/jERfGRnFq9fK4pu0w3vfhJ92yHl/Oqktqd/a21Sv/GtALdJyCmaH9JsU0PsXgZhK1
 V9EL4PTBlV6PJtHCWNHbF5RjlCft1iqoS8BiF+PQj+QEmSozCB9D5ZchQSGmvyZWR9t3
 A57VHryX66jyxQ5eYor/LF/iEEgrMbhXtpbj/brPa1GbPaN14T4vfmxdZ9LbVb9Y5274 Cw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sh0upc12s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 02:26:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37I2QDe5021727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 02:26:13 GMT
Received: from [10.216.9.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 17 Aug
 2023 19:26:06 -0700
Message-ID: <8adb4b91-7def-ecf9-63b5-6f57dc92f390@quicinc.com>
Date:   Fri, 18 Aug 2023 07:56:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1] PCI: qcom: Add sysfs entry to change link speed
 dynamically
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_parass@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230817172032.GA321136@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230817172032.GA321136@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1mArVLB1zTadQS6zgvp2wxkKyW9KXBMt
X-Proofpoint-GUID: 1mArVLB1zTadQS6zgvp2wxkKyW9KXBMt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_02,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180022
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/17/2023 10:50 PM, Bjorn Helgaas wrote:
> On Thu, Aug 17, 2023 at 08:04:43AM +0530, Krishna chaitanya chundru wrote:
>> PCIe can operate on lower GEN speed if client decided based upon
>> the bandwidth & latency requirements. To support dynamic GEN speed
>> switch adding this sysfs support.
> Who does "client" refer to?  I assume it's the system administrator,
> but of course the endpoint is involved in the hardware speed
> negotiation, so one could think of the endpoint as a "client" with its
> own speed capabilities and requirements.

The client here refers to either system administrator or endpoint both 
can decide to go

to lower gen speed for reducing power consumption.

>> To change the GEN speed the link should be in L0, so first disable
>> L0s & L1.
>>
>> L0s needs to be disabled at both RC & EP because L0s entry is
>> independent. For enabling L0s both ends of the link needs to support
>> it, so first check if L0s is supported on both ends and then enable
>> L0s.
> Is there a place to document this sysfs knob?  Why should it be
> qcom-specific?  This sounds like generic PCIe functionality.
>
> The ASPM stuff looks like it should be done by aspm.c, not done behind
> its back.
>
> Everything here looks generic (not qcom-specific) except the
> qcom_pcie_icc_update() and qcom_pcie_opp_update().  Maybe we need some
> core infrastructure around this.

I will try to move the logic to the pci generic and add infrastructure 
to call controller specific calls.

- KC

>
>> This patch is dependent on "PCI: qcom: Add support for OPP"
>> https://lore.kernel.org/linux-arm-msm/1692192264-18515-1-git-send-email-quic_krichai@quicinc.com/T/#t
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 141 +++++++++++++++++++++++++++++++++
>>   1 file changed, 141 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 831d158..ad67d17 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -241,10 +241,150 @@ struct qcom_pcie {
>>   	const struct qcom_pcie_cfg *cfg;
>>   	struct dentry *debugfs;
>>   	bool suspended;
>> +	bool l0s_supported;
>>   };
>>   
>>   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>>   
>> +static void qcom_pcie_icc_update(struct qcom_pcie *pcie);
>> +static void qcom_pcie_opp_update(struct qcom_pcie *pcie);
>> +
>> +static int qcom_pcie_disable_l0s(struct pci_dev *pdev, void *userdata)
>> +{
>> +	int lnkctl;
>> +
>> +	pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCTL, &lnkctl);
>> +	lnkctl &= ~(PCI_EXP_LNKCTL_ASPM_L0S);
>> +	pci_write_config_word(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCTL, lnkctl);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_pcie_check_l0s_support(struct pci_dev *pdev, void *userdata)
>> +{
>> +	struct pci_dev *parent = pdev->bus->self;
>> +	struct qcom_pcie *pcie = userdata;
>> +	struct dw_pcie *pci = pcie->pci;
>> +	int lnkcap;
>> +
>> +	 /* check parent supports L0s */
>> +	if (parent) {
>> +		dev_err(pci->dev, "parent\n");
>> +		pci_read_config_dword(parent, pci_pcie_cap(parent) + PCI_EXP_LNKCAP,
>> +				  &lnkcap);
>> +		if (!(lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)) {
>> +			dev_info(pci->dev, "Parent does not support L0s\n");
>> +			pcie->l0s_supported = false;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
>> +			  &lnkcap);
>> +	dev_err(pci->dev, "child %x\n", lnkcap);
>> +	if (!(lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)) {
>> +		dev_info(pci->dev, "Device does not support L0s\n");
>> +		pcie->l0s_supported = false;
>> +		return 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_pcie_enable_l0s(struct pci_dev *pdev, void *userdata)
>> +{
>> +	int lnkctl;
>> +
>> +	pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCTL, &lnkctl);
>> +	lnkctl |= (PCI_EXP_LNKCTL_ASPM_L0S);
>> +	pci_write_config_word(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCTL, lnkctl);
>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t qcom_pcie_speed_change_store(struct device *dev,
>> +			       struct device_attribute *attr,
>> +			       const char *buf,
>> +			       size_t count)
>> +{
>> +	unsigned int current_speed, target_speed, max_speed;
>> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>> +	struct pci_bus *child, *root_bus = NULL;
>> +	struct dw_pcie_rp *pp = &pcie->pci->pp;
>> +	struct dw_pcie *pci = pcie->pci;
>> +	struct pci_dev *pdev;
>> +	u16 offset;
>> +	u32 val;
>> +	int ret;
>> +
>> +	list_for_each_entry(child, &pp->bridge->bus->children, node) {
>> +		if (child->parent == pp->bridge->bus) {
>> +			root_bus = child;
>> +			break;
>> +		}
>> +	}
>> +
>> +	pdev = root_bus->self;
>> +
>> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +
>> +	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
>> +	max_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
>> +
>> +	val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
>> +	current_speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
>> +
>> +	ret = kstrtouint(buf, 10, &target_speed);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (target_speed > max_speed)
>> +		return -EINVAL;
>> +
>> +	if (current_speed == target_speed)
>> +		return count;
>> +
>> +	pci_walk_bus(pp->bridge->bus, qcom_pcie_disable_l0s, pcie);
>> +
>> +	/* Disable L1 */
>> +	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL);
>> +	val &= ~(PCI_EXP_LNKCTL_ASPM_L1);
>> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL, val);
>> +
>> +	/* Set target GEN speed */
>> +	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>> +	val &= ~PCI_EXP_LNKCTL2_TLS;
>> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, val | target_speed);
>> +
>> +	ret = pcie_retrain_link(pdev, true);
>> +	if (ret)
>> +		dev_err(dev, "Link retrain failed %d\n", ret);
>> +
>> +	/* Enable L1 */
>> +	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL);
>> +	val |= (PCI_EXP_LNKCTL_ASPM_L1);
>> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL, val);
>> +
>> +	pcie->l0s_supported = true;
>> +	pci_walk_bus(pp->bridge->bus, qcom_pcie_check_l0s_support, pcie);
>> +
>> +	if (pcie->l0s_supported)
>> +		pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_l0s, pcie);
>> +
>> +	qcom_pcie_icc_update(pcie);
>> +
>> +	qcom_pcie_opp_update(pcie);
>> +
>> +	return count;
>> +}
>> +static DEVICE_ATTR_WO(qcom_pcie_speed_change);
>> +
>> +static struct attribute *qcom_pcie_attrs[] = {
>> +	&dev_attr_qcom_pcie_speed_change.attr,
>> +	NULL,
>> +};
>> +ATTRIBUTE_GROUPS(qcom_pcie);
>> +
>>   static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>>   {
>>   	gpiod_set_value_cansleep(pcie->reset, 1);
>> @@ -1716,6 +1856,7 @@ static struct platform_driver qcom_pcie_driver = {
>>   		.of_match_table = qcom_pcie_match,
>>   		.pm = &qcom_pcie_pm_ops,
>>   		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +		.dev_groups = qcom_pcie_groups,
>>   	},
>>   };
>>   builtin_platform_driver(qcom_pcie_driver);
>> -- 
>> 2.7.4
>>
