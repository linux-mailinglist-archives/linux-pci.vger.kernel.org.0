Return-Path: <linux-pci+bounces-26587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ACDA996DB
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD2E921997
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9967E289365;
	Wed, 23 Apr 2025 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FZK0tNyc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0AB28BAB2
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430003; cv=none; b=I6jPdVI8qdXxeuHNQF/IZRwp606uoiGs37Q7qL+qLGSR3T7EnB73uhDWD2IKonGbaCcSqJniOK5XoJt5lqPiqTE0Uat2YgxrcRIEXWUElYF8S9RgtJ3kPWF5KwIut1j2hoIghTRDlI/6iY8iSWqV2KUSCGA+yBesdkVhgOBIn6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430003; c=relaxed/simple;
	bh=fqDUwA8t2UWWpUEyQC6cAVOhBUnimvgbh866DiIXJ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsQICdrTkAIGhD1g8iYclO2OA7aFWyudKbKt62WUh8HnumULe8mKmxO5NswKJY/4KnoY+oRQhM42o9Pf+NNsk0IXUpa//LWPxcTr4eEU4peEoVyJAcTuHZYQ9GNA6ZjeoUc5L3u8A4BBOujVTq26+JRPDdMKzhTUe9Cm5azM59Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FZK0tNyc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c554d7dc2aso10687585a.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745430000; x=1746034800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dkawg+tdbHC9hQ8MctNRicE8hYlskMOz2aG9rt+rsDU=;
        b=FZK0tNycIZeEcEKi9Hf/xEWwd4R5BdjYoXvf0cAKhFshlekLKW5HOX9yKKXmpIFUv5
         79Rn9V/mObXQNsTW7WSayR736S462gXQaSU/orkQMUfjtrvbRSm+Cnuhe02vc5N1bE0v
         0KIAD9CwsRC9QPAYCgnj6GcjGyA529Y1v40yo8V2gVxaB6wQZiIfSYWEcJiS+WIs6F4M
         GYwR7rLW6F7Ly+gdekmPYIjCBSgv+slirmo/Qhisyfpdn0Y3c4OPOkp+VWuezk/D4Z4N
         G+lxeOynZfSiMEjeiqVlu17y6KkaZU3jTxuHdOnmDYsijasnvdQHrIQLQ2+0Ww4AUEVJ
         vZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430000; x=1746034800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dkawg+tdbHC9hQ8MctNRicE8hYlskMOz2aG9rt+rsDU=;
        b=NYdJh+GNN+/LzMh5+Zh4vLE0KHgkI4pxY/OJeQHaM3M1g0npOMmF34B2U84HMvja1E
         z0dJv80JRlG+qp+raMxYz5NJLeJrKCY4cUa3yOYvb6muCvE8/SpxcFC8DppPfH2ONIJB
         MQGIvpgQtDXTh6NfF+psMh73/tcGm2hJCRbX2YnRG9I+jSfn+E0sMxxr9tSUvJatDazj
         6BoDQgHqkDGP7am1xYd1vbIwZ0aL8mM1kspno9c4XOQqQCsVHdYETUS+x8vY1qG4DeWX
         fnN9oNcopsBzSa9BVupbiseM2pKTarIZHFbW0p6E6BBC3QLkXSyyQNukjxVUCSKS1k1G
         LXdg==
X-Forwarded-Encrypted: i=1; AJvYcCXc9M/9zUf0VHv4ZAyeDoei0vi6UN0EWX2ORcDeomR6r8I9lH5thK4XRWxE79q2I+ydrA/cgAUTcNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4mOGaC+U3HF9COIKg48W98KRnNG0l963pl4SCGPsMpwY4jBko
	kY3n4yAXWpZXGUXzyUtHoFzVsEYTgvsItLCKIkOrmVf1MoYtSANs3nhf/wh/I5g=
X-Gm-Gg: ASbGnctBwFyLduVxEgUEmJ7r1azk1jN5+Bqy4yV3X64wsGv+hTdjjTx6zpZmYAjnAES
	M7fKBo12dBO29rL9BSImyB17vNfg91HrL1IUGZxORc51b5HaGvtJI40HcYTVem+JiZQMbPcNzx7
	wGx4RAnX/sU5/3lq/ce/dGdL6f+5v2Rln2rP1MmQorlGbfe+OBFRyC80ogL90tEW110ZVTmBI2O
	Dy/CigE1ubhk97DD2i6hcQh7JUWz/9QfauRIBWyAOy5b3J2sp7JCeexGVMlxdroobbolWUU5pLS
	fpCE0tSIy4+G9jaORduXgZmUNbyVmEDY4Qt2FSK77QweMdGq7FugIAj1p9U0C0YT+9iMCQVwetb
	WtTsk2GRt30m5cWLVigD0ORzBbmtSNA==
X-Google-Smtp-Source: AGHT+IEbQuW5n2GfFvJAnoWRo8rT/VepuLZ0gxRArfui4RxjUWT0n6IGPAbDd8GEItyJpW33RI8jLQ==
X-Received: by 2002:a05:620a:4043:b0:7c5:4c6d:7fa5 with SMTP id af79cd13be357-7c92804d68amr3534168985a.48.1745430000401;
        Wed, 23 Apr 2025 10:40:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6e9b6sm711717085a.2.2025.04.23.10.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:39:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7e4l-00000007LfH-1pvw;
	Wed, 23 Apr 2025 14:39:59 -0300
Date: Wed, 23 Apr 2025 14:39:59 -0300
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
Subject: Re: [PATCH v9 15/24] vfio/mlx5: Explicitly use number of pages
 instead of allocated length
Message-ID: <20250423173959.GQ1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <f2367fb33c0716ba661d8ecbd423e7279be23a74.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2367fb33c0716ba661d8ecbd423e7279be23a74.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:06AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> allocated_length is a multiple of page size and number of pages,
> so let's change the functions to accept number of pages. It opens
> us a venue to combine receive and send paths together with code
> readability improvement.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/mlx5/cmd.c  | 32 ++++++++++-----------
>  drivers/vfio/pci/mlx5/cmd.h  | 10 +++----
>  drivers/vfio/pci/mlx5/main.c | 56 +++++++++++++++++++++++-------------
>  3 files changed, 57 insertions(+), 41 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

