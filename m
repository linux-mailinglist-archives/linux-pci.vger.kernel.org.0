Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD98538E51B
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 13:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhEXLM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 07:12:26 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:42603 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbhEXLMX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 07:12:23 -0400
Received: by mail-lf1-f44.google.com with SMTP id a2so40083261lfc.9;
        Mon, 24 May 2021 04:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t6GZS4pp7BMDU12Bp3a8xgfTMF16pSvQnikKfkBTZ74=;
        b=fAaeJdkqG9+AEnBaw9vLY+UaknRe6GjL2e76lbB1xYXlUmB37oRuR/aRVjjayCsjrt
         eAm5CGEm6q5TSW/Tx8v4d9kgyPF++AYM6A1lT/yxZ3VTXzM3jQnQyQyJYnastDMIALzy
         +X2twSH3VzJLvKxPZw5Eqg5BUv3cUse2WVjTpYjeY9/Vt/GcND6/imNOZrhZwJlVC7Ij
         RKpSVsL8YWSHSWix+yls/M+sM7/Ow+tJybSV4kyJ7And9FvreQdcFGzMSfnrZ3rToj3x
         pkBbBMqsHcku6e8AW3r7bpJz3Yb91/vMgwF75BNDN1+aq/QDgSM+fOCqFmxt1J21MXwb
         xlpw==
X-Gm-Message-State: AOAM533aajoIcdEBgz5vJFmX6ZKGBeqzykjx85c4xpChSp2ETgFJfL8g
        ERmUdG3ixbhWJkGFjJk/SvdKJ6l5QoZ03bun
X-Google-Smtp-Source: ABdhPJyCyvMqCwwDyj4I32KcTul8f5c063BmKTyKXxMxuwqF/fTl0uqhABs5RknRe6pIFgpkwyVkMA==
X-Received: by 2002:ac2:46f1:: with SMTP id q17mr6723060lfo.359.1621854653630;
        Mon, 24 May 2021 04:10:53 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r15sm1396410lfr.245.2021.05.24.04.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 04:10:53 -0700 (PDT)
Date:   Mon, 24 May 2021 13:10:51 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] PCI: Visconti: Add Toshiba Visconti PCIe host
 controller driver
Message-ID: <20210524111051.GB244904@rocinante.localdomain>
References: <20210524063004.132043-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210524063004.132043-3-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210524063004.132043-3-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nobuhiro,

Thank you for working on this!

[...]
> +static int visconti_get_resources(struct platform_device *pdev,
> +				  struct visconti_pcie *pcie)
> +{
[...]
> +	pcie->refclk = devm_clk_get(dev, "pcie_refclk");
> +	if (IS_ERR(pcie->refclk)) {
> +		dev_err(dev, "Failed to get refclk clock: %ld\n",
> +			PTR_ERR(pcie->refclk));
> +		return PTR_ERR(pcie->refclk);
> +	}
> +
> +	pcie->sysclk = devm_clk_get(dev, "sysclk");
> +	if (IS_ERR(pcie->sysclk)) {
> +		dev_err(dev, "Failed to get sysclk clock: %ld\n",
> +			PTR_ERR(pcie->sysclk));
> +		return PTR_ERR(pcie->sysclk);
> +	}
> +
> +	pcie->auxclk = devm_clk_get(dev, "auxclk");
> +	if (IS_ERR(pcie->auxclk)) {
> +		dev_err(dev, "Failed to get auxclk clock: %ld\n",
> +			PTR_ERR(pcie->auxclk));
> +		return PTR_ERR(pcie->auxclk);
> +	}

Do you think you could use the dev_err_probe() to handle the
devm_clk_get() failed?  Where applicable this is becoming a common
patter drivers apply, for example:

  pcie->refclk = devm_clk_get(dev, "pcie_refclk");
  if (IS_ERR(pcie->refclk))
  	return dev_err_probe(dev, PTR_ERR(pcie->refclk),
			     "failed to get refclk clock\n");

[...]
> +	pci->link_gen = of_pci_get_max_link_speed(pdev->dev.of_node);
> +	if (pci->link_gen < 0 || pci->link_gen > 3) {
> +		pci->link_gen = 3;
> +		dev_dbg(dev, "Applied default link speed\n");
> +	}
> +
> +	dev_dbg(dev, "Link speed Gen %d", pci->link_gen);

Question about the above debug messages.

Given that both are at the same level and the link speed will be printed
regardless of whether it was set to a default value or not, does it make
sense to still print the message about applying the default link speed?
Unless this is something that will be indeed useful during debugging and
troubleshooting (and in which case just ignore this question).

	Krzysztof
