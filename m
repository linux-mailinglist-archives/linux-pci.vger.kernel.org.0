Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619935B6237
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 22:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiILUcV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 16:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiILUcU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 16:32:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333A53206D;
        Mon, 12 Sep 2022 13:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C243A612AC;
        Mon, 12 Sep 2022 20:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03393C433D6;
        Mon, 12 Sep 2022 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663014738;
        bh=PXeC2aQQnVgOv75X6Uw55HEBxJ0NTSxWsOiyXkjtTms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BczlH589EycP4AyonxYdpcW36S0+PWIMozVDFqFhMmatT8gMRkcKrFfpwS5cmAhj8
         7nxB6dHT1Ryz1A+vlrMp7s8I2bdtfZyyOg0MmXq436qvDMZ0+/T31c8iLdslE025HC
         98XJm0FMtjjfauJ1setzDv4zg4sXs7V8JBVK5F/nqAX6fVC48P+PxH5CvFFT6hxha9
         SSaH6NusuLGQC0AwaHFaH2/vL5S/MOso2mVOl7tNpvcJsKv1OromPDtxp6inYfL4Kb
         zDb8XGMyKKjSUm40y1/Cx2VWOSFY3jCzxBFnAND3vRoKfvyW9d70oDbGy8V2U90KTX
         9HDDU5lKitdbw==
Date:   Mon, 12 Sep 2022 15:32:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajvi Jingar <rajvi.jingar@linux.intel.com>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 0/9] PCI/PM: Always disable PTM for all devices during
 suspend
Message-ID: <20220912203216.GA534915@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e58cbb3c-fcfe-edaa-f8ac-5cf502ea62a6@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 12, 2022 at 01:15:59PM -0700, Rajvi Jingar wrote:
> On 9/9/22 13:24, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas<bhelgaas@google.com>
> > 
> > We currently disable PTM for Root Ports during suspend.  Leaving PTM
> > enabled for downstream devices causes UR errors if they send PTM Requests
> > to upstream devices that have PTM disabled.
> > 
> > The intent of this series is to:
> > 
> >    - Unconditionally disable PTM during suspend (even if the driver saves
> >      its own state) by moving the disable from pci_prepare_to_sleep() to
> >      pci_pm_suspend().
> > 
> >    - Disable PTM for all devices by removing the Root Port condition and
> >      doing it early in the suspend paths.
> > 
> >    - Explicitly re-enable PTM during resume.
> > 
> > Changes between v3 and v4:
> >    - Use u16 for ptm_cap
> >    - Add kernel-doc for pci_enable_ptm() and pci_disable_ptm() (exported
> >      functions)
> >    - Drop "Preserve PTM Root Select" (unnecessary since enabling PTM sets
> >      Root Select when needed)
> >    - Squash these three patches into one because they make more sense that
> >      way:
> > 	PCI/PTM: Add suspend/resume
> > 	PCI/PTM: Add pci_enable_ptm() wrapper
> > 	PCI/PTM: Add pci_disable_ptm() wrapper
> >    - Add "PCI/PTM: Preserve RsvdP bits in PTM Control register"
> >    - Add "PCI/PTM: Consolidate PTM interface declarations"
> > 
> > Bjorn Helgaas (9):
> >    PCI/PTM: Cache PTM Capability offset
> >    PCI/PTM: Add pci_upstream_ptm() helper
> >    PCI/PTM: Separate configuration and enable
> >    PCI/PTM: Add pci_suspend_ptm() and pci_resume_ptm()
> >    PCI/PTM: Move pci_ptm_info() body into its only caller
> >    PCI/PTM: Preserve RsvdP bits in PTM Control register
> >    PCI/PTM: Reorder functions in logical order
> >    PCI/PTM: Consolidate PTM interface declarations
> >    PCI/PM: Always disable PTM for all devices during suspend
> 
> Looks good. It fixes the issue on Dell Precision 5530 with Coffee Lake
> CPU platforms to get improved residency in low power idle states.
> 
> Tested-by:rajvi.jingar@linux.intel.com

Thanks a lot for testing this!

It's best if you can send plain-text mail to the lists.  This was a
multi-part message, which the vger mailing lists reject:

  http://vger.kernel.org/majordomo-info.html

Bjorn
