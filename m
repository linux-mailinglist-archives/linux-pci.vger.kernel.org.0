Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB041F3E9B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 16:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgFIOtB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 10:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbgFIOs7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 10:48:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753B3C05BD1E;
        Tue,  9 Jun 2020 07:48:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f185so3434389wmf.3;
        Tue, 09 Jun 2020 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=6CLfL0PYCpo9/sjjq3Pl5AZJWHFL2uOpz/Dztx8aeO0=;
        b=XL1iSZjJSQ5MhKlhnL8T6g9LHqnuyYdRydWyCC+9v92TOQNIjcMhu/UxGSFvY1jZz5
         g+oFIU3u1s+gaOjEe9ocDGhy4O2qO6yhQS82GYd0LV3K66jhEU2N0HcILeW7j6qxxfXQ
         +upnlfARwVDYFlZ0R1ZhT4giyQkiorNawoyJ2z9K8nTDZBw6YQ/CZA6FiJLteNWl7KeG
         p+WbJhyp8O8CNbUNboBSFzCysLdNfcyDelq09pdejwoauxgALVGDnXbTAd7O5ff0zihB
         wXZWkt8SlnsutXgFeaRcRra3Sr6yEZ4zcCjiPgCNwmkP1TJI/sK44+uNQGd3w52FE/eX
         Bdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=6CLfL0PYCpo9/sjjq3Pl5AZJWHFL2uOpz/Dztx8aeO0=;
        b=t+dvEuzavK1xUUDw7ZRCg5LUk3zgwyotZD9T6gqSDkSX28nv84bZUEqlG+hfx9gc7p
         ELRipc+Sfgi8dcRkEXI8vYvpzIMjYSlggY9KX3m3gljU9/KSWf/PTdsMVT/BQRRyygpV
         DJFXhyLFHbatVnBHJ0YBQchUq/Pv1HlYWr2WiTUQt5vOPHah7cWH1SbrbPXkv/tEjL6Y
         zQsFOW7payLC+RtqBpzlQ7UlyPr+oBR2xxk9/bWqlIGGrSsMHfUsLpoFeQKDIUSaRbw6
         zkgQGj/kuLKSdSBmap2nonZ2qWhZa7HrigyjyH94i1PzwstnCvICXuk/t6kbrOJ/0Mg6
         AujQ==
X-Gm-Message-State: AOAM532O4vXmb1eXPbXsN5nBqkKar8vdtZuVscI8W3x1u1yXMT/e74TF
        uqrB/EewnDYtimIx1ZUQhnk=
X-Google-Smtp-Source: ABdhPJx+eS+1q+XyAEC5cT/WhRz+FTrfQiX+8KzvqvWw3uuqhCEwAxtFrOssvG/KaTBtRbauRy5g5w==
X-Received: by 2002:a7b:c7d8:: with SMTP id z24mr4272309wmk.28.1591714136162;
        Tue, 09 Jun 2020 07:48:56 -0700 (PDT)
Received: from AnsuelXPS (host-79-35-249-242.retail.telecomitalia.it. [79.35.249.242])
        by smtp.gmail.com with ESMTPSA id q11sm3673146wrv.67.2020.06.09.07.48.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 07:48:55 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Bjorn Helgaas'" <helgaas@kernel.org>
Cc:     "'Rob Herring'" <robh+dt@kernel.org>,
        "'Sham Muthayyan'" <smuthayy@codeaurora.org>,
        "'Rob Herring'" <robh@kernel.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Philipp Zabel'" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Varadarajan Narayanan'" <varada@codeaurora.org>
References: <001101d63900$4c7aae60$e5700b20$@gmail.com> <20200602172821.GA829015@bjorn-Precision-5520>
In-Reply-To: <20200602172821.GA829015@bjorn-Precision-5520>
Subject: R: R: [PATCH v5 11/11] PCI: qcom: Add Force GEN1 support
Date:   Tue, 9 Jun 2020 16:48:51 +0200
Message-ID: <021501d63e6d$18a82b40$49f881c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQJkqt5S0S2fXolDpAX0LAwRvYhr3qezhBMQ
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Messaggio originale-----
> Da: Bjorn Helgaas <helgaas@kernel.org>
> Inviato: marted=EC 2 giugno 2020 19:28
> A: ansuelsmth@gmail.com
> Cc: 'Rob Herring' <robh+dt@kernel.org>; 'Sham Muthayyan'
> <smuthayy@codeaurora.org>; 'Rob Herring' <robh@kernel.org>; 'Andy
> Gross' <agross@kernel.org>; 'Bjorn Andersson'
> <bjorn.andersson@linaro.org>; 'Bjorn Helgaas' <bhelgaas@google.com>;
> 'Mark Rutland' <mark.rutland@arm.com>; 'Stanimir Varbanov'
> <svarbanov@mm-sol.com>; 'Lorenzo Pieralisi'
> <lorenzo.pieralisi@arm.com>; 'Andrew Murray'
> <amurray@thegoodpenguin.co.uk>; 'Philipp Zabel'
> <p.zabel@pengutronix.de>; linux-arm-msm@vger.kernel.org; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Varadarajan Narayanan <varada@codeaurora.org>
> Oggetto: Re: R: [PATCH v5 11/11] PCI: qcom: Add Force GEN1 support
>=20
> [+cc Varada]
>=20
> On Tue, Jun 02, 2020 at 07:07:27PM +0200, ansuelsmth@gmail.com
> wrote:
> > > On Tue, Jun 02, 2020 at 01:53:52PM +0200, Ansuel Smith wrote:
> > > > From: Sham Muthayyan <smuthayy@codeaurora.org>
> > > >
> > > > Add Force GEN1 support needed in some ipq8064 board that needs =
to
> > > limit
> > > > some PCIe line to gen1 for some hardware limitation. This is set =
by
the
> > > > max-link-speed binding and needed by some soc based on ipq8064.
> (for
> > > > example Netgear R7800 router)
> > > >
> > > > Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> > > b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index 259b627bf890..0ce15d53c46e 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -27,6 +27,7 @@
> > > >  #include <linux/slab.h>
> > > >  #include <linux/types.h>
> > > >
> > > > +#include "../../pci.h"
> > > >  #include "pcie-designware.h"
> > > >
> > > >  #define PCIE20_PARF_SYS_CTRL			0x00
> > > > @@ -99,6 +100,8 @@
> > > >  #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
> > > >  #define SLV_ADDR_SPACE_SZ			0x10000000
> > > >
> > > > +#define PCIE20_LNK_CONTROL2_LINK_STATUS2	0xa0
> > > > +
> > > >  #define DEVICE_TYPE_RC				0x4
> > > >
> > > >  #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
> > > > @@ -195,6 +198,7 @@ struct qcom_pcie {
> > > >  	struct phy *phy;
> > > >  	struct gpio_desc *reset;
> > > >  	const struct qcom_pcie_ops *ops;
> > > > +	int gen;
> > > >  };
> > > >
> > > >  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> > > > @@ -395,6 +399,11 @@ static int qcom_pcie_init_2_1_0(struct
> > > qcom_pcie *pcie)
> > > >  	/* wait for clock acquisition */
> > > >  	usleep_range(1000, 1500);
> > > >
> > > > +	if (pcie->gen =3D=3D 1) {
> > > > +		val =3D readl(pci->dbi_base +
> > > PCIE20_LNK_CONTROL2_LINK_STATUS2);
> > > > +		val |=3D 1;
> > >
> > > Is this the same bit that's visible in config space as
> > > PCI_EXP_LNKSTA_CLS_2_5GB?  Why not use that #define?
> > >
> > > There are a bunch of other #defines in this file that look like
> > > redefinitions of standard things:
> > >
> > >   #define PCIE20_COMMAND_STATUS                   0x04
> > >     Looks like PCI_COMMAND
> > >
> > >   #define CMD_BME_VAL                             0x4
> > >     Looks like PCI_COMMAND_MASTER
> > >
> > >   #define PCIE20_DEVICE_CONTROL2_STATUS2          0x98
> > >     Looks like (PCIE20_CAP + PCI_EXP_DEVCTL2)
> > >
> > >   #define PCIE_CAP_CPL_TIMEOUT_DISABLE            0x10
> > >     Looks like PCI_EXP_DEVCTL2_COMP_TMOUT_DIS
> > >
> > >   #define PCIE20_CAP                              0x70
> > >     This one is obviously device-specific
> > >
> > >   #define PCIE20_CAP_LINK_CAPABILITIES            (PCIE20_CAP + =
0xC)
> > >     Looks like (PCIE20_CAP + PCI_EXP_LNKCAP)
> > >
> > >   #define PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT (BIT(10) |
> > > BIT(11))
> > >     Looks like PCI_EXP_LNKCAP_ASPMS
> > >
> > >   #define PCIE20_CAP_LINK_1                       (PCIE20_CAP + =
0x14)
> > >   #define PCIE_CAP_LINK1_VAL                      0x2FD7F
> > >     This looks like PCIE20_CAP_LINK_1 should be (PCIE20_CAP +
> > >     PCI_EXP_SLTCAP), but "CAP_LINK_1" doesn't sound like the Slot
> > >     Capabilities register, and I don't know what =
PCIE_CAP_LINK1_VAL
> > >     means.
> >
> > The define are used by ipq8074 and I really can't test the changes.
> > Anyway it shouldn't make a difference use the define instead of the
> > custom value so a patch should not harm anything... Problem is the
> > last 2 define that we really don't know what they are about... How
> > should I proceed? Change only the value related to
> > PCI_EXP_LNKSTA_CLS_2_5GB or change all the other except the last 2?
>=20
> I personally would change all the ones I mentioned above (in a
> separate patch from the one that adds "max-link-speed" support).
> Testing isn't a big deal because changing the #defines shouldn't
> change the generated code at all.
>=20
> PCIE20_CAP_LINK_1 / PCIE_CAP_LINK1_VAL looks like a potential bug or
> at least a very misleading name.  I wouldn't touch it unless we can
> figure out what's going on.
>=20
> Looks like most of this was added by 5d76117f070d ("PCI: qcom: Add
> support for IPQ8074 PCIe controller").  Shame on me for not asking
> these questions at the time.
>=20
> Sham, Varada, can you shed any light on PCIE20_CAP_LINK_1 and
> PCIE_CAP_LINK1_VAL?
>=20

Still no response. Should I push a v6 with this fix and leave the =
unknown
params
as they are?

> > > > +		writel(val, pci->dbi_base +
> > > PCIE20_LNK_CONTROL2_LINK_STATUS2);
> > > > +	}
> > > >
> > > >  	/* Set the Max TLP size to 2K, instead of using default of
4K */
> > > >  	writel(CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K,
> > > > @@ -1397,6 +1406,10 @@ static int qcom_pcie_probe(struct
> > > platform_device *pdev)
> > > >  		goto err_pm_runtime_put;
> > > >  	}
> > > >
> > > > +	pcie->gen =3D of_pci_get_max_link_speed(pdev->dev.of_node);
> > > > +	if (pcie->gen < 0)
> > > > +		pcie->gen =3D 2;
> > > > +
> > > >  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > > "parf");
> > > >  	pcie->parf =3D devm_ioremap_resource(dev, res);
> > > >  	if (IS_ERR(pcie->parf)) {
> > > > --
> > > > 2.25.1
> > > >
> >

