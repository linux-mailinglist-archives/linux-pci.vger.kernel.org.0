Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26FD5F4953
	for <lists+linux-pci@lfdr.de>; Tue,  4 Oct 2022 20:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJDSfj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Oct 2022 14:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJDSfh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2022 14:35:37 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644C25A80A
        for <linux-pci@vger.kernel.org>; Tue,  4 Oct 2022 11:35:35 -0700 (PDT)
Received: (Authenticated sender: x@undead.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 7FA1E240003
        for <linux-pci@vger.kernel.org>; Tue,  4 Oct 2022 18:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=undead.fr; s=gm1;
        t=1664908533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rkDst/92ZPl5v7n0DpIptKJLd3xW1BDa7YZCnYHs9mI=;
        b=MSkK+uHsEEWoNZZY+tO8+/PHVwvKRkBDPB8Z+8z1IwsivnENJ7xanZeLBHeYmVKyyzE0rO
        4YMytiWzEWCUicis+c6mNWZEfRo+w1gH2etwnrywER4v8boi9Lgx8P1o0FEs7RcJ5D+o6W
        0kUKeO/hOyvhfK/KQlJd/rNKOu4QKxdaL0NciSdWCWOZGr52vxb/YMEO0QLdIltcRyPHwG
        +sslNwrruTrpFU25iE68tdVRLFwn6WsneQRMu372iix9pUdYcOK3JXZcmcgnfaQekvp+wv
        xbcOlMBnNIoX8bNRgy1bCIVm/ZUnQRuizJBzk1vybD2RE9NhiPZHPRmGXwxDsw==
Message-ID: <5d8ae0a2-1c0c-11ab-a33c-9b57bd087733@undead.fr>
Date:   Tue, 4 Oct 2022 20:35:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: fr
To:     linux-pci@vger.kernel.org
From:   linuxkernelml@undead.fr
Subject: pci=no_e820 required for Clevo laptop
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

As per 
https://www.kernel.org/doc/Documentation/admin-guide/kernel-parameters.txt, 
I am sending you this email to inform you that I need to set 
"pci=no_e820" parameter to get the SSD and touchpad working.

---------------------------------------------------------------------

Dmidecode:

BIOS Information
     Vendor: INSYDE Corp.
     Version: 1.07.02TPCS
     Release Date: 08/19/2020

     BIOS Revision: 7.2
     Firmware Revision: 7.2
Handle 0x0001, DMI type 1, 27 bytes
System Information
     Manufacturer: PC Specialist LTD
     Product Name: NL4x_NL5xLU
Base Board Information
     Manufacturer: CLEVO
     Product Name: NL4XLU

uname -a
Linux topik 5.19.0-2-amd64 #1 SMP PREEMPT_DYNAMIC Debian 5.19.11-1 
(2022-09-24) x86_64 GNU/Linux

---------------------------------------------------------------------

Regards,

Florent DELAHAYE

