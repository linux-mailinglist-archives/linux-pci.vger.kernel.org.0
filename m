Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA41157E85
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 16:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgBJPNQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 10:13:16 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:45024 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgBJPNP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2020 10:13:15 -0500
Received: by mail-il1-f170.google.com with SMTP id s85so472039ill.11
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2020 07:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhN4XtFCJkoq1uQy3zAa0gdyCp3Sl71uMPy2Eyj8+bE=;
        b=I/xFN0o6OHNqlV1vOX3xfGZ8d/9J7hUwnWgRkbtmq5yervupWrbgBcGxfGD0b8sYLC
         uwcGuejk6bD/ZVkpBth8Jjaa713iNs++YsuJPMlSmtwGys5Gej+Xh2SSNPtHIoOeigwl
         V98nNsFb2EBay4fOu+ill9j4oWB/gkUdI0yu51YKQnRETpoRkcL5c00+Gq/LH+LCLxlH
         laj+IEGsZEzC7ASAVdAWUuf/cVDMbEiNHcd2qjXFZ2RG1UO3Q6bgSxySNgoDxU5Sc2K5
         iyTcCsUu5ozZRmiqGYQtnaI/XkwlXp7xqsE/jANCwbVG2Kvz90jDI8wrUC7x+dciP+Rx
         JiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhN4XtFCJkoq1uQy3zAa0gdyCp3Sl71uMPy2Eyj8+bE=;
        b=BuMBErfDOevkHvCy2IA3kQVVM3Fuv6nnzNxj/XLg4On610KC0bwtfgXXf4BHRNCutn
         5xtMiY+g3tSt9AHZXQ24sheROwj5X3RVTs66fRXdq5Mgpx0jY/By7BfWfE3rqQBWhaA8
         iXKweJWQRDU8UJHDu+a8AkvhEpVLW1Xc6y1rvbn0doFduegdBye6bwaWxoeZyLpgakCT
         4+ZvoABSksPd7Exmis18Qy7efpb81xEeyqWnv2Z7ZUW+i+LkzwE72smnzZXFdp4GuVsN
         3TKx0EgfPoRuYTqibNQEOiHKKh2EL4maImm1RwGdqn4PzsdZhv6mLyHseEc78NBbd0Pl
         MuYA==
X-Gm-Message-State: APjAAAUjD2brsw0y2FXietlX+60xy+OFs2SA71VR8oaWR2i2OorXEPi8
        ZIHA1sWIXLDTnSmJhn8gIaKSkelIgJuIO/o3TKvqbQ==
X-Google-Smtp-Source: APXvYqz8NJ/XJCZgc65CapYNrLpMIOjiJgGhRG/vY2GtMRsBh+nwgtkTAaBtEJw8o0Ee3qShBauPgKT/rw5SSdeonlg=
X-Received: by 2002:a92:ba8d:: with SMTP id t13mr1821680ill.207.1581347594542;
 Mon, 10 Feb 2020 07:13:14 -0800 (PST)
MIME-Version: 1.0
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com> <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com> <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 10 Feb 2020 16:12:30 +0100
Message-ID: <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 6, 2020 at 11:57 AM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> Hi Olof,
>
> Thanks a lot for your comments!
> And sorry for my delay respond!

Actually, they apply with only minor conflicts on top of current -next.

Bjorn, any chance we can get you to pick these up pretty soon? They
enable full use of a promising ARM developer system, the SolidRun
HoneyComb, and would be quite valuable for me and others to be able to
use with mainline or -next without any additional patches applied --
which this patchset achieves.

I know there are pending revisions based on feedback. I'll leave it up
to you and others to determine if that can be done with incremental
patches on top, or if it should be fixed before the initial patchset
is applied. But all in all, it's holding up adaption by me and surely
others of a very interesting platform -- I'm looking to replace my
aging MacchiatoBin with one of these and would need PCIe/NVMe to work
before I do.


Thanks!


-Olof
