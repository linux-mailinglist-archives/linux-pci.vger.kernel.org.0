Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25C73A4437
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 16:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhFKOlL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 10:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhFKOlJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jun 2021 10:41:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5600C061574;
        Fri, 11 Jun 2021 07:38:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h1so2951386plt.1;
        Fri, 11 Jun 2021 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8lYrWaWj8rXB/t2XiDxhDEhaWgsjpf7zHZODYkct5sY=;
        b=oYN9j5Z/Cjd7h021FHyj8wxm8sPCqMSSKS+PshjShNgbATg0/a07QGcEO+TPGy/BcR
         dnNfXLSH/p4J2eBZ+C+EYOutekG4GiJnzsTZlAC/JVREJkDwI3wosR299n4LQHLuMLDt
         7OoIXY+s15J2V/G7504nJ5oNitQNa5eY+LE9cLIEpGhcByotkmlCjHibHFGGDoSQKyTT
         rE6KhxFyg68jWlm+L8EcaAZvxic+wLcjXY3fbgYvWa4cC95z3jJL1pFM6tvm8Jm175wl
         TW9GEu3grV0id3YJEBP4pqcDDcHDpTk/oxs6KLuFEvj8pxcnWT+xPktjhaEtHzixxSiz
         F8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=8lYrWaWj8rXB/t2XiDxhDEhaWgsjpf7zHZODYkct5sY=;
        b=melMc5ISQnPn0qk+YLUwQhpp5BHRFAgyRDXjB9CpJsvaqHOpuFL9l+9mKgiDBbRn/3
         JcDLeTcByzcOWEAkbzrSbHAbmHSSMozbDeRiegQD+UQKIAqGKAsChevt7wFtLai0pVGf
         mfXZKDlGpb/cwPWjXs+oIryzj6W/8Vt2KGPEOMmeNo4U+mOJpO7VUbQy1jqm+mndC8um
         QgvU3r0yQvWEr+rXwXx8xF46Nqzl/fjFDY7p/Sz8p9wWuKlcTPsxEDr/jh5c+foc2Yru
         ZEU6IS/KU7CPnfMpD4Jyh63KaJWAdDpc7KmsIEdzbht2PfCzpue8IHJE7WSYMcY4cy8g
         P9Zg==
X-Gm-Message-State: AOAM5328Pcz0Us3kuvD4LUIJvqUinbsWstSUu8ov/7MVILRpp4CoADmg
        hrfnaj12ozGYm0vqd+29Zo0=
X-Google-Smtp-Source: ABdhPJwaPJKGmSKoSUrGQKKB1LbnTDaqRXUIvShM3eoRuGHjdDT+qfmx817r+169+oLLB8OLjcRTHQ==
X-Received: by 2002:a17:90a:6002:: with SMTP id y2mr9656377pji.197.1623422334188;
        Fri, 11 Jun 2021 07:38:54 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id fy16sm10572998pjb.49.2021.06.11.07.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:38:53 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     helgaas@kernel.org, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com
Subject: Re: [PATCH v3 4/4] arm64: dts: rockchip: Update PCI host bridge
 window to 32-bit address memory
References: <20210607112856.3499682-1-punitagrawal@gmail.com>
        <20210607112856.3499682-5-punitagrawal@gmail.com>
        <3105233.izSxrag8PF@diego>
Date:   Fri, 11 Jun 2021 23:38:50 +0900
In-Reply-To: <3105233.izSxrag8PF@diego> ("Heiko =?utf-8?Q?St=C3=BCbner=22'?=
 =?utf-8?Q?s?= message of "Thu, 10
        Jun 2021 23:50:40 +0200")
Message-ID: <87r1h8ihz9.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Heiko,

Heiko St=C3=BCbner <heiko@sntech.de> writes:

> Hi,
>
> Am Montag, 7. Juni 2021, 13:28:56 CEST schrieb Punit Agrawal:
>> The PCIe host bridge on RK3399 advertises a single 64-bit memory
>> address range even though it lies entirely below 4GB.
>>=20
>> Previously the OF PCI range parser treated 64-bit ranges more
>> leniently (i.e., as 32-bit), but since commit 9d57e61bf723 ("of/pci:
>> Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses")
>> the code takes a stricter view and treats the ranges as advertised in
>> the device tree (i.e, as 64-bit).
>>=20
>> The change in behaviour causes failure when allocating bus addresses
>> to devices connected behind a PCI-to-PCI bridge that require
>> non-prefetchable memory ranges. The allocation failure was observed
>> for certain Samsung NVMe drives connected to RockPro64 boards.
>>=20
>> Update the host bridge window attributes to treat it as 32-bit address
>> memory. This fixes the allocation failure observed since commit
>> 9d57e61bf723.
>>=20
>> Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm=
.com
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
>> Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Rob Herring <robh+dt@kernel.org>
>
> just for clarity, should I just pick this patch separately for 5.13-rc to
> make it easy for people using current kernel devicetrees, or should
> this wait for the update mentioned in the cover-letter response
> and should go all together through the PCI tree?

The device tree change is independent of the other patches in the
series. It would be great if you can pick this one - I am waiting on
feedback from Rob before sending an update on the remaining patches.

Thanks,
Punit

> If so, I can provide an
> Acked-by: Heiko Stuebner <heiko@sntech.de>
>
>
>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/=
dts/rockchip/rk3399.dtsi
>> index 634a91af8e83..4b854eb21f72 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -227,7 +227,7 @@ pcie0: pcie@f8000000 {
>>  		       <&pcie_phy 2>, <&pcie_phy 3>;
>>  		phy-names =3D "pcie-phy-0", "pcie-phy-1",
>>  			    "pcie-phy-2", "pcie-phy-3";
>> -		ranges =3D <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x1e00000>,
>> +		ranges =3D <0x82000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x1e00000>,
>>  			 <0x81000000 0x0 0xfbe00000 0x0 0xfbe00000 0x0 0x100000>;
>>  		resets =3D <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
>>  			 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>,
>>=20
>
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
