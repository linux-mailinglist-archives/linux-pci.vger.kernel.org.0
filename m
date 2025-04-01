Return-Path: <linux-pci+bounces-25036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1843A77428
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 07:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B9A1883C90
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 05:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA632AF14;
	Tue,  1 Apr 2025 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oJojUlJs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED413C2C6
	for <linux-pci@vger.kernel.org>; Tue,  1 Apr 2025 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743486766; cv=none; b=PUg+a/WlvZRO6tiO2Q06Gh85rWMbxPWa7ITyd7H5BnHy+39C5lfGe4C+h9Z8hfMDqiIgFrnrQ1bybzBT4njC9OmuUgfW8TajU0O1lin3i1kgmffz2oAvkyaGPCwaINpX9zIG2X1+hVwFM3Px5xUij1RQzge7fMxm0h2RoMYhVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743486766; c=relaxed/simple;
	bh=+QaopGBM55gMhKn4+IMNFBkQ/Argtnoh9M5CPx4hhqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kb8G1RRwKG8TbTnR97HKvg/4AsKmOrER5aELGWRAf5mRbYksPUCiXFcFtnyhEZXHFfZdlT1RINmOs+mmBPSR/GoMOT7aJATaHiptViUkURwNXMupdcpzp6Tjyr9prOoctrWi//8PKSbYL5QJTZ3k7IxJGfEwFWptJIOpUn5JKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oJojUlJs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5310J4ni032238
	for <linux-pci@vger.kernel.org>; Tue, 1 Apr 2025 05:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NQaLt8PMSngOHyoSTcihfDEfDE5P9beADhv0mJn/7m4=; b=oJojUlJsG5dXaPbh
	JNKWi/UvnCykcyIYfIVf5g6f/TvMnL4B44tpQXzGyTxODa5wYek9yDw5ObjIM9gl
	KwABGQUUTkGMfnRycKRFj+HuZMy+0vinAyab03A2IuJLgCcKqZHqhBXR5StTDbXY
	KNNfOujlUpW4c+UDG5Fa8HUKh74NnD1qtYJrmyes9QYNQZhXMIKYl2rzE/fr6T9A
	Fxr5d5y8c3uyYPYa9+2flwQVqMEyV3QyocyYsFVnA1LxIe0vzX5hKSnXwllvNFAx
	32seqRkEe77q8SDg6oVhEEm+jL++QI9uKy02VtmatjX7Zrvrl3Hm/HKwdriRtM5N
	Jo2gYQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p9mjphx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 01 Apr 2025 05:52:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2241e7e3addso82814715ad.1
        for <linux-pci@vger.kernel.org>; Mon, 31 Mar 2025 22:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743486762; x=1744091562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQaLt8PMSngOHyoSTcihfDEfDE5P9beADhv0mJn/7m4=;
        b=aNK0kt0iCOo7v/yxini8vPS+mlETaN76ps9glhrRmaa0te8bdUgzJmfCQ9kQqzGfEu
         F7ge+iOCtl1BWFUvmBvKixB5NAKEFQqDKv1+ibfeoNOnA8glZeQb2oMNAAiOybWYd+/l
         HNJH4zuheN2wLhg0dveZ5BCAwDKZSsIlQW5ysk1HlZozIgfgXfF6c305s8P3KKQaMVkP
         SiTaxJwho+UWHwvQpv+PVewFVo5SHtCtJiZISGvZHHKoPvz5vebi6UcLF0RYvuqxxOva
         U14O1yti4HZKJMZOyIDWXlu38T1lUwtaLSA/CM6P3NveHcjXjqGHLvibNFOPGJXpVLDz
         wUdA==
X-Forwarded-Encrypted: i=1; AJvYcCVgMLj/CKRs5o2xGnpPI0O4yF/+flTHAKt/azeaaCHGZRGmXwDBMoaJwejjeFrGyqRFJ687apWUkBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxT4I7G8KI8+EmwQvMWA5EREotNu+WRS56aK2KNsWGdomQyvpQ
	zJ6H+0c2SZCh3xTpnztkzYRgyZemopvZbkxArTufzSQLahDF5kgbfoytUWuPj4fvRT5FVV1qW/j
	P4fcA0drXLiVC2F/3bNUJy/AzERf9bWY2JJ6Sxwn7I9aFFI9qaknPDwA/Mjw=
X-Gm-Gg: ASbGnctu4EhM4um+8Zo+NOSq2uIj4xr1jNKDDlr7kEaIij6nXevYy/nSekrQeAjpoO8
	VrHhfzpEmJqoJ4uj5B8lfOED/25/R88tp1PkUfaok9RDC0fgomd+LZkoz5eZYhCnpZ3rUAXeWze
	qC042JUcUql0bFvrQKXLFfN0hz2C5sJa54I8OlNDU9BEo5oHeT/UOunNGl1uguNzORTuJiVQ4Y/
	dRG0mxgZCNnkeg6rF2BTMLfaLjLWXW4PzgSP1hORPSuf+AebmHQ/50Fq5osl9HsT1fC3xqE8XMJ
	qE7ZlAVyQM/mTLskusCfXQkJ+ghdTBH+AM/gJHiVqGHGGw==
X-Received: by 2002:a17:903:1a2b:b0:224:1c41:a4cd with SMTP id d9443c01a7336-2295be318f6mr27460685ad.3.1743486762218;
        Mon, 31 Mar 2025 22:52:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgwh10iYCgOpoeLjVCuNlhcBy5e2Yd3ZjeZgCvFDSEOBRweegPNhiIkkF+4J4dC6xAbF/M+w==
X-Received: by 2002:a17:903:1a2b:b0:224:1c41:a4cd with SMTP id d9443c01a7336-2295be318f6mr27460245ad.3.1743486761846;
        Mon, 31 Mar 2025 22:52:41 -0700 (PDT)
Received: from [10.92.192.202] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cdd52sm79806105ad.157.2025.03.31.22.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 22:52:41 -0700 (PDT)
Message-ID: <385c7c77-0cb7-f899-4934-dfa58328235a@oss.qualcomm.com>
Date: Tue, 1 Apr 2025 11:22:33 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 01/10] dt-bindings: PCI: Add binding for Toshiba TC956x
 PCIe switch
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com>
 <20250226-eager-urchin-of-performance-b71ae4@krzk-bin>
 <8e301a7b-c475-4642-bf91-7a5176a00d1f@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <8e301a7b-c475-4642-bf91-7a5176a00d1f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Mfhsu4/f c=1 sm=1 tr=0 ts=67eb7f2b cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oqaUoJuz7rIYE2SJXf0A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: xUT08sVCxGV0xcIUceb1xdoV5DneSsx2
X-Proofpoint-GUID: xUT08sVCxGV0xcIUceb1xdoV5DneSsx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=937 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010038



On 3/25/2025 7:26 PM, Konrad Dybcio wrote:
> On 2/26/25 8:30 AM, Krzysztof Kozlowski wrote:
>> On Tue, Feb 25, 2025 at 03:03:58PM +0530, Krishna Chaitanya Chundru wrote:
>>> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>
>>> Add a device tree binding for the Toshiba TC956x PCIe switch, which
>>> provides an Ethernet MAC integrated to the 3rd downstream port and two
>>> downstream PCIe ports.
>>>
>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>>
>> Drop, file was named entirely different. I see other changes, altough
>> comparing with b4 is impossible.
>>
>> Why b4 does not work for this patch?
>>
>>    b4 diff '20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com'
>>    Checking for older revisions
>>    Grabbing search results from lore.kernel.org
>>    Nothing matching that query.
>>
>> Looks like you use b4 but decide to not use b4 changesets/versions. Why
>> making it difficult for reviewers and for yourself?
>>
>>
>>> ---
>>>   .../devicetree/bindings/pci/toshiba,tc956x.yaml    | 178 +++++++++++++++++++++
>>>   1 file changed, 178 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
>>> new file mode 100644
>>> index 000000000000..ffed23004f0d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
>>
>> What is "x" here? Wildcard?
> 
> Yes, an overly broad one. Let's use the actual name going forward.
> 
ok I will update the next series the name from tc956x to tc9563 as
suggested.

- Krishna Chaitanya.
> Konrad

