Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D865843B4
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiG1P4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 11:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiG1P4v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 11:56:51 -0400
X-Greylist: delayed 1509 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Jul 2022 08:56:50 PDT
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C851C51A29;
        Thu, 28 Jul 2022 08:56:50 -0700 (PDT)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.17])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1oH5Tr-006dKi-BO; Thu, 28 Jul 2022 16:31:19 +0100
Message-ID: <0d644682-094d-6151-aa2f-86552c8f9a87@codethink.co.uk>
Date:   Thu, 28 Jul 2022 16:31:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND v4 03/15] PCI: dwc: Convert to using native IP-core
 versions representation
Content-Language: en-GB
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20220728152418.GA302516@bhelgaas>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20220728152418.GA302516@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/07/2022 16:24, Bjorn Helgaas wrote:
> On Fri, Jun 24, 2022 at 05:39:35PM +0300, Serge Semin wrote:
>> Since DWC PCIe v4.70a the controller version can be read from the
>> PORT_LOGIC.PCIE_VERSION_OFF register. Version is represented in the FourCC
>> format [1]. It's standard versioning approach for the Synopsys DWC
>> IP-cores. Moreover some of the DWC kernel drivers already make use of it
>> to fixup version-dependent functionality (See DWC USB3, Stmicro STMMAC or
>> recent DW SPI driver).
> 
> These references to other drivers might be useful, but without a
> function name or file name, I can't easily find them.
> 
>> In order to preserve the standard version
>> representation and prevent the data conversion back and forth, we suggest
>> to preserve the native version representation in the DWC PCIe driver too
>> in the same way as it has already been done in the rest of the DWC
>> drivers. IP-core version reading from the CSR will be introduced in the
>> next commit together with a simple macro-based API to use it.
>>
>> [1] https://en.wikipedia.org/wiki/FourCC
> 

I'm currently looking at a OF based dw-apb-timers-pwm driver, so also
would like to follow this.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
