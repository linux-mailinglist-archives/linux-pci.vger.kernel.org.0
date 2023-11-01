Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BC57DE07C
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 12:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbjKALpq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 07:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjKALpp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 07:45:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB48119;
        Wed,  1 Nov 2023 04:45:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09E1C433C7;
        Wed,  1 Nov 2023 11:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698839143;
        bh=uRdXVaNPSlmlco16plmQ5T/iCvBKB01tajwUhNVdG/g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RPoaNCBh+5fWMFs+UXqnfKgZH7T4yKQK6DTDbUkzeIY5Wt0e1UVOXzqawPZnLhVxl
         dFmYdGqgRQZDNKi8x2I4n1FnaR3qFsPSHO1Rwqrz8AbK/t/1mbqRXJLPIvMj1Ctmp1
         PG8bon32+33rlzgcCY6y3ZdQGNRmCtyMlowB56lJ+oMeOUBQZHjkiJRvd7h5Zqbkik
         6lTjUGPSERr1/WzpjN+In6K8tIBIfXBTE/NFbRZaOfzDoamWJCpJvGaN3N651KcICo
         UEytFq27OCxmWI0OUmPMZOF4jB883M7OfExPK/5Cr/sLru00NZICixp6lpb6SHDlaY
         6SeEXPqji8vvg==
Date:   Wed, 1 Nov 2023 06:45:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, gloriouseggroll@gmail.com
Subject: Re: Fwd: Regression: Kernel 6.4 rc1 and higher causes Steam Deck to
 fail to wake from suspend (bisected)
Message-ID: <20231101114541.GA43502@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e784280-02bb-4e0e-a5ae-4e0a40ea4c51@gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Tue, Oct 31, 2023 at 03:21:20PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> > On Kernel 6.4 rc1 and higher if you put the Steam Deck into suspend then press the power button again it will not wake up. 
> > 
> > I don't have a clue as to -why- this commit breaks wake from suspend on steam deck, but it does. Bisected to:
> > 
> > ```
> > 1ad11eafc63ac16e667853bee4273879226d2d1b is the first bad commit
> > commit 1ad11eafc63ac16e667853bee4273879226d2d1b
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Tue Mar 7 14:32:43 2023 -0600
> > 
> >     nvme-pci: drop redundant pci_enable_pcie_error_reporting()
> >     
> >     pci_enable_pcie_error_reporting() enables the device to send ERR_*
> >     Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> >     native"), the PCI core does this for all devices during enumeration, so the
> >     driver doesn't need to do it itself.
> >     
> >     Remove the redundant pci_enable_pcie_error_reporting() call from the
> >     driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
> >     from the driver .remove() path.
> >     
> >     Note that this only controls ERR_* Messages from the device.  An ERR_*
> >     Message may cause the Root Port to generate an interrupt, depending on the
> >     AER Root Error Command register managed by the AER service driver.
> >     
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >     Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> >     Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> >  drivers/nvme/host/pci.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > ```
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.4.y&id=1ad11eafc63ac16e667853bee4273879226d2d1b
> > 
> > Reverting that commit by itself on top of 6.5.9 (stable) allows it to wake from suspend properly.
> 
> See Bugzilla for the full thread.
> 
> Anyway, I'm adding this regression to regzbot:
> 
> #regression introduced: 1ad11eafc63ac1 https://bugzilla.kernel.org/show_bug.cgi?id=218090
> #regression title: Steam Deck fails to wake from suspend due to pci_enable_pcie_error_reporting() removal
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218090

Thanks, I requested some dmesg logs and lspci output to help debug
this.
