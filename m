Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7793B708ABB
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 23:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjERVuV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 17:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjERVuU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 17:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD2B18F
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 14:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B21E65280
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2023 21:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533DAC43445;
        Thu, 18 May 2023 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684446618;
        bh=pvB1dqx6BmrDhpE0rLsmDlFZ7NJUbH9faiGI0N3crJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=s3W0wSwuJcyq2iOt/4sn4enNUUwIF2gOMiK2x8BGhBdNSxPmgw090mN8XOA2huPa3
         6ol3oHXQbv/S8pTHxGtGrmv7ZL1sBMgw+Q70rnHdnRIix7/mwyCcR1/oo9qBbOWgOx
         jRrv9lVE8i18S181xqTlK2IsNZgUUIjmEe/F81SFORAZ7m9db8jVqA3lfW7qtNZgcG
         FPcdPALy68/InxwLUNN6/U+hKh2v5UlVBPdxKxzLgW5X/AWuE0u+thOCvMg5gpB7z/
         SeMYx2DzbOjo7WVzKeUGuzMTM5NHZF/5zt47xzk3HGQJQyCXxX4gv/ZOiBMZ1I1k1A
         EF5ns/0md7w3A==
Date:   Thu, 18 May 2023 16:50:16 -0500
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
Message-ID: <ZGadmGNsHhVO0e1P@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504111301.229358-1-ajayagarwal@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 04, 2023 at 04:42:56PM +0530, Ajay Agarwal wrote:
> On going through the aspm driver, I found some potential bugs
> and opportunities for code cleanup in the way the aspm_disable
> and aspm_default states are being handled by the driver.
> Perform other refactoring as well.
> 
> Changes from v2 to v3:
>  - Commit message updates
> 
> Changes from v1 to v2:
>  - Split the patches into smaller patches
>  - Add the patch to rename L1.2 specific functions
> 
> Ajay Agarwal (5):
>   PCI/ASPM: Disable ASPM_STATE_L1 only when driver disables L1 ASPM
>   PCI/ASPM: Set ASPM_STATE_L1 only when driver enables L1
>   PCI/ASPM: Set ASPM_STATE_L1 when driver enables L1ss
>   PCI/ASPM: Rename L1.2 specific functions
>   PCI/ASPM: Remove unnecessary ASPM_STATE_L1SS check
> 
>  drivers/pci/pcie/aspm.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)

Applied to pci/aspm for v6.5, thanks!

Bjorn
