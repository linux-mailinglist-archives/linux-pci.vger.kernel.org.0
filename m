Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7225B4B12E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 07:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfFSFNK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 01:13:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39274 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfFSFNK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 01:13:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5J5D001013940;
        Wed, 19 Jun 2019 00:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560921180;
        bh=J6ZCI/2KmQ5LK0Mv5p/l9j+MOvVdtitQkF5T0OA9KNM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=II958DAuFXjUTn2oepUcE9v5bpwTOgEZWYd76cFtmQdEpkODdZUqJw4Cai4pNc+nc
         /fwFeMM50EdobnoFT5AjMXksweYF/cGWZmIFTvS/+AUpd7VJFZLERMw4mCoqv7y/jD
         eUgl5NBdgTUVBlHerLSblKCEhpSMTRWQWzxnqM4I=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5J5D0ZO125667
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Jun 2019 00:13:00 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 19
 Jun 2019 00:13:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 19 Jun 2019 00:12:59 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5J5CuGm012093;
        Wed, 19 Jun 2019 00:12:56 -0500
Subject: Re: [PATCH V4 1/2] PCI: dwc: Add API support to de-initialize host
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <Jisheng.Zhang@synaptics.com>,
        <thierry.reding@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190502170426.28688-1-vidyas@nvidia.com>
 <20190503112338.GA25649@e121166-lin.cambridge.arm.com>
 <dec5ecb2-863e-a1db-10c9-2d91f860a2c6@nvidia.com>
 <37697830-5a94-0f8e-a5cf-3347bc4850cb@nvidia.com>
 <b560f3c3-b69e-d9b5-2dae-1ede52af0ea6@nvidia.com>
 <011b52b6-9fcd-8930-1313-6b546226c7b9@nvidia.com>
 <8a6696e0-fc53-2e6b-536b-d1d2668e0f21@nvidia.com>
 <07c3dd04-cfd0-2d52-5917-25d0e40ad00b@nvidia.com>
 <20190618093657.GA30711@e121166-lin.cambridge.arm.com>
 <eb0e5b1e-7e91-4dc6-681f-b497f087c62d@nvidia.com>
 <20190618142821.GC9002@e121166-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <69e79afa-16c7-a00c-653d-e4155999660f@ti.com>
Date:   Wed, 19 Jun 2019 10:41:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618142821.GC9002@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 18/06/19 7:58 PM, Lorenzo Pieralisi wrote:
> On Tue, Jun 18, 2019 at 04:21:17PM +0530, Vidya Sagar wrote:
> 
> [...]
> 
>>> 2) It is not related to this patch but I fail to see the reasoning
>>>     behind the __ in __dw_pci_read_dbi(), there is no no-underscore
>>>     equivalent so its definition is somewhat questionable, maybe
>>>     we should clean-it up (for dbi2 alike).
>> Separate no-underscore versions are present in pcie-designware.h for
>> each width (i.e. l/w/b) as inline and are calling __ versions passing
>> size as argument.
> 
> I understand - the __ prologue was added in b50b2db266d8 maybe
> Kishon can help us understand the __ rationale.
> 
> I am happy to merge it as is, I was just curious about the
> __ annotation (not related to this patch).

In commit b50b2db266d8a8c303e8d88590 ("PCI: dwc: all: Modify dbi accessors to
take dbi_base as argument"), dbi accessors was modified to take dbi_base as
argument (since we wanted to write to dbics2 address space). We didn't want to
change all the drivers invoking dbi accessors to pass the dbi_base. So we added
"__" variant to take dbi_base as argument and the drivers continued to invoke
existing dbi accessors which in-turn invoked "__" version with dbi_base as
argument.

I agree there could be some cleanup since in commit
a509d7d9af5ebf86ffbefa98e49761d ("PCI: dwc: all: Modify dbi accessors to access
data of 4/2/1 bytes"), we modified __dw_pcie_readl_dbi() to
__dw_pcie_write_dbi() when it could have been directly modified to
dw_pcie_write_dbi().

Thanks
Kishon
