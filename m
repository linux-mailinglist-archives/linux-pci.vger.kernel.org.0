Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C0A77DAE7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 09:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242302AbjHPHGP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 03:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242315AbjHPHGK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 03:06:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40179BF;
        Wed, 16 Aug 2023 00:06:09 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37G6cApx006153;
        Wed, 16 Aug 2023 07:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=npvEtPS+ycTaepNqfNy8oXlhCmpyQC2OQsgZCW9B+G8=;
 b=IeYN/wOiGH0otS9cf0Yhn22U2vk6OKQkblH5ChcISRAJAogLLGUrXNl+CNAHHd24wC9+
 8XKMIiV9HHuq/0l0trl6Zd7+PJlQKfEjE0he2+0uXvBeC6sbuMJAAGM4kKFy+Qi7Rzf1
 +vm8HKS+Fwi1ZATtoGu5JZ18iEEXlR6q5tLajuSfzhiw71YhZl7IIXUEihbWh3L9Uaqe
 KyS5u3rhjzmnPASpyNzL36AYOe5ki85VeHO0a/zbbaOSWdkwYyG7XVuIxZ1Po2KAyJeX
 6b+AXM4nellQsCSG1azLooE39wqYYGfAbwjgTP3Jd54MegHtM6fp/t1Czea4zocCHi2l mQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfuj8k3x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 07:06:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37G7636s003603
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 07:06:03 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 16 Aug 2023 00:05:57 -0700
Date:   Wed, 16 Aug 2023 12:35:54 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_parass@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: sm8450: Add opp table support
 to PCIe
Message-ID: <dc14acb4-9fe8-4b3b-a9da-7f7915de4d5c@quicinc.com>
References: <1692102408-7010-1-git-send-email-quic_krichai@quicinc.com>
 <1692102408-7010-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1692102408-7010-3-git-send-email-quic_krichai@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rDErzUi5WBgE6QMXZM7TE95s7FWEECSZ
X-Proofpoint-GUID: rDErzUi5WBgE6QMXZM7TE95s7FWEECSZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_04,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxlogscore=878 bulkscore=0 impostorscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 15, 2023 at 05:56:47PM +0530, Krishna chaitanya chundru wrote:
> PCIe needs to choose the appropriate performance state of RPMH power
> domain based upon the PCIe gen speed.
> 
> So, let's add the OPP table support to specify RPMH performance states.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 47 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 595533a..681ea9c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -381,6 +381,49 @@
>  		};
>  	};
>  
> +	pcie0_opp_table: opp-table-pcie0 {
> +		compatible = "operating-points-v2";
> +
> +		opp-2500000 {
> +			opp-hz = /bits/ 64 <2500000>;
> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +		};
> +
> +		opp-5000000 {
> +			opp-hz = /bits/ 64 <5000000>;
> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +		};
> +
> +		opp-8000000 {
> +			opp-hz = /bits/ 64 <8000000>;
> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +		};
> +	};
> +
> +	pcie1_opp_table: opp-table-pcie1 {
> +		compatible = "operating-points-v2";
> +
> +		opp-2500000 {
> +			opp-hz = /bits/ 64 <2500000>;
> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +		};
> +
> +		opp-5000000 {
> +			opp-hz = /bits/ 64 <5000000>;
> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +		};
> +
> +		opp-8000000 {
> +			opp-hz = /bits/ 64 <8000000>;
> +			opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +		};
> +
> +		opp-16000000 {
> +			opp-hz = /bits/ 64 <16000000>;
> +			opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +		};
> +	};
> +

Should not we using required-opps property to pass the
rpmhpd_opp_xxx phandle so that when this OPP is selected based on your
clock rate, the appropriate OPP (voltage) would be selected on the RPMH side?

Please see SDHCI/MMC voting (sdhc2_opp_table) as an example.

Thanks,
Pavan
