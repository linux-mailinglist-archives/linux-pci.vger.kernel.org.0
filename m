Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B15358914
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 17:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhDHP6k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 11:58:40 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:47025 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhDHP6h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 11:58:37 -0400
Received: by mail-oo1-f43.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so609941oof.13;
        Thu, 08 Apr 2021 08:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6J4L/TsHJ2gKS1KfT1jfs3S232wn3ZqOeaVbpNbMR50=;
        b=id9jjnFVw46xw1IVJ/y2KAuq04WVqFVHzq/7zXR+wA4/d9W2YmVKBs5s0k0zuZnaP5
         4vq0Eq3skVZsoOmPiP2cZJ9+qZp8YtuforU4e0yYLaw/8x4QcNWOyeFvoIkAQgRBVNxy
         Nn8RzHg+cJMfEfeofahCJvLMFCyEdoQ5t3v7POqbqe3PaPQfBHGeRymWjOtaRtLlp6U4
         3GNxX5ia9OyaBLdZ7k/WGA6f1o5vm0H3+yW4/aGgkZxVIwP1un3mtgERDnjgI4CwO3xl
         Zqmc2PIuN9iT+QuqOhM0ZrqiiAtYBZUROx+Z6jW0eCBoEbvhuKDznOpPVdiSNoZAxolU
         YxiA==
X-Gm-Message-State: AOAM530UYkbthlNL3ewOxOGDAw2y3gWNAA1gAnP0qoIqF+HfkH3tREz+
        IuEZLn+arzuIV/5uMVns+Q==
X-Google-Smtp-Source: ABdhPJwe1NgTXpk1jXSjJcDpXkDclx6OHy852pAAAlbNj1hDALIwQ1pjKNO6ghh860jhdWIrEsJCQQ==
X-Received: by 2002:a4a:bd1a:: with SMTP id n26mr7989991oop.45.1617897505861;
        Thu, 08 Apr 2021 08:58:25 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 10sm6179615otq.10.2021.04.08.08.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:58:25 -0700 (PDT)
Received: (nullmailer pid 1552624 invoked by uid 1000);
        Thu, 08 Apr 2021 15:58:23 -0000
Date:   Thu, 8 Apr 2021 10:58:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     lorenzo.pieralisi@arm.com, hes@sifive.com, zong.li@sifive.com,
        jh80.chung@samsung.com, aou@eecs.berkeley.edu, robh+dt@kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        paul.walmsley@sifive.com, linux-clk@vger.kernel.org,
        alex.dewar90@gmail.com, p.zabel@pengutronix.de,
        erik.danie@sifive.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mturquette@baylibre.com,
        vidyas@nvidia.com, sboyd@kernel.org, bhelgaas@google.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host
 controller
Message-ID: <20210408155823.GA1520096@robh.at.kernel.org>
References: <20210406092634.50465-1-greentime.hu@sifive.com>
 <20210406092634.50465-5-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406092634.50465-5-greentime.hu@sifive.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 06 Apr 2021 17:26:32 +0800, Greentime Hu wrote:
> Add PCIe host controller DT bindings of SiFive FU740.
> 
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  .../bindings/pci/sifive,fu740-pcie.yaml       | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
