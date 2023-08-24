Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B8D786495
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 03:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbjHXB2S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 21:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbjHXB2F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 21:28:05 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E792A8;
        Wed, 23 Aug 2023 18:28:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ffa6e25ebbso485210e87.0;
        Wed, 23 Aug 2023 18:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692840481; x=1693445281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vetduGgViyjJuBVB9gXghwBbpYcZ8lgc6rsEZ+ryBhg=;
        b=bSPmJe7askH7b9NH4mjqq6RLQC6eX0h5LXpSMm8NM6ys8+iLfWFFcs5CzdsXh4pKE9
         qFLctkzCQzkdxYUm1VpTW8hNn0+HY57iabA36hAMbn5n8N/9dy0SiBHxpHzH/w10JKuM
         mRnpIsqCND3C6BrmGekgBOTcA2yUgIeGtM3sZ60STB+b3pkhzzOAdHal6gS6dyK/pyB8
         yz9Km4D6q8iokTdZdGaTpyi1BPpIiPiA6Ks7QpZY+53Voa3iEkKV3RTyt8GzVhWDMXSL
         NRrSGqvtFEAhUux7POZyI2GNNkWac/19vUWIPUIKTCvZPz+JdehTW9P+iERmWneG+t29
         +u/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692840481; x=1693445281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vetduGgViyjJuBVB9gXghwBbpYcZ8lgc6rsEZ+ryBhg=;
        b=liT9Kw9J0jzM7GcqGx4swcip2TCkNfQjpFsWvUCLlVdMB7a6UybbvHgB/gtIH0Ih5O
         gjanRfUnaBYciVSU4I6IJgAx4ZPbT9xlYA/pztjXGGLZjcBetPUkye1wEXGFxN9VRfKu
         3ozmc/UiBKY5ffdlJvVxdO5IjrYXqPLnxqmdz5zYWtX8YKY8EX+cMq1yZEngTh7yJBiC
         MUbTwegZMxsB+GUpxfWST0Wxah+O3cPgCo2hPxZG0sGvrn9YZl/RLedHtvWZ1TNVmt+z
         H/Fp5CaZnGnn/WIV7Gwwm88PsIqWJAXZ0rl7t2YaijGMo0HBy9k0J6CTSyjcUTUb//qY
         fiLg==
X-Gm-Message-State: AOJu0YxkcrPXm0+DHz4XTMY60vEpcRdYZDZHZPZrNyJHYnd8DNEROKBA
        yV17WdhQt9c7vSF/9f6cDVdcbupPiPSj6q8+TzyrgRMc6/E=
X-Google-Smtp-Source: AGHT+IFi/Mw7Vt2L+WyArvzM1+AIiEFUSEpUSgFh1dVwGs4f+9QtM7KcOZYse+N1/w7fBFFj2jDgMctFRlOKndymaYc=
X-Received: by 2002:a05:6512:615:b0:4f8:5e62:b94b with SMTP id
 b21-20020a056512061500b004f85e62b94bmr4577882lfe.9.1692840481031; Wed, 23 Aug
 2023 18:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0gvP3YRWTLtV9_b+W_QQ=K_wkFEDj-qT4cNW2RYfTPEgg@mail.gmail.com>
 <20230823205024.GA481013@bhelgaas>
In-Reply-To: <20230823205024.GA481013@bhelgaas>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Thu, 24 Aug 2023 09:27:47 +0800
Message-ID: <CACWXhKniWqJBHaMk7jQUnuF7PGHxoOtFQ4fYpHxFRkJ+9n5mJA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Only read PCI_PM_CTRL register when available
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, bhelgaas@google.com,
        rafael.j.wysocki@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        anders.roxell@linaro.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, guyinggang@loongson.cn,
        siyanteng@loongson.cn, chenhuacai@loongson.cn,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 24, 2023 at 4:50=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Aug 23, 2023 at 02:46:25PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Aug 23, 2023 at 9:28=E2=80=AFAM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > > On Tue, 22 Aug 2023, Rafael J. Wysocki wrote:
> > > > On Tue, Aug 22, 2023 at 3:24=E2=80=AFPM Ilpo J=C3=A4rvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > >
> > > > > On Tue, 22 Aug 2023, Feiyang Chen wrote:
> > > > >
> > > > > > When the current state is already PCI_D0, pci_power_up() will r=
eturn
> > > > > > 0 even though dev->pm_cap is not set. In that case, we should n=
ot
> > > > > > read the PCI_PM_CTRL register in pci_set_full_power_state().
> > > > >
> > > > > IMHO, this is a bit misleading because after this patch, pci_powe=
r_up()
> > > > > returns always an error if dev->pm_cap is not set.
> > > >
> > > > Yes, it does, but it has 2 callers only and the other one ignores t=
he
> > > > return value, so this only matters here.
> > >
> > > I did only mean that the changelog could be more clear how it achieve=
s
> > > the desired result (as currently it states opposite of what the code
> > > does w.r.t. that return value).
> >
> > Fair enough.
> >
> > It looks like the changelog has not been updated since v1.
> >
> > > I'm not against the approach taken by patch.
>
> Feiyang, would you update the commit log so it matches the code and
> post it as a v3?
>

Sure. I will update the commit log.

Thanks,
Feiyang

> Bjorn
