Return-Path: <linux-pci+bounces-41356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E27C6251B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 05:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A880F348EF4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 04:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A3259CBF;
	Mon, 17 Nov 2025 04:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MkTlyOWx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ugcwq4nl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD43313544
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 04:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763353723; cv=none; b=pL/slyZBAx3Aqu79cLgYC/cvWDgLWV3TMRRhYUdpclbE1EDv5+c62XTB2G/W91q95FcTrtRWMKCINDm/n9py6T0rwOTY0Muwss4zQhudarBkCR58tR6O+rlMWET1JZUlU0/fiYbBXbjidCcEJz28ZMfkgMT0JJsNj4Sr25OJs4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763353723; c=relaxed/simple;
	bh=OeM/OYP4MqcRWc5TtekQphX8zrTpv2dN89hcSU7XVys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aA017rxk5c0VV2RkKOaxsk0KqBQOVcjSgrtghGTUqTuFryE2Hq/htqsKrUMhns+YQhKxDP7BgSkaGpI3Gby/plUdlHx4VzmLA3E7V+mwDhO09ymrytL6avJliAIWaICKx50MWB6k+1d7b6qGtLBlPCGu+ZJsxvLWt1sSgacRis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MkTlyOWx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ugcwq4nl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AGNG3jh2159163
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 04:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iPbU5dYethHvG7uL6GYJ4YK1ysP2x8WQABZrUrkX7Fw=; b=MkTlyOWx9N+fSCna
	1wA4mdakAyXuGEaL8+I1JqRqQeirBkbJ5puoEGk0YwVblg+IeJE/uu/HuyPSG7Q5
	fdA8eLwH/bgjcjGAZKvF1p3MwOxQHKQTY2C2rnPWoR1zYG7dQCX2WKJpaHt3z+rO
	D5BX/d3ofoFCOh2sb1IB6G8yOrdhpjRrGfdZmwpAGE7TD1ovQdUkplyPZWUUMtVV
	V0hb0vWMtMfdsWjyRWpBrSuePxQUHk674Zkt/mI3AoeZqvVaMNSj/Xy9rFw+PX4e
	c9yD+q/4CH2XJeLMm4KARUApIYaB4gnCr8y/a5vpm4MiV6hPfKfPp9wzVPo7ZGoe
	ZVM0Kw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejh0ba6y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 04:28:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7bf5cdef41dso1079385b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 16 Nov 2025 20:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763353720; x=1763958520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iPbU5dYethHvG7uL6GYJ4YK1ysP2x8WQABZrUrkX7Fw=;
        b=Ugcwq4nlMGB2Nd8sCEnJbie+HJblwgnyjX0H3csveehwspj+98WoEqvAx2Z+EXeZMJ
         PBRCY3a1HOz4Nsjm7XwcJ1A8/4bsAL4eDNtMoNDPrrUi9TTr8rqFNBGPM9syK1xGbBQH
         YR0C8IfliwagoswbzjGQuQQFWdRTWR+xsOOVDuzQCXaWGCo5fLCEtGLKO1u2CrNJUKmh
         xw1Kb1KEgsLaLBemT0ov4TwwUsGFM6q1QL4MX+Vc9nqOEj18xMxDsYzIgYZSVBO9KQrK
         JYDOGRbk1nyDxv4rCmz9ToKDUR5Aq8ClRhwx7f09VTznYm9AXgKQf3/UpqaVipTaRehm
         17RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763353720; x=1763958520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPbU5dYethHvG7uL6GYJ4YK1ysP2x8WQABZrUrkX7Fw=;
        b=WWRlRQ1Ov8Xl+G+igC3I76ySxjXOkTIcvXRrVnQ8n2xsTjMPcdkul5nmMG9tNhpm0B
         DRRkhk6YXIlMem3w/C96griVhpxX9kMHCZA/U2ClZXEDzyWg4gkdiq+il5wBTG3NjrdE
         vj2KPAA2ksQ2EG0wIXJFpmPSJEk6xocM0ofGk4OgoWPqfzA0lmdyhF+KNClg53huVnuG
         SQcGWGejujviEZYBjEV5bWibpe/blGayoXfCql3xeN7/rbGJmiaycAKAuWCa8p+2IM88
         XdvJPkiNs5ShKTjpsQE0aUgQltMCOQiH6IcR7hnPN36W1jRtEZIPd20kNuaIZHcQu5aN
         n6EA==
X-Forwarded-Encrypted: i=1; AJvYcCV1OJjBl0hMUhSuMGDSjNamIpjJWKxWMproyBR8X/kvYwHEahDH3Q3WKen4FyfXw2N3UyDrz+ZHXUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw21ma3Zv82JQbx9zpRVgJQsLWPw5v98LjG0pMA1/LcdZE/Gzwm
	k4sqd05FzME+UH8X+Ukeu2HAz+C7EDk1hIzIGsNylscN2KJ4GjbPC7zG4AaWfLLzCFBCcyCcE+0
	4NY+T2aIuvg5pS+nukqzi4MIqbqODnJ5dqh9zqPp2+9vVHfDFxXA5DRjw6A3wPNo=
X-Gm-Gg: ASbGncvYS33unj1KImpVYC58LuG5Ju/t7R7D4/6tPRUZgnzPgDdNdnANSRYGkAvL111
	9ya0IY30F3S8ZyXdPEDV+2zCeLxfs+sYm3fyE2P+UX57LVAUHscTvwX07i21BdY1D2y59yl9ylu
	gCJP86L9n/2HpZxOd5c8NEh9eWXg58Fj30fMbznGSkSqsVDncEA6ioTQh1esqPWLBhx9XRET+jK
	7IbJ3wHIoR8P3Zl/1PKvtbCdAybB06QNJSUPDm3xmlLlrR9akVlDrgGFjeeRit7vDVCyZ47p4qI
	IUOAUyjBG4lkRFoMsrlxI3Q/PtR3CeRyCJRv8qiy5ZZOgGMgxYXSoIUjzFjbqaFD+VhQC7UcOSI
	w8lglnGsiexhpczPLrIMD7aSKLTjM+M0=
X-Received: by 2002:a05:6a20:7352:b0:347:6c59:c728 with SMTP id adf61e73a8af0-35b9fa8a393mr13027908637.8.1763353719948;
        Sun, 16 Nov 2025 20:28:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAGXsBySUpGdiPlGNLuHMNHzPUJCG2unKjgBTsUsQrrMo80amGj8Exnb+4i4hydiJ50+pzJA==
X-Received: by 2002:a05:6a20:7352:b0:347:6c59:c728 with SMTP id adf61e73a8af0-35b9fa8a393mr13027878637.8.1763353719327;
        Sun, 16 Nov 2025 20:28:39 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250cd969sm11578890b3a.23.2025.11.16.20.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 20:28:39 -0800 (PST)
Message-ID: <4b04531b-64f9-4e42-b43b-bfcfa251b665@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 09:58:33 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] PM: sleep: wakeirq: Add support for custom IRQ
 flags in dedicated wake IRQ setup
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski
 <brgl@bgdev.pl>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com, sherry.sun@nxp.com
References: <20251107-wakeirq_support-v5-0-464e17f2c20c@oss.qualcomm.com>
 <20251107-wakeirq_support-v5-1-464e17f2c20c@oss.qualcomm.com>
 <CAJZ5v0jF2DG8Dki8+vVbOR20Z-=5=1XW2AjU05fzQPDJfzhLzA@mail.gmail.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0jF2DG8Dki8+vVbOR20Z-=5=1XW2AjU05fzQPDJfzhLzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HsiiDGvLGdGpdYZUXBovsDLc1ATTsP42
X-Authority-Analysis: v=2.4 cv=A8lh/qWG c=1 sm=1 tr=0 ts=691aa478 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=7B57G2-S2px21d87HYoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: HsiiDGvLGdGpdYZUXBovsDLc1ATTsP42
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDAzNSBTYWx0ZWRfXx4NVXfvn6F/G
 YttsGwO9H+zp+hG79+t/SX3PYDYtvk+wpB1S7eNRRjGpIQoFM10IHQQc97z1+gdBBkssknxXd2L
 Rz5DNrMigOZaAo9xyKbdAYwcBOXrUheWg0eemPhYNPadedd7PGuR1qUJsoLA5WrM+duZMUAOhk8
 w974oBUZ6TL0vYvyKJjJIgJXIo57HRtdS2MCY6oNWMr9vQZ7e2BwUodcknfWa6FyuRp+gWweb4z
 6RH1gxZuNYsz2IVCxXlBObagtsxvlXtqkv3zAXrvfEao0JYll+iB6+J+p5/lrf8FzNPt+JgUw5c
 QHtXbOyHDPEAqoPiEmURp6+joJ5CcAmgdpVao++y361ZGzWttFCLZfJjPupUo7XjAgvR7CwfFf9
 wsbDd3g3/DiPB5NH+YAiXGwxGUvJzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170035



On 11/14/2025 10:20 PM, Rafael J. Wysocki wrote:
> On Fri, Nov 7, 2025 at 10:22 AM Krishna Chaitanya Chundru
> <krishna.chundru@oss.qualcomm.com> wrote:
>> Some devices require more flexibility when configuring their dedicated
>> wake-up interrupts, such as support for IRQF_SHARED or other IRQ flags.
>> This is particularly useful in PCIe systems where multiple endpoints
>> (e.g., Wi-Fi and Bluetooth controllers) share a common WAKE# signal
>> line which requests platform to re-establish power and reference clocks
>> to the components. In such cases, drivers can use this API with IRQF_SHARED
>> to register a shared wake IRQ handler.
>>
>> Update the internal helper __dev_pm_set_dedicated_wake_irq() to accept an
>> irq_flags argument. Modify the existing dev_pm_set_dedicated_wake_irq()
>> and dev_pm_set_dedicated_wake_irq_reverse() to preserve current behavior
>> by passing default flags (IRQF_ONESHOT | IRQF_NO_AUTOEN).
>>
>> Introduce a new API, dev_pm_set_dedicated_wake_irq_flags(), to allow
>> callers to specify custom IRQ flags. If IRQF_SHARED is used, remove
>> IRQF_NO_AUTOEN and disable the IRQ after setup to prevent spurious wakeups.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/base/power/wakeirq.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>>   include/linux/pm_wakeirq.h   |  6 ++++++
>>   2 files changed, 44 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
>> index 8aa28c08b2891f3af490175362cc1a759069bd50..655c28d5fc6850f50fc2ed74c5fbc066a21ae7b3 100644
>> --- a/drivers/base/power/wakeirq.c
>> +++ b/drivers/base/power/wakeirq.c
>> @@ -168,7 +168,8 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
>>          return IRQ_HANDLED;
>>   }
>>
>> -static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned int flag)
>> +static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned int flag,
>> +                                          unsigned int irq_flags)
>>   {
>>          struct wake_irq *wirq;
>>          int err;
>> @@ -197,8 +198,7 @@ static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned
>>           * so we use a threaded irq.
>>           */
>>          err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
>> -                                  IRQF_ONESHOT | IRQF_NO_AUTOEN,
>> -                                  wirq->name, wirq);
>> +                                  irq_flags, wirq->name, wirq);
> It looks like IRQF_ONESHOT will always be there in the flags, so maybe do
>
> +                                  IRQF_ONESHOT | irq_flags, wirq->name, wirq);
>
> here?
>
>>          if (err)
>>                  goto err_free_name;
>>
>> @@ -234,7 +234,7 @@ static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned
>>    */
>>   int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>>   {
>> -       return __dev_pm_set_dedicated_wake_irq(dev, irq, 0);
>> +       return __dev_pm_set_dedicated_wake_irq(dev, irq, 0, IRQF_ONESHOT | IRQF_NO_AUTOEN);
>>   }
>>   EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
>>
>> @@ -255,10 +255,43 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
>>    */
>>   int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
>>   {
>> -       return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE);
>> +       return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE,
>> +                                              IRQF_ONESHOT | IRQF_NO_AUTOEN);
>>   }
>>   EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reverse);
>>
>> +/**
>> + * dev_pm_set_dedicated_wake_irq_flags - Request a dedicated wake-up interrupt
>> + *                                       with custom flags
>> + * @dev: Device entry
>> + * @irq: Device wake-up interrupt
>> + * @flags: IRQ flags (e.g., IRQF_SHARED)
>> + *
>> + * This API sets up a threaded interrupt handler for a device that has
>> + * a dedicated wake-up interrupt in addition to the device IO interrupt,
>> + * allowing the caller to specify custom IRQ flags such as IRQF_SHARED.
>> + *
>> + * Returns 0 on success or a negative error code on failure.
>> + */
>> +int dev_pm_set_dedicated_wake_irq_flags(struct device *dev, int irq, unsigned long flags)
>> +{
>> +       struct wake_irq *wirq;
>> +       int ret;
>> +
>> +       flags |= IRQF_ONESHOT;
>> +       if (!(flags & IRQF_SHARED))
>> +               flags |= IRQF_NO_AUTOEN;
>> +
>> +       ret =  __dev_pm_set_dedicated_wake_irq(dev, irq, 0, flags);
>> +       if (!ret && (flags & IRQF_SHARED)) {
>> +               wirq = dev->power.wakeirq;
>> +               disable_irq_nosync(wirq->irq);
>> +       }
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_flags);
> Instead of this, I'd introduce
>
> int dev_pm_set_dedicated_shared_wake_irq(struct device *dev, int irq,
> unsigned long additional_flags)
>
> that would pass IRQF_SHARED combined with additional_flags to
> __dev_pm_set_dedicated_wake_irq() to avoid having two different helper
> functions that can be used for the same purpose.
>
> I think that it would be sufficient for your use case.
Ack.

- Krishna Chaitanya.



