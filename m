Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C856BC1BB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 00:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjCOXtI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 19:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjCOXtG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 19:49:06 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30524EEA
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 16:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678924144; x=1710460144;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z82IAKEcAmktDzgYKj9zrOi91wL+I57ZqPEEFSJQ/xg=;
  b=Kpw1hsUYW9/hGop9HrfI9YeNz2i+uYZA2s0x6nfN/zw8OwTB+ND1ZHWo
   2u2IFFcMCXflym0hAi96jqP3S/2FoNRipuf7pgZtW6fSQC3USTq728Xpy
   aXJ+uNppqVM79f8ZguiKWLTE0MYmxVwYgFjsypK61va0rwIM1CUcTtQpw
   x6WXtMsYyZUsL57EbH4Nye8j6MoS9HcIRCLYVzspmedY0/X6fuyDV2dIW
   3EONBLELuSWxiDeyTdvDB50K0AvirAlQKAc65SIOw/4AZHs7Be/aJTGqa
   BXm9TUjr/ePJsZ51mUksUyrdUubeIWFubIv4NAJWSxqcB4/bC1GUUiGZX
   g==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="225729494"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2023 07:49:04 +0800
IronPort-SDR: LVk4sV+2wYi1M1tm06DAO202ewidi3BDbeZca3KXb5tUx3iXFzaeifAbp8uBqwZUsvKcvGBqvT
 sDcBJypqYl8o2b8Me2O1OBMhhiDrp6DEGgMwEUnk7jb5KkzyoTm9wM6hJonSHGmQj25WDGkdou
 4pQGwkKT7DbvepXS9AJzlGsdarff10xE1Rc1rxK4sc1bl9Yb32hrzGS1UIoi7YE+uBjtxAyeWy
 riyWqcF8z6/UR2KQt3+L/Q3ojUpJcHiXrzZId8wSHEWmvSDOvrm6jH3dqhqw1tr7C2/+oUbVdU
 RdE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 15:59:49 -0700
IronPort-SDR: gvTMCKjgiGtpzRQBHteCrKskjhT+S0KmjaoLdfJMqnU5tJPpS4OjVy4mTguLxd+cp02pcwRFdI
 POYfAFIypY9k3fy7jSVnN+/2LHVJQQEXacKAqR9x1iNXQMdtXrFg91hnAk4e+c2Kb6NfPzwUxg
 OM5qWa9BuUwMg+y2OAtgq7cUSO3En2gV1XBtNc4RQLsPAzHkBRJKEeWa1NiR5Fs/D78vwMcZHF
 JoI8f7laMPphQUaY2eHS5XyepGo3DuvO6GVUN6HxD3glkIgxXvikYOrTIgdnm/q29xt53fNwVX
 MCo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 16:49:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PcRtl6PJKz1RtW0
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 16:49:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678924142; x=1681516143; bh=z82IAKEcAmktDzgYKj9zrOi91wL+I57ZqPE
        EFSJQ/xg=; b=YizTg/WrkVNPPWotE/FS/nNsfL+Z6DOaNrChnkvE3ys/o+M9XUO
        fXYlJI963mgqG6NrCZh2Ml7T9OOrbJfBdwl3VyQD3zNWkQWHy+0m5IArVsG4hXbm
        8s+l2iE/EQpTUrKov85ln0Ki6J1L+K5f4HSLLWYRmE71xFAGoKV008SURZLJ4HOD
        TjA1bUdi2pVh5plfsp9czzF7YruFEdjZCWRASqeDoPq/63bvFvc6N68HJRmPs/Ro
        iqj4vMAgCcdvRcjLjiqDWxAxq6YwgkoHXpGXKvdAFsoHaH5FBa9iUxqEhJu+e5sa
        Ibs+qf4ha+g783Gx7Wzf1xQM7Aix3eWq+dA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MAwg4FZvIHtR for <linux-pci@vger.kernel.org>;
        Wed, 15 Mar 2023 16:49:02 -0700 (PDT)
Received: from [10.89.80.69] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.69])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PcRtj3h6Mz1RtVm;
        Wed, 15 Mar 2023 16:49:01 -0700 (PDT)
Message-ID: <2dd7930e-2411-69ee-b077-ebac78bfc3d1@opensource.wdc.com>
Date:   Thu, 16 Mar 2023 08:49:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 09/16] PCI: epf-test: Improve handling of command and
 status registers
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
 <20230308090313.1653-10-damien.lemoal@opensource.wdc.com>
 <20230315155119.GK98488@thinkpad>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230315155119.GK98488@thinkpad>
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

On 2023/03/16 0:51, Manivannan Sadhasivam wrote:
> On Wed, Mar 08, 2023 at 06:03:06PM +0900, Damien Le Moal wrote:
>> The pci-epf-test driver uses the test register bar memory directly
>> to get and execute a test registers set by the RC side and defined
>> using a struct pci_epf_test_reg. This direct use relies on a casts of
>> the register bar to get a pointer to a struct pci_epf_test_reg to
>> execute the test case and sending back the test result through the
>> status field of struct pci_epf_test_reg. In practice, the status field
>> is always updated before an interrupt is raised in
>> pci_epf_test_raise_irq(), to ensure that the RC side sees the updated
>> status when receiving the interrupts.
>>
>> However, such cast-based direct access does not ensure that changes to
>> the status register make it to memory, and so visible to the host,
>> before an interrupt is raised, thus potentially resulting in the RC host
>> not seeing the correct status result for a test.
>>
>> Avoid this potential problem by using READ_ONCE()/WRITE_ONCE() when
>> accessing the command and status fields of a pci_epf_test_reg structure.
>> This ensure that a test start (pci_epf_test_cmd_handler() function) and
>> completion (with the function pci_epf_test_raise_irq()) achive a correct
>> synchronization with the host side mmio register accesses.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index 43d623682850..e0cf8c2bf6db 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -615,9 +615,14 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>>  	struct pci_epf *epf = epf_test->epf;
>>  	struct device *dev = &epf->dev;
>>  	struct pci_epc *epc = epf->epc;
>> +	u32 status = reg->status | STATUS_IRQ_RAISED;
>>  	int count;
>>  
>> -	reg->status |= STATUS_IRQ_RAISED;
>> +	/*
>> +	 * Set the status before raising the IRQ to ensure that the host sees
>> +	 * the updated value when it gets the IRQ.
>> +	 */
>> +	WRITE_ONCE(reg->status, status);
> 
> For MMIO, it is not sufficient to use WRITE_ONCE() and expect that the write
> has reached the memory (it could be stored in a write buffer). If you really
> care about synchronization, then you should do a read back of the variable.

WRITE_ONCE() does an explicit cast to volatile. So unless the compiler is
seriously buggy, the value should make it to memory. Sure it could be in the CPU
cache, but given that this is memory allocated from dma coherent, I am not sure
that can happen. Or am I missing something ?

-- 
Damien Le Moal
Western Digital Research

