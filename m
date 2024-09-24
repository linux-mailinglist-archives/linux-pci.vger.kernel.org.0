Return-Path: <linux-pci+bounces-13422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9F3984121
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 10:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADDEB1C209EE
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 08:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E742414F124;
	Tue, 24 Sep 2024 08:55:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C595450EE
	for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2024 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168111; cv=none; b=cOfDtl0XX5CX8im4bgI5S/C2OLN/fuBCNRSYss+beHI/VyKmGPWJRbErNb8922W+JKMJR8ibqNYOsqoBVYumEO+gCi9gPy6RDYBPS+oHkPQhfuEHr00Wpphl3yGTSXI4oqar7lXwAUlfurIB0b9/rZ3VJNkQnQdLZ+y2642w0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168111; c=relaxed/simple;
	bh=B855ocoZI5j246WfOh9OvjTcSzB3KmSW6BnXQfhV9D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KocnRACLPE1QmeZ0MjQwAF8R+odQHJAXQRG8hyJoUDQnzfprkl2rID7BO+jmdfCrHVCKzMdlQvqNcBKjNk6kThl9K86V5djod02kkqv5KqFVmWm32vd3cFPflovtbYgNQq63ManFlSfgsN2bhPp4JSFGy0nK9pu6w/mFKMIGS9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D319A100D5865;
	Tue, 24 Sep 2024 10:54:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9D6291DEDA1; Tue, 24 Sep 2024 10:54:58 +0200 (CEST)
Date: Tue, 24 Sep 2024 10:54:58 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"mpearson-lenovo@squebb.ca" <mpearson-lenovo@squebb.ca>
Subject: Re: UAF during boot on MTL based devices with attached dock
Message-ID: <ZvJ-Yhidtc4IlU6P@wunner.de>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>

On Thu, Sep 19, 2024 at 08:06:03AM +0000, Wassenberg, Dennis wrote:
> We want to boot up an Intel MeteorLake based system (e.g. Lenovo
> ThinkPad X13 Gen5) with the Lenovo Thunderbolt 4 universal dock
> attached during boot.
[...]
> 0000:00 [root bus]
>       -> 0000:00:07.0 [bridge to 20-49]
>                      -> 0000:20:00.0 [bridge to 21-49]
>                                     -> 0000:21:00.0 [bridge to 22]
>                                        0000:21:01.0 [bridge to 23-2e]
>                                        0000:21:02.0 [bridge to 2f-3a]
>                                        0000:21:03.0 [bridge to 3b-48]
>                                        0000:21:04.0 [bridge to 49]
>          0000:00:07.2 [bridge to 50-79]

The kernel oopses in kthread irq/156-pciehp.  That belongs to
the Root Port 0000:00:07.0, as is evident from...

    [   12.850063] pcieport 0000:00:07.0: PME: Signaling with IRQ 156

...because PME and hotplug share the same interrupt.

What happens here is that pciehp checks on probe whether the slot is
not occupied (neither link nor presence bits set in config space)
but is in ON_STATE (the list subordinate->devices is non-empty,
see pcie_init()).

pciehp then synthesizes a Presence Detect Changed event to bring the
slot down, i.e. de-enumerate the device in the purportedly non-occupied
slot:

pciehp_probe()
  pciehp_check_presence()
    pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC)

Corresponding messages:

    [   12.850866] pcieport 0000:00:07.0: pciehp: pciehp_check_link_active: lnk_status = 5041

Bit 13 in the Link Status register is not set (Data Link Layer Link Active).

    [   12.850880] pcieport 0000:00:07.0: pciehp: Slot(12): Card not present

Synthesize Presence Detect Changed event

    [   12.850887] pcieport 0000:00:07.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0000:20:00

De-enumerate child device.

We need to find out why the oops occurs for sure, and it's good that
you found it and are able to reproduce it.  But the reason you're
seeing this on some devices and not on others is likely that the
Meteor Lake CPU oddly reports presence and link down even though
there's a device attached which is apparently accessible just fine.

Not sure if that's a hardware erratum in Meteor Lake or a BIOS issue.

I'll need some more time to root cause the oops.  Sorry for the delay,
everyone is still decompressing after Plumbers last week.

Thanks,

Lukas

