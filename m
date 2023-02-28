Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139F46A5177
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 03:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjB1Cxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 21:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjB1Cxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 21:53:34 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2095.outbound.protection.outlook.com [40.107.94.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AC2D32A;
        Mon, 27 Feb 2023 18:53:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAzi0B4H0H87oGU+QHUSOHcIK/0N40MTud0zhFWvNF/IBEKpocHtTdeuN6uRhnYpTJzbo+AkP35KZMW8P/sC1mAhD/2pH6NqCXCOSV1LGsLZRZkD5iFuyIHWhAlsY036W9HX4SxK+NH/XxSaQGgTix4qx+bxYY4/xhfvkbhVzAjM8vT52P/gz8zaMS+k2uZPa1GF4/x8N8/tW8h8aCBCBw6hkn9KXyJSvnkix2h2LsMjtAHZZj4jYmjjyBeO3rAMQLmCr2EIsvlcEPyZQ0s4kS3wpn6wDdSNLLOz9TfJvtpENfhUBteWsi26i4XKZjYW8TBKvqG7tqhL/hWeQuTEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrnmJ00EZUt3u9Y0j5/aSOFvRVfleBw8Pj0tvGGeJ9o=;
 b=Ues+T5rRqc8O51hlCUbqN/rwWEBmS0R5jrB9S7QEJOQSKfknM0u7d1DIO+XgN/kYk0eWUhsBdUZM2AnUF875NTDHY7xoUK5Ro7TO10xYArZ6aXaqKJOiKo9jTzajLW0sVn7b3pLcuw7RQZZEGlUxbqUdZyOO5HbSTqdZMhh4v0OCjisMGD1JMG7bzPcbvuw3Cuz+T5fydoWV+iJ5/T/Fc8qe2qWd2xKv3HovAvOFwC9x9GXgRme5NLdr+RkYh25Sam1BHwhc6HHDtXGmQ7JkqfIaVx8qDIHw/b/Qcm73FUOeRKLYWaciAr0Meb6NYOsgLk5/OREfF/0s255Wnde9+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrnmJ00EZUt3u9Y0j5/aSOFvRVfleBw8Pj0tvGGeJ9o=;
 b=TLqiww6Tot1tJpctQrs6ghHy92g4RbmyWfT5Ek1C6AOoxOCtQRR43FFZh0RWNR1Rk4gT+na1DVDDvYXX3FJWGYAUj5PVwucaWaAzXJG1egyt+aTgbpczq/INj9KwgTri4gAyGa2aNz76Rw9rqOLn7QQTUhu5Qgz0vmG48hr4bpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 SN6PR01MB4222.prod.exchangelabs.com (2603:10b6:805:a8::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24; Tue, 28 Feb 2023 02:53:27 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%6]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 02:53:27 +0000
Message-ID: <e80adfa5-b51a-a1ae-f582-58eaa4a5be68@os.amperecomputing.com>
Date:   Tue, 28 Feb 2023 08:23:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/2] PCI/ATS: Add a helper function to configure ATS STU
 of a PF.
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org
Cc:     jean-philippe@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com
References: <20230227132151.1907480-1-gankulkarni@os.amperecomputing.com>
 <20230227132151.1907480-2-gankulkarni@os.amperecomputing.com>
 <b7a71cca-8223-7346-c024-edc80a106042@linux.intel.com>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <b7a71cca-8223-7346-c024-edc80a106042@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:610:75::15) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|SN6PR01MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: f44755db-6bdd-4c9c-1925-08db1936f72c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayQHz6NESCXfAu8S2VT4O9ZFPyZCdiSOPUiaK4VVKBv0LSpGLj56Xh4HOEi520+E3559eqAckAa0+wKJ6/J2Zn4JA04YeqUwpXGZtGNWc/oGvf0iQZP9P6epnJpG0mJ7D58iSvJ8Ilt6Dre3ayw2YH/A+fXkIG13FMYfvDQh80ums7OQjbrLrNhofy7eZ7xvS2e8e9z+CFJiXgh9Lp+/sPdL79C0d9ssmfwXdI2gxw5w1KL397mICw7KWNMtFymgPbC7WiKu8aL8mRuGqKzJ9kGMAZ2JoD0NO9xKaDnHov/AEdMl0LGaxdC9+35U2AyS311UPL6Ju1tIqudyDY850uFiPu2COqT5YEfH7IdQR4JSV17ljK6f5JVjI+wHccG04H/PNT6puONSTy0ry7mU+bOoaMq3xWL77H7UxdHwm6jYsVhNKgl2zEvJRmBF36Uv8I+gdMzhHo8uQ/hGeSKAAERrCy3gf45CF5TGroo95MG4mhjrPBQYhO3apeN713NXaIKONF8uOMMeypooLdE8zOt9Xp3UiPQty8Smt+uBoxKpBAGVeMlWH6Fzeqjmv47KmLO3xN5rURNNyZhSMmhvXxEYIPmWpc3nsNup4MoL9q5Ne9TsKCVbujT0gqEONI9VRJKp6lvyxEeb8V2dz743iiNvm5TYMgZNfEiuAufeoibdCbNBt8XRVloSgUXzXUKT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(366004)(39850400004)(136003)(451199018)(6506007)(31686004)(8936002)(5660300002)(4326008)(66946007)(2906002)(7416002)(66556008)(8676002)(316002)(66476007)(478600001)(6666004)(107886003)(6486002)(2616005)(31696002)(86362001)(966005)(38100700002)(41300700001)(186003)(26005)(6512007)(53546011)(83380400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmQ2KzJmSDVrOC9XQ1hkZW1oTTExRkExV1l1K1ZPWjlYTjlSUGdHbm50MjRX?=
 =?utf-8?B?K05yd1R3VEI3K3ZoSDlKZnJ3REc0bTc0OCtwRnd6L0lSbWZlVmhuWG5jUnRm?=
 =?utf-8?B?aFNJM3daRzZna2NkM0UxWHp3YjRwWHlBOXROY2dEUHhvSkpSUTVXQUFZZjNm?=
 =?utf-8?B?VkM5TkZSYXJVT0NiYkRjY1lMYUZUQnRMVnpWdkNJaXVTeVFrV1BKcCtXYUlu?=
 =?utf-8?B?QnlxdThSYmMvUWtzQXBvUFBHMm1BNDF6bEMyMHNDN2dYSDZOSTlBQVNRN2RB?=
 =?utf-8?B?eUxWKzlwc1VoSGFBdkxHMjlMS0lkcm1iOFhTclpSRW96UWNiZjVRWXpXdTZk?=
 =?utf-8?B?WVlYM2pyUHBIRDJDRU43K3ZIMk14VW5iWEprYzFnQVUwMzlhRUw1R2hvQmJO?=
 =?utf-8?B?YzZvdTZJdjA5SFk2Wmo4VWFNdGJGb2FPSXlSS2tSZ3pXRlpJUXZqWUFMNlZk?=
 =?utf-8?B?L0hNalBwdjY0ZDI1ZnZ6czYxTzNVak41TDZLUDhwSHY2anJjSVV5dXMvSXpj?=
 =?utf-8?B?U2hFN3l0WGpidU5tVlhmNEQ4eGl1S3dqMUg2OWZBcWVzRTh5dkYzZDNaMmlr?=
 =?utf-8?B?VjdyQmZreWI4S2lJMGVHNmUvbnhzdTNYaVFhbXhpb1RVWjhjd1Q3QlYrM2N4?=
 =?utf-8?B?elNwYkd5MlhrMEVxR2wxbWpKUTZyWmJ0Z096b1dDSVBLTkxTYVo0L0xyVTNL?=
 =?utf-8?B?Y0pGMDF2Q1RHWHhtdFNROFpwM1pXckh4anRLUzNFRGs0c3AxT2RNVDUxRHlF?=
 =?utf-8?B?aFVPRTk3TVJWaUNiMU9PNVFIckdlSHR1SzV2T1FvQ3pqYlZaUkRTdzF3Q0NE?=
 =?utf-8?B?RDlHZWN2MTcrQzI1azhLRURTVW5DdkR4L2QyOHBKM0YvSU5sWGFVWnMvRGtH?=
 =?utf-8?B?SU1DbU1VeVdiRHZLekZoM2JhY3g0ZWgwUnpjK3d4Y09yaDQ1azRzaWUzTTRw?=
 =?utf-8?B?Z2FsZnVOTXVTelVMdkRwZVhhQ1NSZ3JRcGp0amJFbEZNTWRqVlpCdEI3cVJq?=
 =?utf-8?B?Wlg1RXhmdFN0eEhlMkF5bExkK1cyejhVeU1jeWJuaHFFS3h5U1dCaVBzYURY?=
 =?utf-8?B?TlFmQTZDOC9IdkF3QXAwUk5TZDE0SmRXaWZlekNDTnhrT24zaEpPVmszTmJs?=
 =?utf-8?B?NnN2ck14cjRjeFI2QjhoK2tTdVpIcy9QbzZkSXVOQ3AvYitFRUsyeFNxaEFo?=
 =?utf-8?B?NUNzZ0JLdGsyMTZzVGpnbkorTFBVbXMwSXhiOTVWUFdkTTNsUFQ3TEhNZGV3?=
 =?utf-8?B?eDRyb21oLzZRc25xRGxyZFlVV3JsU3BYaFdDLzlIK08zUTQwM21iR01UUGww?=
 =?utf-8?B?ejA5bGtYcFNubE0wNm1jdjBsNUV4WTJNWlU3cGZtMENNdWp0a05aNk1Bemw3?=
 =?utf-8?B?U2dXVnNVUkZVNXVxZWNFVVFITnBLT3FmWWN4UUFubWR6cGZrQVFDV2hsaTla?=
 =?utf-8?B?bUhyOHJDYUxoMHY4K3NqK3haSUlWYTFUWTlwRWZSUGJEaG52YVFUNHVOSTg1?=
 =?utf-8?B?d0JXUjZ3R1loNkhUcGhTV0ZFTHJHejVkRURvRjNGYTRSblFVcm9uejdLSGtO?=
 =?utf-8?B?L29RalU0S0I0R0VoN3BMSjdYdGJRY3JEektwVFZMblpjd05YdW14N1ZXYkln?=
 =?utf-8?B?bHVGVWJmMnloZXNtVEhHbGtQSkYwbC9KTHhmT0w0UzBmU1pSVDl1T1pzWEJn?=
 =?utf-8?B?cmJKaVFQYS9YSlBiUS9zVEJMbDBybFB1SXJiOXpOVlliM3RBbWViYXJxekM3?=
 =?utf-8?B?dGx3UThYbEVWNWFSRzN4ZGZtenh2Ui9CSlIzSTh0YTU5bHhGZHVsQmNzUk8v?=
 =?utf-8?B?dDRDTmp2allkTDVuMmg2ZWRENnFON3JlTTJKdnlSWTl4STVZMkR2YkhMc2xR?=
 =?utf-8?B?V2pzaThiV0orQXpuYkVleUhFTWdCcjZ5L0paUkQ3bU5qNmgwaUgzOGg5VW1x?=
 =?utf-8?B?QzRZei9VZnFJaTROdHVGYTdYcmZkS2k3NnI5eXBUdkdsNUgxdnJ6VE1SeTFW?=
 =?utf-8?B?SVI5cFFDbTBTVjNzZVhXVEFHWFpkOHE1WmxtQUZhSHJIWVJjajNlRzBnQW5D?=
 =?utf-8?B?NDIzRzA0M21aa2g2U1E1RGhwRG1HYVY5Ukh5VnUwWUc2QTBoeCsxMXBncUlZ?=
 =?utf-8?B?SG5BYVNJWllQdnorZDFrTkMvYWl4bmRwTGVvc3VSNCtITXRNM0VzR1dMaEVo?=
 =?utf-8?Q?w3G8yTA92i5W6Ztp1eUf4tTlxvKwqLNhlEHAJtvQfFK7?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44755db-6bdd-4c9c-1925-08db1936f72c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 02:53:26.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LG7SRdodLO7wm9OvJhNRA/ORuIlDSlUi/vqwAjskD2XWnD57PhLXwPlemYzXoCch/ieOkwdObL/zStQ+H19fitl1bk4eWB13+Jgj53fE4RnhYrZjKXI+1kBXyR3S4vSk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4222
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 28-02-2023 12:59 am, Sathyanarayanan Kuppuswamy wrote:
> Hi,
> 
> On 2/27/23 5:21 AM, Ganapatrao Kulkarni wrote:
>> As per PCI specification (PCI Express Base Specification Revision
>> 6.0, Section 10.5) both PF and VFs of a PCI EP are permitted to be enabled
>> independently for ATS capability, however the STU(Smallest Translation
>> Unit) is shared between PF and VFs. For VFs, it is hardwired to Zero and
>> the associated PF's value applies to VFs.
>>
>> In the current code, the STU is being configured while enabling the PF ATS.
>> Hence, it is not able to enable ATS for VFs, if it is not enabled on the
>> associated PF already.>
>> Adding a function pci_ats_stu_configure(), which can be called to
>> configure the STU during PF enumeration.
>> Latter enumerations of VFs can successfully enable ATS independently.
> 
> Why not enable ATS in PF before enabling it in VF? Just updating STU of
> PF and not enabling it seem odd.

More details are in PATCH 0/2 and 2/2.

Also, This was discussed at
https://lore.kernel.org/linux-arm-kernel/20230221154624.GA3701506@bhelgaas/T/

> 
>>
>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>> ---
>>   drivers/pci/ats.c       | 32 ++++++++++++++++++++++++++++++--
>>   include/linux/pci-ats.h |  1 +
>>   2 files changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index f9cc2e10b676..70e1982efdb4 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -46,6 +46,34 @@ bool pci_ats_supported(struct pci_dev *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_ats_supported);
>>   
>> +/**
>> + * pci_ats_stu_configure - Configure STU of a PF.
>> + * @dev: the PCI device
>> + * @ps: the IOMMU page shift
>> + *
>> + * Returns 0 on success, or negative on failure.
>> + */
>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>> +{
>> +	u16 ctrl;
>> +
>> +	if (dev->ats_enabled || dev->is_virtfn)
>> +		return 0;
>> +
>> +	if (!pci_ats_supported(dev))
>> +		return -EINVAL;
>> +
>> +	if (ps < PCI_ATS_MIN_STU)
>> +		return -EINVAL;
>> +
>> +	dev->ats_stu = ps;
>> +	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>> +	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
> 
> If you just want to update the STU, don't overwrite other fields.

Can be read modify write, but felt not necessary, since all other fields 
are at default value zero.

> 
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
>> +
>>   /**
>>    * pci_enable_ats - enable the ATS capability
>>    * @dev: the PCI device
>> @@ -68,8 +96,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>>   		return -EINVAL;
>>   
>>   	/*
>> -	 * Note that enabling ATS on a VF fails unless it's already enabled
>> -	 * with the same STU on the PF.
>> +	 * Note that enabling ATS on a VF fails unless it's already
>> +	 * configured with the same STU on the PF.
>>   	 */
>>   	ctrl = PCI_ATS_CTRL_ENABLE;
>>   	if (dev->is_virtfn) {
>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>> index df54cd5b15db..9b40eb555124 100644
>> --- a/include/linux/pci-ats.h
>> +++ b/include/linux/pci-ats.h
>> @@ -8,6 +8,7 @@
>>   /* Address Translation Service */
>>   bool pci_ats_supported(struct pci_dev *dev);
>>   int pci_enable_ats(struct pci_dev *dev, int ps);
>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);
> 
> What about dummy declaration for !CONFIG_PCI_ATS case?

Thanks, I overlooked else case.
> 
>>   void pci_disable_ats(struct pci_dev *dev);
>>   int pci_ats_queue_depth(struct pci_dev *dev);
>>   int pci_ats_page_aligned(struct pci_dev *dev);
> 


Thanks,
Ganapat
