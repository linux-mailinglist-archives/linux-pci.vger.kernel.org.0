Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF2537F924
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbhEMNvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 09:51:21 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:21496 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbhEMNvS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 09:51:18 -0400
Received: from mail-03.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 4FgtMM1CvHz4x1dq
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 13:50:07 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Zd8jpuMu"
Date:   Thu, 13 May 2021 13:49:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1620913801;
        bh=LJ2Qq5Z5NTb8wUoIz1Fra3dktLBK7JXTteMyoU/44D8=;
        h=Date:To:From:Reply-To:Subject:From;
        b=Zd8jpuMuWwZinJpn5YNbh8iGZXf6hM8pJxRmlTrGl0GA4dl6rXRd+LKUweh73OY7p
         kkKluMJTwMvOQLViPRLf82tzcXSWd7JfC5NiEY7k1PECINUz7QaiCBN36yjNzd0qYG
         3ZKk0ZPZOIypRTuM1pR8DHEzc8Tuk+UkJ/L4sCWQ=
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   "linux.enthusiast" <linux.enthusiast@protonmail.com>
Reply-To: "linux.enthusiast" <linux.enthusiast@protonmail.com>
Subject: How does the "/sys/bus/pci/drivers/*/*" interface work?
Message-ID: <bO6tTSRbjFucyxFz_SsgnnkT6H40xY428tQCVi64ig-N6nVg_xxyHzjb7m31oMu0VRSDjMRt9DdH3jMg7sefDSmx-XEyh-Htr3x9o6AU3hk=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,
I hope this is the correct mailing list to ask my question.

Looking at "/sys/bus/pci/drivers/xxxxx/" I see a bunch of files, which (for=
 a lack of better term) I will call "interfaces" and they can be used to as=
sociate a device with a driver. E.g.:

```
$ ls /sys/bus/pci/drivers/vfio-pci/
bind  module  new_id  remove_id  uevent  unbind
```

For example I can use `bind` or `new_id` to bind a driver to a device:

```
sudo bash -c "echo '0000:${PCI_ADDRESS}' > '/sys/bus/pci/drivers/vfio-pci/b=
ind'"

sudo bash -c "echo '${VENDOR_ID} ${DEVICE_ID}' > '/sys/bus/pci/drivers/vfio=
-pci/new_id'"
```

and I can use `unbind` to unbind the currently used driver from a device:

```
sudo bash -c "echo '0000:${PCI_ADDRESS}' > '/sys/bus/pci/drivers/${DRIVER}/=
unbind'"
```

My problem is that I can find no official documentation on these "interface=
s" (`bind`, `unbind`, `new_id`, `remove_id`,`uevent`).


It seems to me that I have to use `new_id` to bind the driver for the first=
 time after a reboot and if I then unbind it again, I have to use `bind` in=
stead of `new_id` until I reboot again.

If I use `remove_id` after using `new_id`, I have to use `new_id` again the=
 next time.
But if I use `remove_id` before using `new_id`, I get an error (`echo: writ=
e error: No such device`). Same for using `bind` before using `new_id` firs=
t.

I have 3 questions now:
1. Are my assumptions correct?
2. If so, how can I check which of these "interfaces" I need (`new_id` vs `=
bind`) without blindly executing them an then checking if it failed?
3. What are each of these "interfaces" actually doing and how do you use th=
em correctly?

Thanks in advance. I hope I'm doing this correctly, this is my first time o=
n a mailing list.

Best regards
linux.enthusiast

