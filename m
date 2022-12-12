Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1859464A65F
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 18:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiLLR53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 12:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiLLR5X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 12:57:23 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ECC1400E
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 09:57:21 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id w26so428701pfj.6
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VWD5UcXtq1LyFYAMz3GCGFKQOR/j/rUgxjSZsop1QAM=;
        b=SRSupRkJoofEgubzGVsjGDuN7e+joOvoOG6f02dSQ/kZszECXK7bj4QYUl3SnngU8G
         JJ6o8EzWHtvCxHfanypFvXOOBQuOWB8hjInjCRvuxZIhijXEc6JT4uuwpH/cuCpbgF+I
         c6sESYbk+30+5V1TACaHZhglbo1uWQlbjNjg34NyFlW1FQQSAljOZ7wXYbCQD42S/l3o
         ZCrIGeFCSaE7OhgX6fH/+hbinL2dTECL+kzc6qDt3HWkrK0onleePFjZ2Vj7KxHgWajD
         hPt/A3TramTec3HWiczND/TVGCDwThF5LXmVGc7BEOObIEdTnHaHQNBXHv2NW8UHTNer
         ac4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWD5UcXtq1LyFYAMz3GCGFKQOR/j/rUgxjSZsop1QAM=;
        b=zFnRGvHE3SfBXCb0P5PktvJpx4oXsQuQs1lBF8blcDbxjT+ZDB3OFc7Cvo2+zmSf4v
         GkVUFD/z2lqI3LJOtDKhOPj4dqpDz8iSw8U/27jj0wSgfCsCoH/+iU7kFqZz0QW/zf5H
         DnE5ks4u7A5j3wy34kCc2aoHoekS+U2qko8Q3BhFgolEY9QFDlAkUAYkc8VjgW/1RwEg
         bOiAGUETcNZMei3tSu+tmYTLmGoCi+xLcF/y/9AdttVNdpdd8h0aFxnXpFT5rEAlRe08
         0LTmiNbVGXOdQXnlPsh83a/XNWYgnfD5SQ0QmDGDMs+4tZIH43iyhkSqx3PlthZHJXj5
         2fFw==
X-Gm-Message-State: ANoB5pltN7zyaWO/VXnTTgEMMo+KGTicgEsswsXvDSfs290A4n8yOgWr
        s4k/na5bdqeKdKoVcJNNWfaXFHx74bZYvsgYd99trw==
X-Google-Smtp-Source: AA0mqf5CUJ00tzlZ+QA+AQmmOQgQtm7EXeh1hB3NTMG09x2lNEqM+ZfM2ubANdTPEsKAccLrp9xyJC9NA0ivMnBHoaQ=
X-Received: by 2002:a05:6a00:d47:b0:577:8bad:4f9e with SMTP id
 n7-20020a056a000d4700b005778bad4f9emr6603824pfv.77.1670867840496; Mon, 12 Dec
 2022 09:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com> <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
 <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
 <3f83e874-3d7c-cc97-2207-a47dbcfe960f@roeck-us.net> <CAJs=3_D6_TayfdSz9e6P6G+axyUht4iyHnwHgPJ8sXG2a3sm2w@mail.gmail.com>
In-Reply-To: <CAJs=3_D6_TayfdSz9e6P6G+axyUht4iyHnwHgPJ8sXG2a3sm2w@mail.gmail.com>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Mon, 12 Dec 2022 19:56:42 +0200
Message-ID: <CAJs=3_DhEpGjgNZ6+cJiK6WVCQkBYW0V2EvF9vhTW-K6VodB_Q@mail.gmail.com>
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

> Even better would be a separate CONFIG_SNET_VDPA_HWMON Kconfig option.

I prefer to wrap everything with a single Kconfig option.

> depends on HWMON || HWMON=n

Are you referring here to CONFIG_SNET_VDPA, or to the
CONFIG_SNET_VDPA_HWMON you suggested?
Because if this refers to CONFIG_SNET_VDPA, HWMON=m  will block the driver.

Alvaro
