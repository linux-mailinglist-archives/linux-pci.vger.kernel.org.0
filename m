Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E0E707A42
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 08:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjERG0N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 02:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjERG0F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 02:26:05 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38311BE8
        for <linux-pci@vger.kernel.org>; Wed, 17 May 2023 23:25:58 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 571CC2816734D;
        Thu, 18 May 2023 08:25:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 45B3B1AAC52; Thu, 18 May 2023 08:25:57 +0200 (CEST)
Date:   Thu, 18 May 2023 08:25:57 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rongguang Wei <clementwei90@163.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH v4] PCI: pciehp: Fix the slot in BLINKINGON_STATE when
 Presence Detect Changed event occurred
Message-ID: <20230518062557.GB13145@wunner.de>
References: <20230512021518.336460-1-clementwei90@163.com>
 <ZGVAyd23kpbLDdpw@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGVAyd23kpbLDdpw@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 17, 2023 at 04:02:01PM -0500, Bjorn Helgaas wrote:
> I'm curious why we want the 5 seconds of blinking power indicator at
> all.  We can't really do anything in response to an Attention Button
> on an empty slot, so could we just ignore it completely in
> pciehp_handle_button_press()?

That wouldn't cover the case where the slot is occupied when the
button is pressed, but the card is yanked out during the 5 second
blinking interval.

We'd still need the present commit to handle that case.

Thanks,

Lukas
