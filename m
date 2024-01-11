Return-Path: <linux-pci+bounces-2015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 818AA82A577
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 02:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075E6287E3A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 01:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EB639C;
	Thu, 11 Jan 2024 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPuP9jZ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E15393;
	Thu, 11 Jan 2024 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704935505; x=1736471505;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z9GVYUEW98AYXks0XRe2hG8Y1PD3RcSQIPgvCc5RYCc=;
  b=ZPuP9jZ4IWFCPnQe8OSP56zcpKrafzqc1nwyKmviZ6qVQmtB5nhL+22w
   jFpHTdJK4zJ1PhicMQ3HGqhs7rGXOT/OUNp8n9Svdj+myMQqiRZJHOJEF
   i1rOWbD/yaHfE/h+8sNUZh4uTJBBjk6jZGFDMaU3Ei4yBtvE8mh19+e1K
   t7LGLxFsbTt0ZI0km8igVib3VgMaMF3UpktzAJBLhLyxqpQVBM3/u3MQc
   M0hChyjeaY5Ra1z0R8g0x/g6F6rZKqS26NuzUpzQj2z8aFuzhOfAUoy/t
   oGbCQuIRBg/FagXV8haPLUv0X6TlVDQ2smQSKj5sV6inWni8U4X+pJDPk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5434737"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="5434737"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 17:11:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="758576711"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="758576711"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 17:11:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 17:11:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 17:11:43 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 17:11:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA/iovudhJrSxcdNpiIsZ+/qUN1wbDUM+VZbjOZ4JLBMNMQD3GKIUH9Ks8rCD+vDqkLLs+yfSli3SAkP8OQARxAzsmkZgDLlWPAmUGYoEBQVoJE+L1+D1xD9eGOGIhfPzXkFHREOFAf9uuzNbhxVuLE0sfqS3qbm5ZrzCpmuW8KSZC0ovNVqLp/QWV8PoW0iqTtHhBNconyvuICvI5XnokaHnsTb69WaLrQgL2WgYqL0xK+1Ci7ZNDXFLFgJDamt252J3ThxAm6L3ONYGdPEUyEuCrqaqFWAybtHLwU+KtmFipZJa6xQBz5uQ+Ezv4FA4jwK7pSTsbbmD/2Egu/vIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKoiv41EeOaHiUTvPj3GegvnuGiDcbESZVLt/bsTPAY=;
 b=Rhau7wlKFf4kI9ZBUZQWM7efjFv4F+HfG3ZQ9qD+ZQpx9Ioj3g5SJejGh0pwN13dqTy5etkZmDalCgvrZddFfteAJRjPYHTMu8/rDBWYvSFqurTBW8WIkpKjrA+gov4QbLj6Uxrg2hp5RTS6EywC9lOCLP8RsXGiprrpFIzW4X77vooql5ZZvffRdtjBMbDNSsVN0G4KF4sLGQUqbTSD6LTXiF9wJqfAaHgQJ7MNestcSq/BI9BT/fqb72ugKiAWLiFl2s4B8EASfoUboZt0miANnoCUFEKX7TbfxTmDYqIC1GqT1a7kGLsxCPh0VvBuWduB/uNMfE2LJOMSuKdviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 01:11:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 01:11:41 +0000
Date: Wed, 10 Jan 2024 17:11:38 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, KobayashiDaisuke
	<kobayashi.da-06@fujitsu.com>
CC: <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>
Subject: Re: [RFC PATCH 0/3] lspci: Display cxl1.1 device link status
Message-ID: <659f404a99aad_3d2f92946e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>
 <20240109155755.0000087b@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109155755.0000087b@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:303:b8::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b0a5ae-11fc-4eb1-a865-08dc124244b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BzPSpsEpsJTSl4ORKJXLx5ivh8RPUc1aDvP2UCRqdMs14zD74nnS71CwBDxaJ6UXheDUNFX/Hp6k8PuClMugrl5V+2Pa1G7uCp2PMuCuibYyWcJYoX8oPhbbuV78dG596FYcaqYLkn/83jLBgP/IJtgqayESQuiLdlffSroTyjBqppqyQUHPb3IHdNHFCi4UknSsGfkpD17M510PMtr4kzIx9JkNMxk/U2c8XrlLmvG+oB14Gcr5PD3q/EOxwhXnGKFE3lm9nNWD23yIpCisdH+Eb1ZTGnMuA8hAPpEcz2wU8qDj89Sw9e/QApPbIlLZjP1qeQBwVahOPqYPyNXqLDdJkNmK8hU0lZW5FNwtHyD4FbSDEQtdDQRKnA7wPco3j9kx/yy/mraTIwH9LULMiJOSx/a1wzkXbQyubGW3W0Xh52jsuLZ2EBp/Hc5nNLOx/wLF62jQcmDMSKQbDbM/YIefGcRA8fEh+bBs0UF82DaMasnjOOXS7+Wf1kG+HQV6CpX30KWWr1upffjpPeOoQEGGF1BH3bMCy0459Lf2FfN5DCGDivJj9cptYtWpGb9A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(86362001)(82960400001)(41300700001)(38100700002)(6486002)(26005)(9686003)(4326008)(6512007)(66556008)(478600001)(6666004)(66476007)(2906002)(316002)(66946007)(8936002)(6506007)(110136005)(5660300002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x0wDjDrwgUqEw+Z/dwSPkeQp16J6QQe13S4LDc5Nm6W3uVZaeSKuOiATNx3Y?=
 =?us-ascii?Q?MWgeZdElJSF6L5jNXAGeQuDztvpCeKFVtF68jZ3MBdGJzjlBlhaOV8EREE2y?=
 =?us-ascii?Q?w6bQEOZcZgtQtrdNSWlWAEs7neUzxW1gm0NKWN8fvxJXHe2ZWYpF3YSQF2aB?=
 =?us-ascii?Q?HX5x9TvKyrDTGRu9TlMtBCnc/3en837OGPwAdk2azb1tvm4BLmw2PH1Jmu4c?=
 =?us-ascii?Q?OruKLts2oNksMR8ZUIvzFQ+MQHO0Kh4hb5nBGHDxf83+0XmiEWZmpb4/HHT6?=
 =?us-ascii?Q?jqELflPA2Px8CtChUu8MbAs1QLxWnYL9qvbDo1PGiq6iMLHlNhrzKQ686Bhg?=
 =?us-ascii?Q?0NQk/gJcdHhKmVEB4426EIXtxqOn7+qir54zQ8vUZcDEfxQXjGxuvVh8c9tZ?=
 =?us-ascii?Q?yIB3U6T9fue/siPyC5rI7BXOLO0zNL7HH799iGOaubFUjesI7oNWM5X63/Q8?=
 =?us-ascii?Q?7b90BZ7qqG10J2iZJ6Ds2hmYGWel/ynA/JtM9POH/fezjDUAg1vXMtpfCAsZ?=
 =?us-ascii?Q?hGiejB+yhJpIZfynplv3oGP4gaHN9vy9qvlr9ybRHspzz+czzUly+0gFiaz1?=
 =?us-ascii?Q?VgPsOq6+/1z+PITFuzYAiIiqICf0ucBhVn1MY0Sj9T2XDKH3OA3pkoO2R0l4?=
 =?us-ascii?Q?ftU0W8zS10+o3+oc+mbI8LBt+AgwsoywgzmG7vrXwh5ogyRFWMGyeKW5rtV7?=
 =?us-ascii?Q?KBx7QkZrdBelJe8r3ekohG1o+MoxhIwRWANNtLjL7zKwL3ICTjVO2oxifzwj?=
 =?us-ascii?Q?EjU28+r1Lvx3f0xl3S7GCuNbFGVydzc1IqX7QAZGrnFE8kscw8trWhfFD1+9?=
 =?us-ascii?Q?GECxEBlKQWyXdSZDU5AhT5o4uSUFpwwThq32+Sn7z0k7ZgQ7gYOuWWYwWFph?=
 =?us-ascii?Q?dGf6OCUK2XN9L3YqnPqMv/3MWKHAQ2oBn5pmioDaidVXJK1Rvd9koM+Fio4t?=
 =?us-ascii?Q?6NtqfiXOARVLxA/zBgKotdqjQWJHUB8HoPTuRYoNkHm0o2IeU96ILwgzWXmR?=
 =?us-ascii?Q?FVPMheJCatXmkGx+xGljCThz3eeUxQkdabsTpIOdOPsrMq8EpdlSTZWcFw0c?=
 =?us-ascii?Q?YrG2ObgCakt6KIcT38qqpxx8ummn4s0IKVX36pinaBpfU+zKZr5AES6zuOeF?=
 =?us-ascii?Q?95w40M6ccEikkNht1/hPSAo1786nhNqudAL89+RpsfYP6aixJRT3W4amBCg6?=
 =?us-ascii?Q?0e3TmLcG9FQKmgk3I745USaZtgcwbYARw38KQrPWQeRMDAD1fnYHlfdYsKDL?=
 =?us-ascii?Q?nw2e5VOLAS+XqdpuVE3fUiSuLfzO4gA0JJekVE14bPrW14Wc1eYwwVcOyjjH?=
 =?us-ascii?Q?x4yokvKSTJ6BQP4Gs0O2QEsJLz36V3e4MkwIHHB2JZnamqnHPW7eD01vuxIU?=
 =?us-ascii?Q?ZVqVVOCg5FPBiyJubeHraqwngRqhthkC+ow67IycJXkOv78LiBRYBqXGM6bV?=
 =?us-ascii?Q?XE/iUWJPKL6bnuLzc006CRu8l+VIJtsVS7hRC3Yp83k4qFOywMXXBrpUQRCc?=
 =?us-ascii?Q?fnOgpdtGcLVEG1lO7vQiIWEounmC+1wG+/AJRiXO61t2kST5YUoeMNWA7D5D?=
 =?us-ascii?Q?+YTPN/qtk5V7SZY9gJNMdezuUWLfw2x5HwJj1sWbdv4TRWHdzAoqGmsgJQ8C?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b0a5ae-11fc-4eb1-a865-08dc124244b0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 01:11:41.0919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XG5giPsiK/OthddEJQacWu+5PZ/JJKhoRe9Sqg7NLi8H74uM9hTFJwkGbTwjVxgd3S4y84QmjgEl/zyBB5AK3rCTVfHN34AqGtV37K/RtUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 20 Dec 2023 14:07:35 +0900
> KobayashiDaisuke <kobayashi.da-06@fujitsu.com> wrote:
> 
> > Hello.
> > 
> > This patch series adds a feature to lspci that displays the link status
> > of the CXL1.1 device.
> > 
> > CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
> > the link status can be output in the same way as traditional PCIe.
> > However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
> > different method to obtain the link status from traditional PCIe.
> > This is because the link status of the CXL1.1 device is not mapped
> > in the configuration space (as per cxl3.0 specification 8.1).
> > Instead, the configuration space containing the link status is mapped
> > to the memory mapped register region (as per cxl3.0 specification 8.2,
> > Table 8-18). Therefore, the current lspci has a problem where it does
> > not display the link status of the CXL1.1 device. 
> > This patch solves these issues.
> > 
> > The method of acquisition is in the order of obtaining the device UID,
> > obtaining the base address from CEDT, and then obtaining the link
> > status from memory mapped register. Considered outputting with the cxl
> > command due to the scope of the CXL specification, but devices from
> > CXL2.0 onwards can be output in the same way as traditional PCIe.
> > Therefore, it would be better to make the lspci command compatible with
> > the CXL1.1 device for compatibility reasons.
> > 
> > I look forward to any comments you may have.
> Yikes. 
> 
> My gut feeling is that you shouldn't need to do this level of hackery.
> 
> If we need this information to be exposed to tooling then we should
> add support to the kernel to export it somewhere in sysfs and read that
> directly.  Do we need it to be available in absence of the CXL driver
> stack? 

I am hoping that's a non-goal if only because that makes it more
difficult for the kernel to provide some help here without polluting to
the PCI core.

To date, RCRB handling is nothing that the PCI core needs to worry
about, and I am not sure I want to open that box.

I am wondering about an approach like below is sufficient for lspci.

The idea here is that cxl_pci (or other PCI driver for Type-2 RCDs) can
opt-in to publishing these hidden registers.

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4fd1f207c84e..ee63dff63b68 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -960,6 +960,19 @@ static const struct pci_error_handlers cxl_error_handlers = {
        .cor_error_detected     = cxl_cor_error_detected,
 };
 
+static struct attribute *cxl_rcd_attrs[] = {
+       &dev_attr_rcd_lnkcp.attr,
+       &dev_attr_rcd_lnkctl.attr,
+       NULL
+};
+
+static struct attribute_group cxl_rcd_group = {
+       .attrs = cxl_rcd_attrs,
+       .is_visible = cxl_rcd_visible,
+};
+
+__ATTRIBUTE_GROUPS(cxl_pci);
+
 static struct pci_driver cxl_pci_driver = {
        .name                   = KBUILD_MODNAME,
        .id_table               = cxl_mem_pci_tbl,
@@ -967,6 +980,7 @@ static struct pci_driver cxl_pci_driver = {
        .err_handler            = &cxl_error_handlers,
        .driver = {
                .probe_type     = PROBE_PREFER_ASYNCHRONOUS,
+               .dev_groups     = cxl_rcd_groups,
        },
 };
 

However, the problem I believe is this will end up with:

/sys/bus/pci/devices/$pdev/rcd_lnkcap
/sys/bus/pci/devices/$pdev/rcd_lnkctl

...with valid values, but attributes like:

/sys/bus/pci/devices/$pdev/current_link_speed

...returning -EINVAL.

So I think the options are:

1/ Keep the status quo of RCRB knowledge only lives in drivers/cxl/ and
   piecemeal enable specific lspci needs with RCD-specific attributes

...or:

2/ Hack pcie_capability_read_word() to internally figure out that based
   on a config offset a device may have a hidden capability and switch over
   to RCRB based config-cycle access for those.

Given that the CXL 1.1 RCH topology concept was immediately deprecated
in favor of VH topology in CXL 2.0, I am not inclined to pollute the
general Linux PCI core with that "aberration of history" as it were.

