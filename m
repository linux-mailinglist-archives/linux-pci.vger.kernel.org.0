Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50EB5F9813
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 08:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiJJGGO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 02:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiJJGGN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 02:06:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5F934738;
        Sun,  9 Oct 2022 23:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caxm9eq7hgWat+A6/ZoVRJ860PVMG9/0UzbC6DbycXfMvN6qA+50A7ds4Dr58FoMAaxp2tPvl99l73Nh4xNFBQPm05FWtuyjLyFa77DzGRCIUJs4PEO3FKK1RYJhWr3ATIo3XrWqjKlGIiUGG1VSektpQ+QvJD3cNFaLjvlYYoHM4oJEPptFuG5Vbm0l4k6jz/agBVavVn5jjnr2fNBNx7vA3luvhp1B8EpKgSonp5zqeSqEPbUEBamMNw+k1D7j/xBbyWS+0vQp6WUVPWfE1QxUihqDd+sYBS6tya5J+HrEjfONJGdzDSS8j8GMpaUGls17ypwhgjHXIRcMRw5Ocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFpigJsj3EMWZFtu+N7Z7xg2fWjI8LjCuEib0Xf1vxo=;
 b=Ep1I/U7TXvc9RALjbO47hT+TBGVQh666lBtw6iojBahm2XTkYcDxttBrVw+WMmWB1JiBMtJQDO4qq80rksUCehmDykPWuq8xe8y7URK45ykTHhD8W+fJNNNjGdCwdoZqzvIB5PhkeQNcw4BPJN/vVGTLBkI5ZKH+zbXNCyuX/ZvkxDZr8C7mC9jGYZDaAzRHqsKWWZHLfbdmUQ1/jsCcrWuP5Ru6yXb/z6jTVYbsdOwya12d35RQuI6SYyU+LIL6k7lLbkIkMCNvoc5W9WOtWVTj3gBdBhGOGXlXuGTiAWLDfK8HTLyCJDs+m0Laxd3P/OBGmAnQ53X5Uq6SPxChaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFpigJsj3EMWZFtu+N7Z7xg2fWjI8LjCuEib0Xf1vxo=;
 b=Wxa3V/RKYzwNEJ5VHF9aWpKS/TJOXDIx3BS/5JcCKhk/H2KouVhYD1LqXnjEgqagAuMzW9az/Mymjg+Qs17SWENQEeE30n9FejKidgFYDReyUa+vMcGqpiTMVfaRJ+R/BmR0js/4EZfPP59Wvc+QGY/faFNFQMy+LAZhTrbA+BElIUcelvnfzP+tJDsuHQtm4QREqQ7S3O6IsBcL66y/wV0RJL8ZHezsnWXuYhHFwB0kSz11HaH0yQAb+YU4WGoQblV7oV63vF6h2od5wKYcf006vjVC0mJrPxuUZnTsD7GVX86qIofj41u2M9vyyahV0FI0BHmTqsmRb4MtJ46Bmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 06:06:10 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3%7]) with mapi id 15.20.5676.031; Mon, 10 Oct 2022
 06:06:09 +0000
Message-ID: <d841b850-aa54-2a94-2061-984812f82684@nvidia.com>
Date:   Mon, 10 Oct 2022 11:35:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2 0/2] Disable PTM for endpoint mode
Content-Language: en-US
To:     lpieralisi@kernel.org
Cc:     bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, robh@kernel.org, kw@linux.com,
        mmaddireddy@nvidia.com, kthota@nvidia.com, sagar.tv@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20220926111017.12655-1-vidyas@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220926111017.12655-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::8) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: d62c61bb-46a5-478e-9941-08daaa8586ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5PTT9eFd1JlAyf4J0/nG8em6A4GrgZ3co+fZknEob9lLpULkh7nnPbq7uh8C7l4zHpaK18mOhZPErV1GyBEIlEppXVB5e/oq6fe3Rasog2CroD/V15Bsul8c45uPT7BhNakIu8J7FMP9jl7GtCoFFT+I9/oMtdNQiGhrWmkHM8ZDZ8pYD3uAwjLqvVsqkkI65C0xF3Uc+hLiZYdNK32BcRwcj1WTj2yRynHi+vDf/SmCDPZz2DTXJvsr8oUSSW4fITVCamWF2IVwej/AykJ2Z6i1Od6Y/PmJhx3YMtHKMDP95f2wMuY40TMssxp/zlLRSP1Xw9UxdEfHhQq030CYbQ3zkrjjXBBB0YblEDSQZFckukVKE3dTQVq2x15kzJKgOr9lR0T6tLU2dnKEcveb7bKv1Lh/F62tQaqB8da3ClXp9yTUw8OroAxP8NGB790yy2jXgacPatkxWo/bhWt0pcC8vJqjFC/tG4mLpsGtkSrX2mtNIY5atvnr0APeq73XqfR++efYy62r4XEaEblGSKJKsPYa8iXYlLeS7nFfV6988L/f41Na77hDKEjZzk/VhQJBpD3uu06Y7ltkpNhkX+RSsj96qIRFDg+vW9G0Eoic640Zyz2rmLMnhE4khvM/qC1WQoDeltQS+kIGE1KuqbbLvjJKPAeLAAI386B2c1jSxc9Uq68mO4qXbCOcvXbSHCX6CW5Nng99cg5MND2DtDN39dGmsmqtyG+e8RTP9v0+bUU8ruHA8DqoZWmJyKo8AuPkKUozUBcQiMQnYSxYHmeUM2Dlsji6Uzwn+q35BM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(83380400001)(6512007)(186003)(31686004)(2616005)(26005)(66476007)(2906002)(31696002)(86362001)(5660300002)(4744005)(4326008)(53546011)(8676002)(66946007)(66556008)(316002)(6506007)(38100700002)(6486002)(478600001)(6666004)(6916009)(41300700001)(8936002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVBXOFZEK3F5a0NXVkdWekVNellLL3RNS054MGFPbldoWDRlWVRtQlhSSGQv?=
 =?utf-8?B?QlRDcDU2U1pEQzdSbkxUWnFnaFUxQ1FPbGJ6eGZYM0E2dDc1UUdlQ1dVcmlq?=
 =?utf-8?B?SE1rb3Q3UzNRZlpzRWJzRWVOZ0NjSkZOZ2FxNXdyeGsvT1JBdWFFSkdLNmxy?=
 =?utf-8?B?R1RXVmVLTDlmNzcyc2RzT1VIcmJDS2ZNdlFCV1FoVXE4MCt6bE9ZYWFWMVBF?=
 =?utf-8?B?Y0tRbE4wcmtkc3l6VE1XaG1pZTZzY2N2VHV1eWI1b3Q5c2tkUkJoWFNWY0Uz?=
 =?utf-8?B?QmRYUTN4OEdLOWNOOHhsK3Y1Q1c0OFk3NTh5NGMrQURvQ0Vsa01rRVBtNG9n?=
 =?utf-8?B?SXc5MlFLcXJaWm5ST1pjUHRsMlZrTnY4VmpQUXArWG8vbjZoRGgzaFlEczVS?=
 =?utf-8?B?UGx0eG1vdFBzL3pEYVU0QXl1NWhsN2N4VzczcGMvcENYK24vb2dIWFRyQmJO?=
 =?utf-8?B?OElQVS9KMkJNazFhcWljeG9yMTVLWGxnWlJJZjg2T3V1UlFuYlZlVkJaNWtQ?=
 =?utf-8?B?RzNkT21LamJCZkFIeGV1RHZJRGxXREE4SW80KzZjU2ZXREhTVnNCeEI1R1FK?=
 =?utf-8?B?NHZoMjlQUnFpcXRCekpnK1ZYbHFsMjh1N2ZXQ0FDN3ZSOE9tZWJzNnRxZk5Y?=
 =?utf-8?B?dUpGVk85d0ZTYWFaOFhtblV0b3kwUjkxTUdLZEd3alZtOExORUhXUFhhNUlj?=
 =?utf-8?B?dlQ1NGpkaUViWGhOM1BpaDk3QkVtL05nMmk3Q2tnaHRxTjJOemc5TlkwdHFD?=
 =?utf-8?B?MFBhYmlRbzNjU3ZSUDMzMzZCczdxR2hQRHJSODZFWlYzWDU1b0xoUVlSc3Jh?=
 =?utf-8?B?OHBQZ3N0cWhYRXFTQk5PZHc4c1Z3Z2ZZem9lcTdYY0sxZTl4Qm8rQWUvTTlH?=
 =?utf-8?B?SWV4aWdnM1ZHVExONXNUOGlKdUdOYVBYZ2lJTlhJVExZMzIrQWZ5cmY3M0FU?=
 =?utf-8?B?VWRueEt3cVVVWFNzQ0IwNHFwZkx4Nm5hajhtSXU1Y2theU1vVzBwanBPaGtZ?=
 =?utf-8?B?bitpaVU0WFM4Tkd5M05PZTZKSDZWMk15MzZZSEZENHVjWUpZZXJzenQ4ZFlU?=
 =?utf-8?B?TE1zZ0pBZFJxOXFPZUJtTnJVcHQzSnlGdUNnZUkxcVhtT0RURkNJQmkzeGJk?=
 =?utf-8?B?ZHR3QlBDc0pFWXdYbmJ4WVU1QVcwdUpWdlVraVdVZ05FMU0wUjhnTVhIZ2h0?=
 =?utf-8?B?VEJ6SFh0WDErSDlkUFllUzlHMU8wbWptNWhCL3VHQ3RRb2w3NjBEanJsenA5?=
 =?utf-8?B?UDNJazhqUHM1RlFNbERmZEEvUGhYLzVnMHc5Tk5DOHpMZmhGTURkcHRtRHdW?=
 =?utf-8?B?cm8yZWJpUGRJT3ZrbGJ6UDdJME9vaEc5UFRBNWZxM2JHYkZIa0xQaE1GOGpv?=
 =?utf-8?B?SzladTR0M3BBdGNheHU4amhDVEJhQ2pkdHdTVWRzRjFHR3dGQ3ovNjBqOW5C?=
 =?utf-8?B?SGNDYXFtKzBRTVZUeUpVR3dyWkhMRXpqY1lIdVJreXdWREI5VEJIRXNrL1BJ?=
 =?utf-8?B?ekVhZE5HMWNzR1owU2ZUR1JjUW1GUjhZRjJoeDVtdzJwR2pOU2ZFNzc4bGFv?=
 =?utf-8?B?Wm1hakJrS0s4dVRjZXRYemhjNGNMbVFYQ0dMWFhjdTNkS3N0RmNHeS9zVHFY?=
 =?utf-8?B?K0JWSlYxUEdJd3J4RDUyVlZvV0lhUHJ1TEc5KzhZakZrQUdiUDNpYWZyQ040?=
 =?utf-8?B?RURkeTd2WmFMMkVxVkVSWFRrbzNXU05EWjBqRmE2NFVlMUJiTWNVbUhPdVh1?=
 =?utf-8?B?ZnBqQjB6ZkE2RnVPc1A0c1dzcGh5YkZpM3Y2ZmsxWVZyeEJFUjJrUFdqVUlP?=
 =?utf-8?B?VyttbWUrallORWZKa3hpeWlKTksxN3dxZG92NFZ3NzFtdmxxSTRDanUwUjFz?=
 =?utf-8?B?WHpvRE9EcktRTFB1eitEbWNEK0UzQlovNlJuZFhnMktWMDhWNUVKMzRoVmVw?=
 =?utf-8?B?YjlhQkUvbXdtdWlRczZjc1VCR0F1WHZzVS82OFlYNXo1eHAvYzZzSWJtUHVV?=
 =?utf-8?B?TUNQdUQvczU0SThLelQ1azREcEExaytGbGN1OGZtMWNWUTRxYjhINzBhL1Ji?=
 =?utf-8?B?SDh4QXIxTWpvY3FVaUdzMDZIS0Rhc2xDOGVZUUR0WU9hbzBLVXZtanEweGtV?=
 =?utf-8?Q?Jvd7ICYGArWI4Y6+gboxvcMy/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62c61bb-46a5-478e-9941-08daaa8586ca
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 06:06:09.8736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTEiV2FfkFNKz1zDwaMy6GaouK2An88G1p6MQCzG0DuQXiklXUaZIl6lJ1d0JvwS+2c9kqSUG4YOo8yhuO8Q+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,
Do you have any further comments on this series?

Thanks,
Vidya Sagar

On 9/26/2022 4:40 PM, Vidya Sagar wrote:
> This patch series contains patches to disable PTM for endpoint mode
> as the PCIe compliance tool requires the PTM be disabled for the endpoint
> mode.
> 
> V2:
> * Addressed review comments from Jingoo Han
> 
> Vidya Sagar (2):
>    PCI: Add PCI_PTM_CAP_RES macro
>    PCI: designware-ep: Disable PTM capabilities for EP mode
> 
>   .../pci/controller/dwc/pcie-designware-ep.c    | 18 ++++++++++++++++++
>   include/uapi/linux/pci_regs.h                  |  1 +
>   2 files changed, 19 insertions(+)
> 
