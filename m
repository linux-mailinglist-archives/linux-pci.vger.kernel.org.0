Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B754AA7BE
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 09:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiBEIwX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Feb 2022 03:52:23 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:36304 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232461AbiBEIwX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Feb 2022 03:52:23 -0500
Received: from [78.40.148.178] (helo=webmail.codethink.co.uk)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nGGnp-0005LZ-Ak; Sat, 05 Feb 2022 08:52:17 +0000
MIME-Version: 1.0
Date:   Sat, 05 Feb 2022 08:52:17 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] PCI: fu740: fix finding gpios
In-Reply-To: <20220204225308.GA225749@bhelgaas>
References: <20220204225308.GA225749@bhelgaas>
Message-ID: <90fdcc8b0b4e1b6cd9913923fcfb6415@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-02-04 22:53, Bjorn Helgaas wrote:
> Follow subject line convention (s/fix/Fix/, s/gpios/GPIOs/).
> 
> On Fri, Feb 04, 2022 at 05:38:21PM +0000, Ben Dooks wrote:
>> The calls to devm_gpiod_get_optional() have the -gpios on
>> the name. This means the pcie driver is not finding the
>> necessary reset or power gpios to allow the pcie devices
>> on the SiFive Unmatched boards.
>> 
>> Note, this was workng around 5.16 and may not have been
>> broken? There is still an issue if uboot has not probed
>> the pcie bus then there are no pcie devices shown when
>> Linux is started.
> 
> Wrap to fill 75 columns
> s/gpios/GPIOs/
> s/pcie/PCIe/
> s/workng/working/
> s/to allow the pcie devices/to allow the PCIe devices <to something>?/

Thank you, will reword this and re-post.

The note will be removed anyway as explained below.

> I can't tell what this is saying.  It used to work and something broke
> it?  If so, we should have a "Fixes:" tag to identify the commit that
> broke it.
> 
> Or it used to work and "may *not* have been broken"?  I'm confused.
> 
> Unclear how uboot is involved.

I wasn't until we finally tracked down and posted the issue about the
gen1 speed setting for bridge probing. All we knew is that the board
would work if you initialised the PCIe in u-boot, and otherwise would
not probe any peripherals. We have posted a patch for that and are
going to try and sort out what needs doing there.

The issue for the probe is here:
https://marc.info/?l=linux-pci&m=164399947722914&w=3

I also think this may never have worked given the issue above, there
are no clear commits that would break this and the driver has had
very little modification since being added. It may have been luck
that most people are booting from a PCIe device and have uboot start
the PCIe for them.

It is possible there may have been changes in the GPIO or GPIO-OF
handling, but again it may have been masked by uboot initialisaton.
Our boot logs suggest somewhere around 5.16 something changed that
stopped probes working. I will try and bisect down next week to see
if the kernel is at fault or some part of the test framework,
uboot changes or other issues.

>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>  drivers/pci/controller/dwc/pcie-fu740.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c 
>> b/drivers/pci/controller/dwc/pcie-fu740.c
>> index 00cde9a248b5..842b7202b96e 100644
>> --- a/drivers/pci/controller/dwc/pcie-fu740.c
>> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
>> @@ -259,11 +259,11 @@ static int fu740_pcie_probe(struct 
>> platform_device *pdev)
>>  		return PTR_ERR(afp->mgmt_base);
>> 
>>  	/* Fetch GPIOs */
>> -	afp->reset = devm_gpiod_get_optional(dev, "reset-gpios", 
>> GPIOD_OUT_LOW);
>> +	afp->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>>  	if (IS_ERR(afp->reset))
>>  		return dev_err_probe(dev, PTR_ERR(afp->reset), "unable to get 
>> reset-gpios\n");
>> 
>> -	afp->pwren = devm_gpiod_get_optional(dev, "pwren-gpios", 
>> GPIOD_OUT_LOW);
>> +	afp->pwren = devm_gpiod_get_optional(dev, "pwren", GPIOD_OUT_LOW);
>>  	if (IS_ERR(afp->pwren))
>>  		return dev_err_probe(dev, PTR_ERR(afp->pwren), "unable to get 
>> pwren-gpios\n");
>> 
>> --
>> 2.34.1
>> 
