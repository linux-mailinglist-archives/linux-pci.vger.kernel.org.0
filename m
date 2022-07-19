Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B260957A954
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 23:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbiGSVsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 17:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiGSVrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 17:47:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332DB101DB;
        Tue, 19 Jul 2022 14:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B73FA61ACE;
        Tue, 19 Jul 2022 21:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D677AC341C6;
        Tue, 19 Jul 2022 21:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658267253;
        bh=O42Z258w1PIvhpxARBaZzfdZtfjXU2aRWZ6tg2rNQOQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=B9oF9d15v/hGpyZDpEV+SpZWCp9lZrWaF9C+BJRV383twPU0WAoq/O/BYEWsHIT99
         kWGXGLdw7ijk6H0bJzVjEZNMZzLwTp/29GERcg7smrYFW/GdYxvrYCRaydyFUOUaR7
         GZxwxZTHOfpN9+W31pS4mvfyHiAhlLPirFtsLVsh1M8GmUrTQzlIn3BAnyo1Im4sTy
         XkXB4bfP7TfdbbRssRn1TYKwmIxMaFGfKX9EVeNfKRMreenc0Ibe62lbI2AN2G/NCU
         kMdQoWnYUSP/P/81B8PUMvwmOhXUQ5/YpGahMbzRWN+K64zi28k5GhZTlmtZMEcLTZ
         UnVw0QFbptxGg==
Date:   Tue, 19 Jul 2022 16:47:31 -0500
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
Message-ID: <20220719214731.GA1582549@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0qcd6pZ=9fGapGexBMifp68jVezQou0QuK9As9vCyfyg@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 11:16:40PM +0200, Arnd Bergmann wrote:
> On Tue, Jul 19, 2022 at 11:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > commit 0e4daeaa52ca ("PCI: imx6: Convert to NOIRQ_SYSTEM_SLEEP_PM_OPS()")
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Tue Jul 19 15:50:18 2022 -0500
> >
> >     PCI: imx6: Convert to NOIRQ_SYSTEM_SLEEP_PM_OPS()
> >
> >     Replace SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() with NOIRQ_SYSTEM_SLEEP_PM_OPS(),
> >     which has the advantage that the compiler always sees the PM callbacks as
> >     referenced, so they don't need to be wrapped with "#ifdef CONFIG_PM_SLEEP"
> >     or tagged with "__maybe_unused" to avoid "defined but not used" warnings.
> >
> >     See 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old ones").
> >
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks!  And sorry about being crabby earlier.  If this allows us to
get rid of those #ifdefs and __maybe_unused, it's a great improvement!

Bjorn
