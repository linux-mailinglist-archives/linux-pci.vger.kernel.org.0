Return-Path: <linux-pci+bounces-32357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1CEB0859D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 08:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFBD1A60F3D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 06:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E7F21883F;
	Thu, 17 Jul 2025 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/KxkQwk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0BA1D7E5B;
	Thu, 17 Jul 2025 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735476; cv=none; b=mVCEEaMOq50PWgDHOsAJdNsaVaiw9Udg2tHrB4jKJyGCW9ZWYJYJRl4OpLJcAizr5qsIneV6pqwJ6OWrRN2lUj15iqykR2zzXlnbw9yo99CrSodEzrNm/Ak/6xrcGiJxxwujZwE+6M8xqIH91gDhYXdXowv9W4nsLlBdlblppXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735476; c=relaxed/simple;
	bh=M6MVNljG/4vFW8R1A1eKvJO8ARdcM9cOzfnSvpASuO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgZZDfx3EB5tiXg5t8BSTPAJIh3jrwUgulz/JYxZegyeblPNVcDUt8IplVc2lz4XE8ye9gAFmsDT5wwWnLUqoPz0G9j27DcFf1A70REh59iTXD64dBMdGoPNPmVVBGd2l1VoiXXdt4GDy4keIynq44f5yqIRBbEZXANlb1znN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/KxkQwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DABC4CEE3;
	Thu, 17 Jul 2025 06:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752735475;
	bh=M6MVNljG/4vFW8R1A1eKvJO8ARdcM9cOzfnSvpASuO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/KxkQwk2gmXoU5gQ3jBbhL5udD+7TdhJ3ZUPyiutmZSbl4AjQuuJJhOwBdSPE38I
	 ejixaq0jZPNLFcmqsRJjS9QeONHJHR6V8+A5UpwmOUMkbVYVw0RjtYlCreF0x3ICaf
	 2voju0eG8aWO4JIaAUcxeYgPJLaf03AbNyCsjcBH/1GDd7phcnGcWRDl4bi3axbXt0
	 AkzddWcQdie3VVYVE+mWwxC0MANJnWtBrThezD+Oosq/9IYZzkJTwXVK+cUvPhf6KU
	 Bh5r1T3mZoGEY31AtJm7xpjnJJpzp5dbXQq0JLK4WtqUn0LxvfxHEDBGYOLZLqr/KS
	 8197yR/rq3PAw==
Date: Thu, 17 Jul 2025 12:27:47 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Kenneth R. Crudup" <kenny@panix.com>
Cc: "David E. Box" <david.e.box@linux.intel.com>, rafael@kernel.org, 
	bhelgaas@google.com, vicamo.yang@canonical.com, ilpo.jarvinen@linux.intel.com, 
	nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] PCI/ASPM: Allow controller-defined default link state
Message-ID: <l2rk6omhgysf55ee227ju2z5zyen6mksyl3lu37jwfabg45j3w@4cf7wxehxhv6>
References: <20250717004034.2998443-1-david.e.box@linux.intel.com>
 <7a229e18-fbfd-8652-ec2e-a3a3273f7fac@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a229e18-fbfd-8652-ec2e-a3a3273f7fac@panix.com>

On Wed, Jul 16, 2025 at 11:12:45PM GMT, Kenneth R. Crudup wrote:
> 
> Unfortunately, having tested the patch (against Linus' master), it doesn't work.
> 
> I don't think the ASPM(?) state is making it to the VMD.
> 

Because, the VMD driver is not at all setting the PCI_BUS_FLAGS_NO_ASPM_DEFAULT
flag. But I proposed an alternate method [1] to enable ASPM which would avoid
using the flag.

- Mani

[1] https://lore.kernel.org/linux-pci/4xcwba3d4slmz5gfuwypavxqreobnigzyu4vib6powtbibytyp@mmqcns27vlyr/

> LMK if you need more info.
> 
> -Kenny
> 
> On Wed, 16 Jul 2025, David E. Box wrote:
> 
> > Testing is appreciated as I didn't get a chance to do so yet but plan to.
> 
> > Thanks, David
> >
> > ---
> >
> > David E. Box (2):
> >   PCI/ASPM: Allow drivers to provide ASPM link state via pci_bus
> >   PCI: vmd: Provide default ASPM link state for synthetic hierarchy
> >
> >  drivers/pci/controller/vmd.c |  7 +++++--
> >  drivers/pci/pcie/aspm.c      |  5 ++++-
> >  include/linux/pci.h          | 12 ++++++++----
> >  3 files changed, 17 insertions(+), 7 deletions(-)
> >
> >
> > base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
> >
> 
> -- 
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
> 

-- 
மணிவண்ணன் சதாசிவம்

