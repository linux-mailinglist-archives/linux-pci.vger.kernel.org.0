Return-Path: <linux-pci+bounces-30749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16585AE9D42
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 14:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECBD1884EFC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD66917BA1;
	Thu, 26 Jun 2025 12:08:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A41CFBA
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939724; cv=none; b=F11f4i5+jaX6iVKnH/7LHkMvmANyaUYlR/0HD5GlBLyC+u5ztpXd9jUzdPA7AeTExWwLq8jU9K9HGqdPpK7ZfmfGBMwbCKJ74gWLLrRFUdWKawks+8d2Mzwkzg8OGltCa8jN5Xeq/FcbpHNYJ1Y/FwgWrH3JSD8QLIS7bbDkYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939724; c=relaxed/simple;
	bh=P2UkO08Ex7+1oWNq064GQOvODm509BgSbUUWxdH05yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BROt5Lt1hf2awSyFEcYC5q7DLVjd+J4LIHH/9oUsgYynjoFlco3iENEsmnSx5oibnuuIVpOS1nQkpEXKZFsgqTAFQVQ4UkmiPOEulZQUYIonVbHQAxvxSvmBwX4g5TUGiG3O7eQs5rfi9xe7sycJlTVAPR2uJRpoxkZDDZBrYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4C9452C00096;
	Thu, 26 Jun 2025 14:08:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DCB193BCFE3; Thu, 26 Jun 2025 14:08:31 +0200 (CEST)
Date: Thu, 26 Jun 2025 14:08:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Jozef Matejcik (Nokia)" <jozef.matejcik@nokia.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci_probe called concurrently in machine with 2 identical PCI
 devices causing race condition
Message-ID: <aF04PxJ5WqIA7Je0@wunner.de>
References: <AS4PR07MB85085806C2BF5CC518D52808937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR07MB85085806C2BF5CC518D52808937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>

On Thu, Jun 26, 2025 at 10:14:00AM +0000, Jozef Matejcik (Nokia) wrote:
> We have one specific problem related to Linux PCI subsystem.
> 
> We have a device with 2 identical NPUs, so 2 identical PCI devices
> sharing the same 3rd party driver. Our problem is that _pci_probe of
> this driver is called concurrently from 2 kernel threads. It happens
> more frequently when kernel debug logs are enabled in GRUB, appr.
> every 20th or 30th reboot of the device.

So what exactly is the "problem"?  Does something not work?
Do you get errors or warnings?

> So the fix is specifically related to devices with multiple VFs.
> But does this take into account the setup with 2 separate, but
> otherwise identical PCI devices? Is it possible this can occur
> in any machine with 2 identical PCI devices?

Not unless probing of one PF creates another PF.

Thanks,

Lukas

