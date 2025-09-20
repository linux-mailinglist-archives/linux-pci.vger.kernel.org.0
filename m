Return-Path: <linux-pci+bounces-36592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7E3B8CA59
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00421B24AAA
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 14:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57091DDC3F;
	Sat, 20 Sep 2025 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRzEdIGQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D41D61B7
	for <linux-pci@vger.kernel.org>; Sat, 20 Sep 2025 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758378890; cv=none; b=D8fvBb7pWldBOYmP1DbR1AU0ap3zsNVZtAMP4uTgcbMpZFk+Q4N0JGw1eMoI6+t9pUpehW5wgbTubhzzc8xGnTXeyvh1op1iKiG6IagUoFVzdda5Vf9pRWOEfQMe7mD1x1g96rDwaiQcqy9jUuTY4g+9ot0+yfHPGmSJeuL3hjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758378890; c=relaxed/simple;
	bh=m7o1JmdCtCm0ban/9JFAPVOEURfRDh7SX9QH+JTTZCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qu1BG8ml2LPEEmd1YAFBsV3W/Al44qr/KuEgydh/Eo/G5m8zLjGnsOVAizGKzub7dBp1n5a67yfMo3mjgFuJKZgq42Vu9x0vFNSYKyqNGUGP4AbhRk7BbZGxAZ9EEqLck2E2HZ96F/g0GOGe98gn6tjE9NhM5oDwDuWAO/24W7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRzEdIGQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758378887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lmW0GhFqpuOz4IYUZyTxB91HzEDm1lTR2DbWJheeJf8=;
	b=ZRzEdIGQUqOarQgpRXQAcpsRrxp7cB7FfvpuIqSy9bNgHsM0nB5wJNXuG5HdBHRWQBu3BX
	ACtgU9fSb0qtmZ+bpXeXjhjarC+OcsdXI7SyAUkq7x+n9gKBpRG64z/1e/yQHqBBj6WKnh
	LeklW9Me1GMywx7zOdYnBCruQi5l2H0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-ppid0FfTO9q3PbQohqwY2w-1; Sat, 20 Sep 2025 10:34:46 -0400
X-MC-Unique: ppid0FfTO9q3PbQohqwY2w-1
X-Mimecast-MFC-AGG-ID: ppid0FfTO9q3PbQohqwY2w_1758378885
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-890975f55bfso59099239f.3
        for <linux-pci@vger.kernel.org>; Sat, 20 Sep 2025 07:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758378885; x=1758983685;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmW0GhFqpuOz4IYUZyTxB91HzEDm1lTR2DbWJheeJf8=;
        b=k2aSUeR9bjy/yrNRg9uFhAVJ3sgpJFhU5lTDuTu+qFp6KasAInWlx+RYIrIyRlYJ7b
         UwbLsz5O9uffMfyrJ1QkhHq4QPNuyJxnc3Zw7QQlwedyY64GmwTF34z6Eklzjzg0kfIA
         LUqJm1Eqk2XpvTjxcV9Om7W+Cn6E0UgGpiu74+3HsQTBPjfcDwnX5KDua8hjKHhBDzSq
         oLDJPbkuxmjm8Vcg6KkufuVUB3nVEOTjcfZScWv+ALfEkzOclmFFG1iXlO8CI+L+G+Ro
         LftoPcbTPvqLp8oCMn1YxATBSsHFv4L6mrpS4uQty6/dZjoB6i+UN9QV510ggfM0tS0x
         wMQw==
X-Forwarded-Encrypted: i=1; AJvYcCUSIoOjQiBJDfWs9yvx1s+E67cl6NukRtltMCrOs9PzrPnlUUryV4k3CflQbViW5w7/A01Z9mseUCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEWvxX1m7wbJ1NGBm0uP+pdskWtknDfHz3th2DFSX3CAgi1vXO
	NsniefIFBAjnut8LIqdcbsomhU1N7gp66wAgZ1WVzynPTbo7iFjVeTDUnf3cdGXpxgMH46iLTG+
	WUm64dEvs4fStpunqA3JtgdVZ631kAB52WL1ZtUg2xpnHnipw+1/X2B9c/MJ+Wg==
X-Gm-Gg: ASbGncs21sn98k4fDQ8hrPNw1LjaYd3XyCrguqTMM+qZtgqQLjBsQ80+eh9va31c2FE
	4MxervcNGriSVJRt1v6FkCH/lu165pS708D0u1rpay/bD7iI+AH6YBqu4PjcbLyK0nHZIEAXDmB
	f+Snn1ofXb5/8CjUK4u0FbD7UBeWw0M1S5AZ01097dQgXdz26R4OQFXoDvFo1ry5sjoRnb8+b7Y
	HjWPzOpQkAFmkHPmmb+/tG/9cqGPLO0/l+vl79NZ8B2oJ7+j6qLYJMJjHQcBDE0XX3ZQJPpmIaR
	BdW734ZOXzwZY1UjBOePo6iKu/vOvgvu8ttvnKOirc4=
X-Received: by 2002:a05:6e02:2301:b0:40f:407b:f276 with SMTP id e9e14a558f8ab-4248197e364mr38881845ab.4.1758378885057;
        Sat, 20 Sep 2025 07:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn/sU+69zKpMjjxvM7+FqZPhR1nEz46uEcfbGd5xDRY/strRZMysIf+Q/QIhqN6+Ha09OCGw==
X-Received: by 2002:a05:6e02:2301:b0:40f:407b:f276 with SMTP id e9e14a558f8ab-4248197e364mr38881785ab.4.1758378884673;
        Sat, 20 Sep 2025 07:34:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3f7570c6sm3458457173.31.2025.09.20.07.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 07:34:44 -0700 (PDT)
Date: Sat, 20 Sep 2025 08:34:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ajay Garg <ajaygargnsit@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How are iommu-mappings set up in guest-OS for
 dma_alloc_coherent
Message-ID: <20250920083441.306d58d0.alex.williamson@redhat.com>
In-Reply-To: <CAHP4M8XQw5_2LX4OpYeO+8bbAEEaRmjQ39+nPzk0qXzwG7uaUQ@mail.gmail.com>
References: <CAHP4M8W+uMHkzcx-fHJ0NxYf4hrkdFBQTGWwax5wHLa0Qf37Nw@mail.gmail.com>
	<20250919104123.7c6ba069.alex.williamson@redhat.com>
	<CAHP4M8XQw5_2LX4OpYeO+8bbAEEaRmjQ39+nPzk0qXzwG7uaUQ@mail.gmail.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 08:34:41 +0530
Ajay Garg <ajaygargnsit@gmail.com> wrote:

> > If the VM is configured without a vIOMMU or the vIOMMU is inactive in
> > the guest, all of the guest physical memory is pinned and mapped
> > through the physical IOMMU when the guest is started.  Nothing happens
> > regarding the IOMMU when a coherent mapping is created in the guest,
> > it's already setup.
> >  
> 
> Thanks Alex.
> 
> Another doubt pops up for this scenario.
> 
> Let's take a host-OS, with two guess-OSes spawned up (we can take
> everything to be x86_64 for simplicity).
> Guest G1 has PCI-device-1 attached to it; Guest G2 has PCI-device-2
> attached to it.
> 
> a)
> We do "dma_alloc_coherent" in G1, which returns GVA1 (CPU
> virtual-address) and GIOVA1 (Device-bus virtual-address).
> Since vIOMMU is not exposed in guest, so GIOVA1 will/can be equal to
> GPA1 (physical-address).
> 
> This GIOVA1 (== GPA1) will be programmed to the PCI-device-1's
> BAR-register to set up DMA.
> 
> b)
> Similarly, we do "dma_alloc_coherent" in G2, and program GIOVA2 (==
> GPA2) to PCI-device-2's BAR-register to set up DMA.
> 
> c)
> At this point, the physical/host IOMMU will contain mappings for :
> 
>     GIOVA1 => HPA1
>     GIOVA2 => HPA2
> 
> We take "sufficiently" multi-core systems, so that both guests could
> be running concurrently, and HPA1 != HPA2 generally.
> However, since both guests are running independently, we could very
> well land in the situation where
> 
>     GIOVA1 == GIOVA2 (== GPA1 == GPA2).
> 
> How do we handle such conflicts?
> Does x86-IOMMU-PASID come to the rescue here (implicitly meaning that
> PCI-device-1 and PCI-device-2 """"must"""" be PASID capable)?

No, each device has a unique Requester ID (RID).  The IOMMU page tables
are first indexed by the RID, therefore two devices making use of the
same IOVA will use separate page tables resulting in unique HPAs.
PASID provides another level of page table lookup that is not necessary
in the scenario described.  Thanks,

Alex


