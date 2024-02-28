Return-Path: <linux-pci+bounces-4198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C18E86B6FB
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 19:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF6E2899A0
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 18:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D396671EA5;
	Wed, 28 Feb 2024 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dxBCPlld"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2154087E;
	Wed, 28 Feb 2024 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144186; cv=none; b=QxMMTERwqoSFiD2Pkv0OlV8uGk/+Ofs2djfgfU4Qf6U9xwU+TWOQ0BP+Uv7AWqH4UJadepGaSzyWe7hD12pos6aGoUQO3eq1Rhj/24RBe5gzmGwsgGALMsU4BdBZrFvLQWNsE81cCul3qZC7Daw+sPrO14ZPyBaM2Ufxaui+eOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144186; c=relaxed/simple;
	bh=YCnamN+ZO/atEuFaycWdvLvU6Yn6mowtfFIBNvZ/r7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngB64s8r2wPDYzh6ppxw5B9c0XGMgohNv2Bs4QT7fHHaQMve6ZGfdMsPjWeHa7peLqT5OL+d/5ksiJ59k3Eysgu2NRNyGgG8n8EGxoc+N4bVsX2hM0CiuMkZ03xdbbyKdM68CM28H1ATlD4j58EpH7Ec9LH6SWwWsetuhmOVNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dxBCPlld; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id DE35520B74C0; Wed, 28 Feb 2024 10:16:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE35520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709144178;
	bh=og4MbU6fj0BKyQD5O9MQnQfNn4Ii7URCo9iRJW9WPxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dxBCPlldnp9Smg6kffaefldjK9sf8JyJ0wXwfvFdCqCIlN+ooMwr5GPswNWA+g+JK
	 OplaOH2rMpYP8T89+wld4UnCbemUi9LvEYdVYiDJtzBCa0TWA8vqpMi8KzNGguqHBT
	 9x5sIbLzjdJWAmJ9K5QSQuUDhLrBATYVeYNvbxjE=
Date: Wed, 28 Feb 2024 10:16:18 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexander.stein@ew.tq-group.com, decui@microsoft.com
Subject: Re: [PATCH] PCI/sysfs: Fix race in pci sysfs creation
Message-ID: <20240228181618.GA14383@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240227171458.GA16664@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240228152222.GA272403@bhelgaas>
 <20240228172255.GA3579062@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228172255.GA3579062@rocinante>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Feb 29, 2024 at 02:22:55AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> Sorry for late reply.
> 
> [...]
> > > > > Krzysztof has done a ton of work to convert these files to static
> > > > > attributes, where the device model prevents most of these races:
> > > > > 
> > > > >   506140f9c06b ("PCI/sysfs: Convert "index", "acpi_index", "label" to static attributes")
> > > > >   d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
> > > > >   f42c35ea3b13 ("PCI/sysfs: Convert "reset" to static attribute")
> > > > >   527139d738d7 ("PCI/sysfs: Convert "rom" to static attribute")
> > > > >   e1d3f3268b0e ("PCI/sysfs: Convert "config" to static attribute")
> > > > > 
> > > > > and he even posted a series to do the same for the resource files:
> > > > > 
> > > > >   https://lore.kernel.org/linux-pci/20210910202623.2293708-1-kw@linux.com/
> > > > > 
> > > > > I can't remember why we didn't apply that at the time, and it no
> > > > > longer applies cleanly, but I think that's the direction we should go.
> > > > 
> > > > Thanks for you review.
> > > > 
> > > > Please inform me if there's existing feedback explaining why this
> > > > series hasn't been merged yet. I am willing to further improve it
> > > > if necessary.
> > > 
> > > Let us know your opinion so that we can move ahead in fixing this
> > > long pending bug.
> 
> I really thought you were asking me about your patch.  So, I didn't reply
> since Bjorn added his review.
> 
> > There's no feedback on the mailing list (I checked the link above), so
> > the way forward is to update the series so it applies cleanly again
> > and post it as a v3.
> 
> Start with a review, if you have some time.  Perhaps we can make it better
> before sending another revision.
> 
> There are two areas which this series decided not to tackle initially:
> 
>   - Support for the Alpha platform
>   - Support for legacy PCI platforms
> 
> Feel free to have a look at the above.  Perhaps you will have some ideas on how
> to best convert both of these to use static attributes, so that we could convert
> everything at the same time.
> 
> > There's no need to wait for Krzysztof to refresh it, and if you have
> > time to do it, it would be very welcomed!  The best base would be
> > v6.8-rc1.
> 
> That I can do, perhaps this coming weekend.  Or even sooner when I find some
> time this week.
> 
> 	Krzysztof

Thank you ! I will look forward to it. I am happy to review and offer
contributions if required.

- Saurabh

