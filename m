Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21ADDD64F1
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 16:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbfJNOSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 10:18:32 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:40576 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732362AbfJNOSc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Oct 2019 10:18:32 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iK1B7-0001sz-0w; Mon, 14 Oct 2019 16:18:29 +0200
To:     Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v3] PCI: aardvark: Use LTSSM state to build link  training flag
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Oct 2019 15:18:28 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Ellie Reeves <ellierevves@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <20191014140026.GB1426@voidbox>
References: <20190522213351.21366-3-repk@triplefau.lt>
 <20190930154017.GF42880@e119886-lin.cambridge.arm.com>
 <20190930165230.GA12568@voidbox>
 <20191001080546.GI42880@e119886-lin.cambridge.arm.com>
 <20191013113415.3c653526@why>
 <20191014100129.GA18832@e121166-lin.cambridge.arm.com>
 <20191014130627.GA1426@voidbox>
 <eda65141ee1006fe3a93a9989867dc31@www.loen.fr>
 <20191014140026.GB1426@voidbox>
Message-ID: <971be151d24312cc533989a64bd454b4@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: repk@triplefau.lt, lorenzo.pieralisi@arm.com, andrew.murray@arm.com, ellierevves@gmail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org, thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-10-14 15:00, Remi Pommarel wrote:
> On Mon, Oct 14, 2019 at 02:45:34PM +0100, Marc Zyngier wrote:
>> Hi Remi,
>>
>> On 2019-10-14 14:06, Remi Pommarel wrote:
>> > Hi Lorenzo, Marc,

[...]

>> > Sure, I think this could be considered a fix for the following 
>> commit :
>> > Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI
>> > bridge config space")
>> >
>> > Moreover, Marc, I am also a bit supprised that you did not have to 
>> use
>> > [1] to even be able to boot.
>>
>> No, I don't have that one, and yet the system boots fine (although 
>> PCI
>> doesn't get much use on this box). I guess I'm lucky...
>>
>> > Also if you want to be completely immune to this kind of SError 
>> (that
>> > could theoretically happen if the link goes down for other reasons 
>> than
>> > being retrained) you would have to use mainline ATF along with 
>> [2]. But
>> > the chances to hit that are low (could only happen in case of link
>> > errors).
>>
>> Now you've got me worried. Can you point me to that ATF patch? I'm 
>> quite
>> curious as to how you recover from an SError on a v8.0 CPU given 
>> that it
>> has no syndrome information and may as well signal "CPU on fire!"...
>>
>
> The patch is at [1]. Please note that this is done quite similarly 
> for
> rcar.
>
> [1] 
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/1541

That patch, without any other information, looks quite flaky. Unless 
there
is a strong guarantee that ESR_EL3.ISS==2 only when the PCIe controller
goes wrong, it looks like this only papers over the issue...

That's pretty much independent from the patch at hand in this thread, 
but
I certainly wouldn't trust this ATF patch without some more information
about how the fault is reported to the CPU.

         M.
-- 
Jazz is not dead. It just smells funny...
