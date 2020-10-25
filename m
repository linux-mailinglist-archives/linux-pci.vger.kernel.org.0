Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14EE298388
	for <lists+linux-pci@lfdr.de>; Sun, 25 Oct 2020 21:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418738AbgJYUt2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Oct 2020 16:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409589AbgJYUt2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Oct 2020 16:49:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EEEC061755;
        Sun, 25 Oct 2020 13:49:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w65so2183788pfd.3;
        Sun, 25 Oct 2020 13:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=LguKRcbWckkgvDwu3bbwQd9I6/8cYuASCMO5kIuQCSM=;
        b=LPTZpWAXXYsG+bcLPhJGse3KcUOB98133ysnXInBzKhkz/8fUHoZP3ObryFB0e34ep
         Y5/e2h1Ls81JOO3c1hV6nfpWHLKDhHtU40Tolh+LAtjxJfASKQxHA6KUIoD2YxU2pEwN
         lTDEY10xQc/jhjFZy/YwX9Jjakq6y+p0N3rV6Q4EWy4L0KVE7kn90eXTv5YqG5lPv5u0
         cI63yzXTumYl6jPKJyzCbYkc4P9iONKHjLlHq58R29KR5hK+9PZHUHwtETmfDcTPj4f9
         tH/C82xmDIUfTBuc6p4lsvpoK6hv6z6bOfcqN83fQSy6IWMXGN3UiExe+M38ASF43ddj
         g2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=LguKRcbWckkgvDwu3bbwQd9I6/8cYuASCMO5kIuQCSM=;
        b=YUJiThZ4aVQrNvtbB7CZcbznOONJXNjVrpGYSEaLJTHNsqQuiZffMDlPyGfG65fiDS
         AjPp20WvwhECkTvJwEyF6UnJdavNfiK3jFg65kiw8BQVF0QN84yBPCmfvltXkb0k1lKH
         eAyc+tkxlxHDCwA010mMqg7w0b3vZtwQ8W0hix9fr5RnCauylrS2vlHRCHUMbmArUiMZ
         KQQ3mAEw6exAytNM7Sta2ROJ+7mFG+8MusfZ4jU9jshWpz1XKyIV3qRKzKCOqtOOK35f
         3P+bVFuV7CR1IwZjg3q98gd3iLembXr4ape+1zIqVQItGnaFdgXKJuCU07EJJCXKaf/O
         MfEA==
X-Gm-Message-State: AOAM530ie3LO5vTcAr9C+9qMWGfhGBa68eXCp36ScGNy4nwrADlwTpa7
        E/LI4eumK6RoEeRNL30hR6E=
X-Google-Smtp-Source: ABdhPJy+/x3gfuTDxQZ/lNLCRzfaD7Rm9ZtQRIBP7UI1bLRcZJsHklk+DdHhIkrt1SijucAbkH87mA==
X-Received: by 2002:a65:684d:: with SMTP id q13mr13067243pgt.372.1603658967454;
        Sun, 25 Oct 2020 13:49:27 -0700 (PDT)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id w19sm10087136pff.6.2020.10.25.13.49.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Oct 2020 13:49:26 -0700 (PDT)
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
Subject: Re: [PATCH 2/2] PCI: dwc: Add support to configure for ECRC
Thread-Topic: [PATCH 2/2] PCI: dwc: Add support to configure for ECRC
Thread-Index: AQHWqqDjcEvvIfJZ20eYN0/hpzWvqamoy1qz
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Sun, 25 Oct 2020 20:49:20 +0000
Message-ID: <SLXP216MB0477AAC31DF68862BE5BC3EEAA180@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201025073113.31291-1-vidyas@nvidia.com>
 <20201025073113.31291-3-vidyas@nvidia.com>
In-Reply-To: <20201025073113.31291-3-vidyas@nvidia.com>
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

On 10/25/20, 3:31 AM, Vidya Sagar wrote:
>=20
> DesignWare core has a TLP digest (TD) override bit in one of the control
> registers of ATU. This bit also needs to be programmed for proper ECRC
> functionality. This is currently identified as an issue with DesignWare
> IP version 4.90a. This patch does the required programming in ATU upon
> querying the system policy for ECRC.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++--
>  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index b5e438b70cd5..810dcbdbe869 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -245,7 +245,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct d=
w_pcie *pci, u8 func_no,
>  				 lower_32_bits(pci_addr));
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>  				 upper_32_bits(pci_addr));
> -	val =3D type | PCIE_ATU_FUNC_NUM(func_no);
> +	val =3D type | PCIE_ATU_FUNC_NUM(func_no) | pci->td << PCIE_ATU_TD_SHIF=
T;
>  	val =3D upper_32_bits(size - 1) ?
>  		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
> @@ -295,7 +295,8 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pci=
e *pci, u8 func_no,
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
>  			   upper_32_bits(pci_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
> -			   PCIE_ATU_FUNC_NUM(func_no));
> +			   PCIE_ATU_FUNC_NUM(func_no) |
> +			   pci->td << PCIE_ATU_TD_SHIFT);
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
>
>  	/*
> @@ -565,6 +566,9 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	dev_dbg(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
>  		"enabled" : "disabled");
>
> +	if (pci->version =3D=3D 0x490A)
> +		pci->td =3D pcie_is_ecrc_enabled();
> +
>  	if (pci->link_gen > 0)
>  		dw_pcie_link_set_max_speed(pci, pci->link_gen);
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 21dd06831b50..d34723e42e79 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -90,6 +90,7 @@
>  #define PCIE_ATU_TYPE_IO		0x2
>  #define PCIE_ATU_TYPE_CFG0		0x4
>  #define PCIE_ATU_TYPE_CFG1		0x5
> +#define PCIE_ATU_TD_SHIFT		8
>  #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
>  #define PCIE_ATU_CR2			0x908
>  #define PCIE_ATU_ENABLE			BIT(31)
> @@ -276,6 +277,7 @@ struct dw_pcie {
>  	int			num_lanes;
>  	int			link_gen;
>  	u8			n_fts[2];
> +	bool			td;	/* TLP Digest (for ECRC purpose) */

If possible, don't add a new variable to 'dw_pcie' structure.
Please find a way to set TD bit without adding a new variable to 'dw_pcie' =
structure'.

Best regards,
Jingoo Han

>  };
>
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp=
)
> --=20
> 2.17.1

