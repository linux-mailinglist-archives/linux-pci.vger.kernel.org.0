Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB697446EC
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jul 2023 08:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGAGaI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Jul 2023 02:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGAGaG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Jul 2023 02:30:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27E42118;
        Fri, 30 Jun 2023 23:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7mebXRLVE9v9ij47EfBinc4jmOwkXLAWe9/9hgXbqBGBrXCYelrLMJPDComknT2AwQyzUv5J9BQZHf8ISZgKemrwWs1H+CPlMCCM7BHPR83pc8KG2u9WbVvDECOtNiVHq1Bjpu2qEp2KHN7ERDD2XFVeDXU3Hm0AbtYWzSADHvzDor+V4dX8Esig4FQf+ybftldf99A556sEuFs9Gs9h8qmMqDv+Pwmk9oSMF+AryKFnbUYdeKs/kjd71PJ6giDrLWZon30vJdZSv0YnApELV1Uq5b2zWz1bmZOwJIrZASimEuJXhuLa3NOcySdwHNAfQwr/MXsgasyY19779IVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BnRCyBLuP+DIc/f/qXgOnYnptJ2oh7yrEa19JrJWnA=;
 b=FHWdVWIR4wIls9aD6ZmMypSIwiBHySx7RI/vNk5sa6gHHD2foFd9iRQvMZ54hMSInx/tkpwe6U5jAxCloBVN+otqCS6NkFHCvbb0gI//Xm2qaTPNUP4xupYy4/xfCbl0HJKPl5omaBs+bmcvParZCuS3iuuP/G1KH1xJSVzL8MQNnyLIclKzEueNC2cJ4qSWZ8Wi0RQbnkBL8Uc1Gnb4fKjRz7m4ufvlLlEomJNCTkyYu1/i+lfaL4le9wIMhheCY1a5iQa0f+SKmTP88qdmmNPVCZZtEFr1Uj5LqJxF5PC6Bpw0JtEuFA7qQ6dTQ4R8yNtK6QzXvZxpt76zt5/Qiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BnRCyBLuP+DIc/f/qXgOnYnptJ2oh7yrEa19JrJWnA=;
 b=ICoO9vYTs9qWQ0Er2BlmO6GE3iPmJ/yKDV3XodkN6aCwgfQA0RxRX/d0jFpLhtp7RDvPKaKnxnXuMtUOoNqEjoXszy4SyctSBEWC92Mhah6LyjjaHy6Y2zFXJeS4EHf4gY4FRbctSYnQu3DgN8d0f0XkS3q7pBgLZSZX2sohE2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 1 Jul
 2023 06:30:00 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad%5]) with mapi id 15.20.6544.019; Sat, 1 Jul 2023
 06:29:59 +0000
Message-ID: <ba93f227-e46d-dbd0-1082-9396853e2fc4@amd.com>
Date:   Fri, 30 Jun 2023 23:29:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>,
        Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-3-Smita.KoralahalliChannabasappa@amd.com>
 <20230622063105.GA624@wunner.de>
 <d64f8de4-cac1-ccca-33fe-1fda418837e2@amd.com>
 <20230622214247.GB11993@wunner.de>
 <4599d885-219f-3ee0-f425-62746f31cc67@amd.com>
 <20230628132526.GA14276@wunner.de>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230628132526.GA14276@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4c8ded-fe9c-4997-4a37-08db79fc97e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NuDgu+rmfC2e006xxVHLFxa1KLMyj593WAO0EfmRtRliFIpqErcJTmXAr/QOnP7PdrmId2TT+nC9jYgceZ28FnRED98P4LPqYZ/HEch8nLLcmVAOl/Z2QdW4S3UWTxCxjzKOI2RSbXuQpBensh80t/zEW7fozjwgkdFiuxVS4b/iB1OwpegsZC+QhfDUEoERrPaoRg+YHM/w5ezRZsaP7l6/gb3jX9L+LC7XHWTZ12ngBoLGIMPHpDXvAQ8ucjhmgfXzjkxBB3OUfbnvbZvBT6qGbhXRMUi54MYLOh8tKYp3dC1+Wc5SsHMHpgct9T+bFo0guYOloqNUjqKpJBK0NmnORIvUsAdYVSIlucrY/0FWyYIsMPDhXNjEvkDQnJHrV/s6e84tTZHSvqD0oqvxd8l9RK5TjruZLh78F5yqaBd6vqa5B/uVx0n/uOj5pRd+P02RkmGtV/BfBHVOwWrqsj6ys0hY2897qwhSNG6Eff9t9K44sy9j+HPBhE0PkT3J75b4wP0E3l2kkvC6LIsT8LST/dBvdYDCKFfcRwkTmJO0vYwNQP8QUqKEQRMR2sTGGsuyzv6pVj0gLL25S6o+gC5YghY3QcHevNn3FzVPiZwOVxVz1D0PuiWt7e50I+XOzAqD71HeVv2YknY475ufew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(2906002)(6486002)(2616005)(83380400001)(86362001)(53546011)(38100700002)(6666004)(6512007)(186003)(26005)(6506007)(31696002)(54906003)(41300700001)(478600001)(316002)(36756003)(66556008)(6916009)(66476007)(66946007)(5660300002)(4326008)(31686004)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEFVallNbERaOTA3R1B5S3ZhZTUvLzhBV0lWcDVoRlZXa1c3L1lTQyt6OE8x?=
 =?utf-8?B?emU4UTVRYmFqTVV6U29oS1VnaStSd2lOZ0VTejRuR043UnBDbkJHZFdOTlBT?=
 =?utf-8?B?U0RZaFFGWi96cHRXYUU2U295alFrcGdnWnJjRmMzVW42WllyY0RONmtJb0Vt?=
 =?utf-8?B?OXN1aWRMY1RSd1Z1NmF5Z3NOYXpYZUFrSW4zTmVOTXM4bEJrR1liclpyTVhs?=
 =?utf-8?B?eWwzQ3hMOUhXTWlpZHNCWHM0bXJlOFZFSjlYODlWeHA5dkRIMitDRUVPZ3M0?=
 =?utf-8?B?Mmd5Y0hIUmpjRnRiTjdudUZaaDU5Q1VQZWhGUVdRc2E2bFFNcThXRVlDSGsz?=
 =?utf-8?B?QnZDRVF4Y2dINjZkTm93T1h6aDMyRTAzY2hzSGR1VDlxdi9jeS9WQUVoZE1j?=
 =?utf-8?B?UjZ5TEk3Ym5NM1RhOVg4MXRqKzI0dDI1NVliL3ZBUXRsNFpmejEzbktDbW5N?=
 =?utf-8?B?alhKK3lrK2hCaVA2OE9SZW84RkVVT096UnBRMXhDUlB2VmluLytZbFB0ckw2?=
 =?utf-8?B?UVRQVFQwWmd2dFAzZ2hmekFBbzJscDRZcnNrZlUvdURuUDZmNHYzNHF3Q29y?=
 =?utf-8?B?UC8wQThGbW1oTVJHVXVsNjlvOHpDcm9Ib1l5Sms2VEhGT0JkU0FibGVidXlL?=
 =?utf-8?B?dDBuTUc3MlZJYnlxekFGUjVYVFl4NjhyUFRZTlBRSEU0T29KN296ckxpaWc5?=
 =?utf-8?B?di9wSW5PVnRVSjM4Q1lEQ2V1dDk4dXEzZmltVUdESENvS2tYWFlLL2VGSWht?=
 =?utf-8?B?VUp6dlZNV0xZeGtmS3lER2FUZmkwRmNNbmtUUHJiNXBuWDlLN2hPZWdXSEZq?=
 =?utf-8?B?NWZlWDJWM3VTOXRjb0V5SC9RREY4dDd0QzhaSWRSS2RKcHZ2U1RDTERjc25a?=
 =?utf-8?B?WlQxMzVBRURKNVUydXpKZWN1VTQvUTdSS2FId1h1blpLaWp2VUZHK1I0Z1I5?=
 =?utf-8?B?dGZsblUrUjgwTWpQSyswNHRNSGxCZ0dYS25aTkk2VklWZVdDeWxwUmQrQXVi?=
 =?utf-8?B?MzNZNmY4VndMV0RjeWlQMEw5TTFtbnYvcTIxbGU2YXZIak4xNXNKbTBJd0hP?=
 =?utf-8?B?aTZ0WUkvTVRzWXplREZZd3NoT0RJeDdVR3RHQS9WWGx5S3F4SWlBeWxsaGlz?=
 =?utf-8?B?and1bEkxbnNYb1pxQjNSdXhjVUpwUXlQTGF5V2RxbjU0ejNwc20zU0lSQm80?=
 =?utf-8?B?RmFaY3g3Z0phWGJWT2tubW5ad1EzZ2IwWjZ6VEE3d2dTelNSZkRncDI5a0l2?=
 =?utf-8?B?VWxMSjM4MEFBMnhBNVkvM2h1UFN6SnRyUUQyOXVnNVBtTzg3dGFYYXFJZHl4?=
 =?utf-8?B?UDlvUHkyNU12R1NacjFmV1VhRzErVS81QW1SWHQxVmFiditIaU9qQjdpd2tC?=
 =?utf-8?B?dWNadHR6VHJnWXZFT1dLUlhOR1ZkazE3eVEvdXd5c3BVS2pLZm5pZ2UvL0FT?=
 =?utf-8?B?MFVGNXRoNXVHd3RIV3hEajR3UXhCMnhZN3VlMGw2Y24zbk1aM1I0b1N2VWp3?=
 =?utf-8?B?SU41MFNyRE1UNEx1b3pxVGlrdDN5Q0xkOXR6THJnaGtTUjUrOG1SMmxJUFNB?=
 =?utf-8?B?cGRxR3lMeGxHTjB2ZTY5eXFrLytlZE5xdmxJMzduL3Z0bmx4Y3g0aG5DZjBl?=
 =?utf-8?B?TTd5ZnhnbXExSzFEazh3K25OSnVmVGl5UmFFZk5tV2lGNFhVVmRSWW9FQ2hU?=
 =?utf-8?B?SXJGMUx1Uy9yVXRYeGNJQjdoVnlNZ25WR1ZhQXBhcjNUQ1ptR1ovN2hGRlM1?=
 =?utf-8?B?eEpqNm95d0lIL0lpMEQ1U1EvV1kxaTRYV2pGSlpFY0s2eEptcVhDdFVhbEVo?=
 =?utf-8?B?U0dPT3hubHR5NzdlVUN4WFlONGx4Z0tnYmVIbkhuWkZmaGhNbFg4T1RxU1pT?=
 =?utf-8?B?bmJGUlBTblFsZDdJS0VzMjQ4U3JweUV1R2RESkJPSHllMnhFVTU0NXFEQ29L?=
 =?utf-8?B?a3dqNWZYQUxneHQ5NFd6UmMvaDAwZmlYZkowZUcwUm5LUElSckRzS3JjT2Qv?=
 =?utf-8?B?VFlRSHNpN0xUMnRlQ3NVMjlMdEVqQjBFMzFJamkxd2tyM1A3dTlRZEhNRlk3?=
 =?utf-8?B?R3MxRW5peENpNGNQN2NvdFpNYlVUWllNcGlxUDEvellSQUJwN1ZGcm05aGJs?=
 =?utf-8?Q?3CDLOFZx2HRoIq0jvvVHh0Bwa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4c8ded-fe9c-4997-4a37-08db79fc97e6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 06:29:59.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItJWqVxv1wklwIXNIDGFqFQ7yV6rCIijace+t78ZfA/nqZuX21FHqvSSnlIYO0PA1/mSFfl2EIsy4PVLiv3wsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/28/2023 6:25 AM, Lukas Wunner wrote:
> On Tue, Jun 27, 2023 at 10:38:54AM -0700, Smita Koralahalli wrote:
>> Okay, I see there are no objections except for Bjorn/Jay's comments on
>>
>> "But there could be devices where AtomicOps are nominally supported but
>> untested or broken.."
>>
>> Would this be an issue?
> 
> I think you said that BIOS enables AtomicOps on certain AMD machines?
> Or did that observation only apply to 10 Bit tags?

Yes, that observation right now applies only to 10 bit tags.

> 
> If BIOS does enable AtomicOps, it would be interesting to know which
> logic BIOS follows, i.e. how does it determine whether to set
> AtomicOp Requester Enable on Endpoints?

I agree this is a very good thing to know. I have followed up with the 
BIOS team to get some pointers on this. I will get back to you soon.

> 
> It would also be interesting to know how far that BIOS has proliferated,
> i.e. how much experience with various Endpoint devices exists in the
> real world.  If it turns out that BIOS has enabled the feature for
> years on a wide range of Endpoints without any issues, I think
> that would render concerns mute that enabling it in the kernel
> might cause regressions.
> 
> I don't know why the spec says that "discovery of AtomicOp Requester
> capabilities is outside the scope of this specification".  I imagine
> it would be possible to set AtomicOp Requester Enable, then read it
> to determine whether the bit is now indeed 1 or hard-wired to 0.
> In the latter case, AtomicOp Requester capabilities can be assumed
> to be absent.  So that would be a way to make do without any other
> specific discovery of AtomicOp Requester capabilities.
> 
> Thanks,
> 
> Lukas

