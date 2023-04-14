Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFEA6E2728
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 17:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjDNPlR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 11:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDNPlQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 11:41:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91000900C
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 08:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE9E64190
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 15:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46522C433D2;
        Fri, 14 Apr 2023 15:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681486874;
        bh=dJr9ODe2m3gM4Jom9NHUfbY6JF7IAr3JbpepSts1IbM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O45RDz/zWUzKrz31zjzeGejuknhVKodVG1MT4GxJz2p9S0OXGvaAUJ9BgbXcyy4qz
         wciirmxx3GRXP0KPeJuRYSayeas477GAzU87x6qy4hnfuVK/BcOR9zTwQcPh4c5ldv
         PBhmPyjxZG2GO++ytuw9IGeVrlJWvYDhaapTzIa60jLs2a0dfxJ8NNvTSRQq+InBYC
         xdmB0992M2z/BUQNP1oMXq8Ph+U44DHO2jvoHGsFQqcSSUWcj13HMf+dXb6wLWMULf
         KHwvPS1Z87cwiI9NRUQUO+EWMwUMJcTL0e2RlRJDxh8ACesTtZFNWVlhHIUlxfXS30
         tJpi04XRcXCKA==
Date:   Fri, 14 Apr 2023 10:41:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 04/17] PCI: epf-test: Fix DMA transfer completion
 detection
Message-ID: <20230414154112.GA195502@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20cfd32d-0e4c-a928-fc26-1c4c47972ece@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 13, 2023 at 10:50:03AM +0900, Damien Le Moal wrote:
> On 4/4/23 19:16, Damien Le Moal wrote:
> > On 4/4/23 18:47, Shunsuke Mie wrote:
> >>> @@ -120,7 +129,6 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> >>>   	struct dma_async_tx_descriptor *tx;
> >>>   	struct dma_slave_config sconf = {};
> >>>   	struct device *dev = &epf->dev;
> >>> -	dma_cookie_t cookie;
> >>>   	int ret;
> >>>   
> >>>   	if (IS_ERR_OR_NULL(chan)) {
> >>> @@ -152,25 +160,33 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> >>>   	}
> >>>   
> >>>   	reinit_completion(&epf_test->transfer_complete);
> >>> +	epf_test->transfer_chan = chan;
> >>>   	tx->callback = pci_epf_test_dma_callback;
> >>>   	tx->callback_param = epf_test;
> >>> -	cookie = tx->tx_submit(tx);
> >>> +	epf_test->transfer_cookie = tx->tx_submit(tx);
> >>
> >> How about changing the code to use dmaengine_submit() API instead of 
> >> calling a raw function pointer?
> > 
> > This is done in patch 5 of the series.
> 
> Bjorn,
> 
> My apologies for not replying to the series cover letter as I do not have it
> locally (due to WD on-going network issues).
> 
> This is a ping about this series. Can we get it queued ?
> (I do not see it in PCI next tree)

Lorenzo and Krzysztof take care of the endpoint subsystem, so I'll
wait for them.  In the meantime I'll send a couple typo fixes and a
cursory review for trivial issue.s

Bjorn
