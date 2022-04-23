Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D41550CC5F
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 18:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiDWQoh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 12:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbiDWQoR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 12:44:17 -0400
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3660347AD3;
        Sat, 23 Apr 2022 09:41:14 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru ADB9123081DB
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v3 7/8] ARM: dts: r9a06g032: Add USB PHY DT support
To:     Herve Codina <herve.codina@bootlin.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     Rob Herring <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20220422120850.769480-1-herve.codina@bootlin.com>
 <20220422120850.769480-8-herve.codina@bootlin.com>
 <ed432ba2-6081-4d82-bdc9-cd88cb52ca1f@omp.ru>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <f7e76000-11ec-42d1-5767-7f270a3b025d@omp.ru>
Date:   Sat, 23 Apr 2022 19:41:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ed432ba2-6081-4d82-bdc9-cd88cb52ca1f@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/23/22 12:09 PM, Sergey Shtylyov wrote:

[...]
>> Define the r9a06g032 generic part of the USB PHY device node.
>>
>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>> ---
>>  arch/arm/boot/dts/r9a06g032.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
>> index 33581f0c55c4..58af07eb75c9 100644
>> --- a/arch/arm/boot/dts/r9a06g032.dtsi
>> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
>> @@ -59,6 +59,12 @@ ext_rtc_clk: extrtcclk {
>>  		clock-frequency = <0>;
>>  	};
>>  
>> +	usbphy: usbphy {
> 
>    I think the node name should be "usb-phy"...

   It's not my thinking alone, the DT spec documents "usb-phy" in section 2.2.2. :-)

> [...]

MBR, Sergey
