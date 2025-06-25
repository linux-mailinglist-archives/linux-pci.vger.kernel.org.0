Return-Path: <linux-pci+bounces-30639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E817CAE8CF7
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 20:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9B67BAB3E
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B012DFA3D;
	Wed, 25 Jun 2025 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpvlLuDe"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449132DECAE
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877032; cv=none; b=qH2Wb7j7Sf7BqCUhbLfRO4KMYV7nA2Aqm6zlh/YO2QFC++plPplDlzwj7prqazfknQlkwyH68kWW+O/39wtA7JaIp0l9k4GgdRbyzzvLbZLaUp9LIjUthlOBsnmQcyxSxFWRx+AOekC5iTdeIUjJPyWTp3yxcRtk6QXFB5bI184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877032; c=relaxed/simple;
	bh=OKwCn9nMtCrh7A1p8wSY3LMlYeqvq9ekkcCgYTWGuSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+Ye+/Xi+B+1Yg50ATHhUd4czQ8ulO1t0NztHEEAtC/mDWVZYYmcbuDY9bMI4vOaYykUj83FFpmf3mOS2SBIWo1mW3rgUKIYPkn4+gXPyLhoUMqKohsOUZEOp9sfWg3HOIkqOWigh1I9XyuMIKR5fcQwyGdv8MM06La0c3UAsVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpvlLuDe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750877030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfMGLbUmp82Vp8zLQyE3ZcrJ967ELQfIfMW3hfSNO04=;
	b=BpvlLuDeZh/V3OVj1AMEQf8mLDqk3d/TpqlRb+NKWcWPUBoPzfXogByjgyKxfrTvJQAjDu
	7TuvKnF3oRXOeRRjoULdZeyqN2phPsxz29deX5l8qEYC6nqGzUIuehtxNAIxtK+DBpKF7Z
	/tIJ3FttnGxRivY7P4RSKoeMKUW/XU8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-j6-7de4iNROhQHOmy67Jmw-1; Wed, 25 Jun 2025 14:43:48 -0400
X-MC-Unique: j6-7de4iNROhQHOmy67Jmw-1
X-Mimecast-MFC-AGG-ID: j6-7de4iNROhQHOmy67Jmw_1750877027
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ade6db50b9cso18014266b.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 11:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750877027; x=1751481827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfMGLbUmp82Vp8zLQyE3ZcrJ967ELQfIfMW3hfSNO04=;
        b=URp0sX8J0JIFxqp8Oi2UdRYWn0JLb+whx/4ZDo4qifvVMoZhOd1w0R323n3uEYvTkt
         1PyHsZEK/nYuCL6ZI/MeKwLxq/9uN7yG+tM4Y9yzs+kJujKBJvY6UxPNAG+TcOs3B7cz
         yjHfKNPyoLRsBgqioh2Q48cYM/vdWCj+IYFBQXavgBSW77zinrYckeftWet3bvmAzOqu
         Ldp7UM9tMXO0P54ez0jWJ7zewWYphycndpHIIXhvbkzckgiq7fQav6vt+obHWDf5S9Ux
         wS6M1p/EiHWi7yIsnN96obbA7e/xpJv33ZBulkjZxxbcfpOJLVaJhLONet+XYZ3tOs/z
         BsmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6/wWNZukeY1kgpD4HrQ2a6VW2TyWi6zzFnn5vrBCgjjPlBhm5d/2MOcCBRA1FEtsHBjxyASeHj5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXT2xXKkXULI7reQTttW/TOBiHLc3zGdMdsB+UsJTubpGE3vx5
	WCwkWmOUnAXzM7vc8vqI/cLO4buNB2Dma/zL1zeajEA91ZAG5LJOVvZo5W14d8q0nKzUI8MXW98
	9WXj5xf23Zh1afvhpwVoirCtMVE1MwEHVz7OtuPy+E3Bs4MtURRBSn2Dixuj2AA==
X-Gm-Gg: ASbGncuhERdvmeDG7mPOKr9DHhlIgID7Bv9Wzi/ShE0UYQmtgOya+KbZih3jCnIAu4T
	TNcyXb/50/7tSLSKYiwftmKeQTvaP90tcpMnBE9UPIaSI3zkTPbYiQK8wbbaI7y7DxbwzxzZ/Bx
	+4nCiu/Ll+9hFhbOTTAdI1AsPlMqro0FA8w3QZFPFhgn08+uig84IYzmqUzuyjF9jvgieDiLUad
	g+KqlNZMGl1nKIl6aMQJPZdE/Z5zI3sdKMYumMGWBlMSF8LpnPbGcut+wKv5IXEUJTjs9mqj/aG
	pNZHoCotjiULe6scFk8KA7iKsxlQsKbI/NtL778Rm9OdC0XPDGcifK8ob4i8rvxqdTvgHbs+0nK
	YnZuekb8/bAXuSaG8sFqhfhR213PhOGr8zRDHDWdKp/wmN+8StoZ8R+JDLmmtpajmDc0Oa8IhVg
	==
X-Received: by 2002:a17:906:4fc9:b0:ae0:bd4d:4d66 with SMTP id a640c23a62f3a-ae0d0bcaf6bmr112315666b.27.1750877027402;
        Wed, 25 Jun 2025 11:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6yAfvOAABPEeadvXNEjRArNtdC8kCRJRHcRqV9aMzVyjyH3zlO48tY6N9PtKcjd+DMp4mkg==
X-Received: by 2002:a17:906:4fc9:b0:ae0:bd4d:4d66 with SMTP id a640c23a62f3a-ae0d0bcaf6bmr112312966b.27.1750877026869;
        Wed, 25 Jun 2025 11:43:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0a9e514f9sm349350466b.63.2025.06.25.11.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 11:43:46 -0700 (PDT)
Message-ID: <eb98477c-2d5c-4980-ab21-6aed8f0451c9@redhat.com>
Date: Wed, 25 Jun 2025 20:43:45 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] agp/amd64: Bind to unsupported devices only if AGP is
 present
To: Lukas Wunner <lukas@wunner.de>
Cc: Ben Hutchings <ben@decadent.org.uk>, David Airlie <airlied@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Andi Kleen <ak@linux.intel.com>, Ahmed Salem <x0rw3ll@gmail.com>,
 Borislav Petkov <bp@alien8.de>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org
References: <f8ff40f35a9a5836d1371f60e85c09c5735e3c5e.1750497201.git.lukas@wunner.de>
 <b73fbb3e3f03d842f36e6ba2e6a8ad0bb4b904fd.camel@decadent.org.uk>
 <aFalrV1500saBto5@wunner.de>
 <279f63810875f2168c591aab0f30f8284d12fe02.camel@decadent.org.uk>
 <aFa8JJaRP-FUyy6Y@wunner.de>
 <9077aab5304e1839786df9adb33c334d10c69397.camel@decadent.org.uk>
 <98012c55-1e0d-4c1b-b650-5bb189d78009@redhat.com>
 <aFwIu0QveVuJZNoU@wunner.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <aFwIu0QveVuJZNoU@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Jun-25 4:33 PM, Lukas Wunner wrote:
> On Wed, Jun 25, 2025 at 04:08:38PM +0200, Hans de Goede wrote:
>> Lukas made me aware of this attempt to fix the KERN_CRIT msg, because
>> I wrote a slightly different patch to fix this:
>>
>> https://lore.kernel.org/dri-devel/20250625112411.4123-1-hansg@kernel.org/
>>
>> This seems like a cleaner fix to me and something which would be good
>> to have regardless since currently the driver_attach() call is doing
>> too much work because the promisc table catches an unnecessary wide
>> net / match matching many PCI devices which cannot be AGP capable
>> at all.
> 
> So how do you know that all of these unsupported devices have
> PCI_CLASS_BRIDGE_HOST?

The top of the driver says

 * This is a GART driver for the AMD Opteron/Athlon64 on-CPU northbridge.
 * It also includes support for the AMD 8151 AGP bridge

Note this only talks about north bridges.

Also given the age of AGP, I would expect the agp_amd64_pci_table[]
to be pretty much complete and the need for probing for unknown AGP
capable bridges is likely a relic which can be disabled by default.

Actually the amd64-agp code is weird in that has support for
unknown AGP bridges enabled by default in the first place.

The global probe unknown AGP bridges bool which is called
agp_try_unsupported_boot is false by default.

As discussed in the thread with my patch, we should probably
just change the AMD specific agp_try_unsupported to default
to false too.

> The only thing we know is that an AGP
> Capability must be present.
> 
> In particular, AGP 3.0 sec 2.5 explicitly allows PCI-to-PCI bridges
> in addition to Host-to-PCI bridges.

Ok, so we can add a second entry to the agp_amd64_pci_promisc_table[]
to match PCI to PCI bridges just to be sure, that still feels
cleaner to me.

Regards,

Hans



