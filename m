Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792883EB3DC
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 12:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbhHMKNl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 06:13:41 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:40515 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239586AbhHMKNi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 06:13:38 -0400
Received: by mail-lf1-f42.google.com with SMTP id w20so18983121lfu.7;
        Fri, 13 Aug 2021 03:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fvmh77W4uhKVvn/qcwC9APViTa+q9zOugfg6212r9Pg=;
        b=BH8fhZkuCbbpRxho2hkp+DkYgszCbpToH+9zleDKwtr1+6C+fIWdECxDAbt5pVRt9x
         6tD8IoIt4pKbOryHNhNqXN0ay5PMVMJKsD3sg0Rh2vZUoNlmmuM6MzbT/m0le9EBQD7H
         F14XYNLgCObgfvol9mKmiEe5f3I7BWOWTqsPzRaO8wBu169I0Q1ZX0ZwO7woLKR4E2tf
         y52q1KwjToJHimvpyJBCT4xidAGVJQpAsAn5IJw/G8lEKaBFy3LSnd5uIblAkDe2mioq
         sIgn0QolvIJjZAaVofO4M4tFPcEC2qX5e5eRmKbMK8Hl/uVF8TRHSBXivYFn892DFeDb
         te5w==
X-Gm-Message-State: AOAM531N+IKdAEymwgqjg0ivQBq6vKhVh/EZJDjgSBmkrzlaum6olv2Y
        M+dGehQv/fs/4mTgCC3W+tmUAH6yFw5VptJdpyE=
X-Google-Smtp-Source: ABdhPJy+YoLJqti5c7TN3z6hfEgLcoaNhrwLJpZ0jP2eXw3k5xRuqb9WBJNjgvaMTu1yeYw/Vye4+Q==
X-Received: by 2002:a05:6512:2296:: with SMTP id f22mr1136302lfu.248.1628849590561;
        Fri, 13 Aug 2021 03:13:10 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u24sm111115lfc.162.2021.08.13.03.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 03:13:09 -0700 (PDT)
Date:   Fri, 13 Aug 2021 12:13:05 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCIe: limit Max Read Request Size on i.MX to 512 bytes
Message-ID: <20210813101305.GA598827@rocinante>
References: <m37dgp20cr.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m37dgp20cr.fsf@t19.piap.pl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

[...]
> This patch makes the RTL8111 work on i.MX6.

Would it be possible to implement this particular MRRS fix as a quirk
only for the i.MX6 controller?  Unless this is something that we need in
the core, a quirk would be preferred over something that changes the PCI
core.

An example of such quirk might be the one currently implemented for the
Loongson controller, as per:

  https://elixir.bootlin.com/linux/v5.14-rc5/source/drivers/pci/controller/pci-loongson.c#L63

	Krzysztof
