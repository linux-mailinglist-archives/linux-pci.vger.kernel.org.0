Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01BF75A1E5
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 00:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGSWac (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 18:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGSWab (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 18:30:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED01BF0;
        Wed, 19 Jul 2023 15:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pm9fe5bqt5g/fRVWzec3T+JRpxraWkQzqqdZgDeW1PEpRMURzNh2/4Q0ydWBe7G2xPW8sJ7jP83LxmPeeW/bc0I+2JrJMpRFwMdeI3WLzGn1VTR+0BfO/Tysu3J+S960bTbTZLlTLTvZzlfoUaHLDOv005Gc9+pZTbIenRqUD8xkc+D96TwjpQLTpNzENp91rQL5Q/nqJUHgwIlhGY7XRRXI8wywMclB7szvyv6OuA2/S2KBnzja913mgfc11o/O+yRWObvhm367B9LMKns7A+5AzJMFhLa6ZUgJ80Kz1r2qbP49QliheOFrGvHe5bQZxoLMySZ6yAO5LcKjq6uezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUWpJ35fU/2NlbzFUTPd/Xhi65x7s74rsxaDDpjAGsw=;
 b=J+KWoTdwdHFV0Chtwy7Xu0pN2m2rXUFIsJ/KFkwjRCtyUiY7GInuVoSQ5FViTTwd7qcpw/EgcY8b0psD8OWT9rBI1MyVeUlx6eji6Ob2x+d305s87wN2mdEfB6NQmzdgYtFkjgjFpa34fNpz36jN1ernM19CEy9E+h+syTtvV+eq6ubgq9yRRm+M+pLmuYemFISTUVpooOs8/i8B7tSm7rnX/AZqPcG+Ie+mQcQy6k6RqkUYWxlz2ATVtr6j503gU8Ih7AigjFY/WwW1anD4TijP9TFp7gCRys30iebqf3QVvKUCSBLiYT5TfWb5nqkg+vHQ0HfmYoqOZjZSDLFN4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUWpJ35fU/2NlbzFUTPd/Xhi65x7s74rsxaDDpjAGsw=;
 b=nDBohJRi7KD/y3+0Svtf+uIi1PpzD+Fe9vb687D4bFVH6u4iEaj9w46I+EMUplaGj0GAiLxxDsy7I9xfPrNI5Ja+087c00qheJ/KTjcEGKOKNCy29rY1NauPGxvGh2Hj1SPeGT8q1Fk1XICUlyd63tWTV7K98qrAKgyseguygzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SJ0PR12MB5486.namprd12.prod.outlook.com (2603:10b6:a03:3bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 22:30:28 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::642c:a4b0:ae3f:378b]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::642c:a4b0:ae3f:378b%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 22:30:27 +0000
Message-ID: <937d872d-cbc1-3671-9c3d-ddceb9cb270b@amd.com>
Date:   Wed, 19 Jul 2023 15:30:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] cxl/pci: Fix appropriate checking for _OSC while
 handling CXL RAS registers
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
References: <20230719192313.38591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230719192313.38591-3-Smita.KoralahalliChannabasappa@amd.com>
 <53d5eeb3-5a13-3663-57a1-e927c4c369b8@linux.intel.com>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <53d5eeb3-5a13-3663-57a1-e927c4c369b8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::13) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|SJ0PR12MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: f8268f43-6b0d-42cf-ea49-08db88a7c0b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AS4DC7Uz7t96EakCFlK9GIqp/pPCDAggjC/AHLRFLZjze2aMIN5jNyDs3iSqwqY+UtdGY13YFejcZCY806fXtubThMha89FS2KdngcaVxEj/zrzozYmZEayaFqe58dbn5xDQ8OhNINbDfovgld0Y8vRte0pOShUT2RLk8PFsiMI1knFd4aZLJLZBALy/F1bmbzR2gdGIMSXs76DILGnrlrLsQvknwrMZrRwm4vadS10BJOToigEfL0jLCMxGu4Ly8PZhT8Gkja8WZaQmyKDDwXiLi7kzQ4HgAi8uXi+o0wS1PxdRSBlBZdRecMSh4QhH9EVdnrVqRi7oDATylTohjVTVxj1CkiyshlD/BAzvD11gjK+0DK56ZnRRfG+OXfpgOIfsUBIuKT7U9cta7Ff8tweqi+7NqGuCGra29PpqzUa5ykoctDtGW4nTkGnC1pRjB45HTXyucqVcEnl1ugE2mefSWrmRKcPpCWU4kMMq5WHwnA+oK5LCtxMqWSLFrUd1Wd6eiwY9UlmiqE6U7e/ikA3e3KViybFib3bq/jVDp7pvVziKQSeTNYr9ldEs7O0UCs8i5vFiU8AEofN2rdiW2TtQ9TEmqn1wfXfGKhxNx9Km71BaBPYMzYU8nAUDDiTUnnhOEeTTHYedNwU1pwvG6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(26005)(2616005)(53546011)(186003)(6506007)(5660300002)(8676002)(83380400001)(8936002)(41300700001)(7416002)(54906003)(66946007)(66556008)(316002)(66476007)(4326008)(6486002)(6512007)(2906002)(478600001)(36756003)(86362001)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2xVZDFQYURsQ2tFNHNFSW9oUDFLcEpBY3o3czlLZkpBUG01RXh4dWpvSXc1?=
 =?utf-8?B?NDdONEJGMW5xd21majRpUVlYZHB5bzBzMVZQaHo4d0sxWWVxQkptcXo5SVpJ?=
 =?utf-8?B?SUpGTTVobGJNYjREcExJNmV3WExiWERRcTRkbUpVZGtKcHY1bzEvKy8yS2hX?=
 =?utf-8?B?dGE3cjJhU3h0Q0tTSCtuOUZNbEtzbW1SVVIrOVhHMnEyMGdSMlhhVWg2ZjVB?=
 =?utf-8?B?Q0pUS2d0RTdzckliRGhJb1pDaXRXUW1OYzErZm4rR29PKzM5L0gyTldTK0lp?=
 =?utf-8?B?SmVsYThXYlM4d1A3dUdrblNEWkI3dVJueG5uUHNYQ0t6dFZBZmxrTUpVVmtY?=
 =?utf-8?B?Y3lJcEhReDRUWTR4ZXBPZzNSNzA3RWsyaytkc09VRHdacENkRkVubXZxMHBa?=
 =?utf-8?B?aGszYUUwZzdwUW83dTl1VWFGVmxEZHRIanVyMzJxSUhXZmFZbDNHL1E4eTk0?=
 =?utf-8?B?bmJaaGdVVHFSY2N6SU8wanAxU0NPb1J6SEpUZUhFSHU2YVlhaDlqMHZNbWlD?=
 =?utf-8?B?ZjlkSlNodSt3eDJBZ2x2YXdLdGxhL2JHdU5sbkc3UmJ0MGRUcElDaDBmWTZL?=
 =?utf-8?B?SVp6eTlGTE9KOEdBQWdYdW11R2NBOHE0RnVKTVlvVG1sdnNQb21QSXhuWXFQ?=
 =?utf-8?B?ZGpzb2RySk5HZ0E2UTIvcTE2azZWMEJMY3gwRzB1alN1RGM0YXdKSVNBR1lU?=
 =?utf-8?B?aVR4aldOek9DazV5OXVjZTRVUW5neTFZYlduQ0JSOGlLK2R3SmZGWVgvNXpR?=
 =?utf-8?B?ME0xWkk2ZDZSZW5JMUhLMzNQSlBIMmVpSzFPSCs2WGg3RXBmL1dsdzhIZDAy?=
 =?utf-8?B?SFhENEIvcDN0SFhLVnFVZjNWM1ExVXZtT1pGOUtVL2Exei8vbVE0dEFDaGM3?=
 =?utf-8?B?STlqV29JbGZZTGRGYWdiOFE2Z0pldUJNY0JZOHB6a2xCQmltZXYxZjV6RjVy?=
 =?utf-8?B?QUlEaUR1SzdOZUR0V0NqdnlBTzAwWWlTUjFNZHh3ZFFjSlFZNGloRGFUVngw?=
 =?utf-8?B?WDJHY2c3blBONDUxWDRZbXpFWjVadi91R0pqQ0JQd21WancwejBtbUJ1V3dL?=
 =?utf-8?B?dGRPTk43b09yb0lhMENYbm9PWC8yWTdGZU1LY3owS2M4cHNoU1VNWnUzUFNj?=
 =?utf-8?B?WkxlY1ZWRWRZcWtDaldiNXo0Ky9ZYlZWdW8weWhwZXVXcnE3aHg3ZFRzdHU5?=
 =?utf-8?B?a29XVTcwSU05Z1dXVkhQeUF4UWluZDBtT3J4TXNWUkpCQ3FsZGl6Z1MzeWxX?=
 =?utf-8?B?UmZ4WVJPWDBjRmRBWm1id3dBWkNneDE4V2M1SDIxdTVkNGs4cUpkQnFXTVIx?=
 =?utf-8?B?Q01XZG5ZZ2NiUisvWmFuMDVCTGhyckJZVXhUdy9ic2huczVMWG9uYXhrQlVB?=
 =?utf-8?B?RFJZUlRUbVVaQ3E4amloQkJNZ0k2eEU2VE5mYnRRYkFlSlZGVHF0WG1NMzJN?=
 =?utf-8?B?alZBN3FUUC9uWTRIaDFhRHpTLzkwQm9DbnpvZVZYZE1PUlhJQ1N3SFdZYjZ2?=
 =?utf-8?B?ZWFXWmJLUXFPZ2t0d0ZGcHRnK3NpNlZvRVM2WkYrNWd2NGk5U1ZxQnJMYTFa?=
 =?utf-8?B?b0M0Z2pUditseEhoVnJuejJvQ0ZLZURNQ1hTamxVUi95MEZPZlFGcnVNdFRv?=
 =?utf-8?B?QTJsMzR4YThIRlNCOWx2dUVVMU1OckNEOVhQRjc0ZUV6WWUrUklHc0xIb2hm?=
 =?utf-8?B?cTdEa2lMYTRPZkwwWWg0THMrUTI3K2l5Ri9ndk9CU3Nhd1cvUXNiUE5meXdv?=
 =?utf-8?B?MFRldnNQdFArbTBzeDJhN25aRWM0Y05KVW1vSng2WTVzelpOZWZiYVdUTHQ1?=
 =?utf-8?B?bTU4SnpxdUIvMzA1cUxlamF2dFg3V1JWa1FITlh2L014a3R4MFV1aXpBY2VO?=
 =?utf-8?B?YkNnWjZqRldWVWtUeVBVVkZtdGgvbW0wZlk5dnNRVzloWjlNdmxmUko0UFJ5?=
 =?utf-8?B?WFF6RzlZeEZtMTRPcWRCWFNxeHpNQklPN0szVE56YS8zc29yWlRIUFZlYlhD?=
 =?utf-8?B?dnhocnBBWkxha25RSXVWOTFiNUNycG9NeVZZSUMzNjI3Y28rV2NRZS9PM2cv?=
 =?utf-8?B?YXpycDFwTTZJK2p5b1dyNzFHVHoybnZzZ2J0Z0VZclZGc1R5UnZWWGpzaFpn?=
 =?utf-8?Q?LQh/xCHB570Hcc1vjuZKgIca6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8268f43-6b0d-42cf-ea49-08db88a7c0b4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 22:30:27.8412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLLvNfd02H8cseF2jgZ9wE1kLUfvMwexLSpluIaXX8ZVRuRA9HgiqH/iNFHGtL9hpFhd+UX5xNmDVIDyNuvj9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5486
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/19/2023 1:39 PM, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 7/19/23 12:23 PM, Smita Koralahalli wrote:
>> According to Section 9.17.2, Table 9-26 of CXL Specification [1], owner
>> of AER should also own CXL Protocol Error Management as there is no
>> explicit control of CXL Protocol error. And the CXL RAS Cap registers
>> reported on Protocol errors should check for AER _OSC rather than CXL
>> Memory Error Reporting Control _OSC.
>>
>> The CXL Memory Error Reporting Control _OSC specifically highlights
>> handling Memory Error Logging and Signaling Enhancements. These kinds of
>> errors are reported through a device's mailbox and can be managed
>> independently from CXL Protocol Errors.
> 
> Does it fix any issue? If yes, please include that in the commit log.

Yes, this fix actually makes Protocol Error handling independent of 
Component/Memory Error handling.

We observed that OS was not able to handle the protocol errors ("i.e 
unable to reference to the cxl device node") with native AER support. 
The reason being Memory/Component Error handling was under FW control.

Since the RAS registers are tied to protocol errors, I think there is no 
reason that memory error reporting being in fw control or os control 
should be a roadblock in handling RAS registers or accessing the cxl 
device node by OS.

> 
> Since you are removing some change, maybe it needs Fixes: tag?

Missed this. Thanks!

Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")

Will include in v2.

Thanks,
Smita

>>
>> [1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/cxl/pci.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 1cb1494c28fe..44a21ab7add5 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -529,7 +529,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   
>>   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>   {
>> -	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>>   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>   	void __iomem *addr;
>>   	u32 orig_val, val, mask;
>> @@ -541,9 +540,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>   		return 0;
>>   	}
>>   
>> -	/* BIOS has CXL error control */
>> -	if (!host_bridge->native_cxl_error)
>> -		return -ENXIO;
>> +	/* BIOS has PCIe AER error control */
>> +	if (!pcie_aer_is_native(pdev))
>> +		return 0;
>>   
>>   	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>>   	if (rc)
> 

