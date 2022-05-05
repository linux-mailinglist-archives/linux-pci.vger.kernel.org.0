Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B745451C8E3
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 21:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiEET00 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 15:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiEET00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 15:26:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117B4532F3;
        Thu,  5 May 2022 12:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8648D61DF1;
        Thu,  5 May 2022 19:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6DCC385A4;
        Thu,  5 May 2022 19:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651778564;
        bh=tWQ8CO8sNpym6aLYcW6ACSrmqfae5zZqQkH9KrnLkvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tSvoBWO/5Y9tgXuoNKCCJG/o5hG46dkoR3GapdlxbPfFG4v/+uRCtrd9Jj+gjWAfR
         mA0mQqQK5tTB8dcJgTa5ajElvTQD2Z5v7i1VlLl9+vSEHAGnQiX/oW7sAtsI4WySNg
         cRzFI/mwlneW6Nv38957g0Wpl4EwLTlK/kWHB226EJ5Lt/HSUoKbKIM5wlIdhVaEK5
         Su8iDXFPOQY5X1U9L+eZ2U+rIwffDDY3shegztW36ut13/TOFhwCyhopB2xnGQrEqe
         j6KcywUJC+bdOUYJcAsLqy3QNYSRZH2Bv3yXM1cn8a/1zx0KLTRuqg4Gj5ziBVM2br
         j5Giyrh+hogTw==
Date:   Thu, 5 May 2022 14:22:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v1 00/11] PCI/PM: Rework powering up PCI devices
Message-ID: <20220505192241.GA508163@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4738492.GXAFRqVoOG@kreacher>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof, just FYI]

On Thu, May 05, 2022 at 07:57:15PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> This patch set replaces patches [4-9/9] from the series at
> 
> https://lore.kernel.org/linux-pm/4419002.LvFx2qVVIh@kreacher/T/#mf7ed30e7cf114b131e6067e4e10c28e59d661cb4

I applied this to pci/pm, thanks!

I reordered the branch so Krzysztof's "pci_restore_standard_config()
defined but not used" fix is first, followed by your changes, Rafael.

Bjorn
