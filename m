Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C12A6EA321
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 07:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjDUFca (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 01:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjDUFc3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 01:32:29 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D845B9E
        for <linux-pci@vger.kernel.org>; Thu, 20 Apr 2023 22:32:27 -0700 (PDT)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 05D38412CF
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 05:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682055146;
        bh=6fZMAPxaQ2NtCFw/OrUJgDL+NjbElpsSBv71T4079w4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=T9wdh5aMsNa30Bg/2TbOvLS9DbL55vC4AYsE9PsBgBzHXs2pr6Js5PPrdZQCI8MgW
         AVvVj3d8Vuiq8SwH8C0A4wN79T/MpFcKVY2ukf+9OsOgLWbY33jRJfb/oFMVn7J+Od
         +ZzW89P2XI7znVTdepNl1QfDwMtX2UqSjghtFAa1dJtkqAxCtva3t+IeZMGmVBHuBx
         qnPZJUCMRKvKKA5Wg13egbH83DTC3ZKDpd5s4WEAeZxtAbjaKUUN5v9PvMHU6qMEsj
         A8gGCUVFIfN8cFkD/gEAkHMt5icBuRnPy4zHKMhz/EAXanHxQtDQfg/C9mjCKELOEc
         FmwN3X5R8k7/g==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2472a2e72d1so1644932a91.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Apr 2023 22:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682055144; x=1684647144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fZMAPxaQ2NtCFw/OrUJgDL+NjbElpsSBv71T4079w4=;
        b=kJIOt8V6259R815kuc7p31nFNMXgVfmpK/SL+l75CJAPHeaxQHy2oP6Vwp1D7SavlJ
         0T5GyxqNkIwr3bMYtWJZZ58ZvU5c4KS7qu1dBeAJCjR18YVQXC5yjpnMkURCbdGAR91E
         mAGYTOJtVEuCcJvevLXVm175bYDhkV48x9won5MqazwIRHaM5GmDLQLN5mmYDZumFKC/
         8hKonouI2GUiev58dnnUuSxyBRweILN18UHgtYo7CJEjW7Fu87gWWDoz4NpF3AGQfH75
         LM3H9tGlZWFQwBzxB1QVu0b+fDzrn8Dl+sJwkQZidEExQbaMzwT4AhEj+iB1ahOvuvTY
         iomA==
X-Gm-Message-State: AAQBX9e18JQf8gNDiQNU9UC96XtJAfn4nojbwgxMYzwNb+CIRUyHdQJl
        Fu4c+cXtsuqUXdo5eQ9kzEUME4BpWupGf/iL6O5CbXD8RdRirKg2fD9nEqjCwhv+acSBHi134gF
        e92wJbVNU7XUszJyfORz9xiTe0gATup0sQPuhre/UxeHEi948x+rssQ==
X-Received: by 2002:a17:90b:3648:b0:247:35c7:bd67 with SMTP id nh8-20020a17090b364800b0024735c7bd67mr3754301pjb.46.1682055143745;
        Thu, 20 Apr 2023 22:32:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZW3SE5cSn/yddEPPQw5KYQiQxrGhjGAVAADd/GQ9uokNzzHmPpmqsq9Qa5iBnIp1hnHZ8RBNckOT4JFBvEcnM=
X-Received: by 2002:a17:90b:3648:b0:247:35c7:bd67 with SMTP id
 nh8-20020a17090b364800b0024735c7bd67mr3754285pjb.46.1682055143456; Thu, 20
 Apr 2023 22:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230420125941.333675-1-kai.heng.feng@canonical.com>
 <20230420125941.333675-3-kai.heng.feng@canonical.com> <f1409ba9-5370-1e0d-8b6c-e9782505937f@linux.intel.com>
In-Reply-To: <f1409ba9-5370-1e0d-8b6c-e9782505937f@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 21 Apr 2023 13:32:12 +0800
Message-ID: <CAAd53p4chNHrHA8RhSjQYH4znVXHZHJ4m4JrzFiOsun_JsegXA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] PCI/AER: Disable AER interrupt on suspend
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 20, 2023 at 10:53=E2=80=AFPM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 4/20/23 5:59 AM, Kai-Heng Feng wrote:
> > PCIe service that shares IRQ with PME may cause spurious wakeup on
> > system suspend.
> >
> > PCIe Base Spec 5.0, section 5.2 "Link State Power Management" states
> > that TLP and DLLP transmission is disabled for a Link in L2/L3 Ready
> > (D3hot), L2 (D3cold with aux power) and L3 (D3cold), so we don't lose
> > much here to disable AER during system suspend.
> >
> > This is very similar to previous attempts to suspend AER and DPC [1],
> > but with a different reason.
> >
> > [1] https://lore.kernel.org/linux-pci/20220408153159.106741-1-kai.heng.=
feng@canonical.com/
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216295
> >
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
>
> In Patch #1, you skip clearing AER errors in the resume path, right? So i=
f we disable
> interrupts here, will AER driver not be notified on resume path error?

I agree the driver should report the error via aer_isr_one_error() on
resume path.
But on the system I am using (Intel ADL PCH), once the interrupt is
disabled, PCI_ERR_ROOT_STATUS doesn't record error anymore.
Not sure if it's intended though.

Kai-Heng

>
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
