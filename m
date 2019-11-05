Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A57F0752
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 21:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfKEUy5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 15:54:57 -0500
Received: from foss.arm.com ([217.140.110.172]:53458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfKEUy5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 15:54:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36D7C30E;
        Tue,  5 Nov 2019 12:54:56 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A0CB4014A;
        Tue,  5 Nov 2019 04:37:41 -0800 (PST)
Date:   Tue, 5 Nov 2019 12:37:39 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.co" <lorenzo.pieralisi@arm.co>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 07/10] PCI: layerscape: Modify the MSIX to the
 doorbell way
Message-ID: <20191105123739.GB26960@e121166-lin.cambridge.arm.com>
References: <20190822112242.16309-1-xiaowei.bao@nxp.com>
 <20190822112242.16309-7-xiaowei.bao@nxp.com>
 <20190823135816.GH14582@e119886-lin.cambridge.arm.com>
 <AM5PR04MB3299E50BA5D7579D41B8B4F9F5A70@AM5PR04MB3299.eurprd04.prod.outlook.com>
 <20190827132504.GL14582@e119886-lin.cambridge.arm.com>
 <e64a484c-7cf5-5f65-400c-47128ab45e52@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e64a484c-7cf5-5f65-400c-47128ab45e52@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 29, 2019 at 10:43:18AM +0530, Kishon Vijay Abraham I wrote:
> Gustavo,
> 
> On 27/08/19 6:55 PM, Andrew Murray wrote:
> > On Sat, Aug 24, 2019 at 12:08:40AM +0000, Xiaowei Bao wrote:
> >>
> >>
> >>> -----Original Message-----
> >>> From: Andrew Murray <andrew.murray@arm.com>
> >>> Sent: 2019年8月23日 21:58
> >>> To: Xiaowei Bao <xiaowei.bao@nxp.com>
> >>> Cc: bhelgaas@google.com; robh+dt@kernel.org; mark.rutland@arm.com;
> >>> shawnguo@kernel.org; Leo Li <leoyang.li@nxp.com>; kishon@ti.com;
> >>> lorenzo.pieralisi@arm.co; arnd@arndb.de; gregkh@linuxfoundation.org; M.h.
> >>> Lian <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Roy
> >>> Zang <roy.zang@nxp.com>; jingoohan1@gmail.com;
> >>> gustavo.pimentel@synopsys.com; linux-pci@vger.kernel.org;
> >>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org
> >>> Subject: Re: [PATCH v2 07/10] PCI: layerscape: Modify the MSIX to the
> >>> doorbell way
> >>>
> >>> On Thu, Aug 22, 2019 at 07:22:39PM +0800, Xiaowei Bao wrote:
> >>>> The layerscape platform use the doorbell way to trigger MSIX interrupt
> >>>> in EP mode.
> >>>>
> >>>
> >>> I have no problems with this patch, however...
> >>>
> >>> Are you able to add to this message a reason for why you are making this
> >>> change? Did dw_pcie_ep_raise_msix_irq not work when func_no != 0? Or did
> >>> it work yet dw_pcie_ep_raise_msix_irq_doorbell is more efficient?
> >>
> >> The fact is that, this driver is verified in ls1046a platform of NXP before, and ls1046a don't
> >> support MSIX feature, so I set the msix_capable of pci_epc_features struct is false,
> >> but in other platform, e.g. ls1088a, it support the MSIX feature, I verified the MSIX
> >> feature in ls1088a, it is not OK, so I changed to another way. Thanks.
> > 
> > Right, so the existing pci-layerscape-ep.c driver never supported MSIX yet it
> > erroneously had a switch case statement to call dw_pcie_ep_raise_msix_irq which
> > would never get used.
> > 
> > Now that we're adding a platform with MSIX support the existing
> > dw_pcie_ep_raise_msix_irq doesn't work (for this platform) so we are adding a
> > different method.
> 
> Gustavo, can you confirm dw_pcie_ep_raise_msix_irq() works for
> designware as it didn't work for both me and Xiaowei?

This question needs an answer.

Thanks,
Lorenzo
