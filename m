Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A80674BF0
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 06:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjATFPJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 00:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjATFOz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 00:14:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D829545212;
        Thu, 19 Jan 2023 21:03:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3972B82015;
        Thu, 19 Jan 2023 04:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B590C433EF;
        Thu, 19 Jan 2023 04:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674102381;
        bh=Mfk8kWgrggh7nLfPyOq/xtH5uobwBVywJEcQt80do9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O+/lT7YvCltvh3aXo3p5FdOCc6qZIONAmVtNYqX5UY80lHSuJrC8/mMfq4xQXSeIU
         LUeG3Owic9BOxrXKhO8UhYFIMgD5Y97kMZb3SWScz8uzbAN9CkCUvaRFYcCC4qF206
         rwoRxp7h9b9vOGf3i4TpltaoBO4d9bNM7TUp6QXGN8SZ/hpzJPUD04zhrSVGKXrznZ
         xOCAWki2QdNb+uUd0l2VgHoKbKUKGhsJ27JKG8OX/O6HFelcZ5kahfPkVTmg9Ky2p9
         ZUHHONT6BgB9fj4/XDGE49oQExT0BxxVkhh2gShlrjyS6J8+Pzjv4lQEz2inJeyTQ3
         FuQMfiBCw8mWg==
Date:   Wed, 18 Jan 2023 22:26:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/9] PCI/AER: Remove redundant Device Control Error
 Reporting Enable
Message-ID: <20230119042619.GA288847@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e773b789-9ac1-eb45-b1ab-11fc93aede40@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 18, 2023 at 07:55:33PM -0800, Sathyanarayanan Kuppuswamy wrote:
> On 1/18/23 3:46 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native"),
> > ths PCI core sets the Device Control bits that enable error reporting for
> > PCIe devices.
> > 
> > This series removes redundant calls to pci_enable_pcie_error_reporting()
> > that do the same thing from the AER driver and several NIC drivers.
> > 
> > There are several more drivers where this should be removed; I started with
> > just the Intel drivers here.
> > 
> > Bjorn Helgaas (9):
> >   PCI/AER: Remove redundant Device Control Error Reporting Enable
> >   e1000e: Remove redundant pci_enable_pcie_error_reporting()
> >   fm10k: Remove redundant pci_enable_pcie_error_reporting()
> >   i40e: Remove redundant pci_enable_pcie_error_reporting()
> >   iavf: Remove redundant pci_enable_pcie_error_reporting()
> >   ice: Remove redundant pci_enable_pcie_error_reporting()
> >   igb: Remove redundant pci_enable_pcie_error_reporting()
> >   igc: Remove redundant pci_enable_pcie_error_reporting()
> >   ixgbe: Remove redundant pci_enable_pcie_error_reporting()
> 
> It should be simpler to do in one patch. Any reason to split
> it into multiple patches?

Sure, the driver patches could easily be squashed, either by me or be
the netdev folks if they prefer it that way.  There are close to 50
callers, and I hesitate to do them all in a single patch because it
becomes unwieldy to backport (probably pointless for this situation)
or to revert if there's any issue.

These are all trivial removals, but there are a few that are more
complicated and will require closer review, so I didn't include those
here.

> >  drivers/net/ethernet/intel/e1000e/netdev.c    |  7 ---
> >  drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  5 --
> >  drivers/net/ethernet/intel/i40e/i40e_main.c   |  4 --
> >  drivers/net/ethernet/intel/iavf/iavf_main.c   |  5 --
> >  drivers/net/ethernet/intel/ice/ice_main.c     |  3 --
> >  drivers/net/ethernet/intel/igb/igb_main.c     |  5 --
> >  drivers/net/ethernet/intel/igc/igc_main.c     |  5 --
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  5 --
> >  drivers/pci/pcie/aer.c                        | 48 -------------------
> >  9 files changed, 87 deletions(-)
> > 
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
