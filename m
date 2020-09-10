Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2191E2649A2
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 18:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgIJQYQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 12:24:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41365 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgIJQWs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 12:22:48 -0400
Received: by mail-io1-f66.google.com with SMTP id z13so7715071iom.8;
        Thu, 10 Sep 2020 09:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x6OVAQDQzdq4Ax57japRQmg3Kt6tqa724ilE749v5J4=;
        b=KaPyBZcaC04//Ehq0Skajr+JEo26pxveDzgxEmghdQ8CV+vYdJmlhFtbnZxfWlKE70
         jNrQ6vvKzbCdpbawDKbY9nO/TW3LbNxOAk72pfsl8SmSYp0J1mgF2u2He59JN23ktOAF
         OIijDP7pzdYWVo+8jWqrJhkFE3Jd2EGqf5bIC7Gq5Puv+hFSD3u3bV/rOEaYLbtGRVoL
         w5Ecc/HN41m82f+Qz4237pOZEJRr9KSBAGpP4bgIlPqNcbTcexolNKxl7daNEQ4PzcXX
         MRR8lv8vOXMqw/TCFgUzAb3Xts1qjOG8zN69CFPpKZR1tWomrRG9bPAlkyiE9/grpnnH
         0yag==
X-Gm-Message-State: AOAM533Xr5o0kOMiaYRFGmI0XTDkVT6a5JaehN7Ms6DuxBL8AAix5lV6
        xNRmUJLAyotoRRhiZA4b3g==
X-Google-Smtp-Source: ABdhPJw4Thmx5N2ZRDFawSye6Tqzmj20WVyp4QCJb16NMBP8tvFUnBNZw3i+HbuDS33bT1SUtnOW7A==
X-Received: by 2002:a5e:c906:: with SMTP id z6mr8071995iol.86.1599754966762;
        Thu, 10 Sep 2020 09:22:46 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id k16sm2994874ioc.15.2020.09.10.09.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 09:22:46 -0700 (PDT)
Received: (nullmailer pid 473755 invoked by uid 1000);
        Thu, 10 Sep 2020 16:22:43 -0000
Date:   Thu, 10 Sep 2020 10:22:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 10/11] PCI: brcmstb: Set bus max burst size by chip
 type
Message-ID: <20200910162243.GA473672@bogus>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-11-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824193036.6033-11-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Aug 2020 15:30:23 -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> The proper value of the parameter SCB_MAX_BURST_SIZE varies per chip.  The
> 2711 family requires 128B whereas other devices can employ 512.  The
> assignment is complicated by the fact that the values for this two-bit
> field have different meanings;
> 
>   Value   Type_Generic    Type_7278
> 
>      00       Reserved         128B
>      01           128B         256B
>      10           256B         512B
>      11           512B     Reserved
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
