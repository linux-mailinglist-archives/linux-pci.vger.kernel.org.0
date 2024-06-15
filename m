Return-Path: <linux-pci+bounces-8856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC27909794
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 12:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1C11C20BE9
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 10:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F7417C6B;
	Sat, 15 Jun 2024 10:07:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B051CF96;
	Sat, 15 Jun 2024 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718446025; cv=none; b=okQ1CQPWRAWq0ujntGNlndvf/i/hLwCZ+bY7Gr24xmBU/RKNr9hOT4CxjuVfetLHvIKtnKNqZf3EIqFGm0EZ7lEaRotGnlmyvZrmv4GgV1G9EXIe0A3JCrbpS7hyRZkE4qAfETL94JeGzc2OggIXngJbP3Bb+p82Doc1SIetMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718446025; c=relaxed/simple;
	bh=5o+DUAtHi20uDaXoPaGSRmBIpLcxAJLnmLA3JNlxjss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbuSybNMW05MpSIxEpOTvhnrq2nbLSwpAaVtEx7ZFTlvKoYaVkxqPM811l7aWa9iQd98OM9d9aDan6AtkLxc72/Zv0ieNs389+p+KoqHFiJUmI6d7dg8bEczTVerHkU3DOm9ySXKXufTMFHmzm/RxJw1Gg+pL1i7EW4pthLqLRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id CC0F62800BBEF;
	Sat, 15 Jun 2024 12:06:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9BD421EC340; Sat, 15 Jun 2024 12:06:58 +0200 (CEST)
Date: Sat, 15 Jun 2024 12:06:58 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bitao Hu <yaoma@linux.alibaba.com>, bhelgaas@google.com,
	weirongguang@kylinos.cn, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kanie@linux.alibaba.com,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCHv2] PCI: pciehp: Use appropriate conditions to check the
 hotplug controller status
Message-ID: <Zm1nwq97LdLNhrTz@wunner.de>
References: <Zmyb2WMhhNc7zQ2i@wunner.de>
 <20240614220327.GA1125489@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614220327.GA1125489@bhelgaas>

On Fri, Jun 14, 2024 at 05:03:27PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 14, 2024 at 09:36:57PM +0200, Lukas Wunner wrote:
> > Hm, good point.  I guess we should change the logical expression instead:
> > 
> > -	if (present <= 0 && link_active <= 0) {
> > +	if (present < 0 || link_active < 0 || (!present && !link_active)) {
> 
> It gets to be a fairly complicated expression, and I'm not 100% sure
> we should handle the config read failure the same as the "!present &&
> !link_active" case.  The config read failure probably means the
> Downstream Port is gone, the other case means the device *below* that
> port is gone.
> 
> We likely want to cancel the delayed work in both cases, but what
> about the indicators?  If the Downstream Port is gone, we're not going
> to be able to change them.  Do we want the same message for both?
> 
> Maybe we should handle the config failures separately first?  These
> error conditions make everything so ugly.

To keep the code simple, I'm leaning towards not making the call to
pciehp_set_indicators() conditional.  The worst thing that can happen
is that pciehp waits 1 sec for a previous write to the Slot Control
register to time out.


> > > These are cases where we misinterpreted -ENODEV as "device is present"
> > > or "link is active".
> > > 
> > > pciehp_ignore_dpc_link_change() and pciehp_slot_reset() also call
> > > pciehp_check_link_active(), and I think they also interpret -ENODEV as
> > > "link is active".
> > > 
> > > Do we need similar changes there?
> > 
> > Another good observation, both need to check for <= 0 instead of == 0.
> > Do you want to fix that yourself or would you prefer me (or someone else)
> > to submit a patch?
> 
> It'd be great if you or somebody else could do that.

After looking at this with a fresh pair of eyeballs, I'm thinking now
that the code is actually fine the way it is:

- pciehp_ignore_dpc_link_change():

  If pciehp_check_link_active() returns -ENODEV, it means we recovered
  from DPC but immediately afterwards the hotplug port became inaccessible,
  perhaps because it was hot-removed or because a DPC event occurred
  further up in the hierarchy.  In neither case would it be called for
  to synthesize a Data Link Layer State Changed event:

  If the hotplug port was hot-removed, it's better to let the hotplug port
  in its ancestry handle the de-enumeration of its sub-hierarchy and not
  interfere with that by trying to concurrently remove a portion of that
  sub-hierarchy.
  
  If a DPC event occurred further up, it's better to let the DPC-capable
  port in the ancestry handle the recovery and not interfere with that.

- pciehp_slot_reset():

  If pciehp_check_link_active() returns -ENODEV, it means a Hot Reset
  was propagated down the hierarchy after which the hotplug port is
  no longer accessible.  Perhaps the hotplug port was hot removed by
  the user, in which case we should let the hotplug port in the
  ancestry handle de-enumeration.  Another possibility is that reset
  recovery failed.  I don't think we should try to de-enumerate devices
  below the hotplug port in that case.  Maybe another error occurred
  which triggered another reset and things will be fine after we've
  recovered from that.

Thanks,

Lukas

