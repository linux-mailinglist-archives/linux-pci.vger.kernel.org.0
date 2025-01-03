Return-Path: <linux-pci+bounces-19221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C751A008E4
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 12:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF99160AB3
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 11:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C791F9F60;
	Fri,  3 Jan 2025 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eCsIUbN1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC521F941B
	for <linux-pci@vger.kernel.org>; Fri,  3 Jan 2025 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735904943; cv=none; b=mm5EzBR54IYfTesVoZlYqAk2dsUSAXPKtUP2PBIIpbzWehgT7pdQ8oOkQv3MQOAS4490+W1EwTf9hH3an666tHO6viK0l3Hh1nIABPjCdZ3p/dPE5Pm+Y05RGres3hO1qnxsXVkh1/oPe7AbuTZ0Hh1FWTXQnlFvKO/RzOt/rDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735904943; c=relaxed/simple;
	bh=NLd1X0clRT7iGn/Sxk5o+itD4OrXYuoZrJYJ4szklTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgFrmLyuUdPsOpXoSKL/Yuru3vl5EotRBeWxJeoDaHxPtyw1Vtw6BkzBefkAvtnw5Jog01+biyq21zs4DfGkOHq8oQyxb1t5Re4fZtIzPXo8TYawQyv720dH6FXOaCg1mtHt0Pd5oO8aNfcXOOnp1eN41Zpt/D0Eex7OXEoJ4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eCsIUbN1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5036jWKE004203
	for <linux-pci@vger.kernel.org>; Fri, 3 Jan 2025 11:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kSr8QRPbWyeuYtAJXhV7CqtuHNejTbL/irUiflDNBWI=; b=eCsIUbN1EJD6dspX
	Qa5XsuPdhU7dlEEHrNHoj0OsT9moNzhmr//xtCO8BewROYirQK5NTOxbdZJ8oI1B
	VvlcdEjcjjV6VW/KZFcXAJPveRx/ICXxCkzAO/7i2TnLmKcNkcIoYT1QLxQIn8r8
	oOxKsSmnG+UahVQ16MPjFVhc+OIngAG+xx5Ck8ezzLNJbWXF+Y4BrIlQhpc+Hq+z
	+UL9b1/BHBgHlTIwAXmTTPU/DuuyTnA2kMR/s+DngcjV6d/Ho5D5/rMFiUvHYwvc
	WrdpizFg8TPNEbjVuXbm6vpG+xOsqgLRGx2wuOOsvRWOOWYfsf4KLkvbWchO0Sd1
	tb7iUg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43xawj8ngw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 03 Jan 2025 11:49:00 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d904ac0ea2so18630376d6.2
        for <linux-pci@vger.kernel.org>; Fri, 03 Jan 2025 03:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735904938; x=1736509738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSr8QRPbWyeuYtAJXhV7CqtuHNejTbL/irUiflDNBWI=;
        b=qUSTuV6EvRylJo3MjnnCp3+eh0N5A19ZCAQWc9galDvbHU3Bfx8d13cRH6CS8SYViS
         VzH+aKJY9DqUYjBrhG8+Nez+EJE6TTTeFwdsf5ZY1nEs5k/697SdEjXIdPl2vM05srdw
         h7GZ7g5rxR8a97P6edWaihYfhOd0OQlaUWXVKSVgkpSZINBg/QRaTuGgXlCXZQPpl4PF
         zw3WyPxrHc2fD07xqd8yziyXKjz9EahRElGaWFkt0Cv/qpTZIbyYll4I58GaYmM6KY8e
         pgLQb/VmmC8JTwX5xiAUyRRfzh9Ls165kL0qpOIEMsl4Es2Z3ixeEm7ANa/b1ULbVKO+
         BTkw==
X-Forwarded-Encrypted: i=1; AJvYcCXpa0Jj0A/j5ic8Nr5+3bh8Sj+x7emSHjJGPiLdQqiuMFDO1oAv5ctxtfNDxTIKZy1EiSELNF0qfsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnvtkxYLKRydqaSM3h8oqOl6akOXnacHTCXBI7t6t089CxjHNA
	Lk5ykFygl+m1MmiVKRn4QCordGm8TobQ+S+utQ0z/G3j3zWaBH58ECVTYiv+3H6IuNWFfhAmuXH
	swrNj7BJRjdD0443dE8ycBi+2xRiXi0F1hWzmmGZWbxeVOZIWQUDZGlO1Kdm8GStOza8=
X-Gm-Gg: ASbGncs1AyMu1Pyuo1R75XIWHF/WnDzOA2kOxpG35Upn604MjKmnMVo+v2Zz7YNgZeq
	MB6luUqvXLzxzyQchtt0m2uERfm6kT2g7ZR11ZfZ3Nyf77MI6IXGLtcqW3RvML74tjikwMsVY75
	aeSNqE29fIWPV9n4dVkBftGRyK4Nl0ZRk/cqjPqLrn5z4mu3m3PmH67EUATahWFYRiMJkPdEDbx
	+tttEHw/weMPHaBHhj6mA6WNw2AohYC0IVG6BxpgS/pxGNVMHYeC33rUbVhegsK2TKxer4E1C2A
	643CZt7qEQH9f5Hb0mK556ShcYvK7rwj0+c=
X-Received: by 2002:a05:622a:199a:b0:467:85f9:2a72 with SMTP id d75a77b69052e-46a4a6a51camr298064941cf.0.1735904938621;
        Fri, 03 Jan 2025 03:48:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeaakE33Peugzgz4XJzULmcsT1OumHdl1qg3wXiidDFearGseoLbBPjIsRixnqTRiKwVCreA==
X-Received: by 2002:a05:622a:199a:b0:467:85f9:2a72 with SMTP id d75a77b69052e-46a4a6a51camr298064781cf.0.1735904938243;
        Fri, 03 Jan 2025 03:48:58 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f60asm1912866266b.28.2025.01.03.03.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 03:48:57 -0800 (PST)
Message-ID: <95f25457-c1dd-4125-8f0d-46d87a1d5356@oss.qualcomm.com>
Date: Fri, 3 Jan 2025 12:48:55 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the
 user
To: Christoph Hellwig <hch@lst.de>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki"
 <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org
References: <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
 <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>
 <20250103072805.GB28920@lst.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250103072805.GB28920@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bYWcbf0ubvU0SFJJcnOeMScI_866ov7y
X-Proofpoint-ORIG-GUID: bYWcbf0ubvU0SFJJcnOeMScI_866ov7y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501030104

On 3.01.2025 8:28 AM, Christoph Hellwig wrote:
> On Fri, Dec 20, 2024 at 04:15:21PM +0100, Konrad Dybcio wrote:
>> The Qualcomm platform (or class of platforms) we're looking at with this
>> specific issue requires PCIe (implying NVMe) shutdown for S2RAM.
>>
>> The S2RAM entry mechanism is unfortunately misrepresented as an S2Idle
>> state by Linux as of today, and I'm trying really hard to convince some
>> folks to let me describe it correctly, with little success so far..
> 
> Well, not advertizing the right mechanism isn't going to cause havoc
> to any scheme.
> 
>> That is the real underlying issue and once/if it's solved, this patch
>> will not be necessary.
> 
> Well, maybe this thread gave good enough fodder to finally fix it?

Oh I'd love to..

But my changes are getting rejected over philosophical FW design
disagreements, it seems.

Konrad

> 
>>
>>> In theory, ACPI S3 or hibernation may request that, but I've never
>>> seen it happen in practice.
>>>
>>> Suspend-to-idle on x86 may want devices to end up in specific power
>>> states in order to be able to switch the entire platform into a deep
>>> energy-saving mode, but that's never been D3cold so far.
>>
>> In our case the plug is only pulled in S2RAM, otherwise the best we can
>> do is just turn off the devices individually to decrease the overall
>> power draw
> 
> FYI, going to D3 for S2RAM seems perfectly reasonable from the NVMe POV.
> 

