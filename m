Return-Path: <linux-pci+bounces-19927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5206FA12DAA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 22:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F28165FD7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 21:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A221DB37C;
	Wed, 15 Jan 2025 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blB/0psP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC01DB36B;
	Wed, 15 Jan 2025 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976503; cv=none; b=HRtKx+WhvPZW/hc92N5MgNKuOynPwSidIhOmI09or9mZjF4VZnM4W7NS5bC2TT4w15sLbf4oTLf1JWuT9ukLqT8o5M/wXYlsy8AC4dq7HscGuRbCAPfip8CZ/WyUQCeH+OFheuLhw72f/cOXdvOxMxMuA7GJ+kNKpiKEDSwNCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976503; c=relaxed/simple;
	bh=22RyPLAABDkaQ8iAW6+AARNuCYhOIeSUs5QM9SRroco=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AR3vqz26qUBEhJwMnfp5oJ1Ycw2lnFuxb7Dc5FdqTwZHHT2Qd6rLCAvXtu0scbFw5DgHsLYaC45JvFH42I51iP/7odr3zHDgV9ICwVPUfUZOYKx9f4mzyBCd52dt0IV3xz6NIiFFwqe+pE1iP49rezzTMQ9Zm91AbDVGku6gkcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blB/0psP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B604C4CEE1;
	Wed, 15 Jan 2025 21:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736976503;
	bh=22RyPLAABDkaQ8iAW6+AARNuCYhOIeSUs5QM9SRroco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=blB/0psPD4UKqG8ceyhxet/soxDMbNY/3xdHd5BT9CvK1AWGAvxg4AZda8tLypc9f
	 hKdopbMVHtUjioh6u/4HRLG5I6cySKuJXmE3RhRxWQlvQ8zsvqDi+bf0k4DQ06sPHa
	 5+z1ZDoOLfT6oGzKAM9OXhHH2d+iMfno0BgIJD9JcAyrjKHx3qf/I4RYS4L0IbI+ma
	 mAMDjDWo28jgpXO9vc8xeI7TUgV2iMpVE0Bbdjy+ToRtNleO7fYdUaU+4B7zuJW2sB
	 jZtSjzctD0mT89LU4U58AS8e3x303zNzaF4iXm5kMWeJ0YfPVGs3+FXbmNTqWnYn4W
	 ct4Ixiz0VLh7g==
Date: Wed, 15 Jan 2025 15:28:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 3/4] PCI: of: Simplify
 devm_of_pci_get_host_bridge_resources() interface
Message-ID: <20250115212821.GA555572@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ebc17a9-9065-4488-be3b-7534ab442c22@linux.intel.com>

On Tue, Jan 14, 2025 at 04:21:15PM -0800, Sathyanarayanan Kuppuswamy wrote:
> On 1/13/25 3:15 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Previously pci_parse_request_of_pci_ranges() supplied the default bus range
> > to devm_of_pci_get_host_bridge_resources(), but that function is static and
> > has no other callers, so there's no reason to complicate its interface by
> > passing the default bus range.
> > 
> > Drop the busno and bus_max parameters and use 0x0 and 0xff directly in
> > devm_of_pci_get_host_bridge_resources().

> >   	} else {
> > -		if (bus_range->end > bus_range->start + bus_max)
> > -			bus_range->end = bus_range->start + bus_max;
> > +		if (bus_range->end > 0xff) {
> > +			dev_info(dev, "  Invalid end bus number in %pR, defaulting to 0xff\n",
> > +				 bus_range);
> 
> Use dev_warn() ? I noticed that dev_info() is used in place of
> warning/errors in this file.

Good point, changed.

> Probably it needs to be cleaned?
> 
> > +			bus_range->end = 0xff;

