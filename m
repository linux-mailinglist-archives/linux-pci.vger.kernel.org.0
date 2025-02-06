Return-Path: <linux-pci+bounces-20785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A36CA2A0D9
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 07:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D760C1884F74
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 06:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C669322370F;
	Thu,  6 Feb 2025 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p0T9wdEU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6392561D;
	Thu,  6 Feb 2025 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738822780; cv=none; b=R+ainr23FYpwZ8GpH5DV/YmZ49uKFQuwoSHc7zNLgNVtI6p38C15RjHpkXzaKYKtF3j2NX0uzWexa+uIosR7qI6T6Ec0Z8eb8Rc8PoNBSIkNVfAt9ZOUgtwC1atQmkCDgLsVpASSGTIQaArQLALQaP3tUhnp6eHiWC7Q9wDkuSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738822780; c=relaxed/simple;
	bh=/QQ6jrDpB/E4LRwZjoIf3gn2ExmXKKQY1XNXZMX+dLY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epp07S0tu1MQsf9YgfRGTa8EFfOzYgFUGu1MTajimjlTUzl9U42hKNeLfylN9r1CoHJaQfTWLd9ZVDlNabmhxKjy5zJafddo1DkPKaaiGgER+Mxh0ANNkuNs79JmnsEkurW9CqEZCLhegzseP1iZEPan7RskwA6nbhzLjzDk4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p0T9wdEU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161iwPS029805;
	Thu, 6 Feb 2025 06:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1GjdVUeIgEMWel2f4TkBw/gT
	uyQzB8WZcxBa+28LGjA=; b=p0T9wdEU9Wm26EaiPU8pHANnL7yRIDT+PF0mhdQ4
	aLCYFdRbC+UFUjQXrs9wnR9jfZIccDqBbZwHlGYiSlIBJe1ZlcN1bJf1L0TRtVk1
	bWeb8ipW9qBNLVm4mAWAtLcKAM7zaavsllE2rLFyZrR6eUsGYNK8I9mUqXwoeJSa
	2cA9A07INwAWrqOQp9n3+i1PxMvzsR07i9WHyYmSies5MZVpr/yU3pXDI1BAKnht
	9iy8w7C8pylxFyUcpVpsTP2LUVXqosakoFSfObXyoaL/fDdw3CIW3eMo7u+1L+kW
	6GWysLKu2DzbJRNkwsY/xMwv9yZq0gAMg3XjayrBMCPxHg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mkpjrgty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 06:19:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5166JKgU025475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Feb 2025 06:19:20 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Feb 2025 22:19:14 -0800
Date: Thu, 6 Feb 2025 11:49:11 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 6/7] arm64: dts: qcom: ipq5332: Add PCIe related nodes
Message-ID: <Z6RUX3ZbDbd3qvjs@hu-varada-blr.qualcomm.com>
References: <20250128062708.573662-1-quic_varada@quicinc.com>
 <20250128062708.573662-7-quic_varada@quicinc.com>
 <cc1c34f0-0737-469d-a826-2df7f29f6cf3@kernel.org>
 <Z6NCSo98YRgG666Q@hu-varada-blr.qualcomm.com>
 <85f54baa-7d3d-43c3-9944-8f5f3c3006da@kernel.org>
 <Z6OFSr2vrmPJTp4u@hu-varada-blr.qualcomm.com>
 <d867f285-b639-4080-beeb-20b75ee3f4a2@kernel.org>
 <1d78b30c-f71a-4769-b665-7425f00eb5ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1d78b30c-f71a-4769-b665-7425f00eb5ec@kernel.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cLEOi0dATr7nRvo4rsO8ih8xrrbRzmM9
X-Proofpoint-GUID: cLEOi0dATr7nRvo4rsO8ih8xrrbRzmM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=986 lowpriorityscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060050

On Wed, Feb 05, 2025 at 04:54:38PM +0100, Krzysztof Kozlowski wrote:
> On 05/02/2025 16:53, Krzysztof Kozlowski wrote:
> > On 05/02/2025 16:35, Varadarajan Narayanan wrote:
> >> On Wed, Feb 05, 2025 at 02:47:13PM +0100, Krzysztof Kozlowski wrote:
> >>> On 05/02/2025 11:49, Varadarajan Narayanan wrote:
> >>>> On Mon, Feb 03, 2025 at 05:30:32PM +0100, Krzysztof Kozlowski wrote:
> >>>>> On 28/01/2025 07:27, Varadarajan Narayanan wrote:
> >>>>>>
> >>>>>> @@ -479,6 +519,230 @@ frame@b128000 {
> >>>>>>  				status = "disabled";
> >>>>>>  			};
> >>>>>>  		};
> >>>>>> +
> >>>>>> +		pcie1: pcie@18000000 {
> >>>>>> +			compatible = "qcom,pcie-ipq5332", "qcom,pcie-ipq9574";
> >>>>>> +			reg = <0x00088000 0x3000>,
> >>>>>
> >>>>> So as Konrad pointed out now, this was never tested. It's not we who
> >>>>> should run tests for you. It's you.
> >>>>
> >>>> This was tested and it did not flag an error since it is having the order
> >>>> specified in the bindings. qcom,pcie.yaml has 4 reg specifications. Two of
> >>>
> >>>
> >>> Hm, then please paste results of dtbs_check W=1 testing. Here.
> >>>
> >>> I am 100% sure you have there warning and I don't understand your
> >>> reluctance to run the tests even after pointing it out by two people.
> >>
> >> I ran the tests. Not sure which portions to paste. Have attached the full
> >> output just in case you are interested in some other detail. Please take a
> >> look.
> >>
> >> Thanks
> >> Varada
> >>
> >> 	$ grep ipq.*dtb dtbs-check.log
> >
> > Where is the command you have used?

	export ARCH=arm64
	export W=1
	export DT_CHECKER_FLAGS='-v -m'
	export DT_SCHEMA_FILES=qcom
	export CHECK_DTBS=y

	make -j 16 dtbs_check &> dtbs-check.log

> Although that might not matter - you skipped several warnings with your
> grep. So maybe you need to fix your process, not sure.

export W=1 is the problem. Kernel Makefile differentiates between 'W' being
set from environment and from command line with this check

	ifeq ("$(origin W)", "command line")
	  KBUILD_EXTRA_WARN := $(W)
	endif

I assumed similar to DT_SCHEMA_FILES and DT_CHECKER_FLAGS, W will also be
taken. I was not aware of this differentiation, and the 'export W=1' never
came into effect. I re-ran the command as below and see the warnings

	$ make W=1 -j 16 dtbs_check &> dtbs-check2.log

	$ grep Warning dtbs-check2.log | grep ipq.*dt
	arch/arm64/boot/dts/qcom/ipq5332.dtsi:523.24-625.5: Warning (simple_bus_reg): /soc@0/pcie@18000000: simple-bus unit address format error, expected "88000"
	arch/arm64/boot/dts/qcom/ipq5332.dtsi:627.24-729.5: Warning (simple_bus_reg): /soc@0/pcie@20000000: simple-bus unit address format error, expected "80000"
	arch/arm64/boot/dts/qcom/ipq5332.dtsi:523.24-625.5: Warning (simple_bus_reg): /soc@0/pcie@18000000: simple-bus unit address format error, expected "88000"
	arch/arm64/boot/dts/qcom/ipq5332.dtsi:627.24-729.5: Warning (simple_bus_reg): /soc@0/pcie@20000000: simple-bus unit address format error, expected "80000"
	arch/arm64/boot/dts/qcom/ipq5332.dtsi:523.24-625.5: Warning (simple_bus_reg): /soc@0/pcie@18000000: simple-bus unit address format error, expected "88000"
	arch/arm64/boot/dts/qcom/ipq5332.dtsi:627.24-729.5: Warning (simple_bus_reg): /soc@0/pcie@20000000: simple-bus unit address format error, expected "80000"
	arch/arm64/boot/dts/qcom/ipq5332.dtsi:523.24-625.5: Warning (simple_bus_reg): /soc@0/pcie@18000000: simple-bus unit address format error, expected "88000"
	arch/arm64/boot/dts/qcom/ipq5332.dtsi:627.24-729.5: Warning (simple_bus_reg): /soc@0/pcie@20000000: simple-bus unit address format error, expected "80000"
	arch/arm64/boot/dts/qcom/ipq5424.dtsi:304.22-355.5: Warning (simple_bus_reg): /soc@0/usb2@1e00000: simple-bus unit address format error, expected "1ef8800"
	arch/arm64/boot/dts/qcom/ipq5424.dtsi:395.22-448.5: Warning (simple_bus_reg): /soc@0/usb3@8a00000: simple-bus unit address format error, expected "8af8800"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:877.24-959.5: Warning (simple_bus_reg): /soc@0/pcie@10000000: simple-bus unit address format error, expected "f8000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:961.24-1043.5: Warning (simple_bus_reg): /soc@0/pcie@18000000: simple-bus unit address format error, expected "f0000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:1045.24-1127.5: Warning (simple_bus_reg): /soc@0/pcie@20000000: simple-bus unit address format error, expected "88000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:1129.23-1210.5: Warning (simple_bus_reg): /soc@0/pci@28000000: simple-bus unit address format error, expected "80000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:877.24-959.5: Warning (simple_bus_reg): /soc@0/pcie@10000000: simple-bus unit address format error, expected "f8000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:961.24-1043.5: Warning (simple_bus_reg): /soc@0/pcie@18000000: simple-bus unit address format error, expected "f0000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:1045.24-1127.5: Warning (simple_bus_reg): /soc@0/pcie@20000000: simple-bus unit address format error, expected "88000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:1129.23-1210.5: Warning (simple_bus_reg): /soc@0/pci@28000000: simple-bus unit address format error, expected "80000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:877.24-959.5: Warning (simple_bus_reg): /soc@0/pcie@10000000: simple-bus unit address format error, expected "f8000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:961.24-1043.5: Warning (simple_bus_reg): /soc@0/pcie@18000000: simple-bus unit address format error, expected "f0000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:1045.24-1127.5: Warning (simple_bus_reg): /soc@0/pcie@20000000: simple-bus unit address format error, expected "88000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:1129.23-1210.5: Warning (simple_bus_reg): /soc@0/pci@28000000: simple-bus unit address format error, expected "80000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:877.24-959.5: Warning (simple_bus_reg): /soc@0/pcie@10000000: simple-bus unit address format error, expected "f8000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:961.24-1043.5: Warning (simple_bus_reg): /soc@0/pcie@18000000: simple-bus unit address format error, expected "f0000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:1045.24-1127.5: Warning (simple_bus_reg): /soc@0/pcie@20000000: simple-bus unit address format error, expected "88000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:1129.23-1210.5: Warning (simple_bus_reg): /soc@0/pci@28000000: simple-bus unit address format error, expected "80000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:877.24-959.5: Warning (simple_bus_reg): /soc@0/pcie@10000000: simple-bus unit address format error, expected "f8000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:961.24-1043.5: Warning (simple_bus_reg): /soc@0/pcie@18000000: simple-bus unit address format error, expected "f0000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:1045.24-1127.5: Warning (simple_bus_reg): /soc@0/pcie@20000000: simple-bus unit address format error, expected "88000"
	arch/arm64/boot/dts/qcom/ipq9574.dtsi:1129.23-1210.5: Warning (simple_bus_reg): /soc@0/pci@28000000: simple-bus unit address format error, expected "80000"

Will change pcie@xxx to match with the first reg entry and post the next
version.

Thanks
Varada

