Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F5C6FF1CD
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 14:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjEKMsX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 08:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEKMsX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 08:48:23 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0275B8B
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 05:48:21 -0700 (PDT)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CDF733F4D8
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683809298;
        bh=ZkSgjZyo9xVh4gblsVQOCDmnEdqEfK/tJWBgTKA7lTY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=nMlylJqE+NjtauI/vFU5ePvu8CCkAgsYY7a6PfeZeygWICEGHJkMxHcetKqdFyAzX
         +IBVFEbNIjonmBaZLfzYd6uTIHe+8QizOz/qNSMx+9Ti+7YdkX33/SA36OlScTatRP
         apxOZJOR8rcZABcFo8f6VQ9+wFOJJijGAexH/pEXY9uH2CDbfS9JFOjokv0cTcRHMh
         yGzF5aVNuvdGaThgn+SmHEvqxrT7BDnsYWjryDXQUMdWWjNhq0/U+mJU1wlpma4xCS
         yaRaqE5lDFpJnHrKrlPZ10NBL2ae7vnTaCSASZhMY1snWwk3viY8sHATijQrGiHbs1
         efw0EUAHnVi+w==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-643aad3bbf3so4296189b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 05:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683809297; x=1686401297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkSgjZyo9xVh4gblsVQOCDmnEdqEfK/tJWBgTKA7lTY=;
        b=QfeVLp4YBul9cducQJzF2OMEVOFz+vId8uvtrJMGYMPzxWFTwW3/EfWfonmZuh8vJd
         nr4wt1Y9fStix0daRmMfywpQ4o1XF9dXj8dDCYDP+49YKp5ueFsDykV7sDx3IOePJgT1
         U8nyhNX/jFwb8pBQ1ndCSAXXMGU7vdRFcRXs7F0O9gNNdq9vQ3yAiFO99+CGrt7mCpl0
         D5qDSSCY+rCFLxBtF9FzxEhWBqQLO/UgKvIonRSh95PJaDr7TAidfVPrWWw3fIq2Ooii
         0dlk8yeVxVGd5u2NncQtU9+Mt4GPsk2DfiGCUDbAmClIct1aq0hSVUqC79mQH3PzfD7b
         n1cg==
X-Gm-Message-State: AC+VfDzuw57bMNGEN1MOsH3mxrrKEwn1UmHqKeO3T9M+2an3KdQ1iWH6
        /b8sy+P9QEK9YQ+g5aCk96V1Xi+qtZYl5CWV0ZLpmQOgCOMF96HTI0rrgouJl785R/1iSgME+Ln
        m5gaO2Pxk0U88cSE6fLmU4zHiOEsNuhnlm9/JIr8K3XtV4JjhUjFlbQ==
X-Received: by 2002:a05:6a20:3d84:b0:103:ce90:f3d2 with SMTP id s4-20020a056a203d8400b00103ce90f3d2mr2897374pzi.9.1683809297245;
        Thu, 11 May 2023 05:48:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7a5HjvgwmUzaFJhBxIy+pEBXHv6RWgm6O2IL/k7CBCtcM/768F9wF5Jd+uvw8d2kAoRH3ALgS/uKmLbD05/78=
X-Received: by 2002:a05:6a20:3d84:b0:103:ce90:f3d2 with SMTP id
 s4-20020a056a203d8400b00103ce90f3d2mr2897350pzi.9.1683809296857; Thu, 11 May
 2023 05:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230424055249.460381-1-kai.heng.feng@canonical.com> <20230505163714.000003a9@Huawei.com>
In-Reply-To: <20230505163714.000003a9@Huawei.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 11 May 2023 20:48:05 +0800
Message-ID: <CAAd53p63TspntTfVUq5cxNQUVnw_owvwn=Y1RJq67LSUDvxH8w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PCI/AER: Factor out interrupt toggling into helpers
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
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

On Fri, May 5, 2023 at 11:37=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 24 Apr 2023 13:52:47 +0800
> Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> > There are many places that enable and disable AER interrput, so move
>
> interrupt

Thanks, will correct that in next revision.

Kai-Heng

>
> > them into helpers.
>
> Otherwise looks like a good clean up to me.
> FWIW
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> >
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pcie/aer.c | 45 +++++++++++++++++++++++++-----------------
> >  1 file changed, 27 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index f6c24ded134c..1420e1f27105 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1227,6 +1227,28 @@ static irqreturn_t aer_irq(int irq, void *contex=
t)
> >       return IRQ_WAKE_THREAD;
> >  }
> >
> > +static void aer_enable_irq(struct pci_dev *pdev)
> > +{
> > +     int aer =3D pdev->aer_cap;
> > +     u32 reg32;
> > +
> > +     /* Enable Root Port's interrupt in response to error messages */
> > +     pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> > +     reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
> > +     pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> > +}
> > +
> > +static void aer_disable_irq(struct pci_dev *pdev)
> > +{
> > +     int aer =3D pdev->aer_cap;
> > +     u32 reg32;
> > +
> > +     /* Disable Root's interrupt in response to error messages */
> > +     pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> > +     reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
> > +     pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> > +}
> > +
> >  /**
> >   * aer_enable_rootport - enable Root Port's interrupts when receiving =
messages
> >   * @rpc: pointer to a Root Port data structure
> > @@ -1256,10 +1278,7 @@ static void aer_enable_rootport(struct aer_rpc *=
rpc)
> >       pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
> >       pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
> >
> > -     /* Enable Root Port's interrupt in response to error messages */
> > -     pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> > -     reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
> > -     pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> > +     aer_enable_irq(pdev);
> >  }
> >
> >  /**
> > @@ -1274,10 +1293,7 @@ static void aer_disable_rootport(struct aer_rpc =
*rpc)
> >       int aer =3D pdev->aer_cap;
> >       u32 reg32;
> >
> > -     /* Disable Root's interrupt in response to error messages */
> > -     pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> > -     reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
> > -     pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> > +     aer_disable_irq(pdev);
> >
> >       /* Clear Root's error status reg */
> >       pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> > @@ -1372,12 +1388,8 @@ static pci_ers_result_t aer_root_reset(struct pc=
i_dev *dev)
> >        */
> >       aer =3D root ? root->aer_cap : 0;
> >
> > -     if ((host->native_aer || pcie_ports_native) && aer) {
> > -             /* Disable Root's interrupt in response to error messages=
 */
> > -             pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &=
reg32);
> > -             reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
> > -             pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, =
reg32);
> > -     }
> > +     if ((host->native_aer || pcie_ports_native) && aer)
> > +             aer_disable_irq(root);
> >
> >       if (type =3D=3D PCI_EXP_TYPE_RC_EC || type =3D=3D PCI_EXP_TYPE_RC=
_END) {
> >               rc =3D pcie_reset_flr(dev, PCI_RESET_DO_RESET);
> > @@ -1396,10 +1408,7 @@ static pci_ers_result_t aer_root_reset(struct pc=
i_dev *dev)
> >               pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &r=
eg32);
> >               pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, r=
eg32);
> >
> > -             /* Enable Root Port's interrupt in response to error mess=
ages */
> > -             pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &=
reg32);
> > -             reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
> > -             pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, =
reg32);
> > +             aer_enable_irq(root);
> >       }
> >
> >       return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>
