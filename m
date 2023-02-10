Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9EA69289E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 21:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjBJUqP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 15:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjBJUqO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 15:46:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B8370714;
        Fri, 10 Feb 2023 12:46:12 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AI0Lq8017192;
        Fri, 10 Feb 2023 20:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bb06DitSjXDu3MjHbmrzYGjVsyN7Qxb6M+sno74jJpQ=;
 b=0yOfuY7MUsvbQIE/MDwsezWRsDdICVeWDlQZNYAWR7udxjKVW3HwXF/+uv30bbZUZpvQ
 KnK+kakd5TCvGgVLjLHYR+QHLiEhVnEEaqgy2QwbBVFYg9LRsfVw7ChCHENdziyYp0iI
 2QpWvHJEaaWDcqnPECOGYqBPMuytFLeR1Q+hoFjO2ZjHnx6C49k+CT9jrz1otuZmuzJw
 QwYlcDm1kqyn25HCXkVu0UjK4kVgRYLGRp5b+zBAwILA+5mPiAV23n+X0Di393TQBxGY
 QNMTaHaKNPNrRT1qLHJ3gkpeeaSe7ENG0VuhsyU+AHhjP7oXy/eyrxzMqw5pBuKT4kx5 TA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe9np7bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 20:45:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AJVbO5003018;
        Fri, 10 Feb 2023 20:45:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtb8bcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 20:45:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD3KbYkxqGEodwzP4qIFD1L8dttMSG28/UIgYtfKKCZHg+PXJmfsFKOHNiX6YxGoZgwjmBSX3WP95vpgEPNVuwtjp0t1gKirbLPKVaweIZoKN/RDhxlrPpHWQqJUNZ7YQfDQt/GHxC/5km+e1BAhrUsvdG1DJsHF7PBM5JkDuWht6XMBix9wQtbbIxrut9UT74ruukbwTiXZFXt8mtpbZPQOwWZYpRxznjZZVUFKImiUcMPnW1vv1UlWSTT9Wo4rAMcXVTqPMl5Mw1KAmBZoXbkVyGcr7DQWDuXTe1imlBUjYjIrjR4KRNCE/Zlqj+eBTSU/XBCWiNd8ufPBRruRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bb06DitSjXDu3MjHbmrzYGjVsyN7Qxb6M+sno74jJpQ=;
 b=W8FSNq4TT+q2gwcfY0EtzYYq9mVlCmKhf+0deQP8SdaJaKKrM4wVdBWic0xf9wrxOSaUT/+47Dy8U4Isg/n7X5+Pkdua90JIrjkOPpT6O2io1G3MpyXgi8NEVmk7aMca5eKcrF1C0D6h8hhplHwwKfHolTX0OBRJA6vXUIogwYOARI8kvvkLUPcJFwJxmfbtYdfMfztpzUWZ+RSoK0L1MbvRCEMQBIyZkA64xy3COJLY1r28V4oNkrvevofE5GC2DLzG2XOapTSytLHg50AELKl4da8OHNm5OJTUImY5L2IclGZr4+s+rfk/Zrp636XtUxd6lkbGQzc0W5Qu8kacZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb06DitSjXDu3MjHbmrzYGjVsyN7Qxb6M+sno74jJpQ=;
 b=AQdMZb7UivKP7fbLfC+geAQhXtMYskQIJ7swLI0scjb9MOyeipAJJH3G3Ul4VhsqwIhXL7j8JyAvaqDiJ45b8QI/ge9QBy3sNd5r1uu9WFhUMH+8hB7NNinM2KUaERwOOJGW8AuAlqTfthpS5MZ2Td75E7yLAfPBGUfXf3ku5Hw=
Received: from PH0PR10MB4581.namprd10.prod.outlook.com (2603:10b6:510:42::16)
 by SA1PR10MB5712.namprd10.prod.outlook.com (2603:10b6:806:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 20:45:49 +0000
Received: from PH0PR10MB4581.namprd10.prod.outlook.com
 ([fe80::9013:b768:5177:564a]) by PH0PR10MB4581.namprd10.prod.outlook.com
 ([fe80::9013:b768:5177:564a%6]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 20:45:49 +0000
Message-ID: <333dee5b-6710-998c-bf3f-2cb1d676a7da@oracle.com>
Date:   Sat, 11 Feb 2023 02:15:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] PCI: Fix build error when CONFIG_PCI_MSI disabled
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, bhelgaas@google.com,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, tglx@linutronix.de, kevin.tian@intel.com,
        darwi@linutronix.de
References: <158e40e1cfcfc58ae30ecb2bbfaf86e5bba7a1ef.1675978686.git.reinette.chatre@intel.com>
From:   ALOK TIWARI <alok.a.tiwari@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <158e40e1cfcfc58ae30ecb2bbfaf86e5bba7a1ef.1675978686.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0019.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::6) To PH0PR10MB4581.namprd10.prod.outlook.com
 (2603:10b6:510:42::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4581:EE_|SA1PR10MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 421611a8-dfa7-47d0-f570-08db0ba7caad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOaFZQl47in71MPI8woUvlCQ8kSDmtl6/ebUXmi0SHz/jRsWz5zwLqQC2ckTuPwbV15O413SrYK8t36Z1FDfJ8tmLRHaG09dxMv5d2C59nawrC1RwIKugy2PSfBzW/Ee2Z6FTVbNvKQQ7bS11GZzkLJxjyKnHK3oOuZTcHf2uLoqOo8R3uN31z3K8MS4h8ns9u6+c5eIh69/pNIYFgnp3o278iPtgvXra11g76uGJWs7KTZoTotQF+AlRQv15Jyk+wF4rUT1SXhBIqs8h3Hf1ykkAN9SDef0RY2RPE59/JFOihirtjm4GyT9CX7EIaji0pZylKUGA684W+omYGAGFoFMFR3omubNxOi3P8sKmkfKbn/SCtVx7zorUNDMgRnJApYG6eyhNFxlbRHRK6F7MICYtjg5dx9PVMkdoKOfkg5sl9fb1dzkyLlR1X7Q3icSPWGvohZRM3/kZvbGUdrWsNdSe1L+eEPgS70ujrvJFfazB/awBg6bE9/jxEA9pKFwsggHdAJCC/pHik8ubvF2xwnuMGY+be6lxwA0jL87fQ2xvPdgaFThNUzp/hIGcv7wL3fkaZV8W1/nbxt42U09CrznBywSa4tYKy0Fhg3QPQj4binz4tA7R4Fnds57YHOtfdZrjlPwGpKed3pxqlMOqy1h36QE7GA2Punb10ciG3dFD3gJB4VnTUkz+M1rQpq9OHHakEHNAxdMuV1Z1wHO0tqiU6BcHP2nrI7YwmVe8Lo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4581.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199018)(6486002)(6506007)(53546011)(31686004)(5660300002)(7416002)(478600001)(26005)(31696002)(2616005)(6512007)(36916002)(86362001)(6666004)(186003)(38100700002)(66556008)(66476007)(8676002)(36756003)(2906002)(316002)(8936002)(83380400001)(4326008)(41300700001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk1jaDBJdTRGdXFJTHU5eW0wZGIwNjY4Si9SSlJ1aDJpM2NtYlhMSlJmd1Rw?=
 =?utf-8?B?U3Nsa1FQVEttdWl6Z21KeUZ6WlB2aWdVbmlnekFpWG1YNXVkRldadDg1T0Yv?=
 =?utf-8?B?MHFQd2ZHU0FXais0TU1pT1owWDJhSElUb1lNU2ljTDhOVWlvRUlZa2dJUzBL?=
 =?utf-8?B?M21aTkxJZldxUmNLUFUyeExCdml1b21UWDRZcDZoYnNSV0VnQ2xUZTJLSEtI?=
 =?utf-8?B?UTc1YnIzSGo4R0N0K3NyeWJTM2xlRzBNUGtBYTRMZmxqa0dFdVBvS3A4TUZR?=
 =?utf-8?B?RjJ6RmVpRlZWTE5xWjBpTjZSUnU4b1ZGbVlmK3M3SXZNMzhQVHdoVXdtOXV6?=
 =?utf-8?B?OGJIT2cxTlVJZWNEaVZnNnNsemRLbVZUNWxrQ0M2cjVkdzdpclhFRUFTK2c1?=
 =?utf-8?B?KzlmWC95ZnpHWCtJSkdkWDlUU0V4ajVyOTZxK05FRTNRWlFkNTNYdmVXYmFX?=
 =?utf-8?B?UllRUHlRbGJxckI1QWdXb1RpZUN4bEVUNUdQZEYwTTZnN3I0MkFxREpRd3N2?=
 =?utf-8?B?YVBJcEhnNTNpcU9XRWpZeHpIdndLOTdFQ2JKZHd6RnAzY0Q0U09NcXJJSHpz?=
 =?utf-8?B?djJyWHNTSDlWWldIZXhUdTNGWEdiUFArTDZuOFVFd2dvaHY1T1VlckpBZTJP?=
 =?utf-8?B?SlNoUUFFVXhlRnFFYWlwOXpmd1YwbVdlVHRmQkl3OXI4YVN4SXgxRXBhdi9V?=
 =?utf-8?B?MnEzRVlwVlBnb0NDTll5R2k5SGw4QVRobUE2SUpZaFJvblZEMHo2QjdLTklS?=
 =?utf-8?B?cVJyWGU5YTBQUVRjNkxOZHZiNlp4QjR5MnROS1lhVzJqdzYzUkkrVDFpd0FF?=
 =?utf-8?B?SVB5RWU4MHRqN2dhSDJISERwcHI1dzN2bEdlVElzY2lUTlBCTEY2ZWpVOGlX?=
 =?utf-8?B?QWpFOFZzY3pZYlZRUGlvSDkwL3lGY0dsK2FjMUIvWW1XRWcvU25PTkhrd1NS?=
 =?utf-8?B?aFFOMFlNTlpBWk1MTzVVL0hwbU5hVHBmcmpnNlJvcFdlZWdCYlorbTBnbGZN?=
 =?utf-8?B?dHc1bHRaTGVPWG5XNCsxWmhFbzJ2QnJzWk9ZdGVzaTVMajNFYXNmYWRvMEZ2?=
 =?utf-8?B?VW90RWNKUzQzcVJjOGZjZSt3dGhQaHdLQXVSTWhQb1BHZlpPckdldmExdlJQ?=
 =?utf-8?B?eHJJeFdUT1c2L1JMWnFIQmQxbzY3WXVyM1Q4emFBdDdYMEcvQnNVTnJ4ZkZO?=
 =?utf-8?B?M282U1VXWm1mbG1VbUNWdnBmRXRLbi9HVW5HdVd2K0VBbFYzQkdhZk9QWjV2?=
 =?utf-8?B?dmJrMWdqbzVMWEEwT1VxOEM1K3JPUy9iZWtSK0laSnBYRGFiOVBDQnNSWElt?=
 =?utf-8?B?SVpRV1NaU0M1a1lrZFc1OERKOXFiYjlzYy9VbWMxeEhWTmdJU29Nb3RqMlZo?=
 =?utf-8?B?b1diNm1Vdk5WeXZIeE1wSU02K1AzbDRBNUNNT3B4YVdORDBHbHdYNVQ2RWFa?=
 =?utf-8?B?b1NJY3lqQ2hMaC9TMUlpUndobWpDcVhWc0VDNTc3TFNwSkp2TUxIZFV1SzVl?=
 =?utf-8?B?LzZaTFVFZDF2NmR4VlFSd0U2bm45UEdHVWxXRER6SFd1MHVXaXY1K0Y0dmVk?=
 =?utf-8?B?Z1FGV0lhQmFrblN0dU9JZVpOVXdwSFQrWk9ERXlJdE1jMVdTcEZUNm9xalll?=
 =?utf-8?B?eHJKemc1eVhjOEJBRkUwczZPOExscEY4S2JNd25GMVo2d0szVU9OU1F6SDNt?=
 =?utf-8?B?MUFNcy9MUHUwL3BVbnN4WWdvZVJtWTZ6b1RBZ29LY0x0QkxlK1JnNkg1dmJh?=
 =?utf-8?B?YUlyV0FxZmZub09UT1J4aVBpNVFFOERwKzBPTDBzQjgyQmtVVTdETTFzbDRI?=
 =?utf-8?B?Y2VyYnh4eENKU0tzRVZLOTBzRFl6NnBDU251dS9UQWRQWC8rWlZEcFR1ZXpm?=
 =?utf-8?B?VDd0NnNyTi96WEQ4TTBJaE1mSHpiV0NkZVREMXVnVm5HZGNLQzFKemlORHZK?=
 =?utf-8?B?RFRPZklQcjYydVl0bi9tcFFmMlBKZnVNNFlndGhrdlVhczRQYXFzYytWQnNy?=
 =?utf-8?B?Z2hiYUxsWVoxWDIyZUh4eFkrMjVTV2V6Y1kxSFIrQ3creThwK05NZ3ptYkhL?=
 =?utf-8?B?clRPSmlLY1prczIrbDJyelRTS2xBeG10eDJOTS9nU083YkphNUx6bDBNTVBw?=
 =?utf-8?B?ZHhLUDBJRGwreUVRcnh2ek1nWGhja3kydVZqMWRwUWZZNVVna296bmpsSWVT?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UnF3Nlh3NTZ1b1I2eEVYZ0xEWElVSnRSV3U3YmJWRExLUTRBaTZqcC9aL1p1?=
 =?utf-8?B?SC9FbUNXM1FzbXlnS1VaRTkwMDFhS0Q3S0tydzcyZjVla3Z0dGx6K21XcmND?=
 =?utf-8?B?VXpRVnFKVVRFajFaOS9CUmdtQ1p5b2lCdEIvN3I3aG1RUnhHdzB5T1VlNXdu?=
 =?utf-8?B?WlhpUXRRUkpURTFmLzlhN0ZUZXNEUmM3OHdDYnNZYnF1OXVhYktpK0MwL2VB?=
 =?utf-8?B?WS8weUd6cFI4MXUzdHkxNzNmSDB4L1ltMkNMRVllUnpDOEx3VlVHdWRycnMw?=
 =?utf-8?B?TTRaL21UUk1QcGxTM0h6Ylhad1Z2NEJBeDNYekRuNm1sWExMdjZZY29UTjJp?=
 =?utf-8?B?bUpITVhpSS9IeWhDSmhKMERzK094QjlwaGZLa3JJVis4RVp4eUJtVVA0UGZ1?=
 =?utf-8?B?a2xXTG9QSnByTHE5amZ2S2lFKzV4dGpBSmFQY05tMzFZQyszUkk5RnJkRFJ6?=
 =?utf-8?B?UzU1UHBLMVlPV0l0aVoxSm5iaUNxQ0xvelpNa0srbW9OSjZUcjk2Rk1ZeXdp?=
 =?utf-8?B?TjNySVhiS1RsVVRsRk9XN3g4SVIxcXQ5TzVtVWJ0Q3ZEWnE0U0hqSHZKRkhx?=
 =?utf-8?B?UjRlU05WK0hQbmtzY09XMitWbVpOU01xSXQ5bDkvVTgrN2ZJMkZ1VHM1MTBT?=
 =?utf-8?B?NkZWc3llVUZjaGNSMnRDbSsxdVRtOENEbGpGSDh3SDQ1WnFaSkdGNkZXTVh2?=
 =?utf-8?B?Nis3Tnp3bUVyVmIvQmRVRzNkVjI5QnY2N1o5SjZkVWpOWTVmWGxCY2IzL2FD?=
 =?utf-8?B?dG1zWEY1bDZEYkJibTAzVlI2eEdFbUhhMGNnalY0TUFWdlMzL1pIRUpJVEs3?=
 =?utf-8?B?UVNqT1dSR2RLYkpWaENHOGxZS2tWTFdoVkU5OFBhL3YyaVBxdHVWSG5RZlll?=
 =?utf-8?B?TVh0cUxPa2NjWXNtK0ZQSzRBMURnQXBNMlFmYjJ2UFJlTFdDMTNBZUFFeER6?=
 =?utf-8?B?ZC9TcEJlam9XdzVqZ1EyVWFRMnNxVVRnSVhabWhjWHJHZ2VranZMdnlpRy94?=
 =?utf-8?B?UFgxcXJVd2J2SjJwVTh1Q0srUDZBTGx3alVWZi9Pa2ZWVDU2SHhGa3RBeG9B?=
 =?utf-8?B?bENrd0tqbnV3eVBhYzd1MlJPdFhOVlBNMEJINXNEejM0azBJQTJ4cTl5QU5H?=
 =?utf-8?B?dGFYNVNROW9FWlAvTVhRKzhuZVFGNk94OWUreDBhWmltS0JhVGw1MmFHY211?=
 =?utf-8?B?SEtUVG5CSVZxWWt5MXRaZHIzeVJLTG1CY2JWcHFvQTczRlJiT2xSem9oNGx3?=
 =?utf-8?B?VHY5TmY0Vlp1NEkzd0ZQU2ZoYXdwUldpZWl1VTFoeUVsb1dOZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421611a8-dfa7-47d0-f570-08db0ba7caad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4581.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 20:45:49.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2HW0hpsMM2UMkR0OAVV3+LQ8tb1KB0lP4iDMJiQkUPLOFdt6pzV4dFWpkmU+L0Lmmn2DWxxEEcHr6G+2TbF1EmUgeyvd9jfTk/hHg7r5LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100177
X-Proofpoint-ORIG-GUID: AbaGhZNfdn__pGTkw9k0r5TO432Xxo-l
X-Proofpoint-GUID: AbaGhZNfdn__pGTkw9k0r5TO432Xxo-l
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

shall we need to define this function under -> #ifndef CONFIG_PCI_MSI

#ifndef CONFIG_PCI_MSI

+static inline struct msi_map
+pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
+		      const struct irq_affinity_desc *affdesc)
+{
+	struct msi_map map = { .index = -ENOSYS };
+
+	return map;
+}
+
+static inline void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map)
+{
+}
+#endif

Thanks,

Alok

On 2/10/2023 3:19 AM, Reinette Chatre wrote:
> pci_msix_alloc_irq_at() and pci_msix_free_irq() are not
> declared when CONFIG_PCI_MSI is disabled.
>
> Users of these two calls do not yet exist but when users
> do appear (shown below is an attempt to use the new API
> in vfio-pci) the following errors will be encountered when
> compiling with CONFIG_PCI_MSI disabled:
> drivers/vfio/pci/vfio_pci_intrs.c:461:4: error: implicit declaration of\
>          function 'pci_msix_free_irq' is invalid in C99\
>          [-Werror,-Wimplicit-function-declaration]
>                             pci_msix_free_irq(pdev, msix_map);
>                             ^
>     drivers/vfio/pci/vfio_pci_intrs.c:461:4: note: did you mean 'pci_ims_free_irq'?
>     include/linux/pci.h:2516:6: note: 'pci_ims_free_irq' declared here
>     void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
>          ^
> drivers/vfio/pci/vfio_pci_intrs.c:511:15: error: implicit declaration of\
>          function 'pci_msix_alloc_irq_at' is invalid in C99\
>          [-Werror,-Wimplicit-function-declaration]
>                     msix_map = pci_msix_alloc_irq_at(pdev, vector, NULL);
>                                        ^
>     drivers/vfio/pci/vfio_pci_intrs.c:511:15: note: did you mean 'pci_ims_alloc_irq'?
>     include/linux/pci.h:2514:16: note: 'pci_ims_alloc_irq' declared here
>     struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev,\
>                                      union msi_instance_cookie *icookie,
>
> Provide definitions for pci_msix_alloc_irq_at() and pci_msix_free_irq() in
> preparation for users that need to compile when CONFIG_PCI_MSI is
> disabled.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>
> checkpatch.pl warns about the usage of -ENOSYS but it does appear
> to be the custom.
>
>   include/linux/pci.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index adffd65e84b4..448482d1c4fe 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1621,6 +1621,19 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>   					      flags, NULL);
>   }
>   
> +static inline struct msi_map
> +pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
> +		      const struct irq_affinity_desc *affdesc)
> +{
> +	struct msi_map map = { .index = -ENOSYS };
> +
> +	return map;
> +}
> +
> +static inline void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map)
> +{
> +}
> +
>   static inline void pci_free_irq_vectors(struct pci_dev *dev)
>   {
>   }
