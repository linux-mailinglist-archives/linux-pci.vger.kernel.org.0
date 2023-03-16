Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CB96BDB64
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 23:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCPWLS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 18:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCPWLI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 18:11:08 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2FD4DBD0
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 15:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679004638; x=1710540638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BwhFewWBTGHcR2L3lWIABhEO48EgoTHYXLzjzl/RGDE=;
  b=CF6gWvowlQF8yZjiMpISDl3LpXv+xaBGRET/9SmikbL7sEf1np/kRT5H
   gbXXvA3w5xqkxqT00xjXvSsVc22nkUdAkqajko5sX/wf31tqB/pefBaYu
   tjEyaj4V1s+2KsmybMxvIby2RYWjAFrTOb6WEpRXYMsOQDhMmeuhwqxa4
   rrCvBReeKVKP3DARP7PwxB+1A4mZupU06pCHhvDM7ib+Xuymo0EW9oRS4
   MsMA1FmB08Xw9rO0wO+QhOUNyIPvyZndewoJ8VFhE9hkgn6l2QhOowB/k
   ii72BI10pmFCTG5WnkLVH1iMOx35yah7B49+nplQZlZFn2Lo6aFJSgvDx
   w==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673884800"; 
   d="scan'208";a="337850930"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2023 06:09:10 +0800
IronPort-SDR: XQbIvj7Uk1b9cOOHVaSGo+cWQc/uK8NPk6H62UJVteWUnLjbSSLhJpmnXEinY+X1Ff7X4hBnzG
 Lr5IHQRDwXmIM18vaQr1LmiTAe+OcngMK3Hcyp8Qtjgw243yjm7ZLDkmIAuAhP4Ob0zdUelFt4
 HOZfZqto6s+olR8wMGLd2+R0pGw9uBuGzll0zicmH39w7kYWJ+vj2kJ7+JsgCdC7+hcZSxWcjv
 mpaemGA9yTVnv8ydrZbDp48Sgjv/RrMYGT3zWcutB5qezRkqkMahAGn3oiTygptvbhDkigjsp8
 WgA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Mar 2023 14:25:35 -0700
IronPort-SDR: Hog8+1jzGNDasrOOSDUMk2TsiLmr/SZIun4Uaj/vw0xhxGbhTPLrcbCD2tfspzIMlgNknlZyDT
 k7FM1p9BHaOXEjig30ORCPMJcCZJU6+ilqJOGTFFyXqUOuOmFuDsUvi0/nWYBcIvj2CfpJYjU8
 AEfoYYRI2f1onPQQgBpAnTAeHa2ybObIwCC5zZi6GGdBnN3szqlGiGRq9zm+k9VuiNn38GUYsf
 5uSaUJRA42Pp53LEtb0cKVxJTL+zrnoxZUUKDyS3jqLKFmvAUv4t8S/SB20zaqxXuOvjj3DKtr
 ZLQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Mar 2023 15:09:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pd1d23WZbz1RtVq
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 15:09:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679004549; x=1681596550; bh=BwhFewWBTGHcR2L3lWIABhEO48EgoTHYXLz
        jzl/RGDE=; b=VTvMSOt1n+xg5pbYHSTNHomXjUGmowXAasyPPtvTRHlgOelErZJ
        TGhjpcBC1h2GltIkCHIJf3t9kTAKCbnzUHGkgPF/gBZ+FYJ9vLBswyjaiNBpvIxM
        3oeiImJn/VVeXIsOwH6eyzbk4RoLbw2k8AaryDznQyD6aapbK2iDTFu3aIbJcWv4
        D20kAgaw2yiZoJf8dhyHtNBcMew0ve5Qn31/2eNV73xbrqHIieI7Ohqz4yLEuHiL
        78mMGJ2RJWmWscjVLS7uK6r3gfnKWZEhm7+Ai1qeJs5c4x0Mkw75nYAzXW6DnKuX
        JuSobZVuicvUIjxZwQbF3X6I38yPAoap6QQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MHdcxccbZaG2 for <linux-pci@vger.kernel.org>;
        Thu, 16 Mar 2023 15:09:09 -0700 (PDT)
Received: from [10.225.163.88] (unknown [10.225.163.88])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pd1cx56X6z1RtVm;
        Thu, 16 Mar 2023 15:09:05 -0700 (PDT)
Message-ID: <15208569-b3d7-b9f7-6676-9d9122cac84a@opensource.wdc.com>
Date:   Fri, 17 Mar 2023 07:09:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/9] PCI: rockchip: Fix RK3399 PCIe endpoint controller
 driver
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
 <ecd09f27-b799-4741-2c5a-a2de99776c51@opensource.wdc.com>
 <CAAEEuhrk4cSC312UiAL3UwoDZ=urrdDcBThcNHd1dqnAuJTzAw@mail.gmail.com>
 <3c4ed614-f088-928f-2807-deaa5e4b668a@opensource.wdc.com>
 <CAAEEuhqk0scWd3wFbVb9fSgHxPBKotpEPNi+YPG4GD9vLO94mw@mail.gmail.com>
 <8392a7de-666a-bce6-dc9f-b60d6dd93013@opensource.wdc.com>
 <1e8184e9-7e0b-2598-cc5a-e46d6c2f152a@opensource.wdc.com>
 <CAAEEuhoB2LqL=B_BQ0X2T-E+Yt83kPUiv-R9dgU0O-f22ukcWg@mail.gmail.com>
 <CAAEEuhp5WTkaPDRLa8frc9Sc43A3HwApW647v-E9Bse6p5Df5Q@mail.gmail.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAAEEuhp5WTkaPDRLa8frc9Sc43A3HwApW647v-E9Bse6p5Df5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/17/23 01:34, Rick Wertenbroek wrote:
>>> By the way, enabling the interrupts to see the error notifications, I do see a
>>> lot of retry timeout and other recoverable errors. So the issues I am seeing
>>> could be due to my PCI cable setup that is not ideal (bad signal, ground loops,
>>> ... ?). Not sure. I do not have a PCI analyzer handy :)
> 
> I have enabled the IRQs and messages thanks to your patches but I don't get
> messages from the IRQs (it seems no IRQs are fired). My PCIe link seems stable.
> The main issue I face is still that after a random amount of time, the BARs are
> reset to 0, I don't have a PCIe analyzer so I cannot chase config space TLPs
> (e.g., host writing the BAR values to the config header), but I don't think that
> the problem comes from a TLP issued from the host. (it might be).

Hmmm... I am getting lots of IRQs, especially the ones signaling "replay timer
timed out" and "replay timer rolled over after 4 transmissions of the same TLP"
but also some "phy error detected on receive side"... Need to try to rework my
cable setup I guess.

As for the BARs being reset to 0, I have not checked, but it may be why I see
things not working after some inactivity. Will check that. We may be seeing the
same regarding that.

> I don't think it's a buffer overflow / out-of-bounds access by kernel
> code for two reasons
> 1) The values in the config space around the BARs is coherent and unchanged
> 2) The bars are reset to 0 and not a random value
> 
> I suspect a hardware reset of those registers issued internally in the
> PCIe controller,
> I don't know why (it might be a link related event or power state
> related event).
> 
> I have also experienced very slow behavior with the PCI endpoint test driver,
> e.g., pcitest -w 1024 -d would take tens of seconds to complete. It seems to
> come from LCRC errors, when I check the "LCRC Error count register"
> @0xFD90'0214 I can see it drastically increase between two calls of pcitest
> (when I mean drastically it means by 6607 (0x19CF) for example).
> 
> The "ECC Correctable Error Count Register" @0xFD90'0218 reads 0 though.
> 
> I have tried to shorten the cabling by removing one of the PCIe extenders, that
> didn't change the issues much.
> 
> Any ideas as to why I see a large number of TLPs with LCRC errors in them ?
> Do you experience the same ? What are your values in 0xFD90'0214 when
> running e.g., pcitest -w 1024 -d (note: you can reset the counter by writing
> 0xFFFF to it in case it reaches the maximum value of 0xFFFF).

I have not checked. But I will look at these counters to see what I have there.


-- 
Damien Le Moal
Western Digital Research

