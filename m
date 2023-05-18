Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54960708AC9
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 23:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjERVyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 17:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjERVyO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 17:54:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F64FE7A
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 14:54:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD9F165270
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 21:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E6BC433EF;
        Thu, 18 May 2023 21:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684446852;
        bh=q999XaQD8IvsTs1tBr0P2d2XRmwp7YsUG0dFMKgn0vU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YeFJk/sW8iAFbOroLH1TToVz1Gn5qDGlo3VmP19UEhQ89Com/FaALrPgT8f2KUYPW
         E6G2Q5htCNzOUiateIohRXSvaA7tuzy4mLrp19MFwffUyemoXqtlRvsBYFDSjC6CLE
         fuC0SayhVtzmrXPb3qTNwIAo206CANfzJmZ/sDNiCc68JSRhprb3ZIIy73PeIIkZdr
         ZJtOKQGVMHAwMtEobnQUxJrSzA8EhpwCbU+tjVUE3XW+JLnhrMNhsMoYXeq8/xpmKr
         FRCd2UBgKUHoLltw0VncQY3b/FMzJXW8d2wxm4Mqbyb+GW8+mElNb49P7gMIIrrrUm
         fTT0+Gi7NWXrg==
Date:   Thu, 18 May 2023 16:54:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/5] PCI/ASPM: aspm_disable/default state handling and
 other trivial fixes
Message-ID: <ZGaegrNyjXSGe3kQ@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGadmGNsHhVO0e1P@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 18, 2023 at 04:50:18PM -0500, Bjorn Helgaas wrote:
> On Thu, May 04, 2023 at 04:42:56PM +0530, Ajay Agarwal wrote:
> > On going through the aspm driver, I found some potential bugs
> > and opportunities for code cleanup in the way the aspm_disable
> > and aspm_default states are being handled by the driver.
> > Perform other refactoring as well.
> > 
> > Changes from v2 to v3:
> >  - Commit message updates
> > 
> > Changes from v1 to v2:
> >  - Split the patches into smaller patches
> >  - Add the patch to rename L1.2 specific functions
> > 
> > Ajay Agarwal (5):
> >   PCI/ASPM: Disable ASPM_STATE_L1 only when driver disables L1 ASPM
> >   PCI/ASPM: Set ASPM_STATE_L1 only when driver enables L1
> >   PCI/ASPM: Set ASPM_STATE_L1 when driver enables L1ss
> >   PCI/ASPM: Rename L1.2 specific functions
> >   PCI/ASPM: Remove unnecessary ASPM_STATE_L1SS check
> > 
> >  drivers/pci/pcie/aspm.c | 34 +++++++++++++++-------------------
> >  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> Applied to pci/aspm for v6.5, thanks!

Forgot to mention that I picked up Sathy's Reviewed-by on patches 1
and 2 from the v2 posting.  If you only change things suggested by the
reviewer, you can carry those tags forward to the next posting.

Bjorn
