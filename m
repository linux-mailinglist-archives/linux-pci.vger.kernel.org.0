Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB06B27BC6C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 07:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgI2FZG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 01:25:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56482 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgI2FZG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 01:25:06 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08T5NNdV076112;
        Tue, 29 Sep 2020 00:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601357003;
        bh=lsVV+WiqwympooMTHM7zY4Y8lKNeYX3fBUBfCVJ/Lnk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=u9RTZSY0p8VY3yd+DO/wPxiDmHvgLQOv/9YyP5Bfl/tblOAubCsvONbhwUbgLjdbZ
         /cKGeAx5m0FGThnxI/nhlD7bUNB6726QeZ1KmtFTV+0GoBh7x9Bqi8kn2kw+XnRSJ+
         /r1DJzmnQoK8W/Xv9PAXZUBvtkpZnJ/GFO0hybSw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08T5NNpG047481
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 00:23:23 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 29
 Sep 2020 00:23:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 29 Sep 2020 00:23:22 -0500
Received: from [10.250.232.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08T5NAKG078844;
        Tue, 29 Sep 2020 00:23:11 -0500
Subject: Re: [PATCH v2 00/40] PCI: dwc: Driver clean-ups
To:     Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
CC:     "Gross, Andy" <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Kukjin Kim <kgene@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@axis.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <maz@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawn.guo@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Song Xiaowei <songxiaowei@hisilicon.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Yue Wang <yue.wang@amlogic.com>
References: <20200821035420.380495-1-robh@kernel.org>
 <20200915091218.28737-1-michael@walle.cc>
 <CAL_JsqLHBPduSjs1L3R2vbsLygJNDzajt4XThAkRG0DEu-GnAA@mail.gmail.com>
 <346b694e43b1b6b86e4f3164e6589d25@walle.cc>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6b776dda-e575-74f0-5575-0e5d30641522@ti.com>
Date:   Tue, 29 Sep 2020 10:53:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <346b694e43b1b6b86e4f3164e6589d25@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 16/09/20 1:24 pm, Michael Walle wrote:
> Am 2020-09-16 00:02, schrieb Rob Herring:
>> Can you try this? The link up check seemed unnecessary as it is racy.
>> What happens if the link goes down right after checking? That's the
>> only thing in the change that sticks out.
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 317ff512f8df..afee1a0e8883 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -441,6 +441,9 @@ static void __iomem
>> *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
>>         struct pcie_port *pp = bus->sysdata;
>>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>
>> +       if (!dw_pcie_link_up(pci))
>> +               return NULL;
>> +
>>         busdev = PCIE_ATU_BUS(bus->number) |
>> PCIE_ATU_DEV(PCI_SLOT(devfn)) |
>>                  PCIE_ATU_FUNC(PCI_FUNC(devfn));
> 
> This will fix the issue.

This fix is required to get DRA7 EVM booting again in linux-next.

Thanks
Kishon
