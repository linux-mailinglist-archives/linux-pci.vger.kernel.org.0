Return-Path: <linux-pci+bounces-5178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396A88C33D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 14:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CE72E548A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 13:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46DE71739;
	Tue, 26 Mar 2024 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="LRz4axFL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vcIQVYf5"
X-Original-To: linux-pci@vger.kernel.org
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A273528;
	Tue, 26 Mar 2024 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459146; cv=none; b=a7990wBge9wWN01Db2QQLQOVq9J9p1pS4Khj1fF2QVl8dfNTuC/d4bGH5LO3vXMCBodnc/iUuGIYv6wcIjsmlLZpTgaEU7WctPwtkL6xF7RVrkLtwh5LFu9UHJPjK/w4muEnO06GCq0+tfkWonbAQe7sd2zQ/3xBmQ8UP+HsTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459146; c=relaxed/simple;
	bh=Nw6gkzwQJ3vq6k1vADx4v4AL14gU7jDXGeD/VmkPJN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqZXX5Q02tlGPfxe0AVfdyc10sC2oXR3UHK2dqRH2TO5GlRQdkXcNBhjMudz7RZKGhy5+KWP0OwzM3PWDBzrlECJ0uAq8Ce7Ywq3t4vyH3NZwGzzX5wXpK3NS9u6jK97whjztHc2K0JCdqIxsCGQRpmNCkbjJ1+lYfU02If3nFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=LRz4axFL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vcIQVYf5; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 0EC171C000BA;
	Tue, 26 Mar 2024 09:19:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Mar 2024 09:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1711459142; x=
	1711545542; bh=8dkrIjQAho8E94kcntncG9z/hDPUU+6X3l6A7O3vbF8=; b=L
	Rz4axFLvC2Dxz1qd46z5nNt720WBYUvv0U/greVIMdj79SP4BG+PQRhEJcGBzeG+
	Xkwu1ycGLwUVbhLQRbHlefYI8XAHAlYURsqGRvQ0FPQ15gCqRhJREdF1YsUGFmnc
	LFTcBOpooxnzNTxnoR6Wd25ePDVKh8vnh/5JVWrDphLadthJTJr7V+hYWwpi04Mi
	6AwPZ+CyqFrT97SvmVQdgr4V1qGUBlvLN7k6W/fuqf8HV0g/gIonGvnG1mkQ7+3u
	cNfJYqoEnyfHTv1XxbUQMYjwTB1J8fldk4r9pq+SU5GyQyWTJE7KhUh6OxDuX+IZ
	tWxgQZsM+/qlLnal4kOBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711459142; x=1711545542; bh=8dkrIjQAho8E94kcntncG9z/hDPU
	U+6X3l6A7O3vbF8=; b=vcIQVYf5UqI43Xsd10fnZJBQGDxy2yxBdGhf9YbHqwXC
	TmGwGNYmYtGOZLW8AuU3Qm8nxRCnZV+ic73WqE+YiOuJXgAVTivEDg523EtASqxP
	IcV5DB0wZXKB0ENzb5k7qClutbgsKFy2xowY5GR/Jw42Z93L+RsqzMTUjjNGls9X
	VMPdEybPShIgxZUfj8OR8jceG3nDkWkU6JcjKNtc9iZEkBbf3koQhtx6MH0FBi0n
	kDKjtl6jZI823YbgxQSumZnlqHV8SjYgLnxQtLfNW7X0/Z6BThhJG8YPSdnotZgZ
	41jPoqpfivMb2T33YN0Tc44H2+W5milQpMcRD9lwTA==
X-ME-Sender: <xms:RssCZkgqVs6R_BkltFmugRvphof3wFLCdwYbz9T6gmsmiPYejiUDFQ>
    <xme:RssCZtDMAveXgIRoV7uGJ7qTFG0qm3hrYUMTAb8jUxlDXjfGeYRdLVFWC_zONpRGJ
    CXrBsXFfspgoOpjjtY>
X-ME-Received: <xmr:RssCZsFsVNcDNLN6yIR92Hxp1gd09hD9Oi17sdVbdOMFqnXe3MhNq2pnUBCnTCgfPXp0e2p459Pm8mU2fVM_0gY5h2yCvhKe5c8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:RssCZlQgd208te77QdxPinRYKYZW9mRiUo5C8Wdq5ouKl_1WmtRLcg>
    <xmx:RssCZhwAeIRjzplboiN5VAs7YtwvFopvKvNssARPFcxVDZb9E8VO4A>
    <xmx:RssCZj7Q5xmZoyvVg3GyTLRLopXWEBm92wfyolAiTJRbkgUllsleQA>
    <xmx:RssCZuzvkHyBNVrp9xPVM3rfHPiSn2l8eT6fZXa-TAqgwfjNizJPBA>
    <xmx:RssCZomxQuSXbUDISx_t69EzrWD0jlo2kPdGuGWJUky2MqzbyDFlAmstxzg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 09:19:00 -0400 (EDT)
Date: Tue, 26 Mar 2024 22:18:58 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, edmund.raile@proton.me
Subject: Re: [PATCH v2] PCI: Mark LSI FW643 to avoid bus reset
Message-ID: <20240326131858.GA140624@workstation.local>
Mail-Followup-To: Bjorn Helgaas <helgaas@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, edmund.raile@proton.me
References: <20240325012135.36861-1-o-takashi@sakamocchi.jp>
 <20240325144149.GA1432902@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325144149.GA1432902@bhelgaas>

Hi Bjorn,

Thanks for your reply.

On Mon, Mar 25, 2024 at 09:41:49AM -0500, Bjorn Helgaas wrote:
> So even without this patch, you are able to pass the FW643 to a VM
> with VFIO, and you don't see any issues caused by VFIO resetting the
> device?
 
Absolutely yes, at least in my VM, for recent years to maintain Linux
FireWire subsystem and ALSA firewire stack.

> Can you collect the output of:
> 
>   $ find /sys/devices -name reset_method | xargs grep .
 
```
$ sudo find /sys/devices -name reset_method | xargs grep .
/sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/0000:04:09.0/0000:09:00.0/reset_method:bus
/sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/0000:04:09.0/reset_method:pm
/sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/0000:04:02.0/0000:06:00.0/reset_method:pm bus
/sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/0000:04:02.0/reset_method:pm
/sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/0000:04:05.0/0000:07:00.0/reset_method:bus
/sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/0000:04:05.0/reset_method:pm
/sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/0000:04:0a.0/0000:0a:00.0/reset_method:bus
/sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/0000:04:0a.0/reset_method:pm
/sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/0000:04:08.0/0000:08:00.0/reset_method:bus
/sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/0000:04:08.0/0000:08:00.3/reset_method:pm
/sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/0000:04:08.0/reset_method:pm
/sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/0000:04:01.0/reset_method:pm bus
/sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/0000:04:01.0/0000:05:00.0/reset_method:device_specific flr bus
/sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/reset_method:pm bus
/sys/devices/pci0000:00/0000:00:01.2/reset_method:pm
/sys/devices/pci0000:00/0000:00:08.1/0000:0c:00.0/reset_method:flr bus
/sys/devices/pci0000:00/0000:00:08.1/0000:0c:00.3/reset_method:pm
/sys/devices/pci0000:00/0000:00:08.1/0000:0c:00.1/reset_method:flr pm
/sys/devices/pci0000:00/0000:00:08.1/reset_method:pm
/sys/devices/pci0000:00/0000:00:08.1/0000:0c:00.4/reset_method:pm
/sys/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/reset_method:pm bus
/sys/devices/pci0000:00/0000:00:01.1/0000:01:00.0/reset_method:bus
/sys/devices/pci0000:00/0000:00:01.1/reset_method:pm
/sys/devices/pci0000:00/0000:00:01.6/0000:0b:00.0/reset_method:flr bus
/sys/devices/pci0000:00/0000:00:01.6/reset_method:pm
```

If you need each PCI bus bridge information, I can provide it to you.
but I can promise they are typical hardware in AMD CPU or chipset for
Zen generation and nothing special.

> You should be able to manually reset the device with something like
> this (I don't know your topology, so you might have to replace "1d.6"
> with the bridge leading to 06:00.0):
> 
>   # sudo echo 1 > # /sys/devices/pci0000:00/0000:00:1d.6/0000:06:00.0/reset
 
```
$ echo 1 > sudo tee -a /sys/devices/pci0000:00/0000:00:01.2/0000:03:00.0/0000:04:02.0/0000:06:00.0/reset
(nothing happens)
$ journalctl -k -n10
(nothing specific)
```

Would I ask you any point to check after the reset operation?

> I don't *know* of a reason why a Secondary Bus Reset would work
> correctly on your hardware but not on a Mac, but there could be
> something weird going on.

Note that the hardware provided by Apple for the past decade has no
IEEE 1394 interface, thus the patch author seems to use any kind of
bus extension to connect the issued 1394 OHCI hardware. I guess:

* Apple Thunderbolt Display
   * https://lore.kernel.org/linux-pci/1372860295-8306-1-git-send-email-mika.westerberg@linux.intel.com/
* Apple Thunderbolt-OHCI1394 adapter
   * I know FW643 is used for the product.
* Some kind of eGPU box

> Does the patch cause a problem for you?  (Other than the fact that the
> device leaks state between VMs?)

It takes a bit time for me to set up my system with self-compiled v6.9-rc1
kernel. However the leak between VMs is really inconvenient to me by itself.


Thanks

Takashi Sakamoto

