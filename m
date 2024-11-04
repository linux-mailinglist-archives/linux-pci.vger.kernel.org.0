Return-Path: <linux-pci+bounces-15955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFEA9BB5DC
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBFB280D1C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 13:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079FCEEBA;
	Mon,  4 Nov 2024 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORBwIKq4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FBDAD24;
	Mon,  4 Nov 2024 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726627; cv=none; b=VfNPRL4sbrjOvR3DhQY8Nk5WJVUVvV063CcgWt97yQy0ZYImDjSU9vZOWAhoQgjHNnriygdxEd1bgUWLwjPh6NnyvPkANJz3OPaNCAWe8QnKJobZrFOwn8pdCcVi0KALD4LDdqasLKoVNK88crLimCTTPNIPuVeLMDtj1i0FT38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726627; c=relaxed/simple;
	bh=P7QI57CxAQa9VU4sqby7gvOGAsA/VumFML+UImnGOhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZvnnO1BqwzxXVEIIbSTFcl7Kd5flWrPVeZxysjZ8BAwZgbqZl/S1hYAgCUPGcXSSb4yDmjPsRaQNgpaI5ZvEbMLmcDCGJec2CQG8er5jGJ4Ve4kne81EfmL4HI9mgTrFIy11TUp7zgnJrUDnX01q6qTHtVvHvzj4NYlB1/CdxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORBwIKq4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a68480164so665676866b.3;
        Mon, 04 Nov 2024 05:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730726624; x=1731331424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lcm9hg8ZlLTpzsLKubtK2dBr2x4blOaIQS8RO6R+HCA=;
        b=ORBwIKq4rwZdRV0oC+QRaBNYAXtqa6YN8/FWfQNsMz6O0ozn8jHimbzsAYoxUUYwIn
         vxU8hqEKlcGJn7UY0xboScvPZ855/Xjqx9lcjMA4BR/cLEbzULCpLfriY5ez/zcNrdjO
         BtneCRcXKZiwzahr1QTrGH1emFnSrp3fGuldZBjmTa3HZJLJ2LmozApBoFBsCOyoTfo2
         8MHwheOpsgmXCNJIecdd+a/+X5j6olh7rcPHOt/Ql6SqmCodLkHJ4h1SJi+zk4wknLvn
         juDzcN4X1aVWzc12vCIlUJSGy707bSwcGQNWVgrpd8G/+C0V78aRw8UOipUqX3bWtvwl
         fr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730726624; x=1731331424;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcm9hg8ZlLTpzsLKubtK2dBr2x4blOaIQS8RO6R+HCA=;
        b=dg3trlsZLzDayWcBhIaAs17Tl6WUou2S5itUHtBcq4fC4+57wpPRansCdR8QV4sZng
         s4Q6T1kKkHDG8Ynr/TUYTqEFYSxsHNRu5jJayZJ7c+aENDWdTp+hu9DCG0dhR8v1vMfK
         co9S0kCUecaelTr4dO+k/4k9Mkls87zh4og87NWYAXh9JXhWnHuxiF8jdd0KvD+YahPJ
         T5Mj/4vgA0YV8tALf7zpbPe3trYlXD1zKBtEflye+ZJynhvpktvx7Mvw2/G7i7OcHY0f
         9FzEsXvlYSfMTH95hKlJEFwlzYzX3MFgTOH7MxoUqzgrYHdsaKBb4IiuwqUraH9d8+kS
         94+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtW6u8nfyrTaqWr/wid0gG5HUwVU9TBJw0ISV+LPxfne0LsFeobCTAYYOhMgkFOhg0L75BQkSIJ6/5@vger.kernel.org, AJvYcCX8HBdjesS3v/gxsbiN4we5wKHdmWo4OFYJfs3NnMfQJ7DnPTSg2zHwGMTGRmzXaY6k73XMaR+2d5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YweOTsbYI9EcSWL7NQ9GxMghO9vuORrCYNJ/uXJz0R1ziCPm7m4
	XITqncNgg7+s6LM20WjvcL/bTs7vnoRDmdLuxH/DSpm29TNf5JmWJJB/MQ==
X-Google-Smtp-Source: AGHT+IGMXs/OhsmrYuF/kyOzYOK/S6N747FR2p9b9/DU2tBkpzp+QumUjXeOOESSlWG+h2vKrIBFnA==
X-Received: by 2002:a17:907:944f:b0:a9a:825:4c39 with SMTP id a640c23a62f3a-a9de5d00e3emr3517928866b.20.1730726624239;
        Mon, 04 Nov 2024 05:23:44 -0800 (PST)
Received: from ?IPV6:2a02:3100:9c2b:eb00:5887:d6c2:d681:2735? (dynamic-2a02-3100-9c2b-eb00-5887-d6c2-d681-2735.310.pool.telefonica.de. [2a02:3100:9c2b:eb00:5887:d6c2:d681:2735])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9e56498413sm551066066b.32.2024.11.04.05.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 05:23:43 -0800 (PST)
Message-ID: <8acdd01c-1744-4545-9cc7-0a60e83a5d4d@gmail.com>
Date: Mon, 4 Nov 2024 14:23:43 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: Don't call pci_intx() directly
To: Niklas Cassel <cassel@kernel.org>, Philipp Stanner <pstanner@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <c604a8ac-8025-4078-ab90-834d95872e31@gmail.com>
 <ZyiGNtLMSY1vTQH7@ryzen>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ZyiGNtLMSY1vTQH7@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04.11.2024 09:30, Niklas Cassel wrote:
> On Fri, Nov 01, 2024 at 11:38:53PM +0100, Heiner Kallweit wrote:
>> pci_intx() should be called by PCI core and some virtualization code
>> only. In PCI device drivers use the appropriate pci_alloc_irq_vectors()
>> call.
> 
> Hello Heiner,
> 
> as you might or might not know, this patch conflicts with a Philipp's
> already acked patch:
> https://lore.kernel.org/linux-ide/20241015185124.64726-10-pstanner@redhat.com/
> 
I know, therefore he's on cc. Fully migrating PCI device drivers to the
pci_alloc_irq_vectors() should be done anyway and is the cleaner
alternative to changing pci_intx(). However for some drivers this is a rather
complex task, therefore I understand Philipp's approach to adjust pci_intx()
first. He's incorporating other review feedback in his series, so with the
next re-spin he could remove the ahci patch from his series.
> 
> Kind regards,
> Niklas

Heiner

