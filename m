Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AFD264A35
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIJQr7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgIJQmp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 12:42:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B3BC061796
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2020 09:42:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so758895wmi.0
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2020 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GvgbVfIZqihDSRIr1P4MSPZ94jsrKZCQ/F5fxysr01I=;
        b=TyICq94e6vxoZvEgnvm8SlIehSyYzjGupKav4lb+Pxcok42/rR29CaJsm7jZed8wjV
         VcAv2SU6ofqly993m3jDXEk0C+O3H07Etf7gaC64szFw+cNBM0HVU6HG/dU9MLJbTu/k
         uRnYclDANSacP6879/r2nJayBIVdkxcgORPPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GvgbVfIZqihDSRIr1P4MSPZ94jsrKZCQ/F5fxysr01I=;
        b=jnYoQgn7No8k61Bf2O8huEa1pnkLxbYALfR80yLmsAYwWS6bpd+JuuK2zl3iHSNWlg
         P9DmFwzxqoLPyIsPwbPUvYXU1ngkUGV27rFm6G6rv1LmqJecXclyqeLrIFjYQiWRI1cS
         ahAk76hFVixCi6hTuPiCSk+WqSQKyoMTQ6Hj0ze61c4A4piJ0LmSknIdCbfxOBbGcacg
         PNcxQoKJm8q+1uEl7dcAS9nVeUvJcDUbwDz6xvqPUujNaa2dX0d5DC9qy804n4r6PaC5
         IoaP36fEc3vQolfmph6+aWQVlHUo23gxawRIOxzpwh4yZsz0Z8MDfL+6pYcGpUCrZ8TO
         CGYQ==
X-Gm-Message-State: AOAM532x8/TAleCXuOpK3Xg9FRWbbS0td9vjsWd9A/zBBCEGkUFn9nrt
        +nZhWXTLruLXT7Swuy7zqccjFtaTd+hzlAlfz160DQ==
X-Google-Smtp-Source: ABdhPJx5ThJye94JSHiFtZNh0ZQ4aNsRIwOmoYGG2F1UkWonsVmJjeDLByWdS5LZQSLHRuMfqoGw32CjqMUUGfBcWTs=
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr891329wmc.85.1599756162505;
 Thu, 10 Sep 2020 09:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-5-james.quinlan@broadcom.com> <20200910155637.GA423872@bogus>
In-Reply-To: <20200910155637.GA423872@bogus>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 10 Sep 2020 12:42:30 -0400
Message-ID: <CA+-6iNy9g8fhJvd7SOKtc-SZcL8_gLLN1HEs-W8fe-=q6n430A@mail.gmail.com>
Subject: Re: [PATCH v11 04/11] PCI: brcmstb: Add suspend and resume pm_ops
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d18b2e05aef8415c"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000d18b2e05aef8415c
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 10, 2020 at 11:56 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Aug 24, 2020 at 03:30:17PM -0400, Jim Quinlan wrote:
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > Broadcom Set-top (BrcmSTB) boards typically support S2, S3, and S5 suspend
> > and resume.  Now the PCIe driver may do so as well.
> >
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 47 +++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index c2b3d2946a36..3d588ab7a6dd 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -978,6 +978,47 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> >       brcm_pcie_bridge_sw_init_set(pcie, 1);
> >  }
> >
> > +static int brcm_pcie_suspend(struct device *dev)
> > +{
> > +     struct brcm_pcie *pcie = dev_get_drvdata(dev);
> > +
> > +     brcm_pcie_turn_off(pcie);
> > +     clk_disable_unprepare(pcie->clk);
> > +
> > +     return 0;
> > +}
> > +
> > +static int brcm_pcie_resume(struct device *dev)
> > +{
> > +     struct brcm_pcie *pcie = dev_get_drvdata(dev);
> > +     void __iomem *base;
> > +     u32 tmp;
> > +     int ret;
> > +
> > +     base = pcie->base;
> > +     clk_prepare_enable(pcie->clk);
> > +
> > +     /* Take bridge out of reset so we can access the SERDES reg */
> > +     brcm_pcie_bridge_sw_init_set(pcie, 0);
> > +
> > +     /* SERDES_IDDQ = 0 */
> > +     tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> > +     u32p_replace_bits(&tmp, 0, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
> > +     writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> > +
> > +     /* wait for serdes to be stable */
> > +     udelay(100);
>
> Really needs to be a spinloop?
>
> > +
> > +     ret = brcm_pcie_setup(pcie);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (pcie->msi)
> > +             brcm_msi_set_regs(pcie->msi);
> > +
> > +     return 0;
> > +}
> > +
> >  static void __brcm_pcie_remove(struct brcm_pcie *pcie)
> >  {
> >       brcm_msi_remove(pcie);
> > @@ -1087,12 +1128,18 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> >
> >  MODULE_DEVICE_TABLE(of, brcm_pcie_match);
> >
> > +static const struct dev_pm_ops brcm_pcie_pm_ops = {
> > +     .suspend_noirq = brcm_pcie_suspend,
> > +     .resume_noirq = brcm_pcie_resume,
>
> Why do you need interrupts disabled? There's 39 cases of .suspend_noirq
> and 1352 of .suspend in the tree.

I will test switching this to  suspend_late/resume_early.

Thanks,
Jim Quinlan
Broadcom STB
>
> Is doing a clk unprepare even safe in .suspend_noirq? IIRC,
> prepare/unprepare can sleep.
>
> > +};
> > +
> >  static struct platform_driver brcm_pcie_driver = {
> >       .probe = brcm_pcie_probe,
> >       .remove = brcm_pcie_remove,
> >       .driver = {
> >               .name = "brcm-pcie",
> >               .of_match_table = brcm_pcie_match,
> > +             .pm = &brcm_pcie_pm_ops,
> >       },
> >  };
> >  module_platform_driver(brcm_pcie_driver);
> > --
> > 2.17.1
> >

--000000000000d18b2e05aef8415c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICraw6itsuHn
6lhHt6WdHF4uuSAGCqUTWtcYUa1y3m66MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMDkxMDE2NDI0MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA13+DB1ZzkhmZot0HlDhVSWLnzWjmR
X46KbyZIuXExNnTBl8o57ULJ/lCH4wsrZD63JiJewhep69ueF2em0YifCu/S2SN/ymCHK7dfMwBN
X/kgothX3iKIMwoinKodpZItFCyKzyXGWS2JndVFtUnYTNZt1UrN4gJJQMLSRzVHz/aC59npQUdX
Bt/Zt48cmWT37QmA3HorsZvG7c4FX8g0V0IMbJ3EPkIUwWgTKvknGtX3V7mVBqgkYs9s9oLDki2Y
uojIWa8v0PPMkWiOhahK6spzaTNwvOmsr5/Kc2S8uEk0gIAQVrZVoJImAoDFwJMm+MD11d1nhvBL
H07Cs6Jr
--000000000000d18b2e05aef8415c--
