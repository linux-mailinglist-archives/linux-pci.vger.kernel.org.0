Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E6569881F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 23:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBOW4H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 17:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBOW4G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 17:56:06 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3C332E4E
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 14:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676501761; x=1708037761;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KF1wqmd9OiEM2NX23C6uB3mKF2sPSB06Bv3pX90M9tI=;
  b=XPJmT91lLDHJWd4E4d/FJGIZedfSACQnK0VMMMy62iqVNCLHxJjt4EaN
   UT+KgIJOQpKBOgvpfvKDiH+8rLgByfVcuyJg71rL0H0TUAzMVQXAIG9yx
   h2VsLHzGOJyPX9A8ESyUvNNcyiI1XSchr+mAteuCJXUXRRvgenPSr4xCy
   caO5eTnUTtVU+JeGfYdbsZ8jiNrSvTcvSanVjGlcXk0bYX/3IYLi7T/3I
   TDuwnBHkuV9vyAh0TYl9wjT1TggBXrkznt9A4R901yVZyKxkamsbxvcDV
   juHSzHrom/2mDyqFNYaAPjrG3TjbFjNqxyNPAogPRgV2eFg8PMpkU3wE7
   g==;
X-IronPort-AV: E=Sophos;i="5.97,300,1669046400"; 
   d="scan'208";a="327705522"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2023 06:55:58 +0800
IronPort-SDR: v6+c1YnFDaFjE+cHvYbd3Hj6xupQeQG3TgK1q5ISL+3hHywhpZsFQ2TdgAJCuvtYXEvYdL7scB
 IHZ1OfTW/CsZ4yxSnNuBf1dExQqNkKd214Twvj4rUkS54SurbdZChitVq4wrCV6fFgx6aGeeam
 30+b00DGfY14Oi2CDFzVfJSBwrW9O6FIZiGAZzIIXbXdUGMUnwFBeMnHqd7meggi1SuHkmX0We
 6xthF3y+GEvuow3i/lDYwEDRcHau+B/OjErMSc0qjlDYakSDQ6P+6G6seHDSVFiLIlhG5RPCwe
 d04=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 14:07:20 -0800
IronPort-SDR: t2/gXw3fGgNb7LmfC21lbFkqBZXYEnML7M5dxv/Qr70W1GKsg5eyw5Ue/7Cbgg7YMnamPnMU5b
 +ag65KQkIWcrQ5WrOJHutG8E+AuOAQqaG8ifhLYTmZoHfZUcnTKunB2Tvjh/k8hOeR6f2iv6Wm
 yPUE4n1S4W2haMyeQU2pZk4lq1+unW7l7cnB/JBP0T00fh33Z0zOdy9KWr0c9k2xPg7PEZD/ms
 eLClndX6zg2LPV5Y0iTiT4s2u1kcqtusdCFNhK3t8brMqI97BCPAwkekmnlbLVL771L4yrxlAA
 1Eo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 14:56:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PHD2Q51Cvz1Rwt8
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 14:55:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676501757; x=1679093758; bh=KF1wqmd9OiEM2NX23C6uB3mKF2sPSB06Bv3
        pX90M9tI=; b=V9ujQSIdnRndPGVlpYofrS1wENmCG9L+UhiffpHwKi8EkfhEX2/
        HN1d5DN/xZYFv5xg8gXZklFwHmdTwOyKZ/5YS8PgeFNXkYMVT14npVweC3xE1WWE
        VH6YgvNzyDpTw5ztKS8TmJ9Skww32SquZF3quD+8mR5Vv4trEb0uoKN2L+hU8idp
        iMoTEQeCH5+H6+OUUs+ZZwpLVqK393T8gVrZDwgFngWdrql231lmxJXuY+EkqiD+
        8Wb6wVYtMqoCQDAlYhs2ZXsSMb12Sy/ew7Mn8UA1Alb1woia9ESp4sxthCDsMlLX
        kGq/Vkyke8ZAYAlpHEMxVNIjBHn3nIZ81jA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8NlzfmrVazBv for <linux-pci@vger.kernel.org>;
        Wed, 15 Feb 2023 14:55:57 -0800 (PST)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PHD2N2Mzfz1RvLy;
        Wed, 15 Feb 2023 14:55:56 -0800 (PST)
Message-ID: <4801c7c0-4a35-14a3-ee62-d88f43ade8bd@opensource.wdc.com>
Date:   Thu, 16 Feb 2023 07:55:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 07/12] pci: epf-test: Add debug and error messages
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-8-damien.lemoal@opensource.wdc.com>
 <Y+zDUmwj8+ibp3r0@kroah.com>
 <e71ad0dc-2250-7ffc-6d96-745e2da40694@opensource.wdc.com>
 <Y+zJqp9cXelKro6t@kroah.com>
 <077adda6-ef9f-5c31-c041-97342317f1d2@opensource.wdc.com>
 <Y+zdD8G0NJIdiClo@kroah.com>
 <c49df2f9-9848-45aa-9d64-9e4e9841440f@app.fastmail.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c49df2f9-9848-45aa-9d64-9e4e9841440f@app.fastmail.com>
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

On 2/15/23 22:49, Arnd Bergmann wrote:
> On Wed, Feb 15, 2023, at 14:24, Greg Kroah-Hartman wrote:
>> On Wed, Feb 15, 2023 at 09:18:48PM +0900, Damien Le Moal wrote:
>>> On 2/15/23 21:01, Greg Kroah-Hartman wrote:
>>>>>>> @@ -330,6 +330,10 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test, bool use_dma)
>>>>>>>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>>>>>>>  	volatile struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>>>>>>
>>>>>> note, volatile is almost always wrong, please fix that up.
>>>>>
>>>>> OK. Will think of something else.
>>>>
>>>> If this is io memory, use the proper accessors to access it.  If it is
>>>> not io memory, then why is it marked volatile at all?
>>>
>>> This is a PCI bar memory. So I can simply copy the structure locally with
>>> memcpy_fromio() and memcpy_toio().
>>
>> Great, please do so instead of trying to access it directly like this,
>> which will break on some platforms.
> 
> I think the reverse is true here: looking at where the pointer comes
> from, 'reg' is actually the result of dma_alloc_coherent() in the
> memory of the local (endpoint) machine, though it appears as a BAR on
> the remote (host) side and gets mapped with ioremap() there.
> 
> This means that the host must use readl/write/memcpy_fromio/memcpy_toio
> to access the buffer, matching the __iomem token there, while the
> endpoint side not use those. On some machines, readl/write take
> arguments that are not compatible with normal pointers, and will
> do something completely different there.
> 
> A volatile access is not the worst option here, though this conflicts
> with the '__packed' annotation in the structure definition that
> may require bytewise access on architectures without unaligned
> access.
> 
> I would drop the __packed in the definition, possibly annotating
> only the 64-bit src_addr and dst_addr members as __packed to ensure
> the layout is unchanged but the structure as a whole is 32-bit
> aligned, and then use READ_ONCE()/WRITE_ONCE() to atomically
> access each member in the coherent buffer.

I guess that would work too. But given that there are accesses to individual
members all over the place, I think it would be easier to get a local copy of
the reg structure in pci_epf_test_cmd_handler() and pass a pointer of that local
copy to the pci_epf_test_xxx() functions. The only READ_ONCE() needed would be
to test the command field on entry to pci_epf_test_cmd_handler() to be sure that
we have a valid command.

The host side always sets the reg command field last, which I think kind of
assumes an ordered update on the EP side (all other fields set before the
command field). That does seem a bit fragile to me as my understanding is that
PCI does not necessarily guarantees ordering of IO TLPs. But I may be wrong here.

> If ordering between the accesses is required, you can add
> dma_rmb() and dma_wmb() barriers.

Which I guess is the one thing we need after testing the reg command field in
pci_epf_test_cmd_handler() and before making the local copy, to avoid problems
with ordering of the reg fields writes from the host.

Will use that in v2.


-- 
Damien Le Moal
Western Digital Research

