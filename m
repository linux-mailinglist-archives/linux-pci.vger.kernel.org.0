Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6068F2DC2AD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Dec 2020 16:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgLPPDr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Dec 2020 10:03:47 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36536 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgLPPDq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2020 10:03:46 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BGF1qVw044683;
        Wed, 16 Dec 2020 09:01:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608130912;
        bh=PPPWoLxhLgX8Ti9lzpXYC7Vt5i4usJeVSwnKRKTXbYI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dPDsgeW2AZzHpCZlfom40pD8p5I3BqXbfjpPnP0AThfYpJCXkAoPJjY+dIv1IZEDN
         OXIglDIHCELWri8LH1dGiDbnvcRjtuQeUIrJ95NFFXUO5M8P74ox0xGicHE0SRw+E1
         xp3LPNZ94u61O/dRFzZW8MhWGDmYYn0SBGL1Y0ps=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BGF1qhr108499
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 09:01:52 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Dec 2020 09:01:52 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Dec 2020 09:01:52 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BGF1mbG022107;
        Wed, 16 Dec 2020 09:01:49 -0600
Subject: Re: [PATCH v5] PCI: cadence: Retrain Link to work around Gen2
 training defect.
To:     Rob Herring <robh@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nadeem Athani <nadeem@cadence.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
References: <20201215070009.27937-1-kishon@ti.com>
 <CAL_JsqJzi7JkMcd4NZewA=w8q6BsCkrhW3JcED63R=EyE3v29Q@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1ec78477-dadc-cbef-406f-568f44b6c62d@ti.com>
Date:   Wed, 16 Dec 2020 20:31:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJzi7JkMcd4NZewA=w8q6BsCkrhW3JcED63R=EyE3v29Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 15/12/20 9:23 pm, Rob Herring wrote:
> On Tue, Dec 15, 2020 at 1:00 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> From: Nadeem Athani <nadeem@cadence.com>
>>
>> Cadence controller will not initiate autonomous speed change if strapped as
>> Gen2. The Retrain Link bit is set as quirk to enable this speed change.
>>
>> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
>> [kishon@ti.com: Enable the workaround for TI's J721E SoC]
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>> Hi Lorenzo,
>> The previous version of the patch can be found at [1].
>> I slightly re-worked the patch from Nadeem
>> *) Removed additional Link Up Check
>> *) Removed quirk from pcie-cadence-plat.c
>> *) Also removed additional compatible
>>    "cdns,cdns-pcie-host-quirk-retrain" added in that series
>> *) Enabled the quirk for J721E
>> [1] -> http://lore.kernel.org/r/20201211144236.3825-1-nadeem@cadence.com
>>
>>  drivers/pci/controller/cadence/pci-j721e.c    |  3 +
>>  .../controller/cadence/pcie-cadence-host.c    | 67 ++++++++++++++-----
>>  drivers/pci/controller/cadence/pcie-cadence.h | 11 ++-
>>  3 files changed, 62 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
>> index dac1ac8a7615..baf729850cb1 100644
>> --- a/drivers/pci/controller/cadence/pci-j721e.c
>> +++ b/drivers/pci/controller/cadence/pci-j721e.c
>> @@ -64,6 +64,7 @@ enum j721e_pcie_mode {
>>
>>  struct j721e_pcie_data {
>>         enum j721e_pcie_mode    mode;
>> +       bool                    quirk_retrain_flag;
>>  };
>>
>>  static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
>> @@ -280,6 +281,7 @@ static struct pci_ops cdns_ti_pcie_host_ops = {
>>
>>  static const struct j721e_pcie_data j721e_pcie_rc_data = {
>>         .mode = PCI_MODE_RC,
>> +       .quirk_retrain_flag = true,
>>  };
>>
>>  static const struct j721e_pcie_data j721e_pcie_ep_data = {
>> @@ -388,6 +390,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>>
>>                 bridge->ops = &cdns_ti_pcie_host_ops;
>>                 rc = pci_host_bridge_priv(bridge);
>> +               rc->quirk_retrain_flag = data->quirk_retrain_flag;
>>
>>                 cdns_pcie = &rc->pcie;
>>                 cdns_pcie->dev = dev;
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 811c1cb2e8de..773c0d1137ed 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -77,6 +77,50 @@ static struct pci_ops cdns_pcie_host_ops = {
>>         .write          = pci_generic_config_write,
>>  };
>>
>> +static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
>> +{
>> +       struct device *dev = pcie->dev;
>> +       int retries;
>> +
>> +       /* Check if the link is up or not */
>> +       for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>> +               if (cdns_pcie_link_up(pcie)) {
>> +                       dev_info(dev, "Link up\n");
>> +                       return 0;
>> +               }
>> +               usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>> +       }
>> +
>> +       return -ETIMEDOUT;
>> +}
>> +
>> +static void cdns_pcie_retrain(struct cdns_pcie *pcie)
>> +{
>> +       u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
>> +       u16 lnk_stat, lnk_ctl;
>> +
>> +       /*
>> +        * Set retrain bit if current speed is 2.5 GB/s,
>> +        * but the PCIe root port support is > 2.5 GB/s.
> 
> If you don't have the retrain quirk, wouldn't this condition never
> happen and then the function is just a nop? So this could just be
> called unconditionally.

Yeah, but only for the quirk we have to retrain to go to GEN2 speed
mode. Else the HW will automatically retrain and go to GEN2.

Thank You,
Kishon
