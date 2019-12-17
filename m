Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C63EC1232D1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 17:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfLQQpi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 11:45:38 -0500
Received: from mx2a.mailbox.org ([80.241.60.219]:64397 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbfLQQpi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 11:45:38 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 941A4A2179;
        Tue, 17 Dec 2019 17:45:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id YCmfwSKYFigj; Tue, 17 Dec 2019 17:45:32 +0100 (CET)
Subject: Re: PCIe hotplug resource issues with PEX switch (NVMe disks) on AMD
 Epyc system
To:     Keith Busch <kbusch@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
References: <20191216233759.GA249123@google.com>
 <8a0d7768-55f1-c1c8-1507-04e977184a67@denx.de>
 <20191217163046.GA2029@redsun51.ssa.fujisawa.hgst.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <d972b50b-64ff-ae5b-bdff-81ce7fa0fc8f@denx.de>
Date:   Tue, 17 Dec 2019 17:45:30 +0100
MIME-Version: 1.0
In-Reply-To: <20191217163046.GA2029@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17.12.19 17:30, Keith Busch wrote:
> On Tue, Dec 17, 2019 at 02:54:06PM +0100, Stefan Roese wrote:
>> On 17.12.19 00:37, Bjorn Helgaas wrote:
>>>     - Boot with all four PLX slots occupied by NVMe devices.  The BIOS
>>>       may assign space to accommodate them all.  If it does, you should
>>>       be able to hot-remove and add devices after boot.
>>
>> Unfortunately, that's not an option. We need to be able to boot with
>> e.g. one NVMe device and hot-plug one or more devices later.
> 
> That was also my suggestion, but not necessarily as a "solution". It's
> just to see if it works, which might indicate what the kernel could do
> differently.

I see, thanks. Right now, I don't have enough NVMe devices available to
do such a test. I'll add it to my list for tests that should be done
though.

Thanks,
Stefan
