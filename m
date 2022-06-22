Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F63554238
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 07:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356545AbiFVFYJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 01:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiFVFYJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 01:24:09 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7897B36167
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 22:24:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a11so9184115ljb.5
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 22:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SwIledSLJN1+QLOSPItKlxyEAsKWtgQUbp5m5Fbo6uQ=;
        b=yi0OysNlyMSg6TwiZPAbEDxUKmeua7drte42/DUfPgwAoszXJowcaVaHuZgGZcUUIh
         IMTpOJi1r+8ofYsCqnGziazSOoySDDXGQHXWC3MXXMLD4Qxoc9MIsEf97SXpBqY5coXz
         WSBVTzpthRCJu6g/eUTFa8zcxFQyDb/7oyTdelKmL64E4cBypu/KW3RIlvmetc9qiANI
         fQVwVme1pwz5J+JlZzXyc8cljwBMqgPY0oHG3Sk1bU21okCSqWS0OYrxgTT3qvfKDOb6
         pXpaUhMrRmRtd6Z332mM6IRRvKDn+ZrRGuNKfYByuJnZyTehGGGKOmi60/haFUKAp7ii
         8Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SwIledSLJN1+QLOSPItKlxyEAsKWtgQUbp5m5Fbo6uQ=;
        b=uPTzt7+2q2GigwJeDhYQBTDmaw8ZwrDSt6B0Dl2kl/J1hpAFhZqx/DWNUwsGX1MPPh
         BIakq6Kfsj6yiv2HKls3m6pRyvwDmLr8prTWXm9A38TBZ1AJ/RutgNqzoY50NhgyY4zN
         yqwkzYPfAKPh9EsOVNrCEYNQSjLmNT75EgKtqvFiPWKA3rskFffbYPI+XWID/ZtZARkt
         GjAV/mY8ZjyErFzoBtpmcJgTFGcr/yVVtig78ldxFxR63atuqrUO6b/nkXLVs6fBbHuE
         w8Fgm8Qo41RTZYKtBg7ZSa8JNhUrDe0Fe0hBkqb2gvr7ZxSR1lGdgeWJN/5/ELvKvKHR
         tS0g==
X-Gm-Message-State: AJIora9amPG8pn25gXFiLUmA0wkpmqIVWJlA0pyoetvam+ky4R+uZvh+
        hJQxl2bwl+2I8gWVks6sJvLYl2NYmC4auLCAflIiIQ==
X-Google-Smtp-Source: AGRyM1uZ+3lCpiAbKhVLDcGNPyhqSK6wLdiFg4xJOrqa0vUy4IGMre35HEc0/mj2H1l2hL9a1hHOcyRO3vwE80eIvFs=
X-Received: by 2002:a2e:8881:0:b0:255:7790:25e6 with SMTP id
 k1-20020a2e8881000000b00255779025e6mr835126lji.525.1655875444760; Tue, 21 Jun
 2022 22:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220622040924.113279-1-mie@igel.co.jp> <4bc63a00-a220-e9b8-49ff-8c2d783b55f5@ti.com>
In-Reply-To: <4bc63a00-a220-e9b8-49ff-8c2d783b55f5@ti.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Wed, 22 Jun 2022 14:23:51 +0900
Message-ID: <CANXvt5oNDFmU=YtdAFtd3uB9Un0dxCqbD+0VtMRd3Aj1qOc3Wg@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: Don't stop EP controller by EP function
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Chen <lchen@ambarella.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

Thank you for your ack.

2022=E5=B9=B46=E6=9C=8822=E6=97=A5(=E6=B0=B4) 14:10 Kishon Vijay Abraham I =
<kishon@ti.com>:
>
>
>
> On 22/06/22 09:39, Shunsuke Mie wrote:
> > For multi-function endpoint device, an ep function shouldn't stop EP
> > controller. Nomally the controller is stopped via configfs.
>
> %s/Nomally/Normally/
Oops, sorry. Should I resend this patch with fixing the typo?

> > Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to t=
est PCI")
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>
> Thank you for the fix!
>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pc=
i/endpoint/functions/pci-epf-test.c
> > index 5b833f00e980..a5ed779b0a51 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -627,7 +627,6 @@ static void pci_epf_test_unbind(struct pci_epf *epf=
)
> >
> >       cancel_delayed_work(&epf_test->cmd_handler);
> >       pci_epf_test_clean_dma_chan(epf_test);
> > -     pci_epc_stop(epc);
> >       for (bar =3D 0; bar < PCI_STD_NUM_BARS; bar++) {
> >               epf_bar =3D &epf->bar[bar];
> >

Thanks.
Shunsuke Mie
