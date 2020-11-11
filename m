Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D192AF650
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 17:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgKKQ1o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 11:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgKKQ1n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 11:27:43 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C432C0613D1;
        Wed, 11 Nov 2020 08:27:42 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w14so1902849pfd.7;
        Wed, 11 Nov 2020 08:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=jq0Fl4LSGmmSuLHQQ80MHagMMFXsLMgG0lTQ4r3ZmmU=;
        b=nqRDy7mZc8wD25DDRob0F15nj3LL2kN+DdDForcpp3RRNn8kl4lO94nQumvF+fPdBC
         oja4SvLywCDd4mOAo7Gie97VAtuiRQhrtubP16gHjYATmyoDWYuHQ0tB7YoMDZZ4XhdI
         IZE/1CN/xrDIWp64PRDz0sB42vMjeRkywLf98BXhMegysS23lZ++isUP+OpkSnp1mylt
         ZQMfpbDn79n+Fmeka2g8ouxLhoUGEwxZpMcW38G9JkjnGlIo8OoGghGm2Bir+JlBK0E7
         k74FCuyCo0Dig9PKcu+tXBtLaWHZ7QnSaZGlVNsgKax/6QkayzFi55AJrAdUuJFg5U2M
         nqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=jq0Fl4LSGmmSuLHQQ80MHagMMFXsLMgG0lTQ4r3ZmmU=;
        b=DfMjeW2LfHXKFdiniyjHue7ZdeWmKltgDPSKRKRdceK4dCqedrDV0TeZlpQG9TyghT
         dUqgdNksrsLEjwjUSmOYCR28FuCuHIt9i308hzLyvG5hJK8XYv6Mld9SC9mT3KflH1U7
         64aYx+37AQjV5lj6O9781usZU/9hZJbISnz2ecTUDPbCHPTn0DDy4U3zXDfu+0qvxPDv
         wOPGsx9hTgC5/rbrffWz2I5kCQ+zs+oB31bAllqDPJjuFDhawnXr9Gxm6PJtHo5MftuO
         uXLe0V/jPELocJQSk9aSKA2Xy4QNYb2VukfpRD4XPGS0awd2jVUiUcbtbzA8kLkNG+AB
         f3LQ==
X-Gm-Message-State: AOAM53088GPd3RgDW3xWcjRNtRE6JzRs8s51P9uycYpzFP2p0Oy0R54L
        IL5v2Ov/h0OFbL3/eoHY1sc=
X-Google-Smtp-Source: ABdhPJzm94wVpuCQqu0j4L0ECmSTqAkndcvvw8TIJ1ogm9qPl7O3dvt385dhL+RudI54bGfUs+4orw==
X-Received: by 2002:a63:50c:: with SMTP id 12mr22354759pgf.151.1605112061542;
        Wed, 11 Nov 2020 08:27:41 -0800 (PST)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id h7sm3549409pgi.90.2020.11.11.08.27.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2020 08:27:40 -0800 (PST)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH V2] PCI: dwc: Add support to configure for ECRC
Thread-Topic: [PATCH V2] PCI: dwc: Add support to configure for ECRC
Thread-Index: AQHWuCPjvjFVeyl1T0updkl6tiYyg6nDHtIC
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Wed, 11 Nov 2020 16:27:33 +0000
Message-ID: <SLXP216MB0477F0B10AEBEAD996EE66D3AAE80@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201109192611.16104-1-vidyas@nvidia.com>
 <20201111121145.7015-1-vidyas@nvidia.com>
In-Reply-To: <20201111121145.7015-1-vidyas@nvidia.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/11/20, 7:12 AM, Vidya Sagar wrote:
>=20
> DesignWare core has a TLP digest (TD) override bit in one of the control
> registers of ATU. This bit also needs to be programmed for proper ECRC
> functionality. This is currently identified as an issue with DesignWare
> IP version 4.90a.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> V2:
> * Addressed Bjorn's comments
>
>  drivers/pci/controller/dwc/pcie-designware.c | 52 ++++++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h |  1 +
>  2 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index c2dea8fc97c8..ec0d13ab6bad 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -225,6 +225,46 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie =
*pci, u32 index, u32 reg,
>  	dw_pcie_writel_atu(pci, offset + reg, val);
>  }
>
> +static inline u32 dw_pcie_enable_ecrc(u32 val)

What is the reason to use inline here?


Best regards,
Jingoo Han

> +{
> +	/*
> +	 * DesignWare core version 4.90A has this strange design issue
> +	 * where the 'TD' bit in the Control register-1 of the ATU outbound
> +	 * region acts like an override for the ECRC setting i.e. the presence
> +	 * of TLP Digest(ECRC) in the outgoing TLPs is solely determined by
> +	 * this bit. This is contrary to the PCIe spec which says that the
> +	 * enablement of the ECRC is solely determined by the AER registers.
> +	 *
> +	 * Because of this, even when the ECRC is enabled through AER
> +	 * registers, the transactions going through ATU won't have TLP Digest
> +	 * as there is no way the AER sub-system could program the TD bit which
> +	 * is specific to DesignWare core.
> +	 *
> +	 * The best way to handle this scenario is to program the TD bit
> +	 * always. It affects only the traffic from root port to downstream
> +	 * devices.
> +	 *
> +	 * At this point,
> +	 * When ECRC is enabled in AER registers, everything works normally
> +	 * When ECRC is NOT enabled in AER registers, then,
> +	 * on Root Port:- TLP Digest (DWord size) gets appended to each packet
> +	 *                even through it is not required. Since downstream
> +	 *                TLPs are mostly for configuration accesses and BAR
> +	 *                accesses, they are not in critical path and won't
> +	 *                have much negative effect on the performance.
> +	 * on End Point:- TLP Digest is received for some/all the packets comin=
g
> +	 *                from the root port. TLP Digest is ignored because,
> +	 *                as per the PCIe Spec r5.0 v1.0 section 2.2.3
> +	 *                "TLP Digest Rules", when an endpoint receives TLP
> +	 *                Digest when its ECRC check functionality is disabled
> +	 *                in AER registers, received TLP Digest is just ignored=
.
> +	 * Since there is no issue or error reported either side, best way to
> +	 * handle the scenario is to program TD bit by default.
> +	 */
> +
> +	return val | PCIE_ATU_TD;
> +}
> +
>  static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 fun=
c_no,
>  					     int index, int type,
>  					     u64 cpu_addr, u64 pci_addr,
> @@ -245,8 +285,10 @@ static void dw_pcie_prog_outbound_atu_unroll(struct =
dw_pcie *pci, u8 func_no,
>  				 lower_32_bits(pci_addr));
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>  				 upper_32_bits(pci_addr));
> -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> -				 type | PCIE_ATU_FUNC_NUM(func_no));
> +	val =3D type | PCIE_ATU_FUNC_NUM(func_no);
> +	if (pci->version =3D=3D 0x490A)
> +		val =3D dw_pcie_enable_ecrc(val);
> +	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
>  				 PCIE_ATU_ENABLE);
>
> @@ -292,8 +334,10 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pc=
ie *pci, u8 func_no,
>  			   lower_32_bits(pci_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
>  			   upper_32_bits(pci_addr));
> -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
> -			   PCIE_ATU_FUNC_NUM(func_no));
> +	val =3D type | PCIE_ATU_FUNC_NUM(func_no);
> +	if (pci->version =3D=3D 0x490A)
> +		val =3D dw_pcie_enable_ecrc(val);
> +	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
>
>  	/*
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 9d2f511f13fa..285c0ae364ae 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -88,6 +88,7 @@
>  #define PCIE_ATU_TYPE_IO		0x2
>  #define PCIE_ATU_TYPE_CFG0		0x4
>  #define PCIE_ATU_TYPE_CFG1		0x5
> +#define PCIE_ATU_TD			BIT(8)
>  #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
>  #define PCIE_ATU_CR2			0x908
>  #define PCIE_ATU_ENABLE			BIT(31)
> --=20
> 2.17.1

