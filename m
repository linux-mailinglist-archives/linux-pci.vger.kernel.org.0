Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6F811D5F4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 19:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbfLLSkN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Dec 2019 13:40:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34294 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbfLLSkM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2019 13:40:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id f4so4227773wmj.1;
        Thu, 12 Dec 2019 10:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=ELZT1joVEPSh2plOVJR94cvRAmXkAN48Ob21zMz/OVM=;
        b=dirYmOdYRFH9YSrQHN3w5+hlzPxhx6EdRDD3GLC7fKCSVNVIkDSS/CY0kqJvAtQMQ9
         oKY515H+6HkSxdtjjPLkvYD/5I1zNFPB5wEIIua+yPT22Zse5z1HAfcu3Oy5E+hNCaBj
         yGneDXCXLBGRGv+id2MDIAj5em/RMVUc62LATdIddiekTzwJuUaE8+FFFA1xWhb7Fucp
         GXKOJefJeJ5ic7YPAcGuGjVUg8DN4eS8Lwp9HyZlCFhakvoIfg5XvOi1vrXpap2M3Jdz
         BfSUrhKowVfm9lg8M2vgXgdMZfYlb8EFuXGXUx4n+emO0gCSjVyWCydUngE5fsGN9auf
         Ltlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=ELZT1joVEPSh2plOVJR94cvRAmXkAN48Ob21zMz/OVM=;
        b=uCav6kt3aSNlhZMo1XGGy+PrteBW7QZEkKyK9IFYQWBlSdunmBM0QbaEwxQ///f7Si
         SmllSYfEn90qBrHv5ithcRLkUnblrAI8V2FJhGyJWXjsy1gmKquGwp40bpHlsM1WyDtZ
         OiKKt7LZgJUh7qzeZUVMMpdKeKlUJK4JoSefDsXP2WUm9vrRSLHPNntqZAyc+dMiYmt2
         /AsKPi8Bo7ZJZdlsCr+c0HOeedd4VfGNdWkpCoQoTIEoDciStgHSt3ghRBn1S9QeKH52
         CIgPtY9/8xlsFMIAbCx/nSsHRTgjGk+ZgFQJimwp9tgkkP8V07wmqD0TD+7F/LhKGPPP
         ylhw==
X-Gm-Message-State: APjAAAU/hOUfW8dt8WK2J66HiCQo8bLsa2rZebTUUG4rqiaC7Xvb7gNc
        Rb61oeZfRFUGlFqWYV+jNfw=
X-Google-Smtp-Source: APXvYqx0ctM4a47vgtrL3oOacmEM5P15vEIdZYWM3IaprzO2CQaZEe5R3g+5uLTgNWYG7GNBMyJ5sw==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr8290286wmj.106.1576176010334;
        Thu, 12 Dec 2019 10:40:10 -0800 (PST)
Received: from localhost ([5.59.90.131])
        by smtp.gmail.com with ESMTPSA id a1sm6973925wrr.80.2019.12.12.10.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 10:40:09 -0800 (PST)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Frederick Lawler <fred@fredlawl.com>,
        <linux-pci@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?iso-8859-1?Q?Stefan_M=E4tje?= <stefan.maetje@esd.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [REGRESSION] PCI v5.5-rc1 breaks google kevin
Date:   Thu, 12 Dec 2019 19:40:06 +0100
MIME-Version: 1.0
Message-ID: <792cf6ab-26c4-40a4-90b0-a99e620548f4@gmail.com>
In-Reply-To: <CAFqH_50pJVQT3uqtpVgqn4ijfdPMzHoE1ns_KARH+_cKe+3NRg@mail.gmail.com>
References: <58ce5534-64bd-4b4b-bd60-ed4e0c71b20f@gmail.com>
 <166f0016-7061-be5c-660d-0499f74e8697@arm.com>
 <20191212005254.GE24359@e119886-lin.cambridge.arm.com>
 <CAFqH_50pJVQT3uqtpVgqn4ijfdPMzHoE1ns_KARH+_cKe+3NRg@mail.gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday, December 12, 2019 3:16:25 PM CET, Enric Balletbo Serra wrote:
> Hi Vicente,
>
> Missatge de Andrew Murray <andrew.murray@arm.com> del dia dj., 12 de
> des. 2019 a les 1:53:
>>=20
>> On Thu, Dec 12, 2019 at 12:12:56AM +0000, Robin Murphy wrote:
>>> Hi Vicente,
>>>=20
>>> On 2019-12-11 11:38 pm, Vicente Bergas wrote:
>>>> Hi,
>>>> since v5.5-rc1 the google kevin chromebook does not boot.
>>>> Git bisect reports 5e0c21c75e8c PCI/ASPM: Remove pcie_aspm_enabled()
>>>> unnecessary locking
>>>> as the first bad commit.
>>>>=20
>>>> In order to revert it from v5.5-rc1 i had to also revert=20
>>>> some dependencies:
>>>> 5e0c21c75e8c08375a69710527e4a921b897cb7e
>>>> aff5d0552da4055da3faa27ee4252e48bb1f5821
>>>> 35efea32b26f9aacc99bf07e0d2cdfba2028b099
>>>> 687aaf386aeb551130f31705ce40d1341047a936
>>>> 72ea91afbfb08619696ccde610ee4d0d29cf4a1d
>>>> 87e90283c94c76ee11d379ab5a0973382bbd0baf
>>>> After reverting all of this, still no luck.
>>>> So, either the results of git bisect are not to be trusted, or
>>>> there are more bad commits.
>>>>=20
>>>> By "does not boot" i mean that the display fails to start and
>>>> the display is the only output device, so debugging is quite difficult.
>>>=20
>
> Another issue that is affecting current mainline for kevin is fixed
> with [1]. As usual, I have a tracking branch for 5.5 for different
> Chromebooks with some not yet merged patches that makes things work
> while are not fixed [2]. For kevin only the mentioned ASoC patch [1]
> and the pcie fix [3] should be needed. Other than that display is
> working for me on Kevin.
>
> Cheers,
>  Enric
>
> [1]=20
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=
=3Dfor-5.5&id=3D4bf2e385aa59c2fae5f880aa25cfd2b470109093
> [2]=20
> https://gitlab.collabora.com/eballetbo/linux/commits/topic/chromeos/somewha=
t-stable-5.5
> [3]  https://lkml.org/lkml/2019/12/11/199
>
>>> Assuming it's a manifestation of the same PCI breakage that Enric and
>>> Lorenzo figured out, there's a proposed fix here:
>>> https://lkml.org/lkml/2019/12/11/199
>>=20
>> It's likely that any PCI driver that uses PCI IO with that controller will=

>> suffer the same fate.
>>=20
>> Vicente - can you try the patch that has been proposed and verify it fixes=

>> the issue for you?
>>=20
>> Thanks,
>>=20
>> Andrew Murray
>>=20
>>>=20
>>> Robin.
>>>=20
>>>> v5.5-rc1 as is (reverting no commits at all) works fine when=20
>>>> disabling PCI:
>>>> # CONFIG_PCI is not set
>>>>=20
>>>> Regards,
>>>>   Vicente.

Hi Robin, Andrew and Enric,
thank you all for the quick responses!
I can confirm that patch [3] fixes the issue reported in this email and
that [1] fixes the other issue reported on the other email.

Regards,
  Vicen=C3=A7.

