Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DCE211EFE
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jul 2020 10:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGBIk0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jul 2020 04:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgGBIk0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jul 2020 04:40:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258F2C08C5C1;
        Thu,  2 Jul 2020 01:40:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so27137986wrc.7;
        Thu, 02 Jul 2020 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HhIqs5H8Sh0TaWImCuxyQpDb5LLrmm9oiZJu/eGa88o=;
        b=m56LE2FG27ERLTM2smVWanH1WZ8c73ZhZa5Y9WBqjYA589STp1NxLY3bSiuZcYJdce
         p13dHQLyBEc1lKOLaggE/p6JUePhv6F1vpP6HuE4B3Azop6v48geGQNPkpQhbPH+DN8b
         mYDTrq2blgYS0a+WND88IYOwlQL88RThbBIDELMtIZE6Z7aAhXrixXNDQDHt10rBg3fZ
         +StHgRD4UTa5wxbKvJQLD8nSbRd+4QzJnkY6CK/NFyh+aPfnEAcqpoUtsqd2k4QpKq2U
         +B00RnspeXUSrnf60AtCaVn0B+mtoLkeicqPxJD+S5jmzX8MnjeusWdvvviS46oZ91yA
         +WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HhIqs5H8Sh0TaWImCuxyQpDb5LLrmm9oiZJu/eGa88o=;
        b=VODY1pKx9X5TKD94+OLb2d+y991j9YvdfkceZvSrglBdI79wNp8u/RhRPPdgVASjMe
         yeZ2/Y2PsjDPuukLMek9I+TFayBdVTonG0dR+28aR5auANrDIr/2LmkhyM5hrAf4/UMU
         JIq6o3i1xIGntkjx1gSiTIkpT8cB9VIvz904PKpPJpPOwSb5cR4FHaghfAfASerDt1tF
         1Lb9+B3ATjOMrmP2dy/sPAHxlBpE7G0q7yJMpYdzyINhMvku9aj9sAlQfcTkrMGy+bQF
         467PrSD5zImfSBBI4E+Va+7Sy3FRUm+nKvmEleqxeAzrI9VNQY2Iojowg5mgNYhbY7QH
         7DwA==
X-Gm-Message-State: AOAM533ucEqLpNsRAbi5LiMyGGN3jXH+JO6VSQS6yt6uO6i/1jaajGl3
        zE0yl7BalLEAZIgbnRn8wDM=
X-Google-Smtp-Source: ABdhPJyK04Wf4jA1ICMU9g7GrNZXa1md7e+mjUuEotvKGvOj4HUmNMMgeRa0p26antgUXLdwhu512w==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr33510136wru.158.1593679224808;
        Thu, 02 Jul 2020 01:40:24 -0700 (PDT)
Received: from localhost.localdomain ([220.240.234.21])
        by smtp.googlemail.com with ESMTPSA id m16sm5073053wro.0.2020.07.02.01.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 01:40:24 -0700 (PDT)
Message-ID: <24f56c0ed6d10ef565cf83d47d0538d37ac0d8ef.camel@gmail.com>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
From:   Oliver O'Halloran <oohall@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatja@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 02 Jul 2020 18:40:09 +1000
In-Reply-To: <20200702073226.GB1073011@kroah.com>
References: <20200630044943.3425049-1-rajatja@google.com>
         <20200630044943.3425049-6-rajatja@google.com>
         <20200630104948.GC856968@kuha.fi.intel.com>
         <20200630125216.GA1109228@kroah.com>
         <CAJZ5v0iYFKrouQx_b7afPnz7ohjWOKKDhdHj_3HObKYV_rRhiw@mail.gmail.com>
         <20200630153816.GD1785141@kroah.com>
         <CAJZ5v0jUx-RVhJRDngkOXx-3szFJDOgCJs2yuGKFyo2f1qZAwA@mail.gmail.com>
         <20200630170012.GB1894898@kroah.com>
         <CACK8Z6Fcrb8PtmbUJLn8RgiGnC8eqTC9GjsgjPmQgU212WPU0Q@mail.gmail.com>
         <CAOSf1CEZ82iXhYnig0UScS+oRRaxHzSCge9LbA1hW3NaQAiSxQ@mail.gmail.com>
         <20200702073226.GB1073011@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2020-07-02 at 09:32 +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 02, 2020 at 03:23:23PM +1000, Oliver O'Halloran wrote:
> > Yep, that's a problem. If we want to provide a useful mechanism to
> > userspace then the default behaviour of the kernel can't undermine
> > that mechanism. If that means we need another kernel command line
> > parameter then I guess we just have to live with it.
> 
> I really do not want yet-another-kernel-command-line-option if we can
> help it at all.  Sane defaults are the best thing to do here.  Userspace
> comes up really early, put your policy in there, not in blobs passed
> from your bootloader.

Userspace comes up early, but builtin drivers will bind before init is
started. e.g.

# dmesg | egrep '0002:01:00.0|/init'
[    0.976800][    T1] pci 0002:01:00.0: [8086:1589] type 00 class 0x020000
[    0.976923][    T1] pci 0002:01:00.0: reg 0x10: [mem 0x220000000000-0x2200007fffff 64bit pref]
[    0.977004][    T1] pci 0002:01:00.0: reg 0x1c: [mem 0x220002000000-0x220002007fff 64bit pref]
[    0.977068][    T1] pci 0002:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    0.977122][    T1] pci 0002:01:00.0: BAR3 [mem size 0x00008000 64bit pref]: requesting alignment to 0x10000
[    0.977401][    T1] pci 0002:01:00.0: PME# supported from D0 D3hot
[    1.011929][    T1] pci 0002:01:00.0: BAR 0: assigned [mem 0x220000000000-0x2200007fffff 64bit pref]
[    1.012085][    T1] pci 0002:01:00.0: BAR 6: assigned [mem 0x3fe100000000-0x3fe10007ffff pref]
[    1.012127][    T1] pci 0002:01:00.0: BAR 3: assigned [mem 0x220002000000-0x220002007fff 64bit pref]
[    4.399588][   T12] i40e 0002:01:00.0: enabling device (0140 -> 0142)
[    4.410891][   T12] i40e 0002:01:00.0: fw 5.1.40981 api 1.5 nvm 5.03 0x80002469 1.1313.0 [8086:1589] [15d9:0000]
[    4.647524][   T12] i40e 0002:01:00.0: MAC address: 0c:c4:7a:b7:fc:74
[    4.647685][   T12] i40e 0002:01:00.0: FW LLDP is enabled
[    4.653918][   T12] i40e 0002:01:00.0 eth0: NIC Link is Up, 1000 Mbps Full Duplex, Flow Control: None
[    4.655552][   T12] i40e 0002:01:00.0: PCI-Express: Speed 8.0GT/s Width x8
[    4.656071][   T12] i40e 0002:01:00.0: Features: PF-id[0] VSIs: 34 QP: 80 RSS FD_ATR FD_SB NTUPLE VxLAN Geneve PTP VEPA
[   13.803709][    T1] Run /init as init process
[   13.963242][  T711] i40e 0002:01:00.0 enP2p1s0f0: renamed from eth0

Building everything into the kernel is admittedly pretty niche. I only
do it to avoid re-building the initramfs for my test kernels. It does
seem relatively common on embedded systems, but I'm not sure how many
of those care about PCIe. It would be nice to provide *something* to
cover that case for the people who care.

Oliver


