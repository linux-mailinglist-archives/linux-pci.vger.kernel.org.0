Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577382DE50D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 15:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgLROoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 09:44:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40594 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgLROoN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2020 09:44:13 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BIEgJ1h002175;
        Fri, 18 Dec 2020 08:42:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608302539;
        bh=pTnSOVQlYaLLFPXX46y4VH9Zff6M5493tQ8KFZNlnPg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qVoAcJrFpHv8UTLXJKvQVTwSvNJ8ZEnkeV7DBTCkURzuONJJ6bdsu7HivHuSkK4uZ
         rCK+HZSjzBIG4mlmB6a+4y+SMxztzzM9J38Oqaf0i/GXQ5uULFPBjYrK63pAiC3ygn
         lNtfC3xxZpPYoxzBWgqwwMBSjjYLM6IeAMvwXP4k=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BIEgJQ7111684
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 08:42:19 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Dec 2020 08:42:18 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Dec 2020 08:42:18 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BIEgEl9113653;
        Fri, 18 Dec 2020 08:42:15 -0600
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
 <1ec78477-dadc-cbef-406f-568f44b6c62d@ti.com>
 <CAL_JsqLepmopGObX_r+7gtR+keaNtEAA3WA1j697T4jAWP8DHA@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <96ca64cb-ec3a-bb83-2de3-775034ba844b@ti.com>
Date:   Fri, 18 Dec 2020 20:12:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLepmopGObX_r+7gtR+keaNtEAA3WA1j697T4jAWP8DHA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 16/12/20 10:31 pm, Rob Herring wrote:
> On Wed, Dec 16, 2020 at 9:01 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Rob,
>>
>> On 15/12/20 9:23 pm, Rob Herring wrote:
>>> On Tue, Dec 15, 2020 at 1:00 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>>
>>>> From: Nadeem Athani <nadeem@cadence.com>
>>>>
>>>> Cadence controller will not initiate autonomous speed change if strapped as
>>>> Gen2. The Retrain Link bit is set as quirk to enable this speed change.
>>>>
>>>> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
>>>> [kishon@ti.com: Enable the workaround for TI's J721E SoC]
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>> Hi Lorenzo,
>>>> The previous version of the patch can be found at [1].
>>>> I slightly re-worked the patch from Nadeem
>>>> *) Removed additional Link Up Check
>>>> *) Removed quirk from pcie-cadence-plat.c
>>>> *) Also removed additional compatible
>>>>    "cdns,cdns-pcie-host-quirk-retrain" added in that series
>>>> *) Enabled the quirk for J721E
>>>> [1] -> http://lore.kernel.org/r/20201211144236.3825-1-nadeem@cadence.com
>>>>
>>>>  drivers/pci/controller/cadence/pci-j721e.c    |  3 +
>>>>  .../controller/cadence/pcie-cadence-host.c    | 67 ++++++++++++++-----
>>>>  drivers/pci/controller/cadence/pcie-cadence.h | 11 ++-
>>>>  3 files changed, 62 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
>>>> index dac1ac8a7615..baf729850cb1 100644
>>>> --- a/drivers/pci/controller/cadence/pci-j721e.c
>>>> +++ b/drivers/pci/controller/cadence/pci-j721e.c
>>>> @@ -64,6 +64,7 @@ enum j721e_pcie_mode {
>>>>
>>>>  struct j721e_pcie_data {
>>>>         enum j721e_pcie_mode    mode;
>>>> +       bool                    quirk_retrain_flag;
>>>>  };
>>>>
>>>>  static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
>>>> @@ -280,6 +281,7 @@ static struct pci_ops cdns_ti_pcie_host_ops = {
>>>>
>>>>  static const struct j721e_pcie_data j721e_pcie_rc_data = {
>>>>         .mode = PCI_MODE_RC,
>>>> +       .quirk_retrain_flag = true,
>>>>  };
>>>>
>>>>  static const struct j721e_pcie_data j721e_pcie_ep_data = {
>>>> @@ -388,6 +390,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>>>>
>>>>                 bridge->ops = &cdns_ti_pcie_host_ops;
>>>>                 rc = pci_host_bridge_priv(bridge);
>>>> +               rc->quirk_retrain_flag = data->quirk_retrain_flag;
>>>>
>>>>                 cdns_pcie = &rc->pcie;
>>>>                 cdns_pcie->dev = dev;
>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>> index 811c1cb2e8de..773c0d1137ed 100644
>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>> @@ -77,6 +77,50 @@ static struct pci_ops cdns_pcie_host_ops = {
>>>>         .write          = pci_generic_config_write,
>>>>  };
>>>>
>>>> +static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
>>>> +{
>>>> +       struct device *dev = pcie->dev;
>>>> +       int retries;
>>>> +
>>>> +       /* Check if the link is up or not */
>>>> +       for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>>>> +               if (cdns_pcie_link_up(pcie)) {
>>>> +                       dev_info(dev, "Link up\n");
>>>> +                       return 0;
>>>> +               }
>>>> +               usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>>>> +       }
>>>> +
>>>> +       return -ETIMEDOUT;
>>>> +}
>>>> +
>>>> +static void cdns_pcie_retrain(struct cdns_pcie *pcie)
>>>> +{
>>>> +       u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
>>>> +       u16 lnk_stat, lnk_ctl;
>>>> +
>>>> +       /*
>>>> +        * Set retrain bit if current speed is 2.5 GB/s,
>>>> +        * but the PCIe root port support is > 2.5 GB/s.
>>>
>>> If you don't have the retrain quirk, wouldn't this condition never
>>> happen and then the function is just a nop? So this could just be
>>> called unconditionally.
>>
>> Yeah, but only for the quirk we have to retrain to go to GEN2 speed
>> mode. Else the HW will automatically retrain and go to GEN2.
> 
> Again, so you don't need a flag for this. Comparing the speed is
> enough. IOW, all you need is:
> 
> if (current speed < advertised speed)
>   do retrain
> 
> The question is the condition ever true and you don't want to do a
> retrain? I could see higher speeds being unstable or something, but

For all GEN1 cards there will be re-train (since the Cadence IP RC is
GEN2 or more say). This is going to be true for older Cadence IPs and
newer Cadence IPs (where Cadence has enabled HW re-training).

The quirk will prevent SW re-training for newer Cadence IPs when a GEN1
card is connected.
> then 'advertised speed' would be lowered in that case (to prevent auto
> retraining, right?) and the condition would be false.

I don't think the value in PCI_EXP_LNKCAP will change for unstable
links. But yeah it'll fall back to GEN1 based on link training and if
the link is unstable it'll again fall back to GEN1 on link RE-training.

Thanks,
Kishon
