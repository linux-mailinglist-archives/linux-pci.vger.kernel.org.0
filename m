Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FE51583E7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 20:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBJTs2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 14:48:28 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:42560 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJTs2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2020 14:48:28 -0500
Received: by mail-oi1-f172.google.com with SMTP id j132so10370966oih.9;
        Mon, 10 Feb 2020 11:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRFAgHTjcpru4Yh3cmh88ozwK6oz4DRfN4/AXw7tuCc=;
        b=FkBgNkfb1vKrksM2KmB5EvzuRqrsTVNhhZGV3hwVDFUWFX4jzETCFSU/FNdsWZoh/H
         DU6ENvSS9Z0psONgo8Puc1w2LTVG/T52tHsRUpuMkKxGVoDrG9hyNDwxbDPwoMRZBywG
         y22WwKOLb9xw4/SOotLBd13wSvA5VcgNichBIjfY85suSWEh8mU7y8zeHcehq5pkV66d
         mUPqOxzMPnNBp1vzLIIFnHmbNHuhTP7JsVFV9SgsFQjvg49AGmGDp75VyFOoAr+73JyW
         9SL7wHaoYI194HFUpG2oNSYsjE4nM/xTMiuVLSMfg8fDRofcLeO3Q3iNX21juZydemnk
         MI9g==
X-Gm-Message-State: APjAAAX/HIP/EOZtZLEEdcyNxh8ZHK012WL3swWpbO22nrTsu4LQTzqI
        i1IPKuhLAKlYojVYlAZWAot819kFVqc=
X-Google-Smtp-Source: APXvYqxz2YnkuCkbNDnyYSLmdm2eFbVIaeblL6OSBhWfjzGPCfeMRteB2Zrg9xj19t9L35u9sPm/vA==
X-Received: by 2002:a05:6808:611:: with SMTP id y17mr444497oih.146.1581364106617;
        Mon, 10 Feb 2020 11:48:26 -0800 (PST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id q6sm373450otn.73.2020.02.10.11.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 11:48:26 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id b18so7656822otp.0;
        Mon, 10 Feb 2020 11:48:25 -0800 (PST)
X-Received: by 2002:a05:6830:1184:: with SMTP id u4mr2168328otq.221.1581364105459;
 Mon, 10 Feb 2020 11:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com> <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com> <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
 <20200210152257.GD25745@shell.armlinux.org.uk> <CAOesGMj6B-X1s8-mYqS0N6GJXdKka1MxaNV=33D1H++h7bmXrA@mail.gmail.com>
 <CADRPPNSXPCVQEWXfYOpmGBCXMg2MvSPqDEMeeH_8VhkPHDuR5w@mail.gmail.com>
In-Reply-To: <CADRPPNSXPCVQEWXfYOpmGBCXMg2MvSPqDEMeeH_8VhkPHDuR5w@mail.gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 10 Feb 2020 13:48:14 -0600
X-Gmail-Original-Message-ID: <CADRPPNQ6wYOXzH_Hh9x4YDN_Mg1iaiYqMM8p_m9zJXfr_TQayw@mail.gmail.com>
Message-ID: <CADRPPNQ6wYOXzH_Hh9x4YDN_Mg1iaiYqMM8p_m9zJXfr_TQayw@mail.gmail.com>
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
To:     Olof Johansson <olof@lixom.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 10, 2020 at 12:41 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> On Mon, Feb 10, 2020 at 9:32 AM Olof Johansson <olof@lixom.net> wrote:
> >
> > On Mon, Feb 10, 2020 at 4:23 PM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Mon, Feb 10, 2020 at 04:12:30PM +0100, Olof Johansson wrote:
> > > > On Thu, Feb 6, 2020 at 11:57 AM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
> > > > >
> > > > > Hi Olof,
> > > > >
> > > > > Thanks a lot for your comments!
> > > > > And sorry for my delay respond!
> > > >
> > > > Actually, they apply with only minor conflicts on top of current -next.
> > > >
> > > > Bjorn, any chance we can get you to pick these up pretty soon? They
> > > > enable full use of a promising ARM developer system, the SolidRun
> > > > HoneyComb, and would be quite valuable for me and others to be able to
> > > > use with mainline or -next without any additional patches applied --
> > > > which this patchset achieves.
> > > >
> > > > I know there are pending revisions based on feedback. I'll leave it up
> > > > to you and others to determine if that can be done with incremental
> > > > patches on top, or if it should be fixed before the initial patchset
> > > > is applied. But all in all, it's holding up adaption by me and surely
> > > > others of a very interesting platform -- I'm looking to replace my
> > > > aging MacchiatoBin with one of these and would need PCIe/NVMe to work
> > > > before I do.
> > >
> > > If you're going to be using NVMe, make sure you use a power-fail safe
> > > version; I've already had one instance where ext4 failed to mount
> > > because of a corrupted journal using an XPG SX8200 after the Honeycomb
> > > Serror'd, and then I powered it down after a few hours before later
> > > booting it back up.
> > >
> > > EXT4-fs (nvme0n1p2): INFO: recovery required on readonly filesystem
> > > EXT4-fs (nvme0n1p2): write access will be enabled during recovery
> > > JBD2: journal transaction 80849 on nvme0n1p2-8 is corrupt.
> > > EXT4-fs (nvme0n1p2): error loading journal
> >
> > Hmm, using btrfs on mine, not sure if the exposure is similar or not.
> >
> > Do you know if the SErr was due to a known issue and/or if it's
> > something that's fixed in production silicon?
> >
> > (I still can't enable SMMU since across a warm reboot it fails
> > *completely*, with nothing coming up and working. NXP folks, you
> > listening? :)
>
> This is a known issue about DPAA2 MC bus not working well with SMMU
> based IO mapping.  Adding Laurentiu to the chain who has been looking
> into this issue.

Forgot to mention that you can workaround the issue by setting
CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT=n or adding
"arm-smmu.disable_bypass=0" to boot parameters.

Regards,
Leo
