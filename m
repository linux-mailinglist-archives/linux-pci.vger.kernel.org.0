Return-Path: <linux-pci+bounces-38010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBEBBD76AD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 07:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A493188E590
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 05:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8330F264A8D;
	Tue, 14 Oct 2025 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hNJyFge1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eUS8S/U/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47D01D90DF
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 05:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419675; cv=fail; b=Bhrhd2eduI3X549gCTRmwrBJGviqIbZfZ3CZKapyWjx+K6DWUEHZtaRxorfg7PbITWz5d+xSeRhlrSczmicb7lmnKXAaDhon+ZoQ2dwneIQIq4s0yjgU927fjeA1sDIYC6eoCswBiqz2wVzmS1pBtJ/vKhDIbgyqwc0SU9zpC60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419675; c=relaxed/simple;
	bh=aam3LIKzpFjwdofcmGswdP10BI7aY5bXsSnJwQkdoRg=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=GV4ppxMdrPZAS7noP5GwzTw4d5MLag08jxWQN/A3mScEUwmxjdJUPsR3XrFHFq9mx5YV8B6YGrFZrehQh6n072t0+/YZQnvRRYk2U0yA4c61+3yZg1j4ye2NGljXBRb9fpmVzYu9cvtbYxqXJJTlEmtYu2wxjX+wyMN/VGFZEqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hNJyFge1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eUS8S/U/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E2N7bE031579;
	Tue, 14 Oct 2025 05:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=8qE7H8jMiLcNgGkG
	MUTDppmjCR/lhIFHzZM7CNa7F3E=; b=hNJyFge1SYPBzJOeVXHgeXI0wAxMlmZ0
	T77zMcRs9ODvhnxNFEmob7nNCBpM/HDCCq1IQR8XXlDOH5svOsPwMZUZjwfx4JUF
	J3grK0cJXB/bsTfPZHCkHgSgniEJVukWFy81TYYrnpGDecU82xwmgsEbvRi3946f
	azU1rOaL4BcJACW7/CSUqebhmDHhDKq4NK4t9/FxdK5kU8Yy4TTarqVx6D03EBjA
	mBeMuui5ORnxwllpNVf3sNbUZeUcLUHgVMDcpDVXNrx4D9Imp59VBVh4QvWhMcrP
	JWHgnn0iiE5bjp9q2Q86nzLB2Y5vSN4UBsw8o0WAXPwYCMW6BwHB4A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59bhtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 05:27:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59E4ENBZ037644;
	Tue, 14 Oct 2025 05:27:48 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8ff1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 05:27:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUaJpPfkeLFKJHWn+n8nWfSn68gWfaMpUCT841U4EDg4IX8gPQPLi0WsPR2Nv5DXL8/75lZ1TJZRJmUWuepdbniK+SL3609efKCcgYz3sX53Y9SfDO/iWj92jqREPFrMHFtyudR4FDYSSbKoHINVAfhhsGNgZ/+6qrbOcbUSewu6fOngRwx6IBw0bkcoiXIXk7CFu+ntGpo+nFgyOitCASn7E4gRqripJwSCG/9znC6zijrLwGcN1ve/scipRUDPPsGAsOTGjbmPYbSHl2YcsMaVpElpaun3IsYib1r39y0bAPLNWGWTRVCFYqByaPcxaW6KDhwx45IG8WzfKtkuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qE7H8jMiLcNgGkGMUTDppmjCR/lhIFHzZM7CNa7F3E=;
 b=vQUXUXy4NN5iUAS53mmvwGCvkzwKb+SE5xowMnRD/T/kVOze1XYJrl569tUYpHccPStPDLx/vL94cR+YXnZ/iyoAs3SPx/7NxACVdweuSFq1Rp8oRiTtuzfpZ680wT/QR6aAdZFIJn+xqNkiT5xs0++gZ398imLG8M2iC8+aDRuCcrA5korI+Ouy3YmciHVsV6Spdx/CvSJWIFd0mpIlgUra7ukqXjyQsaqKbJlGgG/UmtwGAcvXLiX8Czdki3zQagRkvMKqxEw0ZyxZW9DtVrxktbjlFjoBzHy7NZVYYKk5XyjmTeSTCG7dqHkGoWfW8Uc3Ko0bJajZZb6oioOndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qE7H8jMiLcNgGkGMUTDppmjCR/lhIFHzZM7CNa7F3E=;
 b=eUS8S/U/pQ854tseZsjPMXBtHN0d/Y30+nav3EoLIr8nFkc9syVd+Luv03aE8Ncd045YoBVRx2scy65megnXlHuv444LgZXbEwy27q51Qq6oaoax/U+5iVXugQCkq0GFY9+NyIYAHrirujpTbs3DawWp5C6nRuAnBOje1QBb2N8=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by BL3PR10MB6258.namprd10.prod.outlook.com (2603:10b6:208:38d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 05:27:46 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 05:27:46 +0000
Message-ID: <67958fbe-fa61-4ea4-8040-c6b8d0313d57@oracle.com>
Date: Tue, 14 Oct 2025 10:57:39 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, donald.d.dugger@intel.com,
        linux-pci@vger.kernel.org
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: [QUERY] Is there a reason pci_quirk_enable_intel_rp_mpc_acs() uses
 pci_write_config_word()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|BL3PR10MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6a82bc-f746-4200-794a-08de0ae26813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1ZWRWJHVGxiVWdrZ0hnRklrcFJPdHhoekhzVUlMQWl1RUJHQ3o5aGtocVM2?=
 =?utf-8?B?VVVFOTFwZER5K1VXTWJ1R3cvVkhnTFNFMCtob0Zsc2JhNnp0cHRMZWQydVVp?=
 =?utf-8?B?YlA5MVpQRE52YndGS2JjT2lkeWhsbGtUMGpKMS9QdmpMdjJ5blRlc2hDelY3?=
 =?utf-8?B?OUo2Um9iZWFEU21CSit3Z0tUMGxwaUttYWJUdURCdDd1d0JnVElxZnk5T2tv?=
 =?utf-8?B?RThxd2JoNWhYcTAyckNEb1l0Z2dheGswZHh0V1o3UVJtOWtCREJGQVBUaFp4?=
 =?utf-8?B?R0lsYndBN2dLN1VvbXBDR09ZVTNsVCtEUmgwMDA3b1JLN2VCMmw5ZlNaNUJh?=
 =?utf-8?B?QWNZNWovQTZhSDNtQWZ6UytwSk5ZZVdUMHdUQW5OMjRaNk5kbis0SmRWN3Fj?=
 =?utf-8?B?eXRoQlBrK1NVd2ZYSFhjdklkd0RMRmFUQ013U0VrOE5JRlJEWHVyUGVqSTV6?=
 =?utf-8?B?OThrY3dMSFdLbEdkYUw4bkZHbjBMVjRaNHJ0aFovZjYyTUJVVG9lQ3VaSXRK?=
 =?utf-8?B?Rm5SazZCelZ2MUY2bW5CZXpkOEpxZ1BtK2tOS25RVTVnM0ZvZ2tlQ3J2V2Vs?=
 =?utf-8?B?WTY5VUFzeHlOcFZwT3BmdzdlRkFuZHhnKzBndzd5amZWc2JqMUwvQ3JYcXZJ?=
 =?utf-8?B?eUhIa0FPSlRDWWViaWV1UFVPQkE0WkQvd1Y5RXBOVHBQSkJIQUN6aDJCUHhD?=
 =?utf-8?B?V3h2c2lEWkpORVJwL0FtZVdLNFBYYUV4Y0U4QUo1UzJUdy9JenRCUTRxMUtm?=
 =?utf-8?B?dGZ3a0RZelhVNHVOdFpUSzdnRUZOZFNCbEUvc1dqQVFHOHpqN042Qm84dENs?=
 =?utf-8?B?d042WEFhbWxWUHh1N05NS05FVXBnMnJrb2dEeTRVTHpNL2ZQOThmOStWNVFS?=
 =?utf-8?B?Q3VGNGdyRVhjaCswZ2thdTRCRnQyeWg3dVpCWEUzcHFiNG9GRlV0VnV5UHVI?=
 =?utf-8?B?NklBTk1DaU9TWEtwV2xLVVpCQ3UxWGt4TFErUmRrSU9sWC9qKy9Iei9lSUNu?=
 =?utf-8?B?SGV3a2ZRa1hQdCtDZG91dzBMaG9DWEluZ3hRdFJtNmV4T05NM3ZCR2xXWlVH?=
 =?utf-8?B?dGtzelNmVjhUajBSSFhMc2pKNnlTMzRMNVVHaUhnc2tDUUpVRWFCbzFRZlFj?=
 =?utf-8?B?dW44ZHluRFB5b0JJcXJOajNMSGtyNk1EMCthbFYwUDMvamQvdXVkdXA4WnNw?=
 =?utf-8?B?dUFqL0R4b1FzbE56MkE4bXFNRmlkeS90YXNoT3loSjVTNkxUcWVJOEFIYi9D?=
 =?utf-8?B?TE9aSWlZaUdWdWdqVDFYaFFNcFZWSHNHbnBxN2I0WE1uWXdhNWRoRHJoUjFJ?=
 =?utf-8?B?ZGJMOG9uMFovc2hyVGF0dnh4NXk3a210Z0NPOU5MQTVpK041V0FzS2pEQU9m?=
 =?utf-8?B?VXBWWGpNMllNeG5LTzRwazYra0VHeGg3V203ZE9vNWpydjdiTlpGeXhDQlVu?=
 =?utf-8?B?K1B1c2RiazQ1ZG5adkJPMTRnNS9xK1lDMVdNMnhuVkNLcjN2b1F2RHZIeWlS?=
 =?utf-8?B?dmdLNFA5SHdMSVkvSjdvNzVNRThRaERTTFZuSjZGRWRxWXZTdkxRc09lRzAr?=
 =?utf-8?B?OTdPeFJvcUZpOHVsSFhtYkV0RHV4RzdIS1dhTFFNMFIwc3hyL1BNczl5TjFi?=
 =?utf-8?B?aHFRVlQ3OHVHREF4THJ2YVpWbVZuaklIZ01DckJwVVdIelR1T3AzdU9hY2Z2?=
 =?utf-8?B?dU9rSWQ2d1U2eWdYOE05NW9SdExVWFc4ZGVMejdqYmZNaGlIZVpFNTVyejFH?=
 =?utf-8?B?STBCeElzZUphK1ZtSlZVR3lJNXpLSUk2M25abjE2MC9yTUxwaWprdUVBODFO?=
 =?utf-8?B?eWVxT2dUeFNBQjhrNVFURFhIZjhSRWFSVFBoYXVERVRhSWFSb0VTZ2lmMzhE?=
 =?utf-8?B?Mi9HTVBkTG9wd2ZVczFONW8vU2s4eFpKY2Q3OHhkWklGd1NCWHZZUHBTSlE4?=
 =?utf-8?Q?dnPCS3ougKHEm+Vpn/pDOJI6N50/3/ft?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEpEWHFIL0dNbWJvajNTcGxJMk5QMHF0SFVBT0Fxb0s1V2hjRjlhLzZkbVUy?=
 =?utf-8?B?dTJob3Q5OGtUdC84SUttb2pTeVJYdktBUWZqQ3pYWWpBYjRUMXFFYXltK1JC?=
 =?utf-8?B?bHhGcm1UdGlHcWsyYlNJenNqUXhWS2JMTnVuQ1UwR3dWS2UzMU40V0tUR1Vt?=
 =?utf-8?B?dUtCemZHM00vQU10K0phUklDSy81NE93clJmUU4xN2x6UitTeTlyYVVjTGNj?=
 =?utf-8?B?RkcrbGRNSGxIMWs5S2xxYUZscWh2aFp3NjlLMzBBQW9GK1VNdlBiemRReFR3?=
 =?utf-8?B?eXVBN21Qa0piUEk1U240YmNJcFpnZkdhQURYV1p6NmVHQmZFcXFzaC9nQmcw?=
 =?utf-8?B?YkZNV2lNSnlONVRKTnc3bHFOWjJNU0Y2bFRhU0lNeWFJWEtJQ3pOMVl4cWJF?=
 =?utf-8?B?OUxRUklWc21Va2QyZDdieUZ5UlpjTE5rMGRxK25KS3hhOXhzakJlVVlmZzdO?=
 =?utf-8?B?Q3JpVjFHTjVWZEpNTXVFN0JRTG0yWCsvV0xQUFNWNEt2ZFo1UjQ1eDZJZ25K?=
 =?utf-8?B?LzZJVWFOaWZVT0R4RjhYYnM3Q3BsREptZEsrRzJoR3laYjBLdVBwczQrbzlz?=
 =?utf-8?B?azFObjA5cEt1YjVjT0dJQWxrVFg2TWZJQUVYRDI5Y2QwTUFKQ2dQY0NyWXcv?=
 =?utf-8?B?dG1vSVdhTkJJZ09QR1JpNEo2VC83YzhPbU5oSm5qaUpvV2VPZFNUa1cwSTBQ?=
 =?utf-8?B?QTkwNEMwQkZIL0QxOWxyS0xyL3lRQXJOT1owRGZRUm4wenRMRzB0L21xUTNN?=
 =?utf-8?B?cStZdGpGb1RRcWlXeXJKL0RtVVovV2EyUFVoTUJ5ekpCV2k5V2U0emtUcThi?=
 =?utf-8?B?SzFLSkgycExTQzlWMFRLUUdoRnNhWmFLRnZuT1c5RUNUc3ZpQ1BvN3Nicm1O?=
 =?utf-8?B?eGh1bU1UY2hKTWNURmptTzNwS04zeG1MUGZFeEx5aGNyV3ZVaVR2V1JkU3hX?=
 =?utf-8?B?MFJLcFVHdEtlbWwvQThETlBvVUE4MGpaWTZmZDRnT3lnOU5DbW84L0p2eDF6?=
 =?utf-8?B?LzJSYmYwYmx5TXlrSHlSTjlpNFluYkpJeHBCYW1MK2wvRWlhaGdLLzVobWRF?=
 =?utf-8?B?SnUvUXMrRU5GVjFUZEhHR05jQzdEemZZTUF3ajNsTVU0VjRsYU9HcjNNZ1Y2?=
 =?utf-8?B?ejZYaFF1a0ZKQXUyZWJRVVVINUNtUURud2g1QkFXN3VCM0NOUS9WajhlSVVn?=
 =?utf-8?B?NXpUcFhxbzlEYUNxQkwzc01nVGx4YWJMakFRd0FScFdBdzloT3hzcFpIVEx4?=
 =?utf-8?B?K3pZVlF4Qmp1T1NmM1V4VWRMZDI0SER3RVJJNGFlREtyNmpSaTJuNWpiVnQ4?=
 =?utf-8?B?Y05VbzJuZXRwbzNYbWlMN1dWcldqa29yVjA1cUxPRERnakNpdjZlUEVUS0lY?=
 =?utf-8?B?TFVCMkVWZkRJcnJjdUg4aTVKck9vaVpFcGQ1TTZTQk5yLytCTitTUkxxd2dZ?=
 =?utf-8?B?L2tkMk9nWWdkZmo1aFhOUkMwSElJNUxPSUZXUlE2SjFJRWFGTUFyNDZXc0gy?=
 =?utf-8?B?dU5OWS9aeDR4UVVFN0xxczJzT1VKMmJtWkk5RHoyYWxRNHFZMnMyS2FTN2VC?=
 =?utf-8?B?aGRPRnZvbHlCVXh1U0dZV1ZyY2Y5VHhVbEM4djNJNk9vQXJORFZPWDBmZERS?=
 =?utf-8?B?ZmN6RTNla080c2hmS1VCeTRXQ2E1OUw5U2x1dE5iR0dtWGlnREtHTFhtTDVH?=
 =?utf-8?B?MG9iR2d3MWRJOXNTTFozNmcxOHNCK0k0cWpMOHlpK21ZbFNjOU5ZTlh6cUVu?=
 =?utf-8?B?WEhncFhkR1JnYU5kWnhDMXJEVW1vaHVFc1dPNVdNd3FSSmJHME1wQk9QOUJQ?=
 =?utf-8?B?dWh1MVlROS8veUlVakpiaXM4eTVVMXlTRnNrdnkwazUvRHJSTjZSOWJWMWJo?=
 =?utf-8?B?NVJpMkUyRUZBazhxUjV4SkdQUERHTXozU25uczB5aWQyZVA5ZjVYYWFhb1hr?=
 =?utf-8?B?UW5xRGJhRDRBM25ZZTRoMmZtR2lhdERXZWoydk9lZ29ucHBBY0NqMnZ5QTlC?=
 =?utf-8?B?WjY5MnEvMXlFS0lYNnZ0MDRJNmRqbXVHeG1zamtnN2Y1L2NOcjZ3RWxlQVVo?=
 =?utf-8?B?NXd5Y3BsbzYxTXlyUjZlbEhOY0tmZDNjZHZGQ1VaWnRaU3l0S0JLamVxaEJJ?=
 =?utf-8?B?WlVkWXRkNm1xZFhWdFV1emRSbVZ0SnJKb24rM0VNTTZiRVlkZ1ErTC8rWVNj?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z/zCh5fiCIyjbxUC7/OE2fVMjfT30rDc1nyvwQvRS2PLSa+uHz4H+IiAAtHLW0vXirhueievMIZf3d5AUtKazbWfs+g4Aa8SkNM7HmZVhUJDFIgYu6jbJupClqPknJvT2SRT4/otEgMBPmhKZ4sFubvoay6SmOQQeQAutGe5EzSYgVCR2Lj+2YA/WksJrI71UO+z/ZR/xSSM4l7mAcuoCcD+A6rLUCeF95aJZugCYrxVXwgp5coa2CtI6S1vgx3DW0VfD5EsdB7B2FTK/FkJXX8v4m+r/g3y82YROB1DtmLy2FqjH5aRp8t6PHMh2NRkh8U0UYcqqYl/TIKW8OBaq78/qHhzSFjiRPPtrNfERgSqut2dWokPD1r5wnCdOhmRBB7LNSLTNniIdxFsfRZrIGa2yMYPzsvnjd6Gk1u/7YzJImDiNvBswUcEkV7ezyGtA9DpPWBCicPw4xjxncMyLaEYtZVSrzAwggSdpnnLUBXt6WLKTEGhO8H7Qk9vUSMZGCrqGcCvfgk2v/h9yrD/nK9f9kOgEHVvr+q98B5HYsZoXyxPJYMZAhcEVkwVWBgVP9L8ZiziuiO3m1rKDz5HXds2T/1lc9S80g7vr8ot8+0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6a82bc-f746-4200-794a-08de0ae26813
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 05:27:46.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKvRw5zarYD3jjmqeheSukeXczVLzvFZaYzZF9q3xr86TSokBuni1YQ/DRRiDQbb7igv4GRJJoF6s1ctvsPHRBDhPMBFGBRXJmBFvmlz3lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6258
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140040
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfX7V4t853tmWVu
 OCpe93N6LcxCkmxYVacv5O8B6t6kKlPNrEl5XSRaTGVnAlATvC2RlrAIUgJ//5jnv+8MhIj7pB1
 7sYmJu6ODUkwtzpSw/snzQKA9h5L9zRBSuIvMlCWn+zO+6nKmIf7wSMdFKkdghjvZW0qng/shSL
 4gNeAPu6FnQOEe3JKTpTv9zX3kDnMbYgYCxowYhWCgxo5Jzbd0gX6U8HxuxhZjHLO+LRFcTrVMy
 AqN7Yfg9mF5O/P/vQlvIUryovlYXkFSwdAeGIpou0uKnC9nOae+azQG+BQmtt8FwhaUGNylPnYR
 XWQ3kdW5zMVDzEZpeR7YxalreKnoahPQox+drqnc88/OD2h+isL5E4pJYms+LIuNhCHUGYfGoOe
 Kl6GM73jZPVyAGN+gxS4umSpaKVzPg==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68eddf55 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=s-M6_zQ8fYneQptxYwsA:9 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: 6amuhlDKBaNf1AP3cpjv4UNq_dj6JgxC
X-Proofpoint-GUID: 6amuhlDKBaNf1AP3cpjv4UNq_dj6JgxC

Hi,

function pci_quirk_enable_intel_rp_mpc_acs() in
drivers/pci/quirks.c, I noticed that the code reads a 32-bit value from
INTEL_MPC_REG using pci_read_config_dword(), but writes it back using
pci_write_config_word().

The relevant lines are:

     pci_read_config_dword(dev, INTEL_MPC_REG, &mpc);
     if (!(mpc & INTEL_MPC_REG_IRBNCE)) {
         pci_info(dev, "Enabling MPC IRBNCE\n");
         mpc |= INTEL_MPC_REG_IRBNCE;
         pci_write_config_word(dev, INTEL_MPC_REG, mpc);
     }

Given that:
/* Miscellaneous Port Configuration register */
#define INTEL_MPC_REG 0xd8
/* MPC: Invalid Receive Bus Number Check Enable */
#define INTEL_MPC_REG_IRBNCE (1 << 26)

the IRBNCE bit is in the upper 16 bits of this 32-bit register.
It seems that using pci_write_config_word() would not actually update 
that bit.

is there a specific hardware reason for using a 16-bit write?

Thanks,
Alok

---
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..1bd6e70058b5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5312,7 +5312,7 @@ static void 
pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
         if (!(mpc & INTEL_MPC_REG_IRBNCE)) {
                 pci_info(dev, "Enabling MPC IRBNCE\n");
                 mpc |= INTEL_MPC_REG_IRBNCE;
-               pci_write_config_word(dev, INTEL_MPC_REG, mpc);
+               pci_write_config_dword(dev, INTEL_MPC_REG, mpc);
         }
  }

