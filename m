Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE1A564F2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 10:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfFZI4w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 04:56:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42221 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFZI4w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 04:56:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so987232pff.9;
        Wed, 26 Jun 2019 01:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=Q8ca+vruqU+IqZ3SbIbtiESWjiaIBTLl933ro8ZdJw0=;
        b=Xnb2xHQubYq85R3eL23tYq7TcAQH4r/T0iHYuHWFsrjBeV/gov5Wrn8EWUCMJjzuS9
         +frB/V7EZhArioE2Nz2E+wRMT8mWPcpwpRm50Zd9AoLHqtgpWUMSHCBPMMl5cMqy4Ebg
         Ry5eXuZCHOlXZB2dD9zCoEz1u3BNdsvh2YvGa564eHfWRJJjQ0iqa3s9iX7uc8LdOTCM
         Hv1RBR0npVnCfiLczK5LXLxZoOS1k5gh113X9GlQlNrV+0bdX9LdKb6q6JU/3vZUyFTG
         YD3fDWStvEBkpw47yrDleXU54bZFADwMztsTVvXvDdoM0REXmTgsbCvi2fzRWmdwncnr
         y2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=Q8ca+vruqU+IqZ3SbIbtiESWjiaIBTLl933ro8ZdJw0=;
        b=PH17GFswWU9DglKsSwG57ZG58fhJCLBOwlDvnEeEwPAxEVcGuwt3hZ7iV2fnICsDko
         vA95jeq459a8N9IgI2pwTy7ZwFjr7E4EQ6WUsNxJQm+rtudFFsDNZ4KaZA8ypjx6wq2X
         gLUgWjkz1vmFPgjYFhmLwv6kFC37yADyUmWdGk2eopyQ/nMSR7SUAMPSS2eaV6dQB6S9
         9XcvfFu1wLtIRSOygZJCozqguZcXvUZoeKQyCjqumOLtJR3ONkttHrUOzc9jb8PR26kR
         qqF9d/64FYZHX27gIkkSuQopn8rbfeznGxWBP14hFdOCv4VIEdH8nZujXXM3uaQzbVHA
         ZQuQ==
X-Gm-Message-State: APjAAAVZVLfKdyUWd7RLojwNlMhmEyTXgR/F/Nf873cg/U+Ys5242U7Y
        RtSEjVWVgrsllY9TmJmqcz0=
X-Google-Smtp-Source: APXvYqxoM3Zp1wW+1G88x/FYQQFMfvh++ZD4QgtQaFtqb+72pwYLiDev+WgABndeGFWTDG5hZ+iubQ==
X-Received: by 2002:a17:90a:290b:: with SMTP id g11mr3408583pjd.122.1561539410927;
        Wed, 26 Jun 2019 01:56:50 -0700 (PDT)
Received: from PSXP216MB0662.KORP216.PROD.OUTLOOK.COM ([40.100.44.181])
        by smtp.gmail.com with ESMTPSA id n1sm14799954pgv.15.2019.06.26.01.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 01:56:49 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH V9 2/3] PCI: dwc: Cleanup DBI,ATU read and write APIs
Thread-Topic: [PATCH V9 2/3] PCI: dwc: Cleanup DBI,ATU read and write APIs
Thread-Index: AXN2MDgwOgOxjCFXb0E7BOTT18TfsnN2MDgwv8/oMr4=
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Wed, 26 Jun 2019 08:56:44 +0000
Message-ID: <PSXP216MB0662372E45E6B4961531B299AAE20@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
References: <20190625092238.13207-1-vidyas@nvidia.com>
 <20190625092238.13207-2-vidyas@nvidia.com>
In-Reply-To: <20190625092238.13207-2-vidyas@nvidia.com>
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

On 6/25/19, 6:22 PM, Vidya Sagar wrote:
>
> Cleanup DBI read and write APIs by removing "__" (underscore) from their
> names as there are no no-underscore versions and the underscore versions
> are already doing what no-underscore versions typically do. It also remov=
es
> passing dbi/dbi2 base address as one of the arguments as the same can be
> derived with in read and write APIs. Since dw_pcie_{readl/writel}_dbi()
> APIs can't be used for ATU read/write as ATU base address could be
> different from DBI base address, this patch attempts to implement
> ATU read/write APIs using ATU base address without using
> dw_pcie_{readl/writel}_dbi() APIs.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
> Changes from v8:
> * Removed exporting dw_pcie_{read/write}_atu() APIs
>
> Changes from v7:
> * Based on suggestion from Jingoo Han, moved implementation of readl, wri=
tel for ATU
>   region to separate APIs dw_pcie_{read/write}_atu() in pcie-designware.c=
 file and
>   calling them from pcie-designware.h file.
>
> Changes from v6:
> * Modified ATU read/write APIs to use implementation specific DBI read/wr=
ite
>   APIs if present.
>
> Changes from v5:
> * Removed passing base address as one of the arguments as the same can be=
 derived within
>   the API itself.
> * Modified ATU read/write APIs to call dw_pcie_{write/read}() API
>
> Changes from v4:
> * This is a new patch in this series
>
>  drivers/pci/controller/dwc/pcie-designware.c | 57 ++++++++++++++------
>  drivers/pci/controller/dwc/pcie-designware.h | 34 ++++++------
>  2 files changed, 57 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index 9d7c51c32b3b..c2843ea1d1e8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -52,68 +52,93 @@ int dw_pcie_write(void __iomem *addr, int size, u32 v=
al)
>  	return PCIBIOS_SUCCESSFUL;
>  }
> =20
> -u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> -		       size_t size)
> +u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size)
>  {
>  	int ret;
>  	u32 val;
> =20
>  	if (pci->ops->read_dbi)
> -		return pci->ops->read_dbi(pci, base, reg, size);
> +		return pci->ops->read_dbi(pci, pci->dbi_base, reg, size);
> =20
> -	ret =3D dw_pcie_read(base + reg, size, &val);
> +	ret =3D dw_pcie_read(pci->dbi_base + reg, size, &val);
>  	if (ret)
>  		dev_err(pci->dev, "Read DBI address failed\n");
> =20
>  	return val;
>  }
> =20
> -void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 re=
g,
> -			 size_t size, u32 val)
> +void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 va=
l)
>  {
>  	int ret;
> =20
>  	if (pci->ops->write_dbi) {
> -		pci->ops->write_dbi(pci, base, reg, size, val);
> +		pci->ops->write_dbi(pci, pci->dbi_base, reg, size, val);
>  		return;
>  	}
> =20
> -	ret =3D dw_pcie_write(base + reg, size, val);
> +	ret =3D dw_pcie_write(pci->dbi_base + reg, size, val);
>  	if (ret)
>  		dev_err(pci->dev, "Write DBI address failed\n");
>  }
> =20
> -u32 __dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg=
,
> -			size_t size)
> +u32 dw_pcie_read_dbi2(struct dw_pcie *pci, u32 reg, size_t size)
>  {
>  	int ret;
>  	u32 val;
> =20
>  	if (pci->ops->read_dbi2)
> -		return pci->ops->read_dbi2(pci, base, reg, size);
> +		return pci->ops->read_dbi2(pci, pci->dbi_base2, reg, size);
> =20
> -	ret =3D dw_pcie_read(base + reg, size, &val);
> +	ret =3D dw_pcie_read(pci->dbi_base2 + reg, size, &val);
>  	if (ret)
>  		dev_err(pci->dev, "read DBI address failed\n");
> =20
>  	return val;
>  }
> =20
> -void __dw_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 r=
eg,
> -			  size_t size, u32 val)
> +void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 v=
al)
>  {
>  	int ret;
> =20
>  	if (pci->ops->write_dbi2) {
> -		pci->ops->write_dbi2(pci, base, reg, size, val);
> +		pci->ops->write_dbi2(pci, pci->dbi_base2, reg, size, val);
>  		return;
>  	}
> =20
> -	ret =3D dw_pcie_write(base + reg, size, val);
> +	ret =3D dw_pcie_write(pci->dbi_base2 + reg, size, val);
>  	if (ret)
>  		dev_err(pci->dev, "write DBI address failed\n");
>  }
> =20
> +u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size)
> +{
> +	int ret;
> +	u32 val;
> +
> +	if (pci->ops->read_dbi)
> +		return pci->ops->read_dbi(pci, pci->atu_base, reg, size);
> +
> +	ret =3D dw_pcie_read(pci->atu_base + reg, size, &val);
> +	if (ret)
> +		dev_err(pci->dev, "Read ATU address failed\n");
> +
> +	return val;
> +}
> +
> +void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 va=
l)
> +{
> +	int ret;
> +
> +	if (pci->ops->write_dbi) {
> +		pci->ops->write_dbi(pci, pci->atu_base, reg, size, val);
> +		return;
> +	}
> +
> +	ret =3D dw_pcie_write(pci->atu_base + reg, size, val);
> +	if (ret)
> +		dev_err(pci->dev, "Write ATU address failed\n");
> +}
> +
>  static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 r=
eg)
>  {
>  	u32 offset =3D PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 14762e262758..ffed084a0b4f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -254,14 +254,12 @@ struct dw_pcie {
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_write(void __iomem *addr, int size, u32 val);
> =20
> -u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> -		       size_t size);
> -void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 re=
g,
> -			 size_t size, u32 val);
> -u32 __dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg=
,
> -			size_t size);
> -void __dw_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 r=
eg,
> -			  size_t size, u32 val);
> +u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size);
> +void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 va=
l);
> +u32 dw_pcie_read_dbi2(struct dw_pcie *pci, u32 reg, size_t size);
> +void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 v=
al);
> +u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size);
> +void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 va=
l);
>  int dw_pcie_link_up(struct dw_pcie *pci);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
>  void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
> @@ -275,52 +273,52 @@ void dw_pcie_setup(struct dw_pcie *pci);
> =20
>  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 =
val)
>  {
> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, val);
> +	dw_pcie_write_dbi(pci, reg, 0x4, val);
>  }
> =20
>  static inline u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
>  {
> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x4);
> +	return dw_pcie_read_dbi(pci, reg, 0x4);
>  }
> =20
>  static inline void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 =
val)
>  {
> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x2, val);
> +	dw_pcie_write_dbi(pci, reg, 0x2, val);
>  }
> =20
>  static inline u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg)
>  {
> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x2);
> +	return dw_pcie_read_dbi(pci, reg, 0x2);
>  }
> =20
>  static inline void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 v=
al)
>  {
> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x1, val);
> +	dw_pcie_write_dbi(pci, reg, 0x1, val);
>  }
> =20
>  static inline u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
>  {
> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x1);
> +	return dw_pcie_read_dbi(pci, reg, 0x1);
>  }
> =20
>  static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32=
 val)
>  {
> -	__dw_pcie_write_dbi2(pci, pci->dbi_base2, reg, 0x4, val);
> +	dw_pcie_write_dbi2(pci, reg, 0x4, val);
>  }
> =20
>  static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
>  {
> -	return __dw_pcie_read_dbi2(pci, pci->dbi_base2, reg, 0x4);
> +	return dw_pcie_read_dbi2(pci, reg, 0x4);
>  }
> =20
>  static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 =
val)
>  {
> -	__dw_pcie_write_dbi(pci, pci->atu_base, reg, 0x4, val);
> +	dw_pcie_write_atu(pci, reg, 0x4, val);
>  }
> =20
>  static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
>  {
> -	return __dw_pcie_read_dbi(pci, pci->atu_base, reg, 0x4);
> +	return dw_pcie_read_atu(pci, reg, 0x4);
>  }
> =20
>  static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
> --=20
> 2.17.1

