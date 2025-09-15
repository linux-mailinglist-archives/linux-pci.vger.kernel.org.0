Return-Path: <linux-pci+bounces-36208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1FEB58765
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 00:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59BB1AA57D1
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 22:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD41D2C0F97;
	Mon, 15 Sep 2025 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsVzT+xs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C182C08DC;
	Mon, 15 Sep 2025 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974990; cv=none; b=jvqevdME0jwcAs5WKoUkUkRwrY7g8dHT2udyjZRrCESKlUOez2UCRaFyWbtiBh9sU+41Iu8PArCi3R/MrhT0p8mpeEXKiG1SEdgUE61ZQFzaUjvXTddLs5xV2hkyoBDme+jPlEbik9gdX+KfjQbkTESU0eTlML4541FCBP1AN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974990; c=relaxed/simple;
	bh=XIBKVrLxi77Ps3FXFyvj9VaVbAh4EbDmwoQQpscnDyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXrELPATHkOjlqwvjchIlJPJrRhuIhgGftfZDTPzZJi3dfbitcMQ7f9dkQBYZfLDsny0MhyLwUcdYY14E4JO63gigSR5w7q2MmNQ4N/uzJH6q71qSXW1QGysG9rUgjzwBWxr1oZZYiTeS2w6oHAcR0KKqdvnld6K3HSnJcFIJ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsVzT+xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82E2C4CEF1;
	Mon, 15 Sep 2025 22:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757974990;
	bh=XIBKVrLxi77Ps3FXFyvj9VaVbAh4EbDmwoQQpscnDyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsVzT+xsMM2HqWmCDDwPDULyPm2lqnE0zwNW/7Kvwn/LDrfomz7JcUHWNLX4az5x+
	 3bn/C2ISzMdYkNWuW8wKMPm843lCbwNDCWbjhp6w335VjB+SO9HYndGacRaUpo9BQP
	 fmGBnZ9BxQDUFz1cV9EaZ2LRxnAmGvI9kDe6ZMrQ5w3HufrpZY3iej8aD/oyZ7SsSO
	 BcjVVOCyDQU1zKt3xJvxibvn6flaLHqCBT+pI1Rlhh4+VuvhxrA8SHe8EBU3dohn4Z
	 DUr9BNCFpA+tIXq48C07NPhcK5B4je0DuADTeXuC1FLYwLKe/7lH5G/CVHa0Sc6uL6
	 0XNYYzvwMgXaQ==
Date: Mon, 15 Sep 2025 16:23:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kw@linux.com>
Cc: Matthew Wood <thepacketgeek@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <aMiRy_gJ4MQjgaS7@kbusch-mbp>
References: <20250821232239.599523-1-thepacketgeek@gmail.com>
 <20250821232239.599523-2-thepacketgeek@gmail.com>
 <20250913062041.GB1992308@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250913062041.GB1992308@rocinante>

On Sat, Sep 13, 2025 at 03:20:41PM +0900, Krzysztof Wilczy´nski wrote:
> Hello,
> 
> > @@ -1749,10 +1767,13 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
> >  	struct device *dev = kobj_to_dev(kobj);
> >  	struct pci_dev *pdev = to_pci_dev(dev);
> >  
> > -	if (pci_is_pcie(pdev))
> > -		return a->mode;
> > +	if (!pci_is_pcie(pdev))
> > +		return 0;
> >  
> > -	return 0;
> > +	if (a == &dev_attr_serial_number.attr && !pci_get_dsn(pdev))
> > +		return 0;
> > +
> > +	return a->mode;
> 
> It would be fine to have this sysfs attribute present all the time, and
> simply return error when the serial number is not available.  Not sure if
> hiding it adds a lot of value.  This is how some of the existing attributes
> currently behave.
> 
> But it does add extra code to pcie_dev_attrs_are_visible() where it is now
> a special case, somewhat.

You bring up a good point, but I think it seems odd that the existing
pcie attributes are visible even if we know reading it will fail.
Perhaps the pcie link status visibility should be changed to follow this
patch's example to hide when they don't exist. Applications might notice
a different error, ENOENT vs EINVAL, if the device doesn't support the
capability, but that is a more accurate errno.

