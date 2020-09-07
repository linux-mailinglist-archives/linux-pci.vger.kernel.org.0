Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37BA25F171
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 03:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgIGBSr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Sep 2020 21:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgIGBSq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Sep 2020 21:18:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F73CC061573;
        Sun,  6 Sep 2020 18:18:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so13990667wrn.13;
        Sun, 06 Sep 2020 18:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=r4T9j5dJ1/FQke9mPcxGRN0YcHVl+jeze7XH66yC04k=;
        b=UCyuuBVX8MNIvpPWO6Zqm3kMHeSTsPYMrXzEZ74BinWngymuHTeDP5L3e6iLP4kuBe
         7HXTwta5ASgPy4CjKMYNkBNF3U3hIy2FrajiUstN/mzlRti/7p1Z26KHhL0olpbnCNwy
         u3+m9rh29r1IJIhfgRWsY1+0DLxrujl894pMFAjVjsbZfq1g9hsXnyWvb6h3yv8hsNUI
         dj3AsmJ3xgEtNYpHAzqq859/5m2Ap6U+6YOguhq6hjYYWG9DNK7WstI0h/Bkdc92A2C6
         OcxOTZ8F9Bg8BHjJFDZizr8JkcGaaoAh8bmca2LKO4NBp3RI0sBl2hqPkLjUXMTdSCFF
         vveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=r4T9j5dJ1/FQke9mPcxGRN0YcHVl+jeze7XH66yC04k=;
        b=q60LSIf0/+BrJq3xzfwLp0xOglaML2fTIHPgGw9AkwNzMr0U78oE5QIeAyL8JDXFoI
         XiRKtL7pyvEWFKrAsblOhZoj1prAOVBR/DY+nR3sq2JQxQMXZGxFhS8Ngw0LlZyl/Rr+
         aBxvBMtWL/VcNot7z0jHcjARDQH1Ij7wcCgHMnxN3sfa2To4e+a2nQYP0KC+w0GX99JM
         4gZUl4Qz6cLknTHxC13AzZmxv6O+HyfRJqZkc98MiCOErNRz5GkGAI9RVApLRXBH3/TW
         Hv9QY4xvHz7AT3sJIS9HIhGjuKMp8yTA0WgyEkwYt2BLUrdAc4VN3XqMDPVsvMNci+26
         HX8Q==
X-Gm-Message-State: AOAM531haIz6MgiFr6Yo/VwIWAwxraO9ef2AVYPAGy0Q6p/tV+BDJIpJ
        LpLeWWDkNaR/rzQ3yfCwABdeg34Uz4g=
X-Google-Smtp-Source: ABdhPJygGOsrlVphUk2oBon0ztH/JbZeUQuUvYn18BAsBKvENvacgkpol2ebUmU++5IS8pF4Ql/pPw==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr19742323wrp.187.1599441524555;
        Sun, 06 Sep 2020 18:18:44 -0700 (PDT)
Received: from AnsuelXPS (host-95-251-120-70.retail.telecomitalia.it. [95.251.120.70])
        by smtp.gmail.com with ESMTPSA id m13sm25223822wrr.74.2020.09.06.18.18.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Sep 2020 18:18:43 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Ilia Mirkin'" <imirkin@alum.mit.edu>
Cc:     <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20200907011238.3401-1-imirkin@alum.mit.edu>
In-Reply-To: <20200907011238.3401-1-imirkin@alum.mit.edu>
Subject: R: [PATCH] PCI: qcom: don't clear out PHY_REFCLK_USE_PAD
Date:   Mon, 7 Sep 2020 03:18:41 +0200
Message-ID: <018401d684b4$d31162c0$79342840$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQHY0SUK+QbXAY/uJVDw58GDK9a3NqlXxlPQ
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Messaggio originale-----
> Da: Ilia Mirkin <ibmirkin@gmail.com> Per conto di Ilia Mirkin
> Inviato: luned=EC 7 settembre 2020 03:13
> A: ansuelsmth@gmail.com
> Cc: linux-arm-msm@vger.kernel.org; linux-pci@vger.kernel.org; Ilia =
Mirkin
> <imirkin@alum.mit.edu>
> Oggetto: [PATCH] PCI: qcom: don't clear out PHY_REFCLK_USE_PAD
>=20
> This makes PCIe links come up again on ifc6410 (apq8064).
>=20
> Fixes: de3c4bf6489 ("PCI: qcom: Add support for tx term offset for rev
> 2.1.0")
> Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> b/drivers/pci/controller/dwc/pcie-qcom.c
> index 3aac77a295ba..985b11cf6481 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -387,7 +387,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie
> *pcie)
>=20
>  	/* enable external reference clock */
>  	val =3D readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
> -	val &=3D ~PHY_REFCLK_USE_PAD;

To make sure this doesn't brake ipq806x, why not limit the &=3D to the =
ipq806x
compatible like we do up in the code? (or use the use_pad only if =
apq8064=20
compatible is not detected, to address ipq8064-v2 added later?)

>  	val |=3D PHY_REFCLK_SSP_EN;
>  	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
>=20
> --
> 2.26.2


