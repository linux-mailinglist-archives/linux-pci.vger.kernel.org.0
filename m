Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4F47A57E8
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 05:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjISDcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 23:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjISDcT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 23:32:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF59111
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 20:32:13 -0700 (PDT)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9588F3F680
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2023 03:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695094331;
        bh=FkNEDxyTsk0mxtH7OBITL95mJIWHbf8Ohhbe6/zNdaI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=abVArC909ldM+pTBQAIBh9hOnCz1r15SLttDIshd7+urLGSOR/VDZ3a4V70moI1Az
         +zerCDFIK1PxT3zashNVxXtgcFLrQqZ3i68W4A4nlqWIb+Xfkf/5koacJdnv73/1Bx
         693O6Il9B4cRx4+xLrXYbIkCjNCK1GV2OWgPhxN8D5QjAhgebWn0cmAYwCz7qwWca2
         Sc9NyKQcoYDSNKDHeGgfsC926G/zXh5tsMqnx3DlSFIgCHnstqN10QuKbdkP5cCjRu
         x1CZiENj4haHTY/jsPnyKLqI+QNpFGSpVt8lEmfJdVTv/wszZsH5K+X+RPIeWFIfsL
         H2Gs8RtKcsSng==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5784671b7ebso1787936a12.1
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 20:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695094330; x=1695699130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkNEDxyTsk0mxtH7OBITL95mJIWHbf8Ohhbe6/zNdaI=;
        b=KwAA0b5oBe/XLLm7R+48Wr5y29ei29ibkHf4v0Fh9A/uHNlC73gL1dL6EXJnKCJxFA
         8NpQDfLB9DcwsjvIvVEvvm0c/7xKd/Qyv25OOZ368X7ApktovEiR2u+gp5XAZuIhlrHv
         GKAzL7phTh0H81JZfk7crDOGYz5bkILlG3jh1reYxji9Ct91RFAREBHJ+Rv1x67CsFOY
         sCp1kEhJrwn9gCZScSk5hU2tpIFxjNNrAZaSoH2wi2L01CL4UUFSQgumZ+dPyosRl5z/
         tDtnjjvAlFpVcYe8BYa3aNs6pjFv4uacMTRDyQRpM4dAUwFCAlwXQ9CwNNJGsVffJ2M2
         ENZw==
X-Gm-Message-State: AOJu0Yzag1YcrfU0xFdU+MsbtaZCY0WlbrRo71Z3RMU8W5I2b6LLQXHL
        6Tn5Exxb+EpMtKIu5RsDZBI1XNeiP99IbhTiowYdiFViuO6phJNdKJpioh01zzjM8Enhzo+d4Z0
        UnkdYViRTyzjQKf4JtvSYvoYK9ll2veoB+vzgPBdcIIMImmuGGADnTg==
X-Received: by 2002:a05:6a20:b716:b0:14d:cca3:a100 with SMTP id fg22-20020a056a20b71600b0014dcca3a100mr8319267pzb.36.1695094330035;
        Mon, 18 Sep 2023 20:32:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZVLa+/JXUY2AHiRP0UFZ2fOtGMo6lQOjhK1LVTQ92cMDSW5oCCrqtS4BilU8NYsdMoEmuM0mZj4/tZMaH1A8=
X-Received: by 2002:a05:6a20:b716:b0:14d:cca3:a100 with SMTP id
 fg22-20020a056a20b71600b0014dcca3a100mr8319257pzb.36.1695094329712; Mon, 18
 Sep 2023 20:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p6TJm+KP2X2AtgjGoyA7KkJx8ZHNCkuEQ-2kxxgYVJpOA@mail.gmail.com>
 <20230913125050.GA428916@bhelgaas>
In-Reply-To: <20230913125050.GA428916@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 19 Sep 2023 11:31:57 +0800
Message-ID: <CAAd53p45+jxCE-tnr-Mb2YOnDwppv7GYmp+usYehO87s33qpjg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 8:50=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
[snipped]
> Hmm.  In some ways the VMD device acts as a Root Port, since it
> originates a new hierarchy in a separate domain, but on the upstream
> side, it's just a normal endpoint.
>
> How does AER for the new hierarchy work?  A device below the VMD can
> generate ERR_COR/ERR_NONFATAL/ERR_FATAL messages.  I guess I was
> assuming those messages would terminate at the VMD, and the VMD could
> generate an AER interrupt just like a Root Port.  But that can't be
> right because I don't think VMD would have the Root Error Command
> register needed to manage that interrupt.

VMD itself doesn't seem to manage AER, the rootport that "moved" from
0000 domain does:
[ 2113.507345] pcieport 10000:e0:06.0: AER: Corrected error received:
10000:e1:00.0
[ 2113.507380] nvme 10000:e1:00.0: PCIe Bus Error: severity=3DCorrected,
type=3DPhysical Layer, (Receiver ID)
[ 2113.507389] nvme 10000:e1:00.0:   device [144d:a80a] error
status/mask=3D00000001/0000e000
[ 2113.507398] nvme 10000:e1:00.0:    [ 0] RxErr                  (First)

>
> But if VMD just passes those messages up to the Root Port, the source
> of the messages (the Requester ID) won't make any sense because
> they're in a hierarchy the Root Port doesn't know anything about.

Not sure what's current status is but I think Nirmal's patch is valid
for both our cases.

Kai-Heng

>
> > So what items should be hard-coded, assuming 04b12ef163d1 gets reverted=
?
>
> > > > >>>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > > > >>>> ---
> > > > >>>> v3->v4: Rewrite the commit log.
> > > > >>>> v2->v3: Update the commit log.
> > > > >>>> v1->v2: Update the commit log.
> > > > >>>> ---
> > > > >>>>  drivers/pci/controller/vmd.c | 2 --
> > > > >>>>  1 file changed, 2 deletions(-)
> > > > >>>>
> > > > >>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/contro=
ller/vmd.c
> > > > >>>> index 769eedeb8802..52c2461b4761 100644
> > > > >>>> --- a/drivers/pci/controller/vmd.c
> > > > >>>> +++ b/drivers/pci/controller/vmd.c
> > > > >>>> @@ -701,8 +701,6 @@ static int vmd_alloc_irqs(struct vmd_dev *=
vmd)
> > > > >>>>  static void vmd_copy_host_bridge_flags(struct pci_host_bridge=
 *root_bridge,
> > > > >>>>                                         struct pci_host_bridge=
 *vmd_bridge)
> > > > >>>>  {
> > > > >>>> -        vmd_bridge->native_pcie_hotplug =3D root_bridge->nati=
ve_pcie_hotplug;
> > > > >>>> -        vmd_bridge->native_shpc_hotplug =3D root_bridge->nati=
ve_shpc_hotplug;
> > > > >>>>          vmd_bridge->native_aer =3D root_bridge->native_aer;
> > > > >>>>          vmd_bridge->native_pme =3D root_bridge->native_pme;
> > > > >>>>          vmd_bridge->native_ltr =3D root_bridge->native_ltr;
> > > > >>>> --
> > > > >>>> 2.31.1
> > > > >>>>
> > > >
