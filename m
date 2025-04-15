Return-Path: <linux-pci+bounces-25922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7927EA89B3E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 12:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2650416A607
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 10:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019CA2741CA;
	Tue, 15 Apr 2025 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aBsuZkQr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0442260C
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744714587; cv=none; b=ONCTCjJZZTY+Tved4HJCy1peSbSfMco8vwJl6sXlVZRNlgnLZuVWIn2wUprfMsw3gg5GGuY8m9tDUowhYYQqlRLnQfy0IpkeneMd20U3mfaU0xWAv2BC7VrwuyPJyS3jl82V+NgYnipmjkZAngOpqVuK0lCar9M91GJj8D2JbDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744714587; c=relaxed/simple;
	bh=wXBuDbylQUrjB0iM7PzlB3G82KLfsU+48WBnxvvb5B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwBCnUS0r3Qje5oA9DNhbsRLj4vWl/EI0kNU5Ma9In48Ov1GaDpFtInBS1kMWBlysaVQBeHMX/eXcn+v/bPzGVYuIzNnbkLWYBz0lr6MAb2raRHbk0wZYzBxz6FU71MdjayT9fe7+S4+ps4CQjUqQJoGzEsSrz0m5hdrBRiogxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aBsuZkQr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tCkV025066
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 10:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rYKTS0S+EfVR8OXMdy5BFppRLvfryGbDjZTdsxWF+eE=; b=aBsuZkQr1DMcXLCI
	rytWWbRCdXja8xA/4jWh47Y6EilkkhJHM2XMGgpZmAI5zopLrgO5slPU9v98Ha0p
	MFXd6+5fVf54oT2iSUfYjKRRLhEGVh9bd9ekrCiLN18BdykOVWQdTCjDeOt396ny
	JQ+buPAXlyfEOc/ndyZzN4iZrYJAuAm1T5+uDLCVK2xZEDMv3CsuZKn0pLwqrhq+
	wfoXjPi4W7EW8/0m27k33jf5MDwi+qYTNRxO7er+vo4aBsMU1ftmSKt/9Prb0eY2
	agx/JQ/8G+nxgLH5XCQjyEpxusb+l2pbJVRlHu5C1OiYIexyDDlRFDLdliniKkzK
	N5Va1w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wfrmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 10:56:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4766ce9a08cso10693621cf.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 03:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744714584; x=1745319384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYKTS0S+EfVR8OXMdy5BFppRLvfryGbDjZTdsxWF+eE=;
        b=cbh+3LU3Y4v0oNIEqcFGgDvdB3BUCKxM/U8hhgra5EXoSrJvuX7aRxcSp5G/5zbmb4
         lAg9TL8eszbs4rTL8wtaYgZd2VEYXPYkC4qxWAEoDI3nTDnu2SnjVdivH+wb4SEoU+2H
         78ru8zu3HaPEMsvwMLsg/w5kZyeFLCHkyv6UvIrWrTCT+1FjSl0Sniqs3BoDS6zqAOUP
         OL6DUFsXtIaA2OfqB1Pbdpz5/IaBd1lIyJtiBu2zPssu2XATFjPIBXtyMXQ/EGyUoCRk
         0Mns63fLtrZwisJ7y9JrxwCEk765wFCCfmF1bZN04I0obecBcKR19OludfTxduIjooBe
         gOhw==
X-Forwarded-Encrypted: i=1; AJvYcCWOxzPhXMc2jLuz01o4aqgcGr4d6S/2Zs3J2s9QUOHH3EqLlos9fUfIeN9jixc3QG+sHl/2VQ9PmCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2kXP3nwxQsqyjEPtPzuCfA3KEbc6eBMkydZkRIVXWBf+r6Lnz
	xRT3fsSEYZj0uySLG2TKieIUZi4EFb85HMLKyz+5yls20lXQs+ubHan56hkOzwTLOWqM/NMIZeB
	Esue11w/TIbr4w7W+n7nf3k+A61Y26kU0ScawIqDU0rixXMuzFJw4ipu4RpU=
X-Gm-Gg: ASbGnctzRFFab7BO7cSCjMZ9k+wyCCTaEUgZJACmRElD7tos8HMC+ynuQJOtx+YSqQo
	p005oxW0m2xFyb+KKN+GGg13XlLzClTsPeQXA1fzdAnLU1Iy8k4DYmywXj6aof0kqFUYviVCKLq
	7EllqF9EuVec3Pp3pYyiqVTwO0vnsU2pp3XDbkBcOJx+07ex2pzCltFXID8nJPLLfvbiJAIaTXp
	0ZcFU2seLV/cJ7Bmr4w/1Ij4a3L0p374LPCovYLz0oJ4VfGU5hwCTOeFayG3v05IlB9ONfDhEYE
	IVDMtKuzAk8nCdLS6ievrbazTYqOJObxqNclbw6RYehLKeEzsc4Zbfd306ptPnes6Fw=
X-Received: by 2002:a05:622a:3d3:b0:472:1d00:1faa with SMTP id d75a77b69052e-479775de243mr85517511cf.13.1744714584462;
        Tue, 15 Apr 2025 03:56:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRD3bma8EpKjMM5BlPikOo8DgdDwXPonYsbL4+V/MN8amtSG4FuhrIiyJDFizYQehdJGRF1A==
X-Received: by 2002:a05:622a:3d3:b0:472:1d00:1faa with SMTP id d75a77b69052e-479775de243mr85517281cf.13.1744714584122;
        Tue, 15 Apr 2025 03:56:24 -0700 (PDT)
Received: from [192.168.65.246] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f069dedsm6604397a12.41.2025.04.15.03.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 03:56:23 -0700 (PDT)
Message-ID: <3b27f345-c961-46b2-8846-c7a6ca78a19a@oss.qualcomm.com>
Date: Tue, 15 Apr 2025 12:56:21 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/4] arm64: dts: qcom: ipq5332: Add PCIe related nodes
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
References: <20250317100029.881286-1-quic_varada@quicinc.com>
 <20250317100029.881286-4-quic_varada@quicinc.com>
 <48361e2a-89b2-4474-97aa-557fbbbdf601@oss.qualcomm.com>
 <20250415095023.dxipm4hd73jxoe4n@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250415095023.dxipm4hd73jxoe4n@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=67fe3b59 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=P01nhSEvYWan2JYZi4wA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: zh0u7u0EHmWvFhpf-o_tD27xU5rTZ_yX
X-Proofpoint-GUID: zh0u7u0EHmWvFhpf-o_tD27xU5rTZ_yX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=688 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150077

On 4/15/25 11:50 AM, Varadarajan Narayanan wrote:
> On Fri, Apr 11, 2025 at 01:22:39PM +0200, Konrad Dybcio wrote:
>> On 3/17/25 11:00 AM, Varadarajan Narayanan wrote:
>>> From: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>
>>> Add phy and controller nodes for pcie0_x1 and pcie1_x2.
>>>
>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> ---
>>
>> [...]
>>
>> I think you're reaching out of the BAR register space by an order of magnitude,
>> on both hosts
>>
>> IIUC it's only 32 MiB for both
> 
> Checked with h/w person and he confirmed that the BAR register space is correct.
> It is 256MB for one and 128MB for the other controller.

Thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

