Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC686785802
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 14:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjHWMql convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Aug 2023 08:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjHWMql (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 08:46:41 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E22D1;
        Wed, 23 Aug 2023 05:46:39 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5710b0547easo187015eaf.0;
        Wed, 23 Aug 2023 05:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692794798; x=1693399598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eg8m8m3Txt0N+9hnfhaEqMmV+xfZ84EbGizWfB0wKnE=;
        b=IkSOlsgkfyF93ntLJ+pypYR9kYm0Vm8aT2fgzzGsNportudLVbJtlJoyzHXZWpPmVn
         V9PHZMeDRt4ELm0QYch4YyaAMhiASmNLWGKaHn+FOLV71mEiimSLB7RaLRw6iqxyymgc
         9j9mhUW1ry6g7l4n/zw0nvyueGnUm95EdpbH3KIkPpOW5cEvZJ9oVK+MiN4y9VCV0cvf
         L5L/omzGM+axL5fSYJqZcIdRYjquc6c8w308bRNaPV7rcqZWqGj8NykP4uFjbONX+t1k
         fysRKB0DL2jpiBvo9Y/gIzx+Ax0kqB4XPxkyatQ0AxG5QTpu1u2pp5vMVuyIl5qzrknn
         nXtQ==
X-Gm-Message-State: AOJu0YykrsRcqp7WNUTvTWfo81iox+sCRZcpV55ic4FaFNUH3+Uchcfi
        9U6RjkFX6p91Z+08ILUY/CBCXx6Ar1E/BhAvo7s=
X-Google-Smtp-Source: AGHT+IFSzhPeOu2WXdeN/BSvevGFiWI04i/EWlQwYiSAdcgUW+TUqXf1UThlzpBioi5OugMtb8sYlZ1gRCs1/OdANJs=
X-Received: by 2002:a4a:c3c8:0:b0:56e:487f:8caa with SMTP id
 e8-20020a4ac3c8000000b0056e487f8caamr11923566ooq.1.1692794798581; Wed, 23 Aug
 2023 05:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230822115514.999111-1-chenfeiyang@loongson.cn>
 <c8beef70-1639-c11e-ae38-d8a07279720@linux.intel.com> <CAJZ5v0hpngg6WF7Q2P-MhcTGN8qtAx2U2-ODm=YMzs9=C44DSQ@mail.gmail.com>
 <68a839ff-817e-c5b6-c0a9-7862792786c2@linux.intel.com>
In-Reply-To: <68a839ff-817e-c5b6-c0a9-7862792786c2@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Aug 2023 14:46:25 +0200
Message-ID: <CAJZ5v0gvP3YRWTLtV9_b+W_QQ=K_wkFEDj-qT4cNW2RYfTPEgg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Only read PCI_PM_CTRL register when available
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>, bhelgaas@google.com,
        rafael.j.wysocki@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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

On Wed, Aug 23, 2023 at 9:28 AM Ilpo Järvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 22 Aug 2023, Rafael J. Wysocki wrote:
>
> > On Tue, Aug 22, 2023 at 3:24 PM Ilpo Järvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Tue, 22 Aug 2023, Feiyang Chen wrote:
> > >
> > > > When the current state is already PCI_D0, pci_power_up() will return
> > > > 0 even though dev->pm_cap is not set. In that case, we should not
> > > > read the PCI_PM_CTRL register in pci_set_full_power_state().
> > >
> > > IMHO, this is a bit misleading because after this patch, pci_power_up()
> > > returns always an error if dev->pm_cap is not set.
> >
> > Yes, it does, but it has 2 callers only and the other one ignores the
> > return value, so this only matters here.
>
> I did only mean that the changelog could be more clear how it achieves
> the desired result (as currently it states opposite of what the code
> does w.r.t. that return value).

Fair enough.

It looks like the changelog has not been updated since v1.

> I'm not against the approach taken by patch.

Thanks!
