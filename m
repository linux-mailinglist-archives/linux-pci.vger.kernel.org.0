Return-Path: <linux-pci+bounces-7714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE038CAC32
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 12:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27C71F22C1E
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA270CC9;
	Tue, 21 May 2024 10:25:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5B86CDD8
	for <linux-pci@vger.kernel.org>; Tue, 21 May 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287154; cv=none; b=DmZ1scSPaprjYgX/E1InCx6l6cA7ui562YiJGI6XPPKVnVQvwQqSxiB49bmz/HI300d697IRPUq3hRNWjztjqt3tNBiq6NiM/E323ZQXsIs+74y6EZu0hcR4w4zbF5naOB9aGV6bde6/hFnicWNuWG7Rde+MLFlAwoisGUqmz38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287154; c=relaxed/simple;
	bh=PzkREHFxftmh9BlfZ0knbcVfRSI6Uv/LfaRce+Dlslk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgOwZ7kZZLALpz6bnVCTYLMcpRsDwg2hlcVcVKrnsMfadd3TPhn5/w4fQpulG0BSEPp+UNszIHO5Lgpn2wdiHBkTEdFzowfPQVhdt5l0xPYvGYIF+VoWEevl9wtc5n77mF7nYOEyyUBW2AiNXi0tQga/hNpfnfmAkWkAgaV7Tc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AF90DA7
	for <linux-pci@vger.kernel.org>; Tue, 21 May 2024 03:26:16 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E5D843F766
	for <linux-pci@vger.kernel.org>; Tue, 21 May 2024 03:25:51 -0700 (PDT)
Date: Tue, 21 May 2024 11:25:31 +0100
From: "liviu.dudau@arm.com" <liviu.dudau@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	"will@kernel.org" <will@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Ketan Patil <ketanp@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] Enable PCIe ATS for devicetree boot
Message-ID: <Zkx2m41lIdaV_WyH@e110455-lin.cambridge.arm.com>
References: <PH8PR12MB6674391D5067B469B0400C26B8EC2@PH8PR12MB6674.namprd12.prod.outlook.com>
 <20240515185241.GA2131384@bhelgaas>
 <20240516073500.GA3563602@myrica>
 <ZkXi2LCy9ZZkupjM@bogus>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkXi2LCy9ZZkupjM@bogus>

On Thu, May 16, 2024 at 11:41:28AM +0100, Sudeep Holla wrote:
> On Thu, May 16, 2024 at 08:35:00AM +0100, Jean-Philippe Brucker wrote:
> > Hi,
> > 
> > On Wed, May 15, 2024 at 01:52:41PM -0500, Bjorn Helgaas wrote:
> > > On Wed, May 15, 2024 at 06:28:15PM +0000, Vidya Sagar wrote:
> > > > Thanks, Jean for this series.
> > > > May I know the current status of it?
> > > > Although it was actively reviewed, I see that its current status is set to 
> > > > 'Handled Elsewhere' in https://patchwork.kernel.org/project/linux-pci/list/?series=848836&state=*
> > > > What is the plan to get this series accepted?
> > > 
> > > I probably marked it "handled elsewhere" in the PCI patchwork because
> > > it doesn't touch PCI files (the binding has already been reviewed by
> > > Rob and Liviu), so I assumed the iommu folks would take the series.
> > > I don't know how they track patches.
> > 
> > Yes I think this can go through the IOMMU tree. Since patch 3 is still
> > missing an Ack, I'm resendng the series next cycle.
> > 
> 
> Extremely sorry for that, since I saw Liviu on the thread, I assumed he
> would have acked/reviewed 3/3 as well but now I see that is not the case.
> That said, you must not delay the change just for the DTS file changes.
> Anyways I will ack it now.

Appologies, I was travelling last week and thought DT changes will be taken
via Robin.

Best regards,
Liviu

> 
> --
> Regards,
> Sudeep

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

