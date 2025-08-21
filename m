Return-Path: <linux-pci+bounces-34423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C43B2EB85
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 04:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578C91730C1
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 02:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08132D47E5;
	Thu, 21 Aug 2025 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jk+B531y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196722D3A9C
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744997; cv=none; b=GQ1cPME+BzWslfEJid2tqud/PRCeX5gmNgGISahADYMCGgC/PDg2XlsqEuDM7y1eCF7Dx6gj0+Z/rLgoWPCe/EOk6hQQKS2PDR6z66ACsVKP7i7wfEBiw1z6pr3dlZYeflrr3bbyViZYcn7EoLUiQB2dioq+Grv7z1FxPPu77/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744997; c=relaxed/simple;
	bh=XHwx3T0vj4Lv+s2Y6qqwZiObkh2r7IivbMwDx2b9V+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcL4RZoImo36EvbhRnQaabbsrG3gMqgbxmagVJ5Iigb+eJz9B8hRLYnHYSBpHlEN89XpbS9GYaFbpzGOByvH0qlfvgYQbyNmNiPiXWHkoCck9xnXChTMPiL5w5XQHRy4O/iE69rHlRbETYQY1c7r/WNmh32W9X2qE4OXjeX7Bs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jk+B531y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445824dc27so4871105ad.3
        for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 19:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755744995; x=1756349795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H996zq4Ef8LWOErXtNjqGqwGdLBd8tccS6w3vtc0ofM=;
        b=jk+B531yo+tDFD0GgYH9CPrdGm4F0E8ZaMTy3+3IZduxdZqHtIgSghwYVADFBsnF4W
         B6+JxtFkdUV3FSz3FWaYdOPd8dgkSSC8ShNaMYm1RXAFMdgXe7AGtpH0DCvxI64ifNhT
         1SwXI4i5NAZ8pKkOUcKWymv6DhbR2D4txZT0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755744995; x=1756349795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H996zq4Ef8LWOErXtNjqGqwGdLBd8tccS6w3vtc0ofM=;
        b=FZ3EGqnj8bm4oFSA8pE+IkN/et9+hz/DqkiB25ZCZQcMFS+aobp+F2bnk1YnYO1bwT
         xZFjj27myemTJ0nrnEl45KC3ISjqkfepOOH+gzGcP3MXGdHBOptG+iP7+5MpISIBX1p7
         VmrssjKSz3CFdb6SSOU9nHcnxNlqOq+Z0egMBrC1ilqUqskxZN8ZqgZO4Ve55x33vycL
         NBS8oWLjA5xbBJ9NmHNTus3CCF4ojUSmB4dcDqeCdCMuZlKi+FmgTzI8zesn1sxKsuZN
         k9aMGRYfvTlvraq/HJRrNat4Z3HEwPuChreSUCDlvFOhifiJuaHY6RZwM8awwcb+Z1ED
         02fg==
X-Forwarded-Encrypted: i=1; AJvYcCWEm6+MoH7F6Ab1YJCPXj+d0C2sJuYbvAV9Wq1ZtzyFGvGpTbOU0tin3+ijO8pcaqoAjZJSiGBV46Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCno8ztqmu47wiwkRhcSHp9S4Oz2N6guEgbmwIGwiaHNtuGSQp
	/H4Ex7fk+07ncVEe3M1Z1mXcb1/qeiwdZhWiW+wV1UqqX2Nvt9oVBQ6p5a/uORgz5Q==
X-Gm-Gg: ASbGnctU1ioFNz1vR478248ZfHT7/3hevkTCHQX9rXT8zKwmjHhN7T4IkctkSh4vDl9
	wOkjSOzx1xoHhA/1q82FCeJG+t4uSAdPDkwE0fxnRjrzf7GUbF9P6dkC3PoTt/gqzVg/0Bs7AiN
	Ez49rGe2zXsqr0oykyBNn2uY1vbt/svIZLhFJ5s4yEqXpvX9vGglxm0W4D/4wnHxvCy/K1b1JUr
	0oNJ0YjWUZK+aY5t0YbQepeBwaeIlcf7tWh+m2JjvwbN3E7Nhp++DLY6N2nqKO2WAFXoLpbL5rU
	ZrnTpRIPXTvBuLW/1D4p6DVDlSa46vot5ttZbrEi3BIcau2UGg7wXsfBd1gQ/sxvlhnT0ysLCuF
	9N6RAH7damj/sv8mLPjvfgr7dKOxiVr527y59QxfHMUWqBHzgf4eM516DI6+O
X-Google-Smtp-Source: AGHT+IFfmuP/LFF7jXoz31JRLaGXSHGr8GvB67Fhz5PVKoovm91wDMvqkaL2E7H6MP4gZJtQNndaNg==
X-Received: by 2002:a17:903:3bcc:b0:240:49e8:1d3c with SMTP id d9443c01a7336-245fed7d21amr10502565ad.35.1755744995342;
        Wed, 20 Aug 2025 19:56:35 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2283:604f:d403:4841])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-245ed4c7588sm40352175ad.101.2025.08.20.19.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 19:56:34 -0700 (PDT)
Date: Wed, 20 Aug 2025 19:56:33 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
Message-ID: <aKaK4WS0pY0Nb2yi@google.com>
References: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
 <dfdc655e-1e06-42df-918f-7d56f26a7473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfdc655e-1e06-42df-918f-7d56f26a7473@gmail.com>

On Thu, Aug 21, 2025 at 08:54:52AM +0800, Ethan Zhao wrote:
> On 8/21/2025 1:26 AM, Brian Norris wrote:
> > From: Brian Norris <briannorris@google.com>
> > 
> > max_link_speed, max_link_width, current_link_speed, current_link_width,
> > secondary_bus_number, and subordinate_bus_number all access config
> > registers, but they don't check the runtime PM state. If the device is
> > in D3cold, we may see -EINVAL or even bogus values.
> My understanding, if your device is in D3cold, returning of -EINVAL is
> the right behavior.

That's not the guaranteed result though. Some hosts don't properly
return PCIBIOS_DEVICE_NOT_FOUND, for one. But also, it's racy -- because
we don't even try to hold a pm_runtime reference, the device could
possibly enter D3cold while we're in the middle of reading from it. If
you're lucky, that'll get you a completion timeout and an all-1's
result, and we'll return a garbage result.

So if we want to purposely not resume the device and retain "I can't
give you what you asked for" behavior, we'd at least need a
pm_runtime_get_noresume() or similar.

> > Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
> > rest of the similar sysfs attributes.
> > 
> > Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Brian Norris <briannorris@google.com>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > 
> >   drivers/pci/pci-sysfs.c | 32 +++++++++++++++++++++++++++++---
> >   1 file changed, 29 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 5eea14c1f7f5..160df897dc5e 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -191,9 +191,16 @@ static ssize_t max_link_speed_show(struct device *dev,
> >   				   struct device_attribute *attr, char *buf)
> >   {
> >   	struct pci_dev *pdev = to_pci_dev(dev);
> > +	ssize_t ret;
> > +
> > +	pci_config_pm_runtime_get(pdev);
> This function would potentially change the power state of device,
> that would be a complex process, beyond the meaning of
> max_link_speed_show(), given the semantics of these functions (
> max_link_speed_show()/max_link_width_show()/current_link_speed_show()/
> ....),
> this cannot be done !

What makes this different than the 'config' attribute (i.e., "read
config register")? Why shouldn't that just return -EINVAL? I don't
really buy your reasoning -- "it's a complex process" is not a reason
not to do something. The user asked for the link speed; why not give it?
If the user wanted to know if the device was powered, they could check
the 'power_state' attribute instead.

(Side note: these attributes don't show up anywhere in Documentation/,
so it's also a bit hard to declare "best" semantics for them.)

To flip this question around a bit: if I have a system that aggressively
suspends devices when there's no recent activity, how am I supposed to
check what the link speed is? Probabilistically hammer the file while
hoping some other activity wakes the device, so I can find the small
windows of time where it's RPM_ACTIVE? Disable runtime_pm for the device
while I check?

Brian

