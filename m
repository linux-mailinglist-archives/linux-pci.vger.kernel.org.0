Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916EE5840DF
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiG1ORW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 10:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiG1ORV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 10:17:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8867952479;
        Thu, 28 Jul 2022 07:17:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44F66B82462;
        Thu, 28 Jul 2022 14:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A85CC433D7;
        Thu, 28 Jul 2022 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659017837;
        bh=6pbXjGQzPA0jK7O665nCbQLhvHBSyUCHT262QN0jRb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eGbcuJQuVl3DLIGcmWcf7KXbqtVW4WM3Lls31XLKqeGe9ZPrr5sq55EqRIlHhBsg9
         7FHzeyEYoQdIK3zzkhkRiTDQ7Q/fKdj53f8azU0B9loSRjRm+gRs03arkrCzamzI7p
         8H4N1RESzvs/0J+WVSC2nRLFzEZao5KCZFE9fXQPAEP9LLqQx6UQ/N2Ao4h/wlmh+g
         OChzzoL0XXOKkWPo1uS3okm7gJ+ONE1JWQZTCS5kKro2nu8W1ym1mA1e8RsaDs1G+A
         Pwvey2YiTQPjC43/fgNm7ktTWppiNdbqfL85Ch2iHWcKxAKyOlaPosIlS1BW5k8p+R
         VGIzncjyg3LtA==
Date:   Thu, 28 Jul 2022 09:17:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Message-ID: <20220728141716.GA296915@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <051a3baf-b4dd-7764-2e61-03584cefb4d3@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 28, 2022 at 05:56:28PM +0530, Vidya Sagar wrote:
> 
> 
> On 7/28/2022 3:44 AM, Bjorn Helgaas wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Jun 22, 2022 at 09:31:33AM +0530, Vidya Sagar wrote:
> > > Platforms that cannot support their core initialization without the
> > > reference clock from the host, implement the feature 'core_init_notifier'
> > > to indicate the DesignWare sub-system about when their core is getting
> > > initialized. Any accesses to the core (Ex:- DBI) would result in system
> > > hang in such systems (Ex:- tegra194). This patch moves any access to the
> > > core to dw_pcie_ep_init_complete() API which is effectively called only
> > > after the core initialization.
> > 
> > I assume this is still broken.  I want to fix it.  I assume this patch
> > fixes it and there are no known problems with it.  I assume this can
> > be fixed so it works on all platforms, whether they use
> > core_init_notifier or not.
> Yes. All your assumptions are correct.
> 
> > 
> > I'd like the commit log to be specific about where the hang occurs so
> > it's easy for a non-DesignWare expert (me!) to see the problem.  E.g.,
> > on tegra194, X depends on Y, but Y is initialized after X.  Say
> > specifically what functions X and Y are.
> X = DBI accesses
> Y = Core initialization which in turn depends on the REFCLK from the host
> 
> Without this patch, hang happens when DBI registers are accessed without
> core being initialized. In the case of Tegra194 at least, core gets
> initialized only after REFCLK is available from the host. The way we make
> sure that the REFCLK is available from the host is by checking for PERST#
> de-assertion interrupt. (PCIe spec mandates that the host must supply REFCLK
> before de-asserting PERST# signal).
> This patch prevents any accesses to the DBI/Core registers if the platform
> says that it supports core_init_notifier.

That's basically what the commit log already said.  Can you give me
actual function names as a hint for where to look?

Bjorn
