Return-Path: <linux-pci+bounces-1042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4120B814173
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 06:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651721C2236C
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 05:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6782C63D0;
	Fri, 15 Dec 2023 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="doaWFc66"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10C6AA6;
	Fri, 15 Dec 2023 05:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF4rG17012803;
	Fri, 15 Dec 2023 05:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OIvgiwV5IcUa6vyzIxMJliZLEIyS2TSOj3fE8+EY3XE=; b=do
	aWFc66C+Cka3jzquchaIjPGX5S6kGgRGigusUZ+FTk7ZqnDey2I4/aU0oPn+rsws
	iGndWwCRfgHcovc+lUPyJD6Z+yGWCUOAEGQE4ALkeOlu5Rc6tAsTnqBfDYFT0N5a
	yEKv0zmU3HzxbHfdn71YbLlH6nBSmDJLQBU1Nsnak3nerfoylqy17Smq0pM3HrcV
	oV/ruW9zqCaZ2bbYnj2EBsJUjzdAo41vkfMuWz/d70xMSCPFp9A9pjiDZ1hXiGNR
	RF+HQVcOd3ey2QY8uYvf2LozDXU31XMedVL/EC8+h6iHFq3h3D0/jLGFbnl6320N
	Hgfw/apPJGrbFvipNirg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0a37h0nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 05:45:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF5jNRg013681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 05:45:23 GMT
Received: from [10.201.3.91] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Dec
 2023 21:45:16 -0800
Message-ID: <aeaf0b2a-7fdf-4e23-97bc-7bfc3fd05f41@quicinc.com>
Date: Fri, 15 Dec 2023 11:15:16 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] phy: qcom: ipq5332: Add support for g3x1 and g3x2
 PCIe PHYs
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mani@kernel.org>,
        <quic_nsekar@quicinc.com>, <quic_srichara@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
 <20231214062847.2215542-7-quic_ipkumar@quicinc.com>
 <CAA8EJppSXeV9LSv8VAwYSP9nDzq+uHTvbiEzD4PebEHoOJySNg@mail.gmail.com>
From: Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <CAA8EJppSXeV9LSv8VAwYSP9nDzq+uHTvbiEzD4PebEHoOJySNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vkojKA8BInIcdHfbqwabzdky8Fhz3Wux
X-Proofpoint-ORIG-GUID: vkojKA8BInIcdHfbqwabzdky8Fhz3Wux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312150033



On 12/14/2023 12:42 PM, Dmitry Baryshkov wrote:
> On Thu, 14 Dec 2023 at 08:30, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>> Add support for single-lane and dual-lane PCIe UNIPHY found on
>> Qualcomm IPQ5332 platform. This UNIPHY is similar to the one
>> present in Qualcomm IPQ5018.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>> This patch depends on the below series which adds PCIe support in
>> Qualcomm IPQ5018
>> https://lore.kernel.org/all/20231003120846.28626-1-quic_nsekar@quicinc.com/
>>
>>   .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 44 +++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
>> index 9f9a03faf6fa..aa71b85eb50e 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
>> @@ -34,6 +34,10 @@
>>   #define SSCG_CTRL_REG_6                0xb0
>>   #define PCS_INTERNAL_CONTROL_2 0x2d8
>>
>> +#define PHY_CFG_PLLCFG                         0x220
>> +#define PHY_CFG_EIOS_DTCT_REG                  0x3e4
>> +#define PHY_CFG_GEN3_ALIGN_HOLDOFF_TIME                0x3e8
>> +
>>   #define PHY_MODE_FIXED         0x1
>>
>>   enum qcom_uniphy_pcie_type {
>> @@ -112,6 +116,21 @@ static const struct uniphy_regs ipq5018_regs[] = {
>>          },
>>   };
>>
>> +static const struct uniphy_regs ipq5332_regs[] = {
>> +       {
>> +               .offset = PHY_CFG_PLLCFG,
>> +               .val = 0x30,
>> +       },
>> +       {
>> +               .offset = PHY_CFG_EIOS_DTCT_REG,
>> +               .val = 0x53ef,
>> +       },
>> +       {
>> +               .offset = PHY_CFG_GEN3_ALIGN_HOLDOFF_TIME,
>> +               .val = 0xCf,
>> +       },
>> +};
>> +
>>   static const struct uniphy_pcie_data ipq5018_2x2_data = {
>>          .lanes          = 2,
>>          .lane_offset    = 0x800,
>> @@ -121,6 +140,23 @@ static const struct uniphy_pcie_data ipq5018_2x2_data = {
>>          .pipe_clk_rate  = 125000000,
>>   };
>>
>> +static const struct uniphy_pcie_data ipq5332_x2_data = {
>> +       .lanes          = 2,
>> +       .lane_offset    = 0x800,
>> +       .phy_type       = PHY_TYPE_PCIE_GEN3,
>> +       .init_seq       = ipq5332_regs,
>> +       .init_seq_num   = ARRAY_SIZE(ipq5332_regs),
>> +       .pipe_clk_rate  = 250000000,
>> +};
>> +
>> +static const struct uniphy_pcie_data ipq5332_x1_data = {
>> +       .lanes          = 1,
>> +       .phy_type       = PHY_TYPE_PCIE_GEN3,
>> +       .init_seq       = ipq5332_regs,
>> +       .init_seq_num   = ARRAY_SIZE(ipq5332_regs),
>> +       .pipe_clk_rate  = 250000000,
>> +};
> Please keep structs sorted out.
sure, will address in next patch set.
>
>> +
>>   static void qcom_uniphy_pcie_init(struct qcom_uniphy_pcie *phy)
>>   {
>>          const struct uniphy_pcie_data *data = phy->data;
>> @@ -270,6 +306,14 @@ static const struct of_device_id qcom_uniphy_pcie_id_table[] = {
>>                  .compatible = "qcom,ipq5018-uniphy-pcie-gen2x2",
>>                  .data = &ipq5018_2x2_data,
>>          },
>> +       {
>> +               .compatible = "qcom,ipq5332-uniphy-pcie-gen3x2",
>> +               .data = &ipq5332_x2_data,
>> +       },
>> +       {
>> +               .compatible = "qcom,ipq5332-uniphy-pcie-gen3x1",
>> +               .data = &ipq5332_x1_data,
> The entries here should be sorted out.
will take care.
>
>> +       },
>>          { /* Sentinel */ },
>>   };
>>   MODULE_DEVICE_TABLE(of, qcom_uniphy_pcie_id_table);
>> --
>> 2.34.1
>>
>>
>
--
Thanks,
Praveenkumar

