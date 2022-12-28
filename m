Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6C8657215
	for <lists+linux-pci@lfdr.de>; Wed, 28 Dec 2022 03:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiL1CUL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Dec 2022 21:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiL1CUK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2022 21:20:10 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8510EFC4;
        Tue, 27 Dec 2022 18:20:09 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t2so14836095ply.2;
        Tue, 27 Dec 2022 18:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enzzl8bA/q6QyP6u99nHb/wMrkuqUD77A3Gv70HGdP8=;
        b=msuuYF6lSCKGPsHI2vlC693kxlwgzRvFdY/pnEartRdp2EpSWrTugmSSmqROCEWO6d
         HXUM1XOvGdJYbE2VJjPJrY52Y61ksrAC9L7gZQiAUUeI7RRB7s+2P+FvmnNhFYWSojFu
         rYL24fFfpJleB+tPe3O68Tj+0tnkTc2mYevXUpZ0NPK4H/nHgdrqUwA2/vhxXjMJqAl5
         J4lKz+h6U9oQG/9jpcHD/EPzasoODB6Ca3Z2IoA7eRnFEhwk89gp3Mdgfe42DkyGD1Dr
         Ya4+i9abip/Rc7XhKgQ4ndW2+vAk++e7rkPDq65AGMSXl/ElRlOgWZFd8ouWjNKWuYZW
         I8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enzzl8bA/q6QyP6u99nHb/wMrkuqUD77A3Gv70HGdP8=;
        b=PnJzjPtG90Ls1Wq3ZzA+T/UeDYs+a3TGZZbaYWjr2U1D1Wgj9BNr6aHdVXp092KW/E
         nXiXFP1VM56v0DPxqlKJKXKND3erlSbHjEujl13+ZTGCv7zKI19IqxFvRMngi02cq/wN
         er30IwNP2V8qlRYpK1WlKFLhZO4C4gFmztEUeqSGyQKv8huMiJvMKySQ0URVG0WzviLl
         X0g9XIIivKOMhnh1J1G5Llj78uTXoRdQeGy2m7Qe+pAZ1/ntiiOIKcdtWVGddHbFExm4
         zYHIEVGPxTC0XSi0+uK7u7cVplXeOP4/bl5zpbNpQmgg0ylQTHhvnfqpE+rSGFuXvP5b
         8dIQ==
X-Gm-Message-State: AFqh2kr0a4K+7yFU59hYWyB1SzkqKODxcYGVwHBEMb9UARaTj7yxQkDr
        Uy4U7ngT6qQmJmQpP7tH+OZx33bD5FjmUofOpCg+xQhJHOmdpw==
X-Google-Smtp-Source: AMrXdXtsJrx3dJyiNK2syLZTnlMlVPWU22m0IT0vCJrQ0/IsvUq6egHtCosQWzRKBFgjl45g23cObGU4B84KahwTruk=
X-Received: by 2002:a17:90a:6505:b0:223:fd3b:538e with SMTP id
 i5-20020a17090a650500b00223fd3b538emr2275993pjj.120.1672194009112; Tue, 27
 Dec 2022 18:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20221222072603.1175248-1-korantwork@gmail.com>
 <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev> <Y6TSgGdCTvkwPiVg@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYUWf+Fx3FV7vNTc8+O9NSb0iQp75MTC6gra6XapXK=cxw@mail.gmail.com> <d14ac29d-027a-08a7-c5c8-848a6920d4a2@linux.dev>
In-Reply-To: <d14ac29d-027a-08a7-c5c8-848a6920d4a2@linux.dev>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Wed, 28 Dec 2022 10:19:58 +0800
Message-ID: <CAEm4hYXncuvL-Gk1aEZExrvkbx=N1aiOQNeNjFdB4443EbKNBA@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0 controller
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Keith Busch <kbusch@kernel.org>, nirmal.patel@linux.intel.com,
        lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinghui Li <korantli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Derrick <jonathan.derrick@linux.dev> =E4=BA=8E2022=E5=B9=B412=E6=
=9C=8828=E6=97=A5=E5=91=A8=E4=B8=89 06:32=E5=86=99=E9=81=93=EF=BC=9A
>
> The bypass mode should help in the cases where drives irqs (eg nproc) exc=
eed
> VMD I/O irqs. VMD I/O irqs for 28c0 should be min(63, nproc). You have
> very few cpus for a Skylake system with that many drives, unless you mean=
 you
> are explicitly restricting the 12 drives to only 6 cpus. Either way, bypa=
ss mode
> is effectively VMD-disabled, which points to other issues. Though I have =
also seen
> much smaller interrupt aggregation benefits.

Firstly=EF=BC=8CI am sorry for my words misleading you. We totally tested 1=
2 drives.
And each drive run in 6 CPU cores with 8 jobs.

Secondly, I try to test the drives with VMD disabled,I found the results to
be largely consistent with bypass mode. I suppose the bypass mode just
"bypass" the VMD controller.

The last one=EF=BC=8Cwe found in bypass mode the CPU idle is 91%. But in re=
mapping mode
the CPU idle is 78%. And the bypass's context-switchs is much fewer
than the remapping
mode's. It seems the system is watiing for something in bypass mode.
