Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1528BEAC
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404016AbgJLRHH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 13:07:07 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42989 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404009AbgJLRHH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 13:07:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id 16so19381708oix.9;
        Mon, 12 Oct 2020 10:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a2xn/+GgwQqWyrD+ZSEN3mfGA6kk2+5ejAkBwwRM630=;
        b=GN+/7lb1z4zpW79KbbPFsK5Er/9rVnozuYkr5E/cc1ZjAwbdO5W69SHa32TSOYbn7N
         72s4BN5vek+/zddTUlrVIaL+PkeLRjKkQADg2ryh9BYBb80XOwkQO+wZ64T2CQeXIJh6
         YcwRncyRjyOQKA613od6Xk9zsPZBGO8QkVhv44T0SbT1qx2WG7oRoHQ8pbZ+gNkeqDe/
         S6SAPyQOijjLC9pN6jmVHeh0U+By0NOT/yVNA4+Pvcut2IrWGZdMFlTJ9qL/pHwWlSVT
         6jWlXmhcgeyiMMAwRR71tVnTv0FSrsVYoM6VDd8gjZgKXLYltDaMxHwz95vzPVTj5pSk
         fSYA==
X-Gm-Message-State: AOAM533wh9Ng0bKLfqNDNz3EqBKUdgGZSkScKBZaEOxFzL5hQ5rpes5J
        jaPyJJ8Ob76UVtWmfRdn+w==
X-Google-Smtp-Source: ABdhPJysap7a6nFLcVGrL9w5d0/nnNmFZN3FQotgKMPiTMPbbmrheZOSrq19vIboQlMmKuQhjGhxYA==
X-Received: by 2002:aca:ef03:: with SMTP id n3mr11172935oih.67.1602522426804;
        Mon, 12 Oct 2020 10:07:06 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v17sm8934191ote.40.2020.10.12.10.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 10:07:06 -0700 (PDT)
Received: (nullmailer pid 1761398 invoked by uid 1000);
        Mon, 12 Oct 2020 17:07:05 -0000
Date:   Mon, 12 Oct 2020 12:07:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, david.abdurachmanov@gmail.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v16 1/3] PCI: Call platform_set_drvdata earlier in
 devm_pci_alloc_host_bridge
Message-ID: <20201012170705.GA1761341@bogus>
References: <20201012105754.22596-1-daire.mcnamara@microchip.com>
 <20201012105754.22596-2-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012105754.22596-2-daire.mcnamara@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 12 Oct 2020 11:57:52 +0100, daire.mcnamara@microchip.com wrote:
> Many drivers can now use pci_host_common_probe() directly.
> Their hardware window setup can be moved from their 'custom' probe
> functions to individual driver init functions.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  drivers/pci/controller/pci-host-common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
