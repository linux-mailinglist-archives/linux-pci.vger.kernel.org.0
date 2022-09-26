Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09ABF5EAE7F
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 19:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiIZRtk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 13:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiIZRtN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 13:49:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080EC97EC0;
        Mon, 26 Sep 2022 10:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98A5D60DB7;
        Mon, 26 Sep 2022 17:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0298C433D6;
        Mon, 26 Sep 2022 17:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664212868;
        bh=nnJQPOkwFK1+jDHcMZbZ1ZPA6870WiPeyZQhh9AHeIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KQi4m3MOueTduJHIuUVB/BBIBRH1auZz+TMGV1gbvyjaYWV97ukOucDbVgfLdDz/U
         BLRGbznTu00jC/vLYn/JUYCFAM6/RuoYSBeAUXqKRtWJkOmXdxm1SqUYtouUdx3L0h
         A/IljZ8TsvX08juVJInq1826FqCqt9ieEeciJ0OY+bGnt1DroOdDYZFnLo7PthBCW+
         flWywRovRhg0gud+xBy2TDCxJekRihHtpx1innborvq6x9KZd5oY/YrLAL4I8lHLHE
         nTZC9Ubh9EVPgRA5OLjFVWD/qHJYctHCFMMuskv0LCFow8VysVM6OqIxK3fAHARxtL
         BTWyLp7o1KkoA==
Date:   Mon, 26 Sep 2022 12:21:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhuo Chen <chenzhuo.1@bytedance.com>
Cc:     allenbh@gmail.com, dave.jiang@intel.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, jejb@linux.ibm.com,
        james.smart@broadcom.com, Serge Semin <fancer.lancer@gmail.com>,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
        oohall@gmail.com, jdmason@kudzu.us, bhelgaas@google.com,
        dick.kennedy@broadcom.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] PCI/AER: Use pci_aer_clear_uncorrect_error_status()
 to clear uncorrectable error status
Message-ID: <20220926172106.GA1609382@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e094839-c643-d2e7-698e-0fb6c0e50c4f@bytedance.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 09:30:48PM +0800, Zhuo Chen wrote:
> On 9/23/22 4:02 AM, Bjorn Helgaas wrote:
> > On Mon, Sep 12, 2022 at 01:09:05AM +0800, Zhuo Chen wrote:
> > > On 9/12/22 12:22 AM, Serge Semin wrote:
> > > > On Fri, Sep 02, 2022 at 02:16:32AM +0800, Zhuo Chen wrote:

> > > ‘pci_aer_clear_nonfatal_status()’ in drivers/crypto/hisilicon/qm.c will be
> > > removed in the next kernel:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/crypto/hisilicon/qm.c?id=00278564a60e11df8bcca0ececd8b2f55434e406
> > 
> > This is a problem because 00278564a60e ("crypto: hisilicon - Remove
> > pci_aer_clear_nonfatal_status() call") is in Herbert's cryptodev tree,
> > and if I apply this series to the PCI tree and Linus merges it before
> > Herbert's cryptodev changes, it will break the build.
> > 
> > I think we need to split this patch up like this:
> > 
> >    - Add pci_aer_clear_uncorrect_error_status() to PCI core
> >    - Convert dpc to use pci_aer_clear_uncorrect_error_status()
> >      (I might end up squashing with above)
> >    - Convert lpfc to use pci_aer_clear_uncorrect_error_status()
> >    - Convert ntb_hw_idt to use pci_aer_clear_uncorrect_error_status()
> >    - Unexport pci_aer_clear_nonfatal_status()
> > 
> > Then I can apply all but the last patch safely.  If the crypto changes
> > are merged first, we can add the last one; otherwise we can do it for
> > the next cycle.
> > 
> Good proposal. I will implement these in the next version.
> 
> Do I need to put pci related modifications (include patch 2/3 and 3/3) in a
> patch set or just single patches?

When in doubt, put them in separate patches.  It's trivial for me to
squash them together if that makes more sense, but much more difficult
for me to split them apart.

Thanks for helping clean up this area!

Bjorn
