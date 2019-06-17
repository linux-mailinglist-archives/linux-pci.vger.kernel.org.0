Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71B904861E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 16:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfFQOxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 10:53:51 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:34111 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfFQOxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 10:53:51 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id ACA9C3001237D;
        Mon, 17 Jun 2019 16:53:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7B4E5417199; Mon, 17 Jun 2019 16:53:48 +0200 (CEST)
Date:   Mon, 17 Jun 2019 16:53:48 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI/PME: Fix race on PME polling
Message-ID: <20190617145348.cqmtuqlvabgpo2ky@wunner.de>
References: <0113014581dbe2d1f938813f1783905bd81b79db.1560079442.git.lukas@wunner.de>
 <1957149.eOSnrBRbHu@kreacher>
 <20190617143510.GT2640@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617143510.GT2640@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 17, 2019 at 05:35:10PM +0300, Mika Westerberg wrote:
> Today when doing some PM testing I noticed that this patch actually
> reveals an issue in our native PME handling. Problem is in
> pcie_pme_handle_request() where we first convert req_id to struct
> pci_dev and then call pci_check_pme_status() for it. Now, when a device
> triggers wake the link is first brought up and then the PME is sent to
> root complex with req_id matching the originating device. However, if
> there are PCIe ports in the middle they may still be in D3 which means
> that pci_check_pme_status() returns 0xffff for the device below so there
> are lots of
> 
> 	Spurious native interrupt"
> 
> messages in the dmesg but the actual PME is never handled.
> 
> It has been working because pci_check_pme_status() returned true in case
> of 0xffff as well and we went and runtime resumed to originating device.
> 
> I think the correct way to handle this is actually drop the call to
> pci_check_pme_status() in pcie_pme_handle_request() because the whole
> idea of req_id in PME message is to allow the root complex and SW to
> identify the device without need to poll for the PME status bit.

Either that or the call to pci_check_pme_status() should be encapsulated
in a pci_config_pm_runtime_get() / _put() pair.

Thanks,

Lukas
