Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B221962C6A1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiKPRoc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiKPRo0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:44:26 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F90F5EFAE;
        Wed, 16 Nov 2022 09:44:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivz/P/mb4gxgZv/zZfKlLyRTf+F1GmtyfnNC3AdgsTFN8h6eHV8HlLIJk8aMrF7+4UZdmQ4dnUohJ0mK22rUjelvREimxDzckAt7moEJThU/2ya5vLKqzEwf5+paTpUCt6thwfTBJmnNna4c6QfCE7t078Z93ORlODaQHTvTSEecbqEpB/ljURLrPxzfgoklVfZWYZnTZVQSaYMQ9dvIcb36/Iq/rSvWc5XTHyclCVtv2XT19jjNhTg7Kxlggsx1CgKi0cxMn9sliNAvd4fOQwX+CjRIKEmV4fLzoGFcKFXBMtdC0zfkfszj6YH84pgG0I3GBMMnOgTpiTgvtwq9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH9nevqBkudOEFDeyZF9KO07tsbgFDhKx3cXH86NyS8=;
 b=ME/tvzZD34b15HsM0q/BR2ncr/pDB+S/KVClkml/jUBMgd6SbVRDb1kK54wsKjn0U/Zd1YrE1zkgVHXZqy+nLgT0UwSZj2i1XwnCNCAg1LxbUAfMMHeUSp/75y8UiMxGcInxDW5VY5GGKW9t21nFJZ4DqFEeCgdGdv0hiwA1BzUqf4NQ2LaOVMqiUEjj++GL6/RfVuGW44FgqraDfPDNsKOLbVQMMPzs39r3qoXtxQeejaEi93MTfcy8jIPGMOHtLs92e3+QetDUDVpnyvsX6nv4w8rqtUEuKtS0eE9GZw1TxLBfYFzRlrlW31RteW56Ff9OVMUy+mZe4ehYLLZjbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH9nevqBkudOEFDeyZF9KO07tsbgFDhKx3cXH86NyS8=;
 b=SqtbentsLjpr94ipcz7mYNCwR3z4dVTRcTmfPFZHJr8xtSFa9hPvLuyduxRBmt5uKooPe63Znt29PyeE2hyGmyidUJMSy8A1nJJXgBzBUsoIIGWhYtjawi8jhq63t8eqSJuL+RmtLt0sOWACzKmwICd5T2KmalbG5DGWM4FBfpRtY1B9sMPcgc/dcLzaaM32XdlAgEW1pmTYa+tT/nTpwrscVTuY37z+tEe3b+w4Pdlzzq3yonmGTQ9AX8QguEGAov4Nw+WNUPbi5JKZ9XN3h36EKRcsW0ihmlOh111kgvQYNpvuFFNWs77xSnfgrIxGBv5cFDKu9JULXRIoSXUJeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 17:44:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 17:44:24 +0000
Date:   Wed, 16 Nov 2022 13:44:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 07/39] genirq/msi: Make __msi_domain_alloc_irqs() static
Message-ID: <Y3UhdjldjMduzsph@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122014.004725919@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.004725919@linutronix.de>
X-ClientProxiedBy: YT1PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: f5918800-40ba-4c14-1174-08dac7fa32e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2n0fNgeEGfZZPwEFsH/dIDFHFkduGCwaeJ/X09d5kn4TXYCC9Sx6JoJXhlQAJlzCI6XIz0oNvgJ4RxchOVRZfjuaBSv08NaUSw3RBXDRhA1xuOYYY2fa3QCOXpd0a/R2c4oNqmqoKUrmgUahg8qfaizSvXzMrWDIPmh6innKzbPintq94IG4I/HmBYEYZrNy7JwYgYtc/s8SXOkgUy93YrLHhKNT6TnKaSqbxxxg9iBIZDdWifPa5jNYm8M3LCnxNZuomLI5/LzYYXe6aknTAalIK39Zej5DhtZbgraJtRz2hWvBi4P+4rQpiqEuMnEZ9wlZ4l2kvEVVZyV/rXWHezwlhbUFbi1WD2BnXAzA94DHwajj9+4e+tBjnJQcyWc/jvO/+nAYNFlp9sNdPMYsdebIesBTI+dcqxFx9ODt5U+Fal09z2Lcg1wln1xPhGbugkHCQyN+u2p4bWq7gOJfMopgOVYXHB5RB1ulf9ENVwVAIDMOCsKS6e5IAvHutigB4882Iv+yJXI9f4oTP7oBXQdNcVdD+YViHy0yTybSwjygb69B51Kz85KUvwGu7UWmNQNTxiatRctf0sKLUW1O4yR6E94HmcDDMtAThESFGhvLP+Dfy9oHoLA79M8FVxNzhyNXTeuew6q7Bd4S9gESH96vS5YOVPC77DalCLy+fC3UnyQMpUk4J72nTtJmlZ/NH4ayqUt77VlycBGkVuw7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199015)(36756003)(38100700002)(86362001)(2616005)(186003)(6506007)(2906002)(6512007)(83380400001)(26005)(7416002)(478600001)(41300700001)(54906003)(6486002)(8936002)(4744005)(316002)(66556008)(5660300002)(66946007)(4326008)(6916009)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGeiNPMzju96ZTqBObwAsSmAnzJ7wWUbQxiQyag+IsOixreJncu43KeTP6Ur?=
 =?us-ascii?Q?Hyq2DUFioZhJSaPERM1CBr9a6F3Avt/vAJpESamjxw5j3jeu41cD12tX80/v?=
 =?us-ascii?Q?vl4emUHbJw7RJQrhemOGdROP7zpFVtJlRuU83HLYTkNR5EEVt/CTDnnyThPl?=
 =?us-ascii?Q?/fgLiX0FMYnkL+aqSOiJPRY/p75ULY15Dzmd6UF4B8TQ7aqqSFgnQOVEHias?=
 =?us-ascii?Q?bPPhMtOAYDZyvU9Hsi1nPcydVDzTZKGwXKYD7a5n7Ejxv3p4tBgEm5WWIodg?=
 =?us-ascii?Q?O9EXNpXLysVXOSjNz8CRfii6IkVk2M6kYTy3R1lRemnJ0jmcvPkt8MYA2mCn?=
 =?us-ascii?Q?Nzf1SC4k0deepLM3R6Ie+h45dx9hwb4m8VaI8AUleOBbJOafq/qo1m/E36N8?=
 =?us-ascii?Q?aPCQ7i9kfT/nFJC9kpvFd0lPEoQn0WPiEZ09sJ4+fS47iOEnSS4Vumimj9A3?=
 =?us-ascii?Q?RT6+te/n3YKmbmDl1hfPGszWgLBNgo13gIJwST3Q9DG6x+6epaYmgxeKnTcI?=
 =?us-ascii?Q?HaY25CQLL41+pkhKRnw2CGXPZ07E6TjeqwtKwQ+cIcLDAH/bRt8bgZ5XBAip?=
 =?us-ascii?Q?KhJwAI0XPHty3grM9S05R3AnBejzyhY4Z5COXDsmD6JJi0fH5h95VU1FcFaE?=
 =?us-ascii?Q?llVHI24HrVuR6/iFpnjtoZ/Tt48NzO5chLnHKVkZ/kkVg6EEc4xQ5WLnerzA?=
 =?us-ascii?Q?ai/sogDmReNv8LRBdzkvqwj5ashzjaTk7kCBKCjxDbwZdvF93m3TGL7Mit6z?=
 =?us-ascii?Q?dFR+JO9/TxfMN6UgrBXpyvfPHtM4yZlONWN/xROGU+Eu/SOdTb3kT61IjWNN?=
 =?us-ascii?Q?SDa6TX4zGcCMPJfjk7vfCU3KetPekRrrTTa1DWNUrX3431bo7oQPEhXjoTxF?=
 =?us-ascii?Q?8yJIso+5uW5rUVQoc5e089g4ghbLmwfLkYOzd1/OOHP/peZFNhQq0fGdqsvK?=
 =?us-ascii?Q?aharmbUlW5x5XLVi9mnvpwZ5GNQX1fQAZWKO0zjCTSL/gV70VXOX2XRbkfqH?=
 =?us-ascii?Q?da6NkcAQ8Lr9Gt5wCH2M9iWMzUI5mHktvgAHWo0fenx2kj0JuAR5SA2vWL+E?=
 =?us-ascii?Q?ZP/sm0lTfx2QMSsSupSTrMDMFlASGGm1Hn8339+gCInfZ4dORdLVg+rdaKjw?=
 =?us-ascii?Q?fj+IanKUBZFguFfnQBXP9RI31cyKb5coEhNRUQ8TkUNHNw38BWzYsDts5JTy?=
 =?us-ascii?Q?BhO1MVcGozhKaJuuU0/WqKvYhK0M9v4nfkUlZ6eR3arUHtlV9Qv4jrKI2r6U?=
 =?us-ascii?Q?kT+S4flAkZZuzyw/YLoLjzUnzwrwdg1BOhLqpugN2wHDJ03ndWEufNpmrtFu?=
 =?us-ascii?Q?93f+Wkjg3Tn3+gAylLXdzHk/Qdk7SP9NiZ/yr9z3KEEk7vHMD+fzhuqE6d5w?=
 =?us-ascii?Q?iD3oAWFQBy48VZ2qgg552ZUJrLJzyOPyHZGtCj5pc4drGTs/B2cLs2TUjMhE?=
 =?us-ascii?Q?qgHvAXp9z/rLwaiaTHv2OpU/uAuImg414VnH40BzDYyuefI9KphGNDr9uWTs?=
 =?us-ascii?Q?ES83MtxJ3Nu3Rtd+MIPLsC8rxcDclDUA1307ZP+pJePEqrrq+TLteq28QBeT?=
 =?us-ascii?Q?06s4DMFABJM5e/Iu/QJycn+ez1BUeO/0eZMyWWsu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5918800-40ba-4c14-1174-08dac7fa32e4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 17:44:23.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tihzTt/pOxtshO9bdC4yw6BICbgT4HiUIuQvDTS3Z6LlRZJL146vhFSUJqUZ7wP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:25PM +0100, Thomas Gleixner wrote:
> Nothing outside of the core code requires this.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/msi.h |    7 ++-----
>  kernel/irq/msi.c    |    6 ++++--
>  2 files changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
