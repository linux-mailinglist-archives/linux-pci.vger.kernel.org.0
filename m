Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2990446D9C4
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 18:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbhLHRgO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 12:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbhLHRgO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 12:36:14 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4D5C061746;
        Wed,  8 Dec 2021 09:32:42 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id p13so3078710pfw.2;
        Wed, 08 Dec 2021 09:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GTnOygRYVjIjLSwuhIL1Lc+5UjBjxzuVt14IqySkkNA=;
        b=OoXxuvNL1SZdgC7J4oqN/PTzUJDiznDtwII7++hd6xtR4ZdlzCPnHavbNPFnzI/alb
         4TrfjC2Me0CcfnKVxl3HMhb4pTYxYXCCLzyaFIWAg3vwiFEwxNBBK+sanGRjt7Zpjt6c
         9gTAlh1T5INoGRdwUpY1wx35x+rp346uy2fI9aSXJDiADe1iwQCx92+KV5ntDXaPTXxL
         hNWoA8rLAhi8p6n8GqI9pGkIHlwvf57/Gw9zx98myvRo7oyzlJqsDL/YEJUe8zs0GN+2
         TZPL2RlJY7/CB5ldhl4Mqz5X74nFZ2OmbRQt6Ynq3nRIQADWYNXNLB6fIQujNivo979M
         +Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GTnOygRYVjIjLSwuhIL1Lc+5UjBjxzuVt14IqySkkNA=;
        b=Nh9TtDXxW+QnyCWCDMbG2DeCqUTKK1DZHJ2grK/8FycAqKybhcDZyny5Gy+O0242GB
         0NFrRGn03qYPMFnmLRrnqLa25iM9bnjtOi8pnxCOBOI8GnbA2yg+Z5XPAQhTosHxnJb0
         B62aKRCPP0f5dVLNVqvv686rjQ8lhaDC52oeiho24yfA2k0U05FGXUzHqWTbfikGfjkk
         3HoPyYDSM99IaLjKSJJmhFoIX4Ot9ZWmRTRSgR2pHIbE1jRfKeSvNrQZ5WUW6cUBBP6s
         rEq3uU2G13EV3WNz/0824niyZ3MHknKbNJUBs2Bp4zfvCajwUZJir9Ho2BO3prECE0RL
         8u5Q==
X-Gm-Message-State: AOAM533UBDU8osQbgFZ2O4EG632xLrGGokhkOyUq0UYNA99o0pEob86O
        ew9WVAI6hUwPKjHL4QyeMu/UhY1S7R8=
X-Google-Smtp-Source: ABdhPJyDDF2CspZ7OwtoageGUQ3rKh88TPg58DGSzt6iO8ytJwslleC2V3vOwFN7Ff8aBMLU3SUsIg==
X-Received: by 2002:a63:4458:: with SMTP id t24mr30420895pgk.236.1638984761057;
        Wed, 08 Dec 2021 09:32:41 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i3sm3941617pfe.75.2021.12.08.09.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 09:32:40 -0800 (PST)
Subject: Re: [PATCH v3 6/6] dt-bindings: pci: Convert iProc PCIe to YAML
To:     Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ray Jui <rjui@broadcom.com>, devicetree@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20211208040432.3658355-1-f.fainelli@gmail.com>
 <20211208040432.3658355-7-f.fainelli@gmail.com>
 <1638971068.781821.3857737.nullmailer@robh.at.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <536cbdb6-a541-2f86-faa6-acb1a4e1c173@gmail.com>
Date:   Wed, 8 Dec 2021 09:32:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638971068.781821.3857737.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/8/21 5:44 AM, Rob Herring wrote:
> On Tue, 07 Dec 2021 20:04:32 -0800, Florian Fainelli wrote:
>> Conver the iProc PCIe controller Device Tree binding to YAML now that
>> all DTS in arch/arm and arch/arm64 have been fixed to be compliant.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  .../bindings/pci/brcm,iproc-pcie.txt          | 133 -------------
>>  .../bindings/pci/brcm,iproc-pcie.yaml         | 176 ++++++++++++++++++
>>  2 files changed, 176 insertions(+), 133 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1565076
> 
> 
> pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dt.yaml
> 	arch/arm/boot/dts/bcm911360_entphn.dt.yaml
> 	arch/arm/boot/dts/bcm911360k.dt.yaml
> 	arch/arm/boot/dts/bcm958300k.dt.yaml
> 	arch/arm/boot/dts/bcm958305k.dt.yaml
> 	arch/arm/boot/dts/bcm958522er.dt.yaml
> 	arch/arm/boot/dts/bcm958525er.dt.yaml
> 	arch/arm/boot/dts/bcm958525xmc.dt.yaml
> 	arch/arm/boot/dts/bcm958622hr.dt.yaml
> 	arch/arm/boot/dts/bcm958623hr.dt.yaml
> 	arch/arm/boot/dts/bcm958625hr.dt.yaml
> 	arch/arm/boot/dts/bcm958625k.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml
> 	arch/arm/boot/dts/bcm988312hr.dt.yaml

Those would mean that the binding patch was applied without the DTS
patches earlier in the series?
-- 
Florian
