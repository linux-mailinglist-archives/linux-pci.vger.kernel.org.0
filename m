Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72E76CB31C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 03:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjC1BWg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 21:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1BWg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 21:22:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F29419AD;
        Mon, 27 Mar 2023 18:22:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2F39C68AA6; Tue, 28 Mar 2023 03:22:32 +0200 (CEST)
Date:   Tue, 28 Mar 2023 03:22:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Message-ID: <20230328012231.GB21977@lst.de>
References: <a79ea7f5-6a41-a6c9-cfec-ba01aa2a3cfa@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79ea7f5-6a41-a6c9-cfec-ba01aa2a3cfa@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


I finally found some real time to look into this:

On Tue, Mar 21, 2023 at 02:52:00PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> > The man errors I am getting are
> > 
> > dmar_fault 8 callbacks suppressed
> > DMAR : DRHD: handling fault status req 2
> > DMAR : [DMA Write NO_PASID] Request device [07.00.1] fault addr
> > 0xfffe0000 [fault reason 0x82] Present bit in contect entry is clear

This clearly indicates that my original idea about the AMD gart was
completely bonkers, as we're obviously on an Intel platform.

And this indicates that the device is trying to do a DMA write to
something that isn't IOMMU mapped.  Getting this from an initialization
change (commit 78013eaadf6 (x86: remove the IOMMU table infrastructure")
feels very strange to me.

Can you maybe post the full dmesg?  I wonder if there is interesting
initialization error in here.

