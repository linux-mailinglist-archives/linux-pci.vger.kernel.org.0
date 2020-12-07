Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F0E2D15D0
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 17:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgLGQSL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 11:18:11 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:56744 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgLGQSL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 11:18:11 -0500
Received: from [167.98.27.226] (helo=[172.16.102.109])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kmJCa-0002RR-Qd; Mon, 07 Dec 2020 16:17:28 +0000
Subject: Re: [PATCH] drivers: block: save return value of
 pci_find_capability() in u8
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20201207012600.GA2238381@bjorn-Precision-5520>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <30196321-bdb9-090a-66f1-9fbbb93772b9@codethink.co.uk>
Date:   Mon, 7 Dec 2020 16:17:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201207012600.GA2238381@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/12/2020 01:26, Bjorn Helgaas wrote:
> On Sun, Dec 06, 2020 at 11:08:14PM +0000, Chaitanya Kulkarni wrote:
>> On 12/6/20 11:45, Puranjay Mohan wrote:
>>> Callers of pci_find_capability should save the return value in u8.
>>> change type of variables from int to u8 to match the specification.the com
>>
>> I did not understand this, pci_find_capability() does not return u8.
>>
>> what is it that we are achieving by changing the variable type ?
>>
>> This patch will probably also generate type mismatch warning with
>>
>> certain static analyzers.
> 
> There's a patch pending via the PCI tree to change the return type to
> u8.  We can do one of:
> 
>    - Ignore this.  It only changes something on the stack, so no real
>      space saving and there's no problem assigning the u8 return value
>      to the "int".

I seem to remember some compilers would emit a sequence to constrain the
result to a valid char, but that looks like it is fixed in gcc-9 if the
input was also u8

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
