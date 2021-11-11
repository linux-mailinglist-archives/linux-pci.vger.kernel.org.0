Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA01244DE90
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 00:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhKKXlb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 18:41:31 -0500
Received: from mail-pj1-f46.google.com ([209.85.216.46]:37832 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhKKXlb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 18:41:31 -0500
Received: by mail-pj1-f46.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so5842259pjl.2;
        Thu, 11 Nov 2021 15:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eCaI98BlCuECi8dJPVsw1fYuRE87T8MGMiqrl5DWOGI=;
        b=B9sAdvW0ggyLnz9X7b/hTjk0pcJP0PjI/By/iEwgNUATH2WfdnRckNwHtLhS6ZlBz0
         079kPKYfFiB7OxuXf0lpBA//YGFB+G2T0O5hgoKKm4N7tBh3k7Gyb35F/BuZTfXC6ODS
         /Pu5WBMielxT0o9ISCYIiPhnb6MyeHWGJfppidg1wDdsUJagmwBlDanD6t2dJlYWmpQh
         G/XadgQ7paqORRDGgGvzaH/0JZkZWCT+P39fOrYZcu+V3YHfWAgvzWLgM9sGdf56daRH
         9xnL1MlbdIWldUCznkfms8Jrt2oD1gZZY7Yjbef1fNSSqlrevXBmLcTlfFZ4IM1jftwr
         OjsA==
X-Gm-Message-State: AOAM531OwKZ6yL+l5FZSk9hDZ+Uhv+UlY+w9rkQmq5Ii/289oUdLsNU2
        +oftcer7EyqnMVJQsyYfLAA=
X-Google-Smtp-Source: ABdhPJySVQIFfqJ/C3QR49OSqGdscvGDR/LmiL6MTEAXMeVeH1fbas2Shhi3BKkWNhjBioCKtEuQ4A==
X-Received: by 2002:a17:90a:3b02:: with SMTP id d2mr12293787pjc.159.1636673921201;
        Thu, 11 Nov 2021 15:38:41 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w17sm236218pfu.58.2021.11.11.15.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 15:38:40 -0800 (PST)
Date:   Fri, 12 Nov 2021 00:38:28 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 5/8] PCI/portdrv: add mechanism to turn on subdev
 regulators
Message-ID: <YY2pdNMnYQ/EcQoo@rocinante>
References: <20211110221456.11977-1-jim2101024@gmail.com>
 <20211110221456.11977-6-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110221456.11977-6-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jim,

[...]
> [1] These regulators typically govern the actual power supply to the
>     endpoint chip.  Sometimes they may be a the official PCIe socket

In the above, did you mean to say "be at the"?

> +static void *alloc_subdev_regulators(struct device *dev)
> +{
> +	static const char * const supplies[] = {
> +		"vpcie3v3",
> +		"vpcie3v3aux",
> +		"vpcie12v",
> +	};
> +	const size_t size = sizeof(struct subdev_regulators)
> +		+ sizeof(struct regulator_bulk_data) * ARRAY_SIZE(supplies);

[...]
> +int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> +{
> +	struct device *dev = &bus->dev;
> +	struct subdev_regulators *sr;
> +	int ret;
> +
> +	if (!pcie_is_port_dev(bus->self))
> +		return 0;
> +
> +	if (WARN_ON(bus->dev.driver_data))
> +		dev_err(dev, "multiple clients using dev.driver_data\n");

I have to ask - is the WARN_ON() above adding value given the nature of the
error?  Would dumping a stack be of interest to someone?

Having said that, why do we even need to assert this?  Can there be some
sort of a race condition with access happening here?

I am asking as pci_subdev_regulators_remove_bus() does not seem to be
concerned about this sort of thing yet it also accesses the same driver
data, and such.

[...]
> +/* forward declaration */
> +static struct pci_driver pcie_portdriver;

The comment above might not be needed as it's quite obvious what the code
at this line is for, I believe.

[...]
> @@ -131,6 +155,13 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	if (status)
>  		return status;
>  
> +	if (dev->bus->ops &&
> +	    dev->bus->ops->add_bus &&
> +	    dev->bus->dev.driver_data) {
> +		pcie_portdriver.resume = subdev_regulator_resume;
> +		pcie_portdriver.suspend = subdev_regulator_suspend;
> +	}
> +
>  	pci_save_state(dev);

[...]
> @@ -237,6 +268,7 @@ static struct pci_driver pcie_portdriver = {
>  	.err_handler	= &pcie_portdrv_err_handler,
>  
>  	.driver.pm	= PCIE_PORTDRV_PM_OPS,
> +	/* Note: suspend and resume may be set during probe */

This comment here is for the "driver.pm" line above, correct?  If so, then
I would move it above the statement.  It's a little bit confusing
otherwise.

	Krzysztof

