Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F4D7D81D9
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 13:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjJZLe5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 07:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjJZLe4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 07:34:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A781AA;
        Thu, 26 Oct 2023 04:34:53 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QAmBFV024823;
        Thu, 26 Oct 2023 11:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0RykzLAc2GcpRBB2lxRtT9xw9T54D6XSLPdU1P03Ecg=;
 b=TUbPLcJRU3NeutpppwPr/hqOUndGtWyqtZHchUg2fabbywTsyxW8B99C7mgCpMzrNbIZ
 dKhnFNYGtMhT60D5ZYxeqNgXEuvmpX9A23EOvRFASJbQ1ewVYmhos3ywrD9lNaz0h7xK
 1xtRZKMT5Cg0DsJtKNQEfvo3ylCuHQ3UASiRh13i7d/bvygPfZ9d7UojdHKByEq3FITY
 ebT3JCUvSuHRnCXYweEBbcTxe9W6oBrUPT44ZARfj/Iy27KWYRTDeWagWbMJwh6gXG0o
 ly4OEBtHmlLj+3IAyOf/Ndg+0tVl0XKIZ6J1tsKaorxlTLC+8uLoFjDgPrBtuPdoCjVI /Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tykw28gme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 11:34:37 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39QBYaIs014795
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 11:34:36 GMT
Received: from [10.216.45.182] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 26 Oct
 2023 04:34:27 -0700
Message-ID: <b9fb5970-633b-07f0-4359-09fe8204bbf8@quicinc.com>
Date:   Thu, 26 Oct 2023 17:04:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 4/5] PCI: epf-mhi: Add support for SA8775P
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <robh@kernel.org>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <quic_parass@quicinc.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-phy@lists.infradead.org>
References: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com>
 <1697715430-30820-5-git-send-email-quic_msarkar@quicinc.com>
 <20231025075603.GD3648@thinkpad>
 <610b0621-b140-ee9b-c450-0fec6862c4fc@quicinc.com>
 <fb0647b5-67c4-4558-ac41-ee2b21446ee2@linaro.org>
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <fb0647b5-67c4-4558-ac41-ee2b21446ee2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I9bXBXL35wkZTwKQbllTp6Iof-QEowRZ
X-Proofpoint-GUID: I9bXBXL35wkZTwKQbllTp6Iof-QEowRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_09,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=679 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260098
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/26/2023 4:40 PM, Konrad Dybcio wrote:
>
>
> On 10/26/23 07:30, Mrinmay Sarkar wrote:
>>
>> On 10/25/2023 1:26 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Oct 19, 2023 at 05:07:09PM +0530, Mrinmay Sarkar wrote:
>>>> Add support for Qualcomm Snapdragon SA8775P SoC to the EPF driver.
>>>> SA8775P has the PID (0x0306) and supports HDMA. Currently, it has
>>> Is the PID fixed? I thought you just want to reuse the SDXxx PID in the
>>> meantime.
>>>
>>> - Mani
>>
>> The PID for SA8775p EP is not decided yet. So using 0x0306 PID meantime.
> If it's not decided, why should it go upstream then? Would that
> not break the hosts' expectations when the EP device is updated?
>
> Konrad

I don't think it will break the host's functionality. In host side as 
well we are reusing same 0x0306 for SA8775p

--Mrinmay

