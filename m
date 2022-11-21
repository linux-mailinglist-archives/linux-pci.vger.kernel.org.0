Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74306632C48
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 19:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKUSsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 13:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiKUSsJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 13:48:09 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965071CFF9;
        Mon, 21 Nov 2022 10:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669056487; x=1700592487;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K8XxAOxk3BUTzoa+sDXswNdyNzWvVBonE/+Jdb3xOgs=;
  b=JoAuTu64GVn0qol+Or5OsZ1bfbSQF+hzb2LHzsjES0q0NCk/Q+ChFRpe
   x90er8g8OyLHfq/zWBk0CXvXcRgbMNrTooRIl9PBWzCKm0Z8+zQLCzO7c
   wiKE6NDaQdjKmG5gosK+OC/7XGaem+MyPnW0ISUUXdGBDYcIzREUH7D60
   4+FaqU0KZ4fzxCH7IqVjfrJ+stop6+um7iGVnE0DZfioSTQwUR3qZ0/ZT
   GeZsdvJnglvPFmyea2BnOyn4dYOgF195sD/ix48jn5RkKPKuT4kkLko7P
   qcbqXFbhxxeqB+UG6xXtW2h0no8zO8BF9N5pkkCd+310vJ5lE/9/J/EaB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="294025525"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="294025525"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 10:48:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="641123799"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="641123799"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2022 10:48:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 10:48:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 10:48:06 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 10:48:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNTji4UrrWG0dZV9tPmiKQssLtG2nspUO0fd1iRvTrp45h4ODIsPnS6bM9UPc9XyUtaR2VsYodEwpDi+1XLBHsFfQE0gutBmloFcb57LY8WugLSeI9/6AYW1v1YVUBNclfzUIccVmJ9msxE4M9aM8TPls3cKoqplO/ThbQhMkkiiBHa6ArdPe96ebsc1OYXMGiTMoGx99lTY4JMrvYTLFoWwY2IGQW9W8Hz9I7KFeqAiF+47Ee+L8fdtnkv8AP62EaGWAg4/85OjAcRx6tkfOv2dPiBjzdcrcjBA8VYguG3DZRXINr3WdAS3oceU0RsNdgePCsL6efTaWIqGHuZZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROy2U+/WBZOaMEt/a9U9US1gIMcPa5ZGaHdrd9giCPo=;
 b=BGzuyQhswcRI/1Cw8VqRtVWLkdU/nujnxx6wpjXJRmKBxzPX5CFvgLAM+8lYgmuHuZjrIgK/zoVwVTAHZEzAwEPrX6KXKPLzS3uy0tPZiQCfeTGjWYVN28U8puL1Nvw8YMQnx0ivt5UCl12s06n919EbDFMth1thkubFWEBFizhFfLtsCP7ssg0vs/8svF3Vpn1rrm1iRxvF0prHA3MljHJDx4xYjXJoWtreWDJeag5XjSGYcU0wfvBigpbu5PaMTGp/d0Y3yFQs+zpYXH7r4NkyDUyk4eNA5vkuzPmHTAlKjurFzSm/GUU6/fZWcz1dvztSFA5EAgZfeoUYX49T0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by SA0PR11MB4541.namprd11.prod.outlook.com (2603:10b6:806:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 18:48:05 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::f4b9:901c:6882:c286]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::f4b9:901c:6882:c286%4]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 18:48:05 +0000
Date:   Mon, 21 Nov 2022 13:48:00 -0500
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 2/2] ACPI: PCI: hotplug: Avoid setting
 is_hotplug_bridge for PCIe Upstream Ports
Message-ID: <Y3vH4GzKYoXqC2Af@intel.com>
References: <5623410.DvuYhMxLoT@kreacher>
 <2262230.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2262230.ElGaqSPkdT@kreacher>
X-ClientProxiedBy: SJ0P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::25) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|SA0PR11MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: 100eb6f0-9247-40a7-4f20-08dacbf0ec97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+JD63a/FVYtf838W56j7Fn51oVx3aj46vXkXAuh/bdKgC7pYt89tIw3q4j9uOz9e/VE/b7VQo3qGYASollW0x6ZkLhQRD8hOOMYUVWztHIkQzC6ETTVJKS1yfDfhpsdQpk69STeWj9EQ5+TFQ5rXJI0mnuqH+IiZqhVUp2/dh4Tn56rPkrW+XyjLkd53I8GnIZGBSDi7YdK9uTrFUJllcO3VBGUhUtDfCsfH0fyrRjTvvJHG8smCejCsnj67x+E6A/RtVXEUFFKEeip82S6hl2jE/5N2uWZO7oAxXlM4ubovqhZ7uKpo+/BxmzMvuBb0dgZKDDvGXvzMPXU7tN3yRdOGvjn64+yI9nOKHNpc9fYH/UiMkUO7C2Io8Rz3hmxeXGLLnQau+g+BynoOkX6YKrVflgsLJeZ7mJWUbFKSuPW79ouN0ThIoGq9a/kUGsK8QEVhl3rUCMYZuwXqBMlvnpI5LsRuFvyW/lOfiPWi750JAxzxUUtnPW2HihtqCapmtH2F0cPiUmXYMpmshrAsYtZAJ8T8K+xo8SpouizL+9HFlMB+OCNtsioCrsF7AJJexjfb+uu4cSLCIvmd+biWp2vSKCgnRpby+4lT4eFGfcrIw2hBAic41a2+RhKfq0qB8G1ri3Ae2ZtY5LX8OzT6M3V5qb7j1li6W58nUrkhDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199015)(2906002)(84970400001)(2616005)(66946007)(66556008)(41300700001)(36756003)(86362001)(4326008)(6916009)(38100700002)(54906003)(82960400001)(83380400001)(6506007)(186003)(8936002)(5660300002)(8676002)(66476007)(26005)(6512007)(44832011)(316002)(478600001)(6666004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yiengrQ/ze8/1teAzjeQewEvNR8lraoyLMAcDx5v9ZsVvusNd/OXJm2zL/Px?=
 =?us-ascii?Q?RokkcbKMXmwh6ilBBMAg/FbHNFvyJKI20J6A6eh7KHlLVJLbu7NBZbtPIVw4?=
 =?us-ascii?Q?JkhPFhMcVHbdj5BzBH9vt8942qDnAAObK50E/n4OxLDdE8wFkmnpaLlobYId?=
 =?us-ascii?Q?OPARJ4ZMNQM4JEB3gIU/TqdaNLmyU8fg+VQ2Abn/bapUb82F6bHd7MeYM4Cp?=
 =?us-ascii?Q?uI1zugSp5ItUqJ1qGVrGo2utZcKpkaJULDMOMH/Kp+yKOufmqa0vAvlSxuWk?=
 =?us-ascii?Q?Wak2p01lbTTB4ctFKHcsUjMwCoNBHy1VR8gYsr7LGwdzMJjqg9PXGVAqS1BQ?=
 =?us-ascii?Q?TBc6yRb+0Kwr/NhW1LxsKjq/Umoou2fEhaAdNRll2TE+rk03DJQxnJaCM9OA?=
 =?us-ascii?Q?vzQlbO3xdQ0RVI3n13egVokM6SUHNOp4NN+As2DyEAw/L4hm8bOqnZwjoQ/5?=
 =?us-ascii?Q?dplmyLG0DjV+xupT/tieFQbX431GJ9vvotO4d9+dBHacVf4GTV0X4bU4Bm0Z?=
 =?us-ascii?Q?k0Y9DKW7FuGcRhNFabpBxdPk0V72lDho1vgImsI/Zj0FLauy6AH3+oSwbHBJ?=
 =?us-ascii?Q?Zp7hPZ/D1dbt+E9Urok1zJqHZEcgSUeaAEbpt4H+o7ZwGYZGl1YVEXCg/3DQ?=
 =?us-ascii?Q?S2GfxblqmD9ogVbwwt0BElpxA0h35naEWoF7OZFmK4sE9ulkYaWUlPoPiN23?=
 =?us-ascii?Q?aZMrKBNGGZ6AUBYpI6sVME/pbgLqfG6Ji/dieIgKtDQySSXExAiPNRyW8Vn1?=
 =?us-ascii?Q?M5Qu1OLanbrbhMkt/NPNLbPZFzUfjwSiJy0kjY3VP+IMvATfftwacVgWoIeY?=
 =?us-ascii?Q?RI7G/Z92gRsmVw+wGqc0eoKaBYg+KP6sJd4+vcDWPm04kFhmJD9TGTPNIQxe?=
 =?us-ascii?Q?8lK+xaYFVVeXe4fwAcQxqllL0xd5PAaIDDUDfenIAPTxfjNJZIFPuXEjnR4x?=
 =?us-ascii?Q?S+paqQWBCnMGDEX3T8CoMo8GTLZjK3At2Dq69O8arB5ZbfUp76n0jpEnIloC?=
 =?us-ascii?Q?7WazW3V6jq6qtWC4dnrdgZ65X06nocqg4gn9J5Lz4f2xUlJDey6fGCo0bWg7?=
 =?us-ascii?Q?yTN0cV9B3jLRKexKzxG2P/66+rSglLSUzu02U/oNOodatnAZMONBnj36rDp/?=
 =?us-ascii?Q?vCq4CmM79cl+HMyan2zuEIT5+GTQv1rimuzR4JfJ16LouCbDFloNNGdeG/bB?=
 =?us-ascii?Q?D9ktmsIY7KxAl+JAVfeVouQUHZsn30Xyq5Y7tMF2bCcZ7waga3McqjJbIxdr?=
 =?us-ascii?Q?8Lky9UOMv+djZ7obNgGt9tYcm001lrEPLGrPXw049opWw77SNKG+C1St8aB3?=
 =?us-ascii?Q?mqSEb5ncb4HJ68ufiakQGAJ7JBJg+rUaifpFzYZ2vCYPJ9uD1zF3rMCvAnNn?=
 =?us-ascii?Q?H8R0Aylc1vdNh4M690DjdMbSZ3fIGgJJBQY9IoE97A9tv0YWUT/AgnmNXn9e?=
 =?us-ascii?Q?bC4vXPqBkqTNyi6VTrF+EZXN21yDBe0tVtdlSTTRoTkroVMrkI88Yx/MNmRE?=
 =?us-ascii?Q?1LJ400I99ITAxegm5pJgIAMMV/pFJZ8zsWzsx48ZyQ9Nt4gylADc66JPQAaZ?=
 =?us-ascii?Q?SOY5q17AdXlfWe2kUqGYybPQ5hoO7oiqWPDqNNHU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 100eb6f0-9247-40a7-4f20-08dacbf0ec97
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 18:48:05.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZocZK1x9/yY5MLSsDwPuw/cQpeWxGD0AJ8mYmfKp1WUFzIGNvyRiJNblA/90IIE+KRpsnkuSkxNLoq5z9pXWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4541
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 21, 2022 at 07:16:57PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is reported that on some systems pciehp binds to an Upstream Port and
> attempts to operate it which causes devices below the Port to disappear
> from the bus.
> 
> This happens because acpiphp sets is_hotplug_bridge for that Port (after
> receiving a Device Check notification on it from the platform firmware
> via ACPI) during the enumeration of PCI devices and so when
> get_port_device_capability() runs, it sees that is_hotplug_bridge is
> set and adds PCIE_PORT_SERVICE_HP to Port services (which allows pciehp
> to bind to the Port in question).
> 
> Even though this particular problem can be addressed by making the
> portdrv_core checks more robust, it also causes power management to
> work differently on the affected systems which generally is not
> desirable (PCIe Ports with is_hotplug_bridge set have to pass
> additional tests to be allowed to go into the D3hot/cold power
> states which affects runtime PM of devices below these Ports).
> 
> For this reason, amend check_hotplug_bridge() with a PCIe type check
> to prevent it from setting is_hotplug_bridge for Upstream Ports.
> 
> Reported-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

for the series:

Tested-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

Based on all the explanations you gave and docs you showed to me
recently this makes total sense and the double protection seems
good to me.

Let's see if Lukas agree, but feel free to also use if needed:

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
> +++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
> @@ -411,6 +411,14 @@ static void check_hotplug_bridge(struct
>  	if (dev->is_hotplug_bridge)
>  		return;
>  
> +	/*
> +	 * In the PCIe case, only Root Ports and Downstream Ports are capable of
> +	 * accommodating hotplug devices, so avoid marking Upstream Ports as
> +	 * "hotplug bridges".
> +	 */
> +	if (pci_is_pcie(dev) && pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
> +		return;
> +
>  	list_for_each_entry(func, &slot->funcs, sibling) {
>  		if (PCI_FUNC(dev->devfn) == func->function) {
>  			dev->is_hotplug_bridge = 1;
> 
> 
> 
