Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE92C69933D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 12:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBPLhN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 06:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjBPLhM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 06:37:12 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2110.outbound.protection.outlook.com [40.107.93.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE1C4392B;
        Thu, 16 Feb 2023 03:37:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp7CvKNNs/Gp1IUwv/YuRsLNUTo9v01o+SJbVmQr9aHfuX91hXXG7N/QqeIXFViOpriGQmrciHS4KgcgV+l1iLf4H9pYhWLbtBKILzNAp4B9uqL+FH0Uf2hjmwffwsn4WDGWdBSzceWquDh99XR3z4DjHczQW4BMzkjK0rXNH50MPhWvNEoPOCb8mOrfcWx5moUcej3ndbRnp0PQYuJLj5OReelGvMiEU47fIiCIy2ROYvRb+MXCRA7yKzHHrQN6KozIaI/EaReJ6eELzeqVUFQXbxq6dgxwkpS8+svJdxFKInzBqtRB6SAG2Xpygd0hxPLqivxxJP9oiULDJGnShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVoGVxFtljYpomKj1eIQhqoB4asBsT4gazb5oUGDGCo=;
 b=eAnJDl1qJrvBk91eGzHqWpief/CZjPHMiV74sXzV9gZXm+bSyUGaa7xAu7in97CQ635n4lJ8tW8liSkG5lY9dlQ9ufdI+frabUPiLKeinLD9fqcNDyvlN2sgNfy8ebuw/Mg25PcELt7MMj+9TG261O7jrIBtffYXUOcPNl7Z8B0UPApiLcAKGTInWpMljhH0sGhkGtlU6DkVX+Gpw2TvGhQ6Q7G7vWaKS7OJGfWetjLCb+AmTwz72L2yU+VqbE01SH3YI3Im+tXVwwFpsUW2Ui67T/7YG/LFocm6wqbpqYsh6xlqm4XAzXvHPAyiyy8t+2HRDAtT5gHqlloIWXeVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVoGVxFtljYpomKj1eIQhqoB4asBsT4gazb5oUGDGCo=;
 b=Zpz33dzx89292TirzOjtqQsj2F/t5/G2TEI54DMmtJFo7gbeYftB2oye7SCYSnMZounvg4pTzi7wV1uAlVryZj3oINezVj5A2nsnVy9eu5rQrrJQigoK7AfyhRkxSyY8+lTefqTHzrkLZr+//JOCAveugkCvQ9EMkK7gIu6xIwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 SN6PR01MB4029.prod.exchangelabs.com (2603:10b6:805:a3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.13; Thu, 16 Feb 2023 11:36:57 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%5]) with mapi id 15.20.6111.012; Thu, 16 Feb 2023
 11:36:56 +0000
Message-ID: <3877b6fe-2b7e-3e0c-8b69-65e84c09cdd2@os.amperecomputing.com>
Date:   Thu, 16 Feb 2023 17:06:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] PCI/ATS: Allow to enable ATS on VFs even if it is not
 enabled on PF
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <Y+ksmNWJdWNkGAU9@unreal> <20230215205726.GA3213227@bhelgaas>
 <Y+4PmJb2rBGMhS1y@myrica>
Content-Language: en-US
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <Y+4PmJb2rBGMhS1y@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:610:e5::25) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|SN6PR01MB4029:EE_
X-MS-Office365-Filtering-Correlation-Id: fe293ba1-dd45-4c2b-925e-08db10121bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2e3c86z8oTcXnlhYl4t08cSDFCzxkYfxLpJi+e6WIzYuZp55acCIAK1/SiO7dxKX+nvrJQp8i/yLOPzKtFlPYkvFN2iUmCE4SQkiUkg9Fd+pKoKjjUaMCgwQujAGm+SO4bly6GTEd0ZX/j28xdnDgIQqFdUPFsCPiPlaCFRfG6VJBovngMyvuevLsR57ayCBMSJEh7raXeCa+8/t8zfnXYJNXmqx4teasuEO0btX8RInWJnCodE7GKce8h02w9mA2jfQ1z+Lw358iCQjRKZobmARuxNMFDJycXUS8WVuwQPZCjFzLSCHhYha/L35UO5jPlTUor/f0jAGNjSB3RISmGU0joZaZ504ilZEhJYHCEdMHucvnXXVD5XpW517egFhYTPBU0ZlgfR+Of54RqxBooq8bFHn8uVAb4aBk4VtKGGCKw2AtW5UeMPWSi14CoseO5EuqnH3gnOciQrbKb3CwUe1+rZhAL5E7zteMqumxULkk2HrSHrIReUpuYu0AvVJFTMvSWVRXlkk4Saglg2f4hD5RTT0esLjngwx8IMRmnXvuWIFpAevdpXKoYjKzZaAadnxROqRVhCSUjaSYl+djpGW53lZIWMmloV0c5vEe7sPafEcwAjaevDmH/aDdFP8ucc4a3b+b9ylM2cXk5hbQ2X08zeZVOMA3Lf+XOCE60/w2d4vu71K5WYvTI7ATdV3eLbxZIMILqgfF/1nVCYbAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(346002)(39850400004)(376002)(451199018)(2906002)(83380400001)(86362001)(31696002)(2616005)(38100700002)(66476007)(8676002)(66946007)(66556008)(54906003)(110136005)(316002)(8936002)(5660300002)(7416002)(4326008)(41300700001)(6506007)(6666004)(53546011)(6512007)(26005)(186003)(478600001)(6486002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnVNLzZlc1d1UGRldXMvcWVTTVA0c3QyMTc3Q09yUk5kWlBnN0llb1VWL3JK?=
 =?utf-8?B?bUlSWW10TkdJalFOYm0vTkh0cjFlbk95TmJEbmNMMHlJTDZGSXhnOU5iVHY5?=
 =?utf-8?B?U3JOZmZoTitDT0k1bXEwUjNoQVNrOE9nWVBPVU85YmJrWWtZdlQ2THd0dnBU?=
 =?utf-8?B?QUxrRklQWkxROWE3ckRGbENGUy9pSEZMamlpeWRYK09uWHBydGRmNDdnQ2R4?=
 =?utf-8?B?c1ZHK3hYeUFicUpDTHlkSHBoWTRRRk5pWUhiTFhIUC9MY0EyTlJmekp0d2JM?=
 =?utf-8?B?MWsxTVBYQnUxMkVLWU9JOWczYkUyYkVtNyt3blJ5QmZrMW5kcVhWWDN2U0tN?=
 =?utf-8?B?Z0E0ZCt3S09pbkJzSlhWbS9HYWp6WG9LZElXUGROY0VUR2V4cXh4TFVtOWxq?=
 =?utf-8?B?UlpSczltb09XeitKVmg2aTV4dm9iUlFNRW5xTklRT2ZZVHo3T0tsYy9iYW1q?=
 =?utf-8?B?U1V2aXRCeFZaK0p3Y29yV0ViQ2ptU0E3SEZiREZ5K2pVWU9vdkdXdU5uY3RT?=
 =?utf-8?B?UDlVaFo2SDZEdzREdWdCUy9wQTUreTlqUzVvVjV6MEVEbkVVWW9pWGNmL0gw?=
 =?utf-8?B?cjYwT3hqbEVlaktSbDI3RmR5NlhpWDMrM3pZUmJxNHdEbzFMWHpTTitOQ2hr?=
 =?utf-8?B?VjFVcXFXNFpiNG5EZ0RsN21KWE5iN3duZG9SUm03emJUdzkycENVU0orek81?=
 =?utf-8?B?U2RhelJDOStia2tKTEVCQW1BK081YmhGT25EdW5mY055TnBoQ3RxRTMyNy8z?=
 =?utf-8?B?SmlZYU9laThSLytUMDJCUjdOQ1NOQkhFdnhvZjg1OXpzaDl5QVhwZkV5RTNP?=
 =?utf-8?B?Q2U2WlQ5SlNENlJmR1dBQUZkbytqa2R5SmpFNVRIQlBxenN5L1lXQmlVc01Z?=
 =?utf-8?B?RGpad0lBVUk0Y1Q1R1VScjlZMnkvQ3RnTXpQWHFaQndEcDIyNE5LZy9rZXFo?=
 =?utf-8?B?Zmw3LzB2by95Q0pVYXF6elJsUFhiZXV0QVZCU1lXN3M1Z3p1a3JGRTQ5Snh0?=
 =?utf-8?B?M0txS1pGTnBZYnA4OEhEZ2FJZnFoQkVWb2lCT1RISkh1UmtZUTBaelVtNGRL?=
 =?utf-8?B?U3RieDBhdDQxa1BKWXZjaWdQYXpVZnRXQzVHT1hiMU1jZTNNVmRZamVVK0U5?=
 =?utf-8?B?c045dGY1WWVZQTB3L0xnTmNMdUxCOEFVaEZpbjBZemd6Z2U5SU5uL3VOOElF?=
 =?utf-8?B?TW01b2Y0b3l6L2JHRXJBdXptZUNpNnpKeEM4ckhIMlhncUZ1U3U3eWR2dDVq?=
 =?utf-8?B?MExhWFZJeFRLSDJOK0RVVEhjQmRtZjExUGdURVdjMmUzTm1NcVFXZ3FFRW93?=
 =?utf-8?B?bjliNWl0TkFjUVBDMDU5M2kxK2xTZ3pHTkdsTTZyVC8wTnhrNWJuM1JuU2hY?=
 =?utf-8?B?czkxdmtxSFZCSzJxTjlaSUd4Sk9nZG9WN2VWcVlSeklUcmtNTlJ3WVpjdWNS?=
 =?utf-8?B?VlplN3lGL3JnOXBaT1Q3NVc0d2taRHMraFJxTXR1UEpKMHFqNUZhY1FzUm1W?=
 =?utf-8?B?ak4ybm4wSElUa0drSHdBMDFCNTQvbWoxWUpGdlhvQzA2QTZRalc4QWdWVldM?=
 =?utf-8?B?WEhxQnZqUXZleThYcmlvRTN3WVFnVVJ5T1haZDRVK21hM0tVczdoMGloa3li?=
 =?utf-8?B?QWtnZlc0U2xRYzVTNk84T3A2SjV6WWF1YVhwN1RSKzMxTWthS1EzdlpIZFhC?=
 =?utf-8?B?UGJqb05XK3Uwa1VoTmhPOUR3WXlnNWpPQ28zSDVpajl5MmM2aWhWUnhJbFNl?=
 =?utf-8?B?bGl3SW10V1B4K1UzZmdHOFh5WFR3QnBwc1ZZSGw0b0svR0ZxUVBCdmNYQkFJ?=
 =?utf-8?B?RHNaVmRqTGRuUFFrTGREUWNVRUxid0N1dVRBYXpQczdMazdhdk40QTJqRy9p?=
 =?utf-8?B?MTJQeXV6WlpBVHc0cmxxS2Q4YmpqLzQ1dnBIcU9vVG4yZXpwWG96c2FVbTAw?=
 =?utf-8?B?NGUwZ2hIV0NxalZkSTArY0d0ZnJSYXQ3SmRpWjk3b01OVVNpSHdraGVMbExt?=
 =?utf-8?B?NzdiNGd3VUM0MjYwVnRRQ00ydU5tZVhzVVVrRko0VlhlVWZML3pNR3BzTFpz?=
 =?utf-8?B?S21JUVZrS3NseUN2QTVZM0RRR0JkeEgyZFNLbXpKRTN1QklPOU4rdWY0YWRQ?=
 =?utf-8?B?N2Y4L0ZFbXVyTUpFdVVQcDlTbWk2WGp1emVmR3MwZFdIcjBKTS83YysxMkhU?=
 =?utf-8?Q?SzsMj/P8kjBFTH2zi434c9+Ycz2EcMCKCnl+9oBhIoHZ?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe293ba1-dd45-4c2b-925e-08db10121bd8
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 11:36:56.6628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4X2cCmsV5Jvm1TZmWqoqGsJrPhTHbmmyQva+/PtaFRrIlF8AVkE+6mKeRaAHTA6K3GRgEYN2IDkXOKsK0yvfDjB2+U1y542M2xpj8bW9j27A7j9zxnh9GdPqxgHV3Eg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4029
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 16-02-2023 04:42 pm, Jean-Philippe Brucker wrote:
> On Wed, Feb 15, 2023 at 02:57:26PM -0600, Bjorn Helgaas wrote:
>> [+cc Will, Robin, Joerg for arm-smmu-v3 page size question]
>>
>> On Sun, Feb 12, 2023 at 08:14:48PM +0200, Leon Romanovsky wrote:
>>> On Wed, Feb 08, 2023 at 10:43:21AM -0800, Ganapatrao Kulkarni wrote:
>>>> As per PCIe specification(section 10.5), If a VF implements an
>>>> ATS capability, its associated PF must implement an ATS capability.
>>>> The ATS Capabilities in VFs and their associated PFs are permitted to
>>>> be enabled independently.
>>>> Also, it states that the Smallest Translation Unit (STU) for VFs must be
>>>> hardwired to Zero and the associated PF's value applies to VFs STU.
>>>>
>>>> The current code allows to enable ATS on VFs only if it is already
>>>> enabled on associated PF, which is not necessary as per the specification.
>>>>
>>>> It is only required to have valid STU programmed on PF to enable
>>>> ATS on VFs. Adding code to write the first VFs STU to a PF's STU
>>>> when PFs ATS is not enabled.
>>>
>>> Can you please add here quotes from the spec and its version? I don't see
>>> anything like this in my version of PCIe specification.
>>
>> See PCIe r6.0, sec 10.5.1.
>>
>>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>>> ---
>>>>   drivers/pci/ats.c | 15 +++++++++++----
>>>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>>> index f9cc2e10b676..a97ec67201d1 100644
>>>> --- a/drivers/pci/ats.c
>>>> +++ b/drivers/pci/ats.c
>>>> @@ -67,13 +67,20 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>>>>   	if (ps < PCI_ATS_MIN_STU)
>>>>   		return -EINVAL;
>>>>   
>>>> -	/*
>>>> -	 * Note that enabling ATS on a VF fails unless it's already enabled
>>>> -	 * with the same STU on the PF.
>>>> -	 */
>>>>   	ctrl = PCI_ATS_CTRL_ENABLE;
>>>>   	if (dev->is_virtfn) {
>>>>   		pdev = pci_physfn(dev);
>>>> +
>>>> +		if (!pdev->ats_enabled &&
>>>> +				(pdev->ats_stu < PCI_ATS_MIN_STU)) {
>>>> +			u16 ctrl2;
>>>> +
>>>> +			/* Associated PF's STU value applies to VFs. */
>>>> +			pdev->ats_stu = ps;
>>>> +			ctrl2 = PCI_ATS_CTRL_STU(pdev->ats_stu - PCI_ATS_MIN_STU);
>>>> +			pci_write_config_word(pdev, pdev->ats_cap + PCI_ATS_CTRL, ctrl2);
>>>> +		}
>>
>> For reference, it is this way because of edc90fee916b ("PCI: Allocate
>> ATS struct during enumeration").  The rationale was that since the PF
>> STU applies to all VFs, we should require that the PF STU be
>> programmed before enabling ATS on any of the VFs.
>>
>> This patch relaxes that so the PF STU would be set either by (a)
>> enabling ATS on the PF or (b) enabling ATS on the first VF.
>>
>> This looks racy because theoretically drivers for VF A and VF B could
>> independently call pci_enable_ats() with different IOMMU page sizes,
>> and we don't know which will get there first.
>>
>> Most callers supply a compile-time constant (PAGE_SHIFT or
>> VTD_PAGE_SHIFT), so it won't matter.  arm_smmu_enable_ats() is
>> fancier, but I *assume* it would still supply the same IOMMU page size
>> for all VFs of a given PF.
>>
>> But it's still kind of ugly to call pci_enable_ats(dev_A) and have it
>> muck with the configuration of dev_B.  Maybe we should configure the
>> PF STU (without enabling ATS) at enumeration-time in pci_ats_init()?
>> Is there some way to get the IOMMU page size at that time?
> 
> Not really, on Arm the supported page sizes are discovered when probing
> the SMMU registers, which may happen later than enumeration, during module
> loading.
> 
> What this patch is trying to solve is:
> * want the PF to bypass SMMU translation, and the VF to undergo SMMU
>    translation (in order to assign it to a VM)
> * SMMU forbids enabling ATS for a configuration that bypasses translation.
>    So the PF ATS capability must be left disabled.
> 
> For this situation I wonder if we could do: the SMMU driver, seeing that
> the PF is configured to bypass, calls a new function "pci_configure_ats()"

IMO, This seems to be feasible solution for this situation, which 
addresses SMMU-ATS expectation in bypass and we could avoid PCI VFs 
race. pci_configure_ats() can be called to program/configure STU of a PF 
in smmu-bypass mode.

> instead of pci_enable_ats(), which would only set the STU but leave the
> cap disabled. Then when setting up translation for the VF, the SMMU driver
> calls pci_enable_ats() as usual, which sees the PF's STU set appropriately
> and succeeds.
> 
> Thanks,
> Jean

Thanks,
Ganapat
