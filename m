Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0FA52D666
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 16:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbiESOrB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 10:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbiESOrA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 10:47:00 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A95860B94
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 07:46:59 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2fedd26615cso59038987b3.7
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=wOWY8OWy7Em6vDzMFGjSuMI5xjxfqFqSIB9PTcj/Zg8=;
        b=N4yR6vy1mCQUvXsxlqkXy7oC72BlPYzL3ZOAAgQxCPQNaF8qIruGZvUA/BuDyvIo1o
         G3KtaBP1ZRzqvWXb2VYjQde41alPR88MPjRTUFlzY0vX9QHHxe4x+du4lRRQMyBexfVx
         zp7JBeuNFe10/44ScukAq1oEPYKIu9ld4MNPUqJShvWEtL8SHwhIfKaSTIbDaETejcgy
         hHMOWoQYPl8zntnhnZpkJaasHN5o5PKQ7Ja9UEOcE1HlIN93eF8mw0JDvd3Hx/sTbzZy
         egndv4QVbQjNTfU/F1yqaeBtpJzo/gdUYJD4Bwt3G7N0Cd1ZMlvhjxTYkl1XiXqA30SZ
         S4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=wOWY8OWy7Em6vDzMFGjSuMI5xjxfqFqSIB9PTcj/Zg8=;
        b=vGaFeqQM8wYLoHW0PEQjM68CbNv3lkXnkwS4bhH/zfy4Y9R1BhlQ7J8++BWjB7IG16
         mlb9UwkRf1NIBGKeisUh7srtLctl2ORAE/H1E4XLLIxPOu8RKLuNtqLTaeZmyd9HrlJ5
         ct8GWOWpMRFztCixHXHKI6Zxb0Tm8zB4vtTiMlYeUfOQepVsQQMd/gYGyvO4/7LgI747
         ttpyQe4gupPYMJ9ROMhbPTdDNHxXI1xuxKekkO46Hw8SH/2azbEH6i08NsXcm46yPnO0
         v7HqoIss+SgxZEyl7lpS1rKYTXL1XNhagZF2Xc1eD4xDtknWzfM0UyqE/T06yii/5VUw
         acxg==
X-Gm-Message-State: AOAM532jCFtstyoxyOtKZC9Uv0Rn76aEd5sReSjhHT+EvONu3PwmAlQ/
        ZtAkcdgX/igfg956BjxnoK7IXLeOChTk3M45LTlKA3e+
X-Google-Smtp-Source: ABdhPJycub4AmgKpGbn9XQdXRYrMZhzZBO3q0kfRY8RyJoq8NB74PpgnCE1gk3g2hsbTiiGGpsB9Gnws/GqPMN7X95E=
X-Received: by 2002:a81:bcd:0:b0:2ff:2442:5eff with SMTP id
 196-20020a810bcd000000b002ff24425effmr4978903ywl.261.1652971618065; Thu, 19
 May 2022 07:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <bug-216000-41252@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216000-41252@https.bugzilla.kernel.org/>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Thu, 19 May 2022 09:46:46 -0500
Message-ID: <CABhMZUXY5Xe0QsAXNS+3-QdFfH_zLA6=6bbEDdFm9xd5ek4gZA@mail.gmail.com>
Subject: Fwd: [Bug 216000] New: TBT storage hotplug fail when connect via
 thunderbolt dock
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for the report, Chris!  Forwarding to linux-pci and Lukas for visibility.

---------- Forwarded message ---------
From: <bugzilla-daemon@kernel.org>
Date: Thu, May 19, 2022 at 9:24 AM
Subject: [Bug 216000] New: TBT storage hotplug fail when connect via
thunderbolt dock
To: <bjorn@helgaas.com>

https://bugzilla.kernel.org/show_bug.cgi?id=216000

            Bug ID: 216000
           Summary: TBT storage hotplug fail when connect via thunderbolt
                    dock
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.17 and later
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: chris.chiu@canonical.com
        Regression: No

Created attachment 300996
  --> https://bugzilla.kernel.org/attachment.cgi?id=300996&action=edit
output of lspci -vvv

When I power on the adl-hx laptop with the thuderbolt dock(Dell WD22TB4)
connected, the TBT storage can never be detected if I connect it via the dock.
The kernel message shows "No bus number available for hot-added bridge" as
follows.

[  102.073815] pcieport 0000:3a:01.0: pciehp: Slot(1-1): Card present
[  102.073825] pcieport 0000:3a:01.0: pciehp: Slot(1-1): Link Up
[  102.210491] pci 0000:3c:00.0: [8086:15da] type 01 class 0x060400
[  102.210702] pci 0000:3c:00.0: enabling Extended Tags
[  102.211176] pci 0000:3c:00.0: supports D1 D2
[  102.211179] pci 0000:3c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[  102.211510] pci 0000:3c:00.0: 8.000 Gb/s available PCIe bandwidth, limited
by 2.5 GT/s PCIe x4 link at 0000:03:03.0 (capable of 31.504 Gb/s with 8.0 GT/s
PCIe x4 link)
[  102.211732] pci 0000:3c:00.0: Adding to iommu group 30
[  102.212093] pcieport 0000:3a:01.0: ASPM: current common clock configuration
is inconsistent, reconfiguring
[  102.212172] pci 0000:3c:00.0: No bus number available for hot-added bridge

The problem will be gone if I boot with the kernel parameter
"pci=realloc,assign-busses,hpbussize=0x33" but we expect the `pciehp` should
handle it w/o problem. Which part of system should reserve the PCIe bus number
the hotplug device?

--
