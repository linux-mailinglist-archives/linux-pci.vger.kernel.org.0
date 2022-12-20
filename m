Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC068651B9C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Dec 2022 08:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiLTH1O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Dec 2022 02:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbiLTH0T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2022 02:26:19 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A2167DF
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 23:26:17 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w26so7924034pfj.6
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 23:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oyr16lkkO+f52LJilby/v2FdwozTbFlzoHJ/tqUoOH0=;
        b=V/ydCelJ/1e4NaKd/oZmpUIGZ5NWJzikt1y9DeK3EnIBX7Tpsl2sBZmrsrNIoX4u0T
         WNu1OcpcjMCKuaEWsc9xlaQdAE1+8wmsGroVRqS/ZTbCzTypU9ZP3cs6KgF9QLpKqIz/
         yTRbb/yoteeZv7Bx/U4cVyZkNW9nlfUtkEQBp6ribd5iPly0/dnzdRiOtn6Eyy8ErE0O
         aWVkP73RN+hAEWlGGAteu86kxtOq4cRk5dggcFn23gtLeOjU3V0+73bBGfcUGscDRk66
         q92b4LhF0yrdQNy822RyEEXY916C9PBjAbTiDtdFhXyA1jtM1x2c7d0ULeMGiqdG+FaT
         Jjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oyr16lkkO+f52LJilby/v2FdwozTbFlzoHJ/tqUoOH0=;
        b=KnQwHBXy3E80gmY//xYEVVhWpf/40Hvfs9HSh0XgtRN+hz7b3vUGGWPBmcWLiekie+
         Y346XdmYolptdDJFfdMjHGfta1kwRk88NDxQQGgvqf1DeeqToSm40pJEsp2JL2JzeBUF
         auanNPzbmNQ1KgFwx850TjG4a9na7OEN2T4Knc/omy8GvxoZmOgaZmWREtgdoRfX62y6
         dyM4z89lSDB1b67gIsjjJg9p7hXzy6RCIeSNkd16GfW7HOTCzzgFcsz9KT+aqQHKM+V3
         sVutBOsf1xFwhkg3jQYbKhbjo6iz0P+rsHoL3o+CObrcecX+q6EALBpJCfTwM+B1xVZ6
         jlSQ==
X-Gm-Message-State: AFqh2krLxlM7HOZL9DB2I0CW9ulVke+LdEccGtvrzsC+UoO6K383kDyT
        Ep8Te1K6Psqtb+n1hgkA4z2E8SUSuIH8boEtuG35Uw==
X-Google-Smtp-Source: AMrXdXvgorYeaCukKa+Ic1F+7aqNFQsn9V+GDrAfXDBuRuhaW9TbfEfOw8D+OyfPUBv+NJHe/nuip5DKTGbcS11svBA=
X-Received: by 2002:a63:ee44:0:b0:489:17a2:a53d with SMTP id
 n4-20020a63ee44000000b0048917a2a53dmr499886pgk.255.1671521177155; Mon, 19 Dec
 2022 23:26:17 -0800 (PST)
MIME-Version: 1.0
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com> <96d85666-106b-a43e-6115-b9959b4e3e66@redhat.com>
In-Reply-To: <96d85666-106b-a43e-6115-b9959b4e3e66@redhat.com>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Tue, 20 Dec 2022 09:25:40 +0200
Message-ID: <CAJs=3_DkqB=6MXfUd02j6kKXahS6AWLRes5NUjj9Wp9iRecewg@mail.gmail.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jason,

> So I think we actually don't need to depend on HWMON here?
>
> hwmon.c is only complied when HWMON is enabled and we use IS_ENABLED to
> exclude the hwmon specific does.

We are not really depending on HWMON with "(HWMON || HWMON=n)"
If HWMON=n, the driver can be compiled either as a module or built-in.
If HWMON=y, the driver can be compiled either as a module or built-in.
If HWMON=m, the driver will be forced to be compiled as a module.

This technique allows us to use IS_ENABLED instead of IS_REACHABLE
