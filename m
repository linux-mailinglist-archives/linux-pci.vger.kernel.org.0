Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8743A9CF1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 16:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhFPOIV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 10:08:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42120 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhFPOIU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 10:08:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15GE5f8W117835;
        Wed, 16 Jun 2021 09:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623852341;
        bh=qJ2GnQxd+yS6ISLDIaGuRDIGnMu21lKltpoDuOcviVs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Y9lT3fiGcNzub92cli5OVPZlfJJkKpeM+luPVBsr3MFOO6ZPHHHJVpQ+nkPKYeZGc
         Oigl/gNPm6mvRw7bjJe5x+TOImMI9XtSlzgnK3dGiblZxaNItnhloXDa+TP398uVTd
         GrMY0JrzySfFxPP8q/iiHvxNcpR1bO38e/T6BowE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15GE5fR8015784
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jun 2021 09:05:41 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 16
 Jun 2021 09:05:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 16 Jun 2021 09:05:40 -0500
Received: from [10.250.233.239] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15GE5XZj082268;
        Wed, 16 Jun 2021 09:05:34 -0500
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
        Heiko Stuebner <heiko@sntech.de>
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
Message-ID: <d5bcf443-a0ee-fda5-5c5c-d69d25b53bb9@ti.com>
Date:   Wed, 16 Jun 2021 19:35:33 +0530
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

Hi Lorenzo, Bjorn,

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

Can this series be merged for 5.14? It already includes Ack from Rob for
dt-binding changes and Ack from Tom for Cadence driver changes.

Thanks
Kishon
