Return-Path: <linux-pci+bounces-885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8282811A80
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 18:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE0D1C208CC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 17:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63593A8F6;
	Wed, 13 Dec 2023 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PLSjBY3g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HC+up8GY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A43C9;
	Wed, 13 Dec 2023 09:09:51 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDER28u023870;
	Wed, 13 Dec 2023 17:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=i8DC1ob1638TzWEVmaIn6qn7ErtWP1ASwtF01jtziro=;
 b=PLSjBY3g0dLY2ye9az+XqKdwqE8YcoPz5Syb0/X4JBNMMCEB3PZqDXCzVNfwXAg6Q+3q
 mqnwAS+I9lMQTWVOcUCpRjPLN0Qh5lnZ5MAgfMbguzXXqygCGrTW04xLwy2p6z0+wXRD
 00vFcdc3FJ4qIP9H6S5FZCy96fUfdL90ffKKd25zbG8tE2xJ69z4e7rmaJBcZCg71p5l
 C8Hs8uq5kfUvQLKxcNhTewQW7yhVJYPKCtq94g7coO9/YyqjcIIOwrKJgYBEEgJt4EQF
 xWO2RM2+MPya7GlzmVUBhXbCfrC+S0GD4YhxXvI+gIGuEAHF2eC1TSl3DCFuAGvkt5Fa wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5c8sec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 17:09:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDGx3cA003106;
	Wed, 13 Dec 2023 17:09:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep8mcpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 17:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgpCkOqtuZlxJKueZpcAwjNRXiK6lp+MBDrxrbVzgjV4z35IAltBClLiQ6pXkbhxpQRe3OKUmxq8vcBmJO3ZJkI6SIdXY1WQlfg2zPQzyJBe+w1bJObiOTELzssYOthAznGjUw3l6zX6ltsWf6SVTKqEWKhpFVthbMLexV5hAXAk2k1ToyXqjWhifQOy5tPQm6J6rTzlR4HFIHxryxarT/0tud6Mj1jR6aQzLWd3xFv38GTQ5u4yyubIEkR5mKbIyRQK6S0etzpLT1eALLFYImlElnOFHBOq1vgsROoEzAQS//C4TKDaJ4tT0AYjvBex9KgzQOTuHv0oFU8hDYi0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8DC1ob1638TzWEVmaIn6qn7ErtWP1ASwtF01jtziro=;
 b=aMjzba0qE9B8splPvbrB14GMVX5WHf3LEGtJVjg4aWp98t8oqru7M4h3uEmYNKLLSj6ygnGwN9CUZyikkLU5e241H9//3OYmLwYf0GUFw/mQzYQlxaf+46FN7yGrGGtNuI5PwyMl0kLDIji6/DDU4VOx95nRh3Q9DGlu6l+yfBh//vxmz1tac6NJCallMZ0VSQYef1tHYemYCp0xPgodxfGGeI0zQS+U57wiNpout2KZ2MukxjLFyQ11fkCLJnWRg7kyDkxkl3IQ8A4CiF8XKXSmIkYPO7CpkzRO04CrvseECPLHCTwY+wjwvlmL/EREgL4V2Yl6iRaXpsQwA0Eluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8DC1ob1638TzWEVmaIn6qn7ErtWP1ASwtF01jtziro=;
 b=HC+up8GYQ6/whGSpwjB26QLJxMQNmZSvD9Zxn2k0CCYeKxWEvAGQ7EmWosFX+rkBq/ekNmfXvP7HUWvZBNd/4+l7RhSe7CbiFRcBVx+AiKSk6fV46M6IXmaZFUvXndS+9qxdUdUklKoZx50oEzFceG1HSdo8MpyPz8fqGew6aVg=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by SJ0PR10MB5567.namprd10.prod.outlook.com (2603:10b6:a03:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 17:09:19 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 17:09:19 +0000
Message-ID: <a8db0ed6-05f4-7c2d-c63e-5f2976d25a45@oracle.com>
Date: Wed, 13 Dec 2023 09:09:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple
 devices at a time
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, lenb@kernel.org,
        bhelgaas@google.com, mika.westerberg@linux.intel.com,
        boris.ostrovsky@oracle.com, joe.jin@oracle.com, stable@vger.kernel.org,
        Fiona Ebner <f.ebner@proxmox.com>,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20231213003614.1648343-1-imammedo@redhat.com>
 <20231213003614.1648343-3-imammedo@redhat.com>
 <CAJZ5v0gowV0WJd8pjwrDyHSJPvwgkCXYu9bDG7HHfcyzkSSY6w@mail.gmail.com>
 <CAMLWh55dr2e_R+TYVj=8cFfV==D-DfOZvAeq9JEehYs3nw6-OQ@mail.gmail.com>
 <20231213115248-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20231213115248-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::17) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|SJ0PR10MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 834d3ab4-21d6-4a9a-53f5-08dbfbfe3e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mpRZZMKKMS9z6Zh09fMvzlSC/GcRIGFSj52fyZpoIYZ+J34X9VSi2M9xwPt2dZc0rmHpy/2B+FZlGFp/XunST1vwk/rxmtNdXrraSfy5dxzkarFHSXl3dJqEgkm8XwdmIiExf6KWkxkbv5uy5Md5SrII2Sa8GR+DppOkFS2p6QtsJ1s/FFyfDRkF+Tg/4x6JCp9BLrYPHCWvntgqBN2X+EhS6eB98J+OJvRFfBhvZO7sQbWhg5AM+4Ys2oikHsUv+MXum6vbY8cdJprMAUPjxwFCLHyxkonZIiY/qyMmYMfUlmn10iiPLRZVDzNcoY5WKydSsSCTIg3Ern2XH6u8H4ERR/cU28xra8Ox02TI+tgA+6OFoS1vgI+9rkEco4ohXDk8Kiaf6mYn4XtCn3eHp5joixVdKSh5TsT9pAdsLjTE7DF3+7yUhstovfib+xBpQbjfkCj4PI7iF18Lc7HFeOyo4CFQyVXH07WfH2dG9/MzVVOL+niF5GN0a47ez9lvS+y8D/rjZ7ASEKYJexID3TZrssUTDctgu0wyQyMBhH74Mn23hmkYcLZX6QW2C4qGH4TVdurYtoQ1jhIDOwpTtyrFW2/IPlIP5SX7Modp6ELM+bQKtm89eZWx1/s4CWpa2jOUXCiowE2y9ZRasZ/y3A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(6512007)(2616005)(6506007)(86362001)(38100700002)(31686004)(66476007)(44832011)(66946007)(54906003)(66556008)(316002)(110136005)(478600001)(6486002)(966005)(53546011)(83380400001)(8936002)(8676002)(4326008)(31696002)(7416002)(2906002)(36756003)(41300700001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NGhPY0VscWVZOGl2WmNhVWwvNVZmVDRsdkZjV1ZiRSt1SW1FQlViMUxoZ3ZO?=
 =?utf-8?B?NCs2Q2Nld3A3THhiZkNrZ0FMaTVkRlV3SytiOXE4T0R3VkpDeU8vOXBVUlgy?=
 =?utf-8?B?aTFDcTk2cDdUbm9xaUpLSTU0THErbmV3SEI1aU9LeWtNd3lIaTFZWlJ4UFNC?=
 =?utf-8?B?clBjSGVGQzJDZVl0clhvZkFIb2tNOEx1alBZRHFGUmdqeVRpeVpBN0FxSlhk?=
 =?utf-8?B?MHV3S3ZpcVowS1JWRGRsYllPWWVBMUxLRjRicWhpTmNQUWRmUUFKMWVTSys3?=
 =?utf-8?B?T2FWREI5d0x3TStPK2xqOGRoenREaGI3U0JvNzFFS0RHOGZBWEg0RXB3UjBz?=
 =?utf-8?B?T2lzMVE4N0J3ZS9xL2E4TTNjWmc5aTFjSUxkV01sTzVlbWFFcFVqT21GaHZX?=
 =?utf-8?B?UjlvWHd1ZnVrL3p1OGdCdkhjMlJ4UjIvc1YxVTVTWTF5VGJQUnpZUHIrc1dC?=
 =?utf-8?B?Q3R2YXhBQkttMXBnbTRQSFdDM0I0VU15RmhoNC9wdVRsT05CQVN2dDd4cWxk?=
 =?utf-8?B?N0lCcFRBZ2JXaVV2Kzk2K3JYSkdoSVpRc1RuTlZPek11YjUwZDdjM1RkQ05u?=
 =?utf-8?B?ZWRvYngzQ2N4bWJtenhqVm9LS2pwaXhrY2VkUENYbDNxaW5JUFZENXZIckJw?=
 =?utf-8?B?d0FYRWE5RUtEb3ZWU2hGd25tK2h3MHUwTlZsYXhVZHBwcTZpTTRvVkE4MzhO?=
 =?utf-8?B?UmVESmVORG9aanh6alRwMVQ4dy8xa2lOeEZ0K2JMRmFYRUVHYlUwWWZqaDdV?=
 =?utf-8?B?Q3pISXQxbkxBZlJrQmk0M2hCK1AwR0hoQTkyZnpENWh0NVpZNk9OOW9rbnRo?=
 =?utf-8?B?MlRYSnQxWGU0WHVBb1JvODBXOWVqU1hhbUxWSnJQVVZacUZRa1dXVVcrREpu?=
 =?utf-8?B?U1dYUU5Jd0srZkJBRGs3dWVzcUYraXRpQlpvRXFzRjFYcjVIUVRVNmQ4cXpm?=
 =?utf-8?B?N1Q0czcxTTRGeFM3VVAzbWU0cHphb2RsMVZZNlU0aStLcExqd0d0WFdTcXND?=
 =?utf-8?B?c1Z2ZWJyMWdvYlVtYXFGT0hQN0hUbm1mQ3kxTHZrNGZTd0NYT3IwWWFnUlNO?=
 =?utf-8?B?eCtWUkFxTUlCKzhpa0lidUJmNm1UbVUwcEJoUWtESTN2SjJWTE5uSzhlMVNl?=
 =?utf-8?B?Y3FqVUROeVVoWEdMWmh4TFU1K1VSWVRvMzZsd0JVRHRxdUlSY1EzVWppaU90?=
 =?utf-8?B?UWVkRkdWTk9ZWmN3cW03MWl0bUZQVWhpSE1rVDV2QkIzaGE1Q3Y5cXZKZjdY?=
 =?utf-8?B?WlBNS3hQa1grM2ZNQnZ5ZE9XR3ZPLytEa2QwZkh6U0o4RzA3TlBUc2h3UlNJ?=
 =?utf-8?B?NTRKem5TakhRQjJtOGw5WWtqSFJoMkpGSy9yUjUySlR5TU9yd0FzaHZlWVZZ?=
 =?utf-8?B?Yll2bHVsM2pyUDBmcVR6NXR1TEJQSURZbXJHRXdvNFFrWkhFZytabnRNd29E?=
 =?utf-8?B?RE5YL2ltUGNPNENKOFRUNTJlOUd3SDJVbVJaSTRDL1dTTEQwQjIvOE1zZGxI?=
 =?utf-8?B?b3dGUjJMVWc5QXF6R3NRUEFEa05tR3VHc2MvSnhRNUw5bXgwbkRpUC92MWw0?=
 =?utf-8?B?S0JwNlVZNTllNkV1b0JyOC9Zd1h5c2NPNXpsK2tYTEw5cUgzT045b0w3OTVD?=
 =?utf-8?B?OE96T1RqUjc5WHc2ZmhvWjNSaFFFUlVvaEdWSkJteG4xRlV6SnF0TDdaS1dx?=
 =?utf-8?B?cDkyTEtndE8wT0VqWFJ5ZXJFdHR3SWhqUGFxaXdnK3RxM0NVaWRpbkQyTXBJ?=
 =?utf-8?B?d20zWFY2K01UcXRxdmZYUXNBbmlUWkJjRUxtanJnT2RLdjlmV1FFR3BlNnV6?=
 =?utf-8?B?WGwzZlo4M09MbTZ2eTBFOHVpM2x2S1VDWVlnNHM1WEUvclJHQnZQNnptT0dV?=
 =?utf-8?B?ZTJTMG9YSWlTQXJkR3dpUTgwSW9FSmRBQ21odWJwREFGSGYrN0ZZS3BtMmFz?=
 =?utf-8?B?R3NHL1BhenVkY1pxTFdWU1lNengyL2QycWdIeWtiUVVRZnpMTncreHNDRXp5?=
 =?utf-8?B?UEVTMjdZSFRlSnZtWWVQT3NRN2doZ21rTThIQnEwZ2NNOXpwUHhRN09sVG9Z?=
 =?utf-8?B?b1J3UUhYNHI3blZtZ09QdFVBbjJnem9xRWQrZFlyYkh4Z3RHQWJQbDloWWpk?=
 =?utf-8?Q?1JRQNaHxXpDW0gnSzQemzGXFU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5IGZmkYWXbVDhJqPsnVBMy+4xnkV1rwjpMU6Ja1lyIKX8sJ4jobgV/2Yi5h9h+SBy8I2r17UZsi/q9DsaCcA3W2yMSdB/3ZVv4iWtFOiWsVNBqWsSlW3kZo3b36oWRmpUrrNXVGatn1sGkZ2r/FeV/oUSDhwDmpVYDrrNpKSNpUuJhQuAi7v8jWsY/m75iHZGcbaOd5NHLjtxdjiC0uBINgOs9MEWRqvLWnb/2u66KJ7whvPGi8w27QUtcq6edqiTZEILbotsFPTzm/3OQLBMOvRgjK21DF4Z24GtQSjO+u6h1vLKDQqgK67d76pwf/C0HwKhO9rY4UbQPyma/dGuL5yF0nFk9swpBnmTEHJrWS9I8H5Jit3bxYdQjTr2d2DjSA+ntfjItqwVl53vgb0/PEURfGrTuYEa7FRCwn/W1XvDvzMqcOxPSu3lBv6vb4UATuOCy0aNz3xOlwXFUBDHfL6lmLFieYbGpnQHEv2mdbt7HtOQZqv6vs+hQSM1NYU8QGg1X/9ZitiGfhG1TwYIshHhL32BzYgwubrUTnlfgWfxoS1VISERXtt7kYhvsScbHAWYFNe4qsS5nQYpQ3Yla0i+mJpz7toQeeLcRNbImQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834d3ab4-21d6-4a9a-53f5-08dbfbfe3e63
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 17:09:19.1632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXJhCI9GWBTbNPatw8PBvU1e1gvMhnpokZL0N/qTpb6pXXtToBAafsE3c8iJZ7kbBQ2by2Z3o5gKzOoLvXdVYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_10,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130122
X-Proofpoint-ORIG-GUID: txVwy_g0EtAzh7ZMwg-QBnFmc7OYX3eh
X-Proofpoint-GUID: txVwy_g0EtAzh7ZMwg-QBnFmc7OYX3eh

Hi Igor,

On 12/13/23 08:54, Michael S. Tsirkin wrote:
> On Wed, Dec 13, 2023 at 05:49:39PM +0100, Igor Mammedov wrote:
>> On Wed, Dec 13, 2023 at 2:08 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Wed, Dec 13, 2023 at 1:36 AM Igor Mammedov <imammedo@redhat.com> wrote:
>>>>
>>>> previous commit ("PCI: acpiphp: enable slot only if it hasn't been enabled already"
>>>> introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
>>>> bridge reconfiguration in case of single HBA hotplug.
>>>> However in virt environment it's possible to pause machine hotplug several
>>>> HBAs and let machine run. That can hit the same race when 2nd hotplugged
>>>> HBA will start re-configuring bridge.
>>>> Do the same thing as SHPC and throttle down hotplug of 2nd and up
>>>> devices within single hotplug event.
>>>>
>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>> ---
>>>>  drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
>>>> index 6b11609927d6..30bca2086b24 100644
>>>> --- a/drivers/pci/hotplug/acpiphp_glue.c
>>>> +++ b/drivers/pci/hotplug/acpiphp_glue.c
>>>> @@ -37,6 +37,7 @@
>>>>  #include <linux/mutex.h>
>>>>  #include <linux/slab.h>
>>>>  #include <linux/acpi.h>
>>>> +#include <linux/delay.h>
>>>>
>>>>  #include "../pci.h"
>>>>  #include "acpiphp.h"
>>>> @@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *dev)
>>>>  static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>>>>  {
>>>>         struct acpiphp_slot *slot;
>>>> +        int nr_hp_slots = 0;
>>>>
>>>>         /* Bail out if the bridge is going away. */
>>>>         if (bridge->is_going_away)
>>>> @@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>>>>
>>>>                         /* configure all functions */
>>>>                         if (slot->flags != SLOT_ENABLED) {
>>>> +                               if (nr_hp_slots)
>>>> +                                       msleep(1000);
>>>
>>> Why is 1000 considered the most suitable number here?  Any chance to
>>> define a symbol for it?
>>
>> Timeout was borrowed from SHPC hotplug workflow where it apparently
>> makes race harder to reproduce.
>> (though it's not excuse to add more timeouts elsewhere)
>>
>>> And won't this affect the cases when the race in question is not a concern?
>>
>> In practice it's not likely, since even in virt scenario hypervisor won't
>> stop VM to hotplug device (which beats whole purpose of hotplug).
>>
>> But in case of a very slow VM (overcommit case) it's possible for
>> several HBA's to be hotplugged by the time acpiphp gets a chance
>> to handle the 1st hotplug event. SHPC is more or less 'safe' with its
>> 1sec delay.
>>
>>> Also, adding arbitrary timeouts is not the most robust way of
>>> addressing race conditions IMV.  Wouldn't it be better to add some
>>> proper synchronization between the pieces of code that can race with
>>> each other?
>>
>> I don't like it either, it's a stop gap measure to hide regression on
>> short notice,
>> which I can fixup without much risk in short time left, before folks
>> leave on holidays.
>> It's fine to drop the patch as chances of this happening are small.
>> [1/2] should cover reported cases.
>>
>> Since it's RFC, I basically ask for opinions on a proper way to fix
>> SCSI_ASYNC_SCAN
>> running wild while the hotplug is in progress (and maybe SCSI is not
>> the only user that
>> schedules async job from device probe).
> 
> Of course not. And things don't have to be scheduled from probe right?
> Can be triggered by an interrupt or userspace activity.

I agree with Michael. TBH, I am curious if the two patches can
workaround/resolve the issue.

Would you mind helping explain if to run enable_slot() for a new PCI device can
impact the other PCI devices existing on the bridge?

E.g.,:

1. Attach several virtio-scsi or virtio-net on the same bridge.

2. Trigger workload for those PCI devices. They may do mmio write to kick the
doorbell (to trigger KVM/QEMU ioeventfd) very frequently.

3. Now hot-add an extra PCI device. Since the slot is never enabled, it enables
the slot via enable_slot().

Can I assume the last enable_slot() will temporarily re-configure the bridge
window so that all other PCI devices' mmio will lose effect at that time point?

Since drivers always kick the doorbell conditionally, they may hang forever.

As I have reported, we used to have the similar issue.

PCI: Probe bridge window attributes once at enumeration-time
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=51c48b310183ab6ba5419edfc6a8de889cc04521


Therefore, can I assume the issue is not because to re-enable an already-enabled
slot, but to touch the bridge window for more than once?

Thank you very much!

Dongli Zhang

> 
>> So adding synchronisation and testing
>> would take time (not something I'd do this late in the cycle).
>>
>> So far I'm thinking about adding rw mutex to bridge with the PCI
>> hotplug subsystem
>> being a writer while scsi scan jobs would be readers and wait till hotplug code
>> says it's safe to proceed.
>> I plan to work in this direction and give it some testing, unless
>> someone has a better idea.
> 
>>>
>>>> +
>>>> +                                ++nr_hp_slots;
>>>>                                 enable_slot(slot, true);
>>>>                         }
>>>>                 } else {
>>>> --
>>>
> 

