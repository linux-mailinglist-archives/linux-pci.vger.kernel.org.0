Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583AA3CF261
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 05:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242493AbhGTC07 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 22:26:59 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:45053 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359643AbhGSVVo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 17:21:44 -0400
Received: by mail-il1-f169.google.com with SMTP id r16so17383742ilt.11;
        Mon, 19 Jul 2021 15:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UMxNYOa6GFQ2yWFsW7YtMcQjvxfp7+eaoSFXUNRfn6A=;
        b=cQ9PxpfKtthPk3ZmlKrEJkWcEMcrQ7YR0Nt6rVPfqFoDBiVpGLZf9JqJsWNIqskPvu
         Zknn5eujccp7QH/oPH9GE+iB7EzLiK5C5rAgS+ivk5RphMyIN8bqkryACSmp1otf6K2I
         HygWLcnTyIyHhwkXV9nMjs0I0uQLBByhJOt/vaULe47RyKSJP1wnQdofENWwz3dI83ov
         yubBA9PjrZsCCbS4aVebpL/68JZqhBGlYlG8WorOApZUuWDeZSdPWpEgPZB0Q9YiCwlx
         qOB+eh3+PvMtewbzjLeaYTFO9Of7kvy+PKc2qgTHwXgtRSIOUExZ3J8+4aJKzfMsr6dg
         luIg==
X-Gm-Message-State: AOAM5309oNvWD0UJVg23E1m18NYSwOXKhJofHjI3LIvTS23E8YNlEwDX
        +cFEieZO7oVSDAapdELeug==
X-Google-Smtp-Source: ABdhPJxNChHhs6b16tj/puB+kP93VdK+bZJ4b5isvYqWhF9zhaAwIL3zEsY3WxQGhs0z4bdtfVmNwA==
X-Received: by 2002:a05:6e02:5ce:: with SMTP id l14mr18617614ils.147.1626732137683;
        Mon, 19 Jul 2021 15:02:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n18sm3515332ioz.5.2021.07.19.15.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:02:17 -0700 (PDT)
Received: (nullmailer pid 2676626 invoked by uid 1000);
        Mon, 19 Jul 2021 22:02:13 -0000
Date:   Mon, 19 Jul 2021 16:02:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-pci@vger.kernel.org, mauro.chehab@huawei.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linuxarm@huawei.com
Subject: Re: [PATCH v5 1/5] dt-bindings: PCI: add snps,dw-pcie.yaml
Message-ID: <20210719220213.GA2676489@robh.at.kernel.org>
References: <cover.1626608375.git.mchehab+huawei@kernel.org>
 <53363a7609176ca56c47ef57287466ee84087dc5.1626608375.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53363a7609176ca56c47ef57287466ee84087dc5.1626608375.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 18 Jul 2021 13:40:48 +0200, Mauro Carvalho Chehab wrote:
> Currently, the designware schema is defined on a text file:
> 	designware-pcie.txt
> 
> Convert the pci-bus part into a schema.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 102 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> 

Applied, thanks!
