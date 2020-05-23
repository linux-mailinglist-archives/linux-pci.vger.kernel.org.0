Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A811DF3CF
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 03:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbgEWBYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 21:24:37 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43044 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387418AbgEWBYg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 21:24:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04N1ONZY122215;
        Fri, 22 May 2020 20:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590197063;
        bh=pc8GIbCeCGbGW+dH6N5QrFkDMQ4GvXVFsG0XIqTPplo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SbAjIaifncOFx0ks4RCylrSqylUM8uq5BtAEVysnNa8NfHN5GiBNQJorE0g1OGQ3p
         pmaMHRW9HJCbTSl4SmMy9Ki20mrlSActRpo4rGLeAH3w9bQ+5nDX5+8Lc80msM6hP8
         r3cU/dryBNsrwcNdMMMKBwWzFOn6xUlo1werTWXY=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04N1ON1l064608
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 20:24:23 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 May 2020 20:24:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 May 2020 20:24:22 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04N1OJgZ108060;
        Fri, 22 May 2020 20:24:20 -0500
Subject: Re: [PATCH v4 07/14] PCI: cadence: Add new *ops* for CPU addr fixup
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        PCI <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200506151429.12255-1-kishon@ti.com>
 <20200506151429.12255-8-kishon@ti.com> <20200520213434.GA583923@bogus>
 <3f9cf6e5-94f8-4c54-aaee-c181b0e79f1f@ti.com>
 <CAL_Jsq+qcgKvauJ-GjsnmmpmRusyEJ6pRDpBOQKOadig4XfsxQ@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <44690fec-0b65-0192-75f7-e4fa086c4c0b@ti.com>
Date:   Sat, 23 May 2020 06:54:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+qcgKvauJ-GjsnmmpmRusyEJ6pRDpBOQKOadig4XfsxQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 5/22/2020 10:15 PM, Rob Herring wrote:
> On Thu, May 21, 2020 at 5:35 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Rob,
>>
>> On 5/21/2020 3:04 AM, Rob Herring wrote:
>>> On Wed, May 06, 2020 at 08:44:22PM +0530, Kishon Vijay Abraham I wrote:
>>>> Cadence driver uses "mem" memory resource to obtain the offset of
>>>> configuration space address region, memory space address region and
>>>> message space address region. The obtained offset is used to program
>>>> the Address Translation Unit (ATU). However certain platforms like TI's
>>>> J721E SoC require the absolute address to be programmed in the ATU and not
>>>> just the offset.
>>>
>>> Once again, Cadence host binding is broken (or at least the example is).
>>> The 'mem' region shouldn't even exist. It is overlapping the config
>>> space and 'ranges':
>>>
>>>             reg = <0x0 0xfb000000  0x0 0x01000000>,
>>>                   <0x0 0x41000000  0x0 0x00001000>,
>>>                   <0x0 0x40000000  0x0 0x04000000>;
>>>             reg-names = "reg", "cfg", "mem";
>>>
>>>             ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
>>>                      <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
>>>
>>>
>>> 16M of registers looks a bit odd. I guess it doesn't matter
>>> unless you have a 32-bit platform and care about your virtual
>>> space. Probably should have been 3 regions for LM, RP, and AT looking
>>> at the driver.
>>
>> The "mem" region in never ioremapped. However $patch removes requiring to add
>> "mem" memory resource.
> 
> I was referring to ioremapping 'reg' region.
> 
>>>
>>> Whatever outbound address translation you need should be based on
>>> 'ranges'.
>>
>> You mean we don't need to add "new *ops* for CPU addr fixup"?. The issue is
>> ranges provides CPU address and PCI address. The CPU will access whatever is
>> populated in ranges to access the PCI bus. However while programming the ATU,
>> we cannot use the CPU address provided in ranges directly (in some platforms)
>> because the controller does not see the full address and only the lower 28bits.
> 
> Okay, that is clearer as to what the difference is. I think this
> should be 2 patches. One dropping 'mem' usage and using a mask and the
> 2nd making the mask per platform.

hmm okay.
> 
> Really, the parent node of the PCI controller should probably have
> 'ranges' and you could extract a mask from that. Looks like that is
> what you had for DRA7... I'm not sure if ABI stability is important
> for the Cadence platform. I'd assume that's just some IP eval system
> and probably not?

Right TI's J721E should be the first HW platform to use Cadence in mainline.
> 
> Why do you need an ops here? All you need is a mask value.

So how do we get platform specific mask? Use a different binding to specify the
mask value?
> 
>> This similar restriction was there with Designware (mostly an integration
>> issue) and we used *ops* to fixup the address that has to be programmed in ATU.
>> The Designware initially used a wrapper so that ranges property can be directly
>> used [1]. However this approach was later removed in [2]
>>
>> [1] -> https://lore.kernel.org/patchwork/patch/468523/
>> [2] -> https://lkml.org/lkml/2015/10/16/232
> 
> So while you had the data for a mask in DT, the driver now hardcodes it?

Yes, that's correct. Which approach should we use for Cadence?

Thanks
Kishon
