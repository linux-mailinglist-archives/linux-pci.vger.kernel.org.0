Return-Path: <linux-pci+bounces-32378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC137B08B71
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F17165492
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A2299A8E;
	Thu, 17 Jul 2025 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lcCN/7ii"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAFC28A700
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749978; cv=none; b=DeAkA3ugB/WCG6/ay4kKwh4LI3I8cUjCkcPz1RBR3ZAMfIwdbttQ06q19MKyJNuKGgiMiR+tJ5ow4vyLqHC+1slZLV9te5rm58fp+3T42+TjsTP2twguqi5azs/IzBZQk28DNK0jj1OT5YDRORktf7aaohcOYdwW363ozfUMuH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749978; c=relaxed/simple;
	bh=dFFgXr0V7KJsMFT9bzLI4LKgPjgSk0pPsZwF+/Ain5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlF2w0GjQBsEFcK3om9jPfgjZQPmnVgx+aAzV+snQLR00liN96MXbiXqZxBJ1eikvWHYEQBkDGl9SL9PWwGe4bG/JQaZkdB0bvOiUR6HnAAUVBSAjCKnc07GD/ru1WKxZ/Cmg4T7ivKL+yXrPdTCzW6hYhvCXb6iVGMD+bozmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lcCN/7ii; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H4RA6F021258
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 10:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9m1vcYVumY1HNbRTAgr3tsYxKmOeN38kHcJutqp6GcY=; b=lcCN/7ii+6ET6bQm
	W5JrOXTbbJCbkNfiX90VFzbFNdnsU89a6yKqCm+gzmQQAopy7HKsInmt/7b0KfCW
	CrMJ+zifO1sCVrSDy2XozNYjbi2J1RrZD/ID8aWW3uY+Yd/mej6t901aSHQC/j0F
	UQVMGzHYRRhRkB50lYLjBjKGsdM3r2zolpzCtpWu2vIKhMRg3ygMb6tMGgPLnPUT
	Kddr/9vO2X9atuwi3AJDBKWHI1nTjf9QNJKiwKSu7jUyfAZ/t/DKBmj+D0D5TFeS
	QkXd6PAw4KKQ0oK/6itX5Et1huo/K4b0ul9qLoOi47OgldpKY93VtU5mbagw3LDY
	OUQgOg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpjbxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 10:59:35 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-747ddba7c90so810551b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 03:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752749974; x=1753354774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9m1vcYVumY1HNbRTAgr3tsYxKmOeN38kHcJutqp6GcY=;
        b=ZlmWNhEYdV/f2ugmD6uEAU+KC0h0WwjhMC3Xfq1cipXMxipCErCZNQXPkzb7O1DlI6
         dC2Omd8J9P/v9FsySC7L5heVnX4YyfdGRZAHbmWsF0B0+90TArSN5+SlRc/WrJGsHg36
         cksyC+l3O9rwk762h0MfV9vSRfbmWxrCC3s/4AYT1ehySi1OOf69FCmGcH7ZgR5A/RTe
         RPA6c1ep24ufzJ0lm4hyL9TjE1g9l06kLOqjWDwzRsCVCs3ELBaj33GNh1SbaaNvfleo
         YAfQobik2sKOQq4xVXynosuXunbgyUYls+mBG+XSCN6IMKsNzUu9BmLZPGQH3+VU4VwZ
         l92g==
X-Forwarded-Encrypted: i=1; AJvYcCUX+tFa8muo4KGuPA9ZbSdkAn9amo8aGMKrYHbflc0GNO8pMDb21Lft17YhX5R8iw8vMvZ+gO0Pycc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPB+PQPHqC/1QD+n6K/tvXiCH5EOV9HW+idRGrvIKdJHkf/1co
	aeH7e3OPYOngeW6uzzYQVAHC8ewF4kyYY+7bPk4i1S4mSEmBBw+9+dq30FR8KPSkrQ8H66TzB8N
	1pyBohMAwG5C5CbyzojwO78vkY9HX8hdNcjmMqiKSA81r0Xr7FqaDu6esNQsAj8o=
X-Gm-Gg: ASbGncujb4jzIZwnW+v2+HCPtbKqZB0FYilCWaGCIz09lkc99owiLES3/I/YZ68Bibh
	fVtyJj7YyBRG5exi+jjv1mfHo6x3O0v1Gt698EhME8H9AUl9OqnaeEf25jW6Y5y9f+KWM3+/5b+
	tCO4DjvqydpoWGw8Ggh98aWLnoSZf9NqRpdiWczAm81xC7DGu36vB8BhCtNX8Uo+Gw1ULZBMOTS
	0FHgQbVZxe/LlkUBm8OnU6sV71cLeZsKm1cFgorHbVRVLy3Nzm6dPy1BV6wVeJK4EghrtTi0WTQ
	ZBnm4axTq0KhNAGPRbhCv+J2l2viStrU0/F80TxGGN50pAtpRKYHXOuoJl+DaOzCLUV0WZqEP6m
	21rw54VshzmQwXnHhE/kGDfWblBWkzNV4
X-Received: by 2002:a05:6a00:1945:b0:748:ed51:1300 with SMTP id d2e1a72fcca58-75722869e2dmr8491727b3a.9.1752749974373;
        Thu, 17 Jul 2025 03:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS/1Q6FwFVvJNpwEqbklIvf1jeMXGBNVBGHmlE5Rp/k57dq0BzAzgcVPz3GfhsuMeAZ0ucYA==
X-Received: by 2002:a05:6a00:1945:b0:748:ed51:1300 with SMTP id d2e1a72fcca58-75722869e2dmr8491687b3a.9.1752749973872;
        Thu, 17 Jul 2025 03:59:33 -0700 (PDT)
Received: from [10.133.33.245] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-75914e6f81asm309433b3a.152.2025.07.17.03.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 03:59:33 -0700 (PDT)
Message-ID: <c4a4d594-a705-4de1-af08-42a72ec44023@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 18:59:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
 <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
 <38ace6a3-d594-4438-a193-cf730a7b87d6@oss.qualcomm.com>
 <wyqtr3tz3k2zdf62kgtcepf3sedm7z7wacv27visl2xsrqspmq@wi4fgef2mn2m>
 <03806d02-1cfc-4db2-8b63-c1e51f5456e2@oss.qualcomm.com>
 <5502b2eb-f6d1-4ece-b918-1c8561a92607@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <5502b2eb-f6d1-4ece-b918-1c8561a92607@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA5NiBTYWx0ZWRfX/GdvUY93DaZU
 N/LuaGXj7eiGmkYgfWNH4ZjhzTwvq4H1IVWn3bvt+u+TaADP7GK6sF+nGVEd449SZ6R/5/Hg+Qo
 IqX1H2buIYj3vyMqidqn792P1Ey755cxucAIO1E8kaobX5wCZ1ShnwuxKlrT+JdhCifW8ee459o
 PHEVez5YMAy0Jv5L/LFrGtEemD1q7I6t7RZ7B9lCNujl62Fehv226jqj6DGsLi3sh5a8kesTw1M
 qVQourX2wy3WCVuSvehaj/BJeNPbJuGSZvwDhDa93vCcPKHgD0mrYA6Iac7qMwBCn622RzUKbUd
 L0jhSkZqnOPB4hME5/LH/qSxx60EII+taQ5UrYYIRgUMTvrq9PgKRlqJCz+5yM1sazT6CwlZfBH
 wR6JLeP3BeyfaTmBApecErp7AqNF/esatz6GCE1zKmFGVaZj2++OBT9BgXprhGcBz2TfRi1l
X-Proofpoint-GUID: EoYRhJ9ihFvAyN2cMGrQ1MUkGbHxhv5Q
X-Proofpoint-ORIG-GUID: EoYRhJ9ihFvAyN2cMGrQ1MUkGbHxhv5Q
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6878d797 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Ghoe0wLkBCzmZIYDIaAA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170096



On 7/17/2025 6:55 PM, Konrad Dybcio wrote:
> On 7/17/25 12:46 PM, Baochen Qiang wrote:
>>
>>
>> On 7/17/2025 6:31 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Jul 17, 2025 at 05:24:13PM GMT, Baochen Qiang wrote:
>>>
> 
> [...]
> 
>>>> In addition, frequently I can see below AER warnings:
>>>>
>>>> [  280.383143] aer_ratelimit: 30 callbacks suppressed
>>>> [  280.383151] pcieport 0000:00:1c.0: AER: Correctable error message received from
>>>> 0000:00:1c.0
>>>> [  280.383177] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Correctable, type=Data Link
>>>> Layer, (Transmitter ID)
>>>> [  280.383184] pcieport 0000:00:1c.0:   device [8086:7ab8] error status/mask=00001000/00002000
>>>> [  280.383193] pcieport 0000:00:1c.0:    [12] Timeout
>>>>
>>>
>>> I don't see any AER errors either.
>>
>> My WLAN chip is attached via a PCIe-to-M.2 adapter, maybe some hardware issue? However I
>> never saw them until your changes applied.
> 
> It'd be useful to know whether that's a Qualcomm platform running
> an upstream-ish kernel, or some other host - we've had platform-
> specific issues in the past and the necessary margining/tuning presets
> were only introduced recently

It is an Intel based desktop, so not a Qualcomm platform. But it is indeed an upstream
kernel:

	https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git

> 
> Konrad


