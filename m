Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5E064A523
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 17:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiLLQmN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 11:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiLLQlT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 11:41:19 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E351164B2
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 08:39:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id js9so334094pjb.2
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ehhV0zb8kSbVJbPicNJTUd5tnXvyUTppxVrH8Mn4ijM=;
        b=Qcg4chnbsG6R8ccYYan8ap4SPziBfhNgFCfHkGMvsmrCfLcwgISGtOsoCExNbNkMoz
         SETOpz8gbuT/Z7QPSepJA/KfBcJfj8WXVv1ULQuaMg3Wf/+OZO4iyGnriTdfo59nVKXO
         PvxcdQeDwnshuY69o4sLvalOA8SLaViBMR1vnCtqqch0V5NwCL813GVYn99DBp/QG67l
         i/JMtq7tdDBH1iC5nf9UWgQWSMVfYrpARubgB1IjRMrvhoJgWFndpsabfDGQtcudsAEc
         4CX/IeWRrgez6XsMWEChDDm5T7GfjuUVEVa4GICbYgXdGMCknjqQEAYgiqQk/AXBbDYJ
         mj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehhV0zb8kSbVJbPicNJTUd5tnXvyUTppxVrH8Mn4ijM=;
        b=QLYiH2/DbJlbhAzzJLE9bFNvQvqr85mF99G31ZQ2B0ITrxZzb2Vgxu4FicaHn427gF
         H7clycJkcaRUec1GNkRsvdv40d6UG4fgBL+HgQ2fNJFbpIe5qVi/HxOylcujlQAb33IG
         jmtaXZ03Gctk94EleUL+sQ2u+WAYIeuYK9/23Agsi9Vn0pngw03V5aQdUZBuVSEELqo1
         Kqp+2fLnZehCX8ASrvEu9GWjYLL3HSIFuglbiZH0VXnNKOBmuuUzaYRZ4P/MhcsMaKyF
         mBUv5NADKCABd8wnr6NFbjheLuEXC/a43URPbptutGM1IrT6au2KXeFxmyCCqcM2vcid
         8JjQ==
X-Gm-Message-State: ANoB5ploZataSny+4huENWO131zE+Uwa6/7oGCeWxbI4claaSvRSYanA
        5dGp2AwkOeV8O8WTsx9/kRQSeUrC1LuhdIYug97Idw==
X-Google-Smtp-Source: AA0mqf65BAor0dB27LuDWQIDW98Xa6fxCeLjNlA8eDN4yFyjx2q17O5LBarg8BmiyHDSGuSjFP000d27vqJgexiGzvE=
X-Received: by 2002:a17:90a:6d62:b0:219:4ee5:ccc9 with SMTP id
 z89-20020a17090a6d6200b002194ee5ccc9mr49431166pjj.63.1670863142960; Mon, 12
 Dec 2022 08:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com> <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
 <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
In-Reply-To: <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Mon, 12 Dec 2022 18:38:25 +0200
Message-ID: <CAJs=3_Dc8z3gSorauZSof8koZV2jME5Y1LPTxj3CVgfAZPWZvA@mail.gmail.com>
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

> solidrun/Makefile:
> obj-$(CONFIG_SNET_VDPA) += snet_vdpa.o
> snet_vdpa-$(CONFIG_SNET_VDPA) += snet_main.o
> #if IS_REACHABLE(CONFIG_HWMON)
> snet_vdpa-$(CONFIG_SNET_VDPA) += snet_hwmon.o
> #endif

I meant here
solidrun/Makefile:
obj-$(CONFIG_SNET_VDPA) += snet_vdpa.o
snet_vdpa-$(CONFIG_SNET_VDPA) += snet_main.o
ifdef CONFIG_HWMON
snet_vdpa-$(CONFIG_SNET_VDPA) += snet_hwmon.o
endif

And I'll use
#ifdef CONFIG_HWMON in solidrun/snet_main.c and solidrun/snet_vdpa.h
