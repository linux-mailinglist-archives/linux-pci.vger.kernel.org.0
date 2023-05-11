Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF606FFC99
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 00:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjEKWVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 18:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbjEKWVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 18:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40A8173D;
        Thu, 11 May 2023 15:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81E726129A;
        Thu, 11 May 2023 22:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1F6C433D2;
        Thu, 11 May 2023 22:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683843705;
        bh=uEoG19WBzDgFCX22lW5kC0LgLB9V2u85hfxE6ag5YkA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ulzjhPJYTRC4uNs09sODz7gu3QFGottnH387NekTYaeDanZxk4OxFmB2gKM/GMAxs
         FCn7qrmOxH50BGO/Vzxe011AiAvTKpJ3V0ISv/n5VrmHSNNR3yCj1f1hOQ5yyabSt1
         O1Urd8vker0uVvCO08/KP7g2HLNIoklU3nneVly6C2Od04TP+qg15vVsAmW5RMsRZh
         EMEG8QAAhYcJjexZ9VDIuJwBRXr02rP78Vho996NqUH5GnrE+FuF8n/yOTaHUwPX1n
         h5pFxeFHu5pfl/eWV4vy9xQ2FgeJvzsart6qmgiNXQf3+ZKMf7IfOXCqqgIlXubm1d
         SUz9wnUay+QtA==
Date:   Thu, 11 May 2023 17:21:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy?ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 01/17] PCI: Add concurrency safe clear_and_set variants
 for LNKCTL{,2}
Message-ID: <ZF1qeGhCaO5+TlKu@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13f587b-e937-d546-817d-5fd94443c1eb@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Emmanuel, Rafael, Heiner]

On Thu, May 11, 2023 at 11:28:05PM +0300, Ilpo Järvinen wrote:
> ...
> One question before I trying to come up something is when PCIEASPM is =n, 
> should I provide some simple function that just does the LNKCTL write to 
> disable it?

The current pci_disable_link_state() stub when CONFIG_PCIEASPM is
unset seems clearly wrong.  In fact, it returns *success* when it
actually did nothing.

I think it should probably clear ASPM Control, at least when the OS
has ownership via _OSC.  I kind of think it should do that independent
of _OSC, but that depends on the conversation at [1].

Bjorn

[1] https://lore.kernel.org/r/ZF1dsvJYYnl8Wv0v@bhelgaas
