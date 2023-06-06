Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F65F723D39
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 11:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjFFJYk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 05:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbjFFJYj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 05:24:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF59AE4B;
        Tue,  6 Jun 2023 02:24:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 64DA367373; Tue,  6 Jun 2023 11:24:35 +0200 (CEST)
Date:   Tue, 6 Jun 2023 11:24:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Adriaanse <jason_a69@yahoo.co.uk>, hch@lst.de,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>, baolu.lu@linux.intel.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Message-ID: <20230606092435.GA31061@lst.de>
References: <5f37b0b0-6cb5-b210-a894-d1e91976126e@arm.com> <2a699a99-545c-1324-e052-7d2f41fed1ae@yahoo.co.uk> <07ee0cf7-a5c2-f87a-d627-8dd8fb082345@arm.com> <9648f668-a3bc-3296-71d1-c91cd4c9980e@yahoo.co.uk> <1539e760-392f-a33e-436e-bbf043e79bfc@arm.com> <14f2b1ab-2c7c-fa4d-5854-3df08ac9feef@yahoo.co.uk> <1928df45-7b56-a8a4-21b5-22e5d8ef95eb@leemhuis.info> <9b602abc-37e9-f236-37ee-71bcf1b7ce66@arm.com> <211f3938-2f93-cad7-a92b-821d3ac45b9e@leemhuis.info> <c7da7095-7d68-c65b-daf8-7eee43b79d53@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7da7095-7d68-c65b-daf8-7eee43b79d53@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 02, 2023 at 03:07:19PM +0200, Thorsten Leemhuis wrote:
> Christoph, could you do me a favor and...

> ...submit that quirk, as Bjorn and Alex apparently didn't pick this up?
> I could do so myself, but prefer to leave that to people that actually
> known what they are doing -- and thus can also handle problems later, in
> case any show up. And strictly speaking it apparently was you who caused
> this regression with 78013eaadf6 ("x86: remove the IOMMU table
> infrastructure").

Well, Robin posted it so I think he should also finish it up and get
the credit.  Robin, can you send the quirk with a formal signoff?

