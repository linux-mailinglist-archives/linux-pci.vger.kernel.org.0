Return-Path: <linux-pci+bounces-13471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC4D985187
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 05:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4946B22C93
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 03:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFFE14A0AE;
	Wed, 25 Sep 2024 03:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pL3T9XDw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEDE126F0A;
	Wed, 25 Sep 2024 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235563; cv=none; b=N1q2EX0a/M3qLLm/uoj4bIye/eHl//aybmp6gchy8ecLlxDTW22It1o2/WJIId5rkFy5ca7tGY668GEBIRlutKzCICnTCknmeVbjLf6RH9pN+llKxbQku+TsPS2gVPNRqtO/pnhxK0izUX98dMF02aa6NTUL9fcPKLJOkHdPlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235563; c=relaxed/simple;
	bh=gLcnXGi8N1CCNOxSPiG3MRaLm34yzenfJ8YqjKHG2P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JcHlLMk3E3S1kCDnoGt///wMApitC0wAYmNXNlY0sGpEpklmd76jctWUGD35N7pF/FTaB/vnpIAUBvU6px83O81oWEpi9MoqKBsagyHXHTVmmS0pWLztZ9TTw//B2hD24V8sVB5JQZOe1KETeJN4CZHsjiVv65M20YKYmi4MrOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pL3T9XDw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OHjGat011775;
	Wed, 25 Sep 2024 03:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LHX4DU4UFKSYENtu4JVMJhTMm5T43DZOWocKrJtf/9c=; b=pL3T9XDwbV4yWZom
	BbJmtMmNLvZRAbJvFpkx/uIv3yx/vkxQAonAivfT6iOnE07a319kawqFtvHADMQf
	68N1nA5gQWt2tv2QZUXGFXLpsGrt/w9IYZlg6TbfjxIbMa5RVaMMDs3TAbxjTsrd
	ksYlru1bUenqWh0YjcVBqR7bV62XGBzm3OmW2QVzVoufOaDiqS12d1/EVG4eN1N0
	wBCMiLkKUJws9Nvqq/PObQZAEUBSK+F8hCr76hzrg/NwpzXbBYVBx7cDONInqnNl
	NeTZDnKVt3xCMQ+u9poOvxMSMf2J72/i6lv74XIz954QpHwgsfAdafpkGOkPybBC
	IDu1oQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sph6tvg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 03:39:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P3d4ow019070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 03:39:04 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 20:38:59 -0700
Message-ID: <3d4a8243-5c2f-41c4-85ce-6e072331f4f3@quicinc.com>
Date: Wed, 25 Sep 2024 11:38:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] phy: qcom: qmp: Add phy register and clk setting
 for x1e80100 PCIe3
To: Johan Hovold <johan@kernel.org>
CC: <manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <abel.vesa@linaro.org>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-4-quic_qianyu@quicinc.com>
 <ZvLXjdpBpUS3lLn-@hovoldconsulting.com>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <ZvLXjdpBpUS3lLn-@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jPKHxBa8Rhh04StTzc9btdnvM9jBXhAn
X-Proofpoint-ORIG-GUID: jPKHxBa8Rhh04StTzc9btdnvM9jBXhAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250024


On 9/24/2024 11:15 PM, Johan Hovold wrote:
> On Tue, Sep 24, 2024 at 03:14:41AM -0700, Qiang Yu wrote:
>> Currently driver supports only x4 lane based functionality using tx/rx and
>> tx2/rx2 pair of register sets. To support 8 lane functionality with PCIe3,
>> PCIe3 related QMP PHY provides additional programming which are available
>> as txz and rxz based register set. Hence adds txz and rxz based registers
>> usage and programming sequences.
>> Phy register setting for txz and rxz will
>> be applied to all 8 lanes. Some lanes may have different settings on
>> several registers than txz/rxz, these registers should be programmed after
>> txz/rxz programming sequences completing.
> Please expand and clarify what you mean by this.
PCIe3 supports 8 lanes, so in general, we have to program 8 pairs tx/rx
registers. However, most of tx/rx registers of different lanes have
same settings, so the configuration for all 8 lanes tx/rx registers is
a little repetitive.

Hence, txz/rxz registers are included. The values programmed into txz/rxz
registers by software will be "broadcasted" to all 8 lanes by hardware.
Some lanes may have different settings on several registers than txz/rxz.
In order to ensure the different values take effect, they need to be
programmed after txz/rxz programming sequences completing.
>   
>> Besides, x1e80100 SoC uses QMP phy with version v6.30 for PCIe Gen4 x8.
>> Add the new register offsets in a dedicated header file.
>>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 211 ++++++++++++++++++
>>   .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h    |  25 +++
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h |  19 ++
>>   3 files changed, 255 insertions(+)
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index f71787fb4d7e..d7bbd9df11d7 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> @@ -1344,6 +1346,155 @@ static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
>>   	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_FOM_EQ_CONFIG5, 0x8a),
>>   };
>>   
>> +static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x8_pcie_txz_tbl[] = {
> Please try to follow the sort order used for the other platforms for
> these tables (e.g.  serdes, tx, rx, pcr, pcr_misc).
OK, will follow this order.
>
>> +static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x8_pcie_pcs_misc_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_ENDPOINT_REFCLK_DRIVE, 0xc1),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_OSC_DTCT_ACTIONS, 0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_EQ_CONFIG1, 0x16),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G4_EQ_CONFIG5, 0x02),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G4_PRE_GAIN, 0x2e),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG1, 0x03),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG3, 0x28),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG5, 0x18),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G3_FOM_EQ_CONFIG5, 0x7a),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G4_FOM_EQ_CONFIG5, 0x8a),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G3_RXEQEVAL_TIME, 0x27),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G4_RXEQEVAL_TIME, 0x27),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_TX_RX_CONFIG, 0xc0),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_POWER_STATE_CONFIG2, 0x1d),
>> +
> Stray newline.
>
>> +};
>> +
>> +static const struct qmp_phy_cfg x1e80100_qmp_gen4x8_pciephy_cfg = {
>> +	.lanes = 8,
>> +
>> +	.offsets		= &qmp_pcie_offsets_v6_30,
>> +	.tbls = {
>> +		.serdes			= x1e80100_qmp_gen4x8_pcie_serdes_tbl,
>> +		.serdes_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_serdes_tbl),
>> +		.rx			= x1e80100_qmp_gen4x8_pcie_rx_tbl,
>> +		.rx_num			= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_rx_tbl),
>> +		.pcs			= x1e80100_qmp_gen4x8_pcie_pcs_tbl,
>> +		.pcs_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_pcs_tbl),
>> +		.pcs_misc		= x1e80100_qmp_gen4x8_pcie_pcs_misc_tbl,
>> +		.pcs_misc_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_pcs_misc_tbl),
>> +		.ln_shrd		= x1e80100_qmp_gen4x8_pcie_ln_shrd_tbl,
>> +		.ln_shrd_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_ln_shrd_tbl),
>> +		.txz			= x1e80100_qmp_gen4x8_pcie_txz_tbl,
>> +		.txz_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_txz_tbl),
>> +		.rxz			= x1e80100_qmp_gen4x8_pcie_rxz_tbl,
>> +		.rxz_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_rxz_tbl),
> Try follow the order of the other SoCs here as well (e.g. use the order
> defined in struct qmp_phy_cfg_tbls).

Will follow the order defined in struct qmp_phy_cfg_tbls.

>
>> +	},
>>   static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
>>   {
>>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
>> @@ -3751,6 +3953,9 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
>>   
>>   	qmp_configure(qmp->dev, serdes, tbls->serdes, tbls->serdes_num);
> If your comment in the commit message implies that txz/rxz must be
> programmed before tx/rx then you need to add a comment here as well.

Will add a comment here.

Thanks,
Qiang Yu
>
>> +	qmp_configure(qmp->dev, qmp->txz, tbls->txz, tbls->txz_num);
>> +	qmp_configure(qmp->dev, qmp->rxz, tbls->rxz, tbls->rxz_num);
>> +
>>   	qmp_configure_lane(qmp->dev, tx, tbls->tx, tbls->tx_num, 1);
>>   	qmp_configure_lane(qmp->dev, rx, tbls->rx, tbls->rx_num, 1);
> Johan

