Return-Path: <linux-pci+bounces-5761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEBA899646
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 09:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C781F28936
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 07:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC0E26AFD;
	Fri,  5 Apr 2024 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dI5LGV9N"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F98C2D029
	for <linux-pci@vger.kernel.org>; Fri,  5 Apr 2024 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301087; cv=none; b=Cehbkk5PVJuNAhYW9n2jcWAOJro735yjWN3kO7qJN7qhWC00rK87pnAjfNlSogWjWQyFZ+u2Sd0C7sVeex37fthbAonAONjRbk67qTlAdmagqWueXluGrgfMGui+7Q7bh+FRwshMIKb8KC5Noain8i615R44uU3cqkCvctaFXwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301087; c=relaxed/simple;
	bh=FaJY1Vh/+XbGnJl7l/4I6+2o3O1Tg6lPSEvl1XBTqtQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SeRrtNa1ikaj54GDTCCZ9iK2UvuMen3JbcqECGhsd/8rNH/Y4npV4Z8SOYAQoEbgFp47Pa8pVdsBm/prBBnE4LW/8ofpaYHLh/w3HqmRnZt15okbPEaCmz5alKmNGCk0KdU4Zv1UegELFey5VhJ2xdpMQZNoMCfJhgZLeLb1NzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dI5LGV9N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712301084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FaJY1Vh/+XbGnJl7l/4I6+2o3O1Tg6lPSEvl1XBTqtQ=;
	b=dI5LGV9NxKEzlKAEveAZOpjm4lIRdRrwKgCtFFW79hrHfiBJfy3srmjLCVRWSOJURiVtCd
	5qjmlSrRcBnfjpefyNx4GVvXXvky15LEu7fjZF7W4LWLNQ934Gcx6tqAgJxYb/1jGtUx7Z
	H0spl9CQWdYhTBURgxMgdwWOVjXSSDs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-QjlVYzWzPFSc21aWzdA9ww-1; Fri, 05 Apr 2024 03:11:23 -0400
X-MC-Unique: QjlVYzWzPFSc21aWzdA9ww-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343b9425ed1so343308f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 05 Apr 2024 00:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712301082; x=1712905882;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FaJY1Vh/+XbGnJl7l/4I6+2o3O1Tg6lPSEvl1XBTqtQ=;
        b=rpAvO0kLUA7RAZ9DJZlctS9x+z53aZ/icDftMsz/PglRLxd1924L1/+jlYXSnjrr98
         oJjtiqjv+HYxvMzyoVv91bXNI/irtu3A5KcgU22Bzi1Z9acuQPRnc/nXfNKtjtFccJdt
         sKKO6BThxX3OdH4x9W3TmvTHegq+LTnPEFNR9A/RCY1WpFglWzDvTbM3WDxynsqH0X2s
         WflU+LFnhLMODwYLo2uP7ImO2YDbHjXq/Ff6Z/ZsCQlLbDPeCk+wiSUZmkb0F3DZy0tH
         s60BIzgT78k3cR7lyarPfebjamgAHqUhzx/QbWfkJ9qfIfTmcqmhv+kaLAuk2KlRVtBJ
         Mo4A==
X-Forwarded-Encrypted: i=1; AJvYcCWLa7b+JvC3rQtBM6/PW1dB/j9+zJdvSXtbBQPfapwp/g8d58QL4iF7uy5SwOX03//WrRFsQGOe/JVSiX9TvEA4+pVBZ2NOqAfF
X-Gm-Message-State: AOJu0YzHNnakw4xlNSTNtdiv13NYl0DILxCoLkggkv4T749up5sr6dum
	5D831QSXNphEmCw90LrNKntHyIqqn2pkCeuho8gdmUAPbEMfeupkvOOz7lD3KUqPCa82l7xg4Y+
	xjGwk56C1PWe1xSs55shUDmI27Evvq9KKsW0Vsjxui8dU2rk4Z1sPbmqzyQ==
X-Received: by 2002:a05:600c:35ce:b0:415:54d2:15ad with SMTP id r14-20020a05600c35ce00b0041554d215admr494028wmq.1.1712301082039;
        Fri, 05 Apr 2024 00:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG3drsURmYKY81I73IScfWCYeZGfBqNoxh4npfx6Pwq/q426FKn0qzViRqt34db113evlnNQ==
X-Received: by 2002:a05:600c:35ce:b0:415:54d2:15ad with SMTP id r14-20020a05600c35ce00b0041554d215admr494014wmq.1.1712301081677;
        Fri, 05 Apr 2024 00:11:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-213.dyn.eolo.it. [146.241.247.213])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b004163059bb53sm684688wmo.16.2024.04.05.00.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:11:21 -0700 (PDT)
Message-ID: <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
From: Paolo Abeni <pabeni@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>,  netdev@vger.kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org,  Alexander Duyck <alexanderduyck@fb.com>,
 davem@davemloft.net
Date: Fri, 05 Apr 2024 09:11:19 +0200
In-Reply-To: <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
References: 
	<171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
	 <Zg6Q8Re0TlkDkrkr@nanopsycho>
	 <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
	 <Zg7JDL2WOaIf3dxI@nanopsycho>
	 <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
	 <20240404132548.3229f6c8@kernel.org>
	 <660f22c56a0a2_442282088b@john.notmuch>
	 <20240404165000.47ce17e6@kernel.org>
	 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-04 at 17:11 -0700, Alexander Duyck wrote:
> Again, I would say we look at the blast radius. That is how we should
> be measuring any change. At this point the driver is self contained
> into /drivers/net/ethernet/meta/fbnic/. It isn't exporting anything
> outside that directory, and it can be switched off via Kconfig.

I personally think this is the most relevant point. This is just a new
NIC driver, completely self-encapsulated.=C2=A0I quickly glanced over the
code and it looks like it's not doing anything obviously bad. It really
looks like an usual, legit, NIC driver.

I don't think the fact that the NIC itself is hard to grasp for anyone
outside <organization> makes a difference. Long time ago Greg noted
that drivers has been merged for H/W known to have a _single_ existing
instance (IIRC, I can't find the reference on top of my head, but back
then was quite popular, I hope some other old guy could remember).

To me, the maintainership burden is on Meta: Alex/Meta will have to
handle bug report, breakages, user-complains (I guess this last would
be the easier part ;). If he/they will not cope with the process we can
simply revert the driver. I would be quite surprised if such situation
should happen, but the impact from my PoV looks minimal.

TL;DR: I don't see any good reason to not accept this - unless my quick
glance was too quick and very wrong, but it looks like other has
similar view.

Cheers,

Paolo


