Return-Path: <linux-pci+bounces-42461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D8BC9A977
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 08:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EFEF3479DD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 07:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E2B29BDB0;
	Tue,  2 Dec 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jf3M4DUn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OquZ5v++"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B02302CB0;
	Tue,  2 Dec 2025 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662235; cv=fail; b=X4g9h9U7W0vS/EYMgXIZtUD4PYib14Cy9eY1rKz0MtpKyA8+WdVO8ZkrOIaOtTG+Vszga4hq4W7KyM2A/ylejD+eqpRix9MoaWI4dtGSpdDiMfMBAoQAIBPNd2x/QCFHeeTKQ4cc6mUu0Nmo/XfclscUcXWJvTYewqn6nZMT+c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662235; c=relaxed/simple;
	bh=s1M1TJ4BoZpMJSnbVoIoMhbBG3L5VSWJO8XJKILIihw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vBkGVGrFF2znwEr1eC3MMu+SkEypw01rCftupgPJ0ekESxaIisk9KuPtHEtje8bfE4fyEDjF85FfjSLrDtMBvk04cwNUjBlPXOkuDl1Rmhr7NXatqR4nAJ4RxyCePhX+gPALnCIQb8VuBT57s9kpClHiSHLsy2ERjf3NTnFpw4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jf3M4DUn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OquZ5v++; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B21NFR13288199;
	Tue, 2 Dec 2025 07:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=s1M1TJ4BoZpMJSnbVoIoMhbBG3L5VSWJO8XJKILIihw=; b=
	Jf3M4DUnQ02wlcmSwIyNmm31Pj2s1k8GJAsyxGBwnCccra+LS+L0N3gbnjkTblsg
	fppXvXSbJ0RpLbjtbAi0NVZefQamDLcvba1Z0inJZuPO3h4d++4MiSkpPpKUS0iK
	LW1y1Ix/fPIITXPbCL8IEiEEQXBWpkSp+4tPQ0MF/oMbUEVqZ+zSJLS+lNPNqtlu
	ldiPFURL1TCQW45AUe/N+6KipPkMWSGgNBUZwflZSfTmdkCqV+O0odpeODfQv6+0
	t/Co0q33+iDtWfMW3qNlwWGcqcI44866LjOnI12AyjLtFioTtVpK/zyLShNT/vtj
	85bC1KiWTblB+T53O0DtTA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7f22b82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 07:56:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B263eW1015018;
	Tue, 2 Dec 2025 07:56:46 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq991xh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 07:56:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8Dg99eCGfdrXXsbcZfDCxhkv4/4QQfi7iMGmib/fH6V7swzJn6+EiGOLNAhBoPHxok/wL4uYgEMa7Gg1xBiJGzlkV946NSCQwPZiaLKs7pY+mKP86YJ2I47tM5LW091VYVSzA/79yIMzQiD3EhSCABEg4y+YwJQFjXKQcyM4wtu6DyskLHTqA4Wz/FW7JVkyAVhILnNtkISnbt5yk+vsm2UhEBx6X/Dd71RtzFcU9wB4u5jcF3OhsG4sWUTOkXKveC7sptNq59Q+2pDvm/q5QykJjmREF8bByrm92ytV9H1MrqdCtdPvkP4iGkQ8ONrVUyGEAp74tffiZnrbjCeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1M1TJ4BoZpMJSnbVoIoMhbBG3L5VSWJO8XJKILIihw=;
 b=CgJxhqkH0yqfg3BKQKsI4zAFsVfQRRUbufoRLcgSAiT0Ui2MYnyw0zuRowu0Rw9Rl24DU4zlQFiDR0PPCO4FuE3Vp5gC3l0zhmx+Yy20XVDx76uTS0oSkZ6NUbeX0d/iOWuPsaNM5WAIuUpkiLyPFys9pKzKyCpK+pARvT+HqoFfocOlaI1eIrzfKx69vOfdt6mUKWUqFfcXnap4bMOwnPgqHtnGStRUUpfPnF4dLdMSUckz9qAOKO5z/sz5IWhg93mZ6Du70vA9NWFzxmJFJYriEVn3Qf4NVxXWW6z3JJxytyuDbGNklLg3oF4syi6COidRx9h0qWgfJjKQOsJ/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1M1TJ4BoZpMJSnbVoIoMhbBG3L5VSWJO8XJKILIihw=;
 b=OquZ5v++LIlVid9WJ0FyNrkXi/VMVUYnNZt6/8Wg1sgRg8CVu1LrRg7n0l2uDe66Fbu9MiSqGfQ2iKhMG43YK6EdVAebtVCjWq5FPCTfVjWGKzNIpV57JyKuL0doPeLNOS7+SO25wUmYnDVkju/L7Gfdv2JXcn9MgUOu9zEIxgM=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by DM4PR10MB7428.namprd10.prod.outlook.com (2603:10b6:8:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:56:44 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:56:44 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Do not attempt to set ExtTag for VFs
Thread-Topic: [PATCH v2] PCI: Do not attempt to set ExtTag for VFs
Thread-Index: AQHcU7piSqDn1py/UkyQpwwZm9YksrUOGuYA
Date: Tue, 2 Dec 2025 07:56:44 +0000
Message-ID: <99561464-1C66-4075-9963-C67F8C492E46@oracle.com>
References: <20251112095442.1913258-1-haakon.bugge@oracle.com>
In-Reply-To: <20251112095442.1913258-1-haakon.bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.200.81.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|DM4PR10MB7428:EE_
x-ms-office365-filtering-correlation-id: 73c53b4c-4ade-4d57-b359-08de31785656
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVFydm82NUJkU01oU2swODZVSThiSk03Y1FmMU5BVmZiM2psUmJOLytQVFYw?=
 =?utf-8?B?TnR3OWtvcDEzMHhBUDd0YnNYSjZVSW1sczlMTVRuMkI2V0JuT0ZpRlEyb2ls?=
 =?utf-8?B?NHhEbjd4N0FnTkZ3Ly8wTmdvc2hOUHRKdlRReWgreHBTKzhOVWdMUWJWV1Zq?=
 =?utf-8?B?ZThpWDZJS0tGbEtLeml1aUVKZ1BSd25YcU83eUR1VTV3bDRtdkpSU2h0WDVi?=
 =?utf-8?B?L2grNHZYbkllUWJaUnNTaHVWMlE2RFpvbmQwTzI2bzM1NnU1MExJYS8zbElv?=
 =?utf-8?B?MS9LdW9jbXo0SVNkRW0rKzZDVXhldjN0RGJWZUtWc2xLblF1Zmw1UDNHSUxy?=
 =?utf-8?B?ampCNU9KUkN6cFQ5RFN3bjNuV0JLNXliT0pwNG9QaUlQdjNWOGFJSWwvamsw?=
 =?utf-8?B?ZzBYekROMGovc0Y2N2tCZEVoOFlpd0FyYldqWk93d293b09WUDQrNHJDTzM4?=
 =?utf-8?B?di8yWlVjbnFnRjVzT2dHa3gyS0dkV0tjUHdPcGJZQmI1ek84ZFh6cnBDbG41?=
 =?utf-8?B?bGsyV01QeTNsSlIweFJpUzZjMEVWN0JkS2dhbEpTdXdEdks2VHhEL1UzdWRk?=
 =?utf-8?B?QlFNUFVWNG81djJsay80bnRKZm9za2NmZ0xpMG9HUmIrYmUrb3NaYzh2U251?=
 =?utf-8?B?Ykl1TGJCVVI3cmxucVZPditUUjJ4dkNWdWVtWVErL3VscDBBZjgxb2tnazgx?=
 =?utf-8?B?Vk5tZ3VzaUhXSkVGcFBNRnU1MHc5UWh0cVRkUysxRG9HSWNMVmZldkhBeWtX?=
 =?utf-8?B?YmxDdWNpWThOazdQZUJmNU9WeDQzWG5rU2FMTXhsTk9aYXkwbW1mOFNpRVk3?=
 =?utf-8?B?cDBYZDIydlhwb3RmbHZlQ2xObkxYRFZrR0NHbVgxQlBtZllUcnBBZFdPQUp2?=
 =?utf-8?B?UzJBQXFDU25MMlNmRmZwTEJqeFhuQktvdXlNWUIvT05GWGFmNitvc2NHNjdM?=
 =?utf-8?B?YUlXbGJPOVNLYWFaTEJCSTg3U0gyMll0eWpLeW9OVW1ZRGZ0VlNWSU1nUEVp?=
 =?utf-8?B?SXFtTEpUODhWaE1SelRGVFFxRHJydWQ4TGtHN2VxWHRCN25XS1plM3p4NlpH?=
 =?utf-8?B?NTh6c2ZNWDVSN3BCSHhyeTJkekE5ZEtTUVVKMXJHQThDT2RjZUJLMDhLRFR6?=
 =?utf-8?B?dDVhRXVlOVRJOUVsai9ad2xqZFdwY3dtcEJUVkgySzQrZDFKNXpsQzlQN2F0?=
 =?utf-8?B?TEpKU1RIVnBoRmc0Vkk4S2pBQWRRTXRkczY1RkVSZ2xlQmYvTWxRakdtM1F4?=
 =?utf-8?B?R21xZGZLY0xtWWtXMmxYV3VKS3VqczdQM2g1aXlSZlpEc0Rkc3VXSDI4akln?=
 =?utf-8?B?Uzk1RjhrN1htWG1kclhZOWV2ZEtCOFIzeDEwODRsQmFlQmpLSU1tRURwWW9p?=
 =?utf-8?B?MHJNZ096MVd1MVBkK2lxUzFwcDF1Vmh5NE5hanBOY2QxdFVzWUhBUmt2Sm40?=
 =?utf-8?B?b3RnaG9hU3BVYTRDRFdqMkw3YU1ud2VaQTBvOTBMdmhEVFc3aU84QTlHcnZP?=
 =?utf-8?B?NU9DZHZLNlVtSk5BbjJzY3kzUWI1RFFnWVVnN0Z2eWJZaTZ5VW5vRkd4RFBx?=
 =?utf-8?B?VnZuUW85T0IzY2dBT0Y3SU5yUjFyRHkyQ0ZETDNtWkQ3WXpIQTdxUjlYNzBp?=
 =?utf-8?B?WTFqa2xGcWtiWmFPQ2Vuek9kZktSK0o5di9ZYnMxV0c5bE1zajkvbWZkMUdi?=
 =?utf-8?B?NnVoM1RLb1lPRHJXdEdoR01xZENjRWdRakE0NWR6bCt5Y3NOQzRSS3R4dXRa?=
 =?utf-8?B?N2g4VldMbXNnYUdWWE05UDZDTWZRQkxBM1VvMDE5bFNkeGd0elJtUEpLd2Q4?=
 =?utf-8?B?cVQ3eFFXN2V3c0owSmxHYTQzN29zUFIvclpjaisvMHFjT1FYVlhLc3JoNWZ2?=
 =?utf-8?B?Rm1ORGdoMWtCOFI2T2dGRmtia2pqWUJhRUlOd1Q5akYvSkY5UGJnd1R6QkFG?=
 =?utf-8?B?TkhnaldqZ3FIdDVwSkFyQUJJb1ZjQ09LZldTeXhFcDlMUSswbnp2cjVEUXJJ?=
 =?utf-8?B?dzVjckNFWTl4L2YyWVZFdW9TMEYvY1FxZTlxTUx3L0ZLZkNxWU1HOElMb1Nx?=
 =?utf-8?Q?z18nEo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVczclVGN2pLWXdMVlNJOWNKV0pqTGxQUjB3VC9zTkh6VUdLc25QckVEejdC?=
 =?utf-8?B?b0lhYWdTVjcxQ2JDby9CS3JvY0d4NnRTWUpIZitkMHg0N0Z5OTFGODhKVS9D?=
 =?utf-8?B?YkJsWndaMHUvcFhPdzVaSGdEK1AxWEJOdXNDRlhzUHFVbGppWE5yZitsQ1hF?=
 =?utf-8?B?VS9tdElUVnM0ZzF6eVRwcmpDTjN4Z1FEWFNhS25pbjdORFE0S1F6ZHZMN0VR?=
 =?utf-8?B?cmt1a2RWR2QvWFVDTVZoclhSRStteEcwa25MUWJWbDA1eEt2aC8yOU56NmZS?=
 =?utf-8?B?UTBPYldqZ0xtbVlvM3RZeC9BeVkyMURlM1F3UDIrRGF5WENGYllaLzdWUHlC?=
 =?utf-8?B?clZiVFl6Z1NpdTFwL3Jibk1aTEhqM1U4YzhkSzdFQUJqc0IxeTlHdlNJTFFz?=
 =?utf-8?B?a0Z2ajFYTTRsNWlybmF2bmpJUHYwbTBwZU01NXI4L1E0Q2NsaStBeTVLdXBF?=
 =?utf-8?B?UFdRa1ArbTZWc3pqLzFONE8waWM5aGU0aUpyc1orVEc2WGQrZktjQnhFZVQy?=
 =?utf-8?B?MHB2SW1pUzZjS0pDN0xQaE5lRmFQOXEzZ2RkbGJYLzNtcWpuMUhnUWIxaWZz?=
 =?utf-8?B?bFI0NjhrZnNESHBoS3EyK3ZXb0pSY0x2ZjdlMC94ZlREQnVMN1E1UG83T0Ns?=
 =?utf-8?B?SWFqVTFHeGlNNVhSbDFNVm9BR2RUSkJwVVJqaDQrSFlyTW1EOHJBcElxODJp?=
 =?utf-8?B?S05nbTZEejBmeC96S2ZFR0U0SGgxV001SHM5QVFsaHVYKzVHZmd5TFpUY0Fw?=
 =?utf-8?B?V3ZGeW1sRFY2VWFyV1FWUlNiWk81R0tDaU9SKyt6anM5amdTM05VTk0xR1JW?=
 =?utf-8?B?WjkydVlVdktUU0VrWWRKdkZqd3pNWGcvcmQvSlhYazViSGdlNCtTdmpWS3B5?=
 =?utf-8?B?dEpUMkhNUGJ0dVI0Y1NNcmN3YTM5RnY3dERScDJpSndaUlErQWFHcmpDUVpp?=
 =?utf-8?B?N1RhakdGaVRrS1ZmdkRLdngxc0VYQ0JFUGo0bEZndUZINDVPbzBLbU9IUUhD?=
 =?utf-8?B?NEEvRWNYMmNlNXVPaUdGeVZNT2J3bjdVTFQrOUpqclplazlpWnZRMkFpZ3Ev?=
 =?utf-8?B?TzhDb2kwRG9MUVlRRElCelduakUvdkd3ZGJSelQ2ZWpRemdNYjM4dmdoNTY3?=
 =?utf-8?B?OTh6ZTNrakFvYjBLNjluaEdzMzVzSWR2dGJKZXVIUGhpdnVhVUQwWE85TlM0?=
 =?utf-8?B?ZlFLRWpGNFlRbTZWYUM3dVdDYjlkUWN3aU5CWW9YOW0yWExNUjVQdDVCcUFY?=
 =?utf-8?B?WDlFR1Q0YWFIT3hRdG0vUjBDL0R0RjN5NVBwY3Fmd0p0T3JUR05NblA3blJ2?=
 =?utf-8?B?dUJHNVJVdW5IR04rVTJpL0lFQXRGNzlMUlNRa3hYek13dmxUcW4zTlpsSXJa?=
 =?utf-8?B?TVJMWVFFOE9QT1JHY1NOUWNrRTVxMDZTa2pSNGREMGhyVmZGSktmK0NmZU9s?=
 =?utf-8?B?UTF4ZEJFeEpnRTlmZ0xRKzVMTG5Va0RaT09JdXY5b1BBam5BYk1pNUw2NEVW?=
 =?utf-8?B?WFFxUUtKUTVya0dsUXdHb1pxWXNWcGo5OXlmQkgyc2p6VFpXOCtkb1NZbXZX?=
 =?utf-8?B?NVhaRDlWTmJsdEU4MWJBTHN3WHhVV0x0NFhmdVhVY2g5eUZEa2oyc3JNUGdr?=
 =?utf-8?B?d21UUVZqNHpLTHJDRzVobFY0bStDVXBQa05YZmJiMVY3b1FBdFFFMzYrWVJP?=
 =?utf-8?B?YnZzRFIyVW1VT3lmYkF5U2JtM2FrZllvVVVuUExXdC9rMU42OEVRYWE0UkVa?=
 =?utf-8?B?ZGVmOVE0T3QvVkZkU29kRW5CcGtZSGZ3UGluaDNJYmd1K3FuRVh3SnRFRW05?=
 =?utf-8?B?VUloL0F5OTRWQnRneG1aMXJXQW9SMkVZL1h4YlVKVm9hdFN2RS93Smt2UVdZ?=
 =?utf-8?B?TFQ2dlJjYURqU1p6VU92YlBsZ0RtWDM5QzlZVTlONEIwU09NeUhtZ0MxbWdn?=
 =?utf-8?B?Yk1yZWZhTnBDUlVlYlh2M29hSnNxMGRmejhPVmsyeE1RcCsrYUZsWDhwaUxs?=
 =?utf-8?B?VUdiZm5CSCtBMC9IcWdjamdGMWttZUl4ZmNBZzhKK2Y5ZCtlTDdaM281RUg0?=
 =?utf-8?B?NEtiTWIxc01YczBOajhja2VmR2JMMUJmSTF6QnQvRTJrckJTU3JiWUdJZ0k5?=
 =?utf-8?B?K0h5c3VpRnBJZm9qNWhNV2cwWmVzb0J6SDk5TEEycEtuQjl6RlVHSTV1aUg3?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <691BF44832E8E54FA83B145368BC80BE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hm/UA01PumwlbJlR81XZs1cUUyK1I4eP87a27zll7qWgLUaXSCJv5CAdtu2vsO4S9oUXfs3GDGQOBIWWqLJbeCMHu86HAvHeNVfIeMCsCxnRRXooNO3zV5IxTjik92NRg2FlwwdB5FB0nvHeiYOT1MJL+ri1EPQSF0zJ9y2kZKwgfwmZ5fgH1FDKaOl7S4ENBe8kyCuHrlUVVUPy1+aabX4tEDDBPiN8MZHl2/RvuepSWOzQ04jr749z4Xg1e0GY6tqBYzi22R5LrDKiR0/VTBBZjtfYcZVaUqmkgLbKCCG+Av7DWbdzFX942imwBX9TamxbxNSw2IsOrzy+NJPMub8M+DnSVrgkX8rX/kVdwh5KItAezRNI2w1VtImKKrfBHXSEdCKlavzraQMUrfgzxyNi4+UYau85qgAA5ZyMpfgkgZpQPAylnRDYr2vK6O1GxZkAl5rCA8QQx6fgXd/OMGe+WBgOVyIfnEBYLQ6aEWz0i7Wps8C4KSIB0jIl+FdaXodzUkT9xSLJMMsaie+okanCaoRqL/k6jwtRzz/+p1CHDIqmvFJ/AmZ64R67uy4wx9FgjwmrCoqDWiX2DYUWHAwYpWUCLrSLEkzBTlkN+50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c53b4c-4ade-4d57-b359-08de31785656
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 07:56:44.7324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1OxwETntqsvfTawRl8uAsjdPOs9m2aqiWjO3QfqnV5cIiMF6c2+oHRS7FZAC+Tg2eDXHCS/2QslTBsBh64WNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512020062
X-Authority-Analysis: v=2.4 cv=QMplhwLL c=1 sm=1 tr=0 ts=692e9bbf b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=_WDZCbMO_pg23zlK38IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1N3-U4Mnw_YFU4HpkrzV42OFvOBlj1gu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDA2MiBTYWx0ZWRfX3qk0zIrzREML
 Amt0CACas7RQqhoO0d/E6RYO5UK4stUGWdirg11WYXBnIdBq/L93hKc4IkJ3YLFP6tr/UuChEi9
 3eyQGO0nxuR6rTMt8L9qDFMK6CNK/aiIR5sFTcf/p6j+vLFbonsovsbYjwoq6rLMwneUKh1iVOM
 YNB/HGEZJnQxWTGpnPekbv6K0R1z88vizn7Cf+vkkHKdu0xpEvBxUJdCFOxWZbUwWMTywKDJUOC
 YQ+x6GiO2otaxQfPZw5GEu76D+5Y7Zn4pSXQlml0ZGf75Ax09jfe5sRZjlvPtNy2YcvYrHSGZ4l
 cnv8gMOXFLhKHxMzB7ZHcIphjPTRVEkRWnOrq86743bRZUpP0NN6aKTf45zoLhfA3TxRrEdF+Nz
 hT6UaU6GcvwcPNCPM2iP8qLjHlsW+Q==
X-Proofpoint-GUID: 1N3-U4Mnw_YFU4HpkrzV42OFvOBlj1gu

DQoNCj4gT24gMTIgTm92IDIwMjUsIGF0IDEwOjU0LCBIw6Vrb24gQnVnZ2UgPEhhYWtvbi5CdWdn
ZUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IFRoZSBiaXQgZm9yIGVuYWJsaW5nIGV4dGVuZGVk
IHRhZ3MgaXMgUmVzZXJ2ZWQgYW5kIFByZXNlcnZlZCAoUnN2ZFApDQo+IGZvciBWRnMsIGFjY29y
ZGluZyB0byBQQ0llIHI3LjAgc2VjdGlvbiA3LjUuMy40IHRhYmxlIDcuMjEuICBIZW5jZSwNCj4g
YmFpbCBvdXQgZWFybHkgZnJvbSBwY2lfY29uZmlndXJlX2V4dGVuZGVkX3RhZ3MoKSBpZiB0aGUg
ZGV2aWNlIGlzIGENCj4gVkYuDQo+IA0KPiBPdGhlcndpc2UsIHdlIG1heSBzZWUgaW5jb3JyZWN0
IGxvZyBtZXNzYWdlcyBzdWNoIGFzOg0KPiANCj4gICBrZXJuZWw6IHBjaSAwMDAwOmFmOjAwLjI6
IGVuYWJsaW5nIEV4dGVuZGVkIFRhZ3MNCj4gDQo+IChhZjowMC4yIGlzIGEgVkYpDQo+IA0KPiBG
aXhlczogNjBkYjNhNGQ4Y2M5ICgiUENJOiBFbmFibGUgUENJZSBFeHRlbmRlZCBUYWdzIGlmIHN1
cHBvcnRlZCIpDQo+IFNpZ25lZC1vZmYtYnk6IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9y
YWNsZS5jb20+DQoNCkEgZ2VudGxlIHBpbmcgb24gdGhpcyBvbmUuDQoNCg0KVGh4cywgSMOla29u
DQoNCj4gDQo+IC0tLQ0KPiANCj4gdjEgLT4gdjI6IEFkZGVkIHJlZiB0byBQQ0llIHNwZWMNCj4g
LS0tDQo+IGRyaXZlcnMvcGNpL3Byb2JlLmMgfCAzICsrLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvcHJvYmUuYyBiL2RyaXZlcnMvcGNpL3Byb2JlLmMNCj4gaW5kZXggMGNlOThlMThiNWE4Ny4u
MDE0MDE3ZTE1YmNjOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvcHJvYmUuYw0KPiArKysg
Yi9kcml2ZXJzL3BjaS9wcm9iZS5jDQo+IEBAIC0yMjQ0LDcgKzIyNDQsOCBAQCBpbnQgcGNpX2Nv
bmZpZ3VyZV9leHRlbmRlZF90YWdzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHZvaWQgKmlnbikNCj4g
dTE2IGN0bDsNCj4gaW50IHJldDsNCj4gDQo+IC0gaWYgKCFwY2lfaXNfcGNpZShkZXYpKQ0KPiAr
IC8qIFBDSV9FWFBfREVWQ1RMX0VYVF9UQUcgaXMgUnN2ZFAgaW4gVkZzICovDQo+ICsgaWYgKCFw
Y2lfaXNfcGNpZShkZXYpIHx8IGRldi0+aXNfdmlydGZuKQ0KPiByZXR1cm4gMDsNCj4gDQo+IHJl
dCA9IHBjaWVfY2FwYWJpbGl0eV9yZWFkX2R3b3JkKGRldiwgUENJX0VYUF9ERVZDQVAsICZjYXAp
Ow0KPiAtLSANCj4gMi40My41DQo+IA0KDQo=

