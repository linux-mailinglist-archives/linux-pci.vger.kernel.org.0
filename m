Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA066D5D7F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 12:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjDDKa1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 06:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjDDKa0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 06:30:26 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50351731
        for <linux-pci@vger.kernel.org>; Tue,  4 Apr 2023 03:30:25 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id i10so27968367vss.5
        for <linux-pci@vger.kernel.org>; Tue, 04 Apr 2023 03:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1680604224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib3Cz1MXE3cn0nTFcpYl1DYJE0Cyckteyn2THqatch8=;
        b=DWiMxRUi04G9zSmuXtNTZytHjXXs+Ip2/1oPTCGyafYPdo8nv0FQe+mfC4fT5mcO4M
         cyx5/dt4Sz3ThG2sz7bt5qIi2rupHm+3UTmndOIy7GUYCaMtQQm6Tdz1eH27k1+07kqC
         XafFsFWYlLXSJXgIj4cSyK7zuacPl3xxLwmh0osBL+lPNSELohaQqta5QINJmb4fS98c
         5yeG4ax9auteMyzC3Fa2UlmLtzNqwIAgXx6ziqznYIw+Q8ye+EDl9ZN0/r0+r27pcgpN
         YDk4cyU9SIB31RIKcBWlE6DPXkWGze7D641GGMz6CCOBpcTFhlzdI36m/z69Cdcjt1Hr
         dEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680604224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ib3Cz1MXE3cn0nTFcpYl1DYJE0Cyckteyn2THqatch8=;
        b=loSg1HB0Vamv30hYO07IG58PXW51xovrwGknVGPQlBd4injQcP8h2sxyB/hVwPYR/Q
         E0drbRGYKOkYpg9YrWIVzTTxvEvHNkPNL4tf2U/j5lnX6UQBlMQK6qgjLf9aWYcjD8S9
         oRYn8iky0VTFBurX74kjzscdRXBeiR+SrGrKH6K1o6E3Judqcc87nr3Wq3xMbacUeink
         O+Ij9UTY27DifvqGOiY+OssF2FX3rMevHp+R6SysgHVGZQKn4V+q4XE9kmb4tPefXJ9d
         zvEVDee0f4wmn6Lo9bnpplgoEg1mWAaFtpX37x5jvogUerk8Jrb0mbGMh/8iBIvNEo5l
         JI3Q==
X-Gm-Message-State: AAQBX9ce4yMFfU40R3G806fCHDbADUzv7NeCLFvelnhSl3F+BV/8sbM1
        Gtpj+0dLiTNHFQc4octpdmFT4rkFO/zTSWwiUnwtNw==
X-Google-Smtp-Source: AKy350bWYwOh202y5f32oW0VP+BE3vDu/6P0hBtsY5ib04k4DhK3YuwlOoocoACWE+mk1ya1FRAtMjOVg2SkSiRtTn0=
X-Received: by 2002:a67:d286:0:b0:426:da10:2408 with SMTP id
 z6-20020a67d286000000b00426da102408mr1939052vsi.5.1680604224738; Tue, 04 Apr
 2023 03:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230330085357.2653599-1-damien.lemoal@opensource.wdc.com>
 <20230330085357.2653599-5-damien.lemoal@opensource.wdc.com>
 <9a70d819-70d1-fb69-b053-a37ccfacf145@igel.co.jp> <a54f004c-31ce-b553-616b-d13fa76d709c@fastmail.com>
In-Reply-To: <a54f004c-31ce-b553-616b-d13fa76d709c@fastmail.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 4 Apr 2023 19:30:13 +0900
Message-ID: <CANXvt5qJBY7v6HHCtDoa-qR3O6XYYrNABcRA2URtDODkmD7Xbg@mail.gmail.com>
Subject: Re: [PATCH v4 04/17] PCI: epf-test: Fix DMA transfer completion detection
To:     Damien Le Moal <dlemoal@fastmail.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

2023=E5=B9=B44=E6=9C=884=E6=97=A5(=E7=81=AB) 19:17 Damien Le Moal <dlemoal@=
fastmail.com>:
>
> On 4/4/23 18:47, Shunsuke Mie wrote:
> >> @@ -120,7 +129,6 @@ static int pci_epf_test_data_transfer(struct pci_e=
pf_test *epf_test,
> >>      struct dma_async_tx_descriptor *tx;
> >>      struct dma_slave_config sconf =3D {};
> >>      struct device *dev =3D &epf->dev;
> >> -    dma_cookie_t cookie;
> >>      int ret;
> >>
> >>      if (IS_ERR_OR_NULL(chan)) {
> >> @@ -152,25 +160,33 @@ static int pci_epf_test_data_transfer(struct pci=
_epf_test *epf_test,
> >>      }
> >>
> >>      reinit_completion(&epf_test->transfer_complete);
> >> +    epf_test->transfer_chan =3D chan;
> >>      tx->callback =3D pci_epf_test_dma_callback;
> >>      tx->callback_param =3D epf_test;
> >> -    cookie =3D tx->tx_submit(tx);
> >> +    epf_test->transfer_cookie =3D tx->tx_submit(tx);
> >
> > How about changing the code to use dmaengine_submit() API instead of
> > calling a raw function pointer?
>
> This is done in patch 5 of the series.
Sorry, I missed it.
>
