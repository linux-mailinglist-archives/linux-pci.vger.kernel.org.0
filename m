Return-Path: <linux-pci+bounces-6077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC28A00EC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 21:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B1D2888BB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A16181338;
	Wed, 10 Apr 2024 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFA0wVkx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BD8180A96;
	Wed, 10 Apr 2024 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712779084; cv=none; b=AtQLifyGseFqat2b+HVqYNSXP08cwFUI+p9xjmcLDHSu6Dnyx6xwVEUgkFHxMLwNtVRnHG7hwu/v+5aSWahRabFd8Y8WX5CjwAM0O8wUTAOtA8KOMAnsdx329vobpiOv1fYiWzHOxXLSMBfaxQdGHYe+C7VXCjr5AH47GBWrH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712779084; c=relaxed/simple;
	bh=ONsD2dbNZGTkJd+o8iTpgBT1Mqv/PMMKwKuVtj4bf84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYlDP804hw383XtueLLz5sByTlDuLDwffBYlDdmXWFKslCNjqyiIZLKkj8s1kGXvI1DkEhLLAgdlujs7g3kCb75ujPpoYn4CIWmedo64m0c18y0Yo7oMU4QI6OS4nkV3zoaIJKRqx6A57flh+Cg14nSxKwK7kC/kP6M5CYfDGmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFA0wVkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF83C433F1;
	Wed, 10 Apr 2024 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712779084;
	bh=ONsD2dbNZGTkJd+o8iTpgBT1Mqv/PMMKwKuVtj4bf84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rFA0wVkxwJbwwiRVNgAFbRsk/zAgG34g15gVMeQWYv/gBIKyVPqmCHaLAjRod0D9Y
	 +mgbLx/MbYbuZgwTLONOdrUBIPfJBMDqsRqDAaInm4eqlKz1yapF+Rwc/1WBSFFukH
	 xcLtGka6tTqfczZIq4BSCfgkSh6eqhYJwyHhU5sgcwY50C5U5IYchAg0gIYWsxHDFd
	 W2uiehrAOHIYzj2p7R1sKDcIdlasguxMezz2IO86FhKtE1rY+s3w/mAaT5vRU3w0tw
	 g4EauNSsC1GJ775D+aRkVjMWKnTviCQSJjv5Xbr9t29eU4a3TbWUuzNIVaWASb5vfo
	 S+WxCRQhKIJRg==
Date: Wed, 10 Apr 2024 12:58:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, pabeni@redhat.com, John Fastabend
 <john.fastabend@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrew Lunn <andrew@lunn.ch>, Daniel
 Borkmann <daniel@iogearbox.net>, Edward Cree <ecree.xilinx@gmail.com>,
 netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240410125802.2a1a1aeb@kernel.org>
In-Reply-To: <21c3855b-69e7-44a2-9622-b35f218fecbf@gmail.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
	<20240409135142.692ed5d9@kernel.org>
	<ZhZC1kKMCKRvgIhd@nanopsycho>
	<20240410064611.553c22e9@kernel.org>
	<ZhasUvIMdewdM3KI@nanopsycho>
	<20240410103531.46437def@kernel.org>
	<c0f643ee-2dee-428c-ac5f-2fd59b142c0e@gmail.com>
	<20240410105619.3c19d189@kernel.org>
	<CAKgT0UepNfYJN73J9LRWwAGqQ7YPwQUNTXff3PTN26DpwWix8Q@mail.gmail.com>
	<21c3855b-69e7-44a2-9622-b35f218fecbf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 11:29:57 -0700 Florian Fainelli wrote:
> > If we are going to be trying to come up with some special status maybe
> > it makes sense to have some status in the MAINTAINERS file that would
> > indicate that this driver is exclusive to some organization and not
> > publicly available so any maintenance would have to be proprietary.  
> 
> I like that idea.

+1, also first idea that came to mind but I was too afraid 
of bike shedding to mention it :) Fingers crossed? :)

