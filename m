Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D92F76F718
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 03:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjHDBqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 21:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjHDBqg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 21:46:36 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6A24482;
        Thu,  3 Aug 2023 18:46:33 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id EDA667F8E;
        Fri,  4 Aug 2023 09:46:31 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 4 Aug
 2023 09:46:32 +0800
Received: from [192.168.125.127] (183.27.98.54) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 4 Aug
 2023 09:46:30 +0800
Message-ID: <0b93ffcb-a236-99c0-1cf5-ad584b80c0ab@starfivetech.com>
Date:   Fri, 4 Aug 2023 09:46:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/4] Refactoring Microchip PCIe driver and add StarFive
 PCIe
Content-Language: en-US
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Mason Huo" <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230727103949.26149-1-minda.chen@starfivetech.com>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230727103949.26149-1-minda.chen@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.54]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/7/27 18:39, Minda Chen wrote:
> This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
> JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
> same IP and have commit their codes, which are mixed with PLDA
> controller codes and Microchip platform codes.
> 
> For re-use the PLDA controller codes, I request refactoring microchip
> codes, move PLDA common codes to PLDA files.
> Desigware and Cadence is good example for refactoring codes.
> 
> So first step is extract the PLDA common codes from microchip, and
> refactoring the microchip codes.(patch1 - 2)
> Then, add Starfive codes. (patch3 - 4)
> 
> This patchset is base on v6.5-rc1
> 
> patch1 is move PLDA XpressRICH PCIe host common properties dt-binding
>        docs from microchip,pcie-host.yaml
> patch2 is extracting the PLDA common codes from microchip Polarfire PCIe
>        codes. The change list in the commit message.
> patch3 is add StarFive JH7110 PCIe dt-binding doc.
> patch4 is add StarFive JH7110 Soc PCIe codes.
> 
Hi Rob, Krzysztof(K.K) and Conor
  Do you have any comments for dts-binding doc patch? (patch 1 and patch3) Thanks.  
