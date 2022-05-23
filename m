Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD2C5319A4
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 22:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiEWTYE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 15:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiEWTXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 15:23:46 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14610C1ECF;
        Mon, 23 May 2022 12:02:32 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id z7so5822104ybf.7;
        Mon, 23 May 2022 12:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwUAB/xmEW3kCFHamwODrMltMLrrJWIW+z2+9bNEEzM=;
        b=7GidrMn3D/wKRHfl8nhAcq9hr54bJWf1qP2nSXWNClZ2sCncbgiZZfnYtMykgLIPi4
         3Phmz1b8pVMzfzHkypLOxClcyNWeYibZdbznaZklSGifaXzonS051Ju6HjLtiXhMBimv
         7Ql36hIf6D6+03XOQw75ORyfU+f2eLQ9ZxZFedQD2wM7s/8+viRIpf3ST52sHCIKWhdm
         KkyqPEbvycXiUPfJY+ca6g3JLfhrh14HncElWLcfnPGEiQ0MQC3uxygOYJq8Ik++z9ZJ
         gu3IHxwhMNbl3fswuwk2U67/CzHJxgIhwRE95SXWZnWYBbc+PXimpGwpkOlI65cjPZHA
         ULhQ==
X-Gm-Message-State: AOAM532Aljiq1gONZFO31Gb91kgcujTN0oGiq/Z5dFmWUZDaZrPKpbSE
        GVm3+pfNkgjCbT0udNYBWi3Q0uj64zbTGzWVYnk=
X-Google-Smtp-Source: ABdhPJy18QrqLhTLo5Fev9uXChTSTcA2vc0ub8iaGELzv9YkyhOz68miW3KPgkeuguuwPAF5Aq/wKGBrkZxz/Inpa8E=
X-Received: by 2002:a25:8803:0:b0:64e:4a6a:afb9 with SMTP id
 c3-20020a258803000000b0064e4a6aafb9mr22950379ybl.482.1653332550682; Mon, 23
 May 2022 12:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0iHgtTpW+ox=wK68cnuG6D+KvFiOCh2UF96dxq08Z3BSA@mail.gmail.com>
 <20220523183238.GA174199@bhelgaas>
In-Reply-To: <20220523183238.GA174199@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 May 2022 21:02:19 +0200
Message-ID: <CAJZ5v0joBi4socGHeF-tjhJerd04xrCecQLz+pVYSd6fdtT36w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        David Box <david.e.box@linux.intel.com>,
        "Jingar, Rajvi" <rajvi.jingar@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Mon, May 23, 2022 at 8:32 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, May 19, 2022 at 09:01:27PM +0200, Rafael J. Wysocki wrote:
> > ...
>
> > In the meantime, I think that it would make sense to pick up the first
> > patch in this series which is a good cleanup regardless.
> >
> > Bjorn, could you do that, please?
>
> As far as I know, this series has never actually made it to
> linux-pci@vger.kernel.org, so I haven't seen the 1/2 patch.  This
> query:
>
>   https://lore.kernel.org/linux-pci/?q=f%3Arajvi.jingar
>
> finds only a couple responses.  I did mention this to Rajvi, but
> haven't heard anything yet.

OK, I'll resubmit that patch for him.
