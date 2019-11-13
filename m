Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC6FB372
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfKMPQZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Nov 2019 10:16:25 -0500
Received: from mx1.silicon-gears.com ([81.47.169.96]:51512 "EHLO
        mx1.silicon-gears.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKMPQZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 10:16:25 -0500
X-Greylist: delayed 1717 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 10:16:23 EST
From:   Ismael Luceno Cortes <ismael.luceno@silicon-gears.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Patrik Niklasson <patrik.niklasson@silicon-gears.com>
Subject: Re: Exploring the PCI EP Framework
Thread-Topic: Exploring the PCI EP Framework
Thread-Index: AQHVmU8qOjnPCI1YwEGFWKT7LCnZeKeI0KSAgABOlAA=
Date:   Wed, 13 Nov 2019 14:47:42 +0000
Message-ID: <20191113144742.GA2680@kiki>
References: <20191112114854.GA3478@kiki>
 <6e534239-36c7-086f-502a-fa399917f5f7@ti.com>
In-Reply-To: <6e534239-36c7-086f-502a-fa399917f5f7@ti.com>
Accept-Language: en-GB, es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <860D3405FFCEE741AF0529E27606B64F@silicon-gears.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-User-Approved-Sender: Yes;No
X-TMASE-Result: 10--21.803700-10.000000
X-TMASE-MatchedRID: IDdx3MBO6EALOlLLYTglZaJVTu7sjgg1cVr+FAe3UDUurUcwuzZNE+Mm
        pZ6XwS0iymvINgQng1nYlAhrLW5bRj13WcdbGR6Q8eSmTJSmEv0TcSAXT4xW4EFwIhIhpx6T5su
        eCC+qhXcFRSh7ofHHk4J8ACQtXxmkQLBrHsp/dPPWKVDgooDCt1a9r6f+QKmvs4be7XhW2Z7ZQi
        Ss3YFlOhLGPhTb+r67rM+ASnyCBihhjejNb4SeB65iccRV1A3YSWg+u4ir2NOUbuXvJZv3p7SMH
        jcMZZi7Mom4BC2cp9iUrJ84gMN/iD+waEkxU0QNsFkCLeeufNt6QyBM5BtUW7oNrnFMteaf0A45
        IAXRxM3XM7E4d3fliTmy64DpEeZRYHtDBfDeEsjzXLbkJWzoJPZfafJjZZIJnG0dBE+DEE34GBX
        K/fgP2zpkGp1zoXYsfwFwh/fJ11MJTfSnC4R/H33O3F/Nshx5/RmmEswf7IfvJlVoohLDIVEtMR
        GFGDWD0DAd9+6+KRtktokPgethAchJhcldb+0MLIrMljt3adsfkDOlTQgzYWs5aIlDmHCs3wRfx
        vAEQybGBjzLH/jDjetno5Fr47QUgrOBJP860l327WtDgGBc8hdNweKSmDpaY9tXPGh/u0NVZw42
        jjC7gPXElWYHzovaTPKnaArzlb7l6yjoFgHj/NU8lkLnHC3tj2E0cciid8QObIrZ0cF8LCgkUPW
        YTW1G4vM1YF6AJbalssEwwVS3DgtuKBGekqUpPjKoPgsq7cA=
X-IMSS-DKIM-White-List: No;No
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I'm adding Patrik, who was interested in the thread.

On 13/Nov/2019 15:36, Kishon Vijay Abraham I wrote:
<...> 
> The endpoint relies on polling a shared memory to detect any events. However if
> the HW supports some sort of memory signaled interrupt (similar to what is
> usually available in systems with RC) then we could use it for interrupting the
> endpoint system. All we have to do is map the MSI address to a EP BAR region so
> that host can write to a mapped BAR in order to raise MSI interrupt.

I was proposing exactly that internally here, but I'm not 100% happy
with having the RC-side driver trigger the interrupts this way as we
need to expose a hint about "how", but it's probably the only safe bet
(we know the endpoints in question will always support MSI-X).

> Even if the HW supports, the EP framework doesn't support to use MSI. I'll have
> to see how that can be added.

Thanks for the confirmation. Where's the polling happening? I can take a
look at that.

Patrik: Can you check if we could publish that part of our docs? It
would involve only the signalling.

> > I realize it may not exist because it would imply not yet existing
> > mechanisms. I even don't know if such a thing is feasible with a
> > standard IOMMU, but I'm trying to figure out just that.
> 
> Does the PCI EP controller also wired to IOMMU?

No, I'm just daydreaming: a programmable IOMMU could implement magic
pages which produce rewrites, hooked to the PPR mechanics. Even if it's
not all hardwired, I don't think I could get to play with that.

> > I'm tempted to try to glue together the EP framework with VFIO for the
> > purpose.
> 
> That would help to create a user space endpoint function driver. Not sure if
> it'll help for the doorbell.

Oh, now that I read it again, it's confusing, I meant I would like to
tie EP Framework with VFIO somehow, to implement the EPFs in user-space;
completely unrelated to the previous comments.

> > 
> > Are you aware of any efforts along those lines?
> 
> Most of the efforts in EP right now are towards binding the epf to virtio.
> https://lore.kernel.org/linux-pci/20190905161516.2845-1-haotian.wang@sifive.com/T/#m4092f14a49852425a00a9a9afa80b4d3b1b836d1

Very interesting, I didn't hit any limitations because our EPC driver is
a hack, but we're going to go with the EP Framework in the end, so good
to know (plus we're using virtio already in pretty much the same way).

Thank you very much.

Best regards.

-- 
Ismael Luceno <ismael.luceno@silicon-gears.com>
+34 934452260 ext. 139
Travessera de les Corts 302 Bajos, 08029 Barcelona, Spain

https://www.silicon-gears.com/ - https://www.tttech-auto.com/
