Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C798E650A74
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 11:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiLSKzp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 05:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiLSKzn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 05:55:43 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543CE1E8
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 02:55:40 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t18so5908643pfq.13
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 02:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bcUxBgVr1z9DyQ4ZN2GN42Ihfr7E/yAe4kWvlKo/9VE=;
        b=hz/LA/UWMhUrKc88oqLv8a5AOO+B6sEdDVPbcCMjTKBSYTkliVR/8zKqmlC1v3srEO
         3puDnIEUH6kSdA4wITqevLiygPOddqtvdL9C/cWGPUFobBkoYS34CRZxlaGnu2hxyKRQ
         VnpmjX86mxK0ZFWPu6BNfn25mZRdsDUcJyruWO+4ymiPxVtGblaXosEWCxp82YSzLNoM
         1ktZkcXqATyd3RM32EDtBUEnYwlNaqnmmXgoEI3WZ4hlYl8iabTLp0smE4dSyEGyZa0E
         te8nPPmEDLv39jRYjRbJlWXDWTWmCGzETgZRULoFooKFPGkWXECXORBuXWny8bEzlIyj
         ek3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcUxBgVr1z9DyQ4ZN2GN42Ihfr7E/yAe4kWvlKo/9VE=;
        b=PYHwHuFDwxaOta7JRbaprmT2WbOSGnzZXn8HwhF9KigHXCLpG2zdNMRmpv/J684HfA
         HJ8s2BHy20PmlbB75SATXbmxA9KfC51tM/2yL6c3wAuHDKExbV8f/nfCpztJVgvLxWdA
         nJQCFiY0K5hVW8NQYtyJNrJIeg7QpEfUlMihFPaA2zCKObsmqBYlC3/gUJbwmIL7nCze
         2Ch6X+x+IEjl6fVuNKSWiVvrA13PP05MudxqZ/ZAjAldOIzH9xy2vocHie0kdI63rlRE
         l00epTXdP2jot8anpbHL2GfblRLLRCJ/eiPj2cY4y2/c2+dTChO8xvN3kVA/O9ZwC0Xa
         O6CA==
X-Gm-Message-State: ANoB5pkD7C1iON06RKu6j26/L+PxVJg0jhQsgHAKPdwftYUYbys9AmCi
        SpJlvH5eU67GF+OhQrWxjifxoOecVbt/eWaw7DfKZw==
X-Google-Smtp-Source: AA0mqf7rPC0YgLWsVPpb+FmNTD+eVkLuI7fLf1hvZREsRO6CU3k+C4ECG2TcrBjQHusbGAQIeozy3w9W4ChOzgQ5SFA=
X-Received: by 2002:a05:6a00:10cd:b0:572:5c03:f7ad with SMTP id
 d13-20020a056a0010cd00b005725c03f7admr100325300pfu.17.1671447339734; Mon, 19
 Dec 2022 02:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com> <20221219054757-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221219054757-mutt-send-email-mst@kernel.org>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Mon, 19 Dec 2022 12:55:02 +0200
Message-ID: <CAJs=3_B+NB9LuqDBw_1a_6mXGCP2rA6bsrxLuoQ6gWdEg-vscg@mail.gmail.com>
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

> could we add a comment explaining this trick please?
> can be patch on top ...

Add a comment where?
Do you mean adding a comment in the change log?
