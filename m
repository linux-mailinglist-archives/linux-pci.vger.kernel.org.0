Return-Path: <linux-pci+bounces-5740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB7C898E9C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 21:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9292818B2
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 19:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1843132C15;
	Thu,  4 Apr 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWm9a7UG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C742C13281A;
	Thu,  4 Apr 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257519; cv=none; b=atPLfvWh6eADGuBSsBWSem3BrtdiwoltFcz7DXBtQPWHLa8hwmyAr0X7DtqvX+Tjmx+AhbCaWnz0CSbbRzQI1gpFcwR8wkl4j5CMKsvvIT8J1q0CRH+h+YwM92b5ajq32ujEMJoUFIr1xByODw1g6muncOLGT/4GSaSEi0uPX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257519; c=relaxed/simple;
	bh=KGp40LrbcNKw0qSOzQOETPv7v9G01+pHwMF09MGhAfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDb2vDESgPJWNZJblBWqs73faWRVKzwOmmsuSF9t0tUAHQUsAOfFRHPVTihJ2/9oyiSXZ1pgmorCbOkS2/Q+e07jAh5sujUCV2oDkmc0982Wx0vAEPFYotR2oOsqbZMPmbKKCiaCuB9sh7vjy+w+HsrnpsFos5Ehu/jxL7uJfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWm9a7UG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B986C433F1;
	Thu,  4 Apr 2024 19:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712257519;
	bh=KGp40LrbcNKw0qSOzQOETPv7v9G01+pHwMF09MGhAfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWm9a7UGjgyFQtMbsy+MWiHjpfm8YK8lAQbWLdSYJ82EN3gmz+z6zSE1m/0FM5nz6
	 nLpvcuyNuGB6fehe1B3YJtqYWhE9BVltGSFJ3XqffTQUN/B0kJ03fwuAeh8Z4sUBeS
	 Wp1FwG8u7hxYlmET+n48c5SnjL4dgyZtltsSjrpUZURcVwdQma3YJOgnCYN9cum15w
	 S44EGvuwWrs4KBo3hDW4q1XqxAc528qDWgH7LBCvBEKrElZOq84VsI0mrOHjYGfXrj
	 Tcw8ywaya+y01c5eQKClbW+xRgRG8ZHyrMaQGirbVtNizIFEjl03d4r+eTnEHL+GLj
	 GaIyCN4gModyQ==
Date: Thu, 4 Apr 2024 22:05:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240404190515.GY11187@unreal>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho>
 <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho>
 <20204f34-eae6-47cd-bac3-540a577595e1@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20204f34-eae6-47cd-bac3-540a577595e1@lunn.ch>

On Thu, Apr 04, 2024 at 08:35:18PM +0200, Andrew Lunn wrote:
> > OCP, ehm, lets say I have my reservations...
> > Okay, what motivation would anyne have to touch the fw of a hardware
> > running inside Meta datacenter only? Does not make any sense.
> > 
> > I'd say come again when your HW is not limited to Meta datacenter.
> > For the record and FWIW, I NACK this.
> 
> Is ENA used outside of Amazon data centres?

At least this driver is needed when you use cloud instance in Amazon
and want install your own kernel/OS.

> 
> Is FUNGIBLE used outside of Microsoft data centres?

Have no idea

> 
> Is gVNIC used outside of Google data centres?

You need this driver too.
https://cloud.google.com/compute/docs/networking/using-gvnic

> 
> I don't actually know, i'm more of an Embedded developer.
> 
>   Andrew
> 
> 

