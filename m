Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758EB34A261
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 08:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCZHOc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 03:14:32 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:47031 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhCZHOF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 03:14:05 -0400
Received: by mail-lf1-f54.google.com with SMTP id w37so6147208lfu.13;
        Fri, 26 Mar 2021 00:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J3D3RetWBQStv8LDiiUAqn2Af0uI+83y6GMS6/IQqpc=;
        b=e0AYV2i5nWd9vZbfREqfp+qkR9rhGiBscNnQ/mTzIp1E9fd27CjzgBphvGC9yeOKSy
         DzSCkLWvzSdgtplc0EmAec5SZW2EIc8U/UNCpzYetzsVnIUwgqpvT+yAr1HZQb9S9dX6
         vhdGkCBblqzAL8OOiguD9Fbuk96uqj1PftXFsRFnTuoeAwyUtjsjhOKnQQ8szNo1uMHu
         ZOxGxpb4oftSj0EM3+TNp4igt4M1pRwRxvKoY+yUvCNu4pPn/AxEKzWtg8mx1i/ZH9h3
         01YijVBFAD75SiJeJ9yBHLsVlBwG4at0V08UUrDx4ZpR0EsqlV8Rvj+vC+KfWKoXLcln
         Xygg==
X-Gm-Message-State: AOAM5310FBdfBqUK+3o7iIxEdIS9p9+xp9sCIEtgHUtJ7foHGDX1fQH+
        rf7bz51ue6gGDu464tUPXgg=
X-Google-Smtp-Source: ABdhPJzgeg6BB02Aog2ZfQw20L0rem+otMtnZoT+Gly0obQjZqXhdmnRC6beTC+rL5IlPsQr6BWPvQ==
X-Received: by 2002:a19:3f08:: with SMTP id m8mr7383770lfa.275.1616742843676;
        Fri, 26 Mar 2021 00:14:03 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id i123sm1054639lji.108.2021.03.26.00.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 00:14:03 -0700 (PDT)
Date:   Fri, 26 Mar 2021 08:14:02 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 5/6] PCI: keystone: Add PCI legacy interrupt support for
 AM654
Message-ID: <YF2Jugi4SE+yKMQa@rocinante>
References: <20210325090026.8843-1-kishon@ti.com>
 <20210325090026.8843-6-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210325090026.8843-6-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

[...]
> +	if (!legacy_irq_domain) {
> +		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
> +		return -EINVAL;
> +	}
[...]

It would be "IRQ" and "IRQs" in the message above.

[...]
> -	ret = ks_pcie_config_legacy_irq(ks_pcie);
> -	if (ret)
> -		return ret;
> +	if (!ks_pcie->is_am6) {
> +		pp->bridge->child_ops = &ks_child_pcie_ops;
> +		ret = ks_pcie_config_legacy_irq(ks_pcie);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = ks_pcie_am654_config_legacy_irq(ks_pcie);
> +		if (ret)
> +			return ret;
> +	}
[...]

What if we change this to the following:

	if (!ks_pcie->is_am6) {
		pp->bridge->child_ops = &ks_child_pcie_ops;
		ret = ks_pcie_config_legacy_irq(ks_pcie);
	} else {
		ret = ks_pcie_am654_config_legacy_irq(ks_pcie);
	}
	
	if (ret)
	  	return ret;

Not sure if this is something you would prefer, but it seems that either
of the functions can set "ret", so checking immediately after would be
the same as checking in either of the branches.  But, this is a matter
of style, so it would be up to you - not sure what do you prefer.

Krzysztof
