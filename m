Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558D6736A52
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 13:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjFTLG1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 07:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjFTLGS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 07:06:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952CE10F4;
        Tue, 20 Jun 2023 04:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00845611E2;
        Tue, 20 Jun 2023 11:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E580C433C8;
        Tue, 20 Jun 2023 11:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687259162;
        bh=c6Cl8H2kiIKibjwKn4E7jfaCJ/NmKegmDURyS5dIOTE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nZp2C+ROS21lgm1J0hWgNn22wS1cKofTGZJpkaTJGIfKShWnn349LHgIXFxUTDBcq
         bB1m5FxH7KO806pqJyQdruY0+nToITH9MjgFa8Pw6F0GNIKVLcbzr6RDynGjkORvRR
         u13jrbNsCuu1bRIZscvgL5JiAmgkCftS4n4cQiHqU8N+LxCGyn2QETfNTtOzQ+JsQs
         swAFE96KytVxfZ+Gny2Jjpt+ZWPdVg3qhWI1R1M7atNkMWale9fqZOdeXpGVnosxp/
         7R3u284lSngsoZK0QTWELwnFeKF7rF2efMPwnOHkyHCJ1tYkqdTl1hVMuRDFGHarkA
         BFw9TW8mvveRA==
Date:   Tue, 20 Jun 2023 06:06:00 -0500
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
Message-ID: <20230620110600.GA40675@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459cf0c7-4111-6e76-8124-da1a10666f50@189.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 20, 2023 at 12:04:40PM +0800, Sui Jingfeng wrote:
> Where is the formal(unstream) PCI git branch where we could see the latest
> patch ?

Here's the "misc" branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=misc

And here's the "next" branch that will be merged for v6.5, which
includes "misc" and other things: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=next
