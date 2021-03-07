Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076D5330534
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 00:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhCGXoU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Mar 2021 18:44:20 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:39876 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhCGXoD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Mar 2021 18:44:03 -0500
Received: by mail-lj1-f173.google.com with SMTP id u4so13000155ljh.6;
        Sun, 07 Mar 2021 15:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kB1ak2ni3jTw1VEk48TtG0sEob5ZqARNSeDM3pcSJ3k=;
        b=bFSOurn42jzzGG9pi66FScbaTjPwr/pDrS6Z4v8RGVMWYm/0XWO/Q5YrDG2n2DwT40
         a9D0+W9KJsw4oLSo7WuN3MllGMNeDGnIWpYjrLxTDybgxxclXJFJht0RyAv2D9lgi5Uf
         a5A4LSMT6bdz2FzF7/5nDBpa88cubSp4BbfPp9A7UiJhME4isrOd28XzprnTVEO3JvSr
         Lwc3qa4qXwKCtbUlC88HRRyip2uPYIVL9l1ZW4vIWfobZC4Oee+wAFUzrrBbxnGAB7ho
         vUU3+NO3g98GEae14qR5uv6lLpMC5xbt2eSAg12m1pHIW6HL0o5H9W/6B3qgc9qIS9Lk
         wuUQ==
X-Gm-Message-State: AOAM530DVoW9orD0jlUx4nKIL/0xdSYRiLqqFiigqdyvMpbkdbwXIHwq
        Mhpp/0PBL7SScGt+293eVEs=
X-Google-Smtp-Source: ABdhPJzl4r+3SNeNNsgwDhSNMljeyw95BY3AjokZY4vQ+v6Wn1uSlEzLwEmpfVXmWBJ8Ki0XjkZ3cw==
X-Received: by 2002:a2e:5716:: with SMTP id l22mr6068229ljb.244.1615160641921;
        Sun, 07 Mar 2021 15:44:01 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id k11sm1262574ljg.119.2021.03.07.15.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 15:44:00 -0800 (PST)
Date:   Mon, 8 Mar 2021 00:43:58 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH v9 1/3] PCI: portdrv: Add pcie_port_service_get_irq()
 function
Message-ID: <YEVlPnhbXXN3HFKp@rocinante>
References: <1611007785-25771-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1611007785-25771-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1611007785-25771-2-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> +/*
> + * pcie_port_service_get_irq - get irq of the service
> + * @dev: PCI Express port the service is associated with
> + * @service: For the service to find
> + *
> + * Get irq number associated with given service on a pci_dev
> + */
> +int pcie_port_service_get_irq(struct pci_dev *dev, u32 service)
[...]

A small nitpick.  It would be "IRQ" rather than "irq" in the above
kernel-doc.  Also, missing periods at the end of sentence.

Krzysztof
