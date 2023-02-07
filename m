Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDF868E0D2
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 20:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjBGTD5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 14:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjBGTDx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 14:03:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006303EFFC
        for <linux-pci@vger.kernel.org>; Tue,  7 Feb 2023 11:03:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 894E9B81AC8
        for <linux-pci@vger.kernel.org>; Tue,  7 Feb 2023 19:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B96C433EF;
        Tue,  7 Feb 2023 19:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675796622;
        bh=fqO0URkFS148ZmMTVBXPnJnWplB5d4654ob5FhcD7B4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QxPvPCcM66gbO47B/14MoAtRAxnmnE9fhWR+riQ3HocvTCvHQgjahmJ9oHPmVoGq1
         Q4pYjXMZzCfnEp54xoVuwE91fgcv/BcNptaEJQf1WM/iH23K0z2QIzyW4OOkMzDiha
         ILDmsxuIn/T+14p5guqfadIAAEPFe1pqpVgS1AMfvZYHL+9noSMNMWc7IcAfk7WLdE
         /EFqK7BbnmqzWjjstLpCPWmF65fzjrEg+gW4ZXC9yrhpDf7LtZt3G/WX0DYXXIfQ7d
         IB5CDTc3AhWu0e4hbo/zwqfAQbHl0gV8HNu7JNNzGZUcTBRdKtUbMQj462IBpjFw6B
         WhSKYdpWOlS+g==
Date:   Tue, 7 Feb 2023 13:03:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>
Subject: Re: [PATCH v2 0/3] PCI reset delay fixes
Message-ID: <20230207190340.GA2363357@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673769517.git.lukas@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 15, 2023 at 09:20:30AM +0100, Lukas Wunner wrote:
> Delay fixes for recovery from Secondary Bus Resets and Downstream Port
> Containment, v2:
> 
> 
> Changes v1 -> v2:
> 
> * [PATCH 1/3] PCI/PM: Observe reset delay irrespective of bridge_d3
>   * Add Reviewed-by tags (Mika, Sathyanarayanan)
> 
> * [PATCH 2/3] PCI: Unify delay handling for reset and resume
>   * Introduce PCI_RESET_WAIT macro for 1 sec timeout prescribed by
>     PCIe r6.0 sec 6.6.1 (Bjorn)
>   * Note in kernel-doc of pci_bridge_wait_for_secondary_bus()
>     that timeout parameter is in milliseconds (Bjorn)
>   * Add Reviewed-by tags (Mika, Sathyanarayanan)
> 
> * [PATCH 3/3] PCI/DPC: Await readiness of secondary bus after reset
>   * Move PCIE_RESET_READY_POLL_MS macro below the newly introduced
>     PCI_RESET_WAIT from patch [2/3] and extend its code comment
>   * Mention errors seen on Ponte Vecchio in commit message (Bjorn)
>   * Avoid first person plural in commit message (Sathyanarayanan)
>   * Add Reviewed-by tag (Mika)
> 
> 
> Link to v1:
> 
> https://lore.kernel.org/linux-pci/cover.1672511016.git.lukas@wunner.de/
> 
> 
> Lukas Wunner (3):
>   PCI/PM: Observe reset delay irrespective of bridge_d3
>   PCI: Unify delay handling for reset and resume
>   PCI/DPC: Await readiness of secondary bus after reset
> 
>  drivers/pci/pci-driver.c |  2 +-
>  drivers/pci/pci.c        | 59 +++++++++++++++++-----------------------
>  drivers/pci/pci.h        | 16 ++++++++++-
>  drivers/pci/pcie/dpc.c   |  4 +--
>  4 files changed, 43 insertions(+), 38 deletions(-)

Applied to pci/reset for v6.3, thanks, Lukas!
