Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D198E340CA7
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 19:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhCRSPK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 14:15:10 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:48037 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhCRSOr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 14:14:47 -0400
Received: from [192.168.1.155] ([77.4.36.33]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MvaSG-1lf2Vu0QxK-00sgMS; Thu, 18 Mar 2021 19:14:36 +0100
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com,
        alex.williamson@redhat.com
References: <20210317112309.nborigwfd26px2mj@archlinux>
 <YFHsW/1MF6ZSm8I2@unreal> <20210317131718.3uz7zxnvoofpunng@archlinux>
 <YFILEOQBOLgOy3cy@unreal> <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal> <20210318142252.fqi3das3mtct4yje@archlinux>
 <YFNqbJZo3wqhMc1S@unreal> <20210318170143.ustrbjaqdl644ozj@archlinux>
 <YFOPYs3IGaemTLMj@unreal> <20210318174344.yslqpfyct6ziwypd@archlinux>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Message-ID: <23c58c25-1c53-3777-4b45-415f0c6ec238@metux.net>
Date:   Thu, 18 Mar 2021 19:14:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318174344.yslqpfyct6ziwypd@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+EmNwhUa0ZpjK1PKFSyf4sQ9gV6depDkA4DS3HJpRwCCDZGW6NG
 yPKHizTZzMkG5ZW0mp7LpBd1J8FGbWDQSweytXU2YW6h5SLVz93IFpol2+oeJfb8LzD5yg0
 E9N7tq+IxOr7HCR4nLvsAodTYMiWNL8qwb+EJhInyAp/iSpgTu3x1P/WACXU5Pe1fAcC72B
 w+QCIYOJZAIZi1kFNudEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qzUEXzew1OU=:7om/sHv6mluQyk6xjv13xL
 EE5+8969u0D0besq41aQoG02vtnue1Py3xitOC+Y4toPl4DE/pxPY1ywp9KHww4DrC9VgM+Pm
 sNJSCfiezbspoTIKdSk28AAipdyO4xrg/O6Fibx7fShahNRv2fMs9FQ6G9+O4eo2CV3Ix7MNg
 e5eLHYSs3S30WC63YbTx0XYNgcy4PH/tySQAzjx58HUAQAuiIfYp40r1z2b+/9c/6IyEAXUbU
 VDrxjoi7/LYDjTvX4cCBJXzKu/tbVAnUmusgGqjdYS7FL2ADBnZJCm4n6bK9z83ETyUT1f7iv
 BvYceArBkUowTiDNo9D1fw6Y+BZhQ6yKgS7aduPmpEkoPMtrswEjMuKUgiZBusHMNEYHPHE7e
 SK9Pw0zMobpVYfK6TJTr4h4F2F38DHsXUfCPVrzFlNgDMEdhIHFqNkSPINurQ
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18.03.21 18:43, Amey Narkhede wrote:

> Well I didn't present it as new use case. I just gave existing
> usecase based on existing reset attribute. Nothing new here.
> Nothing really changes wrt that use case.

As a board driver maintainer, I fully support your case. At least as a
development/debugging. And even if people out there play around and find
their own workarounds, these can give us maintainers valuable insights
and save us a lot of time.

> As mentioned earlier not all vendors care about Linux and not
> all of the population can afford to buy new HW just to run Linux.

At least in the x86 world (arm is *much* better here), even the
(supposedly) Linux-friendly ones often don't really care, especially if
the board isn't the newerst model anymore.

Unfortunately, what we do or don't do in the kernel has practically no
influence on board vendor decisions. The best we can practically achieve
at their side is slowing them down on smearing bullshit into FW and acpi
tables. Even getting some useful documentation from vendors is a really
rare thing.

ARM world with device tree, of course, is much better (except for closed
consumer devices like "smartphones" or acpi-poisoned arm64 boxes). At
least for profession embedded boards.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
