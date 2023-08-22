Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD997843F2
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 16:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjHVOYY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 22 Aug 2023 10:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjHVOYY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 10:24:24 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB4AD7;
        Tue, 22 Aug 2023 07:24:22 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-56e9b517f85so614091eaf.0;
        Tue, 22 Aug 2023 07:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692714262; x=1693319062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmSCrZH9zH56Z617nsLmAsTMojl4ZJS3KiHCDxmS6QY=;
        b=QVJPu/Xt8Az9RpnmeBUhK4HXvN9PlQDrhf0sZYRhVJl+deJ3X2dGhIkal5yvsNul4W
         uS+0Dt0KcMfPorpgiC3v3Qjxdmc+4ZVlOuGO9pm13z12xqR5u0uoVzbkiNeqSOAmSNoU
         HUfkPN/MQ8kgVmyM/flozhppF2qB0qoVomPWR7iUfrxV5EGv68t8J2SlEFbmpLbRWkL/
         BjFioeDZ6vDYW+Ha17SXFBR+QyfsNyiP4wiVFHl+IGd/1QPRjPBkYDKesRFeKKVP/Bm/
         i43z3v1qen0+4Uydn1Kfw2tp5ljfr2uHDpFqCSEMTMVdBBgtAfr60I35Rws1yBUM6f86
         E5kw==
X-Gm-Message-State: AOJu0YzPgl/OiC+qvpVmuGmScQ1MwQq2ZePuAWUOSkKisEOyGp2Q6I0F
        FlHKy9xBqXDRPmeH8mTYLPYR6qDbYUZmEMH9SOs=
X-Google-Smtp-Source: AGHT+IEEdGlZBWwY7yJerpt9YwN/bszz4ZO++XFidrVpQNglkrKdNyEcCzGGMOCj/YAvRnZxQSAu/+zCkvgnsu5Yohk=
X-Received: by 2002:a4a:bc85:0:b0:560:b01a:653d with SMTP id
 m5-20020a4abc85000000b00560b01a653dmr9136308oop.0.1692714261958; Tue, 22 Aug
 2023 07:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230822115514.999111-1-chenfeiyang@loongson.cn> <c8beef70-1639-c11e-ae38-d8a07279720@linux.intel.com>
In-Reply-To: <c8beef70-1639-c11e-ae38-d8a07279720@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 16:24:09 +0200
Message-ID: <CAJZ5v0hpngg6WF7Q2P-MhcTGN8qtAx2U2-ODm=YMzs9=C44DSQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Only read PCI_PM_CTRL register when available
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, bhelgaas@google.com,
        rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com,
        helgaas@kernel.org, anders.roxell@linaro.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        guyinggang@loongson.cn, siyanteng@loongson.cn,
        chenhuacai@loongson.cn, loongson-kernel@lists.loongnix.cn,
        chris.chenfeiyang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 22, 2023 at 3:24 PM Ilpo Järvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 22 Aug 2023, Feiyang Chen wrote:
>
> > When the current state is already PCI_D0, pci_power_up() will return
> > 0 even though dev->pm_cap is not set. In that case, we should not
> > read the PCI_PM_CTRL register in pci_set_full_power_state().
>
> IMHO, this is a bit misleading because after this patch, pci_power_up()
> returns always an error if dev->pm_cap is not set.

Yes, it does, but it has 2 callers only and the other one ignores the
return value, so this only matters here.
