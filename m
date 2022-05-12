Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B23C5256FD
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352321AbiELVXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 17:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349865AbiELVXV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 17:23:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 026FE24C752;
        Thu, 12 May 2022 14:23:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A511D106F;
        Thu, 12 May 2022 14:23:19 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.4.238])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 944173F66F;
        Thu, 12 May 2022 14:23:16 -0700 (PDT)
Date:   Thu, 12 May 2022 22:23:09 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        tjoseph@cadence.com, bhelgaas@google.com, robh@kernel.org,
        kishon@ti.com, kw@linux.com, mparab@cadence.com,
        linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: cadence: Clear FLR in device capabilities
 register
Message-ID: <Yn16vX1cGMt0CVj6@lpieralisi>
References: <165228494389.11307.11313445181760109588.b4-ty@arm.com>
 <20220512190626.GA862290@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512190626.GA862290@bhelgaas>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 02:06:26PM -0500, Bjorn Helgaas wrote:
> On Wed, May 11, 2022 at 05:02:35PM +0100, Lorenzo Pieralisi wrote:
> > On Mon, 15 Nov 2021 23:39:16 -0800, Parshuram Raju Thombare wrote:
> > > From: Parshuram Thombare <pthombar@cadence.com>
> > > 
> > > Clear FLR (Function Level Reset) from device capabilities
> > > registers for all physical functions.
> > > 
> > > During FLR, the Margining Lane Status and Margining Lane Control
> > > registers should not be reset, as per PCIe specification.
> > > However, the controller incorrectly resets these registers upon FLR.
> > > This causes PCISIG compliance FLR test to fail. Hence preventing
> > > all functions from advertising FLR support if flag quirk_disable_flr
> > > is set.
> > > 
> > > [...]
> > 
> > Applied to pci/cadence, thanks!
> > 
> > [1/1] PCI: cadence: Clear FLR in device capabilities register
> >       https://git.kernel.org/lpieralisi/pci/c/d3dbd4d862
> 
> Obviously you've already seen the kbuild report:
>   https://lore.kernel.org/r/202205120700.X76G7aC2-lkp@intel.com
> 
> but it looks like most of this patch got lost somehow :)  Happy to fix
> it up for you if you want!

I have messed up the merge, now rebuilt my pci/cadence branch, it
_should_ be fixed, apologies.

Lorenzo
