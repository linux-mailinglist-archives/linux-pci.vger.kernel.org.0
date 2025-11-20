Return-Path: <linux-pci+bounces-41816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B5C75884
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 18:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC18D34588F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41C13644C6;
	Thu, 20 Nov 2025 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="c35OYzSd";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="TDERG8nv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937D2E3AEA;
	Thu, 20 Nov 2025 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658107; cv=fail; b=RbeizSbNbaiybicm4oRjP8H4KaLlViBVCH7fSmjudyszq+oovJS/C+/jAPdC3js5f4FYQe8WmR21aO+lNqXac68xObhX4PHaFZMpSnCFn4585RYWo7JdoHDRoL3lqg6nNoDzJ+SRWlOBvI2juK0k4fZXIzLki+IrC1ngVCeIvHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658107; c=relaxed/simple;
	bh=S8cHEKVwWhSa+Vb2B4dZqj3xQh2XTzs8nuHUkBthU40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OsyTTCjAM4shQHnExDvOC4Ps/uuRK3DS3vgQEBWGdoFXV/rbPg8fuEiGgivO3TeZCCmncuBI71zMtx/6XlvuU+e34fvn3j30d44mcu4bgzvVz/DWNOWahHtMxmYg4kS7NVpErBcuDRQIAQduYWFF1lmVXhlM7Yvi1lBVONmkk+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=c35OYzSd; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=TDERG8nv; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AKGH7bQ2737335;
	Thu, 20 Nov 2025 09:01:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=824g7+kxEqx7xAjnmQtN+76+ey3iOW5HhTvWkqXiX
	bg=; b=c35OYzSdx07jMtPqNbAizeCOiWU9VG5h/hGdeNXQeeNQnQfhcUmGSUJ+/
	RbgwnaGQocbkVLe051qiNOxleh7M9A7ryFrJAj5RUt3obfrWQ0P/kbFR56JvleaV
	uw8SlFaH7daA8GqRhavr52ThybfY1Ojub74W3jqopNdUdCGOLs1klHqG1WzzYlKb
	REPl3g6jYMiYFZSwVIUIAqXbJGgkOYwGqnPYLxdDh024WrNps1l6Km+kkHC/VND8
	vxVX5b5trGdE85WYQfW5zqBCRX5BDdQKOPhaDCvkI5STUigHy0NwhLjbhjx4QX6J
	8wlX9ps6afa08HaMUrig/AZoKNRsA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020133.outbound.protection.outlook.com [52.101.201.133])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ahwa6hevc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 09:01:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLGiTaWyMeiLKR3MTuIFJVd5YFG/2Iqvn7SN6gsD0X2oExb4l+4rbfhYFhgdoyZxte37fRdG6wodbvaJc0KRKtILXOLcbIHeu6QS+7rX4r0CsGIJ5jJvwJJ7cRMWUZEeRp4NZO+A+OsHetZJazMoBwdiIuaZVocLuHmOYO5+CnZdHjB5xzLXKRmBjv/s3e7gU5qSvaWQfVSHcWGmLw6r712lcwbktdja/HKKiEKu/AbrPkGEHp3MUQloqcFN3pYJf3LAetJTs7tL0f2bORnE3P2olEclmnqI3a6RWePbAW6m+yDGF/ToY/H9K0DtNuD2TRfnqPFGcWeJoP3XqPARTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=824g7+kxEqx7xAjnmQtN+76+ey3iOW5HhTvWkqXiXbg=;
 b=LOjJtO6H4Ftv8GqKwp4z7xl0uvSg1r5N6zBswJ40aXR6854EthJf8hHmisAE6TXX8UxEPiEEEND7bnqaiOagczA4L/LU5LKBxnDnwHi808wjgNR6XrPCyU5lhpgHoboV2YBHOyK+zlplEolYVAtRcG/TsVMPPITk7IRD8OLXxLNUnoGndfkBJQF8Yz2jDTWfE2UB9NNRG5xqZaKDjUZmk9pNaXjKem6RswhHJxfLRJp9eyCzUhxYXRnJPa1882i7UBOgT8rm/luwLdlpFRNLWeJkuhrPUoJUAIl85Y8ye62bYBa6xOE2VG4QngZKtFS2ILVI6AbCJhW1a9fZmirmFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=824g7+kxEqx7xAjnmQtN+76+ey3iOW5HhTvWkqXiXbg=;
 b=TDERG8nvbT/QLVq1Thpd7nXx5WuL5j4eAKzyQtwjCbuxoNNQd8oAq5ysUkxgteQf7VsH3/MzXu1LjANWubzf/fXLz/BC69DaBUxegUCBGapqN37D3E4aCA9QWq7NhJ3NU91y19IpCXHlJWiZsDVb8BBZNivu+NdlBGx4NVrWxqyFQISOEDBDyeRGDUuTv/NZS6bzBBeUCqNLfGOssssX14NiPG2RdAIReI+4Ro9G+y4CWFTpS5+bSF3MlaV+8JrRYcxbOWrBpeHfNY0CHZwuRDeNZIh2MM1lP9Vzhp8ot+DOtu3PAxByJTOFIsp2RQa/8fMZGow6JaIyYfyZLGgUTA==
Received: from DM6PR02MB6731.namprd02.prod.outlook.com (2603:10b6:5:222::21)
 by BL3PR02MB8019.namprd02.prod.outlook.com (2603:10b6:208:35a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 20 Nov
 2025 17:01:29 +0000
Received: from DM6PR02MB6731.namprd02.prod.outlook.com
 ([fe80::cb2b:6e78:5fae:c926]) by DM6PR02MB6731.namprd02.prod.outlook.com
 ([fe80::cb2b:6e78:5fae:c926%5]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 17:01:28 +0000
From: Vincent Liu <vincent.liu@nutanix.com>
To: gregkh@linuxfoundation.org
Cc: dakr@kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        vincent.liu@nutanix.com
Subject: [PATCH v3 RESEND] driver core: Check drivers_autoprobe for all added devices
Date: Thu, 20 Nov 2025 17:00:49 +0000
Message-ID: <20251120170049.1214577-1-vincent.liu@nutanix.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251001151508.1684592-1-vincent.liu@nutanix.com>
References: <20251001151508.1684592-1-vincent.liu@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::25) To DM6PR02MB6731.namprd02.prod.outlook.com
 (2603:10b6:5:222::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR02MB6731:EE_|BL3PR02MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 176839c0-731c-4f94-9c78-08de2856727e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o1vR+HjzHSF2lazBvtdwuKALMkMGNSd7pob3quwkV36iwvTwEm0zI7oM28bQ?=
 =?us-ascii?Q?3r7U2eu18/JSLoESPpTM+WZ94JjunfOz+NMlFgBk8wGOaSVUM2r2a07bgT/Z?=
 =?us-ascii?Q?WGidJHEdkZao3BCrXeTbCpG+NMQ4suc2IUKfZvlMWI1cMiTPICovsbinq/0c?=
 =?us-ascii?Q?jmZUBJ6ssFksvAqxM968Fwm6vD5IV85vL4JFnSWVFxr2SG7PVUWfBeaZLaKr?=
 =?us-ascii?Q?j8z0CH9rL+AW3dfvNeL6zr+7672+TryFZu/O8TrgXor4/wdVrswS5biiIZLX?=
 =?us-ascii?Q?W9HTKEHUZqOq5JCElhYjNOEvrIVesIk63sbk6WrGQF0STB52PalOzZ9yItlQ?=
 =?us-ascii?Q?saDIFwdU+TegkNGMZog5lYBCSYchgTQAlhWHtlThDQ+dUYNhy6DZwoLJPmbq?=
 =?us-ascii?Q?VxYHDL/oVGCuHwK5gFIGpg6qOHXoeWylOgHudUDN9YtydcKeIHRkYYuG3QVt?=
 =?us-ascii?Q?UqSXqjcpQqcXDTMjpD8MkfDWpMsyeL3hEVyJLYAeThbzoNHTc+w2SsEDS611?=
 =?us-ascii?Q?97QRSlJouXmNDOIfOxiX9W8TWkVGMOixuH5xTtwwWxAnc4ECe3sFxww26Wyc?=
 =?us-ascii?Q?a2Q94MQGqsBviU4FX3gBYPa8fXDfR2c4ta7fO+u+tXUOrALM5ZauVBsslKvQ?=
 =?us-ascii?Q?z7KguVZnjX+1JfaxeXJa/P82zEp48C9U/sjK0SqhlxYRG/mRxkW/Ter/+qST?=
 =?us-ascii?Q?Bo7RYYFmETIJxYooSxHo6ILBA1IV0UeCPxTltKMLwK8MOXUWG3gUxg2dtLcV?=
 =?us-ascii?Q?8i7QPbxdcsHNRsiOlP2CH1UKO/Loy3KnFPrihy2odkfnWs6aq3UuflWSAC29?=
 =?us-ascii?Q?XuW6dZ74luM2mTtStC/HqB6JkJi3/U3oCmOb4DjzM9CBFFW/BVStepF/Kr32?=
 =?us-ascii?Q?dsizm0pYiXoMfH+J6pKQ62wVF2jJ2tAoKbgGd7QrunBUWdQ3QBysUZ+WmkMg?=
 =?us-ascii?Q?wgrF/EM4pQ7F20uMNWj8JGKMFJimkIU377OfbRoSUAeUdd7pNe5m4TlUJvCx?=
 =?us-ascii?Q?uCIm6EyCDst1b/QvaUjjrY4WDn+x5AAvZGi2r3ftZS5A+6U6YmpE0gCqHctD?=
 =?us-ascii?Q?pkTsvBxxV19m2BDIE8rGOcOP6qrvdk5y6O4Gu4cx2AjKCnzBWzC8x22zkhBf?=
 =?us-ascii?Q?erQoc6Zm5m8uE3fyCIgX9o9Q84YCSDiFXxN9JaDZ6GJpNE8/0T+TDDCtjbMp?=
 =?us-ascii?Q?BffeZSYsM61VRbJ+MZbqU1rW8oYWdIqA/qSwlKsNmO203qyNQTq9Qw35BRU5?=
 =?us-ascii?Q?vR3KfewCfgybabJ/MwkS4K7xerhw59mhk60F0aHGAzmDXVLFDaC0Ojp+RhEz?=
 =?us-ascii?Q?mf8bafXSLu3vLCYqFz7HUtwbNurMdxjN2XgHNUvdurtf0I8lWKavBSRBeP2a?=
 =?us-ascii?Q?cbffJjR4JIRzsSJmFegMMLX5Ekrcuui9D4L9nEqzX5QN1MOzig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6731.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d5u298022xjYXjTMsCAI4/VDHEliQSi/lRyk/iMBVcmKZG+tXuxtz7OWrAdZ?=
 =?us-ascii?Q?AFWFdPi+R4XJUG698nYDbjHiCBNxOEKVpjm6sa0uI/8eMBQNgwU0ICD1EknY?=
 =?us-ascii?Q?zPGTKkRZLegUDz+4TiMRpTBb5o8L+4NyZhXWL6GlsdmoZk84QjYfqh+H3Fu1?=
 =?us-ascii?Q?MMV+eM4U9hX9gyAZX4K8UAVzSTJwSA2edFokBQ2WIVvHN6H5SkSqWRvkDN4t?=
 =?us-ascii?Q?g+pxeZ55639B9Pcx6x/BSxfAAPspAZ9+AE3EMd9PwYdbhhzFpWDlwJZi7iHO?=
 =?us-ascii?Q?MoUZq3OoyhFKT8pnEgcwd7aSoNhLJbblGsKRemwkTcPG58w47SiWzjvyltni?=
 =?us-ascii?Q?233UTaGa+494bHFZSOEiUDRX87Vvz7e2hsBzO+Drq4zmPDiGs+mWPdjTXTuG?=
 =?us-ascii?Q?gQMtxtAyXUiEGxquqaATMb3cyrBcjXmtXIEr7jFHDmtxp4Hji40bnuMfRrGx?=
 =?us-ascii?Q?INImTCztF8n9jcCdfWWdTZyDJOnFjBlp0OvLK7G8d3aMGe4BcnV7TewNA8Wa?=
 =?us-ascii?Q?ucZGokHk3z66/syZxChSfp7quEf35iH/DqgWg87x2rD9DedOTVJDnpHjqzST?=
 =?us-ascii?Q?VLpFdc8aAoY0qa6ExyiYcXIP0GOfohYP00D6dIzOUeQzkh/BoYqB6Fn/Xbok?=
 =?us-ascii?Q?jtY/j5eRoK5qgT/C21A5sfU2tpJvafyhsDMzkv6K20y1tqNMUmsGoV7zeksh?=
 =?us-ascii?Q?oJOgLxhmhf5RNJlGpRVBE0febP0j9Rj2P+4Z8WqNTtlKJUgqOjmHgs0Ig9BE?=
 =?us-ascii?Q?N6ikfgxX4X2bvj6arnXYLCEDNeWRmrXi32tvl7j/EBsxQamIF+QvZFIT0Iaj?=
 =?us-ascii?Q?8KmFVd3mI8dpOe5xLLYc4SZRfmrSKsfsBNTXsuJWsaW/e//yvmybs3UUk72Z?=
 =?us-ascii?Q?YLQ8iKkJq+vmxVWAm41O9oAfK3L1HI+saITW8hb0c3hSpguBf2gyP0pKWoTd?=
 =?us-ascii?Q?ULUSnKtzWf8RphuwJJlCZLlniefRFsUkrSzbyNEJUhYUH7plYCrNLcfOQQaM?=
 =?us-ascii?Q?kwypNjfWbMNqcqr3p0yovNEaEAL1FRcLtliGeul3BTsegBpEKOskuhz4UYyQ?=
 =?us-ascii?Q?KPuknUUdz33ADpI6AIfGQWgK/h9KLkHJeai2yZEo/awwESiaZC53X3uGX2NE?=
 =?us-ascii?Q?wuiQDcOHyRytP94YC//ap58yjxuN/NgIXRZVoZWz5c8TgW170FGbYZ9g2RFm?=
 =?us-ascii?Q?MiGubOuvNtpbiTpnW2SJrqCoxvJ807DUOPIe43v6a23r6CiOZ+dYP5PQnXJR?=
 =?us-ascii?Q?drQw4U21g06gGxQ7HpiCndQCcUXgstc2dPzmJq86l6dTu4rrh2mpfu5GECm0?=
 =?us-ascii?Q?1RVeVW+RyPKi7tCjgG9/GdhUegH3DziCzYiXvi+T25WlxDYvFZgmdxA+vRuw?=
 =?us-ascii?Q?70RZNVob0cmnGn0FpC9BW7uLoQS10D3XbIMBaClF6owEPKzr6/uPBEV8cZoI?=
 =?us-ascii?Q?6ZyBR8l1JtGU8lx+c8A5UQDzMmE/p58kE3vg2Q2Xsu7Sxl3t+UOnE01oiyHU?=
 =?us-ascii?Q?ApazcnE56kR+SgG6nckJMqEuxvCQRYvtlypA7pdnoK+JjuoHW+MwVTX23dUh?=
 =?us-ascii?Q?eJwkBsPNYoATvOrcGsvvSnvST1lvw6VWCpOSAeqj/RESySckf3GAswaq8FB6?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176839c0-731c-4f94-9c78-08de2856727e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6731.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 17:01:28.7903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBhnkq9zs584sP0CgUWvlKVy6H/V/gpT4/xFHFvJcfXP+bRD0t7bnBGiZQZ1wqCX6JPul3x2DslXyjmuUEz7lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8019
X-Proofpoint-GUID: 3d5l0gPeijhuNgp1lDCVVq149uBoYYvE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDExNCBTYWx0ZWRfXwDX3fCjcfmEv
 uYniP3DpdJ460czj6Nq8yn+C1LwQWPxh48wYZYKwcJYtgp8Ev6ph8Ym/fk5b0NMD1+/djvSPZ4W
 ze+sr67HpzCMtSugBJkN0t+uUlaVmLZB2aVhmsVND0PrrHRi7dgSxUtxEojOV/JA4bUCtDnkU0s
 0QY8fuN/QpPJHOi23rSLd+uw+1LtAElhMcOAavgVpzwCY1aDmihS4BIcO/Ee99pnyXM8S2+dhbl
 QvE2t2nxj6R9FdOzJx7iGy8uzqXbifP4ei3x4MWHAA4ypziLdxAEE4PQL48ttoLxxoffwc4tXnB
 bqMtL8kT0ejT6YAMQQtYM5e0vVaoqf03oUoGnDEtaAMzeyUhJ2jygwU5t+AXTEdohMgo/Z3NRoM
 KDhFWUTSkLvQJeAXz3anqast9ep/NQ==
X-Authority-Analysis: v=2.4 cv=Pr6ergM3 c=1 sm=1 tr=0 ts=691f4973 cx=c_pps
 a=jUwHYlc/2yWvgdYQnTyS2w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8
 a=UKb-53nmPGg_TUI14_4A:9
X-Proofpoint-ORIG-GUID: 3d5l0gPeijhuNgp1lDCVVq149uBoYYvE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_06,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

When a device is hot-plugged, the drivers_autoprobe sysfs attribute is
not checked (at least for PCI devices). This means that
drivers_autoprobe is not working as intended, e.g. hot-plugged PCI
devices will still be autoprobed and bound to drivers even with
drivers_autoprobe disabled.

The problem likely started when device_add() was removed from
pci_bus_add_device() in commit 4f535093cf8f ("PCI: Put pci_dev in device
tree as early as possible") which means that the check for
drivers_autoprobe which used to happen in bus_probe_device() is no
longer present (previously bus_add_device() calls bus_probe_device()).
Conveniently, in commit 91703041697c ("PCI: Allow built-in drivers to
use async initial probing") device_attach() was replaced with
device_initial_probe() which faciliates this change to push the check
for drivers_autoprobe into device_initial_probe().

Make sure all devices check drivers_autoprobe by pushing the
drivers_autoprobe check into device_initial_probe(). This will only
affect devices on the PCI bus for now as device_initial_probe() is only
called by pci_bus_add_device() and bus_probe_device(), but
bus_probe_device() already checks for autoprobe, so callers of
bus_probe_device() should not observe changes on autoprobing.
Note also that pushing this check into device_initial_probe() rather
than device_attach() makes it only affect automatic probing of
drivers (e.g. when a device is hot-plugged), userspace can still choose
to manually bind a driver by writing to drivers_probe sysfs attribute,
even with autoprobe disabled.

Any future callers of device_initial_probe() will respect the
drivers_autoprobe sysfs attribute, which is the intended purpose of
drivers_autoprobe.

Signed-off-by: Vincent Liu <vincent.liu@nutanix.com>

Link: https://lore.kernel.org/20251001151508.1684592-1-vincent.liu@nutanix.com
---
v1->v2: Change commit subject to include driver core (no code change)
	https://lore.kernel.org/20251001151508.1684592-1-vincent.liu@nutanix.com
v2->v3: Updated commit message to use PCI and include history (no code change)
	https://lore.kernel.org/20251013181459.517736-1-vincent.liu@nutanix.com/
---
 drivers/base/bus.c |  3 +--
 drivers/base/dd.c  | 10 +++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 5e75e1bce551..320e155c6be7 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -533,8 +533,7 @@ void bus_probe_device(struct device *dev)
 	if (!sp)
 		return;
 
-	if (sp->drivers_autoprobe)
-		device_initial_probe(dev);
+	device_initial_probe(dev);
 
 	mutex_lock(&sp->mutex);
 	list_for_each_entry(sif, &sp->interfaces, node)
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 13ab98e033ea..37fc57e44e54 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1077,7 +1077,15 @@ EXPORT_SYMBOL_GPL(device_attach);
 
 void device_initial_probe(struct device *dev)
 {
-	__device_attach(dev, true);
+	struct subsys_private *sp = bus_to_subsys(dev->bus);
+
+	if (!sp)
+		return;
+
+	if (sp->drivers_autoprobe)
+		__device_attach(dev, true);
+
+	subsys_put(sp);
 }
 
 /*
-- 
2.43.7


