Return-Path: <linux-pci+bounces-20864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12166A2BCD0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 08:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F78188B088
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 07:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71301A76DA;
	Fri,  7 Feb 2025 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YZ87KQj/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF4239082
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738914347; cv=none; b=gzjeU4vYj+Y7FZu3Vo4ylH9wm2DRWRPYsYqnkMiZwR7MD4oWqre7N683QFySalGiusG5rKcKSTuy6LFIrdWXF6pDfU4eu7zRQ8+Oc8BU4wfuU5qHTy0cu2UKM1w/EjIqMNUgn1zxQz33owlutFLPZLSeHGYEVvQXWwOIGZUFfCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738914347; c=relaxed/simple;
	bh=ypUvBmqeSA5zmnvQEnD0qriNJ7GpCmT00dwkj1UgV7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gelwM7acEiize7EP8Ua8EgB2zGK5Tqq3RdrF8b2K7TTM/fJq70tuAvKDh+FewioLMkENe6Hflo0nEtvc+ljYPaxN+P3nWEK6dBozhxz/e7esk5vSPvNtYifI3jibJ3fdQPQzeyQQxkawpt3g3qSejG6vz7w8NJQFoyjO5bIiU2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YZ87KQj/; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6ed9ed5b9so308373085a.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 23:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738914344; x=1739519144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITCo0zOF3w7fSYlcXsHoFxkXnBWTFovbLH+EqkDvJfQ=;
        b=YZ87KQj/2Wz2//tCO4yiUVNBh+MZLwMQRP01c8zikvLiaW+Fw59EXFXKxN3HQHrqAA
         LrSekBOj2fWJ9ol/XdsvnNfXqFjF+RMW2Lf9aCLNXqiKtoj0QurHuWlqVdvxV9IegdNl
         E09ZdtIIP3MW568i+MAa5fwW3OJz3Nj+qm8G7R2eEe2isPcNRZSI3bzEBzvuPEpacSIu
         yBpU0DZFoprMkLVKfZ6M7/UWKfUG7zZ897WbSDztsNYgK9b3FWI6s/hj5hGvCcKhfpyU
         sYSP/1N5HreUWfwNAgWN5wtLnFOaEgL6OKafYex1Jc3PKuKFy+YbL+lxH7GHPpDYwIdb
         N/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738914344; x=1739519144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITCo0zOF3w7fSYlcXsHoFxkXnBWTFovbLH+EqkDvJfQ=;
        b=wei8XP0Zf+6X4dXce5kGq1xjr7egDdoog9IiH6XQ4rWTORLxU4CpnOeLFUko3f6Sew
         IU9EROwmcadV5eIYDRg6TPmT0F5Zm7Km425H+7usxhJn3H2IQGLshAyItSM9+Dk5ebSD
         LyMmJyEC4xu1ERGrKUS35fs5R8apez5h5cmTjylNSNPO3Mlna6GLeAXE2U4Wl7mY/Gc4
         OWRSfFr+68FBKyxAQHndRwkaOPs2zQDuoeYON62cYPdWe+9barkKspkpexxUM3fEKOtU
         LDVMqZa5d4ay4X4P3erlBv8H9VeK4Kmpr5GtSO3J7qXuPiEQL9vNEtlz+Dn+1q0qyMe9
         ld6g==
X-Forwarded-Encrypted: i=1; AJvYcCV+oL9IFWutLPt3AKTyHYRJYYMULBYqohhTT3qLOdReDI16avPGnKKNNXO3XACi066r7hWgNHnWFhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpSFld5xinMuLwWoBdrXVWz4/RwyqK1uWojjgXfPrSRhYNLiG3
	EudE7d6+F6whYG5d4g2siMuyZYtp868QNslIkjOYQCdilSLNBOegsht+cQydiWg=
X-Gm-Gg: ASbGnctNOvgUu0Vp26vlQTkh3wXCCsvorKLdgEYSOG/hZQvjrlZegbXtUJu5YisGpep
	YgOy+jKXX/cW7UW5tmNpAM1gOYoHaiJ/1Z8ca4/Xj+fQz50B400+jLs2s/tRhOvRkYD74yQNMcT
	xMo35x8lOzWtSp8ymlToEBBYQelq7ImG7a9Tl+/4QH3do4CbF4hwwj6Hrg8PZFGbgZElJZXWWhO
	z1dPLKAAczh5HMiVeZgc9EVP7v3nKrK7oBFidJsgre0Hq24gJ0SVe5KW9OKE3yTE4biBOJUyYww
	X9BRxKcxWxKfM5sYGjTHW2wUx09NHMHnV3kGoTLa4Nbz0GkMlo6X9BuU72VtBmOkWLuQiAp6iQ=
	=
X-Google-Smtp-Source: AGHT+IEEbQrgliT3+ZX90iWNqouIwlVzy6+xrcLd8rmzxealOsnm5pyXJqkj1L0uucgsijhy4P9hAA==
X-Received: by 2002:a05:620a:390a:b0:7be:3d02:b5d3 with SMTP id af79cd13be357-7c047ba6bbamr305582885a.1.1738914344599;
        Thu, 06 Feb 2025 23:45:44 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e11bd3sm157511285a.51.2025.02.06.23.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:45:43 -0800 (PST)
Date: Fri, 7 Feb 2025 02:45:41 -0500
From: Gregory Price <gourry@gourry.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
	lukas@wunner.de, ming.li@zohomail.com,
	PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com
Subject: Re: [PATCH v5 12/16] cxl/pci: Change find_cxl_port() to non-static
Message-ID: <Z6W6JcRYjSOglSit@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-13-terry.bowman@amd.com>
 <6786e3fc8432f_186d9b29414@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6786e3fc8432f_186d9b29414@iweiny-mobl.notmuch>

On Tue, Jan 14, 2025 at 04:23:56PM -0600, Ira Weiny wrote:
> Terry Bowman wrote:
> > CXL PCIe Port Protocol Error support will be added in the future. This
> > requires searching for a CXL PCIe Port device in the CXL topology as
> > provided by find_cxl_port(). But, find_cxl_port() is defined static
> > and as a result is not callable outside of this source file.
> > 
> > Update the find_cxl_port() declaration to be non-static.
> > 
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Generally I think Dan prefers this type of patch to be squashed with the
> patch which requires the change.  But I'm ok with the smaller patches...
> 
> :-D
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 

I've read elsewhere that changelog entries should avoid telling
the future - and simply state what the patch is doing.

I.e.: "do the thing" as opposed to "In the future... so do the thing"

The existence of the patch implies there is a user for it.

anyway

Reviewed-by: Gregory Price <gourry@gourry.net>

