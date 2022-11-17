Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D4862E876
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 23:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiKQWcN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 17:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbiKQWcL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 17:32:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB79979E28;
        Thu, 17 Nov 2022 14:32:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 412B7622B9;
        Thu, 17 Nov 2022 22:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB0EC433D6;
        Thu, 17 Nov 2022 22:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668724329;
        bh=+8/7YiFZNB7FixNmf5Be53qj3HRkcnCN/hUatBVlavc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=T4oxAro1aBuveBQWwogruy164XxaSedOAsaEmZRmotI87aVQEHUHGQnbWn7HRCXC/
         UtGrYMlRQ10eXl65cFnkYyKES5yeZ7pHUHVZNW6VQXquw2fOAEHbRjWnGpC2NP9j1y
         WsBEHoivS8Kp6UB+zCHAZtIfVeXQ5nvZF6baGycWAxNcR3G5RXxNqmp73RNFlqAexh
         6JEXylDkqQX69S8smm/a5TBnHHDGTJj2AkGMjNI4K39R0uk4wRKZL5wkGMZyikFEva
         mP6bnYkQqaI9e6+OEeMbeYnvx0AMBq2yTCleOezLPrdH0QKhmH/Kqh+evDv0GtFTmT
         738HDBSFPqyKw==
Date:   Thu, 17 Nov 2022 16:32:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/2] PCI: Allow building CONFIG_OF drivers with
 COMPILE_TEST
Message-ID: <20221117223207.GA1226905@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116205100.1136224-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 02:50:58PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Update CONFIG_OF dependencies so we can compile-test drivers (with
> CONFIG_COMPILE_TEST=y) even without CONFIG_OF being enabled.  OF provides
> stub functions when CONFIG_OF is not set.
> 
> Changes from v1 to v2:
>   - Retain "depends on OF || COMPILE_TEST" instead of dropping "depends on
>     OF" completely so drivers are only offered when they are applicable or
>     COMPILE_SET is enabled (many thanks to Geert for pointing out this
>     major mistake)
> 
> v1: https://lore.kernel.org/r/20221025191339.667614-1-helgaas@kernel.org
> 
> Bjorn Helgaas (2):
>   PCI: Drop of_match_ptr() to avoid unused variables
>   PCI: Allow building CONFIG_OF drivers with COMPILE_TEST
> 
>  drivers/pci/controller/Kconfig          | 34 +++++++++++----------
>  drivers/pci/controller/cadence/Kconfig  | 12 ++++----
>  drivers/pci/controller/dwc/Kconfig      | 40 ++++++++++++++++---------
>  drivers/pci/controller/mobiveil/Kconfig |  2 +-
>  drivers/pci/controller/pci-ftpci100.c   |  2 +-
>  drivers/pci/controller/pci-v3-semi.c    |  2 +-
>  6 files changed, 53 insertions(+), 39 deletions(-)

Applied to pci/kbuild for v6.2.
