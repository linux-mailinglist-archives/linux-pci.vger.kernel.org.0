Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAE8388FBC
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 16:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346771AbhESODQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 10:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240179AbhESODP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 10:03:15 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26433C061760
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 07:01:56 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id o10so11332906ilm.13
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fatalsyntax-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=l0qnOBDAqFxbAl4A/tgruJXdRSPfyXeqpxkVnrjpsLU=;
        b=BCE33qPApN0PgECWGnTxif8soc0GJNwskBzJc2K+CfySp9KdVw+UmXMVjPygm2rZhM
         Re+pomhsghUP0srqeVuGY7acL1TKrvkHdrjBNTVKpjCHzdYdFk6e3J1r/7KzIra98cE3
         Fw/sZdGmTeH04OeqHDJDdybGLBPujMVL12Erac1vWa3kut1MsqhQlaIBbakHUTpUwhym
         Oh9hwaF5ZTCYygHxsLxT1U4WQI0LrPGJdzAVfAboM8jaySEkr6t2kYgO+3l0Qt43CV6H
         RPX/EkPXpjOLs/B/c6NkQHtCIt6alzO6DZ96iiBbbBbCZ8NBi0JyXMSt5D0tdd5LEovM
         /d7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=l0qnOBDAqFxbAl4A/tgruJXdRSPfyXeqpxkVnrjpsLU=;
        b=hA2q8mHix/uuJQWpK+5rmujsPjkFdQHUJ4uo7JhMLsayn3BZLU46U979rXsUobJO4x
         TIIMSL2pYGhtibW/5F2BOO+yUSQ7FksgLOWgf37DFDTQEfDYC/xrbPAvz+/FhMGh0Kdt
         c55QQdt2WkCMLqlo/Z0ZZtOrPrvr2hAvHswYnd3DOrkDx1yTHO9HuUErazndKyHYfjBO
         nt6tgAhiGSRMD5KmLh06YyWYfvdA7xShOgLuEckCN+eZa90j+oyFP/SRi+Aiqc+F0HGB
         wELB4rdf5QKLtS/BHTkz0czNd1H1Osk6sktpcTwLSVKagPj8gPMnKhuZuEslgEsi0/yx
         RoMA==
X-Gm-Message-State: AOAM530ja5XfcXUcPq3EE0wddWxo/+hB6tpnhwYg6dRBgmOqUjFwVH+H
        ZjUaLXC40HQFqdAZMWA2Sqoq/w==
X-Google-Smtp-Source: ABdhPJwfg75GDFB7soifn4UuZUdaLr9R5CyiL2hi51XRrKD29gZA64BPkkDQZlRlbFKjUG2kcnswRw==
X-Received: by 2002:a05:6e02:2149:: with SMTP id d9mr10978074ilv.162.1621432915377;
        Wed, 19 May 2021 07:01:55 -0700 (PDT)
Received: from localhost (2603-6000-ca08-f320-6401-a7ff-fe72-256d.res6.spectrum.com. [2603:6000:ca08:f320:6401:a7ff:fe72:256d])
        by smtp.gmail.com with ESMTPSA id a6sm6121262ili.21.2021.05.19.07.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 07:01:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Bjorn Helgaas" <helgaas@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Alex Williamson" <alex.williamson@redhat.com>
Subject: Re: [PATCH] pci: add NVMe FLR quirk to the SM951 SSD
From:   "Robert Straw" <drbawb@fatalsyntax.com>
To:     "Christoph Hellwig" <hch@infradead.org>
Date:   Wed, 19 May 2021 07:54:19 -0500
Message-Id: <CBH8K74TF8IQ.2KUOIGFJ7K8XP@nagato>
In-Reply-To: <YKTP2GQkLz5jma/q@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed May 19, 2021 at 3:44 AM CDT, Christoph Hellwig wrote:
> On Sat, May 15, 2021 at 12:20:05PM -0500, Robert Straw wrote:
> While it doesn't matter here, NVMe 1.1 is very much out of data, being
> a more than 8 year old specification. The current version is 1.4b,
> with NVMe 2.0 about to be released.

I can't comment on 2.0, but yes 1.4b has the same aside regarding undefined
behavior on the SHST field (on p. 50). The only reason I was looking at
1.1a is because it's specifically listed on the datasheet for the SM951.
(The device under test.)

> No, we don't. This is a bug particular to a specific implementation.
> In fact the whole existing NVMe shutdown before reset quirk is rather
> broken and dangerous, as it concurrently accesses the NVMe registers
> with the actual driver, which could be trivially triggered through the
> sysfs reset attribute.

I'm not exactly clear in what way the nvme driver would  be racing against=
=20
vfio-pci here. (a) vfio-pci is the driver bound in this scenario, and (b)
the vfio-pci driver triggers this quirk by issuing an FLR, which is done=20
with the device locked. (e.g: vfio_pci.c:499.)

In my testing *without this patch* vfio-pci is still bound to the device=20
for at least 60s after guest shutdown, at which point the FLR times out.
After this FLR the device is useless w/o a full reboot of the host.=20
Rebinding it to *either* another guest w/ vfio-pci, or the Linux nvme=20
driver doesn't matter: as the device can no longer be reconfigured.

As I understand it: vfio-pci should not blindly issue an FLR to an NVMe cla=
ss=20
device w/o obeying the protocol. The protocol seems clear that after a=20
shutdown CC->EN must transition from 1 to 0. (I would argue the guest OS=20
leaving the device in this state is the actual violation of the spec. As=20
I'm unable to change that behavior: having vfio-pci clean up the mess w/=20
this quirk seems to be an adequate workaround.)

I am currently testing  a version of this patch that only disables the
controller if the device has been previously shutdown. I am trying to
gauge whether this would be preferable to just blanket-disabling these=20
bugged devices before relinquishing control of them back to the host.

> I'd much rather quirk these broken Samsung drivers to not allow
> assigning them to VFIO.

I'd much rather keep using my storage devices. I will leave the=20
quirk limited to these known-bugged devices.
