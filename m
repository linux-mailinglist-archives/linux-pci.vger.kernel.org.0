Return-Path: <linux-pci+bounces-35854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0028DB5204E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 20:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C5E5E260C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E147F2C2361;
	Wed, 10 Sep 2025 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kg1V77eU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9DF2C2347
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757529317; cv=none; b=pdofB6FtQgmmg0LBK9sb0Gfj4YSZwmZTixyzEyFkTKR6a4zM7oA5g/XBUI2/oq9qwDwAw1zffegCL38PcPsby76uG5UfVxYFShQjHLTjVyt5JvC7gNoGgEJNo7cg3EKwKyYi3nklR0+E1aQO26uanpF/uWuVkMNl4Q7i8M+L2BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757529317; c=relaxed/simple;
	bh=5lFys8BTPsGWhrt0SoMF130W3SY2Xb+sxr9D2suSUyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmzsUraNZ+mAMgY4RRWSBPblmqf8KTMNhTA8jFPsS0/Rbz10Ns4NIVwGnGwRHO8Td9mAR59wLp7Vm39ztNuE/7azj6G7VNn1JIKuJcad9e7qHmDd8UIrwYqFDKDwhh9AfiCgHNyfERjcndqlkyAQeYaJaZe6QVwF8K8G9QhbOEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kg1V77eU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772843b6057so5951768b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757529313; x=1758134113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtDjIHDTo3C1gWUX1+oDXMnJAa5/njN7fZggjarDkBw=;
        b=kg1V77eUf3SglXa4GCnEZsMPWXlf/ZxlggfSMwZms+pwhg4hxSeLb8sLPd24tU3iE9
         WicklG67Mo9PlxzU4USgoXTYzlGPWhhmSpR+uBoQMoN9TvMyqS23sdldsGVOMcjN6UZs
         qvEK7YnlAC80H/KqCUt8SUKZbmjH/uKb9+F8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757529313; x=1758134113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtDjIHDTo3C1gWUX1+oDXMnJAa5/njN7fZggjarDkBw=;
        b=HR8MVYcfGHjk6t3/l19wAGYCMRdU/q/uqQBGh05oFm7gfzNPQH2B48Xou2AzE1hLa9
         QMf4QUHgcBpdgvYu3hkctZbpptA2yQmJnLlURAiDKwcRj+rHufCPBhKTdCr2kB8qlrtt
         64ecZj5bT9WqWdsCLGAr+S/Urob+/6gjDfbLHxLX/saPpgfzs306q+CxLBcZQ3XoWs70
         dXuCfvenXypCrYyEfZe7BzylAHI0vAiXo3OkuzfrBJ6hmSBljFmV7b8TXgd42rvLm8u9
         Sv+CiM0IaxVE3lwrwS7xHK7LEnCmC+0xxcQD5/OufU7EGFfqFXorw4jUW1dV0jra6DLp
         Oexg==
X-Forwarded-Encrypted: i=1; AJvYcCXch7Xt/9DKq3eFQ02fwT97ZXRw5UrHKjwEgFuOpKXucqd8mHTE0OT258zlQExNXRfEyQCp7Z8AByI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO09hUw/nsV02Fybi3eEa12MOeooXXnN0sBhkFlAi+CVw2ju0D
	0M5t+/C1K1+8vvxRp2o9QKDvRxYe/ln6BbfJYiLAYuqJY73k+lYnpjRl1sVKQ9iJKg==
X-Gm-Gg: ASbGncuzWTzI4pV309h3rrYWVxffFfbCRlTRcOZNQaxB3r6DJf0jIHAhYFNa8dZD1gD
	1h/N3gEGvrCGuHYWUez7WhMQOcJPPO8MhzBx1Y5KJumVqeLkYdQn9RDIqrZbJiBpb0O8mS2kOgu
	hmNZcoyzpnZR+RxgmWHpMMo4mPsJraYZq8c2I80jQmyxff/R3noXtGxFs76K9Y34LBQE7pTbE9v
	Y5KsJruOYJV3OKyxyTND6TF2xxwsH/cEkNnPsI171w0W+4nu8GIno87ZnNXzw/8ZZnrfq7Zsh4W
	xCmDIhsQ2YSuycAIWlB6Ly8Qfk7v51OxpiTdrv8ivcPVBrKrgcSOXw5So+pT8Phn8E2sB/s4UIs
	tmKjG+bX5z3b1JV+81njQYxvdjFzwY7NkXIeIB4cT2itifQE6unoFDDDtRTq3N4QsK9zdxKc=
X-Google-Smtp-Source: AGHT+IEv3VB5QczmrOwpVAmxhE/aEbuXp1vgX7hNah2/dUWAz+OV7H3EEAVGg1UBZuQpPsnmusrRcA==
X-Received: by 2002:a05:6a00:c89:b0:772:177:d442 with SMTP id d2e1a72fcca58-7742dddce93mr17438912b3a.20.1757529313302;
        Wed, 10 Sep 2025 11:35:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:4780:f759:d36a:6480])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7746629088dsm5859972b3a.53.2025.09.10.11.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 11:35:12 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:35:10 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
Message-ID: <aMHE3hmnGTYBrK0E@google.com>
References: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
 <dfdc655e-1e06-42df-918f-7d56f26a7473@gmail.com>
 <aKaK4WS0pY0Nb2yi@google.com>
 <048bd3c4-887c-4d17-9636-354cc626afa3@gmail.com>
 <aKc7D78owL_op3Ei@google.com>
 <da46b882-0cd3-48cd-b4fc-b118b25e1e7e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da46b882-0cd3-48cd-b4fc-b118b25e1e7e@gmail.com>

On Fri, Aug 22, 2025 at 09:11:25AM +0800, Ethan Zhao wrote:
> On 8/21/2025 11:28 PM, Brian Norris wrote:
> > On Thu, Aug 21, 2025 at 08:41:28PM +0800, Ethan Zhao wrote:
> > > Hold a PM reference by pci_config_pm_runtime_get() and then write some
> > > data to the PCIe config space, no objection.
> > > 
> > > To know about the linkspeed etc capabilities/not status, how about
> > > creating a cached version of these caps, no need to change their
> > > power state.
> > 
> > For static values like the "max" attributes, maybe that's fine.
> > 
> > But Linux is not always the one changing the link speed. I've seen PCI
> > devices that autonomously request link-speed changes, and AFAICT, the
> > only way we'd know in host software is to go reread the config
> > registers. So caching just produces cache invalidation problems.
> Maybe you meant the link-speed status, that would be volatile based on
> link retraining.

Yes.

> Here we are talking about some non-volatile capabilities value no
> invalidation needed to their cached variables.

I missed the "not status" part a few lines up.

So yes, I agree it's possible to make some of these (but not all) use a
cache. I could perhaps give that a shot, if it's acknowledged that the
non-cacheable attributes are worth fixing.

>
> > > If there is aggressive power saving requirement, and the polling
> > > of these caps will make up wakeup/poweron bugs.
> > 
> > If you're worried about wakeup frequency, I think that's a matter of
> > user space / system administraction to decide -- if it doesn't want to
> > potentially wake up the link, it shouldn't be poking at config-based
> IMHO, sysfs interface is part of KABI, you change its behavior , you
> definitely would break some running binaries. there is alternative
> way to avoid re-cooking binaries or waking up administrator to modify
> their configuration/script in the deep night. you already got it.

That's not how KABI works. Just because there's a potentially-observable
difference doesn't mean we're "breaking" the ABI. You'd have to
demonstrate an actual use case that is breaking. I don't see how it's
"broken" to wake up a device when the API is asking for a value that can
only be retrieved while awake. Sure, it's potentially a small change in
power consumption, but that can apply to almost any kind of change.

My claim is that this is a currently broken area, and that it is
impossible to use these interfaces on a system that aggressively enters
D3cold. If a system observes any difference from this change, then it
was broken before. Bugfixes are not inherently KABI breakages just
because they can be observed.

Brian

