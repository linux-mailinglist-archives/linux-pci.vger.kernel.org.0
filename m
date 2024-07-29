Return-Path: <linux-pci+bounces-10978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE5093FBCB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 18:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F591C22942
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2625548E0;
	Mon, 29 Jul 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L51NkV9H"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B6E17756;
	Mon, 29 Jul 2024 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271664; cv=fail; b=t8LwldZXIS/O51KLDSb8lTcBP6tdZXCgymkqV/Bt3tgTMJJQZWEjlWZwLA2zNUJhG3HSp/Zt9HtWMZxpVDY+xr6cpm6KcSFE/lSDY47uL/9JYEA4hEB9sF1BDTCY67wZYX+uxltXEBvXFrUYu0BBsEyeqNLBXNt8lCUsZjciBB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271664; c=relaxed/simple;
	bh=Y8wKVCKqceNlgawYmMH8RhJJsgLzgjBjjCEl8KKtQAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WlHBQtwb+5hS/UTG2+i6EK368iJAcJng/P0UOwv2ol0mvC4oLOKn210BPMOXd9crFomCvIe2Auxdw73fIGkrbZAHeoFFm0lusuIs+tA2hBfvocmJvqloObkJyDAIOarRHHKnpU+CgGGrrAZTX7gPeU7PdbbPu0B4uu/i6Dhpwb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L51NkV9H; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbmjjzW7GFA3Cdm3IhypOecmloqayec5pfO/PbFij3Hc9JekHxWc6bbjV1K2x1X6UKV8TO+sO5GJ2SVuLuowTlBQ4CleRDm+jk4Gngx6jPGNts06QEij8ZQDYbf7I5SFfSGOBSX92YHt0Fd5v+dLx2Q15WZzFRATfkAiGKWGFhu/0YMwavOhwos45J3fcEdgjG//cJInuZOL88HDg/Bajt8Zjw03AntB+4xVv9bMkiq4984BhuW+sbLBtw809Pi83EM3T9HIsM6FnBMfBfauNgyDNMAyHw0U28lxOEWTUGLk9EnKuDDlrjvX7samewgzRpSpnshbyKrxG78r74qIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9lSRfD4qn7SfOPDVwxfVekaWjW05U739WhjytYfpYg=;
 b=rwe/e7uiWZkg8XCRLYJ9hPnJjfRmhlYvCGrThCSj+lYJi/uCFwpBDbKOAIPXRI4BGrPri1fjv5sITnS3H4WgR0T3LuXUhWNS+YeTKvdwxRRgveiekCvrKMj9ZTACLJVMR/mrBzoAHpujTqG0nWaCgel1Mghz/0qW9z7hqvZ4qkoZIbohtqMQDK3CLjXbWtVS1h9Mh+N9lzq1F58Sa1ceVplUCsKAH0F9Kn+7ph/S1DrXr6+WFepX6ZtjB/U2znbHzanZstHcJMzXQfM/O64IMxubN6jAhHA7MuVz/FZSNrgLuDtPGtSU0rJrf+tS//G8HU5ZuWaH8VuUJfOg4xlmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9lSRfD4qn7SfOPDVwxfVekaWjW05U739WhjytYfpYg=;
 b=L51NkV9HUIk7ltwmxnI5SjPtMEHK9ipEANB5IHG1iAw1ZSph0aV+UTYxahxMDr/v0wjC9xwOQnjxgdJOqCEzxiE9RWODYzS/EQ9gYspqfYrf2ajzJCON/uc3hkQI3WwGzdt1tHSeIknrl3J6ck2fD9XzIqhwB/TmxhL3vYjZVZ8=
Received: from SA1PR04CA0013.namprd04.prod.outlook.com (2603:10b6:806:2ce::19)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 16:47:39 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::a6) by SA1PR04CA0013.outlook.office365.com
 (2603:10b6:806:2ce::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Mon, 29 Jul 2024 16:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Mon, 29 Jul 2024 16:47:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 11:47:39 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 29 Jul 2024 11:47:38 -0500
Message-ID: <af45d85c-2145-cbce-b91b-2aa70a9dcd0f@amd.com>
Date: Mon, 29 Jul 2024 09:47:37 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] PCI: Fix crash during pci_dev hot-unplug on pseries
 KVM guest
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>, Saravana
 Kannan <saravanak@google.com>, Kowshik Jois B S <kowsjois@linux.ibm.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kvm-ppc@vger.kernel.org>, Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
	Lukas Wunner <lukas@wunner.de>, Nicholas Piggin <npiggin@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Vaibhav Jain <vaibhav@linux.ibm.com>,
	<linuxppc-dev@lists.ozlabs.org>
References: <CAL_JsqKKkcXDJ2nz98WNCvsSFzzc3dVXVnxMCntFXsCP=MeKsA@mail.gmail.com>
 <a6c92c73-13fb-8e9c-29de-1437654c3880@amd.com>
 <20240723162107.GA501469-robh@kernel.org>
 <a8d2e310-9446-6cfa-fe00-4ef83cdb6590@amd.com>
 <CAL_JsqJjhaLFm9jiswJTfi4yZFYGKJUdC+HV662RLWEkJjxACw@mail.gmail.com>
 <ac3aeec4-70fc-cd9e-498c-acab0b218d9b@amd.com>
 <p6cs4fxzistpyqkc5bv2sb76inrw7fterocdcu3snnyjpqydbr@thxna6v2umrl>
 <d20b78cd-ed34-3e5a-0176-c20ee5afd0db@amd.com>
 <CAL_JsqJAuVexFAz6gWWuTtX1Go-FnHe6vJapv0znHBERSCtv+Q@mail.gmail.com>
 <0b1be7b7-e65b-8d8e-0659-388dec303039@amd.com>
 <6mjt477ltxhr4sudizyzbspkqb7yspxvnoiblzeiwxw5kwwsmq@bchicp4bmtzq>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <6mjt477ltxhr4sudizyzbspkqb7yspxvnoiblzeiwxw5kwwsmq@bchicp4bmtzq>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a44371-3ede-447b-e3fc-08dcafee287a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkptYkpuTFE1clZmcnBVekpKZUVOTkYyQmY0dUlNekQ2VFY4UjMwVU55Umx2?=
 =?utf-8?B?MGdTZHdXd0M0R0djUFJIYnVZS1BGdjJxd2NzSHdxNWYxNHNodncwcGlCK2sx?=
 =?utf-8?B?WDFDQnFlc3BTQzZrNTNKYnhqWjQrMUhKdXVyNlNCVVltbGY5UXZodnREei81?=
 =?utf-8?B?ZDBWV1I0K1c2a044MWtCd1hWSGxLRVNxeVVjbWdidFVGcTEzbXR6ZURTcFBM?=
 =?utf-8?B?anEyT1F0bUkyRnFuZXlQRnNkdCtZVldRMEJ4aENVWG04TFBGUndlT3c5WXd5?=
 =?utf-8?B?SUZIYUM0Vk5sQmo3S0dvTDRnRjJEMG1uZlBQS1l6RjRsQlBPVWl0MGxMZTFL?=
 =?utf-8?B?bm1HWjY4TWJITWpYK0pLUXB4UDg0R2pGdGdhWndZWEhJNmRWNkEzL0FiYS9H?=
 =?utf-8?B?T1RKcUlWc050VS9DN1NjNXJVQ3BEV3RvSks0VElDU25DdXBJdHVFOHBYejN5?=
 =?utf-8?B?ZXh1QWsrUzZQTVY0d1grUU5Rd0J6MU9MWlpxUTh6UWh2UVp6T3EySFpoSlNv?=
 =?utf-8?B?N1dDYmxDd0RmajRuYzJDWVRMMzRYbkhVWHdyM2pSeUpxM2tORllLWnc4Vldv?=
 =?utf-8?B?dXlJamszTU8vVHVzTkQwdVJ0c1VPMVRrODY4U2tuVDkzWmdBT01salc5dEN6?=
 =?utf-8?B?OURnUWc0THhFbm00M0NoaVFwVjZKYlJjUU84KzJZRFFLK0Q2NlIxWTU5N3Br?=
 =?utf-8?B?cWhUaDNZNEZwZWRqdC9JVGtnNnlETFhrMnVNbkdPbklGQm1VU012WmVPKzRo?=
 =?utf-8?B?a3VoMjI4dVl3dmRiYUd2Qzd0OG9zVEo1c2szQ1ZkZHJUWWwydmRHUzg1OE5O?=
 =?utf-8?B?T3lXVG9ZaVc2UjBzTHpvbjk0R08xRThKSmlyRXZKckprbHBmSzRDZ0VIYklN?=
 =?utf-8?B?VzNFNnNuRlBnSm1ITElxMXN0ZzFObnFuVDFZdG1UZks0SWE5cGdpUWJUVHd0?=
 =?utf-8?B?UlZ3Qkx6NnhvM0dNN09TL3hsTVhlQXA0YlJWc3FiQXlDdVNXSnhtNmIxNjhj?=
 =?utf-8?B?S0JlcXNIZ0pIVXJuZlNxUUt5MlZ0NVFISWg0cDFoZS9oTnIvU3NYdmJUOUl0?=
 =?utf-8?B?K1FvVENvY2hiK1c1NFZORUVwekordWxMMzFSQ01FUUhDYytFckZnSElCeGNn?=
 =?utf-8?B?b2VJZ1pWOWpjRUZOMURhbmFHZndoQjV3Y2hmOWprV2ZZQVVCb2U5ME8wby9I?=
 =?utf-8?B?a2xUdG9kMnZMUnlESU00UnVzYk10V0ZaV3RGbVlQdDdCUUdseFN1b21iYzZs?=
 =?utf-8?B?a0JpcGN0aVVIVTlOMFRTYUxJbTdRdFJzZ1gvSnZmVnU4U3lVQzBBbHhXay9Y?=
 =?utf-8?B?SE1tZzZxblB4NWZnckhDV1FPSFhOKzU4NUFacy9yTkdncDdDTFlORVdDQlZE?=
 =?utf-8?B?TVJTbnhjYllwdFRVNzlvbXo3bEtSNk43T1Z2dE1OTUNrSXBKOVVQSEllQTFJ?=
 =?utf-8?B?RnV6TlJUa3lJTEhMVGVhb1A3TzVsbDhyZzBPQXIzcTNaaCtnODY5U1gvd2wz?=
 =?utf-8?B?bDZZMHVoV2IvdjFwRit1NW5DR2E3VU00S0c2RHIrb3dHenpkS2lJOEhQODdU?=
 =?utf-8?B?bHlEb2pLRU0rQzEzZ2NGb0I3bnNPU1paRXo1WFJuQktVN1U2d1RGN1pwTXNy?=
 =?utf-8?B?elBNVVFhcUxPK1ZRc1ZxMnAzSThIbGFkZFZORG5Da3luRVZSS2wvL3FKbjEv?=
 =?utf-8?B?dktBRWpXSlpuOGJtdkNvaXVHbko1VjNEeFJoYmdXK3cwYW1hVjdyZk55NUU0?=
 =?utf-8?B?SU1YOGVlMTlJMHJwbkJUQ3lqbEpoWkxTcytLcTVodDRteXBtMC9JZFpIM3RO?=
 =?utf-8?B?dXRHUGhpOUV3dktWRnlFYVAyWjNQVGJ0d1ZoTHhML0tYN2NwcFVScU5EaVhR?=
 =?utf-8?B?RzN2YnRCTllyVHdXTG1RSjNOOFh4U3o3S0tjSklnYTBvWWJkaEFnd0tPdEdS?=
 =?utf-8?B?VXFpSE8zNURQSTBHaWxHVFdOZ3hxcU1SVGJjZktLWG11Wm1qVE9pOUxMcjM5?=
 =?utf-8?B?RGMvWTlRY2VBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 16:47:39.5206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a44371-3ede-447b-e3fc-08dcafee287a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597

Hi Amit

On 7/29/24 04:13, Amit Machhiwal wrote:
> Hi Lizhi,
>
> On 2024/07/26 11:45 AM, Lizhi Hou wrote:
>> On 7/26/24 10:52, Rob Herring wrote:
>>> On Thu, Jul 25, 2024 at 6:06 PM Lizhi Hou <lizhi.hou@amd.com> wrote:
>>>> Hi Amit,
>>>>
>>>>
>>>> I try to follow the option which add a OF flag. If Rob is ok with this,
>>>> I would suggest to use it instead of V1 patch
>>>>
>>>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>>>> index dda6092e6d3a..a401ed0463d9 100644
>>>> --- a/drivers/of/dynamic.c
>>>> +++ b/drivers/of/dynamic.c
>>>> @@ -382,6 +382,11 @@ void of_node_release(struct kobject *kobj)
>>>>                                   __func__, node);
>>>>            }
>>>>
>>>> +       if (of_node_check_flag(node, OF_CREATED_WITH_CSET)) {
>>>> +               of_changeset_revert(node->data);
>>>> +               of_changeset_destroy(node->data);
>>>> +       }
>>> What happens if multiple nodes are created in the changeset?
>> Ok. multiple nodes will not work.
>>>> +
>>>>            if (node->child)
>>>>                    pr_err("ERROR: %s() unexpected children for %pOF/%s\n",
>>>>                            __func__, node->parent, node->full_name);
>>>> @@ -507,6 +512,7 @@ struct device_node *of_changeset_create_node(struct
>>>> of_changeset *ocs,
>>>>            np = __of_node_dup(NULL, full_name);
>>>>            if (!np)
>>>>                    return NULL;
>>>> +       of_node_set_flag(np, OF_CREATED_WITH_CSET);
>>> This should be set where the data ptr is set.
>> Ok. It sounds the fix could be simplified to 3 lines change.
> Thanks for the patch. The hot-plug and hot-unplug of PCI device seem to work
> fine as expected. I see this patch would attempt to remove only the nodes which
> were created in `of_pci_make_dev_node()` with the help of the newly introduced
> flag, which looks good to me.
>
> Also, since a call to `of_pci_make_dev_node()` from `pci_bus_add_device()`, that
> creates devices nodes only for bridge devices, is conditional on
> `pci_is_bridge()`, it only makes sense to retain the logical symmetry and call
> `of_pci_remove_node()` conditionally on `pci_is_bridge()` as well in
> `pci_stop_dev()`. Hence, I would like to propose the below change along with the
> above patch:
>
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 910387e5bdbf..c6394bf562cd 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -23,7 +23,8 @@ static void pci_stop_dev(struct pci_dev *dev)
>                  device_release_driver(&dev->dev);
>                  pci_proc_detach_device(dev);
>                  pci_remove_sysfs_dev_files(dev);
> -               of_pci_remove_node(dev);
> +               if (pci_is_bridge(dev))
> +                       of_pci_remove_node(dev);
>   
>                  pci_dev_assign_added(dev, false);
>          }
>
> Please let me know of your thoughts on this and based on that I can spin the v3
> of this patch.

As I mentioned, there are endpoints in pci quirks (pci/quirks.c) will 
also create nodes by of_pci_make_dev_node(). So please remove above two 
lines.


Thanks,

Lizhi

>
> In addition to this, can this patch be taken as part of 6.11 as a bug fix?
>
> Thanks,
> Amit
>
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 51e3dd0ea5ab..0b3ba1e1b18c 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -613,7 +613,7 @@ void of_pci_remove_node(struct pci_dev *pdev)
>>          struct device_node *np;
>>
>>          np = pci_device_to_OF_node(pdev);
>> -       if (!np || !of_node_check_flag(np, OF_DYNAMIC))
>> +       if (!np || !of_node_check_flag(np, OF_CREATED_WITH_CSET))
>>                  return;
>>          pdev->dev.of_node = NULL;
>>
>> @@ -672,6 +672,7 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>>          if (ret)
>>                  goto out_free_node;
>>
>> +       of_node_set_flag(np, OF_CREATED_WITH_CSET);
>>          np->data = cset;
>>          pdev->dev.of_node = np;
>>          kfree(name);
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index a0bedd038a05..a46317f6626e 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -153,6 +153,7 @@ extern struct device_node *of_stdout;
>>   #define OF_POPULATED_BUS       4 /* platform bus created for children */
>>   #define OF_OVERLAY             5 /* allocated for an overlay */
>>   #define OF_OVERLAY_FREE_CSET   6 /* in overlay cset being freed */
>> +#define OF_CREATED_WITH_CSET    7 /* created by of_changeset_create_node */
>>
>>   #define OF_BAD_ADDR    ((u64)-1)
>>
>>
>> Lizhi
>>
>>> Rob

