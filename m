Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C34469FC8B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 20:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjBVT4n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 14:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBVT4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 14:56:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DEC16ACD
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 11:56:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F2DA6182E
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 19:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03DBC4339C;
        Wed, 22 Feb 2023 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677095587;
        bh=9GUsITOX1WsxxSy8KrI6EUONDtTTVq/YCkQroZY3V5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Dy4voP7nAF4SBzlEML7t9U2DcdLwLE2xGsHrIcPvWLApahxDlO2/xLgtOo57yttoI
         pGxoWL9fY/IZAMtA4jnZd5RAQ2lPQYoft5YheNYi/09o8xsofA7VdYsbaOAx+DXdSJ
         1mpy3yX3KviCxQoqd/etaE9z5xbo9iw5ekBoBdvzZZvQVYSn8CtXlsn86R/Cg5EYl7
         4TjCuoBeqlC5awJ9yvw6m/yloSctTmtvrTOLhzTOZSvhTJCr08suP/cDO/fLtclHzM
         Dxd3cGwMjWtwfgBJAax1GgibTeNGcVzNZXO79RSNX10ZuH5TePfHYre0liHicd7pix
         aDiLqpPvT7OsQ==
Date:   Wed, 22 Feb 2023 13:53:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Frank.Li@nxp.com" <Frank.Li@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH RESEND] PCI: endpoint: functions/pci-epf-test: Fix
 dma_chan direction
Message-ID: <20230222195306.GA3792242@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341044E7B5A38A65235652CD8AA9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 22, 2023 at 12:49:14AM +0000, Yoshihiro Shimoda wrote:
> > From: Bjorn Helgaas, Sent: Wednesday, February 22, 2023 5:08 AM
> > On Tue, Feb 21, 2023 at 07:17:06PM +0900, Yoshihiro Shimoda wrote:
> > > In the pci_epf_test_init_dma_chan(), epf_test->dma_chan_rx
> > > is assigned from dma_request_channel() with DMA_DEV_TO_MEM as
> > > filter.dma_mask. However, in the pci_epf_test_data_transfer(),
> > > if the dir is DMA_DEV_TO_MEM, it should use epf->dma_chan_rx,
> > > but it used epf_test->dma_chan_tx. So, fix it. Otherwise,
> > > results of pcitest with enabled DMA will be NG on eDMA
> > > environment.
> > 
> > "NG"?
> 
> I'm sorry, I completely mistook this.
> This should be "NOT OKAY", not "NG".

That should match something printed by pcitest, which would be a good
thing.  Thanks for expanding it for non-pcitest experts like me!

Bjorn
