Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274C94B2E12
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 20:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245650AbiBKT5v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 14:57:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiBKT5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 14:57:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4362DAD
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 11:57:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C466AB82C8D
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 19:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5782DC340E9;
        Fri, 11 Feb 2022 19:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644609466;
        bh=0W7IKkvywATUdWa/xdPaBER17lZZbLUWf0+Tum+aWVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ValmFZKrD0UIYNnt6pxxrxPfLvW/bF7YVAFBAJMWC1uT0h7iPJGPhotSPsfQhq0wR
         s6UWaAVJza592fSmkvwGA/U8QTURwI2vCDZe+ZmPkSU0i+poA6my3gRTa9VGD7L5YJ
         489mC51sp7tK+lVXVVx6a81g8xY4EsuDlE6Ixxe0kzGONYstW+9H4G/7fPUH7+9cX4
         0hOT9hctqLRu92DciXVUAiqZ/v+7IClD/1q2rxo/nusy2kwXpfUqTV/QTrhaBVc2PX
         F7mQcfFxL/fpSJexnRDxO2t470yHV2EV4FTZrIxExJw2emfFpkvEMKMcj86cghi53d
         QYy70VRnnTcug==
Date:   Fri, 11 Feb 2022 13:57:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, Jan Palus <jpalus@fastmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [Bug 215540] New: mvebu: no pcie devices detected on turris
 omnia (5.16.3 regression)
Message-ID: <20220211195744.GA728212@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220211194330.siiwntko6b3lldw4@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 11, 2022 at 08:43:30PM +0100, Pali Rohár wrote:
> On Thursday 03 February 2022 09:47:28 Bjorn Helgaas wrote:
> > [+cc Lorenzo, beginning of thread:
> > https://lore.kernel.org/r/20220127234917.GA150851@bhelgaas]
> > On Thu, Feb 03, 2022 at 01:55:28PM +0100, Pali Rohár wrote:

> > > Bjorn & Greg: How do you want to handle this situation? Should I prepare
> > > special patch for stable which fix it? Or something else?
> > > 
> > > Anyway, do you know how it could happen that patch was incorrectly
> > > auto-backported into stable? Differences between original and
> > > wrongly-modified patch looks very similar (both "bus" and "dev" keywords
> > > have same number of characters) and it was hard for me to see that there
> > > are differences. So probably overlooking could happen or maybe git or
> > > patch tools could do such small changes when doing backports?
> > 
> > Your patch on the mailing list [1] contains:
> > 
> >         mvebu_pcie_setup_hw(port);
> >         mvebu_pcie_set_local_dev_nr(port, 1);
> >   +     mvebu_pcie_set_local_bus_nr(port, 0);
> > 
> > 91a8d79fc797 ("PCI: mvebu: Fix configuring secondary bus of PCIe Root
> > Port via emulated bridge") [2] appeared in v5.17-rc1 and contains:
> > 
> >         mvebu_pcie_setup_hw(port);
> >   -     mvebu_pcie_set_local_dev_nr(port, 1);
> >   +     mvebu_pcie_set_local_dev_nr(port, 0);
> > 
> > And this is the current state of mainline [3].
> > 
> > 91a8d79fc797 was backported to v5.16.3 as 7cde9bf07316 [4], which also
> > contains:
> > 
> >         mvebu_pcie_setup_hw(port);
> >   -     mvebu_pcie_set_local_dev_nr(port, 1);
> >   +     mvebu_pcie_set_local_dev_nr(port, 0);
> > 
> > So I think the problem was a merge error when we first applied this
> > for mainline, and we just need to make a patch for mainline, apply it
> > for v5.17, and mark it for stable.
> 
> Should I prepare and send fixup patch?

Yes, please.  Sorry for the inconvenience!

> > [1] https://lore.kernel.org/r/20211125124605.25915-12-pali@kernel.org
> > [2] https://git.kernel.org/linus/91a8d79fc797
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-mvebu.c?id=v5.17-rc2#n1323
> > [4] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.16.y&id=7cde9bf07316
