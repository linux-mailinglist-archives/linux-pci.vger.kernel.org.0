Return-Path: <linux-pci+bounces-11909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809A0959151
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 01:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352A4283F5C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 23:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95CE1C8FD1;
	Tue, 20 Aug 2024 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrZjgQ9R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D24918C023;
	Tue, 20 Aug 2024 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724197507; cv=none; b=NMdi6dWAm/9fobj08l4Y7VHPkqircTUHVN1cpknJj07TcQvBJP8kXunyxvc9mDGxTx+cCBB4LxtBOkKSy4lLaXqeiMst9sN7qqqhIRKizd8fGds9fb76+rAELXxqY1WzP1iN4ZInOZ54qRtdUZeonZ7e/Z18moUC05g0wuY4jLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724197507; c=relaxed/simple;
	bh=SpJoirkkmSDcZsSbOfsxFos23kDULLjat3l6C9qejSo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=reBdf5RoKKBxvDNYalzLpJ0ZfXxQKWx7ZoJ6sQSIQdTTQhmWZQ2HdJu+JZAXHjSalyS4feHMj60aUdGnjIIIki+5shHCq0KL/J3O1L71uXrFMwtqxHRXUXpaOoETMYoC/eJetvrNd5UbR+lTZ7vLEM0/N3wZaF3sX+mg3NJtZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrZjgQ9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78263C4AF1B;
	Tue, 20 Aug 2024 23:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724197506;
	bh=SpJoirkkmSDcZsSbOfsxFos23kDULLjat3l6C9qejSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jrZjgQ9RK+LxQK2xDIPZEMamp3KWKa0EF4kLONoUo7pg15OWZxSyRHR+KDGf1E5Mf
	 7FmITa6sUh1lz5vYSCxcRuZoJ3d6KY1XP6dNl+kwX4PCCVhQySqXOX/NclVTeY0Fa0
	 af3UalFYU3iYg6Bd4nYVEtaG0889wevvcxsxook3lBF/84NWWTEkKobDonPkppzJHq
	 PjgZygJqvv7CWLW/H91SGBL5qg5DjmuYtB+DsvwsNWSvP6eavlA8a8KIV0RXxn4kxx
	 yEAXm1MCwQG64rSuT5PsW+GRSk1cdrrizSc5kdyR99Kr74bRmwwyNJxcfU2Eq75vYq
	 4L+PT4YbOT5sQ==
Date: Tue, 20 Aug 2024 18:45:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Oliver Neukum <oneukum@suse.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <20240820234504.GA231828@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820060008.jbghpqibbohbemfz@thinkpad>

On Tue, Aug 20, 2024 at 11:30:08AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Aug 19, 2024 at 02:44:43PM +0200, Oliver Neukum wrote:
> > On 02.08.24 07:55, Manivannan Sadhasivam via B4 Relay wrote:
> > 
> > > --- a/drivers/pci/pci-acpi.c
> > > +++ b/drivers/pci/pci-acpi.c
> > > @@ -1434,7 +1434,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> > >   	 * reason is that the bridge may have additional methods such as
> > >   	 * _DSW that need to be called.
> > >   	 */
> > > -	if (pci_dev->bridge_d3_allowed)
> > > +	if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_allowed)
> > 
> > Are you sure you want to require both capabilities here?
> 
> Wakeup is common for both D3Hot and D3Cold, isn't it?

From a spec point of view, moving device from D3hot to D0 is a config
space write that the OS knows how to do, but moving a device from
D3cold to D0 requires some platform-specific magic.  If that's what
you mean by wakeup, they don't look common to me.

Bjorn

