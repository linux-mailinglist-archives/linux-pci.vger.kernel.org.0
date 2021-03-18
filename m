Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB0F340C27
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 18:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhCRRvd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 13:51:33 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41253 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbhCRRvV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 13:51:21 -0400
Received: from [192.168.1.155] ([77.4.36.33]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MvrRB-1lekpc3nCp-00sxN1; Thu, 18 Mar 2021 18:51:12 +0100
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        ameynarkhede03@gmail.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        raphael.norwitz@nutanix.com
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312173452.3855-5-ameynarkhede03@gmail.com>
 <20210314235545.girtrazsdxtrqo2q@pali>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Message-ID: <1da0fa2c-8056-9ae8-6ce4-ab645317772d@metux.net>
Date:   Thu, 18 Mar 2021 18:51:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314235545.girtrazsdxtrqo2q@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yfYWVq+ugqSFaWKTaRJne8X17DPLGCIdmLlkZ0p2Vqk4NFzJ4sk
 wyZU8aaOyehQbG7HE3yHMMZ4/Mu6oXUPWPPPjRjS1RaoWqCWkr3lGUIwgLl7xh8E+zHnGrU
 CIIiMJ+KM08ylEkcC53k7jEwNktiyrojKo9IT6bqJ8u5YpSeX1FYNGpBzOgADxyX6s7OnpJ
 tpWJplS/luDQ8yc9dp2zg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6sccM/UoIG4=:NMyKEYmRkvGFfWLGVyFx43
 aLjEXXSIVP9dGnA8pEasUcrztSNZy7KzMJipuKc1tZ+BPH5LdBwm0FzvFYMCQRIt7LyVqiFw9
 EJqZT3Q0wBTA5/m/DwRlIX0APE5l0GCde/qKELTzVK3A+ncegzxPfBBTc8D7zkKV7D+E2eLho
 8mlq3LCcYUKX5gPQrNrfsYalZHZb1E+S16KyYpQE955fvznI6xTJCqpyYaZzLldBwpr5h4dlQ
 CgOEkQ6KYDwxQk4VgnVCfgRHbDOrQNE44CFIHmZXYgzw0OEzHefAgEzEv3rC2HHJgVJgg84p6
 3Ewrqt0d/94OK3RV/s8HSOgkL9PeyMOa2l6XL2b2YETU4I7q5mzz+uYesN9gX++wma5AzVuvv
 Wb+4by2LYPYaRdd/mHpvPTnBtA7jFdXYVR7ZKRZX416+zEs6yxAfsC9YA9xIO
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15.03.21 00:55, Pali Rohár wrote:

> Moreover for mPCIe form factor cards, boards can share one PERST# signal
> with more PCIe cards and control this signal via GPIO. So asserting
> PERST# GPIO can trigger Warm reset for more PCIe cards, not just one. It
> depends on board or topology.

The pcengines apu* boards happen to be such candidates: they've got
three m.2 slots, but not all wired in the same way (depending on actual
model, not all have pcie wired). Reset lines are driven via gpio, and
some devices (I recall some lte basebands) sometimes need an explicit
reset in order to come up properly.

I have to check the schematics for the diffrent models, how exactly
these gpios are wired. (i've got reports that some production lines
don't have them wired at all - but couldn't confirm this on my own).

BTW: any idea how to inject board specific reset methods, after the
host brigde driver is already active ? In my case, apu boards, the
pci host bridge is probed via acpi and the apu board driver (which sets
up gpios, leds, keys, ...) comes much later.


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
