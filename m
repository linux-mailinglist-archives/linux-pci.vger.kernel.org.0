Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB4786091
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 21:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjHWTXT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Aug 2023 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbjHWTXC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 15:23:02 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06B0E50;
        Wed, 23 Aug 2023 12:23:00 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6bcde3d8657so976630a34.0;
        Wed, 23 Aug 2023 12:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692818580; x=1693423380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTrH4o5ux4AfIjhNwUonXXt16pkl+RCpCrneQG4XR6k=;
        b=bmuiIdnvOGR88TP4MMAQXWCHenmT2Kc6fDb8K6MUej+/xxcUr6TIA2jFa5BfFwJCyj
         pdHXfrg+RvN88vEZPDTEzjJ4xkcErQfeC0Sc+KipVb1Y9vMEO1KM7m5/ZQMWSi1n8kls
         n5KDs0otVKpTe8H0GGhTywFCxU8Lr8ZdCByvwFiTETfCxsjA5W1pw9jz+MmkUjyeRF4G
         6dtamN/nNzRcjI+DhPAdSWC/HKnBuwzbJSYQcC64rpAurbyzRUyNUiAkStzWjm+ngmGN
         Ay8p6sdpXL+moEK6FTqSe5pbi36Um9GHAeXxGPwbBHo6Y4lPwEc2aIhX9U1fAbKN57J1
         nNOQ==
X-Gm-Message-State: AOJu0YxeKsIQhapB63hnxo0mjP1bAYwj5APOKOvtFxVo2AVQU8dvFDqy
        3qwwlb+icDhjOgnx9/a5xFBvXiUTpiB124UPLWf6YLgp
X-Google-Smtp-Source: AGHT+IEDvX+ecDZ1RwPEufppWxoRbprGo8Soq3d6K9vgfOzxnTKsqRCM9rpZnGomGtUUbEiybgCcgQ6zjBvUuebKFcs=
X-Received: by 2002:a4a:37c3:0:b0:570:cad0:fce9 with SMTP id
 r186-20020a4a37c3000000b00570cad0fce9mr9352284oor.1.1692818580204; Wed, 23
 Aug 2023 12:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230823191831.476579-1-helgaas@kernel.org>
In-Reply-To: <20230823191831.476579-1-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Aug 2023 21:22:49 +0200
Message-ID: <CAJZ5v0hAw7fB3YuQ2SGNccV_tPhr0GTYAEkv5NpMxgSuUUVXxw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Tidy save/restore config messages
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
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

On Wed, Aug 23, 2023 at 9:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Update config space save/restore debug messages so they line up better.
> Previously:
>
>   nvme 0000:05:00.0: saving config space at offset 0x4 (reading 0x20100006)
>   nvme 0000:05:00.0: saving config space at offset 0x8 (reading 0x1080200)
>   nvme 0000:05:00.0: saving config space at offset 0xc (reading 0x0)
>
>   nvme 0000:05:00.0: restoring config space at offset 0x4 (was 0x0, writing 0x20100006)
>
> Now:
>
>   nvme 0000:05:00.0: save config 0x04: 0x20100006
>   nvme 0000:05:00.0: save config 0x08: 0x01080200
>   nvme 0000:05:00.0: save config 0x0c: 0x00000000
>
>   nvme 0000:05:00.0: restore config 0x04: 0x00000000 -> 0x20100006
>
> No functional change intended.  Enable these messages by setting
> CONFIG_DYNAMIC_DEBUG=y and adding 'dyndbg="file drivers/pci/* +p"'
> to kernel parameters.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/pci/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..920c161575d4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1681,7 +1681,7 @@ int pci_save_state(struct pci_dev *dev)
>         /* XXX: 100% dword access ok here? */
>         for (i = 0; i < 16; i++) {
>                 pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
> -               pci_dbg(dev, "saving config space at offset %#x (reading %#x)\n",
> +               pci_dbg(dev, "save config %#04x: %#010x\n",
>                         i * 4, dev->saved_config_space[i]);
>         }
>         dev->state_saved = true;
> @@ -1712,7 +1712,7 @@ static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
>                 return;
>
>         for (;;) {
> -               pci_dbg(pdev, "restoring config space at offset %#x (was %#x, writing %#x)\n",
> +               pci_dbg(pdev, "restore config %#04x: %#010x -> %#010x\n",
>                         offset, val, saved_val);
>                 pci_write_config_dword(pdev, offset, saved_val);
>                 if (retry-- <= 0)
> --
> 2.34.1
>
