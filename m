Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E464C340C5A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 18:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhCRR7E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 13:59:04 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:48179 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhCRR6g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 13:58:36 -0400
Received: from [192.168.1.155] ([77.4.36.33]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MxEYY-1lcGoU3fx2-00xZzu; Thu, 18 Mar 2021 18:58:26 +0100
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
To:     Leon Romanovsky <leon@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, alay.shah@nutanix.com,
        suresh.gumpula@nutanix.com, shyam.rajendran@nutanix.com,
        felipe@nutanix.com
References: <YFHh3bopQo/CRepV@unreal>
 <20210317112309.nborigwfd26px2mj@archlinux> <YFHsW/1MF6ZSm8I2@unreal>
 <20210317131718.3uz7zxnvoofpunng@archlinux> <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org> <YFMYzkg101isRXIM@unreal>
 <20210318142252.fqi3das3mtct4yje@archlinux> <YFNqbJZo3wqhMc1S@unreal>
 <20210318170143.ustrbjaqdl644ozj@archlinux> <YFOPYs3IGaemTLMj@unreal>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <5dfcdfae-2b80-d6dd-89fe-2980faf26502@metux.net>
Date:   Thu, 18 Mar 2021 18:58:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFOPYs3IGaemTLMj@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sUANLOhbSsgtdE10mRWK7Pe6X+rTKT/A+XesO8H/+6+SSaXNjRJ
 nIuP2gIi21Ay1mkQ3C0HVEsYFoDPMOQAJT7YyDJNANZhOb7kpq2AHKcpXh88v5DNP+iVUsU
 k4iDS0IrDAe8hYh/9qti5vQ4FdhEOl+EQdOjWW2/AEGvk3EqQbqvOw0XtgxQE1fmBks9yHi
 tmmkUr6m4UfJOfyeodmPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kGrJnPLqp/o=:A0fdqKNAyFuUnpZ5PwjxA8
 mkyY/hhhxZf+v1F75jeuvHrnqeOdp3DhoDweE4/MBkJJ4ZagN0wrfN/YP5/zqenrND4iUzIAM
 wh/RVKaVBzenXDFtXz/+YkQe7SK2WbMqiT8Oxp6tRlw9rntdEtKAy+w9531SIMGcUaw7IP4JG
 CDAOcZvfCZxkEK9HvLwp4w7KaKAmNSBXJ9EeRJfNtzBizAvkfBIdRbXMCejar4/rr1P0R26xD
 8ftcE3F0hd2+GcYaoYJhzSOFXHey68yiYuLwqryQp32GEr9YM3iFXJ7iiho+ZcLDNL7dRAB+v
 k1MTf5OWIb9Edc7StI9m7hEiPWuxd4A6w8baBoQTaFTW4+T6la4RrHAS9w5qIsdceeDAud1kh
 GEHDZB6qkuUqVqrenVOKlzJFJu1pbp3LRNne9LuFmX8vgIBl+EGg6oa7+bqWk
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18.03.21 18:35, Leon Romanovsky wrote:

> I see it as a good example of cheap solution. Vendor won't fix your
> touchpad because distros provide workaround. The same will be with reset.

Usually, vendor won't fix it, anyways, regardless of any kernel
workarounds.

Most Vendors are already completely overstrained w/ anything
software-related. A good reason why we should try to get rid firmware,
as much as we can.

It's really sad. A *decent* vendor would just provide a clean DT and
(actually matching!) schematics. But that's really hard to find, these
days :(


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
