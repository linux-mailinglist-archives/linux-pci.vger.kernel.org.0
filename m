Return-Path: <linux-pci+bounces-13680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45E98BAA2
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 13:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82661C216A2
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 11:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE091BF335;
	Tue,  1 Oct 2024 11:07:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26A51BE86E;
	Tue,  1 Oct 2024 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780842; cv=none; b=K67UlZFi8r34L/5Vf4eHu+DVirWl1gCyTDPoms7VxvQT6eiNLh7morfbPt3YunHZdZ5WagcGtoWXCYkt3Lzl3eskRm09/wxCKlruLOltpGUB1XvBJufLDi/txUgu4/tk5NOict1J0WjpUK1EwkR1DMAglUInv8D1+KiWcpW9ZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780842; c=relaxed/simple;
	bh=weurZ7f6r0W/k0PPpMVi8YHvf9LeKhQs/vfB2a1/Kzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBxJkgrKGms0O/yW/33MMl9ciY4nCyPjooEKWsS931izi6iNjLDmcS7sj2/Bfyvm2aSOel0vKi3rH+C61G5EPtAU8+qrW/vpOOzE14+gosKhXMpq0dKWgYI0ATXB4vN2xt2lUgvwjF76qTshwIa43j2e2cdIJsiJz9W7OWZe5B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 76EF5100D9429;
	Tue,  1 Oct 2024 13:07:18 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 507095008; Tue,  1 Oct 2024 13:07:18 +0200 (CEST)
Date: Tue, 1 Oct 2024 13:07:18 +0200
From: Lukas Wunner <lukas@wunner.de>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
Message-ID: <ZvvX5i95MpWrru4_@wunner.de>
References: <20240926125909.2362244-1-acelan.kao@canonical.com>
 <ZvVgTGVSco0Kg7H5@wunner.de>
 <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>
 <ZvZ61srt3QAca2AI@wunner.de>
 <CAFv23Q=QJ+SmpwvzLmzJeCXwYrAHVvTK96Wz7rY=df7VmGbSmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFv23Q=QJ+SmpwvzLmzJeCXwYrAHVvTK96Wz7rY=df7VmGbSmw@mail.gmail.com>

On Mon, Sep 30, 2024 at 11:27:28AM +0800, AceLan Kao wrote:
> Lukas Wunner <lukas@wunner.de> 2024 9 27 5:28
> > there is a known issue
> > that a deadlock may occur when hot-removing nested PCIe switches (which is
> > what you've got here).  Keith Busch recently re-discovered the issue.
> > You may want to try if the hang goes away if you apply this patch:
> >
> > https://lore.kernel.org/all/20240612181625.3604512-2-kbusch@meta.com/
> >
> > If it does go away then at least we know what the root cause is.
> 
> Yes, the 2 patches work.

Okay so you can't reproduce the issue with those patches?

That would mean 9d573d19547b ("PCI: pciehp: Detect device replacement
during system sleep") isn't the culprit, whew!


> > The patch is a bit hackish, but there's an ongoing effort to tackle the
> > problem more thoroughly:
> >
> > https://lore.kernel.org/all/20240722151936.1452299-1-kbusch@meta.com/
> > https://lore.kernel.org/all/20240827192826.710031-1-kbusch@meta.com/
> 
> v2 can't be applied clearly, so I made some changes.
> And this series doesn't work for me.

Okay, I'll look at those patches separately.

Thanks,

Lukas

