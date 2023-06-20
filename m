Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9881D736682
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 10:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjFTIk7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 04:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjFTIk6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 04:40:58 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20455F1;
        Tue, 20 Jun 2023 01:40:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 686845C012E;
        Tue, 20 Jun 2023 04:40:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 20 Jun 2023 04:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687250453; x=1687336853; bh=Xx
        xXNvzqL5MvLriRDfv9WZWHp2emDFYmwCyeYMvz1og=; b=yr8fQ8fvzZW5GJ5WSB
        F74UvaZ5fNKraaC7XsFhChQzae6G2A89F3N3apVJ+9VOn/VhMDo8C0EEl5K7HOwS
        85yO8i9gja7pZsYkzKgrRQ0lsYCAmuwC+a9ADQS/5dlBnZE72G9aDR5EvUb/u37r
        PovEntq6tRRqnGDvzn+RTI4QH60lfl4jF8rmwdncpDlzK+Gbx0FzbS0Cna2weGGD
        4XzKGhz1TgMECfJv0eHVh75y0/hajtNK9Oa0dcUMJHIzwNh7q/zXDpGGjZCNh5Qc
        WPGLlwUtpzTdUL0oeHD2ikSaPJotEkcJUqU0Y03kQjSEWBJ60+m7XDCbeFz/wwM3
        0RLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687250453; x=1687336853; bh=XxxXNvzqL5MvL
        riRDfv9WZWHp2emDFYmwCyeYMvz1og=; b=asCjFqowiXvMVbJtJ2WnvjGiQKWxh
        P86ExNAqZIvU72VIjO7JKXDSgAoMuumkPzc1fDths9iAiJUVkuTSfgCL8Uxm1Dy0
        3+SuZU9dBGkpGk2s5GXr3rWLxXjctkerG9Yx1SuRV1a3ZbIwKTi1I/hnPS2N3BQ1
        Srqt3O07N++KibMN/UggsKnuYMVkUKwO3UU9nxFJo1qFclDk7piWm2y1NJTErsTa
        8nj6tzkYiw9+xKh0bJs/IhA0IEaY3EC1kwViHpdVNMo3byAA1JZ2V2b4H49RRu3a
        Hu5SSMQRTDBDRwnOWTHti0RcMutKoyv1d/9PuxtZIKPck4Ryy770vBOIg==
X-ME-Sender: <xms:FGaRZLXNU5q4rKM0l0hpsKDmW6_WedsWFcRS6E4GdvtDG8DDl0iXIA>
    <xme:FGaRZDlQUeFeU-CMsr8KvUBRC91SJvdWh1sZSC-Yia8HOC-wEeLpwco11tlCzCiQr
    cgvDCVx9z9nFW-W49Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefhedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:FGaRZHa2nledD2Ep87Nfqqw016eIVMRtJrBmrPKXLKYQ4DojkWkEYg>
    <xmx:FGaRZGUgLbQMlUUEzzc1Ek9sKBClOKWrjgCoCxxhs5WlEuRyfUg8SQ>
    <xmx:FGaRZFlNsfGYf1bUvC6uVPGPyIDdBUPGjMk2UuHymJl4KhsOu-Lj3Q>
    <xmx:FWaRZGgkj8TMepaoJYcWiN7f7NWgqam7GWs94nsGJyISWudZP6I0EA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D45F1B60086; Tue, 20 Jun 2023 04:40:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-496-g8c46984af0-fm-20230615.001-g8c46984a
Mime-Version: 1.0
Message-Id: <76665dd9-1cbc-4b3a-b466-18a54cd74c1c@app.fastmail.com>
In-Reply-To: <CA+G9fYtAi8NQ_5LNku3oik6b0243xhGFt2WyxERNE+eNqLbNOw@mail.gmail.com>
References: <CA+G9fYtAi8NQ_5LNku3oik6b0243xhGFt2WyxERNE+eNqLbNOw@mail.gmail.com>
Date:   Tue, 20 Jun 2023 10:40:30 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "Dan Carpenter" <dan.carpenter@linaro.org>,
        =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>,
        "Anders Roxell" <anders.roxell@linaro.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "Jingoo Han" <jingoohan1@gmail.com>,
        "Gustavo Pimentel" <gustavo.pimentel@synopsys.com>
Cc:     "Benjamin Copeland" <ben.copeland@linaro.org>
Subject: Re: x15: Unable to handle kernel NULL pointer dereference at virtual address
 00000004 when read : pci_generic_config_read
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 20, 2023, at 10:00, Naresh Kamboju wrote:
> We have been noticing the following kernel crash on x15 device while running
> LTP fs proc01 testing with Linux stable rc 6.x kernels.

Do you know if this is a regression with this kernel version compared
to older kernels running the same tests, or an added testcase in LTP
that exercises a code path that may have been broken for longer?

> Starting kernel ...
>
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.3.9-rc1 (tuxmake@tuxmake)
> (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld
> (GNU Binutils for Debian) 2.35.2) #1 SMP @1687172533
> [    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=10c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> [    0.000000] OF: fdt: Machine model: TI AM5728 BeagleBoard-X15
>
> ..
> LTP fs tests running
>
> cd /opt/ltp
> ./runltp -f fs
>
> atch/ltp-lyYeJYjM8Y/fs_di-4743
>              Loops: 10
>     Data File Size: 30
> fs_di       0  TINFO  :  Test Started
> fs_di       0  TINFO  :  Completed Loop 1
> fs_di       0  TINFO  :  Completed Loop 2
> fs_di       0  TINFO  :  Completed Loop 3
> fs_di       0  TINFO  :  Completed Loop 4
> fs_di       0  TINFO  :  Completed Loop 5
> fs_di       0  TINFO  :  Completed Loop 6
> fs_di       0  TINFO  :  Completed Loop 7
> fs_di       0  TINFO  :  Completed Loop 8
> fs_di       0  TINFO  :  Completed Loop 9
> fs_di       0  TINFO  :  Completed Loop 10
> fs_di      10  TPASS  :  Test Successful
> [ 1212.864074] 8<--- cut here ---
> [ 1212.867156] Unable to handle kernel NULL pointer dereference at
> virtual address 00000004 when read
> [ 1212.876159] [00000004] *pgd=fb342835
> [ 1212.879760] Internal error: Oops: 17 [#1] SMP ARM
> [ 1212.884490] Modules linked in: etnaviv gpu_sched
> snd_soc_simple_card snd_soc_simple_card_utils onboard_usb_hub
> snd_soc_davinci_mcasp snd_soc_ti_udma snd_soc_ti_edma snd_soc_ti_sdma
> snd_soc_core ac97_bus snd_pcm_dmaengine snd_pcm cfg80211 snd_timer snd
> soundcore bluetooth display_connector
> [ 1212.910217] CPU: 0 PID: 4855 Comm: proc01 Not tainted 6.3.9-rc1 #1
> [ 1212.916442] Hardware name: Generic DRA74X (Flattened Device Tree)
> [ 1212.922546] PC is at pci_generic_config_read+0x34/0x8c
> [ 1212.927734] LR is at pci_generic_config_read+0x1c/0x8c

It looks like the PCIe bus is not set up correctly, I also
see these messages in the log indicating a problem with it:

[    3.334503] dra7-pcie 51000000.pcie: host bridge /ocp/target-module@51000000/pcie@51000000 ranges:
[    3.343627] dra7-pcie 51000000.pcie:       IO 0x0020003000..0x0020012fff -> 0x0000000000
[    3.351806] dra7-pcie 51000000.pcie:      MEM 0x0020013000..0x002fffffff -> 0x0020013000
[    3.362030] dra7-pcie 51000000.pcie: iATU: unroll F, 16 ob, 4 ib, align 4K, limit 4G
[    4.370635] dra7-pcie 51000000.pcie: Phy link never came up
[    4.376831] dra7-pcie 51000000.pcie: PCI host bridge to bus 0000:00
[    4.383148] pci_bus 0000:00: root bus resource [bus 00-ff]
[    4.388702] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    4.394927] pci_bus 0000:00: root bus resource [mem 0x20013000-0x2fffffff]
[    4.401885] pci 0000:00:00.0: [104c:8888] type 01 class 0x060400
[    4.407958] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    4.414245] pci 0000:00:00.0: reg 0x14: [mem 0x00000000-0x0000ffff]
[    4.420654] pci 0000:00:00.0: supports D1
[    4.424682] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    4.437499] PCI: bus0: Fast back to back transfers disabled
[    4.443389] PCI: bus1: Fast back to back transfers enabled
[    4.448974] pci 0000:00:00.0: BAR 0: assigned [mem 0x20100000-0x201fffff]
[    4.455810] pci 0000:00:00.0: BAR 1: assigned [mem 0x20020000-0x2002ffff]
[    4.462646] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    4.468322] pcieport 0000:00:00.0: PME: Signaling with IRQ 135
[    4.474487] genirq: Threaded irq requested with handler=NULL and !ONESHOT for dra7xx-pcie-main (irq 132)
[    4.484100] dra7-pcie 51000000.pcie: failed to request irq
[    4.489685] dra7-pcie: probe of 51000000.pcie failed with error -22
[    4.503967] pcie-clkctrl:0000:0: failed to disable

The function that crashed is

int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
                            int where, int size, u32 *val)
{
        void __iomem *addr;

        addr = bus->ops->map_bus(bus, devfn, where);
        if (!addr)
                return PCIBIOS_DEVICE_NOT_FOUND;

        if (size == 1)
                *val = readb(addr);
        else if (size == 2) 
                *val = readw(addr); 
        else
                *val = readl(addr);
                 
        return PCIBIOS_SUCCESSFUL;
}                 

I have not disassembled the vmlinux file, but I can see that the
offset into the NULL pointer is '4', which does not match the
structur offsets for bus->ops or ops->map_bus.

I also see that if map_bus returns NULL, we treat that as
an error, but if it returns '4', that is taken as a pointer,
which is my best guess at what is happening here.

map_bus() seems to be either dw_pcie_other_conf_map_bus() or
dw_pcie_own_conf_map_bus(), since the dra7 does not have its
own variant but inherits these from the dwc pci driver.

I think this is caused by the combination of two bugs:

- something prevents the dra7-pcie driver from probing the
  device correctly, ultimately failing with the "failed to
  request irq" message.

- The error handling in dra7xx_pcie_probe() fails to clean
  up after the first problem, leaving the PCIe host
  in a broken state instead of removing it entirely.

       Arnd
