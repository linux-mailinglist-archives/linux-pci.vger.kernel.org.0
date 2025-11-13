Return-Path: <linux-pci+bounces-41065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CF4C561BE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 08:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CFAF346F6E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 07:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3104732F76B;
	Thu, 13 Nov 2025 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bUev4afq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="evpGfOT4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3BD32F74B
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020100; cv=none; b=lrhsU/N4uehl05186dZ2N5EmiS/jle5I1tTN2Vd+vQx8NagNxg6n9gDEcr395f64bMWpVnp182PBDetu/P7jLct8+vGiRQ0s1V+XyChiS8AkXkFw+mCyycvVI8rP86/xIV6SD5SEu78QnZnwGIA8EcXFtQTZM7lY7k8ZiFy7pAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020100; c=relaxed/simple;
	bh=vFb2M/nGxgnEBD9w5S2ekv3idrtEuY3kFjlfebSCyeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6o4qx9ZKDXPHPLYGqa4gKhv4LlMRx+e7sGdAzPhyVB6FcOBGgznnD/Ogy5GX37TKyvA32SjsPKRxaQNhVPpgm3QmM+MivEjRq8KzYM3b7SAMRXQEgQdGi3iw22QfRCd00jVKzF1Pd+30KNkHzjmpcyKLZRRDDZaZO2v+V10pvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bUev4afq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=evpGfOT4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD1SHmU3120385
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 07:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZhJiozGc7U8ZGJ8uF2XWeIPBKlSbzOs14hlPqFLDlL0=; b=bUev4afqfG1rIKXk
	adLozXY4vwGey3rmYhB7jvaFd4QdWpywYz0fC2ZUySlVflX6gn5Kk3rrMnw+5Qg+
	T6UJV396b3J+dRotjg2muurlmmslNjiTZxLPY4QNOP6T4KjJIfxGEQ1IDtqSIm9+
	+HqWEZA7ZOQUmw8ta6QjliNsBVHuWoQO74XEGqQ9973z7QavTew8F4ik2hLgiROC
	0kI/ZJM4aSgNA8zR0tXJ3R4AjfR59nTGdlqoQ9T6RDYgeMcR38/tFR5VipCDGm+Y
	aFO0MwvDpyLyD4436+u6cO2ah4LtDYie4ybWLK5FyA9N9oQWXAjHZBiw2PGkqxIU
	bAYq2Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad5pus03s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 07:48:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-bc349a8a3easo479871a12.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 23:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763020091; x=1763624891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhJiozGc7U8ZGJ8uF2XWeIPBKlSbzOs14hlPqFLDlL0=;
        b=evpGfOT4PWoMD+LQj99PQtAObLm89GzULZm1xLVaIjrCzyTewg2DL12hyufRmgsQDA
         ypQjbeONOFFY9OJXMh5z8UWmri0T0BnNgZjaApT26r2wsqdnNgy6uhPno4Oyi1LQDy2Q
         +pBtive8gHlyIo8ZMPYhodGw6R0zWSsfgaTPopsOoh/Nh+RBmNO1JeBKe/0MfsPxZ0I2
         ZaFQXZ5Nd8zABm9mbb8AaeWZq6WIFyUQoTxWcZbm8i/PB7PA+ads6SAigF6ZAILKpj/h
         07QBTVCQp5dhQJ9MqqNPMG8jV6Bbup/eyt/myMjJuBZiCJYJg8TGlcyP7Cy4P/ijS2ee
         SBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763020091; x=1763624891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhJiozGc7U8ZGJ8uF2XWeIPBKlSbzOs14hlPqFLDlL0=;
        b=ObJvXvM5Khr0IOXPAcDPLbyb4Slde4+s6vVuHQnvvrVWCQkLCoI2ngNzJEZry0pkPl
         DuthsH15tH0XmdUOve6jTO5ve5exBk9tSDqFpYDnu2n4/3fODsi8NlKsaNXruwBh9fzo
         4F2Qa08Jg/ayBAUIqInegSvaXULqyBa0ilowHHS70CFDooztHJ5qgHxdHlr7uBazQE4Z
         aWl4cZcojaE2ulhecWFbD6MUizJRxgFM8k86UwGxoLogh4l5oWn0JEuIN1X7LWTKE6Or
         EhiQUY66AOJZ4dW7GNosolC2UDXrF8lWB4JMT/dehWTHBkeGML0hDbMoFQb5CTzQVtNO
         FyNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0oT1DLtgh8T2ZyhXry65bg9dltVE7IMbhAHVwIVYsy+zSYM6B/dzyIpUgj4oGCZOFtCYScbbxlIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdD3TiGfwecIpyLp6NcryV63mhVxrShZT3Rj9p4xvLe+lew9h2
	YYjF72CeOb+SYIvu/e1kDixk4mUUrQuiOP92PJnWDoqHo08nGIOIp2P1TuGmabDlbEx89KdBYCC
	hYgf/ieb2HUn4C/O44P97Rtlo+xZMEDhJ3ILHxN8uJAsHRGFQ/D0xGOh+xJRGt8c=
X-Gm-Gg: ASbGncsd26/nDQQ9o4ur4bidpp+lr0a/yfCs2zDDq2v2fT8MLUjnbZUboRDZQDbHjPf
	mLeDlSh8WqSr6VZcnWyRuhP8SdxLnliSXHyTB5gx3u6jR49xBSR+pi0AXzXJJScef4ibhven3LA
	+iGi5U5iFH6K2PhVk3SsZwXY1Y4LEw3AWs1GhvyU6OCQ0y4TebDSC+Df7wCC9ssZogJSa0qUsjX
	Q8rF94ygkugUFg83djL/PUucKJmGAZx71hKEUMswIWrCiYENj4PyGOWmhTxDKYOfC9k1oDnqlMI
	KPOlZwUG6HBcY6kF3qWKB+Wb1VgpIv44ZACrT/LoPSo/5HPLoqiqMWxIGxk3uUXm8xTsjCRyGXh
	W1FQVBZuU/O0ZvDUi84Z1rMs7Wo2N0GU=
X-Received: by 2002:a17:902:ebc6:b0:298:495c:1bf0 with SMTP id d9443c01a7336-2984edd2700mr69775685ad.44.1763020091155;
        Wed, 12 Nov 2025 23:48:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8rRkEuWW/6gSHvrkhgOhcnbTpcGFokK+8H6N4ylsRW3aMFxk3k4phtF2p1olCGtMTmr/Plw==
X-Received: by 2002:a17:902:ebc6:b0:298:495c:1bf0 with SMTP id d9443c01a7336-2984edd2700mr69775255ad.44.1763020090661;
        Wed, 12 Nov 2025 23:48:10 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed5asm15548045ad.88.2025.11.12.23.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 23:48:10 -0800 (PST)
Message-ID: <9dbae7ca-b24f-4591-99cf-7720ace6a452@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 13:18:04 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] schemas: pci: Document PCIe T_POWER_ON
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: andersson@kernel.org, robh@kernel.org, krzk@kernel.org, helgaas@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com
References: <20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com>
 <gqvc3orlyk6l5jq2bpxsf5lvvafmtxcpdquffcpdqdiek3bldh@l3em25rqaldg>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <gqvc3orlyk6l5jq2bpxsf5lvvafmtxcpdquffcpdqdiek3bldh@l3em25rqaldg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69158d3b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=5gsRW-pyyPTur7QFVg0A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA1NCBTYWx0ZWRfX72N7qjXak4W0
 dlK6Ye0p6CASENt09hpspehEWIbXR/bBfB/N7WLJLtxeqR9TWkdKpymkWNYEDhP1yH+txmabCvh
 40YwZdpjQhH8KJxcPqvgBjLWMRjfERY4yg0wqbjeztRPRnHWym5Q5iTBr8YDH+FDXQdX0XiGUe5
 flGdbtUeHKxIdgmZxZT9539YZ6MwPxAaLz7CA+lbPed+7t4SHoYF8zw2yaWvcT6Wp41cUDVC2KG
 uZHpN9u5dONT5PvQWrZvv1LCpDd1/FHgu0L9cCKe4ZXdKLqNUOA8Cz1r12l03QcEz0dusRwIw55
 DqDZ/XAV2ADdB35pNe++3qY0EhIaHrFdf9wWvuB/FWFPqYBWfhZiBr80m7PGnqIFG+uUC+w4oga
 vCUh8RpMLfbMpRG6HkQTA7/wT43v3Q==
X-Proofpoint-GUID: Bz-pIsrcUROCCq3cUakeneFkNTmztHbS
X-Proofpoint-ORIG-GUID: Bz-pIsrcUROCCq3cUakeneFkNTmztHbS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130054



On 11/10/2025 5:33 PM, Manivannan Sadhasivam wrote:
> On Mon, Nov 10, 2025 at 04:59:47PM +0530, Krishna Chaitanya Chundru wrote:
>>  From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
>> minimum amount of time(in us) that each component must wait in L1.2.Exit
>> after sampling CLKREQ# asserted before actively driving the interface to
>> ensure no device is ever actively driving into an unpowered component and
>> these values are based on the components and AC coupling capacitors used
>> in the connection linking the two components.
>>
>> This property should be used to indicate the T_POWER_ON for each Root Port.
>>
> I'm not sure if we should restrict this property to just Root Ports. Defining a
> property in 'pci-bus-common.yaml' means, all PCI bridges could use it, but this
> value is applicable to endpoint devices also.
Better to add in pci-device.yaml then.
> Also, you might want to add some info that the driver (or DT consumer) should
> derive the T_POWER_ON Scale and T_POWER_ON Value from this value.
ack

- Krishna Chaitanya.
> - Mani
>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>> Changes in v1:
>> - Updated the commiit text (Mani).
>> - Link to v1: https://lore.kernel.org/all/20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com/#t
>>
>>   dtschema/schemas/pci/pci-bus-common.yaml | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
>> index 5257339..bbe5510 100644
>> --- a/dtschema/schemas/pci/pci-bus-common.yaml
>> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
>> @@ -152,6 +152,15 @@ properties:
>>         This property is invalid in host bridge nodes.
>>       maxItems: 1
>>   
>> +  t-power-on-us:
>> +    description:
>> +      The minimum amount of time that each component must wait in
>> +      L1.2.Exit after sampling CLKREQ# asserted before actively driving
>> +      the interface to ensure no device is ever actively driving into an
>> +      unpowered component. This value is based on the components and AC
>> +      coupling capacitors used in the connection linking the two
>> +      components(PCIe r6.0, sec 5.5.4).
>> +
>>     supports-clkreq:
>>       description:
>>         If present this property specifies that CLKREQ signal routing exists from
>> -- 
>> 2.34.1
>>
>>


