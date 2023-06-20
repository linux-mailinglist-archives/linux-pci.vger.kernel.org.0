Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB4B736B69
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 13:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjFTLxA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 07:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjFTLw7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 07:52:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EC3E71;
        Tue, 20 Jun 2023 04:52:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39D67611EA;
        Tue, 20 Jun 2023 11:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F77C433C0;
        Tue, 20 Jun 2023 11:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687261977;
        bh=6oQE1zx96TjAgwGDThXBWP2xalKhzh5AZUc/ll0gfVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UL/tn1/iL0SE+z0HNifywK0E7QxNfUnOoZT4sCx13aXG7+gYV9SW9TjXOoiza4xab
         kl0pxCJMwU5SyW1ivvBOYCDxMJ4+DVbbDj+qP5vW2eaQKyUjBOLCmAtDLgfDd5zmpV
         +blgL9bED33FX7QDKO/92kypWow0hDf7IcnB1AzdM8aWZiyEbuyo7N3Xq9SLOj9uTY
         UOhQ84T/aspwxvSiQGO3xVzjCZ60GaXjnAcKcVgqXDQlZUDwyqG3Ob3nGr3HRNNwDS
         M58i15cyuWLinzNlDaYzrr//IQEGWv3htPZPAf2ziUSlWv3R5rFPMWCv+7cgK5yttX
         85UbqLqgsJk2w==
Date:   Tue, 20 Jun 2023 06:52:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ben Hutchings <bhutchings@solarflare.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        kernel test robot <lkp@intel.com>, Li Yi <liyi@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add dummy implement for pci_clear_master()
 function
Message-ID: <20230620115255.GA43247@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620110600.GA40675@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 20, 2023 at 06:06:00AM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 20, 2023 at 12:04:40PM +0800, Sui Jingfeng wrote:
> > Where is the formal(unstream) PCI git branch where we could see the latest
> > patch ?
> 
> Here's the "misc" branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=misc
> 
> And here's the "next" branch that will be merged for v6.5, which
> includes "misc" and other things: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=next

I forgot to mention: in case you need to find other git branches, most
subsystems list this in the MAINTAINERS file, e.g.,

  PCI SUBSYSTEM
  ...
  T:      git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git

