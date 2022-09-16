Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ACD5BA50F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 05:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIPDNP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Sep 2022 23:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIPDNO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Sep 2022 23:13:14 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0290E2F3BA
        for <linux-pci@vger.kernel.org>; Thu, 15 Sep 2022 20:13:13 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a2so9439416lfb.6
        for <linux-pci@vger.kernel.org>; Thu, 15 Sep 2022 20:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=pCNbDOXv4cSAARuwg3WhKbwe2uD81YNGaP9zXa8XOR8=;
        b=JKbHuhxA9NeFuoyrTD7av412zgd8fGxndzKlLW1u+2T+7WC8+PoqRJGSNsaVzwBBJd
         +wjaR3keyr3+YfC6QJvi7f8vKpMf9unSE/4P10eRc8qrDxLsA97p7HnBCzdOkSFc9wqP
         RSkktAO1FBuCeR2N/Sz2sxKZSWhW494SVnJHLRdHxS5RLZVGRuakC0NQWxHaFppcURvw
         11CHpCjCiuX51nKvUlda8FxRvDH5mJ7C9Al50whYCRKTOul5q7BB9fesgorTbZZClEYr
         BlJyRsEMMKpwCsTxiejLcqohtE/D1q4r8kH2a3oZ2kvJWgSnGGfeRPMkLz8wDH9Go3Zg
         D7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pCNbDOXv4cSAARuwg3WhKbwe2uD81YNGaP9zXa8XOR8=;
        b=hW4GH1bAWRHvC2xCMrYKBLnBF5LY8JZqegd1uhgwJwdq5QvIoBGyNkhFo2NDG91oQS
         ZG6iVn2/mXovCOfr+ImWRNuBUqw7NmppBX9Dr9F0cnYXC8bVKnkvrMe8f3LgUvRXhpgL
         M+ciWh2ep22tK5eEt3JnwsmDOS+fcGa8Dgejm9ibuH9oQ3aVL3WC1d8yIB4BWkF1f8VP
         oLGUpXpI7GC+Sp+1CWCYuy/olcV6c8u/EavcMzGqf6wjAHxO/N0LCi8Eww0zl+Jv+n6y
         5Z3YEiBgJmdw+yhtWTQiSyucMZcQvQ73v9qEpTKWYI1zqI6jNUfTS3X9fcp/q35bLiO1
         m+TA==
X-Gm-Message-State: ACrzQf2uQvneGrsG0DUrR1+g/HCj74em5ZTgpsBt2kwrbH7nBTGG+cQk
        XdjaXNFo3DVQHjcfQkTrkLIwe85AyT7dgRb6vusleg==
X-Google-Smtp-Source: AMsMyM5Hn6/ihaf0KUFiJNmziY5VtNGUTNPExlkU8W71tPXXeaoHrA1ehqJB4j+5ZAJajCvTM3CjQLrfh4eH3d4ptjM=
X-Received: by 2002:ac2:454a:0:b0:49c:6212:c44d with SMTP id
 j10-20020ac2454a000000b0049c6212c44dmr1036484lfm.430.1663297991313; Thu, 15
 Sep 2022 20:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220815025006.48167-1-mie@igel.co.jp> <20220815184142.GA1960338@bhelgaas>
In-Reply-To: <20220815184142.GA1960338@bhelgaas>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Fri, 16 Sep 2022 12:13:00 +0900
Message-ID: <CANXvt5pYHDx=eneaRxZ0K=psQXsaLyp5dGA7OgoKYJaJ543mqQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: fix Kconfig indent style
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Mason <jdmason@kudzu.us>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

2022=E5=B9=B48=E6=9C=8816=E6=97=A5(=E7=81=AB) 3:41 Bjorn Helgaas <helgaas@k=
ernel.org>:
>
> On Mon, Aug 15, 2022 at 11:50:06AM +0900, Shunsuke Mie wrote:
> > Change to follow the Kconfig style guide. This patch fixes to use tab
> > rather than space to indent, while help text is indented an additional
> > two spaces.
> >
> > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC an=
d EP")
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>
> Thanks for doing this.  In the future make the subject line match the
> history, e.g.,
>
>   $ git log --oneline drivers/pci/endpoint/functions/Kconfig
>   556a2c7dca33 ("PCI: endpoint: Fix Kconfig dependency")
>   e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
>   8b821cf76150 ("PCI: endpoint: Add EP function driver to provide NTB fun=
ctionality")
>   98dbf5af4fdd ("PCI: endpoint: Select CRC32 to fix test build error")
>   349e7a85b25f ("PCI: endpoint: functions: Add an EP function to test PCI=
")
>
> Note that these are all capitalized ("Fix Kconfig indent style").
>
> Lorenzo will likely fix this up when applying, so no need to repost
> for this.
This is a gentle ping.
>
> > ---
> >  drivers/pci/endpoint/functions/Kconfig | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpo=
int/functions/Kconfig
> > index 295a033ee9a2..9fd560886871 100644
> > --- a/drivers/pci/endpoint/functions/Kconfig
> > +++ b/drivers/pci/endpoint/functions/Kconfig
> > @@ -27,13 +27,13 @@ config PCI_EPF_NTB
> >         If in doubt, say "N" to disable Endpoint NTB driver.
> >
> >  config PCI_EPF_VNTB
> > -        tristate "PCI Endpoint NTB driver"
> > -        depends on PCI_ENDPOINT
> > -        depends on NTB
> > -        select CONFIGFS_FS
> > -        help
> > -          Select this configuration option to enable the Non-Transpare=
nt
> > -          Bridge (NTB) driver for PCIe Endpoint. NTB driver implements=
 NTB
> > -          between PCI Root Port and PCIe Endpoint.
> > +     tristate "PCI Endpoint NTB driver"
> > +     depends on PCI_ENDPOINT
> > +     depends on NTB
> > +     select CONFIGFS_FS
> > +     help
> > +       Select this configuration option to enable the Non-Transparent
> > +       Bridge (NTB) driver for PCIe Endpoint. NTB driver implements NT=
B
> > +       between PCI Root Port and PCIe Endpoint.
> >
> > -          If in doubt, say "N" to disable Endpoint NTB driver.
> > +       If in doubt, say "N" to disable Endpoint NTB driver.
> > --
> > 2.17.1
> >
thanks,
Shunsuke
