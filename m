Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93533520F49
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 09:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbiEJID1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 04:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbiEJIDZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 04:03:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEAE24F0E8;
        Tue, 10 May 2022 00:59:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A101C1F43DAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652169565;
        bh=0/8USldqeWAsxzFJkTMe/8nTLoFf3bblkE2WDOxfPaA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QsSJbWxROhDdXBTTpKGk8WfomsV9vGvfl5NVqtQMOcuI4iJMx4XMSIXTGNnpEzlLp
         LWdFgEckcYsR0PXF27dkvzglxnwhf3XmzbaARO41Bd1v7NLCYZG9vkSkbTqPRsr3l8
         7aNGkc2g6uhsfHplnw12egiZBdv8eSYeXYzKWHvgyKXJNC58znt2w92Leeli4C1+GV
         HisD8QyimlyMsqzky7MFckxo7NhS1/LPbtz1gLNL0pkmj9MeZWap9Su26u99S1ExPZ
         +76bFGfHVMTL/okru8zzb9WqInBShKFX8TpFnde4UfnAh/oj277gTFn5RedoDfAdW+
         UycI7AxSIvj4w==
Message-ID: <5f61f655-e5bc-9e70-ce11-431b630a5331@collabora.com>
Date:   Tue, 10 May 2022 09:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] PCI: mediatek-gen3: Assert resets to ensure expected init
 state
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
References: <20220509171631.GA605998@bhelgaas>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220509171631.GA605998@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 09/05/22 19:16, Bjorn Helgaas ha scritto:
> On Mon, May 09, 2022 at 02:18:34PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 04/04/22 16:48, AngeloGioacchino Del Regno ha scritto:
>>> The controller may have been left out of reset by the bootloader,
>>> in which case, before the powerup sequence, the controller will be
>>> found preconfigured with values that were set before booting the
>>> kernel: this produces a controller failure, with the result of
>>> a failure during the mtk_pcie_startup_port() sequence as the PCIe
>>> link never gets up.
>>>
>>> To ensure that we get a clean start in an expected state, assert
>>> both the PHY and MAC resets before executing the controller
>>> power-up sequence.
>>>
>>> Fixes: d3bf75b579b9 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192")
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> Friendly ping for an important fix :-)
> 
> d3bf75b579b9 appeared in v5.13-rc1 (May 2021, a year ago), so I assume
> this is important for v5.19, but not urgent enough to require being in
> v5.18.  Right?
> 

Hello Bjorn,
no it's not *very* urgent, as MediaTek devices that do require this will be
in v5.19 anyway...

Thanks,
Angelo
