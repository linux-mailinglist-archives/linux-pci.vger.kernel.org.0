Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD2B468817
	for <lists+linux-pci@lfdr.de>; Sat,  4 Dec 2021 23:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhLDWcF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Dec 2021 17:32:05 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:40667 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLDWcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Dec 2021 17:32:05 -0500
Received: by mail-wr1-f43.google.com with SMTP id t9so13735300wrx.7;
        Sat, 04 Dec 2021 14:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hi1hBN0ZZGAK29KBqWC91yf7Z/SKLKVcZrDZGGHDVmA=;
        b=rCqXdNx8amEM97QNQgsyaVn304NUBqIt7X89Im+1lX748NqWEYMqu0k6J4lJARxxmO
         OYtJ8MQ8WOAI2eIpFXAM+sZIKZz5pkdJwF3U8P2ejU8qG9vrCeM6h4i0GeizmayiiimV
         C8Hssl1/IMdGYDGA2aQ6zJfdzIq/M3JFUuRyswMpapnpUsIgakJKaJ9tj7vX67Y0mLai
         l7Gh351VFJrLswpxasEcIl5PyhpQaiIu5VkWCaHHr3WgFOgS6vhcU6bRZnknUnSLIuMT
         qqQ3Wf1jdPrKIWvw3mPO2naSM6AmnGrEyFQxgIUN5Mp54rwM9Yu3CO0Xnb8iL2F/E06L
         L1AQ==
X-Gm-Message-State: AOAM531zfJthlKwgOFGqpXJ8RksEAuk3Ws4rrKdj62t8V4mAGjovKfyA
        FH8Jgbiv28nOhGk4j1b8EG8=
X-Google-Smtp-Source: ABdhPJxQt7PAQp8vz1RQgOpbsI+sp+5/9oe6Z2imLXJiwBNE7p4Nn2fjW3Qutx2HGvoUKL8aCTy7hw==
X-Received: by 2002:a5d:588b:: with SMTP id n11mr31434291wrf.344.1638656917872;
        Sat, 04 Dec 2021 14:28:37 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c1sm6520469wrt.14.2021.12.04.14.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 14:28:37 -0800 (PST)
Date:   Sat, 4 Dec 2021 23:28:36 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Constify static dw_pcie_ep_ops
Message-ID: <YavrlE+5LdvvefMP@rocinante>
References: <20211204220316.88655-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211204220316.88655-1-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rikard,

> The only usage of pci_ep_ops is to assign its address to the ops field
> in the dw_pcie_ep struct which is a pointer to const struct dw_pcie_ep_ops.
> Make it const to allow the compiler to put it in read-only memory.

[...]
> @@ -619,7 +619,7 @@ static void qcom_pcie_ep_init(struct dw_pcie_ep *ep)
>  		dw_pcie_ep_reset_bar(pci, bar);
>  }
>  
> -static struct dw_pcie_ep_ops pci_ep_ops = {
> +static const struct dw_pcie_ep_ops pci_ep_ops = {
>  	.ep_init = qcom_pcie_ep_init,
>  	.raise_irq = qcom_pcie_ep_raise_irq,
>  	.get_features = qcom_pcie_epc_get_features,

Looks good, thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
