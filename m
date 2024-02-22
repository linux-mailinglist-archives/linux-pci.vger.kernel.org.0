Return-Path: <linux-pci+bounces-3892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F54786049C
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 22:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148BA281C79
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 21:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C2173F13;
	Thu, 22 Feb 2024 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lEaRkYn+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE30C6AF97;
	Thu, 22 Feb 2024 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636724; cv=fail; b=a0CIldS596yXa4L4tm93qRWQlc2/q9mT5r0u9grSybD2Aaty3cGx5kParjfbp2VKpa5U9UyUEem8V77JdVIBVDREpTVrc+DG+wx2WP5qnsgpN9RM/HjrFCkvFDA/NSHCFHhYpfqgqhZq1pTEaKRqwWwsV4S9QfsxSO6bi9J2lrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636724; c=relaxed/simple;
	bh=MJmZNznj2jBekk7cJUVaeakO7xU64YUbeHvnbnx2Jdk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IdjlT5mx4M506AjakDSkHbZOoVaA2izxiOHqXlB4+f5AXWkxXDz/aja1BaHFuvzQ6VnPOvDeJsAj446ktcFV2Sq30cr58ozN7+I2bsI9eNh12tB6hkFM8if8vfiDcSl1tN85l9fMyXOEPsMWdPDzXPICWGy7qLHQ8VGXa3EHZf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lEaRkYn+; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oS73nWzvswoR3t7H5vPNvOrV0L0W8yHacLXmiePYYtcZyUId863JrtjBZW3nHqJ6hL9ZuQI8bgMFCJm1JIeTx7D0Es6O9Wuj9dFC2BSTXq9x4N74V5vEypaUP05aho+jW9O7E5VHLzr2CkupLfgpTFvnMP8wrhhj+lFIJEPFehp/TmNRkqyNCXEULBSaNeuokl58QwFQEd68Thc/bJdJhwyayP0s3lPu1kncLNclzEF6kLe9XmUiyF/IXVrWmkixRZa1i4mfVurX4fA67Z2oV2Q9ZOOO5KPlJN5DntLu+5tkTTIqWoWaIt6qmIvs+c3Ipf/jE7ym0BOckxLrnBWH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZZun7yDsMlFesmsGfSkIOc/3fFzhC9TFkmX9V8Qw/g=;
 b=QrZagLxkbzkYMcWxtZji1qMNXbUKXt2SXNhMYQ4wiQyI1i2db/bvaW+DTTAu4UArC/SUDBQsJRxw4ANe6ERvIdMdDI8e4Oaq/DCdSCA9KWM19PCnPvK/HYbxywGmTGJ4wf3LSLQPPVXrv999Cm8IEyp7Q5pa1Wq1ZSdCCsWU4to4N9Q1VLXzxVOYudPHPqA6Rs3PbV+haNMi4W1UTnPPJMTbnNx6/Vo0x4ZNQZ0nQXN6RxJtPuf4JKwMKlqz65S6VxN5lhBTYyjQqgVQiwB22ovhlM6ekKS1hDq1RB5UQyT7w4obvzV6If08++eHBwc1P70GaQFhc3szUsQA6uBIEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZZun7yDsMlFesmsGfSkIOc/3fFzhC9TFkmX9V8Qw/g=;
 b=lEaRkYn+5SZsFOKnNemscxsYnpHJTSyqKh8PxbVez3Grrl7rr9IUhBo8DzzCXbuUAVYDZjnzBytsk8a5PpUcGY1H4IwbJsy8XnLbH/tr0JvNGZIF6FemF4ow3AxdbbfXCgOC+VJUXU3omAoUBxidJ8PLHhkqinO+xtztJ1c8JimLQhRoEGa0fUatCmMcfj7szZzJ9J15+cuofajw8CZ3IX3KJDS8zu+DgaojLPBWXD3nNdonGNp1t1O4gK9O+86xJVUD+anldthI8KpzfU2dSKMcfpkERHxcF4trYh8JnNtn3Wc1T1WTJhquHrXsj7IV/6AMwppdnRTQqVCyQmPDJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 21:18:34 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::ad63:96df:9a9a:83e4]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::ad63:96df:9a9a:83e4%5]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 21:18:33 +0000
Message-ID: <17a29a7e-b013-4568-8e21-9647969b6b6d@nvidia.com>
Date: Fri, 23 Feb 2024 02:48:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] PCI: Add support for preserving boot configuration
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org, will@kernel.org,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 frowand.list@gmail.com, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240222170641.GA15593@bhelgaas>
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20240222170641.GA15593@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::14) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e84b121-2b3d-44a5-feff-08dc33ebd348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9p1QJHJ8mkSVjtx+Bnalu/KNOKsxfgYc30+e3uj98Dhcx+vzmyOe+g/bE4d3m4VCSCHHpMo63R5uIO3fbafD8p116PePCAPnJmj3OdmL43ejIU6N0AS3KIeplo1IUq5dnh2t1OS2gjOXxYJusy/1bYgMZPxaUOOVv22sysdN3Z6jjLUdZId9+QKSyPuHcQ8eulqQVrmeRR26sAa3II0AFTu/Oo76Dt1JAW2u33ReB2+pm7BnLvPHCQN+WvXP3sGb60AHrcWv5SHjWX6U+LN0VTJGgJsbtvV2IsI1b4bKihM5u7sK89ZvLfPm3d/hqTZjgD1o5SZOTQuzhtiZS+kXLNZ3dxFPwlZnCitobZZ9ZWEOa3yalpusFldbxei9m4yp17etlKNBHlyfhaf+JuxViHqqAraL7i/wL3LoDEa66Rihg3qX6a14OmJMWqjag7xB2Yy/fmXawu+CEHAlXB5aIwxC13sEFR7vrCLyQyuWTEHjtnykoxftRtAykVf0b1pOaEqSwc3UYWvIN6sEYdARvd3taCqh+kb/c0sepOewJtNi/VgDFUZrQWWmPIeY1X5s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2NFL1AxUVlPS0J2dTRiS3Aza2prUDBvQWtmZHN0bU4vZDBEckxHOGRmQnNu?=
 =?utf-8?B?MVdnNWpHb3I1VUpGQ0EwN3AyY09PbFVTTkZxc3JuV1ZvSkRUNC9pQmZpR0xl?=
 =?utf-8?B?Y24zNW0rNlFyVm9yT3prRld0Ly9NSHBva0R5TUthTDNyZ0lrYnFjOGJWNTV2?=
 =?utf-8?B?cXQyckt4d1NBUSt3NXkxUURqU0RUWDlFVmFwN1ZNL2UzRDJMOXI4YUhUb1JW?=
 =?utf-8?B?ajI1Vk5WMjJJNXdEbmhtbXhmTjFzbkU1T25JSzVCSGlkdDM4clFPdVF5M0ZN?=
 =?utf-8?B?Z0hsS2E5WGgvOGp5Ymp4NkJHMThxRTRSRmtWMWU2b0dMKzN3OStwakdHMmpj?=
 =?utf-8?B?Q3diZU10a0NRbkNlQlV2UGZDKzRMWjNtVVVrNlNRaVZUYlo5WGFxay8xeWtC?=
 =?utf-8?B?VFczTTljL1RyY1hTOC93RTJDMnNTeE5ycCtha2xwSVVIWmorK2hBdmcrbVF1?=
 =?utf-8?B?MitOQjB3ZjdBclQyaVRhbUdjbytCQWdsVERXcXkvZ1dNZy82VGFpNUFqTThM?=
 =?utf-8?B?V1ZQT2FVVkl4NzBqZzZTdEd1Mk01TnIwTTdHVGQ5WHhLcmZucWlwbHJnMWE4?=
 =?utf-8?B?TkZrQ2NsT2tmUlZ5ZldGOS9TNytiYzdnb01SbVNwRURROEpqU3lSQ2RwQ2Jl?=
 =?utf-8?B?YnphN1ovaTl6VHhXUFdHUFNuOVpwbEU4ekN0ejQ2TFVTazFmdm05ZzNFWlQ3?=
 =?utf-8?B?MENoZTAzZlFZamp1RWpOZ3FwdHpZZVNMaTRMbU9GNk51MzhnaE93azY2YVNr?=
 =?utf-8?B?Q1lFUnk5SjJ4cnZJNmg1MVZ0MFpsNnVRbFhuSWtQdGRub1ZyODlPV1NXTTZk?=
 =?utf-8?B?a1QzM0JENndPcXYrTkdHTktBNGZVcnpsQ0dZVGlBMURCVWZ0VU90cWE0c3Y5?=
 =?utf-8?B?RitNN0F0RHNlWnRNOUFmR280YTNxS05vQkVKdjcrTGdtOUFIdFptUEZwUjlJ?=
 =?utf-8?B?RExSc29YVWxiSFNoNXlaUDJJZ0FZYkd4dytqWHNaWFFsbEErd3JySjNiWEwv?=
 =?utf-8?B?d2J6RW03Q0hNdE9WUEtkQ2hHZ2JhQU9DbmFTK2tLV04zNW0vUUhSRVkrRHEw?=
 =?utf-8?B?VjY0RXM3bzlaNDRTa0RVQVBDVnNwOGRNRVFpMXJ4RGRZRTJGQVZRZTRrRUFX?=
 =?utf-8?B?UnljdVJYMzVQK1cvN1NMdzA3VEZyKzFVRjljaEVTSjFjNFlsZ2hGYmF2T0NN?=
 =?utf-8?B?V0NDd21LeHRUNGNqMHIreHFTU3k4ZUp5K2Jrb3pLSTQrblk1Z1FGdjI3TGlY?=
 =?utf-8?B?WmZ1WkI0alBrbHlsdkhOeVg1dmUrbnVHb1dmQWZWaC9zcUZHS0VHQ0RRSDBp?=
 =?utf-8?B?b25iWlcvWUVCN3BkSWtydFNOZm1VcEJYUlFxWDlMbmlHVEVXK0pDb05NYmZv?=
 =?utf-8?B?TFhiRng2MVlMQ0ZuMkdvNFRsOHVuRjdHcWlubFR1eFRuWDB0SVEvTndod0Fh?=
 =?utf-8?B?ak01N2FKczh5UHptTVQ5U2FKaWxubmxrL0xlbGhEODlaS1BWZE8yOWQzRUlC?=
 =?utf-8?B?YjlvSHdUOVpFZ0VxZ3dmTkhBRGtSUldUVU9qM2I5ZWwyMEE3TzhZaThKUkVD?=
 =?utf-8?B?QWVNNkpPSks1SXdYTS9TWkRPVGtXc1FIMU8xdTQ2QjlHS2dxcUkyY1ppNFVr?=
 =?utf-8?B?dWxhMmVrM0NNWCt6dDZYMkgxYU81TktmeXpVTHNTVzlwRU5mZmR3a3lnZE9p?=
 =?utf-8?B?TnZZQUVibE5BWmJtTnRqZzIwZ1Z0T3JaVzlkVGVHc1JCbVV5TEZvMUZ6SHJ3?=
 =?utf-8?B?ZUNQUU5sVGF0cnN0WDB6aCtyditMbEN3bTc5d1pIWEc4cDlPYVEyemorTzJU?=
 =?utf-8?B?SVYyRHQwYXpVZGUyVDJEc1N0MGJRRmZNYllHS3NiS2pZaWpvaGRJZzJpOTlO?=
 =?utf-8?B?dldtM2hmU0tOd0tLOTZVMEF5NTZhZ1dGQSszc3M1OXVTTVRKdDlnZnE1aGwr?=
 =?utf-8?B?T3liaG4yc0JpZzJWNVJhdWJGcUZvVmdxeG9yNzF1REpRNmdxWThnamdYNWx1?=
 =?utf-8?B?RzhwbDNSWFBsamdKaVBuTy9nd3ptL1Q2bnJBbmpYMURqZ0lpbW5RRGtVdDFy?=
 =?utf-8?B?SEswQ0tTNmpVdzZqVTRkeVhieWIzNWNhbll3QWw4RWJ3OTZkbmpWRjFWbjB1?=
 =?utf-8?Q?W5X0biPdj3yYJcaorayN2QuC/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e84b121-2b3d-44a5-feff-08dc33ebd348
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 21:18:33.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pe1wiy4LrfIkxSnKwkj49phmdtAo3pSUIL1x4W2FjDe7vFqwjZ7nAKw1Uwi91zCvvxmn8xJUDFR2cFHgRKfPAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074



On 22-02-2024 22:36, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Feb 22, 2024 at 06:11:10PM +0530, Vidya Sagar wrote:
>> Add support for preserving the boot configuration done by the
>> platform firmware per host bridge basis, based on the presence of
>> 'linux,pci-probe-only' property in the respective PCIe host bridge
>> device-tree node. It also unifies the ACPI and DT based boot flows
>> in this regard.
>> +/**
>> + * of_pci_bridge_check_probe_only - Return true if the boot configuration
>> + *                                  needs to be preserved
> I don't like the "check_probe_only" name because it's a boolean
> function but the name doesn't tell me what a true/false return value
> means.  Something like "preserve_resources" would be better.  If you
> want "probe_only", even removing the "check" would help.
I'll change it in the next patch.
>> + * @node: Device tree node with the domain information.
>> + *
>> + * This function looks for "linux,pci-probe-only" property for a given
>> + * PCIe controller's node and returns true if found. Having this property
>> + * for a PCIe controller ensures that the kernel doesn't re-enumerate and
>> + * reconfigure the BAR resources that are already done by the platform firmware.
> This is generic PCI, not PCIe-specific (also in commit log and comment
> below).
>
> I think "enumeration" specifically refers to discovering what devices
> are present, and the kernel always does that, so drop that part.
> Reconfiguring BARs and bridge windows is what we want to prevent.
Agree and I'll address it in the next patch.
>> + * NOTE: The scope of "linux,pci-probe-only" defined within a PCIe bridge device
>> + *       is limited to the hierarchy under that particular bridge device. whereas
>> + *       the scope of "linux,pci-probe-only" defined within chosen node is
>> + *       system wide.
>> + *
>> + * Return: true if the property exists false otherwise.
>> + */
>> +bool of_pci_bridge_check_probe_only(struct device_node *node)
>> +{
>> +     return of_property_read_bool(node, "linux,pci-probe-only");
>> +}
>> +EXPORT_SYMBOL_GPL(of_pci_bridge_check_probe_only);
> Why does this need to be exported for modules and exposed via
> include/linux/pci.h?
On a second through, I think it is not required to be exported.
I'll address this also in the next patch.
>> +static void pci_check_config_preserve(struct pci_host_bridge *host_bridge)
>> +{
>> +     if (&host_bridge->dev) {
> Checking &host_bridge->dev doesn't seem like the right way to
> determine whether this is an ACPI host bridge.
Honestly, I couldn't find a clear way to differentiate between an ACPI based
host bridge and a DT based host bridge. Hence, the current code tries to get
the information using both ways and since a system can only be either 
ACPI or
DT based, but one at a time, preserve_config will be set only once (assuming
the system wants it to be set). Let me know if there is a better approach
for this?

I was looking at the way 'external_facing' gets set in both the boot 
flows and
I see that there is no common place for it and the respective flows have 
their
functions separately i.e. pci_acpi_set_external_facing() for ACPI and
pci_set_bus_of_node() for DT.

Thanks,
Vidya Sagar
>> +             union acpi_object *obj;
>> +
>> +             /*
>> +              * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
>> +              * exists and returns 0, we must preserve any PCI resource
>> +              * assignments made by firmware for this host bridge.
>> +              */
>> +             obj = acpi_evaluate_dsm(ACPI_HANDLE(&host_bridge->dev), &pci_acpi_dsm_guid, 1,
>> +                                     DSM_PCI_PRESERVE_BOOT_CONFIG, NULL);
>> +             if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0)
>> +                     host_bridge->preserve_config = 1;
>> +             ACPI_FREE(obj);
>> +     }


