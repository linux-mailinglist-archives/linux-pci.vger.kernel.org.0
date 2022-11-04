Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D380F61A2BD
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 21:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKDUyc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 16:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiKDUy2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 16:54:28 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F37B87F;
        Fri,  4 Nov 2022 13:54:25 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 42D235C0095;
        Fri,  4 Nov 2022 16:54:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 04 Nov 2022 16:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667595263; x=1667681663; bh=nAQClq+Tqo
        FF3Rk/ZtLA/p66I0V8hKd6yC+jF0Tb33s=; b=af6z3E0mbmtQVVMtkFIzKx7rPt
        GVLtogtKli44vd3zwqQfUOQeGSVuyDz8lAovefVea8hoxCjcvbV4p0JjPo+mQ7yH
        4arvpQWAaLkSyOXGGz/X3YDiYsR7TSaQUeBqolqUO4Q2xPaX/bZbubDerHeFRuDo
        yPmagKKLn3PlHBog8hmvjVbi4G9p0jXPVZ5IEGH+utcZr0UQa/4TozZuNuDyGQUA
        66sUhFWpVC798dIlTxLSD56UuKz3G04b0w7YJHDm0wQloH2MF9O1E5PGBtYVrhz6
        +eOm1AsT19HbSdM4IC50kNIxklfZoyRfnhjzR7MMAvZ6lvhnqU1YJ5KU7crA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1667595263; x=1667681663; bh=nAQClq+TqoFF3Rk/ZtLA/p66I0V8hKd6yC+
        jF0Tb33s=; b=CuX9+0x5RHGqdqT1Go3gEQFA3csMghXXP8cvTsY8JQmnO+p2aqz
        NOmH4ZzWVQWPXE0eB0fsnppFOCuti/7ytYHc00sQzT3kjfuikFznPzi3/wbXGKMC
        RzJIKittMSj06LpOOERfmzPByLwlMmoivq4CXMy+LsfuyVQ0v1uV9FXjZ6IuBl3K
        tdSlSiqOfretSHFWo3QNBQxir3FuhmHEAIN1tAGFehBg6ovh82YGIHFBeS6TZENv
        KpOHAIsQm61VrDwS1j7YJbgGR59Bqicg5kaeduGkpHQqm2H6WS+VYqCo9AjGJvyt
        OdWKkRhPMqSN97I+3DjZ9ogzAVIUQgpZmMw==
X-ME-Sender: <xms:_ntlY2vmW-e9TIrY4GKDanVcZby5C1izsJFsFE8oDkSCHkTMl-3bHQ>
    <xme:_ntlY7dZv496YUbR55kyAoVa1kcaLg_O9UYqdz41FNQq3BQI7KXRbQ1w8fOcs2EL5
    n1dUxZAuB3JAvtU_w>
X-ME-Received: <xmr:_ntlYxz1J31TlAerJlQDAdarFm4d2KXx3eABuWDNnP0kEwtHcoDhDvLr8J_sRAgXWROtCDZSw-_XXeV78cfnAwe6XfUXXmB97KtybXST5MnT2-omRvSktEMAGvY3zIHf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddugddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhohhhnucfv
    hhhomhhsohhnuceoghhithesjhhohhhnthhhohhmshhonhdrfhgrshhtmhgrihhlrdgtoh
    hmrdgruheqnecuggftrfgrthhtvghrnhepfedvkeevgefgkeeghedvleetieffhefgiefh
    lefgvdekfedvteekueeuveelheevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsehj
    ohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtghomhdrrghu
X-ME-Proxy: <xmx:_3tlYxPx7bKjZ8PaeL5IMg6MqSJ3kZMqbdFnULTxCGjJs3m7yyruWQ>
    <xmx:_3tlY297rungBX7x8uhVX9smJahAzhM3bhENgyepHYvpiWMaBZfUcw>
    <xmx:_3tlY5Xkas8LL1gCor1_PZBDoMimdGG5UDYnFgFowPUF238EWKoCJA>
    <xmx:_3tlY33H9tBHty31XDkYRCIXzlWmV9P5qxKucc8n0mgD99a_Wbu1KQ>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Nov 2022 16:54:19 -0400 (EDT)
From:   John Thomson <git@johnthomson.fastmail.com.au>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mt7621 pci & phy-pci fix future oops from soc_device_match_attr
Date:   Sat,  5 Nov 2022 06:52:40 +1000
Message-Id: <20221104205242.3440388-1-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A change in the mm/slub code identified that the arch/mips/ralink/mt7621.c
soc_dev_init function attempted to kzalloc too early.
https://lore.kernel.org/linux-mm/becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com/
RFC fix: https://lore.kernel.org/lkml/20221103050538.1930758-1-git@johnthomson.fastmail.com.au/

Fixing that mips mt7621 issue exposes an oops in testing the quirk table.
I think we do want these changes committed before the mt7621
kzalloc too early fix, otherwise I introduce oops.

Checkpatch warns on the pci Fixes tag, and suggests
my change for the Fixes tag.

I am not sure if we want these backported to stable trees?
Then, if I need separate patches for the staging drivers in 5.10 pci-phy
and 5.15 pci?


Oops example after the mt7621 kzalloc too early fix atop v6.1-rc2
From Sergio Paracuellos in
https://lore.kernel.org/lkml/CAMhs-H-Eo0ELMpy0iPakTA-3nHdY_mYQG-rrqgSotBKKED=eOg@mail.gmail.com/
[   20.569959] CPU 0 Unable to handle kernel paging request at virtual
address 675f6b6c, epc == 80403dec, ra == 804ae11c
[   20.591060] Oops[#1]:
[   20.595462] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc1+ #148
[   20.608265] $ 0   : 00000000 00000001 82262a00 00000000
[   20.618615] $ 4   : 675f6b6c 808dea04 00000000 804ae138
[   20.628983] $ 8   : 00000000 808787ba 00000000 821f4b00
[   20.639351] $12   : 0000005b 0000005d 0000002d 0000005c
[   20.649735] $16   : 82253580 807b4034 807b4034 804ae138
[   20.660087] $20   : fffffff4 82c382b8 809e1094 00000008
[   20.670455] $24   : 0000002a 0000003f
[   20.680823] $28   : 82050000 82051c30 80a0d638 804ae11c
[   20.691190] Hi    : 00000037
[   20.696891] Lo    : 5c28f6a0
[   20.702610] epc   : 80403dec glob_match+0x1c/0x240
[   20.712100] ra    : 804ae11c soc_device_match_attr+0xac/0xc8
[   20.723330] Status: 11000403 KERNEL EXL IE
[   20.731626] Cause : 40800008 (ExcCode 02)
[   20.739576] BadVA : 675f6b6c
[   20.745277] PrId  : 0001992f (MIPS 1004Kc)
[   20.753414] Modules linked in:
[   20.759448] Process swapper/0 (pid: 1, threadinfo=(ptrval),
task=(ptrval), tls=00000000)
[   20.775520] Stack : fffffff4 80496ab8 820c6010 828c8518 80950000
ffffffea 80950000 80496b48
[   20.792106]         00000000 828c8400 820c6010 821f4880 1e160000
821bc754 82253734 7f8268e6
[   20.808707]         809c6a94 807b4034 804ae138 809c8e88 819a0000
804ae1d8 80a0d638 80438e10
[   20.825282]         821f3e70 80950000 808c0000 828c8400 820c6000
828c8548 820c6010 80456608
[   20.841879]         821f3dc0 821d32c0 819a0000 801d8768 821f3dc0
821d32c0 828c8540 80950000
[   20.858473]         ...
[   20.863298] Call Trace:
[   20.868137] [<80403dec>] glob_match+0x1c/0x240
[   20.876955] [<804ae11c>] soc_device_match_attr+0xac/0xc8
[   20.887500] [<80496b48>] bus_for_each_dev+0x7c/0xc0
[   20.897176] [<804ae1d8>] soc_device_match+0x98/0xc8
[   20.906869] [<80456608>] mt7621_pcie_probe+0x90/0x7b8
[   20.916876] [<8049b46c>] platform_probe+0x54/0x94
[   20.926206] [<80499058>] really_probe+0x200/0x434
[   20.935538] [<80499520>] driver_probe_device+0x44/0xd4
[   20.945732] [<80499ae0>] __driver_attach+0xb8/0x1b0
[   20.955428] [<80496b48>] bus_for_each_dev+0x7c/0xc0
[   20.965089] [<80497f18>] bus_add_driver+0x100/0x218
[   20.974763] [<8049a338>] driver_register+0xd0/0x118
[   20.984438] [<80001590>] do_one_initcall+0x8c/0x28c
[   20.994115] [<809e21c8>] kernel_init_freeable+0x254/0x28c
[   21.004845] [<80781070>] kernel_init+0x24/0x118
[   21.013830] [<800034f8>] ret_from_kernel_thread+0x14/0x1c
[   21.024522]
[   21.027457] Code: 240f005c  2418002a  2419003f <80820000> 24a90001
90a70000  104c006f  24860001  2843005c
[   21.046810]
[   21.049830] ---[ end trace 0000000000000000 ]---
[   21.058935] Kernel panic - not syncing: Fatal exception
[   21.069310] Rebooting in 1 seconds..


Cheers,

John


