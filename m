Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698E364874B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 18:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLIRIN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 12:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiLIRHj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 12:07:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DCB5FCE
        for <linux-pci@vger.kernel.org>; Fri,  9 Dec 2022 09:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8D06622CE
        for <linux-pci@vger.kernel.org>; Fri,  9 Dec 2022 17:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0853CC433EF;
        Fri,  9 Dec 2022 17:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670605634;
        bh=WV+dC6voHwv2c4S2aoELt4sen+WWnPK6o2OU7KA+iEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IfIKyasLIEsG55HWPHifoUbfJUrxyKnaVN0GTEKuKLoIRa5dl8PKzVPWefix3g4ju
         3qna7AWu3UZg9CN6onaxdOsHbfvMxkyNG21tY0QLpZg+MHIjIeJ/ZzHvtSsKOHXfU+
         LQgjJidOQGUarlpnj2elACwbZBqbuoDNbVCPLqxXeNagAarrXP6pbNOcqB7hbxSWAI
         QjH/vCLIA5mvpd+KvnrlSsizNBXIkHZDo7XREKenfeP0ERseFhwG+BtusNY/jn+WM/
         Rufvdir9QgRIqL6YLPZ14vmJqdq7JAfp8PmgTiPMIK9V2KQj6mK35CI4pv8OVMyagE
         RF2g486X26bVA==
Date:   Fri, 9 Dec 2022 11:07:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Do not require an interrupt for all AER
 capable ports
Message-ID: <20221209170712.GA1627846@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207084105.84947-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 07, 2022 at 10:41:05AM +0200, Mika Westerberg wrote:
> Only Root Ports and Event Collectors use MSI for AER. PCIe Switch ports
> or endpoints on the other hand only send messages (that get collected by
> the former). For this reason do not require PCIe switch ports and
> endpoints to use interrupt if they support AER.
> 
> This allows portdrv to attach PCIe switch ports of Intel DG1 and DG2
> discrete graphics cards. These do not declare MSI or legacy interrupts.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks for the additional info!  This seems like something we should
definitely do.

I'm wondering whether we should check for this in
get_port_device_capability().  It already has similar checks for
device type for other services.  This would skip pci_set_master() for
these non-RP, non-RCEC devices, which is probably harmless, since I
assume we only need that to make sure MSI works.

It would also prevent allocation of the AER service for non-RP,
non-RCEC devices.  That's also probably harmless, since aer_probe()
ignores those devices anyway.

What do you think of something like this?  (This is based on my
pci/portdrv branch which squashed everything into portdrv.c:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/portdrv)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index a6c4225505d5..8b16e96ec15c 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -232,7 +232,9 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 #ifdef CONFIG_PCIEAER
-	if (dev->aer_cap && pci_aer_available() &&
+	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
+	    dev->aer_cap && pci_aer_available() &&
 	    (pcie_ports_native || host->native_aer))
 		services |= PCIE_PORT_SERVICE_AER;
 #endif
