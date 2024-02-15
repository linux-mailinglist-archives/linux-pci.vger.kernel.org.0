Return-Path: <linux-pci+bounces-3555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930B5857079
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 23:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18671C20933
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 22:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B7E13B284;
	Thu, 15 Feb 2024 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="obxpjHgj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D2313AA23;
	Thu, 15 Feb 2024 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035708; cv=fail; b=rGhdLJ5gh5njoZDN/Ymi4HABRCevdPsye3M8+hnqg5Wyx2bMK1g5wkj+9OpM+Rb8FGSfQlVj+KRNgq1tM5WhxJrd9OKOgvptymJwvIN6rG9nrIrmFmaY556NmRNp0NnhYoT2wgS4yS5TmvrSPJiEoYcLpqCE6HMeuumKEkzzMPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035708; c=relaxed/simple;
	bh=4zpV7HgZMSDlqqT5LmHPpo1hrmVtdmwr2COGKNhKxwM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cv25NaQyUyO+cnhUEFAM/p0fe11l99krOSdJQ2bszlJVKtoAJQCmQ84hNnsJGxlWpCNFD8NDK7/gqMsNEyAYGca7oXFENDIW1hSw/1A/XeOj2WmdLVQNhcGPmrI7+eGl8wwNRMaX5mibqSznn3OIZG7NqfSnqdPkqUpPvNKb4DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=obxpjHgj; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ymf9PAFDc9ZCPe1W2p4W3n8XnJgXxfsbvKFETD/r+Ax6TWievRFelQksmm/yqEM6M+je63ntIZah9fKT6sdx0RtD1Fqn1BRp5rwTHu8Ha8gQ2QRyvlmU3OdJG2PrE6T3lVpNy4dziz3ssdcn0kKyZFzYXIz8uFAexQ2eHnqu0qOpz0wtOPsM6S7tFAsxmBmMG3vpfqIHeoA/jdVLjI2i5x0jDBFp2fYGb3gysCccr17MtK+ccZ/Qj3tVxtigC+W5iY9FToMAygyl19d1/Rw15hRulOTunEwPfYXrTIuaNejf4sCnuA0nncyN+ijPB5iC2pKozkLMOLx8Z7BijQNjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsKYYsk9ZrUOih6E88Z2ymHL8c17QMoQXZHj/c77SUU=;
 b=SGnySIgfGS+IxLxqMg5tAZnvps3jsEnpxf42jaDBmh7MozZqoEIED32SFkt+qz50D/dQNozIvAzIapxT3ww+ytEaPuefnWRWebsI4l/a2iRmFgHXO4mR3CBNVUItXesPDxkfBiNUseyDDXn/sjTPK2w4TgIsNR030/tGZpfqdnxyrGvWyQJYE1NGMdvIDFx4TLdJoWqPDkZXk6ZK8t+r20Dd70dCiGUH22GPxb7KiqiwA9UdECb5OMTLLVGXnl8HgQ3DlTKRNhIE7fMTNpdMulGa3wGfN62Zq0U8gS0+4xm1Dqxhw0mxC0DDI+yFN4gxloYv2Kq8VlOfLZkOLvszMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsKYYsk9ZrUOih6E88Z2ymHL8c17QMoQXZHj/c77SUU=;
 b=obxpjHgjLeTHsk7x2kdmiU1hgnbIE6x3Gk2BdtDSpOfjFINWmHU5A0EbxWvaFj+0GPvqUHqaGIp1WhvJueKjeYoqZOHnnnLIZt4rLGznPa4sXyFzwhYJzjXiOuoem5JG9ZGlPsFwskeP9oLnl+DmkIBdEYFjhHxL6y541O94OIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Thu, 15 Feb
 2024 22:21:44 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 22:21:43 +0000
Message-ID: <9bd6b12e-e5ba-48a1-8d01-4c886441f314@amd.com>
Date: Thu, 15 Feb 2024 16:21:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] pcie/cxl_timeout: Add CXL Timeout & Isolation
 service driver
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com
References: <20240215211342.GA1304889@bhelgaas>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240215211342.GA1304889@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:5:74::43) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d0813a-21b1-4cf3-bd99-08dc2e747d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eXjPdQpbV0j+nKZig+9knEWAeSE3k9KI5wErXibhXfaBW5c4H5D4hqXITh1f1A/YTrJDjYiL5uzk/7oxhIhoEN+yd2OjVg/Bgddw+2hEctWt8A3iMhP56c2iduBS4yItR+y68Gfji+RnZi6I+UJiPkN0vhX2k8CLwQXC8wKykg65oCV6+dyt1zXjUPx7GRAR0HtOSRrAbOQIi1p2UJOVqcvqAki1oyja/u124cHPDTZTwdI+1vH/mvXEqA9AViYRixQkrDqHaGXfj4Vdc9LhdrhU2bpvNblSmFg+K6tVDmxkIT4CaSojphGc6oLegIkgeC/f24OfJx/gBvVFHm1yqy4oSVeiRGlplYIsI4vzbD3EWvvQ+O9lfbytRqN8WcoY0eM6Osuc2RVpzptcC+UNaQL9QMuptcKBscX7bQoUEwYP4p+6cPoCraIBHiMVu6mdeVRpIJX+ypbs3IjDoAEq3uDiYkNSHENj9ABE2/x+CzMJWJxtY+fGbg3MGf3fBm/ulgwwOe2VyhrnQwYSjNAIp8J++YcVAaDShDZjWCESzx/PKdAeCG2GVDY3t1K9CyCj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6512007)(478600001)(2616005)(41300700001)(53546011)(31686004)(66899024)(2906002)(66476007)(8936002)(4326008)(8676002)(7416002)(5660300002)(6916009)(66556008)(66946007)(6486002)(6506007)(316002)(83380400001)(36756003)(26005)(38100700002)(31696002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm5uZTFBNlpYQVk1eitpalpGT3FZdjRWUWQvYTRiUURsYytKL1hnbkhqU01F?=
 =?utf-8?B?YVBmQlF0UEpncDVnZCtnTk5YOER5bng2L2hNTTlaaXJtUCtlMEtVMU5taU92?=
 =?utf-8?B?eG95d01zbE50TnFnZmFjc3VlOWFkNFQ1RDAreUNWb2RPaGswOWV1aWgwd0w4?=
 =?utf-8?B?TURVWTV1SlRyQ3JwVjJVeTI0bDdsL2J0SHV4SmNZZ2E0RUorejZzc202d0Ni?=
 =?utf-8?B?VXZjRS93ejlsbEtDR0I4K291cjRqMkhCOW9tRk5wZlJRYWNEZTc2YkZMejNy?=
 =?utf-8?B?ZURIa05hcUxJM09xRm9pRjZOaldwTUdSVTVVUm4rWk5rSEZyV1lTRGljbGZi?=
 =?utf-8?B?RlBrS2o4STlUZ0pYN3htSDVrZ05XSmtrRi94bGFCRXdTaG9nMnYxUVpuUmZS?=
 =?utf-8?B?TjJZeWtoaVhHbVVhRGhRVGxsODBoeWljR1c4QXVaQWhXczhhbEZJVGlOVHM1?=
 =?utf-8?B?eEE0K25TSFp6YlYwK0J2cEdSZFNoUGF5SkNXMS9EM0FjTzVaRXZ5RWpHZnNz?=
 =?utf-8?B?by8rVHpWUjJDMDYyTVNGVGV4cDk1MEFxN2RteHg4d0ZIZEw3VjVrTGZoRmYr?=
 =?utf-8?B?NDZnN2lXOHB3YU5saVFlNERGelFLV0RueW91OUdaUmNTeEt0K3ZKa0lNVWdw?=
 =?utf-8?B?aE4vWm8zNmpTNXhQcXNQeGVFM3JUR1NyMzBTRlUzM1pRbDFRdTNrZExBSElk?=
 =?utf-8?B?MUgwY2Rua1FJK2VheFdQUUxEV0NVdTFaSjI2cTR0a3grZE94b24ybWM1Wm5h?=
 =?utf-8?B?RDJucTV6MDFPRGtHdmtsc0syVnRTSWQzVGNvVDdJU3c2MXVUUWw1bHZHc1M1?=
 =?utf-8?B?WWo2Njd0dXJhOVpRb1A2SFdPcWp3a3VWUUZ3emFFNUt5cUFSSWRHVGlBY2ty?=
 =?utf-8?B?QVBWc1dhSmZmelRoUDVDajZlS3BNbFVvVDg3T2NnNHpQMnFJZlN1RXVGNG56?=
 =?utf-8?B?dndUTGxwVVJKOHM2QnNhbnoxd2s4a3hUeXpRODNISzF3NmlFWm5BT09CL3B0?=
 =?utf-8?B?K0VBL2srZ1pDRWZYeEtTNTF4cHZiay9BaGlIT2RqYm9xMWtpVWQ2cVpjZGNM?=
 =?utf-8?B?WjE3eGhlMnNpYllCUnJSTWlWSFRxUVhCSndhcEtTMmc2S01LSmQxQkUwUnBo?=
 =?utf-8?B?ZGc4WkFaTWVYUzZmNmMxbjc2R2JWT1RmejYwVXNxbXM0RXg3SFJEWHBiS2JM?=
 =?utf-8?B?MFFFMTV4RGNWV1dtN2ZpczhYZStTLy9lTTlXWHB3dS9mYmh1UGVoVXNsYWxG?=
 =?utf-8?B?N09Yb21LWGFMLzB0MkJycW0xcXFuT200dVNhbW9Jb000WFUxeGdLd1ZiZmxy?=
 =?utf-8?B?KzdJQnZrQm9kcWdoMFh5NVovRXhtbXBxd1V5WDNvWHM4TkIyS0tDRG92blJh?=
 =?utf-8?B?TE5uaTByaytmdFNmdU9FZVJoK3A2SkZsa213dUJwVElaMzhOQ1VjZmdqSjdz?=
 =?utf-8?B?MzFSSW1NUTRRZW9rQSsrc1dZWVFMbGEzaWhiRkdOejBWdis4NlhrTG1lTGEy?=
 =?utf-8?B?TUJuWFVhSEgvMktSZ0hFZzdza2hjK0dITGNMOHAzZW1Fc1VHMlptWDhzdFU5?=
 =?utf-8?B?VkZla005Qk55cXNQdGhIWC83dFJMRldaYStLZGhZTDJFQkRGK0JtTzRQeHNI?=
 =?utf-8?B?SzlzTEE4Z0VUWGtuVnczUUlaQ0Vqb1gxcG1BSXBRSHloM0dNK2FmL3dOdVI1?=
 =?utf-8?B?SDBTZ1J3c0lLTFRBaUNBQjFOK0tXVFZHOHNudXNRd0FuSitveVZCZG1hN0FU?=
 =?utf-8?B?V3JxNVFhZS9tTDlYenJSS1lwTngwUGZHM0pBZ3JreGNDYVphRVZ3c2RIRTVQ?=
 =?utf-8?B?MGd5Tmg3ZXExUXp2cmFVY0EzYjdWcjNSckZaNERsRTRXckxUY2JnL0Izank3?=
 =?utf-8?B?K1ZSK3ZucVlFWGhibkZDNFY2YzhJL0NTRjdoczVaU05iMHVCS1hVRUFmM2JI?=
 =?utf-8?B?OWszMnlqeFVJNVB1WkZPL2J4bDBkMWNmN01nZi9DSTd5Q28yK0RFZW1EbWJl?=
 =?utf-8?B?dVdzZ05mQ0FHMWMvMk9MV21sZmJyZWhkcGJmUWxxMUtITTdudEVtQ0xncm5G?=
 =?utf-8?B?K1ZEVGJoYmpQMHQxc2Izd3hNZXZwL3Nac1paME5SRmR2VGNYeHZxb1BpRlJT?=
 =?utf-8?Q?4+sqmSdF/rA11IihOtwkRP9t9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d0813a-21b1-4cf3-bd99-08dc2e747d6e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 22:21:43.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wP31X8JIVWZXkvKwdR0K0ZjSDewuS1Sal5GIOaH7qDxq2YcF03SgHSpfxKWxRDd0IXo8boompnlptpysIbaIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916

Hi Bjorn, thanks for the comments! Responses inline.

On 2/15/24 3:13 PM, Bjorn Helgaas wrote:
> Follow drivers/pci/ subject line convention.  Suggest
> 
>   PCI/CXL: Add CXL Timeout & Isolation service driver
> 
> On Thu, Feb 15, 2024 at 01:40:44PM -0600, Ben Cheatham wrote:
>> Add a CXL Timeout & Isolation (CXL 3.0 12.3) service driver to the
>> PCIe port bus driver for CXL root ports. The service will support
>> enabling/programming CXL.mem transaction timeout, error isolation,
>> and interrupt handling.
>> ...
> 
>>  /* CXL 3.0 8.2.4.23 CXL Timeout and Isolation Capability Structure */
>>  #define CXL_TIMEOUT_CAPABILITY_OFFSET 0x0
>> +#define   CXL_TIMEOUT_CAP_MEM_TIMEOUT_SUPP BIT(4)
>> +#define CXL_TIMEOUT_CONTROL_OFFSET 0x8
>> +#define   CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_ENABLE BIT(4)
>>  #define CXL_TIMEOUT_CAPABILITY_LENGTH 0x10
> 
> Weird lack of alignment makes these #defines hard to read, but kudos
> for following the local style ;)
> 
>>  /* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
> 
> Update to current CXL spec, please.  In r3.0, it looks like this is
> sec 8.2.4.16.  Updating everything to r3.1 references would be even
> better.
> 

Yeah a lot of the spec references in cxl.h are out of date, I'll update them
where I touch them. And I didn't realize 3.1 was out yet, I'll update the references
to that revision as well.

>> +config PCIE_CXL_TIMEOUT
>> +	bool "PCI Express CXL.mem Timeout & Isolation Interrupt support"
>> +	depends on PCIEPORTBUS
>> +	depends on CXL_BUS=PCIEPORTBUS && CXL_PORT
>> +	help
>> +	  Enables the CXL.mem Timeout & Isolation PCIE port service driver. This
>> +	  driver, in combination with the CXL driver core, is responsible for
>> +	  handling CXL capable PCIE root ports that undergo CXL.mem error isolation
>> +	  due to either a CXL.mem transaction timeout or uncorrectable device error.
> 
> When running menuconfig, it seems like both PCIEAER_CXL and
> PCIE_CXL_TIMEOUT would fit more logically in the drivers/cxl/Kconfig
> menu along with the rest of the CXL options.
> 

Will do.

> Rewrap to fit in 78 columns.
> 
> s/PCIE/PCIe/ (also below)
> 

Will do both above.

>> + * Implements CXL Timeout & Isolation (CXL 3.0 12.3.2) interrupt support as a
>> + * PCIE port service driver. The driver is set up such that near all of the
>> + * work for setting up and handling interrupts are in this file, while the
>> + * CXL core enables the interrupts during port enumeration.
> 
> Seems like sec 12.3.2 is slightly too specific here.  Maybe 12.3?
> 

12.3.2 is the CXL.mem portion of the section, which is the only section implemented
in the patch set. That being said, I don't mind changing it to 12.3 instead.

>> +struct pcie_cxlt_data {
>> +	struct cxl_timeout *cxlt;
>> +	struct cxl_dport *dport;
> 
> "dport" is not used here.  Would be better to add it in the patch that
> needs it.
> 

Will do.

>> +static int cxl_map_timeout_regs(struct pci_dev *port,
>> +				struct cxl_register_map *map,
>> +				struct cxl_component_regs *regs)
>> +{
>> +	int rc = 0;
> 
> Unnecessary initialization.
> 
>> +	rc = cxl_find_regblock(port, CXL_REGLOC_RBI_COMPONENT, map);
>> ...
> 
>> +int cxl_find_timeout_cap(struct pci_dev *dev, u32 *cap)
>> +{
>> +	struct cxl_component_regs regs;
>> +	struct cxl_register_map map;
>> +	int rc = 0;
> 
> Unnecessary initialization.
> 
>> +	rc = cxl_map_timeout_regs(dev, &map, &regs);
>> +	if (rc)
>> +		return rc;
>> +
>> +	*cap = readl(regs.timeout + CXL_TIMEOUT_CAPABILITY_OFFSET);
>> +	cxl_unmap_timeout_regs(dev, &map, &regs);
>> +
>> +	return rc;
> 
> Since we already know the value:
> 
>   return 0;
> 
>> +}
> 
> Move cxl_find_timeout_cap() to the patch that needs it.  It's unused
> in this one.
> 

Will do to all 4 above.

>> +static int cxl_timeout_probe(struct pcie_device *dev)
>> +{
>> +	struct pci_dev *port = dev->port;
>> +	struct pcie_cxlt_data *pdata;
>> +	struct cxl_timeout *cxlt;
>> +	int rc = 0;
> 
> Unnecessary initialization.
> 
>> +	/* Limit to CXL root ports */
>> +	if (!pci_find_dvsec_capability(port, PCI_DVSEC_VENDOR_ID_CXL,
>> +				       CXL_DVSEC_PORT_EXTENSIONS))
>> +		return -ENODEV;
>> +
>> +	pdata = cxlt_create_pdata(dev);
>> +	if (IS_ERR_OR_NULL(pdata))
>> +		return PTR_ERR(pdata);
>> +
>> +	set_service_data(dev, pdata);
>> +	cxlt = pdata->cxlt;
>> +
>> +	rc = cxl_enable_timeout(dev, cxlt);
>> +	if (rc)
>> +		pci_dbg(dev->port, "Failed to enable CXL.mem timeout: %d\n",
>> +			rc);
> 
> "(%pe)" (similar in subsequent patches)
> 

I wasn't aware of that, I'll change it.

>> +	return rc;
>> +}
>> +
> 
>> @@ -829,6 +829,7 @@ static void __init pcie_init_services(void)
>>  	pcie_pme_init();
>>  	pcie_dpc_init();
>>  	pcie_hp_init();
>> +	pcie_cxlt_init();
> 
> "cxlt" seems slightly too generic outside cxl_timeout.c, since there
> might be other CXL things that start with "t" someday.
> 
>> +#define PCIE_PORT_SERVICE_CXLT_SHIFT	5	/* CXL Timeout & Isolation */
>> +#define PCIE_PORT_SERVICE_CXLT		(1 << PCIE_PORT_SERVICE_CXLT_SHIFT)
> 
> I hate having to add this to the portdrv, but I see why you need to
> (so we can deal with the weirdness of PCIe feature interrupts).
> 
> Bjorn

