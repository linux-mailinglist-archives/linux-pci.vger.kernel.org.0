Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A9E6FFD6D
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 01:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbjEKXnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 19:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbjEKXnF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 19:43:05 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C504EC5
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 16:43:04 -0700 (PDT)
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D25AC3F4A6
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 23:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683848136;
        bh=AavuI0TWlPi0CnfBPjihPkVAm61gVpB2DpqaI9wFivM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=XBvpFCZmr/GaLncsTnnh9EdvENYrggmR6Ej7IaovBrjw9xBvMU8BZdY5j+pZjt9FZ
         UHsrGv1DxW7qfeI0mzCLlTMa8Ix5F3ZLAq51lzqTVV8SC0s3Q15iASoZWDJw3nJ1Ri
         U74RWFjfmCCga5cxHdNkVsn8yg6/qCMMswDOiOQdaaQ1w82V2QRJR8zAoiZxArEeIN
         I03a3vX2VhwhqDxGK+SYSqwqrx8ebnB5DWXVPZ3inkcmG8Hmy9WT+M1Jh14plUzQZ+
         +ruvHBMb3Kqfr+WiIolBtESlh9PD32HMCJX1r/t0RJquRkzQC2GxC2WEhjmlE886kq
         +lzgLB8rWbgHQ==
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-621257e86daso72533296d6.1
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 16:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683848135; x=1686440135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AavuI0TWlPi0CnfBPjihPkVAm61gVpB2DpqaI9wFivM=;
        b=LqxMwdympxAbZqi/ri2vDbCvTZsc+JvtvbwRTG7NnY/TbbzNZ8M1HyV8DRvHGTpV1t
         QGnOp1yPyhkngqR7uu32DUCv98PrS2AdUFHg7b0pZfRKZB5vhTo0g800fRLzp21kUARm
         Bag8QAkSQcWZEVrNnqyKBGJAsHYCbUfj4wT4hOuJdhBUQTcK7RFEKZbegyGd2IAVspmI
         DcQaUIC/EXtk6TJdmis1QYcwcn6rD0qFW4yRa7tti7cQhYqRxzCmosaIMiw7Zr1cnuqe
         eHlxlc3O6sufqIH4MwbI9fI5xzmH4rSkOcMfSCAVmpLDT6N5kE40PeIZP0z+w846C9p9
         +h1Q==
X-Gm-Message-State: AC+VfDxE+CgqKINEsgkyplDBO8c6mqeYX2iNttZK4eaXXu3UWRTeppEA
        N89UKjw+9n2hLzAoE4qZGkerGiKa1wV+NKfNr6hVAxc+4Yj/f3uw93INY2bovv7OkSkhx2WkdBS
        WcVGBYvC+iSnW3taWAqZDq1dyOI6f50RxY+6hmnpXbcLIi0QkndwA+w==
X-Received: by 2002:a05:6214:4111:b0:606:5103:9c98 with SMTP id kc17-20020a056214411100b0060651039c98mr31512341qvb.34.1683848135684;
        Thu, 11 May 2023 16:35:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6X2h4PhBnWCS1JA9fsEFMvT4e/yv9Ou8UzrL8YE7aB8SB5MXK8wwK0ov0ztdzDRtm/ZrxJJRZOUJYD9Md7Uq0=
X-Received: by 2002:a05:6214:4111:b0:606:5103:9c98 with SMTP id
 kc17-20020a056214411100b0060651039c98mr31512322qvb.34.1683848135398; Thu, 11
 May 2023 16:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230511133610.99759-1-kai.heng.feng@canonical.com>
 <20230511133610.99759-2-kai.heng.feng@canonical.com> <35b33699-227d-d1f5-285a-e18ef8e91e57@linux.intel.com>
In-Reply-To: <35b33699-227d-d1f5-285a-e18ef8e91e57@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 12 May 2023 07:35:23 +0800
Message-ID: <CAAd53p7b-kTzU5ZNi-9RCYSjusvarFXXcsL6LSCtc6VO+i7d=g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] PCI/AER: Disable AER interrupt on suspend
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 12, 2023 at 6:08=E2=80=AFAM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 5/11/23 6:36 AM, Kai-Heng Feng wrote:
> > PCIe service that shares IRQ with PME may cause spurious wakeup on
> > system suspend.
> >
> > This is very similar to previous attempts to suspend AER and DPC [1],
> > but this time disabling AER IRQ is to prevent immediate PME wakeup when
> > AER shares the same IRQ line with PME.
>
> IMHO, you don't need to mention the previous submission reason.

Sure, will remove it in next revision.

>
> >
> > It's okay to disable AER because PCIe Base Spec 5.0, section 5.2 "Link
> > State Power Management" states that TLP and DLLP transmission is
> > disabled for a Link in L2/L3 Ready (D3hot), L2 (D3cold with aux power)
> > and L3 (D3cold), hence we don't lose much here to disable AER IRQ durin=
g
> > system suspend.
>
> May be something like below?
>
> PCIe services that share an IRQ with PME, such as AER or DPC, may cause a
> spurious wakeup on system suspend. To prevent this, disable the AER
> interrupt notification during the system suspend process.
>
> As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power Manageme=
nt",
> TLP and DLLP transmission are disabled for a Link in L2/L3 Ready (D3hot),=
 L2
> (D3cold with aux power) and L3 (D3cold) states. So disabling the AER noti=
fication
> during suspend and re-enabling them during the resume process should not =
affect
> the basic functionality.

I'll shamelessly use this in the commit message :)

Kai-Heng

>
> >
> > [1] https://lore.kernel.org/linux-pci/20220408153159.106741-1-kai.heng.=
feng@canonical.com/
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216295
> >
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v5:
> >  - Wording.
> >
> > v4:
> > v3:
> >  - No change.
> >
> > v2:
> >  - Only disable AER IRQ.
> >  - No more check on PME IRQ#.
> >  - Use helper.
> >
> >  drivers/pci/pcie/aer.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 1420e1f27105..9c07fdbeb52d 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1356,6 +1356,26 @@ static int aer_probe(struct pcie_device *dev)
> >       return 0;
> >  }
> >
> > +static int aer_suspend(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +     struct pci_dev *pdev =3D rpc->rpd;
> > +
> > +     aer_disable_irq(pdev);
> > +
> > +     return 0;
> > +}
> > +
> > +static int aer_resume(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +     struct pci_dev *pdev =3D rpc->rpd;
> > +
> > +     aer_enable_irq(pdev);
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> >   * @dev: pointer to Root Port, RCEC, or RCiEP
> > @@ -1420,6 +1440,8 @@ static struct pcie_port_service_driver aerdriver =
=3D {
> >       .service        =3D PCIE_PORT_SERVICE_AER,
> >
> >       .probe          =3D aer_probe,
> > +     .suspend        =3D aer_suspend,
> > +     .resume         =3D aer_resume,
> >       .remove         =3D aer_remove,
> >  };
> >
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
