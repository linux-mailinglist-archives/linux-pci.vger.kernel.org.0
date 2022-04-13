Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7631E50021B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 00:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbiDMWzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 18:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbiDMWzq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 18:55:46 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70EE55882D;
        Wed, 13 Apr 2022 15:53:23 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id C07E692009D; Thu, 14 Apr 2022 00:53:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id BC4E692009C;
        Wed, 13 Apr 2022 23:53:22 +0100 (BST)
Date:   Wed, 13 Apr 2022 23:53:22 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PING^2][PATCH] PCI: Avoid handing out address 0 to devices
In-Reply-To: <alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204132024220.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk>
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

On Sat, 26 Feb 2022, Maciej W. Rozycki wrote:

> We have numerous platforms that permit assigning addresses from 0 to PCI 
> devices, both in the memory and the I/O bus space, and we happily do so 
> if there is no conflict, e.g.:

 Ping for:
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk/>

  Maciej

