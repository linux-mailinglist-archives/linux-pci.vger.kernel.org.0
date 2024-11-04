Return-Path: <linux-pci+bounces-15979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6429BBAE9
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 18:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A3D1F21A28
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 17:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECE71C57A5;
	Mon,  4 Nov 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkU4byX2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396051C3034
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739710; cv=none; b=lMcqkCrqQuDI/2n1/KYGyumXcM5kqQ80p5/7M19A9G8qc+8UGSSGxrgZz4zJAGYfyeype51Paa+Sd7siHzm18JZkoRdgq1GJhOSLJ0I8sfUOXyIoYhDHqkdwmqyxq0stAhz6TR4uCQPXBuN2pdF1vkv6w/02e7QvaUdgJAQdjQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739710; c=relaxed/simple;
	bh=LQWfiUupE4ccCGTVBGP1X+xVSUhT/AgTuBEY0/IdKEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cmz5Jwdum4oW797/QFvVcUCKQ6duG17zojFQwTiR/CJ7HK8md6E9L1POV+Fcm1rRr2T6q8zcuvfJ7FOzDkXsssFN/n4YCOz57bnaBtfgGVKFrozWugRH6aSYeyq4slepOZM2XvCwvrUavydM5hhguA6jDfCA7eh6jXtHpej5NKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkU4byX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45420C4CECE;
	Mon,  4 Nov 2024 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730739709;
	bh=LQWfiUupE4ccCGTVBGP1X+xVSUhT/AgTuBEY0/IdKEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SkU4byX2GTFWbHlL9JXJrg4Hou9t0rb/xxfYPe60+fWRSDuCLERrcOTfjqJKlTpvi
	 JIct5t5UGIGAWWkmKI8gOG7q0m5luZNo2BoPRC00KFbrjCsfvOBKe0kudxHrgXQ/cR
	 g2zPuWsGMFp3vsb26eOYwqPHkziyNxXpXmaXRVUwHV1W/QtKW+MS3czHL8oT17eEC1
	 FXwsdJNhuQYmbpveCS4BNPsWiP5hNRr+vFLlRRW2KxVaYvZGI+iWQqPM/Kch/J/TLm
	 OPWtvw8zpXyAYjegPwi4WFXmAsS3/ah5vhFQbLcN7HROhuVcHTPidT/67RbynoUde/
	 Js3m2PnbXrRGQ==
Date: Mon, 4 Nov 2024 10:01:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alex.williamson@redhat.com,
	ameynarkhede03@gmail.com, raphael.norwitz@nutanix.com
Subject: Re: [PATCHv2 2/2] pci: warn if a running device is unaware of reset
Message-ID: <Zyj9-1kB3VhL6iZR@kbusch-mbp>
References: <20241025222755.3756162-1-kbusch@meta.com>
 <20241025222755.3756162-2-kbusch@meta.com>
 <471500804dff90f31320a2a53a48724fffe318b6.camel@linux.ibm.com>
 <ZyUqKquBudn3hh5_@kbusch-mbp.dhcp.thefacebook.com>
 <d69d959038c80026a3f21811a126676d2b25b7c3.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d69d959038c80026a3f21811a126676d2b25b7c3.camel@linux.ibm.com>

On Mon, Nov 04, 2024 at 10:44:23AM +0100, Niklas Schnelle wrote:
> 
> One more question though, what would happen with this reset for a bus
> with an SR-IOV device with more than 256 VFs i.e. where
> pci_iov_virtfn_bus() returns anything other than 0. I'm guessing since
> VFs are physically still controlled by the bridge all VFs would be
> reset but at the same time virtfn_add_bus() sets the bridge device for
> the added bus as NULL so I think it might look odd in sysfs, sadly I
> don't have such a device to test with. Still, this might actually be an
> argument for having the attribute on the bridge.

I assume everything is reset at the PCI level.

Are you asking what the kernel does? I don't think it does anything
special with SR-IOV functions. Those pci_dev's aren't attached to the
bridge pci_dev; you have to go through the pci_bus' children instead.

