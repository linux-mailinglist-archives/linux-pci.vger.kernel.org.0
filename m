Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682CE524DF1
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 15:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354246AbiELNMK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 09:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354240AbiELNMG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 09:12:06 -0400
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D05D6B03A
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 06:11:51 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id DBD6C440605;
        Thu, 12 May 2022 16:10:47 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1652361048;
        bh=L4ovC1OE9k5pnFkLjPZrRuRHFql/+rjbu0+rWm/pgmg=;
        h=From:To:Cc:Subject:Date:From;
        b=sTPSv4a3kCRKhXDFWzqBN31ER0Rc2/xqjSbJojIIYhe352Cdccgk7vTAPegVnT/G0
         CLq8+BGqa1zkzn6mgne6NCWer29H1Eaw+oKLx2eIIUS9BQJrutFB7i8dfBSOV7Dxwx
         JRWxL5M+23n/AFu6TpedOFaEGBOzTTWSs7lqZ1MuYd1m4L3q4P1rWG/25Q57NCqmzk
         I6P+5vKiYBrGXeBAKOhHWovuLAfC8W6ek/Bzaco8uCVhyTwykXNqg5CgGuc8T4fEPG
         U0O3ZHIkzeiwx/Lm68OCKWEqfjzIbDT3PBLXS4Zlvwlc8GUfNKdpAWwqjCN43QUudW
         TI0RgRR7LYvRg==
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Martin Mares <mj@ucw.cz>
Cc:     linux-pci@vger.kernel.org
Subject: pciutils build failure with older binutils
Date:   Thu, 12 May 2022 15:59:31 +0300
Message-ID: <87mtfm7v58.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Martin,

Since commit 511122b83c12 ("Filters now support partially specified
classes and also prog-if's") binutils older than 2.35 can't build
pciutils 3.8.0 when SHARED=yes.

cc -O2 -Wall -W -Wno-parentheses -Wstrict-prototypes -Wmissing-prototypes -fPIC -fvisibility=hidden   -c -o filter.o filter.c
/tmp/ccLtucRG.s: Assembler messages:
/tmp/ccLtucRG.s:6: Error: multiple versions [`pci_filter_init@@LIBPCI_3.8'|`pci_filter_init@LIBPCI_3.3'] for symbol `pci_filter_init_v38'
/tmp/ccLtucRG.s:8: Error: multiple versions [`pci_filter_parse_slot@@LIBPCI_3.8'|`pci_filter_parse_slot@LIBPCI_3.3'] for symbol `pci_filter_parse_slot_v38'
/tmp/ccLtucRG.s:10: Error: multiple versions [`pci_filter_parse_id@@LIBPCI_3.8'|`pci_filter_parse_id@LIBPCI_3.3'] for symbol `pci_filter_parse_id_v38'
/tmp/ccLtucRG.s:12: Error: multiple versions [`pci_filter_match@@LIBPCI_3.8'|`pci_filter_match@LIBPCI_3.3'] for symbol `pci_filter_match_v38'

The bug appears to be gas/23840[1].

binutils 2.35 was released on July 2020, so many production systems
still use broken toolchains.

Any suggestion?

Thanks,
baruch

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=23840

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
