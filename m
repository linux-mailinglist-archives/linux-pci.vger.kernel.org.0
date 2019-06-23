Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F18A4FAAA
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2019 09:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfFWHrR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jun 2019 03:47:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37367 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfFWHrR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jun 2019 03:47:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh12so5107222plb.4;
        Sun, 23 Jun 2019 00:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=RPrYEkPk1O1WCEgspfUiwE49F/TDzzk3qG3u3/Wz2qI=;
        b=qmnRY63CZzVF3ZeL5UAUuVJHPc9EozPMoh088OGaFND04B8oJHa1WF1GNEmGy0+l6S
         23B0WTmvIkKHleWsofgfIYneJEySN1jDdbzHXk5OYfHCewZdVSc7P65yoTlXV3yfTHgd
         EgKYW7EuLq5vvR0BuCkjtY4sTnMjWY4/FV2BZyuymFT8rnbokuHshAzLoqgJQ73Pq/q7
         JfquJ+xLa+Xa3HONQjQJzxgkSe3VgmxsbP7/M2SIjGOhYSmFtjjQ50UhqS7lu/OfO+1l
         lEy9I1v1gzl+5KQ1aSXLl+DM3/y371SyEtY2dQXsjWfu3HSQUBrSY0aMs40ZB1wHTydA
         mI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=RPrYEkPk1O1WCEgspfUiwE49F/TDzzk3qG3u3/Wz2qI=;
        b=bM1Kv/a32OGdcuytYnMfbC+564TfId0PvG1jd1tTM9zQVxYtq3g7v28YcKoJKDqdLh
         yd3oetVey1Sbkk1qpwLSeFVq5YkOiNX5yMUvi29yxrwh+x1E2iIH2YfEf0IdO68K8n+J
         e1cWam5DPq3qDe/0z9a8t3O6yGwK0uETVQF4noYzKpBymlKBSFPt8/aTcLBQxtOe0CV/
         uDaRL+2MP4CY9Ud/4t8mn1cPlmyOC5+wplH1F3JlSyIjTGtnvmzwtio0X9xZ0ZEZ0yJB
         9zP29ay2KXaGDztp43MI82A2H5VYBy2l+9EkG22HbWUez7X7oNFQRNwCeuQ1Wkv8RobQ
         LowQ==
X-Gm-Message-State: APjAAAXDb+8oKpe2tPCv4rbcLrbUl5+5aelXCGZP943wjNC9Ae+SdZbU
        +s80Oaiqaz0uxvHPVN6UzA5fvAzQ
X-Google-Smtp-Source: APXvYqwHlTSr/LFimnC++W2Zo8tL9aZUILn287invNOUF4ZPvUjgdtg1u4r5jQyJhJVv/ZBoKun0jg==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr141914672pla.235.1561276035953;
        Sun, 23 Jun 2019 00:47:15 -0700 (PDT)
Received: from PSXP216MB0662.KORP216.PROD.OUTLOOK.COM ([40.100.44.181])
        by smtp.gmail.com with ESMTPSA id n17sm14444567pfq.182.2019.06.23.00.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 00:47:14 -0700 (PDT)
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
Subject: Re: [PATCH V7 2/3] PCI: dwc: Cleanup DBI,ATU read and write APIs
Thread-Topic: [PATCH V7 2/3] PCI: dwc: Cleanup DBI,ATU read and write APIs
Thread-Index: AQHVKRrW7dkXykCM7EuXNA/8yEbrl6ao3X9t
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Sun, 23 Jun 2019 07:47:09 +0000
Message-ID: <PSXP216MB0662E297AC662E53D515141CAAE10@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
References: <20190622165143.11906-1-vidyas@nvidia.com>
 <20190622165143.11906-2-vidyas@nvidia.com>
In-Reply-To: <20190622165143.11906-2-vidyas@nvidia.com>
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

On 6/23/19, 1:52 AM, Vidya Sagar wrote:
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
> ---
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
>  drivers/pci/controller/dwc/pcie-designware.c | 28 +++++------
>  drivers/pci/controller/dwc/pcie-designware.h | 51 +++++++++++++-------
>  2 files changed, 45 insertions(+), 34 deletions(-)

.....

>  static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 =
val)
>  {
> -	__dw_pcie_write_dbi(pci, pci->atu_base, reg, 0x4, val);
> +	int ret;
> +
> +	if (pci->ops->write_dbi) {
> +		pci->ops->write_dbi(pci, pci->atu_base, reg, 0x4, val);
> +		return;
> +	}
> +
> +	ret =3D dw_pcie_write(pci->atu_base + reg, 0x4, val);
> +	if (ret)
> +		dev_err(pci->dev, "Write ATU address failed\n");
>  }
> =20
>  static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
>  {
> -	return __dw_pcie_read_dbi(pci, pci->atu_base, reg, 0x4);
> +	int ret;
> +	u32 val;
> +
> +	if (pci->ops->read_dbi)
> +		return pci->ops->read_dbi(pci, pci->atu_base, reg, 0x4);
> +
> +	ret =3D dw_pcie_read(pci->atu_base + reg, 0x4, &val);
> +	if (ret)
> +		dev_err(pci->dev, "Read ATU address failed\n");
> +
> +	return val;
>  }

Hmm. In cases of dbi and  dbi2, readb/readw/readl and writeb/writew/writel =
are
located in pcie-designware.h. These functions just call read/write which ar=
e located
in pcie-designware.c. For readability, would you write the code as below?

1. For drivers/pci/controller/dwc/pcie-designware.h,
    Just call dw_pcie_{write/read}_atu(), instead of implementing functions=
 as below.

	static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 va=
l)
	{
		return  dw_pcie_write_atu(pci, reg, 0x4, val);
	}

	static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)=09
	{
		return  dw_pcie_read_atu(pci, reg, 0x4);
	}

2. For drivers/pci/controller/dwc/pcie-designware.c,
    Please add new dw_pcie_{write/read}_atu() as below.

	void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
	{
		int ret;

		if (pci->ops->write_dbi) {
			pci->ops->write_dbi(pci, pci->atu_base, reg, size, val);
			return;
		}

		ret =3D dw_pcie_write(pci->atu_base + reg, size, val);
		if (ret)
			dev_err(pci->dev, "Write ATU address failed\n");
	}

	u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size)
	{
		int ret;
		u32 val;

		if (pci->ops->read_dbi)
			return pci->ops->read_dbi(pci, pci->atu_base, reg, size);

		ret =3D dw_pcie_read(pci->atu_base + reg, size, &val);
		if (ret)
			dev_err(pci->dev, "Read ATU address failed\n");

		return val;
	}

Thank you.

Best regards,
Jingoo Han

> =20
>  static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
> --=20
> 2.17.1

