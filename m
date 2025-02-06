Return-Path: <linux-pci+bounces-20814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A7AA2AE59
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 18:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7114A169D84
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19AB235363;
	Thu,  6 Feb 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UE/cj0dU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B501A5B93
	for <linux-pci@vger.kernel.org>; Thu,  6 Feb 2025 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861361; cv=none; b=K/flPCAKBKeJScQ2N+zO5E66WzqwuJAMQtcVBQ3ymqJU7IjxLiTZb5fUFtr9ULm5Iam94GID1pZsOlGW2Ge9poprcOancvnpq9KigxkynsvkT2N917SmzB2IMr6sDql5w1qablTSBTT7R4OBFFsMyBjCeKYW5niPNUgx5ON2ols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861361; c=relaxed/simple;
	bh=P+R/seiW4SdaugRVKN5RxHi7jOa6KORXfMaGII56onc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbQAuZZ+bHeFNjmvJuTJswFGvYp9+Mid6VL/cqSBiQbeWDhgKEgWAF+uk0ynWomB/cOBlGOCFxmlISuDd9VCKdBizEOdPjHj875rhxIMiU/mdnQNxz91XKxO6y1Z4R6X3p+fk4TBO60DW8I3oiIA8UeXU8lP60nnqmKXh/z0/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UE/cj0dU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6ef047e9bso109795485a.1
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 09:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738861359; x=1739466159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VgtQMDH8wvAi61vjGth8jKP7I7lFb2s3zjflIWQJd14=;
        b=UE/cj0dUTShBzR2IM8Cd0/Qac7R+yGVdE2S7QXUaBk01jSu7F22eeXo8scVemz4pwu
         m5+GfbOQD+ySkJhGNLi/aodJcmOjbudm2I1l0CUlUlHvu2YchY5ONl8kHNHCVjnNTdB8
         FKLZDk/UfksutX2eTtvAH7NyKp9tVWhzMdk5GvXALriev+L7BqTPi9m3a/moN6xSxTsV
         l8/5OGjEvcyNPgS/TGOXg7PSrdyEYHn4qD9d2VEqH0zryTOOvJhHDXNX3p9duJ5MgGrr
         AA+SwAczjqHoXs4gIT+qRWdgjXajxm6kggamQ9n07krGMcKxI+BQ/RQGqCxTrLKLFCvy
         3bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738861359; x=1739466159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgtQMDH8wvAi61vjGth8jKP7I7lFb2s3zjflIWQJd14=;
        b=h1sz8kj5e/aokozZwuM+kalMq3thjXo+fR9uHprK6LH5zj11PkZ1K95YtI/Gh6WBI9
         V5c1huvyLMVurwbXYIern4E9CSw/YUsBYn1m9Jyec1+6HMnHvK/zHHsWNeW+rQg1YoZU
         3MYCAl3u8CG+y8MMG5QGRToXSRqcEgVm3kznv6OdMzwyCS1aSZLSW6fOHc6bbqzFArjt
         ykZPjMsUC+/jGPrLrH1tJ4B/Y7kE38cv7LHrxl7/l4l0iwa/tlApoRvFMC9ojFmaSm9o
         2xjU6VixTXqCaGgClPlW0hFsoF7HbfD0+FeFPXX+KLwZTkGnoHohrqF+Fhtd3G6BHHTs
         uFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRJb1HgNEOYINoXeICglQYtmVc4dEgI65ZLxgB53NFLx5GHqrbfCZ2XRSHKRecv4yal6+mgm1pzBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWiys8c27gg6+OBgET29k8Dn1CmmxjstQq/bq7xSBgln6jX0mV
	BJGkdKH7VHYxWX5INdkuykKmxJP1BvjPNrXT8h4Z6uJvv3o6zoj07aMd61KNluk=
X-Gm-Gg: ASbGncu/hNtz+JPM9AiWzSKY18XnG56xUrSjJ47nxcPHjOMk9dUdjUsNqfua674a3PY
	C7prCnLgM/fgO+s4Pkkz37XRz0yXZuuvsttEtU5xPBfLZasTMZ3ulhzYnVpOKX0Hb/PH5VnortL
	MKXQ9EjHd0XGPVkvzKWZxRtsYy+o5FqC9LK/xBikoLW6JZtR3BhjBcKNaDAyhb8nXFVQ0wdOmB3
	ftkm19We08Fsg53Rjsc1p0+U3yqCOVaGcgkXyj1T/9SkrluOrZ9DJ8NLvtqRJVO/6n7aaq9SKoP
	ha0MatyPBqNYDNErqWZkZcYWJPm6i72iS1yP6BWmQovsHxrv8OeKVi3PfJFT38xaRyHv0xjLAg=
	=
X-Google-Smtp-Source: AGHT+IH4e+2/mk33Pda+5bbgWoteDOK4b0YEQKjFSfKlwtguaz1AcoSdRIebUoZTBB/swniKFKDIng==
X-Received: by 2002:a05:620a:3705:b0:7ac:b95b:7107 with SMTP id af79cd13be357-7c04024b43cmr646556485a.12.1738861358953;
        Thu, 06 Feb 2025 09:02:38 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041ded1c5sm81054085a.3.2025.02.06.09.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:02:38 -0800 (PST)
Date: Thu, 6 Feb 2025 12:02:36 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 02/16] PCI/AER: Rename AER driver's interfaces to also
 indicate CXL PCIe Port support
Message-ID: <Z6TrLKCthMY9g24W@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-3-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-3-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:38AM -0600, Terry Bowman wrote:
> The AER service driver already includes support for Restricted CXL host
> (RCH) Downstream Port Protocol Error handling. The current implementation
> is based on CXL1.1 using a Root Complex Event Collector.
> 
> Rename function interfaces and parameters where necessary to include
> virtual hierarchy (VH) mode CXL PCIe Port error handling alongside the RCH
> handling.[1] The CXL PCIe Port Protocol Error handling support will be
> added in a future patch.
> 
> Limit changes to renaming variable and function names. No functional
> changes are added.
> 
> [1] CXL 3.1 Spec, 9.12.2 CXL Virtual Hierarchy
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

