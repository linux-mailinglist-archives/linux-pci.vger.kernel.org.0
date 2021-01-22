Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089253004F8
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 15:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbhAVOLA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 09:11:00 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51656 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbhAVOKQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jan 2021 09:10:16 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10ME8IVL110496;
        Fri, 22 Jan 2021 08:08:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611324498;
        bh=w4XabDkfYqLlpKtLwnIUmLYMQ/z5aYMl+m+dHwL0v8k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=u3V0pMykhDgUZEJa1Dcxg7xSweOtPYaboOkgMlSYxfAinatt5Oumasnh9sDmrscyD
         uJRTD05gzPBqiXEEVQaNGdciyLVlGgxgDeRxc8nVP+Gx1pPXXVVZodT449HRngtfSP
         dv6EFYD+Akzg0V91ILj+8qnfcnpgdsY38Uib4G1A=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10ME8I6e072597
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jan 2021 08:08:18 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 Jan 2021 08:08:18 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 Jan 2021 08:08:18 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10ME8BrS073625;
        Fri, 22 Jan 2021 08:08:13 -0600
Subject: Re: [PATCH v9 17/17] Documentation: PCI: Add userguide for PCI
 endpoint NTB function
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>
References: <20210119181852.GA2495234@bjorn-Precision-5520>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <809ab02c-8cc2-86ea-0524-b9350d38c684@ti.com>
Date:   Fri, 22 Jan 2021 19:38:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119181852.GA2495234@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 20/01/21 12:04 am, Bjorn Helgaas wrote:
> On Mon, Jan 04, 2021 at 08:59:09PM +0530, Kishon Vijay Abraham I wrote:
>> Add documentation to help users use pci-epf-ntb function driver and
>> existing host side NTB infrastructure for NTB functionality.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>>  Documentation/PCI/endpoint/index.rst         |   1 +
>>  Documentation/PCI/endpoint/pci-ntb-howto.rst | 160 +++++++++++++++++++
>>  2 files changed, 161 insertions(+)
>>  create mode 100644 Documentation/PCI/endpoint/pci-ntb-howto.rst
>>
>> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
>> index 9cb6e5f3c4d5..38ea1f604b6d 100644
>> --- a/Documentation/PCI/endpoint/index.rst
>> +++ b/Documentation/PCI/endpoint/index.rst
>> @@ -12,6 +12,7 @@ PCI Endpoint Framework
>>     pci-test-function
>>     pci-test-howto
>>     pci-ntb-function
>> +   pci-ntb-howto
>>  
>>     function/binding/pci-test
>>     function/binding/pci-ntb
>> diff --git a/Documentation/PCI/endpoint/pci-ntb-howto.rst b/Documentation/PCI/endpoint/pci-ntb-howto.rst
>> new file mode 100644
>> index 000000000000..b6e1073c9a39
>> --- /dev/null
>> +++ b/Documentation/PCI/endpoint/pci-ntb-howto.rst
>> @@ -0,0 +1,160 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +===================================================================
>> +PCI Non-Transparent Bridge (NTB) Endpoint Function (EPF) User Guide
>> +===================================================================
>> +
>> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
>> +
>> +This document is a guide to help users use pci-epf-ntb function driver
>> +and ntb_hw_epf host driver for NTB functionality. The list of steps to
>> +be followed in the host side and EP side is given below. For the hardware
>> +configuration and internals of NTB using configurable endpoints see
>> +Documentation/PCI/endpoint/pci-ntb-function.rst
>> +
>> +Endpoint Device
>> +===============
>> +
>> +Endpoint Controller Devices
>> +---------------------------
>> +
>> +For implementing NTB functionality at least two endpoint controller devices
>> +are required.
>> +To find the list of endpoint controller devices in the system::
> 
> Is the above one paragraph or two?  Reflow or add blank line as
> appropriate.

I'll add blank line above.

Thanks
Kishon
