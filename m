Return-Path: <linux-pci+bounces-15492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3419B3A8D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 20:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FFA9B21471
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 19:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE8F18B03;
	Mon, 28 Oct 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSNpqiiO"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8FD18873F
	for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144146; cv=none; b=IP5Ek6jY43Y1QsJVZ4oNk+ybW0DZQkQsX6TKMREVvLKrI0RZBCob7tx1ilmMSHJSBGRwmnlzGxP2ZmPjJAStTReBUKpQmRqko6pCxvOvdu32Bl7M4oe6jEwQRjGtck7aUNQJ+Xzwiogjg/ddtHAipnqsz5SNKLSz2nkElH9FMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144146; c=relaxed/simple;
	bh=EB7rdZgzTDq0wJlBIhZ+BY7i49ZgpPo8HqqdvtlQWx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plOoqfZkp51m41apdjRj4oN3vwUKxKOtiCXDuQD1rO4+qvsNuluRYxTGf3s+VMaGvA7t3u0QbIGd2M58JxK83hRE+KJy10vOeZg+SFh4sR0qtt7rX0KYXJ+PWIc7+aG6E063O+hUXOtVJu1ffh+VYAVqKdA5iRtOeYXLd/hstZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSNpqiiO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730144143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6EbTPVVOulSSKt4qgN6hyvD+dM2ix4Ejg2eKKKdFsI=;
	b=HSNpqiiObU83z3U0o4oGAEE1IntZAtlaYo+Vqqeqszd5D1hy29gZuQYQN2iyMGyIwryve9
	5HT//kX7VvfRbQ625XMBBc1ihb894oT8Vt4xNTqU3dtekZR9swqzktEFT4S5wTkop9L3eq
	mo9E10Zj/FIDo4PPsLbK4UAR77zIplo=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-IW_IljaDM4eh9yUzQYf6Og-1; Mon, 28 Oct 2024 15:35:34 -0400
X-MC-Unique: IW_IljaDM4eh9yUzQYf6Og-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4f91f3be4so2335365ab.2
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 12:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730144133; x=1730748933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6EbTPVVOulSSKt4qgN6hyvD+dM2ix4Ejg2eKKKdFsI=;
        b=BoKlAXVjiwVBEGZnqwp9WPrRw9joSkQHN9CoWNWyqEpaquc5VOZ7lMd1IBOfO2Tpeh
         94izv7kRRe5ScKDYJCZYVfcdTZKqEgrgDGtya+q3N40fBmTDvlU17cc04wfJzVHBmJA0
         LKgmO2dyByMn5rDwreYZ0GK8zHxPx2BhZuKps/jcRyqb7/E+a2Tmh0nDvKAfSlDueSHt
         YT1dxSQRPLPu3bhvakaBSObzGeisjc5O9lXTZSNHx3aafGkKL+LpNddza1Stro2v5e+C
         /8repnVs8J7jV5pdszxTH5yeRICifw8vwa/dsBfePOmNLqc0DypVlT8MSPdZL2ap2N22
         FwcQ==
X-Gm-Message-State: AOJu0YwRVbNhzdS54xZuu3iAyw3ejpIUsW7AtqXMgbcs3qt8Su1Epuoa
	SmQH5zlM8Zh6bvoPleBWnvQ/rBDeeAwzLB3te6Y8EFjCvF3gW6JF1/w7hnT02aiUbkAgDRQveYu
	DPNHQDYNavdmF2JiVaPUplCHPMXIDCm9uj2bmAdciR665jkIAVZsjWecMsg==
X-Received: by 2002:a05:6e02:1c26:b0:3a1:a179:bb60 with SMTP id e9e14a558f8ab-3a4ed3011b7mr20477755ab.6.1730144133536;
        Mon, 28 Oct 2024 12:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuFrWWHLrFo4LTg0STWKmMYwaMUq2V5IqbtDdnKYf/3/vbAk6KQaXq8yTrTpcYtWuYlNVf0A==
X-Received: by 2002:a05:6e02:1c26:b0:3a1:a179:bb60 with SMTP id e9e14a558f8ab-3a4ed3011b7mr20477705ab.6.1730144133057;
        Mon, 28 Oct 2024 12:35:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc7277f96asm1829034173.126.2024.10.28.12.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:35:32 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:35:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
 <ameynarkhede03@gmail.com>, <raphael.norwitz@nutanix.com>, Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] pci: warn if a running device is unaware of reset
Message-ID: <20241028133531.23692578.alex.williamson@redhat.com>
In-Reply-To: <20241025222755.3756162-2-kbusch@meta.com>
References: <20241025222755.3756162-1-kbusch@meta.com>
	<20241025222755.3756162-2-kbusch@meta.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 15:27:55 -0700
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> If a reset is issued to a running device with a driver that didn't
> register the notification callbacks, the driver may be unaware of this
> event and have an inconsistent view of the device's state. Log a warning
> of this event because there's nothing else indicating the event occured,
> which could be confusing when debugging such situations.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/pci.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


