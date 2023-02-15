Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFD3697B9E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 13:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjBOMSy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 07:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbjBOMSx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 07:18:53 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6440166D5
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 04:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676463531; x=1707999531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hDzsCh2M3dfHg3kkmzHOTCsgsb4/1233PYaayStoNA4=;
  b=IRXDF2zqpcE4r2YWlE8YjDQCizwSRE3ic/3xasMsqU7PbTxyMWH+LL+G
   b7Qu2HT24/3PEtjOxD9xVl/1mRHgK/TnbwLFLFQt4C93urnfLb5x2O/Q6
   gwY4//PGBI1sNtshQCs+02h/MRhzJljUYklQA0grzBKqqWAdg3R1gfFBH
   JeH9jTE9ePZp4FhViGxgzAOL2IBGxiNoU2nHsQ8Jm794R2XGVU2jPsfBT
   Hyd/CqB4Ve5ZegCMCw7y6UOZOXGmMrn/EyGyALRDUupAakSXyHdk6Qs0z
   hcmJwhETUUhZoJvHkelGxLXOesNbS1VUhUr/KkGgMZ7/swtyTvA3tmt27
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="327664929"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 20:18:51 +0800
IronPort-SDR: efAaq8Pd+6pmKEnvwgO6trotwXEC4iez6Lj3TONe+1t/NB6Z095bPGhaSq9EtpVgCYRVDYyK0m
 X5gYGZYBAxB0z31FLul0h3wPgFW6Oo8YXPN6g+xRlut+iJXgUc612vMdZvEGwQBD3Vs675tuLP
 uMStl1k/VCrggm8fkl24507hGnCeCV7dRP86zixqIEqzBc1WdXyH38sSose0Z+OMFTO8WgxIsM
 38q+P5doDSvl9GeXHxG6PaPilLqjNQkG4WGT+thykjUqmAEokeT0dUf0G386S8eCwDOpB8ahFL
 EQQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 03:30:13 -0800
IronPort-SDR: Bd6UK+FrlMcLy2ssJ1Wnv89x3ZdvzLAc9faDSyxH8ww7/pxP7HbWsDLCGgNCBiJGPsjd1bOhZG
 cor0G8hOh41G+4WwRaGngIWvEOZyTeLdLO8iHwBblqGkg3uVI52gmiB74AQmVUMn9y7igVExzT
 ouR+n40bxUqzgZLW54uzJ9SlbIn3RJUCgb0apJsdy1UYWzybQG4YFSgXDK14/lVy/TpnU3xOQR
 HAs64cU5W66T/M5JG5lpmFqrN5yPWOPyS9L7ND9qRLW6mlT1APQVYtn2b1y+jGja2Ho7XYwlVU
 JYo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 04:18:52 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGxvH150Vz1RwtC
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 04:18:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676463530; x=1679055531; bh=hDzsCh2M3dfHg3kkmzHOTCsgsb4/1233PYa
        ayStoNA4=; b=bfU5xoTdMbb5MgAmTDVOMW1xo26+lsdwjwQJxG/dc1d5Lz47PQi
        V8r9oT+IfVXvUlIxrgt6P5tNUj9o1WgK7R3Xh5YW5q2dBZI0qVf0yL2E8IoxIheA
        wHGaISgk9fqU9dgLPGbEEWO1F+AhssgxYY5lJLPOelOjNfZGSkVeab6fZz76IrEH
        0vKjbjuUZjQ8X1XVDipSgWOmLrIe0XVfkHdN3i1Q47uHT1dZCcwe5SkmfThai0QP
        bZs9J17PmwnFIg8q8QFl8LdIagV0T18nh7f40dogZWzerRGl9+pAPSWF2boVIsHR
        wCayBcLBqHgfv1J1iTXjBErzpHWGKU+bLtQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zFR7FOiIumJ2 for <linux-pci@vger.kernel.org>;
        Wed, 15 Feb 2023 04:18:50 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGxvF0vlzz1RvLy;
        Wed, 15 Feb 2023 04:18:48 -0800 (PST)
Message-ID: <077adda6-ef9f-5c31-c041-97342317f1d2@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 21:18:48 +0900
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
 <Y+zDUmwj8+ibp3r0@kroah.com>
 <e71ad0dc-2250-7ffc-6d96-745e2da40694@opensource.wdc.com>
 <Y+zJqp9cXelKro6t@kroah.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y+zJqp9cXelKro6t@kroah.com>
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

On 2/15/23 21:01, Greg Kroah-Hartman wrote:
> On Wed, Feb 15, 2023 at 08:45:50PM +0900, Damien Le Moal wrote:
>> On 2/15/23 20:34, Greg Kroah-Hartman wrote:
>>> On Wed, Feb 15, 2023 at 12:21:50PM +0900, Damien Le Moal wrote:
>>>> Make the pci-epf-test driver more verbose with dynamic debug messages
>>>> using dev_dbg(). Also add some dev_err() error messages to help
>>>> troubleshoot issues.
>>>>
>>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>>> ---
>>>>  drivers/pci/endpoint/functions/pci-epf-test.c | 69 +++++++++++++++----
>>>>  1 file changed, 56 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>>>> index f630393e8208..9b791f4a7ffb 100644
>>>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>>>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>>>> @@ -330,6 +330,10 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test, bool use_dma)
>>>>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>>>>  	volatile struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>>>
>>> note, volatile is almost always wrong, please fix that up.
>>
>> OK. Will think of something else.
> 
> If this is io memory, use the proper accessors to access it.  If it is
> not io memory, then why is it marked volatile at all?

This is a PCI bar memory. So I can simply copy the structure locally with
memcpy_fromio() and memcpy_toio().

> 
> thanks,
> 
> greg k-h

-- 
Damien Le Moal
Western Digital Research

