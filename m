Return-Path: <linux-pci+bounces-24119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B39FA68D8C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 14:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF28D17BC45
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 13:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9D12566E1;
	Wed, 19 Mar 2025 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/3AuL+A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7376B224F6
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390218; cv=none; b=OWi8SPPJgJRurfrPGZenpZv4JwgP1+XkVPZkCRZyDPNOS6UignjnQU1xWWqs9U9CvWrKioN3B1p6BvqPsx0As2LhuJ0JX3jNGU4dV+qRTsVgwU8nY7rHRunYalrjvBmsO5eZagtw5h/PMfb66wEWy1L9XL8He3H1VK5IPVq0GpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390218; c=relaxed/simple;
	bh=mIhnMEW5yuowNnYq0bWTeTVMLPHGSgJ9laVnEiA4/2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XM0ldpjJ5e8rMqMgqNWbXhnBWuvUvQJDFGVK8pc080MilVgwTMJaQhIk3HoO5mmW2A9mi5ZsuD125T2nuY69gZFK7jGOZzL5LsZPSe1jN6pkqzY0tuMrU0wqkwu3X+mVXK1ndbD3GBcE8Fl6Po2rREJl384W6P72L+kESiKDfbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/3AuL+A; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so28514035e9.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742390214; x=1742995014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZFXJ7cV5lp42vCux/Cd6AXi3tX+zZrjbpR69QN/IgA=;
        b=M/3AuL+AiVAWgICHx0fgUYkO1v3QJn/Pi+/Y1zuffvOTfHNGbkjmDDfabU0+KwL80p
         lQ4H9CkO+VaWca7hqRraH5O1FfkF9+cZ/1GT0W3+7xjS0qnQJh0EEaCXmhlrG2y6Hlr1
         K7kqhDpSnlN5nZbd5FSLAyTE3GNImnGGl1UgI4zDRxiiBIv6EYic1au8jl2Y4RG8AigK
         XUHibrDGu0peBb35v0wfGSRHFDhRENMFd6od2EvdLmAgi7KPJGHEeBQHo6Cl7krzkkbf
         8Bvf2Y9k9Vjj3D9UliDLSVNvH0jc2vvDMyYC3zCGfJAnXIviO7yS+jtG6r1XJrG7/GOv
         mJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390214; x=1742995014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZFXJ7cV5lp42vCux/Cd6AXi3tX+zZrjbpR69QN/IgA=;
        b=cWWeU8LQjzLOghPSu4geWa+ChNfPUj+lM2cm9sUmalvd0YBhJtDhwcYKrvFgQBUuCV
         8nKBRGbhNFTfzlrMYAqC8pPjNetQodyhc8pZes4Hgxf+o9mwH5EnL56Pa9d8hsKmxjHX
         oqVPIDLTsOG9yWxlZYtfbc5Kxt72qq959Tldb6oxkjBPvt5MwGil7HQ85avhlAgquF/W
         IiUylKCTFOUJvaSb0RDEl/Vv4C+Fh/qHWZ2DfUFgfNrKrt+E8XMhtUJAttxGyGsnmhv9
         JjrW4zl/hTuwUGXdzy18ttaCUrHwnHAn0hMKqxEF/s3l+i/2Y8SpXA+sMujra1wWFmmt
         UIfw==
X-Forwarded-Encrypted: i=1; AJvYcCUaiXquxBw2aWKHcYoCHnhzEzks/8JdSLJaf6+pO1WdemrIvB/ndNP36et/kNxAyhX8CZQ6AspjPJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfoX8fR06/8JWBGSUeQCHNs/PKnkwPeJ+/kBLjSNChnlCoD7ZB
	oQY1OphlgcLvlIz5Q7+HHTACZXJu87EiBMAd4LCjdF/O4c75/9pzA8HBy47wylpm4l+k2xlGHR5
	ak2Cr00oygx3rlA==
X-Google-Smtp-Source: AGHT+IGQ0tlk++4uoFRIvqDYa5fnv7Q7EnYkzjyoAXFfXjg3CJAiWVBpRU+wF6+JxkvPFHSROMZ8hlh0rLPLYIo=
X-Received: from wmbay3.prod.google.com ([2002:a05:600c:1e03:b0:43c:f5f7:f76a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c23:b0:43c:f513:958a with SMTP id 5b1f17b1804b1-43d43798dd6mr20385345e9.13.1742390213917;
 Wed, 19 Mar 2025 06:16:53 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:16:52 +0000
In-Reply-To: <Z9q8xcsAYhQjIpe4@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318212940.137577-1-dakr@kernel.org> <Z9qy-UNJjazZZnQw@google.com>
 <Z9q8xcsAYhQjIpe4@cassiopeiae>
Message-ID: <Z9rDxOJ2V2bPjj5i@google.com>
Subject: Re: [PATCH 1/2] rust: pci: impl Send + Sync for pci::Device
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 19, 2025 at 01:47:01PM +0100, Danilo Krummrich wrote:
> On Wed, Mar 19, 2025 at 12:05:13PM +0000, Alice Ryhl wrote:
> > On Tue, Mar 18, 2025 at 10:29:21PM +0100, Danilo Krummrich wrote:
> > > Commit 7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
> > > changed the definition of pci::Device and discarded the implicitly
> > > derived Send and Sync traits.
> > > 
> > > This isn't required by upstream code yet, and hence did not cause any
> > > issues. However, it is relied on by upcoming drivers, hence add it back
> > > in.
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > 
> > I have a question related to this ... does the Driver trait need to
> > require T: Send?
> 
> The driver trait does not have a generic, it doesn't need one. But I think I
> still get what you're asking.

Right I mean, should it be:

trait Driver: Send + Sync { 
    ...
}

> The driver trait never owns a shared reference of the device, it only ever gives
> out a reference that the driver core guarantees to be valid.
> 
> > The change itself LGTM, so:
> > 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > 
> > Alice

