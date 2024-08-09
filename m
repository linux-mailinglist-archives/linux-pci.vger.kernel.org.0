Return-Path: <linux-pci+bounces-11556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B91294D669
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 20:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFA91C21BD2
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 18:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449E015B98F;
	Fri,  9 Aug 2024 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWG6bO48"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D315B57D;
	Fri,  9 Aug 2024 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228863; cv=none; b=IYiVy5UfEqNhXXchKCPCQQSvCbQ1N+eLt2zUNpOi3LUJYIFXIOJkeTjoIXqROn9SjUYhUh0u2bXlMTnGM2hbyaaFbMmLniOk7AhLWiwA9bhcutAKRYWcixnMy3zVakY/HBMjYtwlMRiMDqaFVM988a3DUXV9LOBp57HzZRcM0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228863; c=relaxed/simple;
	bh=XFsaSMmtJk5m0voRT6NHBWymtp8SlyQpKaO27jnyEbU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oE+kAweNsEFKu7J6xXTV32I4giyqiEg31NhkO8bKVRY6BJOOyqd69w1N8oyc4Iqclu4pazIEIi4L2dz3e6uC0Qqf1ETLr+ZZBq/jKydoo4TvH1kFxeB/eBqdxrI/AzH7qQ89oO+vFV+kr+03iI5Mg0UkEVqtuKf14duphPOz5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWG6bO48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396FFC32782;
	Fri,  9 Aug 2024 18:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723228862;
	bh=XFsaSMmtJk5m0voRT6NHBWymtp8SlyQpKaO27jnyEbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LWG6bO48Uxh15h5JOnmNMA5BsT4kdidRfn6G00wQ3EoRMYn/fOReuZfA84avuQqEc
	 ynbbYqtP3J8Y9z1BlUMRH9C2D3OHxTWIaF6y5MITebD5iu94lnDa+iaAZCvFmj88rv
	 yTNv5v6kYlJut5XGwb5D2iFXps6wXP1llP1B2Jc+vSztGdZKnJjGDGGOjOKYitA663
	 QfbrCcLpDnsjpdNJHnpsmYUUHFTeiHMIWTpiR6OljLntJC2mYQkAbCSM0wWWia/7iN
	 MWHOIgNO5KB41qhEDO1vhY0yKwQggUfzWpZMyY8tU7VlxInjBZuyjRdj7GTUjQl8DW
	 9rMRQdCx4j43A==
Date: Fri, 9 Aug 2024 13:41:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Move DMA check into
 read/write/copy functions
Message-ID: <20240809184100.GA205407@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAEEuhp2Cm3ujGB_C3Z7XwQh1whP9BcdT+WOT3w+sa-CK9p3fA@mail.gmail.com>

On Fri, Aug 09, 2024 at 08:56:29AM +0200, Rick Wertenbroek wrote:
> On Tue, Aug 6, 2024 at 9:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Aug 06, 2024 at 06:27:54PM +0200, Rick Wertenbroek wrote:
> > > The test for a DMA transfer was done in pci_epf_test_cmd_handler, which
> > > if not supported would lead to the endpoint function just printing an
> > > error message and waiting for further commands. This would leave the
> >
> > I guess it's the *test* that prints the error message?  Is this the
> > "Cannot transfer data using DMA" message?
> 
> That is the error message, the error message is printed by the
> endpoint function, on the endpoint device. On the host side, nothing
> happens; the test program just hangs because the driver waits
> indefinitely. With the change I proposed, the test program completes
> the test and will display "NOT OKAY" as normal when a test fails.

Thanks for this; something like this would be helpful in the commit
log because it makes the two kernels involved more explicit.

Bjorn

