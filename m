Return-Path: <linux-pci+bounces-887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD32811AE5
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 18:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF399282992
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533BF54BEF;
	Wed, 13 Dec 2023 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lONV4P3C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yw5WW0b7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3249899;
	Wed, 13 Dec 2023 09:25:20 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDER4jR021056;
	Wed, 13 Dec 2023 17:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=rpimtvqfK8lLjIjO3IaXNPBSoDR77sdsr7tcw94ThDw=;
 b=lONV4P3CHtgEXOUTJfoprqd7MdbTL+9vLpfBWiwbgWSSIg9Q+Fl9PSuD+V7bv8qfXFxS
 GsWrCh6ZY5sKo8ZanX2zQ+umGjos0FIbqEG2wDvo3zlVh3jNMXgIRokZf7oIHUKr8zuS
 1hV3fmtBgZ1Ayz6pmgZzhsWF7LxL2e4ss1rZu2OvusoZnTEMGwz4PQAuX69XueVXBKdr
 SY6X4GPS1XG/Y8ngj8I4KhHOaKNUFzf3zIzoYLabGyYHN7idrpHPRZjOKAJyn5Ig8nJX
 0JvnLDeDTrkWgEYbikD2Af5FKHAyWKWZ+bOAHJ5crbXxO8aRYIsOL+ADwM8jAg/HTuLO sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu8t12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 17:25:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDGZYnk013000;
	Wed, 13 Dec 2023 17:25:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepew27j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 17:25:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkH3HFX/047MktDqf0GUNYqkVSo/hHOFyviaDkEIDwTVBa0d+4ucWlRipRFjLUhCIhhc+nXWcr9i2Tq89nfj9ruLcQh4/alBKl53r1L7y78pxxn6plUS+DOgWd0enurfO8+1HgwVMHDpzO/lfaH+GG6GNME70X88YZRI/zEmVB68ERZ4eaqwoXsEujx8YmLWPd3QpLu97p6cgmrd+/bmjayKK0qfW9Qo/kbQpXLmd7PKHSv2MdJxZ1+0nNIqh0tJAzwlB8mYEdmfDHnqe0sx7u7gVRoECjX2KL1bCsC/BTxnCfbB9lJ/tRSxoiDd1xAqpgdtXTr2py9Boa4qu9XUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpimtvqfK8lLjIjO3IaXNPBSoDR77sdsr7tcw94ThDw=;
 b=Bq48j9O+NmipfKu1bUFvYBxo+vTgQVFiDU5Mu88oxn+QF+oQFVx67c2163hHrzug7P4A22F+DtHTDmfYXf1VS14nyFXVeZ9FLdb0ZTiEtfK8trQRsMsxpi/g7syc0g8au8xbkm4XrQeHBviYfwA0Wff/QCCTP07dk2cjgoUoVoXXafSNkvj44597DlzokRju6C+FRDWQLi6XeGsToigvBpsBWWlAIftO9NCFiZ8daMCwCLijW2A468+ggd/c5I2TysO4HBx5718kUkIJx0Rf+Lmkox+IXe9NsKe7qMwRy9U+3RF6hsrgKgsrVEQFa/Qpa9uOSF8FrxkMUsSgbg94eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpimtvqfK8lLjIjO3IaXNPBSoDR77sdsr7tcw94ThDw=;
 b=yw5WW0b7Z8WduD4IGWK0IFFpjKL+yUIwFjEUkXS/ItWIj7SGq5IGWRD6Ht6E521pQphI3E4Dx28CFQairWn85nAZHKFJ6MkyaOZGr/ZGrpIJdfX19EYnBnCKxflOW8P4C4EmY8TYxxqIzOMdmHRDyt4mVjz5nUwhFrOH10hMdsc=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by PH0PR10MB5818.namprd10.prod.outlook.com (2603:10b6:510:140::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 17:25:04 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 17:25:04 +0000
Message-ID: <a7e8e2cc-a228-d444-4266-35711d220143@oracle.com>
Date: Wed, 13 Dec 2023 09:25:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple
 devices at a time
To: Igor Mammedov <imammedo@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, mst@redhat.com,
        rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
        mika.westerberg@linux.intel.com, boris.ostrovsky@oracle.com,
        joe.jin@oracle.com, stable@vger.kernel.org,
        Fiona Ebner
 <f.ebner@proxmox.com>,
        Thomas Lamprecht <t.lamprecht@proxmox.com>,
        linux-kernel@vger.kernel.org
References: <20231213003614.1648343-1-imammedo@redhat.com>
 <20231213003614.1648343-3-imammedo@redhat.com>
 <d93c4614-1bbc-3a30-305e-28ff75d7fde2@oracle.com>
 <20231213110556.5f1d83bf@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20231213110556.5f1d83bf@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0007.prod.exchangelabs.com (2603:10b6:a02:80::20)
 To BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|PH0PR10MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 636b8a66-27fc-40d7-5ca0-08dbfc0071d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o1gegr8wFlPN0KQb7ivU33SmGWlhIQXywuRdnoM6EQFamkr3T+WCGkFrbhFSS5cRunQtvTCBMFfncRr6ejCePbv9iUf2ODhY/dpfv6G28yJYXQ/iU61qCgv8uM01FYCdETwjLKd0utgIFMwajL0BUmeqy+qFG/mX++16AnHA/NRoa0oquyAA3BgG9pFkfDpgHJdRkmQncnRf4EhbywrXjZFWDFAYfxUi7NEHJAMizEo2YV+xUNAU/FQVNjZKQyoe9InNInWF85/wJL3gQ7bi6xmgIr7v3A6EWizapTs49bFVviumVxWESY6mOR/4NisvTjnQ1Xt8cQWd/9ZbdcDKYt1ePpNwGwx2kenIgszpJgwJYVVV+h9CicbknQkrDqZxYrMI6Gp3VLWarGpZiLFTymn1BB3b8oT2RQNitqRbLmsYKTTSn61yCbxsS4EGnRvMYn+QNr3AIO7A6HhonmzS+8y3uyvixkN+yar0te23uB/rYu2ldkzH87K5JsnkRnranM8KR+GxAbCQtwI2FlqE3gu3ijH2zeNOvfDHD1j5kUIRXRyMtkob/s1nYq5FSQmNuI8r317nC/QxXwNA+xsHDduRxLlw8IB/3Aj6qumoSkVdGfY0YOA4kls18iDMT0hBcjwuPeg9bsy4flId/vob4A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31696002)(83380400001)(6506007)(53546011)(6512007)(8676002)(44832011)(2616005)(38100700002)(5660300002)(4326008)(8936002)(7416002)(41300700001)(2906002)(26005)(478600001)(6486002)(316002)(66556008)(66476007)(6916009)(54906003)(86362001)(66946007)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?enREVEZhekhmNVNNQi9udGUrZjNKVTcvT2g0Y2xIOXM2VW5iQ3E0ZFdZbmF5?=
 =?utf-8?B?bmFtZFJvTmx0bVE4UW1RZ0FHSk9QRmlPdE1wck5MaVg0U3Fwald4VWM4MTdF?=
 =?utf-8?B?N1RJMW9aQ3plUlNCOGtpaHhpQ1hWSmRBVnNKR2pvTnFoQitLZ0ZieUYxZ3gx?=
 =?utf-8?B?TVBrNmlPNmtuQVZFY3JrS216UUNYdHdzRkhVN0g1aGJCcEFPVFVQVFhkaTd6?=
 =?utf-8?B?WVpoU21sUUFXUEl6amRvS2tJVzNJcnlBc3RmelFXc3VHbGNiVTduYVJsRVN6?=
 =?utf-8?B?U1VBNUdkTkYzcHA4K3p1em11bnJ0K3dKUGhYMi9EYXRlbEk1THJoTUk0aW5F?=
 =?utf-8?B?ZWp6c210a3k2bjNTaitmamJJdXRSSEcwSTJrdDlPeWMvZVh0QWp0N2pXaFoy?=
 =?utf-8?B?dy90ZE5Ebm5ybXNmdWtnTU5YMWZLcFJhWUZjUTgyUlZpUmF1aGIyL0toSXQw?=
 =?utf-8?B?Z0wzellsUjk5U20rNHRETkVEZXFYQnYzSjRzVjhvUTBFVTE3TEw4ZHhqb2c3?=
 =?utf-8?B?TFRHc0U4NFg5Qzd3WFBOYUVnZHNUQ0lQSm53WkorWVM2MEpiRGxyN2V3YWF4?=
 =?utf-8?B?YUNjUTZxVjFTZGtvdFB6d1FlQkdDSzVFRUx1b2pQQzhJa1l1QnlJN3BMS1VW?=
 =?utf-8?B?bVZ2dFdiaDhIWVNmK2dmM2ZnM2p2K2tyaTBzMGEwVXcyb2RtbUMya0NyUmxy?=
 =?utf-8?B?dWUvWTdNb0VLTmlPWS9KMzJYLzVMMGd6U0U0ZWlGa2lZMjBFVEZscm9XVm5l?=
 =?utf-8?B?N2t4UmxTUGxYZ09UdGZjSFhWQi9Pazd3R0hkQjBObUlnekdoeW5HYmZUWDk3?=
 =?utf-8?B?WG5QcnJCSUlqUU53K0R0UktzN25xRlZraTRXaXZzZzVJUWNFOWM4ZVZML3NK?=
 =?utf-8?B?UVhodUNhd1pmOGQ3czh4YUhGSXZITHU2dGhKazFXTGlmM2JFVHpSM0NpNCtj?=
 =?utf-8?B?VkNJVlRXMGc0SlhvRnZyOUt6akVUTzNlUHNNQjYzVm5pck93amZVQnJ1aCtU?=
 =?utf-8?B?djZtVjNvV0ZnbnI2cWhuekRVbEVvaVBDVk4rT01BbUhRYlZydUM0SDllZVhM?=
 =?utf-8?B?aU9MR0N0T0tyUHFLeG55V0RENkx5elp2bEVoSDdKOVNiQUFZbjAyMkFyT1N2?=
 =?utf-8?B?NHdBN0lCTnYzVC8yS1V6L3RxNlluQ3ZQajcrN0ZrYUY5dGJ6eXBmUko2cEVI?=
 =?utf-8?B?Tk9rbUFPRWNNWXZEYThXbi9VdXdoVzdpWHovWVovUWdDY3ZuNDJJQ0NhQXNE?=
 =?utf-8?B?YjBkSjNIWjdWVXB6RVVXemhsQ1V5MzhyOUNqUzVJTTJvRCtRMW5ZVUVtOFBQ?=
 =?utf-8?B?SUFURjVqd0Y1TW9FM1NlYnByWTUwS205WVZ3OW1abEl4ejJUc3plNTZ2QUM1?=
 =?utf-8?B?L3Rob1hidGtHdDBQRDV2aFN2YWtTMnlUZWZzOGdFdnFoZVRhYXk5VytxODJ1?=
 =?utf-8?B?S1FxcGh4S2xqUG5LUG5wckY5akZnTE03VzViS1MzNnVBbW9WOTBwK3Nab1JS?=
 =?utf-8?B?cExkcG16QUtGNFhEY1R1d2JmY3NYVmQ1YVZ2amk3RlFTbFFjc01oOW1wclRE?=
 =?utf-8?B?YVBycTd1QW12Vlh3d3RnZTcxZGg2Z2pEL3RoOGhxQWIwTkFJeW9MelRiSGd2?=
 =?utf-8?B?aHdkYmhIdXJCS010WlI0cnJrQlhEYTRHTXhtaDgwNkFOeWgzZjgxWjVIQUV6?=
 =?utf-8?B?UVlQY2lmQWM2Mm95M2R4SWlrSUEvRmFwcUVtZWlHeUUzYXBpeGNMMFR2TWVm?=
 =?utf-8?B?T2VVRGlhWHdNenBlajdZbWdkUzZSUkYzbWU2ajZnYnU3YzVRYjFicmxHVmZH?=
 =?utf-8?B?TTNwT0Z3VlhzeWpLS2xLMURuSEtCdUQwNUoxdXlNMjNxV1ZKZDhyeUtJeVVm?=
 =?utf-8?B?Y25QUElsd2xiWHZZMHVVMXhGN245dnlyODJXcGZXZXNRcmR3VWlNVHZGVXdC?=
 =?utf-8?B?YmkwdUZqT01zZmw4cEpMbFMzZ2JCUi9VM2kxVmhvZVgyN29RMEtSN05SdkFo?=
 =?utf-8?B?Zzl1ZE1qU2xDcEFEQlpvNm9SbUJyY2tobkNvZjVxelc2UTl0VjFyU0NkcXNE?=
 =?utf-8?B?OHgweWQ1TjJmUzZJMEFBK0Q3TVJwS1B0bGRobjV6ODBjRk9VeW03ZXFiaGIr?=
 =?utf-8?B?a3JvTFBub0o0NnhsWEJ4T0U3L3Y5MTBaRitnUjEvK3M5WUc0Y0lseHBPcFpT?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Bt8jhSnP8jenJN5CbAyty/aGxOeeK7iKBej3IwFVUWdGNY7Ttbb7UkUHX6rMvCO0Y0ntm3qNF25W1iIolyAQ0zag84gHcXgVOrkGaMszZ1OFQ/FDpkKtdpE/xIQRMOGHUiEQbn87/tgJ7Ik2vcWbzDOoQ2tsyPj7kHTMOX8fknk1Vh24WeKnkjtouGS6zMhZWwFhsJqNGUq14us22G2U2OtPS6IUtvNf8PfhzN0onHKDpS1h1O2g6LYLVTdyVYO2LVAtTi/v3gfxvX2yZOauCk0ponZltuaxKjVLsFG1JIFvJLClMQetPiWer0Iz6zfeDnCNYS3rsSW+SXUMRiofDfrEwe+3efaVwVQhKRCZWBXSTCUp9oyx/ngcpCpguDOKEx1yDRxkMaktXjXJJGeaFvoKRvRFns2/U7u7ul5+u0rnYSfcvjuTrrrzuUkYnp9+flgrAP6lWuV7Wham5rU09PaVhaRKwvxpdtE51Tzm5wdyb+lydmNMKivwmjDEBWDcI0+Yq3tZPFQKB8cfmmdbNy+gKS9Fp+21jcaoDkGqJfVjS4QThJytWPOaWbI0/DjFCxZhzOeoT8c7ZPFLOrFn9JS7BIYQto5xKOXocYG6lxm9ftWROKW5SXYjUc1YYnQC0SSa/ShU9KQWgZV05gfnf5Ao9AiVRMDSP6Sp9WxOJhJxddZHbSB19K2pizgpvPNS/u2WEIXATJ13jAbeEJJlset/flqtylmi5jUBk2ulsXAtIDSiiYksPQNnjWeUB2+NoGTsf6ujQtgqKjFgSRkCDWG377lC25XWS2tckiEnokElLnqbyecyFU9FXfwJsqdTZftUMMKNmLq+3/NGXZ5NzNcAwFEzRM6INYkiHF33CVHQzHSHCOutceQIefNbCtC/htxGmR3oKCVKWxo7VlnFvIQhRUpEI03JYFp3mY/saEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636b8a66-27fc-40d7-5ca0-08dbfc0071d6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 17:25:04.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tr5iv4v/weKTp7gOYsn4JuMX4+E8HTQTONSgrXBU8giKjbFOoEQhc8U+NCBDqe2grr33J2vnqY5JZ54OIY1NYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_10,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130124
X-Proofpoint-GUID: p6TPaBfsate2sBMavMQq17usVZQhM-lq
X-Proofpoint-ORIG-GUID: p6TPaBfsate2sBMavMQq17usVZQhM-lq

Hi Igor,

On 12/13/23 02:05, Igor Mammedov wrote:
> On Wed, 13 Dec 2023 00:13:37 -0800
> Dongli Zhang <dongli.zhang@oracle.com> wrote:
> 
>> Hi Igor,
>>
>>
>> On 12/12/23 16:36, Igor Mammedov wrote:
>>> previous commit ("PCI: acpiphp: enable slot only if it hasn't been enabled already"
>>> introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
>>> bridge reconfiguration in case of single HBA hotplug.
>>> However in virt environment it's possible to pause machine hotplug several
>>> HBAs and let machine run. That can hit the same race when 2nd hotplugged  
>>
>> Would you mind helping explain what does "pause machine hotplug several HBAs and
>> let machine run" indicate?
> 
> qemu example would be:
> {qemu) stop
> (qemu) device_add device_add vhost-scsi-pci,wwpn=naa.5001405324af0985,id=vhost01,bus=bridge1,addr=8
> (qemu) device_add vhost-scsi-pci,wwpn=naa.5001405324af0986,id=vhost02,bus=bridge1,addr=0
> (qemu) cont
> 
> this way when machine continues to run acpiphp code will see 2 HBAs at once
> and try to process one right after another. So [1/2] patch is not enough
> to cover above case, and hence the same hack SHPC employs by adding delay.
> However 2 separate hotplug events as in your reproducer should be covered
> by the 1st patch.

Thank you very much for the explanation.

That indicates the two PCI devices will be detected and enabled in the same
event. Neither of the two PCI devices used to be enabled.

As mentioned in another email, I do not think this is the way to even workaround
the issue, because there are other ways to do mmio at the same time point.

Dongli Zhang

> 
>> Thank you very much!
>>
>> Dongli Zhang
>>
>>> HBA will start re-configuring bridge.
>>> Do the same thing as SHPC and throttle down hotplug of 2nd and up
>>> devices within single hotplug event.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>>  drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
>>> index 6b11609927d6..30bca2086b24 100644
>>> --- a/drivers/pci/hotplug/acpiphp_glue.c
>>> +++ b/drivers/pci/hotplug/acpiphp_glue.c
>>> @@ -37,6 +37,7 @@
>>>  #include <linux/mutex.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/acpi.h>
>>> +#include <linux/delay.h>
>>>  
>>>  #include "../pci.h"
>>>  #include "acpiphp.h"
>>> @@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *dev)
>>>  static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>>>  {
>>>  	struct acpiphp_slot *slot;
>>> +        int nr_hp_slots = 0;
>>>  
>>>  	/* Bail out if the bridge is going away. */
>>>  	if (bridge->is_going_away)
>>> @@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>>>  
>>>  			/* configure all functions */
>>>  			if (slot->flags != SLOT_ENABLED) {
>>> +				if (nr_hp_slots)
>>> +					msleep(1000);
>>> +
>>> +                                ++nr_hp_slots;
>>>  				enable_slot(slot, true);
>>>  			}
>>>  		} else {  
>>
> 

