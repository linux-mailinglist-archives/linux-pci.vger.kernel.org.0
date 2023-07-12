Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B34074FE98
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 07:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGLFII (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 01:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjGLFIH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 01:08:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C53F0;
        Tue, 11 Jul 2023 22:08:05 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C3wseK027784;
        Wed, 12 Jul 2023 05:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dCnyi4x/006EB36CO8CTR21nQ9r+xvXsqaHQF3fs9kM=;
 b=mU8E+95h3zz70v9T/NUyHIb0m+hRW/vZdwOBwdq0ZafkpJQHqxk8gZ/O0fvMqfS8ns4G
 P+zeQqHYlZdyc/BnAoSU6/dR7OcWw9M1TetQyrNlQ1/1M2T0y1gCA9IARwInb8ZgII2m
 YtvslJ3HY+IizCgJhNiijpWpSbAiTC+KXpLh+X47Jri6Xr0YVjSXLR3ApFuBqytXDkez
 vB31d2DfzhKaD17gSD4KAva1yCJYHNipzRH7+smsOrsqIzpj69KY3bVqe3aPeLLlx68n
 06UirMhfrlBrZnZ4n527Et+vEKe3A8dkV+DiP6t1W09wPSdR1ewB5uWunUJSrduKadvJ gg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsf51gku0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 05:08:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36C581Aa004676
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 05:08:01 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 22:07:57 -0700
Message-ID: <db0623b0-b6a3-cc09-f5ac-24e7499d4109@quicinc.com>
Date:   Wed, 12 Jul 2023 10:37:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v7 0/3] PCI: qcom: ep: Add basic interconnect support
Content-Language: en-US
To:     <manivannan.sadhasivam@linaro.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>
References: <1688099123-28036-1-git-send-email-quic_krichai@quicinc.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <1688099123-28036-1-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jqVPe2QRmsUoNyMVgPhCH5gOT206ICWF
X-Proofpoint-GUID: jqVPe2QRmsUoNyMVgPhCH5gOT206ICWF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_02,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 mlxlogscore=759 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120044
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

A gentle ping.


Thanks,

KC

On 6/30/2023 9:55 AM, Krishna chaitanya chundru wrote:
> Add basic support for managing "pcie-mem" interconnect path by setting
> a low constraint before enabling clocks and updating it after the link
> is up based on link speed and width the device got enumerated.
>
> chnages from v6:
> 	- addressed the comments as suggested by mani.
> changes from v5:
>          - addressed the comments by mani.
> changes from v4:
>          - rebased with linux-next.
>          - Added comments as suggested by mani.
>          - removed the arm: dts: qcom: sdx55: Add interconnect path
>            as that patch is already applied.
> changes from v3:
>          - ran make DT_CHECKER_FLAGS=-m dt_binding_check and fixed
>           errors.
>          - Added macros in the qcom ep driver patch as suggested by Dmitry
> changes from v2:
>          - changed the logic for getting speed and width as suggested
>           by bjorn.
>          - fixed compilation errors.
>
>
> Krishna chaitanya chundru (3):
>    dt-bindings: PCI: qcom: ep: Add interconnects path
>    arm: dts: qcom: sdx65: Add PCIe interconnect path
>    PCI: qcom-ep: Add ICC bandwidth voting support
>
>   .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 13 ++++
>   arch/arm/boot/dts/qcom/qcom-sdx65.dtsi             |  3 +
>   drivers/pci/controller/dwc/pcie-qcom-ep.c          | 71 ++++++++++++++++++++++
>   3 files changed, 87 insertions(+)
>
