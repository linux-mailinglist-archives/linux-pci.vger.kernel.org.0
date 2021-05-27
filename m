Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E5C3929D2
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 10:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhE0Isx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 04:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbhE0Isw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 04:48:52 -0400
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 May 2021 01:47:20 PDT
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375A1C061574
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 01:47:20 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4FrLzV3CxLzQk1n;
        Thu, 27 May 2021 10:47:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id BlllBx7_FoVw; Thu, 27 May 2021 10:47:17 +0200 (CEST)
To:     linux-pci@vger.kernel.org
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
From:   Stefan Roese <sr@denx.de>
Subject: pcie-xilinx-nwl: Uncorrectable errors upon PCIe surprise removal
Message-ID: <61d5c2d1-d5a3-f074-c81a-b972840b3536@denx.de>
Date:   Thu, 27 May 2021 10:47:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.26 / 15.00 / 15.00
X-Rspamd-Queue-Id: 22755189F
X-Rspamd-UID: a915cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

on our ZynqMP platform we are seeing uncorrectable errors when we try
to access the BAR of a PCIe device (NVMe drive) which was removed
(surprise removal):

[  255.743801] nwl-pcie fd0e0000.pcie: Slave error
[  255.745210] nwl-pcie fd0e0000.pcie: Non-Fatal Error in AER Capability
[  255.750714] nwl-pcie fd0e0000.pcie: Non-Fatal Error Detected
[  255.752523] nwl-pcie fd0e0000.pcie: Non-Fatal Error in AER Capability
[  255.753840] nwl-pcie fd0e0000.pcie: Non-Fatal Error Detected
[  255.755174] nwl-pcie fd0e0000.pcie: Non-Fatal Error in AER Capability
[  255.756706] nwl-pcie fd0e0000.pcie: Non-Fatal Error Detected
[  255.758168] nwl-pcie fd0e0000.pcie: Non-Fatal Error in AER Capability
...

Sometimes even accompanied (started) by a Kernel crash:

Internal error: synchronous external abort: 96000210 [#1] SMP

It seems that the "Slave error" (bit 4) can be cleared in
nwl_pcie_misc_handler() but both other "Non-Fatal" errors not.

I'm wondering now, if this situation can be resolved somehow, so that
the system "survives" such surprise removals without a crash. What we
really would like to see is, that reading from the unavailable PCI space
(BAR area) returns 0xffffffff as common for PCI.

So is this a known issue that accesses to BAR ranges of removed PCIe
devices result in such errors? If yes, why is this the case? Is there
perhaps a way to fully clear the error condition?

Thanks,
Stefan
