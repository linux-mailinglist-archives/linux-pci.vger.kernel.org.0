Return-Path: <linux-pci+bounces-36347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2A8B7D3F0
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBD34666DD
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 12:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF86F337EA4;
	Wed, 17 Sep 2025 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpPtQsiU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BED337E8F;
	Wed, 17 Sep 2025 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111382; cv=none; b=Hf4jHZ4oGPFUdEG6EGR8tp8clDYY1SPZ4166pzW/UanoFqTsl9Gf6qB5MD8Vkpf/yPUS5+DljjO2zR4lVK/3vnMzeiOzgsmfOnoX5KOYCHjpfRaeC8nr3kO+NR4X/X1wSRKOGJOA8oWnLqaDoXUyrxfi9utNKoxqdxPb3uPnho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111382; c=relaxed/simple;
	bh=7+CAsNonk8Nvuq2pqG+I7mk5eOKh90lsgNRugbjfWac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbkIvNyHVjAkHS+aPWVlQtJPbaJN/R3ZOiBOTNHJw8FskUDLylOIJpdTEgYNtsTwEKLXam8Re8mEr7iU09yyB4jBnXcV3RsMOsVd9HEsHUEgoNxSM2Q20/eYCyRxtckyRTN3CQomAAFH8w9ake8tHGkDrGNJ4boPJODNNlDG/Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpPtQsiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56369C4CEF0;
	Wed, 17 Sep 2025 12:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111382;
	bh=7+CAsNonk8Nvuq2pqG+I7mk5eOKh90lsgNRugbjfWac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpPtQsiUUD4oCdkjAwQLDWP9PPNnEdMPd9PpKEzR2WhrjEU/ksYeuk51fmiUt+a+n
	 i70WbI5mTHaAke210o9lmej64nTWoKEbAN7ZaucnTP7Hfk/d2NAhpMZtrNNczfFTWM
	 q2yXPJV8d0xzyOASnZ6BfeNHVIX1pj/SMnFQhydiQkqPV1HQxlG2hre537G8KADw1X
	 39drVGx3224uP5W1JzxADPo5Uq0wd1X9cs24MfmvZUp443sFY8D9WHp+85XN3KABBh
	 MbfNM65hFRTQRkt4gV8oUqLMsuxFqWgMygO/bVuRV/Toc0YNsQn604RMUCIesnr350
	 T1kipR768lQow==
Date: Wed, 17 Sep 2025 21:16:20 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Matthew Wood <thepacketgeek@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250917121620.GA792199@rocinante>
References: <20250821232239.599523-2-thepacketgeek@gmail.com>
 <20250915193904.GA1756590@bhelgaas>
 <aMnmTMsUWwTwnlWV@kbusch-mbp>
 <20250917083422.GA1467593@rocinante>
 <20250917104859-6d38cb60-b638-4e5f-bf67-22683a441ae6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917104859-6d38cb60-b638-4e5f-bf67-22683a441ae6@linutronix.de>

Hi Thomas,

> > > It's a waste of resources to provide a handle just to say the capability
> > > doesn't exist when the handle could just not exist instead.
> > 
> > I haven't checked how the kernfs side looks like, admittedly, but I think
> > whether an attribute is visible or not, it does not unload and/or de-allocate
> > any space for the accompanying kernfs object...  So, the resources saving
> > here might not be in any way significant.
> 
> If I read the sysfs code correctly (create_files() in fs/sysfs/group.c),
> the kernfs node should not even be allocated for invisible files.

Good to know!  I wasn't sure and did look...  I stand corrected now.

Thank you for taking the time to check this.  Much appreciated. :)

Thank you!

	Krzysztof

