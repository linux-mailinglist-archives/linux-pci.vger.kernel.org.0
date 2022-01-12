Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2EF48CA63
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 18:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344086AbiALRtU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 12:49:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43850 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344275AbiALRtS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 12:49:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5DBC6194C
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 17:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3ABBC36AEA;
        Wed, 12 Jan 2022 17:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642009757;
        bh=utF7QZ/ddbQucUvx3ZScm6SbpTl0j63CwCiu5r3iwDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ITkWZ7LO/3OQagvHoQtERKo5uhU5/RMkPBOJxzwDz+3IIME0s8+rQF2cNLL6ZaoGT
         YAjoMKxCVAC1FJl+VXEQKCwe7ofPfXs1f4xuMA5z81WbOD608JTCdCVvBuSrZVwmJR
         LJGNfkJPKXbbPWQaW05yYbWBNGelc5c3tY/eT9pyXAlkXL54ozK7ktjVEuD9XfuxNA
         7E96Fey+ZwIIVkh2ZhvMYbRNgCQQJEjhlP0qC0lmwEbHC61PjR6yvk+RQgr/BSrTfF
         IvAT8rpiaYALqYiyHq0RUHkUCeIY/h4Ov/33FM5ZCVNkXaGlFcnQOolnCNIknbr5gJ
         k+zYr7QZSezGg==
Date:   Wed, 12 Jan 2022 11:49:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: PCIe AER generates no interrupts on host (ZynqMP)
Message-ID: <20220112174915.GA264064@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58225f13-d6b5-8634-508f-d3654136bc1f@denx.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, mentioned 2bd50dd800b5 again]

On Tue, Jan 11, 2022 at 09:14:13AM +0100, Stefan Roese wrote:
> On 1/10/22 13:16, Stefan Roese wrote:
> > On 1/7/22 11:04, Pali Rohár wrote:
> > > Hello! You asked me in another email for comments to this email, so I'm
> > > replying directly to this email...
> > 
> > Thanks a lot for you input here. Please find some comments below...
> > 
> > > On Tuesday 04 January 2022 10:02:18 Stefan Roese wrote:
> > > > Hi,
> > > > 
> > > > I'm trying to get the Kernel PCIe AER infrastructure to work
> > > > on my ZynqMP based system. E.g. handle the events
> > > > (correctable, uncorrectable etc). In my current tests, no AER
> > > > interrupt is generated though. I'm currently using the
> > > > "surprise down error status" in the uncorrectable error status
> > > > register of the connected PCIe switch (PLX / Broadcom
> > > > PEX8718). Here the bit is correctly logged in the PEX switch
> > > > uncorrectable error status register but no interrupt is
> > > > generated to the root-port / system. And hence no AER
> > > > message(s) reported.
> > > > 
> > > > Does any one of you have some ideas on what might be missing?
> > > > Why are these events not reported to the PCIe rootport driver
> > > > via IRQ? Might this be a problem of the missing MSI-X support
> > > > of the ZynqMP? The AER interrupt is connected as legacy IRQ:
> > > > 
> > > > cat /proc/interrupts | grep -i aer
> > > >   58:          0          0          0          0 
> > > > nwl_pcie:legacy   0 Level
> > > > PCIe PME, aerdrv
> > > 
> > > Error events (correctable, non-fatal and fatal) are reported by
> > > PCIe devices to the Root Complex via PCIe error messages
> > > (Message code of TLP is set to Error Message) and not via
> > > interrupts. Root Port is then responsible to "convert" these
> > > PCIe error messages to MSI(X) interrupt and report it to the
> > > system. According to PCIe spec, AER is supported only via MSI(X)
> > > interrupts, not legacy INTx.
> > 
> > This seems not correct. From the ML link reported by Bjorn, there
> > seems to be a platform specific interrupt on ZynqMP, to report the
> > AER events.  At least this is how I interpret the patch from
> > Bharat from that time.  In the meantime Bharat from Xilinx has
> > sent me a link to a newer, updated patch series to use this "misc"
> > interrupts for AER instead. I'll get into more details on this in
> > another reply.
> > 
> > > Via Bridge Control register (SERR# enable bit) on the Root Port
> > > it is possible to enable / disable reporting of these errors
> > > from PCIe devices on the other end of PCIe link to the system.
> > 
> > Here the BridgeCtl of the Root Port:
> >    BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> > 
> > > Then via Command register (SERR# enable bit) and Device Control
> > > register it is possible to enable / disable reporting of all
> > > errors (from Root Port and also devices on other end of the
> > > link).
> > 
> > The command registers have SERR disabled on all PCIe devices:
> >    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> > Stepping- SERR- FastB2B- DisINTx-
> > 
> > Not sure if this is a problem. I would expect the Kernel PCI subsystem
> > and the AER driver to enable the necessary bits. So is 'SERR-' here
> > a problem?
> > 
> > Device Control has the error reporting enabled:
> >    DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
> 
> A small update on this:
> 
> Just now I noticed, that these bits in the DevCtl register are
> disabled in the PCIe switch setup downstream and upstream ports.
> Actually, these bits are only enabled in the root port PCIe device.
> After enabling these bits via setpci in the PEX switch the surprise
> down message is reported correctly to the root port:
> 
>  nwl-pcie fd0e0000.pcie: Fatal Error in AER Capability
>  pcieport 0000:02:02.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>  pcieport 0000:02:02.0:   device [10b5:8718] error status/mask=00000020/00000000
>  pcieport 0000:02:02.0:    [ 5] SDES                   (First)
> 
> Nice! :)
> 
> So the question now is, why are these bits in the DevCtl registers of
> these other PCIe devices disabled? Debugging shows that
> get_port_device_capability() calls pci_disable_pcie_error_reporting()
> *after* it has been enabled via the AER driver:
> 
>  pcieport 0000:00:00.0: get_port_device_capability (225): pcie_ports_native=1 host->native_aer=1
>  pcieport 0000:00:00.0: AER: pci_disable_pcie_error_reporting (246): rc=0
>  pcieport 0000:00:00.0: AER: set_device_error_reporting (1218): enable=1
>  pcieport 0000:00:00.0: AER: pci_enable_pcie_error_reporting (233): rc=0
>  pci 0000:01:00.0: AER: set_device_error_reporting (1218): enable=1
>  pci 0000:01:00.0: AER: pci_enable_pcie_error_reporting (233): rc=0
>  pci 0000:02:01.0: AER: set_device_error_reporting (1218): enable=1
>  pci 0000:02:01.0: AER: pci_enable_pcie_error_reporting (233): rc=0
>  pci 0000:02:02.0: AER: set_device_error_reporting (1218): enable=1
>  pci 0000:02:02.0: AER: pci_enable_pcie_error_reporting (233): rc=0
>  pci 0000:04:00.0: AER: set_device_error_reporting (1218): enable=1
>  pci 0000:02:03.0: AER: set_device_error_reporting (1218): enable=1
>  pci 0000:02:03.0: AER: pci_enable_pcie_error_reporting (233): rc=0
>  pcieport 0000:01:00.0: get_port_device_capability (225): pcie_ports_native=1 host->native_aer=1
>  pcieport 0000:01:00.0: AER: pci_disable_pcie_error_reporting (246): rc=0

Ah.  I assume you have:

  00:00.0 Root Port to [bus 01-??]
  01:00.0 Switch Upstream Port to [bus 02-??]
  02:0?.0 Switch Downstream Port to [bus 04-??]

pcie_portdrv_probe() claims 00:00.0 and clears CERE NFERE FERE URRE.

aer_probe() claims 00:00.0 and enables CERE NFERE FERE URRE for all
downstream devices, including 01:00.0.

pcie_portdrv_probe() claims 01:00.0 and clears CERE NFERE FERE URRE
again.

aer_probe() declines to claim 01:00.0 because it's not a Root Port, so
CERE NFERE FERE URRE remain cleared.

>  pcieport 0000:02:01.0: get_port_device_capability (225): pcie_ports_native=1 host->native_aer=1
>  pcieport 0000:02:01.0: AER: pci_disable_pcie_error_reporting (246): rc=0
>  pcieport 0000:02:02.0: get_port_device_capability (225): pcie_ports_native=1 host->native_aer=1
>  pcieport 0000:02:02.0: AER: pci_disable_pcie_error_reporting (246): rc=0
>  pcieport 0000:02:03.0: get_port_device_capability (225): pcie_ports_native=1 host->native_aer=1
>  pcieport 0000:02:03.0: AER: pci_disable_pcie_error_reporting (246): rc=0
> 
> Looking at the comment in get_port_device_capability() this might be the
> wrong order (e.g. AER driver enabling vs pcieport disabling):
> 
> static int get_port_device_capability(struct pci_dev *dev)
> ...
> 		/*
> 		 * Disable AER on this port in case it's been enabled by the
> 		 * BIOS (the AER service driver will enable it when necessary).
> 		 */
> 		pci_disable_pcie_error_reporting(dev);
> 	}
> 
> I'll look deeper into this today. But perhaps someone else has a quick
> idea already?

This was added by 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services
during port initialization").  Strangely, this same 11 year old commit
came up yesterday [1] :)

I'm not 100% convinced that get_port_device_capability() should be
calling pci_disable_pcie_error_reporting().  IMO, BIOS should not
leave an interrupt enabled unless it has arranged to handle it.

It's true that disabling it might work around a BIOS bug.  But the
usual reason we call pci_disable_pcie_error_reporting() here is
because host->native_aer is true, and that is usually because
CONFIG_PCIEAER is set (and, for ACPI systems, _OSC granted us control
of AER).  That means we're going to call aer_probe(), which should
enable or disable AER interrupts as it needs.

So I'm curious whether just removing that call (and removing
"pcie_ports=native" if you're using it) helps in your case.

I assume this is probably not an ACPI system, right?  Are you testing
with Bharat's series [2] applied?

Bjorn

[1] https://lore.kernel.org/r/20220111185538.GA152548@bhelgaas
[2] https://lore.kernel.org/r/20220112094251.1271531-1-sr@denx.de

My notes on the call tree in case they're useful for anybody:

  pcie_portdrv_init                   # device_initcall
    pcie_init_services
      pcie_aer_init
        pcie_port_service_register(&aerdriver)
    pci_register_driver(&pcie_portdrive)

  pcie_portdrv_probe
    pcie_port_device_register
      get_port_device_capability
        pci_disable_pcie_error_reporting
          clear CERE NFERE FERE URRE
      pcie_device_init
        device_register               # new service device, available for binding
          ...
            aer_probe                 # driver for new service device

  aer_probe
    if (!PCI_EXP_TYPE_ROOT_PORT)
      return -ENODEV
    aer_enable_rootport
      set_downstream_devices_error_reporting
        pci_walk_bus
          set_device_error_reporting
            pci_enable_pcie_error_reporting
              set CERE NFERE FERE URRE

