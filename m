Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D826D38A3
	for <lists+linux-pci@lfdr.de>; Sun,  2 Apr 2023 17:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDBPCU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Apr 2023 11:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjDBPCT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Apr 2023 11:02:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA57A92;
        Sun,  2 Apr 2023 08:02:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id l7so24926244pjg.5;
        Sun, 02 Apr 2023 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680447738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nHFl2mvT9SEziYPPu5VBnDl2VFGP+2KzbVNxuE05x4=;
        b=EDk8Bawp/BWu0hZabk8SdfKWPv6Zavbl2B2bO2hSQdXkJzBNrcGhSkk8VAA0l/dlDG
         LCCNUAjRhNxjRlUiAHh19RwJKlO2Z6XiieYuo536xiOnJi/6skOjW4JrbR6A+lxxMfd/
         gr5cwsF1LntT9gRAeFseM1ombwQz1dqSbDZxTHbvPHENpDjsvXmJfcDwi1IzvWWPXSXA
         wC0Bto6EoQqSiseaD9cPNhhUNOCBXBQOEGcfNsGZ/iwEcNFUyOIoHEMdqS6Rk6+FUSbo
         zFfOfrrXS2GtdjUBjDqWQjyifLB6LQO/lZoyMWKJ8wOKuCBJN23iro0XX6P4igI5SeSE
         DF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680447738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nHFl2mvT9SEziYPPu5VBnDl2VFGP+2KzbVNxuE05x4=;
        b=U25zc683S4LlgW4+nyD9FgNADQnd+Iv5twNo9WfCAZdYJDeR5DGtH1PY9FvFkofd/D
         SksHqfD94K/YGzenr931evEyeyto+nyymkLlJWxuWH8y+39EYA8ks22kMWPkWWW+s5Jq
         F6WD7RHOcyISge9YkVmwXjFRX8WsR4tUHl/jMjxxElhOQ59h/DyNOm+iRaXkBeF9sHCX
         QmNVv3H5sdW6+UUrDtOfDLH/PhK2t0vUem/qI/wckRI2QUlpeXAK6HPbqtBIwSuB9u9j
         bK2ZLpWUGwbBFyPAgUbofOFzaXKQjOnBwTFQnqVuWnSEPXJbQihhNOA2zf3tqLs5IWh9
         bm9g==
X-Gm-Message-State: AAQBX9fPxdIVlc0pZxpmMtAotdyn4tt0MsRQjvJF1KZa0rGfmU4QjJEZ
        mvQgGmpwNi07oSz1YI6gS6yT+Q+eoxsU4T6oIzweVQFvNpCVELEe
X-Google-Smtp-Source: AKy350YsVaUkNEA209CmY0NkgezF/KhglKHV+8Qx6xeUQ3qP2orfWFQpYG4Kq8aQzHLEwsoXgK7sGYsZAu+ON/8MGeA=
X-Received: by 2002:a17:902:868f:b0:1a0:51f6:a252 with SMTP id
 g15-20020a170902868f00b001a051f6a252mr11425184plo.3.1680447738327; Sun, 02
 Apr 2023 08:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAEm4hYW3zvte_kdWMFrv-pKVijQaL7KzbE12WHuO14s73ExUbQ@mail.gmail.com>
 <20230329163107.GA3061927@bhelgaas>
In-Reply-To: <20230329163107.GA3061927@bhelgaas>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Sun, 2 Apr 2023 23:02:07 +0800
Message-ID: <CAEm4hYXLNP6pcCj5Av35sRG6kCOF0H3+a7VfTtFfGduMgcXJhA@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: vmd: Add the module param to adjust MSI mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 12:31=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Wed, Mar 29, 2023 at 04:57:08PM +0800, Xinghui Li wrote:
> > On Wed, Mar 29, 2023 at 5:34=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > It would also be nice to include a hint about why a user would choose
> > > "on" or "off".  What is the performance effect?  What sort of I/O
> > > scenario would lead you to choose "on" vs "off"?
> > >
> > Before this patch, I sent the patch named :
> > PCI: vmd: Do not disable MSI-X remapping in VMD 28C0 controller
> > (patchwork link:
> > https://patchwork.kernel.org/project/linux-pci/patch/20221222072603.117=
5248-1-korantwork@gmail.com/)
> > We found the 4k rand read's iops could drop 50% if 4 NVMEs were
> > mounted in one PCIE port with VMD MSI bypass.
> > I suppose this is because the VMD Controller can aggregate interrupts.
> > But those test result is so long that I didn't add them to this patch
> > commit log.
> > If you believe it is necessary, I will try to add some simple instructi=
ons
>
> I don't think we need detailed performance numbers, but we need
> something like:
>
>   - "msi_remap=3Doff" improves interrupt handling performance by
>     avoiding the VMD MSI-X domain interrupt handler
>
>   - But "msi_remap=3Don" is needed when ...?
>
In the patch I send in last email, We speculate that the VMD
Controller aggregate interrupts,
making the PCIe port less stressed and improving iops. In this
case(lots of 4k random IO), if we enable the VMD MSI
remapping, we found the interrupts from VMD Controller's MSI are less
and the IOPS is much higher.
> > > ee81ee84f873 ("PCI: vmd: Disable MSI-X remapping when possible")
> > > suggests that MSI-X remapping (I assume the "msi_remap=3Don" case):
> > >
> > >   - Limits the number MSI-X vectors available to child devices to the
> > >     number of VMD MSI-X vectors.
> > >
> > >   - Reduces interrupt handling performance because child device
> > >     interrupts have to go through the VMD MSI-X domain interrupt
> > >     handler.
> > >
> > > So I assume "msi_remap=3Doff" would remove that MSI-X vector limit an=
d
> > > improve interrupt handling performance?
> > >
> > > But obviously there's more to consider because those are both good
> > > things and if we could do that all the time, we would.  So there must
> > > be cases where we *have* to remap.  ee81ee84f873 suggests that not al=
l
> > > VMD devices support disabling remap.  There's also a hint that some
> > > virt configs require it.
> > >
> > I used to just want to disable 28C0's VMD MSI bypass by default.
> > But Nirmal suggested the current method by adjusting the param.
> > Because he and other reviewers worry there are some other scenarios we
> > didn't consider.
> > Adding a method to adjust VMD'S MSI-X mode is better.
>
> This commit log doesn't outline any of those other scenarios, and it
> doesn't say anything about when "msi_remap=3Don" or "msi_remap=3Doff"
> would be necessary or desired, so I have no idea how users are
> supposed to figure out whether or not to use this parameter.
>
I do miss this part.  I'm sorry I ignored the users outside the
community or this discussion.
I will add the necessary guidelines.
> > > This patch doesn't enforce either of those things.  What happens if
> > > the user gets it wrong?
> >
> > If I am wrong, please feel free to correct me at any time.
> > I place the "vmd_config_msi_remap_param" that is VMD MSI-X's mode
> > param configuring helper front
> > "vmd_enable_domain". So, It will not change the logic disabling
> > remapping from ee81ee84f873, such as
> > "Currently MSI remapping must be enabled in guest passthrough mode".
> > So, if the user config the wrong type, it will not work, and they can
> > find it by dmesg.
>
> That's kind of a problem.  I'm not in favor of something failing and
> the user having to debug it via dmesg.  That causes user frustration
> and problem reports.
What about adding a sysfs node for it in VMD PCI bus dir, which allows
users to catch VMD's MSI current working mode?
>
> I don't know what "guest passthrough mode" is.  Can you detect that
> automatically?
I quote this from the commit ee81ee84f873's comment, it can be detected by =
the
logic like this:
if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
offset[0] || offset[1])
I just want to answer your comment: "There's also a hint that some
virt configs require it."
This patch will not modify the logic of determining whether MSI
remapping is enabled
when running VMD in Guest.

Thanks~
