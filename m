Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1087E778041
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 20:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjHJS3t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 14:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjHJS3s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 14:29:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F6426B9;
        Thu, 10 Aug 2023 11:29:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83C86665D1;
        Thu, 10 Aug 2023 18:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFEBC433C8;
        Thu, 10 Aug 2023 18:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691692186;
        bh=jxNTEHQ1rDKvHKrXbpmXZW+78WS0axoYkSgFcfeewyw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YwhfgrcxEI14djj1JXkWfHJJPXIFbgyIl4eeP1OjLCZH+0dY1sE8WCi3P0++iGgxQ
         VY5WhJU19JpSYM6qp0oh8oQNEOsfcQWKsbaFDR1VdaULbqHC7/3VguETLHW0sTo2G/
         sMdIpnKWCY5CArhEjeZ1X5iVUzIPcBzoN4RM3NSm+XLBy1FCCytfhWtYXfnt4908+2
         4O4pVwViXMzuW4ctTAM5IXo6TEN6bvC7p7V9QzqWFkU8e7dzlOat3qorNMIQAQvFtZ
         kmGzrpx5IUXt/ji6DcAsMmqnvCbynQvvux9c9+3X8o116fZkshHpIljWVo2T3x6zmk
         DyY2SGVPI4ttQ==
Date:   Thu, 10 Aug 2023 13:29:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.auger@redhat.com
Subject: Re: [PATCH v2 0/2] PCI: Protect VPD and PME accesses from power
 management
Message-ID: <20230810182944.GA37564@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803171233.3810944-1-alex.williamson@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 03, 2023 at 11:12:31AM -0600, Alex Williamson wrote:
> Since v5.19, vfio-pci makes use of runtime power management on devices.
> This has the effect of potentially putting entire sub-hierarchies into
> lower power states, which has exposed some gaps in the PCI subsystem
> around power management support.
> 
> The first issue is that lspci accesses the VPD sysfs interface, which
> does not provide the same power management wrappers as general config
> space.
> 
> The next covers PME, where we attempt to skip devices based on their PCI
> power state, but don't protect changes to that state or look at the
> overall runtime power management state of the device.
> 
> This latter patch addresses the issue noted by Eric in the follow-ups to
> v1 linked below.
> 
> These patches are logically independent, but only together resolve an
> issue on Eric's system where a pair of endpoints bound to vfio-pci and
> unused by userspace drivers trigger faults through lspci and PME
> polling.  Thanks,
> 
> Alex 
> 
> v1: https://lore.kernel.org/all/20230707151044.1311544-1-alex.williamson@redhat.com/
> 
> Alex Williamson (2):
>   PCI/VPD: Add runtime power management to sysfs interface
>   PCI: Fix runtime PM race with PME polling
> 
>  drivers/pci/pci.c | 23 ++++++++++++++++-------
>  drivers/pci/vpd.c | 34 ++++++++++++++++++++++++++++++++--
>  2 files changed, 48 insertions(+), 9 deletions(-)

Applied with the tweak below to pci/vpd for v6.6, thanks!  The idea is
to match the pci_get_func0_dev() so the get/put balance is clear
without having to analyze PCI_DEV_FLAGS_VPD_REF_F0 usage:

-       if (dev != vpd_dev)
+       if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0)

