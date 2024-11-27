Return-Path: <linux-pci+bounces-17427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA3E9DAE30
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 20:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6404161FF4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 19:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E15202F71;
	Wed, 27 Nov 2024 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWgy5/Et"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8882D66;
	Wed, 27 Nov 2024 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732737412; cv=none; b=WhfEd0JnrZeILeify6X/fJjSY0GFm/9Jh3JTr7M1TcyEDTjSoEsH/X5QHr8sCyGuXk/yttx5jmqXKnf4/LOhcHtx50yOruro8AIDX0r3n20TzFENgg9yPiSVU6tkdgAHZGMz52fZGIlIxn2uw8FnBi9wYC9Ukhme1mWBveZhpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732737412; c=relaxed/simple;
	bh=sSujaLHv8yWSImYfq5lG5j5+Lr3WVgrQiG106s5PoOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odQPBwJMYsfbGgSwzNYCkt+BHTt6NlTdqEyxudjjVyi6Kbk29Z044gytyFZcYe0wm0Ji0hSzALYQPaRvInWYq3q8JeAgVH8rNceJsJ36e4R+R6PgZHHCAMlSJKRAvj4X9zaf0azVJcopdNITECfTdSbbPoHWdaeEt7t7+iDejno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWgy5/Et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC44C4CECC;
	Wed, 27 Nov 2024 19:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732737412;
	bh=sSujaLHv8yWSImYfq5lG5j5+Lr3WVgrQiG106s5PoOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWgy5/EtibxGWAMIude3wCmVkE//GF+ccVVWeWyubl2X4TW7nQGSWWzAvf9jRIzoX
	 g0eRcnhq9AGHz/olZ8c6K3PKyZIBda6Lny1KKh1ste6YRO4Wd5YlxZLfd3PSObLTXp
	 zMkiJh9ChwiCP5BmwCoHNx9kezWDPblS0UdzLEviQAUc3wzdQhKJuow+6JGoyFxoHc
	 MqSOQVp+EqLXdpNZUxS5BIiGB10gTJE10hgXEhJ8sUlTHjHO4oPHJXrZYUHr1NP33F
	 hCi8oPJqseIRliYJfGU4Mpr7x4mrD6f5zYrG3u6cq94mzSQWca9I3wt7bqbKAYPkfp
	 qtDv7fWkGA8lg==
Date: Wed, 27 Nov 2024 13:56:50 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	"open list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: check bridge->bus in pci_host_common_remove
Message-ID: <20241127195650.GA4132105-robh@kernel.org>
References: <20241028084644.3778081-1-peng.fan@oss.nxp.com>
 <20241115062005.6ifvr6ens2qnrrrf@thinkpad>
 <PAXPR04MB8459D1507CA69498D8C38E0488242@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241115144720.ovsyq2ani47norby@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115144720.ovsyq2ani47norby@thinkpad>

On Fri, Nov 15, 2024 at 08:17:20PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 15, 2024 at 10:14:10AM +0000, Peng Fan wrote:
> > Hi Manivannan,
> > 
> > > Subject: Re: [PATCH] PCI: check bridge->bus in
> > > pci_host_common_remove
> > > 
> > > On Mon, Oct 28, 2024 at 04:46:43PM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > When PCI node was created using an overlay and the overlay is
> > > > reverted/destroyed, the "linux,pci-domain" property no longer exists,
> > > > so of_get_pci_domain_nr will return failure. Then
> > > > of_pci_bus_release_domain_nr will actually use the dynamic IDA,
> > > even
> > > > if the IDA was allocated in static IDA. So the flow is as below:
> > > > A: of_changeset_revert
> > > >     pci_host_common_remove
> > > >      pci_bus_release_domain_nr
> > > >        of_pci_bus_release_domain_nr
> > > >          of_get_pci_domain_nr      # fails because overlay is gone
> > > >          ida_free(&pci_domain_nr_dynamic_ida)
> > > >
> > > > With driver calls pci_host_common_remove explicity, the flow
> > > becomes:
> > > > B pci_host_common_remove
> > > >    pci_bus_release_domain_nr
> > > >     of_pci_bus_release_domain_nr
> > > >      of_get_pci_domain_nr      # succeeds in this order
> > > >       ida_free(&pci_domain_nr_static_ida)
> > > > A of_changeset_revert
> > > >    pci_host_common_remove
> > > >
> > > > With updated flow, the pci_host_common_remove will be called
> > > twice, so
> > > > need to check 'bridge->bus' to avoid accessing invalid pointer.
> > > >
> > > > Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > 
> > > I went through the previous discussion [1] and I couldn't see an
> > > agreement on the point raised by Bjorn on 'removing the host bridge
> > > before the overlay'.
> > 
> > This patch is an agreement to Bjorn's idea. 
> > 
> > I have added pci_host_common_remove to remove host bridge
> > before removing overlay as I wrote in commit log.
> > 
> > But of_changeset_revert will still runs into pci_host_
> > common_remove to remove the host bridge again. Per
> > my view, the design of of_changeset_revert to remove
> > the device tree node will trigger device remove, so even
> > pci_host_common_remove was explicitly used before
> > of_changeset_revert. The following call to of_changeset_revert
> > will still call pci_host_common_remove.
> > 
> > So I did this patch to add a check of 'bus' to avoid remove again.
> > 
> 
> Ok. I think there was a misunderstanding. Bjorn's example driver,
> 'i2c-demux-pinctrl' applies the changeset, then adds the i2c adapter for its
> own. And in remove(), it does the reverse.
> 
> But in your case, the issue is with the host bridge driver that gets probed
> because of the changeset. While with 'i2c-demux-pinctrl' driver, it only
> applies the changeset. So we cannot compare both drivers. I believe in your
> case, 'i2c-demux-pinctrl' becomes 'jailhouse', isn't it?
> 
> So in your case, changeset is applied by jailhouse and that causes the
> platform device to be created for the host bridge and then the host bridge
> driver gets probed. So during destroy(), you call of_changeset_revert() that
> removes the platform device and during that process it removes the host bridge
> driver. The issue happens because during host bridge remove, it calls
> pci_remove_root_bus() and that tries to remove the domain_nr using
> pci_bus_release_domain_nr().
>
> But pci_bus_release_domain_nr() uses DT node to check whether to free the
> domain_nr from static IDA or dynamic IDA. And because there is no DT node exist
> at this time (it was already removed by of_changeset_revert()), it forces
> pci_bus_release_domain_nr() to use dynamic IDA even though the IDA was initially
> allocated from static IDA.

Putting linux,pci-domain in an overlay is the same problem as aliases in 
overlays[1]. It's not going to work well.

IMO, you can have overlays, or you can have static domains. You can't 
have both.

> I think a neat way to solve this issue would be by removing the OF node only
> after removing all platform devices/drivers associated with that node. But I
> honestly do not know whether that is possible or not. Otherwise, any other
> driver that relies on the OF node in its remove() callback, could suffer from
> the same issue. And whatever fix we may come up with in PCI core, it will be a
> band-aid only.
> 
> I'd like to check with Rob first about his opinion.

If the struct device has an of_node set, there should be a reference 
count on that node. But I think that only prevents the node from being 
freed. It does not prevent the overlay from being detached. This is one 
of many of the issues with overlays Frank painstakingly documented[2].

Perhaps it is just a matter of iterating thru all the nodes in an 
overlay, getting their driver/device, and forcing them to unbind. 
Though that has to be done per bus type.

Rob

[1] https://lore.kernel.org/all/CAL_Jsq+72Q6LyOj1va_qcyCVkSRwqGNvBFfB9NNOgYXasAFYJQ@mail.gmail.com/
[2] https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts

