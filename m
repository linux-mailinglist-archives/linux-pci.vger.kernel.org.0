Return-Path: <linux-pci+bounces-44502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6F6D12E28
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 14:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E40B301E93F
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F9F35B15A;
	Mon, 12 Jan 2026 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GICQ5ZAV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A439B35B138
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225515; cv=none; b=Awqm9m6YmkJK6X0dpJ6DYGFwRS/gYzuJGHz1CxTrp3znQ/J2hTmvlLd+Mwt7RCBkDf+FmKLkdL/wQ0nKekJ5LNoXfCeH5ApBPj7hCM5lPhVwUCg2TF+ZJ2ga27M/ofIpbb/xoHUjLtwuYM6RAcuOBQJPhRUWzkbVB0+gkgFQCQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225515; c=relaxed/simple;
	bh=cUHVEQ4ugeQMuGA4/ocXfnET6Ezlx8k5T0UznoHi1+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo5L6w5dK3yp7z7RjocAl1l2WoHtvOZ7PGWOJKeRMrcHq4xlGdAA4aWWTnjKYyoXtNwgxl9a88de/M3Ud3yHH3L2WPKq69Ns8J2xb3z4lkiEEBXZGNWElm2egF1Nj9YHMFOoQlTtnRat4jbc0hT91yfCScfOlDsiKrgFUysghtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GICQ5ZAV; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso71611131cf.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 05:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768225513; x=1768830313; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oQVWjYpPCtwp4dXF89g7hQK6KDriflVp74tvOjx72Jc=;
        b=GICQ5ZAV2Gr4ghdUMkl1JWB88WIDy84+ElyztjFepUU/xdAmtbj/1y56tkmQmcKRU0
         X+/y+LWb+C0pRWfeXjaugN3pS/SQy0OQjA5gpSLyoW/JwG6f2Y4+JallvDWBEWAyUxDI
         RJtTlQjGTDES1c1bzMb6fz/FCDYlpegNB4E8dsOLqxDFLzcHLs6d81Y6DWfaiMVbCTIn
         WOKI9rJVPkWfvcCMD5ava1G93AXb4Wvauh1gWyOKAPCYz+MKp8jYws7itoO2wH4yMX5T
         u5aDzBEqC15GTvQOHI0XQP5dWjnY8CkNB6hw9eBrF2G1tPMumuT+R0yvDtvL/CGagMWV
         Rn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768225513; x=1768830313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQVWjYpPCtwp4dXF89g7hQK6KDriflVp74tvOjx72Jc=;
        b=hkvSeNKFk1Nbzz5E4zkGLsmVgdBabn8HUjwrScBaKbiFdQ2XgkiTYcFt6+3wgUFAib
         XuiyaO8bfgcE5tcvLZmzAyk9x0WOa4z5n4gGsG1AlFnvAX3cnp805kaTRSrRTEyr3axC
         af7SmmyD+D1ASgdoezhoyJg4MURYNNBHBwKJXx7Uk21bVi6kCfiktul6oUSjEZqKVHDu
         nZq7AFkly8NozDuET2hj1V6/V7FRGK9S5M0J/l2GxN8lu+E+f0GktaVrmtbNOMx9k5cV
         myll91o6tGeYsF7CajTpWlZvfh/p9lk+z5O/VH6I6A34P8z99deJpb94M8oJTQ9Yg4oe
         SXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuertLDsKjYzuixzkt3/Iy/cZdNIW9ysspw4ni+F4fjSe4oQunFx4bJm2Yq80bYhci517loUYEJEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKuGSLjgQRMw5NIf3sO9WJKFgTOYZ/bri/4uARFDqCCRDjxTSk
	2O8+Iiha3/dCQm1pitan4uf9XtYhDsnklWIRTKl+3UTX7358WQ0DB7mDA4VKXMoMY5s=
X-Gm-Gg: AY/fxX6R1ej3qj5FUMrSSfNZ7YT6u8hJhXvtAamQfINcUXddUmzDOrGTTsTevZpM5lM
	+gyHX2AaRSasaIydknqGAQqhRGnH5VUYZPK7RU9LtY5cpEYq8FnFwyNPm2wL2NBtJgqkhBJQQYD
	+EIO2uEBlLeUKK0rSoiEUUPM9OdHhf1xEwoEr7kgyeAql7TbiEImqGbz75FfaR4zayWdT5WIneO
	ZXxwLDUeUTCLRF2bqWhl3tF7nnuSGcgFeDOUWSIITt89KTWUFKxlT59KuIPYl0R5WiElmT4kq08
	QEpWiQW0sJpogrJJfwDGMfkXJ+kNnSDBrFF5xCV3OaEyhHO/W/epre7sir1knZxn5qlwFIkWkKx
	lIcleKy4Cdqmxg+zeTlC2U2Su3mLhXKA8KPgzYDbZLeYXEU37hgcqE2MQHYEX6Fv2MCXCdIneoh
	Y4b165T/UoFNka7RjqURBKiS53xeCtSzPZgvpY41nF/aZq7RkMCKo2+FNoVb8hIXHVhQTmKirBh
	+kHnA==
X-Google-Smtp-Source: AGHT+IG20+wZaR0cdbZzmqo1CbORIU0XkpxQP0kdASvCc3hNxGR2kbLwFGbi9bRoyfQYpJE34s/36Q==
X-Received: by 2002:ac8:7f4e:0:b0:4ed:6803:6189 with SMTP id d75a77b69052e-4ffb49998dfmr285683391cf.53.1768225512643;
        Mon, 12 Jan 2026 05:45:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e36232sm124159891cf.22.2026.01.12.05.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 05:45:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfIEI-00000003Q1m-3fo1;
	Mon, 12 Jan 2026 09:45:10 -0400
Date: Mon, 12 Jan 2026 09:45:10 -0400
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
Message-ID: <20260112134510.GC745888@ziepe.ca>
References: <20260111205820.830410-1-francois.dugast@intel.com>
 <20260111205820.830410-2-francois.dugast@intel.com>
 <aWQlsyIVVGpCvB3y@casper.infradead.org>
 <874d29da-2008-47e6-9c27-6c00abbf404a@nvidia.com>
 <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>

On Sun, Jan 11, 2026 at 07:51:01PM -0500, Zi Yan wrote:
> On 11 Jan 2026, at 19:19, Balbir Singh wrote:
> 
> > On 1/12/26 08:35, Matthew Wilcox wrote:
> >> On Sun, Jan 11, 2026 at 09:55:40PM +0100, Francois Dugast wrote:
> >>> The core MM splits the folio before calling folio_free, restoring the
> >>> zone pages associated with the folio to an initialized state (e.g.,
> >>> non-compound, pgmap valid, etc...). The order argument represents the
> >>> folio’s order prior to the split which can be used driver side to know
> >>> how many pages are being freed.
> >>
> >> This really feels like the wrong way to fix this problem.
> >>
> 
> Hi Matthew,
> 
> I think the wording is confusing, since the actual issue is that:
> 
> 1. zone_device_page_init() calls prep_compound_page() to form a large folio,
> 2. but free_zone_device_folio() never reverse the course,
> 3. the undo of prep_compound_page() in free_zone_device_folio() needs to
>    be done before driver callback ->folio_free(), since once ->folio_free()
>    is called, the folio can be reallocated immediately,
> 4. after the undo of prep_compound_page(), folio_order() can no longer provide
>    the original order information, thus, folio_free() needs that for proper
>    device side ref manipulation.

There is something wrong with the driver if the "folio can be
reallocated immediately".

The flow generally expects there to be a driver allocator linked to
folio_free()

1) Allocator finds free memory
2) zone_device_page_init() allocates the memory and makes refcount=1
3) __folio_put() knows the recount 0.
4) free_zone_device_folio() calls folio_free(), but it doesn't
   actually need to undo prep_compound_page() because *NOTHING* can
   use the page pointer at this point.
5) Driver puts the memory back into the allocator and now #1 can
   happen. It knows how much memory to put back because folio->order
   is valid from #2
6) #1 happens again, then #2 happens again and the folio is in the
   right state for use. The successor #2 fully undoes the work of the
   predecessor #2.

If you have races where #1 can happen immediately after #3 then the
driver design is fundamentally broken and passing around order isn't
going to help anything.

If the allocator is using the struct page memory then step #5 should
also clean up the struct page with the allocator data before returning
it to the allocator.

I vaugely remember talking about this before in the context of the Xe
driver.. You can't just take an existing VRAM allocator and layer it
on top of the folios and have it broadly ignore the folio_free
callback.

Jsaon

