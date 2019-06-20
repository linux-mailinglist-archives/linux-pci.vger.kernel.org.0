Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 794204C503
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 03:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfFTBf3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 21:35:29 -0400
Received: from ale.deltatee.com ([207.54.116.67]:43330 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731137AbfFTBf3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 21:35:29 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hdlz0-0008Pl-8i; Wed, 19 Jun 2019 19:35:23 -0600
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <SL2P216MB018784C16CC1903DF2CEDCB880E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <a473bee0-0a25-64d5-bd29-1d5bdc43d027@deltatee.com>
 <SL2P216MB01875B40093190DBB6C4CBB780E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <89c6a6ee-46cc-4047-0093-30f07992e7e5@deltatee.com>
Date:   Wed, 19 Jun 2019 19:35:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <SL2P216MB01875B40093190DBB6C4CBB780E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: helgaas@kernel.org, linux-pci@vger.kernel.org, benh@kernel.crashing.org, nicholas.johnson-opensource@outlook.com.au
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_EXCLUSIVE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 4/4] PCI:
 Add pci=hpmemprefsize parameter to set MMIO_PREF size independently]
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-06-19 6:56 p.m., Nicholas Johnson wrote:
> On Wed, Jun 19, 2019 at 10:45:38AM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2019-06-19 8:01 a.m., Nicholas Johnson wrote:
>>> Hi Ben and Logan,
>>>
>>> It looks like my git send-email has been not working correctly since I
>>> started trying to get these patches accepted. I may have remedied this
>>> now, but I have seen that Logan tried to find these patches and failed.
>>> So as a courtesy until I post PATCH v7 (hopefully correctly, this time),
>>> I am forwarding you the patches. I hope you like them. I would love to 
>>> know of any concerns or questions you may have, and / or what happens if 
>>> you test them. Thanks and all the best!
>>>
>>> ----- Forwarded message from Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au> -----
>>>
>>> Date: Thu, 23 May 2019 06:29:28 +0800
>>> From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
>>> To: linux-kernel@vger.kernel.org
>>> Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mika.westerberg@linux.intel.com, corbet@lwn.net, Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
>>> Subject: [PATCH v6 4/4] PCI: Add pci=hpmemprefsize parameter to set MMIO_PREF size independently
>>> X-Mailer: git-send-email 2.19.1
>>>
>>> Add kernel parameter pci=hpmemprefsize=nn[KMG] to control MMIO_PREF size
>>> for PCI hotplug bridges.
>>
>> Makes sense.
>>
>>> Change behaviour of pci=hpmemsize=nn[KMG] to not set MMIO_PREF size if
>>> hpmempref has been specified, rather than controlling both MMIO and
>>> MMIO_PREF sizes unconditionally.
>>
>> I don't think I like that fact that hpmemsize behaves differently if
>> hpmempref size is specfied before it. I'd probably suggest having three
>> parameters: hpmemsize which sets both as it always has, a pref one and a
>> regular one which each set one of parameters.
> 
> It does not matter if hpmempref is specified before or after hpmemsize. 
> I made sure of that.

> Originally, I proposed to depreciate hpiosize, hpmemsize, and introduce: 
> hp_io_size, hp_mmio_size, hp_mmio_pref_size, each controlling its own 
> window exclusively.
> 
> The patch had the old parameters work with a warning, and if the new 
> ones were specified, they would override the old ones. Then, after a few 
> kernel releases, the old ones could be removed.

Well I don't like that either. No need to depreciate hpmemsize.

> Bjorn insisted that there be nil changes which break the existing 
> parameters, and the solution he requested was to leave hpmemsize to work 
> exactly the same (controlling both MMIO and MMIO_PREF), unless 
> hpmemprefsize is given, which will take control of MMIO_PREF from 
> hpmemsize.

I agree with Bjorn here too but my suggestion is to leave hpmemsize
alone and have it set both values as it has always done. And add two new
parameters to set one or the other. Then there's none of this "sets one
if the other one wasn't set". Also, if I only want to change the
non-preftechable version then your method leaves no way to do so without
setting the preftechable version.

Logan

