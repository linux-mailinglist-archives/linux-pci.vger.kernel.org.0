Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE319A9E97
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbfIEJin (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 05:38:43 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:41785 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbfIEJin (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 05:38:43 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 48E342801E4E8;
        Thu,  5 Sep 2019 11:38:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1BA0129FBD7; Thu,  5 Sep 2019 11:38:41 +0200 (CEST)
Date:   Thu, 5 Sep 2019 11:38:41 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Shawn Anastasio <shawn@anastas.io>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru,
        benh@kernel.crashing.org, sbobroff@linux.ibm.com, oohall@gmail.com
Subject: Re: [PATCH 0/2] Fix IOMMU setup for hotplugged devices on pseries
Message-ID: <20190905093841.mkpvzkcrafwpo5lj@wunner.de>
References: <20190905042215.3974-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905042215.3974-1-shawn@anastas.io>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 04, 2019 at 11:22:13PM -0500, Shawn Anastasio wrote:
> If anybody has more insight or a better way to fix this, please let me know.

Have you considered moving the invocation of pcibios_setup_device()
to pcibios_bus_add_device()?

The latter is called from pci_bus_add_device() in drivers/pci/bus.c.
At this point device_add() has been called, so the device exists in
sysfs.

Basically when adding a PCI device, the order is:

* pci_device_add() populates struct pci_dev, calls device_add(),
  binding the device to a driver is prevented
* after pci_device_add() has been called for all discovered devices,
  resources are allocated
* pci_bus_add_device() is called for each device,
  calls pcibios_bus_add_device() and binds the device to a driver

Thanks,

Lukas
