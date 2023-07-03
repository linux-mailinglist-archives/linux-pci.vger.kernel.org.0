Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4278874617F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 19:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGCRmi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGCRmh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 13:42:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B908CE;
        Mon,  3 Jul 2023 10:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D2B560FF0;
        Mon,  3 Jul 2023 17:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D55C433C7;
        Mon,  3 Jul 2023 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688406156;
        bh=N8wxrNCYvX8wNW2cTR4uro5GUwtNXUBwLv1PJ0Yqmdo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HGw9CZ5rItbgVEwHO5VhZTeGdt3MiKy0uJpM+1co8ZR01wOTNeoPjA3q0afX624ob
         uGbItAxPuuTdJYsY6anIl6vpsLrFVRNFrlGsJRqLap657jrv62rhIGono2Lz4I4Afe
         oxNcz4Bq94xsZg9Q84eVbIk52eTM8eG5TGqE1Ol/esaxw43yBLkNlWFKqvFgDuXdr1
         pFjbxD8JQYAuxH5DuqFeN2p+38iZLu3EVO5sZ10aepz1iOQRoZBSOq8mzvPn5hixrO
         zVM/H6X0zo0aZuEilP3l5QeSFGZ2tKA48sSJNnfnYSHzLAIQC7WuamBFxqUi4xZtIA
         AJiv5ogzqS6qw==
Date:   Mon, 3 Jul 2023 12:42:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] PCI: Handle HAS_IOPORT dependencies
Message-ID: <20230703174233.GA529479@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703135255.2202721-1-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 03, 2023 at 03:52:53PM +0200, Niklas Schnelle wrote:
> Hi Bjorn,
> 
> This is a follow up to my ongoing effort of making the inb()/outb() and
> similar I/O port accessors compile-time optional. Previously I sent this as
> a complete treewide series titled "treewide: Remove I/O port accessors for
> HAS_IOPORT=n" with the latest being its 5th version[0]. Now about half of
> the per-subsystem patches have been merged so I'm changing over to stand
> alone subsystem patches. These series are stand alone and should be merged
> via the relevant tree such that with all subsystems complete we can follow
> this up with the last patch[1] that will make the I/O port accessors
> compile-time optional.

Is the merge plan for each subsystem to merge this separately?  I
acked these so they could be merged along with all the tree-wide
changes.

> As for compile-time vs runtime see Linus' reply to my first attempt[2].
> 
> Other than rebasing on current master there are no changes to these
> two patches for the PCI subsystem.
> 
> Thanks,
> Niklas
> 
> [0] https://lore.kernel.org/all/20230516110038.2413224-1-schnelle@linux.ibm.com/
> [1] https://lore.kernel.org/all/20230516110038.2413224-42-schnelle@linux.ibm.com/
> [2] https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/
> 
> Niklas Schnelle (2):
>   PCI: Make quirk using inw() depend on HAS_IOPORT
>   PCI/sysfs: Make I/O resource depend on HAS_IOPORT
> 
>  drivers/pci/pci-sysfs.c | 4 ++++
>  drivers/pci/quirks.c    | 2 ++
>  2 files changed, 6 insertions(+)
> 
> 
> base-commit: a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451
> -- 
> 2.39.2
> 
