Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF764D2A25
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 09:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiCIH6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 02:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiCIH6W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 02:58:22 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547E4163072;
        Tue,  8 Mar 2022 23:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646812630; x=1678348630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZlR3V5nWOBvDPK9gJV01W4WbYt70nLP2OxZKb/+mUw=;
  b=aLwECnsk1po3RyCbI/+Tz44Cvkd4nMxa/x5h6PA53lwFJV8viWTjfOCm
   u1dz6q/AY1hFSgEnZD2z6fUDtt/qXGTKX3Z51KTOM/nriQS+097N0Xgb3
   1uysEH8FyZI3B871S+XyoRM6bkCFBOvIc0MfoBzepEWOiO/qd6+3gJcuL
   vQ3tbOsCxTTxmMz/8Gu+DU5ALNAqLYgk2cFgv+Oc0ZB1qOm0fuF3ewn0V
   akZtnQtK78jpG1Xw0UCOKV9NRgPk0wIzM7ulcptqqjCppjeJPS1kJVGIA
   Ngfjagxl+LZUh6/rIakdcaI/EXQsqeyVDD4aEzKitgs3u62rDDWLXh2kx
   g==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643670000"; 
   d="scan'208";a="22544451"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Mar 2022 08:57:08 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 09 Mar 2022 08:57:08 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 09 Mar 2022 08:57:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646812628; x=1678348628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZlR3V5nWOBvDPK9gJV01W4WbYt70nLP2OxZKb/+mUw=;
  b=Iz9GJDsFsbHvUMh0pLrQbbDH4q1lirwAkZfxoRvmzTYSudDzWtv/gnjt
   D1tRHMQmtslkIAiGxZBaqfc6Ef4iDrbTVXgBt8YQJYw8JFBvFB2mCNg73
   tjxm5gMjNriaxCrAkHIEU0punMESwZL73/LHdppF8ey2sd/kFW9Z3COrA
   d9l1YxTwrLbJfO0j19hAqbsW5ZPReevArZpaAYAPHYV2Tmb/SCtRJzGXy
   DH6HiaGRwvc7vOeRrkUSt/v4Vf7WA4MuiH2X9r4ECsLItFnda5W1Yhu1M
   0laeu1Rpqya6wYytNdBpEw3G+R/BDxOcEPanCOPBx55zrYN7Po1Ya2iKP
   A==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643670000"; 
   d="scan'208";a="22544450"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Mar 2022 08:57:08 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 26BAC280065;
        Wed,  9 Mar 2022 08:57:08 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: (EXT) [PATCH v2 0/7] Add the iMX8MP PCIe support
Date:   Wed, 09 Mar 2022 08:57:05 +0100
Message-ID: <4743587.31r3eYUQgx@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Richard,

Am Montag, 7. M=E4rz 2022, 10:07:27 CET schrieb Richard Zhu:
> Based on the i.MX8MP GPC and blk-ctrl patch-set[1] issued by Lucas and the
> following commits.
>   - one codes refine patch-set[5].
>   - two Fixes[2],[3].
>   - one binding commit[4].
>   - some dts changes in Shawn's git if you want to test PCIe on i.MX8MM E=
VK.
> b4d36c10bf17 arm64: dts: imx8mm-evk: Add the pcie support on imx8mm evk
> board aaeba6a8e226 arm64: dts: imx8mm: Add the pcie support
>     cfc5078432ca arm64: dts: imx8mm: Add the pcie phy support
>=20
> Sorry about that there may be some conflictions when do the codes merge.
> I'm waiting for the ack now, and will re-base them in a proper sequence
> later.

Thanks for providing the dependency list. Unfortunately they did not apply=
=20
without error on my local tree, but this is caused by other patches I track.
I managed to fix the conflicts, I think.
Eventually I was able to get a PCIe M.2 ethernet interface working on my=20
TQMa8MPxL based board. iperf showed >900MBit/s Tx and > 700 MBit/s Rx.
Thanks for your effort. Once the depenencies and reviews are settled, you'l=
l=20
get my tested-by.

Thanks again and regards
Alexander

> This series patches add the i.MX8MP PCIe support and tested on i.MX8MM EVK
> and i.MX8MP EVk boards. The PCIe NVME works fine on both boards.
>=20
> - i.MX8MP PCIe PHY has two resets refer to the i.MX8MM PCIe PHY.
>   Add one more PHY reset for i.MX8MP PCIe PHY accordingly.
> - Add the i.MX8MP PCIe PHY support in the i.MX8M PCIe PHY driver.
>   And share as much as possible codes with i.MX8MM PCIe PHY.
> - Add the i.MX8MP PCIe support in binding document, DTS files, and PCIe
>   driver.
>=20
> Main changes v1-->v2:
> - It's my fault forget including Vinod, re-send v2 after include Vinod
>   and linux-phy@lists.infradead.org.
> - List the basements of this patch-set. The branch, codes changes and so =
on.
> - Clean up some useless register and bit definitions in #3 patch.
>=20
> [1]https://patchwork.kernel.org/project/linux-arm-kernel/cover/2022022820=
173
> 1.3330192-1-l.stach@pengutronix.de/
> [2]https://patchwork.ozlabs.org/project/linux-pci/patch/1646289275-17813-=
1-> git-send-email-hongxing.zhu@nxp.com/
> [3]https://patchwork.ozlabs.org/project/linux-pci/patch/1645672013-8949-1=
=2Dg
> it-send-email-hongxing.zhu@nxp.com/
> [4]https://patchwork.ozlabs.org/project/linux-pci/patch/1646293805-18248-=
1-> git-send-email-hongxing.zhu@nxp.com/
> [5]https://patchwork.ozlabs.org/project/linux-pci/cover/1645760667-10510-=
1-> git-send-email-hongxing.zhu@nxp.com/
>=20
> NOTE:
> Based git <git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.g=
it>
> Based branch <pci/imx6>
>=20
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   1 +
> Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |   4 +-
> arch/arm64/boot/dts/freescale/imx8mp-evk.dts                 |  55
> ++++++++++++++++++++++ arch/arm64/boot/dts/freescale/imx8mp.dtsi         =
 =20
>         |  46 ++++++++++++++++++- drivers/pci/controller/dwc/pci-imx6.c  =
 =20
>                    |  19 +++++++-
> drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 205
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------=
=2D-
> ------- drivers/reset/reset-imx7.c                                   |   =
1 +
> 7 files changed, 286 insertions(+), 45 deletions(-)
>=20
> [PATCH v2 1/7] reset: imx7: Add the iMX8MP PCIe PHY PERST support
> [PATCH v2 2/7] dt-binding: phy: Add iMX8MP PCIe PHY binding
> [PATCH v2 3/7] phy: freescale: imx8m-pcie: Add iMX8MP PCIe PHY
> [PATCH v2 4/7] dt-bindings: imx6q-pcie: Add iMX8MP PCIe compatible
> [PATCH v2 5/7] arm64: dts: imx8mp: add the iMX8MP PCIe support
> [PATCH v2 6/7] arm64: dts: imx8mp-evk: Add PCIe support
> [PATCH v2 7/7] PCI: imx6: Add the iMX8MP PCIe support




