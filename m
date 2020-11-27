Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40582C6C8A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Nov 2020 21:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbgK0U1e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Nov 2020 15:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbgK0U1J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Nov 2020 15:27:09 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77F2C061A48
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2020 12:27:08 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so6814777wrt.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2020 12:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjutnm/tdp1OGf5r7bjxpgf0BLfV0TLSZ10wLJdz8N0=;
        b=HH/fVvChf3J0DZF7OGLyAWkS9VLkg7bMjsWoRCdZTY3ov8mADQ++IrsaFgt415Nwv4
         e7+/R5Bry/gpzoOCLRbTOAj70RBwyq3c/unbMLzE39R3pHQkRiA0LaaNFSYWSzFnffPj
         OxUc0jkivxn2KYC/WGE/O+h2XqiYsdoKR25JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjutnm/tdp1OGf5r7bjxpgf0BLfV0TLSZ10wLJdz8N0=;
        b=KovAx4mzmD+Bm2HJ8UxDwWKq8y2V1moafF2tqoOn5Ze3dkF+XR83muFlkROJqvfLM4
         8sTfshWGw6vULKw1jsThvmWUiXAAm6cVtY4nqD3tv5qQzzA0QND8vGrDhvVEq0LkhtWC
         PEb6hzEPkh4jqrb97zsD94uggO9bqu/5AyyS6AKP+X9/Pakfsy6jEfxL3LSacfSn9Pt9
         w+5epARQNuzqHN9olIPolmy+J2gdSz3LwiGi4EwwWEAzb3vuhP6kdwKfM0+wpt/STTKh
         cAhny90INiFd167LsouFeLc5uR3iYmwVSXXaMCSmKnDEUNYzKBiHjmb4SmyBxbXAwpry
         9+bQ==
X-Gm-Message-State: AOAM533F04C/XayH+IauysCDZChftXGb2TlhJkM+hEkAAtDyWob0fXmL
        8iMR2KaZqCxK96/vHUjHP0S/Ts1fw3PTxMGXuO9VMw==
X-Google-Smtp-Source: ABdhPJycINbYlFrxM+8Y0qB9kNd/iHdNHLxdi0upTfsU9Pj1jtLTkICNetjf14tjbtvT5wyL2z1sVPSj84G0akOXBwY=
X-Received: by 2002:a5d:5552:: with SMTP id g18mr12960850wrw.145.1606508827510;
 Fri, 27 Nov 2020 12:27:07 -0800 (PST)
MIME-Version: 1.0
References: <20201125192424.14440-1-james.quinlan@broadcom.com>
 <20201125192424.14440-3-james.quinlan@broadcom.com> <20201126114912.GA8506@sirena.org.uk>
In-Reply-To: <20201126114912.GA8506@sirena.org.uk>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 27 Nov 2020 15:26:53 -0500
Message-ID: <CA+-6iNzJAf_bKVjbw8bkh3qmSU++m6-DoFKQvBTTZGonYJGXfg@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] PCI: brcmstb: Add control of EP voltage regulator(s)
To:     Mark Brown <broonie@kernel.org>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000366e705b51c7c62"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000000366e705b51c7c62
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 26, 2020 at 6:49 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Nov 25, 2020 at 02:24:19PM -0500, Jim Quinlan wrote:
>
> > +     for (i = 0; i < PCIE_REGULATORS_MAX; i++) {
> > +             ep_reg = devm_regulator_get_optional(dev, ep_regulator_names[i]);
> > +             if (IS_ERR(ep_reg)) {
>
> Does PCI allow supplies to be physically absent?  If not then the driver
> shouldn't be using regulator_get_optional() and much of the code here
> can be deleted.
Hi Mark,

First, as an aside, I'm  a little confused about the purpose of
devm_regulator_get_optional(...);  the other  xxx_get_optional() calls
I am familiar with (eg clock, reset, gpio) return NULL if the desired
item does not exist, and then NULL can be used as a valid pointer for
the rest of the API.  Not so here.

At any rate, our SOCs are placed in a variety of boards which
implement the PCIe RC-EP connection as they wish.  From the PCIe
driver's point of view, the type of power supply that needs to be
turned on is specified in the DT and they cannot be hard coded by the
driver.  I've listed all of the four possibilities; typically one,
maybe two will  be specified, but never all of them.  In addition,
sometimes a regulator is hard wired on and not even controllable by
the PCIe controller.

>
> > +static void brcm_set_regulators(struct brcm_pcie *pcie, bool on)
> > +{
>
> This is open coding the regulator bulk APIs.
Except that a bulk regulator "get"  requires that all supplies are
present.  I would have to first scan the node's properties for the
"-supply" properties and fill in the bulk regulator structure.  I'm
fine with doing that.

However, a previous incarnation of this  commit was reviewed by RobH,
and if I understood him correctly he wanted the actual names of the
possible regulators to be used and specified in the bindings doc.   I
just followed the example of "pcie-rockchip-host.c" whose bindings doc
was reviewed by RobH.

Regards,
Jim Quinlan
Broadcom STB

--0000000000000366e705b51c7c62
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
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAeEHFJnrj2k
0Bnz6tReJ/6wBrIPbcSVieWDWc2GPlnqMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTEyNzIwMjcwN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAkCc4MgUQCkxfVl6nCf6mMW43nvrNz
bbAtfGfz1Mn5Xh+9NAD+6/ym2UIElmluNN0smNT9IdqFq6IwtwapWMzNW9PoqZsAiU+EMbl027Ts
FvArOB7OJzm6tm5e08N541wjxtVU5B4Tbpu4yT1KuWCez5sD8zXKUk+yD+E1s7v6osiufY+AtUdl
2FwvWfM8b6E/jxYn7nikwIMquXYB61sU9DUDqz4Fi3rNRefOsGfcxmMI4QceqJZ/JbdNDxEmVLcB
/Qc3DTYyKFNFBLVsvhWSs3JB6eeWe/N8zfuSRd/Z1lLLY6r6k7Bbba81/jEToHnDM4HSOXcVWGt/
tHRWmQk9
--0000000000000366e705b51c7c62--
