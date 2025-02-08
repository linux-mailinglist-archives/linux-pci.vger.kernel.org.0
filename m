Return-Path: <linux-pci+bounces-21029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBC0A2D78B
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 17:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCE11889A1C
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB82241CB5;
	Sat,  8 Feb 2025 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsBGOhYh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A05241CB1;
	Sat,  8 Feb 2025 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739032946; cv=none; b=pf0hqjbKLr/cliNTqfpX7O5NFZKMaSkorW24rRY7Icf4V5r35KKXz1hfhsVUnp56OVAc6/jWLYDRkMvN9FyNsIQ4+to3yrLTR0caWWo7RmOOfPbuek/IuW387lhcb/KUrs1FZvzCuj0RjD1Hn+4iQo9uKMozuLqBLXllzs6bcPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739032946; c=relaxed/simple;
	bh=DgPsBUG1mZURTvdZonNnm5wpyoUmtVyXOPK1IrfDxEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPrFIwKylv2LCFCJtdPZFpd/adYAH6cRsxoB3OqTDP2gon6ZZPGxIH2FMV5HQnLqsMT7GpujpGYYXs/WrwF2hBaQh6jFe18y4ov2QupWkQwjvK726cYeaRomsGxfOX+7dGbRY+Oji4qZ/JTKd0rTRB6wMCFwvgUmgjGMLKdoOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsBGOhYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DCCC4CED6;
	Sat,  8 Feb 2025 16:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739032945;
	bh=DgPsBUG1mZURTvdZonNnm5wpyoUmtVyXOPK1IrfDxEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsBGOhYhaKpHqCNcPMBGbPr7AdvYG8Ti5Oz+otCVCvAMtL88q2PQRpoaHp8hJH9cV
	 Y9ilRokFxm2Wop5qRa819CN3rUsXYVOEZpp1e0o3NtSmdUtJJpjpP9NuBjcBDHQpKy
	 Eoea5OMH7RxPopOZMzVqFm+qXK6BsVTC0hWLTo1yD6Cy6doeRZ9NxXRauv3iWMs5q7
	 Lc7CBDzAixd/eMHqdHN2z1/cuO3X6bQbW9EBOI00kFQLPaea1gxf4CQsR4zrCBjdyF
	 noecdmR98+W7GT/RFXsDt0vKra6kXPFVsqra9QYIcbETLFBf7MfztOtTAxyd0AVSop
	 iN7fcS6p6k12Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tgnuc-0000000048t-0XvO;
	Sat, 08 Feb 2025 17:42:34 +0100
Date: Sat, 8 Feb 2025 17:42:34 +0100
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
Message-ID: <Z6eJeo34N0q2ldQ9@hovoldconsulting.com>
References: <12619233.O9o76ZdvQC@rjwysocki.net>
 <1c2433d4-7e0f-4395-b841-b8eac7c25651@nvidia.com>
 <Z6YPpbRF_U0TxAbf@hovoldconsulting.com>
 <Z6YcjFBWAVVVANf2@hovoldconsulting.com>
 <CAJZ5v0iHjkfoh2A+hAmMCTG9_nBcJrsRYFD0Hp4ZChYUo7bFEg@mail.gmail.com>
 <Z6YviAFD4Az3EIBa@hovoldconsulting.com>
 <Z6Y0NlW40yHTIlzm@hovoldconsulting.com>
 <CAJZ5v0gBCQW2wwdB+4SyBXtqiis2k1Z2L8SOVKwcVbNxPHqvYA@mail.gmail.com>
 <CAJZ5v0gUcy4V-iztFumRZDUArQHiXE01vW3uC8Y01xnBD6Xi0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gUcy4V-iztFumRZDUArQHiXE01vW3uC8Y01xnBD6Xi0Q@mail.gmail.com>

On Sat, Feb 08, 2025 at 01:10:19PM +0100, Rafael J. Wysocki wrote:
> On Fri, Feb 7, 2025 at 7:14 PM Rafael J. Wysocki <rafael@kernel.org> wrote:

> > > > > > On Fri, Feb 07, 2025 at 02:50:29PM +0100, Johan Hovold wrote:

> > > > > > Ok, so the driver data is never set and runtime PM is never enabled for
> > > > > > this simple bus device, which uses pm_runtime_force_suspend() for system
> > > > > > sleep.

> For now, the power.set_active propagation can be restricted to the
> parent of the device with DPM_FLAG_SMART_SUSPEND set that needs to be
> resumed and that will just be sufficient ATM, so attached is a patch
> doing this.

I can confirm that this fixes the simple-pm-bus regression (without
reintroducing the pci warning) in case you want to get this to Linus
for rc2:

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan

