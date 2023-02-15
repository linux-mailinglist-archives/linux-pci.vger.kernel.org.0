Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ECB697961
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 11:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBOJ7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 04:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjBOJ7H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 04:59:07 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9573E367D2
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 01:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676455145; x=1707991145;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WTkXI4W+MKwwJycy7cbo2GbIsg58uAfo8wCSpFIsYak=;
  b=UF+/FMQMsurdzfQiniX6ug6A2JRH6FgxHOOap2yiLCblh65n5iR+MLpV
   CzprTqlthCRwEftV1diK/iga0PnqMST8ZHWI0Uzd6vGWWwxQjRT54Jt9k
   U17NpVjEkvykIMjwjDS+I7EjEk9aXZu6SE0OMhEWfPgn0VuVNYzI0zpss
   p3bwJ6vZZcdB0nmuMI+3uCiZ7bs+JHBlU9KboGWBNIxhCaC3XLTIUStro
   UUaZ6WHJCZiJ+ewfccE9pbVRupTIJdRVlzVKJH/zhxDPCNzsOrmwlFGKL
   8T8ZLq+d91EixtQaXGRIsOj72bfeRj9IVSDcVQwYLKuGHw3Y82cMHEpmV
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223377104"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 17:59:01 +0800
IronPort-SDR: OrQZemqyrw04Wt9C9I9aZpGvAhH/lrUP40yMAcP42v/OZ/CLPa/2KP/HOFP84iYHPwXfne1vey
 0UukmEeoxwe4zkr4KsKdjJ6W+rRd6IGyKKFWQF7LXW0AOLLJvvgNFztNN7AeH8U/TJcRpKf71i
 gekkYgZ9mX9P4NQGVAbvzIEjYIW0J2MNbeGT/AYHROA1AqaQ9Jl9B+YT1UYF+hxGcIDBD8rMG1
 tIPZYMGkWB5LcDz0UE9TZEQNKt3faZPbjlYLT6KF0lI+HmPwktEL8IHa4RkdqzxWFn9qCJOrOh
 6Hs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 01:10:24 -0800
IronPort-SDR: tOIKrYeC6fk7IAUk2VfenqiFfNI8CmUVmNm4S39B1zhTJQ+41De6lxldvc+pDX1aLrrVI4l5WT
 sGvNvMTkLJAaEGPjVUfWVKi+jn3Md0bhpek0eT89C8Qw1KZqm6N8l1/AHDOHoPUdx2UwNnJwgi
 +PVQ6dpEmA17Dsc4Y6o53K+lntYBNHVCYd7/2KmI7bT4XBzyGZjbQC9Ba/8dvxi1ecUvSpNC0l
 kiZVekPoLqkG1An8YGLPyvBC+GAmbVLywqaeiw5w48IAytpZNTyDx6bif/5s58NF5NIj93kCBU
 1dw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 01:59:03 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGtnx2122z1RvTp
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 01:59:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676455138; x=1679047139; bh=WTkXI4W+MKwwJycy7cbo2GbIsg58uAfo8wC
        SpFIsYak=; b=PJZxYfrKRw5XUinlQGXvfZTe3KKu/Pb7k6M6mo9VoygA9BCRL8P
        CmYgtrhmCbWSof5IaNZ8DvwAJRu850zMvm4dueIboWgQIeIVQqo+u+ewop3IsAy5
        ploWhU9Bc7LMDxcr81yCVuMSwVHJKNUGX0ZrbH74PLD3zRKzL+zI8kRNdsMIQrTu
        URdww+2DEp8ij+FlBh1R5nBEFaHBSznzLxr2nemsrLThWaXNzR+qhR6QREVJzz7g
        wl+oNtf2qJxgu97EvdrdKMkB0cC+XIFkBVkqvPbysEQci44SFwkFZF2lY7JImr/x
        vAQQmj3UVM2hyFEXoW1Bj06/3zk+hzfbIqA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i0GL9mok7ENI for <linux-pci@vger.kernel.org>;
        Wed, 15 Feb 2023 01:58:58 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGtnq2Qlbz1RvLy;
        Wed, 15 Feb 2023 01:58:55 -0800 (PST)
Message-ID: <559bdd8c-9cc8-d7ae-a937-ffee9cfbb8a6@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 18:58:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/9] PCI: rockchip: Remove writes to unused registers
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-2-rick.wertenbroek@gmail.com>
 <2ebd33e2-46ef-356d-ff4c-81b74950d02f@opensource.wdc.com>
 <CAAEEuhr273bKFBWiTVyTjhHhxjuTK=TVd+5K2B07WfWMD+N7mA@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAAEEuhr273bKFBWiTVyTjhHhxjuTK=TVd+5K2B07WfWMD+N7mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/15/23 18:04, Rick Wertenbroek wrote:
> On Wed, Feb 15, 2023 at 12:56 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> I checked the TRM and indeed these registers are listed as unused.
>> However, with this patch, nothing work for me using a Pine rockpro64
>> board. Keeping this patch, your series (modulo some other fixes, more
>> emails coming) is making things work !
> 
> Hello, Thank you for testing the driver and commenting, I'll incorporate your
> suggestions in the next version of this series.
> 
> This patch alone does not make the driver work. Without the fixes to the
> address windows and translation found in [PATCH v2 6/9] ("PCI: rockchip:
> Fix window mapping and address translation for endpoint") transfers will not
> work. However, as you said, with the patch series, the driver works.
> Good to see that you have the driver working on the rockpro64 which is a
> very similar but different board than the one I used (FriendlyElec NanoPC-T4).
> 
>> So I think the bug is with the TRM, not the code. THinking logically about
>> htis, it makes sense: this is programming the address translation unit to
>> translate mmio & dma between host PCI address and local CPU space address.
>> If we never set the PU address, how can that unit possibly ever translate
>> anything ?
> 
> No, the bug is not in the TRM:
> The RK3399 PCIe endpoint core has the physical address space of 64MB
> @ 0xF800'0000 to access the PCIe address space (TRM 17.5.4).
> This space is split into 33 windows, one of 32MBytes and 32 of 1MByte.
> Read-write accesses by the CPU to that region will be translated. Each
> window has a mapping that is configured through the ATR Configuration
> Register Address Map (TRM 17.6.8) and the registers addr0 and addr1
> will dictate the translation between the window (a physical CPU addr)
> into a PCI space address (with this the unit can translate). The other
> registers are for the PCIe header descriptor.
> The translation process is documented in TRM 17.5.5.1.1
> The core will translate all read-write accesses to the windows that fall
> in the 64MB space @ 0xF800'0000 and generate the PCIe addresses
> and headers according to the values in the registers in the ATR
> Configuration Register Address Map (@ 0xFDC0'0000).
> 
> Translation does indeed take place and works
> but requires the changes in [PATCH v2 6/9] ("PCI: rockchip:
> Fix window mapping and address translation for endpoint")
> because it was broken from the start...
> 
> The two writes that were removed are to unused (read-only) registers.
> The writes don't do anything, manually writing and reading back these
> addresses will always lead to 0 (they are read-only). So they are removed.

OK. Tested again and it is working-ish...

./pcitest.sh
## Loading pci_endpoint_test
## BAR tests
BAR0:		OKAY
BAR1:		OKAY
BAR2:		OKAY
BAR3:		OKAY
BAR4:		OKAY
BAR5:		OKAY

## Legacy interrupt tests
SET IRQ TYPE TO LEGACY:		OKAY
LEGACY IRQ:	OKAY

## MSI interrupt tests
SET IRQ TYPE TO MSI:		OKAY
MSI1:		OKAY
MSI2:		OKAY
MSI3:		OKAY
MSI4:		OKAY
MSI5:		OKAY
MSI6:		OKAY
MSI7:		OKAY
MSI8:		OKAY
MSI9:		OKAY
MSI10:		OKAY
MSI11:		OKAY
MSI12:		OKAY
MSI13:		OKAY
MSI14:		OKAY
MSI15:		OKAY
MSI16:		OKAY

## Read Tests (DMA)
READ (      1 bytes):		OKAY
READ (   1024 bytes):		OKAY
READ (   1025 bytes):		OKAY
READ (   4096 bytes):		OKAY
READ ( 131072 bytes):		OKAY
READ (1024000 bytes):		OKAY
READ (1024001 bytes):		OKAY
READ (1048576 bytes):		OKAY

## Write Tests (DMA)
WRITE (      1 bytes):		OKAY
WRITE (   1024 bytes):		OKAY
WRITE (   1025 bytes):		OKAY
WRITE (   4096 bytes):		OKAY
WRITE ( 131072 bytes):		OKAY
WRITE (1024000 bytes):		OKAY

Then stops here doing the 1024001 B case. The host waits for a completion that
does not come. On the EP side, I see:

[   94.307215] pci_epf_test pci_epf_test.0: READ src addr 0xffd00000, 1024001 B
[   94.307960] pci_epc fd000000.pcie-ep: Map region 1 phys addr 0xfa100000 to
pci addr 0xffd00000, 1024001 B
[   94.308924] rockchip-pcie-ep fd000000.pcie-ep: Set atu: region 1, cpu addr
0xfa100000, pci addr 0xffd00000, 1024001 B
[  132.309645] dma-pl330 ff6e0000.dma-controller: Reset Channel-2
CS-20000e FTC-40000

                                                  ^^^^^^^^^^^^^^^
The DMA engine does not like something at all. Back to where I was when I tried
your series initially, which is why I tried removing patch 1 to see what happens...

[  132.370479] pci_epf_test pci_epf_test.0: READ => Size: 1024001 B, DMA: YES,
Time: 38.059623935 s, Rate: 26 KB/s
[  132.372152] pci_epc fd000000.pcie-ep: Unmap region 1
[  132.372780] pci_epf_test pci_epf_test.0: RAISE MSI IRQ 1
[  132.373312] rockchip-pcie-ep fd000000.pcie-ep: Send MSI IRQ 1
[  132.373844] rockchip-pcie-ep fd000000.pcie-ep: MSI disabled
[  132.374388] pci_epf_test pci_epf_test.0: Raise IRQ failed -22

And it looks like the PCI core crashed or something because MSI does not work
anymore as well (note that this is wheat I see with my nvme epf driver too, but
I do not have that DMA channel reset message...)

If I run the tests without DMA (mmio only), everything seems fine:

## Read Tests (No DMA)
READ (      1 bytes):		OKAY
READ (   1024 bytes):		OKAY
READ (   1025 bytes):		OKAY
READ (1024000 bytes):		OKAY
READ (1024001 bytes):		OKAY

## Write Tests (No DMA)
WRITE (      1 bytes):		OKAY
WRITE (   1024 bytes):		OKAY
WRITE (   1025 bytes):		OKAY
WRITE (1024000 bytes):		OKAY
WRITE (1024001 bytes):		OKAY

## Copy Tests (No DMA)
COPY (      1 bytes):		OKAY
COPY (   1024 bytes):		OKAY
COPY (   1025 bytes):		OKAY
COPY (1024000 bytes):		OKAY
COPY (1024001 bytes):		OKAY

So it looks like translation is working with your patch, but that the driver is
still missing something for DMA to work correctly...

Will keep digging.

Note that this is all tested with the patch series fixing pci-epf-test and
pci_endpoint_test drivers that I posted earlier today. As mentioned, my host is
an AMD Ryzen PC.

-- 
Damien Le Moal
Western Digital Research

