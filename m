Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91614D509A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 18:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbiCJRb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 12:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiCJRb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 12:31:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA9EF11A1;
        Thu, 10 Mar 2022 09:30:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA225B8270A;
        Thu, 10 Mar 2022 17:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204F6C340E8;
        Thu, 10 Mar 2022 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646933424;
        bh=Xm6HxslQ4JAAUO3tzolqj+8HYytM0C3tyab+DDDGYzg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TGzEeayaGIUwsWouUcKF4SWChC2LR5w0YVUpr8d3xaYNHng/Bd0l08mgnGB2R822O
         Jmc4gUuF7I9hroi9OZThClOmK9qmySYqdokWAue55JV3dhBP5mrMadkx6u6gkfyN9v
         nD1YroODIFl1Ojivnta16dWkGrqJ89I/pvhDd1aRe3TnWKAbZJL+B06a6QgNm/U6/F
         wDdgs5h+RG+73MHHGPTpW2WGcIBj5CQOmlCD9EfEVJG3N0DSstQwwkFpQ7vrkr+c/3
         LWiGseBi/6ieqQtFZwur+ikH10P49H5YjdTeylxCWCsLnJJRpHcKSG5TGQDRPHrwHo
         4jG6yh2V2fvxg==
Date:   Thu, 10 Mar 2022 11:30:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bhelgaas@google.com, arnd@arndb.de, hch@infradead.org,
        akpm@linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove the deprecated "pci-dma-compat.h" API
Message-ID: <20220310173022.GA166412@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310170445.GA163749@bhelgaas>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 10, 2022 at 11:04:45AM -0600, Bjorn Helgaas wrote:
> On Wed, Mar 09, 2022 at 08:50:39PM +0100, Christophe JAILLET wrote:
> > Now that all usages of the functions defined in "pci-dma-compat.h" have
> > been removed, it is time to remove this file as well.
> 
> As of 1db333d9a51f ("Merge tag 'spi-fix-v5.17-rc7' of
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi"), all the
> following still appear to be used:
> 
>   git grep -E "\<PCI_DMA_(BIDIRECTIONAL|TODEVICE|FROMDEVICE|NONE)"
>   git grep -E "pci_(alloc|zalloc|free)_consistent"
>   git grep -E "pci_(map|unmap)_single"
>   git grep -E "\<pci_(map|unmap)_page"
>   git grep -E "pci_(map|unmap)_sg"
>   git grep -E "pci_dma_sync_"
>   git grep pci_dma_mapping_error
>   git grep -E "pci_set_.*dma_mask"

Christoph mentioned several other trees that this depends on, and
those would likely be in linux-next, but not yet in Linus' tree.  The
above poking around is from the tip of Linus' tree, which was the
wrong place for me to look.

But I did the same in current linux-next, 71941773e143 ("Add
linux-next specific files for 20220310"), and still found quite a few
uses.  Some are in comments, printks, coccinelle scripts, etc.  I
would assume we'd want to remove them all?

Bjorn
