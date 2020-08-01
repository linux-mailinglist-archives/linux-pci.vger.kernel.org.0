Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E68E235337
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 18:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgHAQOI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Aug 2020 12:14:08 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:46217 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgHAQOH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2020 12:14:07 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 8C7A328004995;
        Sat,  1 Aug 2020 18:14:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 629A0372B5; Sat,  1 Aug 2020 18:14:05 +0200 (CEST)
Date:   Sat, 1 Aug 2020 18:14:05 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ian May <ian.may@canonical.com>
Cc:     linux-pci@vger.kernel.org, Keith Busch <keith.busch@wdc.com>
Subject: Re: [PATCH 1/2] PCIe hotplug interrupt and AER deadlock with
 reset_lock and device_lock
Message-ID: <20200801161405.bww7kvcfj5lrcso4@wunner.de>
References: <20200615143250.438252-1-ian.may@canonical.com>
 <20200615143250.438252-2-ian.may@canonical.com>
 <20200615185650.mzxndbw7ghvh5qiv@wunner.de>
 <0598848d-47ab-f436-04ea-7ef1f348905b@canonical.com>
 <20200717052000.vsyvbnwbhni4iy6y@wunner.de>
 <CAE1ug=a8PJpKh0Jx2ZZxo5kwQvvK883xs+mzyMWbW8T1oqyKDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE1ug=a8PJpKh0Jx2ZZxo5kwQvvK883xs+mzyMWbW8T1oqyKDg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc += Keith]

On Fri, Jul 17, 2020 at 09:02:22AM -0500, Ian May wrote:
> I do now have a "better" patch that I was going to submit to the list
> where I converted the pci_slot_mutex to a rw_semaphore.  Do you see
> any potential problems with changing the lock type?  I attached the
> patch if you are interested in checking it over.

The question is, if pci_slot_mutex is an rw_semaphore, can it happen
that pciehp acquires it for writing, provoking a deadlock like this:

        Hotplug                                AER
	----------------------------       ---------------------------
      1 down_read(&ctrl->reset_lock)
	                                 2 down_read(&pci_slot_mutex)
      3 down_write(&pci_slot_mutex)
                                         4 down_write(&ctrl->reset_lock)
	** DEADLOCK **

I think this can happen if the device inserted into the hotplug slot
contains a PCIe switch which itself has hotplug ports.  That's the
case with Thunderbolt:  Every Thunderbolt device contains a PCIe
switch with hotplug ports to extend the Thunderbolt chain.  E.g.
the PCIe hierarchy looks like this for a Thunderbolt host controller
with a chain of two devices:

Root - Upstream - Downstream - Upstream - Downstream - Upstream - Downstream

(host ...)                     (1st device ...)        (2nd device ...)

When a Thunderbolt device is attached, pci_slot_mutex would be taken
for writing in pci_create_slot():

pciehp_configure_device()
  pci_scan_slot()
    pci_scan_single_device()
      pci_scan_device()
            pci_setup_device()
                pci_dev_assign_slot() # acquire pci_slot_mutex for reading
        pci_device_add() # match_driver = false; device_add()
    pci_bus_add_devices()
      pci_bus_add_device() # match_driver = true;  device_attach()
        device_attach()
          __device_attach()
            __device_attach_driver()
              driver_probe_device()
                pcie_portdrv_probe()
                  pcie_port_device_register()
                    pcie_device_init()
                      device_register()
                        device_add()
                          bus_probe_device()
                            device_initial_probe()
                              __device_attach()
                                __device_attach_driver()
                                  driver_probe_device()
                                    pciehp_probe()
                                      init_slot()
				        pci_hp_initialize()
					  pci_create_slot()
					    down_write(pci_slot_mutex)

(You may want to double-check that I got this right.)

In principle, Keith did the right thing to acquire pci_slot_mutex in
pci_bus_error_reset() for accessing the bus->slots list.

I need to think some more to come up with a solution for this particular
deadlock.  Maybe using a klist and traversing it with klist_iter_init()
(holds a ref on each slot, allowing concurrent list access) or something
along those lines...

Thanks,

Lukas
