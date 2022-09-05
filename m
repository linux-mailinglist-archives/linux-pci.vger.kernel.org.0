Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D538E5AD31B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbiIEMme (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 08:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiIEMmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 08:42:19 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCBF57549
        for <linux-pci@vger.kernel.org>; Mon,  5 Sep 2022 05:36:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1662381369; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jzwSuOh6IJATZwHuNsL2y3mE66WyyVuUFp3OBkhdI3/nlNbi6vC3BJ4xysnolbAVJE6FC8ZFSsK/WCc/KxcJAXYA346F+1a+V7XPBiywyHt1sNguJipYrz2DP4PQQYc7KXTrE+lRE9WQ2Kysm8GGXFpvg4CSYqZI9dTSonpmurw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1662381369; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=3BFTEIuXaBmXMdXcV1jx9dIUHzC/SjpIjDhf75BBcss=; 
        b=MoQyPoRt/+e/Rlk/cODfKJwXeKlCZHiGZBQuw8xxmxgiSUcC+13XFfXt7kujQqSWyalCYUeQeJCnWdAJi50GnG6OfejymNVb03fdLVUBQlxQWV3o93TEWgxbfNJPQEp2QDxAFPFqu0ONkJtAO2yhCv8FHay3L+49CdRHouKgl0A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1662381369;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=3BFTEIuXaBmXMdXcV1jx9dIUHzC/SjpIjDhf75BBcss=;
        b=d7t/G9DcrAMChGDU4exE8mGZ8EeyRCprpzJkpLTmoQ9Ntg207btUiAZpZWuIojcq
        48WY1MDgab2CynJC9KFPgF1K5DABeMHFXQu22B+gFfY0Puy6Bkk1njBE61rW1+IpOE6
        QXwmjhYURp4BfDJbuuJSR6G3+Gw9Du0BLf3l+CVU=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1662381368410660.5514011608086; Mon, 5 Sep 2022 05:36:08 -0700 (PDT)
Date:   Mon, 05 Sep 2022 14:36:08 +0200
From:   Li Chen <me@linux.beauty>
To:     "Kishon Vijay Abraham I" <kishon@ti.com>
Cc:     "Li Chen" <lchen@ambarella.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci" <linux-pci@vger.kernel.org>
Message-ID: <1830da6a447.105bbdc74249232.3098870178344058001@linux.beauty>
In-Reply-To: <1830da34e6e.f4f852ec248192.8946829485125284701@linux.beauty>
References: <1830da34e6e.f4f852ec248192.8946829485125284701@linux.beauty>
Subject: Re: [PATCH] PCI: j721e: remove redundant error message
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

 ---- On Mon, 05 Sep 2022 14:32:29 +0200  Li Chen  wrote ---=20
 > From: Li Chen lchen@ambarella.com>
 >=20
 > This error message will also be reported by
 > j721e_pcie_ctrl_init when check j721e_pcie_set_mode
 > return value, so remove it.
 >=20
 > Signed-off-by: Li Chen lchen@ambarella.com>
 > ---
 >  drivers/pci/controller/cadence/pci-j721e.c | 7 +------
 >  1 file changed, 1 insertion(+), 6 deletions(-)
 >=20
 > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/co=
ntroller/cadence/pci-j721e.c
 > index a82f845cc4b5..360a3cc1fae3 100644
 > --- a/drivers/pci/controller/cadence/pci-j721e.c
 > +++ b/drivers/pci/controller/cadence/pci-j721e.c
 > @@ -169,16 +169,11 @@ static int j721e_pcie_set_mode(struct j721e_pcie *=
pcie, struct regmap *syscon,
 >  =C2=A0=C2=A0=C2=A0=C2=A0u32 mask =3D J721E_MODE_RC;
 >  =C2=A0=C2=A0=C2=A0=C2=A0u32 mode =3D pcie->mode;
 >  =C2=A0=C2=A0=C2=A0=C2=A0u32 val =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0int ret =3D 0;
 > =20
 >  =C2=A0=C2=A0=C2=A0=C2=A0if (mode =3D=3D PCI_MODE_RC)
 >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val =3D J721E_MODE_RC;
 > =20
 > -=C2=A0=C2=A0=C2=A0=C2=A0ret =3D regmap_update_bits(syscon, offset, mask=
, val);
 > -=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(dev, "failed to=
 set pcie mode\n");
 > -
 > -=C2=A0=C2=A0=C2=A0=C2=A0return ret;
 > +=C2=A0=C2=A0=C2=A0=C2=A0return regmap_update_bits(syscon, offset, mask,=
 val);
 >  }
 > =20
 >  static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
 > --=20
 > 2.37.2
 >=20
 >=20
 >=20
