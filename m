Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7BF137156
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 16:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgAJPd5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 10:33:57 -0500
Received: from foss.arm.com ([217.140.110.172]:46848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgAJPd5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jan 2020 10:33:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D7BC30E;
        Fri, 10 Jan 2020 07:33:56 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 268623F6C4;
        Fri, 10 Jan 2020 07:33:54 -0800 (PST)
Date:   Fri, 10 Jan 2020 15:33:47 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     Olof Johansson <olof@lixom.net>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
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
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Message-ID: <20200110153347.GA29372@e121166-lin.cambridge.arm.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 17, 2019 at 02:50:15AM +0000, Z.q. Hou wrote:
> Hi Lorenzo,
> 
> The v9 patches have addressed the comments from Andrew, and it has
> been dried about 1 month, can you help to apply them?

We shall have a look beginning of next week, sorry for the delay
in getting back to you.

Lorenzo

> Thanks,
> Zhiqiang
> 
> > -----Original Message-----
> > From: Olof Johansson <olof@lixom.net>
> > Sent: 2019年12月14日 2:37
> > To: Z.q. Hou <zhiqiang.hou@nxp.com>; bhelgaas@google.com
> > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > robh+dt@kernel.org; arnd@arndb.de; mark.rutland@arm.com;
> > l.subrahmanya@mobiveil.co.in; shawnguo@kernel.org;
> > m.karthikeyan@mobiveil.co.in; Leo Li <leoyang.li@nxp.com>;
> > lorenzo.pieralisi@arm.com; catalin.marinas@arm.com;
> > will.deacon@arm.com; andrew.murray@arm.com; Mingkai Hu
> > <mingkai.hu@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>; Xiaowei Bao
> > <xiaowei.bao@nxp.com>
> > Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
> > driver for NXP Layerscape SoCs
> > 
> > Hi!
> > 
> > On Tue, Nov 19, 2019 at 7:45 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
> > >
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > This patch set is to recode the Mobiveil driver and add PCIe support
> > > for NXP Layerscape series SoCs integrated Mobiveil's PCIe Gen4
> > > controller.
> > 
> > Can we get a respin for this on top of the 5.5 merge window material?
> > Given that it's a bunch of refactorings, many of them don't apply on top of
> > the material that was merged.
> > 
> > I'd love to see these go in sooner rather than later so I can start getting -next
> > running on ls2160a here.
> > 
> > 
> > -Olof
