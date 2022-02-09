Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E604AED3F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 09:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbiBIIxN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 03:53:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbiBIIxI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 03:53:08 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637D6C001F74;
        Wed,  9 Feb 2022 00:53:04 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id v186so4015881ybg.1;
        Wed, 09 Feb 2022 00:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MDqRZpl2ZNEFfuQ7yfffHKzYxQqjEhCxkRDN1Sj78Ps=;
        b=cbvyMiumfUXld/I/wxT1ueBd+qe8ToUeMv+ZNjiz7lR7v45FcEsPwEffVyuIq0tT82
         PO6gTRk+UUrwcDPOCiOQhELlf1CnTZCFML/ogntfu//Gj1rn1Hw8xbZBBZhawqz4lRe0
         fPEysu5H9/OMFsXJKwv532eD3Uorplm+HlN6ZkMInTqFv4N/oWjXR00xkrQlz755VqnQ
         +9RwPvWz/ZE4p6iRjyGaHBGHNrvOHPePG4LjAMBboBIkdfYOujRcAJJvZzAwZCPQQk8h
         sOCD0qAzLgG9OL4GxQFtmEsV0D53zPkAt9zuig+6maCHTtG1S5YcQDydcvzuigrdT8A4
         uI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MDqRZpl2ZNEFfuQ7yfffHKzYxQqjEhCxkRDN1Sj78Ps=;
        b=762+I3SVgnRA1ziX0Qehppenf6aypn6bAuM+b2ivqHrsW/b1tX9yQ3jhsYk8HuIxQ0
         iIwtyCruJ5yM0kavIPqUxW4J8zqEfc43ZpkCLFh+JAWcVg3Endidy030Qb4m17cUiUze
         5MlmUdnf3+v9mh8n9tsQnDB5P3nZXNNLy0Tb0wdVbYeRz9hekzMS1KZ6Sa0O/GUf1xeJ
         X4pd2v4YbF/qC7kYxW6JPxvBFK36knfUqf3FCajXJYNDKRUovuOSe5NG4rdulm94dTKZ
         vyUT1XvY/U0Oi94ehMszEmiHgqZLg+uC/0omtihR7u07uNO+dWbOWNi0Ime9q9be+vHI
         SFgQ==
X-Gm-Message-State: AOAM533A5ACSn616GZtEDHSGmP3OtFV3tpRNEhChXsD6asyT6NSh3rzC
        eaEdTNhnvBxe8XjjbsneiQgDo2FOIMXsAKTd1G0=
X-Google-Smtp-Source: ABdhPJwTGByfa1hFDqkwYNeN4BOxA4JwlpvSmwyJQEuJ0ZwibgZOGsyGmRE+oHqgcMNxRgJbh40DHCBik+tp6+3Rk9s=
X-Received: by 2002:a81:fd3:: with SMTP id 202mr1099770ywp.78.1644396779698;
 Wed, 09 Feb 2022 00:52:59 -0800 (PST)
MIME-Version: 1.0
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <PH7PR19MB5562AC3C5E7BBB7730086CC1A02E9@PH7PR19MB5562.namprd19.prod.outlook.com>
In-Reply-To: <PH7PR19MB5562AC3C5E7BBB7730086CC1A02E9@PH7PR19MB5562.namprd19.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 9 Feb 2022 08:52:33 +0000
Message-ID: <CA+V-a8tEwOR-r=+KDe2DhpTMwhXPTgbZYgOWepST3mnhBL_Hag@mail.gmail.com>
Subject: Re: [EXT] [RFC PATCH 0/5] PCIe EPF support for internal DMAC handling
 and driver update for R-Car PCIe EP to support DMAC
To:     Li Chen <lchen@ambarella.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Chen-san,

On Wed, Feb 9, 2022 at 4:48 AM Li Chen <lchen@ambarella.com> wrote:
>
> Hi Prabhakar,
>
> > [0] https://urldefense.com/v3/__https://www.spinics.net/lists/linux-
> > pci/msg92385.html__;!!PeEy7nZLVv0!yP0WqYs165riCjWRhZprjgMVVLfQLtkkPfv_
> > R7XCoqkqgMsOyor90EZp0YAdxu0$
>
> Can your streaming DMA test case(-d) pass if you use EP's internal DMAC i=
nstead of external DMAC?
>
Sorry I don't quite get you here.

This patch series adds support for EP to transfer using internal DMAC
as no external DMAC is supported, so when "-d" option is passed and if
EP has registered it has internal dmac it will use the same and run
the pcitest.

Cheers,
Prabhakar

> Regards,
> Li
>
> **********************************************************************
> This email and attachments contain Ambarella Proprietary and/or Confident=
ial Information and is intended solely for the use of the individual(s) to =
whom it is addressed. Any unauthorized review, use, disclosure, distribute,=
 copy, or print is prohibited. If you are not an intended recipient, please=
 contact the sender by reply email and destroy all copies of the original m=
essage. Thank you.
