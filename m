Return-Path: <linux-pci+bounces-36552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E4EB8BDCE
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 05:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47032587CA8
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 03:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E618DB1C;
	Sat, 20 Sep 2025 03:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrU3colO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87371200C2
	for <linux-pci@vger.kernel.org>; Sat, 20 Sep 2025 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758337497; cv=none; b=CWV54EN83xzjXTKQRl1MG0uHOzGSK7O5fb/I2q3Jw2Qv0iOotpKaly1QstyFenf/JBofHKydPb45oEgrZ/hXcOFrtje8enK1PUf7uO6QjqEDDUJXf0SojX7QsJCVRhvP9xKLZUKORId52TRyoS8B5Eo7FMjbXE6n7JL6DMxdndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758337497; c=relaxed/simple;
	bh=2cEgIsB74CmbK5TCfodP7o3Hjb2jir0HhFaDSWp+kqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPc8NWIjb3ontuxAmFtsuITQMipQwscHzI3a0W8lYCybE5iS41fMCoQ3IzuP0NBPXEkWOog1cyXPs0Uv3F4acho9sxkjG/lr+nJHI+SUQAfR5YGrPZccB1xshhfLjbaUVlLuBNIhxDCSm0OGfFpSuGeTSdI6y0+4gyFAUc6xHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrU3colO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-33c9efd65eeso25750621fa.3
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 20:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758337494; x=1758942294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AxDowc6Vgu9lyfm19bEGVxYXnP4qmjMMcZtbU7ZCpgc=;
        b=NrU3colOj4aWrVhanhpOEtujqFJ26abRFOSVw5q7GzTcpIeu4TO9acd+ywYbQVV1r2
         cNUOIMiRSbCVhbnyrc5o88XybuqIyJCrVo3Remfh1TNakS7VBZz1sZcHyPUk65l0K/Qz
         DN0QDtsBgcSz9ZeTykBn679Q7WZjKqoVgRJu3hYZDyFmxwRgwbqhbUdT3XJZskInxgdW
         OzKV7vvgSlQbvg2SmtRCRzz1kSeRm1pphunAt/tNxIYgah8NS66hVeUer/pMneO6Liz6
         1zRviDhXGc2GvBreBK4SlRFZCGBco9MaJCLWGyFd+Bunivx/JwmzvLsaIp07NFbxZjFn
         8xSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758337494; x=1758942294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxDowc6Vgu9lyfm19bEGVxYXnP4qmjMMcZtbU7ZCpgc=;
        b=CNuFNgIFaflPDO8Jdm/rYKqrDhxAqU07Xr/uTKj7OtZuUIWTiCTeC2oRWn71ujRO8P
         f9ewepHy42wpQk3ZOmM050L9rwe3wL7I/+vzzW8qCJUBgdZJ0uMCan2mU+xXYFNp3nLU
         8h9pQLB99eOvmf75n2xy9NSGcUMGGYUswZaUY7MYfdgPoBXD1uSy+zYSHcWNnGKrJbrk
         lnCnoesw21sXosq8W23ctyWJ5aPC6o4O4MWhZBzD16tnmCF6AKWz8KYiuD3kgl0Sx1Rg
         y+TyUh5fqjI40TAtukjzHPYiQ4gTr40WJuc2ziJx3XKZ/Nv+imxc/EB+hyFIwMO+xiE4
         BDcg==
X-Forwarded-Encrypted: i=1; AJvYcCUiAIBhhnudLbgmHda1WkUk1hUlpU2WDIrIJNVPMK2Loi2jPwwhZPgmPY/1CyHNVPRUfUR+s0WuDv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8uJyH6UECDJVjg5s7SIJEAkRlmv4TI5N1kZkcK2LZPZLRqOQP
	ePVhoSgYvv2RtoK7GD6p/Dv8ljZApHSLDkiThbeQ2OEsoeCHnzwTOdZHO2k+vn004dmS3OQbNiQ
	v842nMDgGs226UjYMsOaSUd7kM8iPogw=
X-Gm-Gg: ASbGncvy33YEqeE++47adZPDxOeT5htxxWseGDr8xyq6gcDkaLRdOG19iXqm5I5MV64
	9m3tisycDQz89nzOWLKQ4279LWRYltXEceZROJUURTzKHfBvefWHbhVNODbENTWXztHMlM0kUfx
	fLUVsbypHURxODQ2eklDqlVp0bqIMk/ZxtkeuFYcXtMg8qiAz9fV27K87SnRFO4Cp0ZqLjmeFFx
	jKYj9j7ZawYZBXFLehr
X-Google-Smtp-Source: AGHT+IEwMou2XBQSSzGZG6evgSVSJaUNGvHcnpODb1GP1Tj46JktEw/MDonba8o/nf7jHpzuoB5lmubhm5hsuZ+LIXQ=
X-Received: by 2002:a2e:9ad5:0:b0:333:e590:1bc9 with SMTP id
 38308e7fff4ca-36416fa7878mr10566731fa.24.1758337493585; Fri, 19 Sep 2025
 20:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHP4M8W+uMHkzcx-fHJ0NxYf4hrkdFBQTGWwax5wHLa0Qf37Nw@mail.gmail.com>
 <20250919104123.7c6ba069.alex.williamson@redhat.com>
In-Reply-To: <20250919104123.7c6ba069.alex.williamson@redhat.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Sat, 20 Sep 2025 08:34:41 +0530
X-Gm-Features: AS18NWDphcT1j8gwMTxu9MruWCeWwbq2i5qkYB6D8u5kBYntKI5e2WpmN9fzxiI
Message-ID: <CAHP4M8XQw5_2LX4OpYeO+8bbAEEaRmjQ39+nPzk0qXzwG7uaUQ@mail.gmail.com>
Subject: Re: How are iommu-mappings set up in guest-OS for dma_alloc_coherent
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> If the VM is configured without a vIOMMU or the vIOMMU is inactive in
> the guest, all of the guest physical memory is pinned and mapped
> through the physical IOMMU when the guest is started.  Nothing happens
> regarding the IOMMU when a coherent mapping is created in the guest,
> it's already setup.
>

Thanks Alex.

Another doubt pops up for this scenario.

Let's take a host-OS, with two guess-OSes spawned up (we can take
everything to be x86_64 for simplicity).
Guest G1 has PCI-device-1 attached to it; Guest G2 has PCI-device-2
attached to it.

a)
We do "dma_alloc_coherent" in G1, which returns GVA1 (CPU
virtual-address) and GIOVA1 (Device-bus virtual-address).
Since vIOMMU is not exposed in guest, so GIOVA1 will/can be equal to
GPA1 (physical-address).

This GIOVA1 (== GPA1) will be programmed to the PCI-device-1's
BAR-register to set up DMA.

b)
Similarly, we do "dma_alloc_coherent" in G2, and program GIOVA2 (==
GPA2) to PCI-device-2's BAR-register to set up DMA.

c)
At this point, the physical/host IOMMU will contain mappings for :

    GIOVA1 => HPA1
    GIOVA2 => HPA2

We take "sufficiently" multi-core systems, so that both guests could
be running concurrently, and HPA1 != HPA2 generally.
However, since both guests are running independently, we could very
well land in the situation where

    GIOVA1 == GIOVA2 (== GPA1 == GPA2).

How do we handle such conflicts?
Does x86-IOMMU-PASID come to the rescue here (implicitly meaning that
PCI-device-1 and PCI-device-2 """"must"""" be PASID capable)?

Once again, many thanks for your time and help Alex !


Thanks and Regards,
Ajay

