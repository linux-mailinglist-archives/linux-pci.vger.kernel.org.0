Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C30A8D94
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 21:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbfIDRQc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 13:16:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42021 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbfIDRQc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 13:16:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id w22so5203530pfi.9;
        Wed, 04 Sep 2019 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0WPF3BC4jLDd3vtXkSBv8TZG6WGb+ZfUilZzHwILAWg=;
        b=PwCyJpVxMpJGoGTtZM5aT9MZ8u5+xowpL9AcC0NtOzBm7HP2QI1AHwK9oDEDvAiPTi
         1mY5E6nYy6JQ5bnHuvnqHZDOcYaHaCOMEee4veWJRsoJcqVaXdHuqQEIqLL2y9eDIL2v
         WynyqE33zvcmhWNOSVnTFA0u9EcO217chv8Z2p7CBeFXfBtLSvBxMOU3XofMj8I2ud4v
         aEcKzbXW8RwYP0mmwzL9epLitEodIJRzZD3VlBC6y2b5vUVTNqoj0nt5M1sN0wvyZgTA
         TPj8S8IQYEK+6DceCb4qObSBanXr4mnrTFZhYE4t55USW3VjoQZSsSx53h+H3ifyhjMA
         LWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0WPF3BC4jLDd3vtXkSBv8TZG6WGb+ZfUilZzHwILAWg=;
        b=Vp40v66S9ciMDd+TxU3kcM0B7a6WKVWrMsmty/Wy33avUN1yuqhWWfTIkaO4YrcdOC
         MxQWffLIykYeTMrXpGreM1tPJNb7TF9fq0q6IFVCDwjHD3rmlWMKKpBOTu309vHASDnq
         +5YW7SQXIWORAGYCxr78BYJOqcmSsJXUdoCoP2fTAO8wjhURWoFKlTnzRzTZw6pR5Y5n
         c9To9i3MDLU+1XqLrwyyHsiJM9UgePwADpuPKipKFRkPnBnDX3a6E1bwf4DH14cxVsWd
         b6MOiIpwNT+JOQegnivvJuosdsOVXYYxhCIkAWujnTtQ+e+fMsN6A3UGEV4PzsfHVprF
         cLiA==
X-Gm-Message-State: APjAAAWtVdTH5qvhrZScnp0x3vtAdANvr1ZhGfrxLg4xauskIvUtcTHx
        sI5PncIWcXyyw1V4sFNRFCvxD32dywM=
X-Google-Smtp-Source: APXvYqyxTs3a17tRv8EsUjP6U1xDnQ/AJO6MjxWuHGaxk3VeAF2/3Mg8nu1ia8+4PpEi0xDtdG03Iw==
X-Received: by 2002:a62:5343:: with SMTP id h64mr33072029pfb.4.1567617390831;
        Wed, 04 Sep 2019 10:16:30 -0700 (PDT)
Received: from [10.67.49.31] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s19sm7722540pfe.86.2019.09.04.10.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 10:16:30 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] PAXB INTx support with proper model
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <107116f2-a5ff-c545-1864-eb5885c4c60e@gmail.com>
Date:   Wed, 4 Sep 2019 10:16:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/28/19 1:54 AM, Srinath Mannam wrote:
> This patch series adds PCIe legacy interrupt (INTx) support to the iProc
> PCIe driver by modeling it with its own IRQ domain. All 4 interrupts INTA,
> INTB, INTC, INTD share the same interrupt line connected to the GIC
> in the system. This is now modeled by using its own IRQ domain.
> 
> Also update all relevant devicetree files to adapt to the new model.
> 
> This patch set is based on Linux-5.2-rc4.
> 
> Changes from v1:
>   - Addressed Rob, Lorenzo, Arnd's comments
>     - Used child node for interrupt controller.
>   - Addressed Andy Shevchenko's comments
>     - Replaced while loop with do-while.

Lorenzo, Bjorn, if you are good with the binding and PCI host driver
changes, you can take patches 1-2 through your tree, and I will queue up
the others through the Broadcom ARM SoC pull requests. If not, please
feel free to add a:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> 
> Ray Jui (6):
>   dt-bindings: pci: Update iProc PCI binding for INTx support
>   PCI: iproc: Add INTx support with better modeling
>   arm: dts: Change PCIe INTx mapping for Cygnus
>   arm: dts: Change PCIe INTx mapping for NSP
>   arm: dts: Change PCIe INTx mapping for HR2
>   arm64: dts: Change PCIe INTx mapping for NS2
> 
>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  48 ++++++++--
>  arch/arm/boot/dts/bcm-cygnus.dtsi                  |  30 ++++++-
>  arch/arm/boot/dts/bcm-hr2.dtsi                     |  30 ++++++-
>  arch/arm/boot/dts/bcm-nsp.dtsi                     |  45 ++++++++--
>  arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |  28 +++++-
>  drivers/pci/controller/pcie-iproc.c                | 100 ++++++++++++++++++++-
>  drivers/pci/controller/pcie-iproc.h                |   6 ++
>  7 files changed, 260 insertions(+), 27 deletions(-)
> 


-- 
Florian
