Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4B156A821
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 18:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbiGGQbr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 12:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiGGQbq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 12:31:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D4E2E9FC;
        Thu,  7 Jul 2022 09:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS6hfCSYsiVdZdvvAmyuiwnhE6A7XGeO+z6SjM7428RJ7RWt9qRaOQhFARhkROybfe+UY7iCvviYe2pYeBPPU74RqkCmU40jacBcNgDbgRkxqo1tJIibih6EEDJiRK8He6aQHCZofkB06+s9XMeBIG9GX5Bk7j/sypNUZTuIzzrKFVymOfatm0gq2H+vAP3/vBL9L8VLc+fb2nCo6lr4+BvOntJGsZ2zZ1Zhx77UdrbNQ1dvpuaDNRI6YCrSUUJDAuEwIC9tMUpHNuxJf5q95iExu4W3Mtxc2F44EMXigkepbG19DgSFpILh38hPSQZMDPoAPVXWcyz4H6Rhs/wmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVMGcDv4TMN48Rtfk3HDyvW8NOmKX+jMZCQx5UQk3hw=;
 b=WM2XFq4tZBzWvksi+7148zBU6c3ctm2Rz+aMH1SENZ1P57b83Gt1QDF+CM//OKCIK9gOV/qh65ENfAJQmmB/pBJBuCAfE3oNnhA46EbENAuT74mhRqb9iVkBWdPWOT5n5ZecPj11VTIyUALDMNkJd/0Nu4eCJMVGjVeu0m6EcD9CkDXwzVNSNSt6/+0zhoA/xZLBjEvMa2c3jTWI+DDB5/mh6tATGJr1IA67c4CcRSwzwcu6cKDmtnHTNQZ/WmoIK8ckJN8PC6QgndtLz5Rm2L9Oy32/5Y0QiYN/3ovNdRxxTu5FEcQOAap/v8ZWYg0Nn0myAWPSomFOQr8ing+7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVMGcDv4TMN48Rtfk3HDyvW8NOmKX+jMZCQx5UQk3hw=;
 b=jQL2NV7sjUxAx9HctYu/bRA1ZcxvB0JwDLiMYKpsS/qGO6E55aKm48rav93DxTmwehiaZkQaFu9cetqgD4vIBNMySOmtRD5y3UhUbbuAx9KFlkOMZOprc1tiUzz5/X5eMgnck6RIf+j9DpAVZejtQGNRL666P8Dtf2YC/QpXdZKd4EAyRcmnc58Xikwr5O8WkpbcfNbgVhtTXE6YHfJb1wHrrZLEbLaJStmWL2Kf7BtgEZOhNbqy6rP83JWH6rgG6mP1Mw5VJc0yvQTodqdXdIzbbg6X7himzXptGqm6ohCy0P7H3AEOGhoG3jN06UZNYwTtL9RH93G+ZuOOKtpxYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by DM6PR12MB3066.namprd12.prod.outlook.com (2603:10b6:5:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 16:31:42 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3%5]) with mapi id 15.20.5395.022; Thu, 7 Jul 2022
 16:31:42 +0000
Message-ID: <d38bc5f1-8c92-db32-5821-c775181ad4f6@nvidia.com>
Date:   Thu, 7 Jul 2022 22:01:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20220707160031.GA306375@bhelgaas>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220707160031.GA306375@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::33) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aa36b0d-24e3-4a94-ed80-08da60362cd5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3066:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5f+8RBZ7mYqC3iyRy2xmJ5FMKPb0cC1YuapNr88Sni0OC4BV1N3zC/6O8nvfPx7yMfoVhL7U5d2p5URX7rYtOJxPYbNR6T+tR1NptMS5B+YCPrRNuPoP63nn4ULdRF0pZ19tMCuCKLBCnd/nvYMVf33MqE0NvxZ4W21dnODgsip9ZYV2usMbM+0fJZT2h3O6rwmx9OU1Ho5UhaFSX0x3VvgAI9cCm9LU1/H7O4Xcn8UF5qS0iw9gYQecOfJ6CHn0dDMfHGDhL8o6TsHhJv7y/MWoUbBtnsfB3eo8wfTYo1N5hF2ZnY2tJ7xlcDymifIcjX67jYJiwOTN11tfM/tpqRNmveB3X7yrdI8BkslbLAmYByib3kyXiHcvKc0zec0HORFex47Z4gHjIeD3JLZET/mZZVz+HK1ChmT4CaPZnHQroqOfJz4KaGF82A8Ia9sv4OtQKIFC6n3KEHasClN0xEokBcGaCsr7yNC87SQ0cBGU3eA0MXHt0hzNs3eWlPtRPuyd42bwvHxDOc8ONMjMtEZ6bGgmnz7NDZC42IaSJDX9h/12uwd0IcIetRRDFIGzHhNt4gY0RjmPIm/xJOeNY3/Ex416rgDqHyd0RmZ7GOQkTftZCW340NkbzcTRbl4clNQO0ImGhnVQL+U0hjCogzZ7MVn/fUnlkvksB9o3MENfN5OvuGrrXXxBT+HbXX1xPqpBWpaoMFQ4Kxh0R/CNJyvOlLC7Ebg0njRL8YjSh6Sz5/35fB5N3TWiT7t0W3zE+3iZo5A5BHLU0k76C/qRqBPG9i1n2lh+VIXgnhinHp8L0hRQzPNmjQmXKAN9/6o44tuubKSVnXE45RbbmYWtX96ua1RyzVxXrlNGZvqqRV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(6486002)(66946007)(4326008)(36756003)(26005)(6916009)(86362001)(31696002)(478600001)(6512007)(6506007)(31686004)(41300700001)(6666004)(8676002)(316002)(66476007)(66556008)(53546011)(38100700002)(186003)(2616005)(5660300002)(8936002)(7416002)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUYxWHNNTUpzQWwvYWxZZ2dZYUhHUVp4TEdnbS9SK2NlUmF1NklaV0dMdWNa?=
 =?utf-8?B?UU0zSk9XUGRDWlVuMUV1RFd4MCtvUmpZQUtCMFJFTCtvMnF5S3hqdDNJTWNh?=
 =?utf-8?B?a3NBMmR3RldlMFNMT3Zvc0ZrNjRmVy8vNmFBV1JXTXBFSTQwV1F5d25Oc2lt?=
 =?utf-8?B?U3p1VXdYdmo2ajNjTlhuaCtTM3hsV090cU1PR3gxb1I2a1dpWmhQSWh2WFA4?=
 =?utf-8?B?RWdUYk10RTZ5VlJCRmw2TEpxekY2bi9CVVJGT0VFVmgzNEFYbkJPd1JrZE51?=
 =?utf-8?B?SUtaSG9GV2hsWUkvZG9EaHNMTjErTDdyQTJ6NXl6SnJSWUtadEo0RVdlOW1p?=
 =?utf-8?B?aFphQUFZM3RwMnRXZmk3L1o4bSswUHZjN09SNUZOcWZwa2NLalVZL3h2L3M1?=
 =?utf-8?B?ZStIL1J5cmFwT3Z3RFVic2IwTTF0ZkN6aCtTR3E2U29ad2dtWVFWcWdzYk5X?=
 =?utf-8?B?Q3BIUVVEWVJtL1NWT3Z2ZlI4UTQ2QUEwSERRTlFTbVRseURaY1JoTTlHYmdu?=
 =?utf-8?B?WEdpZ2JZMHJqYjZJWFhzN0VPSkJ2TzVBQUxZMUpoTWpQV0owNlMxaWhoYTF4?=
 =?utf-8?B?dENMbk9GbE02VlNDYWROdlY5Nlh1Q0owUXdaZk5PN1RQS1c3SE1kZ1JYNjdj?=
 =?utf-8?B?QUUxVVdNY0NzYjJNOWNqVktVZFdHRWh2T3RFMDFSV0VMWURSNEtIY0VYd0s0?=
 =?utf-8?B?bGpnM2x6V2dQSFMyNk1uODBwbGRTeHlxTWc5L1IvVDBrc3hZWDM5RlJNT3lF?=
 =?utf-8?B?dXA2dHN3Umh5UmJjaEVmNy8rQ1VnZ3QwWVNEVDJWR2JyU05xd3kwek1zVzY2?=
 =?utf-8?B?bE1JU2lXNEsySHAyOU5MRUNSc1NkeVhRSVBHaHdYVVdQR2xxbk9vWDk3bG5M?=
 =?utf-8?B?b1AwY3FWUGNybDZNWDU4aVY2L2NPSzNSMXUzTDhjTEd4TlBFWnErZnhtODIx?=
 =?utf-8?B?UG1JQVJycTJWZlRsRnVlRVZhbXB1V2V3VzYrN0NKdXpUS3ZmUk9uamh1Z2lU?=
 =?utf-8?B?dWRna3lFa2p5ZFlDR0JuN2FHOHRmUkxObHVUZi92QW5ZaTdVVFlWVFc0d253?=
 =?utf-8?B?azNKNWlQekxiOUZLVG1qSll6Y2NXZzhqRWpHd2E2REJuSHhxMURtUHEwKy9D?=
 =?utf-8?B?aWxyZFhvSk1ST3BES2orS2hTemRsYnBVY2lmS3NFb2ZCMFlvdzI2ZStDN3Rh?=
 =?utf-8?B?aUF5SERCV0V4bUcrRHVGWUpXbjF4Z1pOUDNDZVMrTUVHNm1YYmk2a2tEYk4r?=
 =?utf-8?B?Z2poUTVwZHJxdVQyMEZMT3QxSC9sK2swc3E5L1hiMGZhM0dINERZOGFIc2k5?=
 =?utf-8?B?dk54cjZuTG9uYTArVEI0MFRZak1hOWN1UXAvanBkeDVPVnJ5R1JqQkJWbUcz?=
 =?utf-8?B?b3U2SVBDem5yRC9iUzREWmNxVGViYmNsUTQwMW9zdXp4QkIyRkhJNkFrNjhn?=
 =?utf-8?B?TFVZU05pbGI0SjhLbEY4UWtuTnoyeUhmZXgyRVYrdGM5VksyVXpFRzQwTkZK?=
 =?utf-8?B?ckJpYjlKS2Z5Wm9FZEtPNUJXa3A2NXlBWkZPVThCMDB6RHNlaEswbElHbWJ0?=
 =?utf-8?B?bTMvMWpzdm5TSitpMW5TN3pzUXBGOHcxL3FhSDhoYzh4aGhmR2JGcE1XdXBC?=
 =?utf-8?B?UmV0YlB0aTZrT3lkUWx3UXNhYWNMaEh2U1cvWkwwcFhPS294RmltTnh6Z3Nh?=
 =?utf-8?B?WjdyTXhndFEwbHk0b2RNS205L2FOS3RZTTgveXR6YkxNNFFtam9IbGxEYzJO?=
 =?utf-8?B?Y3FlbzFXWFBMSEZuT3FzVmZ4Q2xBbGFDVXhXbnJDRnY4YU9FSUo5dzkwa2tF?=
 =?utf-8?B?Zk96RHZjdG9MM2pmNEFFUE9wWnZPc3NrT0lRQmZnRy9KMGRaNlpoeVJRZVlD?=
 =?utf-8?B?dXFaV2tsbnEvTWxWVVBxeEFHNWFGUUNxQzY5dENkWHM4a1c1d1JPY2V3REEw?=
 =?utf-8?B?K0dDRlhhc3pHTGtIckQ5WVZtVW9XSE5rc2I4elg2YXJBS2EyK3RBVFRJak9T?=
 =?utf-8?B?R01NK0gyY2k1OTNPWGlhN0xqN3NVYW1vQWgwNEMweWZVR3dBTDZxYWk0Wmw1?=
 =?utf-8?B?RktldzVaR1NCQlN2YlEzaWIxdU9qTFcyYTVWTHVwZ3B1Nm5RTzA1WHpBWFZX?=
 =?utf-8?Q?DW4sZkesxVv4CoTIex695weaW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa36b0d-24e3-4a94-ed80-08da60362cd5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 16:31:42.6657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N32HavkM91eGUjVwloTilcr5naglw9vTPY14BYAwg1tnSr/nTvrtZsl4ZN4p4e/Xi1j1rlis3jwnf6OQNjabmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3066
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/7/2022 9:30 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> [+cc Serge]
> 
> On Thu, Jul 07, 2022 at 02:39:08PM +0530, Vidya Sagar wrote:
>> Hi,
>> Anyone has review comments for this change?
>> Without this change, Tegra194's endpoint mode is effectively broken.
> 
> Did Tegra194 endpoint mode ever work, or has this always been broken.
> Wondering if there's a Fixes: or stable tag we should add.  Also cc'd
> Serge since he's been doing similar work on dwc.

Yes. The endpoint mode of Tegra194 did work particularly after the 
commit ac37dde72177 ("PCI: dwc: Add API to notify core initialization 
completion")
There are many changes that got merged after this and hence couldn't 
really point to one change to quote in Fixes: tag.

Thanks & Regards,
Vidya Sagar

> 
>> On 6/22/2022 9:31 AM, Vidya Sagar wrote:
>>> Platforms that cannot support their core initialization without the
>>> reference clock from the host, implement the feature 'core_init_notifier'
>>> to indicate the DesignWare sub-system about when their core is getting
>>> initialized. Any accesses to the core (Ex:- DBI) would result in system
>>> hang in such systems (Ex:- tegra194). This patch moves any access to the
>>> core to dw_pcie_ep_init_complete() API which is effectively called only
>>> after the core initialization.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>>    .../pci/controller/dwc/pcie-designware-ep.c   | 88 +++++++++++--------
>>>    1 file changed, 49 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> index 0eda8236c125..9feec720175f 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>> @@ -639,9 +639,14 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
>>>    int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>>>    {
>>>      struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>> +   struct dw_pcie_ep_func *ep_func;
>>> +   struct device *dev = pci->dev;
>>> +   struct pci_epc *epc = ep->epc;
>>>      unsigned int offset;
>>>      unsigned int nbars;
>>>      u8 hdr_type;
>>> +   u8 func_no;
>>> +   void *addr;
>>>      u32 reg;
>>>      int i;
>>> @@ -654,6 +659,42 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>>>              return -EIO;
>>>      }
>>> +   dw_pcie_iatu_detect(pci);
>>> +
>>> +   ep->ib_window_map = devm_kcalloc(dev,
>>> +                                    BITS_TO_LONGS(pci->num_ib_windows),
>>> +                                    sizeof(long),
>>> +                                    GFP_KERNEL);
>>> +   if (!ep->ib_window_map)
>>> +           return -ENOMEM;
>>> +
>>> +   ep->ob_window_map = devm_kcalloc(dev,
>>> +                                    BITS_TO_LONGS(pci->num_ob_windows),
>>> +                                    sizeof(long),
>>> +                                    GFP_KERNEL);
>>> +   if (!ep->ob_window_map)
>>> +           return -ENOMEM;
>>> +
>>> +   addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
>>> +                       GFP_KERNEL);
>>> +   if (!addr)
>>> +           return -ENOMEM;
>>> +   ep->outbound_addr = addr;
>>> +
>>> +   for (func_no = 0; func_no < epc->max_functions; func_no++) {
>>> +           ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
>>> +           if (!ep_func)
>>> +                   return -ENOMEM;
>>> +
>>> +           ep_func->func_no = func_no;
>>> +           ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
>>> +                                                         PCI_CAP_ID_MSI);
>>> +           ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
>>> +                                                          PCI_CAP_ID_MSIX);
>>> +
>>> +           list_add_tail(&ep_func->list, &ep->func_list);
>>> +   }
>>> +
>>>      offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
>>>      dw_pcie_dbi_ro_wr_en(pci);
>>> @@ -677,8 +718,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
>>>    int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>    {
>>>      int ret;
>>> -   void *addr;
>>> -   u8 func_no;
>>>      struct resource *res;
>>>      struct pci_epc *epc;
>>>      struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>> @@ -686,7 +725,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>      struct platform_device *pdev = to_platform_device(dev);
>>>      struct device_node *np = dev->of_node;
>>>      const struct pci_epc_features *epc_features;
>>> -   struct dw_pcie_ep_func *ep_func;
>>>      INIT_LIST_HEAD(&ep->func_list);
>>> @@ -708,8 +746,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>              }
>>>      }
>>> -   dw_pcie_iatu_detect(pci);
>>> -
>>>      res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>>>      if (!res)
>>>              return -EINVAL;
>>> @@ -717,26 +753,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>      ep->phys_base = res->start;
>>>      ep->addr_size = resource_size(res);
>>> -   ep->ib_window_map = devm_kcalloc(dev,
>>> -                                    BITS_TO_LONGS(pci->num_ib_windows),
>>> -                                    sizeof(long),
>>> -                                    GFP_KERNEL);
>>> -   if (!ep->ib_window_map)
>>> -           return -ENOMEM;
>>> -
>>> -   ep->ob_window_map = devm_kcalloc(dev,
>>> -                                    BITS_TO_LONGS(pci->num_ob_windows),
>>> -                                    sizeof(long),
>>> -                                    GFP_KERNEL);
>>> -   if (!ep->ob_window_map)
>>> -           return -ENOMEM;
>>> -
>>> -   addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
>>> -                       GFP_KERNEL);
>>> -   if (!addr)
>>> -           return -ENOMEM;
>>> -   ep->outbound_addr = addr;
>>> -
>>>      if (pci->link_gen < 1)
>>>              pci->link_gen = of_pci_get_max_link_speed(np);
>>> @@ -753,20 +769,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>      if (ret < 0)
>>>              epc->max_functions = 1;
>>> -   for (func_no = 0; func_no < epc->max_functions; func_no++) {
>>> -           ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
>>> -           if (!ep_func)
>>> -                   return -ENOMEM;
>>> -
>>> -           ep_func->func_no = func_no;
>>> -           ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
>>> -                                                         PCI_CAP_ID_MSI);
>>> -           ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
>>> -                                                          PCI_CAP_ID_MSIX);
>>> -
>>> -           list_add_tail(&ep_func->list, &ep->func_list);
>>> -   }
>>> -
>>>      if (ep->ops->ep_init)
>>>              ep->ops->ep_init(ep);
>>> @@ -790,6 +792,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>>                      return 0;
>>>      }
>>> +   /*
>>> +    * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
>>> +    * step as platforms that implement 'core_init_notifier' feature may
>>> +    * not have the hardware ready (i.e. core initialized) for access
>>> +    * (Ex: tegra194). Any hardware access on such platforms result
>>> +    * in system hard hang.
>>> +    */
>>> +
>>>      return dw_pcie_ep_init_complete(ep);
>>>    }
>>>    EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
>>>
