Return-Path: <linux-pci+bounces-6899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D568B7D17
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 18:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BB11F21A25
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF7817F390;
	Tue, 30 Apr 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pD4vRHaL"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC91802AB;
	Tue, 30 Apr 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494790; cv=none; b=rpZMVVRcKQLLphqrjmAaJt3aV5qQNOkrjjjYOHSYmu2KuGJ5QAxa2scHOIKCBPvhmY60FJRy9z7k7UL8o9gc62dSs1ewHACl98pieWqvA09jHcTUIF1LZ3BizsHZRBUEnd/d048dk3HWBXiEvnWN//freFXgi3VYUHiJUv5Uu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494790; c=relaxed/simple;
	bh=2l9At3Rp5SxGzMz7kyLqL/eq/W5Zy3EozaXiK/uejhE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chCak1bls3CfrqUHB7KwkhRwX5EHrvVCqccYwknHBul+trhKGqDXf5pJjupc+aBE0F8r3syUbIFSQKom5H1g9aVX60z0f6UQ5oQCNxmeWqmq7La+upcdp3liTBqgPqjFt6z9gLVBcQB6KP7uhCVdl07lDuiJfJQwjYfvoZmOtAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pD4vRHaL; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFC8020002;
	Tue, 30 Apr 2024 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714494786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6dwRYW34S8P17vH5XtXPm9HMUxIxV6qRAOkld5Rx8tE=;
	b=pD4vRHaLymllfg0enq0ckdTh0OfXfYFtd4pVL1kWnOQRKiaqG9KikcdmJGbFdNAdJ4y+Uk
	HSiK6RSIWe7M6dI0nB4ZrLMD4+bDxl4uYNZw04CEXdgHv87LKw04ySU1W+CQjsuY4Efeq2
	MmO4ywAzfKPoJwqkSaGHEaC1AK8izw7s/QswydY7bBAhbUT1ttklmJ5GK8bu3FrYFfrbdf
	5rxUN+9oP5MvAEVAMkaFFnq5viDSN35lc6J0LRhNyPnF7x33rcxA5eGmaPOFpAeg08U5Z9
	VPV3FiXS0h/7kJVwWV/kJSxcW5RarNmQ3TG9DZFR5ualYpbrXM3SkeLOHNwpZQ==
Date: Tue, 30 Apr 2024 18:33:01 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Saravana Kannan
 <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 00/17] Add support for the LAN966x PCI device using a DT
 overlay
Message-ID: <20240430183301.46568e35@bootlin.com>
In-Reply-To: <4571846d-2001-4bbf-b311-d0b42844143d@lunn.ch>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
	<4571846d-2001-4bbf-b311-d0b42844143d@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Andrew,

On Tue, 30 Apr 2024 15:40:16 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Apr 30, 2024 at 10:37:09AM +0200, Herve Codina wrote:
> > Hi,
> > 
> > This series adds support for the LAN966x chip when used as a PCI
> > device.  
> 
> > This patch series for now adds a Device Tree overlay that describes an
> > initial subset of the devices available over PCI in the LAN996x, and
> > follow-up patch series will add support for more once this initial
> > support has landed.  
> 
> What host systems have you tested with? Are they all native DT, or
> have you tested on an ACPI system? I'm just wondering how well DT
> overlay works if i were to plug a LAN966x device into something like
> an x86 ComExpress board?

I tested on a native DT system (marvell board).

Also I tested on a x86 system (basically a simple PC).
Not all components are available upstream to have it working on a x86 (ACPI)
system. The missing component is not related to the LAN966x PCI driver itself
but in the way DT node are created up to the PCI device.
A DT node at PCI device is needed to have a DT node parent (target) for the
overlay.
The DT node chain is also important because BARs address translations are
done using the 'ranges' property available in each node in the chain.

On a full DT system, the DT looks like (simplified in naming and without the
node properties):
/
  soc {
    ...
    pci_root_bridge {  <-- Present in base dts
       pci_to_pci_bridge {  <-- Created at runtime based on PCI enumeration
            pci_device {  <-- Created at runtime based on PCI enumeration
            }
       }
       pci_device { <-- Created at runtime based on PCI enumeration
       };
    };
  };

On x86:
- A DT root empty node is created.
  This is already upstream from a first proposal [1] and then second one [2].
- PCI-to-PCI bridge and device DT nodes are created at runtime.
  This is the same on DT base systems and this feature is available upstream
  too (last proposal at [3]).

The DT node missing in the chain is the node for the PCI root bridge.
On ACPI, no "base" dts describes this node. The PCI root bridge is described
by ACPI.

I have some draft code that create this DT node when a PCI host bridge is
register if a DT node is not already present and so fill the hole in the DT
node chain.
With that the DT in an ACPI system looks like this:
/
  pci_root_bridge {  <-- Created at runtime when a PCI host bridge is registered
     pci_to_pci_bridge {  <-- Created at runtime based on PCI enumeration
          pci_device {  <-- Created at runtime based on PCI enumeration
          }
     }
     pci_device { <-- Created at runtime based on PCI enumeration
     };
  };

With this node added, the driver works the same way in both DT and ACPI
systems without any modification.

I plan to send the code creating the PCI host bridge node when this current
series is landed in order to add support for DT overlay over PCI on x86
systems.

Also an other series (under review [4]) is needed to avoid struct device
duplication related to the DT nodes creation.

[1] https://lore.kernel.org/lkml/20230317053415.2254616-1-frowand.list@gmail.com/#r
[2] https://lore.kernel.org/lkml/20240217010557.2381548-1-sboyd@kernel.org/
[3] https://lore.kernel.org/lkml/1692120000-46900-1-git-send-email-lizhi.hou@amd.com/
[4] https://lore.kernel.org/lkml/20240423145703.604489-1-herve.codina@bootlin.com/

Best regards,
Hervé

