Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE95617BBA
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 12:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiKCLiF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 07:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiKCLhv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 07:37:51 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B9A13D47;
        Thu,  3 Nov 2022 04:37:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E3DB25C00DB;
        Thu,  3 Nov 2022 07:37:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 03 Nov 2022 07:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1667475444; x=
        1667561844; bh=nmM5Zpu5AzVJtuC5BzGHrcf5/EWlAsxY2pwaIGhzXz8=; b=o
        0H4UePSYfK8Vre3/OK6ZFX0NFx5FHpElxieL/nxnpi57r8sCMNRQvjBSHfWcTaYg
        CyZOreDP7RTw5JJRcUgYa3yJVj2d14zgnh/qqOR5Tzsy9YC27j/B+PWlOB80Pk/h
        CO/85/p5+fuwaTCCidS/JiA4wl2yssoczZ8EAv9aD2ZYBqdI19oQamuyKt2xQPrP
        7UMpqLq96EKkQIem6nozCguWeEbw2XrY7Dv2VDqDqQ7n2d1mpFYj5sr/5CKlPVFy
        h+fEGnLkrneovou6xIe9Qz8EsGzRVvKn2M21POkTUguBHSAsInH4ADOaaeM3koQ3
        bJZIryzShKCrvfs/e5oJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667475444; x=
        1667561844; bh=nmM5Zpu5AzVJtuC5BzGHrcf5/EWlAsxY2pwaIGhzXz8=; b=j
        GuvHHXJ6xfo4Q+t9Q+iEGkjXhCJklg3qpOsSgtpHVjEoo9pWWF7lwKjtbNlHoBUo
        lPXpUjLbocW72nE6DT0v19MRPuGqjEFFyH2LspsMOJF6FyGfZP+cfKzINN+Zzn88
        7mREIhyxQNNgZet1jfOSdqRtQIwOAh+GY+QV075JYj4M3rbS6fHNKFQyLKJb4HxC
        wXJYBsdvpEIUUmV+LIBBWaV9xNTQmK50Ao6T0uva2mO0ozUfoA9h/rL+abpiWViR
        hOOsCsgWn7v/bpeF+5+2yuBA3EwZcDqRB0SVmWqEXe2BDkFYSS56ElaspK88AO/X
        /1KVQJY/SMO1WZhFLgYuQ==
X-ME-Sender: <xms:9KdjY2kQhVkLQcCZ6rXlbbCxOHWyEHnAxaIlLjq7cp4Fq9NOs2kGxQ>
    <xme:9KdjY91uKCHd9zm3d6LBycL7mlx6IxF_tTHiQGA9MD_qCt1lCYOVpRRy_3CnqVKDg
    EOkPQecroQYhFbTYfk>
X-ME-Received: <xmr:9KdjY0oa7kLHJSeL8AFukoZz5twz6aDEkMYys0fpHxRIwSpu2MtZnMQMY59RVP9S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudelgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeduhfekvedvtdeukeeffefgteelgfeugeeuledttdeijeegieeh
    vefghefgvdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:9KdjY6kZGxgnYwaGN1JwrS7E3yShtgusNrrB2cJzSFjCA5AkjQxkMw>
    <xmx:9KdjY02Hpw4JaxxKuvW2fGOPV1HS-g8fFeR0GNxo37kBElx_u0ebfg>
    <xmx:9KdjYxtmxsL-E55qEgH6tA9M9RvEdmsPWyIl3nNJy2VJED9WRYvc2A>
    <xmx:9KdjY9uG4sYkgMGXFkSu2YlqNrCBA3JETsaiWI1ucFSlVGHvQo9Xvg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Nov 2022 07:37:22 -0400 (EDT)
Message-ID: <dc6aef31-5d0f-9265-1a6b-f1569cec4b37@flygoat.com>
Date:   Thu, 3 Nov 2022 11:37:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] PCI: loongson: add skip-scan property for child DT
 node
Content-Language: en-US
To:     Liu Peibao <liupeibao@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     chenhuacai@loongson.cn, lvjianmin@loongson.cn,
        zhuyinbo@loongson.cn, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221103090040.836-1-liupeibao@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20221103090040.836-1-liupeibao@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2022/11/3 09:00, Liu Peibao 写道:
> The PCI Controller of 2k1000 could not mask devices by
> setting vender id & device id in configuration space header
> as invalid values. When there are pins shareble between
> the platform device and PCI device, if the platform device
> is preferred, we should not scan this PCI device. In the
> above scene, add "skip-scan" property in DT node of this
> PCI device.

If you are going to add a new property you need to document it somewhere.

 From my point of view you can use existing property `status = "disabled"`
to for this semantic...

Thanks.
- Jiaxun


>
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> ---
>
