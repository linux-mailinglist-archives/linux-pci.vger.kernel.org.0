Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6D860DFDA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 13:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiJZLm5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 07:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiJZLk4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 07:40:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E284D4A3D;
        Wed, 26 Oct 2022 04:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVJMXgKyQ4S1u1qaujpfIsJ9rodwT07ekTkB5aZame9pTqvYY/25wVQIjXqzqeFg9OuMj0ljJoEdB6zUmyKeW4BGwMpRAzdiMrvSwSp+TuCRnb4FrF8xamXX+qzAOMW95/ohMLInFdLtowjcrnnz9+BQ6gP6b3W95WDyyS/7yBOIKGGOC5vU5r1Sr1BFeGJMa+G9ACSzY81ll/Te16XoePWXxVewdUYGePBIkycLylSGOKKmp+m3wGFSfN9d79ytiuIDQ03inMMf5z6Z3/mVLt4TXfDvJyeTxPZuE9FKMDkltRYYRC9eLhGZrjrXP4x9TGMus7T1MA1fJTv5GUQlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DepCOVTTzvl/xm1EsORri/lj0OyM0aa1wtrVJsz4RM8=;
 b=hRNvmJnjBWUos9sfMAHjUUU/I60okN9D7k6ysApkTT7N9JwZGlFrv2epRf0f+xzwGVrBsYKWDFsXYemkSEoOwalksssDF3PYn5ybZz2NSqScjePf59k661VSOfPW08Xt6b4D+iGg8oglLJvokTRCg3ar4lV/rB+XUe4m4Eq5h7Jxvuo6YC9cxU+/ErscLmpneNGMprF93XTeb5J++MGc6JIIbIQE72rPiOYhhWHGirrFpKDQsbF3AiGb/0AmYOw9Y6+abi12GmWBWOWVwBqkPdfZU5fDGsKuR3ljxzluFdtJG8yBkoCA2k7bqFL9k3BcSbKJLUK6+GtHq5uLLDbOmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DepCOVTTzvl/xm1EsORri/lj0OyM0aa1wtrVJsz4RM8=;
 b=ZP8/vD2BjQrnrPngtvY938O5cwd/WZS8jyqusel2CgetVbN3SEOKMVj8YrAqriHWYQzxkkBv5OjRs675PMCtgSCDA0eQXobDsOKPcRhmP1nfcG5jXAmbD8NaDOCsHJ+o/42XxPayFtFgnPg7E4Lgtd1RIETOuofuBzNneP8s0+fv8HauC4fHb82/aMMEF7DboV5xNix2Pq8us4iuFH+hkbDvj1BQRTd6qcWEm3ahr8v1rcJ09GSjpmwukQ8S2sm9WMo8xeNbexBS/g2f/I54N88QlXq/m424fSQz7IEQhnYqMdV2LBlSlKaiHUOV7L+TGOQ4AypH9HeI3RMmR7dZdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Wed, 26 Oct 2022 11:39:21 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%6]) with mapi id 15.20.5746.023; Wed, 26 Oct 2022
 11:39:20 +0000
Message-ID: <8670e757-7275-57eb-3f5c-0a21ba354e37@nvidia.com>
Date:   Wed, 26 Oct 2022 12:39:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org
Cc:     Vidya Sagar <vidyas@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20221018164329.GA3808783@bhelgaas>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221018164329.GA3808783@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c5bf6c-b97e-4417-4161-08dab746b8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nk4gWPsUUVX3AeJivswH1vhvRAO/3Db03GNkW+t/xPhazQxMk3uY2EQy5NZAnRoGOxw6pjn4+OhWzX/vLzKVwApPAMPL+0F7Q48wOFHNtkS4K2KYesUTDL+yKJtlDuiNxzOu+iC/LMt+xsfyDQ3Qx2IYGeexYnJd7pbO3aC3aaA2L11BGtN35Dxlxt8/vHoP3mdrNV3gg+cVdogVFp0IJoTamMKlu1kz4Y1zEnlNiqCvJOSt11s+0kqt3+rFsD2y9fQFqk00jW5HT6Qp4/3QhbIHTCW3oMYQCMqVj1TxJub0Tw12ly1+7yTBHghbUD7T4o3G14OoxZOp/apjRD5NQiniK3Vw6nnOKQFbRW2Wlw2wzn0qo/x9mibMR/K++HYcIBXRc8eY72NbR+YNygfthNIZKjb4+64ZLM10TlbVs0yxeivvzz3B4YnzZa6MV7I6XH+hvWuUyZ4p6RbBZJtmVa+zTKBB1HYNFdhl/EULGF3TlTXce+YZbUCbMt000E3QzJByWMolaA4Wa30CrHmGwTLJm8SDAkDQINYtPI4yKOCE47wdBRKGCcKXu34qOL4gXTgkCfYEZ0Lwr8la2Jyb+IGSRRsEXYxnambUqxEd/FkrQIOunZYjJWgoGJ0E4HMbMhpwnjTvhdM/+5E+VWVdMqPgsRCT6nutCjFZSgZ9+jtnTBxUL6R4Jbl/qiFoflBWdBGCox8WiBbwxeU9vleaFOEO/bb8EYaYm560ZNQjLNBQe4dshT1/YmMXxPMZuvVEmEf07strxIgPtqmqj1PkajhCRrCI1ZbO2Oyy5pTIcfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(2616005)(7416002)(31686004)(66946007)(66556008)(66476007)(6506007)(53546011)(186003)(83380400001)(5660300002)(36756003)(478600001)(6486002)(4326008)(8676002)(86362001)(2906002)(8936002)(41300700001)(6666004)(31696002)(38100700002)(316002)(54906003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTlPcXBHK3A1Q3dzd0dSUHN6SVh1Z3hZQ2o4dmdyU1FlSTR1QlEzTFlMTEZo?=
 =?utf-8?B?YWdXc1dDWE5MNFFHbFVwZnFEM2sranJXZ2UxZHVPQ1RqUm5UbHFBU1JvZW1L?=
 =?utf-8?B?NVRROUEyVXFMYUtuVXI5Qi91MWtPR3NwK0o3TEVJMTNEVTBUb2tCSzZ2RU1P?=
 =?utf-8?B?Q25MZEE0UlNQbzNnRmRRTjV2dGI1T3JVcVlLRFFGc0llSVVlOUwyYXRodHpn?=
 =?utf-8?B?R1NUYloxR1BvK3N4cjZsQ0Ywci9oc2F0WXRTemJHdVk0ZUN0bVl4VjNqRXAy?=
 =?utf-8?B?YTYybWo1U0lYWFducXJjYTlaWngxU3NaZWxIZkdocDZNMitvTmorK0JuOHda?=
 =?utf-8?B?RVB0aGhtVFR1Y2ZqL1l1bTVCODdNVUNIMnhSdUN2QmRLZSsvRXlKamlFMW5m?=
 =?utf-8?B?U2NORXRaazJMNWhVR1owTzlhTnlYdEtlYVExbmZlcEtMZGcxajFPS2E1WlJr?=
 =?utf-8?B?TUtzMVIwME8wTTExYXZqdnBXRnNicEQySFFubmdOMU93eU93U016QjFiL3Ju?=
 =?utf-8?B?cEp5RFJGc3JodUpiSkdZS2hka3gxL21kRzNXSG1ldWZvaXZpaVZlTTBqWWd5?=
 =?utf-8?B?UVBvaWtPYmRNcy8wbnFjaGNhYnRNSVRKSDNGaGxnUlowQmZsYW1Qd3BJY2sy?=
 =?utf-8?B?WU9GdkV5Zzk5emppeWdwWkVVaEppRmtSY3IrbzhkRTltbTZ2MlFlUTJHQTVU?=
 =?utf-8?B?Wm1Ddks2M0U5S2NmaXFRYkFyK0VGNnNMejhjcEl3MzVUZWxDbUVpS0VzRkFJ?=
 =?utf-8?B?ZklsL2hNZnNvT1FIb3lNMWtYbU1KbVZBNUhVYmt1czU4NHBaY3YrY3VWaFp6?=
 =?utf-8?B?OFRKNDBHck5JOHV1UVhUcUJTc0lDRzA3QXBwN3FpS2N2UlNmVkZabXVNUCtj?=
 =?utf-8?B?dDVzZ3AxSitCclFuQ1duWVIxYlBHVTBXbVpvM3N3NHExTkp3VVB4T2s4Qk5j?=
 =?utf-8?B?K1FjR2Y4QjgwL04xUGZ2dGoyUnI4YmpoUkk0Z3BhTnF0OVpnY1ZUY2picUtC?=
 =?utf-8?B?bzdPSVh3WWZsa2tyaTZWY0NIQTcraVZyWWExSFd2WTIvUUZzdlBPSU5IRlNB?=
 =?utf-8?B?bU5LZlIyMXllRWZON3ZpeHpTQlRiWHBvWWdMWFVXTnlaYVliaUFvNGpVTTU3?=
 =?utf-8?B?TjR2aXNKdC9XR01XQ2lsMThhaTVEdTVJRWU3YkExc0hjNS84WmZQRVo0Q1ZP?=
 =?utf-8?B?ZEV3QmZTUXFTMk5oQkE2cnQxY2tnN2ZsSC9ma29rdFFOTTM4SDViTmh6TTRF?=
 =?utf-8?B?QlBnaGRRcDQyWlV5RFoyUDZ5OStkZFBLdXM0RFV5U2Fqd0duRmRpMHRpY3N1?=
 =?utf-8?B?WEtGbmNBMnBJZ0gwOTFTYmlldnJEZ0M1RXVzRkV4YThGYlZqVllkU0h5MkFQ?=
 =?utf-8?B?Zm9wSHVJMjVKRXhWMVRubzFEZTdZQXhtSkZTTFdzcGVPejl1WTVEVWFSNnRu?=
 =?utf-8?B?U04wTUFMWXo3TElRUlQ3SWw2cEpLRlJIaCtGb3VieWVhcVVSMW9FckQzd2s0?=
 =?utf-8?B?VG5lVEY1QnBGUkgySXB3SFVaclZoK0xQMVhlVmNKOXF4VkFkbllrR1RsM2U0?=
 =?utf-8?B?bDRlVTdxZitlbHVJaGZibEZscDAxdk16STJ2dTV6TWR0NVJTSUtzSmVXbHFU?=
 =?utf-8?B?b2RhL2ZMWWZUUUw1MWlTcUFCRmlCOWc5MldqaEhuekRwRVF2bUk3K0RFOHo1?=
 =?utf-8?B?NW44WTJmRnhoV0NmR0NjQ2ZMdU5acXc4NGx3NEs2eU1DRE1xTTFjd3gwOHY5?=
 =?utf-8?B?cDl0L25WV2RaZGdteGZud0tURjRQazJmWWlLcThycjkxeEowOGVRWGhiRjJD?=
 =?utf-8?B?VWFNeXZ0c0txTlBvQWRDSFVabnFSeUJvazc5dUM0U0QyREtsNEZpVE1xekg4?=
 =?utf-8?B?dmNmTWRBSjk1NEIvT1FDT2c0cmRkelpKZldoUVlrWGFsUGdDMGc3UUtqMC9D?=
 =?utf-8?B?dktmbFJwKy9rVU93VnhlbjdXL1BPWVhBV0pJNitBaHo2VjNvcW5CdUxPUis2?=
 =?utf-8?B?OEgyeDArdnZVMUNPMGpRZGw1eDFxVER3bDhGcW5SVWpUTURJMjdsUTlOcllR?=
 =?utf-8?B?SlQyRURTZDJKMjJnbXlBT01aUGZRRFBXclFyZkM1RXJOL1BHNkhYUXpKeTZZ?=
 =?utf-8?B?eXp3dUh3Zy9RTCtFM3VodHRBOTV0Y3hPUjhmM2xiZ0lUeVpra1F0Tkh6RnNq?=
 =?utf-8?Q?L1os93WEk46qiIbupdydSYbxjNchF/wNRDTpm6O5TArH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c5bf6c-b97e-4417-4161-08dab746b8fb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 11:39:20.8863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHxFvGi+PkIDlnVO1VZH/tbc75gHfdO5feDAfECJ1uJ2AYdbll3jBX5E0DkIt8U1/HKd282HdSMsIlp3FzFHGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 18/10/2022 17:43, Bjorn Helgaas wrote:
> On Tue, Oct 18, 2022 at 07:21:54AM +0100, Jon Hunter wrote:
>> Hi Bjorn,
>>
>> On 13/09/2022 11:12, Vidya Sagar wrote:
>>> Some of the platforms (like Tegra194 and Tegra234) have open slots and
>>> not having an endpoint connected to the slot is not an error.
>>> So, changing the macro from dev_err to dev_info to log the event.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>>    drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>>> index 650a7f22f9d0..25154555aa7a 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>> @@ -456,7 +456,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>>>    	}
>>>    	if (retries >= LINK_WAIT_MAX_RETRIES) {
>>> -		dev_err(pci->dev, "Phy link never came up\n");
>>> +		dev_info(pci->dev, "Phy link never came up\n");
>>>    		return -ETIMEDOUT;
>>>    	}
>>
>>
>> Are you OK to take this change?
> 
> When this came up, Lorenzo was in the middle of a big move and I was
> covering for him while he was unavailable.  But he's back, and I'm
> sure he will resolve this soon.
> 
> Personally I'm OK either way.
> 
> Bjorn


Can we come to a conclusion on this?

We have tests that fail when errors/warning messages are reported. We 
can choose to ignore these errors, but given that this is not an error 
in this case, we were thinking it is better to make it informational.

Thanks
Jon

-- 
nvpublic
