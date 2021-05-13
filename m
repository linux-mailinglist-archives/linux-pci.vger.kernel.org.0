Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A3937F7D7
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 14:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhEMMZW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 08:25:22 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:50907 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhEMMZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 08:25:10 -0400
Received: by mail-wm1-f51.google.com with SMTP id n84so14526813wma.0;
        Thu, 13 May 2021 05:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WrcAU6wwcdMJFXxb8XjuI/OTyRKoaGVru0dfz1KIdrI=;
        b=EN8v9AJnyF81joBuiSUA0QxqMrXxjZF4Y75IAY2iI1SyAQtCS7xuJcyIJU8hVyD9kr
         P6J8H50QKfPMdQ6VprHQTmg/gh1+GwMCFTi0CJ740Fhbyc6+dHW8wrXItVohtbDyXF2H
         eFen6KW+DvNgI2t55TYmz//zy7MYGZyvyYOxs9XfBUpaNsJOpRXvvgX4MJ8jrQoyUrl5
         pItYiJKbjmCIJmpwlBJRcIoaPIcAjxDKV3EiOxa5t6UVKZP9IcFykq65h9s1RcWwsRmm
         I2zhMPQTLUk9jBJEaXollyfLnwJCONGhE5nwSHm8/eGFaBz07y80PQuzSx0PYFqdXtso
         iECg==
X-Gm-Message-State: AOAM531k7WDAB8Z4ByQmtVnXN2aUqh7S3aOjn1jBw/7nPSRdhPeCuGFj
        cbBgfVP23TW8X2dyThjn3w3Xa6G+5lu6YQ==
X-Google-Smtp-Source: ABdhPJza5g00+4SStFgJ9FijkgbHFo3chP1dcMRIqjEFy/h06G5k32DxoklDB3QKXxjMCJPSHXxwkw==
X-Received: by 2002:a7b:c0cf:: with SMTP id s15mr3622290wmh.110.1620908639978;
        Thu, 13 May 2021 05:23:59 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id h15sm2132236wmq.4.2021.05.13.05.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:23:59 -0700 (PDT)
Date:   Thu, 13 May 2021 14:23:57 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: move to use request_irq by IRQF_NO_AUTOEN
 flag
Message-ID: <20210513122357.GA202784@rocinante.localdomain>
References: <1620907394-55649-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1620907394-55649-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Tian,

Thank you for sending the patch over!

> request_irq() after setting IRQ_NOAUTOEN as below
> irq_set_status_flags(irq, IRQ_NOAUTOEN);
> request_irq(dev, irq...);
> can be replaced by request_irq() with IRQF_NO_AUTOEN flag.

A few comments.

The commit message is a bit terse and the subject could be improved
a little.  Does this change fixes an issue with the driver?  Why is this
flag needed?  The commit message could explain better why this change is
needed, etc.

Krzysztof
