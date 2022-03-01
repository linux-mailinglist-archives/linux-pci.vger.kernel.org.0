Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7542F4C972E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 21:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbiCAUoM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 15:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiCAUoI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 15:44:08 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C3EE51E7E;
        Tue,  1 Mar 2022 12:43:24 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8D72892009C; Tue,  1 Mar 2022 21:43:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8A25292009B;
        Tue,  1 Mar 2022 20:43:22 +0000 (GMT)
Date:   Tue, 1 Mar 2022 20:43:22 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PING^2][PATCH v3] pci: Work around ASMedia ASM2824 PCIe link training
 failures
In-Reply-To: <alpine.DEB.2.21.2202010240190.58572@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2203011742590.11354@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202010240190.58572@angie.orcam.me.uk>
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

On Tue, 1 Feb 2022, Maciej W. Rozycki wrote:

> Attempt to handle cases with a downstream port of the ASMedia ASM2824 
> PCIe switch where link training never completes and the link continues 
> switching between speeds indefinitely with the data link layer never 
> reaching the active state.

 Ping for:
<https://lore.kernel.org/all/alpine.DEB.2.21.2202010240190.58572@angie.orcam.me.uk/>

  Maciej
