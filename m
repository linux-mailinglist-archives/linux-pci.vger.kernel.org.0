Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B9D75F596
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 14:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGXMCo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 08:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGXMCn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 08:02:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31BCFA;
        Mon, 24 Jul 2023 05:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGxZkbVwv6HTd0SO6XWR2fbycUnRLwN0pM/FMJLLRKXD7qpEXSwiWGdW1ZaqlzVlHyJkpnID7G7wNFX+Gphmj+baQQ9kak1FYhsJppGS4zmUMO91H8glIFrpBjG8aYF5suw7lIDl+DxwAnUHuydapN+Fo0ISRaLstdI1aP8HeVcxsZ/ih6iRbCYW80o6NxM2vDnnfaGTZzPZ+HWt2GaaAR2fEE0tSiSyIxSzhejvI9OB8ver9NBdOWSR1+JeQeYhx1w1VIOMprWwtxt4zINMVoP3iFhnm9+wO/ihYx5cRdFSb9Sat8OK7WWnJzgHDr+5gizlcJztqZM3JJ1pqqlK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIh1d4wad69LSWZ4+Gua4DyaFeemOBtb5Hsp+bBVBmc=;
 b=dRU+TyhAZXU+9KbcBgXuk/0i05JCkA37x/qF7W9LstiFqDumT6j8eh5ZQ7cXTk+TPSorByGjDVQNAKiA/e/UVopYEWJxacD2LreWJsigZgg8D20s9nw1+lrZnPlvvXWqX1wei1hoHzPmriChfP0Ip6BPJN5c1d1Zje10ElrtAcJdAM5hxWUXahyjB6pMMX33qN6MZGTw4pG9+f7XcB52vEyQuhiR1dzzY9uUoqVAhzruB9nK74xkmzHqfzM72nEcYRGDZ+PG/+zzNYA7H9zHQupUAbYiJhVgvTHnDc3elJ5jwd141B67+/wWt4rmkf9u6mWq1XkNCDfcdZSIqkOEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIh1d4wad69LSWZ4+Gua4DyaFeemOBtb5Hsp+bBVBmc=;
 b=BYnP07GWvH50egU93QyFhTtERw/X7S7Aq4Ns5mnL886CLtEYUjnweeNpRoJad9MNNeoIK9YgFYvFZGnRtnIL5oocZEaPpwummhww0ebHjNCKtb0gu5/5MHkGAvmB4BdiwtnTUoqqXfmzmNXlED4UZRNgJVgwOC9h9khK78roBC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 12:02:40 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::6cf0:e179:9f0b:edd9]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::6cf0:e179:9f0b:edd9%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 12:02:39 +0000
Date:   Mon, 24 Jul 2023 14:02:33 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        oohall@gmail.com, Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 1/3] cxl/pci: Fix appropriate checking for _OSC while
 handling CXL RAS registers
Message-ID: <ZL5oWTxp9fv/DBHL@rric.localdomain>
References: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230721214740.256602-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721214740.256602-2-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::22) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 0439441f-6726-4856-70b2-08db8c3de092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3r3lmLS0RMIgJxO/WW7E/WUbf8AaTf6lj//P7+BGB4zyF3H54zRmADkSwcDy1rwBrFS1pxHlf/KyaisEWyKmV7OyofAoV1auNKtyZpI7UidmvYua/xiJ+tgEMDNVu+/VVZUHq0FItfrXLvXtP9pFsTg0uUmT0rDKmozX4qzADJvSG0WIMFNrQsMq1vL1AMWNk6jj7SHQmYE9dUC9P8KycnJuz4v5WwptrWSbiF8VqXsZc+inNMIwVjXed0UQqBmZrOTFM6maDZi1ni709lJYW5YevT2TJrj+RCsfJRJkacW5lyoez63jiHe1Or/VgPo0PMi1u0iiBMyRE4iwnVujYCk3eBMkhJzmWch9ptaBqUDY3PCVMzWKq3re8qNAodewFU7ac+CWwE+6Lc0o0mlSgW+/kvBVS9DKsUEa5czm+d6/sXC8dYizHTLKgPpU1GhD2CAlSgovptODqHkJmDg4snlnqWdJw7zYbaoB/TKcEmQlC5V0tn0SNB3++9jirAv1oK2xz7H/Nw0G3cp1lXvgURl1mk896SmuIiWWgQ3I+7myn8xJcWMCmpmJ15N/+e+m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(53546011)(41300700001)(6506007)(186003)(83380400001)(478600001)(26005)(6666004)(9686003)(6512007)(2906002)(6486002)(7416002)(5660300002)(66476007)(66556008)(66946007)(4326008)(6636002)(6862004)(8676002)(8936002)(316002)(38100700002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bSxJ94gpwHx5uUJA/juLZ0vmSh4vfRMSWnYTR13OFpW1c+9d6pEQLS1AMNBF?=
 =?us-ascii?Q?CWovfamA3RndmgzXScPLzcPzfiZcS3exQhg9ENqsNVnCy3H2TtyYZnXRIkA+?=
 =?us-ascii?Q?Ei+AZ/EMxdk6v7mBgWVvu2aGb9DYWeLoHTcK18qwLEkuQLKmw/ekC/vtft13?=
 =?us-ascii?Q?xI1HOupe89YTVU0H2OQ79kZvudayD2Kp4d318uulnBWog1bxnmS1N1AsfrYY?=
 =?us-ascii?Q?Y8eEXVwhF1NS9aXeVQIp4Pp2zIuKpV5b0aMvO8UpG4ipUmiFlVr8O2zs9VSm?=
 =?us-ascii?Q?r/yj0uMNyvRReVhSuKtVakByVj9kzyeMsN2o7FCMo7GAPW6X4lmBwbrAtPDM?=
 =?us-ascii?Q?Mls404l39WvtGhRWVZWEtUPv1QplCtYRo8BFIyo6p6T+e42B1iX1ofPPb0Qg?=
 =?us-ascii?Q?Np0NNpqqB4/tdBzk4XLaYUikyGDehr1euMupeaW+MDAue0Gmy6FtciAAYYVv?=
 =?us-ascii?Q?MEU8UDK9cxdfF9Aih+2WSPBTxQnLEMdH4+7aAUVodruRU5vPbD3O50vcE0AE?=
 =?us-ascii?Q?n6WKTfWL7uHaXpXDi+B1hxeN6FRZrqUeqj9V50mQxLAjOYBmzUe4svGhASgS?=
 =?us-ascii?Q?HbcW1PzvkrI/CBRiTK6DlQfZoKw5CiU3BZnNiOvyKE8+9T5ti0uaMifUALUm?=
 =?us-ascii?Q?h/2o0edHSWVG9Mk1rBpYE5PEuEvitKuOOgIBvLpD9tqYcIakmbrvWJgoxsJl?=
 =?us-ascii?Q?/efTKeLKacGNrh9we9J/7+F4yZ8o1ZJaxbt7C1prb9uMPetIkGW/2zgQzlkb?=
 =?us-ascii?Q?dWSLgeemx/3ua8Y9WxO2yugdbdFODp7toOc4xzOYThEuLPNQ75yntmjypdqw?=
 =?us-ascii?Q?71lleu46nlqq4Jwc7M9sE7iSPLR2v3okAt5Sa85KOtWrKblvhY5Grepk8qlh?=
 =?us-ascii?Q?7gIBwYejAuqm4lNo67Zd9gtPnLkOvV0d158az4vXXjOI1FyfQ4M9jQ10xB7B?=
 =?us-ascii?Q?rxOy6UrN6YgFPy/HF0t01sy4jDjTAlskWI17snLtwrdJKsDsuoW7yFijJmEF?=
 =?us-ascii?Q?gmq7+Yna0FaoICwd8mOdHDiVvXjbO83gydy5g6oPlbHyZfWJMeKHL9h9j+iz?=
 =?us-ascii?Q?lNV5yY2/hOGKOKvJan4NQisZqep2IlKI36vL9bG0BF69+6J/87M7lDnJGGfx?=
 =?us-ascii?Q?OGukw6gKsFQ6XLHkqoAmNfzf4ZvMP19U3M9tgud23L5kXf8SqNgzIqwUSrly?=
 =?us-ascii?Q?L0N3sG79igZMGERuCF9QzztSxJoUnLsAfEOGi9ADDklp5qo91bKlG/bwBm9C?=
 =?us-ascii?Q?KdAXiTJjPq0S1gZ6KwahVOKvtWYp/lT2xI1MrBhvi8QW6MbQwnY7MMau0s0t?=
 =?us-ascii?Q?QTFsB+9MabneouzFkl+3JISCvGNa6PU1RXmGUpnl09xtAp5k2mpaQFb57O8i?=
 =?us-ascii?Q?I1qigmQHEv/eFQyDhfvh2uxq+A1qldOcDQ2TFTRr7z/OFC5vFl+22CwkdN90?=
 =?us-ascii?Q?yWvyEdJHmx4pdLsCfcbJaRaH6E6BYI48q7C+xDUtpOGzRtflBlbofM8fHt2w?=
 =?us-ascii?Q?4tKUpwpbPhKhizWLx89h40J/i8PAeyz+2aJQ9rr8lVInLkJFOsfhC2Y4UiU3?=
 =?us-ascii?Q?aaqfhvv4BfGQc+/9Lsb5l+t64rkOmUfbDsJsCWKN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0439441f-6726-4856-70b2-08db8c3de092
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 12:02:39.6179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O63x8b36lYhOew3MOwYeCV5Bm6dexEk/O2XyamJWV4QhMegJDVr3/qCDSyqgQsAzwkdEuHDNEePppSbbxXPAzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21.07.23 21:47:38, Smita Koralahalli wrote:
> According to Section 9.17.2, Table 9-26 of CXL Specification [1], owner
> of AER should also own CXL Protocol Error Management as there is no
> explicit control of CXL Protocol error. And the CXL RAS Cap registers
> reported on Protocol errors should check for AER _OSC rather than CXL
> Memory Error Reporting Control _OSC.
> 
> The CXL Memory Error Reporting Control _OSC specifically highlights
> handling Memory Error Logging and Signaling Enhancements. These kinds of
> errors are reported through a device's mailbox and can be managed
> independently from CXL Protocol Errors.
> 
> This change fixes handling and reporting CXL Protocol Errors and RAS
> registers natively with native AER and FW-First CXL Memory Error Reporting
> Control.
> 
> [1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.
> 
> Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Robert Richter <rrichter@amd.com>

> ---
> v2:
> 	Added fixes tag.
> 	Included what the patch fixes in commit message.
> ---
>  drivers/cxl/pci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1cb1494c28fe..2323169b6e5f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -541,9 +541,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  		return 0;
>  	}
>  
> -	/* BIOS has CXL error control */
> -	if (!host_bridge->native_cxl_error)
> -		return -ENXIO;
> +	/* BIOS has PCIe AER error control */
> +	if (!host_bridge->native_aer)
> +		return 0;
>  
>  	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>  	if (rc)
> -- 
> 2.17.1
> 
