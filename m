Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8AB4199C0
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 18:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhI0Q4r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 12:56:47 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:38775 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbhI0Q4q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 12:56:46 -0400
Received: by mail-oo1-f41.google.com with SMTP id z11-20020a4ad1ab000000b0029f085f5f64so6210470oor.5;
        Mon, 27 Sep 2021 09:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cKeUlYWx7gYOxJFwzzxufj8ho82oLKqCVAmN/2oSozE=;
        b=BBfIn/5+14XtblFFZZ/tGmAdiVxa34lzWsaOBZ7AWe59W7cBxPm5lUH8euiV5vlyLA
         9RkRCIE1YcP3qNQOpsaJjSh2uJudMg9OrEi2fhHG2N4dpNM54pec8Kf8L1p5AgHU2sI8
         vqgR/r3Fgs3MhRzh6MGaG91knxCwES0T/LZsEEdx9vNOzMYK8/0M/T9XeAVmWj1x25QA
         U5/UhjBCwjNcZghArRC7xwPyRm5cWy0POZ9ZYsRh6Zxxdh5CYqMdKttq0iEutvhd322E
         df/06jPLn+n5DR6wvpW7ynPrJJjixDBN5AzEI3dh9mis1pRcSfQZqonKjJPz98I+BAhW
         7KRg==
X-Gm-Message-State: AOAM532IO/Mj7i5hDZsw+J6ZJh4gUILYFQzTFyTHWJzOdfe1YgA7J7Ch
        rjGez/YoKfNy/TCQHA9PLQ==
X-Google-Smtp-Source: ABdhPJyZnCW9Dx5S4p0+DLUXG85OrY65XDrqMa/LWNACAtx1+qxhk+yRoMpQ8gz9n3tLjK9voIiZ1g==
X-Received: by 2002:a4a:c80b:: with SMTP id s11mr764319ooq.65.1632761708018;
        Mon, 27 Sep 2021 09:55:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p64sm3984945oih.29.2021.09.27.09.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:55:07 -0700 (PDT)
Received: (nullmailer pid 3458393 invoked by uid 1000);
        Mon, 27 Sep 2021 16:55:06 -0000
Date:   Mon, 27 Sep 2021 11:55:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Kettenis <kettenis@openbsd.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Saenz Julienne <nsaenzjulienne@suse.de>, sven@svenpeter.dev,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, maz@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, alyssa@rosenzweig.io,
        robin.murphy@arm.com, Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v5 2/4] dt-bindings: interrupt-controller: msi: Add
 msi-ranges property
Message-ID: <YVH3as0y2gt+z+5/@robh.at.kernel.org>
References: <20210921183420.436-1-kettenis@openbsd.org>
 <20210921183420.436-3-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921183420.436-3-kettenis@openbsd.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 21 Sep 2021 20:34:13 +0200, Mark Kettenis wrote:
> Update the MSI controller binding to add an msi-ranges property
> that specifies how MSIs map onto regular interrupts on some other
> interrupt controller.
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  .../bindings/interrupt-controller/msi-controller.yaml     | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Applied, thanks!
