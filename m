Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A051170976E
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 14:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjESMoL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 08:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjESMoK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 08:44:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F29ED;
        Fri, 19 May 2023 05:44:09 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JAuCPT012675;
        Fri, 19 May 2023 12:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JinEieFTQH14LquFwxeJXj4Iare8Kdc9Tc6QwV3ep0E=;
 b=Tcuo+6f152hMzArmyYZr0mvm2dzQ29UJ5sGNU6WAdyTtTIYZLnaTbuzqMRxJKply1uA7
 jTcQFYdheNcR3Nat+Pqt6y6FM7C0mycULYRMjb18f+AyzWfMcPwTOxh587lIMT3WIRgo
 KyGlfw7czGT/5LCLhw69Ddd8scm46nSI6d/U3RiapRa1P39eyeINbQ6oUL62wEkPl5wM
 4HpZQ7ytK1Y/pXp7t07PNX7zezuCLvUmdHhuEyVNO3BANi9YsLSXR8pgoLZeW3ZUU9z0
 NxA5WXWsUlU/KPWocISoom8WHTh+VhQ+kO+0Cgq8std8QmtFpViXoOmQHNAO8mEhvjDB QA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp4ccrmd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 12:43:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JChvdm030562
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 12:43:57 GMT
Received: from [10.216.23.115] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 19 May
 2023 05:43:48 -0700
Message-ID: <36fd2413-8a2a-5b7e-c4a0-64e0ac4622ed@quicinc.com>
Date:   Fri, 19 May 2023 18:13:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/8] PCI: qcom: Do not advertise hotplug capability for
 IPs v2.3.3 and v2.9.0
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>
CC:     <robh@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <steev@kali.org>
References: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
 <20230506073139.8789-5-manivannan.sadhasivam@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20230506073139.8789-5-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eGBtQREnCqHrhpbjufzBGFO-PTTkqSuE
X-Proofpoint-ORIG-GUID: eGBtQREnCqHrhpbjufzBGFO-PTTkqSuE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_08,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=959 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190107
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/6/2023 1:01 PM, Manivannan Sadhasivam wrote:
> SoCs making use of Qcom PCIe controller IPs v2.3.3 and v2.9.0 do not
> support hotplug functionality. But the hotplug capability bit is set by
> default in the hardware. This causes the kernel PCI core to register
> hotplug service for the controller and send hotplug commands to it. But
> those commands will timeout generating messages as below during boot
> and suspend/resume.
> 
> [    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
> [    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
> [    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
> [    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)
> 
> This not only spams the console output but also induces a delay of a
> couple of seconds. To fix this issue, let's not set the HPC bit in
> PCI_EXP_SLTCAP register as a part of the post init sequence to not
> advertise the hotplug capability for the controller.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 00246726c21d..3d5b3ce9e2da 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -140,7 +140,6 @@
>   						PCI_EXP_SLTCAP_AIP | \
>   						PCI_EXP_SLTCAP_PIP | \
>   						PCI_EXP_SLTCAP_HPS | \
> -						PCI_EXP_SLTCAP_HPC | \
>   						PCI_EXP_SLTCAP_EIP | \
>   						PCIE_CAP_SLOT_POWER_LIMIT_VAL | \
>   						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)

  Tested this in ipq9574 board and the 'timeout' messages go away with
  this.

   Tested-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Regards,
  Sricharan
