Return-Path: <linux-pci+bounces-12178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035CB95E3EB
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 16:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD83B1C20AF5
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 14:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEB915573C;
	Sun, 25 Aug 2024 14:29:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0D2AD15;
	Sun, 25 Aug 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724596187; cv=none; b=WcDtJ09NHCzX+efTickYtVR9hGl+xVXSQMqlidC6kqy2QjBMi8RNv2RgXUpIkYUaY4dxHdToMAI+Ch+FlOPxosdRf0SwA335e+00IDvY5HcQ8RrYCZ9uAe4+U9sa+u/FA62ds/xKLMwWX4ppMz9Z+O/SCGfsdE2mlp/49WPATa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724596187; c=relaxed/simple;
	bh=hkUw4CN+PllqJm92DaOyGtZOxUYqKkH4lgEa3f3vRA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjCvMuMJJ+njfkDKfJNtwQa1FIDIjYcLrF7h6lSkpbnS9PU9/BHtRrq1u1vSM2RaGQ1ePK2/t0WDY5nmyKt9wAzfhFcvrthAp0SnBskIIHAdoXS+k7ddhSjlR32wPHqOnl2lu1pJDWpap8N3DK6SgrxHR1kP8ypP4ZVkDZYwvr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1E68030000085;
	Sun, 25 Aug 2024 16:29:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E3915356236; Sun, 25 Aug 2024 16:29:34 +0200 (CEST)
Date: Sun, 25 Aug 2024 16:29:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <Zss_zqsJOZKes1Dp@wunner.de>
References: <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de>
 <20240516083017.GA1421138@black.fi.intel.com>
 <20240516100315.GC1421138@black.fi.intel.com>
 <CA+Y6NJH8vEHVtpVd7QB0UHZd=OSgX1F-QAwoHByLDjjJqpj7MA@mail.gmail.com>
 <ZnvWTo1M_z0Am1QC@wunner.de>
 <20240626085945.GA1532424@black.fi.intel.com>
 <ZqZmleIHv1q3WvsO@wunner.de>
 <20240729080441.GG1532424@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729080441.GG1532424@black.fi.intel.com>

On Mon, Jul 29, 2024 at 11:04:41AM +0300, Mika Westerberg wrote:
> On Sun, Jul 28, 2024 at 05:41:09PM +0200, Lukas Wunner wrote:
> > Do the DROMs on ICM root switches generally lack PCIe Upstream and
> > Downstream Adapter Entries?
> 
> My guess is that they are not populated for ICM host router DROM
> entries. These are pretty much Apple stuff and USB4 dropped them
> completely in favour of the router operations.

I note that Microsoft specifies a "usb4-port-number" for PCIe Downstream
Adapters as well as DP and USB ports:

https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers

Presumably the "usb4-port-number" allows for associating a
pci_dev with a tb_port.  So that's a third way to do that,
on top of DROM entries and the USB4 router operation.

What I don't quite understand is whether the "usb4-port-number"
is only present on PCIe Adapters of the Host Router or whether
it can also exist on PCIe Adapters of Device Routers?

I would also like to know whether "usb4-port-number" is set on
the machines that Esther's quirk seeks to fix?

I found this DSDT of an unknown Lenovo model which does not have
"usb4-port-number" set on any PCIe Adapters, only on USB ports:

https://gist.github.com/64kramsystem/ab2410f081a4f47d4a205699828ab2f9

I assumed that my solution to this problem would not be viable as
we seem to be lacking port numbers for Host Router PCIe Adapters.
Those are needed to associate a pci_dev with a tb_port on the
Host Router and adjust its "untrusted" and "external_facing"
properties.

However if we do have the "usb4-port-number" on Host Router
PCIe Adapters, then my solution would still be viable and
I could look into adding support for the "usb4-port-number"
property to it.

Thanks,

Lukas

