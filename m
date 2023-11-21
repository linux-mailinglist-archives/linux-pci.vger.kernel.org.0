Return-Path: <linux-pci+bounces-47-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5621A7F325F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 16:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA77B2189F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B2958108;
	Tue, 21 Nov 2023 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gqi9G+n7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBA6124;
	Tue, 21 Nov 2023 07:33:02 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALE21Ti005024;
	Tue, 21 Nov 2023 15:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=84V9KsuHbDFjDxL6Jfp4/mRg7EWR+9eO9oj9y9l8Ykc=;
 b=Gqi9G+n7j8J7xN3N2m3gpgbeKMyMqW2pF8cj2DY4PbB3QlmJKkuUJ9K+1IB/9R/QQj1K
 vRB0iYW66smpVEPbjDFy2GE7UJX52whkDqraGSZy/jwcR9WPxMnM6ydmGE5TrKP12nwp
 kTFBVOF5Na2oYJ79L7aO/bjAExKV1bgoQvFfhNLU5uPPwMMkQkZTnF4Pv25/lh97rV/h
 OfgYvQU88cgMwlYSKxBTPPWtHpwQ0PMgZV5KNx5Pskp1VuKyAx/ZEamKIVrTkmrGPxav
 VxboWsFmmka5SuvaWtgKAmrvzOoD3GAMqJUjxfN1LEt8T7ZEJAEGAVHQylT06DM+TkPK UQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugrk21f41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 15:32:55 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALFWtLJ028275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 15:32:55 GMT
Received: from [10.216.11.95] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 21 Nov
 2023 07:32:45 -0800
Message-ID: <f742b95e-dd42-cbd3-61ef-d5255447ea4e@quicinc.com>
Date: Tue, 21 Nov 2023 21:02:41 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sa8775p: Mark PCIe EP controller
 as cache coherent
To: Johan Hovold <johan@kernel.org>
CC: <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <mani@kernel.org>, <robh+dt@kernel.org>,
        <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <robh@kernel.org>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <quic_parass@quicinc.com>, <quic_schintav@quicinc.com>,
        <quic_shijjose@quicinc.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
References: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com>
 <1700577493-18538-4-git-send-email-quic_msarkar@quicinc.com>
 <ZVzE0c8UsW4HXV_u@hovoldconsulting.com>
Content-Language: en-US
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <ZVzE0c8UsW4HXV_u@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l0e2n5NgW5BvyY1OBQPcD9ZbpGR_564t
X-Proofpoint-ORIG-GUID: l0e2n5NgW5BvyY1OBQPcD9ZbpGR_564t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_09,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1011
 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=993
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210121


On 11/21/2023 8:25 PM, Johan Hovold wrote:
> On Tue, Nov 21, 2023 at 08:08:13PM +0530, Mrinmay Sarkar wrote:
>> The PCIe EP controller on SA8775P supports cache coherency, hence add
>> the "dma-coherent" property to mark it as such.
>>
>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sa8775p.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> index 7eab458..ab01efe 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> @@ -3620,6 +3620,7 @@
>>   				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
>>   		interconnect-names = "pcie-mem", "cpu-pcie";
>>   
>> +		dma-coherent;
>>   		iommus = <&pcie_smmu 0x0000 0x7f>;
>>   		resets = <&gcc GCC_PCIE_0_BCR>;
>>   		reset-names = "core";
> What tree is this against?
>
> Both controllers are already marked as dma-coherent in mainline so this
> patch makes no sense (and the context also looks wrong).
>
> It was even you added them apparently:
>
> 	489f14be0e0a ("arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes")
>
> Johan
Hi Johan,

Yes both the RC controllers are dma-coherent and this change is for
PCIe EP controller and it is inside pcie0_ep node.
Actually the pcie0_ep node change is yet to apply on linux next.
I just made this change on top of that and the same I mentioned in
cover letter.

https://lore.kernel.org/all/1699669982-7691-6-git-send-email-quic_msarkar@quicinc.com/

Thanks,
Mrinmay

