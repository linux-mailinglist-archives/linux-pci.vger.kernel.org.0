Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDAC54A2DE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 01:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiFMXnI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 19:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiFMXnH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 19:43:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AFF32EC4
        for <linux-pci@vger.kernel.org>; Mon, 13 Jun 2022 16:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 618766154B
        for <linux-pci@vger.kernel.org>; Mon, 13 Jun 2022 23:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC96C34114;
        Mon, 13 Jun 2022 23:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655163781;
        bh=24EujGkAYGlmR8bK0R/zdIy/jfWC2T7tCv5vVeKhDw0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GyCdHhq+DDQjShDoDu8slh/3GZdfWrsARGbYX8Mm+2xzebaXD4IwKZjnkNmALA6Eh
         lj7A8I1XlGPyKiAfaypinTuo5TT2e6yf/mjb7ii20INvjVYTZTm1nLE3zqBg7cxxxW
         AHfJHPn7WjjleAN99d7j/y04MPUrFNz6isBPJwyNF1/bMF8xRt9iHY3eat8uB6HF1O
         BNzkpDZp0euoizyQhjqC6NIwE87QVcY55YkwUvD+ZOmHOxj1LnST0jeszEwrqkrz1/
         FjLzhv0vOMw2zkTGo1MSDTifuEnLyRTRWAveeDaFelpxE5rhYG8uyBrCxM/AO8vJgM
         oCV50pzVVlMpQ==
Date:   Mon, 13 Jun 2022 18:43:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v2 0/2] PCI: aardvark controller changes BATCH 5 (subset)
Message-ID: <20220613234300.GA726841@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524132827.8837-1-kabel@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 24, 2022 at 03:28:25PM +0200, Marek Behún wrote:
> Hello Bjorn,
> 
> since Lorenzo is AFK but gave his review for patches 3 and 5 of fifth
> batch of Aardvark changes, and you only requested to use FIELD_PREP [1]
> in order to avoid adding new _SHIFT macros, I am now sending these two
> patches to you. Could we get this merged?
> 
> Thanks.
> 
> Marek
> 
> Changes since v1:
> - dropped all patches but 3 and 5
> - changed patch 5 to use FIELD_PREP instead of _SHIFT macro
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20220518202729.GA4606@bhelgaas/
> 
> Pali Rohár (2):
>   PCI: aardvark: Add support for AER registers on emulated bridge
>   PCI: aardvark: Fix reporting Slot capabilities on emulated bridge
> 
>  drivers/pci/controller/pci-aardvark.c | 110 +++++++++++++++++++++++---
>  1 file changed, 101 insertions(+), 9 deletions(-)

Applied to pci/ctrl/aardvark for v5.20, thanks!
