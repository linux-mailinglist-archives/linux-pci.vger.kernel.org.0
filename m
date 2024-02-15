Return-Path: <linux-pci+bounces-3486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98C0856179
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 12:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5438F1F27676
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 11:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01584128382;
	Thu, 15 Feb 2024 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MLsQhn7f"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8253369;
	Thu, 15 Feb 2024 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996369; cv=fail; b=FaTm+z2lO20mrX5k2378zhZijABxIb5l0JvJut0nD++3n7w9xHXeSKB+J1XrPIWvZLAiZnnrStJjXypEUXlixViCr1S979ULlG3Hgy3faB2Gxj1rkZXnFnFonORfGIRo1uiH655XrozLYhnxC4KXVHg7YmoJOBLgyV9bRyk+VUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996369; c=relaxed/simple;
	bh=AuXX/Z7EStLabm7ld4XeFCvxOmPjyUvZxwKaD4v0l9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GGs9l0C6zoWFxMJqUijixeoy4OLr8t8B6+pCvMYeMJjOl3PhmXJUxrqZLj8zn9x57udJ85IChSdaWUJZsO0kHbpvcgy862+ey55FKx+aKoYPEuq8QGjkZlorYwO4IWERLMm1rZbWTwWVTTUojkPU9VYQfoZUgWKOy/8fkhznbB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MLsQhn7f; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IM5CPOHa3lPE+Q6htE+6kc98MHMlSiX2H7h/EMqiR+3wn8AgHCWRL+t3yNvmVyRLfdy6gU+T5ujUUy/u0EkUiZjBu8f4tJNPPD83aMYqiL0gl5qBCcFDLcafNyM5nvrSJclxvbBOgdQfTqVX1Eq3Q9oUFMTHzg1wvqY6J0wpTsJa8XlNFI8zqxwj6eQVyn7onkkZEuLKEft+Tr/gks+Zu2eH5+NhsnDcEhqOSn2dE9cjuu0F8X8vMssmteBVI55GJaf0lRt7wjvgt+FdJ6XgIal0amvoo4bjakK7povMWzDLO6hdW9EESqHFYd1/+XLze/KQAGSAccJHZ2QSp5nM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLgPQX0pJPCezfrcHy5k4d0b4WLCVJvdcQ9Aut+yoF4=;
 b=TYF2wmB7724cmfNFMvTpKt0VrQGDCtS/ALpdD5/OTBXh3wBuNuuixtA5y9LuEycRDAmJ+IMU2vsNUkcioGnlzpH5lRf8D5SVWpXW0B2cC4sTVrzohWO8YkX0MHX4u7rNe/LsYXFf4Nw3iu3Fy7/sjsyjp6ucJ1GDrF2SE0fmFVKB+atdLjKIpH2ToycZ7n2fjSWXy7Kor289xoyAXPeUA6ejTM/sgAoWyM7m5HuSyUzFKIUSdiFtoASStmb7jNUkXAl4V0rTSokg9PpxlJffYJ+CHUwhDTSdIyI8sWog6jTud1YwNS7Mm7bKmpB2ZLiU/62ynU+sdamRBP1cIC6gHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLgPQX0pJPCezfrcHy5k4d0b4WLCVJvdcQ9Aut+yoF4=;
 b=MLsQhn7fdX2ZUZ5Tp60U57upwxlfnib2yoCfNxCctA7dgtjRAMr9A5eoGbo8DUgtNN8OXIEKI3DCJa/Rn3TCL74ljV0FgsAABW3Y75QJg7DY8LpVaeos4TD7s8dpvRAVL+1rmrWR9tIQ3fV2OKMLN2ULb0eWWu3TtDK8qJy/neIAVsPEOrPy/GM7WR0TO4clAzXhCPfoa5u1VAaM9FBu6wQNO8znISwBmJtThh/GYhom7DgrDxl8YACldRP7K49WXdIdCz416tDxGaLS32cYszpKcWfoHJUcks2gYjyZd3lagGB550g3G3uW6/KYzx907vPPwURXaOIbkk+eyczLSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:b7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.11; Thu, 15 Feb 2024 11:25:59 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::ad63:96df:9a9a:83e4]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::ad63:96df:9a9a:83e4%5]) with mapi id 15.20.7292.022; Thu, 15 Feb 2024
 11:25:59 +0000
Message-ID: <17dadf66-055c-4796-a905-44e37b6fcfe3@nvidia.com>
Date: Thu, 15 Feb 2024 16:55:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 13/13] PCI: tegra: Add Tegra194 PCIe support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, bhelgaas@google.com,
 robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
 jonathanh@nvidia.com, Kishon Vijay Abraham I <kishon@kernel.org>,
 catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
 jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, digetx@gmail.com,
 mperttunen@nvidia.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240214191249.GA1263222@bhelgaas>
Content-Language: en-US
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20240214191249.GA1263222@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::13) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|DM4PR12MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 394e01f4-36e1-4c7f-b780-08dc2e18e201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aDI9/cS4KGgBDoQDKGIyC3STbkrh9sGoI1enyvAiDzrAfmlOcgO2T/SuJ/WlQ+gJ37xwCg4+0jFDNdHbWLBGCQv8liK03XDOlqlSbZ9HaPO3eFr4YFBGWSVU0uT94JcbqnhiCNa+kSH48382WHPS0KvmQ3/yApUC5xIYGmvDHfq/KBMAOKo5GmH4VEp554uFNDhDNioRsVIOcWTwU12RdjiN2rrZYm7lvNMpeDOqMlze/871q9eMTmKbYzltC3Kc/OK2VDrukJuBIEF6Lk36FPg6OfilzMLqgaNpUWe6RHljaYvEr9avXnJTQ1ENDaLy/plyS0rkUGyvawvPmPsu6IQ1QouXpTk86E04LVJD3rkdl9DrL9GaX6RDa2wZiCd7ODmXEktg8q3uufiFsV8bPvOddvJc25af49tENenH88qcqgJz5Zp+NyXsoUB8QZPdI4CRvM5oBuseivuzrwPs86qcNFjIX1b0aidmBX64OMY9cCz5d09ASri3oKxPG9cyJvumF0Hu+YYUW2esVE3+3bzZt3xjE5bQ5WeTP5ZhqQtGAjJfWAkGXfcSMHuMteBa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(366004)(396003)(230922051799003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(66946007)(2906002)(36756003)(53546011)(478600001)(66476007)(2616005)(6666004)(6506007)(6512007)(26005)(5660300002)(7416002)(66556008)(6916009)(4326008)(31696002)(316002)(8936002)(8676002)(86362001)(54906003)(38100700002)(6486002)(83380400001)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHNuTW1TOGpqRzFyU3Q5TXY5VE1kTGd6RDdIZ2FLblE2VkJidEZHejBkYTZG?=
 =?utf-8?B?cFkzZnlRbWYxZDVYSSs1Q2tkZENFb0g3WExUb1c0Z3RzQ1VvMWRjeCtKdTVi?=
 =?utf-8?B?SDNVNDh1aktrd2hsWHl3Q1RTOWxXN29qb1haRTBKQ05RUmFLSlU5R2pCcENm?=
 =?utf-8?B?b0F4Y2NKWGFOUWVJTWpkTTNBRFVYRzNLV2NleHNmQW93TjZ6L0xHM3ZPRm1J?=
 =?utf-8?B?ZDl1RDdBbHJ3dU1NQll5amd3T2hOMEh5NGRISHJYSDV3NWtMYlZLUjdEMUs0?=
 =?utf-8?B?N3JFRnlPL0YyYk8zemM3NCtOT3laQ1NjQ0V5WmZsdjRyaXUvYlBPSlJWQVVk?=
 =?utf-8?B?WjhaZkRvUVMxTXFJZ3ZWamVGZStEV1NVZGVtRllqZUhhb2VlWnJxRHhZSTVq?=
 =?utf-8?B?emRRZ0tNRmQwZElhOU0vcmpxV05NaFZwUnZHZXpscXUyS2RwMjJ6ZmNSSjZw?=
 =?utf-8?B?Ny9ZTHhJZzRBZU1TZ3Bab2RBZ2RxVjlpM2djdWFWa21TTlJIRmN5bTFMdEcw?=
 =?utf-8?B?YjBIelVRQjVxa0VQZElLdWVFeERyOHpEQm13UUs2a2IyQkRJUGluQThDMm5i?=
 =?utf-8?B?eXhTbWdMdFVuWjRaWWZDR05mMFcyZisyQmNwT2MvdFI0alpvWFA2RlBWZXpo?=
 =?utf-8?B?djdSTWVjNXdhT1hyL3NXY2RtUnY1WWswaW9YcXp3MkxpOXMwSHRPbE5KU0x2?=
 =?utf-8?B?UWhOMTJNWHNXTkhBNHo4SUJITWxCK3l5cnZRd2hsNUVubk40dVJCSjhwL2g4?=
 =?utf-8?B?TkRHQ25ZcHk2RFk3ZEdYOHk2VGs0ZzI3ZEU2b2l2S1Fwd2JtbzRLV21QZ0lI?=
 =?utf-8?B?K09xY0RmS2srT3h0T0ZySldVNC9FSTdRQStiRVRzRzROUVhtOU9RWkFIek93?=
 =?utf-8?B?Sk9VY1BuWml3Zk1tS1ByakRXVENYUnhBSnk1eTFGQ3FKQWE0czU5cDdoS3Z6?=
 =?utf-8?B?OUUxVEFpUVVmS1hkbHRUM3U5d2lBb2JNdHZ2T1hYNDdCMy93UUY5U0JLUE1h?=
 =?utf-8?B?cFBGd2s1aG9mZWo1OVp2bU8zZlRWcGpkSDZabDNVV3dzSWpmZThkZExJL2gv?=
 =?utf-8?B?aitWTWVHNks4TFdOdGlyL0dkL29IMU9ZanozNitORHdkNVdGbW84UVo1ay9q?=
 =?utf-8?B?cjZvU3c0eHloRzhuUkI5WkY4NnZzU29FbUN2L0gvTDRSL3IwaVZpN0hhdDdK?=
 =?utf-8?B?b2puVWlFa1l6R01Wc1dZL3llYzZ6VFlWL3c5cVNoOFE1WnBOeGpKRmJ3MldR?=
 =?utf-8?B?aDZkbjB6a2V5SGUzL1lVYXVvYllpdW1GT0FyRHJUbkhzNVdTWm8vT3A4U0RR?=
 =?utf-8?B?WW8wSHp1MTAvYmtJWmttSG9rM1plQjQ2bjNTMk1KZjRLRnZvK29meWpJTGZh?=
 =?utf-8?B?VXRINE14bkhFWGRoWmxQdGtSWndzRk1ZcGw2MVM2Qk1BblU4NFpTNWVJU3dB?=
 =?utf-8?B?VVNyT0hDdm85WGV3NmpPd2hJeHMyMkJZWG43NVk4OFhldS9nSHhENFVqWjV3?=
 =?utf-8?B?bnhLRmlmZE02Ky83Q04rREhkOG82SHMzUXAyYW5TQWxwL3h1TDJQT1lHY09S?=
 =?utf-8?B?bDFmUFF1aDI1S0lUQlIzaGMrS0gvcWlyRSs2d2V2dUp3Z3JjTWR6UDJOTHZW?=
 =?utf-8?B?L1FjUkZWSVRHdkxjMDQ4b3hxTzhOWE9ER2piOVpWTDhxK0N4Tk5PaFhEODJx?=
 =?utf-8?B?Qm9wdnoyblZaQzdxVlNNUDVsM2hrUjJoa2ZWMmEzeGpOblVhQ2VXdzFGakxF?=
 =?utf-8?B?R3BBYjVQMy9QVmN5SWtRWE81d09TMGU5blhrUzNOOE4xMUlwWi94YXYrenJl?=
 =?utf-8?B?dGtpczMvVmdTU3lmRmNpNlFUaEQ1bHJiSDJPOFpsN01QNk5QT3JiaDBJNXF2?=
 =?utf-8?B?L3ZpQjNNeHYwYml1YUdTbnNXWDArb3NoVFFTeXFjUDlUanhRcjVGbUkwVlhU?=
 =?utf-8?B?Ym9PSm13ZEx5UXF3bVVXS1hsaGJKa1VWcE1Dd1JnL3VlWGdSam1VTGIwMllI?=
 =?utf-8?B?NG03Umg0K2l4bUJ5WlBrYVpvd0lZMThTTXRrZzZPclJwWnEvSXFqZEthdjd0?=
 =?utf-8?B?SVNtanA5eVAxb3YyeTduUFNtbE04TjdCYWZla3FyWVpLcVo4a0RMbERnTHVm?=
 =?utf-8?Q?ZzoIFDAcoMaSr8wjg3QswyqUp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394e01f4-36e1-4c7f-b780-08dc2e18e201
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 11:25:58.9251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urtg9EGQwTj1iO0BEOirQTQg2ogPTIdVguHBs7L+JNLwfuTF9fwC7zxB9ALxrzYS2L3jvxpWoACxyx94kJoRiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661


On 15-02-2024 00:42, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Vidya, question about ancient history:
>
> On Tue, Aug 13, 2019 at 05:06:27PM +0530, Vidya Sagar wrote:
>> Add support for Synopsys DesignWare core IP based PCIe host controller
>> present in Tegra194 SoC.
>> ...
>> +static int tegra_pcie_dw_host_init(struct pcie_port *pp)
>> +{
>> +     struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +     struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
>> +     u32 val, tmp, offset, speed;
>> +
>> +     tegra_pcie_prepare_host(pp);
>> +
>> +     if (dw_pcie_wait_for_link(pci)) {
>> +             /*
>> +              * There are some endpoints which can't get the link up if
>> +              * root port has Data Link Feature (DLF) enabled.
>> +              * Refer Spec rev 4.0 ver 1.0 sec 3.4.2 & 7.7.4 for more info
>> +              * on Scaled Flow Control and DLF.
>> +              * So, need to confirm that is indeed the case here and attempt
>> +              * link up once again with DLF disabled.
> This comment suggests that there's an issue with *Endpoints*, not an
> issue with the Root Port.  If so, it seems like this problem could
> occur with all Root Ports, not just Tegra194.  Do you remember any
> details about this?
>
> I don't remember hearing about any similar issues, and this driver is
> the only place PCI_EXT_CAP_ID_DLF is referenced, so maybe it is
> actually something related to Tegra194?
We noticed PCIe link-up issues with some endpoints. link-up at the physical
layer level but NOT at the Data link layer level precisely. We further
figured out that it is the DLFE DLLPs that the root port sends during the
link up process which are causing the endpoints get confused and preventing
them from sending the InitFC DLLPs leading to the link not being up at
Data Link Layer level.

PCIe spec rev4.0, Rev 4.0, ver 1.0, Section-3.3 says that (verbatim) 
"The Data
Link Feature Exchange Enable field permits systems to disable the Data Link
Feature Exchange. This can be used to work around legacy hardware that does
not correctly ignore the DLLP".

Based on this, we added the following code to retry link-up with DLFE 
disabled,
only upon confirming that the link came up at phy level but not at the 
DL level
in the previous attempt.

Thanks,

Vidya Sagar

>
>> +             val = appl_readl(pcie, APPL_DEBUG);
>> +             val &= APPL_DEBUG_LTSSM_STATE_MASK;
>> +             val >>= APPL_DEBUG_LTSSM_STATE_SHIFT;
>> +             tmp = appl_readl(pcie, APPL_LINK_STATUS);
>> +             tmp &= APPL_LINK_STATUS_RDLH_LINK_UP;
>> +             if (!(val == 0x11 && !tmp)) {
>> +                     /* Link is down for all good reasons */
>> +                     return 0;
>> +             }
>> +
>> +             dev_info(pci->dev, "Link is down in DLL");
>> +             dev_info(pci->dev, "Trying again with DLFE disabled\n");
>> +             /* Disable LTSSM */
>> +             val = appl_readl(pcie, APPL_CTRL);
>> +             val &= ~APPL_CTRL_LTSSM_EN;
>> +             appl_writel(pcie, val, APPL_CTRL);
>> +
>> +             reset_control_assert(pcie->core_rst);
>> +             reset_control_deassert(pcie->core_rst);
>> +
>> +             offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_DLF);
>> +             val = dw_pcie_readl_dbi(pci, offset + PCI_DLF_CAP);
>> +             val &= ~PCI_DLF_EXCHANGE_ENABLE;
>> +             dw_pcie_writel_dbi(pci, offset, val);
>> +
>> +             tegra_pcie_prepare_host(pp);
>> +
>> +             if (dw_pcie_wait_for_link(pci))
>> +                     return 0;
>> +     }
>> +
>> +     speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>> +             PCI_EXP_LNKSTA_CLS;
>> +     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>> +
>> +     tegra_pcie_enable_interrupts(pp);
>> +
>> +     return 0;
>> +}

