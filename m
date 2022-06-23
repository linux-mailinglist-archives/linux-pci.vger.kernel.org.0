Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E69558778
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 20:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiFWS1P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 14:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiFWS1B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 14:27:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4C82BE9;
        Thu, 23 Jun 2022 10:28:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07F3861B9F;
        Thu, 23 Jun 2022 17:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C00C3411B;
        Thu, 23 Jun 2022 17:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656005284;
        bh=zKTHUEkMNbZcc0IfdYhL4S+A/UWDDSTSzsFXGIjten8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LUF+Z1PfLas2pb5K370GJ2gIxWvky9TVIVHg3VrtLDDtbSoaDmcyPhhCt5oLn6rBC
         C3XR0qizSeh7cEjS4xn+0xj2PhaMas/lnO3KWYz/qJIocmcWwkymycV4F+D3EzY3N7
         vFh9r62bduK2gNXt6G+97KwDxYRnmJV9oz0GCz6RfGkkg9+kCHR5egw6XvChuMm3PO
         zsc5QLQrMneyg7E8dDcDSRlvs07+0cVh2NwyTp8H5jZpxD2muts6V3AXUgPPscFZrX
         mJ98SMqDVJwYP4EOZwtVIibcWUTBdW9kYlgdo0NgRY2FpIVOTZIVA45WI2Cg4ds7Ux
         N/3UGODsqUpSA==
Date:   Thu, 23 Jun 2022 12:28:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, koba.ko@canonical.com,
        Oliver O'Halloran <oohall@gmail.com>, bhelgaas@google.com,
        mika.westerberg@linux.intel.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH v4 2/2] PCI/DPC: Disable DPC service when link is in
 L2/L3 ready, L2 and L3 state
Message-ID: <20220623172802.GA1461319@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p61knfUS02Ny9JCn18F8EgiP0EmJjJcPZ6PoKsPC0y5Hg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 10:27:31AM +0800, Kai-Heng Feng wrote:
> On Mon, Apr 18, 2022 at 10:41 AM Sathyanarayanan Kuppuswamy
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> > On 4/8/22 8:31 AM, Kai-Heng Feng wrote:
> > > On Intel Alder Lake platforms, Thunderbolt entering D3cold can cause
> > > some errors reported by AER:
> > > [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> > > [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > > [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> > > [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > > [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> > > [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> > > [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> > > [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
> > >
> > > Since AER is disabled in previous patch for a Link in L2/L3 Ready, L2
> > > and L3, also disable DPC here as DPC depends on AER to work.
> > >
> > > Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=215453
> > > Reviewed-by: Mika Westerberg<mika.westerberg@linux.intel.com>
> > > Signed-off-by: Kai-Heng Feng<kai.heng.feng@canonical.com>
> >
> > Reviewed-by: Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> A gentle ping...

See questions here:
https://lore.kernel.org/r/20220422222433.GA1464120@bhelgaas
