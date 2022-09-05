Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7785AD328
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 14:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiIEMmr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 08:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbiIEMmb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 08:42:31 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F05D6052D
        for <linux-pci@vger.kernel.org>; Mon,  5 Sep 2022 05:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1662381448; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IbJUiBFOs3gsxBVxYTc17nUX6xMg6bVIqxfB0QQdvENdXwe1Ek3sVSSQf1fTBxcOCznMn8kgR+Mnc6VXeNsBoJuQmdqIE/GXSLoEssdC0HFRmR5/h8emP2gqop1T+KUIE292brUzYfjwZZF0fl2MYZm4oizsJzaTykOQouygYPo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1662381448; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=qwdtaNPJ7CpnHPyO3312RrwKuu4DnM5l7GBP2xaGiP8=; 
        b=ak4dr4HvEjl8kFk0Pi8H8XQySrLCGyifGWtZ+5LLl3vtX7wt0SwZhYIt1XyLyXfl4F0WvFsNIMdO8foBpY+uPzF1wTzYeOQ9t80FlFEsNHmDXeXe9VcsXTh1vDqCFVfYOgiZweirRiCaD5MQKYH7jG/HlGiuweZy+W5GKLX1bGc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1662381448;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=qwdtaNPJ7CpnHPyO3312RrwKuu4DnM5l7GBP2xaGiP8=;
        b=PD+m2VqSc+UZLAnhEqgfnx4WKRxMCL2fztFXwh8mWXStK1YA3B+gxXWF1pxgzlci
        tXIUfVJVYx2RcG/7L5msqDz26SnRC8UfRDubbYfsUnm9gP39B16kcqNZVAtWqWhWBLO
        epRJj21Jf/bX1gekDab+yBHz8JNJEsfQAun3FFck=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1662381446042942.12690892832; Mon, 5 Sep 2022 05:37:26 -0700 (PDT)
Date:   Mon, 05 Sep 2022 14:37:26 +0200
From:   Li Chen <me@linux.beauty>
To:     "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>
Cc:     "Li Chen" <lchen@ambarella.com>, "Rob Herring" <robh@kernel.org>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci" <linux-pci@vger.kernel.org>
Message-ID: <1830da7d38a.bb0e7f41249614.5963135252161347223@linux.beauty>
In-Reply-To: <20220905033702.905-1-me@linux.beauty>
References: <20220905033702.905-1-me@linux.beauty>
Subject: Re: [PATCH] PCI: cadence: remove unused cdns_plat_pcie->is_rc
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ linux-pci

 ---- On Mon, 05 Sep 2022 05:37:03 +0200  Li Chen  wrote ---=20
 > From: Li Chen lchen@ambarella.com>
 >=20
 > We already have cdns_plat_pcie_of_data->is_rc.
 >=20
 > Signed-off-by: Li Chen lchen@ambarella.com>
 > ---
 >  drivers/pci/controller/cadence/pcie-cadence-plat.c | 5 -----
 >  1 file changed, 5 deletions(-)
 >=20
 > diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/driver=
s/pci/controller/cadence/pcie-cadence-plat.c
 > index bac0541317c1..e091fef9c919 100644
 > --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
 > +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
 > @@ -18,12 +18,9 @@
 >  /**
 >   * struct cdns_plat_pcie - private data for this PCIe platform driver
 >   * @pcie: Cadence PCIe controller
 > - * @is_rc: Set to 1 indicates the PCIe controller mode is Root Complex,
 > - *         if 0 it is in Endpoint mode.
 >   */
 >  struct cdns_plat_pcie {
 >  =C2=A0=C2=A0=C2=A0=C2=A0struct cdns_pcie        *pcie;
 > -=C2=A0=C2=A0=C2=A0=C2=A0bool is_rc;
 >  };
 > =20
 >  struct cdns_plat_pcie_of_data {
 > @@ -77,7 +74,6 @@ static int cdns_plat_pcie_probe(struct platform_device=
 *pdev)
 >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc->pcie.dev =3D dev;
 >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc->pcie.ops =3D &cdns_=
plat_ops;
 >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cdns_plat_pcie->pcie =
=3D &rc->pcie;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cdns_plat_pcie->is_rc =
=3D is_rc;
 > =20
 >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D cdns_pcie_init_=
phy(dev, cdns_plat_pcie->pcie);
 >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret) {
 > @@ -105,7 +101,6 @@ static int cdns_plat_pcie_probe(struct platform_devi=
ce *pdev)
 >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ep->pcie.dev =3D dev;
 >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ep->pcie.ops =3D &cdns_=
plat_ops;
 >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cdns_plat_pcie->pcie =
=3D &ep->pcie;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cdns_plat_pcie->is_rc =
=3D is_rc;
 > =20
 >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D cdns_pcie_init_=
phy(dev, cdns_plat_pcie->pcie);
 >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret) {
 > --=20
 > 2.37.2
 >=20
 >=20
