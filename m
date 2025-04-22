Return-Path: <linux-pci+bounces-26449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD9DA97B29
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 01:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0A41887FAD
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 23:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0D1215773;
	Tue, 22 Apr 2025 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KmI9jC2K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33A2153ED
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365317; cv=none; b=LCp03roJmViz+WCspwN5n4pUAWKcbTLjZcKNKB4iKhzT8TkMCpGDQTom/Pw+IMgLdRZ9zWQXcPoVShKCXaToomNodvtpIaawGh9Fm8lWnreo5bm+c+v7SdP8FgTsRqDSDynVVVSbdiN5vU79hIqkpQIIS9gabeJp4/PIe+RenwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365317; c=relaxed/simple;
	bh=d7gFECswBR82rOuJZXYrMO6x34hzdB9wF7yn3yimsy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPXU/QmZx8iu2tU0hUc1FMNtGM7x1lAztaN+UoooeKMtbBb3ACy/RXvJQfMGhPGkX5ozh/XqC8/qwDN84MfcZ4FM052IESXu0YCkPMEs+x8Esv8vo2VRhZ/sqxz+879Cf1n8EDzyC0kxQrRUjKExyDeLN1ASP4m4ifTN3aAllrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KmI9jC2K; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4774d68c670so71314621cf.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 16:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745365314; x=1745970114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d7gFECswBR82rOuJZXYrMO6x34hzdB9wF7yn3yimsy0=;
        b=KmI9jC2K6mVfdrT/JKcCjRxSZJ34NfN1lwMtmTTY44LQxNRxO9tyaiY9fNSN16ZlJB
         OAqZSYK/zAUkC3j8tMdVWOgc69xj+tLv033Wx+xJ/R/KHsKd1Ggu+r/gj3NeIdYInPe/
         1qe6+yFI05Tn5uEvkWkZPvx2bPfnAlLFOfB/QzQHioHm1R2wJ3TDC7QHzhPkgUL6fEu7
         3Dp5G4CJVtD2a0lNTloyLnSKKzlpOekSTE+xT1XT7v4PvhcppkGh5+7AJJzz3yr5pi7H
         SrVgZBuGjseZvEgJ/QoLnHT7zPg+4QdLBXpJRIpwJjM0THel7Jb/EmOCIB7UB93nw3lp
         pniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365314; x=1745970114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7gFECswBR82rOuJZXYrMO6x34hzdB9wF7yn3yimsy0=;
        b=du706K1amVnorJdl66zAt1Tz+jjm6gGgVcdWIrdbR9BZT8/gvEm3Qb9PULnYERrDbW
         lMa0g7UrjWAbFmeuvzHYToZ1Q5NgdMB1bej47XUaTlEErMGVWwYDnRuzk6oV23fi7vRI
         iy0FWRkupg/EEkoX/tV09mm/rleAvJcHzfw05q1CSOneRJQpLud/WkNJciv56TGTpzL6
         fFToYgo+cJEssnfLZ16lbacF6iok6Yv9A3+jvnL30W8/uy+PWsxzuTHT+Adu/oe/WYBx
         NnkOw7ure0tsNKKJ6KZuIjAMlAUt/FconOXtQ8baNuSL33WiMPAodBnR6W1rbwVa8pS9
         diBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX85Jqysw+zYbi42hIDfQejUJBeo/6cW4z3+Ix6u+JeG+lyy4yQnfviMMjt23nPJVE/W/tjNHIg3ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2axKIPtpuHgLph+DbTOdXqIx+M33a/8VHcYoZYefDjYBuDxK
	qRxze6muWT46VQ2n5LQo0yzfRIPNVD/CIziTUmlx8CK1mCy0PempyOzXDVPi4A8=
X-Gm-Gg: ASbGncs7Xi9Z/lx1kWy2bcM3MjjSku2it6DLjBDHv/SstTewy8ytxb+rLpQNb7hUias
	NorGkYAnipzRG+iH6L9M1XlVmrhy1qrlyfGmnB/0bdPtfL9Ria6wc+O+OlzVvYwI1SXV9I2HCMo
	oCSJ1TvqjLhRvPdho5Mar0ng97lpChJduhqTUc/T8LNNqth8keZp+nb+n1ZLUTYTgYt0PKqoEO4
	CP9q5eKKXazJ+nSOuQLMxAnvibDDI/ovWG3ZKqKNYDQyYxsd2KlzN1PGoyWruuuqOoljES3LqKl
	jTtYURN2nF2eA2x5rCqvHFVYGMXgbid2l5YdzlrggBi4/tlPzcLqILAFUHGIxkxywjhmxntKPo9
	WqGkiHu0eMkGlB0Gtp1s=
X-Google-Smtp-Source: AGHT+IHMJVzBS9ofe/pFhoyhF1nSXR0nkPPB8mnB6Kmq2s/kk2ojN9lhj/BWknemUlGIDrPDFrdQpA==
X-Received: by 2002:a05:622a:255:b0:476:6189:4f30 with SMTP id d75a77b69052e-47aec4b5239mr303709741cf.36.1745365314381;
        Tue, 22 Apr 2025 16:41:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c4d68csm62754761cf.47.2025.04.22.16.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:41:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7NFR-00000006xuY-19ey;
	Tue, 22 Apr 2025 20:41:53 -0300
Date: Tue, 22 Apr 2025 20:41:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: William McVicker <willmcvicker@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <20250422234153.GD1213339@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <aAa2Zx86yUfayPSG@google.com>
 <20250422190036.GA1213339@ziepe.ca>
 <aAgQUMbsf0ADRRNc@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAgQUMbsf0ADRRNc@google.com>

On Tue, Apr 22, 2025 at 02:55:28PM -0700, William McVicker wrote:

> On this note, I was looking through `of_dma_configure_id()` and am also
> wondering if we may hit other race conditions if the device is still being
> probed and the dma properties (like the coherent dma mask) haven't been fully
> populated? Just checking if the driver is bound, doesn't seem like enough to
> start configuring the DMA when async probing can happen.

I think the reasoning at work here is that the plugin path for a
struct device should synchronously setup the iommu.

There is enough locking there that the iommu code won't allow the
device plugin to continue until the iommu is fully setup under the
global lock.

The trick of using dev->driver is only a way to tell if this function
is being called from the driver plugin path just before starting the
driver, or from the iommu code just before configuring the iommu.

Given that explanation can you see issues with of_dma_configure_id() ?

Jason

