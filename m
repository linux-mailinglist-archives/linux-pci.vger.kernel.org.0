Return-Path: <linux-pci+bounces-36791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA5EB97084
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE36B188845C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A364A274FF5;
	Tue, 23 Sep 2025 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fx84UchE"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61F275AE2
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648650; cv=none; b=GO4Lp+JpU904jAVWKvPfsqpRNaxngx1I518GplxEuVNgsJX8aEuhy67RBYA/KhG3di4OQ6OuzDaEybDuGz19n1LVYNkDuLTk4HiOn5D9YsP0L1u6l3Di6ILIwoKbelreNtVoA3yi0csVVNMKTCSjq6tiS7z0ko8fqoajKlr0Wjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648650; c=relaxed/simple;
	bh=5WraoSFUp6ajvbI3o5JH4FWFS36gY332T+fZ2BSIiD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVNvblOYCmeQI8trVqkQi8b6vWfsXvhgRiVnn6wfY9RXUEa2B5FLO2eBoibFzuLSJBciLNM+tmunxUw3BCEyC3Wi0Q7p2/5LKLvk00wfTet/r2r8J9oRLPgKenU8lLN4VfvCNlOYwg8InBcUowWKOJoc/a6XsoLKZW/qBJiWfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fx84UchE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758648648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFNQwbdODcls1yBrLTyCkOTsxOyxsNLxzpt49nq+oT4=;
	b=fx84UchE5XWGDbgsBjUAn89A+FBHOSEMeydadGw0L1BPHiRmLGsd4qVQFYS0NsCs2D1YDe
	kS7yoAGxIdSN53ZIVjXJEiCwZF6XgWpimqdwmS/xxDiTo8yQoLeiIafk6MMQS1PG6btk5R
	zaPfqt046G7wO/dQB3FQdlxjKRw8Q8I=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-s8KZj3KUOjWG0qtar_AQcg-1; Tue, 23 Sep 2025 13:30:45 -0400
X-MC-Unique: s8KZj3KUOjWG0qtar_AQcg-1
X-Mimecast-MFC-AGG-ID: s8KZj3KUOjWG0qtar_AQcg_1758648645
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42574155f16so3005425ab.2
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 10:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758648644; x=1759253444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFNQwbdODcls1yBrLTyCkOTsxOyxsNLxzpt49nq+oT4=;
        b=TCu0mt0XvUnWrM67sSSEFmaLz7PKsRQemIPs2qr2IUsuxXtK6YY9AdmoLq4jqp1jiT
         p2PbJpFYpLCQu53Vs61CNbDA1XDkivLMi12YpenlWSBNuzX81EPwJv6f4Jed7OcEslzI
         w1JR/78NX8iHEWBSs14Ly1xszl6SBjWWQ2kXs3xsz5g04ygkU47F12B9wt2vuUiV0TiT
         ovo+PgxsYT8y3kdyVuqILOuMi7TEPrPVa67OE54g3+I6meiqmn0ynLGSV9017i+XRUju
         XVfgYL4jWl4pJKum9OMN+Gy81MvMNSnzLyzg7kYmZwUMych8YtAnmriM8el/C44T9VBU
         8tqA==
X-Forwarded-Encrypted: i=1; AJvYcCVxgNbTkVY2rE4tjghEQZj+Ono2boPFr/xEJUfs5R/rm58lhfGI+UY63f653WS0A2hdAdR5ObGmFSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJhprY/OQz29eu8K+WzpFvGSb7B7ajwYab0MXnZuLecR61ZsWX
	0lE0abopGDN+wwSQCkdYJdJsv46NPPlVGjGlQBI9GKe/OEZDDFLZipBNqVo1XujB1cGiO3188+l
	pquyaNyMIBXP4o6FUktp/sgrEOsH0uHH/kQ0HnOeEZFzYvq4U/KqKL9thevqhSw==
X-Gm-Gg: ASbGncsemxUhpHIUURpkQbsi0v1nQkaIEiewHbvTroyPv0MrvTt2SxvagvJrxC1F1xy
	SOPQqXMrIWpT1N434kq356QqZgO/1RZNNPIJtprGksDnVBd7ActNmXDjS1qj6pcu8gtYcRU2I9D
	55OP3DcI8K6uutNBNEFPuTOhIjcReyArSzA88xy7tvXXRdpPq9m1UvQwpWr8BrDCgoyE3MFiW1X
	8QUPkVZ3v+NHiFa5m0UaP2IhfsIXtoNb9TG8a05JrZL1DDgFyQHqSwBgL/Fr8uv5617D4wXSUci
	WvzpFvFrctxwuutdXC7+ln10T6MPmm6RCX+XOxDbA7o=
X-Received: by 2002:a05:6e02:164d:b0:400:7d06:dd6d with SMTP id e9e14a558f8ab-42581e09c50mr18780935ab.1.1758648644607;
        Tue, 23 Sep 2025 10:30:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNobmhXZYu8wcE6bAQtE0C6wCF0m0+GFNpZFLyv2Bpb6JP547FE77pkIiIGw0EG9S0P84Gyw==
X-Received: by 2002:a05:6e02:164d:b0:400:7d06:dd6d with SMTP id e9e14a558f8ab-42581e09c50mr18780695ab.1.1758648644175;
        Tue, 23 Sep 2025 10:30:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-566127693e0sm275326173.30.2025.09.23.10.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:30:43 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:30:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
 <joro@8bytes.org>, kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/P2PDMA: Refactor to separate core P2P
 functionality from memory allocation
Message-ID: <20250923113041.38bee711.alex.williamson@redhat.com>
In-Reply-To: <20250923150414.GA2608121@nvidia.com>
References: <cover.1757589589.git.leon@kernel.org>
	<1e2cb89ea76a92949d06a804e3ab97478e7cacbb.1757589589.git.leon@kernel.org>
	<20250922150032.3e3da410.alex.williamson@redhat.com>
	<20250923150414.GA2608121@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 12:04:14 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Sep 22, 2025 at 03:00:32PM -0600, Alex Williamson wrote:
> > But then later in patch 8/ and again in 10/ why exactly do we cache
> > the provider on the vfio_pci_core_device rather than ask for it on
> > demand from the p2pdma?  
> 
> It makes the most sense if the P2P is activated once during probe(),
> it is just a cheap memory allocation, so no reason not to.
> 
> If you try to do it on-demand then it will require more locking.

I'm only wondering about splitting to an "initialize/setup" function
where providers for each BAR are setup, and a "get provider" interface,
which doesn't really seem to be a hot path anyway.  Batching could
still be done to setup all BAR providers at once.

However, the setup isn't really once per probe(), even in the case of a
new driver probing we re-use the previously setup providers.  Doesn't
that introduce a problem that the provider bus_offset can be stale if
something like a BAR resize has occurred between drivers?

Possibly the providers should be setup in PCI core, a re-init triggered
for resource updates, and the driver interface is only to get the
provider.  Thanks,

Alex


