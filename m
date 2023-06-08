Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733F6727953
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjFHH5r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 03:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjFHH5q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 03:57:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B197AEA
        for <linux-pci@vger.kernel.org>; Thu,  8 Jun 2023 00:57:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7fc9014fdso1195605e9.3
        for <linux-pci@vger.kernel.org>; Thu, 08 Jun 2023 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686211064; x=1688803064;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQ6hGe0JP6cUwAfdeVhc9hO6F4J5TIAAgSvuHui4rFY=;
        b=Ia/OyGDQCaUwr+FHIJyn4ULWNDU59RvAa7WR59ER6jWkGeeNk2G+HiCBIXfkVt/h+A
         sO4nbNzyR5uKSgJnRETZgtFxA9a2yD6gRfOvlQ3ofZ19HSROJcXbpgZ65D2YFNEZTLV2
         dKFWDODB16YjfA4xeZNGj3p2gMjqt+xhMqmW2/4JQZ0la84PkKrj8hrzH5waZ2MNt+k+
         tHLoR/XhwRaOqQnHIjDuLvP+qBAYzCKhZ13HfIQVo0PqXioYUAggFzrm+f5zLkCJydYR
         kTfsbATPLcmV855JbpYIzgIkzif7nb09VfC7uXsM9MdM0H0kpEnYpgZ6z838Y7fPu0A5
         T+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686211064; x=1688803064;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQ6hGe0JP6cUwAfdeVhc9hO6F4J5TIAAgSvuHui4rFY=;
        b=Honv6puzCzsbSJFPk8m2wAjYb5g1LRa5b7tqzXdI3n6suuS2Dxk59yCOpTcHSIyK5k
         b+++yQgEa0nADJARe1VRCJCI1vIX8a9Ai6BOcwkW6H1sZuu8fB6u8B7kvbbVWrc3UWbz
         XKJo8gUAQGVdGVGl9nM8m2IpGTeKVtmLUaJZNlfH/8mPFuWKudZSOsFcmyCLLc04yOiZ
         jziW2HreGk7nP1iGzyqXSxNxc/hXO+jyREfFo5fI44cJ0u6RsZ6mjy1B/19aIG783hQi
         WqHyXW+AimlL+LF/vk3lFEzIvDKRkLt1OIsxUIUyHm+8Cv7Erh9YeSaxI7SZHdI875fO
         vyqg==
X-Gm-Message-State: AC+VfDwgGVe0zazDLauKY6lhq+RShKMbcMwvyw30EMC9wHoHsiejg2Qu
        ec1bHx+hN+XqsGkqBX5saXj0dS8855Q=
X-Google-Smtp-Source: ACHHUZ6dxrDVadywg57os0Jh8iACG3h2GhXk8bLZR+K7h5WBAvAX9gInehtjSaMKtyLmVoEdoIE88g==
X-Received: by 2002:a05:600c:b41:b0:3f7:408e:b89a with SMTP id k1-20020a05600c0b4100b003f7408eb89amr652593wmr.37.1686211063859;
        Thu, 08 Jun 2023 00:57:43 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:103:11d0:d8d9:c4fa:f040:1af0])
        by smtp.gmail.com with ESMTPSA id f18-20020a7bcc12000000b003f7eafe9d76sm4382403wmh.37.2023.06.08.00.57.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2023 00:57:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: Old Asus doesn't seem to support MSI
From:   Damien Dejean <dam.dejean@gmail.com>
In-Reply-To: <20230607215326.GA1176980@bhelgaas>
Date:   Thu, 8 Jun 2023 09:57:32 +0200
Cc:     linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <02093788-DDD2-4CD7-A23D-00A3E92D089C@gmail.com>
References: <20230607215326.GA1176980@bhelgaas>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for digging into this!

> It's also conceivable that MSI used to work in older kernels, but we
> broke something by v5.10.  Do you know whether any old kernels ever
> worked without "pci=3Dnomsi=E2=80=9D?

I remember trying older linux distributions (Debian oldstable, kernel =
4.19) and
some older Ubuntu(s) but I don=E2=80=99t remember any of them working. =
Plus, the
Ubuntu wiki pages and various post replies to =E2=80=9C=E2=80=A6 Linux =
is not working on my
x73sl laptop=E2=80=9D are always suggesting the pci=3Dnomsi option, so I =
guess the problem
exists since a while.


> What exactly is the symptom you see without "pci=3Dnomsi=E2=80=9D?

To be able to boot at first I had to disable the =E2=80=9CWireless =
adapter" from the BIOS.
And after that, the system was booting but when the kernel was trying to =
switch
to a =E2=80=9Cnice framebuffer=E2=80=9D the display was completely =
mixed-up. I disabled kernel
modesetting and tried to start X manually and I got:

  (EE) NVIDIA(GPU-0): The NVIDIA kernel module does not appear to be =
receiving
  (EE) NVIDIA(GPU-0): interrupts generated by the NVIDIA GPU at =
PCI:1:0:0. =20
  (EE) NVIDIA(GPU-0): Please see Chapter 8: Common Problems in the =
README for additional information.

Thus I used the nouveau.config=3DNvMSI=3D0 and the display worked fine.

Then I re-enabled the wireless adapter (which is a mini PCI-E) card and =
the system was
freezing during the boot again, (after systemd started). At this point =
I=E2=80=99m not really able to
collect the logs as the device seems to be completely frozen. After some =
digging on the
internet I found the pci=3Dnomsi option that solved the issue, and seem =
related to the
option I had to use for nouveau.

I=E2=80=99ll try to collect the logs when the device is freezing, maybe =
we=E2=80=99ll have a better
understanding of the situation.

Damien

