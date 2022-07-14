Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD475741E0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 05:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiGNDad (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 23:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiGNDab (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 23:30:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D525E86;
        Wed, 13 Jul 2022 20:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657769429; x=1689305429;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1HE3byMYotDufWixLjlaRs/3rsijd9cfDeTgu+JWMl4=;
  b=eDGBgn8dvfTUvQ8rOfny1+SZ67YknJPEk7Em+mcizRMNO5alnKZr/4aK
   +hCTtOJ2KqY4WnDHrJoUDYaNZzwaGwU3TRRVROk9whmsjrGb3M5oEUZ8Z
   0M4iUdJm+WMqZVsvsn6Cwpgrfjs+TjGg/TkC1nA9oCsVZDxSkdMeepKgq
   E7t/Sf8GrAs3AJVhMy9MxvXnG0E9lRI2roBoxPq9TIrhABlMnjdabpn27
   vscpODyRJsgjD7t5kfsXIlI8Y9VqvE2Fw8D7tdO/sk6/WSpPI1raJjsTa
   sG8ppmAXf3dI1NSeAqz3fEVShcSPS0yFJVK0Ezu3tBq4C781haM5KpAPN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="282957899"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="282957899"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 20:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="653687846"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jul 2022 20:30:29 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Jul 2022 20:30:29 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Jul 2022 20:30:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 13 Jul 2022 20:30:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 13 Jul 2022 20:30:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc+T7JdCslBMhJOGa60akYkOdP3Wkn8wbstwFvqryrn1ZKQl0EX/S9fdgpEJ/kTUk/7Tj3VUhBW/Y4132qyhQY0Zr5nUEmyZYq8YWUfgne19G6zfYObOb1EOIgH8t5QQ45aHckuo0ICwTWT7RbrJIdEAUL5AyuASrTvNN/ogCaYACWV4RJicmNL8agI6mCfokUALCl6ADt7+QSj4N53zUQt0Qpywwe0u3GUKwOcCgKdDVmKX12vbgGIQ5Ucs1VlLDMwnst/DTbNwTLbotUlswbF77kx2yhLNnSAEWpESzp0ngH1GeUmJgFhsEWo1epkFPEh8V9S6JP2Ql4koshsnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGNI7tpARYoJlHuUUhFWL3ZRi9DU4bcWMcfx6oWvq8o=;
 b=VkFiTYQ21dP7wkvTI+y+qgbJrzfystT+NZ/BtbMsITSu6hz4pO5zd9SNq3xY/4ss7zereLVnvPBxhMy9MNn5QDAGhcm6GZaztm8o1tnMdBbG/DF063YowuZ01EVZP5dd3KOqVcOLtnkfoBJyE57ag8Tq6+JhM7S+gV3KGWkaf1jVxSXBG7L/gSdtHQ9qZ/V1Vov1gtY9hvepGOOCudBwQLPIouenv1I3PFGqOm0WZTTw9UpKmiBIeglaOfQ/CQBNkXjf//pselfLszzAZfMnTOtHiBWF74AsxmTOzxZc1m9TZo07k8E2uXjkpyvuFcGLnr7k/864YACVu9wRJiVvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR1101MB2340.namprd11.prod.outlook.com
 (2603:10b6:404:98::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 03:30:21 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.027; Thu, 14 Jul
 2022 03:30:21 +0000
Date:   Wed, 13 Jul 2022 20:30:18 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V13 4/9] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <62cf8dca27760_1643dc29444@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-5-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220705154932.2141021-5-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 215b9b3f-46bc-451d-2414-08da65492e7d
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2340:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99M/RBp83xdSzSoG60evH99umNpKpMdQYMXKby9NMx2v+rfUPm51flA1JwsjVVVdGpINlBW37V/snncsMriI5fy5gZdhM5QYzlaZxwmmDTB1StL4I5kcnj+axmjuLBEMmLWZY/lm9txaMcALnnWyxkaYLR1GubqeckzaLBdcMBX2Ro4LbC5ZUEm9WkjYNHcoDjm9PMEc4bLi9f/6MA2n0nCEEiXHPe5SsJDd5qXfv1pulU6pbTz67qxDTWmcohkpKwRa9ASQALjjpzrTvsanSmp+mFasNTYOnwRjcTDEKkhXQ8rd7bySB8z2vAtPRxZlkpFCErEqNXkjb8KdAZ7Vd60wS8bzBAvyhMksw9hxdYBEhG/LGBG3i1L0TK0Ajf0Zd8flPf0WJpu2/4BSXqFiIcPY4si8zW8Kw9IDHeZQnM7OP2jtDNC0EUEbtmx2LGZd/BXTqH1U6LWbGxlOp4ylwADx2vgIGUUgdTgxh44na+9IS5lAuW4TJwpuz3QRJ3b1WDzv1qCTszLCmDPTpajymhFQ80cSqDKuO/D+Ft5ZO4F19uDHx4qkpi5f5PyoRFTDowWFp+HbDXipj0qgGz6l2+YDvIP/CcldJu6pmmRRRKn+0ocNyNiaQCquZgm7pkRMqKRdazi+oLJr7JpYyLr8Wr/bfhFc0e3v1cSWjIa2I1bkOEKi5UxjUFmaIzlTRAp8ufc9mA9sIGX7yKX0vL3qH1yd6o/HimF7njTwFPfd6F2fPHmMpxH6ehy2QCb78F2W83XigAJsrh8A3cYXWEGGug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(366004)(39860400002)(346002)(83380400001)(86362001)(82960400001)(478600001)(8936002)(5660300002)(38100700002)(15650500001)(2906002)(41300700001)(6666004)(54906003)(316002)(110136005)(6486002)(186003)(8676002)(4326008)(66556008)(9686003)(66946007)(6512007)(26005)(66476007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g1zriHVYurg1rtdKMPTF1ELhGZpnISCHSxJr+Q+7PkPrgLtMkhcJzvGb6lfR?=
 =?us-ascii?Q?zY86VqXeRWvD0vYIFjwcnO3S0/yjwP5QksHjFfEbWbK2ZntAQdgm+IVPQS1B?=
 =?us-ascii?Q?nWDzQB3ZRnsMgKrbmUEsLn4HoU1XHhePf+K/BQiKLwrJORIouSJG64w00T9Q?=
 =?us-ascii?Q?1vQdbC2vOw9WRUZ4uffDnJUe2qk0+EXULQ+eVqVqYJD8QDC+vMqMP3RBGiNC?=
 =?us-ascii?Q?v6PrAprMU0G3pY8Cmok4ayUum+ms9VGtCeZQhLxFMnUfJnYZge/DMsi0Ch7G?=
 =?us-ascii?Q?WDbGa/BlaOda+F+sHHs1OGT4kKAJ/X1RICDx2lm1cyabAJcr4/SrNAXAk+JL?=
 =?us-ascii?Q?+6/Bk0jhXhUXVC1aHgxpkE1N6O/cJePhXIJPCQ4TiXjrK97QS1g5tRfAvRpW?=
 =?us-ascii?Q?6QSHucE9A6MCkmv62wdfs+c5JPxwvVyq4iH1rrev7FsYDXc5lMA3jm27VWzf?=
 =?us-ascii?Q?SqbCsU8LDZX7Sds8xkblgS03sRy4QexMTrpvHh2iS+W6Wzsewj0ZAEwCSmiu?=
 =?us-ascii?Q?PQRrUM3K2Jnwe7/BeKO7mXL3Eut9+GmqaaF09wDPhJ6vqrOkH3jmhHOqhC5V?=
 =?us-ascii?Q?I8wzeekrQKrYjkkN9O8ApYTUmOQJ6vBTcMPad9DpkEAzVNmBOGOucT1jsezX?=
 =?us-ascii?Q?dkHq44u+GXiNaUC9NtO6pcX+6wNcvPd59MBLNrg1jOwkBrWL9mdOO2Ftk9fA?=
 =?us-ascii?Q?9VG0EqtPvIsOwvGMNRKEv2k23IUcgxOnV/cQAYG2Uv1Y5K9vFuVtKtTSmDw6?=
 =?us-ascii?Q?V/WYiIqKtcXM2jYInTUpxLJdlFwnkc55o2KRibeWt/yUnCOFjSmvnDqypsqN?=
 =?us-ascii?Q?ddDxomD4Vd7sGUNBVHIKeKEMcwLJGeQu102DORTHPt+TBOaBrswhzopHlTaC?=
 =?us-ascii?Q?+DIEjYu3puWW38sGXvwNMvMdPrFQBUqVfRbR5pSPJ9Cy3rx93LL1DVJnNYRt?=
 =?us-ascii?Q?ZQq7xVc+RoE8wFLL0fbXaEbqoynonwRCe+MZ4+dnbiwhjW3reHYF8B5jt7du?=
 =?us-ascii?Q?B/2MiSNIBZDAYl2Mz8YoNrMRlsEv5yEJXdHNUOiA96FgqsdEGkNhpCZAsun6?=
 =?us-ascii?Q?l1lt5aCVPpXK3Utkk2PcOUActnZpsRX8LariSyLBL4swh9/oTpTSc5Z95brV?=
 =?us-ascii?Q?fbBqaY4HcWB7NQOvSpYGjK07ubjQeGymRixCSSej+YU3aIGPy/gG6cD4CyrN?=
 =?us-ascii?Q?nELUr1EaIU32o03T62m2hYGYUwAp0x56bPBcbxX1ETCqPASCulqeZ/sqeGJa?=
 =?us-ascii?Q?DS+U2Egh7jlIcpGj6kKeOeBY/YGnGnwF7inbkGrcJzRHQtrWIHJarpZWaGll?=
 =?us-ascii?Q?mjirR9lcXuNfjG8kIA5uxuE+qIuAJMUuRanc5z+kk6ROwydYP4Y68JSkTdVZ?=
 =?us-ascii?Q?YIJz/GmUwQOZgeHMRsLLInJY8OcxUDQxn7xBYvDosp0igckvBZH+BD6QlAA+?=
 =?us-ascii?Q?Nt+1eOJSIn5OCgKWbK+8Dxn41MB7JL0LvXHmcsLiPVzqElsji0zjT3YC0gqi?=
 =?us-ascii?Q?0nQHXu4MQYRSP2fdov7mwKKIjPFsb34ErmVpwcfOSTYyxP+l80DOqGsr2f8a?=
 =?us-ascii?Q?642KAWChrUfrOp+fbmwcDzY5XHO43I79Z8wKzepcMX43C7VYQwEBp4xSjUnh?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 215b9b3f-46bc-451d-2414-08da65492e7d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 03:30:21.5036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+9Zlehh+4LaP5R/4nNTM/+2HN2yv0EXRsHSIqsTamKsvKeSKJYeBl1pU2jBmF03DuB8+K7ewhRZ8VyZtShmcMqapyDyg1sHngjNkoK/gGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2340
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> DOE mailbox objects will be needed for various mailbox communications
> with each memory device.
> 
> Iterate each DOE mailbox capability and create PCI DOE mailbox objects
> as found.
> 
> It is not anticipated that this is the final resting place for the
> iteration of the DOE devices.  The support of switch ports will drive
> this code into the PCIe side.  In this imagined architecture the CXL
> port driver would then query into the PCI device for the DOE mailbox
> array.
> 
> For now creating the mailboxes in the CXL port is good enough for the
> endpoints.  Later PCIe ports will need to support this to support switch
> ports more generically.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V12:
> 	remove irq param from CXL
> 	Jonathan:
> 		remove xa local variable
> 		clarify MB creation as best effort
> 			But ensure pci_err() if they fail
> 			Check devm_add_action() return for failure
> 	Davidlohr and Jonathan:
> 		Return error ...
> 
> Changes from V11:
> 	Drop review from: Ben Widawsky <bwidawsk@kernel.org>
> 	Remove irq code for now
> 	Adjust for pci_doe_get_int_msg_num()
> 	Adjust for pcim_doe_create_mb()
> 		(No longer need to handle the destroy.)
> 	Use xarray for DOE mailbox array
> 
> Changes from V9:
> 	Bug fix: ensure DOE mailboxes are iterated before memdev add
> 	Ben Widawsky
> 		Set use_irq to false and just return on error.
> 		Don't return a value from devm_cxl_pci_create_doe()
> 		Skip allocating doe_mb array if there are no mailboxes
> 		Skip requesting irqs if none found.
> 	Ben/Jonathan Cameron
> 		s/num_irqs/max_irqs
> 
> Changes from V8:
> 	Move PCI_DOE selection to CXL_BUS to support future patches
> 	which move queries into the port code.
> 	Remove Auxiliary device arch
> 	Squash the functionality of the auxiliary driver into this
> 	patch.
> 	Split out the irq handling a bit.
> 
> Changes from V7:
> 	Minor code clean ups
> 	Rebased on cxl-pending
> 
> Changes from V6:
> 	Move all the auxiliary device stuff to the CXL layer
> 
> Changes from V5:
> 	Split the CXL specific stuff off from the PCI DOE create
> 	auxiliary device code.
> ---
>  drivers/cxl/Kconfig  |  1 +
>  drivers/cxl/cxlmem.h |  3 +++
>  drivers/cxl/pci.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index f64e3984689f..7adaaf80b302 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -2,6 +2,7 @@
>  menuconfig CXL_BUS
>  	tristate "CXL (Compute Express Link) Devices Support"
>  	depends on PCI
> +	select PCI_DOE
>  	help
>  	  CXL is a bus that is electrically compatible with PCI Express, but
>  	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 60d10ee1e7fc..360f282ef80c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -191,6 +191,7 @@ struct cxl_endpoint_dvsec_info {
>   * @component_reg_phys: register base of component registers
>   * @info: Cached DVSEC information about the device.
>   * @serial: PCIe Device Serial Number
> + * @doe_mbs: PCI DOE mailbox array
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -224,6 +225,8 @@ struct cxl_dev_state {
>  	resource_size_t component_reg_phys;
>  	u64 serial;
>  
> +	struct xarray doe_mbs;
> +
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5a0ae46d4989..6228c95fd142 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -8,6 +8,7 @@
>  #include <linux/mutex.h>
>  #include <linux/list.h>
>  #include <linux/pci.h>
> +#include <linux/pci-doe.h>
>  #include <linux/io.h>
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> @@ -386,6 +387,43 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	return rc;
>  }
>  
> +static void cxl_pci_destroy_doe(void *mbs)
> +{
> +	xa_destroy(mbs);
> +}
> +
> +static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u16 off = 0;
> +
> +	/*
> +	 * Mailbox creation is best effort.  Higher layers must determine if
> +	 * the lack of a mailbox for their protocol is a device failure or not.
> +	 */
> +	pci_doe_for_each_off(pdev, off) {
> +		struct pci_doe_mb *doe_mb;
> +
> +		doe_mb = pcim_doe_create_mb(pdev, off);
> +		if (IS_ERR(doe_mb)) {
> +			pci_err(pdev,
> +				"Failed to create MB object for MB @ %x\n",
> +				off);

oh, the rest of cxl_pci driver is using dev_err() and dev_dbg(), not a
big deal, can be a follow-on cleanup to make it consistent.

> +			continue;
> +		}
> +
> +		if (xa_insert(&cxlds->doe_mbs, off, doe_mb, GFP_KERNEL)) {

xarray all the things! Nice.

> +			pci_err(pdev,
> +				"xa_insert failed to insert MB @ %x\n",
> +				off);
> +			continue;

Lets make these error messages more actionable:

"Failed to setup DOE, CDAT data may not be available"

> +		}
> +
> +		pci_dbg(pdev, "Created DOE mailbox @%x\n", off);
> +	}
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -408,6 +446,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(cxlds))
>  		return PTR_ERR(cxlds);
>  
> +	xa_init(&cxlds->doe_mbs);
> +	if (devm_add_action(&pdev->dev, cxl_pci_destroy_doe, &cxlds->doe_mbs))
> +		return -ENOMEM;
> +

This belongs inside devm_cxl_pci_create_doe().

>  	cxlds->serial = pci_get_dsn(pdev);
>  	cxlds->cxl_dvsec = pci_find_dvsec_capability(
>  		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> @@ -434,6 +476,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
>  
> +	devm_cxl_pci_create_doe(cxlds);
> +
>  	rc = cxl_pci_setup_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> -- 
> 2.35.3
> 


