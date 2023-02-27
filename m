Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5506A3C09
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 09:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjB0IM1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 03:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0IM0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 03:12:26 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4CB19F2A
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2023 00:12:25 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y10so2977050pfi.8
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2023 00:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaJLUnQgW3YvM+831rK4y5nTUdoF7eZcnDJFmGI//oE=;
        b=Ngpm7nT9CLlDP9rE42QTdn2hVBMBSwbKJ/5U4B9su4IO7cFkAk3pwyqqwO1e9Vv/CF
         Dd5Fpx3q4gZe+Aedx3imAbYnK2Ii08MrMK/1GH3d34ZqOwLKXkzKTQZVo4+tHZfoY4VO
         WLJNLcB93TdiLrpJ2HQBolnxW6vquDdW63Ynz8QPRkFgWAGe/CfpOnOq3iG+ukf0e87T
         A1tzjoc6QxBZx3FOq+BY25lWzYh02AUtwhIrW8KwZAvewdR5950AlkK2fIZzIyDsRzp1
         3ncsvUaYGQhLNZ2p5WTZA9bHR/qKLhHqlyu/3e0uZYKlcJOjKEmxHEk3u3qCeadiF7kO
         TRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaJLUnQgW3YvM+831rK4y5nTUdoF7eZcnDJFmGI//oE=;
        b=s5T9xaFHdKyUg0e7YKZg90HkQVUptkSUQK5mUya/FIKygzcL8/d5h18vMPGVUj4dMc
         HSCBAhCIt9GltUvVaka+3ej5TmzIFgUguN3fK+7eJ++fZAfHBmyeFiSKbI0Znqbd2g2k
         q5adh+5sDZ9V54Sv9qm9xTut7pxNHXIctR9NbeDuYjexQXd/mcbdNI3zm6GuCr9yUGLt
         llK0TWRbRurwYBluoWEPNgMoCHclAYbbsPKBrH0gwKzyJ5p/naufIOewqpiYr6H+fbbA
         jmENLlpfVQZhU9u4IZ9WeUMkDINhcbIca96lkFlvFSR+Z5vBv3ZmIZfiyBCyPov+FfTe
         GLeQ==
X-Gm-Message-State: AO0yUKWB85nO/Rop90P8U4ioEukEQmFAJhEkW7Cx/tWEXaDfu8XnW8T2
        Pl2JwC6eNqp71wnxmBOfoXfyV5f13VG2uW+aPxJpbmBOfS6Erw==
X-Google-Smtp-Source: AK7set8EDBW9a4nZ/5oesxVYWIxejD62UIU84J6EB5Lf0Miu3NHHvMboaLuYQG0eqDXOAZPL+mw4UGRfkd4eBFDRw3Q=
X-Received: by 2002:a63:9dc9:0:b0:503:2535:44c3 with SMTP id
 i192-20020a639dc9000000b00503253544c3mr2128484pgd.4.1677485545278; Mon, 27
 Feb 2023 00:12:25 -0800 (PST)
MIME-Version: 1.0
References: <8e7978f65c6606fb2d48483435c78bd3@cutk.com> <756173E3-354E-4AC4-89D7-9096B62E344C.1@smtp-inbound1.duck.com>
In-Reply-To: <756173E3-354E-4AC4-89D7-9096B62E344C.1@smtp-inbound1.duck.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 27 Feb 2023 19:12:14 +1100
Message-ID: <CAOSf1CGoAVrzb7nrMgZ6tZP-Akx7DvGD5RBu9KjprP5r2DtQiA@mail.gmail.com>
Subject: Re: ASMedia ASM1812 PCIe switch causes system to freeze hard
To:     fk1xdcio@duck.com
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 26, 2023 at 6:20=E2=80=AFAM <fk1xdcio@duck.com> wrote:
>
> On 2023-02-25 13:28, Chris wrote:
> > I'm testing a generic 4-port PCIe x4 2.5Gbps Ethernet NIC. It uses an
> > ASM1812 for the PCI packet switch to four RTL8125BG network
> > controllers.
>
> Sorry, I forget my attachment with the PCI device information.

Looks like your mail client is breaking threads.

Anyway, the only thing of interest I can see in the log is that AER is
reporting correctable errors on three of your four NICs:

07:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125
2.5GbE Controller (rev 05)
Capabilities: [100 v2] Advanced Error Reporting
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
08:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125
2.5GbE Controller (rev 05)
Capabilities: [100 v2] Advanced Error Reporting
CESta: RxErr+ BadTLP- BadDLLP+ Rollover- Timeout+ AdvNonFatalErr-
09:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125
2.5GbE Controller (rev 05)
Capabilities: [100 v2] Advanced Error Reporting
CESta: RxErr+ BadTLP- BadDLLP+ Rollover- Timeout+ AdvNonFatalErr-
0a:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125
2.5GbE Controller (rev 05)
Capabilities: [100 v2] Advanced Error Reporting
CESta: RxErr+ BadTLP- BadDLLP+ Rollover- Timeout+ AdvNonFatalErr-

Bad Data Link Layer Packet errors suggest that specific card has
signal integrity issues. Assuming that's true, more traffic to the NIC
means more opportunities for uncorrectable errors which would explain
the hard lockups. I'm not sure why setting pci=3Dnommconf seems to fix
the problem, but my guess it's just masking the issue. The AER
capability is in the extended config space which requires the memory
mapped config space to access so disabling that probably just stops
the kernel from noticing that errors are occuring. The network stack
is pretty forgiving of errors since it can just drop packets which
might also explain the lower throughput too.
