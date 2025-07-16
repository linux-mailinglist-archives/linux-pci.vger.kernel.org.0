Return-Path: <linux-pci+bounces-32270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA6AB0775D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 15:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE04C506279
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AE91E8326;
	Wed, 16 Jul 2025 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mvCFxaSv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BECB1E98FB
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673922; cv=none; b=K95PecZSOVgWq4jwYvJGxFNXEr9pLXxQ6dU+QqF+SZgK3zlTfK0gGqtvjGMCqDic+hFyFzJCi8tX1TfGobk3cGV0q1kviJYe2cw06R9kPbysQKzgmjHklCH9tUkV6lNDMa3qPF0rl9WKec1XHPT0gcfmEC9OhkGxcmhXfhUDc68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673922; c=relaxed/simple;
	bh=grW2AUSizTB1ZshpMQ9qX4KBTlAYx4u1Wd4mQU2d5Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2WeBX5C/J+Or9gG4GZhuwQ9aTij9dJb087GpSqxyDcvjIjeeRQVY4735b34TPkgxW3NM6X+D/4ID+mVYULfnHIWB7Ww0yqfXEvlR567yyQpI3CPyRpqUkYKVr7xA4rWKIYOwPILalJ5C/ieGA7fT79A8VwJLKEYktwKe/k1Gzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mvCFxaSv; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a9bff7fc6dso8670481cf.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 06:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752673919; x=1753278719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdjkYZdvq6o0RvZC4J9GMFYo4HQV1x5t2E+S5V0aQY8=;
        b=mvCFxaSvclUh5bvrlHBJvg1vH0LNX8BLOmfigK095/+azcRoBbwUDY+la/D3irZxzF
         0QMAg0PVeUDgAB2vyCqhAadnyI5rA863EnJDUJCTJy9h4M5xWgJQCXtim89d7Co4gkmP
         iWCBQr01yCMjr8OcfZRUQVzJPDKPONhKN47ml5qbKVcbmx3gyfmEPjkfydUJBDqBngdJ
         JYVGE44Od+TwF/YHAS52wbCK68yoG2qyd8WazI1s/MIzGRQZHe/oUTr86tR9QgxvXNWa
         z7D4O9Ai5Oq6hyGZy88alhOFrUBbNh2zjDwVAD55e2tl2++aBij9ztSbhOevGCev2soj
         Bajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752673919; x=1753278719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdjkYZdvq6o0RvZC4J9GMFYo4HQV1x5t2E+S5V0aQY8=;
        b=ecgSj7c2eZ3mv7cRiM/kPdR2Hpm58wbUQ4f6KmuSyMWUhnbdFhPunwWThncKu187CT
         QdVGlJN1MS+BwNP2HgxunYmKfwNVG3sb5I8RUuCV1YSWp6FlRppIpAzaTPHKuDWLodPL
         9wnOJo6ystKpFgr9jVMsGRTtu9sHATHUBaLoKlOGJcX3BXjPG1mD5H9XUoiQKnK9aYsj
         tXln4v5amPn0Hd4QET+/0MV1IWGMjcqN9Avl/ZiwXvbmILIOvm/vQq+cdW3gT7VsFQcr
         MKjTXbsD8+rP7jDd+bU+khWXfk47WUi1tpJ73nMyUqwCKdmA3NleR6vzqIvCY/WsCq6S
         gzTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfYUwcTB3ToUy+vkGywmkOVnHhIjG3hBri28eRMCZh3xKJkKpiUCnSDoqhuoUi4v5XZP0kfQILAaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGxYeHGtLoZf/KYbOAjoQXD5xYT1cXqrmHwwIlpQcV3NFB1UND
	amO7qNgT3AIMSXClJTPZzXMpZMYIY2UHoH9KNQpbKWLw4R1P5X5dBynLKtjXaKTaTNuk8W6FYeh
	ZSi99
X-Gm-Gg: ASbGncsvHF5nngsEyibWcaKDv3vlRdvVDDm9ygsm+kz68LIwPzWxsJXvtsiCzKUaoUy
	/+GO0qJeLyXfxQoJNkbFGjTGxk/kY/YZ81jtI+FQw0Q8w8DyKUZPYY0vg+7Ig/odPj53ZbbOUhg
	4V5I7YqMWEsS/Ah+Q+StyNrcViG4gIOK+At2cWjpsDl5toKJB9pxtAFoT5CSTR3cjeX6YawYFsc
	bRiUeNNAiyrlmlpVzq5UhBBtSczHT6oyQecKqKAkn1fHq/MolxRr/7ZpRkkbrTayIId9EhQRxTb
	3KsdazNHpG6H1ElAXnw/U/OP8fuhjtIpngd6McEnRpWWNDFC5MTIge/OdeStac4cCjuuuZ0zHKE
	zjzEhA3AUXowQMHHdxlbBTGkghXCtfZF5t3DtTi8F2qBMKspPAzmkLOthm7s5DBwyL0FntXi34A
	==
X-Google-Smtp-Source: AGHT+IE34DDGUpdfQtwke2r415OigmLgUTLk3xe/ctPjPqqKTT3F28vzpfc3Ass7rYE3KyXXLelv/w==
X-Received: by 2002:a05:622a:1cc9:b0:4a9:7366:40dd with SMTP id d75a77b69052e-4ab923e48c4mr44229461cf.19.1752673919173;
        Wed, 16 Jul 2025 06:51:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab575ca629sm44704861cf.59.2025.07.16.06.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:51:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uc2Y9-0000000946K-3xvb;
	Wed, 16 Jul 2025 10:51:57 -0300
Date: Wed, 16 Jul 2025 10:51:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, alex.williamson@redhat.com,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org, paulmck@kernel.org
Subject: Re: [PATCHv2] vfio/type1: conditional rescheduling while pinning
Message-ID: <20250716135157.GA2138419@ziepe.ca>
References: <20250715184622.3561598-1-kbusch@meta.com>
 <20250716123201.GA2135755@ziepe.ca>
 <aHetWNNNGstvIOvB@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHetWNNNGstvIOvB@kbusch-mbp>

On Wed, Jul 16, 2025 at 07:47:04AM -0600, Keith Busch wrote:
> On Wed, Jul 16, 2025 at 09:32:01AM -0300, Jason Gunthorpe wrote:
> > 
> > You should be making a matching change to iommufd too..
> 
> Yeah, okay. My colleauge I've been working with on this hasn't yet
> reported CPU stalls using iommufd though, so I'm not sure which path
> iommufd takes to know where to place cond_resched(). Blindly stumbly
> through it, my best guess right now is arriving at the loop in
> iopt_fill_domains_pages(), called through iommufd_vfio_map_dma(). Am I
> close?

Yeah, I would guess maybe put it in pfn_reader_next()

But iommufd won't be faulting the MMIO memory from VFIO so you can't
hit the same exact condition you are describing..

Jason

