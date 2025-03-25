Return-Path: <linux-pci+bounces-24671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 618F2A70326
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 15:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D8416D1B1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3969425743D;
	Tue, 25 Mar 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bwgfOe93"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3272571D1
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911009; cv=none; b=IeX74tp6Shs2XflpG2y/aUirQA3Edqg+1s9k/PXO57TVwKLb5IqF/Ju/2yfgD1hEX7/ZDEnemJ3QwzsXDwfhwWU5ghi6kI3gq3OJWmrbcN+WgHgzkD3V/LdmcFhJrP3jP09tLboSTXrQsW8sH7kUwW+ZXKjPDALrViHCcQej8bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911009; c=relaxed/simple;
	bh=9IaDry6fuUbenQllqTlT5gYi5cOj1Q3ja/I4EJIT8z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLCC8fA8dK7WuLEYLwe9nfvlWgZq9+sryVZ/Oe9p2HZMq0IG4dA/oKVz0kZvieJqRBxf24ip0zHDtcaaJsSxTOaxHsFoNmmV5FN0vi5uf94EhHiOmz0VuL7SKPlnZG+Dvyb5KFF2Qe5gu9bNCytSD7wDDZAfSUmRpJlGiyIFY/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bwgfOe93; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PDerMe021961
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 13:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0sLDZktwhqsG1wOZKxLglmBiOdJLLONIkvu2uYKb5xE=; b=bwgfOe93NgXIrhvF
	iy2HZAAvfKWT42nzdJgEpzmXlWXWSGymuWBRuz1x71ybDi0vo6sYN2C1H1su3imx
	BuQfU1UOemDBpZ5YbLCBT3aQmaSF3yxook1e/SnKD4ek5vgiJwaSuElQ5DYyYK+f
	DFG3OnMesGr/CYRFxqTo+lKbfuteauAb6Crv+r9YP/YVZGWkf6n7W58RYVSuBqwB
	4viRSJhtD6wp7hqFBcu9QFMhIPw9j7fVRc7aVyDVHt4zR9aRz9TzJpuFuLvMq4EO
	WR+zx4HbyztXPMB6ZVYYJnM8T8tDU2d6o71QVgO+8uLlRM7OQ7zJCE8zv/1JvEu1
	c97pLg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hmhk83vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 13:56:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4767ca7a333so7317801cf.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 06:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742911005; x=1743515805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sLDZktwhqsG1wOZKxLglmBiOdJLLONIkvu2uYKb5xE=;
        b=VuK/kYZD2KlW1+0tmKxj2SuwNOP5IG1fyy6iFd8B4VsdPqdcikjnXmTBmpHb42BxcP
         JyBBDYKDuAPh7/dQSfEbGeZ0wqOjHK6i7hYfJ0hIy+4PzrsEZfLizWHuleMrhRxMNwV7
         PEt8zS6CbVvROQbLfVe32o3GroLAZq9hN6Z25ZL+kMj/upaSgqXDImmMJjWdRruli4CN
         t0AbHfTGNTUzUezbE5R+FZpCtOrwSZxT61yttGL4bRoPvXVUl9QnjGle9pvefoE5g5gy
         ltGtKqV3TRrjXlP12QwX9N4EPLfDlgaNmECFfBIgVD9cIP8cKgiDa+ip7s/z7mSB+RKN
         Bfyw==
X-Forwarded-Encrypted: i=1; AJvYcCXScqdmV4sMqS4r1Ora9IIssydm+lmObbrw1pdy7NgDl2ulPbdePqwIT/JXWkoOcPJrXvZq3OvkkT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ZCu9zH5kWSfnAFah3xd5wiLAjr4M1mPzmmrDQ+/uZMQMsZLj
	8KzH6/7WxOAC3O2/f4ys93CCpgPJ73SjY6gPOt86whqr7w4Vb5RZ9OuPN73dhVT1luSOTMyCGsT
	Xqau+eAmFR0/5vWDnaFYZqUgFfangjb2pMoL+oA1imnKpqzp3oKjlPM9K66o=
X-Gm-Gg: ASbGncscrkjVQF478swxMRQSBk2eeH2+ibKAZTpwmBcWLDwRoBqBwQw8YLmLrccsXXp
	77smb6gsQ6nSI6/Liep6LFIwwSpihfz6Zn96UN6a1h6NkNtHmWvnV7KEs48YuQsq68ytqKboUmS
	Gj0ioPgSbAzhOFBoCalvNCbDbb79BHAPSmrAAXVTCjoGKIyxFczEV+/0GplajckoZ6lmq/j5IZt
	1NvFzpcZaOhHZQcdSbBY7k/7z0o2yzh9huMxedrEUm19t5Wp0P9HLPjOn0h0kQqXpw9HhSmm1ew
	8py9K++47ngyDLNkoXfqfBueM7aBp2F6tO0AZHA5nXUHuBHUMXhgM6K6qTIQDepeOTUKBg==
X-Received: by 2002:a05:622a:1883:b0:473:884e:dcff with SMTP id d75a77b69052e-4771de13f51mr88067351cf.13.1742911005336;
        Tue, 25 Mar 2025 06:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn+bjrW3qy1jJkHXha130pv0V5DkYmNYCdBX0USZFkxoEZBO3/5NEu0ewfyB/epISxwClUwg==
X-Received: by 2002:a05:622a:1883:b0:473:884e:dcff with SMTP id d75a77b69052e-4771de13f51mr88067141cf.13.1742911004890;
        Tue, 25 Mar 2025 06:56:44 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf665dcsm7788319a12.13.2025.03.25.06.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 06:56:44 -0700 (PDT)
Message-ID: <8e301a7b-c475-4642-bf91-7a5176a00d1f@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 14:56:40 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: PCI: Add binding for Toshiba TC956x
 PCIe switch
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250226-eager-urchin-of-performance-b71ae4@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=C4PpyRP+ c=1 sm=1 tr=0 ts=67e2b61e cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gGbnW7COpTo7U3-rSK8A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: TDAwH-WkvgA5P_PS8qYLgCXotbw_dyGI
X-Proofpoint-ORIG-GUID: TDAwH-WkvgA5P_PS8qYLgCXotbw_dyGI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250098

On 2/26/25 8:30 AM, Krzysztof Kozlowski wrote:
> On Tue, Feb 25, 2025 at 03:03:58PM +0530, Krishna Chaitanya Chundru wrote:
>> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>
>> Add a device tree binding for the Toshiba TC956x PCIe switch, which
>> provides an Ethernet MAC integrated to the 3rd downstream port and two
>> downstream PCIe ports.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> Drop, file was named entirely different. I see other changes, altough
> comparing with b4 is impossible.
> 
> Why b4 does not work for this patch?
> 
>   b4 diff '20250225-qps615_v4_1-v4-1-e08633a7bdf8@oss.qualcomm.com'
>   Checking for older revisions
>   Grabbing search results from lore.kernel.org
>   Nothing matching that query.
> 
> Looks like you use b4 but decide to not use b4 changesets/versions. Why
> making it difficult for reviewers and for yourself?
> 
> 
>> ---
>>  .../devicetree/bindings/pci/toshiba,tc956x.yaml    | 178 +++++++++++++++++++++
>>  1 file changed, 178 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
>> new file mode 100644
>> index 000000000000..ffed23004f0d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc956x.yaml
> 
> What is "x" here? Wildcard?

Yes, an overly broad one. Let's use the actual name going forward.

Konrad

