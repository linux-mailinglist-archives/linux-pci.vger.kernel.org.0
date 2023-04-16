Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615226E357A
	for <lists+linux-pci@lfdr.de>; Sun, 16 Apr 2023 08:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDPGmB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Apr 2023 02:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDPGmA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Apr 2023 02:42:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60A82D73;
        Sat, 15 Apr 2023 23:41:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8649C67373; Sun, 16 Apr 2023 08:41:56 +0200 (CEST)
Date:   Sun, 16 Apr 2023 08:41:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Message-ID: <20230416064156.GA6410@lst.de>
References: <a79ea7f5-6a41-a6c9-cfec-ba01aa2a3cfa@leemhuis.info> <20230328012231.GB21977@lst.de> <01c50370-002d-5e18-3edc-81c9527aedc9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c50370-002d-5e18-3edc-81c9527aedc9@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 01:18:45PM +0100, Robin Murphy wrote:
> FWIW "Marvell SATA" instantly makes me suspect the phantom function quirk. 
> What *should* happen is the IOMMU driver sees the PCI DMA aliases correctly 
> and sets up context entries for both 07.00.0 and 07.00.1, but it looks like 
> that may be what's gone awry.

Looking at the bug report it seems this is device 9235, which doesn't
need the DMA alias quirks.
