Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895713BB901
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 10:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhGEIY1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 04:24:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43966 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhGEIYY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 04:24:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1658LTJ0005911;
        Mon, 5 Jul 2021 03:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1625473289;
        bh=Y5AlfMUgJJYX/2dmO0aHXkikhRLjjtuU8z3wKxricB0=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=AaI85ThQ6sn8gb1DpFaqvtAe9iPcadMGWGata0NI9XKZ3m1sX8+UyeZt8Nm4GvGia
         m6/BYDrsUoYJ0+4fW2O7HDwekOiteOnirynRY2s7B5m7PjzNCEoKIp6uNvMo6uIsQ+
         PISwMnGtSwdxUbEli4ipDfWO5CjjQ3luGPrn8k6Y=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1658LTVF129783
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jul 2021 03:21:29 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 5 Jul
 2021 03:21:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 5 Jul 2021 03:21:28 -0500
Received: from [10.250.232.207] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1658LNtD100793;
        Mon, 5 Jul 2021 03:21:24 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 08/40] PCI: keystone: Cleanup MSI/legacy interrupt
 configuration and handling
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <Gustavo.Pimentel@synopsys.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180921102155.22839-1-kishon@ti.com>
 <20180921102155.22839-9-kishon@ti.com> <20210703210152.GA16176@rocinante>
Message-ID: <56160f1d-ec91-3b99-312c-aef66eb1a7c2@ti.com>
Date:   Mon, 5 Jul 2021 13:51:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210703210152.GA16176@rocinante>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On 04/07/21 2:31 am, Krzysztof Wilczyński wrote:
> Hi Kishon,
> 
>> Now that all PCI keystone functionality has been moved to pci-keystone.c,
>> cleanup MSI/legacy interrupt configuration and handling.
>>  *) Cleanup macros
>>  *) Remove unnecessary structure variables (required when 2 files are
>>     used)
>>  *) Remove ks_dw_pcie_legacy_irq_chip and use dummy_irq_chip
>>  *) Move request_irq of error irq from ks_add_pcie_port to ks_pcie_probe
>>     as error_irq is common to both host mode and device mode
> [...]
> 
> While looking at some small clean-ups for Bjorn, I stumbled upon this
> series, and it seems a lot of your work here cover what Bjorn wanted to
> do, thus I need to ask - do you recall, and I appreciate it's been
> a while (three years actually), what happened and/or if you ever had the
> time to work on this series?
> 
> Would it be possible to resurrect this?  Do you need any help?

A lot of patches in this series should already be merged (after
splitting into smaller ones)
http://patchwork.ozlabs.org/project/linux-pci/list/?series=71185

https://patchwork.kernel.org/project/linux-arm-kernel/cover/20190321095927.7058-1-kishon@ti.com/

The following series is still pending and is in my TODO list
https://lore.kernel.org/r/20210325090026.8843-1-kishon@ti.com

Are there any other clean-ups you are looking into?

Thanks and Regards
Kishon
