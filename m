Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F43A1DB5C8
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 15:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgETN5L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 09:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETN5K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 09:57:10 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B1B5206C3;
        Wed, 20 May 2020 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589983030;
        bh=5+IbKprRxyqw9NFTJTpxeEJkrQ0uTWF2tKNer2QzvW4=;
        h=Date:From:To:Cc:Subject:From;
        b=Q/rc+qik2yM/X4meIPkIhKjBgLcKmYsuhXCObjnXLXQ53nzwMll4Yv32dZYOOT1xE
         tWoIGlrQa9rjeMjh+5+uDrP9wROLCoFgsVBfksIeeG1s4gEeIjL+DlC8/CFEq0rz34
         dh199yR295AXjsr1E6Zq8j0sGBROxXWAjWbntkPo=
Date:   Wed, 20 May 2020 08:57:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Burton <paulburton@kernel.org>
Cc:     Krzysztof Wilczynski <kw@linux.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: piix4-poweroff.c I/O BAR usage
Message-ID: <20200520135708.GA1086370@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Paul,

This looks like it might be a bug:

  static const int piix4_pm_io_region = PCI_BRIDGE_RESOURCES;

  static int piix4_poweroff_probe(struct pci_dev *dev,
                                  const struct pci_device_id *id)
  {
          ...
          /* Request access to the PIIX4 PM IO registers */
          res = pci_request_region(dev, piix4_pm_io_region,
                                   "PIIX4 PM IO registers");

pci_request_region() takes a BAR number (0-5), but here we're passing
PCI_BRIDGE_RESOURCES (13 if CONFIG_PCI_IOV, or 7 otherwise), which is
the bridge I/O window.

I don't think this device ([8086:7113]) is a bridge, so that resource
should be empty.

Based on this spec:
https://www.intel.com/Assets/PDF/datasheet/290562.pdf,
it looks like it should be the PIIX4 power management function at
function 3, which has no standard PCI BARs but does have a PMBA (Power
Management Base Address) at 0x40 and an SMBBA (SMBus Base Address) at
0x90 in config space.

I suppose on an ACPI system the regions described by PMBA and SMBBA
might be described via ACPI, since they're not discoverable by
standard PCI enumeration?  Pretty sure you don't have ACPI on MIPS
though.

Maybe the driver should read PMBA and SMBBA and reserve those regions
by hand with request_region()?

Bjorn
