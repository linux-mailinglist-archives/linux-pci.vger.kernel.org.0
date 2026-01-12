Return-Path: <linux-pci+bounces-44569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF86D15E41
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 00:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4FA330060CD
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 23:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA62285CA9;
	Mon, 12 Jan 2026 23:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HAWkep//"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C942D238A
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768262058; cv=none; b=efzmZFf+MAeG52U/uEq+CG+HP+pVCl2WJ7HCZGADvidbbP8mq6VwD5JtYchjjTARD5kRVNtXMFu71+N4+C2EkbWdrKDklSO2QJYOquHRpzbNzhlNXgMhxaWevLu2YmR85zPUweVMu9rUDF9jZxkgHJQefyu2XkC4YAgohONciuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768262058; c=relaxed/simple;
	bh=vbQpTPqvkNza84fX2uyalXQvb9OzER6/e1aJC0fiWDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqbGLVugJbKqORILpa7G3pVbWtRTetBGx6gndnnPwPim2Vywkp7hB4YVHPc2NTsTedHDhyaLYPHo1Sas1udJYkHD9akSzWX02MEM+pmSUTtYEKBhajuRRK9fU0D6g+1j4xwQ2qvJtCGi1jfTJ0y2/fBCRMX+eA8qGCqToyKWb7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HAWkep//; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5013d163e2fso401611cf.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 15:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768262056; x=1768866856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vbQpTPqvkNza84fX2uyalXQvb9OzER6/e1aJC0fiWDY=;
        b=HAWkep//EFhJW9wywQFy2dMaCD6x0rWanih6xdYl+a8hTir2qjOknoBiE1lYRxRgVM
         /whsUs9cl+Ycb2AwF8z46BlbbZhWzq2Pmk/lSOqE5IkoroReJFVjrZ+U+1szEvSK6pmk
         QuYiSTtT7Z/pq6rwN+f6YxFrG2KQnyFXY5sMHbedmi3Q642Ov5MBM/fOix+b27wozxUV
         VDzacX25oMKjSSCEjRbKUnkEQ0yhlLisnQCaTAysRvJTC6r6HiOKf1jTMCBX8OsO+m5/
         RvXYkVstXSGVKRf9ehh9ysEdilZPK5RHl2PY19gQMPVMg125ANzOIdNrBAYetGIAzsNU
         sMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768262056; x=1768866856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbQpTPqvkNza84fX2uyalXQvb9OzER6/e1aJC0fiWDY=;
        b=gpVWnpIT3U7/eau2MHrupx7WmVxzf39KWNdfi0ZIjSyeT99Po4PkugFDaEjzV11Wez
         TH8/EjnDjqeY5ril408IQTZjyUSrWGrfGPH4DLKLm4sCReF+lDSxTlLh6hhoOURl609f
         7TWR4DY0FLonQ7jNcF76ysmV86CJ6HJ+a1fvjc8bvyJ7N/3WY938Dl+sFFkM7CgASIV9
         aRbIqlU+dWqkpDyOvzQqp/jHPwC4lAW/YNHg69+B6CxwufTYCXptP+ydauhTIKSOqafG
         stw7pcuqoMpdODNe165n+pGxX32JCDPDLZycJp/ommrjRLaMXQipQ8zBf6QulPD8xj9m
         J8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU8iGqUjRY8UK6ogC4R9DoZNCo5s4BKfYxXtzfG3PWgp6LGLqqbGhPCUykza2SDUePLwuyRzG01y40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfGQIOKBx+OT9dcBP8ZOpBeyPqfVdZNu4K0MXWVMeJ/0u6/xnX
	HA9V88F9uZA/c+AOYGsLbQx4zccLDt8/yb5pDu8/kj9ge2yYCwIl4mF7KisxeIFFKC8=
X-Gm-Gg: AY/fxX6JEwi7L0qFD/oVBG2swRVsa3PfJhmcHYfRY6ZLoo1OFYn9aKil0gb+GBBhilw
	kyuFjucgjimb7kHwVGf8XvZaNQz0FvUP7igz9dKatlGQ03T2LRp0eBJinugHKyoQwVYeNBHWUeC
	0KYUJenp07kyb+Q+Lq9vmcOhVj1YvfiiqZ3UBNVy/mi5mvJyT3ZjQwkLwNaXoqk220XPlf2XIjL
	jiaROJwFqmAWxfuXWtygNtFhbCCgV0jOKPxnXzhXl2nW+RZMSljLzh1kVY1prHPG7UMWsbPoVRl
	Ea5dwBr/EIXU0yZ6Mhu1R8/U+pjMpAocncZwsPqXC3soc/C1hXlJ7kgZSo1ERu1jjQW9lneF+s1
	ewPhPcQxKvCvcT/qN6RO8aYqyKcvZBT8O8AISDMghpwECUSunpSG0fyuWCZqA8cL41x/nP3C+oK
	tQlt0DPSnlyJVw+IxCiX9TZge6cBUFNebLjWdrMSTozAOPTtv+txH0lqWSstHOL1KJUc8=
X-Google-Smtp-Source: AGHT+IFqShnh4nFq4FI+txOqV94h9FNeJmPa4/JUWRJXzRBu2Yp6JXhvTMJ52+U7dVhw4CMApET5TA==
X-Received: by 2002:a05:622a:8d1b:b0:501:3b8c:7d63 with SMTP id d75a77b69052e-5013b8c8686mr4698571cf.26.1768262055766;
        Mon, 12 Jan 2026 15:54:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e35dbfsm129011631cf.19.2026.01.12.15.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:54:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfRji-00000003fUm-0uFg;
	Mon, 12 Jan 2026 19:54:14 -0400
Date: Mon, 12 Jan 2026 19:54:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Francois Dugast <francois.dugast@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
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
	Michal Hocko <mhocko@suse.com>, linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 1/7] mm/zone_device: Add order argument to folio_free
 callback
Message-ID: <20260112235414.GO745888@ziepe.ca>
References: <20260111205820.830410-1-francois.dugast@intel.com>
 <20260111205820.830410-2-francois.dugast@intel.com>
 <aWQlsyIVVGpCvB3y@casper.infradead.org>
 <874d29da-2008-47e6-9c27-6c00abbf404a@nvidia.com>
 <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
 <20260112134510.GC745888@ziepe.ca>
 <aWVsUu1RBKgn0VFH@lstrano-desk.jf.intel.com>
 <45A4E73B-F6C2-44B7-8C81-13E24ED12127@nvidia.com>
 <aWWCK0C23CUl9zEq@lstrano-desk.jf.intel.com>
 <fzpd6caij2l73jkdvvmlk4jxlrdbt5ozu4yladpsbdc4c4jvag@d72h42nfolgh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fzpd6caij2l73jkdvvmlk4jxlrdbt5ozu4yladpsbdc4c4jvag@d72h42nfolgh>

On Tue, Jan 13, 2026 at 10:44:27AM +1100, Alistair Popple wrote:

> Also drivers may have different strategies than just resetting everything back
> to small pages. For example the may choose to only ever allocate large folios
> making the whole clearing/resetting of folio fields superfluous.

+1

Jason

