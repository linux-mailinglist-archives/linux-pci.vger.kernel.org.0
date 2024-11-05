Return-Path: <linux-pci+bounces-16051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C089BD048
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 16:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B861F235F8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8333A1D27B1;
	Tue,  5 Nov 2024 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3kKuKbH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA263BB21;
	Tue,  5 Nov 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820297; cv=none; b=CZK6ivHTLqqIlr4c4cJ+CpkId9GuoCvSDziRqxrdhUYjgE1GeO/RE7smvY2FdDj7vamWlwdqF3MrRsEgFXaPu6FhPM4WJ6mk9rMUcYS7jkDUn4OTHUFz5td3ZrBpS4X7h1pjZ9o6zcQBo3ZnYvR3/m5jRGSxOrX49EwJFMkMfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820297; c=relaxed/simple;
	bh=1iekeL2Za9+ifD3DUVEh/34YJHWRDoMORGZyPsah7qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Dfnho9D6+nkfC5nhUl7sjOQha3eLK0HeLz4Z9LwVoi00eg+10gFidQlfG5sd2BbqMvWOssZ0qbAu/U4EkqzZCNNMrCh0WDn5so8kdumiUKTUJsg0kjRxcj+rTBv7k+SZT3zEwIHeH33a5+sNGjGImWoXNNMXwKIH9E0KLcJUs8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3kKuKbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E41C4CECF;
	Tue,  5 Nov 2024 15:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730820296;
	bh=1iekeL2Za9+ifD3DUVEh/34YJHWRDoMORGZyPsah7qQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=q3kKuKbH7YxY1oQuKykEW6dUwc3kuigmWbpok4ZuDVmWd1t5vS82mD0Z1Tw2388w0
	 BQrw3cIyS6RQp9OV9eFQBYCSvVAhTrYu1Fp2deahiEAHlKOkQcD1KcOrNJDptBGtVv
	 Q8Fdv1jEnqv1ogqPFZGfbfybABpxgVipL4eJZvSmDnHb3VZd/PPCwJU7RxwNLRJ4u8
	 QbaqGTbOrh6AZVKT6uPMGsDs9VlAteni6Eq8tzBzl6uAiBcnrP0KXPYSQXaNwD+x/B
	 85SjevA+we6kUSjRnejOpqrKqap6UkY7CQgc/IGyQ32MnkjwyMGbYprwgHXwOFfFge
	 +D5CqF/RHcHhA==
Date: Tue, 5 Nov 2024 09:24:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Arun Easi <aeasi@marvell.com>, Jonathan Chocron <jonnyc@amazon.com>,
	Bert Kenward <bkenward@solarflare.com>,
	Matt Carlson <mcarlson@broadcom.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Jean Delvare <jdelvare@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Fix read permissions for VPD attributes
Message-ID: <20241105152455.GA1472398@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105075130.GD311159@unreal>

On Tue, Nov 05, 2024 at 09:51:30AM +0200, Leon Romanovsky wrote:
> On Mon, Nov 04, 2024 at 06:10:27PM -0600, Bjorn Helgaas wrote:
> > On Sun, Nov 03, 2024 at 02:33:44PM +0200, Leon Romanovsky wrote:
> > > On Fri, Nov 01, 2024 at 11:47:37AM -0500, Bjorn Helgaas wrote:
> > > > On Fri, Nov 01, 2024 at 04:33:00PM +0200, Leon Romanovsky wrote:
> > > > > On Thu, Oct 31, 2024 at 06:22:52PM -0500, Bjorn Helgaas wrote:
> > > > > > On Tue, Oct 29, 2024 at 07:04:50PM -0500, Bjorn Helgaas wrote:
> > > > > > > On Mon, Oct 28, 2024 at 10:05:33AM +0200, Leon Romanovsky wrote:
> > > > > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > > > > 
> > > > > > > > The Virtual Product Data (VPD) attribute is not
> > > > > > > > readable by regular user without root permissions.
> > > > > > > > Such restriction is not really needed, as data
> > > > > > > > presented in that VPD is not sensitive at all.
> > > > > > > > 
> > > > > > > > This change aligns the permissions of the VPD
> > > > > > > > attribute to be accessible for read by all users,
> > > > > > > > while write being restricted to root only.
> ...

> > What's the use case?  How does an unprivileged user use the VPD
> > information?
> 
> We have to add new field keyword=value in VA section of VPD, which
> will indicate very specific sub-model for devices used as a bridge.
> 
> > I can certainly imagine using VPD for bug reporting, but that
> > would typically involve dmesg, dmidecode, lspci -vv, etc, all of
> > which already require privilege, so it's not clear to me how
> > public VPD info would help in that scenario.
> 
> I'm targeting other scenario - monitoring tool, which doesn't need
> root permissions for reading data. It needs to distinguish between
> NIC sub-models.

Maybe the driver could expose something in sysfs?  Maybe the driver
needs to know the sub-model as well, and reading VPD once in the
driver would make subsequent userspace sysfs reads trivial and fast.

Bjorn

