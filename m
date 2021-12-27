Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54A147FC34
	for <lists+linux-pci@lfdr.de>; Mon, 27 Dec 2021 12:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhL0LaY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Dec 2021 06:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhL0LaX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Dec 2021 06:30:23 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7E3C06173E;
        Mon, 27 Dec 2021 03:30:23 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id fo11so13549427qvb.4;
        Mon, 27 Dec 2021 03:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yhNw9pjNn5LL5fUtXlfMnydvmUl+Bq6jHYVYualK7T4=;
        b=bmmKP7AgTBPmPSoJBws5ns076rkB5ceZaeWi+4jmm9mKz8l83a1AHc3b1uMJxVRk/o
         mOcgGD1w2SwfRzSgb7ntX9XLm744CtagBhBcJvwnHUDNhVZT6grtk04YJD31I2oU53UV
         QDZeMDhvXTnPxC8aae/bb/GUR4eeoOmI65AWGLh8GfWKvc4PzLx2WXErAA1ak753k71t
         kWMKQHpjYsuCryJxOxNC8jfT8xC4juD3JlVGPTHUpmRs0XuM4DNhab0XBFzZ5Gi218vE
         aULGc/6d2UdFwvAlSTC56PcbaQ/Ok/7ZJtrLZ+kwf1QRSpTUdz4jG/9W4h8/5+JxqjKZ
         v2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yhNw9pjNn5LL5fUtXlfMnydvmUl+Bq6jHYVYualK7T4=;
        b=Jm+9pVv+E81FZHIkhd8pSnZq7AHqMgiH1UkSmt/efMlqRVv9iSinHOCeLBtYnoVJ+t
         e1D/RANq6Wo4QZj09DaFqf65LXTW0wbwEFpDWwnzmcYwa/BtCm5MFW26yklhzuDzjZda
         A+i3kbqwWEBTXu1mu/KZQneEgpu7+EjqpY/KJi+BBANfA93p/10X/kMAORozxdIAURVv
         SqX9+9CypF4dcCFNPbcsYBadLgyajjJS5DPOoN3s4RbUMWz1rT8s3Y/00Ax69WGl04v8
         78Sxhd/gaUHeWAdhdtQ0d5iAm2hG1HPGPj8LiMy/0o4IDayOESOWn/k8A8tZajVTRtpH
         vKIw==
X-Gm-Message-State: AOAM530ZlmPsRr8HHFKnXZhpJxiLvWizCtvYJxLRNa8QfHj/nqWJb23P
        jqwivD/7wr4jB7sI1wj90ayCULzFlJl9KutDAjM=
X-Google-Smtp-Source: ABdhPJx1N8QpCleqUoe/JUeICkwQokw3wdeytA3jdDiPiw3GOeHmBdz4Iq0LRRpzqvtVGbe0+OGy0VUwxthCuJxRi1o=
X-Received: by 2002:a05:6214:c4a:: with SMTP id r10mr11866868qvj.62.1640604622551;
 Mon, 27 Dec 2021 03:30:22 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsODP8ze_mvzfJKcRYxuS-esVgHXAvDXS5KN3xFUN6bWgA@mail.gmail.com>
 <CABXGCsMc1_-s5vVv=XVuMJaAtntrfHpCeT3h7wKkK71NuY-izw@mail.gmail.com>
 <CABXGCsMJOfGU8axS4FdGfPCgcPL5iuedpZxa4PETSyFHDckOAg@mail.gmail.com> <CACT4oud-7rpKgcapoNY7Ywd0socwQ-5BPteOxe7S7RNCaUzN+A@mail.gmail.com>
In-Reply-To: <CACT4oud-7rpKgcapoNY7Ywd0socwQ-5BPteOxe7S7RNCaUzN+A@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 27 Dec 2021 16:30:11 +0500
Message-ID: <CABXGCsOX72u3yDcGNF64zbm5mC+Z=_8rxKM0cu7m4i1D8iWvbA@mail.gmail.com>
Subject: Re: [Bug] Driver mt7921e cause computer reboot.
To:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        sean.wang@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        objelf@gmail.com, lorenzo@kernel.org, Soul.Huang@mediatek.com,
        nbd@nbd.name, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 27 Dec 2021 at 15:11, =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com> w=
rote:
> I've been experiencing similar problems, but they're solved at v5.15
> version, at least for me.
>
> How are you installing the kernel? Custom build? Have you updated the
> firmware to latest versions, as well?

I use Fedora Rawhide with default kernel and firmware packages.

$ uname -r
5.16.0-0.rc6.20211223gitbc491fb12513.44.fc36.x86_64
$ rpm -q linux-firmware
linux-firmware-20211027-126.fc36.noarch

>
> For me, these differences seem to be the normal effect of the driver
> not recognizing the device.

By the kernel logs, it looks like this:
After reboot:
$ dmesg | grep mt7921e
[    8.629358] mt7921e 0000:05:00.0: enabling device (0000 -> 0002)
[    8.630229] mt7921e 0000:05:00.0: ASIC revision: 79610010
[    9.687652] mt7921e: probe of 0000:05:00.0 failed with error -110

# rmmod mt7921e
# modprobe mt7921e

[  215.514503] mt7921e 0000:05:00.0: ASIC revision: feed0000
[  216.604741] mt7921e: probe of 0000:05:00.0 failed with error -110

After cold boot after shutdown:
$ dmesg | grep mt7921e
[    8.545171] mt7921e 0000:05:00.0: enabling device (0000 -> 0002)
[    8.545757] mt7921e 0000:05:00.0: ASIC revision: 79610010
[    8.631156] mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build
Time: 20211014150838a
[    8.912687] mt7921e 0000:05:00.0: WM Firmware Version: ____010000,
Build Time: 20211014150922
[    8.938756] mt7921e 0000:05:00.0: Firmware init done
[    9.753257] mt7921e 0000:05:00.0 wlp5s0: renamed from wlan0

It looks like something is not re-initialized after a reboot.
Laptop BIOS is latest: Version 316
https://dlcdnets.asus.com/pub/ASUS/GamingNB/G513QY/G513QYAS316.zip

Maybe anyone from the pci mailing list can lid some light why pci
device not re-initialized after a reboot?

--=20
Best Regards,
Mike Gavrilov.
