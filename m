Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A730E54D511
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357006AbiFOXRJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355329AbiFOXQm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:16:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D1631384;
        Wed, 15 Jun 2022 16:16:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF0E56199C;
        Wed, 15 Jun 2022 23:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9671CC3411B;
        Wed, 15 Jun 2022 23:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655334990;
        bh=uJDAbRhUne1VpqgJp+NbX5hEuKEciyjlBdAFfwtPGyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1NrWr1wISPVX/Oc4CuOXXqOue8/yTb1uDlXZVqvC1gCx3LEOdyqg/jzqTONTGkv1
         6ba4fWrvAbOBz8CQgEoWNN08NDunGqT3za13pdPvxlx6zhUsl8gVHPgNIzAKsxkKWU
         oA+QUSZrp6ZIBv4ycORBTnqBPAjJFw/ibbuaXWLwAX5M95Ka+90fPu6xyD6z4z64PA
         XTZQt4TNzczMZc+UfjrliYduQNquqZ/XMujw2gojUTVv3264OOYlkD4VM6IxbfXT7r
         Dpb4f8E5ZAOx3VM4rCE6BPN+lVxcDreWjTbtvZj6TdUCczRtdXWHDVk3eqA6s4Go4C
         TvXyGlN3C0N4g==
Date:   Wed, 15 Jun 2022 17:16:26 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mstowe@redhat.com" <mstowe@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Message-ID: <YqpoSp2F+Shqvk/u@kbusch-mbp.dhcp.thefacebook.com>
References: <20220614040044.rypyclhqfv5w4xy7@shindev>
 <20220615194727.GA1022614@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615194727.GA1022614@bhelgaas>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 15, 2022 at 02:47:27PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 14, 2022 at 04:00:45AM +0000, Shinichiro Kawasaki wrote:
> > 
> > Yeah, this WARN is confusing for us then it would be valuable to
> > test by blktests not to repeat it. One point I wonder is: which test
> > group the test case will it fall in? The nvme group could be the
> > group to add, probably.
> > 
> > Another point I wonder is other kernel test suite than blktests.
> > Don't we have more appropriate test suite to check PCI device
> > rescan/remove race ? Such a test sounds more like a PCI bus
> > sub-system test than block/storage test.
> 
> I'm not aware of such a test, but it would be nice to have one.
> 
> Can you share your qemu config so I can reproduce this locally?
> 
> Thanks for finding and reporting this!

Hi Bjorn,

This ought to be reproducible with any pci device that can be removed. Since we
initially observed with nvme, you can try with such a device. A quick way to
get one appearing in qemu is to add parameters:

        -drive id=n,if=none,file=null-co://,format=raw \
	-device nvme,serial=foobar,drive=n
