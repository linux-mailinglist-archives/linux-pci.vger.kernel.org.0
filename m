Return-Path: <linux-pci+bounces-33381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218A1B1A826
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 18:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9423D3A3432
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D626C3A4;
	Mon,  4 Aug 2025 16:47:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA7284B3C;
	Mon,  4 Aug 2025 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326048; cv=none; b=me2O/wCc3fDuCvVwBD6wEfm+FtRKzOPITqTaFPZHPnwTWxvDUMAa5EQ9Eu+d0aImpyYtIg2jzLC4xZFmCCtlltY0L/afBs6AjYpJGimelO9UuZrqLZRdCQBz9MB/iikmVYpsY1YCXszd6EvOoa+j/rAU5l3dnsavV3AMlN8Ozhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326048; c=relaxed/simple;
	bh=7Q7JSVkgsm4Y6V36SG2FJd6hUepIqcWTF57dZNOHpL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASRuEWhzZd4h0QWn8Q/hDDwYuabK9+PSce8zIpPvXUunRZd70J/UMqOvOjMhP2M79ymRnMysUGshz2/acbGSIMh6W5Ad+CDRz+dtWguwR+ejONWjqZJ6nm/Uq+iMDPZUI7MEPvewnuEpaGOsPFMf/3QLTV3CjWo1fhO7bZFB0OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6156a162537so7160505a12.2;
        Mon, 04 Aug 2025 09:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754326045; x=1754930845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Mxo2ut3zRoMEZ0uIbzFNClsKHal7Spr1Oet4n2Jkkg=;
        b=EyPxcGX/qrCMfBS0y00EEKB1RGt8uoVltSETbvgMNYHdfKOufQpCITW/SZkLJUV01o
         3P2C/Q3n0sS//dyIErRYskVLIh5vwefx3404XEEzzjW4FQ8VhtyHN9nbs+17Kyuvpoap
         14zIWvdYXH2j/i3MnHMi6MG1OTO2WaCN181m8llVvh9KqRa3kftAN/N4HmTiV3t+ihrR
         wEZpQ8oZy22+RCzqwt1bSEjQRHFy/Ml026opVOSDee4Ncvi18j4Lbx0nZhHS5ZyKgP6V
         7wbsUrNZLs/jeu18ONoi8xG0uPkVogGf393MKfMXAdiDn5AGEwCnn7FiT12g+SDYzon2
         ksOw==
X-Forwarded-Encrypted: i=1; AJvYcCUMbyUJ8ahwe1R6pVEjOLwHdNN4PN7+csi9Rs24gxGr+m60PttfAZQKLW3F/oD91g3fvqeEodhlYhuPQTE=@vger.kernel.org, AJvYcCUh72NoLz71lBdembsliWedeNKIvG3nSMfOIOEZXuA9cGrti/dnp9re0DOoiJ5zrEYShF8tJ1B4qmed@vger.kernel.org
X-Gm-Message-State: AOJu0YxNvatFi3d84VCbxUdIAzyDic4/Q7lgEVce3MNwr/iSpE62Xzq8
	PQ+Qhizq1rT5ixafTGYiYMjX++pb47hs2Wa0/YTRsLitPh+rmAMcYDsr
X-Gm-Gg: ASbGncvzP6gA5pNab5tszHP57mU71o8jZtb4jgBbUjCLBCWIUAD7AIUI61o6c5Lx93O
	Wj5SAMDA1Xjx4Lu3VEiFNeQcDYlHhflm1mSGYkmQK0SPZlGSnlgyTdy1pZS9usQt6V+9hngqx32
	5G9yQDGb4noto6cKEyPmFgEmJMKlTZL9db3upa78bfSMTI1Ps0N75qoiU9PZ88yFko4zGtWUoxF
	EZxkVQ0dQnhtPD9CVbaolWV3hmWzeXQZwCsE3eDfPzaZzi0bBey9GoZ1t340yA+MJHlZgUpbSlY
	uYDkMjeh7kTIUnHE2T/jW/NVR8PjItEJyqzCItvNxSArnWYbzBCoV2FSCYe8mmcOC9CjfQ3cK+F
	F991L7R093thUbrqqmiHM+qka
X-Google-Smtp-Source: AGHT+IE7J7XFqe2CWLwCuaGh0pIpjtaB3ZsoUi1fPUXC1a9sKKnxkU+tAZa8TjMkc7Xp0J+XSrRIDA==
X-Received: by 2002:a17:907:948c:b0:ae6:abe9:4daa with SMTP id a640c23a62f3a-af940079146mr1138489066b.27.1754326044549;
        Mon, 04 Aug 2025 09:47:24 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0753f9sm753604866b.20.2025.08.04.09.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 09:47:24 -0700 (PDT)
Date: Mon, 4 Aug 2025 09:47:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Pan-Doh <pandoh@google.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] PCI/AER: Check for NULL aer_info before ratelimiting in
 pci_print_aer()
Message-ID: <cv67hkaimtzsok7ryrzup3ql7unsizw2vix5nanx252pqblifv@42d6eibemsvx>
References: <20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org>
 <9cd9f4cf-72ab-40f1-9ead-3e6807b4d474@linux.intel.com>
 <3kpkazpe4j4pws7rean5kelwmpfp5ij62psvdzvimcr37do47a@y2pvypskynno>
 <48e24c23-67d4-4d09-a5f5-2a458a47e2e2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48e24c23-67d4-4d09-a5f5-2a458a47e2e2@linux.intel.com>

Hello Sathyanarayanan

On Mon, Aug 04, 2025 at 09:11:27AM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> On 8/4/25 8:35 AM, Breno Leitao wrote:
> > Hello Sathyanarayanan,
> > 
> > On Mon, Aug 04, 2025 at 06:50:30AM -0700, Sathyanarayanan Kuppuswamy wrote:
> > > On 8/4/25 2:17 AM, Breno Leitao wrote:
> > > > Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
> > > > when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
> > > > calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
> > > > does not rate limit, given this is fatal.
> > > Why not add it to pci_print_aer() ?
> > > 
> > > > This prevents a kernel crash triggered by dereferencing a NULL pointer
> > > > in aer_ratelimit(), ensuring safer handling of PCI devices that lack
> > > > AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
> > > > which already performs this NULL check.
> > > Is this happening during the kernel boot ? What is the frequency and steps
> > > to reproduce? I am curious about why pci_print_aer() is called for a PCI device
> > > without aer_info. Not aer_info means, that particular device is already released
> > > or in the process of release (pci_release_dev()). Is this triggered by using a stale
> > > pci_dev pointer?
> > I've reported some of these investigations in here:
> > 
> > https://lore.kernel.org/all/buduna6darbvwfg3aogl5kimyxkggu3n4romnmq6sozut6axeu@clnx7sfsy457/
> 
> It has some details. But you did not mention details like your environment, steps to
> reproduce and how often you see it. I just want to understand in what scenario
> pci_print_aer() is triggered, when releasing the device. I am wondering whether we
> are missing proper locking some where.

Oh, unfortunately I don't have these details.

I have a bunch of machine in "prod" running 6.16, and they crash from
time to time, and then I have the crashdumps.

I can get anything that crashdump provices, but, I don't have
a reproducer or the exacty steps that are triggering it.

If I can get this information from a crashdump, I am more than happy to
investigate. Can we get these information from crashdump?

Thanks,
--breno

