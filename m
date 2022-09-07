Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0895AF992
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 03:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIGB7a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 21:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIGB72 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 21:59:28 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDC626F7
        for <linux-pci@vger.kernel.org>; Tue,  6 Sep 2022 18:59:26 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m15so509025lfl.9
        for <linux-pci@vger.kernel.org>; Tue, 06 Sep 2022 18:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=EFy/QSO0F4j4Apu6RDsR6WCOc7oRq8bSTcHPqIPG7Ts=;
        b=CCb3YOlFRGWWKGrdlvaf62RkHUFHvgRy9Pl9Rd5dpb7MJ1mMzrDvjPIFfvyJGxq521
         HLL2gwDh9W9SZJY07tUIEXxkzko4IKHaUexEgGUbock7JFGJgk+c4+zs+ethDsttKJnY
         Cre2ZzqRNPSSsrPTR4DL8YcPz26qn7efBPg/zkVnaxZmdOhYBiVhTRpxr4GnqiCY3YGJ
         OMPGf2KDNvlMBdDnInQqa2lLDl+mU0OYpsPdblH6WJafSsaPhsF3OwuIuAVR9jzK6Hlo
         6lJ2qANjOJosL8cVbuKIBu87cnBuGSV/KdwBRcffz4+QXJVmy/yCLoPNO8vP3GbByP6H
         CxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EFy/QSO0F4j4Apu6RDsR6WCOc7oRq8bSTcHPqIPG7Ts=;
        b=7LG2WywzOrk0TbCA5DT1ZD7ZMC8Gk598u3G0L82mzySG0ej7F4gEro2+LdkkzIGqx8
         xSs7BjCZWNQo6VRUj30iT1swEVw/mCBCMKNhoYJraCImLygm174Klv7YT2D5AuLn/DlM
         7aSC6KKPKvpqoGzYJa1HEQJPRc03a5XJc8DK8M6+aibKtTCGeY6++6ZCVcIRnWPmY/nx
         IgVs+pU0EwNFCUC0bK2aXMHtW3fwLdcUnUNbT6jWpHqVgXcSplNFo5CtPsJI6Xu+innH
         /gpYpDDPqfQOZi2mo5LwTVT8ss3eW60uMqaf4v929Bk2kHQtAJc3e5j7MX29EPkbK3/y
         R+pg==
X-Gm-Message-State: ACgBeo0QA6YBk1g0D7BoAIRYpNB4GFDinsts2+P54hcoqutDVcmCeMvR
        eCzxZ3Qq5uulHkm8YKCPVEt/Q9BFu2Pp28K1LcUV+Q==
X-Google-Smtp-Source: AA6agR62TnWZqZ0eQ9BI+5r4ExFk6NfXVb5ER+iX5GutywvNPeAGme2Hie99tf6Po3ksGbjEiGX0TE6PEACqxBFgm5c=
X-Received: by 2002:a05:6512:3f05:b0:497:9e06:255b with SMTP id
 y5-20020a0565123f0500b004979e06255bmr355206lfa.175.1662515964784; Tue, 06 Sep
 2022 18:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220906101555.106033-1-mie@igel.co.jp> <Yxcn4CPN3BkC9xg7@kroah.com>
In-Reply-To: <Yxcn4CPN3BkC9xg7@kroah.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Wed, 7 Sep 2022 10:59:13 +0900
Message-ID: <CANXvt5ouQ72R3q=G3W-N77ecmu8k86c4FwpEq4eMaCG-pt=G_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] misc: pci_endpoint_test: Aggregate params
 checking for xfer
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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

2022=E5=B9=B49=E6=9C=886=E6=97=A5(=E7=81=AB) 19:58 Greg Kroah-Hartman <greg=
kh@linuxfoundation.org>:
>
> On Tue, Sep 06, 2022 at 07:15:54PM +0900, Shunsuke Mie wrote:
> > Each transfer test functions have same parameter checking code. This pa=
tch
> > unites those to an introduced function.
> >
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > ---
> > Changes in v2:
> > * New patch
> > ---
> > ---
> >  drivers/misc/pci_endpoint_test.c | 35 ++++++++++++++++++++++++++------
> >  1 file changed, 29 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoi=
nt_test.c
> > index 8f786a225dcf..3bd9f135cdac 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -332,6 +332,17 @@ static bool pci_endpoint_test_msi_irq(struct pci_e=
ndpoint_test *test,
> >       return false;
> >  }
> >
> > +static int pci_endpoint_test_validate_xfer_params(struct device *dev,
> > +             struct pci_endpoint_test_xfer_param *param, size_t alignm=
ent)
> > +{
> > +     if (param->size > SIZE_MAX - alignment) {
> > +             dev_err(dev, "Maximum transfer data size exceeded\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
> >                                  unsigned long arg)
> >  {
> > @@ -363,9 +374,13 @@ static bool pci_endpoint_test_copy(struct pci_endp=
oint_test *test,
> >               return false;
> >       }
> >
> > +     err =3D pci_endpoint_test_validate_xfer_params(dev, &param, align=
ment);
> > +     if (err) {
> > +             dev_err(dev, "Invalid parameter\n");
>
> Also, you just printed 2 errors for the same error.  Not needed.
I see. I'll also change to using the dev_dbg() in the next version.

Thanks,
Shunsuke
