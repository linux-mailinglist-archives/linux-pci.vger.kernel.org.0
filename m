Return-Path: <linux-pci+bounces-39034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9EFBFCE5F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 17:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB9814FCA7B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A70207A22;
	Wed, 22 Oct 2025 15:30:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491422FE15
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147035; cv=none; b=RP2CMqhFnT7ZH2jKmn+tOD2Y7kb/7f7hwvCKyJ/58ZAMnt4hbPwzqTIFBNVhPh4sm5ga+td+jwPC/VyMiIMQi48ZCvVgA3ZpYGLnSm4COQRyGfkYs1TEmvBlwHGatFCDuNsIi4xYWPnuz/NpbuU6f0qQV9/C3eFzu/Hc7TTvH5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147035; c=relaxed/simple;
	bh=8wduVmAPO0yu/HOzcMp/89mbcuv1uxcIlZk4nH88Oyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaFUmMJEvNGJ7D4sz1XFq6NxXHUvBiRCLhtqhdcvZCIpAybqNEntPGfIeUqBs1kLRrYs6LoY9UQpgxl4Kj+QDH7xZVHbP84IToCkJ88lv7wzE2Y02M3rpRWI4AYvGFtHp+sUQr8NUr1n2/qQS0wawOaADuUqRyEBj4ZyXQrKdus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 52CA52C06430;
	Wed, 22 Oct 2025 17:30:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 41EEE4A12; Wed, 22 Oct 2025 17:30:25 +0200 (CEST)
Date: Wed, 22 Oct 2025 17:30:25 +0200
From: Lukas Wunner <lukas@wunner.de>
To: =?iso-8859-1?Q?Adri=E0_Vilanova_Mart=EDnez?= <me@avm99963.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, regressions@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] Intel Wireless adapter is not detected until
 suspending to RAM and resuming
Message-ID: <aPj4kUglHgBm4uAt@wunner.de>
References: <149b04c5-23d3-4fd8-9724-5b955b645fbb@kernel.org>
 <20251020232510.GA1167305@bhelgaas>
 <aPc4JpVyhCY1Oqd-@wunner.de>
 <zmkurgnjb4zw7zcg6uucbtvuratxlaau5lvhkgknidpjz7vnb7@dnsyjbrqtvqw>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zmkurgnjb4zw7zcg6uucbtvuratxlaau5lvhkgknidpjz7vnb7@dnsyjbrqtvqw>

On Tue, Oct 21, 2025 at 03:35:42PM +0200, Adrià Vilanova Martínez wrote:
> [    0.220045] pcieport 0000:00:1c.0: pciehp: Slot Status            : 0x0048

In the working case (without 4d4c10f763d7), there's a stale
Presence Detect Changed event in the Slot Status register.
The event is cleared by pcie_init() prior to enabling interrupts.
However the event immediately re-appears:

> [    0.220308] pcieport 0000:00:1c.0: pciehp: pcie_enable_notification: SLOTCTRL 58 write cmd 1028
> [    0.220316] pcieport 0000:00:1c.0: pciehp: pending interrupts 0x0008 from Slot Status

I also note that in the working case there are a bunch of
Correctable Errors reported through AER several times in the log:

> [    1.949940] pcieport 0000:00:1c.0: AER: Multiple Correctable error message received from 0000:00:1c.0
> [    1.949950] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
> [    1.949955] pcieport 0000:00:1c.0:   device [8086:9d10] error status/mask=00000001/00002000
> [    1.949960] pcieport 0000:00:1c.0:    [ 0] RxErr                  (First)

Now here's the kicker:

Looking at the ASPM configuration in the lspci output you've provided,
I note that after booting without 4d4c10f763d7, ASPM is disabled on
the Root Port but L1 is enabled on the Wifi card!

After resuming from system sleep, ASPM is disabled on both of them
(with and without 4d4c10f763d7).

I suspect the incongruence of ASPM settings between Root Port and
Wifi card is the root cause of the Presence Detect Changed flaps
as well as the Correctable Errors.  I guess the BIOS set these
incorrectly.  Looking at the code in:

pcie_aspm_init_link_state()
  pcie_aspm_cap_init()

... it first disables L0s and L1 to initialize L1 substates,
then restores the register values as they were set by BIOS.
This feels wrong.  The safest option is probably to instead
disable L0s and/or L1 if either of them was only enabled
on one of the two link partners.

pcie_aspm_init_link_state() later does call pcie_config_aspm_path(),
which should rectify incongruent settings.  But it's only called
if the aspm_policy is something else than POLICY_POWERSAVE and
POLICY_POWER_SUPERSAVE.

Which policy is set in your kernel configuration?
(Search for CONFIG_PCIEASPM_...)

Does setting it to CONFIG_PCIEASPM_PERFORMANCE change the behavior?

With 4d4c10f763d7, the Wifi card falls off the bus and the link never
comes back.  I don't know why the commit is causing that.  As Mario
suggested, it may be caused by the platform.  Could you provide an
acpidump for further analysis?  The usual way to share large blobs
like this (as well as dmesg and lspci output) is by opening a bug
on bugzilla.kernel.org and attaching it there.

Thanks,

Lukas

