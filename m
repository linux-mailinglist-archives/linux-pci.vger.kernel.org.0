Return-Path: <linux-pci+bounces-17822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2251B9E6395
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 02:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F3B280FC4
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 01:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3231A269;
	Fri,  6 Dec 2024 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdQEP56w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3241D1758B;
	Fri,  6 Dec 2024 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449778; cv=none; b=YCiHUn2O7if5DlFj8RP7Rg+j29qBcmLg9G5o7NceSu3TiE6jrDTTYf72rDynOOB5YXtXi50Ttu2geuSio5MeHdUWqtkglUyydyWq9UgsMkyXhUKLuXkI2t3t6vWqeOBoFkidmXXlNlU9Q00Tqjjl/AnswlDZtq9tTsHuOyFcvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449778; c=relaxed/simple;
	bh=L4DXv199Z3VF0FFNAtlfPHVec44fIh6kYkZfjqUvd2E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bwOpTVSynkoRo8IK+XmznmnfeKWZ6/+XWV2j/zKM3BLe4G4VEofG//VuL95oaGpxc+NuFXUMF1k1dY8aitd1wA7C6kJ9gsvq7uBxlrhnZweHB6uzLns4HhjMLO/Ok39mLw7aBZAzQ+j/QMOLFYuHbYuQSA9xEfvuoCnQ3awhI6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdQEP56w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6830C4CED1;
	Fri,  6 Dec 2024 01:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733449777;
	bh=L4DXv199Z3VF0FFNAtlfPHVec44fIh6kYkZfjqUvd2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EdQEP56weDWGGpq3MZEWgWO2nZNrpnEwnoMicsmUyyunrex3x6Rbb89miDWIzDZfq
	 4hfKYtzNbc0p7T1WcNCk7W2A3ix79OKIPhXNKMLPzcHWKygIeWmm2U7lRrpEq6A6V/
	 ORmNSQ50Z+hDgyVpjl/J4ZdujO5PQMTlnKlwDzK2Ua/wk+Tp4XJsybYtQfNuXT4Uvr
	 Kovgyqx8oW/S80i5AfSVEbyxfVUXzdlGiLaHbFFgPIsk4jsBU6Bo4ar49F85r3PLBi
	 keCh/iopn5ZJ+joOsEO0xz2720Y1RFgpfkxir252Z8ySN78yCvpxtCEkJLh05Hbcrv
	 0CtvB10R/3iig==
Date: Thu, 5 Dec 2024 19:49:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241206014934.GA3081609@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205232900.GA3072557@bhelgaas>

On Thu, Dec 05, 2024 at 05:29:00PM -0600, Bjorn Helgaas wrote:
> On Sat, Nov 23, 2024 at 02:31:13PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Nov 22, 2024 at 04:20:50PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > > > PCI core allows users to configure the D3Cold state for each PCI
> > > > device through the sysfs attribute
> > > > '/sys/bus/pci/devices/.../d3cold_allowed'. This attribute sets
> > > > the 'pci_dev:d3cold_allowed' flag and could be used by users to
> > > > allow/disallow the PCI devices to enter D3Cold during system
> > > > suspend.
> ...

> > We did attempt to solve this problem in multiple ways, but the
> > lesson learned was, kernel cannot decide the power mode without help
> > from userspace. That's the reason I wanted to make use of this
> > 'd3cold_allowed' sysfs attribute to allow userspace to override the
> > D3Cold if it wants based on platform requirement.
> 
> It seems sub-optimal that this only works how you want if the user
> intervenes.

Oops, I think I got this part backwards.  The patch uses PCI PM if
d3cold_allowed is set, and it's set by default, so it does what you
need for the Qualcomm platform *without* user intervention.

But I guess using the flag allows users in other situations to force
use of NVMe power management by clearing d3cold_allowed via sysfs.
Does that mean some unspecified other platforms might only work
correctly with that user intervention?

