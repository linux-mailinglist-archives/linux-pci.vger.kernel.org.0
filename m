Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31757F0FD6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 11:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjKTKH1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 05:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjKTKHP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 05:07:15 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BCA118;
        Mon, 20 Nov 2023 02:07:08 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK9a2mg031485;
        Mon, 20 Nov 2023 10:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8XNRTI3wuGd4bf5ULCxy9o5QTqPSUb8wRanCjXpoxCg=;
 b=UGzWZYy6jso/o0gUOyLQVkzgpQ8GTShn4455r+cJQ4SvScoPKKVjr8ufR5gvY2uUzBIH
 Z+tsjzOHq8ZBUPwO5xL2zCjQTLheWKVSBavddKygR7Dbr495aX1IpvP3NXJD73jMPKq+
 HSDpve5STvFPDWo7EtVQ1RnBHh5lq3yLzskkycpCS540P7+f6hIE2v5sSSH3kz4cmH28
 bP7R+XGQiWvsDKiDyhpi7on00f69MuPJMPjptMiOv1A14lAt2dsywKUfLvJwoSr3gWOQ
 F33JdSTYXQAJgEkrEaynXJ0eTGzqiRjBfWWGR69pHKOJ78+OOaRomVAgcjWk73q2KSbS dw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug2ax8gme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:06:52 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKA6plj004941
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:06:51 GMT
Received: from [10.218.10.86] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 02:06:43 -0800
Message-ID: <5eae728f-f052-f2aa-7876-cb2421191fc9@quicinc.com>
Date:   Mon, 20 Nov 2023 15:36:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 0/5] arm64: qcom: sa8775p: add support for EP PCIe
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <mani@kernel.org>, <robh+dt@kernel.org>
CC:     <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <robh@kernel.org>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <quic_parass@quicinc.com>, <quic_schintav@quicinc.com>,
        <quic_shijjose@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mhi@lists.linux.dev>
References: <1699669982-7691-1-git-send-email-quic_msarkar@quicinc.com>
Content-Language: en-US
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <1699669982-7691-1-git-send-email-quic_msarkar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2-nfT9vuu7uZY3tK0yJaMkHsOmhBRX83
X-Proofpoint-ORIG-GUID: 2-nfT9vuu7uZY3tK0yJaMkHsOmhBRX83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_08,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=823 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311200068
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some of the patches are reviewed. Please apply in linux-next.

Thanks,
Mrinmay

On 11/11/2023 8:02 AM, Mrinmay Sarkar wrote:
> This series adds the relavent DT bindings, new compatible string,
> add support to EPF driver and add EP PCIe node in dtsi file for
> ep pcie0 controller.
>
> v7 -> v8:
> - Add new patch PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function
>    names
> - Update PCI: epf-mhi: Add support for SA8775P patch on top of the new
>    patch and update commit message.
>
> v6 -> v7:
> - add reviewed by tag in commit message in all patches.
> - update commit message in patch 2 as per comment.
> - update reason for reusing PID in commit message.
>
> v5 -> v6:
> - update cover letter.
>
> v4 -> v5:
> - add maxItems to the respective field to constrain io space and
>    interrupt in all variants.
>
> v3 -> v4:
> - add maxItems field in dt bindings
> - update comment in patch2
> - dropped PHY driver patch as it is already applied [1]
> - update comment in EPF driver patch
> - update commect in dtsi and add iommus instead of iommu-map
>
> [1] https://lore.kernel.org/all/169804254205.383714.18423881810869732517.b4-ty@kernel.org/
>
> v2 -> v3:
> - removed if/then schemas, added minItems for reg,
>    reg-bnames, interrupt and interrupt-names instead.
> - adding qcom,sa8775p-pcie-ep compitable for sa8775p
>    as we have some specific change to add.
> - reusing sm8450's pcs_misc num table as it is same as sa8775p.
>    used appropriate namespace for pcs.
> - remove const from sa8775p_header as kernel test robot
>    throwing some warnings due to this.
> - remove fallback compatiable as we are adding compatiable for sa8775p.
>
> v1 -> v2:
> - update description for dma
> - Reusing qcom,sdx55-pcie-ep compatibe so remove compaitable
>    for sa8775p
> - sort the defines in phy header file and remove extra defines
> - add const in return type pci_epf_header and remove MHI_EPF_USE_DMA
>    flag as hdma patch is not ready
> - add fallback compatiable as qcom,sdx55-pcie-ep, add iommu property
>
>
> Mrinmay Sarkar (5):
>    dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
>    PCI: qcom-ep: Add support for SA8775P SOC
>    PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function names
>    PCI: epf-mhi: Add support for SA8775P
>    arm64: dts: qcom: sa8775p: Add ep pcie0 controller node
>
>   .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 64 +++++++++++++++++++++-
>   arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 46 ++++++++++++++++
>   drivers/pci/controller/dwc/pcie-qcom-ep.c          |  1 +
>   drivers/pci/endpoint/functions/pci-epf-mhi.c       | 21 ++++++-
>   4 files changed, 128 insertions(+), 4 deletions(-)
>
