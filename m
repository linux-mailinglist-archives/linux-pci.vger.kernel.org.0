Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDEE4766E7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 01:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhLPAWC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 19:22:02 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46895 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhLPAWB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 19:22:01 -0500
Received: by mail-wr1-f44.google.com with SMTP id i22so11227262wrb.13;
        Wed, 15 Dec 2021 16:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5WVeXX6wF7Rq2S+DCKKRBlsrDqOKaYzTtLcyOXsKktU=;
        b=71Fyb9Y2z5XfTVJQkLUZsQI6fw/2m6QPaR9OedB+1Hr3Ab/CKeqRfoPXJLd7r/D1mr
         ble9h5LzXogAB0LexPnfwPf9BEW+h/jwIj+hDiJrC6eT1gs5JQzV6uRAo3t9YlT7Hl1I
         KpYbV/gxVMaZWuH31q/8Uk+cEfLyCnjOVEWJ1NS6D9EtOrh6om2YlS9r2vmcZ8p33s5H
         M04hA7Nv0dDHDmbgWPeG91xxeRiT99iw5IXpuWB1v2zuvmYQxojZyJlkduN/B1+xrjf2
         dxH6OfeHUJ/N/wcXUpE4HM2WxFItnlF01wEVgAbOU8DsAFdCNyVkwbrKxO3NqnNoTyey
         mjqA==
X-Gm-Message-State: AOAM532WDvGT0LBymqSmZ6h2EDxjfKKPaiWMlUj8bgBsxHszqrE1qk8k
        pfXIVuo980YZqDOb2+BzSOQ=
X-Google-Smtp-Source: ABdhPJxLZqT3HVtWQiBLR32v2gzej5zHFQfgYEBY+Q1JCFyIlLTVOST7lpHyp2N5Yf05rj757fhaTw==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr6457665wrr.561.1639614120352;
        Wed, 15 Dec 2021 16:22:00 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g13sm3932678wri.102.2021.12.15.16.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 16:21:59 -0800 (PST)
Date:   Thu, 16 Dec 2021 01:21:58 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 1/2] PCI: Add support for VF Resizable Bar extended cap
Message-ID: <YbqGplTKl5i/1/kY@rocinante>
References: <20211215141626.3090807-1-michal.winiarski@intel.com>
 <20211215141626.3090807-2-michal.winiarski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211215141626.3090807-2-michal.winiarski@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Michał,

[...]
> +static int pci_memory_decoding(struct pci_dev *dev)
> +{
> +	u16 cmd;
> +
> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +	if (cmd & PCI_COMMAND_MEMORY)
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PCI_IOV
> +static int pci_vf_memory_decoding(struct pci_dev *dev)
> +{
> +	u16 cmd;
> +
> +	pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_CTRL, &cmd);
> +	if (cmd & PCI_SRIOV_CTRL_MSE)
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +#endif
> +
>  int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>  {
>  	struct resource *res = dev->resource + resno;
>  	struct pci_host_bridge *host;
>  	int old, ret;
>  	u32 sizes;
> -	u16 cmd;
>  
>  	/* Check if we must preserve the firmware's resource assignment */
>  	host = pci_find_host_bridge(dev->bus);
> @@ -424,9 +447,14 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>  	if (!(res->flags & IORESOURCE_UNSET))
>  		return -EBUSY;
>  
> -	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> -	if (cmd & PCI_COMMAND_MEMORY)
> -		return -EBUSY;
> +#ifdef CONFIG_PCI_IOV
> +	if (resno >= PCI_IOV_RESOURCES)
> +		ret = pci_vf_memory_decoding(dev);
> +	else
> +#endif
> +	ret = pci_memory_decoding(dev);
> +	if (ret)
> +		return ret;

The above else works, however, it does trip our static analysis tools, and
lack of the indentation makes it slightly confusing to read, at least at
the first glance.  Thus, I wonder whether it would be possible to combine
the pci_vf_memory_decoding() and pci_memory_decoding() somehow neatly into
a private helper that takes a boolean to indicate whether it's a VF or not.
Then, we could drop the if-statement, since some of the logic could live
within the helper.

What do you think?

	Krzysztof
