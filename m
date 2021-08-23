Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AA13F4FC4
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 19:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhHWRra (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 13:47:30 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:47018 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhHWRr3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Aug 2021 13:47:29 -0400
Received: by mail-ot1-f45.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso38429324ott.13;
        Mon, 23 Aug 2021 10:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XHNF8BxjxXpv6CzNLgilJHOEQR50UikOzfYV8iQxCns=;
        b=mA/aBGPtX8ptEyFvbNVLVQ1XeViNKUgNByIgsZmsCJXvzDjiVdhuftjtBJMzQ/Vld+
         zY3mru6pjXWBiVb/oF5tnCImVgEhO5qkqHNRKT9S6eDsPxeTQyw3wb64PBjEiwedARNl
         7/WXcVCgqA46sDvyMErV9uYPHqmzJLiLuZc8G4hZm3jh4knYKl94QeqdOhDLePERJV4g
         BJCTGvSZBoZIGonbRZiI8mezz7V6R4qOE3bxb49ckGEOPyQCyqrQBSXdog4BUt5ycwR6
         U4LzccBYsKIUAHgq3DWFslj6CrXDbk7CZKEL00qcLzgYu7gvFYRu2TroZF2Ft792Wg3E
         uqtw==
X-Gm-Message-State: AOAM530RzWLwDADKZFqbeEBNZQ3zP8/sr8sVkTvwpmqFRBGrEw+/Pspo
        mV9jxTpzV3SPFkS0EKZr/Q==
X-Google-Smtp-Source: ABdhPJygvaINZvqR7FAI08t3BnM76I+gLS3HOs26kncyFvVhQh0dyUD2ovtmksZvoUF1xQ/OV8lMgg==
X-Received: by 2002:a9d:5cb:: with SMTP id 69mr29480121otd.90.1629740806543;
        Mon, 23 Aug 2021 10:46:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q26sm3904178otf.39.2021.08.23.10.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 10:46:44 -0700 (PDT)
Received: (nullmailer pid 2409335 invoked by uid 1000);
        Mon, 23 Aug 2021 17:46:43 -0000
Date:   Mon, 23 Aug 2021 12:46:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Perform host_init() before registering
 msi
Message-ID: <YSPfA88EOrXn5Ifq@robh.at.kernel.org>
References: <20210823154958.305677-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823154958.305677-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 23, 2021 at 08:49:57AM -0700, Bjorn Andersson wrote:
> On the Qualcomm sc8180x platform the bootloader does something related
> to PCI that leaves a pending "msi" interrupt, which with the current
> ordering often fires before init has a chance to enable the clocks that
> are necessary for the interrupt handler to access the hardware.
> 
> Move the host_init() call before the registration of the "msi" interrupt
> handler to ensure the host driver has a chance to enable the clocks.
> 
> The assignment of the bridge's ops and child_ops is moved along, because
> at least the TI Keystone driver overwrites these in its host_init
> callback.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - New patch, instead of enabling resources in the qcom driver before jumping to
>   dw_pcie_host_init(), per Rob Herring's suggestion.
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
