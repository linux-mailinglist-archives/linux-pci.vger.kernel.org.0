Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB1A5B6242
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 22:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiILUgX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 16:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiILUgX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 16:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E54B49B7C;
        Mon, 12 Sep 2022 13:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3642661251;
        Mon, 12 Sep 2022 20:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7FBC433D6;
        Mon, 12 Sep 2022 20:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663014980;
        bh=UtpUT9+fQRNl1BCL6OuHTXgSHjvjdgrBSs3lARcc/h8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GBnlO/RGGnyYNGGbZKyJ1x7t4+LhEexM6RhXm433N9/GCdonm9cTCc7907V+olO/I
         nYR+UxZk583+xrDHosGjN65hzBv5isrF1SoQhmwLzschYW/Tj9AXa6v5GTlDVFRzAw
         12AvWDaLONmnUJMQ71pl7+/MhvFYrQDBpFWVSsOWHsAXEUgI1udweK6aEELS8GJ71j
         Q4NNjRSnk1/bB+NRJgdnAZZIlSy3vIJU75vFpzNjMByw7muXeiY4d6i4/XXJuPYRs0
         AmnEj/4M1FcydiPy6czlixZG4uc451DlGk7bAZB/vpaO3toGBfnMdo3NWgNc17n6qD
         otilCphuc9HpA==
Date:   Mon, 12 Sep 2022 15:36:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 0/9] PCI/PM: Always disable PTM for all devices during
 suspend
Message-ID: <20220912203619.GA537411@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx6yl9jNu6S8xOJ+@black.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 12, 2022 at 07:16:23AM +0300, Mika Westerberg wrote:
> On Fri, Sep 09, 2022 at 03:24:56PM -0500, Bjorn Helgaas wrote:
> > Bjorn Helgaas (9):
> >   PCI/PTM: Cache PTM Capability offset
> >   PCI/PTM: Add pci_upstream_ptm() helper
> >   PCI/PTM: Separate configuration and enable
> >   PCI/PTM: Add pci_suspend_ptm() and pci_resume_ptm()
> >   PCI/PTM: Move pci_ptm_info() body into its only caller
> >   PCI/PTM: Preserve RsvdP bits in PTM Control register
> >   PCI/PTM: Reorder functions in logical order
> >   PCI/PTM: Consolidate PTM interface declarations
> >   PCI/PM: Always disable PTM for all devices during suspend
> 
> For the whole series,
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you very much, Mika, Kuppuswamy, and Rajvi for your effort in
reviewing and testing these.  I know that's a lot of work, and I
really appreciate it.

I put these on pci/pm together with Rajvi's pci_pm_suspend_noirq()
simplification for v6.1.

Bjorn
