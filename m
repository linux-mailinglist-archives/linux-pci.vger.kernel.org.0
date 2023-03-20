Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3726C1E69
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 18:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCTRqP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 20 Mar 2023 13:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCTRpo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 13:45:44 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790D39770;
        Mon, 20 Mar 2023 10:41:42 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id eg48so49827076edb.13;
        Mon, 20 Mar 2023 10:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhzCf2AYkG2YKumzfeJoTiU2MHsDxNe3IlKWgvXLaW0=;
        b=50byycMgjUjNfzF0pnipWmJLHfRsw5aOdF1JozeRiW9KbpXQYzFpoevpoL3ytp0hea
         TTX5rMJgBhEL3WmlWBCxWJx8wJC9aCBhcYkEK8pD+y5GdCUiLrYoK5bmwwY26MPPUH12
         g2d2tYzxwqjtecOO5o0VRI1B78UE7n3XJUtxKCWEQFSfPeaIoEUw4IH4uoRT2ZFrhIbl
         CKLTTEG0if4fGmscGkB9UW7pfUYcdGvluIx4ewk9p1cKdqPs9Lk+4bRCI2GHp5qEr4B3
         FN0QogjcTkD2gsQ40pU7aKpT8d+i1zcaZHoYKm/m4TPnSoYKiu2UevuZqlBAKoL3WX2/
         WvhA==
X-Gm-Message-State: AO0yUKWRfYoVb+fBXzRKrPWFsNyo+pgWP4z90UJtWD/4JRDwK0L7CfY9
        YlbS0Qk+rlP0BC+BlYFjvsjlO/UEw4BhfKB6h/lQNss4
X-Google-Smtp-Source: AK7set9ZCAYDwyxGwq/HMIy1Gb0EKrHg3nzqco/G8arJp4ry6hL+DmB7yNw9qpkQBarZZxH1LyrOpeWTV6W5OcD7cio=
X-Received: by 2002:a17:907:86a9:b0:934:b5d6:14d0 with SMTP id
 qa41-20020a17090786a900b00934b5d614d0mr2173109ejc.2.1679334080021; Mon, 20
 Mar 2023 10:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230314164416.2219829-1-jean-philippe@linaro.org>
In-Reply-To: <20230314164416.2219829-1-jean-philippe@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Mar 2023 18:41:09 +0100
Message-ID: <CAJZ5v0jS_YAR8kwEVsi4XZ6Qd2Y1O2nMjaUSaj=NXLPMgw2O0g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: VIOT: Initialize the correct IOMMU fwspec
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     eric.auger@redhat.com, rafael@kernel.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This should have been posted with a CC to linux-pci really (now added).

I would recommend resending afresh with linux-pci in the CC list, so
that the people on it don't miss this.

On Tue, Mar 14, 2023 at 5:44 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> When setting up DMA for a PCI device, we need to initialize its
> iommu_fwspec with all possible alias RIDs (such as PCI bridges). To do
> this we use pci_for_each_dma_alias() which calls
> viot_pci_dev_iommu_init(). This function incorrectly initializes the
> fwspec of the bridge instead of the device being configured. Fix it by
> passing the original device as context to pci_for_each_dma_alias().
>
> Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> This fixes issue (1) reported here:
> https://lore.kernel.org/all/Y8qzOKm6kvhGWG1T@myrica/
> ---
>  drivers/acpi/viot.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> index ed752cbbe636..c8025921c129 100644
> --- a/drivers/acpi/viot.c
> +++ b/drivers/acpi/viot.c
> @@ -328,6 +328,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
>  {
>         u32 epid;
>         struct viot_endpoint *ep;
> +       struct device *aliased_dev = data;
>         u32 domain_nr = pci_domain_nr(pdev->bus);
>
>         list_for_each_entry(ep, &viot_pci_ranges, list) {
> @@ -338,7 +339,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
>                         epid = ((domain_nr - ep->segment_start) << 16) +
>                                 dev_id - ep->bdf_start + ep->endpoint_id;
>
> -                       return viot_dev_iommu_init(&pdev->dev, ep->viommu,
> +                       return viot_dev_iommu_init(aliased_dev, ep->viommu,
>                                                    epid);
>                 }
>         }
> @@ -372,7 +373,7 @@ int viot_iommu_configure(struct device *dev)
>  {
>         if (dev_is_pci(dev))
>                 return pci_for_each_dma_alias(to_pci_dev(dev),
> -                                             viot_pci_dev_iommu_init, NULL);
> +                                             viot_pci_dev_iommu_init, dev);
>         else if (dev_is_platform(dev))
>                 return viot_mmio_dev_iommu_init(to_platform_device(dev));
>         return -ENODEV;
> --
