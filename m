Return-Path: <linux-pci+bounces-13996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD2C9950CF
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 15:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB36283458
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A781DF25B;
	Tue,  8 Oct 2024 13:58:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6017197A65
	for <linux-pci@vger.kernel.org>; Tue,  8 Oct 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395925; cv=none; b=fmZalBhbu9YzfA1LRS3XZcM6dMKdFtE1iodO/hIjWh2amR51M5K5U6BIz5+I4rzYSxE5V0zWrio3s8zWVb9yiz10lWkV8BowE7o6Ir64GUGMzxp5B/z2sTWC0Er3Xj+L2PfrPh/TbSWOdk0Ma0oYSjIUAcWu5CwSvmKgJAAoLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395925; c=relaxed/simple;
	bh=+Ic2462xMWxBN2Kceb3IWlwgDelvRrvYXNve57V6qJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+vLYNiH2pAXNNJk8Davzw0oGwXu8F5ZrQl8C7ks0/HEEe9Xms2J95aGqtiLrcaL5iXCLd3vtIYMMFGBHPwjtAGxCNRze+0TMyClOH0GnrlZijemgqL264rSzh8cFa4ENbyI5XAzpLabSm86q1PK80yqlwYzMvnpEIwkxjCeIEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 303BC28013805;
	Tue,  8 Oct 2024 15:58:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1647E2D3FC; Tue,  8 Oct 2024 15:58:34 +0200 (CEST)
Date: Tue, 8 Oct 2024 15:58:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"mpearson-lenovo@squebb.ca" <mpearson-lenovo@squebb.ca>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"minipli@grsecurity.net" <minipli@grsecurity.net>
Subject: Re: UAF during boot on MTL based devices with attached dock
Message-ID: <ZwU6ijD8I5hzMv9X@wunner.de>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
 <c394a3f07bfb7240a2c32fa6d467ea1a03547881.camel@secunet.com>
 <68de3ca4-a624-8b02-8f6d-889deb61495d@linux.intel.com>
 <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>
 <Zv6gT96pHg2Jglxv@wunner.de>
 <Zv-dIHDXNNYomG2Y@wunner.de>
 <bdc3963903e7c4aeec7c34ac0d46c4368152a8c2.camel@secunet.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc3963903e7c4aeec7c34ac0d46c4368152a8c2.camel@secunet.com>

On Mon, Oct 07, 2024 at 04:49:19PM +0000, Wassenberg, Dennis wrote:
> > The unplug event happens at the top of the hierarchy (below the Root Port).
> > So pci_bus_add_devices() binds the Root Port, its driver starts stopping
> > and removing the hierarchy below, all the while pci_bus_add_devices()
> > continues binding drivers to the child devices.
> > 
> > Could you try this patch (in addition to the one below and to the one
> > I sent yesterday):
> > 
> > https://lore.kernel.org/all/20241003084342.27501-1-brgl@bgdev.pl/
> > 
> > It should prevent pci_bus_add_devices() from racing with pciehp stopping
> > and removing devices.
> 
> I checked the combination of all 3 patches as well. In the end it behaves
> the same like if I apply the first patch only (the one you sent the day
> before).

Thanks a lot for testing and the detailed feedback.

Would it be possible for you to try the above-linked patch alone
(on top of a recent stock kernel), i.e. without the refcounting
fix that you say was sufficient to avoid the UAF?

And I'd also appreciate if you could try the match_driver approach ...

https://lore.kernel.org/all/Zv-dIHDXNNYomG2Y@wunner.de/

... alone, i.e. without any other patches.

It's interesting that the refcounting fix was sufficient to avoid
the UAF but I can't get over the fact that the pcieport driver is
unbound from pci_remove_bus_device(), when it should no longer be
bound in the first place.  My impression is that teardown of the
hierarchy by pciehp races with driver binding after the initial
root bus scan, so we probably should try to avoid that.  I'd like
to confirm (or disprove) that hunch.

The refcounting fix could be applied as a safety net but normally
shouldn't be necessary if driver unbinding happens in pci_stop_dev()
and the device remains unbound afterwards.  The match_driver patch
should achieve that.  And the other patch by Bartosz (linked above)
should achieve the same by serializing driver binding after bus
enumeration with driver unbinding by pciehp.

Finally, I'd appreciate if you could send me dmesg output with the
refcounting fix applied.  As said before, the MTL Thunderbolt controller
claims that the link and slot presence bits are cleared, so it
de-enumerates everything attached via Thunderbolt.  I'm wondering
if it then re-enumerates the Thunderbolt-attached devices so they're
actually usable?

I'm hoping Mika can clarify with Intel Thunderbolt CoE whether this
is a hardware issue in MTL that can e.g. be fixed through a firmware
or BIOS update.

Thanks!

Lukas

