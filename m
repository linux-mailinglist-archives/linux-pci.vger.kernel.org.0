Return-Path: <linux-pci+bounces-15149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B339AD49A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 21:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF0F28372F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDF114A09C;
	Wed, 23 Oct 2024 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjMS6ncb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D366513CABC;
	Wed, 23 Oct 2024 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711164; cv=none; b=UV0ALiW2POQlC0FKvCVR10OWbW6H3FQwP40YB/xaP6IN6ThapA13pfoLWgin7BnNehrkRSCXBDcGWNHo1rG9tZaKsaOydxX8Mjw5bc0AMD4epYqtcbsOw5+QCC1tggt5371nmH/oNypBDPD+ew2g9o/3lNE/sD2z6BW6sbgaFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711164; c=relaxed/simple;
	bh=6WtLjHYJ2ulUBqrQctjgZF8w/kA4GT/X593KHxeId6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/UA07A9dcfTvTiNEZ/U5+04oFSzWhQcRJwygJupKBJd8kOJ7ii+sP98cBGXd5OkbgJYr2hVVJVqpK+qv30CcipLp4nn2Pq3/iD/Dq4qaag6OlyWA9q2vaITQr+cm9BnBB2wL2Jyp5LrxzIp8Ri2Xsnb+z0GOxX9cDdijToJRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjMS6ncb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so793821fa.1;
        Wed, 23 Oct 2024 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729711161; x=1730315961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIQXDyI3TGtBNstAqOUEI1Qyhg4Co33pkkgoPkVHbIE=;
        b=QjMS6ncb6TmpZk0NHVUEOPQeUM+aDGEUIBZNqbINDY7lacMu8/kcLN+4sHxzEN4Rpq
         bzvfgLM9qIbDVxCSJNXkyiEi64f8u1zatciYcKsNAAiUSlNyBUgkC8KaoEzICUQ57Uau
         fq2uxVseXX2qXUkaeUPx0WRLP/YkykMpah935ZCF6QiDzi16Z78fuqiIlUXMTb5dzuN7
         oYDYR4Vm8laJWoHEPEGYSBG9VigKAD7U4ASBA8o9FanQsJP5oXxS4X5c4ZSqnXB0A0oh
         ncStA/Ij+Zusja1M4agE7hSP4JZoJmne8iskMLco8JtmRODjdEtlau2FdFSmqd5EONMk
         iOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729711161; x=1730315961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIQXDyI3TGtBNstAqOUEI1Qyhg4Co33pkkgoPkVHbIE=;
        b=aGMiCrjptazJAlhhJKmwIWv5BrlmRvVS2MIR6lPLwQBTdXVCbH+GWa4kiEPfdfVgY9
         jk5UGCQbtjM9UVNU4EyUkd6UrbfcXLI+6fD76I90wOWAboba+EHDsrj8Ng8IYQdMXuNx
         Sw+q1qvatcuJ61pBV3yS9C1mQMfbAAwTJYHSieWLAqKx+k+odD9+SYEJtoBlxJ2MUg5a
         mp02XpKHDDskAj8HJhsGHPF13e2JyGSg+nO9mRp1HpKN2Y0/Beg0pk0SppFotpKKgeg0
         PdN9WRgk6QIaEMON1aT643usQtLBik3ConEISS3RHrKcGoAV+6wk4xa5Ur+ce/Ez8c5K
         LoUA==
X-Forwarded-Encrypted: i=1; AJvYcCWM6owkog1WFBlpsyzwwPpBrAlYJj3KZeKQz1Idlmvn5ui3so710VV59kRbJwYqqD2Tp2mQsDOkBhypKo/Bx/Y=@vger.kernel.org, AJvYcCXOlA+/6y588G/dQ2mhfEDAYuQCbOoqRIQjnPg7UuikScB5hzj7Wr0zjyuw9Twd/oN9g2ivCxKyIjpu@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ6Dl9rQu8tlyJiNCsuClYjBojZKZo+cFpIUcEJqI61k6C4veE
	967CfbwrRnqcDlENGF352kbFaT97UennEohcnGOYIhUyovY15hOE+QFa88IcWX7h2QSJTibh30O
	P9/aiIJH8Q1yt24Y0fl7fjHI3kaTM7Q==
X-Google-Smtp-Source: AGHT+IFpPk1XupSN5DpYsV1j3hmHfFe92pNVTkkF2zUaqRhmR5Oeq8l8vg+TG8kgeu4ZjsxDMDLonaosnGF+iQKaI2g=
X-Received: by 2002:a2e:4e02:0:b0:2fa:ddb5:77f4 with SMTP id
 38308e7fff4ca-2fc9d37f14fmr16529831fa.38.1729711160640; Wed, 23 Oct 2024
 12:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023114647.1011886-1-chandrashekar.devegowda@intel.com> <e6bd065d-0b9b-4c37-958c-fc2a09ea0475@molgen.mpg.de>
In-Reply-To: <e6bd065d-0b9b-4c37-958c-fc2a09ea0475@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 23 Oct 2024 15:19:07 -0400
Message-ID: <CABBYNZJLQJX45cEvwt6mkXkbAeVLgV32JVf2Q0qgzt=PYOeknw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Device suspend-resume support added
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: ChandraShekar <chandrashekar.devegowda@intel.com>, Kiran K <kiran.k@intel.com>, 
	linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 23, 2024 at 3:19=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> [Cc: +Bjorn, +linux-pci]
>
> Dear Chandra,
>
>
> Thank you for the patch.
>
> First something minor: Should there be a space in your name?
>
> ChandraShekar =E2=86=92 Chandra Shekar
>
> `git config --global user.name "=E2=80=A6"` can configure this for your g=
it setup.
>
> Also for the summary/title, it=E2=80=99d be great if you used a statement=
 by
> using a verb (in imperative mood):
>
> Add device suspend-resume support
>
> or shorter
>
> Support suspend-resume
>
> Am 23.10.24 um 13:46 schrieb ChandraShekar:
> > This patch contains the changes in driver to support the suspend and
> > resume i.e move the controller to D3 state when the platform is enterin=
g
> > into suspend and move the controller to D0 on resume.
>
> It=E2=80=99d be great if you elaborated. Please start by the history, sin=
ce when
> Intel Bluetooth PCIe have been there, and why until now this support was
> missing.
>
> Then please describe, what is needed, and what documentation you used to
> implement the support.
>
> Also, please document, how you tested this, including the log messages,
> and also the time it takes to resume.
>
> Is it also possible to use Bluetooth as a wakeup source from suspend?

This is not a system-suspend though or are you asking if the device
can wakeup itself?

> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Signed-off-by: ChandraShekar <chandrashekar.devegowda@intel.com>
> > ---
> >   drivers/bluetooth/btintel_pcie.c | 52 +++++++++++++++++++++++++++++++=
+
> >   drivers/bluetooth/btintel_pcie.h |  4 +++
> >   2 files changed, 56 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btint=
el_pcie.c
> > index fd4a8bd056fa..f2c44b9d7328 100644
> > --- a/drivers/bluetooth/btintel_pcie.c
> > +++ b/drivers/bluetooth/btintel_pcie.c
> > @@ -273,6 +273,12 @@ static int btintel_pcie_reset_bt(struct btintel_pc=
ie_data *data)
> >       return reg =3D=3D 0 ? 0 : -ENODEV;
> >   }
> >
> > +static void btintel_pcie_set_persistence_mode(struct btintel_pcie_data=
 *data)
> > +{
> > +     btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_HW_BOOT_CONFIG,
> > +                               BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON=
);
> > +}
> > +
> >   /* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC=
_CTRL_MAC_INIT bit in
> >    * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
> >    * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
> > @@ -297,6 +303,8 @@ static int btintel_pcie_enable_bt(struct btintel_pc=
ie_data *data)
> >        */
> >       data->boot_stage_cache =3D 0x0;
> >
> > +     btintel_pcie_set_persistence_mode(data);
> > +
> >       /* Set MAC_INIT bit to start primary bootloader */
> >       reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_RE=
G);
> >       reg &=3D ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
> > @@ -1653,11 +1661,55 @@ static void btintel_pcie_remove(struct pci_dev =
*pdev)
> >       pci_set_drvdata(pdev, NULL);
> >   }
> >
> > +static int btintel_pcie_suspend(struct device *dev)
> > +{
> > +     struct btintel_pcie_data *data;
> > +     int err;
> > +     struct  pci_dev *pdev =3D to_pci_dev(dev);
> > +
> > +     data =3D pci_get_drvdata(pdev);
> > +     btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D3_HOT);
> > +     data->gp0_received =3D false;
> > +     err =3D wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> > +                              msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TI=
MEOUT_MS));
> > +     if (!err) {
> > +             bt_dev_err(data->hdev, "failed to receive gp0 interrupt f=
or suspend");
>
> Please include the timeout in the message.
>
> > +             goto fail;
> > +     }
> > +     return 0;
> > +fail:
> > +     return -EBUSY;
> > +}
> > +
> > +static int btintel_pcie_resume(struct device *dev)
> > +{
> > +     struct btintel_pcie_data *data;
> > +     struct  pci_dev *pdev =3D to_pci_dev(dev);
> > +     int err;
> > +
> > +     data =3D pci_get_drvdata(pdev);
> > +     btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
> > +     data->gp0_received =3D false;
> > +     err =3D wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> > +                              msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TI=
MEOUT_MS));
> > +     if (!err) {
> > +             bt_dev_err(data->hdev, "failed to receive gp0 interrupt f=
or resume");
>
> Ditto.
>
> > +             goto fail;
> > +     }
> > +     return 0;
> > +fail:
> > +     return -EBUSY;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(btintel_pcie_pm_ops, btintel_pcie_suspend,
> > +             btintel_pcie_resume);
> > +
> >   static struct pci_driver btintel_pcie_driver =3D {
> >       .name =3D KBUILD_MODNAME,
> >       .id_table =3D btintel_pcie_table,
> >       .probe =3D btintel_pcie_probe,
> >       .remove =3D btintel_pcie_remove,
> > +     .driver.pm =3D &btintel_pcie_pm_ops,
> >   };
> >   module_pci_driver(btintel_pcie_driver);
> >
> > diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btint=
el_pcie.h
> > index f9aada0543c4..38d0c8ea2b6f 100644
> > --- a/drivers/bluetooth/btintel_pcie.h
> > +++ b/drivers/bluetooth/btintel_pcie.h
> > @@ -8,6 +8,7 @@
> >
> >   /* Control and Status Register(BTINTEL_PCIE_CSR) */
> >   #define BTINTEL_PCIE_CSR_BASE                       (0x000)
> > +#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG              (BTINTEL_PCIE_CSR=
_BASE + 0x000)
> >   #define BTINTEL_PCIE_CSR_FUNC_CTRL_REG              (BTINTEL_PCIE_CSR=
_BASE + 0x024)
> >   #define BTINTEL_PCIE_CSR_HW_REV_REG         (BTINTEL_PCIE_CSR_BASE + =
0x028)
> >   #define BTINTEL_PCIE_CSR_RF_ID_REG          (BTINTEL_PCIE_CSR_BASE + =
0x09C)
> > @@ -48,6 +49,9 @@
> >   #define BTINTEL_PCIE_CSR_MSIX_IVAR_BASE             (BTINTEL_PCIE_CSR=
_MSIX_BASE + 0x0880)
> >   #define BTINTEL_PCIE_CSR_MSIX_IVAR(cause)   (BTINTEL_PCIE_CSR_MSIX_IV=
AR_BASE + (cause))
> >
> > +/* CSR HW BOOT CONFIG Register */
> > +#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON              (BIT(31))
> > +
> >   /* Causes for the FH register interrupts */
> >   enum msix_fh_int_causes {
> >       BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0       =3D BIT(0),       /* caus=
e 0 */
>
>
> Kind regards,
>
> Paul
>


--=20
Luiz Augusto von Dentz

