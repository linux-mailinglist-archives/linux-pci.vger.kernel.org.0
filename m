Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4AC4BB75A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 11:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbiBRK5V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Feb 2022 05:57:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiBRK5U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 05:57:20 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086FF19A;
        Fri, 18 Feb 2022 02:57:02 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21IAusmr055006;
        Fri, 18 Feb 2022 04:56:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645181814;
        bh=zaPPdrqTsTLO7qeSrqSREbUwWWYObPacSohErzPCChA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=N65AA5UGmrU6ZpgXYq6VIc9cFNcMo0mIFAA8bwe2G6w9EVOTCYX/RZ5rvL5uoZ4ey
         2bdQicUjdjPG8aw5byayQMHgtSBX9aa2G4AEIBdI4HZ9GTlQy1PudZ+H5zdps56HH6
         Q0ji5ClLtp/jF15Wo8YAzkhR0gM2CCT/MLtAg2C8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21IAusXL068968
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Feb 2022 04:56:54 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 18
 Feb 2022 04:56:52 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 18 Feb 2022 04:56:52 -0600
Received: from [10.250.235.228] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21IAumtH012763;
        Fri, 18 Feb 2022 04:56:49 -0600
Subject: Re: [PATCH] PCI: cadence: respond to received PTM Requests
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
References: <20220131220518.GA515079@bhelgaas>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <bac4cc7e-f81e-82e6-9b60-e5e3199637d7@ti.com>
Date:   Fri, 18 Feb 2022 16:26:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220131220518.GA515079@bhelgaas>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 01/02/22 3:35 am, Bjorn Helgaas wrote:
> Update subject line to match previous conventions ("git log --oneline
> drivers/pci/controller/cadence/pcie-cadence-host.c" to see).
> 
> On Mon, Jan 31, 2022 at 01:08:27PM +0100, Christian Gmeiner wrote:
>> This enables the Controller [RP] to automatically respond
>> with Response/ResponseD messages.
> 
> Update to imperative mood, e.g., "Enable Controller to ...":
> 
>   https://chris.beams.io/posts/git-commit/
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v5.16#n134
> 
>> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
>> ---
>>  drivers/pci/controller/cadence/pcie-cadence-host.c | 10 ++++++++++
>>  drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index fb96d37a135c..940c7dd701d6 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -123,6 +123,14 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
>>  	return ret;
>>  }
>>  
>> +static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
>> +{
>> +	u32 val;
>> +
>> +	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
>> +	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
> 
> I assume this is some device-specific enable bit that is effectively
> ANDed with PCI_PTM_CTRL_ENABLE in the Precision Time Measurement
> Capability?

That's correct. This bit enables Controller [RP] to respond to the received PTM
Requests.

Thanks,
Kishon
> 
>> +}
>> +
>>  static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
>>  {
>>  	struct cdns_pcie *pcie = &rc->pcie;
>> @@ -501,6 +509,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>  	if (rc->quirk_detect_quiet_flag)
>>  		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
>>  
>> +	cdns_pcie_host_enable_ptm_response(pcie);
>> +
>>  	ret = cdns_pcie_start_link(pcie);
>>  	if (ret) {
>>  		dev_err(dev, "Failed to start link\n");
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>> index c8a27b6290ce..9510ea513b8a 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -116,6 +116,10 @@
>>  #define LM_RC_BAR_CFG_APERTURE(bar, aperture)		\
>>  					(((aperture) - 2) << ((bar) * 8))
>>  
>> +/* PTM Control Register */
>> +#define CDNS_PCIE_LM_PTM_CTRL 	(CDNS_PCIE_LM_BASE + 0x0DA8)
>> +#define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN 	BIT(17)
>> +
>>  /*
>>   * Endpoint Function Registers (PCI configuration space for endpoint functions)
>>   */
>> -- 
>> 2.34.1
>>
