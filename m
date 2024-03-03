Return-Path: <linux-pci+bounces-4377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0C986F379
	for <lists+linux-pci@lfdr.de>; Sun,  3 Mar 2024 04:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A011F218F8
	for <lists+linux-pci@lfdr.de>; Sun,  3 Mar 2024 03:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1C029AF;
	Sun,  3 Mar 2024 03:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="g56thN9y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JZdoEKmB"
X-Original-To: linux-pci@vger.kernel.org
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0DA7F;
	Sun,  3 Mar 2024 03:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709435614; cv=none; b=cxm0zed7rSmXP+iEQR8wMzFyhvcMFatv7OE0Ms4oVi8//EiMkXUFHr0O2WA4F+3u97PiqdlJ+y9lLGqS+DGwwiKuJsZxoreArXiKSUF0FHwSp1uxG9fuR4wFfRZ/o5I6o7D2cRv5voaeUFfeyxo6EZZiiS7fKUUAfAr5LDAyhww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709435614; c=relaxed/simple;
	bh=aXk/E1VC6Fs0OgESy453uujPe4S0IwfzXYvHOoboVBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORC1UqFJMfNi83MTgCdZxctQfNwTUHq/inSfFMpJqolCtbfRsguJHSNdgEgUMYlEwYc6ZNKX8DEkoz1HPkAfIXVw2Z+dxPdC5c3BbQnCudHmXzTmsbYrRZfCGpnshqfzSgDHs7HELHC8iQq7dV4ATwA5UfPN811rGKZIODTU8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=g56thN9y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JZdoEKmB; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 5E39E1C00098;
	Sat,  2 Mar 2024 22:13:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 02 Mar 2024 22:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1709435608; x=
	1709522008; bh=x/zIFvm0CQkbS31nHrROpDnZxIitaOxufuuqemOeeoA=; b=g
	56thN9yMkrws8xGyDaGSKHwVuZ4kMUecPnU9XKzKRdUVT5HHdPo6MMHWQhwIl549
	rfjsRKUOFSUCKHKjOLcYALf3EspIK68zveN/GQeIzeDZtws04UDe0wYh4cghDrkS
	kb2pngkCtrpXb/NTEAzoXnDAqG5oFRbSSRMb8F6IKFE4jFKlHcEhqL0SmGLkui5w
	vkalvzFuPFuC3AFxGo63CxfeBO0zzk1zDKVf7uAMsNet8NOdi19gnzOnTqYOipW7
	lHXLYMVJS+iG9a0d7sDSccIVmXtqVOWaeDrjRhKtMrgT0OdoGHVVJdA+KbGGWadV
	B/ecHVBZAuXGFrwH/gTXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709435608; x=1709522008; bh=x/zIFvm0CQkbS31nHrROpDnZxIit
	aOxufuuqemOeeoA=; b=JZdoEKmB78qtyOaP7kvcwVp6bLWPdKc9aK+tuHZomHw0
	i4ZFp9QzPXGCbj6tq2xPHEwcxnv9REjmxXxwb6ieyqTXDxh+aIbCJHNt9+3N5vbq
	uvhjalEPVQ7ZmuGm3cL/pObjQg2saOb94O1rC1e/8QB/4ukGMWFgO6gac4MQBteq
	Rrl9bFcOI2DjdD4GWTo7bbqTTqDykpkFwuuYKzTx49wzpPaeXZ1s0oQaXZ/BpkYy
	ehAG/+AKK5UXHxaW14JNdv1ml11i3L4EuOYGi5S9fyMbz+dilB668iZ8BPY/gJiu
	FWVQFq+l9aA98RxvSyOTAvBmYuEk+E8a0XgJ/mvwFQ==
X-ME-Sender: <xms:2OrjZXlwGxJF_8Z5amfKDFqZSNuOzTJ2dB6xRhkAbKHwpZGn1fby4A>
    <xme:2OrjZa21PULy0HF1GaehZsaC94EKFG87JzlhhX55y3yxe2HKwEpfTuJhRwvwLIgKW
    w73fWeW77d6oUl8D8s>
X-ME-Received: <xmr:2OrjZdogXB6XBSzJHgSbq0qhfd-xYQAAT7MOuah2uxSlzw5RRx25i_2OefLJTqK-zZ8sTbAfsId0QoI650tUf4A0EA7Dje_nrqE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheeggdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeevieelhfdukeffheekffduudevvdefudelleefgeei
    leejheejuedvgefhteevvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:2OrjZflEmUzagsRxaRlUVzpGCObR0XckM0DrbTjw7Q75jzn3X2gs2A>
    <xmx:2OrjZV3YCREY7mQnLSTab-FxMyRat9ZH9i2tQ-rBGpMhSIsTtZxB-g>
    <xmx:2OrjZetJN7bqh_FmkurZoaHIvXSNFNgE_P0z5meYi8bOSsceHI9fSQ>
    <xmx:2OrjZQTZBWIyxiXJsXwsyLeMVz-c-tbwfCJL4j80vDc2r8lqXJFn6yFEGHM>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Mar 2024 22:13:27 -0500 (EST)
Date: Sun, 3 Mar 2024 12:13:25 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Edmund Raile <edmund.raile@proton.me>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] firewire: ohci: prevent leak of left-over IRQ on
 unbind
Message-ID: <20240303031325.GA40441@workstation.local>
Mail-Followup-To: Edmund Raile <edmund.raile@proton.me>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	linux-pci@vger.kernel.org
References: <20240229101236.8074-1-edmund.raile@proton.me>
 <20240229144723.13047-2-edmund.raile@proton.me>
 <20240301044024.GA37429@workstation.local>
 <wrcvrmxqfy2zfpbcgoy4txqmzcoyptzvctzymztlp55gasu2fg@tyudozxoyvzo>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrcvrmxqfy2zfpbcgoy4txqmzcoyptzvctzymztlp55gasu2fg@tyudozxoyvzo>

Hi,

(C.C.ed to the list of PCI SUBSYSTEM.)

On Sat, Mar 02, 2024 at 04:52:06PM +0000, Edmund Raile wrote:
> > In my opinion, the devres mechanism releases the allocated memory when
> > releasing the data of associated device structure.
> > device_release_driver_internal()
> > ->__device_release_driver()
> >   ->device_unbind_cleanup()
> >     (drivers/base/devres.c)
> >     ->devres_release_all(dev);
> >       ->release_nodes()
> >         (kernel/irq/devres.c)
> > 	->free_irq()
> 
> Looking at __device_release_driver() in drivers/base/dd.c,
> device_remove() gets called, leading to dev->bus->remove(dev),
> which likely calls our good old friend from the call trace:
> pci_device_remove().
> 
> > > Call Trace:
> > >  ? remove_proc_entry+0x19c/0x1c0
> > >  ? __warn+0x81/0x130
> > >  ? remove_proc_entry+0x19c/0x1c0
> > >  ? report_bug+0x171/0x1a0
> > >  ? console_unlock+0x78/0x120
> > >  ? handle_bug+0x3c/0x80
> > >  ? exc_invalid_op+0x17/0x70
> > >  ? asm_exc_invalid_op+0x1a/0x20
> > >  ? remove_proc_entry+0x19c/0x1c0
> > >  unregister_irq_proc+0xf4/0x120
> > >  free_desc+0x3d/0xe0
> > >  ? kfree+0x29f/0x2f0
> > >  irq_free_descs+0x47/0x70
> > >  msi_domain_free_locked.part.0+0x19d/0x1d0
> > >  msi_domain_free_irqs_all_locked+0x81/0xc0
> > >  pci_free_msi_irqs+0x12/0x40
> > >  pci_disable_msi+0x4c/0x60
> > >  pci_remove+0x9d/0xc0 [firewire_ohci
> > >      01b483699bebf9cb07a3d69df0aa2bee71db1b26]
> > >  pci_device_remove+0x37/0xa0
> > >  device_release_driver_internal+0x19f/0x200
> > >  unbind_store+0xa1/0xb0
> 
> Then in ohci.c's pci_remove(), we kill the MSIs, which leads to
> the removal of the IRQ, etc.
> Back in __device_release_driver(), after device_remove(),
> device_unbind_cleanup() is called, leading to free_irq(), but too late.
> 
> I think the order of these calls may be our issue but I doubt it
> has been done like this without good reason.
> That code is 8 years old, someone would have noticed if it had an error.

Now I got the point. Before optimizing to device managing resource, the
1394 OHCI driver called `free_irq()` then `pci_disable_msi()` in the
.remove() callback. So the issue did not occur. At present, the order is
reversed, as you find.

To be honestly, I have little knowledge about current implementation of
PCIe MSI operation and the current best-practice in Linux PCI subsystem.
I've just replaced the old implementation of the driver with the
relevant APIs, so I need to consult someone about the issue.

> I could be entirely wrong but the function description in
> /kernel/irq/devres.c tells me that function is meant to be used:
> 
> > Except for the extra @dev argument, this function takes the
> > same arguments and performs the same function as free_irq().
> > This function instead of free_irq() should be used to manually
> > free IRQs allocated with devm_request_irq().
> 
> And while devm_request_irq() has no function description of its own, its
> sister devm_request_threaded_irq() mentions this:
> 
> > IRQs requested with this function will be
> > automatically freed on driver detach.
> > 
> > If an IRQ allocated with this function needs to be freed
> > separately, devm_free_irq() must be used.
> 
> Should we pull in the maintainers of dd.c for their opinion?
> 
> Thank you very much for all the very hard work you do Sakamoto-Sensei!

Indeed. If the current implementation of PCIe MSI requires the call of
`free_irq()` (or something) before calling `pci_disable_msi()`, it
should be documented. But we can also see the `pci_disable_msi()` is
legacy API in PCIe MSI implementation[1]. I guess that the extra care of
order to call these two functions would be useless nowadays by some
enhancement.


[1] https://docs.kernel.org/PCI/msi-howto.html#legacy-apis

Thanks

Takashi Sakamoto

