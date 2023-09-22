Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7157AA773
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 05:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjIVDwe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 23:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVDwe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 23:52:34 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D34F7
        for <linux-pci@vger.kernel.org>; Thu, 21 Sep 2023 20:52:28 -0700 (PDT)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3A7194218A
        for <linux-pci@vger.kernel.org>; Fri, 22 Sep 2023 03:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695354746;
        bh=mT04NwsI/LP9gH9sSJ3bgyS+O0vwJDt7HugJlvm8r/c=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=X7XYAkyCmcYyOc0WwZzf+hTBtH5/3p/RgLkhbqZYTJWIoqMes70pwGBoM5GR6xlrl
         VNchjz6u1DnjTLRccyhDZWQ6e738SZvuSuT7xmRAi4rKmlVgiaVOGnQheF2SQJMbOc
         KpN0Y6OeWKE0iPjJWQ0JO59SjnWM3O0uGWAcZHQFmiQzmLzLMNGB4cmQO9pEIvJCdB
         AeFkJRnFaDQFck0SHnxcSxQ9Te8Qn7Abq5i0+yoYHBMBCwuBqKtvitoRX8ozzBWrlK
         gSS1iXSKyt6FfA5VvCB2DbRoaxtb3s+2pSVbO7sErBP6cwqeeuOArPP2ximp7BgTk2
         yS/X+7Afhl98A==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-274a1d7c6d9so1242679a91.0
        for <linux-pci@vger.kernel.org>; Thu, 21 Sep 2023 20:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695354744; x=1695959544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mT04NwsI/LP9gH9sSJ3bgyS+O0vwJDt7HugJlvm8r/c=;
        b=TBxGI71CqQNEnya4y7SqzDaxwuaqQ0dx4zyonyb9MvWVa3oNsnN8Umx6ZCZdY+ui7x
         CFdQRZVqtuKbqH60unXyfX+JlCff4MmYs3X70qgkn8EZcfDdTpQqdaN8MGffEUSRQjF0
         QjR1kooJM+3wF8H3kbVuO3/pFnxKr2YrCq7sXZbyMTSQFuVKf7sD6X5fol+dOPeApVva
         SY4vXaWIC2KX80hxlkvvaq+ODO/mnP/5hrWDT1sBuYbvI+3SjCCpwsWoHCbtaRGmMbN2
         H8ueivNqqsG24xczD/4CVIZZtQM2m70tNaw7N6cUdoPaxZrhYSV8PrvrBf/FvYTJFvpK
         TRiw==
X-Gm-Message-State: AOJu0YzeOFMo/DrHapWjbUgagTjv0IivigOhVPAuL+zRIufkbTx4OnaM
        j4AB6rD/FoZmBJ5e1TUGR+EzuRD9y31ZljZRPjqjqeRN2pj2Z2DgX+RGG61Xp7qK0vGbfFlxymt
        eYqXqTtdY9xa2RD1HO5l8XyCoK7kqxP0GKNpiZSAohVwvOEWU4V7InA==
X-Received: by 2002:a17:90b:2317:b0:274:ea5b:460d with SMTP id mt23-20020a17090b231700b00274ea5b460dmr7226758pjb.41.1695354744348;
        Thu, 21 Sep 2023 20:52:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFImBaDDUKFRmF3DeMGioChz7q/GOlKI5kLcTAqPI15W/yje33Tp4K2NiiWzotJ5bkv0JHCS+nyO1bgqhUk2EE=
X-Received: by 2002:a17:90b:2317:b0:274:ea5b:460d with SMTP id
 mt23-20020a17090b231700b00274ea5b460dmr7226741pjb.41.1695354743990; Thu, 21
 Sep 2023 20:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230911073352.3472918-1-mika.westerberg@linux.intel.com>
 <fd414b6e-ebe0-9a2b-b9b0-e0131197b434@linux.intel.com> <20230918120916.GS1599918@black.fi.intel.com>
 <28b140a3-8fe9-373d-d66f-20ab104230cc@linux.intel.com> <20230918122252.GT1599918@black.fi.intel.com>
In-Reply-To: <20230918122252.GT1599918@black.fi.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 22 Sep 2023 11:52:11 +0800
Message-ID: <CAAd53p4_3V1xeH0fRNtf17f2_rxG21ZWhNBaW7+vLSy=uhrSqg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/ASPM: Add back L1 PM Substate save and restore
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>,
        Koba Ko <koba.ko@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        linux-pci@vger.kernel.org,
        =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Cc Ricky]

On Mon, Sep 18, 2023 at 8:23=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Ilpo,
>
> On Mon, Sep 18, 2023 at 03:17:41PM +0300, Ilpo J=C3=A4rvinen wrote:
> > > > > +        */
> > > > > +       val =3D cap[1] & PCI_EXP_LNKCTL_ASPMC;
> >
> > Given this line, it just felt pretty obvious because why would the code
> > & PCI_EXP_LNKCTL_* with some random register (value) that isn't LNKCTL =
:-).
>
> That's a fair point :) Okay I can drop the comment in the next version.

We are seeing Realtek cardreader 5261 stops working after S3 resume,
and this patch can fix the issue.

So please collect my tag:
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
