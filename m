Return-Path: <linux-pci+bounces-20907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F9A2C84A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95531162783
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C5B1DE4EA;
	Fri,  7 Feb 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKRyN7DX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507723C8BA;
	Fri,  7 Feb 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738944383; cv=none; b=EGhU0rbyKE2qfVmNw3kou9q3srZcmkLeW3fKDcEXrfCWMwlssEgGbQxaKqavE14qanKZudXNBXgwRRkRG7NsL43jkbGfYBZvLUXakLp2TZV/eC4VmwhDepxkVtDvMoIUCAtGLYUjaqANjm5beBwDM1cWSnbv+RkgmbcBeIWb6UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738944383; c=relaxed/simple;
	bh=HnHgKw5S43ISE7VAWcFFXSGNAVbgSBW92k7zYjpnP+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLhZaPk8k4yzmQWFufOStTcfxPQezC9ZoCFRG4Wyo/eY13UG2ENoQJKqYElxE/SK0bWkNu17txJ4cPhvNUTQsq9jbbyCcPqZSANbx5P8GVexmzBpcqP2e0HGtdTQLI/xoAGasnyc4hb3yrGMAPDuw3YINQ8pt+n3z0az1Fx6PwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKRyN7DX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A347C4CED1;
	Fri,  7 Feb 2025 16:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738944383;
	bh=HnHgKw5S43ISE7VAWcFFXSGNAVbgSBW92k7zYjpnP+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKRyN7DXTTFGL2kajCIA3dkNOWGDeGB1cTDOn7RTq96CkOiMw9/nBJFQmyzjwgQX9
	 BQ1zs7UdI0G+aitry/eU23E0tzlNe4zbUy1SOYF3iOo0Vb6ecfgymKljJ0feHTpk2j
	 1OZVyuU3Ty7S3YMjSPGxFrA/8Kfjrl1xsykooUKzFOC2y7RmTQZC+ml/Z+QxrkJ3Ex
	 jgFqzZ4sKikPY5jSve7yyqpcdfYiuvDey3QdKKstyme5vfTa0AZNL1H7E+Hc+v4QVG
	 CMd5LT/EBiFvvkac1DgN0OJLrhdqYqaZP2Mu5hH99y3kYjb1eFGFk2s3dfEkY9QlLZ
	 rH3uRlY5Mi3Vw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tgQsC-000000004Uq-21Bm;
	Fri, 07 Feb 2025 17:06:32 +0100
Date: Fri, 7 Feb 2025 17:06:32 +0100
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
Message-ID: <Z6YviAFD4Az3EIBa@hovoldconsulting.com>
References: <12619233.O9o76ZdvQC@rjwysocki.net>
 <1c2433d4-7e0f-4395-b841-b8eac7c25651@nvidia.com>
 <Z6YPpbRF_U0TxAbf@hovoldconsulting.com>
 <Z6YcjFBWAVVVANf2@hovoldconsulting.com>
 <CAJZ5v0iHjkfoh2A+hAmMCTG9_nBcJrsRYFD0Hp4ZChYUo7bFEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iHjkfoh2A+hAmMCTG9_nBcJrsRYFD0Hp4ZChYUo7bFEg@mail.gmail.com>

On Fri, Feb 07, 2025 at 04:41:18PM +0100, Rafael J. Wysocki wrote:
> On Fri, Feb 7, 2025 at 3:45 PM Johan Hovold <johan@kernel.org> wrote:
> > On Fri, Feb 07, 2025 at 02:50:29PM +0100, Johan Hovold wrote:

> > Ok, so the driver data is never set and runtime PM is never enabled for
> > this simple bus device, which uses pm_runtime_force_suspend() for system
> > sleep.
> 
> This is kind of confusing.  Why use pm_runtime_force_suspend() if
> runtime PM is never enabled and cannot really work?

It's only done for some buses that this driver handles. The driver is
buggy; I'm preparing a fix for it regardless of the correctness of the
commit that now triggered this.

Johan

