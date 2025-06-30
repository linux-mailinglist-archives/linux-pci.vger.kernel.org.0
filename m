Return-Path: <linux-pci+bounces-31094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A89A0AEE5C0
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 19:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25AE189553F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E52B2E4277;
	Mon, 30 Jun 2025 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bShMX1zV"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9B729DB7F
	for <linux-pci@vger.kernel.org>; Mon, 30 Jun 2025 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304363; cv=none; b=VwMpazq5rygAhgD3bEaTMq2yNnTGXHERc0dC9y27agPy+y0FP9K7t9iT5OReXe5x59I6KN5uUYm1UJPHmGtADapyaoqsrSqrG+Uow1FgwvjpnQfVpBMq6/A4MQ3g6/Harkb9o3D0avFWYTN8ScVSewPm1wrZ4LV5tU6tws1cvJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304363; c=relaxed/simple;
	bh=/ed1E/z18Xh1fVpk+ZX4y+GGRM+8GW66EdG4YQHARuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHwvcFtullpQJSyZvon5E/mRAkZt+OKnvpXFzNTDrhJ4GjBr11KVCicOKQN8XpWPU9KGqA7wZ2wRc1m+pXpq3X7rBZ6lTmBq8w0j2HNj3D70V58OE+NSNLUe4KlFAd9Gj8/yEwGwLwD41u9DLQ4hXZdBPAg+CbaiMgXJXAdgvxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bShMX1zV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751304361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DirzX1KCKtv521PxYtm6kg9uFvxjRQhuzEiLEHXJyMU=;
	b=bShMX1zVTSZB2mWfzaDhM/r8zA0d1amoo7TUlFAOC87Vemw6kBOO7RhWR7wgUIkzGgD6JO
	nK/jiA9cs0WvVcvFjymCQhJUxYWghAvbC5aSEczyzHAqePXR+1EyliFNFy3sjvJAVB7WVe
	sJBjBXkUPr4/xLoPLZSpV5vjJUMbQWU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-r8pnTWNLPZSvfUINdS8m-w-1; Mon, 30 Jun 2025 13:25:59 -0400
X-MC-Unique: r8pnTWNLPZSvfUINdS8m-w-1
X-Mimecast-MFC-AGG-ID: r8pnTWNLPZSvfUINdS8m-w_1751304359
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a579058758so800858f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 30 Jun 2025 10:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751304358; x=1751909158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DirzX1KCKtv521PxYtm6kg9uFvxjRQhuzEiLEHXJyMU=;
        b=ZMNZTv3J6a2i07C5B9trC2TV59bHX1xTOySKMKmQgSE+3IZcafseLSM6pupOvRO8Wy
         yf5UcQtYa/tyuptAvQpbj2ZBlnlGMNKoCxTVWblTLuboNMMs58fpbcSoYXikC7SSUZ6q
         32FEpN1usmEndcWSsx6ZGFRTXKgdTMQ2TTidbnTEDDllr8bjX8z1bQCyp0Ts2//tEMnj
         uNu3Cn7CB+0Hh6/3sYPLj1o4TCN68+rDL96KYboSAeQQ5v5AQOsvzDqYMsDvVD23OPbz
         A3uVUxKGkLFAKXIzQmQzrcpxn2O5oit1qGWOfteoKMX/s6Ijk2bLfE14NFmHpzMnKktK
         MMaA==
X-Forwarded-Encrypted: i=1; AJvYcCVBL+e84mL3B18kG11k0kzR+WBfIfK/fpO3VWYPxMjutLzshoSeDFy8NIpYgP/GZbkMXzBk6u5L1Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YweRhNseQsmFH9VSxwxkYM9O3aUD3Eae5aEQg657Fz9sYSqVSxH
	l47Ap8+8WI8wUJXUAEU2WCAWhk3DqAKyS1ZesZ827v8ml/nhpztiHyPiaNuE2WPRjaj61Pey4lS
	GKO6xZel0CZRrI3Av/UwU6FSMF/0UPA27TV+Kl3Vis/Fa43cjs16SALj9aTEljWSFJJ6oTg==
X-Gm-Gg: ASbGncu2LH0ba58iu5TP6TD/oyvm7VXjzATdonIPaNAhQsmQU7wndkwJjFt1gaK7WTB
	ad48Ie2ZgVa/9Xd+emSq4t3heG015SwTus9Qzf5F4SVsFHh1wRa0XqbdfSZMtC40rZnqaz8XFrq
	kmvqhvNzlgz62621v66RT/64QmEJO6IWw/bFT19wgOYru8vBwMciQP2ERshnyae+BYGBxPKYEGX
	w1hljCh+RwZVXUbpyUx7//6NAr3gl7j122UZxIDmJG5NP4J0Uy2ZxS9TBPwzYOcldCPqYbKpp5M
	qjiGsuOa5NpE9JMa
X-Received: by 2002:a05:6000:710:b0:3aa:c9a8:a387 with SMTP id ffacd0b85a97d-3aac9a8a39cmr8482267f8f.0.1751304358213;
        Mon, 30 Jun 2025 10:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxJNxP8kFLxbkJcu5vn1wYxIzXeajCRrSl1+SZhoLGhSVkUygc5Y6gw3Iwu1mrPLUoBFlNVA==
X-Received: by 2002:a05:6000:710:b0:3aa:c9a8:a387 with SMTP id ffacd0b85a97d-3aac9a8a39cmr8482242f8f.0.1751304357754;
        Mon, 30 Jun 2025 10:25:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45388888533sm152948825e9.21.2025.06.30.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:25:57 -0700 (PDT)
Date: Mon, 30 Jun 2025 13:25:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Parav Pandit <parav@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH RFC] pci: report surprise removal events
Message-ID: <20250630132444-mutt-send-email-mst@kernel.org>
References: <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>
 <aGFBW7wet9V4WENC@wunner.de>
 <20250629132113-mutt-send-email-mst@kernel.org>
 <aGHOzj3_MQ3x7hAD@kbusch-mbp>
 <CY8PR12MB7195F2F2900BAEA69F5431E9DC46A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <aGKUqsudjfk8wCHI@kbusch-mbp>
 <CY8PR12MB7195583E429203129577B51ADC46A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <aGLB_8SFF1Cw95MZ@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGLB_8SFF1Cw95MZ@kbusch-mbp>

On Mon, Jun 30, 2025 at 10:57:35AM -0600, Keith Busch wrote:
> On Mon, Jun 30, 2025 at 01:52:26PM +0000, Parav Pandit wrote:
> > > 
> > > But I didn't suggest calling error_detected from report_error_detected.
> > > Just call it directly without device_lock. It's not very feasible to enforce a non-
> > > blocking callback, though, if speed is really a concern here.
> > Yeah, it would better to either always call a callback with or without the lock.
> > In some flows with lock and in some flows without lock would likely be
> > very bad as one cannot establish a sane locking order.
> 
> On closer look, my suggestion without the device_lock may be racy, but
> using the device_lock prevents the notification that needs to happen.
> Hm, not as easy as I thought. :(

I think I will just add a work_struct and a flag that the driver can set
to schedule it on surprise removal then. Hmm?

-- 
MST


