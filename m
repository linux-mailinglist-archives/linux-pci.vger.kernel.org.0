Return-Path: <linux-pci+bounces-26951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBEBA9F93E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 21:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A45D5A05BD
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 19:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8737296D27;
	Mon, 28 Apr 2025 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZvSrzHJF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jgxgf269"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883B296D1E;
	Mon, 28 Apr 2025 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745867529; cv=fail; b=FlMFxbJQ8syBrYrM54xgkb+NWTrGfoN6HloPKXofC3hjoY3zrtUpqE14GRJ/Hy7y2DbfrsqVXKuykdoHYhNYDv+bp6Khg1J1loonyB+ogNFGo8aDPWlBPbFnc8P4xNTpw4RSgYk2JbVMWq0eHIR+Cqqpjjgi/jYZr2kARgKfEOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745867529; c=relaxed/simple;
	bh=jOCEzc8oppxxsmvbCR9BMM89X88NbQFRweM2Q+siWtY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RfejfBYe5u2L3Gp4Mm98MeM2i3KwLtMn48ORE87EKUkRDAQ2UD77UMIqpAgKuox7CpUBXH5SIrEDOLa108bdr1nczbV+Hv4kn8qc/YGzY8vSa7UdWqWxZLg5/RDiXQflDyVPJ/gmgI81CyxuIejFl6a26tSYv/X6tUZpZnsIOXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZvSrzHJF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jgxgf269; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SJ2Nbb016181;
	Mon, 28 Apr 2025 19:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xe326jP2JIetMoM0SMtKiPSxICWZ2VkGjYiULfFE8GU=; b=
	ZvSrzHJF2ixMsN9xHioXIk6yMQiag2Cvwgwct/ph1RagAYiOdKOC348GlLk99Bnc
	XCYuM5FzEE+wA+fThFoGqZWn/HacQWvCyXzWCy/Dk3EPh3Y2V+2YhjPq9VMi3oj2
	NEdgA3BPPAJKi2Ij8me2TBashBdToEM3GvAUss10HuLG4ZCYDKjV1zQBTR17JHC3
	h3Y/Iz5gVdK8aU1RRY1sbi6HctpjW4O0CXbt+NOhIfUH9XDrzb7mO2rVXfS9hpLL
	VRw8zc9YPeYLgWD6KjjwXpw8J+YQRZYCaJq4Hpi+sBX87cB03mud+c6wwSmKGPUm
	01t0SUB87n4TuqyXF+/9+Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46affng10x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 19:11:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SI2YFq001369;
	Mon, 28 Apr 2025 19:11:46 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013074.outbound.protection.outlook.com [40.93.6.74])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8ufv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 19:11:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQrxubQs0pbyWQXNmUFrqkbHwQRxdxy3cs6NJM2+6qHhpKoP9yUVdy+II2wTyUVBVvuNMicr54rHDtBPOdQaaIh5gXhg8slJ3WIcfRFpTjF5Umo7WqzK8EcwHw9i90YRfhTlOwmncIIkCYODN/6bHa0aM98XbfCSXNoPec36VKtyrGnnsuV+Es8o3Ngt+gI0hU+/hX6ngGXsYofaDHpwxoVzf6GCmTONDhZ4q8RgjhZWeMxdn5sox57r1t4UM5DJ+kEX/IyKufzu19hnbg4VhyD7q/KCN6r1kRBu5V2+Kr9mcb2hTqtOP8/Etf+D2AsUxSc2CC6rU600Xj7zbcDp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xe326jP2JIetMoM0SMtKiPSxICWZ2VkGjYiULfFE8GU=;
 b=u3ACxe0pK5/KJ1UhsTONpnf8V61jYGlb/Dpn1Rcmm3eG/U2CAcGhx8HhcpSVNNbYA5QG91CdsEFJ638f1DrRWIkuSeq3CBRkotst7ZLR+D68NlX9upBvjoD25+By/NAgsq9mY4VQXx/b4SfdgMUK6RXb7yXpp4M5sWxoxHIQzCC5qXhfK94jxTkLQts08+9xO2TiIh/i4xLoZUfCBqFnQ+CLJFJmOa/ZeYynznIDr4rDQeJ+MJejSxWXshwilGK+0oUkmY5faIHzkWb8n3mXRGb4gqJ8F8HnGZUwH6VwRI0/Rwye4GbV7rDk8LSqplSj9fvrjpb9tKqG5g5lCWhWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe326jP2JIetMoM0SMtKiPSxICWZ2VkGjYiULfFE8GU=;
 b=Jgxgf269mYL3Ufm6EeOhvDY4R6jXo11WJe39Xan/xsiI/iXP29ymCwV9CnV5VqZZwuqax9hal/DxWHaXDQ0Exzwy0kPgGjORwgbPckzNSFqhR6mckDwCEKIFzFnpwlxTxCaviTrQEkzr6ye5xe3jNIl36EN/VFAgS1UjeuQzcXY=
Received: from PH0PR10MB4775.namprd10.prod.outlook.com (2603:10b6:510:38::24)
 by DM6PR10MB4171.namprd10.prod.outlook.com (2603:10b6:5:21f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 19:11:43 +0000
Received: from PH0PR10MB4775.namprd10.prod.outlook.com
 ([fe80::a4f5:cfa6:b6d5:a268]) by PH0PR10MB4775.namprd10.prod.outlook.com
 ([fe80::a4f5:cfa6:b6d5:a268%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 19:11:43 +0000
Message-ID: <bab1c156-ed5a-4c1d-8f0a-dd1e39e17c99@oracle.com>
Date: Mon, 28 Apr 2025 12:11:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Report: Performance regression from ib_umem_get on zone device
 pages
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: logane@deltatee.com, hch@lst.de, gregkh@linuxfoundation.org,
        willy@infradead.org, kch@nvidia.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
 <20250423232828.GV1213339@ziepe.ca>
 <84867704-1b25-422a-8c56-6422a2ef50a9@oracle.com>
 <20250424120143.GX1213339@ziepe.ca>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20250424120143.GX1213339@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0370.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::15) To PH0PR10MB4775.namprd10.prod.outlook.com
 (2603:10b6:510:38::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4775:EE_|DM6PR10MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0ae0cc-6194-4a10-724f-08dd868882ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1BZaTU3S0UxaExwWVZ5N3M5bjFsR2RsQ2M0NzBwSXRRbFRNRU04eGNvTE8z?=
 =?utf-8?B?WVpqbDZuYldPOW80MGdQalpTUUN4bi9jSnQ5YjArVFBzalRnU3JWQzA3REdy?=
 =?utf-8?B?dUEzSHVTaWpsa1F6SE93dGJwd0RpYlg4OWF2OFRES2ViWGRuelV2azBDMVow?=
 =?utf-8?B?QlFSbzcrKzJQV1BLNlpEc3hyTUNrOHZodDM0YXM5M3hTMkloVFMvbU9HUWF4?=
 =?utf-8?B?bHlyQyswZWZyZWUrZkdTWEN6REhnSktLU2NtTlFmeXMrdENhOVQ0c1NudWU4?=
 =?utf-8?B?TEd3bTFLbUZqYW9tb042Ty9obU93dEwwWExlelpjc2tKcWtYcCtFcEEwT2pI?=
 =?utf-8?B?TFRTM0NaMDQ5ZERFMC9waEZxYlVlVkc2azFQc3VyVC9aVnRvZnZERUgydHBC?=
 =?utf-8?B?Y0Rzc3ZuVE9TSTBoaWgyZkkwb1NSZ3dzWjlHTXArRW9aTnlzQTJzNUY4TWZr?=
 =?utf-8?B?Y08xa29rTWg1NC95S2pGK2pkR1N5NGRCL01WazRZTmxiUFBaNmErQ3gyWEsx?=
 =?utf-8?B?b0tJaTcyUEZHbEJVTjBVSkR6TzJjSkgxYXQ3V0FXQmNrNWlKR29tZHR1SXdl?=
 =?utf-8?B?TGMrRzZkaGhvY3d1dEh5bSttVGsyYXpCWktuTzV6dVFzaStDdmpNTjhZM3ZW?=
 =?utf-8?B?SnJvUmNVVHJpRDR0b29IQThIZ3BTNGR5SEc0eWxLMXFMLy9MUHJucitJZUtO?=
 =?utf-8?B?ZzBUQWVoaWFkRVgrMXFMUFZVcm9TUXFzVVREaHFMTkdKV3k1aUtPVHhOL2FB?=
 =?utf-8?B?L2J0VFBwZU5xVUh4bFprUHV3NUl5Sk5iVzU2Tkw4eWdtRUJwbEdXcUducHFJ?=
 =?utf-8?B?Tis5U1RCNmNTYU1DUjZHOEZuUHNMTUZZandBL0xSU1VHbjZzQmlnOUZyU2hT?=
 =?utf-8?B?TUU2MG5hT3VOWjNxZ2pBT01tMmJtTGVhY1VYRlF4c2VwSXZpeVI4dkdEQWpU?=
 =?utf-8?B?Z3loMm1pNHUvSnBzQjl4OVB4UlJqNXZoYmJhbjVOcHN0R3Fwd0Z1SGc5TTJH?=
 =?utf-8?B?WkFhdFJ5TTl2bUR5U2NCMjEyeEdTV202WWVZcldnL1Vrck1DWXdlQ3RjRUlJ?=
 =?utf-8?B?TTd4MEgvT2pnMTVNYWpDRU9IODg3YWduVVA0U043UElkbDV1dnpUQ2RLUERq?=
 =?utf-8?B?aXFyZjdkT2x0RmNZNjVEdVk2Z1JyZzErRHAyZmdEdi9oOHFVVDVhaTJWN3cw?=
 =?utf-8?B?NlhvU3IyM1R4SHFPdkNMdkJFS1BiVk1kVS9YZFgwemxzWmxsODhMa1VQSmpa?=
 =?utf-8?B?SGwwTDNxREVDRXEvSmR5TUxDa294NE96T3AwUlp6V2psN0xSNWNIQjFzdldw?=
 =?utf-8?B?TDR5OFNMSXRrMFpYTHo5ZzkxcXZkakxrUEpJT0FQcGVuL2hlZ3RTeGwvOU9K?=
 =?utf-8?B?aUJUOVpZWncrTjBGVmxyS2lvbEhucVdFdDk4ZGRBeWRPdnZ4RVJsaUQ5bkNU?=
 =?utf-8?B?VzdyWWJLbVg4U0Uvb3BMTW4zK01KZDhrTFpLQXJmM0pkVjdxdTJiUHpKZUE2?=
 =?utf-8?B?K2FydXNKQzFPNlNZKzlZYTlFNHJkQzVZdlQ4VU1ERysvWFVtMEZJbnBvS0M1?=
 =?utf-8?B?OThSWnZJQlFEYkRvb3BSWlJBSjBnNUt0QzB2Rk10RlI2cWVWRDdZT1RJVUZV?=
 =?utf-8?B?NU5ZR3dRZDFkZjBJUkJIUkhyN2hRNWVzcGFHU1BtTHNWdE1BV1FkSlFFa200?=
 =?utf-8?B?NE9hazdRWXYySytBZ0NlNzJjb3Zla3hjWjlCRFdZTVh0TCtJdUxYSFRJMXhM?=
 =?utf-8?B?M1FVSEtJcDBMTURMcnZyaGR1QnhDWWM5eGNtT1VVVlU4Mnd1Q0xxM25SMXB1?=
 =?utf-8?B?YTNDM3lrdkg5aE9PNkZDL3hHNWdOdjJkdGdPMk85SmhncGo0TDJORm5ZaFVC?=
 =?utf-8?B?ZW5NeEIzcHViNWEzZE8zdFlhZW50eWlIVmI3Z1ZKblFMN0J3d1ByYWVxMUEy?=
 =?utf-8?Q?kgXaSiFYPtA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4775.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWJLVTU5QTF4OWZmcExjYkIzR0I0SGtkRlJaRTlMTXlmNTBVc3FvU29MTFUw?=
 =?utf-8?B?OGZUNHZQeDVWOUVQVTlBaW1KL09VYzRmNHUvTjlKbEZMbmo4Y1RVTjFSYWhF?=
 =?utf-8?B?eHpMRTJKbm5La0c1cHVFRk54MXNydmt2UTBWWHhyZEt1MVpvV3BRR0RiU2VS?=
 =?utf-8?B?MUk5aGlWcHNiSzU0WkxNbWpKOWh4c1lxQ2Z6aDlEZSt4TWw0azFlWDFNanJj?=
 =?utf-8?B?TUZ6N3Ard2x6Z3l4ZkdHbndQVmRVNC9MOWkxdlJaOW9YY05TcFl3ZE9BMXhC?=
 =?utf-8?B?TWM0NnltVGFCK1dNWjhlZm44UnVoYlJrWkJWdlMyTWNzblNyQ3UrYXZGU29w?=
 =?utf-8?B?SVNvWFpNT3pmSzlDcDQ3Qlp6d1ZzVGx5M0pYUllwM2I3WkJ4U05VNXJWWjZU?=
 =?utf-8?B?UjdWa2FoZXFuaEUyV3J6ekdFU3BKTHBoeDNmNUpRbTJDcXF0RHZMazRNYStu?=
 =?utf-8?B?MldGd3ozRFBwOFZmNjFKaHhML1FMZVVDaGtFNjlva1Z2OWVZdkNpbkhRZzFS?=
 =?utf-8?B?UUJLbHBWYUI2d1pVUFIyaTJ2UkRtaDlLYWtTZ0x4U0JMcCtpek40RHdtelAx?=
 =?utf-8?B?cTBOZTR6RExUM2owTElWM0FiRWNOTFpHaEdZMTZvOEt4M01pZzBPN0RadHVl?=
 =?utf-8?B?MkZMUTliZnJiSVROUlB5S05LSTdXM2FRb3FoRkkramlzMTRrMlN0ZiszV0Rx?=
 =?utf-8?B?WkE5YWJqMERrVWpWd1k3RExZZTA4MlZrM1FsZHIyUllIZS8zRS9WMXVMWEpp?=
 =?utf-8?B?a0Jrc1l1aFA0SzJMYUprS3RETHd2eHo4dXpPdjN1bW1jcUtPQUpPZ3NNMGZx?=
 =?utf-8?B?ckg2NTUwQUdhcXNwZjVTSmhlL2xnNlVhYWpMVnhtOUx0NDNnMHJqejZDWEZ4?=
 =?utf-8?B?NStXTU5RTTlXNDBJWng5MS9CR1lIT1dFZFdEcUFHWUxnZGZOcEpWVDY4TXhK?=
 =?utf-8?B?NTBiVWhWUWZPM2JabE1HREdiaDYwcmF3MG54QVpkK3k5emhLWWdveU1qcTRm?=
 =?utf-8?B?dkp1S3ZqbGVqUEpvUWd0ZkdzSjBQWEJnc1E3YjE5TVBGU09uUU10bkJIbVF0?=
 =?utf-8?B?bTRDdEdDRlIyZGk3QndUTG5GNHJXYUFsSkJxenJlMW1aMDRMUkprTWJkTllu?=
 =?utf-8?B?T2VZTms5RmFwN1h6eTFkanYwcEpBZXhaRDU1dlhma2orWUcxWWs1TFVLQ0hq?=
 =?utf-8?B?YTZyWkFXSDNhK1AwZTBwb0Y4YjBwTkZ0aEMraU1vN2JFMkJDdVpNRVRDZFU3?=
 =?utf-8?B?RVVLZ28rZmJMbWlyUmQ1WHpZNnY3Vm5JQWRzL0NyWWNIR25mVDlLN2xvc0VZ?=
 =?utf-8?B?enBZaGhDWTZuOHJ3c0FlS2ViWm9FYnNqQklWQi9BWGVaNmdlbGg4eUZNTDkz?=
 =?utf-8?B?NEN2UHBWNkZzS2ZDR2FNdjlncnlJL2FUWHQ1cHJRaW5PWlk4RXIxemZ1QVFO?=
 =?utf-8?B?a295NDQreDV4ZW02TDgybjI3UW53OVl1OTkyRmFOKzJSVHNrUVBobU0zeFdX?=
 =?utf-8?B?Q282aml0TGNlajB1MWtWbmwrT3RzYnN1dzJnQklMajVJalFGQlR2NUtrVWQ5?=
 =?utf-8?B?allYcHY2SVNQdHRHODNoSUNiRDRKbDI5amFBb0lHSHlES0p5ZHpkL3oxOW40?=
 =?utf-8?B?QzA4QWFrNGFSVTNmM0U3TkgxNDRJN3d5OFpWOGFSeFJDak5FYk1xV2NJZlRk?=
 =?utf-8?B?N2hUeUVGS1AyNGJ6cFJUWnhoYkJOL3NUeTg4ek4rSTM5Z0NVZUYyV1NkUG1J?=
 =?utf-8?B?WERrVTFzcHFwZHlOL0xqZ09jeldOOE92bzVXalpZVjVGMmkzNUR2dHNiVkx2?=
 =?utf-8?B?V2grb1ZtTVR0K0laczhGaGZ5c1NNSFByMEJvMmFnUEZJQ3R4SWluV3JpcFdt?=
 =?utf-8?B?WHMyZnBxYjNxKzhhVkF6Z2htcm0wdUtwaFp2bE12SUsweWZ5U0Y5SSswVjY2?=
 =?utf-8?B?UGNFQWNhZFZINUNKSUs1SEFlWm5WZDdLMC83SW54SXVTQkZGRkxudzFFL1Zq?=
 =?utf-8?B?NWU2ZjhUdzloVWJmT3dCYjRSY3Zna09wVSs1ZlNwU2Q3c0N1MDVHMUZhZmlp?=
 =?utf-8?B?TDhIb05Kc2VZMC9PbWZXVHBla3crUkdXbFc1UkdpNmp4Rm5hc2tFeUlCTHFR?=
 =?utf-8?Q?ArF3I4+aTyYY1IN5A2R7PR+J6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+XpFRkitWyGFRRk5j0NUVEeL8bNPaDY2cpCl4apNTK4mwgjnGFnExJje+mGlkTxegW6rHGi/Rw68lZbNR5JQPmiROKMiLcpksPpk6orjz3/8uKqq4YNpvweFyJmqobvmS92nwRHlL4HcisTuC4Vm5kXMChn+VIgds1m6a/wDVWmoRgQn5JemFzEbE9NtM1i+uikj38qUO/kvtnHPJTloHHQdMwpFzJFaMyTwA9F3NDDzgGEV6c53OaeciSXu8Bby3emqXl/8NYlzGoa0coBm0McgC/0HMfervgqrM1hisFITBWyyH1sBdhAJ6lqehC9rxK/f72LeRpuDNt8cXlht9kDGKYkn9USUDzEJhBBX0p63GMW3jzFs/SJZWOHg+ICd7Ap/iP0VyIALYPbC3ZE4nFIJamZEyF9JBp+1Sq+IeM9s9rSWviO9GdYEFjyDk7ZDNrNNzAuUqoQpM+oAjlYJk0s6KQmnR4GdyxCN8Ji4N+JGHgldn6m7muNtTB/MrVOb0HJP95IOoY70K4dktW00x0weOBqTVBrmDsHZ8neEsiAP/yCVh8l9O5k09m/JnF6svlb/sn2n5b3ijSuA5oiz6XXo1GTkkbSxcE+CoHvZo+w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0ae0cc-6194-4a10-724f-08dd868882ff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4775.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 19:11:42.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UsB4qXt9AGNeAAK58SBOXijhra+Vv8GwWb2yszSsAVoPI3P6fd/VHi6DPnbJCyETbli1W1RJqCp5dwVcxlrEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504280154
X-Proofpoint-GUID: qaDdkRRPCRoX-mBibgWD5nTBk5ka96TS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE1NCBTYWx0ZWRfXxWAm9U0XdAJ5 Fsrmyusj0Z+kZDcxqPFk5az0HPLAzX0P1nK+2Dsq/WLHtqhc/wgmIqaAteVbUo3U1yGEWPXiyF/ nU5imMqel/r1U4+CMsqf9VEwzAEG7A5pWGKdOfA1Xa315iHfAvcjHqaWmO0pxV7yiJaDVvK8D+k
 d5fTY+TzVQPcpFoMgmL7Bf4zJ6c7EJruwhY92B9ph1O5r4mVWMNc5mqObv9XQav7PwabJ4kDZOX MIoXbo1w1q7kk6hZ+XtFpvy0uDPPKsAetzi9YC4JBSfYZhx1Pvmybs2nLCDbRuzrLcdcDuhvoR6 USEqldg2CtGgtinU18O6/nEUZ1/cUnhocLWW3tM7dTz2Myb+7RtJ85mypeVBs1nKFrKti5lbO8C /ADBnTVg
X-Proofpoint-ORIG-GUID: qaDdkRRPCRoX-mBibgWD5nTBk5ka96TS



On 4/24/2025 5:01 AM, Jason Gunthorpe wrote:
> On Wed, Apr 23, 2025 at 10:35:06PM -0700, jane.chu@oracle.com wrote:
>>
>> On 4/23/2025 4:28 PM, Jason Gunthorpe wrote:
>>>> The flow of a single test run:
>>>>     1. reserve virtual address space for (61440 * 2MB) via mmap with PROT_NONE
>>>> and MAP_ANONYMOUS | MAP_NORESERVE| MAP_PRIVATE
>>>>     2. mmap ((61440 * 2MB) / 12) from each of the 12 device-dax to the
>>>> reserved virtual address space sequentially to form a continual VA
>>>> space
>>> Like is there any chance that each of these 61440 VMA's is a single
>>> 2MB folio from device-dax, or could it be?
>>>
>>> IIRC device-dax does could not use folios until 6.15 so I'm assuming
>>> it is not folios even if it is a pmd mapping?
>>
>> I just ran the mr registration stress test in 6.15-rc3, much better!
>>
>> What's changed?  is it folio for device-dax?  none of the code in
>> ib_umem_get() has changed though, it still loops through 'npages' doing
> 
> I don't know, it is kind of strange that it changed. If device-dax is
> now using folios then it does change the access pattern to the struct
> page array somewhat, especially it moves all the writes to the head
> page of the 2MB section which maybe impacts the the caching?

6.15-rc3 is orders of magnitude better.
Agreed that device-dax's using folio are likely the heros. I've yet to 
check the code and bisect, maybe pin_user_page_fast() adds folios to 
page_list[] instead of 4K pages?  if so, with 511/512 size reduction in 
page_list[], that could drastically improve the dowstream call 
performance in spite of the thrashing, that is, if thrashing is still there.

I'll report my findings.

Thanks,
-jane

> 
> Jason


