Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41CE6E03DA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Apr 2023 03:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDMBuN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 21:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDMBuK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 21:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C867ABC
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 18:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CE55625BD
        for <linux-pci@vger.kernel.org>; Thu, 13 Apr 2023 01:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84078C433A8;
        Thu, 13 Apr 2023 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681350606;
        bh=ka/86xh6PiG3qeWJ0j9E8iYk1yKSEOizSsY25QiUIA4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J3eLVknLXBhMqO1APf0qjJytikdu9FfOL64bxHjYm3pk7qkj6MUZtgItSTySETOV1
         WJ1F48ef1FWKD34UbAgfZtOZsJ2cABMqEUF1Uj4SRg17mtPdmouSianKUElX29z9ww
         jE7u8rnf0rEC8LhvuKFecxbbSLNUkEHk8WipEXncuNW/HHPCxJ/YaRE0p/Zd14+CnX
         Ex4oheopo0vEK8SjahD3yQZiGqn/0c6AMH9IfO9C8iChV6whRY0aHKw1gmgnA7M6Ka
         mhkGSramP6QoS7MoEgLq8/J960bB5o7iQTOcIdzuliZeeuhaPGWtHZHgVi/OtBYaCT
         QqbkSUbyg948g==
Message-ID: <20cfd32d-0e4c-a928-fc26-1c4c47972ece@kernel.org>
Date:   Thu, 13 Apr 2023 10:50:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 04/17] PCI: epf-test: Fix DMA transfer completion
 detection
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230330085357.2653599-1-damien.lemoal@opensource.wdc.com>
 <20230330085357.2653599-5-damien.lemoal@opensource.wdc.com>
 <9a70d819-70d1-fb69-b053-a37ccfacf145@igel.co.jp>
 <a54f004c-31ce-b553-616b-d13fa76d709c@fastmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <a54f004c-31ce-b553-616b-d13fa76d709c@fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/4/23 19:16, Damien Le Moal wrote:
> On 4/4/23 18:47, Shunsuke Mie wrote:
>>> @@ -120,7 +129,6 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>>>   	struct dma_async_tx_descriptor *tx;
>>>   	struct dma_slave_config sconf = {};
>>>   	struct device *dev = &epf->dev;
>>> -	dma_cookie_t cookie;
>>>   	int ret;
>>>   
>>>   	if (IS_ERR_OR_NULL(chan)) {
>>> @@ -152,25 +160,33 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>>>   	}
>>>   
>>>   	reinit_completion(&epf_test->transfer_complete);
>>> +	epf_test->transfer_chan = chan;
>>>   	tx->callback = pci_epf_test_dma_callback;
>>>   	tx->callback_param = epf_test;
>>> -	cookie = tx->tx_submit(tx);
>>> +	epf_test->transfer_cookie = tx->tx_submit(tx);
>>
>> How about changing the code to use dmaengine_submit() API instead of 
>> calling a raw function pointer?
> 
> This is done in patch 5 of the series.

Bjorn,

My apologies for not replying to the series cover letter as I do not have it
locally (due to WD on-going network issues).

This is a ping about this series. Can we get it queued ?
(I do not see it in PCI next tree)

