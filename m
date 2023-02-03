Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42B86893C9
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 10:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjBCJbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 04:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBCJbu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 04:31:50 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E512953EE;
        Fri,  3 Feb 2023 01:31:38 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-142b72a728fso5921046fac.9;
        Fri, 03 Feb 2023 01:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vo/HaF0C39g9IRJApCEPTr2ce7tLCVCZ2W6YPxtmrV4=;
        b=VM3eE5HBdt/1qSo8TQm65S+tKQeVv1tpQaoBi/5j4kfmWy40laCXCNtOMsQ2LN/qm5
         QktQ9v5xaNi661Frt8PDBJFtiSh6VSzRj7rILqTaRx1es/ukKGz4Z04ENGItdE5IzhV3
         cdtu+7EFnDch5WOjYBPWPMD2F/W9Pu92MbqOuUnLc/foOXCfzyj4EB6vxBRHC3GaUuoL
         lMJedKxEpGx6W8CHkwesVOQSww13ub5aCbxlgnhyuB9fp7Y7niJ1ximi0hArvLzqYmb0
         ZcR+7455AEGHWpx4IjNg9Dfjy+titUdY1uw9iIdLpevM9nJd9P7n0SlDZyCKpWzfolEu
         OB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vo/HaF0C39g9IRJApCEPTr2ce7tLCVCZ2W6YPxtmrV4=;
        b=54EccgOI/WgWRU4uQjd5G+Ek8H3cUCcEhuBFY0OXm+f+HGtdE6Y/VpMFcUKhIZ4kUs
         35O00Pf2xFhOSlz1JMMkzysHijFp48P8SJhfHpTCcEIzfvzhU68q5n1U9LDz2NYtXiHq
         Q9Ooy0U2VZLLfHKOV5gcSCtv4WFCnSOzhI/VR+2OCVVtgR/KyWyQ/3NyFaTFqzFn2uo3
         4iBXQ7WFl+IoogEBDareGOJzsNoW9qLQqKm0mSbPjA3M9nuxY8XbhOAD25zHYYIEWKEU
         gpY42CyKRzkMsYjOcai+B0erJ8HQSCBCxo8bvDnAWkZwijeDGZcgvHpMDwr7EZtQsfvR
         aKQg==
X-Gm-Message-State: AO0yUKV1I+d3hALxn9T4MjEjkWDHeIABP7/cQooEqzAxPWgIBIjQ7i2S
        r5CkKJ/4+1N3YTKkFqmcbiqveM3tCUIb6Z6dBHn/ImaB
X-Google-Smtp-Source: AK7set9M4BuQ3c2bnXAgUzK10v7fe7RK83Xi5Im/ivGSymyii7NlWr52uW6ei1OcK9SZR/aQ66WkqGKyRqn9bj/HU/8=
X-Received: by 2002:a05:6870:438d:b0:169:fabf:b222 with SMTP id
 r13-20020a056870438d00b00169fabfb222mr145666oah.83.1675416697670; Fri, 03 Feb
 2023 01:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20221231074041.264738-1-sergio.paracuellos@gmail.com> <167541647472.1154578.14891717976450626734.b4-ty@kernel.org>
In-Reply-To: <167541647472.1154578.14891717976450626734.b4-ty@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 3 Feb 2023 10:31:26 +0100
Message-ID: <CAMhs-H9-dJj_RKBjTx3KjRd1_1C=BxuuFMJ22ZpauarEbvSpNQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: mt7621: Sleep a bit after power on the PCIs phy ports
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, kw@linux.com,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        matthias.bgg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 3, 2023 at 10:29 AM Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
>
> On Sat, 31 Dec 2022 08:40:41 +0100, Sergio Paracuellos wrote:
> > Some devices like ZBT WE1326 and ZBT WF3526-P and some Netgear models need
> > to sleep a bit after call to mt7621_pcie_init_port() driver function to get
> > into reliable boots for both warm and hard resets. The needed time for these
> > devices to always detect the ports seems to be from 75 to 100 milliseconds.
> > There is no datasheet or something similar to really understand why this
> > extra time is needed in these devices but not in most of the boards which
> > use mt7621 SoC. This issue has been reported by openWRT community and the
> > complete discussion is in [0]. The selected time of 100 milliseconds has
> > been also tested in these devices ending up in an always working platform.
> > Hence, properly add the extra 100 milliseconds msleep() function call to make
> > also these devices work.
> >
> > [...]
>
> Applied to pci/controller/mt7621, thanks!
>
> [1/1] PCI: mt7621: Sleep a bit after power on the PCIs phy ports
>       https://git.kernel.org/pci/pci/c/0cb2a8f3456f
>
> Thanks,
> Lorenzo

Thanks!
   Sergio Paracuellos
