Return-Path: <linux-pci+bounces-18910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0359C9F952B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 16:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D2A188F8BD
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB26219A64;
	Fri, 20 Dec 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWkrGgGe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40616218E82
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707730; cv=none; b=OcvM5L2SSEmhMaErfbsAUIFvndvan9U5s63rPI4z/YnB7i3mkyMvj4MNMwjqWVFwCh0jGzp3lFRaXozXI/i9K1Mb72WbEPqkQ8bt1UHt4bBqueoTjjREeRjGTgYjIiQnC9aDY+7anby8EUw6euG/hd59SCU1zliA0g2wCtPZu9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707730; c=relaxed/simple;
	bh=kg49+uaoHpj7D++o6jRL1ADBtrJA1aWRF63Yb9kp8ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eqzy5paTWRbJsEJmCxC5Y1ni9IVB8e3e6E5nMRi/O6CkY5wV4N9PzAb606RNZZ6g795WlInqhXvcITEdN0wElGe6j8/N+CiZUthWr0WsIvlqSqiiI71Bqkw88zky4+GK7+jaC5tnin5/OWxqPUMBBiza9WOXHsMoHJO4WSh5lyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CWkrGgGe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKBbivp023321
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 15:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9pdRk1FNEwE15r/NRpb5txdFYJ22rYoCmR29SeDLD9E=; b=CWkrGgGegK3PkMiY
	21XQ7nuYVRZdULWoQulYqqX8aAHE8jbyNEdEg73YmDZVSxvnURpB4D4bUA+m/kTB
	LO1CY95KY8IVvkA7UHxeL2jUR6ya8zlQljpYX2cWDemMtBTBxIwyQT/J9CgWKBPW
	9sUxYrb6RRpvNNOJWaxLc18BXplb1tD5Rb/YtnO2odLR1Hg4INSoaaBIxhhHsKuV
	/o5/i66CKjOmTe92spTR3caiejJbu24r8RB+RllT4HwZgBQbPp2iYU0wkl5Csv5z
	tCBy0CRXjZdO9bhgYqFHuT2Unuu0R/Lo0AnPZ0heF2W92bgaIriX8GZz9nI059b9
	qGsaIA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n7vg0ghn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 15:15:25 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d88fe63f21so4806086d6.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 07:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707725; x=1735312525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pdRk1FNEwE15r/NRpb5txdFYJ22rYoCmR29SeDLD9E=;
        b=jCKL8mo1uqD+AEQ8BjJL3MI5RSnWZ0pML1631BB5zaLu9pMkcwSuG+QBOXQgEQ6MKL
         RDnPdxAsivIdeOL5CCZ83cvirHXISZudSnCBUzJMD98cgo0QLppaF7w8gwRHxzIcdwnz
         n8aEc1kHImBWf1IUAv8kiTuE3/5lAUYl9XgnjAjlOqZLhKLhpedPpC8b4IwHAUlvlf8j
         9y+jEWhp1iYSnUwuXjnREkxtXwv8mAYLjujDaq7oOdyDyOeCTHIfubtDM8odi7/7dh/B
         fdsYrLAjENf4KoXkhLT5DqnxXEQYeiZpg8NDCumR44koE7eUvPGx/jDLIPlbNATP20oW
         FG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcf/We2mjRZsU696N0mso/1okosJbQuX1ImtQtdyEIndl2oAeatgSXPrmAb6NVDKjrTLqC1CHmB1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoa6BLz4/x4r33D34KWZMSzfS/HZWSM5JCdptFSOYeHikp5A1P
	hUeL9qu6pnnbdRQAijYJZXked1oAinDBoSZfo1GXLVLFVJWBfYROiKIiE+tygPEOKj9iVlqCvFf
	ZUqau+8KEdEyxH5ONAhDbh1dJ3T5b9W1oK9lizjZGTucRdGBbfpfaN9HIiJ4=
X-Gm-Gg: ASbGnctjzw0MyFZ1+xvsOAt+M4I7gLv0PjLkz6jiDknnimPzXfkE5Oy+5aqvNu+eqJk
	oP6jk6binChX7aPLXiuZlbAbr2I/rUiylv7wG/DPfJs1R7lJAwUsiEVjnPFTcKWg4NWY7zoKrL9
	o99MUlznAEQN84s3/3D3b0G8e+XQnvzJX3zDbjtLJt3LWCMiQlDmQaRe9umB6VIAKB47h8zcU9q
	XgQPsNJB/BMX8BwbFCganAyY23sqNYfC+EGgjt6OXgG/vVovOGavdT0z7QQ7gSrZhKCPcXMbwoG
	/I005RD+S1jn2RyjwErqetiMmqGYkLdcA1w=
X-Received: by 2002:a05:620a:2454:b0:7b6:c8a4:ba09 with SMTP id af79cd13be357-7b9ba7be496mr170654785a.9.1734707725186;
        Fri, 20 Dec 2024 07:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFD5koPpJL0wKEso3nr+u+1J+IrI3s+lO5cyWCeEsrPYRbTAkLqKhgQ19j1vhTaqjkKzFcUzQ==
X-Received: by 2002:a05:620a:2454:b0:7b6:c8a4:ba09 with SMTP id af79cd13be357-7b9ba7be496mr170652685a.9.1734707724779;
        Fri, 20 Dec 2024 07:15:24 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a741sm1818444a12.12.2024.12.20.07.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 07:15:24 -0800 (PST)
Message-ID: <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 16:15:21 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the
 user
To: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki"
 <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org
References: <20241205232900.GA3072557@bhelgaas>
 <20241209143821.m4dahsaqeydluyf3@thinkpad> <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gzMfGZ0LmNGjM22A0VhAclwOsLVEuFob
X-Proofpoint-ORIG-GUID: gzMfGZ0LmNGjM22A0VhAclwOsLVEuFob
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200124

On 16.12.2024 5:42 PM, Rafael J. Wysocki wrote:
> On Mon, Dec 16, 2024 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
>>> We need a PM core API that tells the device drivers when it is safe to powerdown
>>> the devices. The usecase here is with PCIe based NVMe devices but the problem is
>>> applicable to other devices as well.
>>
>> Maybe I'm misunderstanding things, but I think the important part is
>> to indicate when a suspend actually MUST put the device into D3.  Because
>> doing that should always be safe, but not always optimal.
> 
> I'm not aware of any cases when a device must be put into D3cold
> (which I think is what you mean) during system-wide suspend.
> 
> Suspend-to-idle on x86 doesn't require this, at least not for
> correctness.  I don't think any platforms using DT require it either.

That would be correct.

The Qualcomm platform (or class of platforms) we're looking at with this
specific issue requires PCIe (implying NVMe) shutdown for S2RAM.

The S2RAM entry mechanism is unfortunately misrepresented as an S2Idle
state by Linux as of today, and I'm trying really hard to convince some
folks to let me describe it correctly, with little success so far..

That is the real underlying issue and once/if it's solved, this patch
will not be necessary.

> In theory, ACPI S3 or hibernation may request that, but I've never
> seen it happen in practice.
> 
> Suspend-to-idle on x86 may want devices to end up in specific power
> states in order to be able to switch the entire platform into a deep
> energy-saving mode, but that's never been D3cold so far.

In our case the plug is only pulled in S2RAM, otherwise the best we can
do is just turn off the devices individually to decrease the overall
power draw

(simplifying some small edge cases here, but that's mostly the story)

Konrad

