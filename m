Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAC16D5CE1
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 12:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjDDKRI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 06:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbjDDKRH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 06:17:07 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E39183
        for <linux-pci@vger.kernel.org>; Tue,  4 Apr 2023 03:17:06 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 81A6F581FF5;
        Tue,  4 Apr 2023 06:17:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Apr 2023 06:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680603424; x=1680607024; bh=RaBdlbb8qtSPpF2y9ZdbaS6K4mx/g7f6hVT
        9ANwt864=; b=oSBYF8BHvxMJ2Y2Pb0Ktebt7o4VedxHZ7VxHXCgFlJLaO0HBVE5
        LIKc98n4c8M/91/jvf3jXfOo5HLyAcpzTfUC5nXmw/6nF6PffyUVqvYEdvGyPUu7
        nAxHNjDDsTBb+HRkW78f7wPcoB7+PXvMPYgE9kXq8E0IAEKKCIUMnvldKhhfaC4w
        605GoH1Pbw50yBZTEhbl6VJ3Oz5xdrjTpQ0XGVb3ahgEj5vyTki+gRWbfjeHCthl
        42EMeeEr2owotGJdszOp4yYfWIqmwhVKVjHZ4m8VFYKzxQC0Ej7BiDHjapAmObMR
        xYOirRdSh9ZSDafunn4Qt350qXpvLR3N7/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=i3db14652.fm2;
         t=1680603424; x=1680607024; bh=RaBdlbb8qtSPpF2y9ZdbaS6K4mx/g7f6
        hVT9ANwt864=; b=Sj10per4iUI6nSIQ/R86hHWtkmwbEkFC6ig2GCqe1WzQ48P6
        hzHl//vkGwe6fmjLBgohlGXkkcLK1YFyA765tI96olfuXnh26sCqZEFLlRVz25TN
        +LKLP04h/lT+qHocKe7Hx/o8AVMvc3QQ4xPCnx1CunJEGfQaZbO0p9JGPtGCYdnQ
        +NMRK36HqUC7QpbynDwYeZzw4vHU9HioaWmNp1gzvj4pESF7Tk2PqEV+x+25J/Dq
        MiNbx78/5wEnFQgTto609aqU/4ZkCyp/w9oCXH1QdROga1lkqbSRIetMHjL8qsmO
        +jytJLUamO9aoiqLnTLRJbrEeIHy7jG4DqYnRQ==
X-ME-Sender: <xms:IPkrZFzgUb_vL_oGSU06W11vzeVGFAeK7pfbUvpcEv7qqsvTK0YwqQ>
    <xme:IPkrZFRLNeoc5kOPMJDuWLNSGO2cHCyEmeXdsTRmLlyha5kBeuCGgpa2IQeMvQrdu
    rIAadlKbofDcZDz4pM>
X-ME-Received: <xmr:IPkrZPXiLtvHyY5hv9jVYvq3Ulw0bWSNteRF9mc_MLTypeS3EIauN5KYaNQWzgVAZK8XgSFWUJCN6usivG5uxAE79eHVfydd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeffrghm
    ihgvnhcunfgvucfoohgrlhcuoegulhgvmhhorghlsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepteefiefhieetgfevhfegfeehffetteduieetudfgleetvdff
    udelveejfefhfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepughlvghmohgrlhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IPkrZHgsnmeHie1xyVTd_pSmhLJdu71ifaMBtIZkJuizAxoLkdcC3A>
    <xmx:IPkrZHCDMIWUXL-t-0097JK9rZ-61MSWQm93G9k_LyzZgjmyatUlDA>
    <xmx:IPkrZAIz5ReSomlD0vsyJIZFPNM6ys5J3X-zIIyVMVy2LFH-y-34hg>
    <xmx:IPkrZDtb984ztdKZP1JbMlSTnfxgBmXIS0whX53JBclnkg37cPcy1w>
Feedback-ID: i3db14652:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 06:17:01 -0400 (EDT)
Message-ID: <a54f004c-31ce-b553-616b-d13fa76d709c@fastmail.com>
Date:   Tue, 4 Apr 2023 19:16:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 04/17] PCI: epf-test: Fix DMA transfer completion
 detection
Content-Language: en-US
To:     Shunsuke Mie <mie@igel.co.jp>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
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
From:   Damien Le Moal <dlemoal@fastmail.com>
In-Reply-To: <9a70d819-70d1-fb69-b053-a37ccfacf145@igel.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/4/23 18:47, Shunsuke Mie wrote:
>> @@ -120,7 +129,6 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>>   	struct dma_async_tx_descriptor *tx;
>>   	struct dma_slave_config sconf = {};
>>   	struct device *dev = &epf->dev;
>> -	dma_cookie_t cookie;
>>   	int ret;
>>   
>>   	if (IS_ERR_OR_NULL(chan)) {
>> @@ -152,25 +160,33 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>>   	}
>>   
>>   	reinit_completion(&epf_test->transfer_complete);
>> +	epf_test->transfer_chan = chan;
>>   	tx->callback = pci_epf_test_dma_callback;
>>   	tx->callback_param = epf_test;
>> -	cookie = tx->tx_submit(tx);
>> +	epf_test->transfer_cookie = tx->tx_submit(tx);
> 
> How about changing the code to use dmaengine_submit() API instead of 
> calling a raw function pointer?

This is done in patch 5 of the series.


