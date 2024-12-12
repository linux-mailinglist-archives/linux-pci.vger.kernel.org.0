Return-Path: <linux-pci+bounces-18215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0CF9EDF23
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 06:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E041666BC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 05:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C47717BB24;
	Thu, 12 Dec 2024 05:59:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6416FF4E;
	Thu, 12 Dec 2024 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733983166; cv=none; b=uW9SVvbl4AuOmv4E4ngyqdSVSQdm0Fqy8tdZb+RkomrzzRDkDlWhYiyWTCggLwCBA/hHz695teBeNAb63vDHxHBZDIyJeNCNQzolJFF+7FmS7NE2iF7oNe9JGmFhejc3tgtHUZDu9txzpW99SZofR5CEge2RSFr+qU0BYXPzEKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733983166; c=relaxed/simple;
	bh=ZqQXAc3nXCYF3BKN0xXrCtUY7QFOP0sYKuINeUb3MGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsptmZSIhQY/4vLrE3PKzhLW4BzLldQyNoowjcJECvYr3/GSdrQqCuDp/55Dp+NMKYqTUo9xNFoedSOX7ADAh57CsJag+lKhi3jphDnBNxnxIDdzmthf3Prxf9boZRQdddSz8uJcoe4OeW8qI/8Y86ukwtU+XKKaTc+wErz/Aag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7EED568D07; Thu, 12 Dec 2024 06:59:20 +0100 (CET)
Date: Thu, 12 Dec 2024 06:59:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241212055920.GB4825@lst.de>
References: <20241205232900.GA3072557@bhelgaas> <20241206014934.GA3081609@bhelgaas> <20241209133606.GA18172@lst.de> <20241209143821.m4dahsaqeydluyf3@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209143821.m4dahsaqeydluyf3@thinkpad>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 09, 2024 at 08:08:21PM +0530, Manivannan Sadhasivam wrote:
> > 
> > The istory here is the the NVMe internal power states are significantly
> > better for the SSDs.  It avoid shutting down the SSD frequently, which
> > creates a lot of extra erase cycles and reduces life time.  It also
> > prevents the SSD from performing maintainance operations while the host
> > system is idle, which is the perfect time for them.  But the idea of
> > putting all periphals into D3 is gaining a lot of ground because it
> > makes the platform vendors life a lot simpler at the cost of others.
> 
> No, I disagree with the last comment. When the system goes to low power mode
> (like S2R/hibernate), it *does* makes a lot of sense to put the devices into
> D3Cold to save power.

Yes.  That's what the pm_suspend_via_firmware call in nvme_suspend is
supposed to catch.  If that is not the right way to check for a
non-runtime suspend we'll need to improve the interface.  Which really
are a mess, and the last thing I want is more "intelligence" in the
drivers.  We need go information from the PM core what is going on so
that things work out of the box.  Overloading obscure sysfs files with
new logic queried from a driver is a complete no-go.

> The current reality is that most of the devicetree platforms *do* want to power
> down the NVMe during suspend. Only when NVMe is used in an OS like Android, we
> might not want to do so (that's something for future, but still a possibility). 

So fix the bloody interface instead of piling up hacks in drivers.


