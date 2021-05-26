Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B600391772
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 14:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhEZMhj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 08:37:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40364 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbhEZMhg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 08:37:36 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QCZGMg006614;
        Wed, 26 May 2021 07:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622032516;
        bh=3bBG8BqrGtdkKHvGc5OmGFJ5N2skyD9sMRW9+N98L+o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AQQjUuHvb8tTt9TCk++YgygGukBZ1fpcROn+F1ysRMsZzDJlEX0FrdQbmad2L/qjQ
         9juB1F7EyXkcx6CWnoRy8xUMOahaq6+yrOb77px7qAdK+hOZ3aDXIzjOkS7fdpnaCm
         Qy8QFYLy2i6fJu4xaJfbryxViplR6b1RVXNC8pho=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QCZFBC103444
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 07:35:15 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 07:35:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 07:35:15 -0500
Received: from [10.250.138.168] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QCYxVx038658;
        Wed, 26 May 2021 07:35:01 -0500
Subject: Re: [PATCH v6 0/7] Add SR-IOV support in PCIe Endpoint Core
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        <yoshihiro.shimoda.uh@renesas.com>, <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
CC:     Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210517074723.10212-1-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <11f417e8-6bc5-93dd-f915-04b352bc61d1@ti.com>
Date:   Wed, 26 May 2021 18:04:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210517074723.10212-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

On 17/05/21 1:17 pm, Kishon Vijay Abraham I wrote:
> Patch series
> *) Adds support to add virtual functions to enable endpoint controller
>    which supports SR-IOV capability
> *) Add support in Cadence endpoint driver to configure virtual functions
> *) Enable pci_endpoint_test driver to create pci_device for virtual
>    functions
> 
> v1 of the patch series can be found at [1]
> v2 of the patch series can be found at [2]
> v3 of the patch series can be found at [3]
> v4 of the patch series can be found at [4]
> v5 of the patch series can be found at [5]
> 
> Here both physical functions and virtual functions use the same
> pci_endpoint_test driver and existing pcitest utility can be used
> to test virtual functions as well.

I request to help test this series in your platform either with SR-IOV
capability or without SR-IOV capability to make sure there are no
regressions.

Thanks in advance for the help!

Best Regards
Kishon

> 
> Changes from v5:
> *) Rebased to 5.13-rc1
> 
> Changes from v4:
> *) Added a fix in Cadence driver which was overwriting BAR configuration
>    of physical function.
> *) Didn't include Tom's Acked-by since Cadence driver is modified in
>    this revision.
> 
> Changes from v3:
> *) Fixed Rob's comment and added his Reviewed-by as suggested by him.
> 
> Changes from v2:
> *) Fixed DT binding documentation comment by Rob
> *) Fixed the error check in pci-epc-core.c
> 
> Changes from v1:
> *) Re-based and Re-worked to latest kernel 5.10.0-rc2+ (now has generic
>    binding for EP)
> 
> [1] -> http://lore.kernel.org/r/20191231113534.30405-1-kishon@ti.com
> [2] -> http://lore.kernel.org/r/20201112175358.2653-1-kishon@ti.com
> [3] -> https://lore.kernel.org/r/20210305050410.9201-1-kishon@ti.com
> [4] -> http://lore.kernel.org/r/20210310160943.7606-1-kishon@ti.com
> [5] -> https://lore.kernel.org/r/20210419083401.31628-1-kishon@ti.com
> 
> Kishon Vijay Abraham I (7):
>   dt-bindings: PCI: pci-ep: Add binding to specify virtual function
>   PCI: endpoint: Add support to add virtual function in endpoint core
>   PCI: endpoint: Add support to link a physical function to a virtual
>     function
>   PCI: endpoint: Add virtual function number in pci_epc ops
>   PCI: cadence: Add support to configure virtual functions
>   misc: pci_endpoint_test: Populate sriov_configure ops to configure
>     SR-IOV device
>   Documentation: PCI: endpoint/pci-endpoint-cfs: Guide to use SR-IOV
> 
>  .../PCI/endpoint/pci-endpoint-cfs.rst         |  12 +-
>  .../devicetree/bindings/pci/pci-ep.yaml       |   7 +
>  drivers/misc/pci_endpoint_test.c              |   1 +
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 285 ++++++++++++++----
>  drivers/pci/controller/cadence/pcie-cadence.h |   7 +
>  .../pci/controller/dwc/pcie-designware-ep.c   |  36 +--
>  drivers/pci/controller/pcie-rcar-ep.c         |  19 +-
>  drivers/pci/controller/pcie-rockchip-ep.c     |  18 +-
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  |  79 +++--
>  drivers/pci/endpoint/functions/pci-epf-test.c |  66 ++--
>  drivers/pci/endpoint/pci-ep-cfs.c             |  24 ++
>  drivers/pci/endpoint/pci-epc-core.c           | 130 +++++---
>  drivers/pci/endpoint/pci-epf-core.c           | 144 ++++++++-
>  include/linux/pci-epc.h                       |  57 ++--
>  include/linux/pci-epf.h                       |  16 +-
>  15 files changed, 684 insertions(+), 217 deletions(-)
> 
