Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3EB286519
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 18:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgJGQp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 12:45:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44282 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgJGQp5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 12:45:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id e20so2394504otj.11;
        Wed, 07 Oct 2020 09:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WnM1HniI+irqMb3dL1ZWNe6hwPnKvmLnla78RIiBA8M=;
        b=X9UHGgkrPVqE6KzJgpQRRE7JDF/S7KLWp/D8t6YWxAhgAvAx08klcpA+8Ca11PGaKL
         WEcpJg4x2ZGMD8fNXH5zKFHiDoDnUkLNeX9A1lrLoiml5ueyKR1KFiuXZbYbwnHVVSDY
         GbZp5njG4ceFZ8jBfnMKK0T8SwCQEuD1SDC5TCB3GqLI28qmnbNzSvfWRMMIS4kKyWfK
         tQClYX5rm0DwIN6J6tI051lANOpFZMAXx4oNJSsMEXkh2pG91PAnvgsxNK6s/Kzjo4Bp
         XnSmDLgf0O8O7sSsoNBa0b9Elix6ImcXNhlipDxUZ9BjXW30OpuFRvF7oqiij3sFNSSR
         fLoA==
X-Gm-Message-State: AOAM533Qq1+9/miDNS7I29tA/cwA9yuAzUW3I18whDDT4R7EUIWY6nNJ
        u1JyxlBLghMRPBZ1r940ag==
X-Google-Smtp-Source: ABdhPJwWdqTIyji6u3rGbBmzEdV7sRf9Y12L76pNZty+mjhrPlNN9ExtnBOuM4E38ARk8hcq/w/+DQ==
X-Received: by 2002:a05:6830:196:: with SMTP id q22mr2270160ota.221.1602089157027;
        Wed, 07 Oct 2020 09:45:57 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j75sm2290342oih.10.2020.10.07.09.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 09:45:56 -0700 (PDT)
Received: (nullmailer pid 359382 invoked by uid 1000);
        Wed, 07 Oct 2020 16:45:55 -0000
Date:   Wed, 7 Oct 2020 11:45:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH v7 3/3] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
Message-ID: <20201007164555.GA359326@bogus>
References: <1599816814-16515-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1599816814-16515-4-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599816814-16515-4-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 11 Sep 2020 18:33:34 +0900, Kunihiko Hayashi wrote:
> This patch adds misc interrupt handler to detect and invoke PME/AER event.
> 
> In UniPhier PCIe controller, PME/AER signals are assigned to the same
> signal as MSI by the internal logic. These signals should be detected by
> the internal register, however, DWC MSI handler can't handle these signals.
> 
> DWC MSI handler calls .msi_host_isr() callback function, that detects
> PME/AER signals with the internal register and invokes the interrupt
> with PME/AER vIRQ numbers.
> 
> These vIRQ numbers is obtained from portdrv in uniphier_add_pcie_port()
> function.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 77 +++++++++++++++++++++++++-----
>  1 file changed, 66 insertions(+), 11 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
