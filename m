Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6006E3581
	for <lists+linux-pci@lfdr.de>; Sun, 16 Apr 2023 08:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjDPGzL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Apr 2023 02:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDPGzK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Apr 2023 02:55:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD051FC7;
        Sat, 15 Apr 2023 23:55:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 80B4167373; Sun, 16 Apr 2023 08:55:04 +0200 (CEST)
Date:   Sun, 16 Apr 2023 08:55:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Adriaanse <jason_a69@yahoo.co.uk>
Cc:     robin.murphy@arm.com, baolu.lu@linux.intel.com, hch@lst.de,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Message-ID: <20230416065503.GB6410@lst.de>
References: <01c50370-002d-5e18-3edc-81c9527aedc9@arm.com> <04a94830-f626-2cd7-d220-7ba3025a409c@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04a94830-f626-2cd7-d220-7ba3025a409c@yahoo.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jason,

sorry for the late reply.  I had some email issues and am still
recovering from the backlog.

On Fri, Mar 31, 2023 at 10:20:37AM +0800, Jason Adriaanse wrote:
> Hi Christoph and Robin,
>
> Christoph - I would like to send you more dmesg information but as my boot 
> device cannot be detected that information is not being written to disk. Is 
> there any way to specifically write boot debug information to say a USB 
> device with some kernel parameters?

I don't know of any good way.  pstore has some ways to save kernel
messages, but it doesn't work to well with normal block devices in
case of crashes.

I'm a bit lost at the moment.

Two ideas I have, would be to

 1) boot with the intel_iommu=off kernel command line
 3) build a kernel with CONFIG_INTEL_IOMMU

and see if that works and report the dmesg.
