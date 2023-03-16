Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92E6BCED4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 12:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCPL7i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 07:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjCPL7b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 07:59:31 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEF4B7DB2;
        Thu, 16 Mar 2023 04:59:20 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32GBx4rX027551;
        Thu, 16 Mar 2023 06:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678967944;
        bh=3SIvM4/LltLP6H0QF/JtQlPd4Najk8f2Ns4lqYZGtJI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=N7psnA/qJApmhbEFyARLK31NaXl/hhklj1m0tr+wcCq0aDu9m9RXMFpWM+BVw0TTR
         H6/TNBGwjQ0e36e4pPjLkbkGb6NqPR//jRVFymcgawhvWW3H9lvqowl5fISZ/ys91S
         KwiLS0PiL8vzA7LvrGEnVv22kMsyPyrCpwymK5+U=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32GBx4gS027599
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Mar 2023 06:59:04 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 16
 Mar 2023 06:59:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 16 Mar 2023 06:59:03 -0500
Received: from [172.24.217.121] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32GBwx8b127781;
        Thu, 16 Mar 2023 06:59:00 -0500
Message-ID: <fe55ef2b-7ef1-d69d-8156-df15dc0f56b4@ti.com>
Date:   Thu, 16 Mar 2023 17:28:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [EXTERNAL] Re: [PATCH v10 1/5] dt-bindings: PCI: ti, j721e-pci-*:
 add checks for num-lanes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Milind Parab <mparab@cadence.com>,
        <wojciech.jasko-EXT@continental-corporation.com>,
        achal Verma <a-verma1@ti.com>
References: <20230316071238.200992-1-a-verma1@ti.com>
 <20230316071238.200992-2-a-verma1@ti.com>
 <7bee3bba-d9e3-18fd-2aff-4316fe097741@kernel.org>
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <7bee3bba-d9e3-18fd-2aff-4316fe097741@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/16/2023 5:01 PM, Krzysztof Kozlowski wrote:
> On 16/03/2023 08:12, Achal Verma wrote:
>> From: Matt Ranostay <mranostay@ti.com>
>>
>> Add num-lanes schema checks based on compatible string on available lanes
>> for that platform.
>>
>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>> Signed-off-by: Achal Verma <a-verma1@ti.com>
>> ---
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Since you skipped important  DT list, there will be no checks executed
> here. It's a NAK unfortunately. :(
> 
> Best regards,
> Krzysztof
Sorry for this, I will resend the series with updated email list and
same version.

Thanks,
Achal Verma
> 
