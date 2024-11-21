Return-Path: <linux-pci+bounces-17140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E99D4954
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 09:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7C21F21B1D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 08:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A5C1CCECC;
	Thu, 21 Nov 2024 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtkEgbv1"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5F1C1AD9
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179355; cv=none; b=T0Nd5UW6tQfi74/TNbSS4x5A6Mzue8EsVKbDN1RqC86QeuADkq3UBM7LimFhcCbTxLrP/ofsGyv+K4QfoP0kpw2FmwxAqVsuygRjA2nmcaZiM7v0MX9T3ztlpZvSKFBLSNB/9iC7eoo7SYRTBH2xz9UsZ91VxoZwl2St4AJaXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179355; c=relaxed/simple;
	bh=K7AkL0tto6CDdGlimdcgf6Xn1JT1cRBDjbJ0bR7LQ/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyF+say0KM26KnBApn8KuGLC+X9XOR+zwzhEA6Mpb5ZWnR+0HsbUmzlPZDY7kT2Xbp7T9ujz2MVihP6RH9vjpBWSWIpMCMNo7PEuW41jVg47X8J8p0Mq1FX/JfjSxusQxNi6QYSKn6W6+iTyKKjzRZFJoTqeC6RzoJxYPuFJrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BtkEgbv1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732179353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlA/Dao4HWIor+ViY9VXGE+zRi2NDg4RCE9H6BNgMBg=;
	b=BtkEgbv1pkpgWk9l3nU5Rqnnkzu5Tww5JZjq/6v+qANqrZozbbZLHGfiB1AJs6G9b6W8MJ
	c8z1FzVGSEBEN8tFgQoKzxlU6lQWpk9Epfv4FwHgd3SMFmQA5JIggAnyyJ5dulg7wRK4hu
	6cKrwUQw6/h/HaZLIHolcK7JcSJ7wuo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-5uoUK-FpObGrdXILDyw6-g-1; Thu, 21 Nov 2024 03:55:51 -0500
X-MC-Unique: 5uoUK-FpObGrdXILDyw6-g-1
X-Mimecast-MFC-AGG-ID: 5uoUK-FpObGrdXILDyw6-g
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-382342b66f5so358823f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 00:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179350; x=1732784150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JlA/Dao4HWIor+ViY9VXGE+zRi2NDg4RCE9H6BNgMBg=;
        b=uheiiKVtZF6Qv0aQPTTOQYerIahc5hDeBscMM2eqOFO6E3lG9+9qgWJPQF40ZrUQ4H
         mTDkV/VpnQB6jeqeNMPp1Fo9Xh9W8a0oqvFjrEpDyi0Uck9jDJFivba5gyXLX3I6daLf
         yVQIOqXI4Jt2MTaIruXZuq5sO+uWJk7FKGcHCKxLd7G5KNeN/VmL5lM+cqf705RkCexC
         3hSCJPBiGdncgysAsPp0dAz/xKOhwisynmBKEGE+3QCVTqDNxEHLoYqklbjcWpEAPvym
         Hefh+ryaKQjR7Uc0KX24ZvxfN1p7fOpqzC0K9d3723C+JdTqUDnJ2b7e+uTYXRyTqdQ8
         QwHA==
X-Forwarded-Encrypted: i=1; AJvYcCWQCViCvkMz5qO1JrNvz+G8so1jfT89O3zRNr4Vr5p1Puh9Gtj9g3BpCetUN+KOOByAdAktN/PzFW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+4fn8THInpudkbKZPkLE3zrt0JKTYBGdSfmqsSlketui1IHe
	kKVGOqxvCs2vd2lBaFlWuyQp/F0E917ckWBQhtXPstKcz2ivICesuv9fCuzbV40lGIbl4C0/ZQC
	p5qSWFHY7IIvGQIP7s0KbMTxe194p4h4WAzTs+kaxjGtaePIimscp35cBOg==
X-Received: by 2002:a05:6000:18a2:b0:382:3cc2:537c with SMTP id ffacd0b85a97d-38254afacf3mr5058447f8f.26.1732179350522;
        Thu, 21 Nov 2024 00:55:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGS5uZ0+VI315ZPetn9/2pNfe8s+g3uPtxT0kC/eI2N51ikDPk7/rCHoqVcvf29z/wcQT0Z1A==
X-Received: by 2002:a05:6000:18a2:b0:382:3cc2:537c with SMTP id ffacd0b85a97d-38254afacf3mr5058426f8f.26.1732179350210;
        Thu, 21 Nov 2024 00:55:50 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254933d1asm4348786f8f.71.2024.11.21.00.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:55:49 -0800 (PST)
Message-ID: <a292cdfe-e319-4bbd-bcc0-a74c16db9053@redhat.com>
Date: Thu, 21 Nov 2024 09:55:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/MSI: Add MSIX option to write to ENTRY_DATA
 before any reads
To: dullfire@yahoo.com, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mostafa Saleh <smostafa@google.com>,
 Marc Zyngier <maz@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241117234843.19236-1-dullfire@yahoo.com>
 <20241117234843.19236-2-dullfire@yahoo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241117234843.19236-2-dullfire@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/24 00:48, dullfire@yahoo.com wrote:
> From: Jonathan Currier <dullfire@yahoo.com>
> 
> Commit 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
> introduces a readl() from ENTRY_VECTOR_CTRL before the writel() to
> ENTRY_DATA. This is correct, however some hardware, like the Sun Neptune
> chips, the niu module, will cause an error and/or fatal trap if any MSIX
> table entry is read before the corresponding ENTRY_DATA field is written
> to. This patch adds an optional early writel() in msix_prepare_msi_desc().

Why the issue can't be addressed into the relevant device driver? It
looks like an H/W bug, a driver specific fix looks IMHO more fitting.

A cross subsystem series, like this one, gives some extra complication
to maintainers.

Thanks,

Paolo


