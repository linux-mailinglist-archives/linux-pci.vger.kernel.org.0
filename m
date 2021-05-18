Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90412387E37
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 19:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351076AbhERRHn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 13:07:43 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:38453 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239478AbhERRHm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 13:07:42 -0400
Received: from [77.244.183.192] (port=62022 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lj3Aj-000CdH-Ny; Tue, 18 May 2021 19:06:21 +0200
Subject: Re: [PATCH 0/5] PCI: dwc: pci-dra7xx: miscellaneous improvements
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
References: <20210517163623.GA21579@bjorn-Precision-5520>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <3e61b95e-f3e4-b5f2-d87f-eec42bcd630f@lucaceresoli.net>
Date:   Tue, 18 May 2021 19:06:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517163623.GA21579@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

On 17/05/21 18:36, Bjorn Helgaas wrote:
> On Mon, May 17, 2021 at 05:41:17PM +0200, Luca Ceresoli wrote:
>> This is an series of mixed improvements to the DRA7 PCI controller driver:
>> allow building as a loadabel module, allow to get and enable a clock and a
>> small cleanup.
>>
>> Luca
>>
>> Luca Ceresoli (5):
>>   PCI: dwc: export more symbols to allow modular drivers
>>   PCI: dwc: pci-dra7xx: make it a kernel module
>>   PCI: dwc: pci-dra7xx: allow to build as a loadable module
>>   PCI: dwc: pci-dra7xx: remove unused include
>>   PCI: dwc: pci-dra7xx: get an optional clock
> 
> This driver has a poor record of subject lines:
> 
>   PCI: pci-dra7xx: Prepare for deferred probe with module_platform_driver
>   PCI: dwc: Move dw_pcie_setup_rc() to DWC common code
>   PCI: dwc/dra7xx: Use the common MSI irq_chip
>   PCI: dwc: pci-dra7xx: Fix runtime PM imbalance on error
> 
> The "PCI: dwc:" ones are fine -- they apply to the shared dwc core,
> not specifically to dra7xx.
> 
> The driver-specific ones:
> 
>   PCI: pci-dra7xx:
>   PCI: dwc/dra7xx:
>   PCI: dwc: pci-dra7xx:
> 
> are redundant and waste space.  There's no need to mention "dwc" for
> dra7xx-specific things, and no need to mention "PCI" twice.
> 
> We should use the "PCI: dra7xx:" prefix for things specific to this
> driver.
> 
> The rest of the subject line should start with a capital letter.  The
> subject line should contain specific information when practical.  For
> example,
> 
>   PCI: dwc: Export dw_pcie_link_up(), dw_pcie_ep_reset_bar() for modular drivers
>   PCI: dra7xx: Allow building as module
>   PCI: dra7xx: Remove unused linux/init.h include
>   PCI: dra7xx: Get optional external clock
> 
> I would squash 2/5 and 3/5, similar to a98d2187efd9 ("PCI: meson:
> Build as module by default") and 526a76991b7b ("PCI: aardvark:
> Implement driver 'remove' function and allow to build it as module").

Thanks for the prompt review. I'll wait a few days for any more comments
and then resend.


-- 
Luca
