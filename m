Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DFE4EB3C5
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 21:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbiC2TCz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 15:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiC2TCu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 15:02:50 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F26BD2FC;
        Tue, 29 Mar 2022 12:01:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 20A95CE1A3E;
        Tue, 29 Mar 2022 19:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C048C2BBE4;
        Tue, 29 Mar 2022 19:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648580461;
        bh=togKQAXsg4SClR+CCOpzzRuF4/TzbRxrDLH3EE/6RsA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CsL56iRwae5VMWCfqiwlBxjDb9qb4ZTZ5GMZw+wJJi1B81g/sVRF9rmxgaxLCksxB
         UrICQ2cTeZUXA5WwDcuT52gwi9QgjJuIVmI+1oALy1ETzWrnoGfs71AdHQJlibooCB
         TJgwwF0IjpDeivB9RvLjhnL0XJ2Sl9yofkBOq7F9vgOlLO6Rk+F/JjRRB2oTJAd0X9
         NXkjEF5F8nac+ZMPXMzKHCX1ESY+N+Z9lLo1mOIVNv3lPVcyo+VxYaYxY3+v4jWkqA
         H2jVj4Wom8Kv7VCOBCynxx6TTy5SM+Q3cgAG1Tvf7VZ9y9HRpvXb3crTSoHJ1Dp7Jc
         xAV8M9Cm7tE5Q==
Date:   Tue, 29 Mar 2022 14:00:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        bhelgaas@google.com, arnd@arndb.de, akpm@linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove the deprecated "pci-dma-compat.h" API
Message-ID: <20220329190059.GA1621960@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkNNWy649S9i6Vbd@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 29, 2022 at 11:18:03AM -0700, Christoph Hellwig wrote:
> On Thu, Mar 10, 2022 at 11:30:22AM -0600, Bjorn Helgaas wrote:
> > Christoph mentioned several other trees that this depends on, and
> > those would likely be in linux-next, but not yet in Linus' tree.  The
> > above poking around is from the tip of Linus' tree, which was the
> > wrong place for me to look.
> > 
> > But I did the same in current linux-next, 71941773e143 ("Add
> > linux-next specific files for 20220310"), and still found quite a few
> > uses.  Some are in comments, printks, coccinelle scripts, etc.  I
> > would assume we'd want to remove them all?
> 
> I'm not sure there is much of a point to clean up the historic
> comments, but it would be a nice cleanup.  I'd very much like to
> queue up this patch now that all the actual symbol references
> are gone now.  Are you ok with that?

Yep, I'm OK with that.  I *would* like to see at least
Documentation/PCI/pci.rst updated soonish (it still refers to
pci_set_dma_mask() and friends).

Bjorn
