Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C4428BF18
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 19:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390741AbgJLRhk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 13:37:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40088 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390724AbgJLRhk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 13:37:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id m128so19496896oig.7;
        Mon, 12 Oct 2020 10:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wbgk4D07H7CuGbzhyg3Gn1Tmoy8o7fxYGrkJpVsJbkk=;
        b=P7kwI4oTWB0fIwFlxmm96DCAw7ihh320xXecU6Hp2KsW1WSxl/XwOVBFckKRdkodIE
         eLit0JBTKvjbZqL3ac8h68rp71wIqEsdAVtV1ljH8zyaVm1rL24YEEEQ8vozJXp1gECO
         Mal+Xgc4y/r7VS6PyV6fzOAmS0TB4s7BZ45JWq9/3E+pdMZv0b8APnMVgP2rVVndXvjQ
         TEzCI3q1NxGVhAgEgEap5JOGv9ga+RV2NzXvTZfpPhKEjtVCd9annNCQR1Uwm5lU+ntB
         Wk2ZzRrmsVEM9oEZh70+aXcWI16uILAqPYs3i2Uy6XXLYuu6ZlApeRwwWZGSmY0FJZ+O
         LtXg==
X-Gm-Message-State: AOAM530uTyrJT0GgEGWv/Jxg3ke79f0g3UjmrojWHWLRHwn/3MKPo/T6
        lQnA8ykNKOHo6mteJDvRIQ==
X-Google-Smtp-Source: ABdhPJyuVzMIc3x8iuqvlKzqJdEkp6n3bvftVjVboxd9/7jMHIUj8f+vyZ17dj8HTqw7G9hRBXghbg==
X-Received: by 2002:a05:6808:254:: with SMTP id m20mr11796147oie.139.1602524259310;
        Mon, 12 Oct 2020 10:37:39 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e3sm10515272ooq.0.2020.10.12.10.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 10:37:38 -0700 (PDT)
Received: (nullmailer pid 1801910 invoked by uid 1000);
        Mon, 12 Oct 2020 17:37:37 -0000
Date:   Mon, 12 Oct 2020 12:37:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        david.abdurachmanov@gmail.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v16 3/3] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20201012173737.GA1801858@bogus>
References: <20201012105754.22596-1-daire.mcnamara@microchip.com>
 <20201012105754.22596-4-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012105754.22596-4-daire.mcnamara@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 12 Oct 2020 11:57:54 +0100, daire.mcnamara@microchip.com wrote:
> Add support for the Microchip PolarFire PCIe controller when
> configured in host (Root Complex) mode.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  drivers/pci/controller/Kconfig               |   9 +
>  drivers/pci/controller/Makefile              |   1 +
>  drivers/pci/controller/pcie-microchip-host.c | 541 +++++++++++++++++++
>  3 files changed, 551 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-microchip-host.c
> 

Reviewed-by: Rob Herring <robh@kernel.org>
