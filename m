Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0DD69E8D8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Feb 2023 21:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBUUIR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 15:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjBUUIR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 15:08:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630DB27D5C
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 12:08:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E61CC611B2
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 20:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F87C433EF;
        Tue, 21 Feb 2023 20:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677010095;
        bh=gHvDJkDn1pKYA3AlH0T1kL2LfG6P70Tz/QyF6FnIoxY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VXk2cSpF7cZk1qhpHRCjgqYSpO10DXW7M8vkvdyFbESgi1rfxLMIQkAFWpJTHry3A
         mciurG2anCMLrLlM9R0xS20wT6+aXcaurYgoIS4APyRgSo8XegNnb1hKTVupC5+iIl
         LJ4HAMnZz9iN/awR60rS+kBvysmmjoXwUm3ywonJ4T0I8DqIqTZMCtIS1qpIKFMFYp
         EXQxTr7VvEggHV3AYg19BriZAbcgwohxHhrAOm87islyyxSW5nPD5OpOWTGdgKDK5e
         buRys4Qewu+EFKaU5n784o49+/cseUKAQhe+BmxXJ3dDz3/O7kpq7WsrPNKzGF8DxT
         Xx7ZoUeDWMpVw==
Date:   Tue, 21 Feb 2023 14:08:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
        kishon@kernel.org, bhelgaas@google.com, Frank.Li@nxp.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: endpoint: functions/pci-epf-test: Fix
 dma_chan direction
Message-ID: <20230221200813.GA3722066@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221101706.3530869-1-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 21, 2023 at 07:17:06PM +0900, Yoshihiro Shimoda wrote:
> In the pci_epf_test_init_dma_chan(), epf_test->dma_chan_rx
> is assigned from dma_request_channel() with DMA_DEV_TO_MEM as
> filter.dma_mask. However, in the pci_epf_test_data_transfer(),
> if the dir is DMA_DEV_TO_MEM, it should use epf->dma_chan_rx,
> but it used epf_test->dma_chan_tx. So, fix it. Otherwise,
> results of pcitest with enabled DMA will be NG on eDMA
> environment.

"NG"?
