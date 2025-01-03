Return-Path: <linux-pci+bounces-19205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF33A004EC
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 08:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0539A3A3BA8
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2943E1C6F55;
	Fri,  3 Jan 2025 07:26:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B71C4A06;
	Fri,  3 Jan 2025 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735889186; cv=none; b=UKLtl6LAElk7jtPQGPvsGx9T5/JjioP9wguLAxljnPlWsMQgNTpZOZz1OMSBsff+9w9CPmZD4hCw3fDnTgW3eu4+HupNWPPUIfL0OLCSO68ZNe0/pgUqKAT7l9h9k+k4FTa3wQRWBXxunV9u4R9yMoeIkcZQACbQHoETdzrkzQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735889186; c=relaxed/simple;
	bh=pz63QfLPi/CCttZOmeS1MoGoR+gt72Nwhzi3Gtrl96U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoCd41xByNEWy7ORmc7d7z548TQV36mKRZLkcSopTlJ9V+59eNYaTlJvtW+ape2gtDUx5LD9wtBf1jWlQlfn20PewlDtVCsuMre4CjeRgQefO0xlQPj3Hh840m8PLSQoJb2cG/lV/Tt1tNlHS3mI9ofRETSJkTrxX1KDPSoeAP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70DA268BEB; Fri,  3 Jan 2025 08:26:18 +0100 (CET)
Date: Fri, 3 Jan 2025 08:26:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Christoph Hellwig <hch@lst.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20250103072618.GA28920@lst.de>
References: <20241216171108.6ssulem3276rkycb@thinkpad> <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com> <20241216175210.mnc5kp6646sq7vzm@thinkpad> <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com> <20241217052632.lbncjto5xibdkc4c@thinkpad> <CAJZ5v0gjrBUgejwBz1vv6P83oZiYu8AuDMs47ZAFJoNhMaMdpQ@mail.gmail.com> <20241219080217.fr2ukr7sk4a7hfmo@thinkpad> <CAJZ5v0hByaAAaYGhAvstwtfa-JP6JRQCbWCZrTsRGWEHHyRKdA@mail.gmail.com> <CAPDyKFqc+YuAyV-120Vvg7HOkhgnJ=wM53LAHTkJ6Gg5=rJumA@mail.gmail.com> <CAJZ5v0gVCjhqLhNz-e7J4nZ05gJO9yYbRaNVuFdQRtO6JbTGfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gVCjhqLhNz-e7J4nZ05gJO9yYbRaNVuFdQRtO6JbTGfA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 19, 2024 at 07:28:53PM +0100, Rafael J. Wysocki wrote:
> In the particular case of NVMe, though, the question of how to
> actually power it down is still open.

Powering down nvme controller is down by shutting the controller
down (nvme_disable_ctrl with shutdown=true).  

> Until there is a clear answer
> to it, the possibility of powering NVMe devices down and up too often
> is not really a practical concern.

Why do you think it isn't a practial concern?

> Generally, the problem of choosing suitable power states during system
> suspend is not limited to storage (for instance, if the sleep time is
> going to be short enough and it is known in advance, it may not be
> useful to change power states of many devices because that is just
> going to take too much time) and the attempts to address it have been
> very limited so far.  There are many factors that come into play, like
> how much energy is to be saved, how much time are suspend and resume
> transitions allowed or expected to take, which devices are expected to
> wake up the system from sleep, etc, and the possible device wearout is
> one of them.

It is true that this applies to all kinds of devices.  But for (flash)
storage devices it is more important because of the effect on device
wear, the shutdown (and unclean restart) times that are much longer than
most devices.


