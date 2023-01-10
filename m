Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A5A66407A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 13:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbjAJM3t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 07:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbjAJM3H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 07:29:07 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8D019031;
        Tue, 10 Jan 2023 04:29:05 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id a30so8678610pfr.6;
        Tue, 10 Jan 2023 04:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kb5rbtDcrrBEALxeAWsV+evBt6CmnxJaFsxwsB5MGXY=;
        b=qNe+yfj0zfhE+SOsV+7F1HjMY4QUPQLGFeqwZbGq9UICOIj33jLbkSueaicCR7cK6S
         YbQ0Oea7WFrB7KteIN0tX1RuMGDP9WfksjlQqUn50FcjIpq1Tt9DdrhUtxOf44A7RMQ0
         9zB5c/wVuWDRyeCyGOnzXmtbwXtA16gHI+8+LUX/qv0VFx3I/EtrkwQCY0pjuOsn2adS
         7I34GKNxBnSBKLwptop0HDX8KliMSPZ6uHIPeaSGd4mObTAU14I6qLPVTFooC/O/Rg+0
         arUTUeg7WOTumYVHwr+y72r/BoVUCwW30hZCjKBeKdVMEfWYTZ3AD5Jm09w/TGUCESij
         si+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kb5rbtDcrrBEALxeAWsV+evBt6CmnxJaFsxwsB5MGXY=;
        b=cxDsWBKopv8/jzXQ7GY7xNPjUpYv8uoM+2vBEm9/A7ALcflArUK+RealF4+3z3cEIS
         3K+O1HFAi9xaad+MnR3fBPVaTfRAhgnpmo3o89LrRfEa8wuyRE8iQMmXcj788azX8j0+
         +QnaWwy5Yr325yTv5FZf/DoLbSaSnG49HttyR/fU+x/S57IETSvh6iiegLk0K5Kqh3Aw
         +Owd6iVVm8mMnAc9qoFqX4XgSA69KLQdChp5qoSJ7Q7NPj/ZdfkGkpm9klnPh7jP685J
         pL8FkJI2jfBvMmA+KbjGFTeaq0GvnhBDjucdg3MDD256MDmQ3UZq5qf9gnc2dCLWV6VO
         zAxQ==
X-Gm-Message-State: AFqh2kpC22nlloBhCLXW3n4TAX9tLR+ObVLhm+6ruPQ1wzzAbbsLzgzp
        26nWGc/4Do91mpJFol7+oGNB1XNm0h/8HpUzkpU=
X-Google-Smtp-Source: AMrXdXtNiNBjupihof2tn2nwgZV2SRXWZCQUHugr/c9LAis0qLd8182FlsbgkYu2OinBKDiY+/Z5XYdrywStKDRgfxQ=
X-Received: by 2002:a63:531b:0:b0:457:4863:2e85 with SMTP id
 h27-20020a63531b000000b0045748632e85mr4278119pgb.6.1673353745346; Tue, 10 Jan
 2023 04:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20221222072603.1175248-1-korantwork@gmail.com>
 <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev> <Y6TSgGdCTvkwPiVg@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYUWf+Fx3FV7vNTc8+O9NSb0iQp75MTC6gra6XapXK=cxw@mail.gmail.com>
 <d14ac29d-027a-08a7-c5c8-848a6920d4a2@linux.dev> <CAEm4hYXncuvL-Gk1aEZExrvkbx=N1aiOQNeNjFdB4443EbKNBA@mail.gmail.com>
 <f05ee82a-4532-b12b-490f-904b946ff7b0@linux.dev>
In-Reply-To: <f05ee82a-4532-b12b-490f-904b946ff7b0@linux.dev>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Tue, 10 Jan 2023 20:28:54 +0800
Message-ID: <CAEm4hYXk1RuKEw41VukH2iGTo_9GmZjUfrESWK5vFtpFA_O_4A@mail.gmail.com>
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

Jonathan Derrick <jonathan.derrick@linux.dev> =E4=BA=8E2023=E5=B9=B41=E6=9C=
=8810=E6=97=A5=E5=91=A8=E4=BA=8C 05:00=E5=86=99=E9=81=93=EF=BC=9A
>
> As the bypass mode seems to affect performance greatly depending on the s=
pecific configuration,
> it may make sense to use a moduleparam to control it
>
We found that each pcie port can mount four drives. If we only test 2
or 1 dirve of one pcie port,
the performance of the drive performance will be normal. Also, we
observed the interruptions in different modes.
bypass:
.....
2022-12-28-11-39-14: 1224       181665   IR-PCI-MSI 201850948-edge      nvm=
e0q68
2022-12-28-11-39-14: 1179       180115   IR-PCI-MSI 201850945-edge      nvm=
e0q65
2022-12-28-11-39-14:  RES        26743   Rescheduling interrupts
2022-12-28-11-39-17: irqtop - IRQ : 3029, TOTAL : 2100315228, CPU :
192, ACTIVE CPU : 192
disable:
......
2022-12-28-12-05-56: 1714       169797   IR-PCI-MSI 14155850-edge      nvme=
1q74
2022-12-28-12-05-56: 1701       168753   IR-PCI-MSI 14155849-edge      nvme=
1q73
2022-12-28-12-05-56:  LOC       163697   Local timer interrupts
2022-12-28-12-05-56:  TLB         5465   TLB shootdowns
2022-12-28-12-06-00: irqtop - IRQ : 3029, TOTAL : 2179022106, CPU :
192, ACTIVE CPU : 192
remapping:
022-12-28-11-25-38:  283       325568   IR-PCI-MSI 24651790-edge      vmd3
2022-12-28-11-25-38:  140       267899   IR-PCI-MSI 13117447-edge      vmd1
2022-12-28-11-25-38:  183       265978   IR-PCI-MSI 13117490-edge      vmd1
......
2022-12-28-11-25-42: irqtop - IRQ : 2109, TOTAL : 2377172002, CPU :
192, ACTIVE CPU : 192

From the result it is not difficult to find, in remapping mode the
interruptions come from vmd.
While in other modes, interrupts come from nvme devices. Besides, we
found the port mounting
4 dirves total interruptions is much fewer than the port mounting 2 or 1 dr=
ive.
NVME 8 and 9 mount in one port, other port mount 4 dirves.

2022-12-28-11-39-14: 2582       494635   IR-PCI-MSI 470810698-edge      nvm=
e9q74
2022-12-28-11-39-14: 2579       489972   IR-PCI-MSI 470810697-edge      nvm=
e9q73
2022-12-28-11-39-14: 2573       480024   IR-PCI-MSI 470810695-edge      nvm=
e9q71
2022-12-28-11-39-14: 2544       312967   IR-PCI-MSI 470286401-edge      nvm=
e8q65
2022-12-28-11-39-14: 2556       312229   IR-PCI-MSI 470286405-edge      nvm=
e8q69
2022-12-28-11-39-14: 2547       310013   IR-PCI-MSI 470286402-edge      nvm=
e8q66
2022-12-28-11-39-14: 2550       308993   IR-PCI-MSI 470286403-edge      nvm=
e8q67
2022-12-28-11-39-14: 2559       308794   IR-PCI-MSI 470286406-edge      nvm=
e8q70
......
2022-12-28-11-39-14: 1296       185773   IR-PCI-MSI 202375243-edge      nvm=
e1q75
2022-12-28-11-39-14: 1209       185646   IR-PCI-MSI 201850947-edge      nvm=
e0q67
2022-12-28-11-39-14: 1831       184151   IR-PCI-MSI 203423828-edge      nvm=
e3q84
2022-12-28-11-39-14: 1254       182313   IR-PCI-MSI 201850950-edge      nvm=
e0q70
2022-12-28-11-39-14: 1224       181665   IR-PCI-MSI 201850948-edge      nvm=
e0q68
2022-12-28-11-39-14: 1179       180115   IR-PCI-MSI 201850945-edge      nvm=
e0q65
> I'd vote for it being in VMD mode (non-bypass) by default.
I speculate that the vmd controller equalizes the interrupt load and
acts like a buffer,
which improves the performance of nvme. I am not sure about my
analysis. So, I'd like
to discuss it with the community.
