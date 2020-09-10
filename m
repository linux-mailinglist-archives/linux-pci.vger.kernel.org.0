Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A91F264EA2
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 21:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIJTUf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 15:20:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39849 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbgIJPwd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 11:52:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id n14so4870571pff.6;
        Thu, 10 Sep 2020 08:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yt6inZ4UVSNp7xfQ5Plp2PnI8YcMVVKMln56iwBh8fs=;
        b=F0qPmPKaR71w7SxVOhw3Hj46grlXMK8kT5UdunY/7kwzLLUSEKQw7oS1UFGPdRe6C3
         pptJp2O1VyL1kCOg/m6YnSDQFaDoxdRn5eMuwCMLseK/E4CwBXQ+NQY0xXzQz0x7/OeC
         tLMGp7ppwuWoO+CdyAaC5anTasnnKk9v4qwijLi9ZnoAJyURzpYAxaD9oo2mHayDizq2
         iTLT/b20GUAKtb/IAv2pz1hGhYlPRHe7h776lcxLKtqrkgZq+cYwrOe3JygWT+Q6lysc
         L13x7UZuVFskF/WyJCHBzhQHlKY8fiX9KiAaKxiCCqGdKRBgNBQ1J4dr8Ux3P0fi1Yd4
         EpxA==
X-Gm-Message-State: AOAM533i2S4SviFv8mcW67sIp/ArakZr0eErpYHMvwAEBiJTmhytREd4
        PzV9Qw46BiP1u1vEQeEhjE6gMR1hk/Zj
X-Google-Smtp-Source: ABdhPJz6scHFdf953mHrwXN0AX9Pbo0NXFqGtbx0EruBY0rGXTEyV/UoIGrIfI2nDFwWE4bP1rfySg==
X-Received: by 2002:a5d:928a:: with SMTP id s10mr7999788iom.166.1599752680735;
        Thu, 10 Sep 2020 08:44:40 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id m87sm3388997ilb.58.2020.09.10.08.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:44:40 -0700 (PDT)
Received: (nullmailer pid 423370 invoked by uid 1000);
        Thu, 10 Sep 2020 15:44:37 -0000
Date:   Thu, 10 Sep 2020 09:44:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 03/11] PCI: brcmstb: Add bcm7278 register info
Message-ID: <20200910154437.GA415514@bogus>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-4-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824193036.6033-4-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 24, 2020 at 03:30:16PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Add in compatibility strings and code for three Broadcom STB chips.  Some
> of the register locations, shifts, and masks are different for certain
> chips, requiring the use of different constants based on of_id.
> 
> We would like to add the following at this time to the match list but we
> need to wait until the end of this patchset so that everything works.
> 
>     { .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
>     { .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
>     { .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
>     { .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 105 +++++++++++++++++++++++---
>  1 file changed, 93 insertions(+), 12 deletions(-)

I think a better abstraction would be to have 2 versions of the 2 
functions that need to be different. But as-is is fine.

Acked-by: Rob Herring <robh@kernel.org>
