Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5204E4188
	for <lists+linux-pci@lfdr.de>; Tue, 22 Mar 2022 15:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiCVOlP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Mar 2022 10:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbiCVOlO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2022 10:41:14 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A4412AC8;
        Tue, 22 Mar 2022 07:39:47 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so1881600fac.7;
        Tue, 22 Mar 2022 07:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WxMgpeiQYhggSsVLRZ+q7Wz7Ufhtg8Nvw1FX59uyKIM=;
        b=pfUofWc5YccH3Zbnj4KCFOAV8I71L318nWLCeKLpHUTKvd+BXMv9tEOu3iId6f7wED
         jMyBo3MYsQS1NQ+tbu9yOkxRdREFIO0UlLmN7BZfZ/ybxAVP7CyViK75qZ+b60G2mkeb
         x3gX7uel7QkZk0x6xUGDfo235NbPim1dmc9Tn1igxU5qO5qSWaFk7eQQ8PbXyHwqJZFE
         vs/lST17/LBmjp0opMEm0qpf8q6VKYO0KA92dRCsQ4zDXwYxFY7RlloXJuVL+7HtiVQZ
         UTg0anqQIRVWznllxg0NPsbxRXXWh3nrqVarepD0x8YDZFRpTDdsSEOoekQ+tID+f653
         07HQ==
X-Gm-Message-State: AOAM531oISgT7pVj6AvSSxAfuEuRlhgjvcWfsg72xf90zyj+EAbLmzjE
        4q06Cb6rqemmYlqE9Vyxbg==
X-Google-Smtp-Source: ABdhPJxPcgHGhDH2C+e7WOOnw416Mg/sQWc1cDtvNNEnB3Z8MzHF5ZBtTXUWtbYsyVbA1huXzoN4QQ==
X-Received: by 2002:a05:6870:6108:b0:dd:ca26:f135 with SMTP id s8-20020a056870610800b000ddca26f135mr1818123oae.22.1647959986324;
        Tue, 22 Mar 2022 07:39:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f8-20020a4a8908000000b0032472938f95sm4241174ooi.17.2022.03.22.07.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 07:39:45 -0700 (PDT)
Received: (nullmailer pid 1981681 invoked by uid 1000);
        Tue, 22 Mar 2022 14:39:43 -0000
Date:   Tue, 22 Mar 2022 09:39:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>
Cc:     dann frazier <dann.frazier@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 0/2] PCI: xgene: Restore working PCIe functionnality
Message-ID: <Yjnfr7V6egc1sewb@robh.at.kernel.org>
References: <20220321104843.949645-1-maz@kernel.org>
 <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
 <87h77rxnyl.wl-maz@kernel.org>
 <CAL_JsqK57KpZmzCE=86dLcHK4Ws_0w0ga4_qoYUe2GwFNpDzRw@mail.gmail.com>
 <87fsnbxgau.wl-maz@kernel.org>
 <e52c8cbd-031b-848f-3d78-dff8b93bd416@arm.com>
 <61809b8f-acaa-bae2-ac5e-aa47c55eea23@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61809b8f-acaa-bae2-ac5e-aa47c55eea23@arm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 22, 2022 at 01:16:35PM +0000, Robin Murphy wrote:
> On 2022-03-21 20:06, Robin Murphy wrote:
> > On 2022-03-21 19:21, Marc Zyngier wrote:
> > > On Mon, 21 Mar 2022 18:03:27 +0000,
> > > Rob Herring <robh@kernel.org> wrote:
> > > > 
> > > > On Mon, Mar 21, 2022 at 11:36 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > > 
> > > > > On Mon, 21 Mar 2022 15:17:34 +0000,
> > > > > Rob Herring <robh@kernel.org> wrote:
> > > > > > 
> > > > > > On Mon, Mar 21, 2022 at 5:49 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > > > > 
> > > > > > For XGene-1, I'd still like to understand what the issue is. Reverting
> > > > > > the first fix and fixing 'dma-ranges' should have fixed it. I need a
> > > > > > dump of how the IB registers are initialized in both cases. I'm not
> > > > > > saying changing 'dma-ranges' in the firmware is going to be required
> > > > > > here. There's a couple of other ways we could fix that without a
> > > > > > firmware change, but first I need to understand why it broke.
> > > > > 
> > > > > Reverting 6dce5aa59e0b was enough for me, without changing anything
> > > > > else.
> > > > 
> > > > Meaning c7a75d07827a didn't matter for you. I'm not sure that it would.
> > > > 
> > > > Can you tell me what 'dma-ranges' contains on your system?
> > > 
> > > Each pcie node (all 5 of them) has:
> > > 
> > > dma-ranges = <0x42000000 0x80 0x00 0x80 0x00 0x00 0x80000000
> > >                0x42000000 0x00 0x00 0x00 0x00 0x80 0x00>;

This is the same as what Stéphane has for Merlin. So c7a75d07827a ("PCI: 
xgene: Fix IB window setup") should have fixed Mustang.

> > 
> > Hmm, is there anyone other than iommu-dma who actually depends on the
> > resource list being sorted in ascending order of bus address? I recall
> > at the time I pushed for creating the list in sorted order as it was the
> > simplest and most efficient option, but there's no technical reason we
> > couldn't create it in as-found order and defer the sorting until
> > iova_reserve_pci_windows() (at worst that could even operate on a
> > temporary copy if need be). It's just more code, which didn't need to
> > exist without a good reason, but if this is one then exist it certainly
> > may.
> 
> Taking a closer look, the Cadence driver is already re-sorting the list
> for its own setup, so iommu-dma can't assume the initial sort is
> preserved and needs to do its own anyway. Does the (untested) diff below
> end up helping X-Gene also?

There's no IOMMU on X-Gene 1 or 2 based on the upstream dts files, so 
how would this matter?

Rob
