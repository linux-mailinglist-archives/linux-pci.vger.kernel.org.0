Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D6C6D1372
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 01:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjC3XnS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 19:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjC3XnR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 19:43:17 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93599CA05;
        Thu, 30 Mar 2023 16:43:13 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id j7so25633850ybg.4;
        Thu, 30 Mar 2023 16:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680219793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcZqAGUTPeSkDw23rK6dbBPBzMq/2/SptfrVxtDB0UQ=;
        b=bPflKkHyODU8uuehrKfUxhncuo2AuQrCOUht50s5CP3/L5DWLKNVwCzJiTEaTHDA2R
         W8PNyNrEL/0WuHRgTIyQeHwGjj3WYh/uc7eHmXOP2Kh0AN+uxMqgTjoR3Kn9SorMT9Xa
         BfwCqqF98FxGxSGu5FYlwvOEc0tA51r61ZxLW00pRti5pfB/oy40Wd6fMETOY3FJusUT
         VYxs32cXpTrNn3hevQUPsImIy8gUaJ4HrTXAx4x1ol/idJy9N3HmWOkgyKDe9Yu4aWTD
         gS4+6/d5JLC7opUHk4WN7PMB8OjJ92hP00c9kz7k94SGP6D/hVQB9e7W+S1kT5ou6+wb
         o/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680219793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcZqAGUTPeSkDw23rK6dbBPBzMq/2/SptfrVxtDB0UQ=;
        b=3TvQjPCxCF1l9y6L34SWMHuGbHXLHcYOwDs5u2YsT7qM2AFEIj7gfqz+BWBgGN1067
         V67SCRW6YGlXPHN9aIcnDyQUA5eH2zwf3WKYeEegS6W797RwLgxFrGYVRoNftgB3B0VC
         RkxkVgaqr9ZM4FSj0kNXVWn8tBHwKd+G54MzzbhuuaruQBbDDz9xZC95g6kdk+1Uputs
         AXnDh23TOoul3pFyDwqEusq93C3CNtBJ8UqFW7d8yJlOFRkZmNUSedzJ5//MohUpgORY
         bgt/zMbKT1Oz71sxvX07jzj8K20y/FKbCk9AOrTxHic374KwyCcqioWNOJvGJDm/JBqH
         n/WA==
X-Gm-Message-State: AAQBX9en69oR3u45z82VKkO7GMZ7dXzi19WIxOYSihLpRqTDRxfUjlaP
        I73kdnyIwpA1Tt8QiiQag8yZbs1quzpdEuMohs0=
X-Google-Smtp-Source: AKy350bqbzF6SrzHXSyol3UEFAY9jZj8xOWQlhMA5/OcrMr1OSBWBXFKxpU7bojSxQYKftTBFL5H45EMrnAbNzqKWXQ=
X-Received: by 2002:a05:6902:1141:b0:b73:caa7:f06f with SMTP id
 p1-20020a056902114100b00b73caa7f06fmr16639952ybu.5.1680219792765; Thu, 30 Mar
 2023 16:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221206221335.GA1363005@bhelgaas> <20230315213537.GA1788623@bhelgaas>
In-Reply-To: <20230315213537.GA1788623@bhelgaas>
From:   Justin Tee <justintee8345@gmail.com>
Date:   Thu, 30 Mar 2023 16:43:01 -0700
Message-ID: <CABPRKS-kMVpEEdJPR6_ru6hjqyjxcVaR+FRWNGS1RRChjeFhCg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] scsi: lpfc: Change to use pci_aer_clear_uncorrect_error_status()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Zhuo Chen <chenzhuo.1@bytedance.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Justin Tee <justin.tee@broadcom.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> But lpfc_aer_cleanup_state() is visible in the
> "lpfc_aer_state_cleanup" sysfs file, so removing it would break any
> userspace that uses it.
>
> If we can rely on the PCI core to clean up AER errors itself
> (admittedly, that might be a big "if"), maybe lpfc_aer_cleanup_state()
> could just become a no-op?
>
> Any comment from the LPFC folks?

We have notified all users of the lpfc_aer_cleanup_state sysfs entry,
and Broadcom LPFC is okay to no-op.

Regards,
Justin

On Wed, Mar 15, 2023 at 2:39=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Dec 06, 2022 at 04:13:35PM -0600, Bjorn Helgaas wrote:
> > On Wed, Sep 28, 2022 at 06:59:41PM +0800, Zhuo Chen wrote:
> > > lpfc_aer_cleanup_state() requires clearing both fatal and non-fatal
> > > uncorrectable error status.
> >
> > I don't know what the point of lpfc_aer_cleanup_state() is.  AER
> > errors should be handled and cleared by the PCI core, not by
> > individual drivers.  Only lpfc, liquidio, and sky2 touch
> > PCI_ERR_UNCOR_STATUS.
> >
> > But lpfc_aer_cleanup_state() is visible in the
> > "lpfc_aer_state_cleanup" sysfs file, so removing it would break any
> > userspace that uses it.
> >
> > If we can rely on the PCI core to clean up AER errors itself
> > (admittedly, that might be a big "if"), maybe lpfc_aer_cleanup_state()
> > could just become a no-op?
> >
> > Any comment from the LPFC folks?
> >
> > Ideally, I would rather not export pci_aer_clear_nonfatal_status() or
> > pci_aer_clear_uncorrect_error_status() outside the PCI core at all.
>
> Resurrecting this old thread.  Zhuo, can you figure out where the PCI
> core clears these errors, include that in the commit log, and propose
> a patch that makes lpfc_aer_cleanup_state() a no-op, by removing the
> pci_aer_clear_nonfatal_status() call completely?
>
> Such a patch could be sent to the SCSI maintainers since it doesn't
> involve the PCI core.
>
> If it turns out that the PCI core *doesn't* clear these errors, we
> should figure out *why* it doesn't and try to change the PCI core so
> it does.
>
> > > But using pci_aer_clear_nonfatal_status()
> > > will only clear non-fatal error status. To clear both fatal and
> > > non-fatal error status, use pci_aer_clear_uncorrect_error_status().
> > >
> > > Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> > > ---
> > >  drivers/scsi/lpfc/lpfc_attr.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_a=
ttr.c
> > > index 09cf2cd0ae60..d835cc0ba153 100644
> > > --- a/drivers/scsi/lpfc/lpfc_attr.c
> > > +++ b/drivers/scsi/lpfc/lpfc_attr.c
> > > @@ -4689,7 +4689,7 @@ static DEVICE_ATTR_RW(lpfc_aer_support);
> > >   * Description:
> > >   * If the @buf contains 1 and the device currently has the AER suppo=
rt
> > >   * enabled, then invokes the kernel AER helper routine
> > > - * pci_aer_clear_nonfatal_status() to clean up the uncorrectable
> > > + * pci_aer_clear_uncorrect_error_status() to clean up the uncorrecta=
ble
> > >   * error status register.
> > >   *
> > >   * Notes:
> > > @@ -4715,7 +4715,7 @@ lpfc_aer_cleanup_state(struct device *dev, stru=
ct device_attribute *attr,
> > >             return -EINVAL;
> > >
> > >     if (phba->hba_flag & HBA_AER_ENABLED)
> > > -           rc =3D pci_aer_clear_nonfatal_status(phba->pcidev);
> > > +           rc =3D pci_aer_clear_uncorrect_error_status(phba->pcidev)=
;
> > >
> > >     if (rc =3D=3D 0)
> > >             return strlen(buf);
> > > --
> > > 2.30.1 (Apple Git-130)
> > >
