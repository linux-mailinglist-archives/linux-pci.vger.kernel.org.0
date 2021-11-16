Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4CF453C89
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 00:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhKPXI0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 18:08:26 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38217 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhKPXIY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 18:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637103927; x=1668639927;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Lfc3GEcBsLhSnyg1tnguuBnuE2boC1l87fOb7QPFVqw=;
  b=UNuCGre1nJUzyRlhFxuKdmmk27UOxq1TXgJ1Z9ZX1VDtFPwCQ28PFOV/
   0L7x5QDz8UD94gsUhXYaVfmLIi0L/eo+ub0vodHoKXbo3+YH/2BzxbFW5
   crieJH62nIwfkA2F9WHZVzN/3fCRkXW7D34SsgDVAYkCcvRK4IVwzHi8P
   ZL3Sr9Z7ybkrh4TSzZ8yO1XldSWR4GAdKQy9HcMTxeBbveAdcN5N2+U1g
   DJA9jUWME6OVQ90CwSqc8g5hBm1QFhMgkaE9q/9ShPAjJxSQQqAGyIgBr
   tc8Zptqo7CuQ24k/e31WntBBhzUg+c/74H5/4VV9xVISx7mBURicjFQY2
   w==;
X-IronPort-AV: E=Sophos;i="5.87,239,1631548800"; 
   d="scan'208";a="186781793"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2021 07:05:25 +0800
IronPort-SDR: g1rPJuqZUMfx69NB74K4l+jJjkf1xOKA9C9wi9hxCvuTqrF2pliDH4FHFq9pgSrKWzYaIqulB2
 AXsrRhM/0zlMwF99yWIixgeIw1sFSPyGaYrCoFp9HwDRgRE+Eokk3d5fnZ6DVyM8LO7PNr3oa1
 2TfNJklrFgKUjM/JecpguWBZpaV2kK9jmPwXwfRUYP6ciAetDkvA5fN9oBaou8LlQZGpBMyKGn
 zrevFPPHkB3+iUmhgVhnC3efOeyM8CNy6TtE59BkOlItuZH89g/l3q0RDmxkxHWwe8hZd+4Sco
 i2vanxS8w0OPHB8TOiY84VpX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 14:40:27 -0800
IronPort-SDR: J7MFcigbXdIGAuHCgFS0N02ynv3eI1C6IWSAWtJAfwTPFunVRGHRaQBkBLwP/XfHnOzuGSjG5B
 W2IiozXPS/7VU0QIa6pYh+YzMPU1ADxsL38MUuSgO3sioj5Sy85WF9HJvCuSckzJo0W/i0p8ZU
 xD7/FnQ93n3V7jETbYF28Qe6hxTFAtCLEM+VzSEjXq1757gI7bpFgMi8ce8H8bEKc7Aoh39HCS
 mI7vqLznXeTx/+v99Ru3ckQGfAWZ0zupKuz7pJ8pJ/EP/7IZFmR6Mim9kFJrT8GeTAytKu0uXS
 dhE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 15:05:25 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hv1qm3XcZz1RtVp
        for <linux-pci@vger.kernel.org>; Tue, 16 Nov 2021 15:05:24 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637103923; x=1639695924; bh=Lfc3GEcBsLhSnyg1tnguuBnuE2boC1l87fO
        b7QPFVqw=; b=RO4whdX0QeutVQCVMw3sjYtpoPQvwR0WAf5yQIj3Z7A26H74KXn
        E56hPiU7rGjOwREsQPC0qeDxElRzfibc6z2j0G+zum5KyU26XdRw0rZJktQrV2Je
        UszDOf9MT4O0fjZhEmM3YcuW2qCqmGvyJAawjGjxRdB4svyMUWHlM7JVd2DIcXDT
        RcIdxhYhXJO1AyZXR9athPK3EH/ktrSxJfgeNQE/dpyw5vDyqexpuEJ3Dk/5Ghvc
        00A1Bz5hvPG8ikvvxky1Pn4UA4TTXESgLCN0uIM9Nxe26Cb4+E6i5Cl5maFrxGse
        f0QGJ2B9gbaprlqGBILLmTc8A/Z3YGbe4Xg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4CBwAUAymeRH for <linux-pci@vger.kernel.org>;
        Tue, 16 Nov 2021 15:05:23 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hv1qk5qLrz1RtVl;
        Tue, 16 Nov 2021 15:05:22 -0800 (PST)
Message-ID: <8951152e-12d7-0ebe-6f61-7d3de7ef28cb@opensource.wdc.com>
Date:   Wed, 17 Nov 2021 08:05:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: Kernel 5.15 doesn't detect SATA drive on boot
Content-Language: en-US
To:     Yuji Nakao <contact@yujinakao.com>, linux-kernel@vger.kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <87h7ccw9qc.fsf@yujinakao.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <87h7ccw9qc.fsf@yujinakao.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/11/16 21:44, Yuji Nakao wrote:
> Hello,
> 
> I'm using Arch Linux on MacBook Air 2010. I updated `linux` package[1]
> from v5.14.16 to v5.15.2 the other day, and the boot process stalled
> with the following message.
> 
> ```shell
> :: running early hook [udev]
> Starting version 249.6-3-arch
> :: running hook [udev]
> :: Triggering uevents...
> Waiting 10 seconds for device /dev/sda3 ...
> ERROR: device '/dev/sda3' not found. Skipping fsck.
> :: mounting '/dev/sda' on real root
> mount: /new_root: no filesystem type specified.
> You are now being dropped into an emergency shell.
> sh: can't access tty; job control turned off
> [rootfs ]#
> ```
> 
> In the emergency shell there's no `sda` devices when I type `$ ls
> /dev/`. By downgrading the kernel, boot process works properly.
> 
> See also Arch Linux bug tracker[2]. There are similar reports on
> Apple devices.
> 
> `dmesg` output in the emergency shell is attached. I guess this issue is
> related to libata, so CCed to Damien Le Moal.

I think that this problem is due to recent PCI subsystem changes which broke Mac
support. The problem show up as the interrupts not being delivered, which in
turn result in the kernel assuming that the drive is not working (see the
timeout error messages in your dmesg output). Hence your boot drive detection
fails and no rootfs to mount.

Adding linux-pci list.



> 
> Regards.
> 
> [1] https://archlinux.org/packages/core/x86_64/linux/
> [2] https://bugs.archlinux.org/task/72734
> 
> 


-- 
Damien Le Moal
Western Digital Research
