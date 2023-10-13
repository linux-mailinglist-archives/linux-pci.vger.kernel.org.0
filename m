Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CF47C8632
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 14:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjJMMzu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 08:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjJMMzt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 08:55:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D11EBD;
        Fri, 13 Oct 2023 05:55:47 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DCccdv010169;
        Fri, 13 Oct 2023 12:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=content-type :
 message-id : date : mime-version : subject : to : cc : references : from :
 in-reply-to; s=qcppdkim1; bh=TIpzwHUlm0XyKhb3N7/UqxLWrvM+Qqn6q9nCmqR9/lg=;
 b=CEYa9tFU56Kse7B+LGX6g+xPmkJkeLIa06NAi00QdNKslB3DiAyXhykvgGcoUOEZg1tl
 u/i/KHWQxoKecGSJlADEuUtL8eWKGHHSeky2rTMSGO211RGd0HslnPu5xXmR2YPVDth0
 G/NB1hSiHh9uPEy333FsmsmhwSc2034SUFuTrv04IZnT2HqJBIaGH0W1bb7jr+wl+W7j
 BAGx47gnBMgaDCoteOdwK1u2LKvIOXftsc8NU/fe23C/2B1y9VXDZNRZ76TsEuGksjlW
 YTxETgpKrssfoomNvQgjKbDAU+r7H8KzpbpNk7LcXLJleCnD5BE1m8x/LchVU4rSbnRO 3w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt109pyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 12:55:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39DCtLgl018204
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 12:55:21 GMT
Received: from [10.216.5.96] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 13 Oct
 2023 05:55:13 -0700
Content-Type: multipart/mixed;
        boundary="------------ZNobSidDYvRu5ncOSVPtVLPy"
Message-ID: <31e6aab6-73f9-a421-9dfa-292d9d0e9649@quicinc.com>
Date:   Fri, 13 Oct 2023 18:25:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/5] dt-bindings: PCI: qcom-ep: Add support for SA8775P
 SoC
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Shazad Hussain <quic_shazhuss@quicinc.com>,
        Rob Herring <robh@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <konrad.dybcio@linaro.org>,
        <mani@kernel.org>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <quic_parass@quicinc.com>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-phy@lists.infradead.org>
References: <1695218113-31198-1-git-send-email-quic_msarkar@quicinc.com>
 <1695218113-31198-2-git-send-email-quic_msarkar@quicinc.com>
 <20230921183850.GA762694-robh@kernel.org>
 <28bf111f-b965-4d38-884b-bc3a0b68a6cc@quicinc.com>
 <8effa7e5-a223-081b-75b8-7b94400d42e6@quicinc.com>
 <CAA8EJpp+3_A-9YXF1yOKdFweVKqrpTxvxKoJcUH6qiDHfCQ-dQ@mail.gmail.com>
Content-Language: en-US
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <CAA8EJpp+3_A-9YXF1yOKdFweVKqrpTxvxKoJcUH6qiDHfCQ-dQ@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gn8rg2bmuizGTtF4737rnU2JxHoazBKc
X-Proofpoint-ORIG-GUID: gn8rg2bmuizGTtF4737rnU2JxHoazBKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_04,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130107
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--------------ZNobSidDYvRu5ncOSVPtVLPy
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 10/11/2023 5:13 PM, Dmitry Baryshkov wrote:
> On Wed, 11 Oct 2023 at 14:14, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>>
>> On 10/6/2023 4:24 PM, Shazad Hussain wrote:
>>>
>>> On 9/22/2023 12:08 AM, Rob Herring wrote:
>>>> On Wed, Sep 20, 2023 at 07:25:08PM +0530, Mrinmay Sarkar wrote:
>>>>> Add devicetree bindings support for SA8775P SoC.
>>>>> Define reg and interrupt per platform.
>>>>>
>>>>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>>>>> ---
>>>>>    .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 130
>>>>> +++++++++++++++++----
>>>>>    1 file changed, 108 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>>>>> b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>>>>> index a223ce0..e860e8f 100644
>>>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
>>>>> @@ -13,6 +13,7 @@ properties:
>>>>>      compatible:
>>>>>        oneOf:
>>>>>          - enum:
>>>>> +          - qcom,sa8775p-pcie-ep
>>>>>              - qcom,sdx55-pcie-ep
>>>>>              - qcom,sm8450-pcie-ep
>>>>>          - items:
>>>>> @@ -20,29 +21,19 @@ properties:
>>>>>              - const: qcom,sdx55-pcie-ep
>>>>>        reg:
>>>>> -    items:
>>>>> -      - description: Qualcomm-specific PARF configuration registers
>>>>> -      - description: DesignWare PCIe registers
>>>>> -      - description: External local bus interface registers
>>>>> -      - description: Address Translation Unit (ATU) registers
>>>>> -      - description: Memory region used to map remote RC address space
>>>>> -      - description: BAR memory region
>>>>> +    minItems: 6
>>>>> +    maxItems: 7
>>>>>        reg-names:
>>>>> -    items:
>>>>> -      - const: parf
>>>>> -      - const: dbi
>>>>> -      - const: elbi
>>>>> -      - const: atu
>>>>> -      - const: addr_space
>>>>> -      - const: mmio
>>>>> +    minItems: 6
>>>>> +    maxItems: 7
>>>> Don't move these into if/then schemas. Then we are duplicating the
>>>> names, and there is no reason to keep them aligned for new compatibles.
>>>>
>>>> Rob
>>> Hi Rob,
>>> As we have one extra reg property (dma) required for sa8775p-pcie-ep,
>>> isn't it expected to be moved in if/then as per number of regs
>>> required. Anyways we would have duplication of some properties for new
>>> compatibles where the member numbers differs for a property.
>>>
>>> Are you suggesting to add the extra reg property (dma) in the existing
>>> reg and reg-names list, and add minItems/maxItems for all compatibles
>>> present in this file ?
> This is what we have been doing in other cases: if the list is an
> extension of the current list, there is no need to duplicate it. One
> can use min/maxItems instead.
Hi Dmitry

we have tried using min/maxItems rather than duplicating but somehow
catch up with some warnings in dt_bindings check

//local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb: 
pcie-ep@1c00000: reg: [[29360128, 12288], [1073741824, 3869], 
[1073745696, 200], [1073745920, 4096], [1073750016, 4096], [29372416, 
12288]] is too short//
//        from schema $id: 
http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
///local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb: 
pcie-ep@1c00000: reg-names: ['parf', 'dbi', 'elbi', 'atu', 'addr_space', 
'mmio'] is too short//
//        from schema $id: 
http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
///local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb: 
pcie-ep@1c00000: interrupts: [[0, 140, 4], [0, 145, 4]] is too short//
//        from schema $id: 
http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
///local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb: 
pcie-ep@1c00000: interrupt-names: ['global', 'doorbell'] is too short//
//        from schema $id: 
http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#//
/

//local/mnt/workspace/Mrinmay/lemans/next-20230914/linux-next/out/Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb: 
pcie-ep@1c00000: interrupt-names: ['global', 'doorbell'] is too short/

added the patch in attachment.

--Mrinmay

>>> -Shazad
>> Here we have defined reg and interrupt per platform as clocks is defined.
>>
>> -Mrinmay
>>
>
--------------ZNobSidDYvRu5ncOSVPtVLPy
Content-Type: text/plain; charset="UTF-8";
	name="0001-dt-bindings-PCI-qcom-ep-Add-support-for-SA8775P-SoC.patch"
Content-Disposition: attachment;
	filename*0="0001-dt-bindings-PCI-qcom-ep-Add-support-for-SA8775P-SoC.pat";
	filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSA1MjA2NTNhZTY5OTYzNjY5NDJmMjFhODk0MmI1ZDhhYzMzZTMwZWUzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNcmlubWF5IFNhcmthciA8cXVpY19tc2Fya2FyQHF1
aWNpbmMuY29tPgpEYXRlOiBGcmksIDEzIE9jdCAyMDIzIDE4OjA5OjU2ICswNTMwClN1Ympl
Y3Q6IFtQQVRDSF0gZHQtYmluZGluZ3M6IFBDSTogcWNvbS1lcDogQWRkIHN1cHBvcnQgZm9y
IFNBODc3NVAgU29DCgpBZGQgZGV2aWNldHJlZSBiaW5kaW5ncyBzdXBwb3J0IGZvciBTQTg3
NzVQIFNvQy4KClNpZ25lZC1vZmYtYnk6IE1yaW5tYXkgU2Fya2FyIDxxdWljX21zYXJrYXJA
cXVpY2luYy5jb20+Ci0tLQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3Fjb20scGNp
ZS1lcC55YW1sIHwgNzMgKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDcw
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9xY29tLHBjaWUtZXAueWFtbCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvcWNvbSxwY2llLWVwLnlhbWwKaW5k
ZXggYTIyM2NlMDI5Y2FiLi4wMGVlZjkyNjg1YTIgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvcWNvbSxwY2llLWVwLnlhbWwKKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9xY29tLHBjaWUtZXAueWFtbApA
QCAtMTMsOSArMTMsMTEgQEAgcHJvcGVydGllczoKICAgY29tcGF0aWJsZToKICAgICBvbmVP
ZjoKICAgICAgIC0gZW51bToKKyAgICAgICAgICAtIHFjb20sc2E4Nzc1cC1wY2llLWVwCiAg
ICAgICAgICAgLSBxY29tLHNkeDU1LXBjaWUtZXAKICAgICAgICAgICAtIHFjb20sc204NDUw
LXBjaWUtZXAKICAgICAgIC0gaXRlbXM6CisgICAgICAgICAgLSBjb25zdDogcWNvbSxzYTg3
NzVwLXBjaWUtZXAKICAgICAgICAgICAtIGNvbnN0OiBxY29tLHNkeDY1LXBjaWUtZXAKICAg
ICAgICAgICAtIGNvbnN0OiBxY29tLHNkeDU1LXBjaWUtZXAKIApAQCAtMjcsNiArMjksNyBA
QCBwcm9wZXJ0aWVzOgogICAgICAgLSBkZXNjcmlwdGlvbjogQWRkcmVzcyBUcmFuc2xhdGlv
biBVbml0IChBVFUpIHJlZ2lzdGVycwogICAgICAgLSBkZXNjcmlwdGlvbjogTWVtb3J5IHJl
Z2lvbiB1c2VkIHRvIG1hcCByZW1vdGUgUkMgYWRkcmVzcyBzcGFjZQogICAgICAgLSBkZXNj
cmlwdGlvbjogQkFSIG1lbW9yeSByZWdpb24KKyAgICAgIC0gZGVzY3JpcHRpb246IERNQSBy
ZWdpc3RlciBzcGFjZQogCiAgIHJlZy1uYW1lczoKICAgICBpdGVtczoKQEAgLTM2LDEzICsz
OSwxNCBAQCBwcm9wZXJ0aWVzOgogICAgICAgLSBjb25zdDogYXR1CiAgICAgICAtIGNvbnN0
OiBhZGRyX3NwYWNlCiAgICAgICAtIGNvbnN0OiBtbWlvCisgICAgICAtIGNvbnN0OiBkbWEK
IAogICBjbG9ja3M6Ci0gICAgbWluSXRlbXM6IDcKKyAgICBtaW5JdGVtczogNQogICAgIG1h
eEl0ZW1zOiA4CiAKICAgY2xvY2stbmFtZXM6Ci0gICAgbWluSXRlbXM6IDcKKyAgICBtaW5J
dGVtczogNQogICAgIG1heEl0ZW1zOiA4CiAKICAgcWNvbSxwZXJzdC1yZWdzOgpAQCAtNjAs
MTEgKzY0LDEzIEBAIHByb3BlcnRpZXM6CiAgICAgaXRlbXM6CiAgICAgICAtIGRlc2NyaXB0
aW9uOiBQQ0llIEdsb2JhbCBpbnRlcnJ1cHQKICAgICAgIC0gZGVzY3JpcHRpb246IFBDSWUg
RG9vcmJlbGwgaW50ZXJydXB0CisgICAgICAtIGRlc2NyaXB0aW9uOiBETUEgaW50ZXJydXB0
CiAKICAgaW50ZXJydXB0LW5hbWVzOgogICAgIGl0ZW1zOgogICAgICAgLSBjb25zdDogZ2xv
YmFsCiAgICAgICAtIGNvbnN0OiBkb29yYmVsbAorICAgICAgLSBjb25zdDogZG1hCiAKICAg
cmVzZXQtZ3Bpb3M6CiAgICAgZGVzY3JpcHRpb246IEdQSU8gdXNlZCBhcyBQRVJTVCMgaW5w
dXQgc2lnbmFsCkBAIC0xMjUsNyArMTMxLDEzIEBAIGFsbE9mOgogICAgICAgICAgICAgICAt
IHFjb20sc2R4NTUtcGNpZS1lcAogICAgIHRoZW46CiAgICAgICBwcm9wZXJ0aWVzOgotICAg
ICAgICBjbG9ja3M6CisgICAgICAgIHJlZzoKKyAgICAgICAgICBtYXhJdGVtczogNgorICAg
ICAgICAgIG1pbkl0ZW1zOiA2CisgICAgICAgIHJlZy1uYW1lczoKKyAgICAgICAgICBtYXhJ
dGVtczogNgorICAgICAgICAgIG1pbkl0ZW1zOiA2CisgICAgICAgICAgY2xvY2tzOgogICAg
ICAgICAgIGl0ZW1zOgogICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogUENJZSBBdXhpbGlh
cnkgY2xvY2sKICAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IFBDSWUgQ0ZHIEFIQiBjbG9j
awpAQCAtMTQzLDYgKzE1NSwxMiBAQCBhbGxPZjoKICAgICAgICAgICAgIC0gY29uc3Q6IHNs
YXZlX3EyYQogICAgICAgICAgICAgLSBjb25zdDogc2xlZXAKICAgICAgICAgICAgIC0gY29u
c3Q6IHJlZgorICAgICAgICBpbnRlcnJ1cHRzOgorICAgICAgICAgIG1heEl0ZW1zOiAyCisg
ICAgICAgICAgbWluSXRlbXM6IDIKKyAgICAgICAgaW50ZXJydXB0LW5hbWVzOgorICAgICAg
ICAgIG1heEl0ZW1zOiAzCisgICAgICAgICAgbWluSXRlbXM6IDMKIAogICAtIGlmOgogICAg
ICAgcHJvcGVydGllczoKQEAgLTE1Miw2ICsxNzAsMTMgQEAgYWxsT2Y6CiAgICAgICAgICAg
ICAgIC0gcWNvbSxzbTg0NTAtcGNpZS1lcAogICAgIHRoZW46CiAgICAgICBwcm9wZXJ0aWVz
OgorICAgICAgICBwcm9wZXJ0aWVzOgorICAgICAgICAgIHJlZzoKKyAgICAgICAgICAgIG1h
eEl0ZW1zOiA2CisgICAgICAgICAgICBtaW5JdGVtczogNgorICAgICAgICAgIHJlZy1uYW1l
czoKKyAgICAgICAgICAgIG1heEl0ZW1zOiA2CisgICAgICAgICAgICBtaW5JdGVtczogNgog
ICAgICAgICBjbG9ja3M6CiAgICAgICAgICAgaXRlbXM6CiAgICAgICAgICAgICAtIGRlc2Ny
aXB0aW9uOiBQQ0llIEF1eGlsaWFyeSBjbG9jawpAQCAtMTcyLDYgKzE5Nyw0OCBAQCBhbGxP
ZjoKICAgICAgICAgICAgIC0gY29uc3Q6IHJlZgogICAgICAgICAgICAgLSBjb25zdDogZGRy
c3Nfc2ZfdGJ1CiAgICAgICAgICAgICAtIGNvbnN0OiBhZ2dyZV9ub2NfYXhpCisgICAgICAg
IGludGVycnVwdHM6CisgICAgICAgICAgbWF4SXRlbXM6IDIKKyAgICAgICAgICBtaW5JdGVt
czogMgorICAgICAgICBpbnRlcnJ1cHQtbmFtZXM6CisgICAgICAgICAgbWF4SXRlbXM6IDMK
KyAgICAgICAgICBtaW5JdGVtczogMworCisgIC0gaWY6CisgICAgICBwcm9wZXJ0aWVzOgor
ICAgICAgICBjb21wYXRpYmxlOgorICAgICAgICAgIGNvbnRhaW5zOgorICAgICAgICAgICAg
ZW51bToKKyAgICAgICAgICAgICAgLSBxY29tLHNhODc3NXAtcGNpZS1lcAorICAgIHRoZW46
CisgICAgICBwcm9wZXJ0aWVzOgorICAgICAgICBwcm9wZXJ0aWVzOgorICAgICAgICByZWc6
CisgICAgICAgICAgbWF4SXRlbXM6IDcKKyAgICAgICAgICBtaW5JdGVtczogNworICAgICAg
ICByZWctbmFtZXM6CisgICAgICAgICAgbWF4SXRlbXM6IDcKKyAgICAgICAgICBtaW5JdGVt
czogNworICAgICAgICBjbG9ja3M6CisgICAgICAgICAgaXRlbXM6CisgICAgICAgICAgICAt
IGRlc2NyaXB0aW9uOiBQQ0llIEF1eGlsaWFyeSBjbG9jaworICAgICAgICAgICAgLSBkZXNj
cmlwdGlvbjogUENJZSBDRkcgQUhCIGNsb2NrCisgICAgICAgICAgICAtIGRlc2NyaXB0aW9u
OiBQQ0llIE1hc3RlciBBWEkgY2xvY2sKKyAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IFBD
SWUgU2xhdmUgQVhJIGNsb2NrCisgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBQQ0llIFNs
YXZlIFEyQSBBWEkgY2xvY2sKKyAgICAgICAgY2xvY2stbmFtZXM6CisgICAgICAgICAgaXRl
bXM6CisgICAgICAgICAgICAtIGNvbnN0OiBhdXgKKyAgICAgICAgICAgIC0gY29uc3Q6IGNm
ZworICAgICAgICAgICAgLSBjb25zdDogYnVzX21hc3RlcgorICAgICAgICAgICAgLSBjb25z
dDogYnVzX3NsYXZlCisgICAgICAgICAgICAtIGNvbnN0OiBzbGF2ZV9xMmEKKyAgICAgICAg
aW50ZXJydXB0czoKKyAgICAgICAgICBtYXhJdGVtczogMworICAgICAgICAgIG1pbkl0ZW1z
OiAzCisgICAgICAgIGludGVycnVwdC1uYW1lczoKKyAgICAgICAgICBtYXhJdGVtczogMwor
ICAgICAgICAgIG1pbkl0ZW1zOiAzCiAKIHVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UK
IAotLSAKMi4xNy4xCgo=

--------------ZNobSidDYvRu5ncOSVPtVLPy--
