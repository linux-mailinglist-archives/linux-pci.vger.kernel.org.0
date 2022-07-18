Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3876578714
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 18:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbiGRQOp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 12:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbiGRQOo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 12:14:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F13267B;
        Mon, 18 Jul 2022 09:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4A5CB81678;
        Mon, 18 Jul 2022 16:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2EEC341C0;
        Mon, 18 Jul 2022 16:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658160881;
        bh=s4BD8mdghSnJ9sX+cdo6zdbaTcPNDfDvBJGqCWlXkwM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eTJPbfeuhG54lKKjhcq4Zg8fuGz+sLEctjlpz2pf6RlFYTkHPG3IndqoG6scRCBof
         ZMhtte88JHAJWNmdPWAsZa7PHd52DlbuKkiBxdmZPZ6/hgF9U6gWkmU6qDB8frUW+5
         7LMWiwCPiiJoDCb5DA3zoJaDABx//V/CGpZwUhzN+A5SViUtJztemvWu1r6NyD8Qvf
         05bPbqyRIh2+E3Hdbl+PdO3Tj30y8qV/0IjKUBpLPmqCMaVUUELRIT0gVhyco+6zY4
         FNHXyZ5NPIKQiqYPuNg1YG4LY4P0ADQzUok6+gvmudiLmGkDXc6DF0Ei7HmHhjMunr
         gme/IMt7QJuPg==
Date:   Mon, 18 Jul 2022 11:14:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: build failure of next-20220718 due to 'imx6_pcie_host_exit'
 defined but not used
Message-ID: <20220718161439.GA1419930@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0MYMbRk1tVmWUBWfnD-1Z5P3fE+DvNycnXaffzqc3htw@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 02:42:16PM +0200, Arnd Bergmann wrote:
> On Mon, Jul 18, 2022 at 1:58 PM Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > Hi All,
> >
> > Not sure if it has been reported, builds of alpha, csky, xtensa, riscv, s390 allmodsconfig
> > have failed to build next-20220718 with the error:
> >
> >
> > drivers/pci/controller/dwc/pci-imx6.c:973:13: error: 'imx6_pcie_host_exit' defined but not used [-Werror=unused-function]
> >   973 | static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
> >       |             ^~~~~~~~~~~~~~~~~~~
> > drivers/pci/controller/dwc/pci-imx6.c:904:13: error: 'imx6_pcie_stop_link' defined but not used [-Werror=unused-function]
> >   904 | static void imx6_pcie_stop_link(struct dw_pcie *pci)
> >       |             ^~~~~~~~~~~~~~~~~~~
> >
> 
> These are called from inside an "#ifdef CONFIG_PM_SLEEP" section. The best
> fix is to remove the #ifdef and replace SET_NOIRQ_SYSTEM_SLEEP_PM_OPS()
> with the new simpler NOIRQ_SYSTEM_SLEEP_PM_OPS().

Might be simpler, but wow, it's hard to keep up with all the
permutations of sleep ops ;)

Unfortunately 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros,
deprecate old ones"), which added NOIRQ_SYSTEM_SLEEP_PM_OPS, didn't
add any hints near SET_NOIRQ_SYSTEM_SLEEP_PM_OPS.

We have several PCI controller drivers that use the "#ifdef
CONFIG_PM_SLEEP" and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS pattern or the
"__maybe_unused" + SET_NOIRQ_SYSTEM_SLEEP_PM_OPS pattern.  I guess we
need to look at all of them and figure out the best practice.

Bjorn
