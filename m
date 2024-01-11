Return-Path: <linux-pci+bounces-2022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A6982A6A7
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 04:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8361C21DB1
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 03:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5569BEC0;
	Thu, 11 Jan 2024 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BDqOS1re"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E710FC
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 03:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXnYZWlziiJKswEX4JidJHC7Hxs61IzdIoGww7MQkyK8tu5l99NQbOKqQoOqz88JTiGaY5cYY/Pw03OTbl7wJGtesH2Toq+nhC6NhJJNNmsCMNHgLqMK7lhIlNech63m+q+otJWsRI5qDdheJiZdbZMDwurxCaIK6f2cTA19sy1/r2t92LogpagKW7o1NQaBAZVVaL0zVc7Cq0Gy8zBA8XWyfybjNYdEOst6N5JmG/twcNT8z1H8r53gU0QmzivUu3EUtHMKNOsbMN7VrmGGyGAS2Ongn8EB0Yf68V88706aq7tD7J6PxnVgBTvI+AqugNk8CP/tcavR+DzxNxcCWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b33LMknL3BTYQIQ/JK+g0L0lpPjPGngWOfKVchn9x8I=;
 b=i5CVhZCHyiFsTdsybpLaHdY0HcQRDNZFY9XvIUA9t6u/gQIAsXqpm/0EOJHgcF6Tl+L6txlsmufI6MAB7csR1mnMQBZvAXl6X7tkvQpaX8nbro6JTueEorAYS2TMmenqPnV7u2Rsr1Ai+Oz9ZjCVcHcPuCkJva6LtASayzHeySLNbmJ+Hi4EXeHwTEXZzLIshwEik+eLxFQqBHXKZspKkEC1xozMgrShP/zZ9kyS5LD9MtlPExnlqLyO+R4C+L4SR1TpM3ev34TKDPDLHE4a8yjX+EntC08cRMO+WAkNGCo1g0slHApO6NKEg/wKIzAPXaW6a/NkrrOh9Sh6PsvKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b33LMknL3BTYQIQ/JK+g0L0lpPjPGngWOfKVchn9x8I=;
 b=BDqOS1rehOYf4rNLRxrL73VNZhNVdIDFJqRJJ2MAiBrTn0JYdRGzWvC7NL2WYssAZ//o1qMQGf0JgWDZG71T4CFzlQwDQqdd8FvyKtXUlR9NyhQSA+ZJ+mILYZHqTQUG84oQlPT/g/Ydtd7BFP/OZ7wHa1ty+2FPeFELb3Li9P0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 03:52:07 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::3112:5f54:2e51:cf89]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::3112:5f54:2e51:cf89%5]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 03:52:07 +0000
Message-ID: <868361f2-889e-47f8-ad54-43b5d8dde522@amd.com>
Date: Thu, 11 Jan 2024 14:52:00 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH pciutils 2/2] pciutils: Add decode support for IDE
 Extended Capability
Content-Language: en-US
Cc: =?UTF-8?Q?Martin_Mare=C5=A1?= <mj@ucw.cz>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20231230124239.310927-1-aik@amd.com>
 <20231230124239.310927-3-aik@amd.com>
From: Alexey Kardashevskiy <aik@amd.com>
To: linux-pci@vger.kernel.org
In-Reply-To: <20231230124239.310927-3-aik@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYAPR01CA0019.ausprd01.prod.outlook.com (2603:10c6:1::31)
 To CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 2716da00-d550-4031-333c-08dc1258ae56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CkCo3SyW4W5ZpRQsKMHHd9d93ETdjr+aU72r+kHc56yKI7mBt8zZixVlZfKw/gkYmldCYzhRtr5iwspkuTtpqc347ZVNo9j19ZSyJXGnDQIQgbfIDhwy/q9LfrxeRsIWg7Crqv97Wa+ZinsQjdL1m/g1Q+fDuNe91frKLCgu6nmkh5SYdmeFK6XUrr1/lGdkZZWmxaavrrE/y0b+1VapRRW31IbMKdThxTWPqfkz7RewlzST9SmPCF8oNxzpcZR87Xx4sCn3U/o9Rk2rFw5IrKwnrOBY4baxAA2w7sdZZxVcvAnnWTvdT6feVF5NEhueICReBbOabdg960TTcT2yM4YU6J9Sy3fjjxgPtF3g6zES0VzteoYD/6TvUjfX6xs4EIvfICIH/BnSLp1XjhcpPHPMNWaCp42Gb8OzQvNoRHfBo+Y+DWzQ8DebB1fUFYXNYXFoepl7nYPWmg0jxgURwO68/JDqJw2Fgwufb926BVzS0S8Et4MznJVX1KpgiLcXC2/02wPdLE/vaHnz7kEcvHLHj7Pk4CEr2XzMUi4tls7KghuI+i544SPqoX6X8WSyDpQclkW0xAdApVWnEMVTMKBzeIK09ElUm9Hz5JpSBX3Y7LTAfqC7nJGKoXgXjj1jZhVnpCVLrBimA+P7sKbFGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(36756003)(31686004)(31696002)(26005)(83380400001)(6512007)(66946007)(66556008)(54906003)(66476007)(316002)(6666004)(478600001)(53546011)(6506007)(8676002)(8936002)(4326008)(19627235002)(6916009)(2616005)(6486002)(5660300002)(30864003)(2906002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkNlS0dwNWNBVlpNbzhEdnR6ZXFiLyszei95Ynl4Rkk4RE1CYTFkb2sxbmZE?=
 =?utf-8?B?TFdMUUxEVm1sM3hjLzJ4Y2lKaEIwMmFTS1F1RGY5eVhOT0xhNzQ3RmtiQzll?=
 =?utf-8?B?Qkw5RVp5MStjOHpLbVBGY0Y4Y2RwMlBUOERnc1ZaZFloeWVocVNyWnBuc0J0?=
 =?utf-8?B?QmdXNHRXeTNUdzg1Mm1xdEVuc1NrV1dzWHN1QVNLdUlzOHE5aVpWS0U0SDFh?=
 =?utf-8?B?dm44YWtwYmhJcXR5UHhaTlFGbDg0ZTE0VkVYRks4bWRMOXBVZUNrNFhjK1VN?=
 =?utf-8?B?OFk4Y1dCSWJnQ0ozaFFtcGRGNU1sRkwwMjlJZlhscEZkdlFaQTIra3h4VjdG?=
 =?utf-8?B?RUFzVVJ5SGpCblRkM2szQmNMNzRHczc1aXFqWEcwWTdBalUzaldRY0RGcjJm?=
 =?utf-8?B?SDQ3SlZhaitJL3ZsWSs2Q3N4dHZuajZmanJlZlB5SE1aVDVsYkt5QjlaeExS?=
 =?utf-8?B?Mi9yZjJsSGF0UWdpQjNMNUdqZFpkeHBjMlpsUWVpdUVjbThlREtrWlFEbWtP?=
 =?utf-8?B?ZUJZNWFGUkhDZ2lPTUlUaUNiUmIwbmtEVjJyZ1l1WU5RcEQvRXBCVU44azA0?=
 =?utf-8?B?SXQ5WUppSjZLaGFDUnlZd0FBZE5nNzBYOXBjL3NFMlhCUTl6QWJpYjY4ZFNO?=
 =?utf-8?B?SER3OURtQUhuTnROS0UxeXExaUtZQ2dybFRQcktXK0hkZmQyWXJLVlF5VUVY?=
 =?utf-8?B?SzB6UlVCbnlzUTlnRzFYY0I4V1U2ak1qUEVmMXNZTVgwcnFKWmtxNmVjNER6?=
 =?utf-8?B?QUhQNVROUHRMMDl5V3AxamI0ZFNiTTlBazQzT1FNb2NBM3AwUWVXZzF6N1dv?=
 =?utf-8?B?cjcvcy9laUU5SGlqaEo2U3gyTnNON1poUW1XR29kaDlJUU5MQ3Nzcms2TjhD?=
 =?utf-8?B?cm1SN3g4bXNJbXk5aDBROUtlRjBoRTFkckRobFRVeFJ1UjBRM1BBaTZUazNl?=
 =?utf-8?B?U0tXTzhrN2xxZTFZRFpxVVRtaHNaK2szbEdRNFRTSG5EK3JqcXg3aHQrbTBk?=
 =?utf-8?B?RS8zYmxHcExRTDEwMzRYUXo5Qk1idm1XOXlDZmNPS1A2aVVGYkhpUmY4dnVo?=
 =?utf-8?B?KytTOStvOWRKTm1vRTJyd29NKytXbEJSM1VyT24wd0FhTU9rY2F2eGNvOUww?=
 =?utf-8?B?S2dqeEpGL0ZVRmdFVDZoemltSEd3OC9iemdSU1Y5YVVHZnFLMU1jVXlFNzNo?=
 =?utf-8?B?c0tOcXBDY25zYUEvb1JPM2U0d0ovbkRubnBlREhLTzIvMVNJYTZkcDFpSExZ?=
 =?utf-8?B?U3g5RFAxZHR4cys2enhtaEpFT0tmTkdLcEtLZzhXWDBjU3h0alJPd1czRksv?=
 =?utf-8?B?WEZSUDVyR0RpTy8wdFJVNGZKcDZyYU4wNXdSa3JNQXpBYkpFbThGZDJBTHUv?=
 =?utf-8?B?N3hHQkFhYjBScU1lVk9pdjZzYUZqdzRSRDE0NFhGSUFhcXU0YW9zNmtoOWRO?=
 =?utf-8?B?ZE9ycE9qZ2ErdnR2dnlJUmFMaWViUHQ3MXl0aVRhd2kzUzVCdkJkMHRWVVhJ?=
 =?utf-8?B?WEdqOGYvdzlka1FJK1hMMS8rYjh1RThzeGZUamV1bWJGZlhZaUl5TEFybnBP?=
 =?utf-8?B?akZXQlpGbGxVV3dtWVEvczczV0taVjBZcWFBQTlIZlg2YmF4L0s5L1BUYXFU?=
 =?utf-8?B?UFJoZHFqNDdOY240RndpRE1JcVp1WmlZWjRmMStJZ3lGQW1DTjAxVlpDdHpJ?=
 =?utf-8?B?SVllTVhpNzFnK1o3RmE5OGNSVGNuVC9OZGZTOS9WUCtsRlExaDMzaXVJS0pl?=
 =?utf-8?B?RFRvSFcrZEZrK093SUZaZjJSM2RXdmMxMmplK2ptV0RTRndlWDh2N0tnR3Na?=
 =?utf-8?B?cGJOc3YxKzFvanVwYy9yeVJiWU4zZlhkcldzbXZkRk5Fd1QyTk5JTzFUaCtz?=
 =?utf-8?B?Y1UrMmJnZWhSRG9NQmJXRzRGNW9KTXJTZHVDckxvSEpGLzh3aDRTN2hQZzJn?=
 =?utf-8?B?NjlBeDNrT0hHOTg4VlNhcWtNYWFFbVlxd2ltQmZYNk1IcDBCaERKKzdxWEpU?=
 =?utf-8?B?NklhTWNFZWdkRXJ0RXVSVTVoZnd6cjJQNG1jNkhqZU1QNGJHMmlpUnluSFRo?=
 =?utf-8?B?SktPS0FqbWo1TjlvcUF4QmZrdHFaNHJCQ2ZrRi85bDdvMTZBNFRaQjVyMVRy?=
 =?utf-8?Q?KOMqGoLyI4Pen8xuxHEzmyFxs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2716da00-d550-4031-333c-08dc1258ae56
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 03:52:07.4658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM7a/nqTrzrnxNMuq8TJuKn4SkZCmkDnCI5BNk51rRddEK4p1WN53pHJIpFPO2yc4vZU0GybMTztD1QJZfz48A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161

On 30/12/23 23:42, Alexey Kardashevskiy wrote:
> IDE (Integrity & Data Encryption) Extended Capability defined in [1]
> implements control of the PCI link encryption.
> 
> The example output is:
> 
> Capabilities: [830 v1] IDE
> 	IDECap: Lnk=1 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM+
> 	IDECtl: IntEn-
> 	LinkIDE#0 Ctl: En- NPR- PR- CPL- PCRC- HdrEnc=no Alg='AES-GCM 256 key size, 96b MAC' TC0 ID0
> 	LinkIDE#0 Sta: Status=secure RecvChkFail-
> 	SelectiveIDE#0 Ctl: En- NPR- PR- CPL- PCRC- HdrEnc=no Alg='AES-GCM 256 key size, 96b MAC' TC0 ID0
> 	SelectiveIDE#0 Sta: insecure RecvChkFail-
> 	SelectiveIDE#0 RID: Valid- Base=0 Limit=0 SegBase=0


Ping? Suspiciously quiet :)

This is also missing:

--- a/setpci.c
+++ b/setpci.c
@@ -396,6 +396,7 @@ static const struct reg_name pci_reg_names[] = {
    { 0x20027,   0, 0, 0x0, "ECAP_LMR" },
    { 0x20028,   0, 0, 0x0, "ECAP_HIER_ID" },
    { 0x20029,   0, 0, 0x0, "ECAP_NPEM" },
+  { 0x20030,   0, 0, 0x0, "ECAP_IDE" },

Which reminded me - one thing I want to do with setpci is changing the 
"En-"s above to "En+". At the moment setpci.c seems only allowing 
offsets into a ecapability which is tricky to use as offsets of 
"LinkIDE#NN Ctl" and "SelectiveIDE#NN Ctl" are not fixed - these are 
variable length arrays.

So, I could
1) teach setpci do parsing (repeat what s-ecaps.c does) to allow 
register names, like "setpci CAP_IDE+LinkIDE#4Ctl", something like this.

2) dump offsets as ([24] in this example and use offsets with setpci 
which it can do now):

LinkIDE#0 Ctl [24]: En- NPR- PR- CPL- PCRC- HdrEnc=no Alg='AES-GCM 256 
key size, 96b MAC' TC0 ID0

3) leave lspci/setpci alone and do it elsewhere.

Any advice? Thanks,

> 
> [1] PCIe r6.0.1, sections 6.33, 7.9.26
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>   lib/header.h |  61 ++++++++
>   ls-ecaps.c   | 162 ++++++++++++++++++++
>   2 files changed, 223 insertions(+)
> 
> diff --git a/lib/header.h b/lib/header.h
> index 47ee8a6..5df2f57 100644
> --- a/lib/header.h
> +++ b/lib/header.h
> @@ -256,6 +256,7 @@
>   #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>   #define PCI_EXT_CAP_ID_32GT	0x2a	/* Physical Layer 32.0 GT/s */
>   #define PCI_EXT_CAP_ID_DOE	0x2e	/* Data Object Exchange */
> +#define PCI_EXT_CAP_ID_IDE	0x30	/* IDE */
>   
>   /*** Definitions of capabilities ***/
>   
> @@ -1416,6 +1417,66 @@
>   #define  PCI_DOE_STS_ERROR		0x4	/* DOE Error */
>   #define  PCI_DOE_STS_OBJECT_READY	0x80000000 /* Data Object Ready */
>   
> +/* IDE Extended Capability */
> +#define PCI_IDE_CAP		0x4
> +#define  PCI_IDE_CAP_LINK_IDE_SUPP	0x1	/* Link IDE Stream Supported */
> +#define  PCI_IDE_CAP_SELECTIVE_IDE_SUPP 0x2	/* Selective IDE Streams Supported */
> +#define  PCI_IDE_CAP_FLOWTHROUGH_IDE_SUPP 0x4	/* Flow-Through IDE Stream Supported */
> +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC_SUPP 0x8 /* Partial Header Encryption Supported */
> +#define  PCI_IDE_CAP_AGGREGATION_SUPP	0x10	/* Aggregation Supported */
> +#define  PCI_IDE_CAP_PCRC_SUPP		0x20	/* PCRC Supported */
> +#define  PCI_IDE_CAP_IDE_KM_SUPP	0x40	/* IDE_KM Protocol Supported */
> +#define  PCI_IDE_CAP_ALG(x)	(((x) >> 8) & 0x1f) /* Supported Algorithms */
> +#define  PCI_IDE_CAP_ALG_AES_GCM_256	0	/* AES-GCM 256 key size, 96b MAC */
> +#define  PCI_IDE_CAP_LINK_TC_NUM(x)		(((x) >> 13) & 0x7) /* Number of TCs Supported for Link IDE */
> +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Number of Selective IDE Streams Supported */
> +#define PCI_IDE_CTL		0x8
> +#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4	/* Flow-Through IDE Stream Enabled */
> +#define PCI_IDE_LINK_STREAM		0xC
> +/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
> +/* Link IDE Stream Control Register */
> +#define  PCI_IDE_LINK_CTL_EN		0x1	/* Link IDE Stream Enable */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR(x)(((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_PR(x)	(((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL(x)(((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> +#define  PCI_IDE_LINK_CTL_PCRC_EN	0x100	/* PCRC Enable */
> +#define  PCI_IDE_LINK_CTL_PART_ENC(x)	(((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
> +#define  PCI_IDE_LINK_CTL_ALG(x)	(((x) >> 14) & 0x1f) /* Selected Algorithm */
> +#define  PCI_IDE_LINK_CTL_TC(x)		(((x) >> 19) & 0x7)  /* Traffic Class */
> +#define  PCI_IDE_LINK_CTL_ID(x)		(((x) >> 24) & 0xff) /* Stream ID */
> +/* Link IDE Stream Status Register */
> +#define  PCI_IDE_LINK_STS_STATUS(x)	((x) & 0xf) /* Link IDE Stream State */
> +#define  PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Message */
> +/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
> +/* Selective IDE Stream Capability Register */
> +#define  PCI_IDE_SEL_CAP_BLOCKS_NUM(x)	((x) & 0xf) /* Number of Address Association Register Blocks */
> +/* Selective IDE Stream Control Register */
> +#define  PCI_IDE_SEL_CTL_EN		0x1	/* Selective IDE Stream Enable */
> +#define  PCI_IDE_SEL_CTL_TX_AGGR_NPR(x)	(((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
> +#define  PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	(((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
> +#define  PCI_IDE_SEL_CTL_TX_AGGR_CPL(x)	(((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> +#define  PCI_IDE_SEL_CTL_PCRC_EN	0x100	/* PCRC Enable */
> +#define  PCI_IDE_SEL_CTL_PART_ENC(x)	(((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
> +#define  PCI_IDE_SEL_CTL_ALG(x)		(((x) >> 14) & 0x1f) /* Selected Algorithm */
> +#define  PCI_IDE_SEL_CTL_TC(x)		(((x) >> 19) & 0x7)  /* Traffic Class */
> +#define  PCI_IDE_SEL_CTL_DEFAULT	0x400000 /* Default Stream */
> +#define  PCI_IDE_SEL_CTL_ID(x)		(((x) >> 24) & 0xff) /* Stream ID */
> +/* Selective IDE Stream Status Register */
> +#define  PCI_IDE_SEL_STS_STATUS(x)	((x) & 0xf) /* Selective IDE Stream State */
> +#define  PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Message */
> +/* IDE RID Association Register 1 */
> +#define  PCI_IDE_SEL_RID_1_LIMIT(x)	(((x) >> 8) & 0xffff) /* RID Limit */
> +/* IDE RID Association Register 2 */
> +#define  PCI_IDE_SEL_RID_2_VALID	0x1	/* Valid */
> +#define  PCI_IDE_SEL_RID_2_BASE(x)	(((x) >> 8) & 0xffff) /* RID Base */
> +#define  PCI_IDE_SEL_RID_2_SEG_BASE(x)	(((x) >> 24) & 0xff) /* Segmeng Base */
> +/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_BLOCKS_NUM */
> +#define  PCI_IDE_SEL_ADDR_1_VALID	0x1	/* Valid */
> +#define  PCI_IDE_SEL_ADDR_1_BASE_LOW(x)	(((x) >> 8) & 0xfff) /* Memory Base Lower */
> +#define  PCI_IDE_SEL_ADDR_1_LIMIT_LOW(x)(((x) >> 20) & 0xfff) /* Memory Limit Lower */
> +/* IDE Address Association Register 2 is "Memory Limit Upper" */
> +/* IDE Address Association Register 3 is "Memory Base Upper" */
> +
>   /*
>    * The PCI interface treats multi-function devices as independent
>    * devices.  The slot/function address of each device is encoded
> diff --git a/ls-ecaps.c b/ls-ecaps.c
> index 2d7d827..9f6c3f8 100644
> --- a/ls-ecaps.c
> +++ b/ls-ecaps.c
> @@ -1468,6 +1468,165 @@ cap_doe(struct device *d, int where)
>   	 FLAG(l, PCI_DOE_STS_OBJECT_READY));
>   }
>   
> +static void
> +cap_ide(struct device *d, int where)
> +{
> +    const char *hdr_enc_mode[] = { "no", "17:2", "25:2", "33:2", "41:2" };
> +    const char *algo[] = { "AES-GCM 256 key size, 96b MAC" };
> +    const char *stream_state[] = { "insecure", "secure" };
> +    const char *aggr[] = { "-", "=2", "=4", "=8" };
> +    u32 l, l2, linknum = 0, selnum = 0, addrnum, off, i, j;
> +    char buf1[16], buf2[16];
> +
> +    printf("IDE\n");
> +
> +    if (verbose < 2)
> +        return;
> +
> +    if (!config_fetch(d, where + PCI_IDE_CAP, 8))
> +      {
> +        printf("\t\t<unreadable>\n");
> +        return;
> +      }
> +
> +    l = get_conf_long(d, where + PCI_IDE_CAP);
> +    if (l & PCI_IDE_CAP_LINK_IDE_SUPP)
> +        linknum = PCI_IDE_CAP_LINK_TC_NUM(l) + 1;
> +    if (l & PCI_IDE_CAP_SELECTIVE_IDE_SUPP)
> +        selnum = PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(l) + 1;
> +
> +    printf("\t\tIDECap: Lnk=%d Sel=%d FlowThru%c PartHdr%c Aggr%c PCPC%c IDE_KM%c\n",
> +      linknum,
> +      selnum,
> +      FLAG(l, PCI_IDE_CAP_FLOWTHROUGH_IDE_SUPP),
> +      FLAG(l, PCI_IDE_CAP_PARTIAL_HEADER_ENC_SUPP),
> +      FLAG(l, PCI_IDE_CAP_AGGREGATION_SUPP),
> +      FLAG(l, PCI_IDE_CAP_PCRC_SUPP),
> +      FLAG(l, PCI_IDE_CAP_IDE_KM_SUPP));
> +
> +    l = get_conf_long(d, where + PCI_IDE_CTL);
> +    printf("\t\tIDECtl: IntEn%c\n",
> +      FLAG(l, PCI_IDE_CTL_FLOWTHROUGH_IDE));
> +
> +    // The rest of the capability is variable length arrays
> +    off = where + PCI_IDE_CAP + PCI_IDE_LINK_STREAM;
> +
> +    // Link IDE Register Block repeated 0 to 8 times
> +    if (linknum)
> +      {
> +        if (!config_fetch(d, off, 8 * linknum))
> +          {
> +            printf("\t\t<unreadable>\n");
> +            return;
> +          }
> +        for (i = 0; i < linknum; ++i)
> +          {
> +            // Link IDE Stream Control Register
> +            l = get_conf_long(d, off);
> +            off += 4;
> +            printf("\t\tLinkIDE#%d Ctl: En%c NPR%s PR%s CPL%s PCRC%c HdrEnc=%s Alg='%s' TC%d ID%d\n",
> +              i,
> +              FLAG(l, PCI_IDE_LINK_CTL_EN),
> +              aggr[PCI_IDE_LINK_CTL_TX_AGGR_NPR(l)],
> +              aggr[PCI_IDE_LINK_CTL_TX_AGGR_PR(l)],
> +              aggr[PCI_IDE_LINK_CTL_TX_AGGR_CPL(l)],
> +              FLAG(l, PCI_IDE_LINK_CTL_EN),
> +              TABLE(hdr_enc_mode, PCI_IDE_LINK_CTL_PART_ENC(l), buf1),
> +              TABLE(algo, PCI_IDE_LINK_CTL_ALG(l), buf2),
> +              PCI_IDE_LINK_CTL_TC(l),
> +              PCI_IDE_LINK_CTL_ID(l)
> +              );
> +
> +            /* Link IDE Stream Status Register */
> +            l = get_conf_long(d, off);
> +            off += 4;
> +            printf("\t\tLinkIDE#%d Sta: Status=%s RecvChkFail%c\n",
> +              i,
> +              TABLE(stream_state, PCI_IDE_LINK_STS_STATUS(l), buf1),
> +              FLAG(l, PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK));
> +          }
> +      }
> +
> +    for (i = 0; i < linknum; ++i)
> +      {
> +        // Fetching Selective IDE Stream Capability/Control/Status/RID1/RID2
> +        if (!config_fetch(d, off, 20))
> +          {
> +            printf("\t\t<unreadable>\n");
> +            return;
> +          }
> +
> +        // Selective IDE Stream Capability Register
> +        l = get_conf_long(d, off);
> +        off += 4;
> +        addrnum = PCI_IDE_SEL_CAP_BLOCKS_NUM(l);
> +
> +        // Selective IDE Stream Control Register
> +        l = get_conf_long(d, off);
> +        off += 4;
> +
> +        printf("\t\tSelectiveIDE#%d Ctl: En%c NPR%s PR%s CPL%s PCRC%c HdrEnc=%s Alg='%s' TC%d ID%d%s\n",
> +          i,
> +          FLAG(l, PCI_IDE_SEL_CTL_EN),
> +          aggr[PCI_IDE_SEL_CTL_TX_AGGR_NPR(l)],
> +          aggr[PCI_IDE_SEL_CTL_TX_AGGR_PR(l)],
> +          aggr[PCI_IDE_SEL_CTL_TX_AGGR_CPL(l)],
> +          FLAG(l, PCI_IDE_SEL_CTL_PCRC_EN),
> +          TABLE(hdr_enc_mode, PCI_IDE_SEL_CTL_PART_ENC(l), buf1),
> +          TABLE(algo, PCI_IDE_SEL_CTL_ALG(l), buf2),
> +          PCI_IDE_SEL_CTL_TC(l),
> +          PCI_IDE_SEL_CTL_ID(l),
> +          (l & PCI_IDE_SEL_CTL_DEFAULT) ? " Default" : ""
> +          );
> +
> +        // Selective IDE Stream Status Register
> +        l = get_conf_long(d, off);
> +        off += 4;
> +
> +        printf("\t\tSelectiveIDE#%d Sta: %s RecvChkFail%c\n",
> +          i,
> +          TABLE(stream_state, PCI_IDE_SEL_STS_STATUS(l), buf1),
> +          FLAG(l, PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK));
> +
> +        // IDE RID Association Registers
> +        l = get_conf_long(d, off);
> +        off += 4;
> +        l2 = get_conf_long(d, off);
> +        off += 4;
> +
> +        printf("\t\tSelectiveIDE#%d RID: Valid%c Base=%x Limit=%x SegBase=%x\n",
> +          i,
> +          FLAG(l2, PCI_IDE_SEL_RID_2_VALID),
> +          PCI_IDE_SEL_RID_2_BASE(l2),
> +          PCI_IDE_SEL_RID_1_LIMIT(l),
> +          PCI_IDE_SEL_RID_2_SEG_BASE(l2));
> +
> +        if (!config_fetch(d, off, addrnum * 12))
> +          {
> +            printf("\t\t<unreadable>\n");
> +            return;
> +          }
> +
> +        // IDE Address Association Registers
> +        for (j = 0; j < addrnum; ++j)
> +          {
> +            u64 limit, base;
> +
> +            l = get_conf_long(d, off);
> +            off += 4;
> +            limit = get_conf_long(d, off);
> +            off += 4;
> +            base = get_conf_long(d, off);
> +            off += 4;
> +            printf("\t\tSelectiveIDE#%d RID: Valid%c Base=%lx Limit=%lx\n",
> +              i,
> +              FLAG(l, PCI_IDE_SEL_ADDR_1_VALID),
> +              (base << 32) | PCI_IDE_SEL_ADDR_1_BASE_LOW(l),
> +              (limit << 32) | PCI_IDE_SEL_ADDR_1_LIMIT_LOW(l));
> +          }
> +      }
> +}
> +
>   void
>   show_ext_caps(struct device *d, int type)
>   {
> @@ -1621,6 +1780,9 @@ show_ext_caps(struct device *d, int type)
>   	  case PCI_EXT_CAP_ID_DOE:
>   	    cap_doe(d, where);
>   	    break;
> +	  case PCI_EXT_CAP_ID_IDE:
> +	    cap_ide(d, where);
> +	    break;
>   	  default:
>   	    printf("Extended Capability ID %#02x\n", id);
>   	    break;

-- 
Alexey


