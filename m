Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A759C697B00
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 12:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjBOLou (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 06:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjBOLoq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 06:44:46 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CB038000
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 03:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676461485; x=1707997485;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UDC9c2BGNb/sHCjP28BHazQT/3USgJFyv0eCaDuMKiM=;
  b=IZhp0E8oOtAjb+FLnmqCiuoxP7fnbeY3D3VdayAFCr+p4I1OQmIdUJst
   u3UXwJ24WsAFztfExmD3zrrKb5KyzZmT6+6xZ997Bnj2HBuTlfuldGLNt
   fRn7FPqJRj5B3uilDTfdg+a+Ixt0wlFz3W1OjtIrAvqr6p2Curj64h1E3
   ZZODwguZ04GP7y+ijKwhlou0Ie/eyN68XSGthqREymoUciZznNaQwRY4N
   VSDUNNc9C871ebkWr8U3OHXvQNB6e1URodUmyIxIyijw4Nqaqy1qLIFC0
   bBBRe6uHofZtrMpzIWPqjkp1u7WxqojZu0KphhuOkO35WwPlqn/Aax5kx
   g==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="221661248"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 19:44:44 +0800
IronPort-SDR: tW73m5acfEwE3brRx3bqeEP5RlJwk9gef4gYryen/1QOi7ZX2OejNyqW696UeylOTkwvqAKJNE
 WMFl6/LYkleKoOcXptW8s3cJqgXb79392O3A1YpbLbfVJY4qF3sXIt7NZvXSB0feU1UUMINk5j
 ZjCkdrVNjtKeWDY8TapC0AAUa8HqymmIVBzTYX5p5v85Pqmiq7KDE5VQIYwmofhlSI3iLCTixz
 MXsF4SWnatPdTumHF69eCjgPJXVvU30g0FuspFBcW3iNVc7wUQYPANigF4Ci71X7XVxkXPkmGX
 DY8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 03:01:51 -0800
IronPort-SDR: gAVGLZ8Iz0YFWE3mQF/8FKgwq1ZiFUZPuk9zwjPngcrqu3WEaKDz3jdN7AlMJC6kHC/rsX8AQe
 C14UWDNzakYNVCIKe5R2XTX6YTly0n0OfSouG75uthX/i/0S3AbiqOUTZSDz+baFbMQsFVBHLr
 jbhIdyJJaygI+Mtp165Tzimw6d9/c81KoFSKggdzF7aCgf9KCtq9+Vcn5gi3y7ZBlEPNKo34E3
 KdF4jweIC/ToyeHn4D9bQkCoFOI5fND6VoP2qQP0HDamUVHF8WlUci2bmClxwPAcrN7JZr7lob
 uB4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 03:44:45 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGx7w2yPQz1RwtC
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 03:44:44 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676461483; x=1679053484; bh=UDC9c2BGNb/sHCjP28BHazQT/3USgJFyv0e
        CaDuMKiM=; b=k522Bg3R2QLTOqktJOuuHoEg2vUL9p4DU9d94PE29DqcUVt0X3T
        OknuhHNefb5DLQirZQIphC6GmkiXkQiVO+CayxFnS3e+d4NdoXhN7dF6qgboGUOK
        8/jFFBcROH+LPSfbzVIyq25sndLXWNxrV+URYE/Sl8SyPLXLNICDGkvKGXjys2/W
        IRUJaxo365ZRdg/rkWLm1OU4s63G0dVv3xvQhJPmSKWhnbf+UegDSasdskaAsd3v
        FTHXE+otAsaSgkbvEGMQXt2tE6Brg/4Hqt7aM3199ASO04deCTzvu5dW9xOx3hCI
        kuldxkH+Z54wb3FrDyKrL5PiGy2JPr3lzHQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id srSXE_d4kkFs for <linux-pci@vger.kernel.org>;
        Wed, 15 Feb 2023 03:44:43 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGx7t2SrWz1RvLy;
        Wed, 15 Feb 2023 03:44:42 -0800 (PST)
Message-ID: <76317715-8055-0d3c-523c-634a041fa265@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 20:44:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 07/12] pci: epf-test: Add debug and error messages
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-8-damien.lemoal@opensource.wdc.com>
 <Y+zDOEIz7Nggk0nb@kroah.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y+zDOEIz7Nggk0nb@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/15/23 20:34, Greg Kroah-Hartman wrote:
> On Wed, Feb 15, 2023 at 12:21:50PM +0900, Damien Le Moal wrote:
>> Make the pci-epf-test driver more verbose with dynamic debug messages
>> using dev_dbg(). Also add some dev_err() error messages to help
>> troubleshoot issues.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 69 +++++++++++++++----
>>  1 file changed, 56 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index f630393e8208..9b791f4a7ffb 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -330,6 +330,10 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test, bool use_dma)
>>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>>  	volatile struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>>  
>> +	dev_dbg(&epf->dev,
>> +		"COPY src addr 0x%llx, dst addr 0x%llx, %u B\n",
>> +		reg->src_addr, reg->dst_addr, reg->size);
> 
> Again, no, please just use ftrace.

OK. Got it.

> 
> thanks,
> 
> greg k-h

-- 
Damien Le Moal
Western Digital Research

