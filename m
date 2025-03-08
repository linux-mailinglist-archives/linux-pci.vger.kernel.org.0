Return-Path: <linux-pci+bounces-23186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F75A57B64
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 16:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9310C169C2A
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1245B167DB7;
	Sat,  8 Mar 2025 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XdlAcI8m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D41C13DBA0
	for <linux-pci@vger.kernel.org>; Sat,  8 Mar 2025 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741446346; cv=none; b=W+tRJUJgthB/cRN2MzbIxF++TiRcC/f7yMu0596s+pEUEK0FO7RVIP2mtmDLb2cvQvMF9dcOu/QP7rkpsweT6T1cMAgLgR4gR+EHR5ofcCxXhC/xZEFWTAsEmS5GB6lGkONZnd37EHYpUHWoIQzM5aKdJUKF4ghWRzHHfeNbe3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741446346; c=relaxed/simple;
	bh=p8FE6Yce4UFFPFp8RPlL6Zq6MyjvmqNXaWFwHY6Xcwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/zipFBEGUdithflEZ/fkqh0phx1mPkIY5kapwbAFgltizMZWXH3xaX46qygDDUemN3eXsDL14E5RDXydQopTUey3+mTR5mQ1VeT+NQV4HHSKuzFFUaB3HgjPfMbt4SQcPdFADKmgGDbgP8Sxycqk9c6RQHw+svQGlxzQdBI3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XdlAcI8m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5287bBAY000451
	for <linux-pci@vger.kernel.org>; Sat, 8 Mar 2025 14:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ajkDcMXkTChhLB9nQXqXX4w1XlD/zn/bmx5ISWyGiDE=; b=XdlAcI8mJvT5ZzSC
	BYdYS14qi2YMrDMG0SARJc7twAMD4ylW/xAiRf7VdzLeQ0p2B88dgMBNI3Vd9/lB
	yg5bLTeegaMxv8TOxoKsro/HOMyWUoyS4XxoEWam/FQftEmPaY8gg+TpfSGOCd41
	5agraq4czLhmGRvhKscIk7UyEvzH1gk2B+vpDRV31EbIc+BIR50KmaoqruxUT+LY
	LueVsidQh+p4yB6nHt5hsOnSE2AGC9vMWSo2R7P+0YGy2exaMsVMwEaqrIepPj5F
	wUgZQnRQ2/y2AM5ss+YTNtGIe4uENpkPfwtM6bdha7fBjl3T7QTn8eZ/p/5Bbl94
	vYh30w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyt0p6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 14:25:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-474f467e613so7926781cf.2
        for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 06:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741443910; x=1742048710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajkDcMXkTChhLB9nQXqXX4w1XlD/zn/bmx5ISWyGiDE=;
        b=mp8lqP7xeUsnLhAncrmeC05sNejOmF3QolvRgmDDQEAwb/+U5P0DsxzCC8NeVugTzO
         /fXPBImf0VwkjnjbIE354mbIgU+RlstZGhIkydDdlsrY0rRGbVm0oRqb6qgeCBcjs9Gy
         iSbsF4QDzVhXitB5zQnlWWs3LJ4Ecsj8rrld678XzFRCSumOETes7DoS2DVaZ61x8b0z
         nxBkmAZWrwuM4o/KLhqX2UCHdXM9AGmhbJhZtbkkMtn/uCAy46+L/XhzvH4oE37mt/Ol
         IcDiT/NErS3ePeGq6mEVLHAgLbiii9CbB1MvjxJPTTPchMNxMK5Xl9kzb7XiFZfehMNc
         USaw==
X-Forwarded-Encrypted: i=1; AJvYcCWmXKN227WS4EVokqBU2whM4mhlg/TFMQRivnUGyfKBLIH6b00mbGQiMS9mD4YJkrsvXTJhVk69Ss4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGrh11jSEWoE3DsmqIvs0HyHSIgnzNZ/Edi9gYEp0adMNYeNhy
	YKuI3ChF6uhzjTSqGJDPUtjp3mfh0R216+79jqNKpWVuQzLXBuIpYlmtjepeoE9HvH0DQ1kVsio
	MESYWhyW/L5iDIKXQTLqs/pxzT53Hz2DJ8PgKyEzWYJ+tAzZqWouSk/tLjJM=
X-Gm-Gg: ASbGncv+RFHv1q9GCfZxjcSMX4GRJGXOGwey8tgRHmfOXEKJyQO6pDL6AUmgiD/+Jmq
	4yqGZItEr0dEO1yKJvjXd55i7wcCbkB2KC/eYPwVoRJDA/gpWdinXkxfhUs4Q/sfEkK7TKUnDRK
	Ew8BoTveP3f4evEuN5ni63rcyRhiPOpQUxpaNvaWSGEEYOMW3E8gXiw2eKU4uDtp6wgR12dFEx0
	fv5O+BszZRYSvq2GYX+olPB2lHbrHby+eDC4p0u1y2Y6CmFC/KdKz17zdqW1kGcGYPHwxlGACCJ
	OgEB5eQh15GuNIAAaY2YOUcUtjUen+aSpYixf8TctLNhGjsaeONLxrv67XEZSx1VATUB4g==
X-Received: by 2002:a05:6214:d6b:b0:6e6:60f6:56db with SMTP id 6a1803df08f44-6e908d8568cmr15818296d6.6.1741443909924;
        Sat, 08 Mar 2025 06:25:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf5Bpdb+EwGJ+DUwof9ezxDFy4IdGxQr6SUgAcI78hiBLBYecPa0sQ6yprSMZOTAU4uNWqGA==
X-Received: by 2002:a05:6214:d6b:b0:6e6:60f6:56db with SMTP id 6a1803df08f44-6e908d8568cmr15818006d6.6.1741443909472;
        Sat, 08 Mar 2025 06:25:09 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23973b09asm438894266b.119.2025.03.08.06.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 06:25:08 -0800 (PST)
Message-ID: <e2d84147-c061-4f12-a44b-f60919625f77@oss.qualcomm.com>
Date: Sat, 8 Mar 2025 15:25:05 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] phy: qualcomm: qcom-uniphy-pcie 28LP add support
 for IPQ5018
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, kishon@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, kw@linux.com, lpieralisi@kernel.org,
        manivannan.sadhasivam@linaro.org, p.zabel@pengutronix.de,
        quic_nsekar@quicinc.com, robh@kernel.org, robimarko@gmail.com,
        vkoul@kernel.org, quic_srichara@quicinc.com
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883A6C7E8FA6810089453149DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
 <oeu6wkfhx2masvendoweoufzit6dcwwer5bakzvg75dz3uc4bj@bwuj4slnb24e>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <oeu6wkfhx2masvendoweoufzit6dcwwer5bakzvg75dz3uc4bj@bwuj4slnb24e>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _hnaKXU3uRwoL3VHvo6gMNPyitYSg5V5
X-Authority-Analysis: v=2.4 cv=CupFcm4D c=1 sm=1 tr=0 ts=67cc5346 cx=c_pps a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=Bxonh79IiWxE7T-ZNUwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _hnaKXU3uRwoL3VHvo6gMNPyitYSg5V5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_05,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=834 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503080108

On 5.03.2025 9:39 PM, Dmitry Baryshkov wrote:
> On Wed, Mar 05, 2025 at 05:41:27PM +0400, George Moussalem wrote:
>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>
>> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Something is wrong here. There can't be two authors for the patch.

It may be that Nitheesh was the original author, whose patch was then
picked up by Sricharan for sending (no additional notices of
co-development), but George later did the same, forgetting to remove
Sricharan from the chain.

Konrad

