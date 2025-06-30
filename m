Return-Path: <linux-pci+bounces-31053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E935AAED566
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 09:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67EB1897A08
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 07:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B135A21ABDD;
	Mon, 30 Jun 2025 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1WBFclB"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71BE1F237A
	for <linux-pci@vger.kernel.org>; Mon, 30 Jun 2025 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267853; cv=none; b=ax5ZBmrzzexnDa3ADDibq2UDC8W+VDgivqrF7+pZojql1MojHfN/H2ofymYWEjRbAd8TJQwrS2o7AujyNY6/D9wq3QcTM+j9bUBlsZosJerwrzqSEjhV6xOBoOMVkxlfWLQhEMR4MgBbK7t65skmrKUDKEMiw6ou19cF6+RmtBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267853; c=relaxed/simple;
	bh=Tn6aoQKc3aa7Te5ssMfmlg1TIGUDpo7hBrg6GnUEEI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwHM+J1EZHEtXbEw5SRru7fZsOZ4499r/71FFYvCsSKn8aIVjum4GO03P8ENWCZ8TSQ/9UPdaD9Ny28RNBjL6P7D6+ysefK3w6ifT540JZpZnnrz/C65SxDggL8GQuau1u8uB8pLvhjzwL3H0pVcqNYhePld/i/aozMkc4uN/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f1WBFclB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751267845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OXgKDsO9IF1jvtOwtc1YPzsL5+C5UReXJZt+iIzw2Mo=;
	b=f1WBFclBkfu9cnuOoGsNd1JTRYYxzrqQM39GYIn+/Upw6eyUFi56ydxT1UTRgVjYmPGb37
	JBzFM3nYSnZoM6rT2vdfa1fCj0RAyXKG9iR3CyvHIb8uJMu+E9QaFZ7YTJPFr9J8zTs1yO
	GuokNUQHSPM64QTze+CqB6Ofwu1ph9Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-h1VDzelWPJe12qdoecAKcA-1; Mon, 30 Jun 2025 03:17:22 -0400
X-MC-Unique: h1VDzelWPJe12qdoecAKcA-1
X-Mimecast-MFC-AGG-ID: h1VDzelWPJe12qdoecAKcA_1751267841
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6085b0265c5so3389474a12.2
        for <linux-pci@vger.kernel.org>; Mon, 30 Jun 2025 00:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751267841; x=1751872641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXgKDsO9IF1jvtOwtc1YPzsL5+C5UReXJZt+iIzw2Mo=;
        b=HrZQWZRn6mSBcAACbIAv0I6ONBW97B71B82EjxrsMAqMNzJkK+N9wotITUwT6Z9KmO
         U6DExsVxNxmuQk1PwmiD9KnFM253Y1EnPzoo63DgYtRjtpW39H5OmZBVs80Q5+0APO/d
         yKKCiDrjbiK3erSjrceaMPXCW7QtLbK+Kt4yyoEOkyREfLFliwQn/00jDeiib0kShWpu
         rFxh6baxN7/DYVFMPYO56ezp6znUyPNRupqULm5UPSjnuFHKx7wKkg8kRQ+8ihSCGnn6
         0nYQMARj0uCX3nh0I5Q8gZTV4xr5/06au87j9o1mG8Rrv5dbq0NOmgHnLSYMEUrSGI8J
         UswQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqNzkJ4xkPkfTKZJQrlwfmWuTVsR8GimocnGbfNKgu7VTjLh8BrG0Oun64yq8IXgyCYCoWLkptbh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1jGZ+/Mry1OBGAxMf7JZ5ku6e70SYavjGisiSJzQa0d9oB+rh
	Iu+PSLNHwv8uZiOHuf12EFqOPQV6UfuB6zjpfUVcJ2eaDOm6Hdew1IZGMsv85ptZgNm5zrP6sGE
	t4kqtvuMqGpGOIIW61T1GyBbWCg6vrxMZ18Z4iqh+DOyzf8A20CFMQMDUCe1fxQ==
X-Gm-Gg: ASbGnctZhvdC/UDbYlJlq09oEIkDV/3CoFBBEbkLCWZP9E0aMtuT9495CRkV2UGtfhC
	dftO5zUA0XB+ax3VBAdhGZ3R4zOQEd0dBXyCf9cX8tMfQ/JJzgsuoyO9p8iyFh8yQMjKnRtTdv5
	CWfmBEuyZh0F5WMvtzrs7UkYEbTkfh3yhsDTgjqq5wkuSG/MaGvn1Ph7zw1RDi1Nd9uVhKmDXie
	w1pPvOsepdwQdUXQq55W2x4y7EAlJGTnRB5Unlbuua4eKajwPX7FCDmsHXKsTQnXgTZO37tmFNk
	wGhdb0ivVzM=
X-Received: by 2002:a17:907:7b89:b0:ae0:e88c:581b with SMTP id a640c23a62f3a-ae3501a1ae4mr1165186266b.53.1751267841031;
        Mon, 30 Jun 2025 00:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKxfKBywT4IQk61EMh763CcXX3O2d6CwAncqtW/koAuBxomT/ER0VDAIzBM2QUWavfZMolHw==
X-Received: by 2002:a17:907:7b89:b0:ae0:e88c:581b with SMTP id a640c23a62f3a-ae3501a1ae4mr1165183566b.53.1751267840551;
        Mon, 30 Jun 2025 00:17:20 -0700 (PDT)
Received: from redhat.com ([31.187.78.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae360e6ce54sm567534666b.37.2025.06.30.00.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:17:20 -0700 (PDT)
Date: Mon, 30 Jun 2025 03:17:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com
Subject: Re: [PATCH RFC] pci: report surprise removal events
Message-ID: <20250630031347-mutt-send-email-mst@kernel.org>
References: <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>
 <aGFBW7wet9V4WENC@wunner.de>
 <20250629132113-mutt-send-email-mst@kernel.org>
 <aGHOzj3_MQ3x7hAD@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGHOzj3_MQ3x7hAD@kbusch-mbp>

On Sun, Jun 29, 2025 at 05:39:58PM -0600, Keith Busch wrote:
> On Sun, Jun 29, 2025 at 01:28:08PM -0400, Michael S. Tsirkin wrote:
> > On Sun, Jun 29, 2025 at 03:36:27PM +0200, Lukas Wunner wrote:
> > > On Sat, Jun 28, 2025 at 02:58:49PM -0400, Michael S. Tsirkin wrote:
> > > 
> > > 1/ The device_lock() will reintroduce the issues solved by 74ff8864cc84.
> > 
> > I see. What other way is there to prevent dev->driver from going away,
> > though? I guess I can add a new spinlock and take it both here and when
> > dev->driver changes? Acceptable?
> 
> You're already holding the pci_bus_sem here, so the final device 'put'
> can't have been called yet, so the device is valid and thread safe in
> this context. I think maintaining the desired lifetime of the
> instantiated driver is just a matter of reference counting within your
> driver.
> 
> Just a thought on your patch, instead of introducing a new callback, you
> could call the existing '->error_detected()' callback with the
> previously set 'pci_channel_io_perm_failure' status. That would totally
> work for nvme to kick its cleanup much quicker than the blk_mq timeout
> handling we currently rely on for this scenario.

That's even easier, sure. However, Lukas raised the issue that
pci_dev_set_disconnected must be fast, and drivers might do silly things
in their callbacks. So, I was working on adding ability to schedule work
on such an event, so prevent such misuse.

At the same time, it's somewhat hard to abstract it all away in
a driver independent manner, a callback is certainly easier.

WDYT?

-- 
MST


