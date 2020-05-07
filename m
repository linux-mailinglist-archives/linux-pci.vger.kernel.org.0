Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A995B1C9DEE
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgEGVwP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:52:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43119 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGVwO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:52:14 -0400
Received: by mail-oi1-f195.google.com with SMTP id j16so6601614oih.10;
        Thu, 07 May 2020 14:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CwgFZL2zIVeDh4eNZXkAe/EzqtLQXZ+cEahULpHlwag=;
        b=TiHKt4zUJcdlGhiH6FIosXPwbKIC3eLlh9Wq07RVaokOuktlb13gxmFj+/au9iVLxl
         7lX+4D+R74UEbvXS2Ytzq62izv/TFPALfFkBgOJQ8bpztxWtDLbNlrFsijZ7+nhdv3nb
         03rAY0nnH7RjtqaeZk3TKth+zFh9Sy/6/wvBVeNH763RaXs7d9n7299FRTUdqDN8zAnd
         SZb70/NZcbCg1qZIxw+pdtbz3hBOVZE3nsH9pEtgJc1ZjGRMMn3y6brM2Grr+sEczkp9
         eipbic4yig3mBMgRhjxHy6woeV7F/JhKAVw2hc6MmUWmVyCF7bSPP37W/ZKqEwACqTPC
         fp4g==
X-Gm-Message-State: AGi0PuZycNi4pY1Qn9WhgbYlOO+H3PuaNVaID9QylW8Zjm7aJclkevr9
        bo7EIcNRLooXTN2gKd/WxA==
X-Google-Smtp-Source: APiQypK0tS24FRujE0yM/MXXbar4hioN4XKMy8/zNA1q7Wdtq10bfTLMJhAeyQQLoMBuj8hAeHLkFw==
X-Received: by 2002:aca:31c2:: with SMTP id x185mr8444912oix.45.1588888333726;
        Thu, 07 May 2020 14:52:13 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a22sm1654553otf.42.2020.05.07.14.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:52:13 -0700 (PDT)
Received: (nullmailer pid 6666 invoked by uid 1000);
        Thu, 07 May 2020 21:52:12 -0000
Date:   Thu, 7 May 2020 16:52:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 RESEND] MAINTAINERS: correct typo in new NXP
 LAYERSCAPE GEN4
Message-ID: <20200507215212.GA6603@bogus>
References: <20200506052130.5780-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506052130.5780-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed,  6 May 2020 07:21:30 +0200, Lukas Bulwahn wrote:
> Commit 3edeb49525bb ("dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4
> controller") includes a new entry in MAINTAINERS, but slipped in a typo in
> one of the file entries.
> 
> Hence, since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>   warning: no file matches F: \
>     drivers/pci/controller/mobibeil/pcie-layerscape-gen4.c
> 
> Correct the typo in PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Rob, please pick this patch (it is not urgent, though).
> 
> v1: https://lore.kernel.org/lkml/20200314142559.13505-1-lukas.bulwahn@gmail.com/
>   - already received: Reviewed-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>   - Bjorn Helgaas' suggestion to squash this into commit 3edeb49525bb
>     ("dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4 controller") before
>     merging upstream did not happen.
> 
> v1 -> v2:
>   - v1 does not apply after reordering MAINTAINERS, i.e., commit 4400b7d68f6e
>     ("MAINTAINERS: sort entries by entry name") and commit 3b50142d8528
>     ("MAINTAINERS: sort field names for all entries").
>   - PATCH v2 applies on v5.7-rc1 now. Please pick v2 instead of v1.
> 
> v2-resend:
>   - resend of v2: https://lore.kernel.org/lkml/20200413070649.7014-1-lukas.bulwahn@gmail.com/ 
>   - still applies to v5.7-rc4 and next-20200505
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
