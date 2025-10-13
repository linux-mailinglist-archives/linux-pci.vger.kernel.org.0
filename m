Return-Path: <linux-pci+bounces-37937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A288BD5AB4
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 20:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA2D420AFD
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8562B2D24AB;
	Mon, 13 Oct 2025 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="MC17PZVE";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="fAJtDrU0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0C1E3DED;
	Mon, 13 Oct 2025 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379371; cv=fail; b=oQOGs5PZMiL7knBPx95HKxaEFRa8aDgA4QOrL/+sEvrIG5Wv36dZZeiPQVXHdGbm9xYbYP2633WOShCxak/zDsaG4dMSmwTlswXz47mF+uKFI5iN9FbFYjJATrAh4R70lDGc0FLZNDlFH+3Yo7HOq8vrfZYJ+gz0ICr/aUIuNKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379371; c=relaxed/simple;
	bh=nwZiSYkIXP3fnmZHie/adJA8HCMTFsJeNSP8ic44dec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nAHk2UQ/7m3IKnyETO0HGQVPMUgaAIUNin9ibFtJoKzNWkS8U2GrBjDw5w5yf4dzgW3ElxbzIVoXKuXct9RA5LThKvAJdbRiIb59rITauLakhV+clwXO+/1t1vzD2BvimLuLLV0qnbK+7lpOaW4hd/OfYjrVc1lNv8SkCndpJjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=MC17PZVE; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=fAJtDrU0; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59DGTotL2277497;
	Mon, 13 Oct 2025 11:16:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=rcG24v42ve7cOqHg2ZlQwJpBYbjtvtVkcFj250EsO
	3Q=; b=MC17PZVEkZC2pK8Mwotk6p3BIIsbN2oGUl5YWDacvkUXtQ0D/64lMpJ9j
	aeUNbMqpF4dxpaj6MD83mGLoEzONqZVLo5yi0M+uhx6Y9JXIlbT4AMuwYVQu9uH5
	LtcVfGAqrBBEHdU82idQT9CQfOPP0ROuHIhgaC2l1KJdw6bz6T9lpJavB42CJ35i
	O9d1ZjV/8dHXKNW0DV8uJdpemQfjdzt16bIqMyH0jneBj6BRY1HwJ9qBb3FIMdyh
	TzscRSbnaCv8CHtqvtnpxeU608yMWixDV+R62WN2PbCeNlIO0WJY3hURsRzChJvp
	c0ZWqK9P0ThBgkKkZCZ5uKb58VkDw==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020125.outbound.protection.outlook.com [52.101.61.125])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49s4y8g88w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 11:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKWH4YErk11jIzVw9/wZ27ibJFVjXBg4qiSbwaCtydIJewYd3fwQoI5+RvHimrqhUPSXMjmd3b8TczPL/atmzlkxxH+Kews5ZwvlmGFB58x7Q7g0TaWZRDSplJXoHfE+VW3PpTGhDIVE9wpiFtyspMcCB+kbozvwK03zSylNIFXtYgik3vRBRTtjsqKDRUxooakHdc1SXkEP7Y0nev8W0ITHFU5DrPdrhOFYTh5qq8hlun4M6lsXQDrZMw0XXVVDGs9fYWfJFgN5Ye/KyoM1JYLRnXIueDVYqjNbtPUYDcYbR17Yaybh6B2TXXzWr/H9DHaSNiXKCuWvkGSTO5qr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcG24v42ve7cOqHg2ZlQwJpBYbjtvtVkcFj250EsO3Q=;
 b=alrQAFRPXp802ZegRere4zX2EhMaU5TTkFlzfTVT1MR6NyizH6ZZOXPyGhhFx0uM70m+KLCgXF1WPue3odYQqD8DTXcfzhnoH/9oVuSAqa0VS3dKtWC7Chdr0fxA81b8SV4lAEW2DLsE19CZuGLXz7Tn3n0Kt7QY7mcaMUX61KXE6UZhs2ekTjm3mheep8QZVht0n/0S/u9kOlr8ChScD+sKokVSWbV0fu6/Sb6tpkwPj+B8rVzSY3CIoh73l0mt2+jYhrZbPiyIuR9bPxV6Lhz1WqsJJKFSLl0e0E/3NVi1sQfJO1lcMsABKaG/MGlp04amsTOKLWUNPqpzjttAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcG24v42ve7cOqHg2ZlQwJpBYbjtvtVkcFj250EsO3Q=;
 b=fAJtDrU08ReMKGoEkeLaaJEOKaB6GbMYYAsOCE+Y3bRJkWjEFQtevb3WhuVvprNFWDEMCpBxaDSEfHgATqgvtm0tlFvX8IA+TtL6cgSmN5owjL/LW5lDvAnkpiFSVFvt6rRD1AgGGBLLgAGwbPNS81mHZUw+qdTXSQviCC1BbWxgH+eDHu6yqxaMg9HN5QUcr70+/yqFwfwuiZSqTjQbwqV8OmWZnIpqyU+y2/Be12iomH6zPRRTiHvsqnhC4Vq2RlrotdQxoVs/pTvM8o0dA1LBpzl+qNhbD0jOq53PfZKpIX3OR9pEy0V+tdvpE+I27V92QJUFzia/DdhRglSgRw==
Received: from BYAPR02MB5016.namprd02.prod.outlook.com (2603:10b6:a03:69::27)
 by SJ0PR02MB7823.namprd02.prod.outlook.com (2603:10b6:a03:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 18:16:00 +0000
Received: from BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a]) by BYAPR02MB5016.namprd02.prod.outlook.com
 ([fe80::c759:bef6:2ea6:d47a%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 18:15:59 +0000
From: Vincent Liu <vincent.liu@nutanix.com>
To: gregkh@linuxfoundation.org, dakr@kernel.org, linux-kernel@vger.kernel.org
Cc: rafael@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        vincent.liu@nutanix.com
Subject: [PATCH v2] driver core: Check drivers_autoprobe for all added devices
Date: Mon, 13 Oct 2025 19:14:59 +0100
Message-ID: <20251013181459.517736-1-vincent.liu@nutanix.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251001151508.1684592-1-vincent.liu@nutanix.com>
References: <20251001151508.1684592-1-vincent.liu@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:806:20::7) To BYAPR02MB5016.namprd02.prod.outlook.com
 (2603:10b6:a03:69::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB5016:EE_|SJ0PR02MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 04577ffd-1fd2-4435-a8b0-08de0a848fd3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+jdXE6m+fTCYVIxgL2PYJ1pTMiYGm3YrHALPSO3GbXKIDLEiVsOZEiQHXY3q?=
 =?us-ascii?Q?aW2zpdcWQ2R/kq4s23ZRuWJsg2+WAZ4HFL/YRF80g8JFSHbCEyu7hmRGDQVh?=
 =?us-ascii?Q?30PHY0ydZ4hDYdGq3Ox4gp1FYSb4ZuyS8CIJiH1ieDMQ+oEYbfLxu7nwqY8W?=
 =?us-ascii?Q?N+xUIwNUmRnYuf/5fmh3999je1/Qir0fZ1rwrW9RPRH5ND1Ts0Up5Ghff/o7?=
 =?us-ascii?Q?fq9LdZDzqqxhlup+UpHMJ7nbPyrYK0fzkKK8kkdSAhCuj8O7g4En0pYqnllz?=
 =?us-ascii?Q?8Sw1eZiQRMcg4Z05Zb6JFDDJrwM8h5xB8Pt3kWgMLqMoFtAoViGj4tTulOvf?=
 =?us-ascii?Q?i0dy0itdt17I9IQCQphimJuQbSXz9pd5fVm+jCj/w76ldTeY38q4LV7RI8er?=
 =?us-ascii?Q?6QqSumepROdCdgdrlKgVBU4QLP22cHJg+49k8He5G92W90s24Rkd5woEmXhv?=
 =?us-ascii?Q?74FqfoLMxvmUjHJ4N0iCQonvMvw57UKhOBz3hYUY2WcTuaAkpV8KQAQmyNoO?=
 =?us-ascii?Q?Wup3S/M0iYMpr5ks5WX1RjDbyvLcrttB08wRclqvfO7rdZhXxmXaxwCd7ndc?=
 =?us-ascii?Q?Zb106muNCvk8CQWfD2vPDHWKNGXZXwKrPl+Ly6hPqbrkxwIMKUwuNmL3SFN/?=
 =?us-ascii?Q?XIoiv8pUZc2hYcye12Wr7TdcAKxAko1rm+gIfXClyOL4H668Xl2S7ZloV8e1?=
 =?us-ascii?Q?LTIOAThxWSjLbuRqRNlkSvCTW7FQF/iFcCvlNLqGOiN7XFbkLUeo22zSY6bF?=
 =?us-ascii?Q?wPbRSN6/wqfTr4ynFOJI1uC+wOexTtIscN5j12Stbw9MnJwekI/TBIRWHKa7?=
 =?us-ascii?Q?eilVBi9iqGsUXpA69AhgDD+D+edaYP6BuZmzGyYc/DRr7RhIMV+vN/CEowEu?=
 =?us-ascii?Q?z3xfuvLVLZ+1A9ZIf5v5aadrGQhjIjmjqYTuAgCTbl0J7v7n7SPNEoF3s5Bo?=
 =?us-ascii?Q?Gm8rCpEWtCiu4DAoKzathb3uGhW2DIj10FE5Cicdz9vWAeXwp1IngZLL9cCV?=
 =?us-ascii?Q?WimW6E0fsUVRyXGdSHDZUDbNHPUuCchuHHllowIb107uE8kG9m/u08JAFZxY?=
 =?us-ascii?Q?AoRdgm7Qu9HBdrmnrdF0SZObyPRSd/9JnFcnVRv+xHz0skluOjCarwRYTGEi?=
 =?us-ascii?Q?GTKWehzQR5CaoeMIECgz6OTjagG2wmYa4PALpAQwvb2zxaLjUqb1po9xj5nW?=
 =?us-ascii?Q?o8kiMbAqcMP7Nxtie/FCc7nn0eL2G7Mhy4jPt1/faxnmJb9dyrcVtUW2gfwt?=
 =?us-ascii?Q?2BX1OH31LzBcQx9NzzhW3erx1nPdMzCRLafFPShLJtufhvvYIm2V0Y2ngpyE?=
 =?us-ascii?Q?VOm3yWAiS1msaSHyTFzHo07XHZmZlK9K7GseKK4ivjprCW5anIsOQ1G+ZUlI?=
 =?us-ascii?Q?NSU+z7o/DMfte88DhECLE6ULgzMH4yafEKI19NqIVkm5K0Gs/ZDHToF5NA24?=
 =?us-ascii?Q?KkQZP2cIPR6hiGRw7pHvmlvQyrJ9SJ/BQj3tT5FSXhoKr7vkiunWYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5016.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3WSr7Fv3A9MsHHXIfPJo5y7V4wj2V7NBKSzfcjZU+9Ra7BB8+2BFw1dKFBgJ?=
 =?us-ascii?Q?6dSwnNYxNJ3dFGsnGZD70RGE+pgR/RGhf2HQNi+xSQwZXCaTeCKsTEYDxwvD?=
 =?us-ascii?Q?WuZIwwWIuyAYj7ZTlbLH7lAHGlpFHcbuPdRktCRyMglAPvMKfAr1i+bT1sE7?=
 =?us-ascii?Q?5smDkdfSCZd1WWQTu/hwhUiXUvqia/XxayyieB0fz6i5dJ0C5eHje5nZERMr?=
 =?us-ascii?Q?OTYJOrzsafuFbWIzsh6bvvaX4ri56Sjw0PbPapJ/gYo3KN60HuVMM83+YXZZ?=
 =?us-ascii?Q?e2a70PH29QbmsF1DJy0IkiKOpx9hVbsUOswfYTAS4mM5ROOF1cqLGUwSE5ol?=
 =?us-ascii?Q?wdQMPNcaYw+VZ+qZwbkjSGqToHmlbr7gFX60o/DEyXQIZw2w7ty78aDsW8YT?=
 =?us-ascii?Q?wlRFgsKz+Z5O8sgicAQ74Ia3xPR+X5xOaVxDyXXMCHqEZLoUQR+RviHOEZIE?=
 =?us-ascii?Q?AKHdsBv8GRQro/Ocqp7AFVyHua3r2a/fPgmjkTKXI2D9pJ0gKfaY0x1SAepp?=
 =?us-ascii?Q?36beFqgT399CbGn6jiCfPEcZQnWfJrlt9e8WIAQeKMgsn0pR/zB1D9GzKgTI?=
 =?us-ascii?Q?S/zDzc3VE/Ae9nfp9y7fkwOgs0Y2dVW/antA85sd/kpeaqRHxs0dXxFqx4R9?=
 =?us-ascii?Q?n5w/6EQJqlKlXrbvkPeli4VbVC5W8hYv333pjay9IGcHRoaz96xIiPm1H6V4?=
 =?us-ascii?Q?Irg5ePQMX9axSS48iEPmFlHEQ3olKuvqdJvMIUMTt87P7RBUmM0DoBx4xHxr?=
 =?us-ascii?Q?AVlGxU+acjFVUR2bqWmxdLa3cp4fP97UPCyTYV61dmaUumSKgp4NrNi6wwTj?=
 =?us-ascii?Q?ouI5JZZDPly2l4/tkz569OyiFc6kPqr7YjG9ZhPWXMlKxpG/VXiuk8i+0cg3?=
 =?us-ascii?Q?d6djR4cWDRYMLHoHX8ONwwuI1p9IVi+7a+3mAONbIsx3kobRysT0LN67xLTi?=
 =?us-ascii?Q?bQZCFLmwkJSez5oXJO1IiXIvZH0YLrw4MFqPBDNBD46ObjjjQLg/zTE9QPJH?=
 =?us-ascii?Q?3+H+2x5e6qFvkSubVML1iFMmPH3V0jagUAcdu/kRzrSd9y/PJaQYsVWKPf7+?=
 =?us-ascii?Q?EucziBq3uIga519A3x8xVs/JjEncUak/IP1VWQcFcw4yngTf1u9XLgKbimeH?=
 =?us-ascii?Q?7aVOnNADH0MkVu2ZFyEdiZH3onLtFVWnSshdzYS00a9WyAA3usZzHGa7n6Ir?=
 =?us-ascii?Q?I5Wt6kNJPwKTcI1dGV04I0UxsymNOWn4Pg1x4CTnyZEtoAuo9WZ+6gb417cg?=
 =?us-ascii?Q?1XE8G7L8aqqB+nEzEA2cdejTGwFqZLVlmTJMM/qoavQXDhV7WH4GfvRUhLlW?=
 =?us-ascii?Q?g/z7ZQ0UasVHqulHZ6cuJ9cNiudQ4SQmZ9gnYjzJkbDcoNV+1BHGm0hlrixv?=
 =?us-ascii?Q?T9uFZBdUKvzOUlYuTLCXbrV6Io7JNadRT5WbB/oYkl7O+IyZMw9LGUyOmvat?=
 =?us-ascii?Q?VRfkHqlaOT8WCMdA8A56OBLuCg05vjaVpz20K5j2xri0yp7Xz31v//FLiAXO?=
 =?us-ascii?Q?s7hccYd0H3GE71npKy+E45SRp6Up89e2hCWyXqKaXZdXmyfWuBTN78eve40Y?=
 =?us-ascii?Q?RP4byiqczrPusRaxfU9WK9T3xisds3jOo4FNJP9fWJJNeE9nFoKzDkN2eGTK?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04577ffd-1fd2-4435-a8b0-08de0a848fd3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5016.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 18:15:59.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjHcL6R4vRiGao6o09G95PmfK/yHF5TWExXgh1oDA1Lea99i5pix1XPG1tNJUFSFJibuhzDr58y89gejELTX+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7823
X-Proofpoint-ORIG-GUID: F0K0WvdStsjqeGAyOKpBUCAe21BHoeVV
X-Proofpoint-GUID: F0K0WvdStsjqeGAyOKpBUCAe21BHoeVV
X-Authority-Analysis: v=2.4 cv=U6+fzOru c=1 sm=1 tr=0 ts=68ed41e3 cx=c_pps
 a=J2I5gP+8VxcSyNNGd87E2w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8
 a=64Cc0HZtAAAA:8 a=vaUuHiGXbuiZ4sT5dA8A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX4ytCxqVa5BRV
 RH41tel80xXVvG/RFodna/QOF5lOUv5PxMDQG9uHfJGE5zXODPfhGcv3/odR83u2qjaqx1hV7gS
 4eUK+JytKuBmH5+dG+sv1tT6JpwmquGnkQGqX674C8IE1K+rhkTIIEUE6g3SrHsMYii665pcps+
 bY3k7ziSsxpM4Piw/Ju9RyqHCwHwBTvjekr9h5KRAZuJZ9EZW3OdqSLAfws+mIelyZiS23izhRD
 7QKotq1edKUAhr9vOtgMaQt+oBVFyte37gD0u4SXl1VJvmSF9Ydzr5wMGXPYd8AfwHn8ulprsvh
 IQ5IM+SrSBF+PFyNYXzx39s5SkdsmNmkTjHFvnIcAWGnkhThckLjY/hR4wSPSVjNZkmVRvTPY9g
 R+x6KxzRW8o+6DJQUtZQRF78C/zWYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

When a device is hot-plugged, the drivers_autoprobe sysfs attribute is
not checked. This means that drivers_autoprobe is not working as
intended, e.g. hot-plugged PCIe devices will still be autoprobed and
bound to drivers even with drivers_autoprobe disabled.

Make sure all devices check drivers_autoprobe by pushing the
drivers_autoprobe check into device_initial_probe. This will only
affect devices on the PCI bus for now as device_initial_probe is only
called by pci_bus_add_device and bus_probe_device (but bus_probe_device
already checks for autoprobe). In particular for the PCI devices, only
hot-plugged PCIe devices/VFs should be affected as the default value of
pci/drivers_autoprobe remains 1 and can only be cleared from userland.

Any future callers of device_initial_probe will respsect the
drivers_autoprobe sysfs attribute, but this should be the intended
purpose of drivers_autoprobe.

Signed-off-by: Vincent Liu <vincent.liu@nutanix.com>
---
v1->v2: Change commit subject to include driver core (no code change)
	https://lore.kernel.org/20251001151508.1684592-1-vincent.liu@nutanix.com
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


