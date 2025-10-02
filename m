Return-Path: <linux-pci+bounces-37404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4BABB3670
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 11:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D15816D754
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C102FFDE8;
	Thu,  2 Oct 2025 09:11:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB702F0C55
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396263; cv=none; b=K5Wuin1gKSWDdTDPV3ohGgrS34C7LWSw3YCArEtKGCnFH1XKti5/oLlp4SQ47z+U8Iu0Q9KFL+BUS5j6dBv9hK7m51l1mMw1M0cg507JIM62mnWq2y7dztiTMQR9B8PnACr4aIS3F4XEHHTmdmmoeJwD1L2tiOyfB1XhUnxKXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396263; c=relaxed/simple;
	bh=0x4mni42h3u3+Yk8psdRxeM5zzr4vUX2feS9t68m2O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd8IMUNJ4HUW6vDo4xakvkjYfjWcg/iNSZgFViPhK5YpQr0D6MHOlfHhLn5/Q21a3QoZ2QmR1ztPFiG4pG/2yLrzvbR95d2pm4OoTrQgKk2JqU9/at+Yrdff5tyUpLC+d500JJ7nZt0Pk6bm4WSgQuTskUc5jb8xdqI+UIuesBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so1683647a12.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 02:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396260; x=1760001060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRDmlXYbuy08sNt5xF8Zckv3BDEt/TW4zDdfvpxaR3k=;
        b=MxtOcMIWhp6YtUml/ItomWOkKSCKcqM3e5fCMN2n/nAePcumCrg1lkT9A1cGBUxR5Q
         nWRiVTGMUtQ+jsbmkQZQfd0JEHMt1hk0sT9JVnk4EoF+lntSq9JfATMgq5Aln6l54pQE
         ypodJQQokeqGmtY4yzb6PU1MWpEXtpWlWAFEN4WK+M4cM6Cmn2KO+PGQznMY3Q7f5XHm
         87JggwI2Ogr3y837T2vaWkQIaOn2K93O/T9jw1bMS6V7dDvMbkvu83uXLH5kwr/ATY/Q
         mlD6rbcsHtLrvrI0g7J71gcDRI0BPsUCM72zfbeZjM/oC0s3L0l2Ak3wqq4knmU4OziG
         8lUA==
X-Forwarded-Encrypted: i=1; AJvYcCWDlVyIRB5i0Q5Cgvms8itVCtowS9WPY/7WTjXpRgfUefa1G5G3oHpxHCXmpUXxlFaJkFZut/4cX3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxAc/0bV2XkToC9ePFlUwzCpLhMx+Ef4uU9mxpfVCGM5vz34+d
	qvCMa2ViIQ3cy6u/YTVVR1WEv0MceeWCNbvCR4UWwE9l/LSe1EfOltN6
X-Gm-Gg: ASbGncvnSs8HI3nMYxFp/oM0vbs1WIrIWWA37Y4H/G2DMmN9Qu5FUuiZ7fTkIHeWO5d
	wMhbxkuwiFa7fC4yP3fRZ8kNwTkSM3mip2tnJOuKWvPuuk+Lt0rrGQXODBtwPas1EsbjLkKzNS9
	iFPlAPbzXQm34FZJHYrQ4icbKozX6B+haWaB6IugicsAfVgQsr2uM8EIxiWrVonmSWoht/dMC4+
	/L+tmHjRjfiVL5Pc8KJLgsna/PsuhqUBjqDxk/NgPzQG8YnuvdNQfj9XHTRRI4iftPXlktRQQN+
	D6aQXFtzweKD0eDCddldHI0gOWpJ5sTGHM8jyqJE4ss6qV34Ky9FIUQOOmzB1HS17Q5fbKMHcD0
	PN4uY5ae14KcaNZQIzacyf99vrphjhc0yDdRI1w==
X-Google-Smtp-Source: AGHT+IGI0lLEvsbF1QPCvI8L4Q/FaURN2Mex33lSpcN9SL3uUzSJV82rsbQoChB7SREpyehAucnnhQ==
X-Received: by 2002:a05:6402:d08:b0:61c:8efa:9c24 with SMTP id 4fb4d7f45d1cf-63678c9f53cmr6776854a12.37.1759396259611;
        Thu, 02 Oct 2025 02:10:59 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637880ffa4dsm1428844a12.29.2025.10.02.02.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:10:59 -0700 (PDT)
Date: Thu, 2 Oct 2025 02:10:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Jon Pan-Doh <pandoh@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI/AER: Check for NULL aer_info before
 ratelimiting in pci_print_aer()
Message-ID: <z5thnuj2nwzuk7wp7kentekm7zx6v6fh5f6zknerdbld665guo@6uxxl7emi3be>
References: <20250929-aer_crash_2-v1-1-68ec4f81c356@debian.org>
 <20251001213657.GA241794@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001213657.GA241794@bhelgaas>

On Wed, Oct 01, 2025 at 04:36:57PM -0500, Bjorn Helgaas wrote:
> On Mon, Sep 29, 2025 at 02:15:47AM -0700, Breno Leitao wrote:
> > Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
> > when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
> > calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
> > does not rate limit, given this is fatal.
> > 
> > This prevents a kernel crash triggered by dereferencing a NULL pointer
> > in aer_ratelimit(), ensuring safer handling of PCI devices that lack
> > AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
> > which already performs this NULL check.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: a57f2bfb4a5863 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Thanks, Breno, I applied this to pci/aer for v6.18.  I added a little
> more detail to the commit log because the path where we hit this is a
> bit obscure.  Please take a look and see if it makes sense:

Thanks! That’s exactly what I would have written if I actually knew what
I was doing. :-)

