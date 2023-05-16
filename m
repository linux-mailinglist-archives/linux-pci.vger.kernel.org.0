Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96E1704AD3
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 12:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjEPKgs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 16 May 2023 06:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjEPKgq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 06:36:46 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 03:36:27 PDT
Received: from tilde.cafe (tilde.cafe [51.222.161.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1283B19A5;
        Tue, 16 May 2023 03:36:26 -0700 (PDT)
Received: from [127.0.0.1] (106.208.19.217.sta.idknet.com [217.19.208.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by tilde.cafe (Postfix) with ESMTPSA id 7588B2027D;
        Tue, 16 May 2023 06:26:26 -0400 (EDT)
Date:   Tue, 16 May 2023 13:26:23 +0300
From:   Acid Bong <acidbong@tilde.cafe>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>, stable@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BREGRESSION=5D_Asus_X541UAK_hangs_o?= =?US-ASCII?Q?n_suspend_and_poweroff_=28v6=2E1=2E6_onward=29?=
In-Reply-To: <ZGKbRo9shUcR0myC@bhelgaas>
References: <ZGKbRo9shUcR0myC@bhelgaas>
Message-ID: <A5B9D233-A082-4C60-9DCB-2B0A2081C089@tilde.cafe>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>Can you collect the complete dmesg log and output of "sudo lspci -vv"
>and post them somewhere (https://bugzilla.kernel.org is a good place)?
`lspci -vvnn` output is linked in the head of the thread. Append .txt to make it readable in the browser (I only understood it after the upload).

>Ideally the dmesg would be from the most recent kernel you have.
Speaking of that, a couple of questions:

1) Should I post them with or without pci=nomsi/noaer? The problem with disabling it is that it floods the logs so fast, that they reach 700M in 5-7 minutes, and, when rotation is enabled (my parameters are default, up to 10 copies 10M each), all pre-flood data is lost instantly.

Also I'm currently bisecting the kernel with MSI disabled in the config. But I'm keeping the parameter in the bootloader for cases when I'm using Gentoo's prebuilt kernel.

2) Can I delete messages by ufw? They contain MACs of my router, laptop and cellphone and I don't really wanna share them

3) I'm not savvy in logs, how exactly should I share dmesg? `dmesg > file`? /var/log/syslog? I already know kern.log doesn't contain logind and some other messages that are present in dmesg

4) Should we continue in this thread or rather start a new one?
