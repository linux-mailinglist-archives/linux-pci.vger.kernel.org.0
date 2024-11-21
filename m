Return-Path: <linux-pci+bounces-17153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFA89D4AE7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 11:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164501F22093
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 10:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487101D04A0;
	Thu, 21 Nov 2024 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVuMSOp7"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A3B1CACD6
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184920; cv=none; b=aNeGav+3nAfzU7KBgKmW90uJmFlg5a9Wf7mSqa7YaOI2rrjqlh9j5LeLPsSOGqen4O4pOvx82w+PVGyH7TiLKtLXBOXbEKZrhz/Ox4X8j73pElWrLBGjARt/AvC3B0+/mcPDHldkgObjH+g9EptDXe13VdVfJBm23nYBTMAOfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184920; c=relaxed/simple;
	bh=sKzohGaYqI7jAfKfMkPF4Mb7mwMdcuQHHA0ja+FhXVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFYPzqIwKBt6ge8SQBl7ulYt+lhfecdBBa9QXJw0da7P1LozMV3Fx7YllgumqWLVA/TnIutnAPBlH43ObAd7/cvs3lDeXISdbzajoAtA3VHF2Q0IEJuCgs0BJUB90hHl6LxHfhgoh41IqdX+F0gQ6GabJmR5zMxsuGm3lovFedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVuMSOp7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732184917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKzohGaYqI7jAfKfMkPF4Mb7mwMdcuQHHA0ja+FhXVI=;
	b=KVuMSOp7macoTFJZFSwq4mzHyq1NiuoZW2sOT/DIfrisX6G/y2kmJQi6E5Jj3Q7n5smR6d
	lbuGZRER9cWY2m4XRNEUVf6QAyWj0jc1WdrbTU8iQmsGLkmbrNB4OaPKoZpyhxVAgiOp9Q
	SlpsXPwjRKua2/+xTwEXkEatFl8CQbk=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-Iu0hFXDROHqZL0BQMm7k-A-1; Thu, 21 Nov 2024 05:28:34 -0500
X-MC-Unique: Iu0hFXDROHqZL0BQMm7k-A-1
X-Mimecast-MFC-AGG-ID: Iu0hFXDROHqZL0BQMm7k-A
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-514e7c4f648so264634e0c.3
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 02:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184913; x=1732789713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKzohGaYqI7jAfKfMkPF4Mb7mwMdcuQHHA0ja+FhXVI=;
        b=vy5N+pHHVWj6g77tpGGkTDPzK2bMbWUtN8oq+rlhNQR8uVb1kN6L2UitTkjgUe0KxK
         pBtN5nJIaapfGBoBnwI51UhTiUemt1NW1TiYARcFhykH6Ql6011O9oHb0c5XE6+f/QCn
         yzGaPch5loivsHY/z99PPHx9t/Rq9myqaWDQvERPJiSSDleu0lGzi1x58lhoXcDC/bWa
         n7r64cTj+RlhIJhqViTf2F+dgE9GJcUO0TTpQILBPgVvGXTnekdhM0dOghE/Wl1u1ETn
         K5lUAfqO7RbCpZn2A0qeZqlWizoQHNEOOIAQ5Zf0qFVeAs39+BKTcmKIq9fWJOnVNKQO
         PaTA==
X-Forwarded-Encrypted: i=1; AJvYcCV8l0c3CpEVQMEbExYbaJOMYXnHmQE3u7Mg849nzZpxTDArHETnyqxDXZn9NZY9aEPbJJlv/AvwzqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRQozZeQODdM77ia5N0HE8v1wshI22VAUXnr2O5IhO+gGGweFD
	4gEz1D3R+bWe1HFXM5gCneObGfRUw3zZPN2JF7tfncbCr6UDmulGeFeFFEn+j7DD9Snklj7O18W
	+w8VvRmd6Xu9uQYXbHKVjN79iu5ZE9+x57fgJIwpI5aj5i2joPhrK3phDkQ==
X-Gm-Gg: ASbGncuHrMZZk3mtv301WEhSXruZY0I+F3xyWQdgNSRp+vTwjMiBsujp3/GIFhfIbx5
	NqmKYUOCwYAgyXNkgmuXDiHopX5Shq0MRfo8lF9mdPCa+OeKXXN6crEX+JyogkqtfsNslNhENKj
	pJbnnIhL1Jgb587UziCfoCyLLNTEkDUHblUl61JuKDSfQLtPANPdIPAgAoJCLd8X9nHJAPFV8wF
	adJtLn5323KRTObyF2t66oD0fDYgdOIAfUIJ1dZ619ssBFin8kSnRbUWSh0yMu5xAE65AiXQA==
X-Received: by 2002:a05:6102:3e07:b0:498:ef8d:8368 with SMTP id ada2fe7eead31-4adaf4bb33fmr7794356137.13.1732184913240;
        Thu, 21 Nov 2024 02:28:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvNgLLYktvPtaJaBpniqt/2h5wYTqtk6DE591nq3WhjRfvS6UaO9CP9BTTqW5PKVBbtxtxGg==
X-Received: by 2002:a05:6102:3e07:b0:498:ef8d:8368 with SMTP id ada2fe7eead31-4adaf4bb33fmr7794340137.13.1732184912953;
        Thu, 21 Nov 2024 02:28:32 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4646ab21517sm20273601cf.82.2024.11.21.02.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 02:28:32 -0800 (PST)
Message-ID: <4f621a9d-f527-4148-831b-aad577a6e097@redhat.com>
Date: Thu, 21 Nov 2024 11:28:28 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/MSI: Add MSIX option to write to ENTRY_DATA
 before any reads
To: Dullfire <dullfire@yahoo.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mostafa Saleh <smostafa@google.com>,
 Marc Zyngier <maz@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241117234843.19236-1-dullfire@yahoo.com>
 <20241117234843.19236-2-dullfire@yahoo.com>
 <a292cdfe-e319-4bbd-bcc0-a74c16db9053@redhat.com>
 <07726755-f9e7-4c01-9a3f-1762e90734af@yahoo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <07726755-f9e7-4c01-9a3f-1762e90734af@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 10:22, Dullfire wrote:
> On 11/21/24 02:55, Paolo Abeni wrote:
>> On 11/18/24 00:48, dullfire@yahoo.com wrote:
>>> From: Jonathan Currier <dullfire@yahoo.com>
>>>
>>> Commit 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
>>> introduces a readl() from ENTRY_VECTOR_CTRL before the writel() to
>>> ENTRY_DATA. This is correct, however some hardware, like the Sun Neptune
>>> chips, the niu module, will cause an error and/or fatal trap if any MSIX
>>> table entry is read before the corresponding ENTRY_DATA field is written
>>> to. This patch adds an optional early writel() in msix_prepare_msi_desc().
>> Why the issue can't be addressed into the relevant device driver? It
>> looks like an H/W bug, a driver specific fix looks IMHO more fitting.
>
> I considered this approach, and thus asked about it in the mailing lists here:
> https://lore.kernel.org/sparclinux/7de14cca-e2fa-49f7-b83e-5f8322cc9e56@yahoo.com/T/

I forgot about such thread, thank you for the reminder. Since the more
hackish code is IRQ specific, if Thomas is fine with that, I'll not oppose.

>> A cross subsystem series, like this one, gives some extra complication
>> to maintainers.

The niu driver is not exactly under very active development, I guess the
whole series could go via the IRQ subsystem, if Thomas agrees.

Cheers,

Paolo


