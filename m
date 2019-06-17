Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA9149559
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 00:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFQWnh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 18:43:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54653 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfFQWnh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 18:43:37 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id a683a0a51c8ced34; Tue, 18 Jun 2019 00:43:35 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI/PME: Fix race on PME polling
Date:   Tue, 18 Jun 2019 00:43:35 +0200
Message-ID: <1943367.SoULSMlgxK@kreacher>
In-Reply-To: <20190617145348.cqmtuqlvabgpo2ky@wunner.de>
References: <0113014581dbe2d1f938813f1783905bd81b79db.1560079442.git.lukas@wunner.de> <20190617143510.GT2640@lahna.fi.intel.com> <20190617145348.cqmtuqlvabgpo2ky@wunner.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday, June 17, 2019 4:53:48 PM CEST Lukas Wunner wrote:
> On Mon, Jun 17, 2019 at 05:35:10PM +0300, Mika Westerberg wrote:
> > Today when doing some PM testing I noticed that this patch actually
> > reveals an issue in our native PME handling. Problem is in
> > pcie_pme_handle_request() where we first convert req_id to struct
> > pci_dev and then call pci_check_pme_status() for it. Now, when a device
> > triggers wake the link is first brought up and then the PME is sent to
> > root complex with req_id matching the originating device. However, if
> > there are PCIe ports in the middle they may still be in D3 which means
> > that pci_check_pme_status() returns 0xffff for the device below so there
> > are lots of
> > 
> > 	Spurious native interrupt"
> > 
> > messages in the dmesg but the actual PME is never handled.
> > 
> > It has been working because pci_check_pme_status() returned true in case
> > of 0xffff as well and we went and runtime resumed to originating device.
> > 
> > I think the correct way to handle this is actually drop the call to
> > pci_check_pme_status() in pcie_pme_handle_request() because the whole
> > idea of req_id in PME message is to allow the root complex and SW to
> > identify the device without need to poll for the PME status bit.
> 
> Either that or the call to pci_check_pme_status() should be encapsulated
> in a pci_config_pm_runtime_get() / _put() pair.

And the whole hierarchy might as well be resumed, which could be rather
wasteful.

The problem is that the $subject patch should affect polling only, but it has
side effects beyond that.



