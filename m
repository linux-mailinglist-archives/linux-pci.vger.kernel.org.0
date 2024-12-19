Return-Path: <linux-pci+bounces-18755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4209F75F0
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 08:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55BE5169976
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 07:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA40217666;
	Thu, 19 Dec 2024 07:41:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1484D155743
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734594102; cv=none; b=Vkohia521BLOg7QMtpxACRvmfJ4CrLoWERo7OziVjDJ0UGdtgCImllyPH2zIra5+SwKVAdFY34erAypGGG3YPMJSkHTTTV5RpwoY1YT0nkdQDT2GlECb7PmsBtxXBbWEbJvPSxG/IuqEUgM+6Bae7iLFMakHLz1jI+0Srhm1kFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734594102; c=relaxed/simple;
	bh=sNYVbAHYpK8sbV26B54xzaBv4AWz0B4HYf2+x+aHhNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlQ/BqGi1vevlauBBdkGEou4c5LniKClkW4mQalKf4bkpy4ZoxAD/BDleW5bxub0jtp6FZ1B96e7Cgx6V4Y4TbUq93q1m4YvabmC5Ad437WHJvITUTVj2nfU3eCvH4MDD0RTefE+0AM4l6l3+15QwzM7ISzU6AazHs6laodnpVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 55E27300011A6;
	Thu, 19 Dec 2024 08:41:30 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4325E2BC2F9; Thu, 19 Dec 2024 08:41:30 +0100 (CET)
Date: Thu, 19 Dec 2024 08:41:30 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Krzysztof Wilczy??ski <kw@linux.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Niklas Schnelle <niks@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH for-linus v3 1/2] PCI: Honor Max Link Speed when
 determining supported speeds
Message-ID: <Z2POKvvGX7HZmqtP@wunner.de>
References: <cover.1734428762.git.lukas@wunner.de>
 <fe03941e3e1cc42fb9bf4395e302bff53ee2198b.1734428762.git.lukas@wunner.de>
 <7bbd48eb-efaf-260f-ad8d-9fe7f2209812@linux.intel.com>
 <20241218234357.GA1444967@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218234357.GA1444967@rocinante>

On Thu, Dec 19, 2024 at 08:43:57AM +0900, Krzysztof Wilczy??ski wrote:
> > > The GENMASK() macro used herein specifies 0 as lowest bit, even though
> > > the Supported Link Speeds Vector ends at bit 1.  This is done on purpose
> > > to avoid a GENMASK(0, 1) macro if Max Link Speed is zero.  That macro
> > > would be invalid as the lowest bit is greater than the highest bit.
> > > Ilpo has witnessed a zero Max Link Speed on Root Complex Integrated
> > > Endpoints in particular, so it does occur in practice.
> > 
> > Thanks for adding this extra information.
> > 
> > I'd also add reference to r6.2 section 7.5.3 which states those registers 
> > are required for RPs, Switch Ports, Bridges, and Endpoints _that are not 
> > RCiEPs_. My reading is that implies they're not required from RCiEPs.
> 
> Let me know how you would like to update the commit message.  I will do it
> directly on the branch.

FWIW, I edited the commit message like this on my local branch:

-Endpoints in particular, so it does occur in practice.
+Endpoints in particular, so it does occur in practice.  (The Link
+Capabilities Register is optional on RCiEPs per PCIe r6.2 sec 7.5.3.)

In other words, I just added the sentence in parentheses.
But maybe Ilpo has another wording preference... :)

Thanks,

Lukas

