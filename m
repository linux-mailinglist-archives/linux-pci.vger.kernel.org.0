Return-Path: <linux-pci+bounces-6055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F45589FEAB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4F51C22460
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DBF17BB2F;
	Wed, 10 Apr 2024 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnw+36ra"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE51779B4;
	Wed, 10 Apr 2024 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770533; cv=none; b=tMJYAIatH8OfrRFMPfcH0DsJLwjyV5RKFIPe+EtYfwENkUebxt8qKnCxlPYDpaFRfnYhXF/EhD9grV4jDu6wxr8nc7UGuFTbJ7slf4tbn4QZwYF/LFA+MvrZe1kh4rqPeVk1EKzDJJ6ZfMGPn3GK/081z7ZiUzAElrR03nGY+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770533; c=relaxed/simple;
	bh=7Kgj+FnDCOAeFadMFeTnbWKsHPEUddUSL9aEnFJgj6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7fu8yW/0K5eLW0uomVlajBABJxAIZP1hNIPzS/Y+ILLTUYMrnyMnLx6b7W8gXqF3tMeGN0ez8SaVZI9H+KieEL5RBljvwXRrCES2qB8JmkyygXlsjuo9cI+JSzngwxCOUvrFqINKXcln7XO/fr069JMM9zuxt+HdSQK5Xz0Wiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnw+36ra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303FBC433C7;
	Wed, 10 Apr 2024 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712770532;
	bh=7Kgj+FnDCOAeFadMFeTnbWKsHPEUddUSL9aEnFJgj6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qnw+36raATUEr+UHJR/erciW7EqRUnbyMXmTYJSq43nUOhkNipsOyjJwMlIeSceAT
	 nuk7IzCYHvInrSCIuHRuz5DhIhKjHdYk3q8RgsQv3qq61fzr8ymJIeoRhtvF5JtvU2
	 zQI5rnSUL+XRrgkRVRskG7RqdUjQXQjnDROJF1b5Pa5VTajLuum+ctqDhlB3dzfQ21
	 exYxymeDjTPJl3ziEPPZ6MeXAC3cgfcqMtKMiUb3rCbOSFiMViBJzuoTlSurhpBepe
	 vmdk3aRL1b9I6p6P1WdqSTRN3TZey6NtUrRNt1F42I19mlk63N95Ouc/WN1lo3/fPn
	 xi//PCJhaQNvQ==
Date: Wed, 10 Apr 2024 10:35:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: pabeni@redhat.com, John Fastabend <john.fastabend@gmail.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Borkmann
 <daniel@iogearbox.net>, Edward Cree <ecree.xilinx@gmail.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, Alexander Duyck
 <alexanderduyck@fb.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240410103531.46437def@kernel.org>
In-Reply-To: <ZhasUvIMdewdM3KI@nanopsycho>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
	<20240409135142.692ed5d9@kernel.org>
	<ZhZC1kKMCKRvgIhd@nanopsycho>
	<20240410064611.553c22e9@kernel.org>
	<ZhasUvIMdewdM3KI@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 17:12:18 +0200 Jiri Pirko wrote:
> >> For these kind of unused drivers, I think it would be legit to
> >> disallow any internal/external api changes. Just do that for some
> >> normal driver, then benefit from the changes in the unused driver.  
> >
> >Unused is a bit strong, and we didn't put netdevsim in a special
> >directory. Let's see if more such drivers appear and if there
> >are practical uses for the separation for scripts etc?  
> 
> The practical use I see that the reviewer would spot right away is
> someone pushes a feature implemented in this unused driver only.
> Say it would be a clear mark for a driver of lower category.
> For the person doing API change it would be an indication that he
> does not have that cautious to not to break anything in this driver.
> The driver maintainer should be the one to deal with potential issues.

Hm, we currently group by vendor but the fact it's a private device
is probably more important indeed. For example if Google submits
a driver for a private device it may be confusing what's public
cloud (which I think/hope GVE is) and what's fully private.

So we could categorize by the characteristic rather than vendor:

drivers/net/ethernet/${term}/fbnic/

I'm afraid it may be hard for us to agree on an accurate term, tho.
"Unused" sounds.. odd, we don't keep unused code, "private"
sounds like we granted someone special right not took some away,
maybe "exclusive"? Or "besteffort"? Or "staging" :D  IDK.

> With this clear marking and Documentation to describe it, I think I
> would be ok to let this in, FWIW.

