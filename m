Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65D2620AD6
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 09:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiKHICk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 03:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiKHICj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 03:02:39 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32039A19C;
        Tue,  8 Nov 2022 00:02:38 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A882Ew8073665;
        Tue, 8 Nov 2022 02:02:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667894534;
        bh=6XtgOCmcOebxwTAMGJJaIMOr0LLKjuEqe0CutpmiHJw=;
        h=Date:From:To:CC:References:In-Reply-To:Subject;
        b=YeT4DHP31A8Jg2MIMMb4/GYngYbVDu91nQYu6SAfl0cssK01FXOuSwXfoZ7vGpFwp
         QaE8e8WLrnwXw1iIi9q7XO6B+ttX51x7NFuJZa+waFbHgjoaKCwiKGAsTf7847i68s
         tgtBEVwFGL+1+06RmRt0qJhlsgtJ3oBeonlIiw5A=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A882EbO016525
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Nov 2022 02:02:14 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 8 Nov
 2022 02:02:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 8 Nov 2022 02:02:13 -0600
Received: from [172.24.223.232] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A8826rl032224;
        Tue, 8 Nov 2022 02:02:07 -0600
Message-ID: <5d049f9c-f86e-990d-6e81-168606172d63@ti.com>
Date:   Tue, 8 Nov 2022 13:32:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Dominic Rath <dominic.rath@ibv-augsburg.net>,
        Rob Herring <robh@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <tjoseph@cadence.com>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <nm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Alexander Bahle <bahle@ibv-augsburg.de>,
        Dominic Rath <rath@ibv-augsburg.de>
References: <20221013062649.303184-1-dominic.rath@ibv-augsburg.de>
 <20221013062649.303184-2-dominic.rath@ibv-augsburg.de>
 <20221013191249.GA38183-robh@kernel.org> <20221014134114.GA307620@JADEVM-DRA>
Content-Language: en-US
In-Reply-To: <20221014134114.GA307620@JADEVM-DRA>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: cdns: Add PHY latency properties
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dominic,

On 14/10/22 7:11 pm, Dominic Rath wrote:
> On Thu, Oct 13, 2022 at 02:12:49PM -0500, Rob Herring wrote:
>> On Thu, Oct 13, 2022 at 08:26:47AM +0200, Dominic Rath wrote:
>>> From: Alexander Bahle <bahle@ibv-augsburg.de>
>>>
>>> Add "cdns,tx-phy-latency-ps" and "cdns,rx-phy-latency-ps" DT bindings for
>>> setting the PCIe PHY latencies.
>>> The properties expect a list of uint32 PHY latencies in picoseconds for
>>> every supported speed starting at PCIe Gen1, e.g.:
>>>
>>>   max-link-speed = <2>;
>>>   tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
>>>   rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */
>>
>> These are a property of the PHY or PCI host? Sounds like PHY to me and 
>> that should be in the PHY node. No reason the PCI driver can't go read 
>> PHY node properties.
> 
> I'm actually not sure if this a property of the PHY, the PCIe host, or
> of the combination of the two.
> 

Latency is mostly related to propogation latency through SERDES PCS and
PMA layers.

> We thought about adding this property to the PHY, too, but we didn't
> know how to handle cases where a single PCIe host is linked with
> multiple PHYs for multi-lane configurations (see TI's AM65x for
> example). Which PHYs latency would you use to configure this PCIe RC?

On AM65x, all lanes go through SERDES of same design (but just different
instances) and thus latencies will remain same across lanes as the PCS
and PMA logics are same. So, the delays are not lane specific

> 
> Personally I don't have a very strong opinion either way - we just
> didn't know any better than to put this into the PCIe host that needs
> it. If you think this is better put into the PHY node we can of course
> send a new version of this patch.
> 

I don't have a preference here...  Delays are dependent on PHYs being
used but something that host needs, will leave it to framework
maintainers.

> Is there any binding that specifies "generic" PCIe properties, similar
> to ethernet-phy.yaml? We couldn't find any.
> 
> I guess in the AM64x case the "PHY" is serdes0_pcie_link below serdes0:
> 
> &serdes0 {
>         serdes0_pcie_link: phy@0 {
> 	...
> 
> This seems to be described by bindings/phy/phy-cadence-torrent.yaml.
> 
> Should we add a generic (without cdns) tx/rx-phy-latency-ps property
> there?
> 
>> If PTM is a standard PCIe thing, then I don't think these should be 
>> Cadence specific. IOW, drop 'cdns'. 
> 
> Yes, it is a standard PCIe thing, but we haven't seen that many
> implementations yet, so we didn't want to pretend to know what this
> looks like in the generic case. We can of course drop 'cdns'.

PTM is definitely standard and vendor specific prefix don't make sense
to me.

> 
> Best Regards,
> 
> Dominic & Alexander


