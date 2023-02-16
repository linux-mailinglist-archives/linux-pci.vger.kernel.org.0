Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E8369947A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 13:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjBPMg1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 07:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjBPMgY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 07:36:24 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ACB59B73
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 04:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676550960; x=1708086960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qWdBXURkEWQ0Kpi/ReACY5uBS9pNg8ScF4q+29CVWaM=;
  b=b4lto1K9DudhwiLXAVl34CszRgGVih1F5JowCd5PgsTf3+cx5Okot7Cf
   5lnEUGaogqCD7+H6l999GjOFOZ7hwvtFq0aq5b2d8O69aZwc6vTmMLRjq
   v9Z989XHl/7XnlPinyt1RfGrkmFsvuoozPa0gXMFHHYdOruqZ8asvcA2l
   vDPhtwANJqKbDn2uM4uDvStLmh1RiMcyMmz2cQxMrGbyhNEUHVwbaoqnG
   OUVzswQlD2CmK4Tb7ZNWN8oohk5wuuzLYzPm99Pbl3dYyeYoSrydn8ctc
   +sbXLeaeJ4jzor8gdYs7vWmWsgjT+Dh2xxE4gZM0x3JYts5BpWDmbxhXx
   A==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669046400"; 
   d="scan'208";a="221752936"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2023 20:35:59 +0800
IronPort-SDR: ZdFHJrDslN+6mRK8PE3TM7KqnvpjgxW2EaSZ2KspN6ciHYkpiFFzEO4VQzFBcuUIVwgBNNGfDv
 voz9+qFlDBqur7566UFIVwwBLspqmjAyBtS17JBcP3S4MwXBnofsMus/UFLitRVPQ7QYL8gzWN
 Iv0Igoglwvu9dL93/JDidy0TDpMGrpYf4TWBSN9HAj33l1mECHfvlSoL+KdoBxlGZnLAXpnk05
 bggEfoknXE4umxPDqR/lbGtGHVZGLjPMc5TX4ZBd01M7W5nMH3dXKAGQfW3jfCm5riqJYEUBNE
 dRA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2023 03:47:20 -0800
IronPort-SDR: EISIjkmNGL1OX74JHRNBGy+hAwE0OvmNToHgmG8hVsC2i0SpYA9s8E/jmqg0++soT5GmFHd3FY
 YNUhh2CFwTNsSUTo8ZoVlwVY7WDbflNJiRIJN4uLjaF34kFDGi+88UOyuQj3nfu+M+AUa33WeT
 NXXyMJYMgv7i/uIEVmmMxZNqIfulXIzhCNjHmRGU4hCuUQnZiutCq5ogwmGonOBmW7N3Hs+tXT
 POjfFADWa2AyiZNt9abyZQT9plpsy0S7ZzsjNYTpgA3r20ZFi24JPX4JIYPvdJItcEVtYOg7dx
 QH0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2023 04:36:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PHZDb3TmCz1Rwtl
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 04:35:59 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676550958; x=1679142959; bh=qWdBXURkEWQ0Kpi/ReACY5uBS9pNg8ScF4q
        +29CVWaM=; b=rZhOpFyV3HkAPg9+vMMlCReHkEY+mtZiE1Y3n3gJMdU17NZmtRF
        rlC2b5oRyBWyZDciDeulRFDkJjI6nfKoMprUTTZhi5lrjIZjfL1yKEVYaFbcjOzL
        ixTvS3tyq9Yt2gwje/v6asBRMeIbRi/3JJ/4BnIFoHrhxctpEgHTy4036fBRtW6C
        Y1OCRhqYbU3LvzX74rX1WbqE97vriI2ioIsbKYE+GE9IelADYvUIpuaCy4EbPMBg
        QfI3n5X7elbTyliEEP/7clS9xHM7kR+JltWyWJiK/ExCk8f8stFu/HQDuwSTQ5u1
        FDftPvQERfpitis8STH/zvbHtlZ2P5GOaug==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hSB-3HN1iN10 for <linux-pci@vger.kernel.org>;
        Thu, 16 Feb 2023 04:35:58 -0800 (PST)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PHZDY2Xyyz1RvLy;
        Thu, 16 Feb 2023 04:35:57 -0800 (PST)
Message-ID: <cfe998de-a791-8f6c-9a95-c48fbc6eef88@opensource.wdc.com>
Date:   Thu, 16 Feb 2023 21:35:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 10/12] misc: pci_endpoint_test: Re-init completion for
 every test
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-11-damien.lemoal@opensource.wdc.com>
 <20230216105540.GK2420@thinkpad>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230216105540.GK2420@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/16/23 19:55, Manivannan Sadhasivam wrote:
> On Wed, Feb 15, 2023 at 12:21:53PM +0900, Damien Le Moal wrote:
>> The irq_raised completion used to detect the end of a test case is
>> initialized when the test device is probed, but never reinitialized
>> again before a test case. As a result, the irq_raised completion
>> synchronization is effective only for the first ioctl test case
>> executed. Any subsequent call to wait_for_completion() by another
>> ioctl() call will immediately return, potentially too early, leading to
>> false positive failures.
>>
>> Fix this by reinitializing the irq_raised completion before starting a
>> new ioctl() test command.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
> Fixes tag? CC stable?

I could not find a ref for this one... git blame did not lead to anything. Not
sure if this file was renamed in the past or something.

> 
>> ---
>>  drivers/misc/pci_endpoint_test.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>> index c1370950c79d..baab08f983a2 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
>> @@ -725,6 +725,10 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>>  	struct pci_dev *pdev = test->pdev;
>>  
>>  	mutex_lock(&test->mutex);
>> +
>> +	reinit_completion(&test->irq_raised);
>> +	test->last_irq = -1;
> 
> -ENODATA?

Sure. Anything works here.


-- 
Damien Le Moal
Western Digital Research

