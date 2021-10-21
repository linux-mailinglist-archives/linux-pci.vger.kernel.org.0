Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB97F436B20
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 21:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhJUTQC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 15:16:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:51815 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhJUTQB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Oct 2021 15:16:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="292578191"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="292578191"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 12:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="495294715"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 21 Oct 2021 12:13:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 21 Oct 2021 12:13:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 21 Oct 2021 12:13:43 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 21 Oct 2021 12:13:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCfQ0EjjpDU8YrtoShvo28CvR/1Wx1p7cdudps6Q73BgQu8/fC56heZ3H3un20KKRfgpeqFKADy7yPxtqaJJoDmVeqLPU5puyn4JXw4l4HZSVwVc20/9wm5wlsHLRnAoPJ3fjfKAkw9OywmxTL3mRHF+njdLEC2iSs68DHBkgpWdj/dBmPO2vPmCSGCCYhRHn6b7p8TAyan8tguaW3idQOgKhsTmhACcdyowuujFaFeCaUGVzkYig3ICWK491fp12bjV66nvM43bFT7SP8QOwcSuBpvROtIUhcHnNs2NjEryq6wsPqi9WwgOeRmxl/p+LFlmumUAOVOyxoice3/5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILG18m15yJTjsxCiiKX/nP2cJhYFYZONSbsTD+RqzBU=;
 b=PtTbrMDvcdMvbIvrgDnxh/v0sUQtZ50wO0CteJcgnuqimeGLX34AhVf+4H/yR88/NuvNSE7fkQPqVJMqduKBHkCmyrEm5w7oxPQ0YRWeOTxneEVLdKXZXdDXCg1hcaPc5lfsp/b5CS98TCc62teaBEYEloSc4TEAGrFO0nST4UeeDpsTi3iymjJj70iH4E0Poo5qLqhnYO4ZgA/QbR0zIBCBN5MnYBI6+9f9byMpOA300zn6w8UtcuNy/uLSLXX2f+NCMc+OGqYw4o0DVmxjKmL3B1ZVyxBiyktOY2tnZP0w5xDwCYZ6DSAJqflPv+HF0bZbVkvModKjHQRwlUmY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILG18m15yJTjsxCiiKX/nP2cJhYFYZONSbsTD+RqzBU=;
 b=nHlYqx83I0/Z2AvgtThk2RtqBFG+3puPeQy5CBhzt5mWM/YZDZ1m5iJ1u0H6SXutO9uHruz2Eb4kpg9N2+m/y4z8Yz5ZVw3u1LhDnU2M1XNd2zy3VIMVXwXD/A6FtUegvmV80lmje90F0g5ZsYApaCM9WxHEW4rJNs0UADwZaBA=
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) by
 DM6PR11MB2972.namprd11.prod.outlook.com (2603:10b6:5:63::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Thu, 21 Oct 2021 19:13:36 +0000
Received: from DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da]) by DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da%9]) with mapi id 15.20.4608.019; Thu, 21 Oct 2021
 19:13:36 +0000
Message-ID: <6289c754-3580-4102-8ff2-666c3cad8da2@intel.com>
Date:   Thu, 21 Oct 2021 21:13:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.0
Subject: Re: [PATCH v2] PCI: Check PCIe upstream port for PME support
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Linux PM" <linux-pm@vger.kernel.org>
References: <20210812153944.813949-1-kai.heng.feng@canonical.com>
 <CAAd53p7sPoH-MD9VMh1u+mf_E7Mc2xVfkHbhN4PCdxQM+v274g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <CAAd53p7sPoH-MD9VMh1u+mf_E7Mc2xVfkHbhN4PCdxQM+v274g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0502CA0001.eurprd05.prod.outlook.com
 (2603:10a6:203:91::11) To DM4PR11MB5326.namprd11.prod.outlook.com
 (2603:10b6:5:391::8)
MIME-Version: 1.0
Received: from [192.168.100.217] (213.134.175.185) by AM5PR0502CA0001.eurprd05.prod.outlook.com (2603:10a6:203:91::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 19:13:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32cf69d2-0570-405f-921a-08d994c6e151
X-MS-TrafficTypeDiagnostic: DM6PR11MB2972:
X-Microsoft-Antispam-PRVS: <DM6PR11MB2972F33812AA6E47DD0CC06FCBBF9@DM6PR11MB2972.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FmVnxBFoivvCcXx6Wrx/NqB+Ka2ko7G8ulfjtHXXTlNypvYZrMcwbn43kbCpKVD80ZwWd+X9lcE2cHKlcaWkxqWTFgQ9pASzblAdooLvcW+3TB8jtn+KaznUYs3sC1CBosMWPZWAqKsic6JyC9Znm4Wu21+oCtxYSHuuBUFI6FQkmQ8mrc89OMXiadw77WIzkATCMUDHs1zLJibEijgecASxomQnyN0DuFzSZNs9kW2JTLGIJ9RIwimFTaLS3EMtHWH86Hb37gruxkxVYYY0cnersRXlREpBCIOyhHXxJlnUqSQ6DtVSdgIsGh/pimhQiZOKUmrLzly8K8pwgKosKlc3io9a/xlM2n1BVJakWlrgAlZyF36KV98YrmKGXlZqesntlxobaQ4YCnFusdTR5KlI4VldLnLZsDmW2cIu3tNezGNzgb53H8CbQKnOZzB3G9rcXZCAqpFbpfXiMAyYkhcn95iz4zLUFIkY+9Y9e7YxoXg2y/XIfSha8PpCSlsmdXr2FgW/O1qZPz/oWIMRWlRTMj04CXQ4lUI6OkSe6kZiQNn869I4zRvHPMEm9Zfq/IZXRZyRezaGsYCLoHZNYVDLvGT+8wI9shqA3kSQXAnDdEiVfT1/MDX54Fzyb1G76nX8B3JcRoinDk23s9AOTAmmzOOTtScRGAig2ciuqc/YoKPUnp73Sl8gbw/XhqXU1a4uaQhC3T3Fz19KOiW0qERhE63JczFFOxBYatEX+l57ICLETSXtHElSljzcYq55nWguKh2OaapYATU3VARQUEHxgSkzX2wqTYN3IQ2V8qDlvAJPtoBc6I4Hj8VgPk0J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5326.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(82960400001)(36756003)(53546011)(8676002)(66946007)(66556008)(2616005)(508600001)(8936002)(36916002)(966005)(31686004)(2906002)(83380400001)(16576012)(6666004)(4326008)(54906003)(110136005)(31696002)(6486002)(38100700002)(316002)(186003)(5660300002)(956004)(26005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uzk1Zm53OGs5Z2NJc3N1NTBmSkpJWU9kVXgvL0ZqYWtnUGkvVVBBVFlRcUJY?=
 =?utf-8?B?aW5PTmh5SXlNeTVmVnZxNFRNL1Q0eEFBaC80enJMb2xoRElBT29DVFY2bXNn?=
 =?utf-8?B?TFo0cWNmL1ZaRm9sWUxXakpCSjkxRFdKRFJlTnY1VzlDL1lqTVBWYW80d0pJ?=
 =?utf-8?B?dWpsZ1BIV1lkZk93U1ZudlJkY3NPa2ovNG56VHJ0R1g4VkhyejkzblNlc1Y5?=
 =?utf-8?B?VGl4SUQ3U1F3YmRnanF3dVZPalRkYUk1WFFURGlRL3BaMno0ekFpY0hQQTds?=
 =?utf-8?B?eEt0ZUtLdmlEbnl3SkxjMDRMNEpveHJIN2tSK0dGYVNrakZ1QXBXYnR1WHhV?=
 =?utf-8?B?cEhGaE9FeUVIY0RRV0sxb3BKblNwRE50b0tHdEZFbFJkMndMaXhRSW9wbGYz?=
 =?utf-8?B?K3VtQXgzZVF4ejE4YjAvdnUwSFE2VDRoY1BUVkMyN2dPQTJtblNvL2xwRVB5?=
 =?utf-8?B?QWRjYWw0OXNmeVFtcTNUbmhZTmpDRkc1ZlFQMTYwcUcwajQxVkE3aEJ3UFFE?=
 =?utf-8?B?ZE16NUVmTE1SN1pTdk44cXJublc0cnpyMWFMVjQ0WXk2dWVJaUhoeG5BWW9C?=
 =?utf-8?B?UnY4MXRqRVQ5ZGNvSHQ3V0ZSRUxVTW1Qd0VVblFsVUtUNUNNYUVIeERNcE80?=
 =?utf-8?B?TThJelhMNnllL1Z4VWRWc0hEMnBuNnp6RGtVOHlmRGpaWDVuRG9udjQ1VHUz?=
 =?utf-8?B?R2FoRlhWamgyMTByTGpmZ1Q1a29od1lSSUZmaG9Vb011U01tKzdBRDhPeFM2?=
 =?utf-8?B?Y04vMmo3M1ZJL3AzTURobnk4SUkrYkNzdzk0TzRXblM5ZzQwS0xxL0VCclRt?=
 =?utf-8?B?T2Evc0dyWFgvN2EzMnNjcnVxRURsTUdNeDNwQTUxc1N6dXBJSTVGYk9LRW9r?=
 =?utf-8?B?R3BVR0dzTG9rZ3A4SnZhdk1DUDJVZXRrbFRZMElWV1hMWmlvSFd2QjlVZjA0?=
 =?utf-8?B?VlpDQTJieU9xUXZJdGRyaFBEekpzNEZQWGwwZjdMWlJiRC9GN21FQmtDZGo3?=
 =?utf-8?B?UzhLZ2VZdTBoZkF6NFJDcW9vNUltRXlhMlorTDh6YXNDQzU4Zi9QNzJoVlJE?=
 =?utf-8?B?RjVBZmtIWFNNdDdYcCtkTTZKd1ViOEo5SGZET1Y5N2FuNnFibTdQQ1dMQzRC?=
 =?utf-8?B?UGhlNVlETG5BTWRmNW9VNUdzZHhPU0Z5RWVTQnVLWmF3bU9MK0JqZnJBRW9t?=
 =?utf-8?B?dFdtQ0o4YVhJYlBsZWVseTBvSG5xRFlsTWxJeXZZRTh3T3NOaFNrbENORnFr?=
 =?utf-8?B?NUczeGo1cm83VFdhVVlFMzlrYjh3UGRjWXo1TjlMSTJHUTlub1RlNmY5RmlK?=
 =?utf-8?B?NUZEVmhUMVcwbjJqZnM5SmVmdmt3cTBhQkFCQ3R2d0RJQm9yNHVZMGtGZjl5?=
 =?utf-8?B?S2xvRjV2Nm0zUkRqa0luTXZIajNkc1gxa0FJVHVmZVlweVU0L0hrMGQ4Uk04?=
 =?utf-8?B?UlpEYzgrczIvSVNvWDJRSlVSblhpMUhibnI3UmpYU0xEeXVjUFl6azgvRE04?=
 =?utf-8?B?b2ZKdjFBQTNMMnBldWRvczM1NjNoZjF5T0ZqVVBMNFJrMXlVM3poanlQdTUz?=
 =?utf-8?B?d2ZlaTllQWZvTGJqRTQ4MmVRMEdMSVZ3TG1xZ2RhbTY2bEdxalJtcmI5T29i?=
 =?utf-8?B?RFRsUzcvSDkxZG8wajlsWXpFbVBVeGlNblp5ZFZHTUE2VlluV0c4N0FUcnBU?=
 =?utf-8?B?NnB1bjYrYTBobEdmYUcrMlZJS3Q1ZlpJOS9UWTcya0JmVEtqeXh5SVAzdmtL?=
 =?utf-8?Q?+TUeLwmqd6jRMH+ui+oVFrlbqcZ8OAxIHSZDh58?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cf69d2-0570-405f-921a-08d994c6e151
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5326.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 19:13:35.7277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rafael.j.wysocki@intel.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2972
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/21/2021 8:56 AM, Kai-Heng Feng wrote:
> On Thu, Aug 12, 2021 at 11:39 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> Some platforms cannot detect ethernet hotplug once its upstream port is
>> runtime suspended because PME isn't granted by BIOS _OSC. The issue can
>> be workarounded by "pcie_ports=native".
>>
>> The vendor confirmed that the PME in _OSC is disabled intentionally for
>> system stability issues on the other OS, so we should also honor the PME
>> setting here.
>>
>> So before marking PME support status for the device, check
>> PCI_EXP_RTCTL_PMEIE bit to ensure PME interrupt is either enabled by
>> firmware or OS.
>>
>> Cc: Lukas Wunner <lukas@wunner.de>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213873
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> A gentle ping...

Any chance to CC this to linux-pm too?

So you basically want to check whether or not the PME interrupts are 
configured on the port?


>> ---
>> v2:
>>   - Instead of prevent root port from runtime suspending, skip
>>     initializing PME status for the downstream device.
>>
>>   drivers/pci/pci.c | 28 +++++++++++++++++++++++++++-
>>   1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index aacf575c15cf..4344dc302edd 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2294,6 +2294,32 @@ void pci_pme_wakeup_bus(struct pci_bus *bus)
>>                  pci_walk_bus(bus, pci_pme_wakeup, (void *)true);
>>   }
>>
>> +#ifdef CONFIG_PCIE_PME
>> +static bool pci_pcie_port_pme_enabled(struct pci_dev *dev)
>> +{
>> +       struct pci_dev *bridge = pci_upstream_bridge(dev);
>> +       u16 val;
>> +       int ret;
>> +
>> +       if (!bridge)
>> +               return true;
>> +
>> +       if (pci_pcie_type(bridge) != PCI_EXP_TYPE_ROOT_PORT &&
>> +           pci_pcie_type(bridge) != PCI_EXP_TYPE_RC_EC)
>> +               return true;
>> +
>> +       ret = pcie_capability_read_word(bridge, PCI_EXP_RTCTL, &val);
>> +       if (ret)
>> +               return false;
>> +
>> +       return val & PCI_EXP_RTCTL_PMEIE;
>> +}
>> +#else
>> +static bool pci_pcie_port_pme_enabled(struct pci_dev *dev)
>> +{
>> +       return true;
>> +}
>> +#endif
>>
>>   /**
>>    * pci_pme_capable - check the capability of PCI device to generate PME#
>> @@ -3095,7 +3121,7 @@ void pci_pm_init(struct pci_dev *dev)
>>          }
>>
>>          pmc &= PCI_PM_CAP_PME_MASK;
>> -       if (pmc) {
>> +       if (pmc && pci_pcie_port_pme_enabled(dev)) {
>>                  pci_info(dev, "PME# supported from%s%s%s%s%s\n",
>>                           (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
>>                           (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
>> --
>> 2.32.0
>>

