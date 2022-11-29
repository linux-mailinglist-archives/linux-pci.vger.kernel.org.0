Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219D763C090
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 14:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiK2NJb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 08:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK2NJa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 08:09:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE952F2
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 05:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669727366; x=1701263366;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0OYjpko6KisWqTtLfreGKX+rXqbqIB6my6A+ynHlMDE=;
  b=ZycWTrhy0lN6nBVgc9FRV3rVDaeTo30aeLOObIrG/OKjZdy1lT44NAnc
   0f2RWBkaHS3gFkyTxucYr8Ow65IgvQzFrzMF4l3R61Gbxx0i0W+GD974b
   3V8iLI8t6RMZV1sqHPK6HYzPmOOiQo0BT6fzMc5rnlM3r2+43fkn+73He
   BfPghiwlC0P4Ucg3URxDb+T1uUFAHHEepCcPwKuX1yjwFCOxnA7XxGEX3
   YTeBcU03Z8LJmNe2MzmjXS8lyA1Sqh02V5Q2ZeNe59afFuHOEVhktgtOy
   hHs8FMbkYFfeSCQO3K8RruWn8IyNUCPeM34NQVo6XtAOxVIL3wffjWlo7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="313804072"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="313804072"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 05:09:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="972665735"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="972665735"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 29 Nov 2022 05:09:25 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 05:09:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 05:09:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 05:09:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 05:09:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYuy90wh5/cxn9ViD/kWmLsPh3MnELVXfiVUXuLEqME3XIqzQKzN+gL4Jtph0IQXc6i919nhlGyMooIyeYVzvPVKHIGm+fgFHiOgv+QnmqgGSiHo41aELouqBAh8ME6+Ilsn5duYZGM3A08z2K6SZpgwR3faGxBvfs/7AfPmYrf1ieWivdGESHFtYmHdzF6ZSDVbePw5thpVib3vVZ9MKHXVwJHZ+mACLF2MnNP/GPNr/bWMsNQyKd6cEoKEas8BLs1+Eg5cE0mCfjSKpYkAEoFz+kbv28TqveRoaUNEJJmoe2a/StQhSxNk9utXHlG2XKonAy56GiRPyCKCRPnKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnBlnGrfeK+NofeJzUKT+Fm7MUTuxSk54oJSaWTc0d0=;
 b=T4dS8w6GmRdM3GgMVc/M5Kq+8O9vypF5eednkwLXyb5fs29NpzKlIVNw1FJ97Lz9i6hscvG+t7AEaeIbBfwYMqUAEhBSVZ6+8igLFMU/9TzVSJV7sWob7NefPbDK7HeMwRFX4ivCzjS/SoKpmM8sPQ6fTXjmLoGSqjM0vNvftteGjy0OfgrS6dAghrD/vCrpHJSmvjxDWjrU1IOYs4xf+p4+ux6XkPMyKFjAkhe5dy7ZAUYnAhLGafFkRdowfnJUzDKFHT+y5PYUpZCE49sSn8dypiZFXFmJtqN5d0htJAqz0jEh/6N3iYyOtvOHccN8T6wsP5cNMNijxbcOIKDtdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM4PR11MB5392.namprd11.prod.outlook.com (2603:10b6:5:397::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 13:09:23 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%3]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 13:09:23 +0000
Date:   Tue, 29 Nov 2022 05:09:18 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        "Sathyanarayanan Kuppuswamy" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Ravi Kishore Koppuravuri" <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] PCI/DPC: Add Software Trigger as reset method
Message-ID: <Y4YEfrG2jFLiEyoP@a4bf019067fa.jf.intel.com>
References: <9c1533fd42e9002bd6d2020656fa1dd0e3e3bf3a.1669706952.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9c1533fd42e9002bd6d2020656fa1dd0e3e3bf3a.1669706952.git.lukas@wunner.de>
X-ClientProxiedBy: SJ0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::17) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DM4PR11MB5392:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4fb034-117f-454d-011f-08dad20aef50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2kp7qUlNWd1gkGT3IsS/ZNIdOxb2y9mhMwzwS9meLBAHZR1SUd6DZapyglRHx+k1qNN7WwJgjXpQfQLPh8q4cA2SpdTcWKBwW+M4B26PaOE2bwmJyPMMh1xuFyteCDjOgXtVIhw15KPZ1A9b5D2wupIkwRZhXIiLzGfX1c12bcmdu+WBwXxuxieZwbdnr8qJGsKIggGAg/3FGYzgM0osVWGSzgbBsgrVtqtvQsae5Mum6wjK5KbymXp9th+XPiJAEpQpFbb6KC/4lMtdG9joGFzPayBnPm3lGr6zd3JbWZGcUoQyX+fK2KqdAw57GQ7R+RoYzkbimcz9wgUwDSTXnAU7FHqE/t8/RWooukWhbs59/vG3Z3u2PUeGE+6mEFuzC2zZu1PEbv4oVswFmiUcZRXD5JG4WdR+8jRzVQEkVVbzKLhVn9NZDIVvK6XCBPThjvN1NkZkR0IhgDoh+d1s+9stuZpExxxtCCMj88H71DpSANAlSAmNSeyYOwF5MNMUH/YNLUNqwPbaBl/kc5tnf95oV2Xp2g9bWUUZHPP9Tds9IgtqzIDZnFbEBiB0E5jgxl87gz3tB7+b4XXLNLOPXkaeQmUG8YDzaU2fMpBWygoVes/ReDDcGYLnBm5S+rox4nEqh4wJZO+MUDZb/Wr7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(478600001)(6486002)(2906002)(83380400001)(6666004)(66946007)(54906003)(6916009)(38100700002)(5660300002)(44832011)(66556008)(8936002)(6506007)(41300700001)(4326008)(66476007)(8676002)(82960400001)(86362001)(26005)(316002)(6512007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MUSBzThPX0cMZFpvop7qyzxd6axW65K2zv2haySsxgSjOE7Iy+orToD67X5o?=
 =?us-ascii?Q?5vRBnSBfXddNH/s/L1WcnFdusnefaTFCmxMgduQgyXjUUy8mjw2bnlQkVEhk?=
 =?us-ascii?Q?+t0thoQuUd1GOhaNjKXMjsvsRQrY8OyOT+uDS8ckrbGrqvAYUW5wZqBMyt9U?=
 =?us-ascii?Q?MOTusFNM53sPE819aSHkv/1ZJmKjg3IdzZPeyWvKzAwbteb5Uuj0ycJqgV0Y?=
 =?us-ascii?Q?5RJKMQpyj+DyNZc49uDAeapy0sPH30sN9Ffv2oIciM/2d/ke1BtijV5g4DsO?=
 =?us-ascii?Q?T7v9wR/yJpB1NjV9074RPSPhOoNV3joE0UGJMusGH8z8GEannCNys0Rf4wdY?=
 =?us-ascii?Q?cDE0b3vcJQrbh3EhRuf0TLv2shrFWpQAOIUO2KV9jmgK5an3wY6I6wJbMnYT?=
 =?us-ascii?Q?RDgqT6F8Hf+586qlQIAhoHz/Nl+FhPTA+U6igYTMyy04Bpabh6D2vnpn3t27?=
 =?us-ascii?Q?ZW+B2Z/R3B62OxkgEoTKUPq4JxK2MiZw/BOy66pU98Bdv3V1vE02H0ftSXmM?=
 =?us-ascii?Q?jxmu37M/PFwF+xnSQXkWlVH5AUUmV4T6QXadCQ6L7VfCnwAWxaOoYB/Zq/aw?=
 =?us-ascii?Q?ccU+M/5hsG+jtWQNlDRl7tdHfLIagDi2NvzlodhqQ6nbRIduQV4bP37Eu16t?=
 =?us-ascii?Q?B1VehSI62WxHTftqoT6bp9XpiYI/DbznX33egMjgnlBrbhIydliCAi+S1MzL?=
 =?us-ascii?Q?qclDipPjWwPbcYWO1EPKuaQ+vRpvmyXu2aGjDr50b7kdPESZsWFxBbyPnpLS?=
 =?us-ascii?Q?MpkP338oHKa3fXGq0T3XIua6nliQsSep/Azz5fRuPVKe3YQpl5mnVeLcwKwY?=
 =?us-ascii?Q?cn3aUYbWjiSYTxXZ2fz4MzkmJHRuPD2DXCin/+5REr7Z6505w5lzF55XZO4A?=
 =?us-ascii?Q?fRovFXyptPf7i4ZT/ylgj0ZsD33NrswE9WQee0f00iyN2F1/M5dp6BFd9EA1?=
 =?us-ascii?Q?rhlo6i0GuQwxyCBLiZeSDCrWUqsujKr8zZNvor3luf2zLGyFNdU5fb6PxxoK?=
 =?us-ascii?Q?1+INIUpSjEKJ4H/K5RTp6I7zzeSLLpRh/JQCvYAKC3xnf3/LfTLWSL+xQ+q2?=
 =?us-ascii?Q?bf4ZcGSlRGSW7/MystoYP8UsnWfxb83dko43RNNzVm4nNWKZ0PFYGa7PuFTm?=
 =?us-ascii?Q?V7Gx4nJk0ZsFKW/bFon2kgSHxwHEi1VGcUKdcOruN9EkIl//R2hLb1U7/HQw?=
 =?us-ascii?Q?WGhfplIak4wgotUQOr22juFLMuY61MEkvPUrhGpsMgeQ63gGHfKW8F/kU6eX?=
 =?us-ascii?Q?dZwjC5TzjKvjEZXDLKkZ806GGqjA6YNXTZ00BEBiJmcJGUjBPmlsca1dtBRj?=
 =?us-ascii?Q?Exape3FI+ldSfxwqqCDhgNNJqLXLZ4FPyrasnVeyOHg5+UTpS2lL53dHJUir?=
 =?us-ascii?Q?T+PSHPjVN/ueKaWqRyYUsNowH1iNs1fycAqAbd+TXAP88rxo8wNs8mldQFOK?=
 =?us-ascii?Q?S2m+wZCEohFfZ6cJOBzCit45de0MMDBdPcsv7KSvLHFGFf/ENy+HT1ZaUvp+?=
 =?us-ascii?Q?+vaSafRpgxPjr6LhO8WAVWogBZdcGib12US5ai4R8ECoviIC7rq52uCCg3l8?=
 =?us-ascii?Q?XO89EZeT67YmSyO9jiqgEN816a/6quxYBOxnzsFwS804KljOcd6bNDelUJxn?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4fb034-117f-454d-011f-08dad20aef50
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 13:09:23.3787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gx1+deQksAd7cPYdJIKiCRPLy9ZE+CGKGO9FeiTC4I8nxm8UGCelTlHiHuq05/C1eJx8epCLCYNHB1hfQLuWHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5392
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 29, 2022 at 08:35:55AM +0100, Lukas Wunner wrote:
> Add DPC Software Trigger as a reset method to be used for silicon
> validation among other things:
> 
>   # echo dpc_sw_trigger > reset_method
>   # echo 1 > reset
> 
> After validating DPC, the default reset_method(s) may be reinstated:
> 
>   # echo default > reset_method
> 
> Writing the DPC Control Register requires that control was granted by
> firmware, so expose the reset_method only if DPC is native.  (And AER,
> which must always be granted or denied in unison per PCI Firmware Spec
> r3.3 table 4-5.)
> 
> The reset attribute in sysfs is meant to reset a single PCI Function,
> but DPC resets the entire hierarchy below the parent.  So only expose
> the reset method on PCI Functions without siblings or children.
> Checking for that may happen both *before* the PCI Function has been
> added to the bus list (via pci_device_add() -> pci_init_capabilities())
> and *after* (via reset_method_store()), hence differentiate between
> those two cases on reset probing.
> 
> It would be useful for silicon validation to have a separate sysfs
> attribute for PCI bridges to reset their downstream hierarchy.  Prepare
> for introduction of such an attribute by adding separate functions
> pci_dpc_sw_trigger() (to reset the hierarchy below a bridge) and
> pci_dpc_sw_trigger_parent() (to reset a single PCI Function), where the
> latter calls the former to trigger DPC on the parent bridge.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Minor nit: Do you think debugfs might be a better place to stash some of
these non-production use cases?

Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  drivers/pci/pci.c             |  1 +
>  drivers/pci/pci.h             |  2 ++
>  drivers/pci/pcie/dpc.c        | 57 +++++++++++++++++++++++++++++++++++
>  include/linux/pci.h           |  2 +-
>  include/uapi/linux/pci_regs.h |  1 +
>  5 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fba95486caaf..f561f84a8bca 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5225,6 +5225,7 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ pci_af_flr, .name = "af_flr" },
>  	{ pci_pm_reset, .name = "pm" },
>  	{ pci_reset_bus_function, .name = "bus" },
> +	{ pci_dpc_sw_trigger_parent, .name = "dpc_sw_trigger" },
>  };
>  
>  static ssize_t reset_method_show(struct device *dev,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9ed3b5550043..da2a3af4c46c 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -425,11 +425,13 @@ void pci_dpc_init(struct pci_dev *pdev);
>  void dpc_process_error(struct pci_dev *pdev);
>  pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
>  bool pci_dpc_recovered(struct pci_dev *pdev);
> +int pci_dpc_sw_trigger_parent(struct pci_dev *pdev, bool probe);
>  #else
>  static inline void pci_save_dpc_state(struct pci_dev *dev) {}
>  static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
>  static inline void pci_dpc_init(struct pci_dev *pdev) {}
>  static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
> +static inline int pci_dpc_sw_trigger_parent(struct pci_dev *pdev, bool probe) { return -ENOTTY; }
>  #endif
>  
>  #ifdef CONFIG_PCIEPORTBUS
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index f5ffea17c7f8..47fd69d0a9c2 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -322,6 +322,63 @@ static irqreturn_t dpc_irq(int irq, void *context)
>  	return IRQ_HANDLED;
>  }
>  
> +static int pci_dpc_sw_trigger(struct pci_dev *pdev, bool probe)
> +{
> +	struct pci_host_bridge *host;
> +	u16 cap, ctl;
> +
> +	if (probe) {
> +		if (!pdev->dpc_cap)
> +			return -ENOTTY;
> +
> +		host = pci_find_host_bridge(pdev->bus);
> +		if (!host->native_dpc && !pcie_ports_dpc_native)
> +			return -ENOTTY;
> +
> +		if (!pcie_aer_is_native(pdev))
> +			return -ENOTTY;
> +
> +		pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP,
> +				     &cap);
> +		if (!(cap & PCI_EXP_DPC_CAP_SW_TRIGGER))
> +			return -ENOTTY;
> +
> +		return 0;
> +	}
> +
> +	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
> +	ctl |= PCI_EXP_DPC_CTL_SW_TRIGGER;
> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
> +	return 0;
> +}
> +
> +int pci_dpc_sw_trigger_parent(struct pci_dev *pdev, bool probe)
> +{
> +	if (probe) {
> +		/*
> +		 * Reset must only affect @pdev, so bail out if it has siblings
> +		 * or descendants.  Need to differentiate whether @pdev has
> +		 * already been added to the bus list or not:
> +		 */
> +		if (list_empty(&pdev->bus_list) &&
> +		    !list_empty(&pdev->bus->devices))
> +			return -ENOTTY;
> +
> +		if (!list_empty(&pdev->bus_list) &&
> +		    !list_is_singular(&pdev->bus->devices))
> +			return -ENOTTY;
> +
> +		if (pdev->subordinate &&
> +		    !list_empty(&pdev->subordinate->devices))
> +			return -ENOTTY;
> +
> +		if (!pdev->bus->self)
> +			return -ENOTTY;
> +	}
> +
> +	return pci_dpc_sw_trigger(pdev->bus->self, probe);
> +}
> +
>  void pci_dpc_init(struct pci_dev *pdev)
>  {
>  	u16 cap;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 28af4414f789..7890cd4eb97d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -50,7 +50,7 @@
>  			       PCI_STATUS_PARITY)
>  
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 7
> +#define PCI_NUM_RESET_METHODS 8
>  
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 1c3591c8e09e..73b3ccdffb3a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1035,6 +1035,7 @@
>  #define PCI_EXP_DPC_CTL			0x06	/* DPC control */
>  #define  PCI_EXP_DPC_CTL_EN_FATAL	0x0001	/* Enable trigger on ERR_FATAL message */
>  #define  PCI_EXP_DPC_CTL_EN_NONFATAL	0x0002	/* Enable trigger on ERR_NONFATAL message */
> +#define  PCI_EXP_DPC_CTL_SW_TRIGGER	0x0040	/* Software Trigger */
>  #define  PCI_EXP_DPC_CTL_INT_EN		0x0008	/* DPC Interrupt Enable */
>  
>  #define PCI_EXP_DPC_STATUS		0x08	/* DPC Status */
> -- 
> 2.36.1
> 
