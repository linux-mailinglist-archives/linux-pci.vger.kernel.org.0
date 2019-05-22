Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D93F226A25
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 20:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfEVSxm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 14:53:42 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:52917 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfEVSxm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2019 14:53:42 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 2BED430000CEE;
        Wed, 22 May 2019 20:53:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B6EFD2E4EC6; Wed, 22 May 2019 20:53:39 +0200 (CEST)
Date:   Wed, 22 May 2019 20:53:39 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] PCI / PM: Don't runtime suspend when device only
 supports wakeup from D0
Message-ID: <20190522185339.pfo5xeopyz2i5iem@wunner.de>
References: <20190522181157.GC79339@google.com>
 <Pine.LNX.4.44L0.1905221433310.1410-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1905221433310.1410-100000@iolanthe.rowland.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 22, 2019 at 02:39:56PM -0400, Alan Stern wrote:
> According to Kai, PME signalling doesn't work in D0 -- or at least, it
> is _documented_ not to work in D0 -- even though it is enabled and the
> device claims to support it.
> 
> In any case, I don't really see any point in "runtime suspending" a 
> device while leaving it in D0.  We might as well just leave it alone.

There may be devices whose drivers are able to reduce power consumption
through some device-specific means when runtime suspending, even though
the device remains in PCI_D0.  The patch would cause a power regression
for those.

In particular, pci_target_state() returns PCI_D0 if the device lacks the
PM capability.

Thanks,

Lukas
