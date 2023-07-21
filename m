Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC0D75C3CB
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 11:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjGUJ41 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 05:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjGUJ40 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 05:56:26 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A02359A;
        Fri, 21 Jul 2023 02:56:04 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8E2A824DE03;
        Fri, 21 Jul 2023 17:55:53 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 17:55:53 +0800
Received: from [192.168.125.127] (113.72.147.86) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 17:55:52 +0800
Message-ID: <8e8a987e-f596-31b3-dfbf-69c285a1dfb1@starfivetech.com>
Date:   Fri, 21 Jul 2023 17:55:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/9] Refactoring Microchip PolarFire PCIe driver
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230719152626.GA502469@bhelgaas>
 <52ebc991-0e73-8df4-61b2-32989ab4e62c@starfivetech.com>
 <20230720-unkempt-bath-9d320d55577c@wendy>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230720-unkempt-bath-9d320d55577c@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
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



On 2023/7/20 20:12, Conor Dooley wrote:
> On Thu, Jul 20, 2023 at 10:15:51AM +0800, Minda Chen wrote:
>> On 2023/7/19 23:26, Bjorn Helgaas wrote:
>> > On Wed, Jul 19, 2023 at 06:20:48PM +0800, Minda Chen wrote:
> 
>> >> This patchset is base on v6.5-rc1
>> > 
>> > Doesn't quite apply cleanly for me:
>> > 
>> I am sorry, The driver need stg clk and syscon driver, which are have't be merge to main line.
>> mainly dts is(patch9) rejected, Must apply this series patch first. (I forget add this link in cover letter)
>> https://patchwork.kernel.org/project/linux-riscv/cover/20230712092007.31013-1-xingyu.wu@starfivetech.com/
>> and this syscon patch 
>> https://patchwork.kernel.org/project/linux-riscv/patch/20230717023040.78860-7-xingyu.wu@starfivetech.com/
> 
> You could detach the dts patch from the series & send it independently once
> everything it depends on is in place. I'm going to pick up both of the
> patches you've linked for v6.6 in the next day or two.
Thanks very much. I have considered removing the dts patch. But I think Maintainers
also review the dts patch. So I add this.....
