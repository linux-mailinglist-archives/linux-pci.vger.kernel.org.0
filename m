Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC38542AE9
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 11:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiFHJK5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 05:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiFHJJl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 05:09:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500CFC1EC9
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 01:29:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so32051457lfg.7
        for <linux-pci@vger.kernel.org>; Wed, 08 Jun 2022 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1SyqLbCgyXNySsIeInygogACTwvtbHAghMfis7Fhfw8=;
        b=MkmQAJvYhqdjCbC1ly7iObXnqQ80RVKEIx09xfoH1jy8IKAMCpxv9M0ifSzzZ5mE20
         15xRnCsSbS3Qfnrfg601x/dhVHbpiFWD+H5gT1un0cK8iGjhz7+mE7MkN9G8pciD5pgC
         nLjYH4XwaPQ0Fg+RdTITcxFn59JAT6QQje3X57G8uSylP7KwWJs3eUpIFIsD6w+5VFVL
         /zsp38yZP/pRtPkTY0J+xVHfUTquEounjf7ISVsN1y0XPE1tUA0pG0G3NI6fdDOx35lk
         JqPU4rFduxi8eRe1Iv1e4VOGWTbDO8bOV7QRqdYMHQg9RWZCLvY/BANCgy6giAUJrKiS
         c5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1SyqLbCgyXNySsIeInygogACTwvtbHAghMfis7Fhfw8=;
        b=6lsgQGogGnXJjr7+BXPfEmFvWhx5RKubjYGoMH7mNKibwInxiNWXaB+e8/OB2WBmM2
         Jn9DCnxKYiBRUjtrtXLLazRaR87p+symKQNZCz1e7proXpbW3BPaHEqAOeyIo8U0dClF
         LnK+GRbRv5PkKkPyiKVpfJr/pmOmxgJmd2g2+udR3hV6atWlEQ0WMxfg7tPOZi5XeQwI
         E1pALGW/2zzJV6Iosi5jzbMhHp+xqUnhubd3K5JqTpOGmV6c/bDUX+SP/BLqX18Se7I1
         D3AGHJAJ6I9aIfjA+8alQi2ujDPIsq/zC8e6QQxkQ6tbwr6e10ReImSY1BLyGpbrRZsH
         c8Sw==
X-Gm-Message-State: AOAM531wWTb2ufD601GKuE5hhCYTwmIJcBMzumQv/yMRRhH2i7/RMeTp
        latmJEPN1Mz+h7xSnwcyUdQtMP5iraI/K4mGvGo=
X-Google-Smtp-Source: ABdhPJyuYtN/gSRp8xwuX+eqt9bgjW2m+IKvUrZrXaYi5Wm57qB78KPu7WYIKDc7/+65OSyDbs5OBEQAXfc7qJlGCCs=
X-Received: by 2002:a05:6512:e9c:b0:479:1fd9:1b94 with SMTP id
 bi28-20020a0565120e9c00b004791fd91b94mr13867584lfb.591.1654676988547; Wed, 08
 Jun 2022 01:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <f336dd51-a6f2-4168-9e4b-1a6dc3d7da6a@www.fastmail.com> <20220604000712.GA118018@bhelgaas>
In-Reply-To: <20220604000712.GA118018@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 8 Jun 2022 16:29:37 +0800
Message-ID: <CAAhV-H6TYqB8SE=RR9UdDUdw5z6m3buZT=0aGFj+fFoQmyvNqg@mail.gmail.com>
Subject: Re: [PATCH V13 4/6] PCI: loongson: Improve the MRRS quirk for LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn, Jiaxun,

On Sat, Jun 4, 2022 at 8:07 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jun 03, 2022 at 11:57:47PM +0100, Jiaxun Yang wrote:
> > =E5=9C=A82022=E5=B9=B46=E6=9C=882=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=
=E5=8D=885:20=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A.
> > >
> > > I'd really like to have a single implementation of whatever quirk
> > > works around this.  I don't think we should have multiple copies
> > > just because we assume some firmware takes care of part of this
> > > for us.
> > >
> > Yeah that was my idea when I was writing the present version of
> > workaround.  However in later LS7A revisions Loongson somehow raised
> > MRRS for several PCIe controllers on chip to 1024 and other ports
> > remains to be 256. Kernel have no way to aware of this change and we
> > can only rely on firmware to set proper value.
>
> That's fine; we need a controller-specific way to find the limit
> (whether it's fixed for all versions or discovered from firmware
> settings or whatever).
>
> My hope is that given that controller-specific value, we can have a
> single quirk that works on keystone, loongson, etc. to enforce the
> limit on all relevant devices.  Some platform firmware might do that
> configuration already, but it's OK if a generic quirk re-does it.
>
> I don't think it's worth having two quirks, one that does the
> configuration, and another that relies on firmware having done it.
I think it is better to let keystone and loongson to both use the
no_inc_mrrs quirk.

Huacai

>
> > I have no idea how Loongson achieved this in hardware. All those
> > PCIe controllers are attached under the same AXI bus should share
> > the same AXI to HyperTransport bridge as AXI slave behind a bus
> > matrix. Perhaps instead of fixing error handling of their AXI
> > protocol implementation they just increased the buffer size in AXI
> > bridge so it can accomplish larger requests at one time.
>
> > >> In keystone=E2=80=99s case it=E2=80=99s likely that their firmware w=
on=E2=80=99t do such thing, so
> > >> their workaround shouldn=E2=80=99t be removed.
> > >> And  no_inc_mrrs should be set for them to prevent device drivers mo=
difying
> > >> MRRS afterwards.
> > >
> > > I have the vague impression that this issue is related to an arm64 AX=
I
> > > bus property [2] or maybe a DesignWare controller property [3], so
> > > this might affect several PCIe controller drivers.
> >
> > In my understanding it=E2=80=99s likely to be a AXI implementation issu=
e.
>
> I know almost nothing about AXI, but this concerns me because it
> sounds like other drivers could be affected.
>
> Bjorn
