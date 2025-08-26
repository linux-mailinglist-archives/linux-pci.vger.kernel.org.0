Return-Path: <linux-pci+bounces-34795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF9CB37454
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 23:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FE71BA171C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 21:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8582F83B7;
	Tue, 26 Aug 2025 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="wG4DZEHM";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="MWMcbfRC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0f-00379502.gpphosted.com (mx0f-00379502.gpphosted.com [67.231.155.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DB52BE644;
	Tue, 26 Aug 2025 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.155.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243391; cv=fail; b=NYFtsnQkkrWegBr/GAqgoK6v3tDUBbt/gSwM+9qqM7V8R+uEEY2XcvNnksZ3KqomTEaj8d4hq50nxpq2T6GDxSHxw2LEn1EV1vo1wNspSrDabzVuElQwQcjkX/AFvV5VPSNQyxhPJKBDvnlb9FFZZSeAYQv4kHVVEvGuVXyykNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243391; c=relaxed/simple;
	bh=VwnY+beG3eUSLPY5fpMhLM5Ip94h3fcA8Am+hrxnpMQ=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=j5pOszg4B2Ze5c1o/lgczlZb2Ybq4p7pnHL4pgPir5GnoJSggtTAZM9RhKQctmGSj32Zhty5Ur9DKo4mavLQKXy0go/5PLW6szMnCgMkQ4CbyYpKp6r2m1Uj4Yi1nGGWbN/pC2xP0csTst5Rd6jT9CAxClkWC77UGI6s31uj2nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov; spf=pass smtp.mailfrom=llnl.gov; dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b=wG4DZEHM; dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b=MWMcbfRC; arc=fail smtp.client-ip=67.231.155.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=llnl.gov
Received: from pps.filterd (m0422210.ppops.net [127.0.0.1])
	by mx0f-00379502.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QKgPjU020526;
	Tue, 26 Aug 2025 14:22:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=message-id : date : to
 : from : subject : cc : content-type : content-transfer-encoding :
 mime-version; s=02022021-podllnl;
 bh=yjjPxHZQxhSesI+Gwrj3oWgffe75x8HAIia1aijLyCs=;
 b=wG4DZEHMEgE5vW+Rr67Il3Dw9SWg2zrNNZq7otzjRHIFb0n0TRsM/2KjSlutRcFCpI12
 z9RDN6kCGNCtLgGBfogd4sWFvBVKOp4M/3KHR3JAZTWbL6CrnwPtG/d7LbFbftQSZ9NM
 RNEjsuTmEw4Xlti1SUYg3Os9WlTMEG7p8EwI2aBbgkWFWiXrfiVh3vDPUqknJcii4I92
 Ojm4NG4j0qMdc9ZLRd4aeoaHaJbJrFV8mB2eVV6a4g5Wu4suxmdC740XBvMNHAbyn76I
 IyYDar5xiAhvtPGLlJ/D9wtI6+JtO592ciuZXz6uKX7sT2U3mY3oyXcDVnkBy8wB2dCh PQ== 
Received: from by5pr09cu001.outbound.protection.outlook.com (mail-westusazon11011021.outbound.protection.outlook.com [52.101.86.21])
	by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 48sm6t034s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 14:22:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGhjJDdzSQ/tWNEIpGWb03iBo9muv/G+MpI6Dg4FdKC1jqCX0Vy75riLZbG0IyZSwfvoA/+vbHI+xAfUzwa4DZTsy3kU2n2AARVrYnt+jtdpIcdwMBgMlB5RX4irNsDEOODkL1a8Do1I5xwH5QcrGyEKeb94XsTikazusr/9YloHes5gaXt3E75nGMi0YqN6qhAOAJKaF91WQwAjZ43V5HL/Jh3VG3yIBLFgXQTsVN6uL6nJ9u/3Jxm9YAc31tgDHgwAps+NZIgo9TtOMX6wsW7B5qxtmbqTbBKD9qSKvdo6UY/H3AWa3w5ZkQqOYrPTwcpfUGPhgYhmZyb8Vkczeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjjPxHZQxhSesI+Gwrj3oWgffe75x8HAIia1aijLyCs=;
 b=ZtNjcNXcXd9LuAhiEmDiLNTmlRaUwcr6cA3ZTQppMl7aAU8xPoyS7DV5HNIJYLHjiTLHkFOHGfvO7hSCxklPBXATu4s6GTwSqxfP1ZR2ly1VSam35yElAhIRCUId/r9RXxHkH1VHsTVj755OAL+ZbZESi5xQiVtZdFU6UQA3bi37Wel326ishoIXzuXaIjtlVvhShMkm+mb1XWXGYFf5rDwRnMHqDcdhraCB0LoJ8LxqP5zJhn6ukLJH4Psz+QwkT9jhTdUeXYIm9R+2AkjBXbVRK+LNyYBm2nazwZNslT9gO0rn9CHwdYT0BytFMBKv2Zjk7EjXMdWFaZO+BNJhsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjjPxHZQxhSesI+Gwrj3oWgffe75x8HAIia1aijLyCs=;
 b=MWMcbfRCA5VHQrjn6mrIZaQpBww8QHrkb+gXqfp/wP7n6hziimmIF0Po2KTfxw5hJiG9FZ2JpWxFUr60VX/pd3KZVJM9p+/69hbkrOuN30d5JTkfbZ9FcEOJRJShR39ojRssE+WH0bI0WohgLPKwbJDKvjS+P0WVJ/0GuFgdgV0=
Received: from DS0PR09MB11477.namprd09.prod.outlook.com (2603:10b6:8:16c::14)
 by SA1PR09MB11817.namprd09.prod.outlook.com (2603:10b6:806:362::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 21:22:35 +0000
Received: from DS0PR09MB11477.namprd09.prod.outlook.com
 ([fe80::7b00:e70:604b:3ce3]) by DS0PR09MB11477.namprd09.prod.outlook.com
 ([fe80::7b00:e70:604b:3ce3%4]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 21:22:34 +0000
Message-ID: <ea057313-d467-4bc2-9dcd-68dd57a715fa@llnl.gov>
Date: Tue, 26 Aug 2025 14:22:32 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: corey@minyard.net, alok.a.tiwari@oracle.com,
        Lukas Wunner <lukas@wunner.de>, mariusz.tkaczyk@linux.intel.com,
        minyard@acm.org, Bjorn Helgaas <helgaas@kernel.org>
From: Tony Hutter <hutter2@llnl.gov>
Subject: [PATCH v5] Introduce Cray ClusterStor E1000 NVMe slot LED driver
Cc: linux-pci@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::9) To DS0PR09MB11477.namprd09.prod.outlook.com
 (2603:10b6:8:16c::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR09MB11477:EE_|SA1PR09MB11817:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4dfd67-381d-4755-325d-08dde4e6ac9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWkxNS8vb3I0MGlzTzVFaDdOK0x0b2ZCZW1USkNVUHdiV3dlVzB5amN0akxn?=
 =?utf-8?B?UG5Jd1RTTWtmSDZ6TXFOREZ2NHZQVHA4Um91eDJNTlZ2dDVja3p2RkdMVHNK?=
 =?utf-8?B?TFFUSWdtNWI5TzlCUjU1bDJvUXcxd0VkenJiTk5HR1p1RTRuYXRNQUlHT2la?=
 =?utf-8?B?RlRpSWZSUGZESnVUSVQwNG41aUJjdDFQN0ErZW91UzFZVTcxS0tDZnpDb1pS?=
 =?utf-8?B?ZytXMkd0MllxUmVSVyttRjRpYjFZNU4waGE5MlFKUnA0QWpDd0syR2ljcjgy?=
 =?utf-8?B?V3BWNWR2aEhyeVN6Y3VJeDdydnBZL1ZOaWxRQjk1L2liamtDbWQ3eFpvODFx?=
 =?utf-8?B?RnBaU0FBSG9ka1dJTWpSMnIwK2M1N2FORjlFNHJralVMMmcxb2RGTFh5QXRx?=
 =?utf-8?B?S1h1aDlDRWNGKzR6K3JyOEY1RjR6KzBrUkJFd1lEbEdkS3FRVnRic25xR0lE?=
 =?utf-8?B?bW11dURzakdXb0tsZURhdE8wWmNhYTE1clRDWUxKb2lLTytubTh2Sk5Jc3hp?=
 =?utf-8?B?UXNrNGt2UGMwajV3MGw3cWlDL011OUNkQkF3dVBzZEdhSm1UZnhYU0lRMmNN?=
 =?utf-8?B?ZHdQWjIvMlZFaWxoVnRvOWVLSTlIcUZUbjF4OEZsclcxdE9HTERPdUMxQmlX?=
 =?utf-8?B?NkxXYTN5bTh2azRZaGxtRzhiajlLdHVoaVdnWU8vcHNURXYxMnNZbk5FcnZm?=
 =?utf-8?B?dm9JNmJhSFZVOWlrRXZtQVM5MzJIN3lzTDYxaHNBbXJ6QUx1cUtjVmluK0dT?=
 =?utf-8?B?NzExQWJaK205M29uOHhCQ1JaUXFNeENrNGYxWElaRFpkSXB0ekVaNHlvd2d2?=
 =?utf-8?B?WmFBdTJqQUJSRmFhZVJKMVlvNmdZLzA4dEdPcGtxaGM0dytBZkNJVzkwUjRq?=
 =?utf-8?B?d3g1ck8vdjNJR3ExVWgvcm9iWERqWHZ1VjF5OEh3L0hPWTNmSkZQT3lBNjNq?=
 =?utf-8?B?eTZabkVWbkVKNG03SjEvUUVWQnJENklzd3N2OEl6MGI3dWgySFBZTDh3Qm12?=
 =?utf-8?B?Vy9RcWFyUmdQcThiNEFBRmVaT1Bkdm5iYXhmN01hRi9SRlRKK0dsVHkyN2Mx?=
 =?utf-8?B?QWJQbDMwUjZPSkJleWNiaUs0Sk1Fa0ZLcWFrSFEvWFQ0cUMvc3hmWUNkNkRt?=
 =?utf-8?B?aFVJM05DV215aWUyblc4b1NkOXZGd2tvM0NPT2hwSmFDTXRYRmpMRGx5QW5H?=
 =?utf-8?B?UitJem1tUGNkTXN6S0RwQ1dvaENvdnFDSzRxWDMzcWVqVENVMW15bWdqd2ZM?=
 =?utf-8?B?NGh4WFo5M1ZBc0VZNVM0dkpCcFlmUlNzdUViOU05Z2RxSGgzekZSa1JYQzQ2?=
 =?utf-8?B?K2pOdWhnazBWdmZLajNRdmdpSStsL3B5YnV0S1lHZ3BEZDNtUzBEMTV1bFR5?=
 =?utf-8?B?eHE2bGVQbU9yMFJreVpHcFJPL1FPZ2paOU1taGpnZ0loNXA1TVVpY0JxdERW?=
 =?utf-8?B?cTV6bSs0dGVBclRhcDd2dkZRSXB0SnBpWGtYaHVrODd5WWpsa1NiS1NjeDhU?=
 =?utf-8?B?cUNpcEpPL2RIWlROeDlEclBFMjVjZWFvRXJJM2g4ZWEvUHBnek96T2NRUWdx?=
 =?utf-8?B?dHdhZWNuQlN1MEhKT3lKREROMXdHS2J6bmI0ak9sRVdRcjRVei9xdVZJWGV2?=
 =?utf-8?B?b2RVTzhCNGZlbVZkUzBvWU42R2lXaTBDZWQzSE9zRWN3YmRqNG1pUk1pUDE4?=
 =?utf-8?B?cUZkbmJCdlAxY1FuQ29OS0RydDMvQjhleDh5aklXdW4vQ3RwR3ZDSHpEandI?=
 =?utf-8?B?ZTFTZktNd050Rk1FTk1XdGs3ei9hRGZqWHUzZUdBVFViTERpY3pvZElQUHdu?=
 =?utf-8?B?aU9sczI1L1VDVEtNcnJpd1U5VTdXL0VFZTdDVHlSY2FVdmhXeHJwalRDRmo1?=
 =?utf-8?B?OWZJcVkxMFhoWEtzamtSSlNSZTFGSTJRc0MxZll2bXlRUmlKejE1QWlsNU9D?=
 =?utf-8?Q?TBe7BDh1dAA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR09MB11477.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTdhYVIrVEJnZlkvRWRwT2xhejQvbHh2ZmVMeHVWRW4vbTBkTDFFcFU0Z1pW?=
 =?utf-8?B?MFpTWVpUOEIyK3kxQU5wVDRDYmVJb05RMkwra2dyM1R5R1llK3R4RExsWFlo?=
 =?utf-8?B?ZXJmSm94ZmNTMnIrVzNSLzVvQnpEWDNnRnVYRWVDTzRNdENsU0kwSFl3dzZY?=
 =?utf-8?B?UFRmZTl0aVRhbm9TMXhOdWN1Q2dCbW8vUXUzSDZJeEYzalVyR0E0dk4wRnVV?=
 =?utf-8?B?QkRuOEJvS0J1Sm5HWUdqRnhJMTAxSWQ3SWJ1RERhclpNazgxdnNLRGZZY1Fi?=
 =?utf-8?B?Q2twUmQ5N3RLTHJOSm41bnVmZUdJaXRXOFRZSjAyRHl1SExpaEg5MVV0NXVO?=
 =?utf-8?B?cmw4cmVaQVgxUWlNOEF2YXFGYWwzdWRZM1FuODBwSW1LNFErTGZjckNnMjRq?=
 =?utf-8?B?QnI4RWEzd2dFdm50ZW1GOUlvOEFsN3hjaUdGMWtEak9yeW1XVzVOMDY0Wmg1?=
 =?utf-8?B?M0l4NUdOSnk0TDM0MFZSTVA4TlRDMzhGdDdVSEoyTkVHNHpnOXdyWEFOT2FZ?=
 =?utf-8?B?Y1UweWl6SFZvUHVEck4xRVR1bCsxUGhTa2szbGpSejJxNzdQTVNRQzNUb1g1?=
 =?utf-8?B?RkQyNVZ4WTcyNjYvQ1NudmpLbGxkanVrSWdybTJwWjV4OHFEQ1gyak56RjlR?=
 =?utf-8?B?dDZ6VFF6QXg1MktwdUNkcmJMK0lmS0w4MnNEOFV1dTFJSDJnRUNSbXkrVHNt?=
 =?utf-8?B?OWtmWGcwVUp2cEhjQUh6NHkvK240eWRURFFXRGNUV3dRR3NmK1NLdXdtWU9m?=
 =?utf-8?B?UVJBTFlwVjZmWDEyL1FvRGNkcGgrOXB3dmtVdVB4NEYyY0txTTFmQTJPcVJN?=
 =?utf-8?B?Um9KRk5yb016dmNMNHhRM0ZIclVOUGJycEZKekZCZXdtT29CcGFSTVJmdHN2?=
 =?utf-8?B?a3JjaDFpamJPT012YjhvUU1iOXVzby9GYnQwL2dnTkQ1NnNnVk00V2ZmZmJN?=
 =?utf-8?B?TkYxeHNNMjJ6YVk2NW9XWTlFeWlXbFErRmw0SFFjUEFKTGM1S0lNV3lka0RK?=
 =?utf-8?B?RnRrV09tZmFJOHB3UUNQSERNWll0Y1I5RlhLZ1BYbUNMSlVmWGIzbmllY1NJ?=
 =?utf-8?B?ak1ZREVhbHVKMDNMcnNPbE04T3NZd3p0M3RCUWlBQkQvZ2FnSlpBRXAwS3di?=
 =?utf-8?B?Ums1MUN6R3VYOFBoOXFDQXY3MXdrUWsyWXUxSklpdTAzVThBalNWd0NEdXpk?=
 =?utf-8?B?RHB6T3JGSjFWWFNMY3R0L0ZLbTY2a3MyN1BEOFBDb0p6V0tKSVRSVU8wMTJQ?=
 =?utf-8?B?emh0U1dZajU1Unp2R1pOL3ZrQk9DWkk5a2NJNGlIRUp0eWpJemZuSXprQjJO?=
 =?utf-8?B?MTlUS1ZRcnBDMmhlWXRsdkNyYjdGZU1DQkFjdmk2MnJRRFd0eXgxYnRNbDFH?=
 =?utf-8?B?ODUwLzA5Z1dEVEpPQVRDYkRYZFRzZDB6Y2M3ZGpPaWhlNHFHamhJWnFhdUMy?=
 =?utf-8?B?ZEhkTTdINHJFWkF0aEdrOFh1Zlh5OXVobkFkTGcraDJjUVhXb2hCWUt2NGpm?=
 =?utf-8?B?bGc5aVlxeE5HRFZPaC96NTJ0WWhPZVI1dlQ0akxBRmJVZmV5QUVVc3diOXlG?=
 =?utf-8?B?TE5jSGNZc24wenYyZXoydjBaSHh0Ny9RelhJOFVFZ1RNQ2FUbjVjaUNhTmU5?=
 =?utf-8?B?R0NKZDlWdE1BS0ZCUmlpSW5KcVhESTJaUnV1MUJkemtuMDRpcWFhNkVKZm1C?=
 =?utf-8?B?VGw5VnAzeDVwd3NrQlRSKzBISFpoVnJyWlNxSmJhRXN5MEVHbHA0RXdSVGxU?=
 =?utf-8?B?NGlJOFVmRFRjRC9wU2xScUVUTDZwQnRkTnMvNkx0eGNwTFpvbHkrSlhYQXQ1?=
 =?utf-8?B?YWRSbFNISklXWjFxRU5HY2t4WVRYZ0g1c25KekhENWtpVXM2ZGJvNjlzQ0ZD?=
 =?utf-8?B?QzB6dTBvY0RFMmpWak9PK3N0WGVLQW5GdS9aUlRKcTZ6c2paSm5sRjNmcnhR?=
 =?utf-8?B?RUJOcEVFdzJtd1VjdmNxd09jNmdvNXFNV1pKNlJmN2tMMXhMaDJkaExnQzBv?=
 =?utf-8?B?bHdybDZwb1ZIbThQTzI3OENhSUJ1MnV4cWYreGRidmF2dVZaMmtac01iY0dj?=
 =?utf-8?B?NVByelZrbUt0QnErdk5aclpCNlJOV3l4K004cmFIVExWSWE5ZEcvelR0MGRm?=
 =?utf-8?Q?UGnr5qzxPQRmnznZ8l6XnaWdR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Gr0D8MKluNX3IA9+iUbEH2InDUpI6vPcp2fCS6EVWm5YNuIgDPnXNOYQSB7HHQ3bKuoH87TxTcSGy3yLgTapEYmD1lMNBtLDGVQYgVkFGkieY+Zr0yVOHYIR8nm+8/FVPD3SWdZyeZUSnuFBeG8GTqME+560GB3s6yHimxUOV9j+mPH5DGEYnwam035mQAcj46FSvFmoZSWcczjc7DRljkZZIyYhcXCTa97a47ogMWKusyu8fPUzfucQE0PiH4z23qIg34g1fb8b4wCmfPSejoY+TK2u5Hj+UWKiIaQs63sfhYG0zREGaRwRRQ9Uaw4m0wP9t9uz/aJAjLbog1ZniKCxfbxsrbUKuxOU5QdCoZ8SxefN1Ll1XK1IzT/o6XDuSo4YhY2xioMo1mxWReDQo7eQ5Iusz0TyRlbRHd0qJv9xLcQPFzNbxPANiraPmCZnn1Gwa9cjdk/nVzT/TKD3ARV3DjBz9kWNtphNDXTwtfmZ0JB752EBB4MYf6Yw/B0cl0vU5DxZAPZ+hEyL1KGUvjUasWUvgyJIMffh1mRtxf24kxiQ2J8NcVv4UCddRzCRwy8SH4qhjTzPVNZhCD9IvcHH3ydDqonzVEOKRnmj+5SY04873SYhfTM6cOBJ4j5ulzO5j6ICRUGeBF9zhBkcRQ==
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4dfd67-381d-4755-325d-08dde4e6ac9c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR09MB11477.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 21:22:34.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR09MB11817
X-Proofpoint-GUID: mHoLjmk6C4uaaMWo75Cwmd2mbc41n7AI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE4NyBTYWx0ZWRfX88zA5EXRCh4C J1TThQriYv11kimNH29hRZDwCSsOcdI8mUba//8ohValBEr/eC6OiPd0lVGZEEY5lmiEeGWbqB8 9QbPpvcr0PMSiwwrnccLzgYe5jPV7+YkJGkpXsmaOQolIhQauD8a/xAhmpVwOADZeYxVVFWtC2U
 bv8CoxiU0exav6cD4Nus8nAVnZH2KeT5NyT2SnypBbFfQiGSABNq+i602sQ2kcc7mr/stq8QxvP UlSslM/t4ZvT83fSvZJAQ2lRQIfG1/w/Jv38ZkWw8XC5Oj9/lrvXRbsMH6ld62q+Lkp2jxnGpZ8 iGZkrQbyERmJFn5W3BFbnW4xk0aM7t0U7IIcIH9LJzKcPx34a3tc7FPVPZQLINkQB959j6L0JHV LeSYV8q2
X-Proofpoint-ORIG-GUID: mHoLjmk6C4uaaMWo75Cwmd2mbc41n7AI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260187

Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
The driver provides hotplug attention status callbacks for the 24 NVMe
slots on the E1000.  This allows users to access the E1000's locate and
fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
entries.  This driver uses IPMI to communicate with the E1000 controller
to toggle the LEDs.

Signed-off-by: Tony Hutter <hutter2@llnl.gov>
---
Changes in v5:
 - Removed unnecessary ipmi_smi.h #include.
 - Added WARN_ON() to craye1k_do_message() to sanity check that craye1k->lock
   is held.
 - Added additional comments for when craye1k->lock should be held.

Changes in v4:
 - Fix typo in Kconfig: "is it" ->  "it is"
 - Rename some #defines to CRAYE1K_SUBCMD_*
 - Use IS_ERR() check in craye1k_debugfs_init()
 - Return -EIO instead of -EINVAL when LED value check fails

Changes in v3:
 - Add 'attention' values in Documentation/ABI/testing/sysfs-bus-pci.
 - Remove ACPI_PCI_SLOT dependency.
 - Cleanup craye1k_do_message() error checking.
 - Skip unneeded memcpy() on failure in __craye1k_do_command().
 - Merge craye1k_do_command_and_netfn() code into craye1k_do_command().
 - Make craye1k_is_primary() return boolean.
 - Return negative error code on failure in craye1k_set_primary().

Changes in v2:
 - Integrated E1000 code into the pciehp driver as an built-in
   extention rather than as a standalone module.
 - Moved debug tunables and counters to debugfs.
 - Removed forward declarations.
 - Kept the /sys/bus/pci/slots/<slot>/attention interface rather
   than using NPEM/_DSM or led_classdev as suggested.  The "attention"
   interface is more beneficial for our site, since it allows us to
   control the NVMe slot LEDs agnostically across different enclosure
   vendors and kernel versions using the same scripts.  It is also
   nice to use the same /sys/bus/pci/slots/<slot>/ sysfs directory for
   both slot LED toggling ("attention") and slot power control
   ("power").
---
 Documentation/ABI/testing/sysfs-bus-pci |  21 +
 MAINTAINERS                             |   5 +
 drivers/pci/hotplug/Kconfig             |  10 +
 drivers/pci/hotplug/Makefile            |   3 +
 drivers/pci/hotplug/pciehp.h            |   7 +
 drivers/pci/hotplug/pciehp_core.c       |  12 +
 drivers/pci/hotplug/pciehp_craye1k.c    | 672 ++++++++++++++++++++++++
 7 files changed, 730 insertions(+)
 create mode 100644 drivers/pci/hotplug/pciehp_craye1k.c

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 69f952fffec7..9b1c008c39c2 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -231,6 +231,27 @@ Description:
 		    - scXX contains the device subclass;
 		    - iXX contains the device class programming interface.
 
+What:		/sys/bus/pci/slots/.../attention
+Date:		February 2025
+Contact:	linux-pci@vger.kernel.org
+Description:
+		The attention attribute is used to read or write the attention
+		status for an enclosure slot.  This is often used to set the
+		slot LED value on a NVMe storage enclosure.
+
+		Common values:
+		0 = OFF
+		1 = ON
+		2 = blink (ampere, ibmphp, pciehp, rpaphp, shpchp)
+
+		Using the pciehp_craye1k extensions:
+		0 = fault LED OFF, locate LED OFF
+		1 = fault LED ON,  locate LED OFF
+		2 = fault LED OFF, locate LED ON
+		3 = fault LED ON,  locate LED ON
+
+		Other values are no-op, OFF, or ON depending on the driver.
+
 What:		/sys/bus/pci/slots/.../module
 Date:		June 2009
 Contact:	linux-pci@vger.kernel.org
diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..6701fb9e211f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6459,6 +6459,11 @@ S:	Maintained
 F:	Documentation/filesystems/cramfs.rst
 F:	fs/cramfs/
 
+CRAY CLUSTERSTOR E1000 NVME SLOT LED DRIVER EXTENSIONS
+M:	Tony Hutter <hutter2@llnl.gov>
+S:	Maintained
+F:	drivers/pci/hotplug/pciehp_craye1k.c
+
 CRC LIBRARY
 M:	Eric Biggers <ebiggers@kernel.org>
 R:	Ard Biesheuvel <ardb@kernel.org>
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 3207860b52e4..8994bffe04c1 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -183,4 +183,14 @@ config HOTPLUG_PCI_S390
 
 	  When in doubt, say Y.
 
+config HOTPLUG_PCI_PCIE_CRAY_E1000
+	bool "PCIe Hotplug extensions for Cray ClusterStor E1000"
+	depends on HOTPLUG_PCI_PCIE && IPMI_HANDLER=y
+	help
+	  Say Y here if you have a Cray ClusterStor E1000 and want to control
+	  your NVMe slot LEDs.  Without this driver it is not possible
+	  to control the fault and locate LEDs on the E1000's 24 NVMe slots.
+
+	  When in doubt, say N.
+
 endif # HOTPLUG_PCI
diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 40aaf31fe338..82a1f0592d0a 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -66,6 +66,9 @@ pciehp-objs		:=	pciehp_core.o	\
 				pciehp_ctrl.o	\
 				pciehp_pci.o	\
 				pciehp_hpc.o
+ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+pciehp-objs		+=	pciehp_craye1k.o
+endif
 
 shpchp-objs		:=	shpchp_core.o	\
 				shpchp_ctrl.o	\
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb..f4c09a110a07 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -199,6 +199,13 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
 int pciehp_slot_reset(struct pcie_device *dev);
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
+int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot, u8 status);
+bool is_craye1k_slot(struct controller *ctrl);
+int craye1k_init(void);
+#endif
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index f59baa912970..835052384879 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -73,6 +73,13 @@ static int init_slot(struct controller *ctrl)
 		ops->get_attention_status = pciehp_get_raw_indicator_status;
 		ops->set_attention_status = pciehp_set_raw_indicator_status;
 	}
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+	if (is_craye1k_slot(ctrl)) {
+		/* slots 1-24 on Cray E1000s are controlled differently */
+		ops->get_attention_status = craye1k_get_attention_status;
+		ops->set_attention_status = craye1k_set_attention_status;
+	}
+#endif
 
 	/* register this slot with the hotplug pci core */
 	ctrl->hotplug_slot.ops = ops;
@@ -378,6 +385,11 @@ int __init pcie_hp_init(void)
 	pr_debug("pcie_port_service_register = %d\n", retval);
 	if (retval)
 		pr_debug("Failure to register service\n");
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+	retval = craye1k_init();
+	if (retval)
+		pr_debug("Failure to register Cray E1000 extensions");
+#endif
 
 	return retval;
 }
diff --git a/drivers/pci/hotplug/pciehp_craye1k.c b/drivers/pci/hotplug/pciehp_craye1k.c
new file mode 100644
index 000000000000..211ac62c4d5b
--- /dev/null
+++ b/drivers/pci/hotplug/pciehp_craye1k.c
@@ -0,0 +1,672 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022-2024 Lawrence Livermore National Security, LLC
+ */
+/*
+ * Cray ClusterStor E1000 hotplug slot LED driver extensions
+ *
+ * This driver controls the NVMe slot LEDs on the Cray ClusterStore E1000.
+ * It provides hotplug attention status callbacks for the 24 NVMe slots on
+ * the E1000.  This allows users to access the E1000's locate and fault
+ * LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs entries.
+ * This driver uses IPMI to communicate with the E1000 controller to toggle
+ * the LEDs.
+ *
+ * This driver is based off of ibmpex.c
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/dmi.h>
+#include <linux/ipmi.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+#include <linux/random.h>
+#include "pciehp.h"
+
+/* Cray E1000 commands */
+#define CRAYE1K_CMD_NETFN       0x3c
+#define CRAYE1K_CMD_PRIMARY     0x33
+#define CRAYE1K_CMD_FAULT_LED   0x39
+#define CRAYE1K_CMD_LOCATE_LED  0x22
+
+/* Subcommands */
+#define CRAYE1K_SUBCMD_GET_LED		0x0
+#define CRAYE1K_SUBCMD_SET_LED		0x1
+#define CRAYE1K_SUBCMD_SET_PRIMARY	0x1
+
+/*
+ * Milliseconds to wait after get/set LED command.  200ms value found though
+ * experimentation
+ */
+#define	CRAYE1K_POST_CMD_WAIT_MS	200
+
+struct craye1k {
+	struct device *dev;   /* BMC device */
+	struct mutex lock;
+	struct completion read_complete;
+	struct ipmi_addr address;
+	struct ipmi_user *user;
+	int iface;
+
+	long tx_msg_id;
+	struct kernel_ipmi_msg tx_msg;
+	unsigned char tx_msg_data[IPMI_MAX_MSG_LENGTH];
+	unsigned char rx_msg_data[IPMI_MAX_MSG_LENGTH];
+	unsigned long rx_msg_len;
+	unsigned char rx_result;	/* IPMI completion code */
+
+	/* Parent dir for all our debugfs entries */
+	struct dentry *parent;
+
+	/* debugfs stats */
+	u64 check_primary;
+	u64 check_primary_failed;
+	u64 was_already_primary;
+	u64 was_not_already_primary;
+	u64 set_primary;
+	u64 set_initial_primary_failed;
+	u64 set_primary_failed;
+	u64 set_led_locate_failed;
+	u64 set_led_fault_failed;
+	u64 set_led_readback_failed;
+	u64 set_led_failed;
+	u64 get_led_failed;
+	u64 completion_timeout;
+	u64 wrong_msgid;
+	u64 request_failed;
+
+	/* debugfs configuration options */
+
+	/* Print info on spurious IPMI messages */
+	bool print_errors;
+
+	/* Retries for kernel IPMI layer */
+	u32 ipmi_retries;
+
+	/* Timeout in ms for IPMI (0 = use IPMI default_retry_ms) */
+	u32 ipmi_timeout_ms;
+
+	/* Timeout in ms to wait for E1000 message completion */
+	u32 completion_timeout_ms;
+};
+
+/*
+ * Make our craye1k a global so get/set_attention_status() can access it.
+ * This is safe since there's only one node controller on the board, and so it's
+ * impossible to instantiate more than one craye1k.
+ */
+static struct craye1k *craye1k_global;
+
+/* Return parent dir dentry */
+static struct dentry *
+craye1k_debugfs_init(struct craye1k *craye1k)
+{
+	umode_t mode = 0644;
+	struct dentry *parent = debugfs_create_dir("pciehp_craye1k", NULL);
+
+	if (IS_ERR(parent))
+		return NULL;
+
+	debugfs_create_x64("check_primary", mode, parent,
+			   &craye1k->check_primary);
+	debugfs_create_x64("check_primary_failed", mode, parent,
+			   &craye1k->check_primary_failed);
+	debugfs_create_x64("was_already_primary", mode, parent,
+			   &craye1k->was_already_primary);
+	debugfs_create_x64("was_not_already_primary", mode, parent,
+			   &craye1k->was_not_already_primary);
+	debugfs_create_x64("set_primary", mode, parent,
+			   &craye1k->set_primary);
+	debugfs_create_x64("set_initial_primary_failed", mode, parent,
+			   &craye1k->set_initial_primary_failed);
+	debugfs_create_x64("set_primary_failed", mode, parent,
+			   &craye1k->set_primary_failed);
+	debugfs_create_x64("set_led_locate_failed", mode, parent,
+			   &craye1k->set_led_locate_failed);
+	debugfs_create_x64("set_led_fault_failed", mode, parent,
+			   &craye1k->set_led_fault_failed);
+	debugfs_create_x64("set_led_readback_failed", mode, parent,
+			   &craye1k->set_led_readback_failed);
+	debugfs_create_x64("set_led_failed", mode, parent,
+			   &craye1k->set_led_failed);
+	debugfs_create_x64("get_led_failed", mode, parent,
+			   &craye1k->get_led_failed);
+	debugfs_create_x64("completion_timeout", mode, parent,
+			   &craye1k->completion_timeout);
+	debugfs_create_x64("wrong_msgid", mode, parent,
+			   &craye1k->wrong_msgid);
+	debugfs_create_x64("request_failed", mode, parent,
+			   &craye1k->request_failed);
+
+	debugfs_create_x32("ipmi_retries", mode, parent,
+			   &craye1k->ipmi_retries);
+	debugfs_create_x32("ipmi_timeout_ms", mode, parent,
+			   &craye1k->ipmi_timeout_ms);
+	debugfs_create_x32("completion_timeout_ms", mode, parent,
+			   &craye1k->completion_timeout_ms);
+	debugfs_create_bool("print_errors", mode, parent,
+			    &craye1k->print_errors);
+
+	return parent;
+}
+
+/*
+ * craye1k_msg_handler() - IPMI message response handler
+ */
+static void craye1k_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
+{
+	struct craye1k *craye1k = user_msg_data;
+
+	if (msg->msgid != craye1k->tx_msg_id) {
+		craye1k->wrong_msgid++;
+		if (craye1k->print_errors) {
+			dev_warn_ratelimited(craye1k->dev, "rx msgid %d != %d",
+					     (int)msg->msgid,
+					     (int)craye1k->tx_msg_id);
+		}
+		ipmi_free_recv_msg(msg);
+		return;
+	}
+
+	/* Set rx_result to the IPMI completion code */
+	if (msg->msg.data_len > 0)
+		craye1k->rx_result = msg->msg.data[0];
+	else
+		craye1k->rx_result = IPMI_UNKNOWN_ERR_COMPLETION_CODE;
+
+	if (msg->msg.data_len > 1) {
+		/* Exclude completion code from data bytes */
+		craye1k->rx_msg_len = msg->msg.data_len - 1;
+		memcpy(craye1k->rx_msg_data, msg->msg.data + 1,
+		       craye1k->rx_msg_len);
+	} else {
+		craye1k->rx_msg_len = 0;
+	}
+
+	ipmi_free_recv_msg(msg);
+
+	complete(&craye1k->read_complete);
+}
+
+static const struct ipmi_user_hndl craye1k_user_hndl = {
+	.ipmi_recv_hndl = craye1k_msg_handler
+};
+
+static void craye1k_new_smi(int iface, struct device *dev)
+{
+	int rc;
+	struct craye1k *craye1k;
+
+	/* There's only one node controller so driver data should not be set */
+	WARN_ON(craye1k_global);
+
+	craye1k = kzalloc(sizeof(*craye1k), GFP_KERNEL);
+	if (!craye1k)
+		return;
+
+	craye1k->address.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	craye1k->address.channel = IPMI_BMC_CHANNEL;
+	craye1k->iface = iface;
+	craye1k->dev = dev;
+	craye1k->tx_msg.data = craye1k->tx_msg_data;
+	craye1k->ipmi_retries = 4;
+	craye1k->ipmi_timeout_ms = 500;
+	craye1k->completion_timeout_ms = 300;
+
+	init_completion(&craye1k->read_complete);
+	mutex_init(&craye1k->lock);
+
+	dev_set_drvdata(dev, craye1k);
+
+	rc = ipmi_create_user(craye1k->iface, &craye1k_user_hndl, craye1k,
+			      &craye1k->user);
+	if (rc < 0) {
+		dev_err_ratelimited(dev,
+				    "Unable to register IPMI user, iface %d\n",
+				    craye1k->iface);
+		kfree(craye1k);
+		dev_set_drvdata(dev, NULL);
+		return;
+	}
+
+	craye1k_global = craye1k;
+
+	craye1k->parent = craye1k_debugfs_init(craye1k);
+	if (!craye1k->parent)
+		dev_warn_ratelimited(dev, "Cannot create debugfs");
+
+	dev_info_ratelimited(dev,
+			     "Cray ClusterStor E1000 slot LEDs registered");
+}
+
+static void craye1k_smi_gone(int iface)
+{
+	pr_warn("craye1k: Got unexpected smi_gone, iface=%d", iface);
+}
+
+static struct ipmi_smi_watcher craye1k_smi_watcher = {
+	.owner = THIS_MODULE,
+	.new_smi = craye1k_new_smi,
+	.smi_gone = craye1k_smi_gone
+};
+
+/*
+ * craye1k_send_message() - Send the message already setup in 'craye1k'
+ *
+ * Context: craye1k->lock is already held.
+ * Return: 0 on success, non-zero on error.
+ */
+static int craye1k_send_message(struct craye1k *craye1k)
+{
+	int rc;
+
+	rc = ipmi_validate_addr(&craye1k->address, sizeof(craye1k->address));
+	if (rc) {
+		dev_err_ratelimited(craye1k->dev, "validate_addr() = %d\n", rc);
+		return rc;
+	}
+
+	craye1k->tx_msg_id++;
+
+	rc = ipmi_request_settime(craye1k->user, &craye1k->address,
+				  craye1k->tx_msg_id, &craye1k->tx_msg, craye1k,
+				  0, craye1k->ipmi_retries,
+				  craye1k->ipmi_timeout_ms);
+
+	if (rc) {
+		craye1k->request_failed++;
+		return rc;
+	}
+
+	return 0;
+}
+
+/*
+ * craye1k_do_message() - Send the message in 'craye1k' and wait for a response
+ *
+ * Context: craye1k->lock is already held.
+ * Return: 0 on success, non-zero on error.
+ */
+static int craye1k_do_message(struct craye1k *craye1k)
+{
+	int rc;
+	struct completion *read_complete = &craye1k->read_complete;
+	unsigned long tout = msecs_to_jiffies(craye1k->completion_timeout_ms);
+
+	WARN_ON(!mutex_is_locked(&craye1k->lock));
+
+	rc = craye1k_send_message(craye1k);
+	if (rc)
+		return rc;
+
+	rc = wait_for_completion_killable_timeout(read_complete, tout);
+	if (rc == 0) {
+		/* timed out */
+		craye1k->completion_timeout++;
+		return -ETIME;
+	}
+
+	return 0;
+}
+
+/*
+ * __craye1k_do_command() - Do an IPMI command
+ *
+ * Send a command with optional data bytes, and read back response bytes.
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: 0 on success, non-zero on error.
+ */
+static int __craye1k_do_command(struct craye1k *craye1k, u8 netfn, u8 cmd,
+				u8 *send_data, u8 send_data_len, u8 *recv_data,
+				u8 recv_data_len)
+{
+	int rc;
+
+	craye1k->tx_msg.netfn = netfn;
+	craye1k->tx_msg.cmd = cmd;
+
+	if (send_data) {
+		memcpy(&craye1k->tx_msg_data[0], send_data, send_data_len);
+		craye1k->tx_msg.data_len = send_data_len;
+	} else {
+		craye1k->tx_msg_data[0] = 0;
+		craye1k->tx_msg.data_len = 0;
+	}
+
+	rc = craye1k_do_message(craye1k);
+	if (rc == 0)
+		memcpy(recv_data, craye1k->rx_msg_data, recv_data_len);
+
+	return rc;
+}
+
+/*
+ * craye1k_do_command() - Do a Cray E1000 specific IPMI command.
+ * @cmd: Cray E1000 specific command
+ * @send_data:  Data to send after the command
+ * @send_data_len: Data length
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: the last byte from the response or 0 if response had no response
+ * data bytes, else -1 on error.
+ */
+static int craye1k_do_command(struct craye1k *craye1k, u8 cmd, u8 *send_data,
+			      u8 send_data_len)
+{
+	int rc;
+
+	rc = __craye1k_do_command(craye1k, CRAYE1K_CMD_NETFN, cmd, send_data,
+				  send_data_len, NULL, 0);
+	if (rc != 0) {
+		/* Error attempting command */
+		return -1;
+	}
+
+	if (craye1k->tx_msg.data_len == 0)
+		return 0;
+
+	/* Return last received byte value */
+	return craye1k->rx_msg_data[craye1k->rx_msg_len - 1];
+}
+
+/*
+ * __craye1k_set_primary() - Tell the BMC we want to be the primary server
+ *
+ * An E1000 board has two physical servers on it.  In order to set a slot
+ * NVMe LED, this server needs to first tell the BMC that it's the primary
+ * server.
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: 0 on success, non-zero on error.
+ */
+static int __craye1k_set_primary(struct craye1k *craye1k)
+{
+	u8 bytes[2] = {CRAYE1K_SUBCMD_SET_PRIMARY, 1};	/* set primary to 1 */
+
+	craye1k->set_primary++;
+	return craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, bytes, 2);
+}
+
+/*
+ * craye1k_is_primary() - Are we the primary server?
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: true if we are the primary server, false otherwise.
+ */
+static bool craye1k_is_primary(struct craye1k *craye1k)
+{
+	u8 byte = 0;
+	int rc;
+
+	/* Response byte is 0x1 on success */
+	rc = craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, &byte, 1);
+	craye1k->check_primary++;
+	if (rc == 0x1)
+		return true;   /* success */
+
+	craye1k->check_primary_failed++;
+	return false;   /* We are not the primary server node */
+}
+
+/*
+ * craye1k_set_primary() - Attempt to set ourselves as the primary server
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: 0 on success, -1 otherwise.
+ */
+static int craye1k_set_primary(struct craye1k *craye1k)
+{
+	int tries = 10;
+
+	if (craye1k_is_primary(craye1k)) {
+		craye1k->was_already_primary++;
+		return 0;
+	}
+	craye1k->was_not_already_primary++;
+
+	/* delay found through experimentation */
+	msleep(300);
+
+	if (__craye1k_set_primary(craye1k) != 0) {
+		craye1k->set_initial_primary_failed++;
+		return -1;	/* error */
+	}
+
+	/*
+	 * It can take 2 to 3 seconds after setting primary for the controller
+	 * to report that it is the primary.
+	 */
+	while (tries--) {
+		msleep(500);
+		if (craye1k_is_primary(craye1k))
+			break;
+	}
+
+	if (tries == 0) {
+		craye1k->set_primary_failed++;
+		return -1;	/* never reported that it's primary */
+	}
+
+	/* Wait for primary switch to finish */
+	msleep(1500);
+
+	return 0;
+}
+
+/*
+ * craye1k_get_slot_led() - Get slot LED value
+ * @slot: Slot number (1-24)
+ * @is_locate_led: 0 = get fault LED value, 1 = get locate LED value
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: slot value on success, -1 on failure.
+ */
+static int craye1k_get_slot_led(struct craye1k *craye1k, unsigned char slot,
+				bool is_locate_led)
+{
+	u8 bytes[2];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_SUBCMD_GET_LED;
+	bytes[1] = slot;
+
+	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
+
+	return craye1k_do_command(craye1k, cmd, bytes, 2);
+}
+
+/*
+ * craye1k_set_slot_led() - Attempt to set the locate/fault LED to a value
+ * @slot: Slot number (1-24)
+ * @is_locate_led: 0 = use fault LED, 1 = use locate LED
+ * @value: Value to set (0 or 1)
+ *
+ * Check the LED value after calling this function to ensure it has been set
+ * properly.
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: 0 on success, non-zero on failure.
+ */
+static int craye1k_set_slot_led(struct craye1k *craye1k, unsigned char slot,
+				unsigned char is_locate_led,
+				unsigned char value)
+{
+	u8 bytes[3];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_SUBCMD_SET_LED;
+	bytes[1] = slot;
+	bytes[2] = value;
+
+	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
+
+	return craye1k_do_command(craye1k, cmd, bytes, 3);
+}
+
+/*
+ * __craye1k_get_attention_status() - Get LED value
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: 0 on success, -EIO on failure.
+ */
+static int __craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
+					  u8 *status, bool set_primary)
+{
+	unsigned char slot;
+	int locate, fault;
+	struct craye1k *craye1k;
+
+	craye1k = craye1k_global;
+	slot = PSN(to_ctrl(hotplug_slot));
+
+	if (set_primary) {
+		if (craye1k_set_primary(craye1k) != 0) {
+			craye1k->get_led_failed++;
+			return -EIO;
+		}
+	}
+
+	locate = craye1k_get_slot_led(craye1k, slot, true);
+	if (locate == -1) {
+		craye1k->get_led_failed++;
+		return -EIO;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	fault = craye1k_get_slot_led(craye1k, slot, false);
+	if (fault == -1) {
+		craye1k->get_led_failed++;
+		return -EIO;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	*status = locate << 1 | fault;
+
+	return 0;
+}
+
+int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
+				 u8 *status)
+{
+	int rc;
+	struct craye1k *craye1k;
+
+	craye1k = craye1k_global;
+
+	if (mutex_lock_interruptible(&craye1k->lock) != 0)
+		return -EINTR;
+
+	rc =  __craye1k_get_attention_status(hotplug_slot, status, true);
+
+	mutex_unlock(&craye1k->lock);
+	return rc;
+}
+
+int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot,
+				 u8 status)
+{
+	unsigned char slot;
+	int tries = 4;
+	int rc;
+	u8 new_status;
+	struct craye1k *craye1k;
+	bool locate, fault;
+
+	craye1k = craye1k_global;
+
+	slot = PSN(to_ctrl(hotplug_slot));
+
+	if (mutex_lock_interruptible(&craye1k->lock) != 0)
+		return -EINTR;
+
+	/* Retry to ensure all LEDs are set */
+	while (tries--) {
+		/*
+		 * The node must first set itself to be the primary node before
+		 * setting the slot LEDs (each board has two nodes, or
+		 * "servers" as they're called by the manufacturer).  This can
+		 * lead to contention if both nodes are trying to set the LEDs
+		 * at the same time.
+		 */
+		rc = craye1k_set_primary(craye1k);
+		if (rc != 0) {
+			/* Could not set as primary node.  Just retry again. */
+			continue;
+		}
+
+		/* Write value twice to increase success rate */
+		locate = (status & 0x2) >> 1;
+		craye1k_set_slot_led(craye1k, slot, 1, locate);
+		if (craye1k_set_slot_led(craye1k, slot, 1, locate) != 0) {
+			craye1k->set_led_locate_failed++;
+			continue;	/* fail, retry */
+		}
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		fault = status & 0x1;
+		craye1k_set_slot_led(craye1k, slot, 0, fault);
+		if (craye1k_set_slot_led(craye1k, slot, 0, fault) != 0) {
+			craye1k->set_led_fault_failed++;
+			continue;	/* fail, retry */
+		}
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		rc = __craye1k_get_attention_status(hotplug_slot, &new_status,
+						    false);
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		if (rc == 0 && new_status == status)
+			break;	/* success */
+
+		craye1k->set_led_readback_failed++;
+
+		/*
+		 * At this point we weren't successful in setting the LED and
+		 * need to try again.
+		 *
+		 * Do a random back-off to reduce contention with other server
+		 * node in the unlikely case that both server nodes are trying to
+		 * trying to set a LED at the same time.
+		 *
+		 * The 500ms minimum in the back-off reduced the chance of this
+		 * whole retry loop failing from 1 in 700 to none in 10000.
+		 */
+		msleep(500 + (get_random_long() % 500));
+	}
+	mutex_unlock(&craye1k->lock);
+	if (tries == 0) {
+		craye1k->set_led_failed++;
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static bool is_craye1k_board(void)
+{
+	return dmi_match(DMI_PRODUCT_NAME, "VSSEP1EC");
+}
+
+bool is_craye1k_slot(struct controller *ctrl)
+{
+	return (PSN(ctrl) >= 1 && PSN(ctrl) <= 24 && is_craye1k_board());
+}
+
+int craye1k_init(void)
+{
+	if (!is_craye1k_board())
+		return 0;
+
+	return ipmi_smi_watcher_register(&craye1k_smi_watcher);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tony Hutter <hutter2@llnl.gov>");
+MODULE_DESCRIPTION("Cray E1000 NVMe Slot LED driver");
-- 
2.43.7

