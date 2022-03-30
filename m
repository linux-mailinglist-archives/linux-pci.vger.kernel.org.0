Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB824ECB0E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 19:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbiC3Ruv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 13:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237874AbiC3Ruu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 13:50:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484A6DA3
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 10:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D91F6609FA
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 17:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F65C340EC;
        Wed, 30 Mar 2022 17:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648662544;
        bh=L33j1N4IfewPczDqxFtMIJIzY9R8yshsvhIvNyGLvtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hetG+tr2A4xqYqd4SSELT/B2q9VBAWjzi0YCeHq+yKQC7wUZXJmyToeCpULzjNY0H
         QXiGLHSyrN3QqFruM0EacAzg4SuvdKsE2QLJO15cWaoZZFK/pgfmpYQ57eyx0CcK7W
         nDQyhJN4vHx8I3G0p2kl5nlnjItq33UhFD9VsWWZVUYnTbcwSdiWMDP1DozhVnyVy0
         ql/2JnIe/0t9Q08n/ES+siF6gmXuakVpPo+IzrDLGFx9xU6r6mwLSGQEEOZuyxifbf
         I1QWWNU3Jn8zH24b7508mOlkLxuD+Dm9+nEHZOw/Q2cSVvZHpAqBfXZrKlpA9PgXvm
         X3bJX29GV8gjg==
Date:   Wed, 30 Mar 2022 12:49:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Nirmal Patel <nirmal.patel@intel.com>
Subject: Re: [PATCH v2 2/2] Allow VMD to disable MSIX remapping with
 interrupt remapping enabled.
Message-ID: <20220330174900.GA1694073@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eddff32-1347-ad09-642c-951a69c82388@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 29, 2022 at 03:48:21PM -0700, Patel, Nirmal wrote:
> On 3/16/2022 8:51 AM, Nirmal Patel wrote:
> > This patch removes a placeholder patch 2565e5b69c44 ("PCI: vmd: Do
> > not disable MSI-X remapping if interrupt remapping is enabled by IOMMU.")
> > This patch was added as a workaround to disable MSI remapping if iommu
> > enables interrupt remapping. VMD does not assign proper IRQ domain to
> > child devices when MSIX is disabled. There is no dependency between MSI
> > remapping by VMD and interrupt remapping by iommu. MSI remapping can be
> > enabled or disabled with and without interrupt remap.
> >
> > Signed-off-by: Nirmal Patel <nirmal.patel@intel.com>
> > ---
> >  drivers/pci/controller/vmd.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index 3a6570e5b765..91bc1b40d40c 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -6,7 +6,6 @@
> >  
> >  #include <linux/device.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/iommu.h>
> >  #include <linux/irq.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > @@ -813,8 +812,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> >  	 * acceptable because the guest is usually CPU-limited and MSI
> >  	 * remapping doesn't become a performance bottleneck.
> >  	 */
> > -	if (iommu_capable(vmd->dev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
> > -	    !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> > +	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> >  	    offset[0] || offset[1]) {
> >  		ret = vmd_alloc_irqs(vmd);
> >  		if (ret)

If/when you repost this, please update the subject and commit log to
use "MSI-X" consistently instead of the current mix of "MSI-X" and
"MSIX".

Also s/iommu/IOMMU/.

In subject line, add "PCI: vmd: " prefix and drop trailing period.

Also rewrite commit log in imperative mood, e.g., "Revert 2565e5b69c44
..." instead of "This patch removes ..."  It's 100% clear that the
commit log refers to *this* patch, so it's pointless to include that.

It's further confusing that "This patch was added ..." refers to
*2565e5b69c44*, not this revert.

This reverts 2565e5b69c44 (but doesn't remove the #include
<linux/iommu.h>" added by 2565e5b69c44).

2565e5b69c44 fixed a problem.  If that fix is no longer necessary
because of some other change, the commit log should mention that
change.  Otherwise somebody will backport this fix too far and
reintroduce the problem solved by 2565e5b69c44.

Bjorn
