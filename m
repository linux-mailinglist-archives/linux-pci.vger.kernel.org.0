Return-Path: <linux-pci+bounces-7567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3908C74B9
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 12:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC5F1C23E47
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 10:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5841145334;
	Thu, 16 May 2024 10:41:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752DE143C4D;
	Thu, 16 May 2024 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856094; cv=none; b=F4At5BUxFa3/V0et4nK/ANChSb2K01jC0jjRB6wYhH+Vnnflc+LLGUeD67/eZ41vW+NL+w3SrEWTVGT6PrGr2v4MrTbJ3GHhrPW8PIegEP865coPgT2jMBP/251lYo6zUC4wXbyNRuJ9bpg44b8HAljScdgbNd2xI+4B4c7cGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856094; c=relaxed/simple;
	bh=1zBY8GdvqnuiFGTAx8ikTNvk5ZnfO/lIvciqAzyr5b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPZuunWuVm/4UGIJbHisSe+xW8jYdlFIYxLFvU7JvpwRodd5iuu3l+yYGjgX8/ATtw1kiAQyNkiay+pUSeqbdFVW61Hdf71AqP4FVDHi/+X5fFKugp8hOLPOTpSnGp8n+RW1CHKDCiXvqtEzrHrXrgEIEZB2DIWCdY5Gd4DAux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FB51DA7;
	Thu, 16 May 2024 03:41:57 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9ED253F762;
	Thu, 16 May 2024 03:41:30 -0700 (PDT)
Date: Thu, 16 May 2024 11:41:28 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	"will@kernel.org" <will@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"liviu.dudau@arm.com" <liviu.dudau@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Ketan Patil <ketanp@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] Enable PCIe ATS for devicetree boot
Message-ID: <ZkXi2LCy9ZZkupjM@bogus>
References: <PH8PR12MB6674391D5067B469B0400C26B8EC2@PH8PR12MB6674.namprd12.prod.outlook.com>
 <20240515185241.GA2131384@bhelgaas>
 <20240516073500.GA3563602@myrica>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516073500.GA3563602@myrica>

On Thu, May 16, 2024 at 08:35:00AM +0100, Jean-Philippe Brucker wrote:
> Hi,
> 
> On Wed, May 15, 2024 at 01:52:41PM -0500, Bjorn Helgaas wrote:
> > On Wed, May 15, 2024 at 06:28:15PM +0000, Vidya Sagar wrote:
> > > Thanks, Jean for this series.
> > > May I know the current status of it?
> > > Although it was actively reviewed, I see that its current status is set to 
> > > 'Handled Elsewhere' in https://patchwork.kernel.org/project/linux-pci/list/?series=848836&state=*
> > > What is the plan to get this series accepted?
> > 
> > I probably marked it "handled elsewhere" in the PCI patchwork because
> > it doesn't touch PCI files (the binding has already been reviewed by
> > Rob and Liviu), so I assumed the iommu folks would take the series.
> > I don't know how they track patches.
> 
> Yes I think this can go through the IOMMU tree. Since patch 3 is still
> missing an Ack, I'm resendng the series next cycle.
> 

Extremely sorry for that, since I saw Liviu on the thread, I assumed he
would have acked/reviewed 3/3 as well but now I see that is not the case.
That said, you must not delay the change just for the DTS file changes.
Anyways I will ack it now.

--
Regards,
Sudeep

