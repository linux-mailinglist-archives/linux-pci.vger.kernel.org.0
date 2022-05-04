Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5FE51ABFB
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 19:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355493AbiEDSCI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 14:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377569AbiEDSBN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 14:01:13 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34434E3A8;
        Wed,  4 May 2022 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hy+OhVR/LV0xEzAsGTGdgKCKGoSd8NJQpERGht9sL1o=; b=Ex1fLswhxbmvMM6ln5WhknBLM/
        PmSusBqYOAcPwmB8INTvkq+eguCyPDijsDz8PAtNIfwqfyCvYK2KU8Jlv28tNo5jveGmStK04hweD
        C5mjIZ/bvhvb0WqBv6UmR1pHy1qBwnblP8khg8eEY94TpR3ROiwJeqqqiZC1ZAsUlcS0=;
Received: from p200300daa70ef200891a2ae4514fd280.dip0.t-ipconnect.de ([2003:da:a70e:f200:891a:2ae4:514f:d280] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nmIcD-00043Z-CU; Wed, 04 May 2022 19:16:41 +0200
Message-ID: <c54c5692-56bd-c17c-24f5-741ec2a1a839@nbd.name>
Date:   Wed, 4 May 2022 19:16:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] PCI: mediatek-gen3: change driver name to mtk-pcie-gen3
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220504170658.GA453994@bhelgaas>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20220504170658.GA453994@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 04.05.22 19:06, Bjorn Helgaas wrote:
> On Wed, May 04, 2022 at 12:05:55PM +0200, Felix Fietkau wrote:
>> This allows it to coexist with the other mtk pcie driver in the same kernel
> 
> I assume this is a v3 of [1].  Please:
Thanks, I wasn't aware of that patch.

>    - Follow the subject line capitalization convention, i.e.,
>      "PCI: mediatek-gen3: Change ..."
> 
>    - Expand the commit log to say why this is important.  From a C
>      language level, using the same "mtk-pcie" string in both drivers
>      is no problem.  So please mention where it *is* a problem, e.g.,
>      if it's a problem with modprobe or similar, say that.  Or if it's
>      to make log messages in dmesg have different driver names, say
>      that.The reason is the fact that driver_register will refuse to register a 
driver if one with the same name has already been registered.

>    - s/pcie/PCIe/ in commit log and other English text.
> 
>    - Add a period at the end of the commit log sentence.
> 
> [1] https://lore.kernel.org/r/20220422070908.14043-1-jianjun.wang@mediatek.com
Will take care of this and send an updated version as v3.

- Felix
