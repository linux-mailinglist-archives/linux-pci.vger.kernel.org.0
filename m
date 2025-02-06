Return-Path: <linux-pci+bounces-20813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49A7A2AE56
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 18:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC423188C049
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 17:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5611A5BB1;
	Thu,  6 Feb 2025 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NkIXopTr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909B23719C
	for <linux-pci@vger.kernel.org>; Thu,  6 Feb 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861292; cv=none; b=OFkZ9WXvEtl6ISSXEZG4slnKFVvfzZSnzNRkCxfWaYhqUDzr26VeyMv2HVVmBQAXRtIBJMWEF0XCJ67u9kTlDbyTfnTVtW1e4JtSx7OtXcLHeplq/wBbjFs4wAk3a4HSeaO/MibYW3oaOl7obS6vcOPxgwahHDN5k8yeZTRtTq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861292; c=relaxed/simple;
	bh=mUQxeAoVhGLDKfZCjmQ+zwGLwy+EoSUmrYxPfxXIL6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uh6abiHygKwPLKjyTOC69HGFfZhPLHurSYao5EKE1xi0A3ICx3wUHKw2axPfCzlIzUKTT+eGWqhUlsmnLF9v/ff0woOV+61yZTPFb3LmrmnZaJFMU+lP4tG6SSrnZKWe6/jK3yC9ptPRTx0vJ8br54YKG6HWc5KDqOGmiu6crig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NkIXopTr; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6c3629816so56745885a.1
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 09:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738861289; x=1739466089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgBoTjTd0P6BFI3Nbzw9+84X02WOLlHkP1rNoeDXlds=;
        b=NkIXopTrIiKEVYjUtldwS67oh1iABkZl5vv5sXrd8hUM80sF+WxAd+LcL45rhx1b9T
         B+fTolK+Ilaq2g7yt587b9WNhMKblPdZOXH2GXkoIZFB6wBMLtSv9YsCoW7LW5pqS+Lt
         m9FIyulpjayclUUPAyJeq9PeWVFqkkxoqH+m+RivG+rYO4MtG7EGjXHg3QIjTCmPg8+2
         WZP581FWEMqClswqJxoZ3H5QNLW6nSq24j3CmgSYrNmRJC6Sv9gjqP/dkHO5olHKAFeL
         Q/R2yCkhvDjlaHar8mgiLchHp5xRCBoMxL5YlxOP4elQ2kBuOXXome7cK6gL/gNbaz+O
         RGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738861289; x=1739466089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgBoTjTd0P6BFI3Nbzw9+84X02WOLlHkP1rNoeDXlds=;
        b=V5HKOi5jAL/KC79xMhS+n6IVHQuH52zTIyC6Janz2nBEvbnN/lE7Gsd9YTFa892xoV
         y7yS6DyCcP6EWR+bSvlE1iKwm15/4hLyO7ILuvZOOGKhM36YagTgVmZIF6XjYKv4vu97
         bh/spVdlUP0tKUuORrbxHB6a5HjXl0ALZKfGgLQoibVyZHrH3dO+Bqq2+kBjMfEc5yP5
         M2QECDQ+p4/M1sCaaSpyDABi3yS3k/mUy2ea469FeXziF8Uqe7pKRW6XmZmyjAQrm9cy
         x9MVMRa5A4aRXQnJz+UOHiAAxJ7kn5kJGwzQbBPJlw4mQRVGFGc3qE1rSTVqWsipGjk0
         NKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq4gKu/NVEHRIf7e0Y5P23LezQQSuXSZt5EStqgKLLmkDBkIPrdbvSkOTq/vEj1SQEun8+mSBHxAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+7CZscLeT4hX5zGTB6h8mMslUtVtVrqmOvvR3wI6Q6mjjwQFs
	txqy5DNsHKwK1ftHwrA6+wVqg6Wgp857aprWgFXdNF7Nmw1Pm6/gHdTRn35pJY4=
X-Gm-Gg: ASbGnct2d493Flns3hrMjKTWct5xClM3xjVp3j3Vb1QjDWXKAN9zh0izadyHEI7Njtd
	40VPUu+vq2/C/nNa6mhpDDwzjYaAYYnqUAvDsMrKEYf/P63rVmso7WYH5yAv1vbaBfb7wnx66gw
	k8BsvzNvDUlYhSyEySLzxDsj1L9psambHqakrq+QLtdUTj/7H0GV2SymwbJVs6vpW7JBkYgz3Vq
	j3qfwQZn/bmSsQn9sJ5n4xnDgfQ9DVrDBeHlEoy6LI0Rl5VNcKYNt66l2HFJEihgFQdUwnXEiUW
	lC0oAayRSAJgAkgEAkkmw+D9WUn5+mgo9Fe+a1OXELd8hIPa8fiWF7PC3X1s9qPFxB3Z5mtg5Q=
	=
X-Google-Smtp-Source: AGHT+IEz2w/jzoGAbYYUG4jWVTjuyIsaInPSObipS3QKdXNC4LTgYymhViMzJNqRP4gdORV7RtRXSg==
X-Received: by 2002:a05:620a:2602:b0:7b6:d1f6:3df with SMTP id af79cd13be357-7c039fcf500mr1192368485a.21.1738861289178;
        Thu, 06 Feb 2025 09:01:29 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9f4desm79480285a.81.2025.02.06.09.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:01:28 -0800 (PST)
Date: Thu, 6 Feb 2025 12:01:26 -0500
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
Subject: Re: [PATCH v5 01/16] PCI/AER: Introduce 'struct cxl_err_handlers'
 and add to 'struct pci_driver'
Message-ID: <Z6Tq5mWoxiD3LyQ3@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-2-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-2-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:37AM -0600, Terry Bowman wrote:
> CXL.io provides protocol error handling on top of PCIe Protocol Error
> handling. But, CXL.io and PCIe have different handling requirements
> for uncorrectable errors (UCE).
> 
> The PCIe AER service driver may attempt recovering PCIe devices with
> UCE while recovery is not used for CXL.io. Recovery is not used in the
> CXL.io case because of potential corruption on what can be system memory.
> 
> Create pci_driver::cxl_err_handlers structure similar to
> pci_driver::error_handler. Create handlers for correctable and
> uncorrectable CXL.io error handling.
> 
> The CXL error handlers will be used in future patches adding CXL PCIe
> Port Protocol Error handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

