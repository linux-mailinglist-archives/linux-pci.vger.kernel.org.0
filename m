Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB487301C0
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbjFNOZt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jun 2023 10:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbjFNOZs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2023 10:25:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D9F1BC3;
        Wed, 14 Jun 2023 07:25:46 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35ECT6Re030760;
        Wed, 14 Jun 2023 14:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FpQu4Js6vqOdkzbv0j34KMlbmoXThDPhRdZIxA/yt9E=;
 b=I7lWzdUEH6MlkmtERvG3IhfK/fIfLYuvy+I1QJJq3Qv+VJL/4eBjwFPTWsefSKK48Cp2
 MucGgqj0V43nQh9b8oGKsEILKs1DQIcQNRqRJpJRbmcild68sh+kMq9wQyMxzFRaOGVU
 Sfy5urh/r/RxuCJc6hujXLGiEVXQ7BgqeiliDWpW4vh+XP/ON6A+jPNw2W0Bq9HI4UaP
 fONObxOu5VQQOZm5saVrfvlpxaRLFLq5eS4sWs/qMycpBdyqsyC+52FDGljCigqDuFoq
 7RLaXWXmlOI8OEFz4qVGbDoiTqsKlRSk6I+RQ4CO0DBYl/2Ic+W5c88R0jY4kozVgddP gg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7b818mu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 14:25:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EEPdaS004256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 14:25:39 GMT
Received: from [10.216.59.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 14 Jun
 2023 07:25:33 -0700
Message-ID: <9675298d-3375-b603-d012-7c9cdc61daed@quicinc.com>
Date:   Wed, 14 Jun 2023 19:55:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/3] dt-bindings: PCI: qcom: ep: Add interconnects path
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <devicetree@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <1686311249-6857-1-git-send-email-quic_krichai@quicinc.com>
 <1686311249-6857-2-git-send-email-quic_krichai@quicinc.com>
 <168631638078.662811.2470035951687478762.robh@kernel.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <168631638078.662811.2470035951687478762.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xnqMGFMYAXiXMP3oZ4cWi_zrkfbfB0pu
X-Proofpoint-GUID: xnqMGFMYAXiXMP3oZ4cWi_zrkfbfB0pu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxlogscore=918 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140125
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/9/2023 6:43 PM, Rob Herring wrote:
> On Fri, 09 Jun 2023 17:17:26 +0530, Krishna chaitanya chundru wrote:
>> Some platforms may not boot if a device driver doesn't initialize
>> the interconnect path. Mostly it is handled by the bootloader but
>> we have starting to see cases where bootloader simply ignores them.
>>
>> Add the "pcie-mem" interconnect path as a required property to the
>> bindings.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml:206:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
>
> dtschema/dtc warnings/errors:
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dts'
> Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml:206:1: found a tab character where an indentation space is expected
> make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml:206:1: found a tab character where an indentation space is expected
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml: ignoring, error parsing file
> make: *** [Makefile:1512: dt_binding_check] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1686311249-6857-2-git-send-email-quic_krichai@quicinc.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>
sorry for sending the patch without checking the patch. fixed the errors 
and sent new patch
