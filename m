Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB57749906
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 08:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfFRGmm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 02:42:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41186 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfFRGmd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 02:42:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id 83so7110497pgg.8;
        Mon, 17 Jun 2019 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=AwdujDdMY1xkfO2MFtISLAJ7c2q8GQgPX1OyMyL8iRQ=;
        b=gc2T8mZda1iOBIUmBR+zjgUg7PzAigxme6RC6t0LcJNLaNAGfWI8VT0+Hl16YajImI
         dt8LgXYjCOCR5b+h3pZ0JCkE2PdcwIhrIfXcm4fNt4PhNwdMwPlVL18i8VJpHnqjRblO
         7Z5Yjbyk/4A8NUfguEKdBgIeWYbcSE6+pMxYQszys+hq8z6wtL/7bMF1s5n0ZJKRU8c6
         deHly0PG/anOfsaEeErCt2F8+ui2INpvBvCFodzBg78FPYttPGrATfvLeXcMzTdZvNK3
         5ZQ3OEpWMwqP1ZYHv077vlJ8LaPXwWZDbW/QlKKRPhTpg0ZMXXhImyw8m8M1Ltlox0xa
         /Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=AwdujDdMY1xkfO2MFtISLAJ7c2q8GQgPX1OyMyL8iRQ=;
        b=is1cRqJPXhAaP71bRPI9ANiQI5+gLAQfjP9R+ufbdQV26D2boA0cmBZ9pypkAFP/Cq
         VNb8Betj0+fQWk2qNVWyvZFL2uu03l9zawSrRKCVZbgC7ovj7AyMogLyeMAbwQhKd/JI
         hlbaFmar8RgK4nm2ca1+iBOnRcEA4VtfQDC7rQWkYoKDaA1/EaPb24PtguYct7wThSyF
         1PphLpi7MhMMRRr5AJUqSA6/7GT28QxuFX8qNtPPK9foeAtlBmz9IhT2GlJhFG5ZIrQq
         4ZR2wDqqbIeVv0TZEvzG5ICZpNGhz54/vfmcgST+EHjezGH1sxInjFrDUsSlz1gKIzIM
         0fXg==
X-Gm-Message-State: APjAAAW7QpWASIRYicoPG/1fsL/IjiIghH8YYIEhpA+2CKve0vKdyEVk
        0QmmCYS1mBwnYOAwNwaNXnk=
X-Google-Smtp-Source: APXvYqx9gUXNF4RnA0Ob4Cvlv0zMqP0GxfJNKUQHMuobER/vyaq4K+0A2QDhVIk6qSAyLUTOu5nexg==
X-Received: by 2002:a17:90a:ca0f:: with SMTP id x15mr218820pjt.82.1560839660866;
        Mon, 17 Jun 2019 23:34:20 -0700 (PDT)
Received: from PSXP216MB0662.KORP216.PROD.OUTLOOK.COM ([40.100.44.181])
        by smtp.gmail.com with ESMTPSA id y1sm1204874pjw.5.2019.06.17.23.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 23:34:19 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "digetx@gmail.com" <digetx@gmail.com>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH V10 03/15] PCI: dwc: Perform dbi regs write lock towards
 the end
Thread-Topic: [PATCH V10 03/15] PCI: dwc: Perform dbi regs write lock towards
 the end
Thread-Index: AQHVJZgV1RcRQMIdqU6FIMIehEk3Laag9HhB
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Tue, 18 Jun 2019 06:34:12 +0000
Message-ID: <PSXP216MB066293334CA5E29E14C41B9FAAEA0@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
References: <20190612095339.20118-1-vidyas@nvidia.com>
 <20190612095339.20118-4-vidyas@nvidia.com>
In-Reply-To: <20190612095339.20118-4-vidyas@nvidia.com>
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

On 6/12/19, 6:54 PM, Vidya Sagar wrote:
>
> Remove multiple write enable and disable sequences of dbi registers as
> Tegra194 implements writes to BAR-0 register (offset: 0x10) controlled by
> DBI write-lock enable bit thereby not allowing any further writes to BAR-=
0
> register in config space to take place. Hence enabling write permission a=
t
> the start of function and disabling the same only towards the end.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Acked-by: Jingoo Han  <jingoohan1@gmail.com>

Sorry for being late. I read the previous threads. I don't think that this =
patch
has any harmful effects. This patch looks good to me.
Thank you.

Best regards,
Jingoo Han

> ---
> Changes since [v9]:
> * None
>
> Changes since [v8]:
> * None
>
> Changes since [v7]:
> * None
>
> Changes since [v6]:
> * None
>
> Changes since [v5]:
> * Moved write enable to the beginning of the API and write disable to the=
 end
>
> Changes since [v4]:
> * None
>
> Changes since [v3]:
> * None
>
> Changes since [v2]:
> * None
>
> Changes since [v1]:
> * None
>
>  drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index f93252d0da5b..d3156446ff27 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -628,6 +628,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	u32 val, ctrl, num_ctrls;
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> =20
> +	/*
> +	 * Enable DBI read-only registers for writing/updating configuration.
> +	 * Write permission gets disabled towards the end of this function.
> +	 */
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
>  	dw_pcie_setup(pci);
> =20
>  	if (!pp->ops->msi_host_init) {
> @@ -650,12 +656,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
> =20
>  	/* Setup interrupt pins */
> -	dw_pcie_dbi_ro_wr_en(pci);
>  	val =3D dw_pcie_readl_dbi(pci, PCI_INTERRUPT_LINE);
>  	val &=3D 0xffff00ff;
>  	val |=3D 0x00000100;
>  	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
> -	dw_pcie_dbi_ro_wr_dis(pci);
> =20
>  	/* Setup bus numbers */
>  	val =3D dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
> @@ -687,15 +691,13 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> =20
>  	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> =20
> -	/* Enable write permission for the DBI read-only register */
> -	dw_pcie_dbi_ro_wr_en(pci);
>  	/* Program correct class for RC */
>  	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> -	/* Better disable write permission right after the update */
> -	dw_pcie_dbi_ro_wr_dis(pci);
> =20
>  	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
>  	val |=3D PORT_LOGIC_SPEED_CHANGE;
>  	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> --=20
> 2.17.1

