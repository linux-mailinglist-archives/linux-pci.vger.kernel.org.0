Return-Path: <linux-pci+bounces-32723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C8CB0D8E6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 14:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B241C20FF7
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB232E2EFF;
	Tue, 22 Jul 2025 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTmDkw8Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD223ED63;
	Tue, 22 Jul 2025 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185874; cv=none; b=G42sWCsKQeX3OovFtwIsVxym6+mmgSjDQ5yoT2teJMqlgpPjO3EHjSo7B0wFlh8fQTideOLKQMw/CLyaX80jkb64jABQ9vN5VWQQIsW8/weRcwfS/6KjgyLKs4UouWR6dr//t6LlmD5O/jwtFPQQ+33LY4NzA0xlU7Y6CRVHnrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185874; c=relaxed/simple;
	bh=3eAdipsJ6tJ8YkYVriMzsqv7jbDFOI6+lt1f3E7noWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A86uN+3eetVumJ1zdL9S0QjseDHtW6N5NWBW/8GujG2BuysKW/ihsJhZwADICvFhUdSpYvUILDIrQn6HG6LIgLGVIyPTvmUIBtjsg1yQJ1wpnipRvuWUt2JcM/T9rFBfhl9p1MqHOGoHP8+ruU7x1UnhjK26jMajWRMUxtBjYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTmDkw8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C95C4CEEB;
	Tue, 22 Jul 2025 12:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753185874;
	bh=3eAdipsJ6tJ8YkYVriMzsqv7jbDFOI6+lt1f3E7noWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTmDkw8Zy0TYzyUJoeyzFzzA7ihP4aVHZjnj0P0Ho4zEF5gI8cCGx9YjblNLDb3Qe
	 8MAroQg08ouJQcYTFUS76SDDx5XW+jxBSrKHyMrv5ZjGd6kAeMgaxjf/jmB5FT0DdP
	 OoCirihtEEa0tll8V95uKt3uOyGs/t4ysnTX8GnK4tQPAy1Pj+y4Zv/KViFJvN4405
	 KT+8Ixc4TMKdYaueayptTXt03l3GI3I78xgxw1HnosM4iW7XrC9s9xRqaEHHUqBTrI
	 cO8hiwxS0NUg6cx475mfuMw+clG339ppWzWWxLWCKQb1uwGX3VlvSDB0e5OcFHQCyb
	 cChaMV6D948TA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueBjL-000000002RI-47pU;
	Tue, 22 Jul 2025 14:04:24 +0200
Date: Tue, 22 Jul 2025 14:04:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI/pwrctrl: Fix device and OF node leak at bus scan
Message-ID: <aH9-R8eHdr31b4HA@hovoldconsulting.com>
References: <20250721153609.8611-1-johan+linaro@kernel.org>
 <20250721153609.8611-3-johan+linaro@kernel.org>
 <20250722110833.0000542d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722110833.0000542d@huawei.com>

On Tue, Jul 22, 2025 at 11:08:33AM +0100, Jonathan Cameron wrote:
> On Mon, 21 Jul 2025 17:36:08 +0200
> Johan Hovold <johan+linaro@kernel.org> wrote:

> > @@ -2515,9 +2515,15 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
> >  	struct device_node *np;
> >  
> >  	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
> > -	if (!np || of_find_device_by_node(np))
> > +	if (!np)
> >  		return NULL;
> >  
> > +	pdev = of_find_device_by_node(np);

> Given we have two entirely different pdevs in here, I'd use an extra
> local variable to indicate what this one is the pwctrl one created below.

It's actually the same pwrctrl platform device (which may have been
created in an earlier call to the function) so using the same variable
should be fine.

Johan

