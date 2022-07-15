Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7F8576561
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 18:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiGOQj1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 12:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiGOQjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 12:39:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9E71CB1A;
        Fri, 15 Jul 2022 09:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1DEAB82D22;
        Fri, 15 Jul 2022 16:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79381C341C0;
        Fri, 15 Jul 2022 16:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657903159;
        bh=v7W8lmq4cb+ya0haAmh+BoGKkNN9ocmTb1w4z46LtBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AJfdaQWmT971HaDv5gCayR4VjfTQHkAb3MocBP1OV8ONJCoO1yAhzVagg1+7u2YEF
         nBKzwFWXZqszDvLNbeQda6e9EGFGtOX7evXM8rMz5mpvDDPIMZ9XRZrjwnNIrCgAw/
         bvpLNN1nOJ0LsyxOHWim+4+1MXjP56uxNH1G0NKb4ULGwt9vEASQWz2J+FzVeYO8DU
         sHILGSL6pBIArtc+PO+6an2tUT8aH9A1ZLPfQU7mGMbNCMucWhK19XYqSuOaNI2rC0
         +KI/jLj7Js5uknoGonlZw6e4ns8HJiEhxdvte5DBKSeIV79znF/ScC+xakxmtwWwiZ
         SVT3J1dww9Eew==
Date:   Fri, 15 Jul 2022 11:39:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] arm: ioremap: Fix compilation of code which use
 pci_remap_iospace() without CONFIG_MMU
Message-ID: <20220715163917.GA1138832@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220715080412.j3wgvzlv5evp5zbb@pali>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 10:04:12AM +0200, Pali Rohár wrote:
> On Thursday 14 July 2022 15:04:43 Bjorn Helgaas wrote:
> > [+cc linux-pci, update Lorenzo's email addr]
> > 
> > Hi Pali,
> > 
> > Thanks for cc'ing me.  I think your previous notes didn't include
> > linux-pci or me, so I missed them.
> 
> https://lore.kernel.org/r/20211205123209.lyx76daqdwzqwex4@pali/

Sorry I missed it!
