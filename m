Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC002B0978
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 17:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgKLQFl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 11:05:41 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35820 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgKLQFk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 11:05:40 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACG5ZSB118306;
        Thu, 12 Nov 2020 10:05:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605197135;
        bh=9yETxY8RPhX8mtyohaZIEqS18xzqCiuxeaRy0WwXgn4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nyHcE2+TQuluMWit3IgaslrYTd5bGNBFq2BmM/XchOub+xku61WHETmyqWvaFsvFS
         CHk2N3ManQHF9iobqbRO4y83Iwb3z71nGa6ZMYR5r//mJwXCYfsAQ7/9hrMGNEJBw7
         S2jhxVfvPnXqhW0ii5B3u9nQmxckjGECY+uA7/OA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACG5ZRt099598
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 10:05:35 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 10:05:35 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 10:05:35 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACG5VOt018182;
        Thu, 12 Nov 2020 10:05:32 -0600
Subject: Re: [PATCH v2 5/7] arm64: dts: ti: k3-j7200-main: Add PCIe device
 tree node
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, Lee Jones <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201109170409.4498-1-kishon@ti.com>
 <20201109170409.4498-6-kishon@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <fa7dbf5c-adc3-db43-47c2-94c0afa72a40@ti.com>
Date:   Thu, 12 Nov 2020 21:35:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109170409.4498-6-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/9/20 10:34 PM, Kishon Vijay Abraham I wrote:
> Add PCIe device tree node (both RC and EP) for the single PCIe
> instance present in j7200.
> 

nit: s/j7200/J7200

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

[...]
