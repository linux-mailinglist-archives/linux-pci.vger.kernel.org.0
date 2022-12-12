Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6EC64A8A3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 21:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiLLUSU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 15:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbiLLUSS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 15:18:18 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33F52670
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 12:18:17 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso1176043pjh.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 12:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=axhmleuH8rpWvYOnrEikJutSJr7tOe+t2XEG/Vl+vQc=;
        b=tWrwRuw+j/boDtM3gaZ778LpIC001lK9QGYYUMX9E9RltU8x4J4umuRNOae8QzTVAQ
         FTjxY86vc729tJulRuxmao1ufLPCjmc3hQ+FDzqU63T37gwHn2doK6/rc6vFahDZUprz
         lC4Eult3Y71ap/gHA8nE6oUPGEEqGnZHU0FhYANh9kefc/2SqzXv3v/n3bjc68mv9iEz
         t6+EtMA+2RKvPhqC4dK4KVUgW9eX6BpP2zOnKtvC1UvDt8PKgyEuBvXVBRHEBO9WEuy/
         8NNxv9xYJtfDgC/p2Pdbs5fIRkkiCP3qtu4bGAktkQkVP2WMyIkLENZu1E4Sr7mjtLDP
         A9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axhmleuH8rpWvYOnrEikJutSJr7tOe+t2XEG/Vl+vQc=;
        b=fyJdkHaEcH4GFYEMVqpBSI7yXkCsWenSizldlHosyGzLFM18ZUQT7SLoNd4eCD9HHH
         OdImL3U9GgtF7ME6AIp5W1eg8MPBAC8K/vO7xgb0b3dOFONtyqBXof3SKp3+Wp2gmgBf
         qORiLvt9A3bu0ggdNwmuoJlmdCkkqhkV5pVlCqJME0vp82ugsm7oJcX1ehyM2A/SLj1q
         8lvF7m6ab3licki38PxSybdAbJ74bhwT5xUlXOBNg5LTyjSa9BxJg5py/5K2Bm8+L6i8
         tG8D9wiFM+0R60bOecPQX8RItzBdMNip3CIBQzvLS7ULO/ZVoBBd5bM2cQqvDmkphRnq
         dihg==
X-Gm-Message-State: ANoB5plNce0VB6yMbBLH2sj8ueTn/uXwjnflWVpl3KRodTUzWBNbJDpN
        98p3Z3jQOUwg0pPHqcZAln6b9KdHaMa/sM35dHnNnQ==
X-Google-Smtp-Source: AA0mqf5WNAvXFSTfWfvUwZfrRe1Gym0jHQBebEfisP8IEEnEdxx5vnffhLqwK7ffd7oDRYtVx2rRNoXRJrVB+lu2tK8=
X-Received: by 2002:a17:90a:a00c:b0:219:6b57:9e77 with SMTP id
 q12-20020a17090aa00c00b002196b579e77mr34340pjp.120.1670876296957; Mon, 12 Dec
 2022 12:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com> <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
 <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
 <3f83e874-3d7c-cc97-2207-a47dbcfe960f@roeck-us.net> <CAJs=3_D6_TayfdSz9e6P6G+axyUht4iyHnwHgPJ8sXG2a3sm2w@mail.gmail.com>
 <CAJs=3_DhEpGjgNZ6+cJiK6WVCQkBYW0V2EvF9vhTW-K6VodB_Q@mail.gmail.com> <f02e6f0f-d144-3eed-03e2-e55f459f666c@roeck-us.net>
In-Reply-To: <f02e6f0f-d144-3eed-03e2-e55f459f666c@roeck-us.net>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Mon, 12 Dec 2022 22:17:39 +0200
Message-ID: <CAJs=3_Aso4kRbMao-mfeD3B-DX8vgryCZVP96-U+_53CEZu3aQ@mail.gmail.com>
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

> No, it won't. It would force SNET_VDPA to be built as module if HWMON
> is built as module. Then you would not need IS_REACHABLE but could use
> IS_ENABLED instead.

Ok, thanks Guenter.
I'll create a new version tomorrow.

Alvaro
