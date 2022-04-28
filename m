Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2335135BE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 15:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347765AbiD1Nye (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 09:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347775AbiD1Nyc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 09:54:32 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8925AF1F3;
        Thu, 28 Apr 2022 06:51:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p18so5609332edr.7;
        Thu, 28 Apr 2022 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wzLb2H0YcqmUah8DGfau1BD9HEOhRKzt1fvXpHtcIh4=;
        b=FjkheFcaXEuFQtQdX/5QvXJmeX2G1CCMN74+ZPt3CKrIk7nB01k6OWMCt4vOL4nAuN
         s5dBbT9JBC/4SY2Tx4bQPUvmKsEtCXmnP4i6mNfJ+2GRZeC7VYAwhpXGBhFnHP2ScHzF
         VayIjF7pB00hoq9lm1dz7J9N1f2lu4rq2l0SNdPgEVXhsJ5/dLrzvOTszAsFnfpODn1r
         aQtxmb/LahGa4inIw2csTWpj7H2RtD+exkl6QM+jZ/whGgEm56tAn0Hwtu2hjfWiAYMP
         o5pZRHDw5YkqaqqcoSlNaKpojEMJv2BfIL+6kBXUemmc7e0bYu0GKzWCeBp15oI73aGJ
         xl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wzLb2H0YcqmUah8DGfau1BD9HEOhRKzt1fvXpHtcIh4=;
        b=h4GX7YYaypjRkI51ydgg/oBmnRvAHtOe/chlfOG2pq1qH1dT4AFGwaaevRQnVe1bUK
         FfS9xOnRmOeDHf/yNDUmIrLXcTMaXfZvJzJF4L8PXFV+HPUUeapGOSrPX2ugxR2Qklpu
         fWIT0891JX0fXC/qXIfeM//rkAfvrU6TfmzqTJ916Qt1vOEQyNcN1Qx/oTzTm7G89AFb
         n/1HvzDtd8G1zCQruLLi9dpS0SYY3LT4c66O1xqgmprjaC+zxvbEIB5+SkL4bfUbWZc5
         IMv8d7OLXjyGq50VXvhD6Vc6FukkqfSXxlfm4/bvRlMfthHeyP7lLb+ePXueNSXiOYaM
         P48Q==
X-Gm-Message-State: AOAM532cgUeXIJtZ7ThgNalYxmZunBeNCnhqB8nO5pXLoDuC7oFGuuMY
        nBD+3+178rsNqH6CLIzFjm7fRR+iwx24uX6EPh8=
X-Google-Smtp-Source: ABdhPJzY8x+vpRvIT3jJFsms/VfptYvZpAhiELEKuWGYRDqQ1rFRPnlIxYZHfDgNz4b+MuyuuSNYAEUaw/tqUVGU7Zc=
X-Received: by 2002:a05:6402:440d:b0:412:9e8a:5e51 with SMTP id
 y13-20020a056402440d00b004129e8a5e51mr36680407eda.362.1651153876361; Thu, 28
 Apr 2022 06:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAH9NwWec6ovS1xQbuPsB5duskJdmK_qv4t+URTK6thCvGNST7w@mail.gmail.com>
 <20220323023714.GA1244184@bhelgaas> <CAH9NwWfZQWbfc6VJMT3isv2gmnWCoAOU4osDKQ7EBW_XsywGpg@mail.gmail.com>
In-Reply-To: <CAH9NwWfZQWbfc6VJMT3isv2gmnWCoAOU4osDKQ7EBW_XsywGpg@mail.gmail.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Thu, 28 Apr 2022 15:51:05 +0200
Message-ID: <CAH9NwWegh0E3-9PQy-t90SF3biZd3xtBXt-qCK4gtyjMQrVnAw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: cadence: Enable Controller to respond to received
 PTM Requests
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
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

>
> > > >
> > > > > This enables the Controller [RP] to automatically respond with
> > > > > Response/ResponseD messages if CDNS_PCIE_LM_TPM_CTRL_PTMRSEN
> > > > > and PCI_PTM_CTRL_ENABLE bits are both set.
> > > > >
> > > > > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> >
> > We're in the middle of the merge window right now, but I'm sure
> > Lorenzo will be able to look at it after -rc1.  This looks fine to me.
> >
>
> Another gentle ping :(
>

Ping..
-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
