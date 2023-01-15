Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AEB66B01E
	for <lists+linux-pci@lfdr.de>; Sun, 15 Jan 2023 10:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjAOJVy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Jan 2023 04:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAOJVx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jan 2023 04:21:53 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A1159E4
        for <linux-pci@vger.kernel.org>; Sun, 15 Jan 2023 01:21:51 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so4700557pjg.4
        for <linux-pci@vger.kernel.org>; Sun, 15 Jan 2023 01:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIULLdFP9e5GK7VAsZJfbRrocIEnNIPLUhOzuA4qczM=;
        b=tTaNTa1Hqf1Xh+NeCY0IfXIhnDKR+1lXlyMuOU5idn9XRFMkQDxMJ1qsHxycuqXjyd
         WDW2xj4TFfp7i05eOxAf1uzjNeC23FaZg/XrXVv2eRXWUCPILlj+W6mYBlKorIWowrIT
         Hyy+a6HXuOnTsKKMvGmUWbw1Osz8p74E96d+S32XHUeQic0vWxp9TvEQD1PVVp578tlx
         AljUXu9RhI2ee//VEduOnNewEK4YTMXPPj2zP81jqfHsDk2QcSuuIbt2Vja4DAHsAvlH
         l0Hv8j5RiKAxGBKJHzSalk2nxqN0XSvbmiNjNCFiIV7g8CwdjkcoB/zy8hetYfrlw3mz
         r9BA==
X-Gm-Message-State: AFqh2krc5IvgEobMA3EA/ouWhLV00mH2rzFA9sy6l2tBXGwfM9U1+gQH
        LBLH9arSU/UFzz0Ow6RPTByIyJJ/iuPholg=
X-Google-Smtp-Source: AMrXdXtdHtMy57L288byrYn3zQWL4WhnOnXBVD2PhshcxduljL3a4Xsda0EXW3JEwUT6WO6/8pHv0g==
X-Received: by 2002:a17:902:ccc5:b0:185:441e:4cfc with SMTP id z5-20020a170902ccc500b00185441e4cfcmr101010664ple.44.1673774511376;
        Sun, 15 Jan 2023 01:21:51 -0800 (PST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com. [209.85.210.180])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902b19500b00189e1522982sm17054801plr.168.2023.01.15.01.21.50
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 01:21:50 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id w2so3600680pfc.11
        for <linux-pci@vger.kernel.org>; Sun, 15 Jan 2023 01:21:50 -0800 (PST)
X-Received: by 2002:a65:674e:0:b0:48d:a8d8:6f73 with SMTP id
 c14-20020a65674e000000b0048da8d86f73mr4342639pgu.396.1673774510283; Sun, 15
 Jan 2023 01:21:50 -0800 (PST)
MIME-Version: 1.0
From:   Peifeng Qiu <linux@qiupf.dev>
Date:   Sun, 15 Jan 2023 18:21:39 +0900
X-Gmail-Original-Message-ID: <CAPH51bc1ZoP2ukJJh8nfrNY1FCp1nk7AP0jGGCvoskq2XbmAoA@mail.gmail.com>
Message-ID: <CAPH51bc1ZoP2ukJJh8nfrNY1FCp1nk7AP0jGGCvoskq2XbmAoA@mail.gmail.com>
Subject: Missing sriov_numvfs after removal of EfiMemoryMappedIO from E820 map
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi.

I'm using a dual Xeon system with Intel e810 25G network card and make use
of SRIOV feature heavily. I have a script to setup the NIC the first step is
echo $VFS > /sys/class/net/$DEVNAME/device/sriov_numvfs

After switching from v6.1 to v6.2-rc1 "sriov_numvfs" is no longer present. If I
switch back to v6.1 it's back. Command line parameters are the same so it's
most likely kernel changes. I did git bisect and found the culprit to be
07eab0901ed(efi/x86: Remove EfiMemoryMappedIO from E820 map)

I tested v6.2-rc3 and it's the same. I reverted this commit on top of v6.2-rc3
then sriov_numvfs is back again. Comparing the dmesg output, I found that
with commit 07eab0901ed these lines are present:
[    0.000000] efi: Remove mem94: MMIO range=[0x80000000-0x8fffffff]
(256MB) from e820 map
[    0.000000] e820: remove [mem 0x80000000-0x8fffffff] reserved
[    0.000000] efi: Remove mem95: MMIO range=[0xfd000000-0xfe7fffff]
(24MB) from e820 map
[    0.000000] e820: remove [mem 0xfd000000-0xfe7fffff] reserved
[    0.000000] efi: Not removing mem96: MMIO
range=[0xfed20000-0xfed44fff] (148KB) from e820 map
[    0.000000] efi: Remove mem97: MMIO range=[0xff000000-0xffffffff]
(16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] efi: Remove mem99: MMIO
range=[0x1ffc00000000-0x1fffffffffff] (16384MB) from e820 map
[    0.000000] e820: remove [mem 0x1ffc00000000-0x1fffffffffff] reserved

I think that's what the commit actually does. But the following are missing:
[    2.516119] pci 0000:ca:00.0: reg 0x184: [mem
0x208ffd000000-0x208ffd01ffff 64bit pref]
[    2.516121] pci 0000:ca:00.0: VF(n) BAR0 space: [mem
0x208ffd000000-0x208ffdffffff 64bit pref] (contains BAR0 for 128 VFs)
[    2.516134] pci 0000:ca:00.0: reg 0x190: [mem
0x208ffe220000-0x208ffe223fff 64bit pref]
[    2.516136] pci 0000:ca:00.0: VF(n) BAR3 space: [mem
0x208ffe220000-0x208ffe41ffff 64bit pref] (contains BAR3 for 128 VFs)

Not sure whether this is a driver issue specific to Intel e810(module ice) or
a more general one. Any thoughts on this issue?

Best regards,
Peifeng Qiu
