Return-Path: <linux-pci+bounces-2810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A3F842952
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 17:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34E21F274DE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 16:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6945A129A81;
	Tue, 30 Jan 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oee9L0w6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8801272C2
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632203; cv=none; b=nNFKibJ8T5+Se+QVppVYenHgbfnEorZvvch6u9eQo+CCu1cyDD25XPYBTuyMJW82rZ4n3YsuqCaZH6lQH2pTgkpBjBZHDEWAlxnsRDodxEV5MkemE5iPwtPRbZFAtuSyECn1vLyIXjGtK0CMJkxl5wJnJcMvIhMNvT0kL3wzbhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632203; c=relaxed/simple;
	bh=HGUrBCzw44fCvpMm/PJWRDlmh/Lag6HIgqKwNA9HrWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQK766U3kRZ5Mxx2nCvA/inPnulg/nJdPhTq2PeQG+lmJORlCayYLqV37RrStBw1XcMxPFIPLFxdRKCTHfL9kKjW2Dnn2tYxELfr06kjxdtXGK1n4N9oMOydKj6MG4DOzzDXZS/rAPVNaB/vEiME936M3oHroQ4UIG4SlkQ4uKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oee9L0w6; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42a99202ae0so17486951cf.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 08:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706632200; x=1707237000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Zcz0g1eKRHdqCkK9hAt9D66pTC6Kq1KClFa9gGBswE=;
        b=oee9L0w6kTxb+TEBX1EaGVSqTUgLmvaM7W5MhZngj0CBv4NyMFZAXvoOS8DGUETRXE
         1o2c+xEhFJN1AvQMGo9HUO4Byl6rVkehTmJRiXUqO390VwHVBNDz039b7sv0uPTQyalp
         lQjpeiO9/z62r8x3lmOwKL0H0BqnQKSHaOY8ARY6aysr7MJej13TcgQS9KdysPF+UJC7
         FYN5uMfxVC01Pmk5YmXR6tVRcZ/uz4xqpR3BTiwo6aHG3TCASM10C1EW/wQrX2WCtMMB
         cC3gJ2A22niq56IWArJbmV4Lh9eLKMVOQ35yopowSIFO+ZdwmF2Oushel/sfRbo/0pxG
         Venw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632200; x=1707237000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Zcz0g1eKRHdqCkK9hAt9D66pTC6Kq1KClFa9gGBswE=;
        b=h46d5nqSNP2q8aYB+irExq/i0TTjDaFiYOuCIA97yDKHsU9bS1kb8lOxOlm/DW0XqW
         KqGnxpd1ulh/CKENoFBWo/x6HcVVxo3Eup5qt5NoPtwKxQM+TvMB27RfGWsV3fO2ikDK
         Z/gZCv6EKq8CVaFBQt2HtV7pEYmk0pCM+gFUUS8cygM5R3M9VZOp66sc7o4fDlQbiOpm
         9gf0sCma0x0BR9LSyHNi8EkrVRZrXlJTaVMG7gYt+ijagHnj8zVkmYF53eE5i+JPhqC4
         GJkKn/zf84fLt8z3SmNQlfcQOc9j7T25Dkypmuny7gsoXQUvGUTe+lYBYJJKXMZU5biO
         cq9g==
X-Gm-Message-State: AOJu0YwrFNuYSlDygqgBiJ7/Kgdjx6JuvU5M4epU/wwTPCHX5F0OwhwN
	DL8lFjZ+8hlg1timH8+/Mm7DwBfWkd9XYIaTUV5nySeJXzEzlhv/CxF+TC0plCw=
X-Google-Smtp-Source: AGHT+IHJ22nh+Fe0GzCkeJR6CbigdX/oZbOW5Ogqo3y2IKf/Ji393IFIDhCodz601kwxWiAWl4jxrQ==
X-Received: by 2002:a05:622a:1454:b0:42a:ad6b:cf92 with SMTP id v20-20020a05622a145400b0042aad6bcf92mr255081qtx.10.1706632200418;
        Tue, 30 Jan 2024 08:30:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id fb21-20020a05622a481500b0042796ee2fb4sm4144162qtb.30.2024.01.30.08.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 08:29:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rUqzm-00AJVf-T4;
	Tue, 30 Jan 2024 12:29:58 -0400
Date: Tue, 30 Jan 2024 12:29:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"will@kernel.org" <will@kernel.org>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
Message-ID: <20240130162958.GF50608@ziepe.ca>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7adec292-9d38-41ab-a982-bd840b24f3ab@intel.com>
 <0aee453c-e98f-4b72-8107-31d4731abcdb@linux.intel.com>
 <BN9PR11MB5276D3372267CE9246170FA78C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <500c4582-ec05-4a9e-9b68-d2ae19aed49b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500c4582-ec05-4a9e-9b68-d2ae19aed49b@linux.intel.com>

On Tue, Jan 30, 2024 at 04:15:33PM +0800, Ethan Zhao wrote:
> Some tricky situations:
> 
> 1. The ATS invalidation request is issued from driver driver, while it is
> in handling, device is removed. this momment, the device instance still
> exists in the bus list. yes, if searching it by BDF, could get it.
> 
> 2. The ATS invalidation request is issued from iommu_bus_notifier()
> for surprise removal reason, as shown in above calltrace, device was
> already removed from bus list. if searching it by BDF, return NULL.
> 
> 3. The ATS invlidation request is issued from iommu_bus_notifier()
> for safe removal, when is in handling, device is removed or link
> is down. also as #2, device was already removed from bus list.
> if searching it by BDF. got NULL.
> ...
> 
> so, searching device by BDF, only works for the ATS invalidation
> request is from device driver.

In the good path, where the hot removal is expected and this is about
coordinating, the IOMMU driver should do an orderly shutdown of the
ATS mechanism:

 1 Write to PCI config space to disable the ATS
 2 Make the IOMMU respond to ATS requests with UR and set it to BLOCKED
 3 Issue a flush of the ATC
 4 Wait for all outstanding ATC flushes to complete

If it is a bad/surprise path where the device is already gone then:

 1 should automatically not do anything, possibly timing out
 2 must succeed
 3 should time out
 4 should "complete" in that the ATC flushes are all timed out

IMHO all you need to do is not crash/lockup while processing the ATC
timeouts. If this is a surprise path then the ATC timeout might
already happened before the iommu driver remove notifier event happens.

If the driver needs to translate from the IOMMU device table index
into a struct device it is probably best to do that inside the driver.

eg ARM maintains a rbtree in the iommu dev data. (see
arm_smmu_insert_master)

Jason

