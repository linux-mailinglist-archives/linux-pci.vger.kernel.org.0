Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD82697A19
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 11:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjBOKmL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 05:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbjBOKmK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 05:42:10 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0435537B46
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 02:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676457726; x=1707993726;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bYOeNaHyaVrirbdon1Wxef62nvktUzAM/kkBHGbdOTg=;
  b=Y+P27HcUShuy//RutdzX50pV6jPW6U9g3WTSndEoo7VoMTFQPcbId1VB
   jgfewZ/kLfF8dchSjvRyCgRUGC5WUnbhos2L5NnddfGvlNZrAfzc5IsUV
   TtPoE3HtYsSjwIN5cS1z+ZVrPLDJekWqt13AJ7NjTzBqGfdc93NYFLPYX
   FtkOpZYZnb5TeuVQl/tebWph29RthYMl5P1zX/xcP2A0wRigI57qsSSZl
   9/OTQfCSTREaz0vmtf4WqgWfRpTshuyErsbtttdyGDkl5OjWOKz32erYb
   bpAAlszZz6nwZCv4ME6sXYe7E9gNuoi4dpV7Fo/0pFCgBv78OZbwqhZ7G
   A==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="228332146"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 18:42:05 +0800
IronPort-SDR: l6E5PIcJ7yLEuf0wfAG9IFDxgl7MiYU+/Mh4EIlcQjhbUn0khouRP9c/35LqMRrQFyYZI8mNxa
 oz5EgFQLpPrECbjr6A/CAGRrlBupw5gssKyPpoa+zoQy+UIWOJWopasnc7ZnXRu3Uy3pw4Jb3l
 S0IpKbjP70pAsHRZAwhtB3RCpG5ZBceVCWmLpMSp46+VKxNUfOf2ek3LK43rkRXSBu3v2OLfUa
 dYQAktbP9xDqxuTbzvU2y2DwSVYU9qsy6K4+451cOJlGxv+vuVAdwXWSvpeAXTAJ9+I16GDUKe
 beM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 01:53:27 -0800
IronPort-SDR: v4MaULS9n+hNbVHrDV0zXH3CPJTicQtE24EcDjMvh90CQoqi8CSY4kuT39qjLAqVcyUfpf2tQ1
 drp9eMcPwfuabsH+nuaovM2Ey9DZhpk7av5YQlNcO3EGCQtyx0bWZA4iyAxwm/ZcQbNhPcb4li
 BqYnzLTCsGBPdZrHkVFTQbOaJeYwBcsnOtxfaPONOLH8ySqnyci1fAH1xloVVZy2KivTsq/NtI
 65Pg0PoJHBoE4leO/NdSgwFdZiIhmhTTii/pKfvCpbBP4zOILu9BZxs8NWfm3VsOI4k8QNhmHR
 X5M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 02:42:06 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGvld29VMz1RvTr
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 02:42:05 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676457723; x=1679049724; bh=bYOeNaHyaVrirbdon1Wxef62nvktUzAM/kk
        BHGbdOTg=; b=ON0F5Q+U0+QUO1m86MIM9DQ+JEo1a4jPVOzjn2HAs3UFHdAcLAf
        o4KQbxqw0O85vE3RBMc65JsQa/sedcCwupRT57p3GhDI/IC4MGt2FMyjiQlNWa/u
        sZXhXUga6EWCiuWpPzu6tBCM+4Pv61gIvrGMj9BywTXz9v+ozRvuzt8/H6trmUB6
        hOkHQiQYeyWLU5jrKd0RblnJWtINh6I2uiU/Lw36/ctdbumiHMUUDJXALMZF8AR3
        KGAokSFa0Mpc8W4hB0gDma+uGUexGFZbCZhw0Eqe0g2BcyodtSvs0yxYt4o+FUn2
        TMpa8PWVJ5TgBYgPFZoUd8CFrMWuEN2tKGg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ffXpmVBNzsyW for <linux-pci@vger.kernel.org>;
        Wed, 15 Feb 2023 02:42:03 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGvlW6T6dz1RvLy;
        Wed, 15 Feb 2023 02:41:59 -0800 (PST)
Message-ID: <b0219543-dec3-dfa2-8bba-93e4bc32eee2@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 19:41:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/9] PCI: rockchip: Fix RK3399 PCIe endpoint controller
 driver
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
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <7b8a8d38-feef-d2af-f23f-6b2b46f78110@opensource.wdc.com>
 <CAAEEuhrzysR-xfx7X-gVqUdi17R1YiWxyBM+0asQxtyZ9PQozg@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAAEEuhrzysR-xfx7X-gVqUdi17R1YiWxyBM+0asQxtyZ9PQozg@mail.gmail.com>
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

On 2/15/23 19:28, Rick Wertenbroek wrote:
> On Wed, Feb 15, 2023 at 2:51 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> Note about that: with your series applied, nothing was working for me on
>> my pine Rockpro64 board (AMD Ryzen host). I got weird/unstable behavior
>> and the host IOMMU screaming about IO page faults due to the endpoint
>> doing weird pci accesses. Running the host with IOMMU on really helps in
>> debugging this stuff :)
> 
> Thank you for testing, I have also tested with a Ryzen host, I have IOMMU
> enabled as well.
> 
>>
>> With the few fixes to your series I commented about, things started to
>> work better, but still very unstable. More debugging and I found out that
>> the pci-epf-test drivers, both host and endpoint sides, have nasty
>> problems that lead to reporting failures when things are actually working,
>> or outright dummy things being done that trigger errors (e.g. bad DMA
>> synchronization triggers IOMMU page faults reports). I have a dozen fix
>> patches for these drivers. Will clean them up and post ASAP.
>>
>> With the test drivers fixed + the fixes to your series, I have the
>> pci_test.sh tests passing 100% of the time, repeatedly (in a loop). All solid.
>>
> 
> Good to hear that it now works, I'll try them as well.
> 
>> However, I am still seeing issues with my ongoing work with a NVMe
>> endpoint driver function: I see everything working when the host BIOS
>> pokes at the NVMe "drive" it sees (all good, that is normal), but once
>> Linux nvme driver probe kicks in, IRQs are essentially dead: the nvme
>> driver does not see anything strange and allocates IRQs (1 first, which
>> ends up being INTX, then multiple MSI one for each completion queue), but
>> on the endpoint side, attempting to raise MSI or INTX IRQs result in error
>> as the rockchip-ep driver sees both INTX and MSI as disabled. No clue what
>> is going on. I suspect that a pci reset may have happened and corrupted
>> the core configuration. However, the EPC/EPF infrastructure does not
>> catch/process PCI resets as far as I can tell. That may be the issue.
>> I do not see this issue with the epf test driver, because I suspect the
>> host BIOS not knowing anything about that device, it does not touch it.
>> This all may depend on the host & BIOS. Not sure. Need to try with
>> different hosts. Just FYI :)
>>
> 
> Interesting that you are working on this, I started to patch the RK3399 PCIe
> endpoint controller driver for a similar project, I want to run our NVMe
> firmware in a Linux PCIe endpoint function.
> 
> For the IRQs there are two things that come to mind:
> 1) The host driver could actually disable them and work in polling mode,
> I have seen that with different versions of the Linux kernel NVMe driver
> sometimes it would choose to use polling instead of IRQs for the queues.
> So maybe it's just the
> 2) The RK3399 PCIe endpoint controller is said to be able only to generate
> one type of interrupt at a given time. "It is capable of generating MSI or
> Legacy interrupt if the PCIe is configured as EP. Notes that one PCIe
> component can't generate both types of interrupts. It is either one or the
> other." (see TRM 17.5.9 Interrupt Support).
> I don't know exactly what the TRM means the the controller cannot
> use both interrupts at the same time, but this might be a path to explore

The host says that both INTX is enabled and MSI disabled when the nvme driver
starts probing. That driver starts probe with a single vector to enable the
device first and use the admin SQ/CQ for indentify etc. Then, that IRQ is freed
and multiple MSI vectors allocated, one for each admin + IO queue pair.
The problem is that on the endpoint, the driver says that both INTX and MSI are
disabled but the host at least sees INTX enabled, and the first IRQ allocated
for the probe enables MSI and gets one vector. But that MSI enable is not seen
by the EP, and the EP also says that INTX is disabled, contrary to what the host
says.

When the BIOS probe the drive, both INTX and MSI are OK. Only one IRQ is used by
the BIOS and I tried both by setting & disabling MSI. What I think happens is
that there may be a PCI reset/FLR or something similar, and that screws up the
core config... I do not have a PCI bus analyzer, so hard to debug :)

I did hack both the host nvme driver and EP driver to print PCI link status etc,
but I do not see anything strange there. Furthermore, the BAR accesses and admin
SQ/CQ commands and cqe exchange is working as I get the identify commands from
the host and the host sees the cqe, but after a timeout as it never receives any
IRQ... I would like to try testing without the BIOS touching the EP nvme
controller. But not sure how to do that. Probably should ignore the first CC.EN
enable event I see, which is from the BIOS.

-- 
Damien Le Moal
Western Digital Research

