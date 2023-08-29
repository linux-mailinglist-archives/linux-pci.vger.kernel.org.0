Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522A778C383
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 13:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjH2LmB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 07:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjH2Llq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 07:41:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F16109;
        Tue, 29 Aug 2023 04:41:44 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T8dqFR022525;
        Tue, 29 Aug 2023 11:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DlY/qdaNMNq10NKgO940HSDMhKIvZidjccSEt9cixBo=;
 b=WfURxchH4icrOif/hdnjAROC7S/dJWBbOmP6QgC78A9ErBsy7ynNp6h87FKCp7OGtItl
 0ZQ9x4I05S8hKJt9Yx0uKCDMCmBULHGJ6rRoa1f+HWn61uqxI1Babcw5Yin1YtX9eA4f
 Zvep/qv0WTxomrxJDq6DNIes2Q9JgjzkcVUHB4+Vw8505livFxqPQrW+6rxx6t/CF4/5
 ArKHDp55ZOxWDTCvqw0dwl1cveegvR7Bdk7NMjGmYVuQ4/MN3rlPvmoSs6J+n/wmQQdq
 c59FNrmf+zbXZJnvOvOPIIg9op7ZvbaOD/CDBhkTnutElDK+0es3hcq6Tj7N+/yHq+Bz uw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srvr82m7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 11:41:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TBfauJ029292
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 11:41:36 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 04:41:33 -0700
Message-ID: <b7f5d32f-6f1a-d584-4cdd-4c5faf08a72e@quicinc.com>
Date:   Tue, 29 Aug 2023 17:11:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v10 0/4] PCI: qcom: ep: Add basic interconnect support
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>
References: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
 <20230728025648.GC4433@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230728025648.GC4433@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z45AldLl8kvH5xeDZ5nSQidvm7T-B_WC
X-Proofpoint-ORIG-GUID: z45AldLl8kvH5xeDZ5nSQidvm7T-B_WC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_08,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=739 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308290101
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/28/2023 8:26 AM, Manivannan Sadhasivam wrote:
> On Wed, Jul 19, 2023 at 12:50:14PM +0530, Krishna chaitanya chundru wrote:
>> Add basic support for managing "pcie-mem" interconnect path by setting
>> a low constraint before enabling clocks and updating it after the link
>> is up based on link speed and width the device got enumerated.
>>
> Krzysztof, can this series be merged for 6.6? Bjorn A will pick the dts patches.
>
> - Mani

A Gentle ping

- KC

>> changes from v9:
>> 	- addressed the comments by mani.
>> changes from v8:
>>          - Added cpu to pcie path in dtsi and in dtsi binding.
>> changes from v7:
>>          - setting icc bw to '0' in disable resources as suggested by mani.
>> changes from v6:
>>          - addressed the comments as suggested by mani.
>> changes from v5:
>>          - addressed the comments by mani.
>> changes from v4:
>>          - rebased with linux-next.
>>          - Added comments as suggested by mani.
>>          - removed the arm: dts: qcom: sdx55: Add interconnect path
>>            as that patch is already applied.
>> changes from v3:
>>          - ran make DT_CHECKER_FLAGS=-m dt_binding_check and fixed
>>           errors.
>>          - Added macros in the qcom ep driver patch as suggested by Dmitry
>> changes from v2:
>>          - changed the logic for getting speed and width as suggested
>>           by bjorn.
>>          - fixed compilation errors.
>>
>>
>> Krishna chaitanya chundru (4):
>>    PCI: qcom-ep: Add ICC bandwidth voting support
>>    arm: dts: qcom: sdx65: Add PCIe EP interconnect path
>>    arm: dts: qcom: sdx55: Add CPU PCIe EP interconnect path
>>    dt-bindings: PCI: qcom: ep: Add interconnects path
>>
>>   .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 15 +++++
>>   arch/arm/boot/dts/qcom/qcom-sdx55.dtsi             |  5 +-
>>   arch/arm/boot/dts/qcom/qcom-sdx65.dtsi             |  4 ++
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c          | 71 ++++++++++++++++++++++
>>   4 files changed, 93 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.7.4
>>
