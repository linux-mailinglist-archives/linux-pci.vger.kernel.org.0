Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78154A9857
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 12:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358287AbiBDLYM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 06:24:12 -0500
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:4705
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241309AbiBDLYL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Feb 2022 06:24:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7HlJMSGE8oecttM3WFncyUmTdp1Rfsf2I9BU6GDkCR3x3DJfGZIxRYjCu8XqK13OPXp+ajwhzpRgR+QgUR2dDXgjmZo7UsS+eHK/SXw9Bz5VLseMgs5H8tIf0v7b5lKejnCiyJVTIPEifk+5qr1LvjSz0uPl5+ebegbKxTe8Yp6TbinRA1xB2QqS48RsDqPmgyOfcm+47uquyTaTBP1R6SIEthKNo0XW8HCiHPDWVltJOQBpiCg4hkIIuqD+qWnx60b+Tm+1jUS4o6ZjDcypxkiOUKry+78GYEY5YjETcscp3z2xstMFifMLmINLc8eFHQxxfS8hfmEAoIBan6wgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBR2JNt6DieatqpFxi0FXYFbPaor3RufKygb0kYBOlw=;
 b=O7tZkdlOeR+sfZvZew6y2qCz5KNf3AJGJ7vLtWVZwwan/juSuGf9dg7pTlYrMJK7j4qkYOmSX8wU5DJQgIIcsMKbulp2KgoIWQISvC/oQzDhjwcFvD6N1DlRb03OJO4CtAFTpb0CWsmnlHcDP0oq4EckIXVwBVprvoepDEHrXHVOehfx7Vn/DA2lyZ4AXxTmf1p3nNShW7m8UbLC+etpaLuSj5TFwmkHxqsPhItonLb72HQLlA2Y0oMljSRRM4k97IEHBDZIOF22hiGNmqx9sPGQHCY0HmTEdtyJ91yxFPgFlk7TMOLSknqYzZrMDSZf4Y1BPoB7jNUxx2ozDuJT/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBR2JNt6DieatqpFxi0FXYFbPaor3RufKygb0kYBOlw=;
 b=P7RyLXSY+KjDUtWjBN3K1G38eV1z/BwJMf48yiga02EI4uuEWN/4dHQjO5QcHWLj3lepiEXe1MD/cyfCiu2ISiNgVCujrBdvzWNDkd7fNAEP4k3qeRkFZY6qIsAYMNkJ9gqJNJfO1lxKrl2O5y9RGlM3Suwh8kB7fr5HZ8gPMjNj+/oIqEnHKu7DzTv5DOhEXtO909Begn4hmafENG2xld6sHMSFaIUuoXLEpVbxmemTx3oD1Pz1n6JaRjqVcG5enQ9BJ3Lq+nQO/cYauucLzfFiIpxs4tQxuBUa4Yceli8Q4/1uvV1sa4wjsW9rGhMiRJLezsSK4+jS+RzJXfg1pQ==
Received: from BN8PR12MB3156.namprd12.prod.outlook.com (2603:10b6:408:96::29)
 by BN6PR1201MB2513.namprd12.prod.outlook.com (2603:10b6:404:ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 11:24:10 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 by BN8PR12MB3156.namprd12.prod.outlook.com (2603:10b6:408:96::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 11:24:09 +0000
Received: from BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::c1b2:224f:101a:a588]) by BL1PR12MB5304.namprd12.prod.outlook.com
 ([fe80::c1b2:224f:101a:a588%5]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 11:24:09 +0000
Message-ID: <34868577-2907-2b7a-5919-444c5c2c6b9a@nvidia.com>
Date:   Fri, 4 Feb 2022 16:53:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, kenny@panix.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        kai.heng.feng@canonical.com, chris.packham@alliedtelesis.co.nz,
        yangyicong@hisilicon.com, treding@nvidia.com, jonathanh@nvidia.com,
        sagupta@nvidia.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220201123536.12962-1-vidyas@nvidia.com>
X-Nvconfidentiality: public
From:   Abhishek Sahu <abhsahu@nvidia.com>
In-Reply-To: <20220201123536.12962-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::34) To BL1PR12MB5304.namprd12.prod.outlook.com
 (2603:10b6:208:314::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f820d793-e5cf-4904-88da-08d9e7d0dc84
X-MS-TrafficTypeDiagnostic: BN8PR12MB3156:EE_|BN6PR1201MB2513:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3156E617CA9B246D9EB0422CCC299@BN8PR12MB3156.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //RxEFTLFvWxuKUk3GDFlobSOyxGacvw31m25RWaK+oktMWpG6Fo3MbdJ0ZrHKB7AWP3FzqS4+L7xL0xeSu1S9mawtSnnLWi2YRlQWiZWbqQuC0R9cLpgRNduf0QYNFBlAoz1KJEbiMYEP89fIDT1tCjbVC2xhy1Zqiah22XOMJLipGig47/2HNedHCAz2JlLoQixv1rVN6r90Tvw/6Ic12tRfwe1AjWa4bXRBht8mE3JGpJIQX+kxQU1GySGlGiKgg88PwT9UYmGSEufYPUE0ndM67gZm3I3qcSnA3lD54fFNVtHTCgPaJuPeqidotQcTeVZjJJOdEmg74Or7tH/5Q6K8LID/PeVFUYF5XqxmBvegXT70qtY21fEzpu/m3vyARkiUiiIWnI9p24V5937tL/1dqGU1v4Y1qcu/4H4PXoSdLScsm5L7aylo2SmPY+P4iXSbIKJn9QCUF2iQtRqf8kqREpTG+rxtcrT1Pqf2VvstJpIq95fUkEicFQ9RLItFJ6MqztwgUZ6SNBGGfeg8HMzAAY26c0dh6QpRiE5wzae8kBSTUkPZU/Q94V7K1mIPJYlcEc35iZWycGnWznG2+i0zbwK5rUjnhBpaJgnyq2tspc6kwasaQ7UVYo3p3xQnEsIx7Nk6bz/RS+uiP2VSVTE6DTVaDDAA0/PAFitahNZIcaPm8dJqj3vaL3N2cFeKGHbwcQBDX38Rrm9ZJjUePnSC63owlpnz9rTsNWThrDi4gxt5Ij+AhHEsYK+MNmFeLkcQpzG0AeIP6gAFMBemRKdMIoKE63kvL/OBmp/V71AiCTFAOpRDLFdsN+XLj17wqv2YuXOixdTzcIoifHBaH2+RFfeXoa5MDadWR9FpgtKlrOElkri5My81hBj3jytU3YaIdD7TpVUFRBCxAcbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3156.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6636002)(5660300002)(36756003)(6486002)(83380400001)(966005)(6512007)(508600001)(921005)(31696002)(2906002)(15650500001)(186003)(66556008)(31686004)(66476007)(26005)(6506007)(4326008)(8676002)(8936002)(2616005)(66946007)(38100700002)(7416002)(6666004)(316002)(53546011)(86362001)(55236004)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTBrUmdSdUdrMVpMUnUxQXcyNTdyL3dFb1oraVFMVlkzQi92U0NicmgrMnNJ?=
 =?utf-8?B?RzlZb1FWelFKSDNWQy9XZDdQZ3VCVjBZR1F3ejYrbkxvbzNYRDliZENaYUVM?=
 =?utf-8?B?Vk5GNmg4OGZzeG91djd5TXZ0a05SREJsdFhTRmY5d3pobmhEc3Z0ZWh5amRW?=
 =?utf-8?B?UzdqMXVIME9uV0FrRGZDOCsyN0xsRWh6bHdpb0dhWFlUVGZ1alJTMEpTVEh4?=
 =?utf-8?B?Z1RqU3FjZ1g3cDRvU0JkTExhMlRBUUZuY1ZKSjBwMGtvRVR3UG4rVGIxWFox?=
 =?utf-8?B?dDY4TlA2bFgzZlhibFJ3L3daNEJxbVhoanJDSzhBa0ptS0l2ekpYYnVINkhl?=
 =?utf-8?B?NGZvbkhyWUlna29BMlFwbGpmMTE4MWJUUUNYdmlSZDBITmZVcEZ5a0lwM3Bx?=
 =?utf-8?B?bG9VRjh5VDhuY2lZTEV6QVN2TkkvTVJmVFhIRzV5a0xLMStta2hmTWw3UjdR?=
 =?utf-8?B?V0dia0diTTNQSlRYM0dRTkNXT2RMUmlXVkhRWUVLczhzN3VhRGZrR2h3bVox?=
 =?utf-8?B?UmhCR2EvYXhmd2ExZ1lqTUVENFdvQU1TS2pxNWdjVlFYdTFUK1ppTERBZmYz?=
 =?utf-8?B?UVBTZldyVGg3VStkTEpJd3RGR2c3ZWxNQ2tscXpxcXhwSmc4eHI5MjgyZlBP?=
 =?utf-8?B?VUJER0V0NWk1aTJYUUF0aFNRaTdGY2lTd0hEUit6K0lSTkNndEt3VC9lcTFz?=
 =?utf-8?B?aXZQZ29JdnRGbUpFbEdrMUZHSlVKOHVEV2txRURJZW10aFRlMUdsSldjVnhI?=
 =?utf-8?B?Y1ZkQytHVWZ4N25aWXBXREIwcm4wbW5QZ2VXcXJxaDh6Uk1iQmtTbk9vWlh0?=
 =?utf-8?B?RXhRL1MwREFNRjl5b1N4dlhlMURLOHM1WWJZaGdOSWY2UlI5b0dmWDhlZzZ5?=
 =?utf-8?B?NDFtRnNmRjRWM0UxK0pqOC9PTXhiSE1HWDZVY1NLZ1lDOWpiWlRDTDc1OFVx?=
 =?utf-8?B?SnpHc09LREpyMG56YmhTeDZlZUtGWGd5TnU0Y3diRlFEK0FwdWNmYUZyVkha?=
 =?utf-8?B?MGhjWEFZa0NUUjg3aklyV1FCRms0eitDZUFWbGduVGdrYlRyQkppczZLYmMx?=
 =?utf-8?B?N3BOVzB4cVM0N1U2bVdac2FPbWpwWWl1RURrNkpQdFNtOUs0UU8xWkp4NEVr?=
 =?utf-8?B?cmwyanE1U29EbFBOcmVjUTRnU29HWmNEMHdJejIxYVQ2ZWZUOGxvTzFndjE2?=
 =?utf-8?B?aVAvTVAyb0lWTzN0Q1VrTTBrWEhQaU9yZGdxc0RDLzZ6bU9HSUpsaFNoT2V4?=
 =?utf-8?B?OW1EL0VnN28wS1VQM1JqRlZtQm42R21qak9lYU1HOXdpSDFmQzgzdzhDYnRr?=
 =?utf-8?B?c1J0Q1dxT24yVzZHUDduS3hqd0R3SG9OblYwbTd0VGhxWWs1cGx4K0w2VGdO?=
 =?utf-8?B?Wmx5ejNOT29EYXMvbkQ5aGJJUVRCUm5ReFp2Z2FtME1RT041OVYwRW1kUHg0?=
 =?utf-8?B?c1BVbWFBNkRicWZib25ZYWgrWFJwNVNNai9qL3YrM0dPYk5zVUdweDNqSno2?=
 =?utf-8?B?WHNIVmZKbmtNazl0d0FlNDg2Qi9hbEMvMys0YmtxNzlrbEsybHlETUNBNCtS?=
 =?utf-8?B?RlVJTUEzY3NiL0ZoWFVvckxBY1Bpd0pYSk42OTBxeFJ0RzBxczl4dW1GdTMv?=
 =?utf-8?B?Zlp2aFg2c254ZWdHREJOMWhXdTJ4Tnh4cVArbEVZUDhLVDgxV1puZHdIWFJK?=
 =?utf-8?B?ZmhqYzFNY1U2T2I2WVBkTUI0WEhJL3VBRU5FOHZ0VHNrVXZNVG9zc1ROQk55?=
 =?utf-8?B?eFdRS1F2VnMwMW9jOHBTdkU1bVNxaU1UWEJ6c013bkRVSVdCSlViOTREc2hs?=
 =?utf-8?B?RjNqM0ZCcnBxdDJqY1o3Vmg1SGQyVnZydnl6M2RieEhHQ2QzQkdFYkJHZ1cx?=
 =?utf-8?B?dnNrRmtKSDdKUUhXSlpyQUZuVU1DSDJ1WW1zTXI0cDY0ZnA3TnRHaVlvWjBz?=
 =?utf-8?B?RmE4MVZqN3hoaGVCYzV0SlI5VmE2MFNUZktvU0Fyc2Fpa2JnTExUdE5qc0k2?=
 =?utf-8?B?ZXlBWmtsdFd6K3NJRG5lTkxxeVRTOEZWVjBZYmFvT3l5VDBIZ3FIS3BHOW4y?=
 =?utf-8?B?dGF6UFJnSDRRYmR2K0hHUHo4OUpwc0xaVWs1REh1aTdhLzRpVnQvektGRDFk?=
 =?utf-8?B?VWNyME9FQ05UbzhBd3dmOHBydTFzWm9FTHNJdVV5THhHVFZ3c1dNWHk1SzJY?=
 =?utf-8?Q?cAi+JFcQGt1RWp1dKCuxp4w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f820d793-e5cf-4904-88da-08d9e7d0dc84
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5304.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 11:24:09.3198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EE7Xbei+mevd8P5Owryxtk4sYb40zRYRKEyDNK3+qld5DFmLKZfMZ4m+cHPmICRhVfdu6XtFzZnroCe+sfAhLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2513
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/1/2022 6:05 PM, Vidya Sagar wrote:
> Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
> saved and restored during suspend/resume leading to L1 Substates
> configuration being lost post-resume.
> 
> Save the L1 Substates control registers so that the configuration is
> retained post-resume.
> 

 Thanks Vidya for making this change.
 
 I have applied your patch in v5.17-rc2 and did 100 cycles of
 suspend/resume in a Alder lake based notebook which has 
 NVIDIA discrete GPU and it is working fine.

 After Boot:

 # lspci -d "0x10de:" -vvv|grep "L1SubCtl1"
   L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+

 After Suspend/resume without this patch:

   L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-

 After Suspend/resume with this patch:
   L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+


 Tested-by: Abhishek Sahu <abhsahu@nvidia.com>

 Thanks,
 Abhishek

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Hi,
> Similar patch was merged in the past through the commit 4257f7e008ea
> ("PCI/ASPM: Save/restore L1SS Capability for suspend/resume") but it later
> got reverted through the commit 40fb68c7725a as Kenneth R. Crudup
> <kenny@panix.com> reported disk IO errors because of it. I couldn't spend much
> time debugging the issue back then, but taking a fresh look at the issue, it
> seems more like an issue with the platform in question than this change itself.
> Reason being that there are other devices that support ASPM L1 Sub-States
> on that platform (as observed in the lspci output mentioned at
> https://lore.kernel.org/linux-pci/53d3bd83-c0c2-d71f-9e5b-1dbdde55786@panix.com/ )
> and assuming that L1 Sub-States are indeed enabled for those devices, there
> are no issues reported from those devices except from the NVMe drive.
> When it comes to the NVMe driver, the code at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c?h=v5.17-rc2#n3008
> has some quirks for some of the models from Dell Inc and I'm wondering if
> the model on which the issue was observed might need a quirk of its own??
> 
> So,
> Kenneth R. Crudup <kenny@panix.com>
> Could you please try this patch on top of linux-next and collect more info?
> - 'sudo lspci -vvvv' output before and after hibernation
> - could you please confirm the working of this patch for non NVMe devices that
>   support L1 Sub-States?
> - Could you please try "NVME_QUIRK_NO_DEEPEST_PS" and "NVME_QUIRK_SIMPLE_SUSPEND"
>   quirks (one at a time) in check_vendor_combination_bug() API and see if it
>   makes any difference?
> 
> Thanks & Regards,
> Vidya Sagar
> 
>  drivers/pci/pci.c       |  7 +++++++
>  drivers/pci/pci.h       |  4 ++++
>  drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..75a8b264ddac 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1617,6 +1617,7 @@ int pci_save_state(struct pci_dev *dev)
>  		return i;
>  
>  	pci_save_ltr_state(dev);
> +	pci_save_aspm_l1ss_state(dev);
>  	pci_save_dpc_state(dev);
>  	pci_save_aer_state(dev);
>  	pci_save_ptm_state(dev);
> @@ -1723,6 +1724,7 @@ void pci_restore_state(struct pci_dev *dev)
>  	 * LTR itself (in the PCIe capability).
>  	 */
>  	pci_restore_ltr_state(dev);
> +	pci_restore_aspm_l1ss_state(dev);
>  
>  	pci_restore_pcie_state(dev);
>  	pci_restore_pasid_state(dev);
> @@ -3430,6 +3432,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>  	if (error)
>  		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
>  
> +	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
> +					    2 * sizeof(u32));
> +	if (error)
> +		pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
> +
>  	pci_allocate_vc_save_buffers(dev);
>  }
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3d60cabde1a1..5de1cfe07749 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
> +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>  #endif
>  
>  #ifdef CONFIG_PCIE_ECRC
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b7424c9bc..2c29fdd20059 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>  				PCI_L1SS_CTL1_L1SS_MASK, val);
>  }
>  
> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
> +{
> +	int aspm_l1ss;
> +	struct pci_cap_saved_state *save_state;
> +	u32 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +	if (!aspm_l1ss)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u32 *)&save_state->cap.data[0];
> +	pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
> +	pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
> +}
> +
> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> +{
> +	int aspm_l1ss;
> +	struct pci_cap_saved_state *save_state;
> +	u32 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +	if (!aspm_l1ss)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u32 *)&save_state->cap.data[0];
> +	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> +	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> +}
> +
>  static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>  {
>  	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,

