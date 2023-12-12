Return-Path: <linux-pci+bounces-778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A660F80DFEE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 01:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6748CB2131A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 00:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926B818D;
	Tue, 12 Dec 2023 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FHvx7G4f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wXHdM7Ew"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF09E1A1;
	Mon, 11 Dec 2023 16:14:42 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBM4DiA027060;
	Tue, 12 Dec 2023 00:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=g2DaSet4I+humXV1l9xnx6QIs8Hk/F7dGk8S/ZOcTpk=;
 b=FHvx7G4fci7gI17ofAobLWqRGif0o4tcaYPqvT/72WqBKn7pPSeu37U3cVUPADoLXaFJ
 dmg+FhpCZlAfh0La9cdwq6CySyD162XWZC3b/9LnW44KpaprkXdLMi2O+jgN0uPW0qXS
 /hXORapLWzWnPeKHDxhPxDvE7hiW+S6m86kR2ruDa9Z0YiAPsYEkFK4ubh5tnNhXc0z0
 sptHBiGRjXlKgioXmMwYfh3B0vC+AD2wl42Hkya9pZZfH2IUeyOCLm8YrrbNDqb1qaQt
 fQCHyNNYshHijddieN+ccCOUhFfDMFwbHFOWFhzh0CZiPpmA2szb+H7uvk6XnKlYNwAw Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5c4c6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 00:14:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC04ovi009808;
	Tue, 12 Dec 2023 00:14:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep5s39m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 00:14:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPCRegZqsSYtw/o3Vj7EKCytQpL6p3MQRsyCoh3qvJzEcdna7ZnfSRb/Y1XGCAFWN0b25qY1YH7LFzjZxkdU0DLBYUXnYrbz5X/fcRXlAzMniov/4mp3KKbGb/Yur79Srjk/lAkIiU6fy76+7gzADK6n7TL+joRrhqhUUzvE3MXtMygK86dE2k8RNmV3yQmzXYoEDy7d45jZ93fxNthgmFi6pYmvshjVNUTmw+if1Y0jmi6zut0dUzopQnfAOKOZ90AYu1Sl0z+aI56wn+kouXrQKT3OF1XHGrwVzmxdcboXGxo1bqSjBUmMhLGOzaHVlw7vLiBVMs0WZpsZmswiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2DaSet4I+humXV1l9xnx6QIs8Hk/F7dGk8S/ZOcTpk=;
 b=LWOYS0pCTwQ3wzjzVA6JeOh7vt4ow6R005lcF33IbNrWjChPMl1RqZ53AbRUqaq2gx8FlKEAY1z9ncJT9JSnVRVXqFfy+mJwyAQ8htq+BcsH1Th19G+Gvzof0QiwjpjNaFOKO/EL3c4h3Bh6/GvIh7sZcGU3/XzTPve5Gdsp1ShIZl2wDtHjm4GtIzhGcJ7j8Yq16vg1JAiSE3odIQdqOyCTpSLOvTZ414Ea26PIyoEuNCZX0AOdbjdRk01D9iCwoNJIU+2P+pddRfoiR9y2QrR1Nf1ISH7Pp4MJgNMJxn0wFa77ZUJhZv5FjO6Np76Oy4ka4qFaignGFUPTrKHOWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2DaSet4I+humXV1l9xnx6QIs8Hk/F7dGk8S/ZOcTpk=;
 b=wXHdM7EwmZFRR0Bx08kU/ykuNLVZ4GQu7YTeTZPcoMslfrZnensPLHw1NBv260bHP6k0hgkXMfpOTas5uqEL8ARSrODwPl8/YdINNGJ/4bH0Y+r5v3WjFA9gPJJTBhE1M//IzFbHCpPY6hWfdxL0MZLXMnZEaSk87KxXXfUI63Q=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 00:14:31 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777%4]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 00:14:31 +0000
Message-ID: <3c4a446a-b167-11b8-f36f-d3c1b49b42e9@oracle.com>
Date: Mon, 11 Dec 2023 16:14:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc: imammedo@redhat.com, mst@redhat.com, rafael@kernel.org, lenb@kernel.org,
        bhelgaas@google.com, helgaas@kernel.org,
        mika.westerberg@linux.intel.com, boris.ostrovsky@oracle.com,
        joe.jin@oracle.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Dongli Zhang <dongli.zhang@oracle.com>
Subject: [Regression report] commit 40613da52b13 ("PCI: acpiphp: Reassign
 resources on bridge if necessary")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0086.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::19) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|BY5PR10MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 88998ed9-125e-4526-1689-08dbfaa75017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	k7HJfGDJ7KwIdUdL2mJ4fICUsp/h6YETHaF7iwSRHi4XyKn5/MsVIanJDMu4Qyy6c94XyuhqlHp+Hndg9Ul+8ygMGZNpBlBF5r692fSXVuGBSL2EoNhzyvZOy/SoEpdFHf5ZXsYLaUqSyVavTvB24BN1pi20n0f+eM9eoM8dY+pKqKjrai1gKsHUjHe6JZ22/DE1wKBxj2rGZ4hnTWfDean6gUbh5xaO5IUeqHDOMVqjJp8slOrfss6nybjLWHjNyJBuV+RAxm0DxA11EFxlE/keOqQTUC6RfiktGuVH+KavdWw3jpN1S4pYcmONOYIwf8AhrzZuHlRb7hq60NW2NLNrfleSZcGdCfvw1OFV3JDtSUnlPcAQnR0wAmCkwKyDPTUfzq5f8GPLT50M9AyQExgc5eea4gGZJa1LgrLvexOM0QeXuMaUm5garqYf5UyAyEyiikf93AI27/5eRYma2nZ+rdNl2RajV2LtfonY6Yzq4nwjsaOpR5TRSPJ9Tj77fOTy1XQ8RwpfWloX1yWtye6wnslt64IOeFmSoE5Phi9PsN3en270846BPCKQmD2003Kh8aQKWEs3wGBpV+/Pigd5EWgNomP6rPsoU1BS+DmJcIA2hXB+VfOf6Rj2fDRncF+A3qLRXnTCOoVaRo6nnQoAAKE1WGBrF5zYxQKpNr9xBXIEKjmCfAT2RZrGPtM9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(26005)(2616005)(66556008)(36756003)(38100700002)(31696002)(86362001)(7416002)(44832011)(5660300002)(6512007)(6666004)(83380400001)(8936002)(8676002)(66946007)(6486002)(966005)(66476007)(316002)(2906002)(4326008)(478600001)(41300700001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QVY1dlJiUmxhRXNydU95SlNlT1NLOHlIN0oyRzVVeVJiNk5VczAyMVZvd2FU?=
 =?utf-8?B?K0UwMFdGRzFxRUpidi9iN0t5dHdUcVZIeTlpd2VBRTBlTFk3ZW4xVmlHTUVz?=
 =?utf-8?B?OUV1a3ZZUmNPZkU5VkZxamFQdy8rVWwwemFwKzJZUGxSRmFiTjkwclI5THg1?=
 =?utf-8?B?cTZoQklZRUs1MDViT0JnMWJEN1RGSjRQL2xiN0pVWU9IUEJYdFRpbWFBZVlM?=
 =?utf-8?B?djF6YnVvaG1TM3ZXc0cwbDlWa1dNcFlqaGU4TnZrUENMaWR2eWtLT3lwVS9F?=
 =?utf-8?B?bzlMOE1idEFMWFFTa09RTTJGTlUrSGIwQ3JNRzN0VlNLcm5CdGdHWlc2RWJm?=
 =?utf-8?B?d01iLzEyS2gvTStLQzJvZ3p3bmczazBBbVJOaUtlbTQ3bGVkbG5mUWYxaTFw?=
 =?utf-8?B?Z3BMOTdLcjFzYWdrS3hKenpxVDVsbjNpMzRuRVF4eHN2Y2hmNXUyTXBPdkZ5?=
 =?utf-8?B?T1ZMaDFIOFZ5RjRZODhQaVNZS0JLYndtT2FvQXExOE5JZnJ5VnBIRytORzQz?=
 =?utf-8?B?amJ2N00zRk9sd1hQbG9wU1pmQUlHbUNzb0FPY3cvR3FvY1pyRFQwQnMyaVEz?=
 =?utf-8?B?c0ltNEtjd0ppb2owTmY1WlZBNi9VYm5xZzF5SmsxWHU0NGo4OUdpOWhXdHBC?=
 =?utf-8?B?NnZoYmw4ZVJHckg3cDZGTzJ4TitNS3N4c3hFZDZWbDkvdEpPZWUrVXV3Tk5r?=
 =?utf-8?B?OWZlZlpHc2FCVXl3dVE4a3BRallSUnZjV1lDZXYrOUpNT0tEUmxvc0Vzc1VX?=
 =?utf-8?B?S2crMEVySVZjSE9DYzBwemNCRURnbERmTzdKckpsVkR2SjU0U3hoMENIZFdk?=
 =?utf-8?B?a2xlU01SdEs5K0duTE9YSlpPZzU0cWsvZkxUSm9mcjMrNTRXa1JFNzR5T01U?=
 =?utf-8?B?L04vL3F2N3dSRUUyZ0FiN051TFpFZVV0amphU0NLZHhieHNqckVtT0J6aDJl?=
 =?utf-8?B?M2pHWnJXb3NwTFBWSVRtbEJaWjByUE5kRVBlZTlBNmhvTFU3OXYvVmRxdERH?=
 =?utf-8?B?WmVnc2NTbGFlRnBCTUZDK0U1RmZPdjdEOHYrb295V0FnSnczV0NLaDZVeTBD?=
 =?utf-8?B?NUdDTSttdXJBbGJqaDhTTmRHUm9GRjkvT3U0SU9mZTJQL3JpSXBUeUpkVlkx?=
 =?utf-8?B?WnFMR2lJZVp5eE5lYkh3OUdnZ24zWXFTRzR6OHQ2L09SZEZNQTJKaWpwTG9s?=
 =?utf-8?B?QjIya01WalIvQ1c1T2dpazVpVVN6Qk5IYTZ5ZjN2bFdlSGdrZHFQUDhoaldK?=
 =?utf-8?B?SWxjbnhPZU1Vb01qV08vckV4akorWG1uNTJ3N3VtSEpBOHZmL0Q3LzZSaWs0?=
 =?utf-8?B?ejlXZjBIRWNnY3E5UGdRSW0zMXlWTnZLWTBRUnVkdTJsTUJHMFQzT2dWb3RJ?=
 =?utf-8?B?WHRpbytndzN6S1BGcG9OT2EreHpvd2VIc0Z0YXpQdGNENmhqTVhJU0pTTnNL?=
 =?utf-8?B?cjFkV3NqZS93aXZDMncvZmdjVFlYRjloU1V6aUt5OTRoOUlSWmgzdGhHNGxM?=
 =?utf-8?B?KzF6MGp6OTJpTG9JUlhqRTUvNnZhWDNsUk82R3BpUU1ELzBCTFYybmNGYnlK?=
 =?utf-8?B?U3BDNjg2RVpKWm8rWTdBNFZRd0tkWi9SNERmZ1NuSFQxUkRvQ0R3VUlaeWpk?=
 =?utf-8?B?NVR5MkorZ3ZIVEh5c2dYeW94Q20zK016QW1VNVc2TmQ5VUJZbjc2bnVvVlRZ?=
 =?utf-8?B?YllhWXR4RzlKaVNxbFVRMzJjTXJTY0hRVCs3SjVQWUpHdHdYZEFhb3FicVps?=
 =?utf-8?B?OHFoRW9MT2VOM0hmZFdqSlNhLzk1T2I1bFRpdjZCSVdYM0JaOGJ6TnUzNWhJ?=
 =?utf-8?B?bk9na3g0enVZUlZ6TnMydU5FZWtuMVczMmtDWlQ4KzZCdFlSbWlJNVovUjRL?=
 =?utf-8?B?b0N5T0hKckNpcmxCWEZERHlzNG5ZNkQ3OWtjb1phZ1NaL2hrYnpTbWI2T0lk?=
 =?utf-8?B?TTI3eGhoU2h1QXFOQkxTMFlFZTJEWU0yQXlBZVRxcjAvalR1QkY5a3J1RTdw?=
 =?utf-8?B?ZlQ4dG5mWms2YVZMQ3YyRSs0ZURnZGZ2SW0wVEExejJBU1BCVi9xTjRIOTQ3?=
 =?utf-8?B?emN1cjdHdWpPaE50V1FIU1pHbUNIOWJ5Qmd3WjEvdGJKcnV5RUxxVE1nY05n?=
 =?utf-8?Q?JdAuFgSiXFffe1rBUTp8gan0y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	v9AZdrB6adtuBPcz7sAQmA9dThALS8nqnrfnFeg1tPOq51EMFaY8aoqSKr9sxeRVBWOlejS8FNgBfX135VatOo6jaoEvI0SgZWdNtBlRy+wi/nYqZLaBoG5A6nQggdQjS+6v9XSTUfc3I7l/xvOA++XjEDfZN9VNQcOrAM3+det8/XoJaO6lPLugsULHzAvI14nIsEJtwOg2fIrucB5YdcJGADhysZmJHFY/Ojpnb+XvZh82eG9dj4kLK1auAfMHNVUwNJULMOBAbZPf1x5aFp8XkwWQsui66guptvIae7C9yZv+6QAk63A2XzFxxLxmm90dW9s0Z5/BKuPAGvgspughPscD0Ht8IdqfHZtVN+uBYpxQUNUCsa9gkhSItOTT7kv5sl+h9bZBbai32deQJ4Ar5wq1BeC9yo1/HDRh3RVm/6mPWez+qyP5ROCmzZLpKy7vHhXOtK1wBuXkLOZiKZIff1XDKrSS5QbHb3fXyeHlVdxzXCUMLPJubAg7Gg+Sx9z4v6E6hBIwgOK2DjSwE0TkbP0dnKOsqqJXnRQJb65J28eQGXKN85xthvcLRli0sDkMUGo8MA5NlkUhN/jPxPkoLWVla5qB2GdFIKyAQMV0vuMuD83tS9DG6va+X/cj5eqnc0dAA3ohEHDOn/biHjmwFaWuT7x3TDEqfNZpxJGv8EGYE8YGAiAFmzD+77mCqVhaWAZYIi+0uwy3J5Wnyo3ID3VF6r1iM1/PbWCKWtzTZA6tFds/E4H9WdEhmnUeS3PdkBrxvJafRFvrr7hu+Awq/5C8LqiG+VcFVu5FIvQnhMlvpcbQKf7HCujkREy4wqt2MaSIm+adpVmRq9OAzXNijM+FgL3DqA42abQnzeu7O45Ci8J+UrNtPArMXwzhxtrSbPNsPcySY518qdA78Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88998ed9-125e-4526-1689-08dbfaa75017
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 00:14:31.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X73aOZkYIwrm4xv/saZ5gl/Z+KH4L3YrpwcEyVp201R46z3TC2ycuF4Pq+EVAqb78qU/zy+ZfNzuubQUjm2/Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_11,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120000
X-Proofpoint-ORIG-GUID: pG9cy-ubERAAB0IqjN43UB58Y7RnA561
X-Proofpoint-GUID: pG9cy-ubERAAB0IqjN43UB58Y7RnA561

Hi,

This is to report a regression caused by commit 40613da52b13 ("PCI: acpiphp:
Reassign resources on bridge if necessary").

PCI: acpiphp: Reassign resources on bridge if necessary
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=40613da52b13fb21c5566f10b287e0ca8c12c4e9


That patch may reconfigure the mmio resource of the bridge so that to write to
mmio during PCI hotplug may lose effect.

Here is how to reproduce the issue.

1. Create QEMU (v8.1.0) VM with the below.

qemu-system-x86_64 -machine pc,accel=kvm \
-smp 8 -m 8G -cpu host -hda uefi-os.qcow2 \
-drive if=pflash,format=raw,unit=0,file=OVMF_CODE.fd,readonly \
-drive if=pflash,format=raw,unit=1,file=OVMF_VARS.fd \
-kernel mainline-linux/arch/x86_64/boot/bzImage \
-append "root=/dev/sda2 init=/sbin/init text console=ttyS0 loglevel=7" \
-serial none -display none -vnc :9 -monitor stdio \
-net nic -net user,hostfwd=tcp::5027-:22 \
-device pci-bridge,id=bridge1,bus=pci.0,chassis_nr=2

We should have CONFIG_SCSI_SCAN_ASYNC=y so that scsi probing happens in another
thread.

2. Hot-add two vhost-scsi PCI devices consecutively.

(qemu) device_add vhost-scsi-pci,wwpn=naa.5001405324af0985,id=vhost01,bus=bridge1,addr=8
(qemu) device_add vhost-scsi-pci,wwpn=naa.5001405324af0986,id=vhost02,bus=bridge1,addr=0

3. The 1st hot-add succeeds.

[   44.365111] ACPI: \_SB_.PCI0.S20_.S40_: Device check in hotplug_event()
[   44.365261] pci 0000:01:08.0: [1af4:1004] type 00 class 0x010000
[   44.365377] pci 0000:01:08.0: reg 0x10: [io  0x0000-0x003f]
[   44.365425] pci 0000:01:08.0: reg 0x14: [mem 0x00000000-0x00000fff]
[   44.365589] pci 0000:01:08.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
[   44.366479] pci 0000:01:08.0: EDR: Notify handler installed
[   44.367255] pci 0000:01:08.0: vgaarb: pci_notify
[   44.367490] pci 0000:00:04.0: BAR 15: assigned [mem 0x800100000-0x8001fffff 64bit pref]
[   44.367497] pci 0000:01:08.0: BAR 4: assigned [mem 0x800100000-0x800103fff 64bit pref]
[   44.367579] pci 0000:01:08.0: BAR 1: assigned [mem 0xc1000000-0xc1000fff]
[   44.367605] pci 0000:01:08.0: BAR 0: assigned [io  0xc000-0xc03f]
[   44.367638] pci 0000:00:04.0: PCI bridge to [bus 01]
[   44.367653] pci 0000:00:04.0:   bridge window [io  0xc000-0xcfff]
[   44.369258] pci 0000:00:04.0:   bridge window [mem 0xc1000000-0xc11fffff]
[   44.370134] pci 0000:00:04.0:   bridge window [mem 0x800100000-0x8001fffff 64bit pref]
[   44.372147] virtio-pci 0000:01:08.0: vgaarb: pci_notify
[   44.372155] virtio-pci 0000:01:08.0: runtime IRQ mapping not provided by arch
[   44.409717] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[   44.409781] virtio-pci 0000:01:08.0: enabling device (0000 -> 0003)
[   44.448742] virtio-pci 0000:01:08.0: enabling bus mastering
[   44.452982] scsi host2: Virtio SCSI HBA
[   44.470553] virtio-pci 0000:01:08.0: vgaarb: pci_notify
[   44.471124] scsi 2:0:1:0: Direct-Access     LIO-ORG  lun1             4.0  PQ: 0 ANSI: 5
[   44.490102] sd 2:0:1:0: Attached scsi generic sg2 type 0
[   44.490240] sd 2:0:1:0: [sdb] 262144 512-byte logical blocks: (134 MB/128 MiB)
[   44.490275] sd 2:0:1:0: [sdb] Write Protect is off
[   44.490279] sd 2:0:1:0: [sdb] Mode Sense: 43 00 10 08
[   44.490333] sd 2:0:1:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   44.501807] sd 2:0:1:0: [sdb] Preferred minimum I/O size 512 bytes
[   44.501812] sd 2:0:1:0: [sdb] Optimal transfer size 8388608 bytes
[   44.504009] sd 2:0:1:0: [sdb] Attached SCSI disk

4. The 2nd hot-add fails. We do not see scsi probing finished.

[   52.285341] ACPI: \_SB_.PCI0.S20_.S00_: Device check in hotplug_event()
[   52.285488] pci 0000:01:00.0: [1af4:1004] type 00 class 0x010000
[   52.285620] pci 0000:01:00.0: reg 0x10: [io  0x0000-0x003f]
[   52.285668] pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x00000fff]
[   52.285833] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
[   52.286687] pci 0000:01:00.0: EDR: Notify handler installed
[   52.287484] pci 0000:01:00.0: vgaarb: pci_notify
[   52.287568] pci 0000:01:00.0: BAR 4: assigned [mem 0x800104000-0x800107fff 64bit pref]
[   52.287650] pci 0000:01:00.0: BAR 1: assigned [mem 0xc1001000-0xc1001fff]
[   52.287676] pci 0000:01:00.0: BAR 0: assigned [io  0xc040-0xc07f]
[   52.287701] pci 0000:00:04.0: PCI bridge to [bus 01]
[   52.287715] pci 0000:00:04.0:   bridge window [io  0xc000-0xcfff]
[   52.289611] pci 0000:00:04.0:   bridge window [mem 0xc1000000-0xc11fffff]
[   52.291062] pci 0000:00:04.0:   bridge window [mem 0x800100000-0x8001fffff 64bit pref]
[   52.294057] virtio-pci 0000:01:00.0: vgaarb: pci_notify
[   52.294065] virtio-pci 0000:01:00.0: runtime IRQ mapping not provided by arch
[   52.294083] virtio-pci 0000:01:00.0: enabling device (0000 -> 0003)
[   52.335305] virtio-pci 0000:01:00.0: enabling bus mastering
[   52.339810] scsi host3: Virtio SCSI HBA
[   52.358165] virtio-pci 0000:01:00.0: vgaarb: pci_notify
[   52.358380] pci 0000:00:04.0: PCI bridge to [bus 01]
[   52.358398] pci 0000:00:04.0:   bridge window [io  0xc000-0xcfff]
[   52.358518] scsi 3:0:1:0: Direct-Access     LIO-ORG  lun2             4.0  PQ: 0 ANSI: 5
[   52.360287] pci 0000:00:04.0:   bridge window [mem 0xc1000000-0xc11fffff]
[   52.362313] pci 0000:00:04.0:   bridge window [mem 0x800100000-0x8001fffff 64bit pref]

It is because of the following. To reconfigure the mmio resource of bridge and
to probe scsi happens at the same time, in different threads.

[   52.358398] pci 0000:00:04.0:   bridge window [io  0xc000-0xcfff]
[   52.358518] scsi 3:0:1:0: Direct-Access     LIO-ORG  lun2             4.0  PQ: 0 ANSI: 5
[   52.360287] pci 0000:00:04.0:   bridge window [mem 0xc1000000-0xc11fffff]
[   52.362313] pci 0000:00:04.0:   bridge window [mem 0x800100000-0x8001fffff 64bit pref]

The race starts since line 638.

627 static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
628 {
629         struct resource *res;
630         struct pci_bus_region region;
631         u32 l, bu, lu;
632
633         /*
634          * Clear out the upper 32 bits of PREF limit.  If
635          * PCI_PREF_BASE_UPPER32 was non-zero, this temporarily disables
636          * PREF range, which is ok.
637          */
638         pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
639
640         /* Set up PREF base/limit */
641         bu = lu = 0;
642         res = &bridge->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
643         pcibios_resource_to_bus(bridge->bus, &region, res);
644         if (res->flags & IORESOURCE_PREFETCH) {
645                 l = (region.start >> 16) & 0xfff0;
646                 l |= region.end & 0xfff00000;
647                 if (res->flags & IORESOURCE_MEM_64) {
648                         bu = upper_32_bits(region.start);
649                         lu = upper_32_bits(region.end);
650                 }
651                 pci_info(bridge, "  bridge window %pR\n", res);
652         } else {
653                 l = 0x0000fff0;
654         }
655         pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);
656
657         /* Set the upper 32 bits of PREF base & limit */
658         pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, bu);
659         pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, lu);
660 }


To probe the vhost-scsi and to reconfigure bridge window happen in different
threads. There is a race between them so that to write to mmio may not work. It
is called ioeventfd from KVM/QEMU's perspective.

[0] pci_setup_bridge_mmio_pref
[0] pci_setup_bridge
[0] pci_assign_unassigned_bridge_resources
[0] enable_slot
[0] acpiphp_check_bridge
[0] acpiphp_hotplug_notify
[0] acpi_device_hotplug
[0] acpi_hotplug_work_fn
[0] process_one_work
[0] worker_thread
[0] kthread
[0] ret_from_fork
[0] ret_from_fork_asm

[0] blk_execute_rq
[0] scsi_execute_cmd
[0] scsi_probe_lun
[0] scsi_probe_and_add_lun
[0] __scsi_scan_target
[0] scsi_scan_channel
[0] scsi_scan_host_selected
[0] do_scsi_scan_host
[0] do_scan_async
[0] async_run_entry_fn
[0] process_one_work
[0] worker_thread
[0] kthread
[0] ret_from_fork


Indeed, I am curious if this impacts other PCI devices on this PCI bridge,
doing mmio (e.g., to kick the doorbell register during that time).

There used to be similar issue. According to prior commits, we may need to
touch the bridge window for only once.

PCI: Probe bridge window attributes once at enumeration-time
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=51c48b310183ab6ba5419edfc6a8de889cc04521


Thank you very much!

Dongli Zhang

