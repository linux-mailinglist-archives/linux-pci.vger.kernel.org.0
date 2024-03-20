Return-Path: <linux-pci+bounces-4927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE64880BBC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 08:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FD31F22213
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 07:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D1F1EB22;
	Wed, 20 Mar 2024 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHM/hvog"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC3020DCB;
	Wed, 20 Mar 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918748; cv=none; b=Ul5Z2yAOY2iBSbpHM5t93bhBQw4AnsqJ6jCBNCCP4hokvy03+Ybs2XkEIy1GXOxp4QwgwvJxS4kOFE4BRTK7X5sNc14keVAsUJsL2JdJD16cLyBH0DeloMMb63FFs+0fBGdMQEcUKgXCWSt92dok3uVnxQAYyb5LflGCddx3YtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918748; c=relaxed/simple;
	bh=JTCshX56DhuRq+dbv3LL4ovkRcC7ucxnZ9MEKhul8/k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=B9AR+vHH7cfaiYUmWQEW9DW1goRQUeTTvDPe3euD6vxrE9oxk0thTLDG71i2M3G0+Fkq/Qdzch0txwO/1NPSw8wGRCcVlw4Qs/WqResFbYM+hdD8O8J7mh3prTNbzJroYlvCbBWnBVa8Xb8FpHKT2sQ5JcAfTuhOyCDaZ6jUTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHM/hvog; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c390f91b22so1478972b6e.0;
        Wed, 20 Mar 2024 00:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710918746; x=1711523546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhuMvCo3TgtaW8PwFw7FBLn/PThKgsQ0zRt/0tBJ7iM=;
        b=GHM/hvog9FhxEl/ajQL6VxjStjChy6xrGBbffe9R+Z24jj+neGCAsUllTQoIX7YXON
         u7JOyHDXxW209/mAKHS7/d5Euy/ILNXzHlYrJDb0QlsdKmm+BHRUWETGXZ0ifKgJBc78
         RI9wdbq5juqNiE/xvpQ+r4J5clCiwy+Xlul876IkgvnZDKvR9oRulro+sjoRVROOgn31
         n4yJzyzjyViVeM8tHbjDX9lVP0anV07RdC2UrtMqsI6D4ygRK77nBVmWbLZEs+CqJGJA
         6VNM7mYQQY//6EZF2X9+bOiANWU8+mNPpS8zVnFSWNXeZjk+5OaDu+5VIx5cQxO0rHBw
         e26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710918746; x=1711523546;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhuMvCo3TgtaW8PwFw7FBLn/PThKgsQ0zRt/0tBJ7iM=;
        b=Q9OetgVsh1BFXWmDwWj9VYWDP17mjw/eQhPteuKTZeczUAYPtsSNmxoB1iv4Z9PqZH
         oW09DoH3aH9UwQ5JGq1FzyvcKxuoyuYV61nnrA6Nu2s5pOp8a6Z8df2SwyTv29s967+O
         quoxfI772D5wJsC9Xs81pRpXNlFlELpFSLuvn+6Mh7TfQK0zWqv3ub4Fr8pQp8yAhz2Z
         urBWHaS30ztnXeZ2nc5orWC6YYPjGoabayK+erh/u0JrIIP2Vw4AI9vynw9S7BW9W//C
         J5mYH/56XusrLymOPdOOeR9vEzZ4cj6RB78dREmyfwyJjQzgR2ci1cZSek3DZBJmcSL2
         JQ3w==
X-Forwarded-Encrypted: i=1; AJvYcCVy9vyWsnmMVs2LyZNl1/fV7i/phykZyk2U3FVrcA9rwSinwYONztw/i2VWJRj8cv8CU+xZmWqC8JZmlzSZgh9+oGZIvKY/kWYPx5/LNRfYgbv4lIoFIAWSsQbdCwjYH7iKMVfa8xAyYmL+7Sdd9qwqKQC5YsrvD8ZnUo7K2ELNX2gbRw==
X-Gm-Message-State: AOJu0YzVffOs41Bbl0V6314dnx4RmB4+d2LZC//cZOhKcclj/btX30ho
	ksXXnsrGvo0Fr+XWKl5yqAWaRsl6X4L2cNO3UtMwJ7xn4jb4gRDZT6IJQtNgCWg=
X-Google-Smtp-Source: AGHT+IFYjkAhJU6qgZKZ1Sxu70SlW955OlQtKscMfS6t4l/5ITm8Mj2uH+x1X+AJ/XOFEtz5dOqgiA==
X-Received: by 2002:a05:6808:b04:b0:3c3:59ef:821e with SMTP id s4-20020a0568080b0400b003c359ef821emr4183108oij.48.1710918746273;
        Wed, 20 Mar 2024 00:12:26 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.232])
        by smtp.gmail.com with ESMTPSA id ks11-20020a056a004b8b00b006e647059cccsm10918577pfb.33.2024.03.20.00.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 00:12:25 -0700 (PDT)
Subject: Re: [PATCH v15,RESEND 22/23] PCI: starfive: Offload the NVMe timeout
 workaround to host drivers.
To: Keith Busch <kbusch@kernel.org>, Kevin Xie <kevin.xie@starfivetech.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Minda Chen
 <minda.chen@starfivetech.com>, Conor Dooley <conor@kernel.org>,
 "kw@linux.com" <kw@linux.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "daire.mcnamara@microchip.com" <daire.mcnamara@microchip.com>,
 "emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 Mason Huo <mason.huo@starfivetech.com>,
 Leyfoon Tan <leyfoon.tan@starfivetech.com>
References: <ZeCd+xqE6x2ZFtJN@lpieralisi>
 <mhng-87e7ef5a-d60b-4057-960d-41bc901b6c7f@palmer-ri-x1c9>
 <ZedAn8IC+Mpm4Sqz@lpieralisi>
 <ZQ0PR01MB0981BC562E837B232B419AC28229A@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
 <ZfJmMcs2UThVSC4v@kbusch-mbp>
From: Bo Gan <ganboing@gmail.com>
Message-ID: <16a1e6c6-2e2f-08e5-8da0-1462cec57e1f@gmail.com>
Date: Wed, 20 Mar 2024 00:12:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZfJmMcs2UThVSC4v@kbusch-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 3/13/24 7:51 PM, Keith Busch wrote:
> On Thu, Mar 14, 2024 at 02:18:38AM +0000, Kevin Xie wrote:
>>> Re: [PATCH v15,RESEND 22/23] PCI: starfive: Offload the NVMe timeout
>>> workaround to host drivers.
>>>
>>> On Mon, Mar 04, 2024 at 10:08:06AM -0800, Palmer Dabbelt wrote:
>>>> On Thu, 29 Feb 2024 07:08:43 PST (-0800), lpieralisi@kernel.org wrote:
>>>>> On Tue, Feb 27, 2024 at 06:35:21PM +0800, Minda Chen wrote:
>>>>>> From: Kevin Xie <kevin.xie@starfivetech.com>
>>>>>>
>>>>>> As the Starfive JH7110 hardware can't keep two inbound post write
>>>>>> in order all the time, such as MSI messages and NVMe completions.
>>>>>> If the NVMe completion update later than the MSI, an NVMe IRQ handle
>>> will miss.
>>>>>
>>>>> Please explain what the problem is and what "NVMe completions" means
>>>>> given that you are talking about posted writes.

Echoing Keith here. Why are you treating NVMe completions + MSI as a special case?
What's special about this combination other than two posted writes? I own JH7110
visionfive 2 boards myself, and if I'm not mistaken, there are two identical PCIe
controllers in JH7110. The first one connects the onboard USB controller of vf2,
which also enables MSI interrupts. How come this exact problem not affecting the
USB controller? The commit message from Minda strongly suggests it does, and also
for R8169 NIC. Thus, why would you suggest the problem is confined to NVMe?

Bo

>>
>> Sorry, we made a casual conclusion here.
>> Not any two of inbound post requests can`t be kept in order in JH7110 SoC,
>> the only one case we found is NVMe completions with MSI interrupts.
>> To be more precise, they are the pending status in nvme_completion struct and
>> nvme_irq handler in nvme/host/pci.c.
>>
>> We have shown the original workaround patch before:
>> https://lore.kernel.org/lkml/CAJM55Z9HtBSyCq7rDEDFdw644pOWCKJfPqhmi3SD1x6p3g2SLQ@mail.gmail.com/
>> We put it in our github branch and works fine for a long time.
>> Looking forward to better advices from someone familiar with NVMe drivers.
> 
> So this platform treats strictly ordered writes the same as if relaxed
> ordering was enabled? I am not sure if we could reasonably work around
> such behavior. An arbitrary delay is likely too long for most cases, and
> too short for the worst case.
> 
> I suppose we could quirk a non-posted transaction in the interrupt
> handler to force flush pending memory updates, but that will noticeably
> harm your nvme performance. Maybe if you constrain such behavior to the
> spurious IRQ_NONE condition, then it might be okay? I don't know.
> 

Also copied Keith's latest reply below, and I also have the same doubt.

> Hm, that may not be good enough: if nvme completions can be reordered
> with their msi's, then I assume data may reorder with their completion.
> Your application will inevitably see stale and corrupted data, so it
> sounds like you need some kind of barrier per completion. Ouch!

