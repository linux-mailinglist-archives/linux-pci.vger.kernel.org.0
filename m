Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ECD7EE71E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 20:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjKPTDG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Nov 2023 14:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345464AbjKPTDE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Nov 2023 14:03:04 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2103.outbound.protection.outlook.com [40.107.237.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D47182;
        Thu, 16 Nov 2023 11:03:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaSIzXQTXiSD8AyJjrv+kX+n+CzzInWnjZ8tjLI2hjrMcsXta978XLc4n3eZPKKl5lTzUOTe7ICUX61cyCQr6wyYeo7UqWxafsvK4gwhd90z/7fzWTaKZiLloFppqCK4ovQQzS+XjSubzm9cEV9jY3t2UDGU3+1QviEFglYB7johWpKTvH3Fb0r5nH4hyqROfwM95ZTu5VYqs96NO9hjxcBpcKNyW/tZ0/evMC1oAcx2vRECHZPh8WtISkOAZvSW/2OU2zkMQmFRF9lcxT4wbWS3x9k//4PqNGmq0xzWNJfkZyCODUT9dZUASHECfS/JPAcsJVz1iqT8slVggiR6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR1vBSoWjSkjZiPQcGzLRNEIK4dqKDVbimxtF8tHx+g=;
 b=h/uWprszvIMfzKG6Q1ltRPVvz3++klqPzPSd7u+9BsX2TII9KWbKVcjhvKrZQgwJ5Awq10lQegPv96BtKIZA1n1P/sxKAW+iiEnZ/Bw2UEVPwrnuxHfojc5i731or2XIFCP8f/zV+emhkNU/hhrEv0hOnxhoXXfhBujyvxamIKUaAJ8VLE8GIYUyWWyxxUz670WaKFDYfUsq4amwy7Bslz+R4YUoxK3lEtVGyHbJokLFr4HoLSNuLVxRSrD16aTP/H4+kQPm3Meu53+x323apsnDUJBEpSdPv6T16DUoahUiR0cr2fc+un2Wur6jw5WPw21CSrKMNO/Z9v5jrg/Xew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR1vBSoWjSkjZiPQcGzLRNEIK4dqKDVbimxtF8tHx+g=;
 b=nnN3una78BBDoGcy0SBqe7miVPIVolf0AYwhANuuERi7wxyeqcldCDD7n6bTXvCCAIuCIgfWxfrSqO4HxxDQHSfsWsA2aSZDO8WtqYs9BF88xSuMHfkxm+jPCMx//p9iC7vw1U20KwFZur0Q1qxTopKEZvUbs8hZVJkzlpEByCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 PH7PR01MB7872.prod.exchangelabs.com (2603:10b6:510:1df::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.21; Thu, 16 Nov 2023 19:02:56 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 19:02:55 +0000
Date:   Thu, 16 Nov 2023 11:02:20 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        kaishen@linux.alibaba.com, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, chengyou@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v10 4/5] drivers/perf: add DesignWare PCIe PMU driver
In-Reply-To: <7e383d7f-8df5-4d49-a45e-3dbe23b2c925@linux.alibaba.com>
Message-ID: <f18a97f0-a629-21c2-a772-b098262629e5@os.amperecomputing.com>
References: <20231104133216.42056-1-xueshuai@linux.alibaba.com> <20231104133216.42056-5-xueshuai@linux.alibaba.com> <32626689-c8b1-9bd-b00-5285c633bfbc@os.amperecomputing.com> <7e383d7f-8df5-4d49-a45e-3dbe23b2c925@linux.alibaba.com>
Content-Type: multipart/mixed; boundary="1372433909-1814920884-1700161374=:2081"
X-ClientProxiedBy: CH2PR05CA0027.namprd05.prod.outlook.com (2603:10b6:610::40)
 To DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|PH7PR01MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a0560b-e0c5-4d4a-bdaa-08dbe6d6a42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngZme1KbaVFhYuCLGAkHGiWe5GvKsDPTd8+TRphDFT33amBUVU/jsu9leky0H8H/kmYzMpaQm9Q90QxINGX6FzWNylmlhDHwQNnRsLJb39aLT6gYmANBzGARmyr6VemVmG1ZprqLDb9UBiPBC0w3/dh/iKWucCZ0lNFSr/+kJnhDVtLeUEWPddDPG4qQHFg7HNWuyKjQqwQ+LsMpeudyB2qtXFO5oObJz8yLY0huksW4w0KO6LWYYnXWm26ncK3XmO0fRnO5nkZExpwx6o/qulXbcUYyVojhXceGMxae7q9i8Fh8eOYlNj5IHXLxtY/jhUwHtyss8xg4a/n6U9RO/OqTFD/Zdn4Hw3bPCXOlmVsoTZIwH5kINuTOt90lWhEAHqKEKCkLNVAAzKJvohOrkJ2gWpqhjM/CkOqfsYzgU8NznD6iJ3xo3IM1TFIiJS/2HWkmBLATdyuoyaw4fWPHeWMU8fwSBifoBC42zbaLAHMZXpdlgEcekJQnrkez9fS7SPa+tMRmZw1Fo8okhJsbn2EQt4kcFl1y+XmKntKWs5ZEW//RGjzeBnruSz6uVN6MPHfYEUW+DhvxEn/GAsyPgHxEV+GzHtfkj860JbKy6Nxzyh9CX0DzLrBq20Akt90q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39850400004)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(38100700002)(31686004)(31696002)(86362001)(7416002)(5660300002)(4326008)(8936002)(41300700001)(8676002)(2616005)(6916009)(6512007)(316002)(26005)(66556008)(66476007)(66946007)(52116002)(53546011)(33964004)(6666004)(478600001)(38350700005)(6506007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGZZVlpjSCsyVDZjSllSQzhNNXROemdXKzQ3RDVVSFRBNFUvRG5lYXZxRno0?=
 =?utf-8?B?dUVkMyt3NWI1cHZLaGlyaEVLc0l5UG1zOVdudmxTa2NGc1RvNzR6QnlXV0Yx?=
 =?utf-8?B?Nzc0VkxXczBoRFFGZ1BrOGZ4KzllcWhQMnJudi83Sk5NRTZaaHRNc0dQMElq?=
 =?utf-8?B?L0xqbzdUZ0dmTk0rRVV6cHIzY0xFeWRUenRFanNhL2FtNkkrNnBEZWtTQWph?=
 =?utf-8?B?cGl2V216dU1XWFk0SzBVV1BOZTRjcWNvSnBLbXJ3MzRCNUlyMEkzMjN0SkNR?=
 =?utf-8?B?UThSN3Q4VUs5dWZNZnJ6eldRWE1QZnRYbE5QNkRLZmxFd1hxT01KbzF6YU1O?=
 =?utf-8?B?VlVCeHN2Q0ZOL2VnSlJxVVhDd2hYaVVySWVqclRJenJWa1pLT1JBYjFkTUsy?=
 =?utf-8?B?eFdKSHhkbUxmOGZrSzNrWkRJZkV3UlIvNmQvNXg0SlVtbEplTkNlY1N3NG1R?=
 =?utf-8?B?SnZycDJMcVp1ckVVa0NJT2NiamZXa256MFNWajlQZmxFRmo5aUJQNnB4ajlJ?=
 =?utf-8?B?T1o3SFBGS0I1NkFGYUJ4T1dUSzhBM2tXd0drNFNDdFBMN0JHNGc1TjJodDRa?=
 =?utf-8?B?OVN5QnJpelRyQUo5NnJSV0toL2dDa3VsejdTa1IxZXRUSWR2dk1WWEdNUThD?=
 =?utf-8?B?WVBHYjZoZklYMjdkS3A1NHFIVThLS2dyK3pWUUorMCtFQ0RZb0R1cEwyaFg4?=
 =?utf-8?B?S0lJMm9SM2RPY3I5QWFZVDBlZyszYzdxVEJtZFI3SGM2dm94UVF6cTdyZDVh?=
 =?utf-8?B?UUVCQjcvMi9WN2l1K1FwZWxnRHdVR085VU5nS1NNU2JQYWNLRW12S2oxclNk?=
 =?utf-8?B?MWFYdkFwN3ZWdkV2cmtQd1VsQW5JeUlialUwSXlMWWpkYVNRZkgzN1crK1Nn?=
 =?utf-8?B?eTk2cHdEeFRhM2gzakc4WloxT3NHSG9ieUozWGdsZXJPOFpyTUFTYTBEYjBy?=
 =?utf-8?B?NlV6MzkzL0JIcmRxU2didE5NNVRsWTM4WEFHdCthWVRqNDNKeHB0VGxWajg1?=
 =?utf-8?B?ZDVIQnBVRFBIMHFMSEVmRHZmdXZMb010L21NVU5OYVIzQkhucnZNRmhXRHZI?=
 =?utf-8?B?TEZadUxpRXZad3VpcjU4dnFaN0lOSEFjenFoc0Q3alJYZlM5aVhjYWxMejZ4?=
 =?utf-8?B?S3JTeVQzQTFwanNreWIyMTNvbkdjeXhJRU4yNXFGemd6Z3N3YWZpeU5Xd3Ri?=
 =?utf-8?B?ME94RVZTb2xkcUQ0eHlSSnF4VjJyaDV6aVFCbWV0cTFXNGM1dUpjY2xQQmc4?=
 =?utf-8?B?dGdtOUs1NElCMTZiWm45US9vUkF5bEJtSW5iZWdVK3haaWNHc0tUTS8xM3k4?=
 =?utf-8?B?eWdxNmhvOE1RZUx3RFVRQUlUdWVVdkFaWW1CMFpucFpTSkc1eWJLVVlYdmcv?=
 =?utf-8?B?NXNrcFNnekRuUmwxZHVYdTNha245VzA0WmVOTUJmQmR6dG52aGVEaThlbmFU?=
 =?utf-8?B?dUZTa3h4WFE0Sy9udTg1akw3KzZ3Z2pqWFNBQVhvT0k0OFRodUc0L0ZYNDZ0?=
 =?utf-8?B?OGpoTEZBNyt1c2VuOFhPQ0JsMVIwc3VLb0VrZGQ1UkNRNDF0ZWtiSFcxa1Jn?=
 =?utf-8?B?alh4ZDVkZVB5Zmo1dXRpREVqUUVRQ3o2SVZKK2lBMnZyN2ZTbVV4YnhRR3Fi?=
 =?utf-8?B?bEpCWWIxbzRNL3k4REprZ245WUlGRDc4cGlIRXVwQllqUStQall5eiszcFQy?=
 =?utf-8?B?emp1RXlJVUQ5YXQ3SDIrV2VubG12SUxiSW12S2NKOHB0Nm9ZWS92cWRTWXZX?=
 =?utf-8?B?a0JxakpjREd5WEdvWGh2OU54VUxyTkhTb1hoMkVqZU1XR1lLZG9UaEVDUDlS?=
 =?utf-8?B?VU9iWUJGTDNoWm00OUFnSjFyRXdtUjZtckk1c0RzYXByNGJITGVkYVF5RUkv?=
 =?utf-8?B?ZklWTXZtc1hMemFSdW5QbTB3enp3YkdLS0lNSDRnbGozclFOZ3dUdDUrQnJp?=
 =?utf-8?B?OHlEdlFLK0dNRGFaSUc2TFBtZVVUbzluN0hnMHRtcElSd3RKcmtMaFhTaHBj?=
 =?utf-8?B?ci9qZTVtVmVCTlU4Tkl5LzUrVnhJVTB0TldkdStWQkloU2I4dmZpbHA0bzdq?=
 =?utf-8?B?MjMxVWcvSVIrZ2VYQ1Q5NnUrWlU2Ylh6M1dZZ1VWTzlmalJwT1FHdkN1aWhR?=
 =?utf-8?B?VkpVcEJkZ09FWUowQllHZ0xNWlBvRHRtQ2M0emhTeUUwR01FOHh6UTdVNnVl?=
 =?utf-8?Q?XdPlcxZKu0sZIuWZg6YZP2o=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a0560b-e0c5-4d4a-bdaa-08dbe6d6a42d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 19:02:55.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTaRF6bupbLnDSqrcSAORZm9wS9L+F3uBYiq3u+uGSQqHVNEFG0gCTIFrC6Pslld0jAqxQ/k+62rEJL1VLPVTWsyHKnWFXBfU4MFO9zKLK+gJ5VpnJXo1rJGzqSVXDGp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7872
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--1372433909-1814920884-1700161374=:2081
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Thu, 16 Nov 2023, Shuai Xue wrote:
> On 2023/11/16 11:50, Ilkka Koskinen wrote:
>>> +static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>>> +{
>>> +    struct pci_dev *pdev = plat_dev->dev.platform_data;
>>> +    struct dwc_pcie_pmu *pcie_pmu;
>>> +    char *name;
>>> +    u32 bdf, val;
>>> +    u16 vsec;
>>> +    int ret;
>>> +
>>> +    vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
>>> +                    DWC_PCIE_VSEC_RAS_DES_ID);
>>
>> You nicely changed to use vendor list in this version but here the driver still tries to find Alibaba specific capability.
>
> Sorry, I missed here.
>
>> I guess, you could search again using the vendor list. The other option would be to make dwc_pcie_match_des_cap() to return the vendor id, pass it to dwc_pcie_register_dev(), which would add it to device's platform data with
>> the pointer to the pci device.
>
> The dwc_pcie_pmu_probe() is called by device which has DWC_PCIE_VSEC_RAS_DES_ID cap.
> So I guess I can use pdev->vendor directly here, e.g?
>
> 	pci_find_vsec_capability(pdev, pdev->vendor, DWC_PCIE_VSEC_RAS_DES_ID);


Oh, right. That seems correct.

Cheers, Ilkka

>
> Best Regards,
> Shuai
>
--1372433909-1814920884-1700161374=:2081--
