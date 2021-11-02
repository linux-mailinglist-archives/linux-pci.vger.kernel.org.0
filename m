Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D468A443063
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 15:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhKBOaN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 10:30:13 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:43621 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhKBOaI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Nov 2021 10:30:08 -0400
Received: by mail-ot1-f54.google.com with SMTP id n13-20020a9d710d000000b005558709b70fso23762796otj.10;
        Tue, 02 Nov 2021 07:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iJsAkCsAmGZv5gRDRXSkbNwK6vmPsC2LYUXejh0824s=;
        b=o//fYDtEvJhuc7bEeMJiG0Z4MeQ7n1XfTyzgFFta+JuZF71p8wKg4E9AP9jtqkSTuV
         p8RFSRuETZNyMlCe5GVPybVD70ZnZt9WAxFal1k/w+mJtw9QB/5r4mUOlQ+Ilto3dG4B
         YrETMgFgL59zrqBNPNW6NM5tWoVmGumUkE4+dVkBsE0gQQDxfTirXrRmSddeJTpIqnwa
         3Hir0AecTn7k3WCDo+e7SUA7iIT9WzeEF6i93NRLHRq5O0qjqdnLSo91XBT3aVx1gJNh
         Hjy5sWlKbmj07CyVc2+In5vrU4nFHOebjNYac2IQekJihtTXByroponKwl/gLJ+PkDmA
         ij8A==
X-Gm-Message-State: AOAM533gOjr0Kk8Qd4RviVn5VwKY5u8IpAxHO+CBju7hBemtsvDuFvwW
        I7Sc5lK1+qq8mdWxFDFd8g==
X-Google-Smtp-Source: ABdhPJzGWhZyyJSZnmIhNcfiPdiSLvkAudb19QtTakiAtFsSxK1EZgasqAS8pi+xSgZqWWJm66Ifag==
X-Received: by 2002:a9d:518a:: with SMTP id y10mr21488710otg.143.1635863253170;
        Tue, 02 Nov 2021 07:27:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j25sm3377889oos.23.2021.11.02.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 07:27:32 -0700 (PDT)
Received: (nullmailer pid 2822626 invoked by uid 1000);
        Tue, 02 Nov 2021 14:27:31 -0000
Date:   Tue, 2 Nov 2021 09:27:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     devicetree@vger.kernel.org, james.quinlan@broadcom.com,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-pci@vger.kernel.org, Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/9] dt-bindings: PCI: correct brcmstb interrupts,
 interrupt-map.
Message-ID: <YYFK0xL1YI40OgZF@robh.at.kernel.org>
References: <20211029200319.23475-1-jim2101024@gmail.com>
 <20211029200319.23475-2-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029200319.23475-2-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 29 Oct 2021 16:03:09 -0400, Jim Quinlan wrote:
> The "pcie" and "msi" interrupts were given the same interrupt when they are
> actually different.  Interrupt-map only had the INTA entry; the INTB, INTC,
> and INTD entries are added.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
