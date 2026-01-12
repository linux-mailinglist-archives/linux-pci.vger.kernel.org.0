Return-Path: <linux-pci+bounces-44530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EBBD142A9
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7BDF3002163
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD87352C29;
	Mon, 12 Jan 2026 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xh28jBuC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88C536CDEE
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236607; cv=none; b=SpvpCDSQ+vFxf9Gd/tqdF4Du1bIRJWPzdaheHSOH2VzWYldN/rTnCGxdPNM/9zQuNGWUZmXa0QwvW/xJmsIcWIHF9JEJyBx0/mgWZPDZaNBxObxSBNco9h3ZhgSum1pOuciWAD3yAKrGoxKAbMU5onYHJy347kV/1+I38fCi2Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236607; c=relaxed/simple;
	bh=tqjQya8iav+U2F1Y8sTA4RoO8FG8N5ZbxkqeKQhKHMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBJFbynbuJQMPrs+c8qxiv8jax59ftOHfhiDwhwpb9WZsCRMh/+tvufQVtUadq/nqBP4ChAJ7wvmeWJGZ+bx8+Hv13vxOg5nlfE32WgNluM2sodzRu2/U29mFlySh4eC13r+xge016RSZFtcdPezJtifYZlV+TieLFFNZD/biLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Xh28jBuC; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ffbea7fdf1so33029301cf.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 08:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768236603; x=1768841403; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eAxh70JY3ShLNfnDxBWsRZWpalCHcaRfsM5YzKZ+W9w=;
        b=Xh28jBuCzSmjNImJHPipMhJ0Ay7bk672VmA9OuRlRS5xHW5yOjBQoqGrHp/AwF81rB
         U4wbU+uoNLx2hWjU7U4zq3tWfLHjExnBD0S2eQKaomwC1k6Re30nBI8pSTT4ZUFwDXtw
         NB+3sqspu7NHXnhnH1vGI97i4pjAI57Tck8NM8TbREST9HEQAuFfCqITWgCnp0IvR9fK
         +ZdAosDXqrYrMVZd4ILWmB9i07jlSbP6DyIB9yxkaOjGqB4aGN22b/QWCSygCzJpyPQe
         W6fEtrLRoKz3QtzuKuqh5mJBRVgPzcZzMRv1SZTKdpfxUsRxAxwrExm1lW+TsFUPDzah
         L4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768236603; x=1768841403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAxh70JY3ShLNfnDxBWsRZWpalCHcaRfsM5YzKZ+W9w=;
        b=tV7xsdIpKGNn0/m51mR3WcN2JkHPseV3hSPj5r0YGkU/pX6yMMXwAhFPFP6+QYvn6o
         8f0ua7TqkI8drZdUlhMepEED2m4R89sXwUyfWZjmB5m+JvvUWs4/h5mk1E3nXamllOFX
         uEXCp/Va/OGvmbDQOY56jU29qhxD/5l461QBvJY2CIKEX9F9WT0MCfBriNpuApeV37Es
         GQFrp8YGRU6JZBj9SIK+qwpp94qxjkts6ZXMlkVUk/1g4duOmqsqQYQClZW1GnzBVYXk
         myhEUZ1LcbBEsiuEIE3NA3Jcf5s5JJmZYT+zqL1o4+vQ7Z2eVArw/SjRAPPzEnRxbfPR
         MEeA==
X-Forwarded-Encrypted: i=1; AJvYcCXorvjX85ZQsmv3hR5veiLImGwzFkdAga9uYdiK3jc5xZ7L20BKODFwaoh8T1zDkS2bWC+Wprx/mt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztwF96LPfZBLRKLxF9ENoYLVobmP2vxb/E/VJaepPKz3PeOnK7
	u9bimWAOT8d8EY/TYOQVlyMo28aPCc8JaZP0mSN8u+gFjY1poamPDRuxk2XRozbjT6I=
X-Gm-Gg: AY/fxX7J/RYOSormDzwRd/EpIL/gyS1VMyFCn7ffhsW9WnraXc7Gzn71Tz1rORPs4Lg
	JeALSgJFpbHn5j3LuRm1EnaMNDSJV4ucrT4PITGA1PNw4uSjd3vzsSysW50MKdIIGficV7R0MJW
	w9MLlodoB6pcobP6Hpdm6k8/7d3CQ9kkbTOvYB8RGb+yiyGGnJnGOwjZchs6BdwK7QFVqpbKICR
	ZLlYbQowBpkcZH8hVli7H8ZpvaAVi2nO2eWxZ3AaIBqYF3H3VnH9V6MTq+KaunIHzyZLbsNUYP1
	Rj7XYgPVj0oHePkVhainNtIuGHN1LCtBlvBfBWtxAa5u+MQE8Weca0V7+eAVUkfaicFuCM2XZQ/
	nSuJKHQNdDRJYfu7BolqRX9nhUFHzLEyxAD7+xoIkLuOW/9E0pmIffDTcaaud0j0XOUCOaOmqut
	qPmVulL7GhwUAG661yQG0RDVoFFv8OI7LpYf2NQYEpT25wjwbTQ1+i93yHIte63MeW5JE=
X-Google-Smtp-Source: AGHT+IE/A98Uf8f6ySXPvh9xamBlLANpUoYS4iXttzp8YDJn905I/7mcjcPxPkNVMXbRPnmf8UaJPg==
X-Received: by 2002:ac8:6f1a:0:b0:4ee:208a:fbec with SMTP id d75a77b69052e-4ffb4a1ed32mr255276771cf.66.1768236602551;
        Mon, 12 Jan 2026 08:50:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077253218sm139285396d6.43.2026.01.12.08.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:50:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfL7B-00000003RcK-2R9k;
	Mon, 12 Jan 2026 12:50:01 -0400
Date: Mon, 12 Jan 2026 12:50:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>, Balbir Singh <balbirs@nvidia.com>,
	Francois Dugast <francois.dugast@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Matthew Brost <matthew.brost@intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alistair Popple <apopple@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 1/7] mm/zone_device: Add order argument to folio_free
 callback
Message-ID: <20260112165001.GG745888@ziepe.ca>
References: <20260111205820.830410-1-francois.dugast@intel.com>
 <20260111205820.830410-2-francois.dugast@intel.com>
 <aWQlsyIVVGpCvB3y@casper.infradead.org>
 <874d29da-2008-47e6-9c27-6c00abbf404a@nvidia.com>
 <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
 <20260112134510.GC745888@ziepe.ca>
 <218D42B0-3E08-4ABC-9FB4-1203BB31E547@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <218D42B0-3E08-4ABC-9FB4-1203BB31E547@nvidia.com>

On Mon, Jan 12, 2026 at 11:31:04AM -0500, Zi Yan wrote:
> > folio_free()
> >
> > 1) Allocator finds free memory
> > 2) zone_device_page_init() allocates the memory and makes refcount=1
> > 3) __folio_put() knows the recount 0.
> > 4) free_zone_device_folio() calls folio_free(), but it doesn't
> >    actually need to undo prep_compound_page() because *NOTHING* can
> >    use the page pointer at this point.
> > 5) Driver puts the memory back into the allocator and now #1 can
> >    happen. It knows how much memory to put back because folio->order
> >    is valid from #2
> > 6) #1 happens again, then #2 happens again and the folio is in the
> >    right state for use. The successor #2 fully undoes the work of the
> >    predecessor #2.
> 
> But how can a successor #2 undo the work if the second #1 only allocates
> half of the original folio? For example, an order-9 at PFN 0 is
> allocated and freed, then an order-8 at PFN 0 is allocated and another
> order-8 at PFN 256 is allocated. How can two #2s undo the same order-9
> without corrupting each other’s data?

What do you mean? The fundamental rule is you can't read the folio or
the order outside folio_free once it's refcount reaches 0.

So the successor #2 will write updated heads and order to the order 8
pages at PFN 0 and the ones starting at PFN 256 will remain with
garbage.

This is OK because nothing is allowed to read them as their refcount
is 0.

If later PFN256 is allocated then it will get updated head and order
at the same time it's refcount becomes 1.

There is corruption and they don't corrupt each other's data.

> > If the allocator is using the struct page memory then step #5 should
> > also clean up the struct page with the allocator data before returning
> > it to the allocator.
> 
> Do you mean ->folio_free() callback should undo prep_compound_page()
> instead?

I wouldn't say undo, I was very careful to say it needs to get the
struct page memory into a state that the allocator algorithm expects,
whatever that means.

Jason

