Return-Path: <linux-pci+bounces-10127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E99D92DC9F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 01:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829001C216AE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 23:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D1E1527A7;
	Wed, 10 Jul 2024 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lygC33GS"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2085D15383E;
	Wed, 10 Jul 2024 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653997; cv=fail; b=poNK/B0H4fcMeJGJPDuoT3CQcY+XdpnS0MgDvz4wiUGO5hDEEIhlbdJ+WUVoEH5BhMVQNXJksmHDUdsFNrXE5q3Yz/IMRlA7+ZjXSm/1OX0swCMsWcQH8ZBEFFW7yfzqiBhdlRr0eAH3txHcCbJvUToGNY3x4oHZtrd3vicE+gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653997; c=relaxed/simple;
	bh=w+IkT9AD6lIh8OQC0txyjXdIlYUfwPvf2lUGXDKj3Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jBgNROFLYVOgsaOEl8S4KL4rwqeHg6XuW35+5ZqgURyG3aY2WiBDGtcpiFGgbqTBxQrVnHDkTtELerjTYuMVeYTqWHJYBam15jj0MyVrVU4kJUUImzcSNrwAxl5gVSh9N5G8zH/sjrzbQE6e8/NcZcuhgne2dr/ZVIMOJGzzOkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lygC33GS; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWq5sOzkEriLKx+hymslEN12lFgKNIlX096oSHTxpcqctsLcfwXruA/IKlf8QL7NlZnJayxLNht+hrT86sq7Y6CubZfP6powi/JS2VBaLrb14Mkgs7pbJoeVRLG71RPjYMsHJyRfGak14U+5m7zL5rwrC35AYDK2pL4oStVXsK+od/P3mmXVlDbPgIWEDY7eT/fVJRwkGtMo2lK7C6TygG2xu0jA1d10KRBj4+VUhR2JXG1Jnkg/XOepol74rFiKoZxaE/yIhLS4G0G/5hf9PI7N26om9OV6w5ogPQb9yCheU3FhfqC5ihOvE42cGNFnPOlQdKtpiRa/ec10jeLQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+IkT9AD6lIh8OQC0txyjXdIlYUfwPvf2lUGXDKj3Xg=;
 b=WzwrrNMs7Bs53WHsBWBtM9ysrWXbgIN9N3MQbeTDeYtvuYgnHvT0aqPl5K/4GoK9jcp3pGiKZNN6FtMO68EXBRA2GmeVKhnLuwiGv1urGO5Fha/BTfc6UAlkJm2VqfsXwMVqhokl8gCFsM1gpwAI6ttMP9mw+7a6rpdxijVbuNhqC5H9NE8+GgVNh48XzsOfhZhzTJoQ87rulxmbjCV1ad7E1I5LVSfdRukohz3hsdrTdzEfbQXEHZygWPmI5U9EpCj7G+JUZluuZ4ngU6Vx5BJ4pISzzvv4dp3nNtM0Fk3CXqZGbdX+6Rvufy1nooFC9yJx7CAtfYhtYYoP+7gjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+IkT9AD6lIh8OQC0txyjXdIlYUfwPvf2lUGXDKj3Xg=;
 b=lygC33GSCIl6zV+NqbLylWjPKbFtoChi+D5cENr/SM3rtajZqUOD88GHrO5Tbu+PBj86tQF9HdaSMgv+svLYW3UlKzDe+z7ZQyTl3sbAqFqIK5/AhmGr50O0O4CrzHjsv+iyu66gPGqvG9+GHbKEx+UcQ8uHesAqKnWyLBpbGgA=
Received: from MW4PR03CA0032.namprd03.prod.outlook.com (2603:10b6:303:8e::7)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 23:26:31 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::a4) by MW4PR03CA0032.outlook.office365.com
 (2603:10b6:303:8e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Wed, 10 Jul 2024 23:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Wed, 10 Jul 2024 23:26:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 18:26:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 18:26:29 -0500
Received: from [172.25.198.154] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 18:26:28 -0500
Message-ID: <5e8240d1-01ee-4cd4-8b6c-df951325d86f@amd.com>
Date: Wed, 10 Jul 2024 19:26:27 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] PCI: align small (<4k) BARs
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
CC: <x86@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a5ff71-a0b6-4396-1c75-08dca137bb43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzJGdTZKd1diMU5yTDdTaUdMaGtyU0o5L2lkT3hac2krQStuUitEcStFd0FO?=
 =?utf-8?B?UkVjM2tCMzBSQmV0eTJRKzc3b2MyWDZtTTYzajJkNGpWUWk2OEptYkpqY0dJ?=
 =?utf-8?B?TnZ0YXM1b3l4NnJKbytxRWdsUjRSMDN3a1lTdjZlazZUalllcWtnMTBkRHlp?=
 =?utf-8?B?VFc1Mkdac3lZWG8rUEM5c04xaTNCZjY0VVBITE5aMldKQTNkb3ZReXZBblRk?=
 =?utf-8?B?U0lpVjNqdVI1TFZnbm5RQWRBNjljUy9Yd01ScS9PUDlJcDgzUDg5eXFJai81?=
 =?utf-8?B?NnBMNXNvcUxXY0hRM1VkaTZLaE1hTHIzSUFFZUpZQkNrMGg4MUdtYWlHeHRY?=
 =?utf-8?B?OHhuV3ZqZi9GdWNHVzdIV2xVOXdsOVVuM3gxVDBxckFqTTJFSExwUHFzSWpN?=
 =?utf-8?B?RFJMNmZTeS9JVE5lZDN2ZWNvU3dOOUlZRjVvdTRHMnRlM2pEZ2tCeC9RaVVI?=
 =?utf-8?B?NVV3RTdQY2xIcW56UnkyTjNyTGYyYXRwMWhsdytXaTR6MWJzeGN2NGJVSFYr?=
 =?utf-8?B?MmFNMVFWaTNobVdpVFA1TnprSy81ZWtkSDdmdDZsbERuakp6c1JndGx1cGQ3?=
 =?utf-8?B?aUlTRURkZCtDUjF1SXV5ZE1kQWx5cVM2ZXJaU0NjNlVkeklSQ0pleGh3NDNu?=
 =?utf-8?B?citmSEFHRit3VU12Znd6bjBOTEh1bnM0Y0VUVjNaQS8rcHVsdU9GT2FBMjZz?=
 =?utf-8?B?SjVRUlRWL0JkemxYODdrRGQ1bEpCcjRFRFNzOGZ0MlY0L205b2M0TkRnR0hx?=
 =?utf-8?B?R2hRN21kOHFsSlVEM25EdnA2TXVDRGsrUDNpcVJEcWM3WTVJWDcvbTBEQ25h?=
 =?utf-8?B?ZDNkdlBtdXRPSkhrVzNDRXpsR0VQOFE2UE9LQ1RjTWRxZUxKQTFiNU4vNHdP?=
 =?utf-8?B?T3QyTVV6cG9qazZHdjdYQnpnMnZoL1hBNWl2RDIzWHMyRE5oc2JhQnlYYUFa?=
 =?utf-8?B?QmRMQ0d1YTBsTVRwVDY3aTBtcVNNTm5NL1RvUVo0bllOY0hINGVCdSs2OURq?=
 =?utf-8?B?U25hUXloYUhBeUtYRUNkUVRnRmpiWE1IWFlnRS9CK2xhS0NFays3ckI5ZnRT?=
 =?utf-8?B?cGd2bE9uT2RJV002VjBid2NHVU9uZkdWY1lpeS9qZkd1a3Z1WGsyZ1d5V0dh?=
 =?utf-8?B?QlRoZnZNcTVRMDVURmdYN0VlRFhVbzFZamlVZGlsZkl0RUFBZ3c1RjRSallT?=
 =?utf-8?B?M0RoZitTdzNsZE5pRGt4YXhHUGNodHROU1pjM2J5WjZvTlljejcyNitZK1pw?=
 =?utf-8?B?aktzZ1JPaUM2YjlMWmxUZHp2b3lYdEZLK0NMdldyWG9hMnRrRGJ0dGgwcVh1?=
 =?utf-8?B?L1pTNzJ6WnU2RFNRQ1I1SUFaaDJZazhiZ3RIckU0aUlJclNud256eVdwUDZh?=
 =?utf-8?B?dEpIS2RNRFl6Tm91dUJwUEhZTnhrYU03M1NuVXZ4YjlQb2h6MysxV08wWjdr?=
 =?utf-8?B?V2dRb1RhbGpwME1RSzhNd3BHT2U2b1B0c2oySSt3aFA4YUw0MEx0THFkOTc1?=
 =?utf-8?B?TzZneE42Wm5mRG9pZ1BDVHVXQWpYVWhJMVFBZFpJOFFYMHU4T2wzZXdXbml6?=
 =?utf-8?B?Z0xHS3VPS0lmV1Z4Ym1CZW85eXZVQkNLbXhNOFdMZWpINktoZXpPc3F0ODNN?=
 =?utf-8?B?UEVBU2xCNEN2U3gyc0ZoaDYxRHRsTDJPQUZpSVlLRkZoZmQ1Q0xWRDlLZkFS?=
 =?utf-8?B?TzBwTXE4TkRvdkRlZW5XR2NPeG1PMXk0cEJUanI4SlBCUzd2dVhQUlpFdXFQ?=
 =?utf-8?B?cTNqQVFBNnpEbFU0T2hhMjJHTk1ORy9iV05uRDVoZHA0cDRJMmhGbmgreTVl?=
 =?utf-8?B?bkR6KzFodkprcU5DemRsckVnVUhjb1FiMS84SjhLd0RtNGwwdmhDekxPSjgr?=
 =?utf-8?B?b1lCRjNYdW5PZG94YVNQRXFuZUFMSm16WEJld3hKUGR6Wmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 23:26:31.3497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a5ff71-a0b6-4396-1c75-08dca137bb43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943

On 7/9/24 09:35, Stewart Hildebrand wrote:
> This series sets the default minimum resource alignment to 4k for memory
> BARs. In preparation, it makes an optimization and addresses some corner
> cases observed when reallocating BARs. I consider the prepapatory
> patches to be prerequisites to changing the default BAR size.

Sorry, I meant for this to say default BAR "alignment", not "size"

