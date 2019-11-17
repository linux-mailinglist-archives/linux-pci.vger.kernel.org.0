Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404A1FFC54
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 00:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfKQXnX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Nov 2019 18:43:23 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46139 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKQXnU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Nov 2019 18:43:20 -0500
Received: by mail-io1-f68.google.com with SMTP id i11so5689316iol.13
        for <linux-pci@vger.kernel.org>; Sun, 17 Nov 2019 15:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gO7JzUs1xTIM39SPuA1vE59ZvFKWnOGozjWoKCw6sXM=;
        b=Az+/I7lHFbVkaqL0FbrZvY677NI4pv3eUdMA62AcQbO5wA8DkVp2aPGoeqPfNUHrfk
         ABbcIlJ3QZYcb2ZRXeOPWDoYZYdK7Hsd/IXtODfXxESV5YhUplhKbnDbA3XcvFhDCwqb
         KL7FtPqb5sqgz8GUYYLRUu/TwH7yyyqlNQZaBWsJKn7Oe9k7pjMsSk4zA/mPDXhKLba1
         JXQ06DOymgUDoRGDrI+OXJvFSy4c5ojZII3n8c1xCqkfJVeDdYSYBsBn5zGDSIz6cj3g
         9uAVPhrBop0Tf7I70i87w/avt6Azg7K2aB/jCR+nE0NPTKjmyCYL2O3b6eVnk4obuWFi
         9WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gO7JzUs1xTIM39SPuA1vE59ZvFKWnOGozjWoKCw6sXM=;
        b=e6cGcsx+PbP5BSl2BdPEEumNqUsQOSmt/JnF5LO0LSdbwt6NjjrudXHF4xYhXWuYS1
         cE7YspvRYYKlPFs0QBgVgzUcGMidB5UVy1YCA3GZQIrd7OYJjDawdDTRIbqwEUZHeG/5
         2hZ9nBf1ALzXBoR+/AXqpWBDEuz+sRLq3UNJ49MRM6XWlXHrQ/IATQRuVgqNzYfqrcKl
         da88GCsnRyX6UVC+Dzqqmep6NCnB2YGYdxviEoSTa5jezA9P78E90Icr8wufkYBwMV4V
         yYCqPFdKQTGcAj8RHEEM3SJS7RQkGv6gZ4/HWu2w+yCMAa9LMmLMoOplAmdk0x8hH/wy
         CROA==
X-Gm-Message-State: APjAAAVkQUVtf9PJLjUes7GC0Horcv/LmkqA+Sbn0DNFlvJUbjyaMFai
        giJeryodAmMlHnzD1XvhbLwxB8On8OktNZoS4Bjc2Q==
X-Google-Smtp-Source: APXvYqyP4+EazzeJvuLahCx5eNJx2OzlF33tiVwK2gEty2XmZRMI1J2A/D4UNEfOJ+qepdEtHRIpZaLePpX0plJOIJc=
X-Received: by 2002:a5d:938d:: with SMTP id c13mr5053836iol.159.1574034198746;
 Sun, 17 Nov 2019 15:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20190926112933.8922-1-kishon@ti.com>
In-Reply-To: <20190926112933.8922-1-kishon@ti.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Sun, 17 Nov 2019 18:43:08 -0500
Message-ID: <CAPoiz9x1LsXEeK2n98+4Rm9oTCiowrMUO5d6PPtc4SQG3mP9uA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] Implement NTB Controller using multiple PCI
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-ntb <linux-ntb@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 26, 2019 at 7:30 AM 'Kishon Vijay Abraham I' via linux-ntb
<linux-ntb@googlegroups.com> wrote:
>
> This series is sent as RFC since this series is dependent on
> [1] (cannot be merged before that series) and to get early review
> comments.
>
> I'll also split this series into smaller chunk when I post the
> next revision.
>
> This series is about implementing SW defined NTB using
> multiple endpoint instances. This series has been tested using
> 2 endpoint instances in J7 connected to two DRA7 boards.
>
> This was presented in Linux Plumbers Conference. The presentation
> can be found @ [2]
>
> This series:
>   *) Add support to define endpoint function using device tree
>   *) Add a specification for implementing NTB controller using
>      multiple endpoint instances.
>   *) Add a NTB endpoint function driver and a NTB host side PCI
>      driver that follows the specification.
>   *) Add support in PCIe endpoint core to support secondary
>      interface.
>   *) Add a device tree overlay file to configure J7 as NTB
>
> The test setup is something like below
>    +-------------+                                   +-------------+
>    |             |                                   |             |
>    |    DRA72    |                                   |    DRA76    |
>    |             |                                   |             |
>    +------^------+                                   +------^------+
>           |                                                 |
>           |                                                 |
> +---------|-------------------------------------------------|---------+
> |  +------v------+                                   +------v------+  |
> |  |             |                                   |             |  |
> |  |     EP      |                                   |     EP      |  |
> |  | CONTROLLER1 |                                   | CONTROLLER2 |  |
> |  |             <----------------------------------->             |  |
> |  |             |                                   |             |  |
> |  |             |                                   |             |  |
> |  |             |                 J7                |             |  |
> |  |             |  (Configured using NTB Function)  |             |  |
> |  +-------------+                                   +-------------+  |
> +---------------------------------------------------------------------+
>
> Here DRA72 and DRA76 could be replaced with *any* PCI host.
>
> EP side (J7):
> =============
>
> In the kernel:
>         cd /sys/kernel/config/pci_ep/
>         echo 1 > controllers/d800000.pcie-ep/start
>         echo 1 > controllers/d000000.pcie-ep/start
>
> RC side (DRA7):
> ===============
>         echo 0000:01:00.0 > /sys/bus/pci/devices/0000\:01\:00.0/driver/unbind
>         echo 0000:01:00.0 > /sys/bus/pci/drivers/ntb_hw_epf/bind
>         modprobe ntb_transport
>         modprobe ntb_netdev
>
> On each of the hosts Ethernet Interface will be created.
>
> Provide an IP address to each of the hosts:
> HOST1 (dra72):
> ifconfig eth2 192.168.1.2 up
>
> HOST2 (dra76):
> ifconfig eth2 192.168.1.1 up
>
> Once this is done standard network utilities like ping or iperf can be
> used.
>
> root@dra7xx-evm:~# iperf -c 192.168.1.2
> ------------------------------------------------------------
> Client connecting to 192.168.1.2, TCP port 5001
> TCP window size: 2.50 MByte (default)
> ------------------------------------------------------------
> [  3] local 192.168.1.1 port 60814 connected with 192.168.1.2 port 5001
> [ ID] Interval       Transfer     Bandwidth
> [  3]  0.0-10.0 sec   705 MBytes   591 Mbits/sec
>
> [1] -> http://lore.kernel.org/r/20190604131516.13596-1-kishon@ti.com
> [2] -> https://www.linuxplumbersconf.org/event/4/contributions/395/attachments/284/481/Implementing_NTB_Controller_Using_PCIe_Endpoint_-_final.pdf


I had a few nits, but I think this series looks good enough to be sent
out for inclusion.

Thanks,
Jon

> Kishon Vijay Abraham I (21):
>   dt-bindings: PCI: Endpoint: Add DT bindings for PCI EPF Bus
>   dt-bindings: PCI: Endpoint: Add DT bindings for PCI EPF Device
>   dt-bindings: PCI: Endpoint: Add DT bindings for PCI EPF NTB Device
>   Documentation: PCI: Add specification for the *PCI NTB* function
>     device
>   PCI: endpoint: Add API to get reference to EPC from device-tree
>   PCI: endpoint: Add API to create EPF device from device tree
>   PCI: endpoint: Add "pci-epf-bus" driver
>   PCI: endpoint: Make *_get_first_free_bar() take into account 64 bit
>     BAR
>   PCI: endpoint: Add helper API to get the 'next' unreserved BAR
>   PCI: endpoint: Make pci_epf_driver ops optional
>   PCI: endpoint: Add helper API to populate header with values from DT
>   PCI: endpoint: Add support to associate secondary EPC with EPF
>   PCI: endpoint: Add pci_epc_ops to map MSI irq
>   PCI: cadence: Implement ->msi_map_irq() ops
>   PCI: endpoint: Remove unused pci_epf_match_device()
>   PCI: endpoint: Fix missing mutex_unlock in error case
>   PCI: endpoint: *_free_bar() to return error codes on failure
>   PCI: endpoint: Add EP function driver to provide NTB functionality
>   PCI: Add TI J721E device to pci ids
>   NTB: Add support for EPF PCI-Express Non-Transparent Bridge
>   NTB: tool: Enable the NTB/PCIe link on the local or remote side of
>     bridge
>
>  Documentation/PCI/endpoint/pci-test-ntb.txt   |  315 +++++
>  .../bindings/pci/endpoint/pci-epf-bus.txt     |   27 +
>  .../bindings/pci/endpoint/pci-epf-ntb.txt     |   31 +
>  .../bindings/pci/endpoint/pci-epf.txt         |   28 +
>  drivers/ntb/hw/Kconfig                        |    1 +
>  drivers/ntb/hw/Makefile                       |    1 +
>  drivers/ntb/hw/epf/Kconfig                    |    5 +
>  drivers/ntb/hw/epf/Makefile                   |    1 +
>  drivers/ntb/hw/epf/ntb_hw_epf.c               |  648 ++++++++++
>  drivers/ntb/test/ntb_tool.c                   |    1 +
>  drivers/pci/controller/pcie-cadence-ep.c      |   59 +
>  drivers/pci/endpoint/Makefile                 |    3 +-
>  drivers/pci/endpoint/functions/Kconfig        |   12 +
>  drivers/pci/endpoint/functions/Makefile       |    1 +
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 1143 +++++++++++++++++
>  drivers/pci/endpoint/functions/pci-epf-test.c |   12 +-
>  drivers/pci/endpoint/pci-ep-cfs.c             |    6 +-
>  drivers/pci/endpoint/pci-epc-core.c           |  221 +++-
>  drivers/pci/endpoint/pci-epf-bus.c            |   54 +
>  drivers/pci/endpoint/pci-epf-core.c           |  133 +-
>  include/linux/pci-epc.h                       |   42 +-
>  include/linux/pci-epf.h                       |   35 +-
>  include/linux/pci_ids.h                       |    1 +
>  23 files changed, 2715 insertions(+), 65 deletions(-)
>  create mode 100644 Documentation/PCI/endpoint/pci-test-ntb.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt
>  create mode 100644 drivers/ntb/hw/epf/Kconfig
>  create mode 100644 drivers/ntb/hw/epf/Makefile
>  create mode 100644 drivers/ntb/hw/epf/ntb_hw_epf.c
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-ntb.c
>  create mode 100644 drivers/pci/endpoint/pci-epf-bus.c
>
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20190926112933.8922-1-kishon%40ti.com.
