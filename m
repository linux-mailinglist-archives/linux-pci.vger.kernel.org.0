Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0D3EA4F7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 14:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbhHLM5X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 08:57:23 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43733 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbhHLM5X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 08:57:23 -0400
Received: by mail-ot1-f42.google.com with SMTP id r16-20020a0568304190b02904f26cead745so7563243otu.10;
        Thu, 12 Aug 2021 05:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Dn1hE2ukpz/WECVCplI+uSk9eP83Ym70szgfvUF3Ew=;
        b=E/L/+q+kpH61k3Z+SzMUkFXlxIOZK4yb1KaGUtDpweA8kSMS2+DiaJj7TsVRAoBQzD
         0kIzTFf1OJw+nXXclxCbGw3li/5O4GcRLkUkGXkI+/KogCCJb3IQbZLKSb+fkeEhBJKA
         KB+Iimp+4+LTE3e9NvAjgjAdZK5jSp1fhVRab+xcJ5r9ab75ggRyMXIVBc4FqShgY0dF
         mw141bcvbQmBGUyj1+fwP/HGlxd0ZrV3cKHLvJGTY3xLIqlJcT+1IrR9bb6QrA/W+C+E
         hL7f5ANoIZUMKrsdU1DLpK5K6NEco+DnnUeAWhUCBk9BavsunNM69+lwCGzBiT+AdCjI
         XKCw==
X-Gm-Message-State: AOAM530G4KF74mgGCZYjBKptI22cEAw5JopqBWIOI6MLtnUCqhQRh7Dx
        0RNKAZfH+Cv0QvetJ3ZEnQ==
X-Google-Smtp-Source: ABdhPJyYec/VgtswnBEuZftjOY/B95EXc8HL+d/1/ZZhKfJ0OjKyRLmPhayd9j8kaFtttlHgnA2WNg==
X-Received: by 2002:a05:6830:1108:: with SMTP id w8mr3321893otq.88.1628773017952;
        Thu, 12 Aug 2021 05:56:57 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d2sm592888otl.32.2021.08.12.05.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 05:56:57 -0700 (PDT)
Received: (nullmailer pid 1259131 invoked by uid 1000);
        Thu, 12 Aug 2021 12:56:56 -0000
Date:   Thu, 12 Aug 2021 07:56:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: PCI: kirin: fix HiKey970 example
Message-ID: <YRUamNF18ese0DYw@robh.at.kernel.org>
References: <cover.1628754620.git.mchehab+huawei@kernel.org>
 <655e21422a14620ae2d55335eb72bcaa66f5384d.1628754620.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655e21422a14620ae2d55335eb72bcaa66f5384d.1628754620.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 12, 2021 at 09:55:52AM +0200, Mauro Carvalho Chehab wrote:
> The given example doesn't produce all of_nodes at sysfs.
> Update it to reflect what's actually working.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 64 +++++++++++--------
>  1 file changed, 36 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> index d05deebe9dbb..668a09e27139 100644
> --- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> @@ -97,7 +97,6 @@ examples:
>                <0x0 0xfc180000 0x0 0x1000>,
>                <0x0 0xf5000000 0x0 0x2000>;
>          reg-names = "dbi", "apb", "config";
> -        msi-parent = <&its_pcie>;
>          #address-cells = <3>;
>          #size-cells = <2>;
>          device_type = "pci";
> @@ -116,43 +115,52 @@ examples:
>                          <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
>          reset-gpios = <&gpio7 0 0>;
>          hisilicon,clken-gpios = <&gpio27 3 0>, <&gpio17 0 0>, <&gpio20 6 0>;
> -
> -        pcie@0 { // Lane 0: PCIe switch: Bus 1, Device 0
> -          reg = <0 0 0 0 0>;
> +        pcie@0,0 { // Lane 0: PCIe switch: Bus 1, Device 0
> +          reg = <0x80 0 0 0 0>;
>            compatible = "pciclass,0604";
>            device_type = "pci";
>            #address-cells = <3>;
>            #size-cells = <2>;
>            ranges;
> -          pcie@1,0 { // Lane 4: M.2
> -            reg = <0x800 0 0 0 0>;
> +          msi-parent = <&its_pcie>;

Why do we need this change? Adding the child nodes shouldn't change 
the behavior here. I'd expect that we'd walk the parent nodes until we 
find a 'msi-parent' much like 'interrupt-parent'.

It looks like we walk PCI bus parents to get the MSI domain, but we 
don't walk the DT node parents. 

Adding Marc for his thoughts.

Rob
