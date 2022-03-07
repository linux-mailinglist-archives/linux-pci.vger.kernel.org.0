Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8965E4CF3D9
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 09:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiCGInF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 03:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiCGIm7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 03:42:59 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A6754F88;
        Mon,  7 Mar 2022 00:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646642525; x=1678178525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CYDp9LwY8E/w662Qpkpqpqip6bbcmYnqEj5DmkGb4wM=;
  b=oRhqUzCiOdjF6yNFfqoquLHZyZWaF2Fp7E7GKimLrU6TvJlpNhbeja0+
   yfIAosqyubI/T/Q8GesV4WsSdW2NOoO2WeGIcYgTWHCc1ovaR6QV0FG9f
   uhevzcESzgIeQVbvzwWGWZcWpkHPqM8m1XcEGr5IxyfFLqi7VtLAgz8ER
   lb7hjz+S1gQhDqAV3xOwwLAxUdN62uJOzfjMLcSFm8nW7TMpTrr8Usld1
   rS6SEP/F3BicsCmHJStBWFt0IM2wLGoORriliRThFuWbNPtjm34H1PN8U
   vikS9j9G5b1s1LzMqoPQfkMhymR8iYlLbQcM1Bgf/tulx7dFfBYQESrs1
   g==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643670000"; 
   d="scan'208";a="22485416"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Mar 2022 09:42:02 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Mar 2022 09:42:02 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Mar 2022 09:42:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646642522; x=1678178522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CYDp9LwY8E/w662Qpkpqpqip6bbcmYnqEj5DmkGb4wM=;
  b=XsUPiSpIxXBaHYHnEX5+oduK7QnMuBHScuscsvGLdy+NF6BI4tbyKwZv
   FKYD5pVJ5BZ8H0unWq8nNX1NSNKCNsGlg1EoQLkIJt1GHbdBn86svbP6a
   Q/o2N/OkifvcP1HVfq47+ynB8gyS2WH+11obCky4pP882FCBoE3VwgQOI
   zQ5QjBsx4DTOx/19guWn9XFxiCn8vQ+l5bfvLc1Ewvb96DomeRYTY1X0b
   ZMMyrXAPfwVmyC+nZ4RT+RljKlhuv5LGIjDo/PV5VUY6PTe37yNnzCYWo
   47XjUlTm00gzYPdaIFkXwz1V+o2HV1UeZV4v4wL5DthqBvP2flUc/u8SU
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643670000"; 
   d="scan'208";a="22485415"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Mar 2022 09:42:02 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 83C39280065;
        Mon,  7 Mar 2022 09:42:02 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: (EXT) RE: (EXT) [PATCH v1 4/7] dt-bindings: imx6q-pcie: Add iMX8MP PCIe compatible string
Date:   Mon, 07 Mar 2022 09:42:02 +0100
Message-ID: <4386341.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <AS8PR04MB8676905699E85011E625BFE68C089@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646634556-23779-1-git-send-email-hongxing.zhu@nxp.com> <11939148.O9o76ZdvQC@steina-w> <AS8PR04MB8676905699E85011E625BFE68C089@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

Am Montag, 7. M=C3=A4rz 2022, 09:19:52 CET schrieb Hongxing Zhu:
> > -----Original Message-----
> > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Sent: 2022=E5=B9=B43=E6=9C=887=E6=97=A5 16:03
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: p.zabel@pengutronix.de; l.stach@pengutronix.de; bhelgaas@google.com;
> > lorenzo.pieralisi@arm.com; robh@kernel.org; shawnguo@kernel.org;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>; Hongxing Zhu <hongxing.zhu@nxp.com>
> > Subject: Re: (EXT) [PATCH v1 4/7] dt-bindings: imx6q-pcie: Add iMX8MP
> > PCIe
> > compatible string
> >=20
> > Hi Richard,
> >=20
> > thanks for providing a patch supporting PCie on iMX8MP.
> >=20
> > Am Montag, 7. M=C3=A4rz 2022, 07:29:13 CET schrieb Richard Zhu:
> >=20
> > > Add i.MX8MP PCIe compatible string.
> > >
> > >
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >=20
> > >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > >
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml index
> > > 36c8a06d17a0..252e5b72aee0 100644
> > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > @@ -26,6 +26,7 @@ properties:
> > >=20
> > >        - fsl,imx7d-pcie
> > >        - fsl,imx8mq-pcie
> > >        - fsl,imx8mm-pcie
> > >=20
> > > +      - fsl,imx8mp-pcie
> > >
> > >
> > >
> > >    reg:
> > >   =20
> > >      items:
> >=20
> >=20
> > Which branch is this based on? I don't have 'fsl,imx8mm-pcie' entry in =
my
> > tree.
 Another patch 7 also doesn't apply cleanly.
> >=20
>=20
> Hi Alexander:
> Thanks for your quick reply.

Thanks for your fast response. I just wanted to give it a try on our own=20
custom iMX8MP board. I did see the PCIe RC, but not EP (yet), no link up fo=
r=20
now.

> In the past days, I had summit some patches, and wait for ack or reviewed
> tags.
 But they might have some conflictions when do the codes merge.
> I'm waiting for the ack, and will re-base them in a proper sequence later.
>=20
> About the #4 patch apply, it's better to pick the following commit, since=
 it
> had
 Lucas' Reviewed-by tag, and wait for merge.
> https://patchwork.ozlabs.org/project/linux-pci/patch/1646293805-18248-1-g=
it-> send-email-hongxing.zhu@nxp.com/
=20
> About the #7 patch, I do the changes based on the following patch-set.
> https://patchwork.ozlabs.org/project/linux-pci/cover/1645760667-10510-1-g=
it-> send-email-hongxing.zhu@nxp.com/
=20
> I would add the dependency patch-set later in the cover-letter later.
> Sorry to bring in-conveniency to you.

Thanks I'll retry with the dependencies updated, so I hopefully won't miss=
=20
something.

> BTW, If you want to tests PCIe on i.MX8MM EVK board too, the following dts
> changes should be cherry-picked from Shawn's git.
> b4d36c10bf17 arm64: dts: imx8mm-evk: Add the pcie support on imx8mm evk
> board
 aaeba6a8e226 arm64: dts: imx8mm: Add the pcie support
> cfc5078432ca arm64: dts: imx8mm: Add the pcie phy support

Thanks I'll keep the imx8mm support in mind.

Best regards
Alexander



