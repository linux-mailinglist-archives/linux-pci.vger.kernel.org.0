Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C19453CC5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 00:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhKPXoC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 18:44:02 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:31981 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKPXoC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 18:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637106064; x=1668642064;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ev+2wVhbaz0dqm95xJZP6RcPucLU+FM+XzatSFIxj7Y=;
  b=WzCr8uZotrYCipidNK/8ijzBW5bUD/zUyUF4eSrLWboCEbrqj8G6pSx6
   LMBF3HYfPp8zwe1JsyOX9z5aztgArYZ20vnbtlqwL1koGJW5aq6za53d/
   w/vzZ9M0BN/KZXdRF5ADm5/Pr9ENIbft1+6W531227TkdKWSVMw1GsFsq
   eNpwh/QnNHWQc26vB+APns528k//c+m6tG5zJN4XSmQZXB33zbmcbCqmD
   7ud8fph/Vbeoqza+ajd5RQ2nXetNViQbHL0QEOxVOpXue7U33FZ5G1/z5
   lz2qLO2TVlerEh11ZuaD5vIgdJSATDaUoySuVeOXEfpTqnvmcu5gFIG0Z
   g==;
X-IronPort-AV: E=Sophos;i="5.87,239,1631548800"; 
   d="scan'208";a="297603733"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2021 07:41:02 +0800
IronPort-SDR: OeJgKer5h8Z7Zh5q1ksci0ONreV/kHcyHcYMtHv1sxnLzPh8S256rhnoZ5B1awBXZtQpILPbA1
 DIKdjjXwgeOX7UoAfv2veMfS8CoL7lgbDJeCsWbSshuoTauAdaX0SQlnAb+WRf8IGUgo3Xw5Bb
 lyX+shVRb77DNUGspbwW/Jp4/NYi81IbkRxGs5y+44snXhK2HZIyMqXjXKux7IjsLPaFELFAMg
 aZaRyF+CmGllVkctYFmABslWaAF6vGhACf+aiR4Wl/of3HqbPMpSmo4Uxk9H3TQGszhWqjYnxc
 QX6aSOsCuFkH2WZ+d3BKRSQD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 15:14:32 -0800
IronPort-SDR: 5bk229e4J0bIv9XwMOHICAFXb6DHN/je6/xQZUw+TGtgBQa6Wy8NMAHrNHVWgTjHY+hD0FvTwp
 Rg1a93YCft0aWvFY5LnpOgYd7xKJiuwPC6iqC/rjjlKwCU85vZKkk2tQVqchqMgviYhgQQwwqq
 etzxcGeTv2Ni6Tn9Mit0Qmu061PwEIh6FqfuqD0dLeWxZINm+t7TZcfWqV6Fg45v37UoDnjdPq
 2BZmY3Zm2ruAalIrLHmoqZbsdNOdEnBbVbviMAltj35om3dpxVmDjBh+s9m8kPpCaMtxe4FsOQ
 URM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 15:41:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hv2ct20wDz1RtVw
        for <linux-pci@vger.kernel.org>; Tue, 16 Nov 2021 15:41:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637106061; x=1639698062; bh=ev+2wVhbaz0dqm95xJZP6RcPucLU+FM+Xza
        tSFIxj7Y=; b=gt+4qiE3oNsiI5gIqzNhGTpKbPVTCMvJPX6KZ94nPTuvLk4aFj5
        87FlemEX3MtkdCukf0AKNPbZxMFAbAxi8Cr08wTSTqlAfYXxk+8siKI/wowsTMfe
        C3kwxKl4ozBV8LCORYvbxooIkxwYFpUG4P95eHGoi++pWA0qeoBNGPq5vu7ignZt
        uz/qhdMrQD5ACluQR/QkRhxOThcvKD+D/HBnPRBF8MCB3YhhzIxIOuIDKijst8zq
        dtAgYYFUW3bIr1Oq3wuOrQpZmzlGsC92a+gqMZiRCzOBln1pxbHGp/BfvGJ4ev9l
        sUr3gehE16adH9Wt6ZZ4gO6/RpGXPA2yt/w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5lRa1fMeUZCZ for <linux-pci@vger.kernel.org>;
        Tue, 16 Nov 2021 15:41:01 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hv2cq69f8z1RtVl;
        Tue, 16 Nov 2021 15:40:59 -0800 (PST)
Message-ID: <26826c5d-2fa6-9719-be2a-5a22d1e9abc0@opensource.wdc.com>
Date:   Wed, 17 Nov 2021 08:40:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: Kernel 5.15 doesn't detect SATA drive on boot
Content-Language: en-US
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Yuji Nakao <contact@yujinakao.com>, linux-kernel@vger.kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        ". Bjorn Helgaas" <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
References: <87h7ccw9qc.fsf@yujinakao.com>
 <8951152e-12d7-0ebe-6f61-7d3de7ef28cb@opensource.wdc.com>
 <YZQ+GhRR+CPbQ5dX@rocinante>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <YZQ+GhRR+CPbQ5dX@rocinante>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/11/17 8:26, Krzysztof Wilczy=C5=84ski wrote:
> [+CC Arnd, Bjorn, Marc and Sasha for visibility]
>=20
> Hello Damien and Yuji,
>=20
> [...]
>>> I'm using Arch Linux on MacBook Air 2010. I updated `linux` package[1=
]
>>> from v5.14.16 to v5.15.2 the other day, and the boot process stalled
>>> with the following message.
>>>
>>> ```shell
>>> :: running early hook [udev]
>>> Starting version 249.6-3-arch
>>> :: running hook [udev]
>>> :: Triggering uevents...
>>> Waiting 10 seconds for device /dev/sda3 ...
>>> ERROR: device '/dev/sda3' not found. Skipping fsck.
>>> :: mounting '/dev/sda' on real root
>>> mount: /new_root: no filesystem type specified.
>>> You are now being dropped into an emergency shell.
>>> sh: can't access tty; job control turned off
>>> [rootfs ]#
>>> ```
>>>
>>> In the emergency shell there's no `sda` devices when I type `$ ls
>>> /dev/`. By downgrading the kernel, boot process works properly.
>>>
>>> See also Arch Linux bug tracker[2]. There are similar reports on
>>> Apple devices.
>>>
>>> `dmesg` output in the emergency shell is attached. I guess this issue=
 is
>>> related to libata, so CCed to Damien Le Moal.
>>
>> I think that this problem is due to recent PCI subsystem changes which=
 broke Mac
>> support. The problem show up as the interrupts not being delivered, wh=
ich in
>> turn result in the kernel assuming that the drive is not working (see =
the
>> timeout error messages in your dmesg output). Hence your boot drive de=
tection
>> fails and no rootfs to mount.
>>
>> Adding linux-pci list.
>>
>>
>>
>>>
>>> Regards.
>>>
>>> [1] https://archlinux.org/packages/core/x86_64/linux/
>>> [2] https://bugs.archlinux.org/task/72734
>=20

Krzysztof,

> The error in the dmesg output (see [2] where the log file is attached)
> looks similar to the problem reported a week or so ago, as per:
>=20
>   https://lore.kernel.org/linux-pci/ee3884db-da17-39e3-4010-bcc8f878e2f=
6@xenosoft.de/

Thanks. I searched this thread but could not find it in the archive.
Early morning, need more coffee :)

>=20
> The problematic commits where reverted by Bjorn and the Pull Request th=
at
> did it was accepted, as per:
>=20
>   https://lore.kernel.org/linux-pci/20211111195040.GA1345641@bhelgaas/
>=20
> Thus, this would made its way into 5.16-rc1, I suppose.  We might have =
to
> back-port this to the stable and long-term kernels.

Yes, I think the fix needs to go in 5.15, which is latest stable and LTS.

>=20
> Yuji, could you, if you have some time to spare, try the 5.16-rc1 to se=
e if
> this have gotten better on your system?
>=20
> 	Krzysztof
>=20


--=20
Damien Le Moal
Western Digital Research
