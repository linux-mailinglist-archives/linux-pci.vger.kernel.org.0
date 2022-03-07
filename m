Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947324CF321
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 09:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiCGIEA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 03:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbiCGID7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 03:03:59 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB66D2BB29;
        Mon,  7 Mar 2022 00:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646640184; x=1678176184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XwvBg13gYha3GKzUexcw4i2Qs97JLoPQKDu0q5vkeoU=;
  b=p4ZMYeqIyA7m4N4mlj53NtnU1Qjy26k2Td2EGvE9d9JBYE59GWzklCDy
   JpG+JxacLuYtPCWKCZC9EQ6SDyLSKClTgQ+UpVV2kJ11QfS5tgAcN6xjt
   lGeIzLdWQrTQMzUcrCaW/jjQQp/91ezdYywJd4nEbVFW7aJejHo8d0FBS
   vCyJSL956+jv/7ilyn/waG1JBbRhRloVYQjMvxA/KEDLid0CjNvSnAV4c
   LVTkjWaBDgF1UWtsiWmhcZ+VoauXY7ZBy9cjr+HESnslMq20KN+e50Bav
   CGmuwYIW4orgkh0KRuMapb5RDVFcnYHwEKVlCahXfTEPtdbeCLBXfYsrA
   w==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643670000"; 
   d="scan'208";a="22482837"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Mar 2022 09:03:00 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Mar 2022 09:03:00 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Mar 2022 09:03:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646640180; x=1678176180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XwvBg13gYha3GKzUexcw4i2Qs97JLoPQKDu0q5vkeoU=;
  b=MJfcm0OOYbqBM6snxtJdUUdtEdNVdEpTFmOMMdgauHUkO9CFPPg0dl4j
   sf7Ra6s/URzXAjeo9RVfMvBrg2qXVOGybTLwDWwda3PnsURD9R+EZmfcB
   9L8XvyXVm0b//tC4ouMWGv6lr3ZAQ14IXea3mZ5qoOD2vSQNoMkUl4Ob6
   1gIPfVcxo3rpZJlqx63dj3RJzFBLTbiZJcpE9hC3bnbz7g3Q6yUilVrCs
   oCBc7AsBRHlbr+Nwt6UXe9W4f8tLhh1HK4QaKMU4ESLaeCLfF/VJFQ3TV
   gFrw2/HCsya527QclKgCDfrrHP3a5EBJoZP2rDyhA7zu4077AUsYfjl67
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643670000"; 
   d="scan'208";a="22482836"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Mar 2022 09:03:00 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 7069B280065;
        Mon,  7 Mar 2022 09:03:00 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: (EXT) [PATCH v1 4/7] dt-bindings: imx6q-pcie: Add iMX8MP PCIe compatible string
Date:   Mon, 07 Mar 2022 09:02:58 +0100
Message-ID: <11939148.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <1646634556-23779-5-git-send-email-hongxing.zhu@nxp.com>
References: <1646634556-23779-1-git-send-email-hongxing.zhu@nxp.com> <1646634556-23779-5-git-send-email-hongxing.zhu@nxp.com>
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

Hi Richard,

thanks for providing a patch supporting PCie on iMX8MP.

Am Montag, 7. M=E4rz 2022, 07:29:13 CET schrieb Richard Zhu:
> Add i.MX8MP PCIe compatible string.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml index
> 36c8a06d17a0..252e5b72aee0 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -26,6 +26,7 @@ properties:
>        - fsl,imx7d-pcie
>        - fsl,imx8mq-pcie
>        - fsl,imx8mm-pcie
> +      - fsl,imx8mp-pcie
>=20
>    reg:
>      items:

Which branch is this based on? I don't have 'fsl,imx8mm-pcie' entry in my=20
tree. Another patch 7 also doesn't apply cleanly.

Regards
Alexander


