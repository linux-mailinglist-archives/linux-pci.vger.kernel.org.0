Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7815C331139
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 15:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCHOuD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 09:50:03 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:34520 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhCHOtn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 09:49:43 -0500
Received: by mail-lj1-f180.google.com with SMTP id i26so4776666ljn.1;
        Mon, 08 Mar 2021 06:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uP1fIZmfDtQZr61LMQHQQSmFTjaTdGRRkSa9BlpzgAc=;
        b=npzg+/GnhQYMf3B3ETD8KAP/LnYIamkVlXZ7yCxDT5MjavHQzO1cDre90oXHAsMBR/
         iCV1QocnRQRxwHLsSN1sNkd6qlUsaA32/155czMXigv4k6auuvPZmJr8uKIICmjssfYm
         6a5hCq6jI6VKJr8KRkXdqiGkLU03NPXhUeHh5NJVtJiwJniz7BMRHechCq/Qcghb1anH
         sNi2TWyD6WD5v4hfmHBmsUb3gAxnKmu8TRhnnxC+vwRtQiqfkUHLN3yv+CEDFLDUk9hn
         F9C+GBj6D3abawtgKSUMfglZ0rM7BSSd1T3DPhlg+cAyUnqbp4NM20liHYcdDOvJjBkr
         YwwA==
X-Gm-Message-State: AOAM5336FaIRwctwPwa6S6KCV5zV7ufPLQ/FGtu3/YkfDnE1syvjpnSi
        +/74bS1SoC/7m8jSu2p3l+E=
X-Google-Smtp-Source: ABdhPJyP8ZPxW8ct3ipsXj51uD/e3cOpusqCx9So2VJw63k1aQJmuyqgCaSZmZRJaLmj3fUZZmD62g==
X-Received: by 2002:a2e:320c:: with SMTP id y12mr14582266ljy.360.1615214981904;
        Mon, 08 Mar 2021 06:49:41 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 28sm1517926ljv.125.2021.03.08.06.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:49:41 -0800 (PST)
Date:   Mon, 8 Mar 2021 15:49:40 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     'Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] PCI: brcmstb: Fix error return code in
 brcm_pcie_probe()
Message-ID: <YEY5hLEAqnI23DSW@rocinante>
References: <20210308135619.19133-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308135619.19133-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
>  	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
>  		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
> +		ret = -ENODEV;
>  		goto fail;
[...]

Nice catch!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Thank you!

Krzysztof
