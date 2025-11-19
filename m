Return-Path: <linux-pci+bounces-41674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D94C7C70DA1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 20:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E5584E1CA9
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 19:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03BD36C0BB;
	Wed, 19 Nov 2025 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jBqa/z5s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165AE28469C
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581004; cv=none; b=cWtN8IfoUQDJwJtz0oq9FBXYGNsRBS/W8kRLtBQWZPRqkZzo3ObVwdWpCjLRLSKjB/RTKqMgAkwCIV38zSMjkYWkG0gsfZ8vsXW/1XXcDgd4+PB4o2APRthOgCNdSV0LYoExCbDyAIn+6W+JoS3zfHix8NVsCnmsyKHcMK51hrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581004; c=relaxed/simple;
	bh=sztelLlBrONBmM282viGyh6kz65i94yYxCWrYWozdqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E03fG0Ub8CKCd22rSRqwJHPv7r8Fby/hn3E/99/z8ti723u55hsv66n/v0wjdBbdAs43CYcY1bMekAC6uaRtAgrRWX8RMcObMsjS3N2CfRcP6TQ1nIrP2iquzEw6jnqvN+W6YaRm9nW9FO8WDqt2uznY+FovO/dJpb5dXCk9Mr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jBqa/z5s; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee44df7750so812361cf.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 11:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763580999; x=1764185799; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sztelLlBrONBmM282viGyh6kz65i94yYxCWrYWozdqM=;
        b=jBqa/z5s9CGp5RICxeKSJrdO5l3megJVr81FnjM4RHwVEKCUb4xEQ8NaoiOBOhnzcZ
         bMxWoyoMgmSdI5ISZhu0sMMq/bhX6xdwOzl9EI+joXijVlgSlY/nZpUwpWnn/B0Ui1n3
         W1cP0IRwL+kjK02u1dFunMpg85hYN05Dj9YAOL9GP3DccFBflwbNZyVBV7hJoxkN969L
         WGavQPhrCgEO9MrysbD9xVHbtHHSiRc7gCv2T2zrxkr+wtl5uM6DDuTpWX8LCAjj2xlp
         FMsXVMjmkR4zOh3um/QXeOnX47MD5GU5Nvj7Dyi23HwJxfdQIj3H8yE3t+KQbYckONLZ
         +Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763580999; x=1764185799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sztelLlBrONBmM282viGyh6kz65i94yYxCWrYWozdqM=;
        b=AKF5mH/6HK54KY43hUkPRcH71mRMG0nzDBVWiZLEjNQJayycj0+8yvKy7kxuH5vRSX
         njcfjzUKbKPZPCrAUc4ru+blG0eK1bdmSU6ND98ZXNuakrwIgo2RrxHQ8NJPpgUvf9LN
         S3QcHp22wWrg5Pzc2QJijFWrhZrf+ZhmUAcZgFcAfKbpilghCdi513QIvN3jMrPETrIA
         dfas+sstl/41A/rxolTZFttpR57Dj+gpvYsoAIBl7C6MyHmKVDklnYGvu3n+jEZtTNBJ
         3flVgzu8B46fs/QU2wAzfF0Xv2pCwGof9ycCMxTM0KeHHhq+CiiIutU2bs2bPAWSZfFj
         6h2g==
X-Forwarded-Encrypted: i=1; AJvYcCXtbTHCDgOVmSoFqE45QFlb+UVF0rK+2vNJIivlGOUnXpsU4VPb+tcrhMafbiv+nF78/9q9yUqFY64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+piYuCTPhkIpF84AxRPl5QPbclrjwhAm+ch6QIpWj7UxAYIX
	yh9LKIl1hnndU4kNT2LV20cShwONyxyQH7DHSbqk6w1lOLTTO35VF7rUtQOqmlTkuEE=
X-Gm-Gg: ASbGncvzc7wbcS5RQKiDhOkresHRJ0lfp9pbhYVx7VPCVT79e682Ikc0ie9vtrZIwHj
	oZmQ3sYpUwyJbjDQAN846b5LoidkCbebd6VVouAt/bczQ9hol2O1AWeuqgk69G/sk3ge030chk0
	k6agfsIA29xTrRAYMB2zHNFVwvBRElKUj/s/bql5R83OnSTNAuPg++YZGyrn1TVgwlj24pGE8t7
	/fl39HoHzX8QHRZsQQYrbdHAozrG7lx2doB6ssR3uZABknc+aurAQkmFsYtAM+4s3lu+zzQyBdc
	AWrVWopSOIdmOiXsH/1JoGG1lp/iDqHMwjU71c9834YjRB7hLpyzMAMnWxgZd94+KsKCsjTdyQU
	2ny8GceE4a5OXIUgidShu/MnPcjHODh7Z+DtLJh5sKjPxOsBlLfPnNUxMGXGHqwPi8NDlgmpHyX
	0dhBfJutbE4/2fF/OjivrrsiylwrzinxzesIO0y5Dw857hacdHszxf5+M5
X-Google-Smtp-Source: AGHT+IEogkhlTHFcyAE9/u1UuBQV+X3tukog/nHIoHavB/ndnYOWZGPWrkYoYNh/EOln2cA+Kp4KoA==
X-Received: by 2002:a05:622a:310:b0:4ee:1d84:3068 with SMTP id d75a77b69052e-4ee4971a985mr8236121cf.76.1763580999342;
        Wed, 19 Nov 2025 11:36:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48d64503sm3117901cf.13.2025.11.19.11.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:36:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLnyo-00000000bYz-0lQx;
	Wed, 19 Nov 2025 15:36:38 -0400
Date: Wed, 19 Nov 2025 15:36:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, Alex Mastro <amastro@fb.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [Linaro-mm-sig] [PATCH v8 06/11] dma-buf: provide phys_vec to
 scatter-gather mapping routine
Message-ID: <20251119193638.GQ17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <8a11b605-6ac7-48ac-8f27-22df7072e4ad@amd.com>
 <20251119134245.GD18335@unreal>
 <6714dc49-6b5c-4d58-9a43-95bb95873a97@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6714dc49-6b5c-4d58-9a43-95bb95873a97@amd.com>

On Wed, Nov 19, 2025 at 03:11:01PM +0100, Christian König wrote:

> I miss interpreted the call to pci_p2pdma_map_type() here in that
> now the DMA-buf code decides if transactions go over the root
> complex or not.

Oh, that's not it at all. I think you get it, but just to be really
clear:

This code is taking a physical address from the exporter and
determining how it MUST route inside the fabric. There is only one
single choice with no optionality.

The exporter already decided if it will go over the host bridge by
providing an address that must use a host bridge path.

> But the exporter can call pci_p2pdma_map_type() even before calling
> this function, so that looks fine to me.

Yes, the exporter needs to decide where the data is placed before it
tries to map it into the SGT.

Jason

