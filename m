Return-Path: <linux-pci+bounces-10390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891C89331B2
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 21:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF3F1F27C05
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 19:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EC819E7F7;
	Tue, 16 Jul 2024 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="pcuOxhl1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54021A08DE;
	Tue, 16 Jul 2024 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156871; cv=fail; b=KJCPUPknhV8aPK7aQQBOBkEBaHJRWdR0+n0rVO/BKa20UnGquov5aEn/nLzKqJ2MevebVd+379xVqQYYr5QqXh7yjSObRvlvhBqAlXNAom3l/+UtzZmR2NRdneqMKkriWcBHUO2Rk5in5dqba4o3TII+zT/xXnXTJ2chpe4lylI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156871; c=relaxed/simple;
	bh=trKhTSEHnSXXLl64OFicedox6Pb/WaYdowAvClqKzLI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MyMSBQFrJbzqfOD26eJimprdQ3/YHCKftnhxJQoUwIGH8fDaswkkZIB4+HYpc/elhLp9MgGIVVtM/s43srQX7W+XZGFulq/aGaz1wzzok6DjlqrM94RJkuLFzjlKRPsqmtW/Vfh7UwEcc2KJrsDisMhO354GgkWBQHVU+CuBsGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=pcuOxhl1; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GHc2Nr009381;
	Tue, 16 Jul 2024 12:07:18 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40dwe7gcen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 12:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKl/XjN+nFMpeKjr9gD+RyL8KEDpfw3iP0AL2sOOd30OJT8KUhF+M2+AXvKxTNZc9EfR9qCGaOjLeChfS2bTtcnp+a2OoEhF0QMdu5YVImVSfKDuWOyu9RDbBf9sBKxOlZ9X0cbu53WnUuPQFM2zI669PIbpYBFqRViWWJwzdDE1073ZFwbF7zO2R79/UPLsLEKml69JcetPyLBrFWYyFGxxC+Xu0r6/VYaBM1Rsv6BMA6GRu85eqsKjjDCnyT93XRnELeyrX4oQvfppTujWgUXmB7YTMZuMMPCcau0NNiihwOEiU4+PQP8Q4865lRup63GIpuL5iVbpiH1xOw9DFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JY4UGQBS/qRDuP0ewCjHoK26Ck5jn9G46+JrHSrsUCU=;
 b=QQ+HXPtEKoxiYZal4Sa4ZoZMNxL+GN5Llsg9SsZhSrrUtnyk8jLS6wzcYIoVUL3zd5SZhjGAOAq95zd/9lKu0QX48ZTfURHQJG0wT0kgCDzipmfHabfE57gtiOtXp9DdVDlHnyjtC4knaOORMgGbZU0B5ONfVsd09s0HPaqzippWBa34Xye0nhYRbGNcydaUXIgUF2a9OxPOE1hB5+Bjz1xp+O69WdLh2BHW77ndLsz+BDmO1ASzCIZHZN/1mN0FpWwjg1E+iZycKQL19qWmeWH9++2cBz6GjvLFle3obkgDZXbpkKLg1b7/gnUXyGvoGKw/pDqBD8lRvEFmH1pzPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY4UGQBS/qRDuP0ewCjHoK26Ck5jn9G46+JrHSrsUCU=;
 b=pcuOxhl1f/vgaj34jXQEW1+ZVFZxvIR+jTgoYz/FhGLmNMOeAGDGnRk//f4sIpwWdyFoIgIxT0QU8z8hxX4/ky4Zh38DzDCLszRLrQkBpIL6TunZzVF6j94P5YunD4wAUwKGwAuWEvApTkl9+RPBOKnCNmjADwELtbE09CPtPiA=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by DM4PR18MB4383.namprd18.prod.outlook.com (2603:10b6:5:39f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 19:07:03 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%6]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 19:07:03 +0000
Message-ID: <fc972506-7fde-4b79-ac51-4657409e462f@marvell.com>
Date: Wed, 17 Jul 2024 00:36:52 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 04/12] PCI: brcmstb: Use bridge reset if available
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Stanimir Varbanov <svarbanov@suse.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
 <20240710221630.29561-5-james.quinlan@broadcom.com>
 <2c539dc6-bfb1-4dbe-8fbd-4dc04984f473@marvell.com>
 <CA+-6iNxm0mVDKWAH1P8ZYs5cVf7YEKSeM-r38Re8ST2v8+BKXQ@mail.gmail.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <CA+-6iNxm0mVDKWAH1P8ZYs5cVf7YEKSeM-r38Re8ST2v8+BKXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::24) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|DM4PR18MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 025eb13e-b198-4ba6-c7f8-08dca5ca79fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NUJUUnpzQjdZOExPUjdrYU1jakc3UkFqYXJSUFlxeWFTV0E4R0xNZ3B4eUVL?=
 =?utf-8?B?VUhyOFVEb0RRclhyQXhBb3dFN0xoMVZ6aloyT0pOWHdLYUtIZS84ZmsvZ1Z6?=
 =?utf-8?B?cUdTSlp3bldITWlQWTZGNWZlbFRjc3ZRZElMdzNsR1pZUk1QS3U3SkVtdDEy?=
 =?utf-8?B?U1F3VGNQZFc3U0FWbThiT1huYS81NTZlVW11N3Q2emVWc05IaDJDR1B1VUVm?=
 =?utf-8?B?bkNPa0JWUzJtMWdWQ2UvNXZEd3l2ZWRjUmZWdXJaaTFNRUJ3ZnJXMFhCU3N6?=
 =?utf-8?B?bjhvTnJGbE5FK1FOalV6ekxmdytvUjh1bG1FYzZFc0phVjhpMVoyMVNvaUhD?=
 =?utf-8?B?MTVKNUJpZTJVWlUyVWt3d3d2KzZKNmlzVXhwcktIeDhzc2FCMkk5NFFLYis4?=
 =?utf-8?B?OHEyWldLUGpiMTIzWktYU3BxZEFWR0s5K1lrUVoybU1tdmFXY014V01HNSs4?=
 =?utf-8?B?dG1qblE3cDZSamM4Y3lBVkdQNFN3dlQ3TURESnRYNUdrQkZOaGFHWTVoRmRS?=
 =?utf-8?B?VkZiUzE4d0Vac2cxZUhoSEhWNVNKZnc2d044Y3ROUmorVHRoUjlmV1JiSnNL?=
 =?utf-8?B?UFJYbGFMeFQ3TkYyT0xld2hvM3o2MnJDVkRmZG8weElSVFVSZllabVd2alBl?=
 =?utf-8?B?WXByd2dKcUhWQlJKbzd3ekN5cGNsMVR4NlFZZXhNNHZxeFN1UHJKaFR4aWd2?=
 =?utf-8?B?STl1TlRtRDNJZTUvQUI3UDdhc2x3Wk1pbXdFM0VPU3craVpMaUU1K0Q2OVdu?=
 =?utf-8?B?S0docXVXc0svei9qSjZBNmRUMHY1UnpvSzc4RXFSOEphcXUrR0F1dkRLTlp1?=
 =?utf-8?B?MXk1VjRmUDNmenZPaXVQTVB3Q2J3ZWNMRENSNnpYZUZrQzMyd2FsZFhzNVQ0?=
 =?utf-8?B?emgxMTVnOU95MU54M3YydzFIZGZtRHhVYnlPWUFoZEtYSjcwLzQvakRlVi9a?=
 =?utf-8?B?b3hmcUp4UmRoVnh0Um1wNlBKVVp3T3lPUldpQy9pYXVZTTE3b1JnRHc3K2d2?=
 =?utf-8?B?ZVZLMlBBUVZTQjZNbHhYZUdBc0dVdWZOUzU4eFZ0N2U5V1FSZTRERWt2Q2Qy?=
 =?utf-8?B?OXhkSldkYktjOEg3ei9Vd0dFZEVsSDVtUFMvSEw1d2NkZk9vQjkxdStSOFpW?=
 =?utf-8?B?UndDWEpUNEFjNGdjQjZzMWFycUtlUkRIYXhrYzFmSTN4TktKTnU4THZrRzhB?=
 =?utf-8?B?U2ZicGNzL21SaXpReER5Zm9vZjdOQlQvakc2d0VqM2Zxb2VuK1ZKa3ZHeVhD?=
 =?utf-8?B?T1hoZGZVOXI1TW9ONzd6Y0plNTRJUm9CMzc3eEw1MjlEZlZ3a3NFTzNPc0NG?=
 =?utf-8?B?NS9oY2J4bkpkU2t6alJ4OUhLeEpoT2RqRFpDWjlZK2YvQk8yMGdjZXBxY2Z2?=
 =?utf-8?B?amFleDgxMnkwZ2FkQUFrVytJNWhHbzRFS0k0Ym5VdDM1K1F1K081NnMxT1pF?=
 =?utf-8?B?YnNBMlFRT0JOaFN3T0VpU2hDT2JScC9NZVdmSGdrSGJKUERpckt3dEU1OVZ3?=
 =?utf-8?B?dkNOOG11N0dTMEk4WS9TK1gvdFJxVHUydmlYNHBPQzhyTmZMUE1TN1Z3ejFp?=
 =?utf-8?B?Q2hEVGU0QVBtcDgzdFlzNkwwUUFQYmcydEtoeEVNUWxYUFhkdDBRdWlxRHJT?=
 =?utf-8?B?S1E3cXBLVGZnYll6OGI4Zys1SWY3aVdMVC9sYVVObzR6V2RBdWtMMldKaDNI?=
 =?utf-8?B?V2N2MDh0THpLaHZIaGxVNDg5dkVwSC93cmovOUp6M0VZVmg4b3VSQWJ5SjhC?=
 =?utf-8?B?YVZJMlVtR3ZaN3FYRjJzUC9uMEtVTXpXMXBPMzFrdnY0QnZteUFBTlNncjE0?=
 =?utf-8?B?UHJQWmV2elVGS0lMeFBIQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S2c0WEFTWS9IQzUzNGdCZTd4NUlLaEF6REhPS1hUQU40R1UybExmQlRDeXRV?=
 =?utf-8?B?Q3BsTmRNUFp3RWxrZ0lwZ3hHVFNJQjVoa29xTSt2YlBrT3RpV216T0UvOGVU?=
 =?utf-8?B?Z1hWNklhR01oQW9HbGd1UHhRQnF5bmU0dEFTaWxBdFlTaFI4RXlVejJBeXhI?=
 =?utf-8?B?bEJ5RE1WK0NHd2JVclk1NDZCeUdKVUNTUUExT1hyUDVydjk2M0s2WlQ4eEdY?=
 =?utf-8?B?TFZBc2RuelBHeVN2WXhUc0dpN2tSaHV5azVvOHNWdFNjMGZiajQwRS9GQ3Nz?=
 =?utf-8?B?SEo1N3k5M0gyaXpGV0xtaXptZjZJUEUvSzE5NGpvZ0ZXeFRxbklwMGZGZk5Q?=
 =?utf-8?B?S3hPandQQ2N4Q0t4cjMwVDZCM24rSUdkbGpWbWZXU1lsT3AvaGVlRklvc2Rv?=
 =?utf-8?B?akJLcml1eWxpY2wrb3dGMHJXZDJuM3J4Z056eHUvSFZLNU1yNFFVVmkyNzR5?=
 =?utf-8?B?VDBqY3RHaWkxYzRGQ0dpbmdoYm1CMlFrRzQ0M28vYjRxWk84ejlLMi92N0h2?=
 =?utf-8?B?R1JTbWNVbEZGNExDVzU0YkxVQ1lQWWZzYmEzc3J6R3VFMm5CcTFEMW9iZWV0?=
 =?utf-8?B?NXhlRkEvV3MranFVcWhreUkwVFMwc2liK0NKMjVTVHlNSzdDVUZObUN1bVdt?=
 =?utf-8?B?QlJJMDdRanpSaVJmVk01MHBiNUtMVk40bnp6WVpjNksvLzN2Nkc2R2FUbGx2?=
 =?utf-8?B?Y2ZoSE5QSDVOOUpnSGxZb0x4b3JCdEEvb2d3eUhKaERaZmtJOUlhSTZwQTl4?=
 =?utf-8?B?dXhMRVhQQkJhMkllalMzNUFndDBCM24xTVpIYmVhYnpFTCtWQlJ2TVJ0RVY0?=
 =?utf-8?B?Z0lscVR1VUJOSGxFbk51dUlPdjV2MjMwV0thenRtYmZwb01yV1Zpam9pT0U5?=
 =?utf-8?B?dk4vdUkyVEd4ZEVubUNMcm82amliWWVSRUxGYVdZQ1FIUVhOTUhnVmltYnM4?=
 =?utf-8?B?MGM2L3paY1N3ckNMTjJWdVk5OEgxSFJTS2ovc3RKRkNSd2kzZElKRkpQYjFO?=
 =?utf-8?B?K0FLWlBsMTJqeEtrZnNFUy9aeHR3L1h4R2RvbXhra0dyUy9uOWlqZmdjdHpW?=
 =?utf-8?B?WkpJSzRSUy9TS29kL0U1Z3RUVUpuaTlyREMyNTRMaE1VSDZDSVVwWEJUMmVo?=
 =?utf-8?B?QTNVdG50dmJVc29zUlZLRXZwd3pZUk8zVFF3VWR6Z3EydVBydEc5aWsvT2VS?=
 =?utf-8?B?WUZCU2RINWJ0QXk4R3VEMzcxc0UzU3Vram10RUdFaXcwT053cStHcFBZU1Zo?=
 =?utf-8?B?NVN5MjA5a3d6MTRYQ2pTSkVJbGpxQ1VjVm4wYlZYb3ZkQ2oxRjBIOERCZTN3?=
 =?utf-8?B?d2kzQm5DTTRkT2RTQkxKdXFObXlzdU1VR3Y2MVhYcHNZYkZ2czIzSWxCeU96?=
 =?utf-8?B?OW9PY1MrTUNjajBMd1FOckx6UjlueFFXaWtZdFNyMldOc0hWMk0zNmpPbU9K?=
 =?utf-8?B?NGVYclhieHQ2QTNVVDVVVENVbW1XQTBzb0NTaDdjTC9NeWVtdlJmOU9yZUpF?=
 =?utf-8?B?ZEg0c0ZTZUtlZWdYekUwN0htSnhBaytYMnRhWW1DQjBpclljQncrQTBVc1hn?=
 =?utf-8?B?cmdUL1JRUEZzZUxKRVNrQWkrWGJER1VxY0RZaHU2OUt1SEtwcHpVT1VybmtZ?=
 =?utf-8?B?bWo1OW5wVU1HZG14cGNlZUE4anN3UlB0ajUreHVxQkY1TkdCZ25VanJLd2k0?=
 =?utf-8?B?dDN1enBVS09uZngyVVlQcy8zcnM1K09vdHAxNHdVQzN3RStFL055MDB2WkZV?=
 =?utf-8?B?WjN3TlVSNDNkcXM2bkJMWmFqUURGNjEwR3poekN4aWdTRjh2OTgvZHk2c09X?=
 =?utf-8?B?MXY1UWtyWnBYU3piRHk3ck9ZN1RnWDVvVXlaVGdPcE5COVp1Y3BqYjB4cnhY?=
 =?utf-8?B?QkxaVFVtYUlOcGw4UjNtcW80MURJM2g1V2ZMQVNBeTVjNGUvM09TR1dBbG44?=
 =?utf-8?B?czJJcWdWRHNnNVR0OTZmRnV3Q3JIN1BoZVdlbDBMYk9JN3N3SXc3SHQwWDc3?=
 =?utf-8?B?VDB2aFBLcHJKUlNlV0N2TU1MWlo5VFV5ekg5S042Q1Rya2xoRzhyZUJrMnhu?=
 =?utf-8?B?bmJCb0lCY2lkMTdIVEVYVFJUVUlMak1LQ3F5L3JodW9ZWGRvcjF2RWVBTHBz?=
 =?utf-8?Q?foXNPGgUOVzJu6vlJQF5zawQi?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025eb13e-b198-4ba6-c7f8-08dca5ca79fe
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:07:03.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkDJBVss+pAGTn+hE0fbRUJFA1snGHgHazfhhseVMOcxC3yiTuqhulQV6ebrAc2kvUubXC5xqtLYGN2J5K3Luw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4383
X-Proofpoint-GUID: oA83C6Q5Gw7pCwZmIbJSHOWJzNr1hDu8
X-Proofpoint-ORIG-GUID: oA83C6Q5Gw7pCwZmIbJSHOWJzNr1hDu8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01

On 7/17/2024 12:10 AM, Jim Quinlan wrote:
> On Sat, Jul 13, 2024 at 3:12 PM Amit Singh Tomar <amitsinght@marvell.com> wrote:
>>
>> On 7/11/2024 3:46 AM, Jim Quinlan wrote:
>>> The 7712 SOC has a bridge reset which can be described in the device tree.
>>> If it is present, use it. Otherwise, continue to use the legacy method to
>>> reset the bridge.
>>>
>>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>>> ---
>>>    drivers/pci/controller/pcie-brcmstb.c | 22 +++++++++++++++++-----
>>>    1 file changed, 17 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>>> index c257434edc08..92816d8d215a 100644
>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>> @@ -265,6 +265,7 @@ struct brcm_pcie {
>>>        enum pcie_type          type;
>>>        struct reset_control    *rescal;
>>>        struct reset_control    *perst_reset;
>>> +     struct reset_control    *bridge;
>>>        int                     num_memc;
>>>        u64                     memc_size[PCIE_BRCM_MAX_MEMC];
>>>        u32                     hw_rev;
>>> @@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
>>>
>>>    static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>>>    {
>>> -     u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
>>> -     u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
>>> +     if (pcie->bridge) {
>>> +             if (val)
>>> +                     reset_control_assert(pcie->bridge);
>>> +             else
>>> +                     reset_control_deassert(pcie->bridge);
>>> +     } else {
>>> +             u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
>>> +             u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
>>>
>>> -     tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>>> -     tmp = (tmp & ~mask) | ((val << shift) & mask);
>>> -     writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>>> +             tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>>> +             tmp = (tmp & ~mask) | ((val << shift) & mask);
>>> +             writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>>> +     }
>>>    }
>>>
>>>    static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
>>> @@ -1621,6 +1629,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>>        if (IS_ERR(pcie->perst_reset))
>>>                return PTR_ERR(pcie->perst_reset);
>>>
>>> +     pcie->bridge = devm_reset_control_get_optional_exclusive(&pdev->dev, "bridge");
>>> +     if (IS_ERR(pcie->bridge))
>>> +             return PTR_ERR(pcie->bridge);
>> How about using "dev_err_probe," which utilizes "dev_err" for logging
>> error messages and recording the deferred probe reason?
> 
> Hello Amit,
> 
> Someone else brought this up and I want to defer moving to
> dev_err_probe() in a future series.  I'd like to get this series out
> now as Stan is waiting to apply his commits on top of it.
> 

Sure, that's fine with me.

Thanks,
-Amit

