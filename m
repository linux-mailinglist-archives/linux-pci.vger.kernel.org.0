Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A751150021E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 00:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbiDMWzw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 18:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiDMWzu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 18:55:50 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5A7058816;
        Wed, 13 Apr 2022 15:53:28 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id F02BF92009D; Thu, 14 Apr 2022 00:53:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id ED04A92009C;
        Wed, 13 Apr 2022 23:53:27 +0100 (BST)
Date:   Wed, 13 Apr 2022 23:53:27 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PING][PATCH v4] pci: Work around ASMedia ASM2824 PCIe link training
 failures
In-Reply-To: <alpine.DEB.2.21.2203310037480.44113@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204132027360.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203310037480.44113@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 31 Mar 2022, Maciej W. Rozycki wrote:

> Attempt to handle cases with a downstream port of the ASMedia ASM2824 
> PCIe switch where link training never completes and the link continues 
> switching between speeds indefinitely with the data link layer never 
> reaching the active state.

 Ping for:
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2203310037480.44113@angie.orcam.me.uk/>

  Maciej
