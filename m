Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E12483EA9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 10:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiADJC1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 04:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiADJC0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 04:02:26 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8363CC061761
        for <linux-pci@vger.kernel.org>; Tue,  4 Jan 2022 01:02:25 -0800 (PST)
Received: from smtp1.mailbox.org (unknown [91.198.250.123])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4JSmpQ4g7RzQk3P;
        Tue,  4 Jan 2022 10:02:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <4736848c-7b3b-a99d-8fd3-540ec6eb920b@denx.de>
Date:   Tue, 4 Jan 2022 10:02:18 +0100
MIME-Version: 1.0
Content-Language: en-US
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>
From:   Stefan Roese <sr@denx.de>
Subject: PCIe AER generates no interrupts on host (ZynqMP)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I'm trying to get the Kernel PCIe AER infrastructure to work on my
ZynqMP based system. E.g. handle the events (correctable, uncorrectable
etc). In my current tests, no AER interrupt is generated though. I'm
currently using the "surprise down error status" in the uncorrectable
error status register of the connected PCIe switch (PLX / Broadcom
PEX8718). Here the bit is correctly logged in the PEX switch
uncorrectable error status register but no interrupt is generated
to the root-port / system. And hence no AER message(s) reported.

Does any one of you have some ideas on what might be missing? Why are
these events not reported to the PCIe rootport driver via IRQ? Might
this be a problem of the missing MSI-X support of the ZynqMP? The AER
interrupt is connected as legacy IRQ:

cat /proc/interrupts | grep -i aer
  58:          0          0          0          0  nwl_pcie:legacy   0 
Level     PCIe PME, aerdrv

BTW: This was tested on v5.10 and recent v5.16-rc6.

Thanks,
Stefan
