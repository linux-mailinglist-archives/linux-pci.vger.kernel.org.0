Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5DF3B19C8
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 14:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhFWMXA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 08:23:00 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41484 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhFWMXA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 08:23:00 -0400
Received: by mail-wr1-f47.google.com with SMTP id f15so2412365wro.8;
        Wed, 23 Jun 2021 05:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UfP6k5ommLM5X7TkcxI89PaM7Nsi15an45FVpSiGZ1w=;
        b=D8kqkLgbNyH4eQfPf7Q4U6sJ/ysi0YIf/fmfmvlEGquUc8hzIV3/lqbj+Bhw7fOKhi
         sIdYqznIOBejqyywviC8+x3EU4EAdXODDewoS/A+1PCmRtr4dy4UPbs44OAkShIEsKfZ
         KKvy0o79d16yLMVHgKvdbOEyVCy7tvYzXEYkW/3Nuw+BszZr3P2xqbYfKa5GzSjrKo5y
         VSKIPizBbqvnuMe/CbKjLzcPBLym6M4gd4HqdH0LR/6oMZsbOGq+AeiYwG/T70F/IPHm
         5kAUBwh1dtw8hNwt/lpoSba7IAKtk6FeFmTKcuYd7IO9qsl5sUoxubkNAKEdJzFNKY1L
         qxrA==
X-Gm-Message-State: AOAM531v6HdY3E93xF63NIR5VSK+AKdS80mLj3fVi+p33MsCIg8BXv4K
        WmZbdTsWxZE9yr0AkTbYTYQ=
X-Google-Smtp-Source: ABdhPJwabmji/un4AUhLivSfMKZJDm6mnfCuU7n4mPp2sqRUjLTKOfww+5IO42a4UcM2C2mHjPFiMQ==
X-Received: by 2002:adf:f808:: with SMTP id s8mr10890798wrp.270.1624450841945;
        Wed, 23 Jun 2021 05:20:41 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id l10sm2734991wrv.82.2021.06.23.05.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 05:20:41 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:20:40 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: xilinx-nwl: Enable the clock through CCF
Message-ID: <20210623122040.GA46059@rocinante>
References: <dbc0ab2e109111ca814e73abb30a1dda5d333dbe.1624449519.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbc0ab2e109111ca814e73abb30a1dda5d333dbe.1624449519.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Michal,

Thank you for sending the patch over!

> Simply enable clocks. There is no remove function that's why
> this should be enough for simple operation.

What clock is this?  Would it be worth mentioning what it is for
a reference (and for posterity) the commit message?

Also why it would need to be enabled and wasn't before?  Would this be
a fix for some problem?  Would this warrant a "Fixes:" tag?  And would
it need to be back-ported to stable kernels?

[...]
> @@ -823,6 +825,11 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> +	pcie->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(pcie->clk))
> +		return PTR_ERR(pcie->clk);
> +	clk_prepare_enable(pcie->clk);
> +
[...]

Almost every other user of clk_prepare_enable() would check for
potential failure, print an appropriate message, and then do the
necessary clean-up before bailing out and returning an error.

Would adding an error check for clk_prepare_enable() and printing an
error message using dev_err() be too much in this case?  If not, then
I would rather follow the pattern that other users established and
handle errors as needed.  What do you think?

	Krzysztof
