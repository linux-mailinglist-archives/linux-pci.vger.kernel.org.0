Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14916D7C00
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 13:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbjDELwB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 07:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237630AbjDELwA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 07:52:00 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A988125;
        Wed,  5 Apr 2023 04:51:59 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 11B4792009C; Wed,  5 Apr 2023 13:51:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0A81B92009B;
        Wed,  5 Apr 2023 12:51:58 +0100 (BST)
Date:   Wed, 5 Apr 2023 12:51:57 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/7] PCI: pciehp: Rely on `link_active_reporting'
In-Reply-To: <20230405071839.GA27005@wunner.de>
Message-ID: <alpine.DEB.2.21.2304051246240.63571@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2304042200040.37565@angie.orcam.me.uk> <alpine.DEB.2.21.2304042243250.37565@angie.orcam.me.uk> <20230405071839.GA27005@wunner.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 5 Apr 2023, Lukas Wunner wrote:

> > Use `link_active_reporting' to determine whether Data Link Layer Link 
> > Active Reporting is available rather than re-retrieving the capability.
> > 
> > Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> 
> I provided a Reviewed-by for this patch back in February:
> 
> https://lore.kernel.org/linux-pci/20230213135327.GA29595@wunner.de/

 Apologies, it's been so long and so many distractions that I completely 
forgot about it.  Thank you for your vigilance, and for the review in the 
first place.  Really appreciated!

 I'll post v8 tonight with the change description updated and the patch 
reordered.

  Maciej
