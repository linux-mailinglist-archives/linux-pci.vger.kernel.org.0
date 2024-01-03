Return-Path: <linux-pci+bounces-1628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0211A823128
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 17:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7AE81C23965
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244A81B29A;
	Wed,  3 Jan 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NvdKB0Sj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SwetajyV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297BB1B297;
	Wed,  3 Jan 2024 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403FEUBM032308;
	Wed, 3 Jan 2024 16:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Q1PlW12qUNaHyfcsaQlFfV3fA0Zdx21UbJVAUMUnJXc=;
 b=NvdKB0SjJ7tQu7elJLFQqxxPxtwXJz+CU+0xAU1T7hdeB11KzTEWc+rfXYp3iN7j/6hy
 hlVBjwhGLCv+xRuJvijJDkrDBwozIQfRc5K4ZDSlOfoMQSciKdM+m4Z4sjG7b4rdi/TQ
 ilIc7dQstqwj5y5RI02mCdJtnmXsyABZqq5por9cohCVFJwR4Cvr9yW54a9+40NWZtHX
 M5NGE7E3CY0xF53TlFa0ua03W22fW9rag30EDa02NiU+taV5p7K692yKbN+TS+cp7ThZ
 Qdorr64aDIjrQTBEvVn/iRaC4vpEB8sQTF1R3VRiTlfWM1Rb+4kyK2kHcjYs9cgFQfWG jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vab3awags-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jan 2024 16:19:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 403GIqbe036095;
	Wed, 3 Jan 2024 16:19:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vdb08g0wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jan 2024 16:19:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfGD0++IenHAUHlWIR4/nPmLTDHCPGT/Z30ffNjDyOHBjL5hr6DAY7SxweiVVQMHpv309foNgw2POQ4fYCKfVSM2kQLNJQOw3uSX6uxCtD482rfjvDn8RVMB1asWAx+9ugEY8yIBH/YhTOeyr1hl/R97634GA/c4dcKZfrtS7eZuhCCf0vfjFMEk2in+4cTZcX9mXh5xkKJck+vOaU8kL7f5BfDbi5/UONxKNpyPulm2UpBc02PEWu6vmanggO9bmvWcGopjZYgJ8BeNhLYBofSTrUKZd8J5+WNcalX2/atNMY3g5QbNIxv+nhGapb42gmB0SPkIflwxrueQSTV9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1PlW12qUNaHyfcsaQlFfV3fA0Zdx21UbJVAUMUnJXc=;
 b=ewGtgyBX9v1a1znb8DKa6sjrTTcrmjYBTCxozr4YE5EsCzyKwY0B10oJIqLH7Tq09J+cQRniizEVm+e3Txn+WQQsbM1Pgn/io3lT9s4GYALPYgepKb9Qh7wh8AI0rjV4RU+Y6lTSdW8K4awghNgGVIbNQNhwyaq3R2PWGMFZTBExd/eTWnk74FoIpRykBp46bq+bMf0sG6+rXPWTPtmBs6XUDpWp0CcEVX5zkCWnbeZ1Kbvs33rn2DvZtxFiNCQdEaL/Gr65Xb4Uq0yGtVRT75ZdQq485kZYD76bm+IqLWYrLtkZfVtd/M9qEJvauypTXJTmfzau80Sr27kXsIbxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1PlW12qUNaHyfcsaQlFfV3fA0Zdx21UbJVAUMUnJXc=;
 b=SwetajyV0P1uMnEu0PIaqpcUd1MZkhhkzYW3n6zQtqKpazqQxFwcdUfjVomUbHgM3dXg7qYdvZBgF5pJWBYsEKNmwYZwOJaa8ZQX83D1Nau6J5VSJpAj/RBZVAjBtQ+4y2tKJ7u1lRTyFTJCGOS2/Acv7IXKQwEH/GgqMe0/aSg=
Received: from BN7PR10MB2659.namprd10.prod.outlook.com (2603:10b6:406:c5::18)
 by SN4PR10MB5591.namprd10.prod.outlook.com (2603:10b6:806:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 16:19:07 +0000
Received: from BN7PR10MB2659.namprd10.prod.outlook.com
 ([fe80::42cb:adff:cf30:d93e]) by BN7PR10MB2659.namprd10.prod.outlook.com
 ([fe80::42cb:adff:cf30:d93e%7]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 16:19:07 +0000
Message-ID: <e11aac19-981d-11ad-d49f-f104e7dae133@oracle.com>
Date: Wed, 3 Jan 2024 08:19:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple
 devices at a time
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
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
 <a8db0ed6-05f4-7c2d-c63e-5f2976d25a45@oracle.com>
 <20240103105458.1f548f33@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20240103105458.1f548f33@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::29) To BN7PR10MB2659.namprd10.prod.outlook.com
 (2603:10b6:406:c5::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR10MB2659:EE_|SN4PR10MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: 200841b7-ca7b-4b27-ecc7-08dc0c77b5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KYQncMi5F5PYfAThSyuouA1wbQZVOVrPQZ1fOlbeSpujJTQVfKbb+BFFYVI6SVHkXuH+6VrVUYb6ZMq0h9XK7artAb7DRhlXT0yGEqYFPGjaflz0rzt4Sk8Ln7Wa9n22lyRhMMM07gRIFqQKpvP6j18+5rUw89lu/sdF8q900uiLhMZ11viipdZe1L5NtvPCi7sDm1n9CQbUr6hmOIbRxmCLeXXIJ2Fsg6cuOqa/oq24SsQtGINi925ANiZLxeKQrjBwfjv8ESCdgSUevvPgZ/0TcoLiaFTfqOQJEOCgomQG0vF6CaJF5GQ7zJ6jTvMfAnsUQxMHIZTTC9TXY4pJPCc0nKhwHrkIPYibAgU6E3Oq3NrlE/InTX4OKzAmY8q6LfMOVa2x7Gr8hNDm7I6/1WqfO1eWkeq4I/fMFQKf12zKOT3VlubzHHTvQc6o6VuVQbhDum+D2PcJJnp7y4jf92WG0DyudgGQ/N300BPBxgCIH6k6u/4J9egAD8i6CiuDNUGIMSndXQExv1PXh9RCbvATsWLlVIRPhrvTNDUV/n9i3Ioc7HHgFYvTxcUBr9DtvP/rs9JpU09F/drJrN+jFYYBcI+0cZJMHpodIrTZ7jG+4FnAzASWNAYCNWfaQn6650glEbOCmwcTV0ktJA5WAg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR10MB2659.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66899024)(31686004)(6512007)(6506007)(6666004)(53546011)(26005)(2616005)(38100700002)(31696002)(86362001)(36756003)(41300700001)(8676002)(44832011)(8936002)(4326008)(83380400001)(2906002)(7416002)(5660300002)(66476007)(66556008)(966005)(478600001)(6486002)(66946007)(54906003)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QXRYb2UyYnprVTd4MXdmeHdnT045dGVhZW1zbVlxWFFiUDU2SFBrcGFJNGg4?=
 =?utf-8?B?dlZ1Z3ExTUxuTldlNUxGT1V4VHBVR0owVEkzNlAwWmJkcEJhNllTL1g5b1JF?=
 =?utf-8?B?OEVDVkZzaVJ0ZnEzdis5QnFxVFhiRFQxR0N3bEFkNS9tR1dRTS9RY2txY0dq?=
 =?utf-8?B?LzY4RFpJcEJlMEVkcGVIbWxjY2FrMENzUHJlQk5WQTl6elpCQndJSEF6b3V1?=
 =?utf-8?B?VnUwUlVqbXBLbG1XeVkzek80ZmhuWHRha1NOQktkc0lydVVkV0RSWnBPZkdK?=
 =?utf-8?B?VllmZjlOZ2pscFZaWDMySW5CTEo3NjEyVnB2ejY3cnZNNStDajJ1UGsydnhv?=
 =?utf-8?B?VFJYcThMSE9uSHBQSVFoTGJNR2VYNXF4NXZhWE5kYjB1ODZGYmJ4eGluZitC?=
 =?utf-8?B?ZHRkbysyOW1kQkRUd1NadzlIbjN5KzNXenJTODBZWktXQkNEbnJ0Tk81QVk1?=
 =?utf-8?B?SkhYTXNya1VaQ0xNbWovWHN0YjE5dStDSGVMNHl2YlZEWHROR01ROTdOQXQ1?=
 =?utf-8?B?NWVsR0hta2JnVnh5MDR2TUZMZWd3eWs0ZUtWakNKazBxY2gvTDhNUnF6VDlx?=
 =?utf-8?B?L1dKZ3gzMWZkajFMSHNGdmFPY0JCZGxaOGM0OVJ6VVhtL3VSWlpueU1pa2hF?=
 =?utf-8?B?eWFjL2dqRU1qa1NucEowWEVuOXZlb0NtYjRxay9oc1FKcy9RNmI4ZThVQ2I1?=
 =?utf-8?B?SUJoZTR6TmR0QndLdFVENStRcy9PS1ZJeTE3STQ3Z0g4L2pRRWhISFpHVXJm?=
 =?utf-8?B?Nll6dU1uWFBPVkZSTTFXb2VGZGtoUmRlWTdtNmthakRBV2EvTW40Wll6L2x5?=
 =?utf-8?B?ZldsUjJLRnlmL2ZpUWhuV25VUVlWWTcxZ3E4M3lGYnl6TXQvUWtaYVBGVnYr?=
 =?utf-8?B?RTZvVEdDaEg3bk4wZk52b1ZkQWZjei9NTUlrY29NUmx1a09VVW9oOFRaM2Fk?=
 =?utf-8?B?L1ZYcERTUkx6SStLSksrbWZLcU56S0lDT2xpVGIxTnFpVFltUGYycVBYVVdY?=
 =?utf-8?B?UExkYXlsRW1PNXJ5SXFXczVmM3hzZkNYdnNDOHlzTUlub1VvYmNpdHh4L2t0?=
 =?utf-8?B?UjZkTVF3Mms0bms3ZHhta0J6T0pBRFpXdlNVT2tZMm5HcVA5TVZHUitLUFhB?=
 =?utf-8?B?OXl0WG1UZldaWXZSNmhINEcyeTl1ZjdacnhucUgvcHJTUVlOU1hudFRuYWlF?=
 =?utf-8?B?RW8xR24yY1NGZWUxbGd5cU42K0grNDhqMzNNcUthYzJnbnBmbWFvbEJnY2pj?=
 =?utf-8?B?NHgrdlp3ZUFQMGY1MkMxTXdkOVZaK3FSVFRGakduN0tkVG1mMC9ua0FFTGhB?=
 =?utf-8?B?aTBUYS9PQ3NzUURsTnN0K0VmTGZpc3pZLzB1KzJmUkRLOW5OYSt1c3RZY3Uv?=
 =?utf-8?B?ZE02RHkzUWlGdFc3Y2lnajNEQnhzc05BTWs5b0F1UlJ0bUx5cjhUazBJR1Nm?=
 =?utf-8?B?VXFLZVBCSUlCTm9Wa3luV0tIVWVRODN0ZFZ3T3oxNGFLeHZvNUVTc0FsL082?=
 =?utf-8?B?cDBJOTlzQTJqRVlXVGpKdzFzK3J3VVBIQTlFVEkzV0lxNDdMTHRVUUpWSGta?=
 =?utf-8?B?YzdoMlFCY0tBQm9hNi9GN1RsWVRraHlVVjA4M05KNURHVDROVmZ0anhNYkpE?=
 =?utf-8?B?cGM2UFB6VklIY3plKzdWR0V6cXZlMGJCZjRmdnk0OVZLaFNLZnhzYm5NYWhm?=
 =?utf-8?B?QXFSS3RJdUNQaWhhbVJsZHBPVm9zS3FIUTFBaDhyUGJ6MUZqKzBhQU9acGQz?=
 =?utf-8?B?VVMzTVc4NkwwTkhrelJsWkZLMWJ4c0ZpQW1PTjFRS0ZUSi9JMjFCY0JnTGhq?=
 =?utf-8?B?SjhjR0FCUFpsMVZIZVZjVDloOURwd1prSTAyNmlnRURsVm1FUWRGYXBGdUY5?=
 =?utf-8?B?WlpMRzBWYjdHVjRCVkNON25HNnlLclRZU1g0dmxoZG13UWFFNi9sdzNrbjc1?=
 =?utf-8?B?SjVJZ3FTeFpCWGdPakZqNkxQRktMTE1xaFNSd3Y0djZLRTZlTGxUVG5VdFNt?=
 =?utf-8?B?MGExckp5eXJ5NW82TStHOTNIVUFseVVqZ1RyV0txVEhpcHgrdHdyZzdLZFcz?=
 =?utf-8?B?d3Q1bHlpYmRqYUE5RENkd2x2WmdLT1BWQlEweEhUV3E2bnQwOGF1eTVydEZl?=
 =?utf-8?B?SlNRNFFUVkpLbWFaMUZ0dlpIaDMrSnNxaDFOa01pQS9wNFZEU1Y1bzc2b2lr?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vk2ppmk83pcCsMii1kEzjcqZ2sU6adxoPgIAvKR9cKHN6TMwsQbKMVqd27dcsh9W1k30prDy0yfYabILtUAnFEs7NMw2ttXsSgbKaYOrLlhEzGyvtPsRSlWeYFAt85U4pJwLvfeLmIFXSTxwsZ9S3Mi2GjfgLPkT+2mVo/jUapflgNJXzEcAreroyhXArLM08zbBVwxqfkA5zdR64WIXSh+ATC2iDRdsURkpaIuR42DEZW1GXmXzSIaU4ncuJgpxY7p1F2W8q/kQBefcFBhC3R5AMZPpwSoLrmanAq9P1GCkCD9Jaf57TL+zKImorZ1toOU2Y8RTMfT1YFywhpG76r3ummceX2UgWaLeUmNbKmRNfRLSBul43XVG7eWE+LuLIPfbvYzOB4qdwWD7seE5PjmZkxxFbkFyDHMNE1X5XaPt4YM+af02Jwt/Ok5TQG/JXMxLIqLocVcTA8m+TljgXIGx1OhXW0BDaLYGvWayBAJpH7yFVqM8QWALG+oSo6svl9fPJfQPRcWpC+YkjBb3moVUE37MpZm9Gm49A9at+vFw8bHuJZ0ayaWU7RHjJ1UMFLjZGoQeJiOt37NZmXf9T5Nwr5hWMG8i5JMgWqEMwgs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200841b7-ca7b-4b27-ecc7-08dc0c77b5c5
X-MS-Exchange-CrossTenant-AuthSource: BN7PR10MB2659.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 16:19:07.1993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NX82fk5bAQANknxEUSEBLhxpNrtxN7Uok+iRhBJh6Wy7D6aXjqIBwjjhNUGBr9XLW82vJ18pqcx/kugZ1JpVOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401030133
X-Proofpoint-GUID: Q5UKLk4XqbZcqIPoUic8yycOUWo-D0Ne
X-Proofpoint-ORIG-GUID: Q5UKLk4XqbZcqIPoUic8yycOUWo-D0Ne

Hi Igor,

On 1/3/24 01:54, Igor Mammedov wrote:
> On Wed, 13 Dec 2023 09:09:18 -0800
> Dongli Zhang <dongli.zhang@oracle.com> wrote:
> 
>> Hi Igor,
>>
>> On 12/13/23 08:54, Michael S. Tsirkin wrote:
>>> On Wed, Dec 13, 2023 at 05:49:39PM +0100, Igor Mammedov wrote:  
>>>> On Wed, Dec 13, 2023 at 2:08 PM Rafael J. Wysocki <rafael@kernel.org> wrote:  
>>>>>
>>>>> On Wed, Dec 13, 2023 at 1:36 AM Igor Mammedov <imammedo@redhat.com> wrote:  
>>>>>>
>>>>>> previous commit ("PCI: acpiphp: enable slot only if it hasn't been enabled already"
>>>>>> introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
>>>>>> bridge reconfiguration in case of single HBA hotplug.
>>>>>> However in virt environment it's possible to pause machine hotplug several
>>>>>> HBAs and let machine run. That can hit the same race when 2nd hotplugged
>>>>>> HBA will start re-configuring bridge.
>>>>>> Do the same thing as SHPC and throttle down hotplug of 2nd and up
>>>>>> devices within single hotplug event.
>>>>>>
>>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>>> ---
>>>>>>  drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
>>>>>>  1 file changed, 6 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
>>>>>> index 6b11609927d6..30bca2086b24 100644
>>>>>> --- a/drivers/pci/hotplug/acpiphp_glue.c
>>>>>> +++ b/drivers/pci/hotplug/acpiphp_glue.c
>>>>>> @@ -37,6 +37,7 @@
>>>>>>  #include <linux/mutex.h>
>>>>>>  #include <linux/slab.h>
>>>>>>  #include <linux/acpi.h>
>>>>>> +#include <linux/delay.h>
>>>>>>
>>>>>>  #include "../pci.h"
>>>>>>  #include "acpiphp.h"
>>>>>> @@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *dev)
>>>>>>  static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>>>>>>  {
>>>>>>         struct acpiphp_slot *slot;
>>>>>> +        int nr_hp_slots = 0;
>>>>>>
>>>>>>         /* Bail out if the bridge is going away. */
>>>>>>         if (bridge->is_going_away)
>>>>>> @@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>>>>>>
>>>>>>                         /* configure all functions */
>>>>>>                         if (slot->flags != SLOT_ENABLED) {
>>>>>> +                               if (nr_hp_slots)
>>>>>> +                                       msleep(1000);  
>>>>>
>>>>> Why is 1000 considered the most suitable number here?  Any chance to
>>>>> define a symbol for it?  
>>>>
>>>> Timeout was borrowed from SHPC hotplug workflow where it apparently
>>>> makes race harder to reproduce.
>>>> (though it's not excuse to add more timeouts elsewhere)
>>>>  
>>>>> And won't this affect the cases when the race in question is not a concern?  
>>>>
>>>> In practice it's not likely, since even in virt scenario hypervisor won't
>>>> stop VM to hotplug device (which beats whole purpose of hotplug).
>>>>
>>>> But in case of a very slow VM (overcommit case) it's possible for
>>>> several HBA's to be hotplugged by the time acpiphp gets a chance
>>>> to handle the 1st hotplug event. SHPC is more or less 'safe' with its
>>>> 1sec delay.
>>>>  
>>>>> Also, adding arbitrary timeouts is not the most robust way of
>>>>> addressing race conditions IMV.  Wouldn't it be better to add some
>>>>> proper synchronization between the pieces of code that can race with
>>>>> each other?  
>>>>
>>>> I don't like it either, it's a stop gap measure to hide regression on
>>>> short notice,
>>>> which I can fixup without much risk in short time left, before folks
>>>> leave on holidays.
>>>> It's fine to drop the patch as chances of this happening are small.
>>>> [1/2] should cover reported cases.
>>>>
>>>> Since it's RFC, I basically ask for opinions on a proper way to fix
>>>> SCSI_ASYNC_SCAN
>>>> running wild while the hotplug is in progress (and maybe SCSI is not
>>>> the only user that
>>>> schedules async job from device probe).  
>>>
>>> Of course not. And things don't have to be scheduled from probe right?
>>> Can be triggered by an interrupt or userspace activity.  
>>
>> I agree with Michael. TBH, I am curious if the two patches can
>> workaround/resolve the issue.
>>
>> Would you mind helping explain if to run enable_slot() for a new PCI device can
>> impact the other PCI devices existing on the bridge?
>>
>> E.g.,:
>>
>> 1. Attach several virtio-scsi or virtio-net on the same bridge.
>>
>> 2. Trigger workload for those PCI devices. They may do mmio write to kick the
>> doorbell (to trigger KVM/QEMU ioeventfd) very frequently.
>>
>> 3. Now hot-add an extra PCI device. Since the slot is never enabled, it enables
>> the slot via enable_slot().
>>
>> Can I assume the last enable_slot() will temporarily re-configure the bridge
>> window so that all other PCI devices' mmio will lose effect at that time point?
> 
> That's likely what would happen.
> The same issue should apply to native PCIe and SHPC hotplug, as they also use
> pci_assign_unassigned_bridge_resources().
> 
> Perhaps drivers have to be taught that PCI tree is being reconfigured or some
> another approach can be used to deal with it.
> Do you have any ideas?

This is not limited to the kernel space. The kernel space may remap/expose the
mmio region to the userspace. The userspace program may directly interacts with
the PCI device as well (DPDK?).

How about stop machine mechanism if we need to touch the PCI bridge window, to
guarantee no CPU is actively accessing the mmio?

Thank you very much!

Dongli Zhang

> 
> I'm comparing with Windows guest, which manages to reconfigure PCI hierarchy
> on the fly. (though I haven't tested that under heavy load with several
> devices on a bridge).
> 
>> Since drivers always kick the doorbell conditionally, they may hang forever.
>>
>> As I have reported, we used to have the similar issue.
>>
>> PCI: Probe bridge window attributes once at enumeration-time
>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=51c48b310183ab6ba5419edfc6a8de889cc04521__;!!ACWV5N9M2RV99hQ!KCs-3SYiAH9t7yzAmSJlDD-YJ7bo0z3Syg9VYF8JJ3JTkYeoSINQD4Tx_7NpDxWeL04FF5lLWlQHrZMsDkoY$ 
>>
>>
>> Therefore, can I assume the issue is not because to re-enable an already-enabled
>> slot, but to touch the bridge window for more than once?
>>
>> Thank you very much!
>>
>> Dongli Zhang
>>
>>>   
>>>> So adding synchronisation and testing
>>>> would take time (not something I'd do this late in the cycle).
>>>>
>>>> So far I'm thinking about adding rw mutex to bridge with the PCI
>>>> hotplug subsystem
>>>> being a writer while scsi scan jobs would be readers and wait till hotplug code
>>>> says it's safe to proceed.
>>>> I plan to work in this direction and give it some testing, unless
>>>> someone has a better idea.  
>>>   
>>>>>  
>>>>>> +
>>>>>> +                                ++nr_hp_slots;
>>>>>>                                 enable_slot(slot, true);
>>>>>>                         }
>>>>>>                 } else {
>>>>>> --  
>>>>>  
>>>   
>>
> 

