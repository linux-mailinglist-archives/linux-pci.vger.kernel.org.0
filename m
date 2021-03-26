Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106E134A243
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 07:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCZG6Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 02:58:25 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:36760 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhCZG6F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 02:58:05 -0400
Received: by mail-lj1-f172.google.com with SMTP id z25so6212864lja.3;
        Thu, 25 Mar 2021 23:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y2qrP/+7Eqq1r7Y1EufmGR7ispG9hVe1quq8g3HloPA=;
        b=iyIrMeFDKTkNy5rnJFMuiORdE8hI9rQXDt/S0NAuRW3/BKRbxGgLTMwtRW1scnUL1r
         pyUGr8InOzO5ian/dk1wXQ4svHCTCY1cUM5Igo6xXU76dUXZhf+7Cl4obhp87Cm63pzQ
         Y2kirMBbFwd0EYJYDcNyez41XVY6AeYZA1UoqxRfPqcXuW/mRaoWnOsEs/LFlTd3pQM4
         elyUd2QDIvGslww50x6SisNNDfukWlRl4GxgOak4+aEN1uZZoHM/2ksReVlITKCYU91p
         W5ea2wuMOKXKSVOC3jQeEJMS3DTQJARGzPs7ca6F8K52Jj3ynlEwVhSh8JwkfNsTksqH
         /wDA==
X-Gm-Message-State: AOAM532rWOIvc241wUakgssJsXCTGeDRERrg1t+hA8ol8voWeWZ2ZU2W
        vrIJdN+lORZCNEpN0DeBtlM=
X-Google-Smtp-Source: ABdhPJyGi+WicJuhZegLet4p9d7lsO+uyChxmo2YFW1S9ebzuMxKHTKCHZvWdS7GKDzZnDsg4S3obQ==
X-Received: by 2002:a2e:2c0d:: with SMTP id s13mr7893263ljs.105.1616741883666;
        Thu, 25 Mar 2021 23:58:03 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y16sm191038lfy.252.2021.03.25.23.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 23:58:02 -0700 (PDT)
Date:   Fri, 26 Mar 2021 07:58:01 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 4/6] PCI: keystone: Convert to using hierarchy domain for
 legacy interrupts
Message-ID: <YF2F+VYO7bZNLB/u@rocinante>
References: <20210325090026.8843-1-kishon@ti.com>
 <20210325090026.8843-5-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210325090026.8843-5-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

Thank you for sending the series over!

A few small nitpick, so feel free to ignore it.

[...]
> +	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
> +	if (ret < 0) {
> +		pr_err("Failed to allocate parent irq %u: %d\n",
> +		       parent_fwspec.param[0], ret);
> +		return ret;
[...]

Use "IRQ" in the message above.

Also, the error messages with both starting with upper- and lower- case
letter, not sure if this is because of dev_err() vs pr_err(), but if
there is no significance between these two methods, then it might be
nice to keep the style consistent.

Krzysztof
