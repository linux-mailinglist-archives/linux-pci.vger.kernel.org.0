Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD065ACC69
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 09:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbiIEHZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 03:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbiIEHZg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 03:25:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FAE40BE6;
        Mon,  5 Sep 2022 00:22:44 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2855e1qP007005;
        Mon, 5 Sep 2022 07:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kubCKYLJeUMpMSD/hRdOyYdxZyH84wz7YEGced83hJE=;
 b=b1eYvakBepUCkBmNZWZSmh7v8zKKxZQfWzw0LXkt+bYjaOOf79Ouu7SNNHjRqMcIkwOR
 bzz3F0MgD6b3IIvQRvI5+97oivM+ybV/zBXdxpb3IiJvnU3zbG3wGcQH3xgg0Ui8AxCk
 q0G+B43oibJPfc5lWknkz5i1yMiOdemF9kGkQmlKyov/vRnPUPRsKwF/I7yJc1O+48GY
 M+N9r61zwGp4C0eQjjZihqP+/VPK6k4AcBWcn3HWeo4jUjEIWrpfzxC+efsIzPPWN+r2
 hSGWWoGWOfF3Lk9uxC120cvoMtSFTCDJ39wVh/G6dx53sKF9eixp6/TxR9Q4BGU44TUF 7g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jbypmkd82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 07:21:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2857LQXJ003272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Sep 2022 07:21:26 GMT
Received: from [10.50.47.247] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 5 Sep 2022
 00:21:17 -0700
Message-ID: <3af38280-c94b-e5ef-7a66-4869b1f36a30@quicinc.com>
Date:   Mon, 5 Sep 2022 12:51:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 2/3] PCI: qcom: Restrict pci transactions after pci
 suspend
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Krishna Chaitanya Chundru" <quic_krichai@quicinc.com>
CC:     Stephen Boyd <swboyd@chromium.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
References: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
 <1659526134-22978-3-git-send-email-quic_krichai@quicinc.com>
 <CAE-0n500y-n+ZjasYQRAa3JgamQG1c+Aqn0YiX-i0L-w6C4dbQ@mail.gmail.com>
 <3d052733-3600-b6eb-baf3-d8806a150af3@quicinc.com>
 <CAE-0n53oMnnn7rOPEiibc=XM52z9THDc9jYhe3x3C_AsLtmARQ@mail.gmail.com>
 <81dcbf72-92bb-093a-da48-89a73ead820e@quicinc.com>
 <CAE-0n50NRiBNDjK2UrA_wOoRz3+3cKb4uiUiCw4t1F19Kw9EhA@mail.gmail.com>
 <20220827172655.GA14465@thinkpad>
 <a1b7c47c-9657-54bb-6b4e-1d98b3a65b91@quicinc.com>
 <20220830115514.GD135982@thinkpad>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220830115514.GD135982@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rUhb-i1K1UpPaAIekJeyIwhdi64bYleT
X-Proofpoint-GUID: rUhb-i1K1UpPaAIekJeyIwhdi64bYleT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_05,2022-09-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=910
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050035
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/30/2022 5:25 PM, Manivannan Sadhasivam wrote:

<SNIP>...

>> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
>> index 21b3ac2a29d2..042afec1cf9d 100644
>> --- a/kernel/irq/irqdesc.c
>> +++ b/kernel/irq/irqdesc.c
>> @@ -487,8 +487,9 @@ static int alloc_descs(unsigned int start, unsigned int
>> cnt, int node,
>>
>>
>>
>>                 if (affinity) {
>>                          if (affinity->is_managed) {
>> -                               flags = IRQD_AFFINITY_MANAGED |
>> -                                       IRQD_MANAGED_SHUTDOWN;
>> +//                             flags = IRQD_AFFINITY_MANAGED |
>> +//                                     IRQD_MANAGED_SHUTDOWN;
>> +                               flags = 0;//IRQD_AFFINITY_MANAGED |
>>                          }
>>                          mask = &affinity->mask;
>>                          node = cpu_to_node(cpumask_first(mask));
>>
> The only solution I can think of is keeping the clocks related to DBI access
> active or switch to another clock source that consumes less power if available
> during suspend.
>
> But limiting the DBI access using hacks doesn't look good.

Why not just define "irq_startup and irq_shutdown" callbacks for dw_pcie_msi_irq_chip?
So when the cpu is offlined and irq_shutdown is called for that irqchip in migrate_one_irq(),
you would mask the irq and then disable the clocks. Similarly, on CPU onlining, you would
enable the clocks and unmask the irq. This way XO is still achieved as you are turning off
the clocks before suspend and back on after resume.

Thanks,
Sai


