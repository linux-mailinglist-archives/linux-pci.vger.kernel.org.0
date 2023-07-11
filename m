Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0F274E99D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 10:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGKI7B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 04:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjGKI7A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 04:59:00 -0400
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 01:58:59 PDT
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79B1135
        for <linux-pci@vger.kernel.org>; Tue, 11 Jul 2023 01:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689065018; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=S3cTy0fsLuxO5P+6GpmQtIqvI7lr0Dqi0eY2pKCHqPewx7bymVIhkiQ83Io+iS8nSsHMkZZefkMvfK9KlVZQA190phU6vYT4bfbYZZFwa3QGy1atBo0KAFKitF8qta/Wnmj1lygrv+HnItGXwrfjnyXGfTSxW+FV6FXlTS8RQJE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1689065018; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=27498WPSjMT1LxPrnU8cRaKTNK5njVp4Ji5jHwrXcnE=; 
        b=i4YJZZQX2YKhPLzpaCqtd/VXM/0688Lr352U19TQxJs20/l9jM+UCL6JsIEbknCf5db156NUaR/IaQ6v/j1DuF8Fi7WMaUZhWGFT+CYVZB1p+r4Llcglc1ZaMLZXaK54YizWfsEMCX7wTP+BhGgL5y7QHEuGWRS32v62GCZQL+s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1689065018;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=27498WPSjMT1LxPrnU8cRaKTNK5njVp4Ji5jHwrXcnE=;
        b=enn5OXLldmHjVz3OsfTE6HG8RPulw4xUYK2vzqwXYDsy939W5WXdUQXmBsFKVEkv
        kKGYdX/4y+nZSqX2h5cDxj+6upZ8EtE/6NXIcZ+wcpwG4y7G+CCyyIiRSFqEREaP0v6
        4bhJ+knrvBxYCHuVi2XreLPCgEE9mGwFX0f/h2D8=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1689065018098331.1410899810264; Tue, 11 Jul 2023 01:43:38 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:43:38 +0800
From:   Li Chen <me@linux.beauty>
To:     "Verma, Achal" <a-verma1@ti.com>
Cc:     "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Tom Joseph" <tjoseph@cadence.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-omap" <linux-omap@vger.kernel.org>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <189441ed2ad.124e883f62543235.4120232059297538219@linux.beauty>
In-Reply-To: <ac95ffd2-50c6-f715-5c37-f658bacf4ca4@ti.com>
References: <1892e291fa4.1219137911620526.2248312811348305435@linux.beauty> <ac95ffd2-50c6-f715-5c37-f658bacf4ca4@ti.com>
Subject: Re: [PATCH 1/2] PCI: j721e: Allow async probe
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


 ---- On Tue, 11 Jul 2023 14:16:01 +0800  Verma, Achal  wrote ---=20
 >=20
 >=20
 > On 7/7/2023 7:53 AM, Li Chen wrote:
 > > From: Li Chen lchen@ambarella.com>
 > >=20
 > > I observed that on Ambarella SoC, which also utilizes
 > > the Cadence controller, the boot time increases by 1
 > > second when no endpoints (including switch) are connected
 > > to PCIe. This increase is caused by cdns_pcie_host_wait_for_link.
 > >=20
 > > Enabling async probe can eliminate this boot time increase.
 > >=20
 > > I guess j721e also has this issue.
 > I have tested this along with:
 > https://lore.kernel.org=20
 > /all/1892e2ae15f.f7e5dc061620757.4339091752690983066@linux.beauty/
 >=20
 > But I couldn't find second patch in this series.

Sorry for my mistake, the second patch is just the link you mentioned(https=
://lore.kernel.org/all/1892e2ae15f.f7e5dc061620757.4339091752690983066@linu=
x.beauty/), I accidentally removed its "2/2" prefix.

Should I post v2 to fix the subject issue?

 > >=20
 > > Signed-off-by: Li Chen lchen@ambarella.com>
 > Tested-by: Achal Verma a-verma1@ti.com>
 > > ---
 > >   drivers/pci/controller/cadence/pci-j721e.c | 1 +
 > >   1 file changed, 1 insertion(+)
 > >=20
 > > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/=
controller/cadence/pci-j721e.c
 > > index e70213c9060a..660c13bdb606 100644
 > > --- a/drivers/pci/controller/cadence/pci-j721e.c
 > > +++ b/drivers/pci/controller/cadence/pci-j721e.c
 > > @@ -561,6 +561,7 @@ static struct platform_driver j721e_pcie_driver =
=3D {
 > >   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=C2=A0=C2=
=A0=C2=A0=3D "j721e-pcie",
 > >   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.of_match_table =3D =
of_j721e_pcie_match,
 > >   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.suppress_bind_attrs=
 =3D true,
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe_type =3D PROBE=
_PREFER_ASYNCHRONOUS,
 > >   =C2=A0=C2=A0=C2=A0=C2=A0},
 > >   };
 > >   builtin_platform_driver(j721e_pcie_driver);
 >=20

Regards,
Li
