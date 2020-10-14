Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3255828DEEF
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 12:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgJNKcO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 06:32:14 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:60485 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgJNKcN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Oct 2020 06:32:13 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 1373bc51
        for <linux-pci@vger.kernel.org>;
        Wed, 14 Oct 2020 09:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=G7lsWchDFAdzTrUiW/46+cTGgP0=; b=nVCamy
        0IrZwiqVsZEygGtuBVVpEd8XEgusGO6I9nMBUn+/GhglLt2t+6gGI8HZgWp6YOj1
        R1ZbDWSmUzRe5gi6JsRvPFGhJoDh7xgG1LgwvYpUx6t8VdvU2+gmzY+RfpolGzl1
        xEuLZQFbQlBS6nQv2MXqPlS5kg1nvhUIu0R+LaaLB81d4qTE0l6KyE2QYxqV6ETt
        iYpzQox5vDINKqtUEFKfEMs4CGylCPRAYVMUVjn9lj9OKYg5PUmFRtGKjGCnkF4x
        QORHKNRo2sLLyrQacs4ucwkHMpB9AEd/EhlCnhD3S1Sxi5XOKezd8KYjXRu+h+3i
        KFwpZ6t3yqDsEnOg==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cef81c60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-pci@vger.kernel.org>;
        Wed, 14 Oct 2020 09:58:36 +0000 (UTC)
Received: by mail-il1-f173.google.com with SMTP id k1so1220112ilc.10
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 03:32:06 -0700 (PDT)
X-Gm-Message-State: AOAM5315/Z2N5QYuj2q36IiZXfIKlsXtRcHWPd5tUovaJFgBPJ29pqnd
        PUx/nTLvqLOzTmQOTw2IybIuilzwVzlD7yK72MU=
X-Google-Smtp-Source: ABdhPJzPWedYt4j8eeP6btKncevGPQyNtGMnwi5KjK5QdR6zaUA329oSe1PP8IacZ3ZH1QMmdfrU3iAShaMdBdzlKuA=
X-Received: by 2002:a92:c142:: with SMTP id b2mr3172794ilh.207.1602671525731;
 Wed, 14 Oct 2020 03:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qa4NQCj8w-Apd2TnbtMjbox0jA6T347Bf_wEkJrzSz0g@mail.gmail.com>
 <20201012220325.GA3752081@bjorn-Precision-5520>
In-Reply-To: <20201012220325.GA3752081@bjorn-Precision-5520>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 14 Oct 2020 12:31:54 +0200
X-Gmail-Original-Message-ID: <CAHmME9rUfxP1XwhPPMNAneWtq=bV0OZrQNittC4qF4+zp5ocaA@mail.gmail.com>
Message-ID: <CAHmME9rUfxP1XwhPPMNAneWtq=bV0OZrQNittC4qF4+zp5ocaA@mail.gmail.com>
Subject: Re: spammy dmesg about fluctuating pcie bandwidth on 5.9
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Alex G." <mr.nuke.me@gmail.com>, linux-pci@vger.kernel.org,
        "Bolen, Austin" <austin_bolen@dell.com>,
        Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

You know, more errors today make me suspect that maybe the thunderbolt
controller in my laptop is just dying. I'll go back to 5.8 for a few
days and see if the problem disappears. If it doesn't, we'll chalk
this up to a hardware failure.

[52564.683527] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52587.429587] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52610.176643] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52632.442035] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52655.196484] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52676.069815] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52698.838958] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52721.614715] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52743.822935] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52766.584985] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52787.503210] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52809.614398] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52831.958357] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52854.548572] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52877.299670] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52899.745745] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52921.962762] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52944.734183] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52967.506717] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[52989.692810] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53011.590205] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53031.853021] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53054.598835] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53076.737036] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53099.154976] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53121.615704] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53144.370826] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53167.110803] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53189.632904] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53212.122360] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53234.568455] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53257.314696] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53280.065899] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53302.653802] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53324.802066] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53347.155385] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53369.930754] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53392.673206] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53415.422695] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53437.575469] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53459.924374] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53481.226712] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53503.978701] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53526.718798] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53549.226976] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53571.729911] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53591.785311] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53613.674967] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53635.864761] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53657.596000] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53680.345128] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53702.607956] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53725.349727] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53747.698887] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53768.391645] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53790.710167] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53813.458448] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53835.962155] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53858.737424] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53880.632360] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53903.377152] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53926.127577] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53948.872052] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53971.165685] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[53992.899248] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54015.646103] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54037.379802] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54060.126666] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54082.719828] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54105.460604] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54128.206816] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54150.720032] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54173.461119] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54196.233695] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54218.980327] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54241.324117] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54263.273554] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54285.753796] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54308.500256] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54331.243588] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54353.993575] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54376.742436] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54399.538827] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54421.939879] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54443.171688] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54463.907753] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54486.444609] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54508.819424] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54531.378247] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54553.859614] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54576.259269] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54599.002388] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54620.281823] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54642.868030] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54665.623918] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54688.360596] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54709.563471] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54732.116911] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54753.826188] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54776.601969] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54799.357644] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54821.583955] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54844.333217] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54865.797148] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54888.275264] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54910.835481] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54932.674099] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54955.424133] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54978.176316] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[54999.902146] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55022.271627] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55043.551963] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55065.950926] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55088.697586] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55111.445225] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55132.908323] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55155.654698] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55178.424171] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55201.202069] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55223.385345] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55245.944860] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55268.697286] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55291.443936] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55314.212435] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55336.588308] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55359.327636] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55382.116790] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55404.849910] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55427.086288] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55449.540717] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55472.264838] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55494.633414] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55516.739769] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55539.539306] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55560.895074] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55583.641087] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55605.589889] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55628.012965] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55650.758661] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55671.614120] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55694.386532] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55717.162811] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55739.929464] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55762.711654] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55785.481001] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55807.296763] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55830.032549] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55852.806503] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55875.557826] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55898.300307] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55920.601459] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55943.386320] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55965.805180] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[55987.966448] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56010.710686] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56032.985013] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56055.383350] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56078.131338] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56100.908103] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56123.672924] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56146.456694] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56168.241434] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56190.984557] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56213.728970] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56236.479194] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56259.227574] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56281.741010] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56304.515104] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56327.285574] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56349.815666] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56372.564126] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56395.149359] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56417.893220] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56440.653872] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56463.124535] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56485.844516] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56507.793974] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56530.538045] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56551.550994] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56573.681263] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56596.218372] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56618.768060] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56641.527359] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56664.308180] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56686.804588] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56708.884207] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56731.661614] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56753.395308] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56775.100166] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56797.848057] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56820.030602] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56842.755564] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56864.933402] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56887.664037] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56909.977074] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56931.689354] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56954.429864] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56976.240067] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[56999.005743] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57021.742083] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57044.059589] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57066.802625] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57087.471889] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57110.184581] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57132.642118] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57155.388264] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57177.170280] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57199.174069] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57221.916709] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57243.603547] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57265.733447] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57288.105229] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57310.613015] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57333.194769] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57355.941465] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57378.689362] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57399.836987] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57422.130106] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57444.048839] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57466.822191] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57489.568757] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57512.318493] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57534.798548] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57556.131559] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57578.874350] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57601.623701] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57624.366037] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57647.109293] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57669.888354] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57692.631543] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57715.384177] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57737.111593] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57759.830741] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57782.370961] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57805.109123] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57827.859680] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57850.605854] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57873.348583] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57895.085168] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57916.818517] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57939.269916] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57962.017043] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[57984.798361] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58007.568477] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58030.313263] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58053.073731] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58075.808104] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58098.554446] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58121.305341] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58143.542285] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58166.292920] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58189.040938] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58211.786224] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58234.566964] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58256.727558] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58279.464486] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58302.214869] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58324.985393] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58347.329004] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58370.051630] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58391.091796] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58413.678065] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58436.452531] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58459.200188] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58480.989136] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58503.546267] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58526.305437] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58549.042640] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58571.308535] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58594.085007] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58616.858737] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58639.606010] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58662.378957] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58685.152599] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58707.922352] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58730.692272] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58752.744976] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58775.738760] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58798.508419] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58820.908075] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58843.651135] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58866.431214] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58888.527585] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58911.090843] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58932.024059] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58952.720709] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58975.436974] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[58997.704290] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59020.451632] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59043.197656] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59065.952627] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59088.693117] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59111.249018] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59133.783099] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59155.489148] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59177.195098] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59199.948567] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59222.321785] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59244.528647] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59267.274380] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59289.540350] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59312.290949] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59334.797382] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59357.510671] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59380.263129] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59403.006149] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59425.513087] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59448.255446] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59470.855849] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59493.591610] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59516.370701] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59539.114221] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59561.861008] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59584.633419] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59607.383700] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59630.130540] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59652.869666] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59675.622224] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59698.362745] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59721.141469] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59743.671676] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59765.375589] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59788.154873] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59810.901046] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59833.670234] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59855.400450] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59878.177218] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59900.146113] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59922.896282] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59944.808905] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59967.085545] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[59989.857786] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60011.114246] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60033.880849] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60055.980698] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60077.745125] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60099.904108] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60122.676501] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60144.735906] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60167.082029] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60189.822241] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60211.212537] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60233.718434] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60256.464482] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60279.217766] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60301.954241] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60324.726592] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60347.473717] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60370.223613] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60392.989234] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60415.765029] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60436.948989] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60459.525062] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60481.261825] pcieport 0000:04:00.0: 31.504 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60503.765720] pcieport 0000:04:00.0: 8.000 Gb/s available PCIe
bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1b.4 (capable
of 1984.941 Gb/s with 32.0 GT/s PCIe x63 link)
[60528.348595] pcieport 0000:00:1b.4: Data Link Layer Link Active not
set in 1000 msec
[60528.348661] pcieport 0000:04:00.0: can't change power state from
D3cold to D0 (config space inaccessible)
[60528.348743] pcieport 0000:05:02.0: can't change power state from
D3cold to D0 (config space inaccessible)
[60528.348747] pcieport 0000:00:1b.4: pciehp: Slot(20): Card not present
[60528.348750] pcieport 0000:05:00.0: can't change power state from
D3cold to D0 (config space inaccessible)
[60528.348764] pcieport 0000:05:04.0: can't change power state from
D3cold to D0 (config space inaccessible)
[60528.348768] xhci_hcd 0000:2c:00.0: can't change power state from
D3cold to D0 (config space inaccessible)
[60528.348786] pcieport 0000:05:01.0: can't change power state from
D3cold to D0 (config space inaccessible)
[60528.348788] xhci_hcd 0000:2c:00.0: can't change power state from
D3hot to D0 (config space inaccessible)
[60528.348809] thunderbolt 0000:06:00.0: can't change power state from
D3cold to D0 (config space inaccessible)
[60528.348827] xhci_hcd 0000:2c:00.0: Controller not ready at resume -19
[60528.348828] ------------[ cut here ]------------
[60528.348832] thunderbolt 0000:06:00.0: interrupt for TX ring 0 is
already enabled
[60528.348835] xhci_hcd 0000:2c:00.0: PCI post-resume error -19!
[60528.348838] xhci_hcd 0000:2c:00.0: HC died; cleaning up
[60528.348917] WARNING: CPU: 6 PID: 1332774 at
drivers/thunderbolt/nhi.c:100 ring_interrupt_active+0x18c/0x1e0
[thunderbolt]
[60528.348918] Modules linked in: fuse snd_usb_audio snd_usbmidi_lib
snd_rawmidi snd_seq_device snd_hda_codec_hdmi rfcomm af_packet cmac
algif_skcipher bnep uvcvideo btusb videobuf2_vmalloc btintel
videobuf2_memops videobuf2_v4l2 videobuf2
_common bluetooth ecdh_generic videodev ecc usbhid mc 8021q xt_hl
ip6table_filter ip6_tables xt_multiport xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter nvidia_drm(PO)
nvidia_modeset(PO) joydev mousedev rmi_smbus rm
i_core snd_hda_codec_conexant snd_hda_codec_generic intel_rapl_msr
wmi_bmof iwlmvm mac80211 libarc4 intel_powerclamp coretemp kvm_intel
nvidia(PO) snd_hda_intel kvm i915 snd_intel_dspcfg snd_hda_codec
irqbypass iwlwifi intel_gtt i2c_algo_b
it snd_hwdep crc32_pclmul sdhci_pci crc32c_intel xhci_pci cqhci
snd_hda_core drm_kms_helper snd_pcm xhci_hcd sdhci syscopyarea
sysfillrect snd_timer mei_me input_leds psmouse
processor_thermal_device usbcore sysimgblt thinkpad_acpi usb_com
mon ee1004 thunderbolt ledtrig_audio fb_sys_fops
[60528.348969]  cfg80211 mmc_core intel_rapl_common mei
intel_pch_thermal e1000e cec snd intel_soc_dts_iosf soundcore
led_class wmi rfkill int3403_thermal int340x_thermal_zone
pinctrl_cannonlake pinctrl_intel int3400_thermal acpi_thermal_r
el evdev sch_fq_codel drm drm_panel_orientation_quirks
[60528.348990] CPU: 6 PID: 1332774 Comm: kworker/6:4 Tainted: P S   U
   O      5.9.0+ #146
[60528.348992] Hardware name: LENOVO 20QTCTO1WW/20QTCTO1WW, BIOS
N2OET47W (1.34 ) 08/06/2020
[60528.349001] Workqueue: pm pm_runtime_work
[60528.349016] RIP: 0010:ring_interrupt_active+0x18c/0x1e0 [thunderbolt]
[60528.349020] Code: c7 b0 00 00 00 4c 89 0c 24 e8 20 c3 0e e1 4c 8b
0c 24 48 89 c6 45 89 f8 4c 89 e9 4c 89 f2 48 c7 c7 10 28 46 a0 e8 97
5b c7 e0 <0f> 0b e9 6d ff ff ff 0f b6 43 78 c4 62 01 f7 f8 44 09 ff e9
2d ff
[60528.349023] RSP: 0018:ffff88814f68fd18 EFLAGS: 00010096
[60528.349026] RAX: 0000000000000044 RBX: ffff888ff08cb500 RCX: ffff888ffc397328
[60528.349028] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff888ffc397320
[60528.349030] RBP: 0000000000038200 R08: 0000000000000001 R09: 0000000000000f23
[60528.349033] R10: 00000000000116a4 R11: 0000000000000000 R12: 00000000ffffffff
[60528.349035] R13: ffffffffa0461f25 R14: ffff888ff4bdf3a0 R15: 0000000000000000
[60528.349038] FS:  0000000000000000(0000) GS:ffff888ffc380000(0000)
knlGS:0000000000000000
[60528.349040] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[60528.349042] CR2: 00000a27085ca038 CR3: 0000000002009004 CR4: 00000000003726e0
[60528.349044] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[60528.349046] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[60528.349048] Call Trace:
[60528.349068]  tb_ring_start+0x102/0x200 [thunderbolt]
[60528.349083]  tb_ctl_start+0x1a/0x70 [thunderbolt]
[60528.349103]  tb_domain_runtime_resume+0x10/0x30 [thunderbolt]
[60528.349111]  pci_pm_runtime_resume+0xa2/0xc0
[60528.349117]  ? new_id_store+0x1a0/0x1a0
[60528.349121]  ? new_id_store+0x1a0/0x1a0
[60528.349128]  __rpm_callback+0x68/0x120
[60528.349132]  ? new_id_store+0x1a0/0x1a0
[60528.349138]  rpm_callback+0x1a/0x70
[60528.349142]  ? new_id_store+0x1a0/0x1a0
[60528.349147]  rpm_resume+0x52f/0x780
[60528.349155]  ? finish_task_switch+0x14c/0x240
[60528.349161]  pm_runtime_work+0x63/0x80
[60528.349165]  process_one_work+0x1ca/0x390
[60528.349169]  worker_thread+0x48/0x3c0
[60528.349173]  ? rescuer_thread+0x3d0/0x3d0
[60528.349178]  kthread+0x114/0x130
[60528.349184]  ? kthread_create_worker_on_cpu+0x40/0x40
[60528.349188]  ret_from_fork+0x1f/0x30
[60528.349193] ---[ end trace 36cc03dab37a7618 ]---
[60528.349208] ------------[ cut here ]------------
[60528.349210] thunderbolt 0000:06:00.0: interrupt for RX ring 0 is
already enabled
[60528.349268] WARNING: CPU: 6 PID: 1332774 at
drivers/thunderbolt/nhi.c:100 ring_interrupt_active+0x18c/0x1e0
[thunderbolt]
[60528.349269] Modules linked in: fuse snd_usb_audio snd_usbmidi_lib
snd_rawmidi snd_seq_device snd_hda_codec_hdmi rfcomm af_packet cmac
algif_skcipher bnep uvcvideo btusb videobuf2_vmalloc btintel
videobuf2_memops videobuf2_v4l2 videobuf2
_common bluetooth ecdh_generic videodev ecc usbhid mc 8021q xt_hl
ip6table_filter ip6_tables xt_multiport xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter nvidia_drm(PO)
nvidia_modeset(PO) joydev mousedev rmi_smbus rm
i_core snd_hda_codec_conexant snd_hda_codec_generic intel_rapl_msr
wmi_bmof iwlmvm mac80211 libarc4 intel_powerclamp coretemp kvm_intel
nvidia(PO) snd_hda_intel kvm i915 snd_intel_dspcfg snd_hda_codec
irqbypass iwlwifi intel_gtt i2c_algo_b
it snd_hwdep crc32_pclmul sdhci_pci crc32c_intel xhci_pci cqhci
snd_hda_core drm_kms_helper snd_pcm xhci_hcd sdhci syscopyarea
sysfillrect snd_timer mei_me input_leds psmouse
processor_thermal_device usbcore sysimgblt thinkpad_acpi usb_com
mon ee1004 thunderbolt ledtrig_audio fb_sys_fops
[60528.349313]  cfg80211 mmc_core intel_rapl_common mei
intel_pch_thermal e1000e cec snd intel_soc_dts_iosf soundcore
led_class wmi rfkill int3403_thermal int340x_thermal_zone
pinctrl_cannonlake pinctrl_intel int3400_thermal acpi_thermal_r
el evdev sch_fq_codel drm drm_panel_orientation_quirks
[60528.349329] CPU: 6 PID: 1332774 Comm: kworker/6:4 Tainted: P S   U
W  O      5.9.0+ #146
[60528.349331] Hardware name: LENOVO 20QTCTO1WW/20QTCTO1WW, BIOS
N2OET47W (1.34 ) 08/06/2020
[60528.349338] Workqueue: pm pm_runtime_work
[60528.349352] RIP: 0010:ring_interrupt_active+0x18c/0x1e0 [thunderbolt]
[60528.349356] Code: c7 b0 00 00 00 4c 89 0c 24 e8 20 c3 0e e1 4c 8b
0c 24 48 89 c6 45 89 f8 4c 89 e9 4c 89 f2 48 c7 c7 10 28 46 a0 e8 97
5b c7 e0 <0f> 0b e9 6d ff ff ff 0f b6 43 78 c4 62 01 f7 f8 44 09 ff e9
2d ff
[60528.349359] RSP: 0018:ffff88814f68fd18 EFLAGS: 00010096
[60528.349361] RAX: 0000000000000044 RBX: ffff888ff08cb5c0 RCX: ffff888ffc397328
[60528.349363] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff888ffc397320
[60528.349365] RBP: 0000000000038200 R08: 0000000000000001 R09: 0000000000000f4f
[60528.349367] R10: 00000000000126f4 R11: 0000000000000000 R12: 00000000ffffffff
[60528.349369] R13: ffffffffa0461f2d R14: ffff888ff4bdf3a0 R15: 0000000000000000
[60528.349372] FS:  0000000000000000(0000) GS:ffff888ffc380000(0000)
knlGS:0000000000000000
[60528.349374] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[60528.349376] CR2: 00000a27085ca038 CR3: 0000000002009004 CR4: 00000000003726e0
[60528.349377] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[60528.349379] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[60528.349380] Call Trace:
[60528.349395]  tb_ring_start+0x102/0x200 [thunderbolt]
[60528.349410]  tb_ctl_start+0x24/0x70 [thunderbolt]
[60528.349428]  tb_domain_runtime_resume+0x10/0x30 [thunderbolt]
[60528.349432] xhci_hcd 0000:2c:00.0: remove, state 4
[60528.349439]  pci_pm_runtime_resume+0xa2/0xc0
[60528.349441] usb usb4: USB disconnect, device number 1
[60528.349447]  ? new_id_store+0x1a0/0x1a0
[60528.349451]  ? new_id_store+0x1a0/0x1a0
[60528.349457]  __rpm_callback+0x68/0x120
[60528.349462]  ? new_id_store+0x1a0/0x1a0
[60528.349466]  rpm_callback+0x1a/0x70
[60528.349471]  ? new_id_store+0x1a0/0x1a0
[60528.349476]  rpm_resume+0x52f/0x780
[60528.349482]  ? finish_task_switch+0x14c/0x240
[60528.349488]  pm_runtime_work+0x63/0x80
[60528.349492]  process_one_work+0x1ca/0x390
[60528.349496]  worker_thread+0x48/0x3c0
[60528.349499]  ? rescuer_thread+0x3d0/0x3d0
[60528.349504]  kthread+0x114/0x130
[60528.349509]  ? kthread_create_worker_on_cpu+0x40/0x40
[60528.349512]  ret_from_fork+0x1f/0x30
[60528.349516] ---[ end trace 36cc03dab37a7619 ]---
[60528.349880] xhci_hcd 0000:2c:00.0: USB bus 4 deregistered
[60528.349891] xhci_hcd 0000:2c:00.0: remove, state 4
[60528.349896] usb usb3: USB disconnect, device number 1
[60528.350332] xhci_hcd 0000:2c:00.0: Host halt failed, -19
[60528.350347] xhci_hcd 0000:2c:00.0: Host not accessible, reset failed.
[60528.350589] xhci_hcd 0000:2c:00.0: USB bus 3 deregistered
[60611.324161] thunderbolt 0000:06:00.0: failed to send driver ready to ICM
[60611.825639] pci 0000:06:00.0: Removing from iommu group 22
[60611.825745] pci_bus 0000:06: busn_res: [bus 06] is released
[60611.825873] pci 0000:05:00.0: Removing from iommu group 18
[60611.825956] pci_bus 0000:07: busn_res: [bus 07-2b] is released
[60611.826071] pci 0000:05:01.0: Removing from iommu group 19
[60611.826337] pci 0000:2c:00.0: Removing from iommu group 23
[60611.826432] pci_bus 0000:2c: busn_res: [bus 2c] is released
[60611.826596] pci 0000:05:02.0: Removing from iommu group 20
[60611.826882] pci_bus 0000:2d: busn_res: [bus 2d-51] is released
[60611.826994] pci 0000:05:04.0: Removing from iommu group 21
[60611.827077] pci_bus 0000:05: busn_res: [bus 05-51] is released
[60611.827415] pci 0000:04:00.0: Removing from iommu group 17
