Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD98271A38
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 06:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgIUExE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 00:53:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34340 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUExE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 00:53:04 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08L4qm3F104834;
        Sun, 20 Sep 2020 23:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600663968;
        bh=9uy99y5TKZJggG1dvxT3XStGw93Gtk7IkvWznY+qP3s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=K4gIhkwolUAfm9iVFAchCwcLKjneOwbtczCbhfEJb0GxdRnrZXSxnS5IdVJnrbkNK
         ePvICW/RFGMfgr3/260DoeM1KblpZ0umuirFakC8xUzASdO1YJ0jE/1RN1mVmR3cL/
         1wazJS79T+GmZWJDPvRsIqF3kusrxjixhxJxqAk0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08L4qmKx060489;
        Sun, 20 Sep 2020 23:52:48 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 20
 Sep 2020 23:52:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 20 Sep 2020 23:52:48 -0500
Received: from [10.250.232.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08L4qgFL030746;
        Sun, 20 Sep 2020 23:52:43 -0500
Subject: Re: [PATCH v5 14/17] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>
References: <20200918064227.1463-1-kishon@ti.com>
 <20200918064227.1463-15-kishon@ti.com>
 <93b651aa-23e5-9249-6b22-fef65806b007@infradead.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c8b7fa2b-5586-3929-1e00-8473106935f9@ti.com>
Date:   Mon, 21 Sep 2020 10:22:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <93b651aa-23e5-9249-6b22-fef65806b007@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Randy,

On 18/09/20 9:45 pm, Randy Dunlap wrote:
> On 9/17/20 11:42 PM, Kishon Vijay Abraham I wrote:
>> diff --git a/drivers/ntb/hw/epf/Kconfig b/drivers/ntb/hw/epf/Kconfig
>> new file mode 100644
>> index 000000000000..6197d1aab344
>> --- /dev/null
>> +++ b/drivers/ntb/hw/epf/Kconfig
>> @@ -0,0 +1,6 @@
>> +config NTB_EPF
>> +	tristate "Generic EPF Non-Transparent Bridge support"
>> +	depends on m
>> +	help
>> +	  This driver supports EPF NTB on configurable endpoint.
>> +	  If unsure, say N.
> 
> Hi,
> Why is this driver restricted to 'm' (loadable module)?
> I.e., it cannot be builtin.

I'm trying to keep all the host side PCI drivers corresponding to the
devices configured using endpoint function drivers as modules and also
not populate MODULE_DEVICE_TABLE() to prevent auto-loading.

The different endpoint function drivers (right now only pci-epf-test.c
and pci-epf-ntb.c) can use the same device ID and vendorID for
configuring the endpoint devices. So on the host side, it's possible an
un-intended PCI driver can be bound to the device. So in-order to give
users the flexibility of deciding the driver to be bound, I'm trying to
keep it as modules. (Some driver like NTB also uses class code
PCI_CLASS_MEMORY_RAM for binding a driver in addition to deviceID and
vendorID but it need not be the case for all the drivers.)

Thanks
Kishon
