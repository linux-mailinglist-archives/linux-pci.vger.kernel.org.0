Return-Path: <linux-pci+bounces-5022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC9E88747B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 22:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B171F21F61
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 21:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012C05820D;
	Fri, 22 Mar 2024 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCtIf4iK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147B53361
	for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711143441; cv=none; b=V00J+qI/w3oedMUY2k8OXn4aK/Q+kufLUFBxhT5cYir/b2KQV8riH2gGrO/7J6gAx9tVtQyrbXns4nMlWMddEQTO1y3v1b9e50tJld60jeWgCy5NpWtiY+u5qXob9HEjjcouF9/dvMtKf7b/VxtKcCKWzDKP5RQs1FNyhI/efcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711143441; c=relaxed/simple;
	bh=Bp0TMupPA8sSC+P8D3Hh48Z9GN1U3o2H2jhGE4SaM24=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jF2kfsx52S0USjQ8fn7aXdynFHdaph72/6F3Rkt1a5lAVNijVCxtJn3T+Y5KuN5ixp1kCBG5NmqB6VXjhQY/OIQnwESrGK0cxCbSpZ7UUCw3O+cDiWFc/JiBey0GHSbBwxTps54C75UlpIqqXkG38Bkqa6QHgEeT7W3XBIKqezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCtIf4iK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312D4C433C7;
	Fri, 22 Mar 2024 21:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711143441;
	bh=Bp0TMupPA8sSC+P8D3Hh48Z9GN1U3o2H2jhGE4SaM24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aCtIf4iKE5xHG+PBqtqvpW8yuKFNIHt2jkb3AKm32WLEFQ73Ef58n+hTuvRJSbLkL
	 D992bTaw5JpuZp49RD3B57UEB3oiPPG1fhMP3aSJfhBtEKcC00VCd1Tjtuq8CV/NY0
	 /zxuH9pZsLS4xOHW01dsNouZfDg+gcRaMUna/jHGE1+CuzIzL//A98r++qPEp/VL12
	 1/+OyS6bcg8DXB2/w84uhMEIweW5OsYITwaMqSjUiJWs1s2HcdIy38XjO7rHluBVVG
	 e3QBbLWdxpuLnpNSBd7owR9hFTdfjwVYePO8jTmieSygXda3eBvgy5tOdiWYFPS8s0
	 5Jx9jpkcZ3pjg==
Date: Fri, 22 Mar 2024 16:37:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	paul.m.stillwell.jr@intel.com
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20240322213719.GA1376171@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322135700.0000192a@linux.intel.com>

On Fri, Mar 22, 2024 at 01:57:00PM -0700, Nirmal Patel wrote:
> On Fri, 15 Mar 2024 09:29:32 +0800
> Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> ...

> > If there's an official document on intel.com, it can make many things
> > clearer and easier.
> > States what VMD does and what VMD expect OS to do can be really
> > helpful. Basically put what you wrote in an official document.
> 
> Thanks for the suggestion. I can certainly find official VMD
> architecture document and add that required information to
> Documentation/PCI/controller/vmd.rst. Will that be okay?

I'd definitely be interested in whatever you can add to illuminate
these issues.

> I also need your some help/suggestion on following alternate solution.
> We have been looking at VMD HW registers to find some empty registers.
> Cache Line Size register offset OCh is not being used by VMD. This is
> the explanation in PCI spec 5.0 section 7.5.1.1.7:
> "This read-write register is implemented for legacy compatibility
> purposes but has no effect on any PCI Express device behavior."
> Can these registers be used for passing _OSC settings from BIOS to VMD
> OS driver?
> 
> These 8 bits are more than enough for UEFI VMD driver to store all _OSC
> flags and VMD OS driver can read it during OS boot up. This will solve
> all of our issues.

Interesting idea.  I think you'd have to do some work to separate out
the conventional PCI devices, where PCI_CACHE_LINE_SIZE is still
relevant, to make sure nothing breaks.  But I think we overwrite it in
some cases even for PCIe devices where it's pointless, and it would be
nice to clean that up.

Bjorn

