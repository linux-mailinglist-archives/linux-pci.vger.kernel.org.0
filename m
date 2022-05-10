Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8EC5222E9
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 19:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245595AbiEJRlj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 13:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348312AbiEJRlg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 13:41:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE6160BB7
        for <linux-pci@vger.kernel.org>; Tue, 10 May 2022 10:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48230B81EB8
        for <linux-pci@vger.kernel.org>; Tue, 10 May 2022 17:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AFAC385A6;
        Tue, 10 May 2022 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652204256;
        bh=amTynlsXSBDuV1LFoOUJ1nJYmmTUPo8m+sUT2qLGbfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qGgAFeGkkU7hvHnGWmMBwVefIyzpToHL4n5gIYqCLtcTi7KltgF77CbO1XEHH/kWL
         HSOROQa0juqsaf0R9pxGuY7rv6ix4KvKHeo3tMTWdhtK5oyIGw8aWOzqX79vbhvZX1
         ecMeGSQDDWOy5xy6+zyrjhCA8NgyOelpGgnMzg4QQZgXbpDN6Vi9q2H5ebpdDr5H2P
         zK56qOnucef6pfoEVWc9QQcb3TrpqET13tAd1C562MPxb72YHVjP13PGn2SlZ/iGw8
         itIq/ZPA9TVCvozQOVvZ8eW8E7pix8EaKwDwXyMNdykxrMlDWqlB5qkhCYcCGuye2j
         8Mqj7TE3228Tg==
Date:   Tue, 10 May 2022 12:37:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Write to srvio_numvfs triggers kernel panic
Message-ID: <20220510173733.GA688834@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnoIossyu7KQ8xmC@infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 09, 2022 at 11:39:30PM -0700, Christoph Hellwig wrote:
> On Mon, May 09, 2022 at 10:58:57AM -0600, Alex Williamson wrote:
> > is_physfn = 0, is_virtfn = 0: A non-SR-IOV function
> > is_physfn = 1, is_virtfn = 0: An SR-IOV PF
> > is_physfn = 0, is_virtfn = 1: An SR-IOV VF
> > 
> > As implemented with bit fields this is 2 bits, which is more space
> > efficient than an enum.  Thanks,
> 
> A two-bit bitfield with explicit constants for the values would probably
> still much eaiser to understand.
> 
> And there is some code that seems to intepret is_physfn a bit odd, e.g.:
> 
> arch/powerpc/kernel/eeh_sysfs.c:        np = pci_device_to_OF_node(pdev->is_physfn ? pdev : pdev->physfn);
> arch/powerpc/kernel/eeh_sysfs.c:        np = pci_device_to_OF_node(pdev->is_physfn ? pdev : pdev->physfn);

"dev->sriov != NULL" and "dev->is_physfn" are basically the same and
many of the dev->is_physfn uses in drivers/pci would end up being
simpler if replaced with dev->sriov, e.g.,

  int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
  {
    if (!dev->is_physfn)
      return -EINVAL;
    return dev->bus->number + ((dev->devfn + dev->sriov->offset +
				dev->sriov->stride * vf_id) >> 8);
  }

would be more obvious as:

  if (dev->sriov)
    return dev->bus->number + ((dev->devfn + dev->sriov->offset +
				dev->sriov->stride * vf_id) >> 8);
  return -EINVAL;
