Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C04324103
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 17:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhBXPgi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 10:36:38 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:42600 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbhBXOK5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 09:10:57 -0500
Received: by mail-lj1-f170.google.com with SMTP id v17so2516675ljj.9;
        Wed, 24 Feb 2021 06:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rp6xFbMVcSNr3U+KePG0/i37RYbSH1lUEiS0Y/RzdOU=;
        b=gLuRYKwqytwVlTdgWXXJZGidDRnz4Fq29+G/1/flO15N0gKUMgEgdtXga3QlbUdhdx
         2nbXjOtv1bGb+REQO11xyYEq00wC3qRRZeHrND2lmlKF+sfsF+ZL9+7yrXDxejvX1AkO
         JwTGbgeNI6JnjvwKp+L+YqUUb7BcHVmTNDukhLvtBK7QohEDbs2aDlsf4Jja4lJCfSuO
         bDKE/xtVflpjc9OVBfdCSP53EQEntJfmWMCQ/8MsUrY1fzaoECuaws+yahPIH0vclkM/
         /WPLOSYcRKKkEtf+insaqVgK+gah4whRrIgiqgM+Idpqr3aKlqCxkTn1yb9qevR5FoYO
         2kQw==
X-Gm-Message-State: AOAM531PS8BCMUWAQ1LAfbAyu4fBnwLHl1Rx+28OA4H1RJvdjuVxC1Pe
        Jt4LUOmFsqmHRQCS45RY/iU=
X-Google-Smtp-Source: ABdhPJw0MxwBtXUxHE7ZBUDyzNlLM4MxrrjRipAt6fYrgf8jDMdyN1rtiQm3NBCDC0X9YA8LNWW25A==
X-Received: by 2002:a2e:7409:: with SMTP id p9mr19032678ljc.404.1614175815511;
        Wed, 24 Feb 2021 06:10:15 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n13sm509705lfu.265.2021.02.24.06.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:10:15 -0800 (PST)
Date:   Wed, 24 Feb 2021 15:10:13 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, maz@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com
Subject: Re: [v8,6/7] PCI: mediatek-gen3: Add system PM support
Message-ID: <YDZeRc6CHV/WzyCm@rocinante>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
 <20210224061132.26526-7-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210224061132.26526-7-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jianjun,

> Add suspend_noirq and resume_noirq callback functions to implement
> PM system suspend hooks for MediaTek Gen3 PCIe controller.

So, "systems suspend" and "resume" hooks, correct?

> When system suspend, trigger the PCIe link to L2 state and pull down

It probably would be "the system suspends".

[...]
> When system resum, the PCIe link should be re-established and the
> related control register values should be restored.

Similarly to the above: "the system resumes".

[...]
> +	if (err) {
> +		dev_err(port->dev, "can not enter L2 state\n");
> +		return err;
> +	}

Most likely you want "cannot" or "can't" in the above error message.

> +	/* Pull down the PERST# pin */
> +	val = readl_relaxed(port->base + PCIE_RST_CTRL_REG);
> +	val |= PCIE_PE_RSTB;
> +	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);
> +
> +	dev_dbg(port->dev, "enter L2 state success");

Just a nitpick.  What about "entered L2 states successfully"?

[...]
> +	if (err) {
> +		dev_err(port->dev, "resume failed\n");
> +		return err;
> +	}

This error message does not quite convey that the mtk_pcie_startup_port()
was the function that failed, which is only a part of what you have to do
to successfully resume.

> +	dev_dbg(port->dev, "resume done\n");

A nitpick.  Probably not needed, as lack of error message would mean
that the device resumed successfully after being suspended.

Krzysztof
