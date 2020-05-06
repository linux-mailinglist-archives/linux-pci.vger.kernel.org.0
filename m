Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618F31C667F
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 05:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgEFDzP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 23:55:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51262 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgEFDzP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 23:55:15 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0463swqG026651;
        Tue, 5 May 2020 22:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588737298;
        bh=dP9vIylGch3mfYOoHduGYa4fpVr1vxqy1GWoA3PI0aY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HqoN+g1f6QCF8y1A1LVthP/mExB8HaQXALSKQCtVsTK94opB6EDbI0nH8XuZi15M0
         L313zb0cQUc3vZE/yksWkkzf5kegyvfFcFHnRPdyWPTEQGm2dxcdysoiLpKkGwHNmK
         jiJGC43/GgNWMbBJGRfiOgU9qOruxlcTwTImygDw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0463swt9020345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 May 2020 22:54:58 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 5 May
 2020 22:54:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 5 May 2020 22:54:58 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0463ssDu004336;
        Tue, 5 May 2020 22:54:55 -0500
Subject: Re: [PATCH v3 14/14] MAINTAINERS: Add Kishon Vijay Abraham I for TI
 J721E SoC PCIe
To:     Joe Perches <joe@perches.com>, Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200417125753.13021-1-kishon@ti.com>
 <20200417125753.13021-15-kishon@ti.com>
 <ee72cdce1c487f7d0fd089f59fb92422ef2d9396.camel@perches.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d4ca70be-0beb-f1a3-2c70-54df976c2983@ti.com>
Date:   Wed, 6 May 2020 09:24:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ee72cdce1c487f7d0fd089f59fb92422ef2d9396.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Joe,

On 4/17/2020 8:49 PM, Joe Perches wrote:
> On Fri, 2020-04-17 at 18:27 +0530, Kishon Vijay Abraham I wrote:
>> Add Kishon Vijay Abraham I as MAINTAINER for TI J721E SoC PCIe.
> []
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> @@ -12968,13 +12968,15 @@ S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
>>  F:	drivers/pci/controller/dwc/*designware*
>>  
>> -PCI DRIVER FOR TI DRA7XX
>> +PCI DRIVER FOR TI DRA7XX/J721E
>>  M:	Kishon Vijay Abraham I <kishon@ti.com>
>>  L:	linux-omap@vger.kernel.org
>>  L:	linux-pci@vger.kernel.org
>> +L:	linux-arm-kernel@lists.infradead.org
>>  S:	Supported
>>  F:	Documentation/devicetree/bindings/pci/ti-pci.txt
>>  F:	drivers/pci/controller/dwc/pci-dra7xx.c
>> +F:	drivers/pci/controller/cadence/pci-j721e.c
> 
> Please keep file patterns in alphabetic order by
> moving this new cadence line up one line above dwc.

Sure, will fix this up in my next revision.

Thanks
Kishon
