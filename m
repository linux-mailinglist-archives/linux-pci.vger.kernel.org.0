Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B0F697B03
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 12:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjBOLp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 06:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjBOLp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 06:45:58 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B06E93F0
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 03:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676461557; x=1707997557;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ni04Ra4MpV2J7lj6/LI9yPegRO0UsE2L6oTUZwJ9UCk=;
  b=e8iStgGowRrSsiG3hcsuwSKYfGoBvUxaC8DsFdyYW5uRt4R0zTJMMwdV
   tFDivCU0h9upQIgox14xVGXRSHLklp2lA70uQvHUfrjrn8WkZ8RrgOA5x
   5UAXXEUWbIBmM1+VxO8R8xN62G7QcAt4IdDTD0XCLQY5veaL2+BXJg05C
   E1ItebqzJgCcZ8h8O+L8w/QwsGfez0e6aoIn3gCgPNToId/4RoApfJHYK
   NOe3l7WqYlJ45MgdGsMVHejCpACagd4bQUNAGcC7vpu7VcoFLy+Im3nbM
   zgX96dCyusfsB06FPrIENyIVumWJ5WZvrB2ya/Gc0rTLM+giPHFq2c01m
   A==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="228336397"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 19:45:54 +0800
IronPort-SDR: b8yNVGojLWZ3Q/s1BrHsrkl0KK6dlbc0rX2UbBe+s0OOgo6WUpogOvOTC2HeEJIGSbwmoFPKn/
 FcLr1pZUFUIooCqj+bzKGqYnRm9f2bpZfNFS3/ouQEm0MzW7rSyeD3hiXnRTpCij60Oj5ikAlN
 oTahuhQVFVhoKD9h/0u8yd7Ta3PUYFzyeVfjaVK8TBU7b6VVgsdjZloh+La306TKFL0nHxXbsk
 dsqMd4K1KaXEVHjLfAPwroafKdVe0asWrgLd2YQBgrtgdVtApNg4bAa7+wKp5yLgbtWisu1u4D
 wF0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 02:57:15 -0800
IronPort-SDR: g+Ud1uRpbqECaJcgtPokXblw6eiCUt1qnWPFLAkXOVlKuCasNKRwM548ybEORYEQrqBwRYlWD8
 IePDWiPm4NGcKOMAVK5kXWO0fqgPaOB8Qym5rY7rYu6VbceKlcWGrInvWpzF2yJ2y5QNS4dSJm
 Yn7G/njHKO4WP+0cc1feNEbUwEgK33LHwjJpau9V9//N27SShv6rm1/iBco1ykKFom+OSBBiFE
 gZazm/IwbwLRs5AUCPpc+SfO5cvvJQmH1UJV7BlecXADkTOSq1wxkLxXGSQLHzEjDqv2+QXYKs
 9oc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 03:45:54 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGx9F2jPHz1Rwrq
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 03:45:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676461552; x=1679053553; bh=ni04Ra4MpV2J7lj6/LI9yPegRO0UsE2L6oT
        UZwJ9UCk=; b=Pe+H0vkc+pxJUmH5kyePSSPm+dVMGqnK0YycxaFfP/TP24Gk0AM
        K9/924EDXFuLPIG3KqkesFT1L0iesy7ugc8j063yKt0ILXWbgYk1kFhCw7bV/tDH
        mH8wetCKP9LAlRAvJqhYWD0EvJPdmsnWmM8SJrp1lWxMIRP/YBrlrXQrhjm3uSzv
        u9n/YF6RQQxfnX9nzz2Lb2KFFbOEQtNdE4urasKhNalttMXN5PxS67jtqH4vSG2p
        cPItOBl0zKPmqzytz4rEWBXUEGzifAnr5NE+WClw32XikIk2UZc/svxgF9CBAhY+
        DA5ydaXsSaWzj7D5UpUMkdCvrNj3fSmvKCw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DcN607-BPdRL for <linux-pci@vger.kernel.org>;
        Wed, 15 Feb 2023 03:45:52 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGx9C3M7jz1RvLy;
        Wed, 15 Feb 2023 03:45:51 -0800 (PST)
Message-ID: <e71ad0dc-2250-7ffc-6d96-745e2da40694@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 20:45:50 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y+zDUmwj8+ibp3r0@kroah.com>
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
> 
> note, volatile is almost always wrong, please fix that up.

OK. Will think of something else.
Thanks for the feedback.

-- 
Damien Le Moal
Western Digital Research

