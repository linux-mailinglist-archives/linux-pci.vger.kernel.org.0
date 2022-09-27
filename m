Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9258E5EBE04
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiI0JJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiI0JJx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:09:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84BE5B7B5;
        Tue, 27 Sep 2022 02:09:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F97A61765;
        Tue, 27 Sep 2022 09:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570AAC433D6;
        Tue, 27 Sep 2022 09:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664269790;
        bh=EWbMZHKTMYken4F8JD7i0ndrYShdQA5tQ02UkQ9AlcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LvxP901oWdRcaSwbyeje69HYrPiaB8QNyeisvqQijkau7Hk0bHHQpHjkEFHBzEZOU
         rwp1V2aN/TvlijSWwLu0A2FjF5z39Qe5+otZs+4fcHTDKRYSmoC9K0XwJbleJY6qDJ
         4zfj0TRtNueGVqH3KLqgAGkrIbpltR7DRh4rIfRs6oVp6U4z5M3ZwgFEDkjT868TEF
         m86uGcwVE3qMrs8TbkeRBy11+8lqmNvpLUzhXCSwuxwKBTPDwsmig75PLqlyMAdKYa
         6mREcILldx/s2ktJb9awGWsz+IFz1Z/C15m2WaeSjM8bmMBTSx424wTaKLHnTYvYtp
         GUufzqu39/r1A==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: Introduce new PCI_CONF1_ADDRESS() and PCI_CONF1_EXT_ADDRESS() macros
Date:   Tue, 27 Sep 2022 11:09:45 +0200
Message-Id: <166426977267.72332.7243947648115345777.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924092404.31776-1-pali@kernel.org>
References: <20220924092404.31776-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 24 Sep 2022 11:24:01 +0200, Pali Rohár wrote:
> PCI controllers and lot of non-ECAM compliant PCIe controllers still use
> Intel PCI Configuration Mechanism #1 for accessing PCI config space.
> 
> Native PCIe controller drivers invents its own macros which implements
> config space address calculation and in lof of cases it is just
> duplication of the same code.
> 
> [...]

Applied to pci/misc, thanks!

[1/3] PCI: Add standard PCI Config Address macros
      https://git.kernel.org/lpieralisi/pci/c/8a9b7ef74369
[2/3] PCI: ftpci100: Use PCI_CONF1_ADDRESS() macro
      https://git.kernel.org/lpieralisi/pci/c/f75a27dc6c07
[3/3] PCI: mt7621: Use PCI_CONF1_EXT_ADDRESS() macro
      https://git.kernel.org/lpieralisi/pci/c/2301a3e1a566

Thanks,
Lorenzo
