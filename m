Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAEA27F978
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 08:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgJAG3d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 02:29:33 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42644 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAG3d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 02:29:33 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0916TR8F011549;
        Thu, 1 Oct 2020 01:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601533767;
        bh=4aZalwaPL1EhmWy6gkpltx9aa/PZ3tVxW5OeJ8yyVAs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VhH+TNLIP26ps5vPoXpk+j142eZXbg6EE6yugLCApFnV+uuTUVxxqgCmlStjZG4mh
         fTTT7dasKG9CChjJwJrLzAn5Wi9kqJ8GRcv+yTAXl8FR/QRQhGqOALsnmruJ8HnCw1
         ldT5op1blyN9qSqfmxIt1ypsvAnCItIfFlUPkCM0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0916TRMh124210
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 01:29:27 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 01:29:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 01:29:26 -0500
Received: from [10.250.232.108] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0916TNvs116546;
        Thu, 1 Oct 2020 01:29:24 -0500
Subject: Re: sparse warnings
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-pci@vger.kernel.org>
References: <20200930223928.GA2643255@bjorn-Precision-5520>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6638a699-6476-d449-afa5-9be7799fe9a5@ti.com>
Date:   Thu, 1 Oct 2020 11:59:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930223928.GA2643255@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+RobH, Lorenzo

Hi Bjorn,

On 01/10/20 4:09 am, Bjorn Helgaas wrote:
> On Wed, Jul 29, 2020 at 02:48:15PM -0500, Bjorn Helgaas wrote:
>> Just FYI, I see the following sparse warnings (among others):
>>
>>   $ make C=2 drivers/pci/
>>
>>   drivers/pci/endpoint/functions/pci-epf-test.c:288:24: warning: incorrect type in argument 1 (different address spaces)
>>   drivers/pci/endpoint/functions/pci-epf-test.c:288:24:    expected void *to
>>   drivers/pci/endpoint/functions/pci-epf-test.c:288:24:    got void [noderef] <asn:2> *[assigned] dst_addr
>>   drivers/pci/endpoint/functions/pci-epf-test.c:288:34: warning: incorrect type in argument 2 (different address spaces)
>>   drivers/pci/endpoint/functions/pci-epf-test.c:288:34:    expected void const *from
>>   drivers/pci/endpoint/functions/pci-epf-test.c:288:34:    got void [noderef] <asn:2> *[assigned] src_addr
>>
>>   drivers/pci/controller/dwc/pcie-designware.c:447:52: warning: cast truncates bits from constant value (ffffffff7fffffff becomes 7fffffff)
>>
>> It'd be nice to fix these if it's practical.
> 
> Any ideas about these?

pci-epf-test here uses memcpy() to copy data from one memory mapped IO
address to other memory mapped IO address. Other places in this driver
uses memcpy_fromio() and memcpy_toio() since only one of them is memory
mapped IO address.

So the option is to either use memcpy_fromio() to copy data from IO to
temporary buffer and then use memcpy_toio() to copy data from the
temporary buffer to the memory mapped IO or create a new variant
[memcpy_fromtoio()?] that takes both memory mapped IO address.

Thanks
Kishon
