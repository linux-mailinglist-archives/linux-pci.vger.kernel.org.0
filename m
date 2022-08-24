Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EDE59FD81
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 16:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbiHXOqD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 10:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbiHXOp5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 10:45:57 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE9671724
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 07:45:53 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11c4d7d4683so20986340fac.8
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 07:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xJW2jI96Zwcrvy+eTtY4zwb6R7KH49EInbBsysTbn04=;
        b=VhZ1r9dZw+q80O6nYjGPVr3Ni0ZZ1y1ZdEbIemDT/Di6L0qxY/Ro2D2l+08GZvkmkm
         ukKNV0tJ6aDz+zMJ1XKSVlUh6dnx//7R+ufQT0kH5YQ7laUchITugBQMDWGJ1NAIZ3Vd
         ghRuDpnMAINyfbwg/aLX+/9jH2RlbDkUk7UuiG9MqBHkx6/VkB5uaIylZs4Jp7n55sau
         wo3eS/AbWetL4ts1TRUXKjAeGnK6i3iV0OHPFplupPkUxwYXpbB+sUYVSyIQH9g2rlrC
         7grIxYeK4TwjZ7x6R7ABxXZheJ+50ruDEKqTf3iHjm2ho15RdQBmamCGbZAv8RzJJM5V
         slqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xJW2jI96Zwcrvy+eTtY4zwb6R7KH49EInbBsysTbn04=;
        b=ERx+Q9A2arxLY9+LcEw1M7Z/T7pIVPggPk8CV4tGjV2QxNDsBIOvPgUS/ytRV6f0Bl
         Cu4XYMzdIsluifGMzXd0ubqq9QH8dhj+W4/TZVpA8tsVP586AW+ujpPv+uoJXkrAZCa6
         KBrx2N15/BDebUUIyrf+Gk00ig9Ez//mJ1kQLEZjIn37pObNokg+c2E69EMvq9w3uT59
         eXYySO3E4TBsTVEoyov+egut3p82WUbvKF/81WTGpuVNGtUTyjiaUThD/bveUV01BjFb
         rFLIDlvE87TnV5AOmtjmp+F6yNJx7W5M3O66h9vlE6j+0QVWgUILTdC4ZxAq/57LhAln
         Bilg==
X-Gm-Message-State: ACgBeo2j7WOmYGr/Oq9VtwC9YZlSV/ozk0hVwWIAXKINKXw2DTfEgCEC
        qQCmj8bfob/MAdntY/yoECgjWXwKLd5Xj8LO7A4=
X-Google-Smtp-Source: AA6agR66fkmkvlbzDo7a46+yk6fXL1KDXUmUWrF+QVrtdW+IrekthVSmJuG9nEr3Bc6wthKrZ+24RcujERHX4470XWs=
X-Received: by 2002:a05:6870:5a4:b0:11d:37b3:ff54 with SMTP id
 m36-20020a05687005a400b0011d37b3ff54mr3703850oap.172.1661352352883; Wed, 24
 Aug 2022 07:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220819190725.GA2499154@bhelgaas> <6aad506b-5324-649e-9700-7ceaaf7ef94b@amd.com>
 <CAARYdbhVwD1m1rAzbR=K60O=_A3wFsb1ya=zRV_bmF8s3Kb02A@mail.gmail.com> <30671d88-85a1-0cdf-03db-3a77d6ef96e9@amd.com>
In-Reply-To: <30671d88-85a1-0cdf-03db-3a77d6ef96e9@amd.com>
From:   Tom Seewald <tseewald@gmail.com>
Date:   Wed, 24 Aug 2022 09:45:41 -0500
Message-ID: <CAARYdbhdR0v=V82WnQOGBNrcth8z6F_61SxG9OTzgNpgg3xx7A@mail.gmail.com>
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
To:     "Lazar, Lijo" <lijo.lazar@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, regressions@lists.linux.dev,
        David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
        Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stefan Roese <sr@denx.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 24, 2022 at 12:11 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
> Unfortunately, I don't have any NV platforms to test. Attached is an
> 'untested-patch' based on your trace logs.
>
> Thanks,
> Lijo

Thank you for the patch. It applied cleanly to v6.0-rc2 and after
booting that kernel I no longer see any messages about PCI errors. I
have uploaded a dmesg log to the bug report:
https://bugzilla.kernel.org/attachment.cgi?id=301642
