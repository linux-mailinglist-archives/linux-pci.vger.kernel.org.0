Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D777380AFF
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 16:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhENOFK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 10:05:10 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:39763 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhENOFJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 10:05:09 -0400
Received: by mail-ed1-f54.google.com with SMTP id h16so458010edr.6
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 07:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1lFRaL7AX9G7L+LX7wTjLSR90F1RNGvbwL6N9QuJctw=;
        b=YBMr5mQAk1IDcaY1lRmjtsr0p+h6ZiWuCqrtgK0x9c67c2+IUAH66l3IgooQF1O+bt
         VDBKN35RB+Okk7kKJSURfQTJ+WcvIG7yDLsOm3uom/afiKcANeLCpWm78D0F/gYV4vv7
         2P/4m7C3Qn9Ze7T/Kgn9y+XvS8+o8Ho861sSk+pKRi6HgUcmzwyog9gwR2euuQYtD/VZ
         Taz6BfuAWpwjiztxxT6LyDXmrFBow46+H1FUGwJHh+WoGIIRPS7KONGBf9fIB3gGmBHL
         x1ZKroPWHB0HMQophNHLYzlViq8benVx36qyNZmrrLYV10E+yO0+kX7qEmY+zF5VXxu7
         kDIg==
X-Gm-Message-State: AOAM5315EuzNb2S+sKkBA//med0p6K3XOFW2IiB1ZYx/QZ7hdqxpQTVZ
        wWn6BDc7ft0pkTohGhCSpAI=
X-Google-Smtp-Source: ABdhPJztSMQF4Gj4hdwxZnUhWp6kstdw1iZNy5zktoEs+7d6q8HjRxxCTzWuGn058kELmsCyBJ6Oqw==
X-Received: by 2002:a05:6402:2317:: with SMTP id l23mr30926457eda.265.1621001036633;
        Fri, 14 May 2021 07:03:56 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id v18sm3432577ejg.63.2021.05.14.07.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:03:56 -0700 (PDT)
Date:   Fri, 14 May 2021 16:03:55 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 3/5] PCI: Improve the mrrs quirk for LS7A
Message-ID: <20210514140355.GH9537@rocinante.localdomain>
References: <20210514080025.1828197-1-chenhuacai@loongson.cn>
 <20210514080025.1828197-4-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210514080025.1828197-4-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Huacai,

It would be "MRRS" in the subject line.

> In new revision of LS7A, some pcie ports support larger value than 256,

Here, it would be "PCIe" instead of "pcie".

> but their mrrs values are not dectectable. And moreover, the current

It would be "MRRS", and "detectable".

> loongson_mrrs_quirk() cannot avoid devices increasing its mrrs after
> pci_enable_device(). So the only possible way is configure mrrs of all
> devices in BIOS, and add a pci dev flag (PCI_DEV_FLAGS_NO_INCREASE_MRRS)
> to stop the increasing mrrs operations.
[...]

Again, it would be "MRRS" and "PCI" throughout.  Possibly also "device
flag" rather than "dev flag", but this is more of a nit pick.

Krzysztof
