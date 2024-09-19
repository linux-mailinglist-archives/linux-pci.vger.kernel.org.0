Return-Path: <linux-pci+bounces-13294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A7097CAB6
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 16:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A933EB20982
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 14:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DD519E96B;
	Thu, 19 Sep 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cL+ry6ya"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FECA28EA;
	Thu, 19 Sep 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754761; cv=none; b=q6FDmRMIBT80ctvH4ec5f9CH6xbVK71CSxN/QsVm4nPnBthxZBG9CXyxwF5oDDvgh9IBjFWYBlmZStCp56RedMQfIiJdLLF3yB+omrB58zxrv8Pbgn02JAjM6PsePgO6lBboB7Ju7cQ2S+lmrbuqXtEezUA3Na/uO8WBDpldeQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754761; c=relaxed/simple;
	bh=1jusQ2QZysUrEYVXS+vA+nlKfHuKO4nT+tL/ykCQ7KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tJ/Ru+YSNcOu87fe0hoBFKq9TctlxRivX9H65our5iBJVYyliNNTc83DO8BgdAAMmpsCtFiijSxJ2igl9zwXGXSYRVp3O8TLMdEZ3vgvXvQVkhtOLdDIxAtt8XeITR+8Se4OT3zSCRPp8iGZOOJMFgXG2JNA83OCd462SryhP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cL+ry6ya; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J96WYd023715;
	Thu, 19 Sep 2024 14:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uFhBTahebu4VgxkS8FMCQLMBIAheHoUGsXISykSdThA=; b=cL+ry6yaTOl/b2tf
	DyZivyfX9G1J/iaQA7Y/V6suKXAqXvkNGm93xqsVNpLVz7bsM7Qy8RD0j4PLiFPl
	IVD4DMiOfLWmx8eBgB0y4dyyHwloKNh2zR1tR19XTFMM1Svt4tbNiG3BfHHtEG8G
	Zy6P0bethRLpv4F+jFYAUXWjSE+2slYxvzNwokcWllxPp1xDBXTRPAUVQ4yDfS3q
	OXJ8mq/uNmTPY2q7y7YFBq1409IFjXDKc0SjGxD1Wuf/iS/6EMzpyvP/BNSnXx94
	5zKwS8HLR4Jj6kzfaXQyB4kmbq8Wejj6T/UOxWinNgeVV6SDnb12rhcFIjBBWEQT
	NFLmvA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4kjngxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 14:05:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48JE5kqn013393
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 14:05:46 GMT
Received: from [10.253.37.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Sep
 2024 07:05:40 -0700
Message-ID: <af601078-3ab7-484e-bdd3-6220a5fb3083@quicinc.com>
Date: Thu, 19 Sep 2024 22:05:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <abel.vesa@linaro.org>, <quic_msarkar@quicinc.com>,
        <quic_devipriy@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <kw@linux.com>, <lpieralisi@kernel.org>, <neil.armstrong@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
 <20240913083724.1217691-6-quic_qianyu@quicinc.com>
 <20240913135710.6ionsmzo45orin6n@thinkpad>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20240913135710.6ionsmzo45orin6n@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: givn9zvQi86dlin518MTGRoXkk5wFe4p
X-Proofpoint-ORIG-GUID: givn9zvQi86dlin518MTGRoXkk5wFe4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409190093


On 9/13/2024 9:57 PM, Manivannan Sadhasivam wrote:
> On Fri, Sep 13, 2024 at 01:37:24AM -0700, Qiang Yu wrote:
>> Describe PCIe3 controller and PHY. Also add required system resources like
>> regulators, clocks, interrupts and registers configuration for PCIe3.
>>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 202 ++++++++++++++++++++++++-
>>   1 file changed, 201 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index a36076e3c56b..a7703e4974a6 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -744,7 +744,7 @@ gcc: clock-controller@100000 {
>>   
>>   			clocks = <&bi_tcxo_div2>,
>>   				 <&sleep_clk>,
>> -				 <0>,
>> +				 <&pcie3_phy>,
>>   				 <&pcie4_phy>,
>>   				 <&pcie5_phy>,
>>   				 <&pcie6a_phy>,
>> @@ -2907,6 +2907,206 @@ mmss_noc: interconnect@1780000 {
>>   			#interconnect-cells = <2>;
>>   		};
>>   
>> +		pcie3: pci@1bd0000 {
> pcie@
>
>> +			device_type = "pci";
>> +			compatible = "qcom,pcie-x1e80100";
>> +			reg = <0 0x01bd0000 0 0x3000>,
>> +			      <0 0x78000000 0 0xf1d>,
> 0x0 here and below.
>
>> +			      <0 0x78000f40 0 0xa8>,
>> +			      <0 0x78001000 0 0x1000>,
>> +			      <0 0x78100000 0 0x100000>,
>> +			      <0 0x01bd3000 0 0x1000>;
>> +			reg-names = "parf",
>> +				    "dbi",
>> +				    "elbi",
>> +				    "atu",
>> +				    "config",
>> +				    "mhi";
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x78200000 0x0 0x100000>,
>> +				 <0x02000000 0x0 0x78300000 0x0 0x78300000 0x0 0x3d00000>,
>> +				 <0x03000000 0x7 0x40000000 0x7 0x40000000 0x0 0x40000000>;
>> +			bus-range = <0x00 0xff>;
>> +
>> +			dma-coherent;
>> +
>> +			linux,pci-domain = <3>;
>> +			num-lanes = <8>;
>> +
>> +			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 671 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "msi0",
>> +					  "msi1",
>> +					  "msi2",
>> +					  "msi3",
>> +					  "msi4",
>> +					  "msi5",
>> +					  "msi6",
>> +					  "msi7";
> Can you add 'global' interrupt as well? While doing so, please make sure the
> global_irq related patches are applied and Link up works fine. Those patches are
> already in linux-next.
Sure, let me add global interrupt and have a try. Will also update patch
according to your other comments.

Thanks,
Qiang
>
>> +
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0x7>;
>> +			interrupt-map = <0 0 0 1 &intc 0 0 0 220 IRQ_TYPE_LEVEL_HIGH>,
> Use GIC_SPI for the parent interrupt specifier.
>
> - Mani
>
>> +					<0 0 0 2 &intc 0 0 0 221 IRQ_TYPE_LEVEL_HIGH>,
>> +					<0 0 0 3 &intc 0 0 0 237 IRQ_TYPE_LEVEL_HIGH>,
>> +					<0 0 0 4 &intc 0 0 0 238 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			clocks = <&gcc GCC_PCIE_3_AUX_CLK>,
>> +				 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
>> +				 <&gcc GCC_PCIE_3_MSTR_AXI_CLK>,
>> +				 <&gcc GCC_PCIE_3_SLV_AXI_CLK>,
>> +				 <&gcc GCC_PCIE_3_SLV_Q2A_AXI_CLK>,
>> +				 <&gcc GCC_CFG_NOC_PCIE_ANOC_NORTH_AHB_CLK>,
>> +				 <&gcc GCC_CNOC_PCIE_NORTH_SF_AXI_CLK>;
>> +			clock-names = "aux",
>> +				      "cfg",
>> +				      "bus_master",
>> +				      "bus_slave",
>> +				      "slave_q2a",
>> +				      "noc_aggr",
>> +				      "cnoc_sf_axi";
>> +
>> +			assigned-clocks = <&gcc GCC_PCIE_3_AUX_CLK>;
>> +			assigned-clock-rates = <19200000>;
>> +
>> +			interconnects = <&pcie_south_anoc MASTER_PCIE_3 QCOM_ICC_TAG_ALWAYS
>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
>> +					 &cnoc_main SLAVE_PCIE_3 QCOM_ICC_TAG_ALWAYS>;
>> +			interconnect-names = "pcie-mem",
>> +					     "cpu-pcie";
>> +
>> +			resets = <&gcc GCC_PCIE_3_BCR>,
>> +				 <&gcc GCC_PCIE_3_LINK_DOWN_BCR>;
>> +			reset-names = "pci",
>> +				      "link_down";
>> +
>> +			power-domains = <&gcc GCC_PCIE_3_GDSC>;
>> +
>> +			phys = <&pcie3_phy>;
>> +			phy-names = "pciephy";
>> +
>> +			operating-points-v2 = <&pcie3_opp_table>;
>> +
>> +			status = "disabled";
>> +
>> +			pcie3_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				/* GEN 1 x1 */
>> +				opp-2500000 {
>> +					opp-hz = /bits/ 64 <2500000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <250000 1>;
>> +				};
>> +
>> +				/* GEN 1 x2 and GEN 2 x1 */
>> +				opp-5000000 {
>> +					opp-hz = /bits/ 64 <5000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <500000 1>;
>> +				};
>> +
>> +				/* GEN 1 x4 and GEN 2 x2 */
>> +				opp-10000000 {
>> +					opp-hz = /bits/ 64 <10000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <1000000 1>;
>> +				};
>> +
>> +				/* GEN 1 x8 and GEN 2 x4 */
>> +				opp-20000000 {
>> +					opp-hz = /bits/ 64 <20000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <2000000 1>;
>> +				};
>> +
>> +				/* GEN 2 x8 */
>> +				opp-40000000 {
>> +					opp-hz = /bits/ 64 <40000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <4000000 1>;
>> +				};
>> +
>> +				/* GEN 3 x1 */
>> +				opp-8000000 {
>> +					opp-hz = /bits/ 64 <8000000>;
>> +					required-opps = <&rpmhpd_opp_svs>;
>> +					opp-peak-kBps = <984500 1>;
>> +				};
>> +
>> +				/* GEN 3 x2 and GEN 4 x1 */
>> +				opp-16000000 {
>> +					opp-hz = /bits/ 64 <16000000>;
>> +					required-opps = <&rpmhpd_opp_svs>;
>> +					opp-peak-kBps = <1969000 1>;
>> +				};
>> +
>> +				/* GEN 3 x4 and GEN 4 x2 */
>> +				opp-32000000 {
>> +					opp-hz = /bits/ 64 <32000000>;
>> +					required-opps = <&rpmhpd_opp_svs>;
>> +					opp-peak-kBps = <3938000 1>;
>> +				};
>> +
>> +				/* GEN 3 x8 and GEN 4 x4 */
>> +				opp-64000000 {
>> +					opp-hz = /bits/ 64 <64000000>;
>> +					required-opps = <&rpmhpd_opp_svs>;
>> +					opp-peak-kBps = <7876000 1>;
>> +				};
>> +
>> +				/* GEN 4 x8 */
>> +				opp-128000000 {
>> +					opp-hz = /bits/ 64 <128000000>;
>> +					required-opps = <&rpmhpd_opp_svs>;
>> +					opp-peak-kBps = <15753000 1>;
>> +				};
>> +			};
>> +		};
>> +
>> +		pcie3_phy: phy@1be0000 {
>> +			compatible = "qcom,x1e80100-qmp-gen4x8-pcie-phy";
>> +			reg = <0 0x01be0000 0 0x10000>;
>> +
>> +			clocks = <&gcc GCC_PCIE_3_PHY_AUX_CLK>,
>> +				 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
>> +				 <&tcsr TCSR_PCIE_8L_CLKREF_EN>,
>> +				 <&gcc GCC_PCIE_3_PHY_RCHNG_CLK>,
>> +				 <&gcc GCC_PCIE_3_PIPE_CLK>,
>> +				 <&gcc GCC_PCIE_3_PIPEDIV2_CLK>;
>> +			clock-names = "aux",
>> +				      "cfg_ahb",
>> +				      "ref",
>> +				      "rchng",
>> +				      "pipe",
>> +				      "pipediv2";
>> +
>> +			resets = <&gcc GCC_PCIE_3_PHY_BCR>,
>> +				 <&gcc GCC_PCIE_3_NOCSR_COM_PHY_BCR>;
>> +			reset-names = "phy",
>> +				      "phy_nocsr";
>> +
>> +			assigned-clocks = <&gcc GCC_PCIE_3_PHY_RCHNG_CLK>;
>> +			assigned-clock-rates = <100000000>;
>> +
>> +			power-domains = <&gcc GCC_PCIE_3_PHY_GDSC>;
>> +
>> +			#clock-cells = <0>;
>> +			clock-output-names = "pcie3_pipe_clk";
>> +
>> +			#phy-cells = <0>;
>> +
>> +			status = "disabled";
>> +		};
>> +
>>   		pcie6a: pci@1bf8000 {
>>   			device_type = "pci";
>>   			compatible = "qcom,pcie-x1e80100";
>> -- 
>> 2.34.1
>>

