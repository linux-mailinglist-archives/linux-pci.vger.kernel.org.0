Return-Path: <linux-pci+bounces-16055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F369BD10B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 16:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B341F21A33
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF55213E04B;
	Tue,  5 Nov 2024 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcLvUESt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB713AD39;
	Tue,  5 Nov 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821872; cv=none; b=CDHvkId39fAoivAhiP67UmqiSITSCvVxan9SjIYy2hdTP9TK+Vlw1WOr2vU7YjnSPxg7bTnHFJp9IwRMqvoXpQUlpZhSQt4POHlJHguID1rlYTfNZzuasqkCafzHmaNpKZu33Le0RUK6LA2mkWAJAQYOkPU1ZzT53T8x/casQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821872; c=relaxed/simple;
	bh=9gg64+zLzmScB6rLE0xyrG4oPXaPJh5aBqZd4X+MNxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5YFsyIHt4y3XQUBAGOiY7ONptuAv27RUIeokCVLvZk0I0pGVtzf2qsaLUGxjJ09aWxwds3JVasTVL04sgBWHHLH98vw0Jws9tSrW6kBH+FErxv9glKw3HHp3Dt+xjBgl4D1xeIFuLBai2IGa5FuQvjKsoDQ3VbKfhMvR6Yid4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcLvUESt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9abe139088so830569966b.1;
        Tue, 05 Nov 2024 07:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730821869; x=1731426669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=doXGW9SwLVT8y5B8i7/1kg9DRr5jPtqPNvFumlRofGY=;
        b=XcLvUEStx4KPEpMLsGXAET9sokMC0gmuth9M1CPhtf8W0d0V5lnLFnmtgs18/6mIHJ
         HvWocK/U+Vn5BhllD7uWNO6CYmB+Kw/hf+LxGvYnv0mJ9uBg1lB1aJzNZmRR5oOn/V9t
         jouAf38zgPQm5SGJlqzmXKjVepKtg6bNbTBqLWfpnz8ODG8q6EDw8/p/xDLF2JZK4Q64
         D/S1JU85qFY3dDi73/DuyCVpiUCgHP8YWIZtynI86nQPf8AlcPBiHDv7lYCL9OceVb6O
         rKYxxlzMTl4tJKvwFDDMIpQ2nC1CBgXJvD7GCIjWEr0sucluz0jjTzNPmwPN3mTR2zrO
         UDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730821869; x=1731426669;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doXGW9SwLVT8y5B8i7/1kg9DRr5jPtqPNvFumlRofGY=;
        b=W+BZZeLRtJJ2biREvPuxbl7FY7/ewZovo3Yz+X6aKDE91WfZPIAxbJBtJvc9YDSvzD
         KMcSBziTkQl2sGwbI1X5IwmaquGUZCume/HTthwPzaQX2f/IEYYVd5bpG+EWpRi2M8uM
         hzq69wq5OMHUci9Ro5fBoDMp9Pnipsx7oFkygQ98jvRIQPfUlovCKdFAY+12ZlYjqqg+
         lAY3RD/KcC8vIpyn1I7je14Q53oUPtoUFA3YXNljdyzdWbeaPhcHJT/XJ2XV1vuP9Pcs
         WTjCZag84dSbIZOrMWmyXRCEo92jEze9uu5xGEITyHFs0qTPi/jVcBrSemI/O/WMmTlY
         J7ww==
X-Forwarded-Encrypted: i=1; AJvYcCUvIhaodqXzdVbBhLdAk4XmJgVxIhgEGCGzPCOnCl/BwgFAPAwyLflujqHQs70nu+z5SN1hUhM5u/YY@vger.kernel.org, AJvYcCXc8QQl8/JqP6Lmk4uuNZzkaUZL6Nq39cihl78Ug8/EmiobIzVtLmNJXraVGYwDnKXRTYErek3GP4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+O1uuyhf38VcgwlNYlrJD0uIfrK3GDx87l7YRqwBHcbMkkXDm
	DU8+lt/MyhO4dhER8Q/TvlMXwBzgp2Z+eyJOciObC8sKOeLg9YmuqD9tUA==
X-Google-Smtp-Source: AGHT+IGCL0LkR9BukZ3J1kidFbtscUrWz2BmaYIfXHBnwHDo85ebk1DKiCbfK5tTNHSQLXNxXD0Jsg==
X-Received: by 2002:a17:906:1983:b0:a9e:8612:eeca with SMTP id a640c23a62f3a-a9e8612f052mr988538666b.48.1730821869121;
        Tue, 05 Nov 2024 07:51:09 -0800 (PST)
Received: from ?IPV6:2a02:3100:a5ef:5e00:8091:2c62:bec6:13bf? (dynamic-2a02-3100-a5ef-5e00-8091-2c62-bec6-13bf.310.pool.telefonica.de. [2a02:3100:a5ef:5e00:8091:2c62:bec6:13bf])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9eb17cec79sm152098866b.105.2024.11.05.07.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 07:51:08 -0800 (PST)
Message-ID: <c6cfefcf-ff1e-4194-9384-67eeea77c346@gmail.com>
Date: Tue, 5 Nov 2024 16:51:08 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: Don't call pci_intx() directly
To: Philipp Stanner <pstanner@redhat.com>, Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <c604a8ac-8025-4078-ab90-834d95872e31@gmail.com>
 <ZyiGNtLMSY1vTQH7@ryzen> <8acdd01c-1744-4545-9cc7-0a60e83a5d4d@gmail.com>
 <5e56bf9bd7b65ecbf1bdb0af8569c4548c335220.camel@redhat.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5e56bf9bd7b65ecbf1bdb0af8569c4548c335220.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05.11.2024 16:22, Philipp Stanner wrote:
> On Mon, 2024-11-04 at 14:23 +0100, Heiner Kallweit wrote:
>> On 04.11.2024 09:30, Niklas Cassel wrote:
>>> On Fri, Nov 01, 2024 at 11:38:53PM +0100, Heiner Kallweit wrote:
>>>> pci_intx() should be called by PCI core and some virtualization
>>>> code
>>>> only. In PCI device drivers use the appropriate
>>>> pci_alloc_irq_vectors()
>>>> call.
>>>
>>> Hello Heiner,
>>>
>>> as you might or might not know, this patch conflicts with a
>>> Philipp's
>>> already acked patch:
>>> https://lore.kernel.org/linux-ide/20241015185124.64726-10-pstanner@redhat.com/
>>>
>> I know, therefore he's on cc. Fully migrating PCI device drivers to
>> the
>> pci_alloc_irq_vectors() should be done anyway and is the cleaner
>> alternative to changing pci_intx(). However for some drivers this is
>> a rather
>> complex task, therefore I understand Philipp's approach to adjust
>> pci_intx()
>> first. He's incorporating other review feedback in his series, so
>> with the
>> next re-spin he could remove the ahci patch from his series.
> 
> As I have stated before, this is not just about cleaning up pci_intx().
> 
> Again:
> pci_alloc_irq_vectors() USES pci_intx(), and my series does address
> that in its MSI patch.
> 
That's clear. The point is that in the end only PCI core and some
virtualization stuff should use a low-level function like pci_intx().
Device drivers should never use pci_intx() directly, managed or not.

I think all the hassle with managed intx could be avoided if PCI core
would unconditionally reset register PCI_COMMAND (or at least the most
relevant bits) to the initial value on driver exit.

> If you want to help, a careful review of the MSI bits would be helpful.
> Your patch here uses pci_intx(), you just don't see it anymore.
> 
> That said, in principle it's of course possible for me to drop patches
> while we're still in review, but I tend to think that it's causing both
> you and me more work if the pci_intx() vs. pci_alloc_irq_vectors() is
> worked on out of all times right now.
> 
> It also causes more work load for the reviewers, since they'd have
> reviewed my patch for nothing and would have to review yours then.
> 
> Also be aware that I am not yet sure whether the devres aspect should
> also be removed or made more explicit in MSI. Take a look at
> pcim_setup_msi_release().
> 
> In the worst case you might just replace one problem with another
> before we figured it all out.
> 
> Regards,
> P.
> 
>>>
>>> Kind regards,
>>> Niklas
>>
>> Heiner
>>
> 


