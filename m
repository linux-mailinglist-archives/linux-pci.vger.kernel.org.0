Return-Path: <linux-pci+bounces-26611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B27A998A3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 21:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B644A1E08
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F6F2918F2;
	Wed, 23 Apr 2025 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M6jLaANO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WplpMN8q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE00292922;
	Wed, 23 Apr 2025 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745436922; cv=fail; b=bb0opCL9typSx5LZ2ei/TxWoagj2HU2w/8Qi8BIhswSHvT5Q4Zr+pLCCAE1bnI4DHmy4nMH8X8jiOVaeg9xuq1ZzXJAuH8hn//vzU7Oqd7g0MB7TKd4Cty7eSRDLpEO52OxnjX5w9WiZG9+66ElxuAvzqca84qa+oQpvDsTmVQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745436922; c=relaxed/simple;
	bh=WqG3Oik7Y6OWib62f/Q+EXepg8OcuibDRCUXhOHAoc4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hgMJJ0iBJXmEHUUx4nyBJkRGLZabHsOBr1p1uJXQc3q7FszMwRF8WlHOyopU6md8N5HOdqAi8Iwk0ij0svgahTH7E4LENyx5yoij/kmGf51eyoyVkEMQlTrGc+HaDu4ueGI7BnR3Om7aR/xt4XDRuTWPyUHqhYr/eVM8EQZxlB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M6jLaANO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WplpMN8q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NGtpKu025292;
	Wed, 23 Apr 2025 19:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=n68QeyLCC4H/buDavKZLDLRSwvNQomdtgXVBGkrE8hs=; b=
	M6jLaANO9jjBoNrAyZv/ledwGnmSCaMlFj2KOj43Ic/4JGwQBOguJAcUpI60Kr2Z
	B9QOSp9IX2kj64yNGdi8CN4YrEFWFMlaJRxPpcroSXhSu3H5qKbZ01NZ7OpPjNun
	9kay4CHs20Wg7hdIADZ92QV8n+V4UsUxSxmEfAWedVTnQFLL+++kpX1fFlFdDDTH
	oUXflLIBaSVRB5x+ftr6i59iphwtSbsAtMl+tOPKIo6t8iceQrB47yjZvm+anOKj
	9I8AavSRpnlDKVtcF5xyYK3ApU3xWHANaZONevVRwFSlviR9ASVqtLr+YBu45di0
	WabqeyMC+kSzoQ+RVgTkdA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha21d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 19:35:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NI5CmQ039221;
	Wed, 23 Apr 2025 19:35:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jkg3e8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 19:35:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUgEdnSL+iQVzPe2LIhqmVYfjuZf6C+b4Wippk3XeHdnRYoD2KKFBGK+GQrASgaow4VNBUUcnzUIOftlFj2K8Tpgj9y/wCg5vmDwj0Zoy4yd6U8/DhZdaynD55vIY9KPDhEhDOpxISPtpi7OzZkrf+n1XwElqPePGNUqBCt6frMZr/P3U4A/TIrfDBuEW0iMv9R87r+w3IAPL8N6D4A6zBU/ArenUfNteURZMMDi3bhNphVmMAFtI1XkHX9KJytttOYP0C6EqKPgJB43jdAZtsg24dHKpK4f4kbxw4dDl9Cvy7kTJelb79CStpLlugmPC+RsRig4Y6If82947iTwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n68QeyLCC4H/buDavKZLDLRSwvNQomdtgXVBGkrE8hs=;
 b=CCRwRz2ckJwBdYDGijlEXzCGZ1XDnzkhHk6LKjKtfpCyU9+kb09jeWInHwWLI2b4w9rf/bWvzkGeFppt9RIqYvsjebaSwCet3UI4tVSUrxJn+5VKYYPIpY0PTYu3KTkxGKO5My1Vds89DAvnBidJPJs0i4Oh2SCO/UMoQpsFvsjWM2ii0vHtyw2BAjO0pfK+ZE239pzbRlXtfE+Pd+2sQzQ39Wq31gZCYSe5b5+z6NtNS3rhxPEkGrvhKnhBrOutSyE5xUTb6BoVI2q8ASn04pY6QrnLqIdxdODryeS+ixPZ1J1jx2ka5M9jnra/qwedH1XyEwFMCFqRi9CKqlV7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n68QeyLCC4H/buDavKZLDLRSwvNQomdtgXVBGkrE8hs=;
 b=WplpMN8qGSwUJeKGzV2qGu9pWw/ih+WWxzr0U+hXEC4tLP/Vac6LjYx7ckEuH7i49iCvSP2oNAkvNGP8xYe0+b9dnW+GVTcg3zgNGMacusQ9ZkFz6SIDR+tr7M6DUD6gszx8e4zDk13NxWEfAOunOTRrCxg6wCpkhdvS6rmSCr0=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by PH3PPFCA9331432.namprd10.prod.outlook.com (2603:10b6:518:1::7c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Wed, 23 Apr
 2025 19:34:58 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%3]) with mapi id 15.20.8655.030; Wed, 23 Apr 2025
 19:34:58 +0000
Message-ID: <a59b447b-3c42-4a50-9b1a-cb7044ecfa5a@oracle.com>
Date: Wed, 23 Apr 2025 12:34:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Resend: Report: Performance regression from ib_umem_get on zone
 device pages
To: logang@deltatee.com, hch@lst.de, gregkh@linuxfoundation.org, jgg@ziepe.ca,
        willy@infradead.org, kch@nvidia.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:a03:114::37) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|PH3PPFCA9331432:EE_
X-MS-Office365-Filtering-Correlation-Id: 3310b673-17a9-4ea0-619f-08dd829deef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkZhYnJKbElCU25pOFVVOHV3R0owNUgwRWthQjJuQk5FNkdWSmJubVJoN3Ru?=
 =?utf-8?B?N3VkYlcxVUFmaFFnaElKSmU5S0FIL09EU2JSS05vNGVURi82bUZxMkZvMUZq?=
 =?utf-8?B?M0RXVXQxNjlCRVpEUXl6dFFPR0pSZXNMWHVSOC9SdCtaMjZyakN2ci9LTURR?=
 =?utf-8?B?U0VzL25qdnFpTWsxdno2eVk4RTRuaERjZGl2bUFJVzRNN1V3NEozdWFld1hJ?=
 =?utf-8?B?RWhDZ29jeEhhR21NSzFZcVNwZThUWnAxTnJJb3N3R3VtZkVGTW0ybjBNWG5S?=
 =?utf-8?B?T2wrb0pja1JFbzFidTdPU0hiTUhjc3V1MEg1ZHp3V0lLUUVpNnlzUDZsWGJO?=
 =?utf-8?B?OE9yY1NhbzJGOUFZS1QvMkVYY1ZZdlhkS09nZHlvczBxNG5CQnFReEtzSkZ6?=
 =?utf-8?B?OEU4ditsY3ZaREJZWVpQS2cwYngwN0xLNWF5Sy9ENUR3UkNQNE5qaVI5aktK?=
 =?utf-8?B?dFF3T3F2Qy9FZk01c09WalNJUVQ1ZWhxckV6VTdNbWdLUlpjU21PU2JWM09L?=
 =?utf-8?B?dmFDemtYalpGcFZ4YTk0OENiZE9QcHFOdmJoemY3TFYvQmxHS0QvdjJEWFYr?=
 =?utf-8?B?cC9KVFhrMkVXYjNaMUVxdDl5cDM3cHBIZFFyTlg3QXVoUitPcXluK1pvbXdh?=
 =?utf-8?B?Z2t3UFZjRms5ZnRaSzI2WDVwNlNoQ2xzUFJpKy9Qb0x3bTMwWUJIY0F4SUFa?=
 =?utf-8?B?WTVZWEU1QTc4Qi92d2ZHWmJiTGQ5M0NWNHprU0xMYWkxcDBBejRxbnh2YjVM?=
 =?utf-8?B?YzhlcGxqdWt6MjZLMmhMdUtFS2VwekE3dEFkVUhub1g0aGV5amdMNzBDeW5y?=
 =?utf-8?B?QkdkNjg2U25QTlBxU3g5SkVwL2Y0b0F3aEViZGlKaG03b0g4emxUK05Tejgy?=
 =?utf-8?B?WlBDbG5odFczVFBhV1BCcHp1ZWhqdUk1TmF6VDFXUzlER0tNTlhmL1hlT1J5?=
 =?utf-8?B?Y2FuL3dLMi9FbzEvaHNoeWJOOTdMT0hBQmRaYkxaUXZmUUZTYXN6dks1MkhF?=
 =?utf-8?B?ZnFGWVpMcTluMVVkWmJMRjg0Wlptak9uaHNuU05zUXZQRStxOTk4QW9sbWJs?=
 =?utf-8?B?dksxNzNkL0dHV0lDcndvQ29kRVo4MTFEWjh4cDFBVFdtMUtuOFpWK09ZOGNu?=
 =?utf-8?B?VGNQZDNrazBYZndEbXJEQ0czOVBIVWNXMGRPYVlwNncyZi9saElLNjNLbDVw?=
 =?utf-8?B?dThMQ1lJclN6RVdQaGZPVTV6N1NraExtYXdFTlI1K21oZ3d6R2NRenN1SnVN?=
 =?utf-8?B?WGhUenpLdldPYkh1WmdtYWFNL2FBUnZsQ0luTEtrU1A0b2Mza2dacUp5T01x?=
 =?utf-8?B?bXRBa2pSMC9pRWYyMTdxR1RPRHNibmJpN29vY3cyK05QVW1GWTlTYUlCQ2JB?=
 =?utf-8?B?djZJOUxVUXJVaWlpN09YQm96WXU3cEFmeXFiSUN1Qks2cGpIdXRLN016aHB4?=
 =?utf-8?B?NDR3MHd6SE5UbWpxQlJIZXFOOGtyREFVVnZrR09GK0E4ZzlDOEVVVnY3VmlD?=
 =?utf-8?B?Qy9FNGl3QnVPdWt0NWR6c1llMms2b0QrbHJKdnFFNUx5TDl4ZnNlVVFiWnls?=
 =?utf-8?B?eFhqNVRnOXllZmpCb1NtZjZWcWZkL095a0FHcVcwOExkaTJ4T2xIaTZ5dzFF?=
 =?utf-8?B?QjNRUnMwbjMzZ0FnaXlSVEFsWkpFMzBLVGRaR2V6T2ZMM256ZWgxRmlWcUV0?=
 =?utf-8?B?bDQrNTczQTRTeC9Id3FzTCsyMUdaMUI4WTBhRWtEUHdOU2V5VlN1V1JDOHJj?=
 =?utf-8?B?YTNzUmY0TlJsYjJpMHExMEdJY1RXdWl4RGJjT3o4dkc3cWp5YU1nbytSbVNM?=
 =?utf-8?B?aFErNG9zVjFXalc1ZTRWMm9wYUQ1WE95TDdyMGxhcEI2YUhFaFc2T3ZzZlcv?=
 =?utf-8?B?OXJMbmYwVUFJclg4MGpmQ0pXSXpsZE5ISmZsRi9lZTJaZDBlRitSWDkvTlQ5?=
 =?utf-8?B?VldsbTNNMGZwUFhLNGdQN1p2a09UYjUrNUZJa0pJbE9kQnBEOVR5ZFM5d1lJ?=
 =?utf-8?B?Z2dYNVNJMEFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STBLU0pZNDE0QkV0MFZYV3M2YTgwRUdydEg1TUhHYW1ZRENxUExiK2FLSWgw?=
 =?utf-8?B?cWgyYTM1bXcySUlQN2xEWGNRUi9pYTlZYTc0VmR1YXd2SGlDM0hMREI1ajRC?=
 =?utf-8?B?QlJxREhyUklTTE9ONmJTeGIzenNYa0JZcHNqVXVCd3Y5TnZqeHVnczJ1dUFV?=
 =?utf-8?B?WVNqaWVLdUFNZWhsZkZqZlk1c25DNW9FZEhFM2ZQV2dHNUtnbHl6eFJlQVhr?=
 =?utf-8?B?UWNCZ2JwTWQwT0E1dW9MNzc4bVRyV2NCZkY0UlpZeFl6Z21QSmZrdGVPbkJH?=
 =?utf-8?B?V2oralhlU2c3V3dGME1BbC9PS3daVjZyd1QyYjNPMVByeVZWTTg5M2NoUEsz?=
 =?utf-8?B?UXFOZStYSlJPZUZSL3pubVpMcUNIS2tPUllhaGl2RERZZUdOWjFkaXJmNTc3?=
 =?utf-8?B?Uk5RWG9MVmE1TVcra29PVURITFU2N1RCcHlZbXpJWDZlY2lvdW1kVy9DMnov?=
 =?utf-8?B?Mnd6KzNkOW8vbGJwUGJ3V2d3V0JQSVEwRGxLOXorUUFJVm10N2pDNnhJR2du?=
 =?utf-8?B?VGRtd3pMWTg4SGpQWGx0TFlKS2U1M2xkUEJudmovc05pWW1VdkNvL2F0TkxO?=
 =?utf-8?B?eHVUM1Ftc0VKazJwUm9EZThudnVlTnE2Yjg5czRpbXZ3UnBVUm4vc2ViS2V6?=
 =?utf-8?B?UFZXTEpvcWhGWnpiUTZpaDNKeHJ0WTFtVmJra0FpazlyNTZDbnlMNCtCbzVE?=
 =?utf-8?B?UmxhN05DSTB0Q00vSjBGZnpKYkI5MHV3ZVhaYVBQYkw4TGE2TkZ1eTgzUk5z?=
 =?utf-8?B?eDJldlZGMWVRbkZEdVRLRExWa1AwYjR1ekJ0enJHdXFqSUNhdGVSVVJ3OUMr?=
 =?utf-8?B?SU5SV1Q2UzkwNEFmYU95NHQySlArODVFNHk3Rk0xUTFITFNpeDRJaklKMHM3?=
 =?utf-8?B?WEF4ZitHME5jUDdQUFBMOU16elVqeUxkRnhYTXQvWE1ybjlJdzBVTHFFV25B?=
 =?utf-8?B?b1JKOG1lR29uRDhMU2NiaXpmZVk5ck05bEJKeE9LTVY0MVl5Q3F6RnMxUVpH?=
 =?utf-8?B?MmdpTEczREJ0WStCdEVzMzhOU2FXWmlTSk1hKzRXcUxrMkFZdWtaOHdqMW5l?=
 =?utf-8?B?bnd0NUpqSmhCL09rMDcwMEdmdVhxNWtEb0FRUEQwSi9ZdG5aKzRDN1BySExV?=
 =?utf-8?B?bkpYa05LQmZCeGU1WXloZTZWazJqNWF5bGxuSlFjMW05c2JORmowZDFEVHV4?=
 =?utf-8?B?c3lhUVFoaTJLODYwdk43RmlRQmxQTllLUzh5OFFjUjBrQ2RQOFY2OGtSVEwv?=
 =?utf-8?B?RUZrckg2TlpLa1VjRFI0RXJOa2hleExXeXFRUHUxRkp1QVBrb01kSWJQYmgy?=
 =?utf-8?B?NzZuLzdsRWV3SndWdlBqNWhQMXYreDNsNEpiZTRoMkJWc05jRHppWXErVkVP?=
 =?utf-8?B?U3UzTUpwQ2hNT2VETEdBakx4b3hmOEgrdmZJV3Y4MEdVdjI1Q3pDVVJEUmc5?=
 =?utf-8?B?SVRkWUl0cFAxVUMvMFRHUU9aVmZaWmpOdVY3QndxUElrNkkyMzUvdkFMTitT?=
 =?utf-8?B?L0xkbys3SmJ1Vit6TDRCamcvcU1qV3Rla1pySWN1T21WR3JUT0tUS0tVZ3Ra?=
 =?utf-8?B?ZkpUYlhwYU1XT1V0SUl0ZnlFdjd4c05QZ0owUFFGb3BzK3gyK0ZCUXp4aGFO?=
 =?utf-8?B?OGdXaEpsdm9GaEEzZVRHZXpJMXUwQ1pleVA1TkNxMVlSYU1IOWpqbzhqdGMr?=
 =?utf-8?B?S1pJTnY1VW5TaE5iaUc0cnF6dW1WQmRtc0pJNDlIOE15bVlSS3RIR292VEVm?=
 =?utf-8?B?ckNyc1NoNDRrUHM3U0N0bHh6UjZJemVEMnA2YWZIV2JCOEkzN3NzS2Rsdml4?=
 =?utf-8?B?WG9CdE41dm5zdW1ZM0dEaWM1MGlrckNBSjFndDgxTENyR3NBZ2RoSlE5ZjV1?=
 =?utf-8?B?VDNGN2ZPb29ZSmxVbVZZVTNTODltbXNMNjEvOUdmeXgrSkJzQzM5MXhZOG5O?=
 =?utf-8?B?d251QS9HM3paeloyRGpmVXV0aytzQW5Rc01JSXVBUE1qNkZQUWFpMGJ0VGg4?=
 =?utf-8?B?RTJDWXRseGZNOVEzYnBtVUlFWFExbTlWNjRRaFNiWVIvQStwV0kvNS94N0Vq?=
 =?utf-8?B?ZTc2czllQVhuUHB1M2k2VWQzdm5Kd1AySkpQZjdVdDJGZWgxOTlkaGZkbDND?=
 =?utf-8?Q?BT8o7LG/pstJrTkDI0/v0157D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jGZx9l7SnUScip4lKTB7HEG++KyMv/LZN+uAl+khYQW3ActXmS3QOcyLfYGD83AnJjpEw/EhWLHGG2kZ2y5gyUJj7nh2EH3cVEhfQNKnj+bCJs8+BUcEsVxhFNP5Pg24orWMJl5a0u/UMEZlpg0ZQO68tVz0IAYdak38tDp70rPBVgvnJDyiazsRWaTQh1a8bs9071XgWuntnYz4UTihW9yTeXVr0TO9URDrLamX/cHeePoujHTpGMT79S9Eq0efqEzqgprZN8kX2jq/YEXsUWJ9tC956ZngfbfY42Roy0MxDEoPZmjdy1d14TeyHUu9BFzBHIv9NM0T3sgXV48Jg9xhdm2Wf6ZuJrr5TRi3JFuf26rY1R1BDdi+5cDQ4ifaMusg8ZT+GPS+pgVfUzRndQeQO+DFJULIogzbA3LyqWje61864sV3C/4bUw/agsC8XPFwiPLnPAqo9BZBbWNW7zh/60O6cjHy1DweA7KbEE/lfW67dSkkHz1QUtpQmUj6XEJghPjVvHxCETEdoAceVDlidtl6a6VUQ7DQdquqe8wwuY3I2GjOaNIFq5AjcbLqW2qbok6Rg/B0248rVnp/QoD8/RkEtG30cuUYYF0bPdU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3310b673-17a9-4ea0-619f-08dd829deef8
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 19:34:58.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6umKkxXuPJ4gEXeWYMooWCdZXPRKN2yBj8d/HNlfz/LiEBwgBYD0Xp5tWkNcbOX3UNdmkt3QG4NQzkKGc5Zmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFCA9331432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_11,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEzNSBTYWx0ZWRfX2V8S9x/vjmKz 8hEezLHDeucFQhaiXB2V6IOCxayQyBAlvD3InSNimbaY7aK/ieuCs2PuZ432Bd3ZrXXR/nSUDD5 YRQMS05vQBueB/1Xot0TO/W1TEVSQYiD29PnK4CSYa5KGwMmIOgnSW2o6WP3lpKadxXzDBhgo4k
 Ztp2yC2vFdFR1xDsbi6hl1iYoy4fw2B6Zk91xnNSR6kZTKvqD9GudPNyelrDkFLcz3Vtf+otctH Cys7vaignNiQPTK+jTVi1J27q8xMoJpWhO3mvj01rf/9qM+BZcLXgHO8DR9mxCiaUzHGjx4RoYB Td2n/PJ+VdBLFXK4zuxxM49yk4zb28eaBgJiRnxPtJUKdew+lWnPNPN6yOBun2qMvNmDNJTSFGH v0UuAig6
X-Proofpoint-GUID: fffxTP_LWnaHh0I5Je5cK1poB5JIb8vc
X-Proofpoint-ORIG-GUID: fffxTP_LWnaHh0I5Je5cK1poB5JIb8vc

Resend due to a serious typo.

On 4/23/2025 12:21 PM, jane.chu@oracle.com wrote:
> Hi,
> 
> I recently looked at an mr cache registration regression issue that 
> follows device-dax backed mr memory, not system RAM backed mr memory.
> 
> It boils down to
>    1567b49d1a40 lib/scatterlist: add check when merging zone device pages
>    [PATCH v11 5/9] lib/scatterlist: add check when merging zone device 
> pages
>    https://lore.kernel.org/all/20221021174116.7200-6-logang@deltatee.com/
> 
> that went into v6.2-rc1.
> 
> The line that introduced the regression is
>    ib_uverbs_reg_mr
>      mlx5_ib_reg_user_mr
>        ib_umem_get
>          sg_alloc_append_table_from_pages
>            pages_are_mergeable
>              zone_device_pages_have_same_pgmap(a,b)
>                return a->pgmap == b->pgmap               <-------
> 
> Sub "return a->pgmap == b->pgmap" with "return true" purely as an 
> experiment and the regression reliably went away.
> 
> So this looks like a case of CPU cache thrashing, but I don't know how to 
> fix it. Could someone help address the issue?  I'd be happy to help 
> verifying.
> 
> My test system is a two-socket bare metal Intel(R) Xeon(R) Platinum 
> 8352Y with with 12 Intel NVDIMMs installed.
> 
> # lscpu
> Architecture:        x86_64
> CPU op-mode(s):      32-bit, 64-bit
> Model name:          Intel(R) Xeon(R) Platinum 8352Y CPU @ 2.20GHz
> L1d cache:           48K        <----
> L1i cache:           32K
> L2 cache:            1280K
> L3 cache:            49152K
> NUMA node0 CPU(s):   0-31,64-95
> NUMA node1 CPU(s):   32-63,96-127
> 
> # cat /proc/meminfo
> MemTotal:       263744088 kB
> MemFree:        252151828 kB
> MemAvailable:   251806008 kB
> 
> There are 12 device-dax instances configured exactly the same -
> # ndctl list -m devdax | egrep -m 1 'map'
>      "map":"mem",
> # ndctl list -m devdax | egrep -c 'map'
> 12
> # ndctl list -m devdax
> [
>    {
>      "dev":"namespace1.0",
>      "mode":"devdax",
>      "map":"mem",
>      "size":135289372672,
>      "uuid":"a67deda8-e5b3-4a6e-bea2-c1ebdc0fd996",
>      "chardev":"dax1.0",
>      "align":2097152
>    },
> [..]
> 
> The system is idle unless running mr registration test. The test 
> attempts to register 61440 mrs by 64 threads in parallel, each mr is 2MB 
> and is backed by device-dax memory.
> 
> The flow of a single test run:
>    1. reserve virtual address space for (61440 * 2MB) via mmap with 
> PROT_NONE and MAP_ANONYMOUS | MAP_NORESERVE| MAP_PRIVATE
>    2. mmap ((61440 * 2MB) / 12) from each of the 12 device-dax to the 
> reserved virtual address space sequentially to form a continual VA space
>    3. touch the entire mapped memory page by page
>    4. take timestamp,
>       create 40 pthreads, each thread registers (61440 / 40) mrs via 
> ibv_reg_mr(),
>       take another timestamp after pthread_join
>    5. wait 10 seconds
>    6. repeat step 4 except for deregistration via ibv_dereg_mr()
>    7. tear down everything
> 
> I hope the above description is helpful as I am not at liberty to share 
> the test code.
> 
> Here is the highlight from perfdiff comparing the culprit(PATCH 5/9) 
> against the baseline(PATCH 4/9).
> 
> baseline = 49580e690755 block: add check when merging zone device pages
> culprit  = 1567b49d1a40 lib/scatterlist: add check when merging zone 
> device pages
> 
> # Baseline  Delta Abs  Shared Object              Symbol
> # ........  .........  ......................... ............................................................
> #
>      26.53%    -19.46%  [kernel.kallsyms]          [k] follow_page_mask
>      49.15%    +11.56%  [kernel.kallsyms]          [k] 
> native_queued_spin_lock_slowpath
>                 +1.38%  [kernel.kallsyms]          [k] 
> pages_are_mergeable       <----
>                 +0.82%  [kernel.kallsyms]          [k] 
> __rdma_block_iter_next
>       0.74%     +0.68%  [kernel.kallsyms]          [k] osq_lock
>                 +0.56%  [kernel.kallsyms]          [k] 
> mlx5r_umr_update_mr_pas
>       2.25%     +0.49%  [kernel.kallsyms]          [k] 
> follow_pmd_mask.isra.0
>       1.92%     +0.37%  [kernel.kallsyms]          [k] _raw_spin_lock
>       1.13%     +0.35%  [kernel.kallsyms]          [k] __get_user_pages
> 
> With baseline, per mr registration takes ~2950 nanoseconds, +- 50ns,
> with culprit, per mr registration takes ~6850 nanoseconds, +- 50ns.
> 
> Regards,
> -jane


