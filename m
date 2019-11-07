Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF03F3A03
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 22:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfKGVDy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 16:03:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45749 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfKGVDy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 16:03:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id w11so2740242pga.12;
        Thu, 07 Nov 2019 13:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=dLyIngmz+BTvSBHC9yhtist9Z7w0m+jHBN6leCOiFg8=;
        b=LlMKOilursif2cmk7KD4OrMaQwbo+qNMnCWkfsYZyZE2XJWunIKwegqFXgMNahIhkf
         RQlqyz1FEaw5yyLtr0F4ekwHaFQZ8eH5Qr38Q9CvAs4dkMWUMp3hrIHtjzc5WCfccSEC
         Ce40NfUh3piVu4h6wT3skKVlBvZMNE0mS2jX3Sk7FnmK3LcOmi6PjLaAfuX8U+y9lL4p
         oCmPko9Ee0Bm9y9PhSG+3tBKxfRuh0rgIL3TrR647jXDh1ZdYkcfAOdpaWgzwVo03j7I
         vtxyyGUdaiieqqL3GNuuibih1290irha5CUIPFO4DRTglvQFlf2/92MFExRkBItBkj5U
         nHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=dLyIngmz+BTvSBHC9yhtist9Z7w0m+jHBN6leCOiFg8=;
        b=Q0G0vKKa6JufSt55foAz6hraxmdILk4++dIefDjgm5tdVwj+jX5LDWwbpH0DFdHjow
         pOEdZtJORn9EJUbaDlu80suCRt/EvSVxmAs3CRc//uBrOim59WzP88FAqKz9N8rFI2cY
         I3+5LTkVdEMBdefqQ0G7bRQNBgGjk762KWXUBSNHV7APmjXdryW1s7zO116u8cu9g4a/
         G5AyNIuR11rZvkRusBnJVh6vWCIR+eqChhjdiGe+EV1dzRFQWHMU0WccVQlUoaDwyW4w
         0gd0rDXLMm6M/lF3311X6e6JuwPrIVMt0i6mTL2bsOZHFMP/33bQCVVnPw9AJ8YgIMSy
         5Q7w==
X-Gm-Message-State: APjAAAXzbpbHL4wagVfWV4JB2D7JrvuSAQuFFBHA63eZQvNsnvlva5uR
        4167VWpavMnW5h1BnXPKdGw=
X-Google-Smtp-Source: APXvYqxm7LIR2q/HEZLQThakoI216kYyFPwG8AURuE+FFMJQzzJWAEiR9Q+EU3iZZjPTm/jlxqoycA==
X-Received: by 2002:a65:6201:: with SMTP id d1mr6973175pgv.182.1573160633096;
        Thu, 07 Nov 2019 13:03:53 -0800 (PST)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id g6sm3302210pfh.125.2019.11.07.13.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 13:03:52 -0800 (PST)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH v5 3/3] PCI: artpec6: Configure FTS with dwc helper
 function
Thread-Topic: [PATCH v5 3/3] PCI: artpec6: Configure FTS with dwc helper
 function
Thread-Index: AQHVlFSCgoYxKfQji0+JDeSIjacZDaeANQQr
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Thu, 7 Nov 2019 21:03:46 +0000
Message-ID: <SL2P216MB010527F9E1C142F0A347ED63AA780@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <cover.1572950559.git.eswara.kota@linux.intel.com>
 <90a64d72a32dbc75c03a58a1813f50e547170ff4.1572950559.git.eswara.kota@linux.intel.com>
In-Reply-To: <90a64d72a32dbc75c03a58a1813f50e547170ff4.1572950559.git.eswara.kota@linux.intel.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/5/19, 10:44 PM, Dilip Kota wrote:
>=20
> Utilize DesugnWare helper functions to configure Fast Training

Nitpicking: Fix typo (DesugnWare --> DesignWare)

If possible, how about the following?
Utilize DesignWare --> Use DesignWare

Best regards,
Jingoo Han

> Sequence. Drop the respective code in the driver.
>
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/pcie-artpec6.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/cont=
roller/dwc/pcie-artpec6.c
> index d00252bd8fae..02d93b8c7942 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -51,9 +51,6 @@ static const struct of_device_id artpec6_pcie_of_match[=
];
>  #define ACK_N_FTS_MASK			GENMASK(15, 8)
>  #define ACK_N_FTS(x)			(((x) << 8) & ACK_N_FTS_MASK)
> =20
> -#define FAST_TRAINING_SEQ_MASK		GENMASK(7, 0)
> -#define FAST_TRAINING_SEQ(x)		(((x) << 0) & FAST_TRAINING_SEQ_MASK)
> -
>  /* ARTPEC-6 specific registers */
>  #define PCIECFG				0x18
>  #define  PCIECFG_DBG_OEN		BIT(24)
> @@ -313,10 +310,7 @@ static void artpec6_pcie_set_nfts(struct artpec6_pci=
e *artpec6_pcie)
>  	 * Set the Number of Fast Training Sequences that the core
>  	 * advertises as its N_FTS during Gen2 or Gen3 link training.
>  	 */
> -	val =3D dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -	val &=3D ~FAST_TRAINING_SEQ_MASK;
> -	val |=3D FAST_TRAINING_SEQ(180);
> -	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +	dw_pcie_link_set_n_fts(pci, 180);
>  }
>
>  static void artpec6_pcie_assert_core_reset(struct artpec6_pcie *artpec6_=
pcie)
> --=20
> 2.11.0

