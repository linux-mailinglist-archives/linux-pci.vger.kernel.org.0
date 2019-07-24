Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E5D73308
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 17:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfGXPsX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 11:48:23 -0400
Received: from ale.deltatee.com ([207.54.116.67]:43298 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfGXPsX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jul 2019 11:48:23 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqJV7-000564-B7; Wed, 24 Jul 2019 09:48:22 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <SL2P216MB01878BBCD75F21D882AEEA2880C60@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20190724133814.GA194025@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c016b0b3-6e76-625d-e603-65ddb1286cf6@deltatee.com>
Date:   Wed, 24 Jul 2019 09:48:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724133814.GA194025@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com, benh@kernel.crashing.org, nicholas.johnson-opensource@outlook.com.au, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: Possible PCI Regression Linux 5.3-rc1
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-07-24 7:38 a.m., Bjorn Helgaas wrote:
> On Wed, Jul 24, 2019 at 12:54:00PM +0000, Nicholas Johnson wrote:
>> Hi all,
>>
>> I was just rebasing my patches for linux 5.3-rc1 and noticed a possible 
>> regression that shows on both of my machines. It is also reproducible 
>> with the unmodified Ubuntu mainline kernel, downloadable at [1].
>>
>> Running the lspci command takes 1-3 seconds with 5.3-rc1 (rather than an 
>> imperceivable amount of time). Booting with pci.dyndbg does not reveal 
>> why.
>>
>> $ uname -r
>> 5.3.0-050300rc1-generic
>> $ time lspci -vt 1>/dev/null
>>
>> real	0m2.321s
>> user	0m0.026s
>> sys	0m0.000s
>>
>> If none of you are aware of this or what is causing it, I will submit a 
>> bug report to Bugzilla.
> 
> I wasn't aware of this; thanks for reporting it!  I wasn't able to
> reproduce this in qemu.  Can you play with "strace -r lspci -vt" and
> the like?  Maybe try "lspci -n" to see if it's related to looking up
> the names?
I also just tested 5.3-rc1 on my machine and lspci behaves normally.

Logan
