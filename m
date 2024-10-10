Return-Path: <linux-pci+bounces-14228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DCA999255
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 21:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536F7283BA6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 19:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96D21C9ECA;
	Thu, 10 Oct 2024 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmouf5pn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070C193407;
	Thu, 10 Oct 2024 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588596; cv=none; b=t/6LYwqm8H7TgFN5j7RKiyDfLRYDVe1PVJ49Pngszwff69EW3t8PHQP+SGiiRiiv++emKOqjqlDVdTruxsX/fPn1823Nyr+Zc7OSeCmxZlOkxiq0fwIV7SnvydXYfXs7dsPpHP6J+Ok29jJjQgGpOcmZxwY70ch0AKIz0MVP8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588596; c=relaxed/simple;
	bh=3N4bxKzSTM3E1Kdx3WcG7suWB9kIbX8x8GXD+Ekm3iw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ULMjhJaOI7Hd3Pz8+rRbqgcLX/3LjP2Q8k+8oNzz+PNnpBm4JwUX4mx3tk8qDWmOtcep/5VDcuagCoP8q7S2AN2oEEYrOsgYhDxjJIlV7R8VYkJZCLfl1UmxlOHJAjSITrWM4xJ/Ku5w1Yft+vSeDFqDq5qy8HGSswAx0sI0keM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmouf5pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117BFC4CEC5;
	Thu, 10 Oct 2024 19:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728588596;
	bh=3N4bxKzSTM3E1Kdx3WcG7suWB9kIbX8x8GXD+Ekm3iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hmouf5pnhxyKs39WdW/IYFRGG/mYgpHAmqDLDRVelBCK8S7ZOhNoWC7ZUWxWnWCtz
	 AA4n7lRqY3Dv3tvOa6HHkEh5r+hXYG9MH7A9mxtA8bLVw3jQSMusPwNvHhHlEkPIRq
	 dN8vDF3Strw0X/vEJr0rf7nOC8WwbUFw7Rui+hpFsop/kaGIiRPts0zKTVzr4iM8eq
	 hbQhaXUkBzzr+2gBImZQvbbc4kDRiSWC2VP5s8Plwwp9esc6KUFimmijjzRRc7bedH
	 Yb3BSpCQ9N8s/WDiutfYACb+kO0YhKXX1kktLAXpPYcNDaN4aeDZpSGdvN1uLbODqQ
	 qB+5PADCrrG+w==
Date: Thu, 10 Oct 2024 14:29:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tony Hutter <hutter2@llnl.gov>
Cc: Lukas Wunner <lukas@wunner.de>, mariusz.tkaczyk@linux.intel.com,
	minyard@acm.org, linux-pci@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Introduce Cray ClusterStor E1000 NVMe slot LED
 driver
Message-ID: <20241010192954.GA574548@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5beda7c3-e5fa-4105-aefd-9d91fad6d967@llnl.gov>

On Thu, Oct 10, 2024 at 11:53:42AM -0700, Tony Hutter wrote:
> > I don't quite understand what the E1000 is and where this code
> > runs.  Since you have a DMI check for DMI_PRODUCT_NAME "VSSEP1EC",
> > I assume E1000 is an attached storage controller, and this driver
> > is part of an embedded OS running inside the E1000 itself, *not*
> > on the system to which the E1000 is attached?
> 
> You can think of an E1000 as a standard rack mount storage server
> with 24 NVMe slots.  They are often used as Lustre servers.  The DMI
> check makes sure the E1000 LED driver can only be loaded on E1000
> boards.  The driver is running on the main system (where Lustre
> runs) rather than a embedded storage controller. The driver does
> communicate with a embedded controller via IPMI to control the LEDs
> though.
> 
> I'm currently on baby bonding leave, but I'll try to implement your
> review comments into a version 3 patch once I get back into the
> office.

Congratulations!  Hope your family is all doing well!

Bjorn

