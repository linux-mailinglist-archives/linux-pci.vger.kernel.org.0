Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCC373B880
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjFWNNJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 09:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFWNND (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 09:13:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B452680;
        Fri, 23 Jun 2023 06:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLVFBH1pu1DWbrIzPQOdm8q9jx2LVSNPwR002xiRg/1BVFt+FeSDYeXubZZ3fK8XtWsHgpSHD5AKPjOve9nYCIa4tmDukfLxEsLzHpj8txgLZG5HUCWTyBs/+5/2w2+jl6VrWDPmIH6OoVeczA5sGoRRKe5qlwE2YjO0VNg/FK0pSyPPlwfenvCPKI9Bj/tVMZ1nntjPQbupyH3y8Qo2sfo0dCqAZfTSX3j7fJVhc+gLFTha9PZl1JaeSZ4fxWBwfa8c/cLAm5zVaKRKpim88H8fRCSZ5YnWRzbxhrIxNGuZSTmcSUaoh8BZve069ZbNuLVgs3E1lmHJCcg6isTVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WYgPGEdJ2RsLDuIPrErRUP2p0cyFqxDixis3n/ShgI=;
 b=Q6yU0Ratv/k92Bs2f2sYXNZlYMcdzIErqyX+XryilOqAWQwpHQD66ZFhUMQlZ2F2IaiBoqhCdm3rD9zJdS+f8yH24N65aw7zX8IdV1q8vieZr7dkU2RHiovx8ZHTluAtP3JqBgf5N8dYHfo3hhADHeVgmEZsKmpeTCCUltqu0HG+z1LeaZ2F5hhapivsgeFv5bGQD4AQbkTWoqsonQJORio7KO8UidFTQt9IsDoYHozME0dUlo71IKdd+rxxIK1ZpefdbxkvvOCkuiAugqPd5Eqm+efBPF1/W1W3SEokCNMzcHII7A4iEASEyAfa3gci8qSf9y+/PKZySAi7JkpbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WYgPGEdJ2RsLDuIPrErRUP2p0cyFqxDixis3n/ShgI=;
 b=Solo5IvDJNKQaGBnTvV3tKJ+7hcjoJhwWiktYCzpPgJeM7epqcQV9ywiGsnfhS3t+xItGpV9MeFMXnfijbCq1oNJ3xcmbuvgjvlDPy7hu6iPwBll5vdhleE96+Ht0075zB49dqigqqib90oEa2iVxSBcCzHMGiUAwE+RYV8HCVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4599.namprd12.prod.outlook.com (2603:10b6:a03:107::22)
 by BN9PR12MB5274.namprd12.prod.outlook.com (2603:10b6:408:11f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 13:12:57 +0000
Received: from BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::193c:7a54:320e:89c1]) by BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::193c:7a54:320e:89c1%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 13:12:57 +0000
Message-ID: <75aaffe7-f1f5-fd14-8a56-633a8065eb6f@amd.com>
Date:   Fri, 23 Jun 2023 08:12:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-3-Smita.KoralahalliChannabasappa@amd.com>
 <20230622063105.GA624@wunner.de>
 <d64f8de4-cac1-ccca-33fe-1fda418837e2@amd.com>
 <20230622214247.GB11993@wunner.de>
From:   Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <20230622214247.GB11993@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0415.namprd03.prod.outlook.com
 (2603:10b6:408:111::30) To BYAPR12MB4599.namprd12.prod.outlook.com
 (2603:10b6:a03:107::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4599:EE_|BN9PR12MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: 54550897-21c8-47a0-9ad9-08db73eb8fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6kI4nfN7skAli8D28KsWpZCCoAfXZt7NfuorVbgUT+5PElg8ULjlp39JSxHTiQJ2LipJm4uebFPAEpWpVtifgMUxhSV2W+xpFEIE0Mpy5YaqF+dLey+nIoXOL++ELL+ysV6BNkwU+ZMd7fcABJ7QvmnZv16fs/xxpTBdiCbMur75Dr7fxdqma24rif7C1RmzNmQQ5rwwv/grmV/D2s7Ala2i4L9EXst7l2+dy7zVKBjMxqgRFh+DVgkJUfSWnChnDHivssWdcZ+DNCoBv+InFBL0uD0wAmd2pAkkzPe4evI6JfZKtaZk1YlSkuTzqIC6Si6aYK+/JXgpk7rHYdEuVh7D420MHZ4gBL+ceq97K8mFWR3LAuq1MADfpWzNseWbbvDCi0t9dfpjOIZq7p/GZQ6N/9KAF9zEBBSWXty59vPXFANmUnWLtbpLX9nDJBFopzdHVwfqrQZuNkAlJNi+fNlxVQNBcKaJFC/fMHP0Vyn9HMFx/MhPT49NsteNOeVPfGdLRUs+mt5bK0TCao/OF5jPDF4RixGc/+Abh0++TLtIeqCDQXSZd8JjHkYzLPc/EpS3KMMGNdEhzgsWUXdN0fmDMTxG6QWkSLDEZ53XX4Qpow0qFhNIa4YTQEt1XiWDGPLXe/78npAIMIh+a0mUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199021)(44832011)(5660300002)(36756003)(8676002)(8936002)(38100700002)(2906002)(478600001)(6666004)(6486002)(186003)(31696002)(110136005)(54906003)(86362001)(2616005)(26005)(31686004)(53546011)(6506007)(6512007)(4326008)(6636002)(66556008)(66476007)(66946007)(83380400001)(41300700001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFZCbzdQN052M3BZaWhjeDl4cVV3MXkyTjl1SVVZWHAzQ0lYNzExemhSc1Vy?=
 =?utf-8?B?VXJ0YnBoNlR0MzhDQWZ2eHp1U3g0NnlPQklURGdTdVBwNEo3d1hUS0UxVFhx?=
 =?utf-8?B?Q0pQUlV0VmxMSDVpQ3gvNERIY2Jqa0xuUnp3M3FDU1JpbExOZFZaYkorK2lj?=
 =?utf-8?B?MlBQQmFFSmF6QVdsVCtzRDVzU0NDU21SVTFRaythcWEvMjY1cnJGQU9qYlFP?=
 =?utf-8?B?TkcwRFpQd3hLdldENitodVN4WEorSFFYcTgvanNRRUZLQkdkMGQ1RVZ6T1Bw?=
 =?utf-8?B?anptUzJzMStDbEtwcVNSVkFwTDdPdVp2VHZDZ1JFSFZuMC80Z0luTGZLWHVI?=
 =?utf-8?B?aW5BQzM1M3NrYk9WVUJsU2JDQmdLWjRBT0ZDZm5lZ3ZJQjA1RXhGT29ZUVlL?=
 =?utf-8?B?VGJSWldpbE9PMlZFYUkraU1sNXA0Y2FaSFB5cUJ2MWlHQm1kUU1ZWWZvd3dK?=
 =?utf-8?B?MURYQmNaOWdBbldIaU43UUNtWGhjZy92WG1PdG1LTk9pVFZ6cStqcFEvWGVX?=
 =?utf-8?B?NUZhQzBheWQ0YkUzck94VGdaQ2trMjNqd2UvMVk3MWdtK3BHUURyR1ZGR1VZ?=
 =?utf-8?B?dGxhYXZBUjlPUmRjZ3h3SDdrM0pDV2FYNGROSE1nSVFoS0JHaEE2b1hIYVl4?=
 =?utf-8?B?YmVHT0h0MzdoVjZ6WDFKakxsVVpZaTBtNW5pUlg4UDVTcklBS1p0azNwTmxQ?=
 =?utf-8?B?c1JUckwyWERkaXhkUm5HQkR0aEVrTE8zRVVWbytZMUdncFhFaTdxWTk1WGFw?=
 =?utf-8?B?RTVKd3k4bkhSYzhvM0h4UytSKzNsTy9uUWxnaks5b3I0Zjl4QktLdjFRZUw0?=
 =?utf-8?B?QUNpRjRyZStQZmN6QmdDdnBPS3V0c3QyR2FXaHR3aUsyVENVdlpVZEErYXJ3?=
 =?utf-8?B?UG1qdlJ5UG1OVDRtbzNndWdpam5uVUN3SnNzVDVsWU9pdW9VOG1RaVRIbm84?=
 =?utf-8?B?Mk1kdDROeVVMSUZwcUdTbU16Wnd0VDF2LzBwT01sZlJ3Q2Ztb1FpdjhSTHBD?=
 =?utf-8?B?a2JnbEtSTXI5b3FaN25FckFCRXdKbHhqY3hVcVVpSmZmaDIxa1UvK2hZYzU0?=
 =?utf-8?B?ZVdodVEybmxvb1hqcDhMWFFkZ1dmcURFTmJrSHRxZWJudjJGcG1qKy9pNnh1?=
 =?utf-8?B?SVlNbkV6aE9GQWM5bUtMVUpFeUhLN3o1aE9mODIxOUlLUGxncnlrdXhtVHA0?=
 =?utf-8?B?WGxYY1JzenAwbXJ6TjBDNjR0K3NBNVVPTytvdU1UVG9LVWtKc2FSNTZCTXNs?=
 =?utf-8?B?b2t1MkdHU2RRMlRINHFDZyt2TVVFYldYelh3Rkh6TnhjbURiMXFkQUV4VHgy?=
 =?utf-8?B?emc4YkhQcldwV2RzK2ZwUFpKL2JpNGRVc3J6aGQwRDFTR1BmSWZnZjFwbkwx?=
 =?utf-8?B?djAxN3p1Q3NFaWFieXh2MnVnUDgxRndmVmFKWFlEcmpmRjdob01HLzM5Yzcx?=
 =?utf-8?B?Q1NqR1pnQ3NNcXBnRUVFVm92eElhZW5mclEvWUxqenZuSi9OSE92ZXUyTWVR?=
 =?utf-8?B?dUlkTG1CQlROZ1pFSVZLQjRLbmp2eFVwaGpxNVhKclQrQS9ZMXF1UnhKazhv?=
 =?utf-8?B?YXY1N1pRY0dLU1hibkVDeDRpT2l5cGtMLzBrZ1NXMThCaG1lbWc4MWdJdmxG?=
 =?utf-8?B?cEp4dlpwaXR5NnowZjV0OWMxQnR0SkJyNGtBK1hVaTZuU2l0OTlBK3V6R2tN?=
 =?utf-8?B?dEg5WFR6YUo0c3dlVU8wM0xKODNLWm41WVpuWjlJd1Fuelcyb05xcFN3N3JY?=
 =?utf-8?B?U3M5UDljYVJDSXlrYW9wZXI5YVBnN2tLV1VJZVU0NHZ5d3pkUytXc01OaFlp?=
 =?utf-8?B?THFJdk1VZDA5RE9NWmN1SVVRTi81VE1TeWk3RXVoZ1lpOTNiUENMZ05JWnky?=
 =?utf-8?B?enhwdENwVXpQRGdjbVZnMTlhd1RMK3pOVVJKVHFLYzEwektQbTZzK0RYM1Vv?=
 =?utf-8?B?VXg0MlJXb3lKMzBMVkUzY3ZVSzBLbnJNVkhCdWpNVC9KSlF5U1ZwS3gxMmc5?=
 =?utf-8?B?Mjcxd2dOZmxqTG1Fd1FvTkpJVm03QjczOFV4bjRYaVh1NXJNQk0wYk5BaTc1?=
 =?utf-8?B?eEZxMEl0YUd6WENrU01TdWp3bXd3SlJzelhEZ004TUxUYlArQlJ3amF1Y1M1?=
 =?utf-8?Q?tikne+cI9b/wq4oPy1Jk+3NiG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54550897-21c8-47a0-9ad9-08db73eb8fba
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 13:12:57.1224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMr0bfH0ICCIo1jgh9Dy8IgIBdQ/feg9XfNe0iTc/n++eK+RV6xsAGIXLBDiJEqkbiplghcQ058AJEQmWJ1LaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5274
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

On 6/22/2023 16:42, Lukas Wunner wrote:

> I don't now why commit 430a23689dea, which introduced
> pci_enable_atomic_ops_to_root(), chose to add it as a library function
> which is only called from specific drivers, instead of universally
> enabling the feature for all devices.  Adding the commit authors to cc
> so they can chime in.

IIRC during the initial design discussion on linux-pci this approach was suggested to avoid triggering potential bugs in devices without AtomicOps support. See quote below.

I've no objections to changing it.

On 2016-05-06 10:48, Bjorn Helgaas wrote:

> Once enabled in Device Control 2, a device's use of AtomicOps is
> competely device-specific.  In many cases, the device probably doesn't
> support AtomicOps, so enabling them would be a no-op.  But there could
> be devices where AtomicOps are nominally supported but untested or
> broken.  Even if we didn't change their drivers, those devices could
> start using AtomicOps, so I'm not comfortable with the PCI core
> enabling AtomicOp requests indiscriminately.


