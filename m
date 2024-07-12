Return-Path: <linux-pci+bounces-10204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A1692FA6A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 14:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747AA28278F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E883116F291;
	Fri, 12 Jul 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TuVR3Foc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D316F278
	for <linux-pci@vger.kernel.org>; Fri, 12 Jul 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788161; cv=none; b=iiEGbvmf+LrOzZzRStdvzBp2wj71pmk3e8f4LioHM8GOofmfpwePvs/fmfxqpAvQyA/Bau8YF6t35o+XapMamaOmy1aM6t7z9HGyKwjPTo2ISShzo04UfGt088iXWAd6roVd8sbJ8Qe4S+X1jc1zypt3VYsDdzQ0GALeTjPldkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788161; c=relaxed/simple;
	bh=kBJT8YbrNHkTssvswA9gJLT8aMBMcBvE6Xo16vVg1no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1uuRHRyd1faMXR3uw5rjaWsyiNuJdUFQRXqQXCmlmEkH0E36of3gqDOa1Nt7L1VhxoxcCEwuPUIsSo45fimdEyqOPTMmHNxmoUD2UWWQMyptpJfr8o07fJWWmGC5AKLbPih6fNyRFxLIMUWzBqH6HR5CMkhn29RS3EmvYvlpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TuVR3Foc; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79f0c08aa45so137753985a.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Jul 2024 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720788159; x=1721392959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBJT8YbrNHkTssvswA9gJLT8aMBMcBvE6Xo16vVg1no=;
        b=TuVR3FocARcpqfy530ragffG6U+brCvhWS74eVbcK7zuwsGCjwYxyLVWPeCrW8Tl1Z
         keThHek33bvykJW6zX6kX1mNKTFcGKYArF07Lhfka5PtwUFxF02HtD8kXJrw28+zvshz
         z4op9+LIk59enAtbsw38HLzLvvkiKZ9xNLjmPlJO6UaNCm+oKss4tfy/JU2mkZHvYcs5
         VNGR8sF/olPMkoj1z3PC0/B6VXwgq4l/Sy3r+Xa+Ku64ejfMbrySZOrE6M0ZZ+qcjfMw
         cB48If94KqPkEJkiivRvonLkUNG26hhA+RLDyQBBDYt8nKt3spEwhEnlaZnw08TdGVoQ
         iPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720788159; x=1721392959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBJT8YbrNHkTssvswA9gJLT8aMBMcBvE6Xo16vVg1no=;
        b=UJ2Ax2TLgqOFaYGWbbZKHkeUUJxNUaNEIaXfusaFdS5QWH8Utq+fnJ2tlP2T3ORe5T
         iJAwv32wuAFrhQJdl1chDnFeszlaBbDf8zEuwTx0sTaYdzJ1vXVfHHCanonsOEIBmAJ6
         8fC5w9DAOYeCXnGo1Seyw5yJe24r/hpdxL6Z5/UULZCNiTQpoU3cqJp8WTAnvGH33zwv
         TnI3G4nJKbXgW2a8f91ckfUXdfzEdE6naF3TNraiNhBum8QrLLk88LcQgsf0n7VRqFcg
         7K5fPcXbnAlprf4f+bNpikaiXXiBewV19L4I8cclWGSWb+10sSskjGKnBHm68VXjDkw2
         kSKw==
X-Forwarded-Encrypted: i=1; AJvYcCWzPbhEtByyirh71cJrcVCnPpC3aFygkQFh8xwvXfV3wweApiEOVBmu9tMF7XvNSmfOV5EMxdigRu5m3MQY+OFN4wnBYTx5FC0H
X-Gm-Message-State: AOJu0Yze8IxuxTFp+rXghVmz1cYRnMu0ZYWA0iY50E0PKn7MbmP+DWFU
	zd0f2wfabQ+4xw9fXvjUjSpPHbpM8l/80e0w7130goajB0+5g2BQsI72zsRCgg0=
X-Google-Smtp-Source: AGHT+IFNcSNXyjLCUq4DHk3R2ij71BFERvS9sNsM3zBakmLtTWzYOjs3C+yBv/o3LvcwnsHGWOmY4Q==
X-Received: by 2002:ae9:e315:0:b0:79f:1836:b143 with SMTP id af79cd13be357-79f19ae5454mr1218368285a.50.1720788159083;
        Fri, 12 Jul 2024 05:42:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1902ac2esm394037485a.59.2024.07.12.05.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 05:42:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSFbh-000FUg-Ne;
	Fri, 12 Jul 2024 09:42:37 -0300
Date: Fri, 12 Jul 2024 09:42:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240712124237.GX14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240705063910.GA12337@lst.de>
 <20240708235721.GF14050@ziepe.ca>
 <20240709062015.GB16180@lst.de>
 <20240709190320.GN14050@ziepe.ca>
 <20240710062212.GA25895@lst.de>
 <20240711232917.GR14050@ziepe.ca>
 <20240712045422.GA4774@lst.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712045422.GA4774@lst.de>

On Fri, Jul 12, 2024 at 06:54:22AM +0200, Christoph Hellwig wrote:

> This is all purely hypothetical, and I'm happy to just check for it
> and reject it for it now.

I do know a patch set is cooking to allow mixing ZONE_DEVICE P2P and
anon memory in the same VMA ala HMM with transparent migration of
ZONE_DEVICE to anon.

In this situation userspace will be generating IO with no idea about
any P2P/!P2P boundaries.

Jason

