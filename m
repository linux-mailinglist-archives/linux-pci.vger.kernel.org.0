Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600AC6E9C77
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 21:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjDTT3B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 15:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjDTT27 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 15:28:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C7640E8;
        Thu, 20 Apr 2023 12:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 283E564B73;
        Thu, 20 Apr 2023 19:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585BAC433D2;
        Thu, 20 Apr 2023 19:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682018934;
        bh=OqAGpGx3D2fdto7RaMWzAePQOU0MhP4k68Rrs8rlP5M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=W6QiVMTxWWkSYnEpQTCkNDLWa/ltQVAy8nOZDV9mNSWpoU9jqv3+grEDrYwonf3Cl
         fXKaYx9aSgntEBjvX32vxC6RgkEVQbN5HSNrretugTRtLloDOA5CyfOeWp0PwE9zxl
         IqyV7hVVLjl/rLzNU9gCBdcM7Gasoct/A6I7TQ+pnduwcJhf+Vkmhx1lWCrMPdSZKg
         N2N+U893nzJwSLJ1Wdp5WM3JfXn3apO/XwJvqBAhN7yWN8Cn4frFkI6oMOeN5kSNlM
         KLZeGOrBc0p+qMf3J1q79RHpzJ3GUic48Y2HiWh5jTbbkHAxlVhTcrsHxy+vk3lPvl
         XfDY5Sjioriag==
Date:   Thu, 20 Apr 2023 14:28:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/7] PCI: Tidy controller Kconfig
Message-ID: <20230420192852.GA317599@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418174336.145585-1-helgaas@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 12:43:29PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use vendor name in all native controller Kconfig entries.  Use consistent
> prompt language.  Sort entries by vendor name so they appear in alpha order
> in menuconfig.
> 
> Bjorn Helgaas (7):
>   PCI: meson: Add 'Amlogic' to Kconfig prompt
>   PCI: hv: Add 'Microsoft' to Kconfig prompt
>   PCI: xilinx-nwl: Add 'Xilinx' to Kconfig prompt
>   PCI: Use consistent controller Kconfig menu entry language
>   PCI: Sort controller Kconfig entries by vendor
>   PCI: dwc: Sort Kconfig entries by vendor
>   PCI: mobiveil: Sort Kconfig entries by vendor
> 
>  drivers/pci/controller/Kconfig          | 463 ++++++++++-----------
>  drivers/pci/controller/cadence/Kconfig  |  10 +-
>  drivers/pci/controller/dwc/Kconfig      | 518 ++++++++++++------------
>  drivers/pci/controller/mobiveil/Kconfig |  19 +-
>  4 files changed, 506 insertions(+), 504 deletions(-)

I applied these to pci/controller/kconfig for v6.4.
