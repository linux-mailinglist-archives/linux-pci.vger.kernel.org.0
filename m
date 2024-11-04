Return-Path: <linux-pci+bounces-15994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1089BBE24
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 20:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB071C21C1F
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 19:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3791CBE82;
	Mon,  4 Nov 2024 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh9asJzO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500C1CB9F4;
	Mon,  4 Nov 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749239; cv=none; b=iqTqE3jJOXI+SgR0nyaH9yKIiNEQhd5CJk7OvbsvehY37cSKtTMS9IW3j6SRyD99dblTQsDN4mjC2c6lgsJNkajpM4Ysbyzh0LOCX7j8ZnfdBeBhPSyb2jETnNG+BC/vOj8Lab5KGgkObzvSgLuzo/BjPI8jtB6xpqo4KZm+t7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749239; c=relaxed/simple;
	bh=HshDG9cwpCUdjoLqNUKdEZ2Vt0um+DYEdKwUucQCB6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5X/RaiQDR2UOBU5XVgKo8MsFUdg94gp/Y134aS4ipmPi0NQYCqg8XEyPiVTfkMQHKEq80qx0NK5FpbmSY+KCi2JiONO6gVwDFCcGUcUljy5Rewr2/fH5LdsFyRA/eeYx/sqf9Ekl3tGWnriKWVShVSKTwuGeFZlC/jFJD1imhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wh9asJzO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9e8522c10bso330382366b.1;
        Mon, 04 Nov 2024 11:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730749236; x=1731354036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W4oXHflC0Jl7Q8WHg624vJhar0ZcwoESY/4D6gZdnsI=;
        b=Wh9asJzOAh4yv4zowLpPz++RrLHIC65DNC06ciSAjgsbRrT+jcSQWkKE9FC4Doe/h6
         eRXF28/OeptoITEHgd8RhPi4/MdXEOyTrm6d7dllHdQpUSKWDfPdyZUyQzEhN7NLdkzU
         vnKhhIOl3w4tv9olV0qr4aAknf8fmBk/BDOoiazY4y5jajluNrDl5jpAGxMOp/Ix9KGQ
         Vt9yBd0sS7pMhturC2v4mIK6V5vhkuzx8YMLmbWlPZu00Waq8L/gU0LqrX49pewKUZu0
         /YpAPm2Ijq+AwHZ5GU7SaTAKXFu8BpNOp2XAvCbM4hgOKybGTF09WSWiukqgvVbVBvWj
         RbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730749236; x=1731354036;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4oXHflC0Jl7Q8WHg624vJhar0ZcwoESY/4D6gZdnsI=;
        b=HTaO/VrhvPKQusdAqT98KBmBM+LKzL4ExjN0Qnprx2TU7rO6dV1CQIEVZZ6gMAErq8
         4fVCUMSnkM5Ehxygt8NwcXxsJHYP4uvtueKHfcsdeAoXWgk01Q8Dghv0rtbFgELtt5Eh
         xYaHLqPuryWHiRjHO4g5K+0qRcRe4HK/8E97WHiVQ9PjpFfh3KMH73/9XcNuwVtNlHZf
         ksVmYF32gxFnjy+fSyGD2nAPREEykV7dxfk2DenGp8V9g0RaByCFJPVrfBghWPWyWJYf
         MogCdl1i8b7VCtkf/ob0EluYFKIhrDXOJUgLhUuEeqvEntmemwLC2NQ6HDhfw4lCz8PL
         hq5w==
X-Forwarded-Encrypted: i=1; AJvYcCUeqDz1VS5nrVcbNxpzy0RLUNN/RTmpgvWKqBSuP4ISTD+4uhZlRsWFk4rfLXsCMYCPZ/wB2C6N3D75@vger.kernel.org, AJvYcCWI4wZCgdcydykdf8TkA9jK8rxdxhHDPDA2KNsBN9M0jkHnoz7erJ+GHz66kIL9wOVw6aQzV30W9wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaU7aSdU0m3VlJpi1rjSqKuHUuQFo/CbtG1i5yeiHPIt7RGSu0
	pKxudjjRf46pFX+wE+k8mjkusRN1Lhh/J1NhzWgZarbmbPUaYalbd0RZGA==
X-Google-Smtp-Source: AGHT+IED7Ffhj2HbnFtfLIZV7cbjU1sQHdSY3PSLJKc59rG/6GedDgeV+4G0TgAIqD+1u709b/e2Lg==
X-Received: by 2002:a17:907:74d:b0:a93:a664:a23f with SMTP id a640c23a62f3a-a9e559df7ffmr1371135466b.5.1730749236187;
        Mon, 04 Nov 2024 11:40:36 -0800 (PST)
Received: from ?IPV6:2a02:3100:9c2b:eb00:5887:d6c2:d681:2735? (dynamic-2a02-3100-9c2b-eb00-5887-d6c2-d681-2735.310.pool.telefonica.de. [2a02:3100:9c2b:eb00:5887:d6c2:d681:2735])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9eb17cf8eesm21359966b.92.2024.11.04.11.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 11:40:34 -0800 (PST)
Message-ID: <6ccdfa6a-1e04-4e6f-93d5-821f4f38d06f@gmail.com>
Date: Mon, 4 Nov 2024 20:40:34 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: Don't call pci_intx() directly
To: Niklas Cassel <cassel@kernel.org>
Cc: Philipp Stanner <pstanner@redhat.com>, Damien Le Moal
 <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <c604a8ac-8025-4078-ab90-834d95872e31@gmail.com>
 <ZyiGNtLMSY1vTQH7@ryzen> <8acdd01c-1744-4545-9cc7-0a60e83a5d4d@gmail.com>
 <ZykUO31aOfnCIkUH@ryzen>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ZykUO31aOfnCIkUH@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04.11.2024 19:36, Niklas Cassel wrote:
> On Mon, Nov 04, 2024 at 02:23:43PM +0100, Heiner Kallweit wrote:
>> On 04.11.2024 09:30, Niklas Cassel wrote:
>>> On Fri, Nov 01, 2024 at 11:38:53PM +0100, Heiner Kallweit wrote:
>>>> pci_intx() should be called by PCI core and some virtualization code
>>>> only. In PCI device drivers use the appropriate pci_alloc_irq_vectors()
>>>> call.
>>>
>>> Hello Heiner,
>>>
>>> as you might or might not know, this patch conflicts with a Philipp's
>>> already acked patch:
>>> https://lore.kernel.org/linux-ide/20241015185124.64726-10-pstanner@redhat.com/
>>>
>> I know, therefore he's on cc. Fully migrating PCI device drivers to the
>> pci_alloc_irq_vectors() should be done anyway and is the cleaner
>> alternative to changing pci_intx(). However for some drivers this is a rather
>> complex task, therefore I understand Philipp's approach to adjust pci_intx()
>> first. He's incorporating other review feedback in his series, so with the
>> next re-spin he could remove the ahci patch from his series.
> 
> Well, if you look at Philipp's patch it:
> 
> 1) Doesn't only update drivers/ata/ahci.c,
> it also updates:
> drivers/ata/ata_piix.c
> drivers/ata/pata_rdc.c
> drivers/ata/sata_sil24.c
> drivers/ata/sata_sis.c
> drivers/ata/sata_uli.c
> drivers/ata/sata_vsc.c
> 
> Why don't you update the other drivers in drivers/ata/* ?
> 
Because I don't have hw for testing the changes and usually I'm
somewhat reluctant to submit patches which are compile-tested only.

> 
> 2) Doesn't just bother to fix a single subsystem (drivers/ata/),
> it is actually part of a series that fixes all affected subsystems.
> 
> Why don't you send out this fix as part of a series that fixes all the
> affected subsystems?
> 
Because for some drivers it's complex (e.g. bnx2x) and I don't have
hw to test the changes.

> 
> Kind regards,
> Niklas


