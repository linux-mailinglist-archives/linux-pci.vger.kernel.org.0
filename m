Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF6D6312D8
	for <lists+linux-pci@lfdr.de>; Sun, 20 Nov 2022 08:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKTHiF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Nov 2022 02:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTHiE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2022 02:38:04 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903738FB3D
        for <linux-pci@vger.kernel.org>; Sat, 19 Nov 2022 23:38:03 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-14286d5ebc3so7327294fac.3
        for <linux-pci@vger.kernel.org>; Sat, 19 Nov 2022 23:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b+3JsFRo8ohaqU1e2ftdI7ZpHTBJErIV+tpoKu8gwDs=;
        b=hcAJhQkrZz3KBes6UB9GGrwyBjAGxk/sDGfCN8j2Ru1Uz6rrWZY0pMhIibV/r4HHT8
         upo5GdzrGz0MZLeTS923qgGqvV7AvrtPYm52oLrkwTIvWT4sKNWemScWBmhvl8gg9gIO
         ihUqUQmxts4ze/Wcr6VMZgvsc+owkeHAmzbRNZDd+LVU5mzajeCY83rU/odY0x/RfhiY
         TfKDKmmLFUJac2py5rhTiCWLpSIhA07WUjUdbW7aO86NG9KpPtt1sDFUt7KOLo+/e98d
         vzN6hzlcjeLBIA+SFq8qbt/kF2UT6+/xH3HAlQ2EbnIuDjJf/zNk4ZKIzb08uHIZFEoX
         Lfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+3JsFRo8ohaqU1e2ftdI7ZpHTBJErIV+tpoKu8gwDs=;
        b=E38niKXBYlkscugQaib5A1Ym37R0ugma+uvnYIZORW+dm01xcuKdiHjC5f38Q81WUc
         ZcoVBKYT4Vze2R2gTk5W1S3f4sBdob+ZK1VffIo7MpwoEvn4INy2lzPAsMZVgCdWSz03
         MwOfy9gtMivamQ+9MseLFxvXon8nId6mhCuLhcqDr5N6Hd4q0Yv2RRCQZRFP9rNPh2kR
         bXmJK3Vj5EkuSekuhe9Dk0pvQ2Lvh3iiemGmoCK2hXOBNajZBIhMNOK4mZRguFK6VppF
         bsTBtOfCFwQN3QQ0Oi+k80WqAsEo2wc3jLU0T5vFNC4EetgZ+B310fLQhSsf6h4I4+0q
         AT8w==
X-Gm-Message-State: ANoB5pkPs20c1xrD0PSvEiiYacAHw9cnOEbbXfWx3ozZZdk13DUlKqbZ
        OeDYoZijtZZQ2uQ9oTd0Bo5HryJaQpAEx9b0pGg=
X-Google-Smtp-Source: AA0mqf5r4IbTqf+Fh0BHckwZeBZUTvmRVAqoJeRA1Quznr1UAY/yGzRM0bhSJoNt6navPiW+rieL+R+ZJw3OdVwBYMQ=
X-Received: by 2002:a05:6870:e983:b0:141:f267:1bd0 with SMTP id
 r3-20020a056870e98300b00141f2671bd0mr7539401oao.144.1668929882876; Sat, 19
 Nov 2022 23:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20221119110837.2419466-1-sergio.paracuellos@gmail.com> <20221119180322.GA1366676@bhelgaas>
In-Reply-To: <20221119180322.GA1366676@bhelgaas>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sun, 20 Nov 2022 08:37:50 +0100
Message-ID: <CAMhs-H-i1arxS4daudfG8AGuFyxmJuNe6CY4A+Pi+u8RNUM65A@mail.gmail.com>
Subject: Re: [PATCH] PCI: mt7621: increase PERST_DELAY_MS
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, kw@linux.com, robh@kernel.org,
        lpieralisi@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Sat, Nov 19, 2022 at 7:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Hi Sergio,
>
> s/increase/Increase/ in subject, to match history.

I missed that, sorry.

>
> On Sat, Nov 19, 2022 at 12:08:37PM +0100, Sergio Paracuellos wrote:
> > Some devices using this SoC and PCI's like ZBT WE1326 and Netgear R6220 need
> > more time to get the PCI ports properly working after reset. Hence, increase
> > PERST_DELAY_MS definition used for this purpose from 100 ms to 500 ms to get
> > into confiable boots and working PCI for these devices.
>
> confiable?

It seems my spanish confused my mind here :). I meant trustable.

>
> It looks like we sleep for PERST_DELAY_MS twice during probe:
>
>   mt7621_pcie_probe
>     mt7621_pcie_init_ports
>       mt7621_pcie_reset_assert
>         list_for_each_entry(port, &pcie->ports, list)
>           mt7621_control_assert
>           mt7621_rst_gpio_pcie_assert
>         msleep(PERST_DELAY_MS)                      #1
>       mt7621_pcie_reset_rc_deassert
>         list_for_each_entry(port, &pcie->ports, list)
>           mt7621_control_deassert
>
>       mt7621_pcie_reset_ep_deassert
>         list_for_each_entry(port, &pcie->ports, list)
>           mt7621_rst_gpio_pcie_deassert
>         msleep(PERST_DELAY_MS)                      #2
>
> so this increases the minimum probe time from 200 ms to 1000 ms.  It
> looks like these delays have different purposes and might not need to
> be the same.
>
> I assume mt7621_pcie_reset_assert() asserts PERST#, and the sleep #1
> is enforcing T_PVPERL, i.e., the minimum time between power becoming
> stable and PERST# being inactive, which PCIe CEM r2.0, sec 2.6.2, says
> is at least 100 ms.  We probably don't know how long it takes for
> power to become stable, and the previous PERST_DELAY_MS of 100 ms
> didn't include any time for that, so it makes sense to me to increase
> it.
>
> But what about sleep #2?  That happens *after* PERST# is deasserted,
> so it seems like that must be for a different purpose, and if so,
> deserves its own separate #define.  PCIe r6.0, sec 6.6.1 specifies a
> minimum 100 ms after exiting Conventional Reset before sending config
> requests.  Is that what this delay is for?  If so, maybe it doesn't
> need to be increased?  Or maybe not as much?

Sure, let me review this part a bit and come back to you with a proper
patch for fixing the issue and taking into account your comments. I
don't have the devices that are having this issue and I need a bit of
testing before submitting anything to be sure the fix is correct.

Thanks a lot for your comments.

Best regards,
    Sergio Paracuellos

>
> Bjorn
>
> > Fixes: 475fe234bdfd ("staging: mt7621-pci: change value for 'PERST_DELAY_MS'")
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-mt7621.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> > index 4bd1abf26008..438889045fa6 100644
> > --- a/drivers/pci/controller/pcie-mt7621.c
> > +++ b/drivers/pci/controller/pcie-mt7621.c
> > @@ -60,7 +60,7 @@
> >  #define PCIE_PORT_LINKUP             BIT(0)
> >  #define PCIE_PORT_CNT                        3
> >
> > -#define PERST_DELAY_MS                       100
> > +#define PERST_DELAY_MS                       500
> >
> >  /**
> >   * struct mt7621_pcie_port - PCIe port information
> > --
> > 2.25.1
> >
