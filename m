Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A865350F1A
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 08:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhDAGgD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 02:36:03 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:42686 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDAGfw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 02:35:52 -0400
Received: by mail-wr1-f42.google.com with SMTP id x13so619943wrs.9;
        Wed, 31 Mar 2021 23:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4rL9IgiyziFhXFq9JhHe8MRiCspi+Fv8AChbH+YGoiU=;
        b=Rj5XDwKRTS5/KBbtPpopcf5XDovGAoqH5lC3YJGlqXaJ0YssGzN3200uen4VpP3mM3
         nuxZsVvbOtAwRFrgUb6t0MBX9306iBcfgvYq9xjUk9f3MSNgPwyYLhM8jlf/BV8VHIjF
         PkCKGdIkJ4jEr+bp0Ct+TfuS2TRe+Hsd2r0HhkItB+K9RP212JFbHLUc+0D9QX8FG5fh
         qxkK1npDe06eUExH/QkRLZPJILAI1yZtDgZXJWF66Un+8cakJITbaQ3KtwLwpCtYC2wZ
         yRqIBhexWG9r/eUfQ6+qSlql6wO1waLAlD0Sz8x8RMNU3rv6qof49em6K8CEZRBrRgwF
         sKRQ==
X-Gm-Message-State: AOAM533EgJiax2A1+UafRvswvjLynK8RJtOKYQMFN5N83JI8DgvMqv1x
        stijOfvs1zl4j38ezPS5rpw=
X-Google-Smtp-Source: ABdhPJw/qtpkUX8J2ufQv5E/USmElRfcGrQQSfQnIFS25ZxrLYmTbD+T5qkceGS46q+4xdmea/1CTg==
X-Received: by 2002:a5d:4d45:: with SMTP id a5mr7872790wru.396.1617258950754;
        Wed, 31 Mar 2021 23:35:50 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id k4sm11620091wrd.9.2021.03.31.23.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:35:50 -0700 (PDT)
Date:   Thu, 1 Apr 2021 08:35:48 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     paul.walmsley@sifive.com, hes@sifive.com, erik.danie@sifive.com,
        zong.li@sifive.com, bhelgaas@google.com, robh+dt@kernel.org,
        aou@eecs.berkeley.edu, mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        helgaas@kernel.org
Subject: Re: [PATCH v4 5/6] PCI: fu740: Add SiFive FU740 PCIe host controller
 driver
Message-ID: <YGVpxHd/JhYPyaMQ@rocinante>
References: <20210401060054.40788-1-greentime.hu@sifive.com>
 <20210401060054.40788-6-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210401060054.40788-6-greentime.hu@sifive.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Greentime,

[...]
> +	/* Wait for wait_idle */
> +	ret = readl_poll_timeout(phy_cr_para_ack, val, val, 10, 5000);
> +	if (ret)
> +		dev_err(dev, "Wait for wait_ilde state failed!\n");
> +
> +	/* Clear */
> +	writel_relaxed(0, phy_cr_para_wr_en);
> +
> +	/* Wait for ~wait_idle */
> +	ret = readl_poll_timeout(phy_cr_para_ack, val, !val, 10, 5000);
> +	if (ret)
> +		dev_err(dev, "Wait for !wait_ilde state failed!\n");
> +}
[...]
> +static int fu740_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct device *dev = pci->dev;
> +
> +	/* Start LTSSM. */
> +	fu740_pcie_ltssm_enable(dev);
> +	return 0;
> +}

The typos etc., are still here.  See:

  https://lore.kernel.org/linux-pci/YFQqpojmJyX0l6lx@rocinante/

Krzysztof
