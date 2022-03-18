Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DFB4DDC2F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 15:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiCROwn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiCROwm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 10:52:42 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D4F261B;
        Fri, 18 Mar 2022 07:51:22 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 385E128042B86;
        Fri, 18 Mar 2022 15:51:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2CB204ADE5; Fri, 18 Mar 2022 15:51:21 +0100 (CET)
Date:   Fri, 18 Mar 2022 15:51:21 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Message-ID: <20220318145121.GA11127@wunner.de>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
 <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjRvMk1kcbMwJvx+@lahna>
 <65207fdf-c4ab-5165-dbda-8ab55b51adb7@arm.com>
 <YjSCWaq7Ej/2iJPp@lahna>
 <78fc0426-c22a-ec62-f92b-0019bea5947e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78fc0426-c22a-ec62-f92b-0019bea5947e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 18, 2022 at 02:08:16PM +0000, Robin Murphy wrote:
> OK, so do we have any realistic options for identifying the correct PCI
> devices, if USB4 PCIe adapters might be anywhere relative to their
> associated NHI? Short of maintaining a list of known IDs, the only thought I
> have left is that if we walk the whole PCI segment looking specifically for
> hotplug-capable Gen1 ports, any system modern enough to have Thunderbolt is
> *probably* not going to have any real PCIe Gen1 hotplug slots, so maybe
> false negatives might be tolerable, but it still feels like a bit of a
> sketchy heuristic.

The Thunderbolt Device ROM contains the PCI slot number, so you can
correlate the Thunderbolt switch ports with PCIe downstream ports
and know exactly where PCIe tunnels are terminated.

Code is here:
* thunderbolt: Obtain PCI slot number from DROM
  https://github.com/l1k/linux/commit/756f7148bc10
* thunderbolt: Move upstream_port to struct tb
  https://github.com/l1k/linux/commit/58f16e7dd431
* thunderbolt: Correlate PCI devices with Thunderbolt ports
  https://github.com/l1k/linux/commit/f53ea40a7487

I implemented that in 2018, so it won't apply cleanly to current
mainline.  But I kept forward-porting it on my private branch and
could push that to GitHub if anyone is interested.

I don't know if this will work out-of-the-box for SoC-integrated
Thunderbolt controllers.  It was developed with the discrete
controllers in mind, which was the only thing available back then.

Thanks,

Lukas
