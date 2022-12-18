Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D3B6505A6
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 00:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiLRXZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Dec 2022 18:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiLRXZE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Dec 2022 18:25:04 -0500
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462EBF71
        for <linux-pci@vger.kernel.org>; Sun, 18 Dec 2022 15:25:02 -0800 (PST)
Received: by air.basealt.ru (Postfix, from userid 490)
        id E1DB42F20229; Sun, 18 Dec 2022 23:25:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
Received: from localhost (broadband-188-32-10-232.ip.moscow.rt.ru [188.32.10.232])
        by air.basealt.ru (Postfix) with ESMTPSA id AD36A2F20227;
        Sun, 18 Dec 2022 23:24:58 +0000 (UTC)
Date:   Mon, 19 Dec 2022 02:24:56 +0300
From:   "Alexey V. Vissarionov" <gremlin@altlinux.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Alexey V. Vissarionov" <gremlin@altlinux.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Yu Zhao <yu.zhao@intel.com>, linux-pci@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] PCI/IOV: "virtfn4294967295\0" requires 17 bytes
Message-ID: <20221218232456.GB1182@altlinux.org>
References: <20221218033347.23743-1-gremlin@altlinux.org>
 <Y57x/iCSkdtU3kov@rocinante>
 <20221218122139.GA1182@altlinux.org>
 <Y5+R7DUZFaFNEeza@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5+R7DUZFaFNEeza@casper.infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-12-18 22:19:24 +0000, Matthew Wilcox wrote:

 >>> Thank you for sending the patch over! However, if possible,
 >>> can you send it as plain text without any multi-part MIME
 >>> involved?
 >> ACK.
 >>> If possible, it would be nice to mention that this needed
 >>> to make sure that there is enough space to correctly
 >>> NULL-terminate the ID string.
 >> ACK.
 >> So, here goes the corrected text:
 >> Although unlikely, the 'id' value may be as big as 4294967295
 >> (uint32_max) and "virtfn4294967295\0" would require 17 bytes
 >> instead of 16 to make sure that buffer has enough space to
 >> properly NULL-terminate the ID string.
 > Wait, what? How can we get to a number that large for the
 > virtual function ID? devfn is 8 bits, bus is a further 8 bits.
 > Sure, domain is an extra 16 bits on top of that but I'm pretty
 > sure that virtual functions can't span multiple domains.
 > Unless that's changed recently? Even if they can, we'd need
 > to span 2^14 domains to get up to a billion IDs. That's a
 > hell of a system and I think overflowing here is the least
 > of our problems.

Possibly in some synthetic cases this may be achieved with some
specially crafted "BadPCI" (similar to "BadUSB") device...

 > So while this is typed as u32, I don't think it can get
 > anywhere close.

Anyway, the final decision is up to you.


-- 
Alexey V. Vissarionov
gremlin נעי altlinux פ‏כ org; +vii-cmiii-ccxxix-lxxix-xlii
GPG: 0D92F19E1C0DC36E27F61A29CD17E2B43D879005 @ hkp://keys.gnupg.net
