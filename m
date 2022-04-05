Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2FB4F3EB2
	for <lists+linux-pci@lfdr.de>; Tue,  5 Apr 2022 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbiDEMo2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 08:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355434AbiDELOr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 07:14:47 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C4D4CD50
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 03:34:38 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 235AYIMC119521;
        Tue, 5 Apr 2022 05:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649154858;
        bh=DR2dofC4k+YCFwpS6FJDhDTV9xef2CHosonkTows2EE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cftCXFu1TZzidMsDbGFwjp1mM7bP3CbtdsmkFFLEDJkXnOPkZT+hX3DPgTbW9Bp4p
         CnaFO7jdIA83ObyajseuUiobb2fdJRlK98LE2wJsFPjXx4rSeHc+KMhV3R9iyh5Ehq
         fcPmb6kIp7z3/EUJhe9iH1OxGxTwdphWmATRtQBo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 235AYIha017000
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Apr 2022 05:34:18 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Apr 2022 05:34:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Apr 2022 05:34:17 -0500
Received: from [10.250.235.92] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 235AYDoE108818;
        Tue, 5 Apr 2022 05:34:13 -0500
Subject: Re: [PATCH V2 0/4] NTB function for PCIe RC to EP connection
To:     Frank Li <Frank.Li@nxp.com>, <helgaas@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <kw@linux.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lznuaa@gmail.com>, <hongxing.zhu@nxp.com>, <jdmason@kudzu.us>,
        <dave.jiang@intel.com>, <allenbh@gmail.com>
CC:     <linux-ntb@googlegroups.com>, <linux-pci@vger.kernel.org>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <fa2ab3cf-1508-bbeb-47af-8b2d47904b20@ti.com>
Date:   Tue, 5 Apr 2022 16:04:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220222162355.32369-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank Li,

On 22/02/22 9:53 pm, Frank Li wrote:
> This implement NTB function for PCIe EP to RC connections.
> The existed ntb epf need two PCI EPs and two PCI Host.

As I had earlier mentioned in [1], IMHO ideal solution would be build on virtio
layer instead of trying to build on NTB layer (which is specific to RC<->RC
communication).

Are there any specific reasons for not taking that path?

Thanks,
Kishon

[1] -> https://lore.kernel.org/r/459745d1-9fe7-e792-3532-33ee9552bc4d@ti.com
> 
> This just need EP to RC connections.
> 
>     ┌────────────┐         ┌─────────────────────────────────────┐
>     │            │         │                                     │
>     ├────────────┤         │                      ┌──────────────┤
>     │ NTB        │         │                      │ NTB          │
>     │ NetDev     │         │                      │ NetDev       │
>     ├────────────┤         │                      ├──────────────┤
>     │ NTB        │         │                      │ NTB          │
>     │ Transfer   │         │                      │ Transfer     │
>     ├────────────┤         │                      ├──────────────┤
>     │            │         │                      │              │
>     │  PCI NTB   │         │                      │              │
>     │    EPF     │         │                      │              │
>     │   Driver   │         │                      │ PCI Virtual  │
>     │            │         ├───────────────┐      │ NTB Driver   │
>     │            │         │ PCI EP NTB    │◄────►│              │
>     │            │         │  FN Driver    │      │              │
>     ├────────────┤         ├───────────────┤      ├──────────────┤
>     │            │         │               │      │              │
>     │  PCI BUS   │ ◄─────► │  PCI EP BUS   │      │  Virtual PCI │
>     │            │  PCI    │               │      │     BUS      │
>     └────────────┘         └───────────────┴──────┴──────────────┘
>         PCI RC                        PCI EP
> 
> 
> 
> Frank Li (4):
>   PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address
>   NTB: epf: Allow more flexibility in the memory BAR map method
>   PCI: endpoint: Support NTB transfer between RC and EP
>   Documentation: PCI: Add specification for the PCI vNTB function device
> 
>  Documentation/PCI/endpoint/index.rst          |    2 +
>  .../PCI/endpoint/pci-vntb-function.rst        |  126 ++
>  Documentation/PCI/endpoint/pci-vntb-howto.rst |  167 ++
>  drivers/ntb/hw/epf/ntb_hw_epf.c               |   48 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   |   10 +-
>  drivers/pci/endpoint/functions/Kconfig        |   11 +
>  drivers/pci/endpoint/functions/Makefile       |    1 +
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1424 +++++++++++++++++
>  8 files changed, 1775 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/PCI/endpoint/pci-vntb-function.rst
>  create mode 100644 Documentation/PCI/endpoint/pci-vntb-howto.rst
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vntb.c
> 
