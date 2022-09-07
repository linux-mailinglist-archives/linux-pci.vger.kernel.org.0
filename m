Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6948B5B0EF3
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 23:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIGVMK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 17:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGVMJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 17:12:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64255B5A7A;
        Wed,  7 Sep 2022 14:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E861561AA6;
        Wed,  7 Sep 2022 21:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E7EC433D6;
        Wed,  7 Sep 2022 21:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662585127;
        bh=+6pupswLT/5KMqoUVG/++x6soH6vXGFxtdFjR4zc48o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j1U0pDn67U4M2WDDIAFvV5uy8PC8N8RDxNh3grnUPADeAOzuPwKSLLDchTNa58vrk
         thqTWKOM316PnE4oALrDBqBOa/X8yRvq+DiFY+CqI563xm1csr/YW1Q23GqBKgGLs3
         K5ccTPx18GnCvYjiUP0UDoy9xfMD7K/c77xhicx7ZCQ+Uc+JxKQbTffRlzI1ILWTBD
         DE6jyM73/2qmYhA9YrCf1dxb0c6owNsSQenwOvx6ye8DgwBcqGcLl2tu8rE9+Hy1yf
         i9n+c8MUS4gcZ32aPkQLUfp7qZ98BIwT+BLTnd5dEZdRjYmuaoM6e6fic+R+5M6i6q
         6Wg137N6szTVw==
Date:   Wed, 7 Sep 2022 16:12:05 -0500
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
Subject: Re: [PATCH v3 05/10] PCI/PTM: Add pci_disable_ptm() wrapper
Message-ID: <20220907211205.GA119516@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxgsCwOeFJVvItVO@black.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 07, 2022 at 08:28:43AM +0300, Mika Westerberg wrote:
> On Tue, Sep 06, 2022 at 05:23:46PM -0500, Bjorn Helgaas wrote:
> > @@ -42,6 +42,13 @@ void pci_disable_ptm(struct pci_dev *dev)
> >  	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
> >  }
> 
> Since you export these, I suggest adding kernel-doc to explain how these
> are supposed to be used in drivers (pre-conditions etc.).

Currently there really aren't any preconditions, so kernel-doc would
repeat the function name and parameters without adding any real
information, but I think it would be good to add a few explanatory
comments.  It always seems obvious when writing it, but it's never so
obvious without all the context ;)

> > +void pci_disable_ptm(struct pci_dev *dev)
> > +{
> > +	__pci_disable_ptm(dev);
> > +	dev->ptm_enabled = 0;
> > +}
> > +EXPORT_SYMBOL(pci_disable_ptm);
> 
> EXPORT_SYMBOL_GPL()?

I don't feel strongly either way, but am inclined to do the same as
pci_enable_ptm() and pcie_ptm_enabled(), which are both EXPORT_SYMBOL.
We could change all of them at once if it's worthwhile.  Currently
there's only one caller (igc) in the tree.

Bjorn
