Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88892876B7
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgJHPI0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 11:08:26 -0400
Received: from foss.arm.com ([217.140.110.172]:33994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729833AbgJHPI0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Oct 2020 11:08:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B95EB1063;
        Thu,  8 Oct 2020 08:08:25 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83FE23F70D;
        Thu,  8 Oct 2020 08:08:24 -0700 (PDT)
Date:   Thu, 8 Oct 2020 16:08:19 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Walle <michael@walle.cc>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Message-ID: <20201008150819.GA3871@e121166-lin.cambridge.arm.com>
References: <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
 <HE1PR0402MB337180458625B05D1529535384390@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <20200928093911.GB12010@e121166-lin.cambridge.arm.com>
 <HE1PR0402MB33713A623A37D08AE3253DEB84320@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <DM5PR12MB1276D80424F88F8A9243D5E2DA320@DM5PR12MB1276.namprd12.prod.outlook.com>
 <CAL_JsqJJxq2jZzbzZffsrPxnoLJdWLLS-7bG-vaqyqs5NkQhHQ@mail.gmail.com>
 <9ac53f04-f2e8-c5f9-e1f7-e54270ec55a0@ti.com>
 <CAL_JsqJEp8yyctJYUjHM4Ti6ggPb4ouYM_WDvpj_PiobnAozBw@mail.gmail.com>
 <67ac959f-561e-d1a0-2d89-9a85d5f92c72@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ac959f-561e-d1a0-2d89-9a85d5f92c72@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 01, 2020 at 07:02:04PM +0530, Kishon Vijay Abraham I wrote:

[...]

> >> Yeah, I don't see any registers in the DRA7x PCIe wrapper for disabling
> >> error forwarding.
> > 
> > It's a DWC port logic register AFAICT, but perhaps not present in all versions.
> 
> Okay. I see there's a register PCIECTRL_PL_AXIS_SLV_ERR_RESP which has a
> reset value of 0.
> 
> It has four bit-fields, RESET_TIMEOUT_ERR_MAP, NO_VID_ERR_MAP,
> DBI_ERR_MAP and SLAVE_ERR_MAP. I'm not seeing any difference in behavior
> if I set all these bits. Maybe it requires platform support too. I'll
> check this with our design team.
> 
> Meanwhile would it be okay to add linkup check atleast for DRA7X so that
> we could have it booting in linux-next?

Do you mind sending a patch on top of my pci/dwc please ?

Thanks,
Lorenzo
