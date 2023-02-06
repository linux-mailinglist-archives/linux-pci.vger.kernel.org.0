Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC9868BD2A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 13:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBFMpE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 07:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBFMpD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 07:45:03 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87CE5FD1;
        Mon,  6 Feb 2023 04:45:02 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso15047632pjj.1;
        Mon, 06 Feb 2023 04:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gM1T1LiTjFLuiGBuHxUovgMZMlzmJ0u3GsfkKmTxj0M=;
        b=LEYtyfsEYNtKsHvFXQmMWDZ3DL1IGzocBn1YvmZHApBcNR9De+PKIGV+8WVH8YXL1W
         0chffXrUj6aZhNixcKCPqqf0v5pVQxw1QsxWTIwbABujMZCkzEqeH2QEwl3TEN7N4G/S
         0GnEZ9FytnMSdgw78CgRjBC2FLIpbtv3XACWjog8CWrL7b5Y72BzooQWiyjf2B4JKatu
         OTYisgAA/UgfjhXpT2bpvSOnh47YBTpytt9p+i/IVua/JqYwISXZ/ZJ83R3VO3T8IEH0
         hR0HcDM9tQDmL2hZvVVDL0DEpgJbP0nV5dHatlO35aBmn7EoG1Tqr9p4JyOgC272RUey
         mQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gM1T1LiTjFLuiGBuHxUovgMZMlzmJ0u3GsfkKmTxj0M=;
        b=qoIVtZjF/4qD36I56nMDjAP1HBJlPagS1StnfQlJRsSiX+JuN9M2+xh6EW108DAZcS
         CK8BymtjQYFajDYXT4yh2sJgAEGyMqVS5qKw57qy+rxL02ZQMLFGsjAoTr69rmGwqWuC
         XbGdgz1E8z1pLgh0pf7iJLG/UywV9n5eQVPw+AACxh22/zFwiL+0lakVfY93JQzTOvqd
         GX6G/MqKaznfuAp2D9VRlMP2JMtWqw9IZknDw82LIbLyat/nJBgMzSYb8au4QHDUPzbV
         fb9n2XsCr4jLZN2kI8wcqt3dYERV2Z9tiFHUs0J4UjDmYrLPX5IL5sSA9DYNiPp4KvCm
         LdmQ==
X-Gm-Message-State: AO0yUKULxAWpP0u4eoALfDQNFn6Db0ouKfrRfQ1/9YfkC9S/UGl6auD6
        BqyFaYQYwSdgqNbUk2XtOiLrHj5Gx43zWDAs+RY=
X-Google-Smtp-Source: AK7set/U1nmg01crHXqmJueQELsf06ewfSOKn9103EC3Etsc9ROFlDdAWo5G3bi5fo0k8DJH+xKJs8TV08WXvwAs3KU=
X-Received: by 2002:a17:90a:74c4:b0:22b:f34a:1f52 with SMTP id
 p4-20020a17090a74c400b0022bf34a1f52mr2922483pjl.76.1675687502165; Mon, 06 Feb
 2023 04:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20221222072603.1175248-1-korantwork@gmail.com>
 <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev> <Y6TSgGdCTvkwPiVg@kbusch-mbp.dhcp.thefacebook.com>
 <CAEm4hYUWf+Fx3FV7vNTc8+O9NSb0iQp75MTC6gra6XapXK=cxw@mail.gmail.com>
 <d14ac29d-027a-08a7-c5c8-848a6920d4a2@linux.dev> <CAEm4hYXncuvL-Gk1aEZExrvkbx=N1aiOQNeNjFdB4443EbKNBA@mail.gmail.com>
 <f05ee82a-4532-b12b-490f-904b946ff7b0@linux.dev> <CAEm4hYXk1RuKEw41VukH2iGTo_9GmZjUfrESWK5vFtpFA_O_4A@mail.gmail.com>
In-Reply-To: <CAEm4hYXk1RuKEw41VukH2iGTo_9GmZjUfrESWK5vFtpFA_O_4A@mail.gmail.com>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Mon, 6 Feb 2023 20:45:57 +0800
Message-ID: <CAEm4hYWeZFrYxSvAcBJ8iw=t507vZMqfBwiQXFSJd2Hcyfw7fA@mail.gmail.com>
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

Friendly ping~

Xinghui Li <korantwork@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8810=E6=97=
=A5=E5=91=A8=E4=BA=8C 20:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Jonathan Derrick <jonathan.derrick@linux.dev> =E4=BA=8E2023=E5=B9=B41=E6=
=9C=8810=E6=97=A5=E5=91=A8=E4=BA=8C 05:00=E5=86=99=E9=81=93=EF=BC=9A
> >
> > As the bypass mode seems to affect performance greatly depending on the=
 specific configuration,
> > it may make sense to use a moduleparam to control it
> >
> We found that each pcie port can mount four drives. If we only test 2
> or 1 dirve of one pcie port,
> the performance of the drive performance will be normal. Also, we
> observed the interruptions in different modes.
> bypass:
> .....
> 2022-12-28-11-39-14: 1224       181665   IR-PCI-MSI 201850948-edge      n=
vme0q68
> 2022-12-28-11-39-14: 1179       180115   IR-PCI-MSI 201850945-edge      n=
vme0q65
> 2022-12-28-11-39-14:  RES        26743   Rescheduling interrupts
> 2022-12-28-11-39-17: irqtop - IRQ : 3029, TOTAL : 2100315228, CPU :
> 192, ACTIVE CPU : 192
> disable:
> ......
> 2022-12-28-12-05-56: 1714       169797   IR-PCI-MSI 14155850-edge      nv=
me1q74
> 2022-12-28-12-05-56: 1701       168753   IR-PCI-MSI 14155849-edge      nv=
me1q73
> 2022-12-28-12-05-56:  LOC       163697   Local timer interrupts
> 2022-12-28-12-05-56:  TLB         5465   TLB shootdowns
> 2022-12-28-12-06-00: irqtop - IRQ : 3029, TOTAL : 2179022106, CPU :
> 192, ACTIVE CPU : 192
> remapping:
> 022-12-28-11-25-38:  283       325568   IR-PCI-MSI 24651790-edge      vmd=
3
> 2022-12-28-11-25-38:  140       267899   IR-PCI-MSI 13117447-edge      vm=
d1
> 2022-12-28-11-25-38:  183       265978   IR-PCI-MSI 13117490-edge      vm=
d1
> ......
> 2022-12-28-11-25-42: irqtop - IRQ : 2109, TOTAL : 2377172002, CPU :
> 192, ACTIVE CPU : 192
>
> From the result it is not difficult to find, in remapping mode the
> interruptions come from vmd.
> While in other modes, interrupts come from nvme devices. Besides, we
> found the port mounting
> 4 dirves total interruptions is much fewer than the port mounting 2 or 1 =
drive.
> NVME 8 and 9 mount in one port, other port mount 4 dirves.
>
> 2022-12-28-11-39-14: 2582       494635   IR-PCI-MSI 470810698-edge      n=
vme9q74
> 2022-12-28-11-39-14: 2579       489972   IR-PCI-MSI 470810697-edge      n=
vme9q73
> 2022-12-28-11-39-14: 2573       480024   IR-PCI-MSI 470810695-edge      n=
vme9q71
> 2022-12-28-11-39-14: 2544       312967   IR-PCI-MSI 470286401-edge      n=
vme8q65
> 2022-12-28-11-39-14: 2556       312229   IR-PCI-MSI 470286405-edge      n=
vme8q69
> 2022-12-28-11-39-14: 2547       310013   IR-PCI-MSI 470286402-edge      n=
vme8q66
> 2022-12-28-11-39-14: 2550       308993   IR-PCI-MSI 470286403-edge      n=
vme8q67
> 2022-12-28-11-39-14: 2559       308794   IR-PCI-MSI 470286406-edge      n=
vme8q70
> ......
> 2022-12-28-11-39-14: 1296       185773   IR-PCI-MSI 202375243-edge      n=
vme1q75
> 2022-12-28-11-39-14: 1209       185646   IR-PCI-MSI 201850947-edge      n=
vme0q67
> 2022-12-28-11-39-14: 1831       184151   IR-PCI-MSI 203423828-edge      n=
vme3q84
> 2022-12-28-11-39-14: 1254       182313   IR-PCI-MSI 201850950-edge      n=
vme0q70
> 2022-12-28-11-39-14: 1224       181665   IR-PCI-MSI 201850948-edge      n=
vme0q68
> 2022-12-28-11-39-14: 1179       180115   IR-PCI-MSI 201850945-edge      n=
vme0q65
> > I'd vote for it being in VMD mode (non-bypass) by default.
> I speculate that the vmd controller equalizes the interrupt load and
> acts like a buffer,
> which improves the performance of nvme. I am not sure about my
> analysis. So, I'd like
> to discuss it with the community.
