Return-Path: <linux-pci+bounces-5749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7720A898F90
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 22:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1732CB22B6E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 20:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2780F137774;
	Thu,  4 Apr 2024 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHy5Jdi5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00720135A5D;
	Thu,  4 Apr 2024 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262350; cv=none; b=qLEl2xqbXDIwxxG5j7TvDMhawzMFfRluHV7UP3y7YH2rqp8A/XpOtu5ScvyoIEcsiyUWdyupIQHXYLsg0pmhhxYMwmiBseu8kBtI4yJE5eTzPouU8QkD1B0RYz/AHzltsLDkiiMsA+4nVzgXGkQ3hZRIr5bNjUuHLf7+VIocyyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262350; c=relaxed/simple;
	bh=ciiSIq7gaRxYmr5OtFASzeoMibqUc9h5nfKc40e7Zmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuXAGJXUkM75K8peN2eoknUoUV5IKXESweXC4rikbOs/TxMvs67E886H0tVeZ0gvrCYXNSqIVB9Y6TwfaiVd+d/fyagMAlqJUZJ6pxUMu8zWIyEc+p65riYmoFVz7XcHVsMAjVfB5dDtBMm2f6/zHi3elWvmpY1slJ4A6giCQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHy5Jdi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254FEC433C7;
	Thu,  4 Apr 2024 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712262349;
	bh=ciiSIq7gaRxYmr5OtFASzeoMibqUc9h5nfKc40e7Zmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jHy5Jdi5F/In2qkz+/6LPmdLPPNHpQtpxlH2EGWdPyAaimnaL+/b1dprCOKMl+uea
	 cJt4wfJZQZgg8WHIim9NCGA6ZgKjTtTPkQCsY0D0ClFUegZg7YZcP6rxugxlYHKJKD
	 yXg0K5itDe+SrfL/EN+HbXPYC14RVmJmiXzjXyBeZd4tCC+BFU0yfO1pYxa+leeXhm
	 eywNzclWRG5rj6Avk1bDtSU03+YjRdzz9DGIcwGQQljTR8UuSwgxJd82L30p1bNLgE
	 ZuzWS6iQCTNsgdGUYOEtmalhZEG0ej1E9urrvQLoZyeskwtQBkcryFXvbTFl7DhDZO
	 j+T5YOxvHCiZw==
Date: Thu, 4 Apr 2024 13:25:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, Alexander Duyck
 <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240404132548.3229f6c8@kernel.org>
In-Reply-To: <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
	<Zg6Q8Re0TlkDkrkr@nanopsycho>
	<CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
	<Zg7JDL2WOaIf3dxI@nanopsycho>
	<CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 12:22:02 -0700 Alexander Duyck wrote:
> The argument itself doesn't really hold water. The fact is the Meta
> data centers are not an insignificant consumer of Linux, 

customer or beneficiary ?

> so it isn't as if the driver isn't going to be used. This implies
> some lack of good faith from Meta.

"Good faith" is not a sufficient foundation for a community consisting
of volunteers, and commercial entities (with the xz debacle maybe even
less today than it was a month ago). As a maintainer I really don't want
to be in position of judging the "good faith" of corporate actors.

> I don't understand that as we are
> contributing across multiple areas in the kernel including networking
> and ebpf. Is Meta expected to start pulling time from our upstream
> maintainers to have them update out-of-tree kernel modules since the
> community isn't willing to let us maintain it in the kernel? Is the
> message that the kernel is expected to get value from Meta, but that
> value is not meant to be reciprocated? Would you really rather have
> us start maintaining our own internal kernel with our own
> "proprietary goodness", and ask other NIC vendors to have to maintain
> their drivers against yet another kernel if they want to be used in
> our data centers?

Please allow the community to make rational choices in the interest of
the project and more importantly the interest of its broader user base.

Google would also claim "good faith" -- undoubtedly is supports 
the kernel, and lets some of its best engineers contribute.
Did that make them stop trying to build Fuchsia? The "good faith" of
companies operates with the limits of margin of error of they consider
rational and beneficial.

I don't want to put my thumb on the scale (yet?), but (with my
maintainer hat on) please don't use the "Meta is good" argument, because
someone will send a similar driver from a less involved company later on
and we'll be accused of playing favorites :( Plus companies can change
their approach to open source from "inclusive" to "extractive" 
(to borrow the economic terminology) rather quickly.

