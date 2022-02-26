Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CD74C5558
	for <lists+linux-pci@lfdr.de>; Sat, 26 Feb 2022 12:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiBZLB1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Feb 2022 06:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiBZLB0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Feb 2022 06:01:26 -0500
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Feb 2022 03:00:50 PST
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3454C43EF1
        for <linux-pci@vger.kernel.org>; Sat, 26 Feb 2022 03:00:49 -0800 (PST)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 7534E28048F; Sat, 26 Feb 2022 11:52:49 +0100 (CET)
Date:   Sat, 26 Feb 2022 11:52:49 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Decode PCIe 6.0 Slot Power Limit values
Message-ID: <mj+md-20220226.105239.55178.nikam@ucw.cz>
References: <20220225181209.12642-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225181209.12642-1-pali@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

> When the Slot Power Limit Scale field equals 00b (1.0x) and Slot
> Power Limit Value exceeds EFh, the following alternative encodings
> are used:
[...]

Thanks, applied.

				Martin
