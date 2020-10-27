Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD1929B0E2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 15:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758874AbgJ0OYn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 10:24:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46513 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758868AbgJ0OYm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 10:24:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id y14so988738pfp.13;
        Tue, 27 Oct 2020 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=56nUUkgKe4I6sk5yHSHhG6Eq1F2qb1ly5xobm5DPAV8=;
        b=hRsZYTsnYBkm424SJRPVqr+DnCD5VlXbBKYfz0RmnVws5MT79H3xozb4x9raCbEkQj
         bYstWPLzzRoFRM89ES6lQF7keObAV2h4huLUETaFwIeOvwxFgzLL3oXDmulBkrMT+GR3
         mSURuJjEBFCaE1HEfk5ULcLYUmw+YYmho/aWlxXwhfJGxyNb6XsUCXBfw7UIjepVWTuJ
         9sgCVNbtYh2OkoSXVSNcj7RPlCmLuG8rsw58mncS1HOizVARclAt3cGr9imtpVyQPXtK
         tyhp2WEqnyOISL+kTyH39PPCj+oChs7BNI0Z+sGjARbY3FlPN3oCykNFYffG2I0s2Jb1
         HZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=56nUUkgKe4I6sk5yHSHhG6Eq1F2qb1ly5xobm5DPAV8=;
        b=mD/UvjSWZXxBcSCJjFaNtl2BCZzniW+jH5NX2rV3asAGLadRWegnRmNHhEXWlAoLW0
         lcp+PpReMEHYaiybrKEF/XnqXZbYctVi8FALN24TMsEOFl0raf94cjzXh8vaq/BbKWd1
         q6gq6pe5UoMAzIieBr9ph1AtWl7k6EnXn7hnaGDDX6IKCSOZV4nM8d1kLGVE3wrqKSJx
         PFihXFvfVz0OkjpQ/cx7HLSxC9FKj9LwEUzvn9fCJSa3GZiueM8EkFe8krVZpZBcxNeJ
         Ud6bKRiVCee2YJHbbh7YAYCUF676w8149TLm4WH/BqnZVv6N4LFOLMyG8Ndk2KKY9pY9
         Qnwg==
X-Gm-Message-State: AOAM532cgB8JvtzPAOPYI+nlwnmooUfXrFcUqtJCcTqMYg+KBn1Ogpns
        gGTen3zseYLhjp2T6wljfww=
X-Google-Smtp-Source: ABdhPJzRzVBS7TAXmSkVTb30mGa789yxjLikfG/VS40jP7lCKG2uKRbjorC57GI3E8fpioEtqF9syw==
X-Received: by 2002:a63:9d4d:: with SMTP id i74mr2119745pgd.182.1603808681336;
        Tue, 27 Oct 2020 07:24:41 -0700 (PDT)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id t10sm2228863pjr.37.2020.10.27.07.24.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 07:24:40 -0700 (PDT)
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
Subject: Re: [PATCH V2 2/2] PCI: dwc: Add support to configure for ECRC
Thread-Topic: [PATCH V2 2/2] PCI: dwc: Add support to configure for ECRC
Thread-Index: AQHWrDe7/+iWHZRKwkSnJse3+P1mYKmrgVZp
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Tue, 27 Oct 2020 14:24:34 +0000
Message-ID: <SLXP216MB047716AE91EBDBC7A2396BB3AA160@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201027080330.8877-1-vidyas@nvidia.com>
 <20201027080330.8877-3-vidyas@nvidia.com>
In-Reply-To: <20201027080330.8877-3-vidyas@nvidia.com>
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

On 10/27/20, 4:03 AM, Vidya Sagar wrote:
>=20
> DesignWare core has a TLP digest (TD) override bit in one of the control
> registers of ATU. This bit also needs to be programmed for proper ECRC
> functionality. This is currently identified as an issue with DesignWare
> IP version 4.90a. This patch does the required programming in ATU upon
> querying the system policy for ECRC.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
> V2:
> * Addressed Jingoo's review comment
> * Removed saving 'td' bit information in 'dw_pcie' structure
>
>  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++--
>  drivers/pci/controller/dwc/pcie-designware.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index b5e438b70cd5..cbd651b219d2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -246,6 +246,8 @@ static void dw_pcie_prog_outbound_atu_unroll(struct d=
w_pcie *pci, u8 func_no,
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>  				 upper_32_bits(pci_addr));
>  	val =3D type | PCIE_ATU_FUNC_NUM(func_no);
> +	if (pci->version =3D=3D 0x490A)
> +		val =3D val | pcie_is_ecrc_enabled() << PCIE_ATU_TD_SHIFT;
>  	val =3D upper_32_bits(size - 1) ?
>  		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
> @@ -294,8 +296,10 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pc=
ie *pci, u8 func_no,
>  			   lower_32_bits(pci_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
>  			   upper_32_bits(pci_addr));
> -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
> -			   PCIE_ATU_FUNC_NUM(func_no));
> +	val =3D type | PCIE_ATU_FUNC_NUM(func_no);
> +	if (pci->version =3D=3D 0x490A)
> +		val =3D val | pcie_is_ecrc_enabled() << PCIE_ATU_TD_SHIFT;
> +	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
>
>  	/*
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 21dd06831b50..e5449b205c22 100644
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
> --=20
> 2.17.1

