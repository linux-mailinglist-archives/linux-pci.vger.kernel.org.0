Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8860652702
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 10:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfFYIrq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 04:47:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38842 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfFYIrq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 04:47:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id g4so8446105plb.5;
        Tue, 25 Jun 2019 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=RPiWSabt5JgoWs5z40nQXXXKrZ3PBISZqfHALf5K1aM=;
        b=Sz0I0sBTv0opAvby7bD8S71CXkhtdKHo78vR6Pn6+4QMdTxjy3//L76zw/vAWyUGy2
         vKfyVT5cwJIU9ErBxIrO+aysfc4rTx+L/UUtpscmht6Koz4m7Gl11GDCRUma4OEjkjej
         oS/b+OvxwZHQo6IVeUTzp8lTeVSaMKbzDDhUS+th3DsbNYlyGi2r6mNPduuV1hHFRvPm
         m/r08YrTfe9d5CbOdyKFeHy3LBhTgBurgssT64IC2QErCcAMI0LxOT6fD8fHRf6Po8t6
         cRJZYk763nI/p3n6PwsYfndJCXrBJOzx2wc5xjk/2b0IUA5veoKwxH4MGEgbYuwBFeCN
         /YoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=RPiWSabt5JgoWs5z40nQXXXKrZ3PBISZqfHALf5K1aM=;
        b=OTnr0kw4CQ5bq+Ovfd7x7Eqdd2j5PcU7i8pKDw1VDt5EE+8mUfDfpnnS2wHBnJS8yp
         iU2wqVS42Bx6Y96dXZV4e/fwVKwoCNwZxlMfQPW4pZdZiUMnSuGtiffAGd6vFY2fqJV3
         wZFY/4dUxL7mZd4c07IIuFFmH3Imiet9Pde264+CwWz1zUX3AnYWp+TcBZBc5lygPEXS
         o7qpSv3l848JF6/p6rWZWQSHC0d+CVEeroaiKNagPy/D6pM7mSrknhdnLG1VbhHKI8Vx
         dkbcc1ugkan7/0fZd4BcFPiqtrP/QMjdbQ69yTvekKKS1NkiMWLndcOjJ00zweKbJRLd
         Zj4Q==
X-Gm-Message-State: APjAAAXWxtOawAkRMOUe3KQ7EiMC5vXWJ67ojFsA8HbJG0y1AxLoSCDu
        wkt236sk5GLnGzmImaGHQtI=
X-Google-Smtp-Source: APXvYqxS9rd6025LvTXepoBuM+Fl4OiltcA6UGOv+QgfZAo2tiZuTDpVYaKa7WQBS7h9Ta9iSNENeQ==
X-Received: by 2002:a17:902:7787:: with SMTP id o7mr7143805pll.120.1561452465723;
        Tue, 25 Jun 2019 01:47:45 -0700 (PDT)
Received: from PSXP216MB0662.KORP216.PROD.OUTLOOK.COM ([40.100.44.181])
        by smtp.gmail.com with ESMTPSA id k19sm6987917pgl.42.2019.06.25.01.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 01:47:44 -0700 (PDT)
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
Subject: Re: [PATCH V8 2/3] PCI: dwc: Cleanup DBI,ATU read and write APIs
Thread-Topic: [PATCH V8 2/3] PCI: dwc: Cleanup DBI,ATU read and write APIs
Thread-Index: AQHVKk1mZn06E4x3n0K7Ma23pehWQqasEKv6
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Tue, 25 Jun 2019 08:47:39 +0000
Message-ID: <PSXP216MB066244DBB956E189F6B88559AAE30@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
References: <20190624052611.11279-1-vidyas@nvidia.com>
 <20190624052611.11279-2-vidyas@nvidia.com>
In-Reply-To: <20190624052611.11279-2-vidyas@nvidia.com>
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

On 6/24/19, 2:26 PM, Vidya Sagar wrote:
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
>  drivers/pci/controller/dwc/pcie-designware.c | 28 +++++------
>  drivers/pci/controller/dwc/pcie-designware.h | 51 +++++++++++++-------
>  2 files changed, 45 insertions(+), 34 deletions(-)

.......

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
> +EXPORT_SYMBOL_GPL(dw_pcie_read_atu);

Don't export dw_pcie_read_atu unnecessarily.

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
> +EXPORT_SYMBOL_GPL(dw_pcie_write_atu);

Don't export dw_pcie_write_atu unnecessarily.

Best regards,
Jingoo Han

.....
