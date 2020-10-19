Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E638F292B42
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 18:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgJSQNs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 12:13:48 -0400
Received: from foss.arm.com ([217.140.110.172]:32928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730504AbgJSQNr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Oct 2020 12:13:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2263F1FB;
        Mon, 19 Oct 2020 09:13:47 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF6953F66B;
        Mon, 19 Oct 2020 09:13:45 -0700 (PDT)
Date:   Mon, 19 Oct 2020 17:13:31 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Walle <michael@walle.cc>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Message-ID: <20201019161311.GA9813@e121166-lin.cambridge.arm.com>
References: <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
 <HE1PR0402MB337180458625B05D1529535384390@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <20200928093911.GB12010@e121166-lin.cambridge.arm.com>
 <HE1PR0402MB33713A623A37D08AE3253DEB84320@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <DM5PR12MB1276D80424F88F8A9243D5E2DA320@DM5PR12MB1276.namprd12.prod.outlook.com>
 <CAL_JsqJJxq2jZzbzZffsrPxnoLJdWLLS-7bG-vaqyqs5NkQhHQ@mail.gmail.com>
 <9ac53f04-f2e8-c5f9-e1f7-e54270ec55a0@ti.com>
 <CAL_JsqJEp8yyctJYUjHM4Ti6ggPb4ouYM_WDvpj_PiobnAozBw@mail.gmail.com>
 <67ac959f-561e-d1a0-2d89-9a85d5f92c72@ti.com>
 <HE1PR0402MB3371684F1578E953F881CE5484070@HE1PR0402MB3371.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0402MB3371684F1578E953F881CE5484070@HE1PR0402MB3371.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 12, 2020 at 04:41:11AM +0000, Z.q. Hou wrote:

[...]

> > >> Yeah, I don't see any registers in the DRA7x PCIe wrapper for
> > >> disabling error forwarding.
> > >
> > > It's a DWC port logic register AFAICT, but perhaps not present in all
> > versions.
> > 
> > Okay. I see there's a register PCIECTRL_PL_AXIS_SLV_ERR_RESP which has a
> > reset value of 0.
> > 
> > It has four bit-fields, RESET_TIMEOUT_ERR_MAP, NO_VID_ERR_MAP,
> > DBI_ERR_MAP and SLAVE_ERR_MAP. I'm not seeing any difference in
> > behavior if I set all these bits. Maybe it requires platform support too. I'll
> > check this with our design team.
> 
> In DWC v4.40a databook, there is a bit AMBA_ERROR_RESPONSE_GLOBAL
> which controls if enable the error forwarding. The *MAP bits only
> determine which error (SLVERR or DECERR) will be forwarded to AXI/AHB
> bus.

I have not seen a follow-up to this but I would like to, still keen
on avoiding this patch if possible - if this is port logic it should
be common across controllers implementations I assume.

Gustavo, Kishon ?

Thanks,
Lorenzo

> Thanks,
> Zhiqiang
> 
> > 
> > Meanwhile would it be okay to add linkup check atleast for DRA7X so that
> > we could have it booting in linux-next?
> > 
> > Thanks
> > Kishon
