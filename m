Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A10552951
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 04:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbiFUC1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 22:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242704AbiFUC1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 22:27:47 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A2114011
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 19:27:46 -0700 (PDT)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A5FFD3FC11
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 02:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1655778464;
        bh=E2ILNW0gf9tTHNwMSSDXvKI5yArGGaqGE5uePOoWe2M=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=W9FajsxT7yfyXABmQspbiWpj2Tl+V6X6z0PbhDGNE+V0RzG1vKBMUl0kKtdMZnAka
         zMDSOoTBFh4KAuTDL8ozW1KP1v4EHsX/oyMnn8/3zR6n/vqDzPg3PVgBrWnHxDn3T1
         47QUCKM45QACPRsRQE5G9wYQN7kN9/BpfzupXinFGK6aqK7fVIhlPFEjyWZ8GoJK1S
         Io1IV3doh4NXllC2C1ZWpH81o7AfBckPF+GQsJMVU7oBsBna3xOBpfNgsoAgDPcrmL
         x1oU3qRQYLc/VUZRswEe9d+bThm9JvVcc21dIQ+zLd0YoWlcqkYnJLSwHsvpbF7aPe
         ZQvD+M//QmKgw==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-f313416010so8417646fac.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 19:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2ILNW0gf9tTHNwMSSDXvKI5yArGGaqGE5uePOoWe2M=;
        b=ttYi/p5eJbzseljwyX/34EjNcqPgMq5yY9rHYZt/a1U89vwDTa58zQoDuAYr1i0dnX
         HcFqsV84bNXB/2wcoKW7PSxMVzU0t3lP42t0jLZtNAJ+Y0MDxSkCVSvI9Q/sE8MfgtD3
         oX0dr4IzpZfUKsnb5M1wHmNs2qOo7R4lLo8B8j4nvy88d1sfqGbb5MGRMShqYrirksV5
         FTXaucjrMS46VHTym/64FBMKIcLUH2sVUw6m+JjaWqo7b5h6K+K0PJLKhgGbMs5LItnE
         CefsN7fdUcYQitCfQMBnhTP7H4QZ+hxJWhP7Z4ziKxl3LFFpQEq/dnKmHLNn/uCe91g5
         9nUA==
X-Gm-Message-State: AJIora/5BoXZpfA9qVA+zV98meMlPoT/8QbOa/7+mj85p7zOo3GtbfJE
        h4PxkV7Kno6890e/2ATxRdDDf0bOwJvKLEdExqbiRgnJbbJayJ8/vMn1YG5gapLbKG6NgPtMWus
        wkgjc8ZtmWthEBzFJdkbXhVN9GTogCeJVHkn+jAWteKhrtfA9SDMjQg==
X-Received: by 2002:a05:6870:51ce:b0:101:c7e3:d7a5 with SMTP id b14-20020a05687051ce00b00101c7e3d7a5mr7075689oaj.176.1655778463519;
        Mon, 20 Jun 2022 19:27:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vZLvkYDH4Le6WT3ZT7+7pPrshf6xYt0vj8FsKZf3JR7+H1FAKU3rm40KLEl0Jy+kx4CjUCiuSHq1zWHm5piH0=
X-Received: by 2002:a05:6870:51ce:b0:101:c7e3:d7a5 with SMTP id
 b14-20020a05687051ce00b00101c7e3d7a5mr7075675oaj.176.1655778463263; Mon, 20
 Jun 2022 19:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220408153159.106741-1-kai.heng.feng@canonical.com>
 <20220408153159.106741-2-kai.heng.feng@canonical.com> <0d4e8764-b1ae-ae59-06ff-d5b705891da4@linux.intel.com>
In-Reply-To: <0d4e8764-b1ae-ae59-06ff-d5b705891da4@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 21 Jun 2022 10:27:31 +0800
Message-ID: <CAAd53p61knfUS02Ny9JCn18F8EgiP0EmJjJcPZ6PoKsPC0y5Hg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PCI/DPC: Disable DPC service when link is in L2/L3
 ready, L2 and L3 state
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, baolu.lu@linux.intel.com,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 18, 2022 at 10:41 AM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 4/8/22 8:31 AM, Kai-Heng Feng wrote:
> > On Intel Alder Lake platforms, Thunderbolt entering D3cold can cause
> > some errors reported by AER:
> > [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> > [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> > [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> > [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> > [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> > [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
> >
> > Since AER is disabled in previous patch for a Link in L2/L3 Ready, L2
> > and L3, also disable DPC here as DPC depends on AER to work.
> >
> > Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=215453
> > Reviewed-by: Mika Westerberg<mika.westerberg@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng<kai.heng.feng@canonical.com>
>
> Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>

A gentle ping...

> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
