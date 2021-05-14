Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97F3380A59
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 15:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhENNXj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 09:23:39 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:45984 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhENNXj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 09:23:39 -0400
Received: by mail-wr1-f54.google.com with SMTP id h4so30009038wrt.12
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 06:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aTq0oe3Fv2QJnIG0k4arwy1DcjhikT+/71Nk8lxk+JA=;
        b=fKaaEhkVVJdhnipWAenpOjsJAqvjlPPxYYVh0kIzW2W9Fuw5jrk7o/bixCqZqFc0RX
         3Vf3AufWMLsjYh5SLhcea7cljQTQuEAFLDwjSTarsVqoHzPTh4VH/bNs9dCi2EfV0fX+
         G6YpLPzfi/bVkLr6Kve4YLws7tMwe6mDj2U71Fswv2eWdXfKGWoz6TgsZ+X0FHoN2KA6
         frd4h3Q/NheNmqJPKS89Wx2tVv1d41+Jd/6EEbR3YKwAAaLmwZPIXDttWZVjVb8wK7NC
         bZheg0tNFFy42QPwy7f0zhpR7KlNWz7b1sn3iahBMvQ2dG9zywFD8xKymmJdN4aEO+9D
         0XWw==
X-Gm-Message-State: AOAM532D4nbNxNglwxLyj7LR5hO4JgIWM0iDe8H8zBpKRQFW6RYSz1JU
        TP3/0GjjkEZmy/GuIaLUbK8=
X-Google-Smtp-Source: ABdhPJyv3JdQaSeOo8V+8fVog8VENgrBGwojvm6y/oxx1Sqv6sM6xNwuYB6RRnshWnV+2BQfuyTJ5g==
X-Received: by 2002:a5d:64eb:: with SMTP id g11mr59612053wri.260.1620998547465;
        Fri, 14 May 2021 06:22:27 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f4sm6738009wrz.33.2021.05.14.06.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 06:22:26 -0700 (PDT)
Date:   Fri, 14 May 2021 15:22:26 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: Re: [PATCH 4/5] PCI: Add quirk for multifunction devices of LS7A
Message-ID: <20210514132226.GF9537@rocinante.localdomain>
References: <20210514080025.1828197-1-chenhuacai@loongson.cn>
 <20210514080025.1828197-5-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210514080025.1828197-5-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jianmin,

[...]
> In LS7A, multifunction device use same pci PIN and different
> irq for different function, so fix it for standard pci PIN
> usage.

It would be "PCI" instead of "pci" and "IRQ" instead of "irq" in the
commit message.  This would also be true in the other patches in this
series.

[...]
> +	if (pci_match_id(devids, dev)) {
> +		u8 fun = dev->devfn & 7;

You could use the PCI_FUNC() macro here.

Krzysztof
