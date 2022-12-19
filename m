Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAE1650ABF
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 12:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiLSLdB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 06:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiLSLdA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 06:33:00 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B573DFAE
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 03:32:59 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 65so5994239pfx.9
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 03:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0n+w2I53HsHcRxj0Rc3TmCJ6R20Bcho6xyBreSLv9PY=;
        b=6Vp+RpGlOP7g0+6GZiHWjyZjtMK4wKz3IjxmVYVMBcPIMyytjPJb7ztH9RG3/9EMP4
         Ry96vhVGKhjb5sPLV105Q6LZExICvLBl0ckbzOvQrRvKo+JZfWdQz8RI9olpzO8qcGDN
         WyiSW+Z6bd5/pGJMXOUv6Z4UcDnGiodOpBHEZyMO4awFIrOv707KcRBu4ULJdzbRtMgD
         f9PFJ9yWqsfT2MEmn47+d1pj4QKfVo2SMtY5Fmn4Vjyf0l4epQlaeLvwSiHsy7Ng6sm1
         fpvJqJgZhKGgJ5bMs7KX+DHrPfZKT1ob0dbTyVK40Lz5yxYmty2wrkTI73gT2I6CdX3f
         LfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0n+w2I53HsHcRxj0Rc3TmCJ6R20Bcho6xyBreSLv9PY=;
        b=veSyhU3AMyjd7W4w+piAPBH5Yng1+QWMpGq3VLKyadN8ZGtElSlfa2TkohfIoq93a3
         vrksacZ7ThLV2WVaKcl7RIM2lZaH8svx9ZQoVK8uSbvT7gFXlk+gaJvoIa+/ZAAjmOkW
         Xq0mGAdOFKjNJchsCoym9CC7fXm0plpDo1ysUZ9sH5cB39W29ISE5tQPN81mv8V4Vhpi
         u70cPBH9/UxxSdmJGUfLQ6Os1w9BJ8F7G5p9EN5MIfJ42F/1kyRBehS0XGPcU4ErGlfU
         4kZ9ZYiF8dEyEprvIHhgKKROhCShYTfkNgxdx/QYeeddEaasLvS+kmdgnCcDnZcHySSh
         itGQ==
X-Gm-Message-State: AFqh2koBbDmtVs6s8gfS7Pn/GUzcxGcrr0sDn2mdhT5A+u0IjBXm/FGp
        DI5hjZK+Ofq00COHVd8DzPsZlUiHxWlewRMWcmT/MQ==
X-Google-Smtp-Source: AMrXdXu/L9zLi9FO6BusNumo5dwkvvOcy0ioAN8eZATOvK/JqTNJkvtwZy5tdtoXjgVm2ugkEBZnnZggZcJkRZVldGw=
X-Received: by 2002:a63:f315:0:b0:48c:5903:2f5b with SMTP id
 l21-20020a63f315000000b0048c59032f5bmr144376pgh.504.1671449578688; Mon, 19
 Dec 2022 03:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com> <20221219054757-mutt-send-email-mst@kernel.org>
 <CAJs=3_B+NB9LuqDBw_1a_6mXGCP2rA6bsrxLuoQ6gWdEg-vscg@mail.gmail.com> <20221219060316-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221219060316-mutt-send-email-mst@kernel.org>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Mon, 19 Dec 2022 13:32:22 +0200
Message-ID: <CAJs=3_Cq3ca=evn9J=mQT3ieF0wi2YVfjfgJ3Ykh-Adu7Fxujw@mail.gmail.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        bhelgaas@google.com, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ok,

> can be patch on top ...

Just to be sure,  you mean here to create a new patch adding a comment
to the kconfig file, not a new version for this patch, right?
