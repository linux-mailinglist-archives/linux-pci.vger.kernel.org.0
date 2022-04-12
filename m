Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537AF4FDEED
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 14:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348856AbiDLMCT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 08:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344748AbiDLMCK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 08:02:10 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18403673DA;
        Tue, 12 Apr 2022 03:57:13 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ed65e63afcso37161307b3.9;
        Tue, 12 Apr 2022 03:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaflxtjiKkxyQsuVHjWDitjpj4rR193VNQfbaSulm+s=;
        b=69zQX/d8z1w1b30EETIqSMYqlqtkdJ+Rkve2oyhQSpNvc+A10ZH3cPnRfwgBsjOKYz
         Rbl8zxjA8d6IljjYDsPnQrF66aF6BOJRsjU0xXcMuC8+CWVNiY4+lfJrUTFfqVVO9N1u
         /Gco4mWVift0Cn7NQuaXc7hPq7W6lnlOGjLAzb2uNKHMdh7jnQNCYul1aU3vd+znshAo
         pYCwvU227ikf2DPB0WWJjwHsE2koad3ikabWRDanbrjleWlkQrOaV6Vq7N6JifXPkwK2
         AsnazcZboq5j/yUW9InhATSpKRfvWfu9fCHObMkKQuGgjbOJEIBjR0KBNW/q/I23H6PU
         Uofw==
X-Gm-Message-State: AOAM532Iega3dPX8rzkodURY+D9orrGipYG2f7mlbyS6rhCxniCtVPQr
        0JhSZ++4JPBCTl52LDYyDOAH0JkeRXYXQ/mEXE8=
X-Google-Smtp-Source: ABdhPJz1z+xluyOTJtty+XCL5wZ0FrG6XQd1t4Tc/ElfX3ah4G+SIm4TesoFz04aTAkcK/J0gGIgDdonVP25C4VEhg4=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr28631839ywb.326.1649761032367; Tue, 12
 Apr 2022 03:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <4419002.LvFx2qVVIh@kreacher> <11975904.O9o76ZdvQC@kreacher>
 <4721615.GXAFRqVoOG@kreacher> <YlVJorXPD1EoqVCB@lahna>
In-Reply-To: <YlVJorXPD1EoqVCB@lahna>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Apr 2022 12:56:59 +0200
Message-ID: <CAJZ5v0jbTh13tf_Kv9+8BgsQSrNX0KhR6EWJEiWuMuDpG6a-Bg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] PCI/PM: Rearrange pci_update_current_state()
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 12, 2022 at 12:54 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Apr 11, 2022 at 04:21:04PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Save one config space access in pci_update_current_state() by
> > testing the retireved PCI_PM_CTRL register value against
>               ^^^^^^^^^
> retrieved

Yup, thanks!
