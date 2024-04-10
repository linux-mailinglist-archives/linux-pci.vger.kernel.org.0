Return-Path: <linux-pci+bounces-6097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B83A8A0333
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 00:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D6E2854CE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E197A184107;
	Wed, 10 Apr 2024 22:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HmxkiMyM"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBF2181CE4;
	Wed, 10 Apr 2024 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787573; cv=none; b=Gnjy6WMRrCSndffOB8V/1NqQ2vnSDJvN1+Je2tl0lB0085SWwL3QJcSEmcixpE0ei51jT8n1/dxVRLrMUWMMErRm/Kwq/k5OYv8V4X/R/3sXFLIhM876eubwLto5ud79RnPomu+aGR6/jS07MwyI2dC3T04LZnhWutBTjN7irvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787573; c=relaxed/simple;
	bh=RBqljQm7JMEgswn2qtxe3dR7eQ1g8PHIfsgJYiV3nf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSLopWMOCfh30WmTbo+Ip+6Ku354eNLO30SI2CZR085yUzXJer6JXiZYeOKWLpAqKIMfQg6vzzPo4VyKCWGs0LEjkSTHyiAQbpT7sntjKyhcoXzH0AvPPaQJq4P2NF6GZ3jJIZTibJ7sjsAzDCgZvfjBYOVDzW4Hg8SrXGMvklY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HmxkiMyM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lLc/qmGcLY8CIbx/gZ/1esqXMmyRWUNlzhQigQOjjZM=; b=HmxkiMyMtPH3j8+tJmE7bKSvMW
	NG4xWukEDGTsIhjtyxvwHyOyeEDDf69EPd0HC8ycnEEpL3lxB+7GIGkkXpHQ5E4QTWlA3Q82gUYiq
	SCvFcW9pD17iXr6+0VVBUTmFRfP3f6Zybtfuj3CrpfhEBrNfJGtfNIAnauyVuXQy3aeM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rugHf-00Ci4U-Rp; Thu, 11 Apr 2024 00:19:11 +0200
Date: Thu, 11 Apr 2024 00:19:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
	John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <6a775533-bd50-4f57-85f7-125c107bd77a@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
 <6615adbde1430_249cf52944@willemb.c.googlers.com.notmuch>
 <ZhY_MVfBMMlGAuK5@nanopsycho>
 <885f0615-81e8-4f1f-9e97-b82f4d9509d3@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <885f0615-81e8-4f1f-9e97-b82f4d9509d3@intel.com>

> I think its good practice to ensure multiple vendors/drivers can use
> whatever common uAPI or kernel API exists. It can be frustrating when
> some new API gets introduced but then can't be used by another device..
> In most cases thats on the vendors for being slow to respond or work
> with each other when developing the new API.

I tend to agree with the last part. Vendors tend not to reviewer other
vendors patches, and so often don't notice a new API being added which
they could use, if it was a little bit more generic. Also vendors
often seem to focus on their devices/firmware requirements, not an
abstract device, and so end up with something not generic.

As a reviewer, i try to take more notice of new APIs than most other
things, and ideally it is something we should all do.

	 Andrew




