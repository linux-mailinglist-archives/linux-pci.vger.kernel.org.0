Return-Path: <linux-pci+bounces-14949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B9E9A716C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 19:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9851F2340E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 17:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905A71EF0B4;
	Mon, 21 Oct 2024 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSAuLsWm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA3D1EABD1;
	Mon, 21 Oct 2024 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533211; cv=none; b=e2cfmWTUagD9FuvHKLrkYaLZykLUYUefq6Tng3TCKnhYCZF3EpndqZgUOzu1NA0aE8IpcEWmeYtCpRkZOzfskZ0R5LdPOikBctWGO+VweRRQWA5/Tyspq9PqM05nNo4t/RqqQRyDUBhKdwcpqLdl9e4Dy6lYHGz9yN5kVNLBCh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533211; c=relaxed/simple;
	bh=pEO3WCdTG0OPmLeMMYj2xwB5T3LSe9k1uzrv7xAakx0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qn8Hw+ms9wAB3jmh73j9W5AogJEWyYX8zGyAE1/XrPOtRP7+wQ5NL4pFlskVxwL7Zq1fMqBu2iJ0sr4WvYYRjePJsgsS2JnVj2qXstCB0d0kG4702wEgYS5X5WZFwaubfN+ufggqxlqyTfKj0+cWZXl+n6eXH6eg2wFAsGElbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSAuLsWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7F6C4CEC3;
	Mon, 21 Oct 2024 17:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729533211;
	bh=pEO3WCdTG0OPmLeMMYj2xwB5T3LSe9k1uzrv7xAakx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oSAuLsWmFi6L0bCtv6qZr7bUMa7W/b85jFoSuSurslAl9wnf8jpPqdn9CiBD9kodq
	 6jhgMDKF9HmmVDmXDOZp1N8/LgW/Ro6LpFAybMv7rIPqja/W2ydi8h8Z46l8iJls48
	 oluy9OrlphhI67hn+DH/RWk5jsXXE2Cn6ZGKCt6TD+3AYiOUxpNLjVnc2TQKi8J9Gx
	 Bygl4l5Rs8Am1QaiByzxRy8eSnEEQSWG3i36qr5Q5Jf8mDKEOxOnMHMfk5QCQYCVrD
	 oJLlSGPw5UmRnQqG4SpnDYJNfa0NV5YrBy0RR1i+FS7q7ySToJs1Ml55Y+kOseXmbC
	 W6UDoMX8gF59g==
Date: Mon, 21 Oct 2024 12:53:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI: Improve printout in pdev_sort_resources()
Message-ID: <20241021175328.GA839797@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241018234258.GA770341@bhelgaas>

Oops, I inadvertently removed the cc list when I sent the response
below.  Adding it back here.

On Fri, Oct 18, 2024 at 06:42:59PM -0500, Bjorn Helgaas wrote:
> [+cc Jonathan]
> 
> On Thu, Oct 17, 2024 at 12:55:45PM +0300, Ilpo Järvinen wrote:
> > Use pci_resource_name() helper in pdev_sort_resources() to print
> > resources in user-friendly format. Also replace the vague "bogus
> > alignment" with a more precise explanation of the problem.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Applied with Philipp's reviewed-by to pci/resource for v6.13, thanks!
> 
> Happy to add yours, too, Jonathan, if you want.  You basically said
> so, but I don't want to presume :)
> 
> > ---
> > 
> > v2:
> > - Place colon after %s %pR to be consistent with other printouts
> > - Replace vague "bogus alignment" with the exact cause
> > 
> >  drivers/pci/setup-bus.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 23082bc0ca37..0fd286f79674 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -134,6 +134,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
> >  	int i;
> >  
> >  	pci_dev_for_each_resource(dev, r, i) {
> > +		const char *r_name = pci_resource_name(dev, i);
> >  		struct pci_dev_resource *dev_res, *tmp;
> >  		resource_size_t r_align;
> >  		struct list_head *n;
> > @@ -146,8 +147,8 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
> >  
> >  		r_align = pci_resource_alignment(dev, r);
> >  		if (!r_align) {
> > -			pci_warn(dev, "BAR %d: %pR has bogus alignment\n",
> > -				 i, r);
> > +			pci_warn(dev, "%s %pR: alignment must not be zero\n",
> > +				 r_name, r);
> >  			continue;
> >  		}
> >  
> > -- 
> > 2.39.5
> > 

