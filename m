Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179D5280490
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbgJARHD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 13:07:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34887 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbgJARHD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 13:07:03 -0400
Received: by mail-ot1-f68.google.com with SMTP id s66so6194659otb.2
        for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2020 10:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x3Uqk7RUDD4P/cWUH5DEpveOz3I0qVfowr1XRqC33vc=;
        b=RVkd1OImugvdWLQQxYPYkxZeH51JSIg7fSU47MKya+l4fXKrt2e2c6osBYtNYHlZHk
         kqwXY+u/syQc3U4ZnJ8jGcxdRurvYfyRh/kf+lGnZma7fvic9RS7M4qm/RnvVHGTOlcU
         88NfJHhrAhtGb5SqS791BtFVNiSHytq7jfFKKH+z/KBWAe4/Pdqm9j0n+1M96mcp8llB
         4+HVFPd9A8+t3rtJHGzwY/+8WhckulW21EfJBELzwMkNd9pe2GxBTLKRq1heiaTN1KVS
         Fxx8rEFtXkpNraiAxpfCF4lEJSnp3Y6K6IzfbNX1QbpjoCCQlvp+Q1+9W21s+4PqjHAG
         DK/Q==
X-Gm-Message-State: AOAM531zJip5IC9L92kTTz4CJFSkQRf3HH7OQd6L2u01dinOLtvkOIgj
        c1MrgXnK7SE7amD10KpulA==
X-Google-Smtp-Source: ABdhPJx5lppRCcvZVKuAtlTAyZjjK4W9Xm49D+tf5usEraXCM6xu42ZkGuff2W04hryx1px8Q68jAg==
X-Received: by 2002:a05:6830:14cb:: with SMTP id t11mr5840296otq.74.1601572022638;
        Thu, 01 Oct 2020 10:07:02 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a6sm1329235otf.51.2020.10.01.10.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:07:02 -0700 (PDT)
Received: (nullmailer pid 893058 invoked by uid 1000);
        Thu, 01 Oct 2020 17:07:01 -0000
Date:   Thu, 1 Oct 2020 12:07:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] PCI: iproc: Fix using plain integer as NULL pointer in
 iproc_pcie_pltfm_probe
Message-ID: <20201001170701.GA709405@bogus>
References: <20200922194932.465925-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922194932.465925-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 07:49:32PM +0000, Krzysztof Wilczyński wrote:
> Fix sparse build warning:
> 
>   drivers/pci/controller/pcie-iproc-platform.c:102:33: warning: Using plain integer as NULL pointer
> 
> The map_irq member of the struct iproc_pcie takes a function pointer
> serving as a callback to map interrupts, therefore we should pass a NULL
> pointer to it rather than a integer in the iproc_pcie_pltfm_probe()
> function.
> 
> Related:
>   commit b64aa11eb2dd ("PCI: Set bridge map_irq and swizzle_irq to
>   default functions")
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/controller/pcie-iproc-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Not sure what I was smoking that day...

Reviewed-by: Rob Herring <robh@kernel.org>
