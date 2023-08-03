Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06DE76E07B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 08:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjHCGpJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 02:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjHCGpC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 02:45:02 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60C41982;
        Wed,  2 Aug 2023 23:44:54 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 99B7C24E2DD;
        Thu,  3 Aug 2023 14:44:46 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 3 Aug
 2023 14:44:46 +0800
Received: from [192.168.125.127] (183.27.98.54) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 3 Aug
 2023 14:44:45 +0800
Message-ID: <683e52c7-ae06-06f9-c999-0b6f3d56dbc1@starfivetech.com>
Date:   Thu, 3 Aug 2023 14:44:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] PCI: plda: Get common codes from Microchip
 PolarFire host
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84sk?= =?UTF-8?Q?i?= <kw@linux.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Mason Huo" <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230727103949.26149-1-minda.chen@starfivetech.com>
 <20230727103949.26149-3-minda.chen@starfivetech.com>
 <6e85db42-b946-14a5-fe2b-d90f01cb24d2@infradead.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <6e85db42-b946-14a5-fe2b-d90f01cb24d2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.54]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/7/27 23:21, Randy Dunlap wrote:
> Hi--
> 
> On 7/27/23 03:39, Minda Chen wrote:
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8e4f9d5dca55..ec59c6d00bf9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16170,6 +16170,14 @@ S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/cdns,*
>>  F:	drivers/pci/controller/cadence/
>>  
> 
> This new entry is not in the correct location.
> It should be in alphabetical order, so it goes between
> 
> PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER
> and
> PCI DRIVER FOR RENESAS R-CAR
> 
> Thanks.
> 
Got it. Thanks
>> +PCI DRIVER FOR PLDA PCIE IP
>> +M:	Daire McNamara <daire.mcnamara@microchip.com>
>> +M:	Kevin Xie <kevin.xie@starfivetech.com>
>> +L:	linux-pci@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/pci/plda,*
>> +F:	drivers/pci/controller/plda/*plda*
>> +
>>  PCI DRIVER FOR FREESCALE LAYERSCAPE
>>  M:	Minghuan Lian <minghuan.Lian@nxp.com>
>>  M:	Mingkai Hu <mingkai.hu@nxp.com>
> 
