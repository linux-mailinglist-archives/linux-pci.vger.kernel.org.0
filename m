Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A043EC0E4
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 08:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbhHNGYB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 02:24:01 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:53249 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhHNGYA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Aug 2021 02:24:00 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 657AA3000E426;
        Sat, 14 Aug 2021 08:23:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 53F3D19442; Sat, 14 Aug 2021 08:23:28 +0200 (CEST)
Date:   Sat, 14 Aug 2021 08:23:28 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, kw@linux.com, pavel@ucw.cz
Subject: Re: [PATCH v3] Add support for PCIe SSD status LED management
Message-ID: <20210814062328.GA25723@wunner.de>
References: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 05:36:53PM -0400, Stuart Hayes wrote:
> +struct mutex drive_status_dev_list_lock;
> +struct list_head drive_status_dev_list;

Should be declared static.

> +const guid_t pcie_ssd_leds_dsm_guid =
> +	GUID_INIT(0x5d524d9d, 0xfff9, 0x4d4b,
> +		  0x8c, 0xb7, 0x74, 0x7e, 0xd5, 0x1e, 0x19, 0x4d);

Same.

> +struct drive_status_led_ops dsm_drive_status_led_ops = {
> +	.get_supported_states = get_supported_states_dsm,
> +	.get_current_states = get_current_states_dsm,
> +	.set_current_states = set_current_states_dsm,
> +};

Same.

> +static void probe_pdev(struct pci_dev *pdev)
> +{
> +	/*
> +	 * This is only supported on PCIe storage devices and PCIe ports
> +	 */
> +	if (pdev->class != PCI_CLASS_STORAGE_EXPRESS &&
> +	    pdev->class != PCI_CLASS_BRIDGE_PCI)
> +		return;
> +	if (pdev_has_dsm(pdev))
> +		add_drive_status_dev(pdev, &dsm_drive_status_led_ops);
> +}

Why is &dsm_drive_status_led_ops passed to add_drive_status_dev()?
It's always the same argument.

> +static int __init ssd_leds_init(void)
> +{
> +	mutex_init(&drive_status_dev_list_lock);
> +	INIT_LIST_HEAD(&drive_status_dev_list);
> +
> +	bus_register_notifier(&pci_bus_type, &ssd_leds_pci_bus_nb);
> +	initial_scan_for_leds();
> +	return 0;
> +}

There's a concurrency issue here:  initial_scan_for_leds() uses
bus_for_each_dev(), which walks the bus's klist_devices.  When a
device is added (e.g. hotplugged), that device gets added to the
tail of klist_devices.  (See call to klist_add_tail() in
bus_add_device().)

It is thus possible that probe_pdev() is run concurrently for the
same device, once by the notifier and once by initial_scan_for_leds().

The problem is that add_drive_status_dev() only checks at the top
of the function whether the device has already been added to
drive_status_dev_list.  It goes on to instantiate the LED
and only then adds the device to drive_status_dev_list.

It's thus possible that the same LED is instantiated twice
which might confuse users.

Thanks,

Lukas
