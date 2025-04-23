Return-Path: <linux-pci+bounces-26585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AF3A996D1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBB2920B5A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8E28B50C;
	Wed, 23 Apr 2025 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XV88OjQX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED832857F8
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429938; cv=none; b=cO0dscAvlzyIjCurATFgpHlG17m//m5U96XWmt2dWr6SS63VCOb0mi3y+76Bh0MpVShPMHERd+gFKCy+TNkCqdpT5MME9b+PyJLN9yip6brDOJUpUAntGIWdXNzMlsnh+E06bmBq3BR60fiP6X5+8smaWwxmxJC6T+qxpGUF5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429938; c=relaxed/simple;
	bh=jyCSrAMbJeJJMtfyLp932NW76okHOgg35e8+PFG3Bes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7Q9hdEQb+ioMTN70rR9GP4e/Qwe+WsS9Q3cxg1eH2igWxiu67s04OX6TMjtfCesf9fBEULZ6kTi4Z87jxXKgnuCpH1POt1BEMLH7vOjKlwZULDpuky2qziDGzPVsPkpv6hPHNFWY8hCnMkGY8n3VVLWKu635pvIfBAkBtgFnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XV88OjQX; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5e1b40f68so9191685a.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745429935; x=1746034735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZKbLbO/VBglO/Va9GZRrTXMgQWmFJOWwhYhgpmasyg=;
        b=XV88OjQXLvia7kK4o00ZKUcesjYunq5WroYYymOJIGPMGmbS/9i7/qihmuV7uOasU4
         OXl8PETx5N3fBmnwdHey/3OYAFXqGUH3OPC9lDRQ3t7t5ywtpMDnAQfl5fXiXDw0kz0Y
         CY7vXgT33OAcwYME65ecscD4qSwBEzKjCIcCmKALFBpmrDUzivrqYevJro0byOJABFZm
         U27EyPyD2OYa9Q5WnrYhRvJ6IlClmvfZsSYDVXfiY18SHL3rcq5umqVuzT5sD0yp3yd5
         P0OLu9NB/5EVomSa/v3aTFE9KbMXn5dTG7PuVElsFKFgm+UzdsRy6Q7MuGfp0offCZkj
         bQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429935; x=1746034735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZKbLbO/VBglO/Va9GZRrTXMgQWmFJOWwhYhgpmasyg=;
        b=XR5eflxu/sege0Ci+LzuwuqPvPkkyQndmSpTPHtiZ7x8HNZeJgfkgZvAhChUg5bP4I
         Dc8V0j/+T9dHqrvE/mwMeTNlIvqmjQLL940fc5sX1AdAVSCWAg6EYmkDjOeAeE3In8GK
         CI4DA09jtgGNW/cuxilcYKiqRtF9boAzGqN2oC+ttE3/z3O1ikr5MtrQxQri10NMhl7M
         SVPBOoMYxrKLoJHOTBrL13D4AId4jEfwK2zhGYprVrziakFYe7fqHgTeqczTY9ZdvrEg
         BDhYcp531+nWC6cL8gUM1OGwdlZX7Ki1MymJcOk6gs8iLi8Y68vGIIFYXNfXofWJrtjb
         em9A==
X-Forwarded-Encrypted: i=1; AJvYcCWsJmL2IiywulckQbqGuq5+yengxFNxpoRHUPpvneOhOiTv/EX5h0FnYE9u60HNqeiGRlNfuht1Ndo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZkBKpKj5b50IWbzvEEbE2gYVs7U1vbKzpmbQGYQTxQr42G7PG
	T5Tl0uAWR7ZTElzHq+9Q86AbXMsyyNr6I3+bSek0sSXt6+uAnlWIFJV+Eyx9qOM=
X-Gm-Gg: ASbGncsOPRCqrHyu4g2Hza8jaNkAMtaAOCp00qdSZm2Rdda8OoPwQlo3W/s4+Rc+wqP
	lb/JhFYWBN6BKyzK25jUdwMPTlUdRP+eKyLA0CaYZNhTGtZSG/77fPutIoehK6ymCW6y2ejaYl5
	Eqrej0qztQHK1Mo1pboaU0PrDGc1+VeHtg+HhwZpWp22Ft4DFPYXS3S6nhL122fBQt4RKRbLe81
	ynRerSqarcSuVnw5xgFln1TOeuENbMQWkV3tsHj9JQ58ZE9FnxZLJRyfI/GCyn9JCt0RBxwnoYf
	S8usaMhkEa1ALGlb0mzuBB8Jgw05bBYy1N3pEgOeqnbTovn5+hGgtw5vjPNDt721UHQCmckc8nE
	tdOV878chF5ytJuixdIA=
X-Google-Smtp-Source: AGHT+IGgN3qsfS6onNY8+gQMZCTHD3MSF9+S5w+6n1/7VM1d4IchwJLfZsPm7/0ZCJyeB599ZskZwg==
X-Received: by 2002:a05:620a:1917:b0:7c5:ae20:e832 with SMTP id af79cd13be357-7c927f6ff15mr2997015185a.11.1745429935582;
        Wed, 23 Apr 2025 10:38:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8c9f2sm708523885a.29.2025.04.23.10.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:38:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7e3i-00000007Le6-2jjE;
	Wed, 23 Apr 2025 14:38:54 -0300
Date: Wed, 23 Apr 2025 14:38:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 14/24] RDMA/umem: Separate implicit ODP initialization
 from explicit ODP
Message-ID: <20250423173854.GP1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <c79721bb70988f60fa23fdfb6785e13f6ef806c5.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c79721bb70988f60fa23fdfb6785e13f6ef806c5.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:05AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Create separate functions for the implicit ODP initialization
> which is different from the explicit ODP initialization.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 91 +++++++++++++++---------------
>  1 file changed, 46 insertions(+), 45 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

