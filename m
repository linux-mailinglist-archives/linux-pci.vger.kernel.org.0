Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C806898CE
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 13:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjBCMcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 07:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjBCMch (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 07:32:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D5679F3A;
        Fri,  3 Feb 2023 04:32:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66798B82A20;
        Fri,  3 Feb 2023 12:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795C9C43444;
        Fri,  3 Feb 2023 12:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675427552;
        bh=iJge+MFqjbzizxQCThk6ckFPnVqDT96ToH0Ft3Tw/hQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Cb+FiVf/u22D5ODmDsgmYB8x4z6jjnH3mAnoWdFnxki4XJTKMQBiz5uhRsfODBXgO
         GeWrObErqwhYm49IJTiu1MgdZYxii+TaVIiN8buzRpT9pi7nOe0w4hjd/fEOjTLxBG
         kmpHBUVtAleOKUDYGP/4Xg4PCozDxNijxu7qVKxB2iRWgH0793gRrJ0kilVEo6gKsq
         5QT0ueotzjpqQAgBvq5DhuXquHQW4S+yg7TzAi0/snNwmXlQNQl1xyVsdABEIkeF6e
         vYxsCnMJxuoYKab+IinW/T9AsopCmSgayyZwwmpJ1nPZBlIocNuAmYn2oKahxX1Rze
         UYNiOt6C2cX0g==
Message-ID: <9c2c0e88-41d8-f9ec-d934-2d1752696b1a@kernel.org>
Date:   Fri, 3 Feb 2023 13:32:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] dt-bindings: PCI: mediatek-gen3: Add support for
 controlling power and reset
Content-Language: en-US
To:     =?UTF-8?B?SmlhbiBZYW5nICjmnajmiKwp?= <Jian.Yang@mediatek.com>,
        "robh@kernel.org" <robh@kernel.org>,
        =?UTF-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>, "kw@linux.com" <kw@linux.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <Chuanjia.Liu@mediatek.com>,
        =?UTF-8?B?UWl6aG9uZyBDaGVuZyAo56iL5ZWf5b+gKQ==?= 
        <Qizhong.Cheng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        =?UTF-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        =?UTF-8?B?RGF2aWQtWUggQ2hpdSAo6YKx6Yi657+UKQ==?= 
        <David-YH.Chiu@mediatek.com>
References: <20230111032830.20447-1-jian.yang@mediatek.com>
 <20230111032830.20447-3-jian.yang@mediatek.com>
 <dccfa004-1d40-acc0-6220-9232193b648f@kernel.org>
 <8d954de7f9507099bd9bea6801f446f80bd832aa.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <8d954de7f9507099bd9bea6801f446f80bd832aa.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/02/2023 10:38, Jian Yang (杨戬) wrote:
>>> +  pcie12v-supply:
>>> +    description:
>>> +      The regulator phandle that provides 12V power to downstream
>>> component.
>>> +
>>> +  dsc-reset-gpios:
>>> +    description:
>>> +      The reset GPIO of a downstream component.
>>
>> Why you cannot use standard reset-gpios property?
> 
> The "dsc-reset-gpios" represents an extra reset pin other than PERST#
> required by a PCIe downstream device. But the "reset-gpios", described
> in "pci.txt", represents the PERST#. So I tend to add a new property to
> meet this requirement.

OK

>>
>>> +    description:
>>> +      The delay time between assertion and de-assertion of a
>>> downstream
>>> +      component's reset GPIO.
>>
>> Why this should be a property of DT?
> 
> Same as the reason I described above. I suppose we need to add a
> property to let user determine the delay time due to differences
> in requirements between various devices.

No, I don't think we want individual properties like that. There is
ongoing discussion about this:
https://lore.kernel.org/all/20221214095342.937303-1-alexander.stein@ew.tq-group.com/

Feedback is welcomed - there. Don't create your own half-baked delays
for different hardware designs.

Best regards,
Krzysztof

