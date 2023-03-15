Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1056BC1B3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 00:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjCOXrD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 19:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjCOXrC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 19:47:02 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0634D2B1
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 16:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678923993; x=1710459993;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GccmSzdDOq7TnWK1LL6uhb+BmX4gGgbvWw5ezUo+ZAo=;
  b=GU0PNiIZ/t8N+/FiuIoP5mXJiykDGWIx6kZQH8fB7VZISpem+C3BrLcB
   V3e9cLN5uL365v6dBlQ+FZVHwVTsY/S477KRcv/Bih75diKZeZcjHJYb2
   UDjg4NEnfTEB+eNpLsm9VNDxRhUBB1ugWUMC1qoA6sggpA+9spvxUhqgd
   rbvFho92xLfolaWwX5bevCLbUvrbQaQxFUMJJ68kjn07d6EWhmfgKXbKR
   cvoezmW242krZ/XxLymF0BPKiF1x/duymLgI87OIM3JFAjQH9GvO9GJ1F
   i+qu5EmspFY1SoFklc0U1Rmh/YuEUFjtwz5ikr7SK2IFWGYO9M+hFRUO2
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="225729407"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2023 07:46:11 +0800
IronPort-SDR: Ji5G4gXZWBFBqR54sUycibiMZloAmxnl0CmTp1IMyEiELRX1qPtkli3mA6T+PNnVd0oLXiCcKU
 hki4scTvEpVwTres4qq4preZux3iTPsfIm1O76c0T70wBOffloUvdQEzQzoaL9yK2NSKMuoyM9
 0DEVhsA9DAUvghm4Zq0d33SAu/OFL6iH9f0J8Pj4gFeu7yyEC9TfgmWhdOCeHfEn6k9NFjLGjP
 +e49KkQ5O2qNtozgONp812WZ/KAdOt1h8HlMzdYlCXQ4sHhm9/2UTV+jp/r1v3ZbdBBpsDj7as
 BgI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 16:02:37 -0700
IronPort-SDR: b4YuTQmH7NMpijzcNJcOijQFu4PDtVWg1rRiGkUxqOnN7RVqkH0KfzAYtT9Ra339UC6feAs5TT
 wMs7U8ogo8k1FLmXNvsmkiVOkbvy4VPoMMRzcHNt00EwYseoHVqcuqyNV6IhncosqKAuO194By
 Lo5Y6PUUKfLVLzMrCtRx5dS5hXtgLjFqJ4EaCHsx5nGKRHZECQBxtvg7rvx8SVyazbfWpbwLzc
 a+C9zuP0I0FXoUQer92lQDlfSXe+yhTmWOaZLI/JDgGMiRBjBtonu5Ki2RkG+6DYjF8TLFIjzy
 3Ek=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 16:46:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PcRqR0zcvz1RtVw
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 16:46:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678923970; x=1681515971; bh=GccmSzdDOq7TnWK1LL6uhb+BmX4gGgbvWw5
        ezUo+ZAo=; b=VrEY4OHn9qclUToroKPXrFqE/4e4ZXEISJ+jhuqka9D48y2F2Kz
        TeaTKaQ2YZSNf7LDyqkMVM205921V7LIPGgHGfu6CKVxSISXkW8rUFhz4Ib+s4jo
        u815rFstNZSH7bNDNN4TZMc4NOKCo+otfGMcM4J0l7Pq8UmE7M8nmwYCY2jSrzS0
        +xRW0kk6irShF5/sotoOszrEwe/Ypwb/pVDE7mmHA3eICwiOTtcJd7xE4ccxp4Xt
        6gbvINEPfbax8SPG3bAf0cnsKID1RJotirQGV8677ddYvxFEoFIafLoZDPQtKhpY
        xglu9xYeFkkc9TYAuABPSnapUw+1HR0izzA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id buw_A_YnwVfi for <linux-pci@vger.kernel.org>;
        Wed, 15 Mar 2023 16:46:10 -0700 (PDT)
Received: from [10.89.80.69] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.69])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PcRqN6gJlz1RtVm;
        Wed, 15 Mar 2023 16:46:08 -0700 (PDT)
Message-ID: <c9d0c032-cda5-cf35-8a25-d7a297140337@opensource.wdc.com>
Date:   Thu, 16 Mar 2023 08:46:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 04/16] PCI: epf-test: Fix DMA transfer completion
 detection
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
 <20230308090313.1653-5-damien.lemoal@opensource.wdc.com>
 <20230315152029.GF98488@thinkpad>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230315152029.GF98488@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/03/16 0:20, Manivannan Sadhasivam wrote:
>> @@ -152,25 +160,35 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>>  	}
>>  
>>  	reinit_completion(&epf_test->transfer_complete);
>> +	epf_test->transfer_chan = chan;
>>  	tx->callback = pci_epf_test_dma_callback;
>>  	tx->callback_param = epf_test;
>> -	cookie = tx->tx_submit(tx);
>> +	epf_test->transfer_cookie = tx->tx_submit(tx);
>>  
>> -	ret = dma_submit_error(cookie);
>> +	ret = dma_submit_error(epf_test->transfer_cookie);
>>  	if (ret) {
>> -		dev_err(dev, "Failed to do DMA tx_submit %d\n", cookie);
>> -		return -EIO;
>> +		dev_err(dev, "Failed to do DMA tx_submit %d\n", ret);
>> +		goto terminate;
>>  	}
>>  
>>  	dma_async_issue_pending(chan);
>>  	ret = wait_for_completion_interruptible(&epf_test->transfer_complete);
>>  	if (ret < 0) {
>> -		dmaengine_terminate_sync(chan);
>> -		dev_err(dev, "DMA wait_for_completion_timeout\n");
>> -		return -ETIMEDOUT;
>> +		dev_err(dev, "DMA wait_for_completion interrupted\n");
>> +		goto terminate;
>>  	}
>>  
>> -	return 0;
>> +	if (epf_test->transfer_status == DMA_ERROR) {
>> +		dev_err(dev, "DMA transfer failed\n");
>> +		ret = -EIO;
>> +	}
>> +
>> +	WARN_ON(epf_test->transfer_status != DMA_COMPLETE);
> 
> Why do you need this check? Even if required, WARN_ON is superfluous here.

The check is needed to return -EIO if there was a problem with the transfer,
because wait_for_completion_interruptible() does not notify such errors (it only
notifies timeouts).

And yes, the WARN can go away. Will remove it.

-- 
Damien Le Moal
Western Digital Research

