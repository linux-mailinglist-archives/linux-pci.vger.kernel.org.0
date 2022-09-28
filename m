Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5627C5EE851
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 23:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiI1VcP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 17:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiI1VcO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 17:32:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5A4760FE;
        Wed, 28 Sep 2022 14:32:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87E4AB820C2;
        Wed, 28 Sep 2022 21:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF589C433D6;
        Wed, 28 Sep 2022 21:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664400731;
        bh=MZ7K2L7OFQOceL1+MLNNgstlr1GNb++R4EBc4ueAOng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZDbmfvT0Nqwdw0W3rCmJG4NfVwvy9Amgr3wcmdydyhC3g71yrMBs9njtt9swjj0gH
         iatX9M52PfnXCqnBWSVISElr2A3xqpU7lSmt2/Oli9dyb+bw/EYMZxWfwL+QF7yt4h
         DwcmjtlyLNRHLnQ0kCSB9nwPRD0nYggXQ6gWMOGk/+nsx/tW+ekYd2lWj3W3GaAQqo
         kn6+M2NOa6b6tyrAfD2bainkYXug9sYUgv0uIcdG3CBP4jSQYNIUOye05iOQa3wTjQ
         0tcv0IIXDS2qsPcELMdTxwtyQqYZKNIyi5XsnRJN3Nx2cUMTPq9mloTyO458EaWRlG
         zLUqN2BX7YW8g==
Date:   Wed, 28 Sep 2022 16:32:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Lukas Wunner <lukas@wunner.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI/portdrv: Flag services when IRQ is shared with
 PME
Message-ID: <20220928213209.GA1839792@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727013255.269815-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 27, 2022 at 09:32:50AM +0800, Kai-Heng Feng wrote:
> After commit cb1f65c1e142 ("PM: s2idle: ACPI: Fix wakeup interrupts
> handling"), there's a system that always gets woken up by spurious PME
> event when one of the root port is put to D3cold.
> 
> '/sys/power/pm_wakeup_irq' shows 122, which is an IRQ shared between
> PME, AER and DPC:
> pcieport 0000:00:01.0: PME: Signaling with IRQ 122
> pcieport 0000:00:01.0: AER: enabled with IRQ 122
> pcieport 0000:00:01.0: DPC: enabled with IRQ 122
> 
> Disabling services one by one and the issue goes away when
> PCIE_PORT_SERVICE_AER is not enabled. Following the lead, more info can
> be found on resume when pci_aer_clear_status() is removed from
> pci_restore_state() to print out what happened:
> pcieport 0000:00:01.0: AER: Corrected error received: 0000:00:01.0
> pcieport 0000:00:01.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> pcieport 0000:00:01.0:   device [8086:4c01] error status/mask=00000001/00002000
> pcieport 0000:00:01.0:    [ 0] RxErr
> 
> Since the corrected AER error happens at physical layer when the root
> port is transitioning to D3cold, making system be able to suspend is
> more important than reporting issues like this.
> 
> So introduce a new flag to indicate when IRQ is shared with PME,
> therefore AER and DPC can be suspended to prevent any spurious wakeup.
> HP already has its own suspend routine so it doesn't need to use this
> flag.

I think it probably does make sense to disable AER and DPC interrupts
during suspend.  I'm not sure it makes sense to do that conditionally
based on whether the interrupt is shared.  I think I'd rather disable
them always, whether the interrupt is shared or not, because then we
would do the same thing on all machines.  What do you think?

Bjorn
