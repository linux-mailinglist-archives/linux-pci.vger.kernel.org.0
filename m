Return-Path: <linux-pci+bounces-10601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B109390E3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 16:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64CF2B2160A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0106A16DC13;
	Mon, 22 Jul 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV+bvDlB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88116D9D1;
	Mon, 22 Jul 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659453; cv=none; b=p8LR2VuX2bSyGLEp2Zb2SRArnOzJ0aHaOCJvhTEImsNPs78kndWUIFb0mEkb+EkQ9PNNGMs41x36/GxPyiuNNrTj4Vn+D9NCF4ERocphJn7DaXU8Q7EBz2PoDxazr57bMpygstGAYGZxQbHuzuM+LU+U1BgV/2znENoGic2b9EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659453; c=relaxed/simple;
	bh=xOnb4vfSEzLp9u9zRJaR5xKQ3AxFJbvHhCRkcpvw8yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNgebAKZBrNn8KwfgUJ7Q/YCGdKEn7K7x7EOL9Mb2nzkelW9cCzTONG9+q/6+Q/PhG4HHeRiMexAbt9BG/SnQiKHU5tsLTb+m5pvcz8/T+4rleM5q+h/6EYXStXGOOWpti03IvoGI7ciDkyfGiS2xR2BBtvNe6vDAGk8c289/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV+bvDlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1615C4AF0D;
	Mon, 22 Jul 2024 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721659453;
	bh=xOnb4vfSEzLp9u9zRJaR5xKQ3AxFJbvHhCRkcpvw8yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GV+bvDlBySZyg4kwglwPcXSjacb+rhOXhuS+3NpAwHsJnOg1PlxsJgkAlSGWGMHs0
	 GVIiZGn6crvoXWlYk/xroNXTBI4xVs1ZWl34rD81TLv2JLh26PorVjOz6lwNERMDKV
	 embfn/ZBeKOcGY3zzeOHbTcIPFy/TD8IzPDOnOVFzrT1dcqDoVSNDI+siId+Jn+sKn
	 5B2wkDhTgSbRLUaeEZiW0ydqsv+VtNG5xnEFKwZu4NtHM9ZLP1aL8RtAjUDHCxA7e8
	 bk7vc5JKPcWk/6myNTDt8nowk0Ypqdpxvnojl2ZsToeWCIpv/UqQy6z//ZNKmYcuZn
	 Y7na4E0Q4xiqg==
Date: Mon, 22 Jul 2024 08:44:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Keith Busch <kbusch@meta.com>, rafael@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, lukas@wunner.de
Subject: Re: [PATCH] driver core: get kobject ref when accessing dev_attrs
Message-ID: <Zp5wOjhgK7HdPqsS@kbusch-mbp.dhcp.thefacebook.com>
References: <20240719185513.3376321-1-kbusch@meta.com>
 <2024072058-dork-ferret-71d5@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024072058-dork-ferret-71d5@gregkh>

On Sat, Jul 20, 2024 at 07:17:55AM +0200, Greg KH wrote:
> On Fri, Jul 19, 2024 at 11:55:13AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Get a reference to the device's kobject while storing and showing device
> > attributes so that the device is valid for the lifetime of the sysfs access.
> > Without this, the device may be released and use-after-free will occur.
> > 
> > This is an easy problem to recreate with pci switches. Basic topology on a my
> > qemu test machine:
> > 
> > -[0000:00]-+-00.0  Intel Corporation 82G33/G31/P35/P31 Express DRAM Controller
> >            +-01.0-[01-04]----00.0-[02-04]--+-00.0-[03]--
> >                                            \-01.0-[04]----00.0  Red Hat, Inc. Virtio block device
> > 
> > Simultaneously remove devices 04:00.0 and 01:00.0 and you'll hit it:
> > 
> >  # echo 1 > /sys/bus/pci/devices/0000\:04\:00.0/remove &
> >  # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove
> 
> So you remove the parent before the child and also want to remove the
> child at the same time?  You are going to have bad problems here :)

The example I provided is surely a user error, but it just demonstrates
the issue. The parent device can be removed at any time without user
action: hotplug and error handling take devices down automatically. And
it's not just a problem when requesting to concurrently removing the
child device; it's still a use-after-free from just accessing its
attributes.
 
> > @@ -2433,12 +2433,15 @@ static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
> >  	struct device *dev = kobj_to_dev(kobj);
> >  	ssize_t ret = -EIO;
> >  
> > +	if (!kobject_get_unless_zero(kobj))
> > +		return -ENXIO;
> 
> We've been down this path before, and it doesn't end well from what I
> recall.  Attributes that when written to remove themselves need to call
> the correct function to do so (look at how scsi does it).  I think this
> change will now break that functionality.  Look in the email archives a
> long time ago for more details, I can't recall them at the moment,
> sorry.

Thanks for the suggestion. I'll try to figure out what scsi does and see
if that strategy can work here.

