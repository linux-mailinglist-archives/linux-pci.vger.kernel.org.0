Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0B9269027
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 17:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgINPiT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 11:38:19 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55578 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgINPhs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 11:37:48 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08EFbStm060262;
        Mon, 14 Sep 2020 10:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600097848;
        bh=IscYVn9/1Ngh3jqm3W1TxrrkC1/VilWwlvxLwV2qJkA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ptoiWDcMI/O6OyCAG9i/k/5+FBmUV4OLB8bxb6cUjvik3ezsX+LtCJsHiQVqKgyRa
         1Bkn6603SDu0m0TXQzfB2G/L/OkVzMzc4qL+vy6KHmLG1YEBqnxzDb5xDUBW7qXSqp
         g3tqqaIJ164mcYpkQfvLN4oJ7rH6WShykKXFk4O0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08EFbSXi080492;
        Mon, 14 Sep 2020 10:37:28 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Sep 2020 10:36:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Sep 2020 10:36:14 -0500
Received: from [10.250.232.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08EFa8FJ102628;
        Mon, 14 Sep 2020 10:36:09 -0500
Subject: Re: [PATCH v3 17/17] Documentation: PCI: Add userguide for PCI
 endpoint NTB function
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Rob Herring <robh@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ntb@googlegroups.com>
References: <20200904075052.8911-1-kishon@ti.com>
 <20200904075052.8911-18-kishon@ti.com>
 <f16f5a90-13c1-bfc6-ad83-1c6becbf1629@infradead.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c06d2a12-6533-361e-a0c8-9faa62abd8f0@ti.com>
Date:   Mon, 14 Sep 2020 21:06:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f16f5a90-13c1-bfc6-ad83-1c6becbf1629@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Randy,

On 06/09/20 3:38 am, Randy Dunlap wrote:
> On 9/4/20 12:50 AM, Kishon Vijay Abraham I wrote:
>> Add documentation to help users use pci-epf-ntb function driver and
>> existing host side NTB infrastructure for NTB functionality.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  Documentation/PCI/endpoint/index.rst         |   1 +
>>  Documentation/PCI/endpoint/pci-ntb-howto.rst | 160 +++++++++++++++++++
>>  2 files changed, 161 insertions(+)
>>  create mode 100644 Documentation/PCI/endpoint/pci-ntb-howto.rst
> 
> Hi,
> There are a few edits below:

Thanks for reviewing. I'll fix and post a new revision.

Thanks
Kishon

> 
> 
>> diff --git a/Documentation/PCI/endpoint/pci-ntb-howto.rst b/Documentation/PCI/endpoint/pci-ntb-howto.rst
>> new file mode 100644
>> index 000000000000..2fbb0a051c3b
>> --- /dev/null
>> +++ b/Documentation/PCI/endpoint/pci-ntb-howto.rst
>> @@ -0,0 +1,160 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +======================
>> +PCI NTB EPF User Guide
>> +======================
>> +
>> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
>> +
>> +This document is a guide to help users use pci-epf-ntb function driver
>> +and ntb_hw_epf host driver for NTB functionality. The list of steps to
>> +be followed in the host side and EP side is given below. For the hardware
>> +configuration and internals of NTB using configurable endpoints see
>> +Documentation/PCI/endpoint/pci-ntb-function.rst
>> +
>> +Endpoint Device
>> +===============
>> +
>> +Endpoint Controller Devices
>> +---------------------------
>> +
>> +For implementing NTB functionality atleast two endpoint controller devices
> 
>                                       at least
> 
>> +are required.
>> +To find the list of endpoint controller devices in the system::
>> +
>> +        # ls /sys/class/pci_epc/
>> +          2900000.pcie-ep  2910000.pcie-ep
>> +
>> +If PCI_ENDPOINT_CONFIGFS is enabled::
>> +
>> +	# ls /sys/kernel/config/pci_ep/controllers
>> +	  2900000.pcie-ep  2910000.pcie-ep
>> +
>> +
>> +Endpoint Function Drivers
>> +-------------------------
>> +
>> +To find the list of endpoint function drivers in the system::
>> +
>> +	# ls /sys/bus/pci-epf/drivers
>> +	  pci_epf_ntb   pci_epf_ntb
>> +
>> +If PCI_ENDPOINT_CONFIGFS is enabled::
>> +
>> +	# ls /sys/kernel/config/pci_ep/functions
>> +	  pci_epf_ntb   pci_epf_ntb
>> +
>> +
>> +Creating pci-epf-ntb Device
>> +----------------------------
>> +
>> +PCI endpoint function device can be created using the configfs. To create
>> +pci-epf-ntb device, the following commands can be used::
>> +
>> +	# mount -t configfs none /sys/kernel/config
>> +	# cd /sys/kernel/config/pci_ep/
>> +	# mkdir functions/pci_epf_ntb/func1
>> +
>> +The "mkdir func1" above creates the pci-epf-ntb function device that will
>> +be probed by pci_epf_ntb driver.
>> +
>> +The PCI endpoint framework populates the directory with the following
>> +configurable fields::
>> +
>> +	# ls functions/pci_epf_ntb/func1
>> +          baseclass_code    deviceid          msi_interrupts    pci-epf-ntb.0
>> +          progif_code       secondary         subsys_id         vendorid
>> +          cache_line_size   interrupt_pin     msix_interrupts   primary
>> +          revid             subclass_code     subsys_vendor_id
>> +
>> +The PCI endpoint function driver populates these entries with default values
>> +when the device is bound to the driver. The pci-epf-ntb driver populates
>> +vendorid with 0xffff and interrupt_pin with 0x0001::
>> +
>> +	# cat functions/pci_epf_ntb/func1/vendorid
>> +	  0xffff
>> +	# cat functions/pci_epf_ntb/func1/interrupt_pin
>> +	  0x0001
>> +
>> +
>> +Configuring pci-epf-ntb Device
>> +-------------------------------
>> +
>> +The user can configure the pci-epf-ntb device using configfs entry. In order
> 
>                                                  using its configfs entry.
> 
>> +to change the vendorid and the deviceid, the following
>> +commands can be used::
>> +
>> +	# echo 0x104c > functions/pci_epf_ntb/func1/vendorid
>> +	# echo 0xb00d > functions/pci_epf_ntb/func1/deviceid
>> +
>> +In-order to configure NTB specific attributes, a new sub-directory to func1
> 
>    In order
> 
>> +should be created::
>> +
>> +	# mkdir functions/pci_epf_ntb/func1/pci_epf_ntb.0/
>> +
>> +The NTB function driver will populate this directory with various attributes
>> +that can be configured by the user::
>> +
>> +	# ls functions/pci_epf_ntb/func1/pci_epf_ntb.0/
>> +          db_count    mw1         mw2         mw3         mw4         num_mws
>> +          spad_count
>> +
>> +A sample configuration for NTB function is given below::
>> +
>> +	# echo 4 > functions/pci_epf_ntb/func1/pci_epf_ntb.0/db_count
>> +	# echo 128 > functions/pci_epf_ntb/func1/pci_epf_ntb.0/spad_count
>> +	# echo 2 > functions/pci_epf_ntb/func1/pci_epf_ntb.0/num_mws
>> +	# echo 0x100000 > functions/pci_epf_ntb/func1/pci_epf_ntb.0/mw1
>> +	# echo 0x100000 > functions/pci_epf_ntb/func1/pci_epf_ntb.0/mw2
>> +
>> +Binding pci-epf-ntb Device to EP Controller
>> +--------------------------------------------
>> +
>> +NTB function device should be attached to two PCIe endpoint controllers
>> +connected to the two hosts. Use the 'primary' and 'secondary' entries
>> +inside NTB function device to attach one PCIe endpoint controller to
>> +primary interface and the other PCIe endpoint controller to the secondary
>> +interface. ::
>> +
>> +        # ln -s controllers/2900000.pcie-ep/ functions/pci-epf-ntb/func1/primary
>> +        # ln -s controllers/2910000.pcie-ep/ functions/pci-epf-ntb/func1/secondary
>> +
>> +Once the above step is completed, both the PCI endpoint controllers is ready to
> 
>                                                                        are ready
> 
>> +establish a link with the host.
>> +
>> +
>> +Start the Link
>> +--------------
>> +
>> +In order for the endpoint device to establish a link with the host, the _start_
>> +field should be populated with '1'. For NTB, both the PCIe endpoint controllers
>> +should establish link with the host::
>> +
>> +        #echo 1 > controllers/2900000.pcie-ep/start
>> +        #echo 1 > controllers/2910000.pcie-ep/start
>> +
>> +
>> +RootComplex Device
>> +==================
>> +
>> +lspci Output
>> +------------
>> +
>> +Note that the devices listed here correspond to the value populated in 1.4
> 
> Can you use a section name (or reference) here instead of "1.4"?  I can't see 1.4
> when reading with an editor.
> 
>> +above::
>> +
>> +        # lspci
>> +        0000:00:00.0 PCI bridge: Texas Instruments Device b00d
>> +        0000:01:00.0 RAM memory: Texas Instruments Device b00d
>> +
>> +
>> +Using ntb_hw_epf Device
>> +-----------------------
>> +
>> +The host side software follows the standard NTB software architecture in Linux.
>> +All the existing client side NTB utilities like NTB Transport Client and NTB
>> +Netdev, NTB Ping Pong Test Client and NTB Tool Test Clientcan be used with NTB
> 
>                                                        Client can be
> 
>> +function device.
>> +
>> +For more information on NTB see
>> +Documentation/driver-api/ntb.rst
> 
> 
> thanks.
> 
