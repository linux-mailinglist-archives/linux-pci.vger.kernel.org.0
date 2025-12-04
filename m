Return-Path: <linux-pci+bounces-42626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C7FCA3AF0
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 13:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 424B93007C55
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2F432AAA5;
	Thu,  4 Dec 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HsH2H5X0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JmtRnAJf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC38A2DEA87
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852725; cv=none; b=psOmzq9w6rMBo3S35rFHVl4kut/fKP3pED+9QxUzQYNcG2xB/Jlea3KFSkqHnzytlmdTgNtRNr77CT71X0abIqIfc/gvZuVwMJ/usrmNs4IfEKvXnMUMiMIAwq5Z4nsAEwvv71hqcCua95yarVF8GpaaApjpdpPDnjII1htGuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852725; c=relaxed/simple;
	bh=fR/wz95v+ab2M/jnCBU6UtLaH1ljn/M4mc9nbjw8hoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A45UVX43IT1fBHMvBbXEfZKSFHaxQP3XyTsoQ4GhFUicjqAxw2kUXfCePYsXop+kYUepAnFuU+GjW83JcJxyP5ypUQx9JIXGz26fVUxJC8AASC4jzypA+YqPXImZRUVi7jNKLwlrf1l9YYYC4/Ge4S49Z5zmwU7sKE7NhQqrHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HsH2H5X0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JmtRnAJf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B4AEuXW1159694
	for <linux-pci@vger.kernel.org>; Thu, 4 Dec 2025 12:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kj9xyiYEYQQhKupjG/NGhtwvNM64eXefSge44gZ7fUY=; b=HsH2H5X008CupkBy
	uT34Kp4knCJnpvl8H1VJgRKqWk58vg8O/d2yvvoYbZ9ADT+8mVxTnu2Dxa1RYyqW
	rT5UPIj3IDFb9BZ36JWZ0dKbbSE0YE259DNtFNhAbDwa9IYgOCFZch8RrLszWR0C
	GWSUKHr9uNPgwykA6RJF+VQbncbLvroy9ZqalD5iPKek6CLmJtFmKmFyB7X0/ZTI
	esb58LzoLo3hjzidBlPAlSu8Bb8JNMUM7ZLJiN5IoTUhDUFjaorSrpog1FaFK/xj
	z07/++mhpgye659F5rXt+3d2AVgt7s+tY9ubIHtQVMAG3AEcGOgGwOsqbETkoJjR
	obAUpA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atu3h2tdb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2025 12:52:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed767bf637so649491cf.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2025 04:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764852722; x=1765457522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kj9xyiYEYQQhKupjG/NGhtwvNM64eXefSge44gZ7fUY=;
        b=JmtRnAJfsUb2iH2isl+xWs06G8Y8UsFPPc6sblgC5jWMVdm2J56X3paX34PnpsAdDF
         SVnZFe4T0kXK9uEnUzdAlD3e1fvImz8lNVgaVsa2KcAQu+EEnsYE2h2jvqF7LoUoVy/f
         OEUJAuhEhEPR3RC9jL3vvMLs6y836v+WTA5oCcoM1QBURRuNv7c/ZBFQ8xSVBJhkpWoV
         pjgObQ6pl5+A8PGgxvca69aL5PREI9GnQ++gRgUb+9myJs9nYxF1YvBVbE3ICtX6mdZO
         /hLttKvH/5bcYMN4BlDFwwOsptwMKYFlT2PD4606/R4JdkUat4uyFh5wUva1Q30E1MOE
         gy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764852722; x=1765457522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kj9xyiYEYQQhKupjG/NGhtwvNM64eXefSge44gZ7fUY=;
        b=wcR16MMS+iLRF0ppY3cUj04hCDycjkVTcEGdTJPYMzjH6K+M0pCabJB/Zz7cuP6jqE
         z3b2zG14CXthCe4UAN4nMv8fYJAnJj4tySemb5pocqz/teksMrKsr1cXN/hOwjIhwBcd
         s435neHLq+kRtQP9a9av+zQgyxPr46AEcLggvNyS1t8BlvO8dVDgY4vhfjLeM1ZDmbp9
         zEAWhOYV5AC9TMNTBgv5vyLa+kAx/HCvcjJV7uvCFJLa8bVxJ7Gn5N1no0MnsknEnLSc
         cxRo4McuU8KEws9drcrGNOQAyZieUXZ0gk5LT12V1n3aNSTdxkE0QQEDyHRmB4Qf2M4R
         45qw==
X-Forwarded-Encrypted: i=1; AJvYcCWUoLbtfedzSV6JIa3QbN4j+RQcsXRu8oiA8L3SitHdWSF8eWfsu248/FKu9DzB9xSsHZgm62jmlsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWB3FxSXW55ETi/CkM422jsv71LKE/iZR50qQCFSDPVDwDMHRH
	MD0hZwuaOpC7CojhDBznkHAEpsXZ2m5qqvJEXw/hzgvCWByfoLgyTXMIHD0pHsu3xe5tPmVQcWT
	R9pHGn+N+KkuHjZ68Z0+Ta7g++GnUZ8IaxVsMYjZfY4qxIWlX/kKnA5BqFtfIXPI=
X-Gm-Gg: ASbGnctufqdXrPfFb6JHNspiAPBYvAqLGu8Z7P+rayQG9zjPKnGX2SQOdlHAXbLAu/R
	J1BSjh54ABcJhhrRNcnAXEN7i1AjPWCn4O5xyc+HRFt6r9LPt9mq0zP2Bmvb4engyspVIdixcQn
	FGsx9RlbIDoYNoS9c94j2bh1uctfU4JIua74BKBQVYkkkzmCvvbM3zBdWR6sph5T9ZQB9v9KXqZ
	jWsmGEXI2ojzK7fZEiSg7xXA2mTyYCwatzJL69y1X9Q4vUGTCqUGkDZyIC/HzyHuJi/9LztOmeT
	foznkzO8CpvwzDZlsAtr81N+tuj7XGpwhfBvbFuxRrawhUK57+jYQzcM/98SSk8NMh4LZ+L62pp
	+RE5wq7Tyt4Has15Gfv8iJYCB4u10K+hQNIR9kMp3ZuDg5oAGGKgJkfaf+i76Mf3dfA==
X-Received: by 2002:a05:622a:14d4:b0:4ed:b7f0:c76e with SMTP id d75a77b69052e-4f01b39e3f2mr52687841cf.8.1764852721960;
        Thu, 04 Dec 2025 04:52:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0bLdgdxO5Xx7VpBTNWQVdPb4PGrfj4fxevUAaWvvwerQ9JsZj8ppP5fqoZwFHpJwan5XAcA==
X-Received: by 2002:a05:622a:14d4:b0:4ed:b7f0:c76e with SMTP id d75a77b69052e-4f01b39e3f2mr52687521cf.8.1764852721485;
        Thu, 04 Dec 2025 04:52:01 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f44d3db6sm127856366b.29.2025.12.04.04.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 04:52:00 -0800 (PST)
Message-ID: <6c45abe8-6c1c-4cf1-b538-abf65edefba5@oss.qualcomm.com>
Date: Thu, 4 Dec 2025 13:51:59 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Add quirk to disable ASPM L1 for Sandisk SN740
 NVMe SSDs
To: Val Packett <val@packett.cool>, Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Bogoslavsky <Alexey.Bogoslavsky@sandisk.com>,
        Jeffrey Lien <Jeff.Lien@sandisk.com>,
        Avinash M N <Avinash.M.N@sandisk.com>
References: <20251120161253.189580-1-mani@kernel.org>
 <20251124235307.GA2725632@bhelgaas>
 <tiadpmogdxom5h2bquct2ch6hoc6ozh6bgnzdmnj3mia22vtue@c5yjxbx65lsm>
 <9a9280e7-d29a-475a-83fa-671acfab9d92@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <9a9280e7-d29a-475a-83fa-671acfab9d92@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDEwNSBTYWx0ZWRfX2OXxfd2eKrYy
 TnF93L2HEr6gtppag2zdKGkzERwzidVNm+8/rqpzNizoY5BM9OViS5QRfVUeASCMPqn6dQUmFJ1
 9+8lbXfAZzxYtNDHwhTPcuHAZ4YcyfOcNhK7pb9aa0T/D+y9p/VBUZiXC5G4mVOAo8emqWkJVh5
 bjE57r0ZNe9oCZDnJPP1phqDtOWVk0E14ZE/8yClq+uL37kS7d3fcJ/dKXY+UIKCIsf2/GggS4H
 jeHVCKeUqqypXPVTir0o6hMSdaJ8qzzybcDXYUlQldfxJuATG61QebCoqUON6LmZUj5PAfSjRgj
 C73/cWC+hbMM5GC8I1sTEdKMMbvO7sne0H/hHaESEEIxECWs+ussOQMgHDUw51qucnhgiXhn5yZ
 mnVt0M3i4kiAn97zlNAgrk4Bqd6p+A==
X-Proofpoint-GUID: eihcpa3LvBVyah_f4X7JaNumTYl5_6HS
X-Authority-Analysis: v=2.4 cv=KJxXzVFo c=1 sm=1 tr=0 ts=693183f3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gvLC6PIGuGH4zeNmEhwA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: eihcpa3LvBVyah_f4X7JaNumTYl5_6HS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_03,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512040105

On 12/1/25 7:48 AM, Val Packett wrote:
> 
> On 11/25/25 2:21 AM, Manivannan Sadhasivam wrote:
>> [..]
>> There are a couple of points that made me convince myself:
>>
>> * Other X1E laptops are working fine with ASPM L1.
>> * This laptop has WCN785x WiFi/BT combo card connected to the other controller
>> instance and L1 is working fine for it.
>> * There is no known issue with ASPM L1 in X1E chipsets.
>>
>> Because of these, I was so certain that the NVMe is the fault here.
> 
> There is *a* known issue with ASPM L1 on X1E, reported by maaaany users on #aarch64-laptops, that we discussed in another thread..
> 
> But it is a full system freeze, **not** a correctable AER message, and it definitely happens with a bunch of various SSDs on various laptops. I personally have had it happen both with the SN740 and an SK Hynix drive, on a Latitude 7455. It's an SSD-only issue (disabling ASPM just for the drive, but keeping it on for the WiFi, was enough to get to month-long uptime) but not specific to any SSD model.

Are the steps to reproduce roughly

* boot without disabling ASPM
* wait
* system reboots on its own (or just freezes?)

?

Konrad

