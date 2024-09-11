Return-Path: <linux-pci+bounces-13029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57540974C81
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 10:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3741C214E2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 08:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A803A142E9D;
	Wed, 11 Sep 2024 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mh3jAILL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0337137772;
	Wed, 11 Sep 2024 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042974; cv=none; b=Z/YUJunBVFsmIQUAAtMqcKyHJjv+Y9rNeouk9tdf93TDHitYljpvGN2SjbKqQinRXvMJGZXhYbgs63B5dsR/YorJYmo09+zVeraJPjRfoGjLBxx31wc/SrunKHb/ZyfQB+YxMkByu7e0AT9k55OOL2niucHd6CfwgizFVo0AXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042974; c=relaxed/simple;
	bh=Ab73JY5g5y+GR5W88HxSwWJqX3T0AZcZEhr8fYdpqSk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=ZDlHicle6f/F++pYv08CJkoKK9IKVY+vV3xPb2ez7qYBQML4nrkqUMwfdOPwdBttXTNEWcWgA0JHsST75EiP1c7fFpuUi3JJjDWOJa2nKBHx3ELBomSV7/mlWFPiKJcuQvtH/iscYK0j0iKPdDJziUxxb/kV5rtvnvW6LMy5cWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mh3jAILL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B3GeJ5013216;
	Wed, 11 Sep 2024 08:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kat7Z5rzKp+1bL71CgVzhMMx3n9gIB5aF9Vh/GFZSY4=; b=mh3jAILLnbr5fAxK
	GyoyHDcjJuYKxDwDSL+WLXfLQ2ra8WA8SlFIuzQp80Xt7BMZuL24TGnZ4WQc8TY5
	jBiS/3XmDMRp86NSRVjyZPwMKMjlrQ8UpbLjJaWpifUXTcCW0Whmcul+w90OETe0
	uRqUjYiIM3T9uH/BxPzXi7ERwP7TPCJMPnYJ8G6fqlSFvUxZeGx5trOT2BQwfwkY
	KB/ZenewOIjhlqADELRmjZ98n5cniWdKzt47skwOB7nKV2WSzRjlIU1+ePAfSqYp
	mHyN3tXnB+679Hd9HGAuSCb6pK9bDcX0Mcqn5dQh6+SnM0+QdT17AEdrKjWVE43b
	z8eMEQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy6srxc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 08:22:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48B8MhCN030069
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 08:22:43 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Sep
 2024 01:22:38 -0700
Message-ID: <cc9df490-dca9-4771-91cb-e8e1b5d2d48e@quicinc.com>
Date: Wed, 11 Sep 2024 16:22:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] arm64: dts: qcom: x1e80100: Add support for PCIe3 on
 x1e80100
From: Qiang Yu <quic_qianyu@quicinc.com>
To: Konrad Dybcio <konradybcio@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <andersson@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <abel.vesa@linaro.org>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>
CC: <dmitry.baryshkov@linaro.org>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-5-quic_qianyu@quicinc.com>
 <41d4bc67-e47c-4b6e-a620-b83f48f43103@kernel.org>
 <ffbeb834-c56a-40b2-b9d6-f03149a1a37b@quicinc.com>
Content-Language: en-US
In-Reply-To: <ffbeb834-c56a-40b2-b9d6-f03149a1a37b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: boWC1osfgObxqFEerBDwfbejaaFhHKOj
X-Proofpoint-ORIG-GUID: boWC1osfgObxqFEerBDwfbejaaFhHKOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110063


On 8/28/2024 9:36 PM, Qiang Yu wrote:
>
> On 8/27/2024 6:42 PM, Konrad Dybcio wrote:
>> On 27.08.2024 8:36 AM, Qiang Yu wrote:
>>> Describe PCIe3 controller and PHY. Also add required system 
>>> resources like
>>> regulators, clocks, interrupts and registers configuration for PCIe3.
>>>
>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 205 
>>> ++++++++++++++++++++++++-
>>>   1 file changed, 204 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi 
>>> b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>> index 74b694e74705..55b81e7de1c7 100644
>>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>>> @@ -744,7 +744,7 @@ gcc: clock-controller@100000 {
>>>                 clocks = <&bi_tcxo_div2>,
>>>                    <&sleep_clk>,
>>> -                 <0>,
>>> +                 <&pcie3_phy>,
>>>                    <&pcie4_phy>,
>>>                    <&pcie5_phy>,
>>>                    <&pcie6a_phy>,
>>> @@ -2879,6 +2879,209 @@ mmss_noc: interconnect@1780000 {
>>>               #interconnect-cells = <2>;
>>>           };
>>>   +        pcie3: pci@1bd0000 {
>>> +            device_type = "pci";
>>> +            compatible = "qcom,pcie-x1e80100";
>>> +            reg = <0 0x01bd0000 0 0x3000>,
>>> +                  <0 0x78000000 0 0xf1d>,
>>> +                  <0 0x78000f40 0 0xa8>,
>>> +                  <0 0x78001000 0 0x1000>,
>>> +                  <0 0x78100000 0 0x100000>;
>>> +            reg-names = "parf",
>>> +                    "dbi",
>>> +                    "elbi",
>>> +                    "atu",
>>> +                    "config";
>> There's a "mhi" region at 0x01bd3000, 0x1000-wide too, please add it
>>
>>> +            #address-cells = <3>;
>>> +            #size-cells = <2>;
>>> +            ranges = <0x01000000 0 0x00000000 0 0x78200000 0 
>>> 0x100000>,
>>> +                 <0x02000000 0 0x78300000 0 0x78300000 0 0x3d00000>;
>> There's 64bit BAR space as well:
>>
>> <0x03000000 0x7 0x40000000 0x7 0x40000000 0x0 0x40000000>;
>>
>>> +            bus-range = <0 0xff>;
>> 0x00 please
>>
>>> +
>>> +            dma-coherent;
>>> +
>>> +            linux,pci-domain = <3>;
>>> +            num-lanes = <8>;
>>> +
>>> +            interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 671 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
>>> +            interrupt-names = "msi0",
>>> +                      "msi1",
>>> +                      "msi2",
>>> +                      "msi3",
>>> +                      "msi4",
>>> +                      "msi5",
>>> +                      "msi6",
>>> +                      "msi7";
>>> +
>>> +            #interrupt-cells = <1>;
>>> +            interrupt-map-mask = <0 0 0 0x7>;
>>> +            interrupt-map = <0 0 0 1 &intc 0 0 0 220 
>>> IRQ_TYPE_LEVEL_HIGH>,
>>> +                    <0 0 0 2 &intc 0 0 0 221 IRQ_TYPE_LEVEL_HIGH>,
>>> +                    <0 0 0 3 &intc 0 0 0 237 IRQ_TYPE_LEVEL_HIGH>,
>>> +                    <0 0 0 4 &intc 0 0 0 238 IRQ_TYPE_LEVEL_HIGH>;
>>> +
>>> +            clocks = <&gcc GCC_PCIE_3_PIPE_CLK_SRC>,
>> We don't toggle source clocks from dt, this is upstream of the pipe
>> div clocks and is taken care of by the common clock framework,
>> please drop.
> GCC_PCIE_3_PIPE_CLK_SRC is a clk mux. The enable and disable callback
> provided in clk driver is used to switch between pipe_clk and XO,
> respectively. If we drop GCC_PCIE_3_PIPE_CLK_SRC here, that means
> the mux will be XO until pipediv2 clk is enabled. I need to do some
> experiment to check this. Will update in thread.
>
> Thanks,
> Qiang
After removing GCC_PCIE_3_PIPE_CLK_SRC, I tested it and link was up.

Thanks,
Qiang
>>> +                 <&gcc GCC_PCIE_3_AUX_CLK>,
>>> +                 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
>>> +                 <&gcc GCC_PCIE_3_MSTR_AXI_CLK>,
>>> +                 <&gcc GCC_PCIE_3_SLV_AXI_CLK>,
>>> +                 <&gcc GCC_PCIE_3_SLV_Q2A_AXI_CLK>,
>>> +                 <&gcc GCC_CFG_NOC_PCIE_ANOC_SOUTH_AHB_CLK>,
>> GCC_CFG_NOC_PCIE_ANOC_NORTH_AHB_CLK
>>
>>> +                 <&gcc GCC_CNOC_PCIE_NORTH_SF_AXI_CLK>;
>>> +            clock-names = "pipe_clk_src",
>>> +                      "aux",
>>> +                      "cfg",
>>> +                      "bus_master",
>>> +                      "bus_slave",
>>> +                      "slave_q2a",
>>> +                      "noc_aggr",
>>> +                      "cnoc_sf_axi";
>>> +
>>> +            assigned-clocks = <&gcc GCC_PCIE_3_AUX_CLK>;
>>> +            assigned-clock-rates = <19200000>;
>>> +
>>> +            interconnects = <&pcie_south_anoc MASTER_PCIE_3 
>>> QCOM_ICC_TAG_ALWAYS
>>> +                     &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>>> +                    <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
>>> +                     &cnoc_main SLAVE_PCIE_3 QCOM_ICC_TAG_ALWAYS>;
>>> +            interconnect-names = "pcie-mem",
>>> +                         "cpu-pcie";
>>> +
>>> +            resets = <&gcc GCC_PCIE_3_BCR>,
>>> +                 <&gcc GCC_PCIE_3_LINK_DOWN_BCR>;
>>> +            reset-names = "pci",
>>> +                      "link_down";
>>> +
>>> +            power-domains = <&gcc GCC_PCIE_3_GDSC>;
>>> +
>>> +            phys = <&pcie3_phy>;
>>> +            phy-names = "pciephy";
>>> +
>>> +            operating-points-v2 = <&pcie3_opp_table>;
>>> +
>>> +            status = "disabled";
>>> +
>>> +            pcie3_opp_table: opp-table {
>>> +                compatible = "operating-points-v2";
>>> +
>>> +                /* GEN 1 x1 */
>>> +                opp-2500000 {
>>> +                    opp-hz = /bits/ 64 <2500000>;
>>> +                    required-opps = <&rpmhpd_opp_low_svs>;
>>> +                    opp-peak-kBps = <250000 1>;
>>> +                };
>>> +
>>> +                /* GEN 1 x2 and GEN 2 x1 */
>>> +                opp-5000000 {
>>> +                    opp-hz = /bits/ 64 <5000000>;
>>> +                    required-opps = <&rpmhpd_opp_low_svs>;
>>> +                    opp-peak-kBps = <500000 1>;
>>> +                };
>>> +
>>> +                /* GEN 1 x4 and GEN 2 x2*/
>> Missing ' '
>>
>>> +                opp-10000000 {
>>> +                    opp-hz = /bits/ 64 <10000000>;
>>> +                    required-opps = <&rpmhpd_opp_low_svs>;
>>> +                    opp-peak-kBps = <1000000 1>;
>>> +                };
>>> +
>>> +                /* GEN 1 x8 and GEN 2 X4 */
>> Inconsistent capitalization, please use lowercase 'x'
>>
>> [...]
>>
>>> +        pcie3_phy: phy@1be0000 {
>>> +            compatible = "qcom,x1e80100-qmp-gen4x8-pcie-phy";
>>> +            reg = <0 0x01be0000 0 0x10000>;
>>> +
>>> +            clocks = <&gcc GCC_PCIE_3_AUX_CLK>,
>> This clock doesn't belong here, the PHY is clocked by PHY_AUX
>>
>>> +                 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
>>> +                 <&rpmhcc RPMH_CXO_CLK>,
>> This is unnecessary as commented before
>>
>>> +                 <&gcc GCC_PCIE_3_PHY_RCHNG_CLK>,
>>> +                 <&gcc GCC_PCIE_3_PHY_AUX_CLK>,
>>> +                 <&gcc GCC_PCIE_3_PIPE_CLK>,
>>> +                 <&gcc GCC_PCIE_3_PIPEDIV2_CLK>,
>>> +                 <&tcsr TCSR_PCIE_8L_CLKREF_EN>;
>> This should be the 'ref' here
>>
>> Konrad

