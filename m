Return-Path: <linux-pci+bounces-12386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D8E963396
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 23:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4EE1F21ABD
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 21:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BCD1AC8AF;
	Wed, 28 Aug 2024 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQzfE7wK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002D1AC89F;
	Wed, 28 Aug 2024 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879228; cv=none; b=JHI+BfHMBUlp7pBQA4vsfQBLf77nA6zu0daccyPA7G5Eyz2w9W7HSELTfKLGqnt6NnI34VWc3+BLm4GqF/LHFcw67lno08xD31c1SOoJnlo2xVZGSHAcfVM7pk3gZtIjXBCvwoaMk/lDcVVRqviUzY6cDnNxSBSeSy7HKfgnVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879228; c=relaxed/simple;
	bh=Zy4IKvv7xF6dTECNeMe16McFo8bvNj3UO1dSrfkGpoU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HWEzwWymf9DVFSldEKkfNU5+cNjXE4k4fetGDhHxGUE9O6UljQFFSt84xkQdgR0DIHnZkqPpbjRxnxv2Dbc5Ri0/IF2D5FeE5LuMTQoh/V+82Z6FUlL3XdCFOhOxK8mWdsT22Zb02kuEQpmcb6t2wMKzCPcPWkCAGLV2UK71MD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQzfE7wK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C12C4CEC0;
	Wed, 28 Aug 2024 21:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724879227;
	bh=Zy4IKvv7xF6dTECNeMe16McFo8bvNj3UO1dSrfkGpoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bQzfE7wK3MdnBD0K0WywH6SwP9+GjOi/m84ItNDzW840f0jTx0V/pmj6AatEUOmlu
	 0RmqoENdx576D2hqRsKbRweoBYFLMGLO0RsNr9jmBoQm5vIBKAOPIM8MRM57gAKpiL
	 nvN0rGlCgDQWgc7zeFUhvqEy7nU47iWDXMUFiWqjmpArOGdQnl9OyikJwYhWBQ8sX9
	 LlvcqYOFJ/4b37l2rhORYvHQ6RWZxdLariDTyujsj4mxsPdAdediDRqXeXbdPeyxij
	 aFUHdHJcHdz6z2gDlk37YEU6moXDyn+730CLI1Kh0CYTXHyAY2ngQvcUI79JVLzQH4
	 gRNH6FZZBi6pQ==
Date: Wed, 28 Aug 2024 16:07:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <20240828210705.GA37859@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828155217.jccpmcgvizqomj4x@thinkpad>

On Wed, Aug 28, 2024 at 09:22:17PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Aug 20, 2024 at 08:45:59PM -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 02, 2024 at 11:25:02AM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > Currently, there is no proper distinction between D3Hot and D3Cold while
> > > handling the power management for PCI bridges. For instance,
> > > pci_bridge_d3_allowed() API decides whether it is allowed to put the
> > > bridge in D3, but it doesn't explicitly specify whether D3Hot or D3Cold
> > > is allowed in a scenario. This often leads to confusion and may be prone
> > > to errors.
> > > 
> > > So let's split the D3Hot and D3Cold handling where possible. The current
> > > pci_bridge_d3_allowed() API is now split into pci_bridge_d3hot_allowed()
> > > and pci_bridge_d3cold_allowed() APIs and used in relevant places.
> > 
> > s/So let's split/Split/
> > 
> > > Also, pci_bridge_d3_update() API is now renamed to
> > > pci_bridge_d3cold_update() since it was only used to check the possibility
> > > of D3Cold.
> > > 
> > > Note that it is assumed that only D3Hot needs to be checked while
> > > transitioning the bridge during runtime PM and D3Cold in other places. In
> > > the ACPI case, wakeup is now only enabled if both D3Hot and D3Cold are
> > > allowed for the bridge.
> > > 
> > > Still, there are places where just 'd3' is used opaquely, but those are
> > > hard to distinguish, hence left for future cleanups.
> > 
> > The spec does use "D3Hot/D3Cold" (with Hot/Cold capitalized and
> > subscripted), but most Linux doc and comments use "D3hot" and
> > "D3cold", so I think we should stick with the Linux convention (it's
> > not 100%, but it's a pretty big majority).
> > 
> > > -	if (pci_dev->bridge_d3_allowed)
> > > +	if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_allowed)
> > 
> > Much of this patch is renames that could be easily reviewed.  But
> > there are a few things like this that are not simple renames.  Can you
> > split out these non-rename things to their own patch(es) with their
> > own explanations?
> 
> I can, but I do not want these cleanups/refactoring to delay merging
> the patch 4. Are you OK if I just send it standalone and work on the
> refactoring as a separate series?

You mean to send patch 4/4 standalone, and do the rest separately?
That sounds reasonable to me.

