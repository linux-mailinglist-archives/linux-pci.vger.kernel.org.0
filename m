Return-Path: <linux-pci+bounces-36167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C61BB57EEB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 16:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEFA161AFE
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D262FFDF7;
	Mon, 15 Sep 2025 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aznarjCN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593A527461;
	Mon, 15 Sep 2025 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946539; cv=none; b=NeH8X6BRC2eBbx6QhefB4GHAypxWIBpPyK48TeDogntTEGjP8ME9QIgeWSR77Fdg1nrSVySkkHHCa0YjpW0A82u1eSIMyKrwkP1O9J+WnMXYGE9v2wiZ+D7C4UKoMyn7p1uTf853x0m1/CELM3GQ1sk9PX+B+vKxrgv+1d1fH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946539; c=relaxed/simple;
	bh=EgT9R2R8e3sTbKbdhG6OlsOC7QwWtgWnokLPG63/BcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flqPdDYwN98/VJqT6p8osn8wuZ1mn+H12grXWKPzvAWLDarnmpdjoQ4xrpkAyh33lefHy5vmVlZkrfIKKoTnEqUtXMBoGnidFOPMEumAZRkXqrtMyPO2C5mC/ZzzvV+YLkmr0OdxGo0pD4xfQxkVO5mXWKvzhWbtAaGrF4HjIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aznarjCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF433C4CEF1;
	Mon, 15 Sep 2025 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757946539;
	bh=EgT9R2R8e3sTbKbdhG6OlsOC7QwWtgWnokLPG63/BcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aznarjCNixBG85m590SUihDdfWa3aml66JIxssJCi1LS+zwWHzg4FUlLyAnalqQMm
	 NYwjREyVizZcptqaeHgaoI0/dACOCJgfWNOAFYWxlAWXOS3tvO8BMu2N3TZjf8scj2
	 s8El3SQdJgBupfAkZ02UFtFSz1mhar3XApoC3XOs/yhZ7b+4cDcd4nTyTvPl5OtdFa
	 B24UwbhD/wWgi1n/at6q9z0Y8R1YsQ+oEtunaFcdOJiRYE7LVFbxsPC9m38XTKlN2N
	 zI+ECKNOSFqumzris7wjTHnEywtuTelu+ex06D65ZPT0cQkNuB+x1YznABHvVJtHgf
	 vOfIvMomdnfug==
Date: Mon, 15 Sep 2025 08:28:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kw@linux.com>
Cc: Matthew Wood <thepacketgeek@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <aMgiqJVWTptU6Fq0@kbusch-mbp>
References: <20250821232239.599523-1-thepacketgeek@gmail.com>
 <20250821232239.599523-2-thepacketgeek@gmail.com>
 <aK9e_Un3fWMWDIzD@kbusch-mbp>
 <20250913061720.GA1992308@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250913061720.GA1992308@rocinante>

On Sat, Sep 13, 2025 at 03:17:20PM +0900, Krzysztof Wilczy´nski wrote:
> Who needs this?  Why is this useful?  Why hasn't there been a need for
> exposing serial number in past decades,

I can't speak for other reviewers for their interest in having such an
attribute. Matt provided the reasoning here in the cover letter by
making it possible to access from unpriviledged applications that are
managing devices assigned to them without jumping through hoops to get
that information.

> and suddenly we need it so desperately?

"desperately" is a bit of a stretch. This simple patch has been out for
many months now, missed 2 merge windows with zero negative feedback, and
we're about to miss a 3rd. At this point, "frustration" would be a
better description.
 
> We probably wouldn't want to add this if there is only a single user that
> needs this, 

There's multiple reviewers representing different companies.

> especially give that userspace tools like lspci already expose
> this when someone needs it.

Only if you're root. This new attribute is admin-only by default too,
but can be changed as needed.

> Also, we were reluctant to expose some types of information, like serial
> numbers and such, via the VPD recently, so why exposing any serial numbers
> via sysfs would be any different?

It's a specification defined attribute of a device, and sysfs is the
interface that exports device attributes.

