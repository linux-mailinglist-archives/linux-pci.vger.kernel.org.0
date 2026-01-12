Return-Path: <linux-pci+bounces-44568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E3FD15E1E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 00:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 910923016ED8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 23:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA692D2397;
	Mon, 12 Jan 2026 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Jg/9iBa/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61D32BD5AD
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768261990; cv=none; b=ucY8yaLOXiW/2qvS1TTrXaKroKYKkSLSkqZm4mAbsXQCgPTvHSAYwuguo0JXnjNeuqH+yZoq316GUoJaj8IYuEhmN1CRky44LN9Y5QR6M/la+sNxH6fnvSFT9JNkQf8xd71Q/yWLhgdSavm8zWxQM1amotu9l2w/IkSn31yRk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768261990; c=relaxed/simple;
	bh=OsumxHHod6cIwX4b7rdpDcd79fga9ieWIlr7hu71obk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNYhIzvJcmpgCd0cvGn0+NglWHoj1olovMDSHADkIDDAh7JWX0377Enege1prq7MAiaMgMeP1RHbdPjYeIXn0vIwcrk0K7JM4cs4g9mSsshdOy+eZy2+LyY0euxWFp4yHcUO08EjDygA2K9buxo1xcCoWRCOESKY98ZLXIO2XgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Jg/9iBa/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b23b6d9f11so748504985a.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 15:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768261988; x=1768866788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MFAPVPPrTQcXGzmX4uMQny5ONRwVZsvoYJMZG32QBJM=;
        b=Jg/9iBa/FaqzZNIe0tXBwAIEk6mV8adU7a0Sr276NkTnVEOdm/5rCGuq7FsWF+FA0d
         Q9J4zzEmw555iFZ3q9O1cG8LgHnJgS+00Rq4pum2YJfYTw68mf03f44mrTRFIDYG2CI7
         86IazSc5frMobT5lMtuCnSYtwBqEQKaCnrH0wfkftQDAItzE3r4u/o8xxKmT3pV7+BC+
         xYULpTvrv2IAqRMWFF/ME7JsgbEfYLJBUsoddr2HWZO+HcXhYu6wygW8nf0lItb2G4eU
         olfnP8lZPmMOROH0uixhcMJKlheMNtx0oas2ekwTggbtOZNYxfIvkrZHhcnlABXByfbF
         c1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768261988; x=1768866788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFAPVPPrTQcXGzmX4uMQny5ONRwVZsvoYJMZG32QBJM=;
        b=NWLiDGnukQnRhEBQKcw1dd4jeyjyRnTZeDGlqbO1GR1bx/r4hqa2hd4QNVu1QGwq7m
         KBxLr5pOUPuy873NeF6kgaaaVSGlADd5ViuKh5xue65rtJJO4T0+Z8DmRn9SfpaZj5Vl
         eybyvs3/6ls+V3SO7vY/sm1pUV1WTil42OPAYDcjr9F36k8iRFSFkrD6T0d8LBpG0Cym
         HrrMFjVol2cZqafKF/If7hfm9/iAr2uN4n/s740FN1JiKaGxwY2hTvZsxo+p6APX5jth
         Dgnnv9vu6P80KfemmAvsSsGzW6+xcdevarnyRUAz3M2S2QMKhOpn5+IoMAlkmSA/jRWr
         x1KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEpdKqaUQw7lU/7U4YlfJb8qto65fq7ExCU+mgkUKIwx5VTtSVl9KBd1mQU3vw+0cuP7UEzBDuz+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2sf7Ha0ZWYwigUAcqUD71MXGQVDUvr8izhl3QlJ6CUnJWqSqs
	oZfsjly4b6EQJIJlXhPDBptJjMfq7NF4kQbjo1ZmA4lfL7j0gbRllB+JbZd7VF466jo=
X-Gm-Gg: AY/fxX4JXeqkk+olvIo6sZEgI/tRJaPetYIFM7sBZ3ZKUL1baGEDP8pjqUPu1fkgVTD
	X/b9Bcm0AkgoPOVD9dBu2qs45jdDoZuCyXayEdDVFCAMYV1MVAVuz4brG0+MNTz1isMW3ugQuOp
	wv4ZqXCGRzyF4qEXE8NpptrM4TGeYn9HzbzTugtIqwG9yNRy31BdGZKNscKYbfjA29JP86NPN0S
	Pb2I6GPHepoYpemXT+uR5QAAXFr4u1nsawdY46Q61E2PhP+Y6FVkGjbI6iMvrr0a4OoyBo7qzgW
	8U6ojVcuubJcX9eamlsuVSvoOO/SlC9SDRZObj/iTiyIy9q4qhvNOM0/XqYTxrwUs/6CqsS5kAI
	7e7asfBeJ2GrLtwaIzU71s6ATzKhPeN7caex4LhwHlCL9l5d8QiFUJ4Df7JMrZH+ImKc4dnKOzm
	P6Y5R7SRc8zhsqulIkz71+VBGXJawxNOGrlHub3uDT4mFamSpCsGJpMVAKvftw30eLn9iGM4f4x
	nZH2Q==
X-Google-Smtp-Source: AGHT+IECCLtz04Q1g6y58MlK+cu2G+IQ+shlJTLlvJFkV+wtTDGmcQVfka7R8tosUNuc3dGp+UEbDg==
X-Received: by 2002:a05:620a:4804:b0:8b2:7536:bd2c with SMTP id af79cd13be357-8c3894188a8mr2759937485a.78.1768261987580;
        Mon, 12 Jan 2026 15:53:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f530907sm1597443885a.39.2026.01.12.15.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:53:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfRic-00000003fUQ-2VnR;
	Mon, 12 Jan 2026 19:53:06 -0400
Date: Mon, 12 Jan 2026 19:53:06 -0400
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
Message-ID: <20260112235306.GN745888@ziepe.ca>
References: <874d29da-2008-47e6-9c27-6c00abbf404a@nvidia.com>
 <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
 <20260112134510.GC745888@ziepe.ca>
 <218D42B0-3E08-4ABC-9FB4-1203BB31E547@nvidia.com>
 <20260112165001.GG745888@ziepe.ca>
 <86D91C8B-C3EA-4836-8DC2-829499477618@nvidia.com>
 <20260112182500.GI745888@ziepe.ca>
 <6AFCEB51-8EE1-4AC9-8F39-FCA561BE8CB5@nvidia.com>
 <20260112192816.GL745888@ziepe.ca>
 <8DB7DC41-FDBD-4739-AABC-D363A1572ADD@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8DB7DC41-FDBD-4739-AABC-D363A1572ADD@nvidia.com>

On Mon, Jan 12, 2026 at 06:34:06PM -0500, Zi Yan wrote:
> page[1].flags.f &= ~PAGE_FLAGS_SECOND. It clears folio->order.
> 
> free_tail_page_prepare() clears ->mapping, which is TAIL_MAPPING, and
> compound_head at the end.
> 
> page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP. It clears PG_head for compound
> pages.
> 
> These three parts undo prep_compound_page().

Well, mm doesn't clear all things on alloc..

> In current nouveau code, ->free_folios is used holding the freed folio.
> In nouveau_dmem_page_alloc_locked(), the freed folio is passed to
> zone_device_folio_init(). If the allocated folio order is different
> from the freed folio order, I do not know how you are going to keep
> track of the rest of the freed folio. Of course you can implement a
> buddy allocator there.

nouveau doesn't support high order folios.

A simple linked list is not really a suitable data structure to ever
support high order folios with.. If it were to use such a thing, and
did want to take a high order folio off the list, and reduce its
order, then it would have to put the remainder back on the list with a
revised order value. That's all, nothing hard.

Again if the driver needs to store information in the struct page to
manage its free list mechanism (ie linked pointers, order, whatever)
then it should be doing that directly.

When it takes the memory range off the free list it should call
zone_device_page_init() to make it ready to be used again. I think it
is a poor argument to say that zone_device_page_init() should rely on
values already in the struct page to work properly :\

The usable space within the struct page, and what values must be fixed
for correct system function, should exactly mirror what frozen pages
require. After free it is effectively now a frozen page owned by the
device driver.

I haven't seen any documentation on that, but I suspect Matthew and
David have some ideas..

If there is a reason for order, flags and mapping to be something
particular then it should flow from the definition of frozen pages,
and be documented, IMHO.

Jason

