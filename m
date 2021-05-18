Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45E6388241
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 23:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352532AbhERVkY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 17:40:24 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:49748 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233448AbhERVkY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 17:40:24 -0400
Received: from [77.244.183.192] (port=63068 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lj7Qd-00080V-Du; Tue, 18 May 2021 23:39:03 +0200
Subject: Re: [PATCH 2/5] PCI: dwc: pci-dra7xx: make it a kernel module
To:     Rob Herring <robh@kernel.org>
Cc:     PCI <linux-pci@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
References: <20210517154122.430544-1-luca@lucaceresoli.net>
 <20210517154122.430544-3-luca@lucaceresoli.net>
 <CAL_JsqKcD7iw85X1be20kZxDsHY7F3J0TQTTgeZYiMMX3O3S4w@mail.gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <593829a9-b560-2a87-3f56-48a791201f39@lucaceresoli.net>
Date:   Tue, 18 May 2021 23:39:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKcD7iw85X1be20kZxDsHY7F3J0TQTTgeZYiMMX3O3S4w@mail.gmail.com>
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

Hi Rob,

On 18/05/21 20:55, Rob Herring wrote:
> On Mon, May 17, 2021 at 10:41 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>>
>> This allows to build the driver as a loadable kernel module.
> 
> Enable building the driver as a loadable kernel module.
> 
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> ---
>>  drivers/pci/controller/dwc/pci-dra7xx.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
>> index 6457695df00c..fe11b96fe9a5 100644
>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/irqdomain.h>
>>  #include <linux/kernel.h>
>>  #include <linux/init.h>
>> +#include <linux/module.h>
>>  #include <linux/of_device.h>
>>  #include <linux/of_gpio.h>
>>  #include <linux/of_pci.h>
>> @@ -949,4 +950,8 @@ static struct platform_driver dra7xx_pcie_driver = {
>>         },
>>         .shutdown = dra7xx_pcie_shutdown,
>>  };
>> -builtin_platform_driver(dra7xx_pcie_driver);
>> +module_platform_driver(dra7xx_pcie_driver);
> 
> You need MODULE_DEVICE_TABLE() too for autoloading.

Good catch! Will be fixed in v2.

Thanks.
-- 
Luca
