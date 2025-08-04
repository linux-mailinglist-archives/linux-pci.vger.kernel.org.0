Return-Path: <linux-pci+bounces-33378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FE9B1A627
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 17:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DAC181BFE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 15:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1003821B8F2;
	Mon,  4 Aug 2025 15:35:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9EE367;
	Mon,  4 Aug 2025 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321725; cv=none; b=oWYE8+7NxThSK3EHD1cedIBpYq0RiEBNGom8Zy107GSBuNofB8PpnOrXNfSbPH94+ojYbL/3ZYpu40+ll31W3D1z9THQEUTTmTv9DGZiwPP3FUK7HQfv/BqMai4VCN2XJ/Ek618EEBnFdY6ugE4XXUzGgTtUfnyfKljVy44sQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321725; c=relaxed/simple;
	bh=8a9JKCh4Zk4GxN3BImPizfRk6PketL8ImmZ+Wkp6glM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhSYu6/w1B+SiYhvR/JRK5YbbJ7eOYmoTKTgg0rs3zLTxIyw63X+vkWCaEuj/t+Tb52mYkPf4HEF5gMhnUeg3uG499j4ANrsOK8Ap6ONctFUWFgaxflurcNH/g4CkdUOXwhqNvf2/FfOjHV/I+9YsMY5blWIGzfQSGlEJAsYTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af96d097df5so178892466b.3;
        Mon, 04 Aug 2025 08:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321722; x=1754926522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkvknQsIRTLNlHjYffIfMN8B8TJuS69lKIHDLLVrOcs=;
        b=cnGakPHGxfHAuJeTkDB7YyKoyPd3/R8IzugV8FN3ZxfTbDxTbbagpFlPTFyFw1wUGP
         +wfwmuK5dofcBjhmGgHzszD2sUI+EfqQgrkTmcwT7WR6nWcU+eRjqxEvAr7iIJp1VQKZ
         3klW+Oiqzw4a2ElyNPetUZ04LGAKzKOKn1yApt278fZfFoQVm7M2XKi0AK9IvLBFxeaK
         zPowIFbnGR2XOOvOXwHWvaUhDvql1flXkAFF7U6udZj2Ji0jlaCzv8qkfzhFzUS2RCcb
         ZLBu4LSqWz7zGx2ofhAS47pDT9v3hB24j53T9xW0I4QqaxP4npYo3r8zlYBYuIIjLLaH
         vKEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxpLhgvXef75SPjdaH6efeCTMTOX+CBbAFqQcJLmMf3fF6bqI7PzHQYrDnFF/4x4N0arZEUcqJllykQHs=@vger.kernel.org, AJvYcCVtdLBzb+4HsGCDwhPHxDF2Fi4zUCXFo34F4wzDj5s0KyUsGLNq5ZD8a8SMXUOni16x09a3tkh0m089@vger.kernel.org
X-Gm-Message-State: AOJu0YxsMQGG6vWjaQEZiAuiBQ9CYYsdlbqd1rNU4G8OFIcESKq3Tc3Z
	txACdJVqCoW8TQ2XMksDtfn0E6eiiOM3MWaQy3Oty91AM7GmBSTy3TOU
X-Gm-Gg: ASbGncv7ysR8RgbUiwZ4nS2Pqgy6SI6y/QxdAuYi1D9LQ9ppuFnVPEybThkAwV3iZBP
	fx4BA6ikDn/V572QqHyXTWHprhX0gn6dYfVa4xxsDJoga756fXWGyEaB+Y4So0dK4daIt18l4o+
	A3E9ZSPxp1+xdZF+fm5HVKOjfu+g5PzPTXlKI2LkoMdx4wFsva2gWP8CLxk4GGl1Q23YTF46xlE
	CaPsrFHMEtTtq0mY+rFcGEwvB4MH53GSps0aO1KIqJwtFzpIPZcT7Lv/s678NM7TPPQ3AgBkoec
	1F9GTjgdXKVApoTHT2SQGUlZh55M4LZQeXt7+D8MhTegw44n7x2eMEkM5jd5PJFEdB2taZ15D8G
	U68i54xhSpvg+JKEwTboZtNE=
X-Google-Smtp-Source: AGHT+IGY6yKz+FByCTSLRPrfqErAuLhPrr9SDzfJMrRAtdl7cm5w7Ayr/q2YVc1pbEeuWrcQqViPkA==
X-Received: by 2002:a17:907:c25:b0:ae3:4f80:ac4c with SMTP id a640c23a62f3a-af93ffc139emr1027516966b.12.1754321722244;
        Mon, 04 Aug 2025 08:35:22 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2436a4sm753208266b.134.2025.08.04.08.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:35:21 -0700 (PDT)
Date: Mon, 4 Aug 2025 08:35:19 -0700
From: Breno Leitao <leitao@debian.org>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Pan-Doh <pandoh@google.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] PCI/AER: Check for NULL aer_info before ratelimiting in
 pci_print_aer()
Message-ID: <3kpkazpe4j4pws7rean5kelwmpfp5ij62psvdzvimcr37do47a@y2pvypskynno>
References: <20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org>
 <9cd9f4cf-72ab-40f1-9ead-3e6807b4d474@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd9f4cf-72ab-40f1-9ead-3e6807b4d474@linux.intel.com>

Hello Sathyanarayanan,

On Mon, Aug 04, 2025 at 06:50:30AM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> On 8/4/25 2:17 AM, Breno Leitao wrote:
> > Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
> > when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
> > calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
> > does not rate limit, given this is fatal.
> 
> Why not add it to pci_print_aer() ?
> 
> > 
> > This prevents a kernel crash triggered by dereferencing a NULL pointer
> > in aer_ratelimit(), ensuring safer handling of PCI devices that lack
> > AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
> > which already performs this NULL check.
> 
> Is this happening during the kernel boot ? What is the frequency and steps
> to reproduce? I am curious about why pci_print_aer() is called for a PCI device
> without aer_info. Not aer_info means, that particular device is already released
> or in the process of release (pci_release_dev()). Is this triggered by using a stale
> pci_dev pointer?

I've reported some of these investigations in here:

https://lore.kernel.org/all/buduna6darbvwfg3aogl5kimyxkggu3n4romnmq6sozut6axeu@clnx7sfsy457/

