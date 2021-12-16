Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36076476B35
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 08:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhLPHus (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 02:50:48 -0500
Received: from mail-co1nam11on2053.outbound.protection.outlook.com ([40.107.220.53]:8544
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232125AbhLPHuq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Dec 2021 02:50:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gy4qHCv2Ta2SsRy7H3LB7uLRLEtIX2oj/peKwB5tg8a6UueEAFsxGEFR402g3OsH+sHpHTv1ZKXHCbhE3wmVw43jT1McvNYtLY57Xm8Huc/YZVQRauuiN9yf4Wkcf440A1/RY5zXTsg0wnkfAZBItG3Q+vKbWdb/9LpmODBW2jxwpnvJcuUEbvtimUnjyvL0JK/MApb3YjwWxjcj90f/89+Ffc/IQCI8xJVdGD8IIlOkWl3AayD6Jzffcli79BaGxJ0Y99Hh8SiXJz5NpSC2xGRM8AT66q+j5Tg/BkBPhNSRid+bYdnsOtHF7N341N9rB0GBJE79nuSvBsm5CYThrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8083ywSwroeEfTarq5+aPL0952zwW4w0QIxV22x9R0=;
 b=KDpR+IuOCBHId2t6+983TtW6feaj9ycM4YQcUEogNWPP7lwIZ7K4KKqYp36kPuGSdROJ2e/7P3kizEQILj9JJ6EscjnIsnX1ytPLaJkr3RLCyIu+F8h9GWwlqhNTO2YEAY+FmPmN8ZKGX+WJInUzASY9lPQrOj3nUHGZWTBUF9BrSC398yKQFIoxlwg8F+OAsJ/W4PCqATUGE/SYS0z9jaFm8p17j5gK5FA9aN6SMw4dg1Zuns3c3upiJJZ/cjTj2h3pXb5aofUhhSOS2t7L3Rsay+ICW6WUw6mcgUVH7xWcBAt1ElOlOyoZ1JMUKWmgVc6AJvNLz9ewGfgcEicd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8083ywSwroeEfTarq5+aPL0952zwW4w0QIxV22x9R0=;
 b=UxC+l6qmEzUDTjbDu9nMXfAaAy2ZYTh6m7WRRpd8k1J3vsTZ/CUqnjehB4Gs6mGLMkEJ32Cp+xOR/g6oHfe2O1YPnC6oNtWSwzMxZb8NTE3Si3k8umdVFEUoKS9ge9NTAQnEiI5wm39IPBBo2IdUychhSBokyQGIyKrDKCx0Bfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com (10.174.101.14) by
 MWHPR12MB1487.namprd12.prod.outlook.com (10.172.49.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Thu, 16 Dec 2021 07:50:44 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4%12]) with mapi id 15.20.4778.018; Thu, 16 Dec
 2021 07:50:44 +0000
Subject: Re: [PATCH 1/2] PCI: Add support for VF Resizable Bar extended cap
To:     =?UTF-8?Q?Micha=c5=82_Winiarski?= <michal.winiarski@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20211215141626.3090807-1-michal.winiarski@intel.com>
 <20211215141626.3090807-2-michal.winiarski@intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7a09b5c5-9c7c-106a-65c6-8c25c4918960@amd.com>
Date:   Thu, 16 Dec 2021 08:50:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211215141626.3090807-2-michal.winiarski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0129.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::7) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f8357d0-8b4c-45bb-37b7-08d9c068c386
X-MS-TrafficTypeDiagnostic: MWHPR12MB1487:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1487718A433445AADB06D5EA83779@MWHPR12MB1487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrQ/jtGDkrek0yiNf9KvjUVwH7Wg/3AgREenBNO8mpdba76FzFf7tutsuGFnUnThPAykMj5i454vYbtklkezIiYroAIMl9TjNjdM5UnQB+cZGgdmq+tRq4lJyLCoJwDsyGNmk0SqpTwNYbaoA5/pYFSU665cKcynNxKnTNQP6z0ioqNmTLxyrL7tvWKblWU4o3MGZ96xyNwpdzYELf+GJDxFnwLWm/nybdXxcO4HgMr096sLlgfCuoOrAv6FoBO16TZRGqxOMeDnhpWHps1s0B5WZG7Ci3ftAzOQpT7h8o5oc1NqbodTkCtDFvv3GpvgelHTxhBSQBSBIqYwqfU2Ipxb3ri/Q5Et/80OS56sH++ZrA/a/A8C8MNfme0yQy4fZUHxSbUkDD0Gh/HfBBjRMw6EgERe1zHmk0LWh8X5SEC/IjuJqjbcuefh6IyVZtaXmfBg0E9fOwB0DRI2zQgfgjBL3agHPrngtbmuHZPB6007pe8mZhzIWdz0hBmkBHnkh7cCqL1HBQU5cFldC/VeI+msm9Xr825IzV333UGS+njVRe7X1oZoSUfsRWeL4vURbGCj4t6O+/nTkc2RSTB20jSvLh42hXu7xrbG/fLmPTA3iUKMtUnwthO68GBMsqIWmVYKgMVAkcjsDgFSCnnREw1Eq10I7pUuJ/QqAK2wG1Tm6ynUW7pXCRYadxdasQlPSUSvHgyEhYjFOYimq4vy2LM6dQiGM1iFVUoIiDUPmYT0ijQy89p06w4782GWlfeX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(31696002)(66946007)(54906003)(83380400001)(86362001)(38100700002)(36756003)(2906002)(6666004)(186003)(5660300002)(6486002)(6512007)(110136005)(316002)(8936002)(2616005)(26005)(31686004)(8676002)(66556008)(66476007)(6506007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU1GckhjTnJRbGxseGo0VXdNc2ZIc2Q5RldMVS9KRjBxMnJuUWl5cENnQ2tn?=
 =?utf-8?B?b203VW1nTzN5S1Zsa2Q5eG0rTUxSc21jSXU0UTY0Uzc2WUFBWExiNzRrQ1By?=
 =?utf-8?B?NkNwYVQ1NzFNUk1LMXFlV3VFQ2Zldm04OEE1c1dQTFk1VjI3T1JGTGlYYjU0?=
 =?utf-8?B?WDB0UHhrQTRkT2FtQ09yNXpUdVpqOXp2SmkrMkRnd0VwNnIyRy9yS3FLaEsx?=
 =?utf-8?B?MjFoc0xKSjFrZGd2Ukl1b3lMQ3dtRlp6WmNFeXVOSU5nWDNiZjgzNllLaWpX?=
 =?utf-8?B?QlZMSjlRQVJqNXF3ZlNSKzc5VU9JcHZ6RDNTWlFWV3FnYVlzZmo3YUxMQnlC?=
 =?utf-8?B?emt4azVwZVBZd2hnZWt6VzErZk90d0lNRjhpaGtRczJqcE9TOEF5SHQ4cUZS?=
 =?utf-8?B?eU9QbkFmSjdEQkJydmJJUXpmcEFXbGNUc2VFTkt2alM2dEw3YjJyVllmUGdy?=
 =?utf-8?B?Y1k5WTVWMzh3US9HaWN5YWdnNjZvY0xaaVNkMnAycUpESk9TVFpWckZtOWxF?=
 =?utf-8?B?TFEvemlpRjYxUWFxQ2oxVzE5M2diWTdvZ3psSHNnempiOUpFMy8vUjU5TWU4?=
 =?utf-8?B?ZnlVUmd2Q3B4d29LRUk1VkVveTVRbVpMVG03YmR1YUkwaUc0clZIclJXY1Z3?=
 =?utf-8?B?dnNxd3ZEN2IvdHY4UWJoeVVEV0ZyRG1UOGNqNTdWRkdqRXAwTjdrK3ptcjFk?=
 =?utf-8?B?THRmNk1JS0ZMZjZ1cTc3MWFSOXlYZ1c5cklTUi92ME5uZFk0YlVRRVE2TXps?=
 =?utf-8?B?cnVOSTJwTmZpZ3dYaGtGVFB6SGw1a080NnJKclUySmdSYlFhMUF1a01JUEwv?=
 =?utf-8?B?MkMzbGtZYnVCK0VMUkJEWDBqc3pzTFpvNDBKV3Jxc2JtKys3MUJZWHl4aWFk?=
 =?utf-8?B?MGIwRGpRdkRqM2U1NlJOa0RENDBFVEtQR0ZiK1NGcUU5TkpaUWF4Unh3bzI0?=
 =?utf-8?B?YlB4RnQ2a2tKdTQ2eVRVV2VRaVdST3dXM3hMeEc3UGNtNXlSMkVIZ1NlWmgy?=
 =?utf-8?B?KzFyeU0wQWwyblB4U1Z5QVdxMFdqYnBydEo2Tk9MK2Y5aFoycjQ2UGorWDBy?=
 =?utf-8?B?QlY4R3I5OUNCcUc0eU9wWXRueFVJRkx6ZlNlR2thN2VidVkzdmVtV2dhOHdH?=
 =?utf-8?B?RExyMkVzeFhJdHhXYjJmbG9uQ0ErTmJ1RzhucThCUmVZQjhqT2RKaHMybVRt?=
 =?utf-8?B?UDg2KzZrMHlSNVZTY0hEVEllK1N6dnR0UE5aaklTUUZUdTVsTlA5dldFaU5F?=
 =?utf-8?B?cEs5aHAzTVpMVXVjTTFsTGhLbk9XRTVob09sMUNGR3ZkcUU1OUtUWXlKRHJl?=
 =?utf-8?B?TFNnN2pFSkRvMlZOVGVTbEZ1dThNckQ1NEFTYU1WT0p1b245Nmd2ditCRG9J?=
 =?utf-8?B?Y1BOb1BBMkRCOStiaE9iU3d3N0lJR0dRWUQ1MmJZNTQ1ODg0R29udVNEZHFw?=
 =?utf-8?B?aHFvYyszbUlkd3l1N1lLOWY1ckI0UmF0V3Y3b1VxV09NaDZqYWRiMVpqeVJx?=
 =?utf-8?B?ajFObDRWU1NtSExuYlhIdnk5WFZPNCtUNkZUbXhFU3B3amQ5cmFNOVFsVGxD?=
 =?utf-8?B?TVNCZllrc1IxMElQelJrbG95MHo0MHpTZVpCYjVmL3hoNGNTL0FlZGllengx?=
 =?utf-8?B?MFdrd3ZEY3k3N3dwQVBEZytTM21CQjBsME04QXZ4YURVeEJ4K2p0aWJLQitz?=
 =?utf-8?B?RGl1QStzMFZybW5nRUN5T0wwTUpWZWFJSG13b01NQnpkOGd1WUdxZSt1SEVU?=
 =?utf-8?B?Z3oxUHR3WXRTMEhhUkhvbnBWaFAvSnNxalZ2WXk2UWlIMDIzRDZYa0plKzll?=
 =?utf-8?B?ZUZvMjkzU1BqaW9oZlRNZVJIK3pNN3BxRDVHQUNKdjh4cnJqbFNKalVDd0VQ?=
 =?utf-8?B?ZVpHMFE2K3pJeW5Pd2o4UVhreGV6bldyNW5JZW5FVEhnNUQ1Yno0S05VNlpJ?=
 =?utf-8?B?ZVJUN25SSUl4Nmg3RlZhdm9keTY2VlVQSUNBRldqMCtsV1Q3YXcvQjlDQTI2?=
 =?utf-8?B?c29vbHZ1VDNqdlNBcUxHMklZOG9TbmZHY3ZQMFdvWTlsVTVVRHZldGhVbFhJ?=
 =?utf-8?B?OU15VUxyU0wraVNxZGZiaThTUDlVVjB1dXkyNjlESzVYZXBNQlpGOCtYMGxq?=
 =?utf-8?Q?mPQA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8357d0-8b4c-45bb-37b7-08d9c068c386
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 07:50:44.0930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgefiBS++xoiX1B/Yc1+tXKrBBL7KqI8Cl/n8lNUdshizj4TGX5GmezHXRvtIMza
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1487
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Am 15.12.21 um 15:16 schrieb Michał Winiarski:
> Similar to regular resizable BAR, VF BAR can also be resized.
> The structures are very similar, which means we can reuse most of the
> implementation. See PCIe r4.0, sec 9.3.7.4.
>
> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
> ---
>   drivers/pci/pci.c             | 25 +++++++++++++++--
>   drivers/pci/setup-res.c       | 53 ++++++++++++++++++++++++++++++++---
>   include/uapi/linux/pci_regs.h |  1 +
>   3 files changed, 72 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3d2fb394986a4..89448c5104e46 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1682,12 +1682,15 @@ static void pci_restore_config_space(struct pci_dev *pdev)
>   	}
>   }
>   
> -static void pci_restore_rebar_state(struct pci_dev *pdev)
> +static void __pci_restore_rebar_state(struct pci_dev *pdev, int cap)
>   {
>   	unsigned int pos, nbars, i;
>   	u32 ctrl;
>   
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> +	if (WARN_ON(cap != PCI_EXT_CAP_ID_REBAR && cap != PCI_EXT_CAP_ID_VF_REBAR))
> +		return;
> +
> +	pos = pci_find_ext_capability(pdev, cap);
>   	if (!pos)
>   		return;
>   
> @@ -1709,6 +1712,14 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
>   	}
>   }
>   
> +static void pci_restore_rebar_state(struct pci_dev *pdev)
> +{
> +	__pci_restore_rebar_state(pdev, PCI_EXT_CAP_ID_REBAR);
> +#ifdef CONFIG_PCI_IOV
> +	__pci_restore_rebar_state(pdev, PCI_EXT_CAP_ID_VF_REBAR);
> +#endif
> +}
> +

It's probably cleaner to let the caller specify the capability to 
restore directly.

>   /**
>    * pci_restore_state - Restore the saved state of a PCI device
>    * @dev: PCI device that we're dealing with
> @@ -3639,10 +3650,18 @@ void pci_acs_init(struct pci_dev *dev)
>    */
>   static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
>   {
> +	int cap = PCI_EXT_CAP_ID_REBAR;
>   	unsigned int pos, nbars, i;
>   	u32 ctrl;
>   
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> +#ifdef CONFIG_PCI_IOV
> +	if (bar >= PCI_IOV_RESOURCES) {
> +		cap = PCI_EXT_CAP_ID_VF_REBAR;
> +		bar -= PCI_IOV_RESOURCES;
> +	}
> +#endif
> +
> +	pos = pci_find_ext_capability(pdev, cap);
>   	if (!pos)
>   		return -ENOTSUPP;
>   
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 7f1acb3918d0c..1946e52e7678a 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -407,13 +407,36 @@ void pci_release_resource(struct pci_dev *dev, int resno)
>   }
>   EXPORT_SYMBOL(pci_release_resource);
>   
> +static int pci_memory_decoding(struct pci_dev *dev)
> +{
> +	u16 cmd;
> +
> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +	if (cmd & PCI_COMMAND_MEMORY)
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PCI_IOV
> +static int pci_vf_memory_decoding(struct pci_dev *dev)
> +{
> +	u16 cmd;
> +
> +	pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_CTRL, &cmd);
> +	if (cmd & PCI_SRIOV_CTRL_MSE)
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +#endif
> +
>   int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>   {
>   	struct resource *res = dev->resource + resno;
>   	struct pci_host_bridge *host;
>   	int old, ret;
>   	u32 sizes;
> -	u16 cmd;
>   
>   	/* Check if we must preserve the firmware's resource assignment */
>   	host = pci_find_host_bridge(dev->bus);
> @@ -424,9 +447,14 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>   	if (!(res->flags & IORESOURCE_UNSET))
>   		return -EBUSY;
>   
> -	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> -	if (cmd & PCI_COMMAND_MEMORY)
> -		return -EBUSY;
> +#ifdef CONFIG_PCI_IOV
> +	if (resno >= PCI_IOV_RESOURCES)
> +		ret = pci_vf_memory_decoding(dev);
> +	else
> +#endif
> +	ret = pci_memory_decoding(dev);
> +	if (ret)
> +		return ret;

Way to many #ifdef spread around inside the code, please restructure that.

For example concentrating the logic in a single function should help:

static int pci_check_decoding_disabled(..., inr resno)
{

#ifdef CONFIG_PCI_IOV
	if (resno...
		return -EBUSY;
	else
		return 0;
#endif

	if (...)
		return -EBUSY;
	return 0;

}

>   
>   	sizes = pci_rebar_get_possible_sizes(dev, resno);
>   	if (!sizes)
> @@ -445,6 +473,14 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>   
>   	res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
>   
> +#ifdef CONFIG_PCI_IOV
> +	if (resno >= PCI_IOV_RESOURCES) {
> +		dev->sriov->barsz[resno - PCI_IOV_RESOURCES] = pci_rebar_size_to_bytes(size);
> +		res->end = res->start +
> +			resource_size(res) * pci_sriov_get_totalvfs(dev) - 1;
> +	}
> +#endif
> +
>   	/* Check if the new config works by trying to assign everything. */
>   	if (dev->bus->self) {
>   		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
> @@ -456,6 +492,15 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>   error_resize:
>   	pci_rebar_set_size(dev, resno, old);
>   	res->end = res->start + pci_rebar_size_to_bytes(old) - 1;
> +
> +#ifdef CONFIG_PCI_IOV
> +	if (resno >= PCI_IOV_RESOURCES) {
> +		dev->sriov->barsz[resno - PCI_IOV_RESOURCES] = pci_rebar_size_to_bytes(old);
> +		res->end = res->start +
> +			pci_rebar_size_to_bytes(old) * pci_sriov_get_totalvfs(dev) - 1;
> +	}
> +#endif
> +

Looks like this deserves it's own function.

Regards,
Christian.

>   	return ret;
>   }
>   EXPORT_SYMBOL(pci_resize_resource);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ff6ccbc6efe96..7f5726d23b038 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -734,6 +734,7 @@
>   #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
>   #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
>   #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
> +#define PCI_EXT_CAP_ID_VF_REBAR	0x24	/* VF Resizable BAR */
>   #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>   #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
>   #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT

