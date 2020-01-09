Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E85031356AE
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 11:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgAIKR1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 05:17:27 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52376 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgAIKR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jan 2020 05:17:27 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 009AHE2v100029;
        Thu, 9 Jan 2020 04:17:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578565034;
        bh=dD1YFWbC0Y7B9niXQWfTUrQg3FwDw851xh9FQ221VB4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SnN5SH8XX4JhKyx1d11va8cV5XIYCpZYj8XzJ34POQo+nTFWbMTuOZOHeNfFdwhz5
         pyYIZDxSVOIwZ/nZd4dChG2ylyd/1gAuzC+YBCStLALcCyGMzOlwy487aA4bm/tQIy
         F/GMlX1I+jzhBTqKrl1AB8Uu9x2lObjqwmyaDjWU=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 009AHDkc039244
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Jan 2020 04:17:14 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 9 Jan
 2020 04:17:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 9 Jan 2020 04:17:13 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 009AH9k0024424;
        Thu, 9 Jan 2020 04:17:10 -0600
Subject: Re: [PATCH 0/4] Redesign MSI-X support in PCIe Endpoint Core
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20191211224636.GA122332@google.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a971c0b1-ed66-fd4c-5a1d-7aef9d410866@ti.com>
Date:   Thu, 9 Jan 2020 15:49:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191211224636.GA122332@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 12/12/19 4:16 AM, Bjorn Helgaas wrote:
> On Wed, Dec 11, 2019 at 06:16:04PM +0530, Kishon Vijay Abraham I wrote:
>> Existing MSI-X support in Endpoint core has limitations:
>>  1) MSIX table (which is mapped to a BAR) is not allocated by
>>     anyone. Ideally this should be allocated by endpoint
>>     function driver.
>>  2) Endpoint controller can choose any random BARs for MSIX
>>     table (irrespective of whether the endpoint function driver
>>     has allocated memory for it or not)
>>
>> In order to avoid these limitations, pci_epc_set_msix() is
>> modified to include BAR Indicator register (BIR) configuration
>> and MSIX table offset as arguments. This series also fixed MSIX
>> support in dwc driver and add MSI-X support in Cadence PCIe driver.
>>
>> The previous version of Cadence EP MSI-X support is @ [1].
>> This series is created on top of [2]
>>
>> [1] -> https://patchwork.ozlabs.org/patch/971160/
>> [2] -> http://lore.kernel.org/r/20191209092147.22901-1-kishon@ti.com
>>
>> Alan Douglas (1):
>>   PCI: cadence: Add MSI-X support to Endpoint driver
>>
>> Kishon Vijay Abraham I (3):
>>   PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments
>>   PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSIX table
>>     address
>>   PCI: keystone: Add AM654 PCIe Endpoint to raise MSIX interrupt
> 
> Trivial nits:
> 
>   - There's a mix of "MSI-X" and "MSIX" in the subjects, commit logs,
>     and comments.  I prefer "MSI-X" to match usage in the spec.
> 
>   - "Fixes:" tags need not include "commit".  It doesn't *hurt*
>     anything, but it takes up space that could be used for the
>     subject.
> 
>   - Commit references typically use a 12-char SHA1.  Again, doesn't
>     hurt anything.

I'll fix all this in my next revision.

Xiaowei, Gustavo,

The issues we discussed in  [1] should be fixed with this series. Can
you help test this in your platforms?

[1] -> https://lkml.org/lkml/2019/11/6/678

Thanks
Kishon
> 
