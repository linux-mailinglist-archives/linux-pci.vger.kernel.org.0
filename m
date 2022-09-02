Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAF35ABB28
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 01:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiIBXcj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 19:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIBXci (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 19:32:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8218FBA52;
        Fri,  2 Sep 2022 16:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BE85B82E09;
        Fri,  2 Sep 2022 23:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFF4C433D6;
        Fri,  2 Sep 2022 23:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662161555;
        bh=ql5z0DlbjgYQ4iRXGuQnGIo40H+DIE+ADXoJxnPR0oA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r/WhKay9QaAlFpfwSR8CPlw8+AkFRg41xzGrTlMtuw5HCnviRus2WqxD8UlT2dQU6
         Rn9kJ5VaLpq55OdkbSdnJdu2T9v2fSBJWpAkC9YFO6kYfsFwWs6CEh59fvVHOKHiUW
         Ux7PxnvDxu1nlB8GaPOHm/hTIOf7ellSV80lwR18TomrnVjmoHf742PRAG2o9qKEsv
         28PlRyovrUDbWJzJ47lK15poKSehnK3D07gEPIjpduKnJ/o73t+FjL/mkNuNx2FW+i
         Ohm7EKf7dclSfJN2cNnGZZKutBu6IH3F/Qdkz5MvnO1Ub3CAyi4QoW7KlnvSEcxSkx
         v4osYuZpEED4Q==
Date:   Fri, 2 Sep 2022 18:32:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/4] PCI/PTM: Preserve PTM Root Select
Message-ID: <20220902233233.GA390494@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44b33ce9-e0ed-976c-9a13-b154d32b200e@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 02, 2022 at 02:11:12PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 9/2/22 1:38 PM, Bjorn Helgaas wrote:
> > On Fri, Sep 02, 2022 at 10:24:05AM -0700, Sathyanarayanan Kuppuswamy wrote:
> >> On 9/2/22 7:58 AM, Bjorn Helgaas wrote:
> >>> From: Bjorn Helgaas <bhelgaas@google.com>
> >>>
> >>> When disabling PTM, there's no need to clear the Root Select bit.  We
> >>> disable PTM during suspend, and we want to re-enable it during resume.
> >>> Clearing Root Select here makes re-enabling more complicated.
> >>
> >> Currently, it looks like we disable PCI_PTM_CTRL_ROOT in pci_disable_ptm(),
> >> but not enable it in pci_enable_ptm(). Do you know this did not trigger an
> >> issue?
> ...

> > Thanks for asking this, because it reminds me why I didn't add
> > pci_enable_ptm() calls in the resume paths!  That would make them
> > parallel with the suspend paths, which would definitely be nice.  But
> > we would have to rework pci_enable_ptm() to work for Root Ports and
> > Switch Ports as well.  I think we *could* do that.  What do you think?
> 
> IMO, the code will look better if we keep the suspend and resume paths in
> sync. Since we are calling pci_disable_ptm() in suspend path, it makes
> sense to call pci_enable_ptm() in resume path.
> 
> Making the pci_enable_ptm() handle root and upstream ports should not
> be very complicated, right?

I took a stab at it.  pci_enable_ptm() is getting kind of ugly, but
maybe it's better overall.  I'll post it and you can see what you
think.
