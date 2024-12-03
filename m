Return-Path: <linux-pci+bounces-17597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88A29E2D47
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 21:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9894E2821D0
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 20:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FE020A5F3;
	Tue,  3 Dec 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mh1EEYqH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F4020A5EE;
	Tue,  3 Dec 2024 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258255; cv=fail; b=aN4SQEQEtBFuqy1HITwfBtoWu5q+pF/7f2OFKWsz+uATTE5fN5wva+v9LdoBHLXXE7ABE7PHkiYs2mwVn7UtYpkfSdkJq+sSiFwgowa9NQ6pf+p7AFpG1QFq/df2VemLEtT5pYJ5z0YgozW2NAGBmODP59PeEGNlEqVSFvFVPR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258255; c=relaxed/simple;
	bh=o5EKIj3vNC7YvPmJEwQfL1pJ0yVh5RKNjyYncOCamTU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Q/+TGzkOt4UGmGNU6iJ2Qj86QVZj+UqbxdTcqebEAVSx08ig3tJ21PgRecUUZ7jpGMldS8tCNa5DopsAs5/NKle8bROtcEqWxgL2PfQhdM/Bcgx7qmCH6q8Uk5+jLRjDBSIWR9QsXu6o7VIFE+P1LzCyOhYWhvS62c5HexJzTjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mh1EEYqH; arc=fail smtp.client-ip=40.107.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLqgLeAmopfgb7DsouyC/kmPVvHs7DHct6/jogQAjoPkC2D9kqOKEiG8oD5TyYaCpZeFf/uAx1EDiyq81UyFvkqWS8E1Acg1I45WCArC/XLg7xf4xGtA6UbGDXCY/JkumCssA3iBi8/LpBUGgNpHBgrv30R6+rO5W3ASfjn6oqLUDQM/VKzIOL/dsQlROOHmMvmG0X0G8JH/1Hi09K+C3WGMPesMmjNBgVItZu+0Azy6yjWsAEMaGytgic2hT6tqrwYhnTFQRmIS2WHUW9pw9n02Z15VjmXiTAaNXNcIGIUGS9zgiShDdf9UJIiyKqWWBz2s1Vdf+yG3DvdpDWOy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgVPjIxixay55JQCXGUQeF5Pm0xBX2Gb/KuEgDxzx2k=;
 b=UBiYigYtytls4KD4whu4cXIhoLBGzeFtiDWnfKBV9ncdghF63tOzJ27E+rrsqitbMWMBAB/BMlMM1xvAoJ/WTxyqr4FB+fAUt49VxWhDnK/elo2biOcf7XA1wI++ICxq8wRRscGe34G7dXYuu0txBSU+w16FTYzaacyMjiKQAtAqVZxyzSNW7+MNiqFujGUG1AnB4TJ0H0yQLrSHj2VJStq51JjQv46L9/l+6aQRs6Za0ppxjWp2lq0k4LN/0fCIVMrQqaPacAW585SwgkWBsND2jkz7jIqefZv3+K/t/k2ns9MPsYU1iWFOu8wlYqHumA/hkXpQrd3d/O647xTh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgVPjIxixay55JQCXGUQeF5Pm0xBX2Gb/KuEgDxzx2k=;
 b=mh1EEYqHoOwKhYgrjR8aws8noZDHurZHhqW7KAhRvvqYsdrLPl8ebAN8tsLWmNNeDT/j42FCq3zvukn9xDagv5Ub3drRXs9cqqwS8oGcGRcJsCpgMbsOfBxgnd+tE8fL3wW3GJ/ZFzWQOufZf7iTeEntjPe2k3Q19h8OK3yVtjT3Ae6VAapRPbR800jpUjzML2P/FPcMPdvLLxT6idatBVyMr4fsD6uYJ93HLpe3IU2BH7UGpBD/skZiAZYFZ7qM7PiCwHkKUo5WgpPAd5JsEtxNR9TrA1kz7LHRtm11KdIrTVkOxTmctLSlRwLocZR+Up0l7Z7TZlpAn7m66upSyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8730.eurprd04.prod.outlook.com (2603:10a6:20b:43d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Tue, 3 Dec
 2024 20:37:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:37:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 03 Dec 2024 15:36:54 -0500
Subject: [PATCH v9 5/6] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-ep-msi-v9-5-a60dbc3f15dd@nxp.com>
References: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
In-Reply-To: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, jdmason@kudzu.us, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733258225; l=5948;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=o5EKIj3vNC7YvPmJEwQfL1pJ0yVh5RKNjyYncOCamTU=;
 b=1oGpdo808LSKWefQoCYEAZjxj2YrDNBTNO8Z17lkQJYo9T0m3xl48/XXkYKGIYtCv+zxgiwaG
 /tuFOfBMZWiDzuh797sqg1Pk8N8CuRec3c1gCfVLKh2+bWgI8hFS0J7
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8bc1d2-873e-49eb-30f8-08dd13da4ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0ZReXhaNEEwQm1TNUhxQmxpalk4T2lweE8zb3pNc1U5WForcC9ZT05WZ29W?=
 =?utf-8?B?bXp2aG82a202aXhMd0dDbEVjalV1T3k5NnNmdTdSME9jT29IbE1NcWp2SWZJ?=
 =?utf-8?B?bk0ySWY0VE1aMWJyS1FWc0tqQUh1L1U2OVZ0STI5cVNXNk9HWDlYYlQzNVcx?=
 =?utf-8?B?ajFaUzBVRjZBc0Q0V1RlVHl2SC81TVQxY1lybit0RUY3ZytYZk9KeG80eXIw?=
 =?utf-8?B?bzg3WG1TV0p5L1BBc25KakNhTm1odU45NmZiSDVxN1BQZFl0SXFpcEhXRkhS?=
 =?utf-8?B?cG5vT0lLRkJUeGdqREw2Z3FrSWN4V2lEdDVlK29aL1VWRFZPcEFTUUp6eDgw?=
 =?utf-8?B?WTJEbDR6THczM3dTMHN4L1RvWHE3OWE4d05mZTYwc24rMThuS0VJUGYxdW84?=
 =?utf-8?B?TWcwblp5aFl3bGR6U2tjVkpFNVNnanNLRjR5aGVVSnRCWmlYc05uTmJQb3Mw?=
 =?utf-8?B?RWxoNUMxQk1uUUZOV0trYzJkNWhVeVRkUkN0Nk96L0lJd2pSUTQyejJSRVBp?=
 =?utf-8?B?RktBRGJoRDFkd1p6VkxMeFRGc2hNR1Y1akdCZkR4bXNVYUQvMnNuT0pTWko5?=
 =?utf-8?B?UVhpRlRWeG9CSUlWbWtYRWFaeVZGSStPSFF2YjJ3cEw2N1d1VzAzNjFLWW9Q?=
 =?utf-8?B?cVFHNnp5NEZnZjJ4SnAvQjIrU2dkWGUwREc0OGhRQ0JHOXRNZEFSWTNwYWll?=
 =?utf-8?B?ZktYejlZdUQrd3ErN1BUeVJYeGdWM1NITHI1SE00V3lmMXgza2ZqK2RWSGRY?=
 =?utf-8?B?Rkp6TmtrNmRLNEZnUmwxb3FNT0QzTHIyT1FEb2xYWmJPa3BzaGJjOWU4VTVv?=
 =?utf-8?B?N1RQeTdyMmQ3K3ByZ3JCd3lYSWxYVms1cjRKVWZGNHZXblhienRyUzRrVUpl?=
 =?utf-8?B?NXQzcWNnM213ZGVLZ1g0Nm9JWVZyaGZPS0srb2prZ3dnVnpuVDNDY2pwWHVm?=
 =?utf-8?B?b1o1b3llNnZJTG9ibXpZNHRydzZhZTNFekdPR1MvN0tiWXBVNjkwNm5zaVY1?=
 =?utf-8?B?d1dLL1paWmU1aGxDeEZIRXlzc2ozNkpQYWY1Tk1mMTdiWXlFTW9GTEdyYy91?=
 =?utf-8?B?TlVSWlFnS1plem80bHB6QVB0QWVIc0c1eWRQWGJDUVJBQStyV3MzYXpRN0Fv?=
 =?utf-8?B?RzNEZDMzclRUTnRsWkJiRkk0elczMFFid0dCN0ZjMXpvbElxdVFLTHBtUVNw?=
 =?utf-8?B?UndyNmlaY2ZVdlBRK1JyREt6RW1ubHQ1bEd0UmIyNHNLR3IvVVJSZ01uU0pt?=
 =?utf-8?B?dEM5U3BhMkpQWFYyUjFJbFpUL2xrbVYvY0xXdzFLQkZoVmVFOVE5bk1XaWJy?=
 =?utf-8?B?ZWxIYmxYNWVSNFBBTUgvWGh4eWQ5dGdPYkVsWTZFbmhhL2tKUE9uOC9rd042?=
 =?utf-8?B?RlpUQ0p5MENlb04rVjA4Q2FuS0pmM0V4NWRvZkxGbU9sZS9hb3M4VnJRNFJC?=
 =?utf-8?B?Ty8ySkE4cUZ1WjQ3R2g5eXFVMHA1SmNTQ0JOVGNFOUF6bC96bjdsOVJWQVQ0?=
 =?utf-8?B?a3RuS0JmUk9KOElkWWFyY25YMm80aHBrU0NsWm5zY1I4R3l0eXZEbzdBb2NE?=
 =?utf-8?B?a3ZTcmo2c3U2dUtuUG5CNFIvVVYzcVZMNWtrM0FNSEQ2dHg1dWxHdEZNMzlz?=
 =?utf-8?B?VEh0QkxTZEdpbHpadk5BdXhESGg3S1ZuWmdZdGtkRUJ2QkpOOFIrend3MUhH?=
 =?utf-8?B?SHEyRjBRcmJRMTNzZ2FXUS9XTjhWUi9mck5tWUp1NjRzeUtqTEhEVUs4YzEw?=
 =?utf-8?B?REF2YUdsVE4zVy9JaXRGRWZHVm1JTmFnU01VRFc1TkRiejVGc2lwem1hUVVm?=
 =?utf-8?B?dzlWeG5XUEUwUnJ4TXpZQk5XaS9IdjZ1aXJJSG5jalBNd0dMS3VKNFkwQUNT?=
 =?utf-8?B?dUFEaGpwY1VURkVMQ3lNcjN3SFFSMU1sV0lyMDBVazRpZ3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGRrakpLbVdBL1hpWG9Ca2pTa2gyMW9ZcFlIK2E4VHhPL1QydWQ3b05aODR1?=
 =?utf-8?B?eVdOWm11dVpOQXU5OFNSZkFXRmNYaFJZaXRYbjdQUC95SXZidkQ4QjcvbmpX?=
 =?utf-8?B?LzZhRVpYdExhcm1nY292emk3V0x4YzJQbWR0QUdXVXdOeWN5MklGSFBnZWJJ?=
 =?utf-8?B?Umt0MmM1aHp3a2thNGphYmp3V1JBdEhaQVZRc2poQTVSRUZFT1B3dGI1enB6?=
 =?utf-8?B?eVZXZzZJYmQ2anJ3YVI2VWhpdHhVNjBHa0ZzaGhwQXNNd05BS3M4Q29EcGlW?=
 =?utf-8?B?TlVKWkMwbjZ6TlkzMlVwcFJUMGJBNnBhZktIc3pwREVwN3hqT3dRLy9BaDBD?=
 =?utf-8?B?SWdjN3FTalNZTWN6NXVGd2ZtNFlSTkxTeWVaZGVEV0ZBblFaUGRCdmM0OHIw?=
 =?utf-8?B?cFVQZUJRRmpzQWdnRXV2VTF0OVYzeEpnUzR3RnV3UnBqQVhSMnRDQUEweFFX?=
 =?utf-8?B?Zk9QSndqSWY4YVBkUW91dDBnYWdUS01Qc3llTWphVDFwZGNpdlNRcS9KSmVq?=
 =?utf-8?B?TkE0bUl4ODZuRzRkZ1I3RnZPcUFydTBQNnRBWC9kOGVnelo4Q2R3MEpYU3Uz?=
 =?utf-8?B?djVOWDh3OGZ5YjhEL0tacWRTdHJ5SFpFcjhqZlZuQmZtTnR6djNFL29vdFVm?=
 =?utf-8?B?QTBaMUNHTDBVa0N5cWtVWkpSeFR5MU1zOVJrQkVjSDloQ3dFczRZYkEzc0RG?=
 =?utf-8?B?d3VqVklZckE2TkNHbnhCOXAxTWpJekNsM0xkVUEzaDdvZmFndDUyaWtmc01R?=
 =?utf-8?B?WUprclMxOERha2dhZ1NUVzVNTXBPQVo1SjVVRElnUExYWHNBc0RoUngrYnVJ?=
 =?utf-8?B?VVhJUXBzSDNsb01UdWpEaklIN1RwTDlUNUpWRGZNS01zUW9BY2h3ME5KNGo0?=
 =?utf-8?B?NTY2MVN2M2dwbGo3ZUNjZzNRSkR2c3J1bTBMT1AvanZHeHZGbVZJSXhZS2xs?=
 =?utf-8?B?SG5mV0dZOGRFbnhCazJLeUdOaWVLRlk1QVc0OUJQcnRLK2RmNDg2VWY4bnNS?=
 =?utf-8?B?TWJ6N1h5NjFqTFR3ZW1QVkRqUWFkUzVCbWdIMEUwbmZreFB0b0hWbmpFM1Z5?=
 =?utf-8?B?YzVpQnJiY1diUzhiOHAvMi9lM1VRaDVtYkJpK2xCajhQZC9uTjRqcHFpaW9r?=
 =?utf-8?B?YkFUMDJPTlFUWTNDZlBiYnhkOFMwMHZTa2EwaGYvalc4cWNnS3E4NUlvU3lt?=
 =?utf-8?B?UWdoeEFvT1lkeW5wai8xK2FoK2VJWkVtbm0xREJBeC82c0ZSbHFEN01WaXdG?=
 =?utf-8?B?R01GTWgxVUdKOUJzMXZGbFVENmpmcmMxa0E2STgrOGhUK1FqSUNZM1VmOE16?=
 =?utf-8?B?Vk1CeExPV080ZkVXd2o1VTRUeGFteU1MRG1ZYVkxTldGaTZqa2JPS2kyeTFM?=
 =?utf-8?B?YzBwTG5kMUZtcTlLcjRYek1jYzlXN29JbDlkMnQ1bDAxZEtLRXN2S2FYNisy?=
 =?utf-8?B?V08zRFcycU1tMWFUZWZ6S3MveVMyNWFORVBHUjI4bFRhVjBSUGtqKy90bkxP?=
 =?utf-8?B?b0lDMXhONURkOHBKQzJ5T0ZpSlp1Qnp3dElzYTFzekJXbGNiYnlpb1AzcFF4?=
 =?utf-8?B?OTMwWk1xK3F0MUpKazllM2NxS2RYUldETTJrYUxYM2g4RnpYTHUzMjBqU251?=
 =?utf-8?B?UGZLSzhCOWo1LzdEeUVTSDQvQWdSYWVKbk1TZWtlcFZ2RDgrbkZuOUFPazAv?=
 =?utf-8?B?bmIyS3l1ZUlGenp2c0c3UmkyUEpXMUxrZzFnQUFIWVZXdW96ODYraHBTVDgw?=
 =?utf-8?B?NEorbVpqOFhqTm12NjQwZUlqanhkelBtelBrQWxUaTFzUHFNTFF6VUdtTTFU?=
 =?utf-8?B?TWh5dmZLNkxqaE1oMkltaFMzV0E1TzVZQ2JaSWYwbWxTTzdCUmo3S2ZpbVhi?=
 =?utf-8?B?TUg0MjhTK0R6N0J0L3dkdGo1TnlvSGN0bXBHcDlnVlUxK1NaVEJGZ3U5c2M0?=
 =?utf-8?B?ZzdILzZpMVNtV3NoZXcySm1NQWhXUnFFRjlYVjZlUHNvbnhQQWRkem9aS1pk?=
 =?utf-8?B?S1ROYWF3Q2ZTdXlkNkNCU2NDTnR4QjdwWnFZOXZlSTA5R3NMSGpWVXNXWVh4?=
 =?utf-8?B?RndqTVNjdlY1YmVBOGVUQmtFdDlHRXJzd0VSYzZuSTAvRk9LNWVHSWs3VG96?=
 =?utf-8?Q?Zors=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8bc1d2-873e-49eb-30f8-08dd13da4ee7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:37:30.5102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DKSDeMt08UFTvMbLpMnRiIIUBZo6F8RhPYCs8SKprjSwnYsnKMSCm1ZcBB8M3Six+D90cjC1ZnVn7AYrvjMiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8730

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
and PCIE_ENDPOINT_TEST_DB_DATA.

Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
address provided by PCI_ENDPOINT_TEST_DB_OFFSET and wait for endpoint
feedback.

Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
to enable EP side's doorbell support and avoid compatible problem, which
host side driver miss-match with endpoint side function driver. See below
table:

		Host side new driver	Host side old driver
EP: new driver		S			F
EP: old driver		F			F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v8 to v9
- change PCITEST_DOORBELL to 0xa

Change form v6 to v8
- none

Change from v5 to v6
- %s/PCI_ENDPOINT_TEST_DB_ADDR/PCI_ENDPOINT_TEST_DB_OFFSET/g

Change from v4 to v5
- remove unused varible
- add irq_type at pci_endpoint_test_doorbell();

change from v3 to v4
- Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- Remove new DID requirement.
---
 drivers/misc/pci_endpoint_test.c | 80 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 81 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee2..b3f36b6ba8ba2 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -42,6 +42,8 @@
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
+#define COMMAND_ENABLE_DOORBELL			BIT(6)
+#define COMMAND_DISABLE_DOORBELL		BIT(7)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -53,6 +55,11 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -67,6 +74,10 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+#define PCI_ENDPOINT_TEST_DB_BAR		0x30
+#define PCI_ENDPOINT_TEST_DB_OFFSET		0x34
+#define PCI_ENDPOINT_TEST_DB_DATA		0x38
+
 #define FLAG_USE_DMA				BIT(0)
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
@@ -108,6 +119,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -746,6 +758,71 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	int irq_type = test->irq_type;
+	enum pci_barno bar;
+	u32 data, status;
+	u32 addr;
+
+	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return false;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_ENABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_DOORBELL_ENABLE_FAIL) {
+		dev_err(dev, "Failed to enable doorbell\n");
+		return false;
+	}
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
+	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	writel(data, test->bar[bar] + addr);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		dev_err(dev, "Endpoint have not received Doorbell\n");
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_DISABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (status & STATUS_DOORBELL_DISABLE_FAIL) {
+		dev_err(dev, "Failed to disable doorbell\n");
+		return false;
+	}
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		return false;
+
+	return true;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -793,6 +870,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 94b46b043b536..b82e7f2ed937d 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -20,6 +20,7 @@
 #define PCITEST_MSIX		_IOW('P', 0x7, int)
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
+#define PCITEST_DOORBELL	_IO('P', 0xa)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001

-- 
2.34.1


