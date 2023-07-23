Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D41A75E2F7
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jul 2023 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjGWQEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jul 2023 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGWQEy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jul 2023 12:04:54 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 627DEE72
        for <linux-pci@vger.kernel.org>; Sun, 23 Jul 2023 09:04:51 -0700 (PDT)
Received: (qmail 1819799 invoked by uid 1000); 23 Jul 2023 12:04:50 -0400
Date:   Sun, 23 Jul 2023 12:04:50 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Wireless mailing list <linux-wireless@vger.kernel.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        PCI mailing list <linux-pci@vger.kernel.org>
Subject: Nomenclature for USB-connected WiFi devices
Message-ID: <8ce5288f-9ed2-4df9-a0a2-bb46941089fb@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If you've got a WiFi device that connects to the host computer via USB, 
do you refer to it as a "wireless USB device" or as a "USB wireless 
device"?

The second would seem to be more logical, by analogy with things like a 
USB mouse or a USB thumbdrive -- we don't say "mouse USB device" or 
"thumbdrive USB device"!

Furthermore, the first ("Wireless USB") is in fact the name of a defunct 
specification for an Ultra-WideBand interface that would run the USB 
communication protocol over a wireless connection.

Nevertheless there are quite a few places in the kernel source that use 
"wireless USB" where they really mean "USB wireless".  (A few of them 
are gray cases, like "Sierra Wireless USB-to-WWAN", although here the 
word "Wireless" evidently is redundant -- maybe it is part of a brand 
name?)

Would there be any objection to a patch that does a wholesale conversion 
from "wireless USB" to "USB wireless"?

Alan Stern

PS: Similar reasoning applies to the term "wireless PCIe device", 
although here the number of offenders is smaller.
