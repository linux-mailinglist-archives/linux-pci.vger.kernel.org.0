Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8E264A4C1
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 17:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiLLQaV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 11:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiLLQaT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 11:30:19 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD282B48F
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 08:30:18 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 82so8581830pgc.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OUILWEspXMe7ooUig3KmknX9KoRcehzQ+nw7PUyJ1kU=;
        b=OaaojC/sMyai941Icb8QrOqMENAWi28ghc9hDsed00zjgjisK6qVEZu2vOMG8n6FBF
         mRTAFH6tUYD1vvdF+OQzbqW4ejDlJmdO83c0sjR8B6XLmzvRlBgKt6VPAt6yOfgNXXyS
         N5hpWodqaEejfLPFa5uI/+RgmUe+2L5KuDbTZUzGpS0Yy71Zsw9asM92nPSSAqgzID8V
         TZbBBSJDtvX+M6y77IBx8HxMvYUg0YvxvqtzfiXR379RHxM6LHGWjUpvhiicE9ZSZ9m8
         NJUY3oS5uH+mKQyJu3VMfKT0w/YVtgxjW31JMhCJYUkUnNwWQRbj6amimPqgaYKW5WtQ
         qWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUILWEspXMe7ooUig3KmknX9KoRcehzQ+nw7PUyJ1kU=;
        b=GTfYHqLTzU6aBnMxSTWDR2xDqivyQStatM114QWvkts98XHCSttfLU3WGuxa0bsQc4
         Vh2zwQy7ppAuWT3qz1jULqirJSWiTM3n62OR0V5d0K/SzvOBLw5i7R582+gu9YTd71ZN
         A6aqkZcS1CQD4OnP96ig3rdQzBj/vZ8SG19FNB8w3oRlmbPsL1yxkZXyoSO+pfdGDzk8
         tunuaz3VfVCXr79vAGyQDzPePlFVC8asPNC4TjOQZS0DMPHDgSS+yWJzIiWRPCvlMbZJ
         YLtVmCGcmczI0RWKryn/7LD7wW/HhdPvlig/yEjoyd92oY1xLdk6HbkNISOV4GlpLbIT
         Mk/w==
X-Gm-Message-State: ANoB5plLTK6FQrKkSeWAdhGu5lFWLiAcNE+ebr/jSMhUSN9j8d2VNVsU
        WiTT9kHKIFnX+uyw7h+ji/pPIxLqzmnlzgwOKZOntvWM9zGFsC3S
X-Google-Smtp-Source: AA0mqf7JA3HhSeTurk8iZookol7LHDnbT/F4m7xHYAYV/UuB9gMGq1bbOo6jpRGSGdf/yNJmDF2yJW3rA7g/Yj6tJB4=
X-Received: by 2002:a05:6a00:10cd:b0:572:5c03:f7ad with SMTP id
 d13-20020a056a0010cd00b005725c03f7admr98862692pfu.17.1670862618084; Mon, 12
 Dec 2022 08:30:18 -0800 (PST)
MIME-Version: 1.0
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com> <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
In-Reply-To: <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Mon, 12 Dec 2022 18:29:41 +0200
Message-ID: <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
Subject: Re: [PATCH 3/3 v4] virtio: vdpa: new SolidNET DPU driver.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean Delvare <jdelvare@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Guenter,
Thanks for your comments.

> This is wrong. It should be possible to build the driver without it, and
> without forcing everyone to enable hwmon just to get support for this device -
> even more so since hwmon support is explicitly marked as optional below.
> Why force people to compile it if it is not mandatory ?
>
>
> Yes, I know, "select HWMON" is done elsewhere as well, but it is just as wrong
> there. No one should be forced to enable HWMON support just to get, say, support
> for the IDT PCIe-switch Non-Transparent Bridge.


You have a good point.
I will remove it from the Kconfig file, and I will add:
#if IS_REACHABLE(CONFIG_HWMON)
in relevant places

Something like:

solidrun/Makefile:
obj-$(CONFIG_SNET_VDPA) += snet_vdpa.o
snet_vdpa-$(CONFIG_SNET_VDPA) += snet_main.o
#if IS_REACHABLE(CONFIG_HWMON)
snet_vdpa-$(CONFIG_SNET_VDPA) += snet_hwmon.o
#endif

solidrun/snet_main.c, snet_vdpa_probe_pf function:

if (PSNET_FLAG_ON(psnet, SNET_CFG_FLAG_HWMON)) {
#if IS_REACHABLE(CONFIG_HWMON)
        psnet_create_hwmon(pdev);
#else
        SNET_ERR(pdev, "Can't start HWMON, CONFIG_HWMON is not reachable\n");
#endif
}

solidrun/snet_vdpa.h, snet_vdpa_probe_pf function:
#if IS_REACHABLE(CONFIG_HWMON)
void psnet_create_hwmon(struct pci_dev *pdev);
#endif

What do you think?

> I do not see why the second include would be needed.

You're right, I'll remove it.

>
> Tpecast seems unnecessary.

I'll remove it.

> Kind of obvious.

Ok, I'll remove the comment.

> Badly misleading indent. No idea why checkpatch doesn't report it.
>
>
> That makes me wonder: Did you not run checkpatch --strict, or did you choose
> to ignore what it reports ?

I did run checkpatch (without --strict).
I tried now with --strict. and I'm not getting any indent
errors/warnings, this is strange..
I will fix it.

> FWIW, a _hwmon ending in a hwmon driver device name is redundant.
> What else would it be ? Why not just use pci_name() ?

I'll change it to "snet_%s", pci_name(pdev)

> devm_hwmon_device_register_with_info() returns an ERR_PTR on error,
> not NULL.

Ok, I'll fix it.

> I hope you know what you are doing here. This may result in people wondering
> why hwmon support doesn't work if they expect it to work. No one looks
> into the kernel log. Besides, ignoring the error doesn't really help
> much because that error return means that something serious is wrong.

You have a point, but the hwmon is not the "main" functionality of
this device, so I don't want to fail the entire device because of a
"side" functionality.
Now that the SNET vdpa driver doesn't select CONFIG_HWMON, we may have
a situation when the SNET_CFG_FLAG_HWMON flag is set, but the kernel
is compiled without CONFIG_HWMON.
I don't think that I should fail probe in this case.

> Wow, a 5-second hot loop. Not my responsibility to accept or reject this
> part of the code, but personally I think this is completely unaccceptable.

The SNET DPU may require some time to become ready.
If the driver is compiled as a module, this is not a problem, but if
the driver is builtin in the kernel, we may need to wait a little for
the DPU.
But you're right, 5 secs is indeed a big number, I'll change it to 2 secs.

> Memory allocation failures are not commonly logged since the low level code
> already does that.

Right, I'll remove the error log.

Alvaro
