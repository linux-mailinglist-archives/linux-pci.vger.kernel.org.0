Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EDA7601AC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 23:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjGXV70 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 17:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjGXV7Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 17:59:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1E81BCD;
        Mon, 24 Jul 2023 14:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaCFcG5BDRhnf6OpaBAFjMLvH1Jppfih20HAUDpWAgXtFbYIQIlEa2ua/5riArGfO94mfwV72QyO5AtxwD5ZYK/c2IZFsMjZMltNByz4PK8dvJGYefWvvaSl++2L3w3BxiU3Wptyzh+QpYGN9lKQmLnOuRjKLNnKx4qkEr1uF7NRV0VbhauLAW0QyX7AUyAp6vUaWhlxZkBMBUAOPhz6PdIxx5FgdBhGVc3xXYUUDslan0ES9/vaYxLI2+OZ98sF0SLZ8xOXdasT8UWWUqRTcCPyShFrClxp8ipjSZfOOMbEyHablu1qrLqlQQ7sPi7nCsvEPKMEa5CrBzEbM1m83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z62m8T3vSNWoeygPMl+imHEsFvbDlfxtIVatJ5YmhXU=;
 b=cjDcUo0HBvbOMvdbjDXsBK+99pobd1EeScRPsTIMchlZNKzqL4/y26X7/luMLrizeyTXp5j2Hl8c17UPxCcKEBccqiN5cEAf6sGMznwHY+u8vwSeP630xNDUhWg7u/rJzoPClbeNoI2k9t9kESnVxvNgoIA3rj/zW363lDdVfyfcJuIcGbmLkhfnFPB/KXUTMwg9r/+QPZlo1C/FSfGdHU1yjnrRi/VLM+I4L42tgvtYl443dy/ZVWZZL/L0LLjo3rkda4+ez7UHa2rZpkd/N+K9f5KK9qB5helmajC+1Vvyki9lASEZSs66WwXHHVl8yBLypE5lORpDA2UHfxWuLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z62m8T3vSNWoeygPMl+imHEsFvbDlfxtIVatJ5YmhXU=;
 b=4AY+tCU35YzSJd20Y3f6s+DFutSrY0PW/sbXvatOJ3H6+FrvMQhD/GBCoZM6ZAS2ImiYV+5a0EigoiOwCvQdm1wjArD9FSnZapRe/vXAz1AHsOJWTGwUm4a+NndiTFKAKBhIBh1cv7ll2l/yEKQR/Ov00oHunGMhWAzTsi3huz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 21:59:12 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::642c:a4b0:ae3f:378b]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::642c:a4b0:ae3f:378b%4]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 21:59:11 +0000
Message-ID: <64da6d98-953f-f813-7184-e69b1c8bb28e@amd.com>
Date:   Mon, 24 Jul 2023 14:59:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] cxl/pci: Fix appropriate checking for _OSC while
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
References: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230721214740.256602-2-Smita.KoralahalliChannabasappa@amd.com>
 <0e4dc46f-a086-8b85-f94f-b3530d958209@linux.intel.com>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <0e4dc46f-a086-8b85-f94f-b3530d958209@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::10) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: cb39021c-b961-4a6d-6730-08db8c913649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDPNGCPhjOl/omvRjk3Y4gcebX/EXXyPXRWqm3rIpUUCfMI+GdKDCgaxM/rox9o+uroBUKqeLQcn4GgrXXtrMabFAbv9TERHshZjBzY7bxvYjRyDYJ2OMiYRnKt0hexTwFUh7dqFl+bHXV5hlbIp4hfkZuvORVpCwSxYorZ1WYdSoOndYTrn7uhK84gg5X3BYNqZNjExC8LOBNKsUFXDotgE5ORlyYlgeKZkahCl8fPc1ai1x/BP9IrS/WCZ+O6h6xa9CJkpzM18wphk+sjECzXFYPl8TaiMd6Trt2xmi0xBmSC//tgiWZA3uc5J9sFywsr7SHGnPlWyXpzlefuGqO3Are9pGoeaN7n8xbgvLLt+afxyHqVHNvgBJ70RJBoa+nmeCkS1nNw5zx1sAly+DKwYvKWBCML+jlXTPuEUCX6+9jAqCwOmE6phNbvfVLDIwaVTHQ94nt1lD33lVnxOCIa1mox+2uHx55WrQM03A9zDH62MTvilff0es6Z2IkBBUzUGg/Wj/Qk8Vce446I+ogJAVzaoah5+5PYsAnR0LhcOevKEFuplMdXShJMY28E5VnZg6SAt4+Q7GTbUfsUwJHExhDSKjiA+jRa4wkpRNmAdt7DC9xyuQiawf1nmPDlRBmj9esVE04MWsEukXq9o9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(38100700002)(36756003)(2616005)(66556008)(6506007)(7416002)(8676002)(6486002)(8936002)(5660300002)(478600001)(54906003)(316002)(66476007)(4326008)(66946007)(41300700001)(186003)(26005)(6512007)(966005)(6666004)(4744005)(2906002)(31686004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1NBQ3NUWGNTdkNZbFY4YVRlZDRUendYWkNGaVl5b1M4VjROVXR0UkVBUjlF?=
 =?utf-8?B?KzRWV001cm9IRnhjMjFkSVRhNk13TjAyZVpMeHpweUNueXRCeEhqV2VXdzhC?=
 =?utf-8?B?KzNWNXprYU5WMGl2cFlRRjNNSlZDT051L2VMcWdpaHpaVVo5Y2VUSGV1UVFn?=
 =?utf-8?B?T3VrWHlHMDh4WjFSZ0JNUkw5bWRyMGR2SlRjZ2R3ZUpURjBrbVhOeXNXUmJJ?=
 =?utf-8?B?alZUWENibDZMUVVOUktpSndIQm5HM2R1Y2JhRjI2dGJFMEgzY0hucERUQU9x?=
 =?utf-8?B?a0RqQ1NJejlqc1gzU0tmVzZuSzZMYWU3S3pZbmlUNlFPSWpFclI2Mmk0M2kw?=
 =?utf-8?B?aDA2OE1TcTBJZVV5RHFsN1VQT2laMGJRbmE1ZDAreFZKTzJwQzdhUmNYTGdi?=
 =?utf-8?B?ZVRkZDd3Ym1BOWhFUDB5YllqSnZ0cG44SkcxRE0wUVcwWmExSW1JNE9Id2p1?=
 =?utf-8?B?OS9YS3dHZEhXdWFIZ2x6emIxT1ZraTREV3NMQjBnMTBTd3NrQTVrc2ozZnVC?=
 =?utf-8?B?am5DQVRhS0RaTVEvUTJ3TWtOUHY2VllnU3ljMUJoU0xZazBFQXM3d0RDbjJN?=
 =?utf-8?B?OGxHazk5VFdaUWY5bzhhekZGbVZYSUg4UkhrUzcrSnZmUm5jYlhNVmxYRkhw?=
 =?utf-8?B?QVA5MkhuTVZ4aFdMdXpoMHVDVlAxVXJvSkNPRGdHdHhianFiZTdQZTU1QXVo?=
 =?utf-8?B?d0cwYkR5VFR3ZHRxVkthNTRBQmRHQitEcHo3d3pGSHdXdjhHanRsZitBalpk?=
 =?utf-8?B?dytXMC85VWJnMnk4V2V5RU1qYXl0TEVxSDllZEZDbWVWMHFxNlpZS2xydHNm?=
 =?utf-8?B?Zk95T3JmWVpaZ2p4c24xbW42VEd4MDFrT3ZkK1FyRG1iaVRVenlSMnlxemJi?=
 =?utf-8?B?NEpUdDcrejNHaThyN0hvcG5HcUpkZitpazU0dm9MOW5jTUJJRkVRYVZoQU1t?=
 =?utf-8?B?VzJ3bFplZkJ5ZnJKQ05Wc0lxUitpQUtJdUJ5NVFRZTdod1RWc08zNXBkcnA5?=
 =?utf-8?B?QUV3RTBaa1A4QVlxc3JnVCt0bDlxYmhRUzh0ekQ4aHFkemFYdTVkQWxlSlF6?=
 =?utf-8?B?UzNmQUxpb1MxU0pzNTVDN2JEcEJvZ2RRdDViL2JjVWIyRVVSSHJxNTZtaWdm?=
 =?utf-8?B?RzF0dzk4cm93RE1LdU12akhMSlVMY3FaS1Jtamd1TW43Q295UHBFQWQweDln?=
 =?utf-8?B?R1FzKzd5cWpXN1RjaWhpRS9uZUljM2o0dDZQS3FLaEhmZHZvbWExOFhzZ3Bt?=
 =?utf-8?B?ek1DK2wxY08zbUs5WEVDOTlpV0laNWNVVWhRRGN6Yy8weGFJSXFRMnJ6Qnlk?=
 =?utf-8?B?dW4vVldQZS8vNDlCTDRqTFk5K0xWSEFiZUZSakVrcHA0TmpBclVSM2twMk5s?=
 =?utf-8?B?NXc4c2IvVHc0RkJhak1tK2dSaTl3UlRQZk56SGJQLzRSYnZWRjlzQ3orT2hM?=
 =?utf-8?B?WmI4a2QrbHJQODhoai9zNkdFTWZibjJibjd1Ym13RkNlTllUdWIzRHk5ektx?=
 =?utf-8?B?MWk3Y3B0aUhkb05VV0lRM1I0TDJiS0g0ZG9BZHJzMWdOOVVKcW50Ty9pamRm?=
 =?utf-8?B?WXBPUFlUckRYTTZ2WGZMczB1QWVWOExRcnNpa2lNWGQ0Q0JzQkhlUWYxZlov?=
 =?utf-8?B?N0dueWwyL0JjQXB2aVdLOGNCdk9YL2QzcVREOXpsYzJKLzFoMUpwMTZsWXBU?=
 =?utf-8?B?M0lCdWJ0cFVDZCs4TENwblkzT0VqM1V0dit4LzVFUVN0LzRSU1ZINWcvYTJl?=
 =?utf-8?B?RWorcVZqWUdTeThkR0FEMGcrWExEc3dWcUNONStodGZ3ODZlS1pOb2hOWG04?=
 =?utf-8?B?emFZdDVCc0pZUWtlTXNUUS9WWjR4WXFPckRoMUxLUllMbys5YXBIS3ZuZVBU?=
 =?utf-8?B?SXg3T014eFBaUldWeDRXRDErYWo0ZDAwL203cHVqWjNuYVIzS0g2ZmxzM2sr?=
 =?utf-8?B?d2pXSFFBL1htVEtlQUkvaXRPangyTnBYWkhNS1JLbmttRXV2WGM2dklBZStD?=
 =?utf-8?B?VUx1Ykt3Y0d2b1pBRGpMS2tRWGFTSW1pbW40SmY2S0MrRWwwZnJDc21vNDdl?=
 =?utf-8?B?NzJwTERnd0VWQVVPaU9KTC8wcFFoMEVSclVHazhvL2FzeTVVZnNteVpwdEJk?=
 =?utf-8?Q?6FBazjqU1IR0dt+SRolhopyOG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb39021c-b961-4a6d-6730-08db8c913649
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 21:59:11.6392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYBCnyMsXhrcKKmQ4J/FvvFSfn8s7FyFfDfvSWs+Y8QKQdipHsFQCg3Nm9mBn7gKCC5ptEsT0CTxCXkVHo82+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


>> -	/* BIOS has CXL error control */
>> -	if (!host_bridge->native_cxl_error)
>> -		return -ENXIO;
>> +	/* BIOS has PCIe AER error control */
>> +	if (!host_bridge->native_aer)
>> +		return 0;
> 
> Why not directly use pcie_aer_is_native() here?
Yeah, this was in my v1. But changed as per Robert's comments, to be 
applicable for automated backports..

https://lore.kernel.org/all/ZLkxiZv3lWfazwVH@rric.localdomain/

Please advice.

Thanks,
Smita
> 
>>   
>>   	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>>   	if (rc)
> 

