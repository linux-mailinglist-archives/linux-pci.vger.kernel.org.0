Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01657E8511
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 22:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjKJVau (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 16:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKJVat (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 16:30:49 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4433422E
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 13:30:44 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso22504225ad.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 13:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1699651844; x=1700256644; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+CheBc7uM+XP2k8xBG8rMGey2PAXBnOwyRe0w6f/tI=;
        b=MfHgfH+DAWQNgqanf+nOqklHZplUI3BjeUhdfOo1mr4znN9lE5G7mFB1eG78N2XRqU
         V5UVAQi8Ug1+xr2VSpXWRraOfsNu39Dr9rRQ4aJ34RYAm7ffQMkpA9SIdWmsq5fMvPKs
         heyG8PZeDSJlKwU93SwS+GVKYMQhLDpgVI8ZFxmiptlDqnMlva3RIMfh4qd5G/TbAV4g
         n0cfO8EAbEWw0MBwU0P+lAknXg7N6V/6DT9stwqS4HHXpTYleSAXFWfZd5kYcKPjsN+z
         sDYrww/wPQfovJ9FLEULoxy+A2sRGEhZSwbmno0vk5p9o+PGKWBZeFgCNhqi45V9UZF0
         okeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699651844; x=1700256644;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+CheBc7uM+XP2k8xBG8rMGey2PAXBnOwyRe0w6f/tI=;
        b=OaLJruNCpysxVGUsQQAF3+UsRckxqx8wm6E4Cn1X6c0Zc4ap/nVvaePPFGKF2j7XkQ
         YnuvKBwpc9GeVFmkepmVVHhXl3ptv31SUBIfXWD6aIfS2+6oPXEbsdnhclORB+W+9S5A
         WkFjeC5/7Dg381DvLDQ1Cdj1SHD8AQ2egIQleOWE4K/0EKG/bZ6dip9ha9UGLHmrAlGT
         O2Rn2bfWA4hwvLcP/J94TV2QZ9xf26/PWBvDcXB9zikwHV4+H8cPFe4OGg+dzyOjmMcp
         h/tRZtQXfhrRvXB9w+l8D+Kp7RTdlMtkUHk1kspz0duabeMuXCXe1eVi9IwyG9DiyIK9
         KZNg==
X-Gm-Message-State: AOJu0YxIx0B/7qMQ5KGlR0O3LU4HbtR14RaPKIG3L8NTa2br4uxtJHQO
        Mx2DdF4BtcSe7qrIS14afJiduvaCnyVM9ZvoVsT1jQ==
X-Google-Smtp-Source: AGHT+IGpPCdnbfWruVLuQxXKZj80qbVAT6p47XVV5Dl76ViD8S4k2a+h4DMy3e3b46+YaWmJP61j+w==
X-Received: by 2002:a17:902:f54e:b0:1cc:2469:f2ff with SMTP id h14-20020a170902f54e00b001cc2469f2ffmr609463plf.9.1699651844250;
        Fri, 10 Nov 2023 13:30:44 -0800 (PST)
Received: from smtpclient.apple (76-10-188-40.dsl.teksavvy.com. [76.10.188.40])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ea8600b001cc2a6196b3sm89536plb.197.2023.11.10.13.30.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2023 13:30:43 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v2 1/1] switchtec: Fix stdev_release crash after suprise
 device loss.
From:   Daniel Stodden <dns@arista.com>
In-Reply-To: <dc15dc87-d199-4295-96b4-b972f4965bd5@deltatee.com>
Date:   Fri, 10 Nov 2023 13:30:30 -0800
Cc:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <531029E9-0321-4E5A-8C65-3378B8DCB5E2@arista.com>
References: <20231110201917.89016-1-dns@arista.com>
 <20231110201917.89016-2-dns@arista.com>
 <dc15dc87-d199-4295-96b4-b972f4965bd5@deltatee.com>
To:     Logan Gunthorpe <logang@deltatee.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi.

[Sorry, sending this twice, again, hoping this time it won't bounce, =
because html]

> Nice catch, thanks!
>=20
> The solution looks good to me, though I might quibble slightly about
> style: I'm not sure why we need two helper functions =
(disable_dma_mrpc()
> and switchtec_exit_pci()) that are only called in one place. I'd
> probably just open code both of them.
>=20
> Other than that:
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

I'm fine with it either way. I added those mainly because of the =
enable_dma_mrpc/switctec_init_pci
counterparts were already there. And likewise single-use, as would be =
usual.

So the subroutines would maintain symmetry between probe() and remove().

So.. just don't add the new remove()-relevant ones? (One alternative =
would be to send another change right after,
which goes after single-use pairs altogether.)

Daniel

> Logan
>=20
>> ---
>> drivers/pci/switch/switchtec.c | 29 +++++++++++++++++++++--------
>> 1 file changed, 21 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/pci/switch/switchtec.c =
b/drivers/pci/switch/switchtec.c
>> index e69cac84b605..002d0205d263 100644
>> --- a/drivers/pci/switch/switchtec.c
>> +++ b/drivers/pci/switch/switchtec.c
>> @@ -1247,17 +1247,17 @@ static void enable_dma_mrpc(struct =
switchtec_dev *stdev)
>> iowrite32(SWITCHTEC_DMA_MRPC_EN, &stdev->mmio_mrpc->dma_en);
>> }
>>=20
>> +static void disable_dma_mrpc(struct switchtec_dev *stdev)
>> +{
>> + iowrite32(0, &stdev->mmio_mrpc->dma_en);
>> + flush_wc_buf(stdev);
>> + writeq(0, &stdev->mmio_mrpc->dma_addr);
>> +}
>> +
>> static void stdev_release(struct device *dev)
>> {
>> struct switchtec_dev *stdev =3D to_stdev(dev);
>>=20
>> - if (stdev->dma_mrpc) {
>> - iowrite32(0, &stdev->mmio_mrpc->dma_en);
>> - flush_wc_buf(stdev);
>> - writeq(0, &stdev->mmio_mrpc->dma_addr);
>> - dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
>> - stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
>> - }
>> kfree(stdev);
>> }
>>=20
>> @@ -1301,7 +1301,7 @@ static struct switchtec_dev =
*stdev_create(struct pci_dev *pdev)
>> return ERR_PTR(-ENOMEM);
>>=20
>> stdev->alive =3D true;
>> - stdev->pdev =3D pdev;
>> + stdev->pdev =3D pci_dev_get(pdev);
>> INIT_LIST_HEAD(&stdev->mrpc_queue);
>> mutex_init(&stdev->mrpc_mutex);
>> stdev->mrpc_busy =3D 0;
>> @@ -1587,6 +1587,16 @@ static int switchtec_init_pci(struct =
switchtec_dev *stdev,
>> return 0;
>> }
>>=20
>> +static void switchtec_exit_pci(struct switchtec_dev *stdev)
>> +{
>> + if (stdev->dma_mrpc) {
>> + disable_dma_mrpc(stdev);
>> + dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
>> +   stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
>> + stdev->dma_mrpc =3D NULL;
>> + }
>> +}
>> +
>> static int switchtec_pci_probe(struct pci_dev *pdev,
>>        const struct pci_device_id *id)
>> {
>> @@ -1646,6 +1656,9 @@ static void switchtec_pci_remove(struct pci_dev =
*pdev)
>> ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
>> dev_info(&stdev->dev, "unregistered.\n");
>> stdev_kill(stdev);
>> + switchtec_exit_pci(stdev);
>> + pci_dev_put(stdev->pdev);
>> + stdev->pdev =3D NULL;
>> put_device(&stdev->dev);
>> }


