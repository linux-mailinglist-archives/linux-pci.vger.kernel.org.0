Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36C6392D63
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 14:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbhE0MCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 08:02:01 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:34519 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbhE0MCA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 08:02:00 -0400
Received: by mail-pg1-f170.google.com with SMTP id l70so3543113pga.1;
        Thu, 27 May 2021 05:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7E+snXRKtF61Jjk2GKrLUclqVALjjRqEpKc9vwHiVQ=;
        b=HJ2FEUFT1+9sB0mWryK2uZ1Gm2NIHVTc8xuGypaVIbmhHZZlJECOujepdPtgFCDPET
         bgcJgpBv0fEVPfyjbw52VUNBQiGz/7kRTb5lTl4vX29+SBvYAWT1R2yExiY2LGaSyFcq
         yXflbXum0cC5OC6IpVhfkyI4LT+rqRDJNf9OxU3tm2fzyeKb+kCkiiFO3xfyHNDSIjKK
         au9fKuo5opB/nI/8hWSth4F4WLnleS6ybf6SMB0zo+jZyueEpMg24pTSYWqN/46d/s+5
         olMQskVOzp2fTNL9fBtFfHnKWFZiHpd6JfBHBpH9ISxxcC8D0i+Z+zdzquxSJA7b0Mwe
         Ll+g==
X-Gm-Message-State: AOAM532enrE3nxsFaROPe04Kl+DzD81HSWfI1iib3aBO0am5imhLPFDm
        RyrGMSSyvMCbkkmuiioU3qE=
X-Google-Smtp-Source: ABdhPJzffr3IEnwebY9euYhPooD2T3JRPqy4zfTamBLic9O2jynwPlQfxC3YPXAGd5JSwSF91p3vBQ==
X-Received: by 2002:aa7:8159:0:b029:2c5:dfd8:3ac4 with SMTP id d25-20020aa781590000b02902c5dfd83ac4mr3027137pfn.16.1622116827627;
        Thu, 27 May 2021 05:00:27 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g8sm1701207pfo.85.2021.05.27.05.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 05:00:27 -0700 (PDT)
Date:   Thu, 27 May 2021 14:00:15 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Om Prakash Singh <omp@nvidia.com>
Cc:     vidyas@nvidia.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [RESEND PATCH V1 0/5] Update pcie-tegra194 driver
Message-ID: <20210527120015.GA213718@rocinante.localdomain>
References: <20210527115246.20509-1-omp@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210527115246.20509-1-omp@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prakash,

Thank you for sending the patches over!

> Update pcie-tegra194 driver with bug fixing and cleanup
> 
> Om Prakash Singh (5):
>   PCI: tegra: Fix handling BME_CHGED event
>   PCI: tegra: Fix MSI-X programming
>   PCI: tegra: Disable interrupts before entering L2
>   PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
>   PCI: tegra: Cleanup unused code
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 36 +++++++++++++---------
>  1 file changed, 22 insertions(+), 14 deletions(-)

Why the resend?  I saw you send this series before, and now you are
resending it?  Help me understand what is going on here.

	Krzysztof
