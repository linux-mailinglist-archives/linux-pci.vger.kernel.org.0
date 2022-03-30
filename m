Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006FA4EBFA1
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 13:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244116AbiC3LPc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 07:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343541AbiC3LPa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 07:15:30 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B771E23BFB;
        Wed, 30 Mar 2022 04:13:42 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2e6650cde1bso214777197b3.12;
        Wed, 30 Mar 2022 04:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9LtN354uVuUYmVb2mASO8NEBFMkBKelxqOXNVRMI1A=;
        b=XqJegpkErBHQu+EhoXrl9y5OSLjp/YZKurs5eTx/HohGEjZTNK1HrCLgps4qVdVMJq
         70LfDEoyiULkfV9JmrVWcHKcSvdaEIJwcUkKdI3DylWRqBNE8KPsZY2taz3HtMFXgZN2
         3ze63H27BBKdUXo6Dgkb+n87zXq+q9etgOQUnNDiN32uAjcIslbqHcm0RNL5RbmeIGcJ
         KknspNkXWh+uAOiBXKvs2oUv1b7hrBOnHNk0m8/kdiCjtpDPVFyRZrMlihJ+fC5QGPKU
         jUkcO4K53Ifrrz2icLKMum1Y0icghvS5B2uxltugHc5o6MMQ6emGLwfCeoDmuPqNx1aS
         1Egg==
X-Gm-Message-State: AOAM533LKmRK+zvDvrvSMU9C3SGujInzeKt4L0Eg/N9RGMDuCva+3pVw
        vpE7xoUDKQVQXCs0zWeUy7uqilFFpIa8BA/SWM0=
X-Google-Smtp-Source: ABdhPJz63lQUAbKwHsXnq3i2ewkJOjPWbatjhaAuYA6ElUjLgJFwKEKLZx/MotMNC3w9/8M8yzIvMkWAo1h4DpMfPuc=
X-Received: by 2002:a81:6887:0:b0:2e6:126d:3102 with SMTP id
 d129-20020a816887000000b002e6126d3102mr35867153ywc.7.1648638821666; Wed, 30
 Mar 2022 04:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220328230008.3587975-1-tansuresh@google.com>
 <YkO7d7Eel4BVQOy4@kbusch-mbp.dhcp.thefacebook.com> <20220330062516.GA24340@wunner.de>
In-Reply-To: <20220330062516.GA24340@wunner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Mar 2022 13:13:30 +0200
Message-ID: <CAJZ5v0jUuv7+j5M7xKhC2BdNdj-t==f56GbSDK_Tfrr7=pMcLQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Asynchronous shutdown interface and example implementation
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Keith Busch <kbusch@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
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

On Wed, Mar 30, 2022 at 8:25 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, Mar 29, 2022 at 08:07:51PM -0600, Keith Busch wrote:
> > Thanks, I agree we should improve shutdown times. I tried a while ago, but
> > lost track to follow up at the time. Here's the reference, fwiw, though it
> > may be out of date :):
> >
> >   http://lists.infradead.org/pipermail/linux-nvme/2014-May/000826.html
> >
> > The above solution is similiar to how probe waits on an async domain.
> > Maybe pci can schedule the async shutdown instead of relying on low-level
> > drivers so that everyone implicitly benefits instead of just nvme? I'll
> > double-check if that's reasonable, but I'll look through this series too.
>
> Using the async API seems much more reasonable than adding new callbacks.
>
> However I'd argue that it shouldn't be necessary to amend any drivers,
> this should all be doable in the driver core:  Basically a device needs
> to wait for its children and device links consumers to shutdown, apart
> from that everything should be able to run asynchronously.

Well, this is done already in the system-wide and hibernation paths.
It should be possible to implement asynchronous shutdown analogously.
