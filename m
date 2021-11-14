Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7B644F5C6
	for <lists+linux-pci@lfdr.de>; Sun, 14 Nov 2021 01:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhKNATB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Nov 2021 19:19:01 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:51964 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhKNATA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Nov 2021 19:19:00 -0500
Received: by mail-wm1-f49.google.com with SMTP id z200so10761180wmc.1
        for <linux-pci@vger.kernel.org>; Sat, 13 Nov 2021 16:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T4okuhNZ0aFkHoy/qECcndpmmMvNSv9y7kAHxm3X9UQ=;
        b=HvAh+6U0jU4D8pgnYZGmDRHfd5cvb3bbNd0VRlu/fDQCDZczvQkzh5qkT/GXazTiKy
         DpfjJTKOMTwv48/Vsc+kZLXMzabbnK8C77zHDziw1K8ooDZFxjjVmK2fS1VUysBihmDY
         Xf3auGrWQzqpZ4yyx67QFGqv5zcEHkeJy973dWWmDau3dvdAu/Wk//lY679BuV+2mYSw
         9QS71/+HA1f7nPTLhktdSeWH3mXmIr6S/PLsWJ+gwDJtxhKlXcTmFRJIoI2KAoWBeGAB
         5zV6DEui2DG5/VcNtGPg1sbzI6PYvTg4eu0zZxMDd026M34kOdLeuDhk1+EPsun1GXCk
         iyTw==
X-Gm-Message-State: AOAM533CyWFJOHvSOzCcZICog4HkmzUaErkC9oPpwP+TRvKlcie2P6QQ
        tMr5aGcBfokChvQHD0M67Y1wejz788jkRw==
X-Google-Smtp-Source: ABdhPJyB17oPWV+/WdRd6yTPQKCX1ng+arMf56+d5v4gdHz0arq0mLyxSiMZqWnv4hwSbUksUtc1Tg==
X-Received: by 2002:a1c:ed02:: with SMTP id l2mr29716890wmh.115.1636848966662;
        Sat, 13 Nov 2021 16:16:06 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g13sm7500668wrd.57.2021.11.13.16.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 16:16:05 -0800 (PST)
Date:   Sun, 14 Nov 2021 01:16:04 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, jonathan.derrick@linux.dev
Subject: Re: [PATCH v4] PCI: vmd: Clean up domain before enumeration
Message-ID: <YZBVROkidHzVvu8O@rocinante>
References: <20211025182934.185703-1-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211025182934.185703-1-nirmal.patel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nirmal,

> +static void vmd_domain_reset(struct vmd_dev *vmd)
> +{
> +	u16 bus, max_buses = resource_size(&vmd->resources[0]);
> +	u8 dev, functions, fn, hdr_type;
> +	char __iomem *base;
> +
> +	for (bus = 0; bus < max_buses; bus++) {
> +		for (dev = 0; dev < 32; dev++) {
> +			base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
> +						PCI_DEVFN(dev, 0), 0);
> +
> +			hdr_type = readb(base + PCI_HEADER_TYPE) &
> +					 PCI_HEADER_TYPE_MASK;
> +
> +			functions = !!(hdr_type & 0x80) ? 8 : 1;

A small nitpick: there is no benefit in converting the result of the
expression in the brackets (alebit, keep the brackets for readibility)
to a boolean alike result.

> +			for (fn = 0; fn < functions; fn++) {
> +				base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
> +						PCI_DEVFN(dev, fn), 0);
> +

Thank you for using the ECAM macros!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
