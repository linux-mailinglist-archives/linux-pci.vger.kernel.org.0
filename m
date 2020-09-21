Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF9B271A1D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 06:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgIUEfU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 00:35:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:32782 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUEfU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 00:35:20 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08L4Yvj4101198;
        Sun, 20 Sep 2020 23:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600662897;
        bh=WgoOtI+mWNEhU87sIoLc3wQAHysSHQBYrpEdQxdi7R0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eazXT8PpjR3wm78Fq29IuQUJ2XyEy/eua/RYyHa0+Qj1lxkL7NbSr00PqjvwxkH3f
         NLBs6B6CnwpEK4f1PiDMHInJREBoS8PoBw7WfJTPEjXdpIqHJR7ovkpSDOciph1F/H
         pcFU5HDANH16FxRruhH3LPrv/23zSDgCBJQo9FQw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08L4YvJW121785
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 20 Sep 2020 23:34:57 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 20
 Sep 2020 23:34:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 20 Sep 2020 23:34:57 -0500
Received: from [10.250.232.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08L4YphG020154;
        Sun, 20 Sep 2020 23:34:52 -0500
Subject: Re: [PATCH v5 12/17] PCI: endpoint: Add EP function driver to provide
 NTB functionality
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
 <20200918064227.1463-13-kishon@ti.com>
 <31985ad8-2e9b-99d8-55ef-4ae90103e499@infradead.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b79f760b-0641-0e14-375b-df89588405b6@ti.com>
Date:   Mon, 21 Sep 2020 10:04:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <31985ad8-2e9b-99d8-55ef-4ae90103e499@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Randy,

On 18/09/20 9:47 pm, Randy Dunlap wrote:
> On 9/17/20 11:42 PM, Kishon Vijay Abraham I wrote:
>> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
>> index 8820d0f7ec77..55ac7bb2d469 100644
>> --- a/drivers/pci/endpoint/functions/Kconfig
>> +++ b/drivers/pci/endpoint/functions/Kconfig
>> @@ -12,3 +12,15 @@ config PCI_EPF_TEST
>>  	   for PCI Endpoint.
>>  
>>  	   If in doubt, say "N" to disable Endpoint test driver.
>> +
>> +config PCI_EPF_NTB
>> +	tristate "PCI Endpoint NTB driver"
>> +	depends on PCI_ENDPOINT
>> +	help
>> +	   Select this configuration option to enable the NTB driver
>> +	   for PCI Endpoint. NTB driver implements NTB controller
>> +	   functionality using multiple PCIe endpoint instances. It
>> +	   can support NTB endpoint function devices created using
>> +	   device tree.
> 
> Indent help text with one tab + 2 spaces...
> according to coding-style.rst.

Okay, will fix this.

Thanks
Kishon
