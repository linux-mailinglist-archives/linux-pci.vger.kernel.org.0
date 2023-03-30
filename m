Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994EF6D0CA7
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 19:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjC3RWf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 30 Mar 2023 13:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjC3RWc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 13:22:32 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AB0E06A;
        Thu, 30 Mar 2023 10:22:30 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id ew6so79315712edb.7;
        Thu, 30 Mar 2023 10:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVAn4wR6MEB1azuZNqppvLy3xIslL0OfTJA1ojOVPMs=;
        b=6LpbL61VMiYMF4ttOaHt0LLFF0gKs591U4zPcsOztQReayV/pm1S7laRvapNeffI/6
         eNbmaEvXuBKt1XmitCJ6uzQahH20marGB1hUPEBNwzRenYtwsoZVUYCQXZsedx3PlRFb
         XKxMwrZ1MebRuxJbXmN0iTMWM/7ygZjSD10pE7KMC7zruVYawrivs3Isn2LolADNe1Cw
         3n+VJIH9/QnXqXAM0+nAp66B3nGbILrH8DEwtmHHBUy7Yfs1tj37nqLLNBIrtHd2WHw7
         5qCo/9G2n/qoX8Ponk5RwUc83uaLukYY+/K87vKuwYeIckSyqa1xjaUMfUDWsiMjObdx
         iPmw==
X-Gm-Message-State: AAQBX9dS35sp0BOeMGaaJfWTSUO+hE+DGwb/fCG+9JNsVWs8uiHYGd7z
        qQo87p0yril/FcXtTdrGmS8aRqHu9uLmz0E8zgnbKizk
X-Google-Smtp-Source: AKy350aWoTnfeNTO0Zh34lQQjCl79sTr1N4Q92wZJzRbUTZGgAbJgGc97/iIuq9rCgZAjBTQ33hmTNwCgef6g8VRQ7Y=
X-Received: by 2002:a17:906:fe49:b0:8b1:3298:c587 with SMTP id
 wz9-20020a170906fe4900b008b13298c587mr13056544ejb.2.1680196948585; Thu, 30
 Mar 2023 10:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230320180528.281755-1-jean-philippe@linaro.org> <1a227cc4-217b-01aa-ecee-9819160d9a44@redhat.com>
In-Reply-To: <1a227cc4-217b-01aa-ecee-9819160d9a44@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Mar 2023 19:22:17 +0200
Message-ID: <CAJZ5v0hv3B-J0EOUxuKXAatvnpo463OpYLTEAzar-FS7onp21g@mail.gmail.com>
Subject: Re: [RESEND PATCH] ACPI: VIOT: Initialize the correct IOMMU fwspec
To:     eric.auger@redhat.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, helgaas@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 22, 2023 at 11:04 AM Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Jean,
>
> On 3/20/23 19:05, Jean-Philippe Brucker wrote:
> > When setting up DMA for a PCI device, we need to initialize its
> > iommu_fwspec with all possible alias RIDs (such as PCI bridges). To do
> > this we use pci_for_each_dma_alias() which calls
> > viot_pci_dev_iommu_init(). This function incorrectly initializes the
> > fwspec of the bridge instead of the device being configured. Fix it by
> > passing the original device as context to pci_for_each_dma_alias().
> >
> > Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
> > Reported-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>
> Tested-by: Eric Auger <eric.auger@redhat.com>

Applied as 6.4 material, thanks!
