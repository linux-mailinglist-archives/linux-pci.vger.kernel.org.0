Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9005F64A629
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 18:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiLLRr3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 12:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiLLRrX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 12:47:23 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B615513E9E
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 09:47:22 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 4so6869521plj.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ipOHdrYPtRyHmITr3Spy0Cyv3HoWc/t968poH9p0+Q=;
        b=5i9cZZL2zuUIX9rA7rIeDeujcnS3jPzYTu8e2y3808aJVDV+JSJfzRb400JxwUIbUL
         6uAPP0ah/ikPwu2aiOs0rM9V8qlRHfvLcFgaZFLZbBcLhbFzdrd9VSLjHgzlkFwaujvq
         BooahlNnb4g0kVEBzz2pfWkuUOX7cTxt4RYvkfrNtcBac2sy1tAdisI1WeGsQnoADEvo
         +Z7wqtX6kDWv6+/KNJlVxIt8qOmdBwXFPUW5GvkJGb9RsR0I+aY9vdq7yvbmrk/NSJSS
         rLpqQGfSPWBxmhk43GFcCLYNZ2oHKSTrwzAtbp3gn++40kEzcLnhpggowo7AXN1rS+w3
         LmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ipOHdrYPtRyHmITr3Spy0Cyv3HoWc/t968poH9p0+Q=;
        b=cL4TsbfW0BKEJ2bTV+fQo2OeTL0dbagdRpuLuIkhHPzSWkxrXxmJOu2DWHAOFZwPde
         slxIIkX3iyUBI7xBdlgGinBQR1DE28C3lFvxL4daoxpY2PVpzk2bz8GZcLvlSGnjCzqB
         MXNirPzfFxzvR/0LY6OrLTAOGjkxJbX4gWKEKV2u9HesxNdRMj535TL+MrwahRrSx7Yv
         M/mByrqcMyszEDsCvX9obwUL8HFkd/yPSdRF20w1zNFf4JbLjoix221myf+OWebYQxDs
         RBy12FGmW9KIsuKKFffa1Cxz1Dyr/6ztJA+DyK6LVatahIT1YlYNjT3mHYtOiFSxw5z3
         2U5Q==
X-Gm-Message-State: ANoB5pmVPKJ9L3aCA2GzU34TlZXIKgtpWWpebAy951cU/ofM41jiHULv
        gJsDUnkEptXgCyoWInk4zGEeJud6xBP6yECby47FtA==
X-Google-Smtp-Source: AA0mqf64REr7zmomQ/FZcu1X2SZ4Hu47/FZkW7JvmpebDHEGxnB75O7EKBDjhj6GLujkXS8BNIUSIIgWqT2AEGvIA0A=
X-Received: by 2002:a17:902:ccce:b0:189:d0d5:e75b with SMTP id
 z14-20020a170902ccce00b00189d0d5e75bmr21475124ple.163.1670867242173; Mon, 12
 Dec 2022 09:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com> <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
 <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com> <3f83e874-3d7c-cc97-2207-a47dbcfe960f@roeck-us.net>
In-Reply-To: <3f83e874-3d7c-cc97-2207-a47dbcfe960f@roeck-us.net>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Mon, 12 Dec 2022 19:46:43 +0200
Message-ID: <CAJs=3_D6_TayfdSz9e6P6G+axyUht4iyHnwHgPJ8sXG2a3sm2w@mail.gmail.com>
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

> That isn't the point. A 2-second hot loop is just as bad.
> There should be a usleep_range() or similar between loop iterations.

I'll replace schedule() with usleep_range()

Alvaro
