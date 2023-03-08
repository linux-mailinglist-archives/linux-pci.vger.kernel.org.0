Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D4A6B021C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 09:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCHIzO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 03:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCHIzM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 03:55:12 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2122.outbound.protection.outlook.com [40.107.100.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE0A91B44;
        Wed,  8 Mar 2023 00:55:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chsoZVB0kSWUf91M0yobUjuOQSZ/568YoP90SqAKOILcd4ajWZtDOENnkWfcSREvScGbmoliHqEW5p1ZYNFEWrViZyWZHJsYxxVyLxd0LWKx8qzXlwuOFFLsIUSTSNXiOBmGeYcTpmEuQXq6eh3JCWsJNYqyj8i6ZKqQqmp0QQbSKC0ZtqNnrI8D6XtbdG+MaLA5Qh335Fps8HFrbknBTQgqw2vqII+2+hd7vMYmM5KMjQ5Bmjw5pqVElZvVW6GRWkir0ZLoUejKdAge9NuNEr6a1PnBb1XVXm48ngjPQ4/XooVdQsNY87d8rjLVmCLBIZXOa5ScMiRePjci4V29yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVt3OY0Z8Nlqon4Aq248KjNwd7WV255SmZJpA/bFggc=;
 b=djHUymyPXfTAugc9LsFvrXgpOX7N418KJ4wyncTHy5hASS4m8SGrj4tlaqcnKKn3NPPN5EyvoBaZR0uZvd7oqTthsO197BVZkNCGYgExZhZDOQV7Rdrs8h8B1UDb3EUq97/yOJFeNRf3y7scKNojMG2t3+V25Boggh2IGVDp7wczTIQTAcM37YH1vFbowAFr2QY4voPSrZMOdB3rZmOIFFvCSSEK/UunFPW71SDU3THlOFMTttDCspMxufShgLWwgRcq4n2RA9fo2TAcPLfHc+SmXMq10F70D0XTE2G+QO8QzxNulEoxOviLKdVZtZnY7x6ej+1A5J83oeBecI4otA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVt3OY0Z8Nlqon4Aq248KjNwd7WV255SmZJpA/bFggc=;
 b=YoWQHXu3FFIDLXUu/ucmVGFTCmylzoRQCVEHSK8xjYJJTpEKWIc+kAgwmTgNYFzdihQlJWo1Pk0K6Omfu8mmxVwT6G4h4ygsXC5brUSpKQIZ5JlaRCLMeHuEWvXH6vrm8FIzKx1s3vXXyTZ0w+O1xJKs8MGQAEOZXvs/xUcG2VY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 BN8PR01MB5428.prod.exchangelabs.com (2603:10b6:408:ad::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17; Wed, 8 Mar 2023 08:55:03 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%8]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 08:55:03 +0000
Message-ID: <6a3f9545-1e59-982a-c3c9-8d13a7de448a@os.amperecomputing.com>
Date:   Wed, 8 Mar 2023 14:24:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] PCI/ATS: Add a helper function to configure ATS
 STU of a PF
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org
Cc:     jean-philippe@linaro.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
References: <20230228042137.1941024-1-gankulkarni@os.amperecomputing.com>
 <20230228042137.1941024-2-gankulkarni@os.amperecomputing.com>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <20230228042137.1941024-2-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:610:53::31) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|BN8PR01MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcfa3e4-53ed-41f4-d5fb-08db1fb2ce60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzI9EjawX8kh7NcMC6tk7QjVcDcYbfJoDpxg7F4eW8kl9HbbZkPAEevS7gOAlVWDAgmouu/JWcRTO4L/OE9PFvhXPiIdO5Ob95w+v51H6vUD4hmDlolNgZmMgdbnqE5O9/Oo5LGbHceAsuKtr8ucNbmyix68hvJmg5F54/MyIyfpRc0KREAupJDpl8BqsiYQgOCi4To7dbCOGB8Ez+8zE6RQpeXXeItCoa9rUqtOIVN/dxB70NsOABTYhnsggYpiV+dfK0n2AdQO1QJDWK/UPhENMqzJsPmBGR41jsKrHylZPqNlECqhP3eguVBdt9SJ4gFnz91DUiU2yL/oE5EqyjoSN1hTzdJHzh4WWjbx5rN7n6L1xchZrBeDdoBtNAth1XVB48D0kWrUrkX1GgN1kf91AMq0xMCE14hwmlvVxDg1EcxOEUXLVPtWtOlaQ8yc555JchAG7jEoCuPVDl544xDzOXj0cKnmiGhlD05h2+VvMAv+ZIONRVZxntZ+veLHNnW3iCTpOeR9Gp4z/gX9BiNNmke32Bx1eEP6TvaUB/sN/bNeeVUKPlEIiQjzOsJAg341i+l5dymIeYPHmRMsGEq0wP6p4ESclUO1HKMYZomQOjUNfll/VnDlpIkZoozNRPN4wld0jsQKJk12aqSzbkP6rNHJ6NCcPruoF+xqIkeFDn4mCzRMwgzpbtudN0Q/cHF5fDUx9pHZ/1Q5kR6NmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(396003)(366004)(346002)(136003)(376002)(451199018)(31686004)(86362001)(38100700002)(31696002)(83380400001)(6512007)(26005)(53546011)(186003)(6666004)(6506007)(2616005)(316002)(5660300002)(7416002)(8936002)(478600001)(6486002)(4326008)(107886003)(41300700001)(2906002)(66556008)(8676002)(66946007)(66476007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDZQTER6blc2Mm54d0ZERW9SdTkzM2dmNHJzdGxrQVQzcXYxZkJuSmhEZjhv?=
 =?utf-8?B?bkRYbFgxcUM0dEc0Nnp6WkRNUUJwSTJXMHNsczQ2QkQyT1g5SENwQlBvNWt5?=
 =?utf-8?B?a084YU9McXdoSEdDRGp6KzEvTjU5VTZ3WllHcDJ4elIvSDh5aXQ1amx6azFE?=
 =?utf-8?B?OE44VUxBUzY4bzZUaW1yc1Q5TGUva0lNQnlNdzFYT0lGTVkvVDFnQ3FhZ0pW?=
 =?utf-8?B?TTU0T093eFVVL0JwdHd4Wms0Q3cvTmJrWG5xNDVhbnhmYXYwUElvMmxVZkpu?=
 =?utf-8?B?Tkttb29OV24waU1rclhpeGE5a2lvOXFVUFJ5dkxDQUlodGJyZGNSSFkrZ1Yv?=
 =?utf-8?B?bGl6cDhtN2dxZVhTMjByMHV6RnFldHk5SS82TTg5UHNRUFV3czRDaGI2MGlj?=
 =?utf-8?B?cVpJSm1wdi9lMUhGa25xbkVkZHZ2Vjl4clRvT2xYbFF3cXRWNHhYOVNXWm1M?=
 =?utf-8?B?TGZlRGVwR1pPWWFCOWtxUWU1cUdwak1XeklUaUN2ZmZKVDNDSEp3WHJIS29J?=
 =?utf-8?B?VjRzSGh2YzVkNzU0a2ExV1BFb3JzcWtkYm9raFBpTC9uWmlhSFhlUUNhYzFL?=
 =?utf-8?B?VTJ0MnIvcXNBZHc3RmlsL0ZVQmd4bVNGbjBxdk52ckVaUTNEbi9jTlYvQzAr?=
 =?utf-8?B?cFErL3o5SWpsamFVZXJ3R0dJSXA4VkhVam4vNzkweHZNN3JjZHIxYlp3dHpH?=
 =?utf-8?B?a09tQUE2L05JTmRLQURsM3ExYmEwczYxbWJLZ0FCM05kTUcwTHdoVmplSG9x?=
 =?utf-8?B?dFZpWTFmSXoySmxRY3hCOEN0SlN4TUtmbVYydE9SZlVWSW9EWFU5YytId3A3?=
 =?utf-8?B?VmVhZW11TWk4ckk5TUJzSXZUdS9ITEhiemk4aTVIWDk2WlhsMDhZMkVQN1B5?=
 =?utf-8?B?Z3VxODRUMlRhMVJ5aEp5ZDdDTkxYdXpsNTBlRTBCOXl4U0FBWjE2c3VSZFll?=
 =?utf-8?B?QVEwdG1KRnhoRmFZY3p4cW1ZanVaTWxZU2lhN1NuME4rQUs5OGRZRThGaHdY?=
 =?utf-8?B?Y3d3RnV3T2czMVNiRVJvUGw4ai8yc1VQSDZWa056bWNhNHdlSFJCVXFYWFM3?=
 =?utf-8?B?cUFySWU1eVA1NDB0R2tKNmdvTllZWmFMN3haSXUyazlaZ0tQbXlCcHRMVVpU?=
 =?utf-8?B?Y05xb1VmTXVGcGtmczBuVkVOZUtkT01XcjRSNElTRTR0dUJXOHFVcTFabDc5?=
 =?utf-8?B?eWovdk5IcE95bDZuWVR0VmtoaXpNQnAxOUo1VmpmYjNtaDVneFl2MkNIdnMw?=
 =?utf-8?B?UkxSYnorbW9xOFNvMUw5RFlKUk1ndWE3M2llREdVWWlWdXZnLzk5V3pUMW1t?=
 =?utf-8?B?ajZTODV6Y25GNTNjNHFRZ01qKzhOdE4zeEREVisyQTZuUEVXWUE0OVVLQzg3?=
 =?utf-8?B?MnFGeDdTR3RveGhLNjBXN0k5alhOcldZdEpuOC9rOUV4VDRMV3VNa3hQUHpK?=
 =?utf-8?B?cE9kQ0ErODlLZ0xqK01JOE9wanlwVjhJMWQveW5NK3YxOGZDaG53bVhHK0V2?=
 =?utf-8?B?b1hpbnhjbFBFZEFKQy9BaDZLUDJOQjFwcTJ3eUtQdFpBZXNzZzlaZTAwaG5V?=
 =?utf-8?B?TUdRbURaU1JyOHFEMnBOb2xxZ0g1R29yOTc3cVY0QVZSRzN4WkYxMkhydGZ3?=
 =?utf-8?B?Um95UENtNFlrSzJBK2VWSHZYVmIyY1lkdlUwNlNTcXBzelpSb0RXWGRia2ZI?=
 =?utf-8?B?bjI5akJYVGRBejlNMFVRZHJlRXN1cmkvcVhuQjQ5bDFtT1BhNWtjUThvZ2lO?=
 =?utf-8?B?bzA0WFUwMkxRcERlUDBTODBjV2dKN2szKzhjMGtPOXhpQVUrekhsNEVySjBU?=
 =?utf-8?B?c0RPRGo1UDVIRmVNeUhmcWM4MnZGWjE5YjdyZjlxTThiWEdHUHZBcnFITkV6?=
 =?utf-8?B?d2FpSFdSVVdYWXZYMWRFTlhVaWVYTlZpWlVSWk5xbVR2VnJjdys3SDh2bWZr?=
 =?utf-8?B?dktIaFFvUS9nd2x5aEt5QXlnV0ZPRlpZUUNIODZCS2tmbUxkekV1VU5maGRh?=
 =?utf-8?B?MUE1NDc5eVVwVm5nV3h6RlkxTHM2djRqY2gyTUlVTlFDanZURHQ0Mi9PRnJS?=
 =?utf-8?B?RlVqaERYemdIUFQ2d0J3UDdjWmV2QzdzUUx6UThycW8xRU5ONm40eGhvQ2Fj?=
 =?utf-8?B?UE9jakZENWhrdWFXOXVjYjFIcC9mSHlmMDl0VXFaQkR0VkhEUk5BMWFic0tF?=
 =?utf-8?Q?m1QtLQH9vmnVdc4UKT9oFCRdH8vEH+SHwkHOERLn/ZQV?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcfa3e4-53ed-41f4-d5fb-08db1fb2ce60
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 08:55:03.1399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GPK284qG7nlOzReFuDxwzX3K/fExqQ9sSkhOkeblU/KaHuZqzrXp6QVYcx0sLaphAKK1VUr97SBB8ywAA8JYkuOiWSGztWTqSMIrKGBhnVbSrC69EHqzoPR6QQv88JC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR01MB5428
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Bjorn,

On 28-02-2023 09:51 am, Ganapatrao Kulkarni wrote:
> As per PCI specification (PCI Express Base Specification Revision
> 6.0, Section 10.5) both PF and VFs of a PCI EP are permitted to be enabled
> independently for ATS capability, however the STU(Smallest Translation
> Unit) is shared between PF and VFs. For VFs, it is hardwired to Zero and
> the associated PF's value applies to VFs.
> 
> In the current code, the STU is being configured while enabling the PF ATS.
> Hence, it is not able to enable ATS for VFs, if it is not enabled on the
> associated PF already.
> 
> Adding a function pci_ats_stu_configure(), which can be called to
> configure the STU during PF enumeration.
> Latter enumerations of VFs can successfully enable ATS independently.

Any comments?
> 
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
>   drivers/pci/ats.c       | 33 +++++++++++++++++++++++++++++++--
>   include/linux/pci-ats.h |  3 +++
>   2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index f9cc2e10b676..1611bfa1d5da 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -46,6 +46,35 @@ bool pci_ats_supported(struct pci_dev *dev)
>   }
>   EXPORT_SYMBOL_GPL(pci_ats_supported);
>   
> +/**
> + * pci_ats_stu_configure - Configure STU of a PF.
> + * @dev: the PCI device
> + * @ps: the IOMMU page shift
> + *
> + * Returns 0 on success, or negative on failure.
> + */
> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
> +{
> +	u16 ctrl;
> +
> +	if (dev->ats_enabled || dev->is_virtfn)
> +		return 0;
> +
> +	if (!pci_ats_supported(dev))
> +		return -EINVAL;
> +
> +	if (ps < PCI_ATS_MIN_STU)
> +		return -EINVAL;
> +
> +	dev->ats_stu = ps;
> +	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
> +	ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
> +	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
> +
>   /**
>    * pci_enable_ats - enable the ATS capability
>    * @dev: the PCI device
> @@ -68,8 +97,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>   		return -EINVAL;
>   
>   	/*
> -	 * Note that enabling ATS on a VF fails unless it's already enabled
> -	 * with the same STU on the PF.
> +	 * Note that enabling ATS on a VF fails unless it's already
> +	 * configured with the same STU on the PF.
>   	 */
>   	ctrl = PCI_ATS_CTRL_ENABLE;
>   	if (dev->is_virtfn) {
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index df54cd5b15db..7d62a92aaf23 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -8,6 +8,7 @@
>   /* Address Translation Service */
>   bool pci_ats_supported(struct pci_dev *dev);
>   int pci_enable_ats(struct pci_dev *dev, int ps);
> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);
>   void pci_disable_ats(struct pci_dev *dev);
>   int pci_ats_queue_depth(struct pci_dev *dev);
>   int pci_ats_page_aligned(struct pci_dev *dev);
> @@ -16,6 +17,8 @@ static inline bool pci_ats_supported(struct pci_dev *d)
>   { return false; }
>   static inline int pci_enable_ats(struct pci_dev *d, int ps)
>   { return -ENODEV; }
> +static inline int pci_ats_stu_configure(struct pci_dev *d, int ps)
> +{ return -ENODEV; }
>   static inline void pci_disable_ats(struct pci_dev *d) { }
>   static inline int pci_ats_queue_depth(struct pci_dev *d)
>   { return -ENODEV; }


Thanks,
Ganapat
