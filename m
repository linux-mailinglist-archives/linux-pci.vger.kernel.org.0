Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87A0F5F99
	for <lists+linux-pci@lfdr.de>; Sat,  9 Nov 2019 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfKIOtW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Nov 2019 09:49:22 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:56149 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfKIOtW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Nov 2019 09:49:22 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id D6E31101C01C0;
        Sat,  9 Nov 2019 15:49:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 937602F7319; Sat,  9 Nov 2019 15:49:19 +0100 (CET)
Date:   Sat, 9 Nov 2019 15:49:19 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: Add missing link delays required by the PCIe
 spec
Message-ID: <20191109144919.a2whrvyih4k4fu42@wunner.de>
References: <20191107121847.24781-1-mika.westerberg@linux.intel.com>
 <20191107121847.24781-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107121847.24781-3-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 03:18:47PM +0300, Mika Westerberg wrote:
> +static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
> +{
> +	const struct pci_dev *pdev;
> +	int min_delay = 100;
> +	int max_delay = 0;
> +
> +	list_for_each_entry(pdev, &bus->devices, bus_list) {
> +		if (pdev->d3cold_delay < min_delay)
> +			min_delay = pdev->d3cold_delay;
> +		if (pdev->d3cold_delay > max_delay)
> +			max_delay = pdev->d3cold_delay;
> +	}

You need to hold pci_bus_sem when accessing the devices list.


> +	if (!dev->subordinate || list_empty(&dev->subordinate->devices))
> +		return;

Same here.


> +	child = list_first_entry(&dev->subordinate->devices, struct pci_dev,
> +				 bus_list);

And again.


Thanks,

Lukas
