Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7DD59B8F6
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 08:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiHVGGa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 02:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiHVGG3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 02:06:29 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE5820BD6;
        Sun, 21 Aug 2022 23:06:28 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27M66BLL095517;
        Mon, 22 Aug 2022 01:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661148371;
        bh=wtcORBkLFKuLF/Y7L8i/MMlzJo9cWQHz5pZAexxzLto=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=m2MkllkuPI892qsMVGBQB5NHMkpL03mcFWciSp4lFma4bboTv5gSZQWSdPv5lAkyD
         OPc+QUkvOeN4LMhEZqzMB147lmMb7+Xt1SkJWqTbTg8TfELlx2JNUkPeCXAlbiLx9e
         bUU+lEPQcrWU6bta6PZr0SBBNUY+ePHEKEBJmF6g=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27M66BTF004894
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 01:06:11 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 22
 Aug 2022 01:06:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 22 Aug 2022 01:06:11 -0500
Received: from [172.24.147.145] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27M6685L040211;
        Mon, 22 Aug 2022 01:06:09 -0500
Message-ID: <63d2bd69-2e94-a987-aec3-554ce5af6594@ti.com>
Date:   Mon, 22 Aug 2022 11:36:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] MAINTAINERS: Add myself as the reviewer for PCI Endpoint
 Subsystem
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>
References: <20220819200555.GA2502055@bhelgaas>
From:   Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <20220819200555.GA2502055@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 20/08/22 01:35, Bjorn Helgaas wrote:
> On Fri, Aug 19, 2022 at 07:38:17AM +0530, Manivannan Sadhasivam wrote:
>> I've been reviewing the patches related to PCI Endpoint Subsystem for
>> some time. So I'd like to add myself as the reviewer to get immediate
>> attention to the patches.
>>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Thanks, applied to for-linus for v6.0.
> 
> Updated subject line to:
> 
>   MAINTAINERS: Add Manivannan Sadhasivam as PCI Endpoint reviewer
> 
> since "add myself" doesn't mean anything without reading the whole
> commit log.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

> 
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 21081f72776d..58a163c2e5dc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15682,6 +15682,7 @@ PCI ENDPOINT SUBSYSTEM
>>  M:	Kishon Vijay Abraham I <kishon@ti.com>
>>  M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>>  R:	Krzysztof Wilczyński <kw@linux.com>
>> +R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>  L:	linux-pci@vger.kernel.org
>>  S:	Supported
>>  Q:	https://patchwork.kernel.org/project/linux-pci/list/
>> -- 
>> 2.25.1
>>
