Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328117E1B07
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 08:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjKFHUN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 02:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjKFHUM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 02:20:12 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D5B13E;
        Sun,  5 Nov 2023 23:20:08 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A62N2qh026181;
        Mon, 6 Nov 2023 07:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aC6zXgw869lTHrTz2q1Yo1l+dKQQlLxl2PZT39ZpNHg=;
 b=Gl74fGqIeWQbO13NVWF1DuHBy8KIQpbQQOwBUWTJB6p/TKp9cMsxx6TBm8FsZDd3IzoR
 9a02N1XOnGJU5a6VV4iXMwwmubVghKiE6mgbRj8CY5vL2ryhIRVWP+j2hmqJO/PNQ3wL
 E03hublQYlY3Isq6Qzw5ithKmpfR9j2YudAceEK5V6EX9grd5zpp3eO2DmeFGnXVdUpT
 sN7sBkD1Z3e9l+peDyIUTTm3eQXJxXjIyeudRVrR3YFSh8dbNa1T9yuFiQGysHGP7TJ6
 HHp94PwN8tACa/fN+W3FJjTOPZsFEsYjl+rbPbDgExRwaIs0Cc9EDo7I0MukKPcbSaCe sg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5eg3uc3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 07:20:02 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A67K1Cj021668
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 07:20:01 GMT
Received: from [10.218.10.86] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 5 Nov
 2023 23:19:54 -0800
Message-ID: <cb4324aa-8035-ce6e-94ef-a31ed070225c@quicinc.com>
Date:   Mon, 6 Nov 2023 12:49:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <robh+dt@kernel.org>, <quic_shazhuss@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nayiluri@quicinc.com>, <robh@kernel.org>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <quic_parass@quicinc.com>, <quic_schintav@quicinc.com>,
        <quic_shijjose@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <1698767186-5046-1-git-send-email-quic_msarkar@quicinc.com>
 <1698767186-5046-2-git-send-email-quic_msarkar@quicinc.com>
 <CAA8EJpoMoUvF8R3PjgCNijS6-8Gs5FjvC6dYerNBVBuYW3FmPA@mail.gmail.com>
 <20231102163619.GA20943@thinkpad>
 <21dea74b-b802-2e69-af4b-07dfb68b7024@linaro.org>
 <20231103075849.GA3039@thinkpad>
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <20231103075849.GA3039@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nBfYums_2CFxZl6f7W_2mWNOmcznJ4fZ
X-Proofpoint-ORIG-GUID: nBfYums_2CFxZl6f7W_2mWNOmcznJ4fZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_05,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060063
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/3/2023 1:28 PM, Manivannan Sadhasivam wrote:
> On Thu, Nov 02, 2023 at 11:25:36PM +0100, Konrad Dybcio wrote:
>>
>> On 02/11/2023 17:36, Manivannan Sadhasivam wrote:
>>> On Thu, Nov 02, 2023 at 05:34:24PM +0200, Dmitry Baryshkov wrote:
>>>> On Tue, 31 Oct 2023 at 17:46, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>>>>> This change will enable cache snooping logic to support
>>>>> cache coherency for SA8755P RC platform.
>>>>>
>>>>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>>>>> ---
>>>>>    drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
>>>>>    1 file changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>>> index 6902e97..6f240fc 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>>> @@ -51,6 +51,7 @@
>>>>>    #define PARF_SID_OFFSET                                0x234
>>>>>    #define PARF_BDF_TRANSLATE_CFG                 0x24c
>>>>>    #define PARF_SLV_ADDR_SPACE_SIZE               0x358
>>>>> +#define PCIE_PARF_NO_SNOOP_OVERIDE             0x3d4
>>>>>    #define PARF_DEVICE_TYPE                       0x1000
>>>>>    #define PARF_BDF_TO_SID_TABLE_N                        0x2000
>>>>>
>>>>> @@ -117,6 +118,9 @@
>>>>>    /* PARF_LTSSM register fields */
>>>>>    #define LTSSM_EN                               BIT(8)
>>>>>
>>>>> +/* PARF_NO_SNOOP_OVERIDE register value */
>>>>> +#define NO_SNOOP_OVERIDE_EN                    0xa
>>>>> +
>>>>>    /* PARF_DEVICE_TYPE register fields */
>>>>>    #define DEVICE_TYPE_RC                         0x4
>>>>>
>>>>> @@ -961,6 +965,13 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>>>>>
>>>>>    static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>>>>>    {
>>>>> +       struct dw_pcie *pci = pcie->pci;
>>>>> +       struct device *dev = pci->dev;
>>>>> +
>>>>> +       /* Enable cache snooping for SA8775P */
>>>>> +       if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8775p"))
>>>> Obviously: please populate a flag in the data structures instead of
>>>> doing of_device_is_compatible(). Same applies to the patch 2.
>>>>
>>> Not necessary at this point. For some unknown reasons, the HW team ended up
>>> disabling cache snooping on this specific platform. Whereas on other platforms,
>>> it is enabled by default. So I have low expectations that we would need this
>>> setting on other platforms in the future.
>>>
>>> My concern with the usage of flag is that it warrants a new "qcom_pcie_cfg"
>>> instance just for this quirk and it looks overkill to me.
>>>
>>> So if we endup seeing this behavior on other platforms as well (unlikely) then
>>> we can switch to the flag approach.
>> This register reads zeroes on 8250, can we confirm it works as
>> expected there?
> I don't know if this register is even implemented in 8250. Mrinmay, can you
> check?
Yes we have this register in 8250 platform as well
and I can see the default value is 0x0.

--Mrinmay
>> I guess some benchmarks with and without
>> 'dma-coherent'?
>>
> The performance benefit can be measured by saturating the link. But it is
> obvious that snooping the cache will give better performance (plus it avoids
> cache flush in kernel).
>
> - Mani
>
