Return-Path: <linux-pci+bounces-42354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C74C968EA
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 11:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5E553416A3
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350492FDC29;
	Mon,  1 Dec 2025 10:03:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2421CC4F
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583437; cv=none; b=pmQ5bfkOlfio7hrCwByH0azw7EwUNXp1oj8Hzbi9CuCG9n+ODMOocmif8xTSTxySTYqocG1ensfaeDmBL63XtPtliWguCbIHWfd0Yj21wmLAuYp4MyMaYjw5MuV6kwJzytA4X+hSFt7au4WTsLnKDqw0Xvn5ApsGze/KosRcZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583437; c=relaxed/simple;
	bh=Nozt1h71bbS35XfJBzehHCcoJ0IRMYMJlqiLsJVm4dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxLWKFQ2KOn6Bgee1BK2JJ/oDPkuj0hn8hIM3qoNpKO8XkWMYBeCEOGo5rg37SpggAviR9RlEE35IzVdruaIi7JhPainK7/IoATLVNQsf942t+MYnxnOE4JXmFNdpd+2QgyWOx0i9b6PaHWAmDZ1Q+Siwe0SMvAJerq+KwMeYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 547A92C0601E;
	Mon,  1 Dec 2025 11:03:46 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1343D1E6DF; Mon,  1 Dec 2025 11:03:46 +0100 (CET)
Date: Mon, 1 Dec 2025 11:03:46 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	kanie <kanie@linux.alibaba.com>,
	alikernel-developer <alikernel-developer@linux.alibaba.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] PCI: Fix PCIe SBR dev/link wait error
Message-ID: <aS1oArFHeo9FAuv-@wunner.de>
References: <20251124104502.777141-1-guanghuifeng@linux.alibaba.com>
 <20251124235858.GA2726643@bhelgaas>
 <a4a2a5ee-1f4e-4560-b8cf-c9c10ae475dd.guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a2a5ee-1f4e-4560-b8cf-c9c10ae475dd.guanghuifeng@linux.alibaba.com>

On Tue, Nov 25, 2025 at 02:20:10PM +0800, guanghui.fgh wrote:
> After __pci_reset_slot/__pci_reset_bus calls
> pci_bridge_wait_for_secondary_bus, the device will be restored via
> pci_dev_restore. However, when a multifunction PCIe device is connected,
> executing pci_bridge_wait_for_secondary_bus only guarantees the restoration
> of a random device. For other devices that are still restoring, executing
> pci_dev_restore cannot restore the device state normally, resulting in
> errors or even device offline.

PCIe is point-to-point, i.e. at the two ends of a link there's only a
single physical device.  So if there are multiple pci_dev's on a bus,
they're additional functions or VFs of the same physical device.

The expectation is that if the first device on the bus is accessible,
all other functions of the same physical device are accessible as well.
That's why we only wait for the first device to become accessible.

It seems highly unusual that the different functions of the same physical
device require different delays until they're accessible.  I don't think
we can accept such a sweeping change wholesale without more details,
so please share what the topology looks like (lspci -tv), what devices are
involved (lspci -vvv) and which device requires extra wait time for some
of its functions.

Thanks,

Lukas

