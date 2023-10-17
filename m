Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C505A7CB9AA
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 06:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjJQEPQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 00:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjJQEPP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 00:15:15 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600AC9F;
        Mon, 16 Oct 2023 21:15:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39H4EtRE028919;
        Mon, 16 Oct 2023 23:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697516095;
        bh=oL7oHmZvkQOudY/B18BQOXJfuksRsqH0MmTfTp0ufSU=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=NwzS2DJxudKY5XMCJWV00/RH233dmq3VUrmlM6zNpRn0bKM2MVak1A+uLErpDPPC7
         qXOEShq9PrMrot5mCEhHj56mIeaFvTv9gRo0DMi648rRV/Rk1a1dljzyLHRdLcClLm
         fmVb42seBEnMYvOZXi+W6z83Yz/czRRvWHOyYxuQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39H4EtHG121910
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Oct 2023 23:14:55 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 23:14:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 23:14:55 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39H4EpJq007105;
        Mon, 16 Oct 2023 23:14:52 -0500
Message-ID: <eacc8aa9-7480-f46c-8852-88f1f8f46bff@ti.com>
Date:   Tue, 17 Oct 2023 09:44:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
CC:     Bjorn Helgaas <helgaas@kernel.org>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: keystone: Don't enable BAR0 if link is not detected
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
References: <20231013184958.GA1118393@bhelgaas>
 <c11f4b9f-8cbe-1fd0-886b-f36547dc8d3c@ti.com>
 <klxzte53bzk774zinhfrdwdwalvv2hlvc2mqiuyecxcneqkdbt@qbkyc4fdlcka>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <klxzte53bzk774zinhfrdwdwalvv2hlvc2mqiuyecxcneqkdbt@qbkyc4fdlcka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On 17/10/23 02:59, Serge Semin wrote:
> Hi Siddharth
> 

...

>>>
>>> I assume MSI-X actually does work for downstream endpoints?  I
>>> wouldn't think anybody would have bothered with
>>> ks_pcie_v3_65_add_bus() unless MSI-X works.
>>
>> Yes, I think it is supposed to work, but it doesn't seem to be working right now
>> considering that even with Endpoint device connected, the readl() returns all Fs.
> 
> Could you please have look at what DW PCIe IP-core version is utilized
> in the Keystone PCIe host controller? If it's of v5.x then here is

The DW PCIe IP-core version is 4.90a.

> what HW databook says about the BARs initialization: "If you do use a
> BAR, then you should program it to capture TLPs that are targeted to
> your local non-application memory space residing on TRGT1, and not for
> the application on TRGT0 (dbi). The BAR range must be outside of the
> three Base/Limit regions."

Yes, it's the same even in the DW PCIe IP-core version 4.90a Databook:

3.5.7.2 RC Mode

Two BARs are present but are not expected to be used. You should disable them or
else they will be unnecessarily assigned memory during device enumeration. If
you do use a BAR, then you should program it to capture TLPs that are targeted
to your local non-application memory space residing on TRGT1, and not for the
application on TRGT1. The BAR range must be outside of the three Base/Limit regions.

> 
> I have no idea whether the BAR being set with an address within the
> Base/Limit regions could have caused the lags you see, but I would
> have at least checked that.

I will check that. Thank you for sharing your feedback.

> 
> -Serge(y)
> 
>>
>> -- 
>> Regards,
>> Siddharth.

-- 
Regards,
Siddharth.
