Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E5F34A271
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 08:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCZHTY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 03:19:24 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:55250 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhCZHTK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 03:19:10 -0400
Received: by mail-wm1-f52.google.com with SMTP id k128so2415523wmk.4;
        Fri, 26 Mar 2021 00:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fLNL3raZRrGxUJu9e4f1n/rQLMtqVUBuwaA1ykbylUk=;
        b=p534m1V6PBzMEjxzs3FRwVpNZwDQ6HuSi8PPZ2zbiIsdwTSRNzU5vc/Yayc8yt1Y6A
         b5YOSkN6W8bVLJ6wcsu49zg7ZQVbCjnJZgXhQlyPesN7i4lzF/yiEgTWgxuq5WqPMb95
         tc87t5D8q2F3XDzz1mTUyK+C9OF4VPEZgDgnOCkbNbyhV2hGqDzGHYO6UMpaTBaj0HPX
         4dF/apbdmaIM5qTQkZy3LdCmAgLCGFkqAtTShzVLoGhEO+K6+6PRshK6U4uUIFsGx464
         WwPLakDhefzPwOQfzpyhr9GboC9x3K4zoz71uUFoGNOgQhFyai6phCv+NHWww+vjucRx
         BX+w==
X-Gm-Message-State: AOAM531LqLoFxZRvm/VfcXCldLmF19t/aD9m0C/n0T0ZojOxofJuzgXe
        gOG5ROee+rYtalaP8oyPnlk=
X-Google-Smtp-Source: ABdhPJzw9FCS1e3r6/gNJEX0b3FR2E4bCH9ja95FbJe61CwUS7gnjiuRlB6fVOR7d9+kCyPWWaxi2A==
X-Received: by 2002:a1c:2308:: with SMTP id j8mr11875666wmj.45.1616743148933;
        Fri, 26 Mar 2021 00:19:08 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u23sm9760443wmn.26.2021.03.26.00.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 00:19:08 -0700 (PDT)
Date:   Fri, 26 Mar 2021 08:19:07 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 6/6] PCI: keystone: Add workaround for Errata #i2037
 (AM65x SR 1.0)
Message-ID: <YF2K6+R1P3SNUoo5@rocinante>
References: <20210325090026.8843-1-kishon@ti.com>
 <20210325090026.8843-7-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210325090026.8843-7-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

A few small nitpicks.

> Errata #i2037 in AM65x/DRA80xM Processors Silicon Revision 1.0
> (SPRZ452D–July 2018–Revised December 2019 [1]) mentions when an
> inbound PCIe TLP spans more than two internal AXI 128-byte bursts,
> the bus may corrupt the packet payload and the corrupt data may
> cause associated applications or the processor to hang.
> 
> The workaround for Errata #i2037 is to limit the maximum read
> request size and maximum payload size to 128 Bytes. Add workaround
> for Errata #i2037 here. The errata and workaround is applicable
> only to AM65x SR 1.0 and later versions of the silicon will have
> this fixed.

I think it would be either "128 B" or "128 bytes", there is no need to
capitalise bytes.

[...]
> +	/*
> +	 * Memory transactions fail with PCI controller in AM654 PG1.0
> +	 * when MRRS is set to more than 128 Bytes. Force the MRRS to
> +	 * 128 Bytes in all downstream devices.
> +	 */

Same here, it would be "128 bytes" in the comment above.

[...]
> +		if (pcie_get_readrq(dev) > 128) {
> +			dev_info(&dev->dev, "limiting MRRS to 128\n");
> +			pcie_set_readrq(dev, 128);
> +		}
[...]

Might be nice to add unit here, so "128 bytes".

Krzysztof
