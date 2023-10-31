Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3D7DD519
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 18:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376419AbjJaRrS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376423AbjJaRrQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 13:47:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B62DA;
        Tue, 31 Oct 2023 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698774433; x=1730310433;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z+Ln+aIehS39v1r+jcuApCy/UDmCuP7Oev5KB/w6ank=;
  b=YFSMRVCaq5UZf/JnoezNv2PhN8wbet4rDKdCfX1mCtyVly6M7AwzfiJI
   4S+7v+0XYzQIeL5m9RbKo87cl1r9ul4lf6mfGdfO8cSQnGIQ9AHyU86fk
   H0M+NmeaMWG/SIiDJzbf4ySVi7D1Q9m5gpeNdBTdesNr1+yq65NsR/T3I
   zGYZp91yPvG5RwtXwp9yLnJlAfwlfIi3s9vBDV0bozLeEiyP8TZi7ZbIH
   U8n98ujXzDNANfVHR9w6X2useq2k5A6N+ShJ3dHQJIJHF8EerFYoQDx6y
   nf3Q0Se09JwszCkxT5cnMAbZkMCol1mpVnPgrChKcUNBtNMJLpwEfTcSY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="368550378"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="368550378"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 10:47:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="795656232"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="795656232"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 10:47:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 10:47:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 10:47:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 10:47:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZE+DVIcGXHnqU1c6a/ucHw7cRf8QV2avIF9XilpkVFnTaFcpsdAXlPCaSIBkGUF9P8Ep9jEuiV1BEaeD9syj4dq/taJ0tJ8g9/deLECryAOqGdqXKCigAWPhjJ+Qg8GwySScrjqLH9W1+G5YnJm4owubWxYkuxJhcP2wKqXkK3i1ZER7tTWwq44Xs+UDZySuioILTvyOKlftA4z5gb+3Zyi6Jl3ZGH9d1Mvn9w8kTBm6AwKFgHhV+qrEgCsI/HmyumBlxNCHocx25+xcHuRL4SUWjpjtaiqL5IqSmcBpU9KS/yNwUbgziJndJrNSOkzF6lCm8fdMSbCZ7Me5DczgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izVKngJicZs5XLgQW5YVf8pHkusKM7gH5U3BEvcIzDg=;
 b=gYn/s+JqLeAtIE31Y0haxkYCfYwhF/nrKvEX3dr2B7b7ro39iUFAAbSCgKg15Wcu0m3/437s811AWmW/6jNQP6DwTZZuV82P3GWGLG4DbDzNcw+d1IYp3Tz5zPYObas+cIvrC+39dlvgbClE/OmJIK+t31oit0Hdhm/V9T8dsXiyGUUP+4/aHaPk2V3MCasUjJfKH0xaJp+xKoraBkp1SjN5DViPcNJ7FKDB2sruhUmcHPzRjypl9JOqESdMGGiORtttnoPJsxOHOB/GwmL4+dC6/Hj6RES/PECTAzxfmhZBWMtVJLbah542Y54IgPf0IrS2pbqHV7CNmyBDwH29Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5393.namprd11.prod.outlook.com (2603:10b6:610:b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 31 Oct
 2023 17:47:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6933.026; Tue, 31 Oct 2023
 17:47:07 +0000
Date:   Tue, 31 Oct 2023 10:47:04 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
        <loongarch@lists.linux.dev>, kernel test robot <lkp@intel.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 c503e3eec382ac708ee7adf874add37b77c5d312
Message-ID: <65413d98d6d5e_244c782949d@dwillia2-xfh.jf.intel.com.notmuch>
References: <202310310457.5LusQqF6-lkp@intel.com>
 <20231031161757.GA11354@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231031161757.GA11354@bhelgaas>
X-ClientProxiedBy: MW4PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:303:b8::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: 13555e45-a10f-4e33-8e5e-08dbda39667c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XM06rREy/25wr6G5T9jLuRopMo/ybTlwU7VscuJf05tKqQz6zpxb3NVw17Xo6P0mBKL7P12aGmcsO1zvyq+Fd4vIsOPouNFM4PryTRNduoi+9bcuCKAFbSqSyU5YdFq7K9VAL14Z2sfHwD1S4mS/JvUK+PmRGpa6wujQNen3nEPqJ5KSRWsJZLFUAI4T/MODRyH320mRc8UjRZ9BwMZ5b38mAhXXH3X40J56wxkHRFm48tq3PZ0zhT/rl/1zI9jfrBGKzJPO+2LelHo7ylqVdP3HvnElsYHDGDZgh+cIRoytfEL3jhMw42THXTLhglYjjfr+fsrOd0ZDGAxHgZxSZcZoyCiQTFWnOeT/CDQCfQNGCt9OduXbYrTKzP32WMZeL4GbMMW3PRS6JD+GlSqWy6ube1rA/oV4Q71vJVEyBFhzSr95e32nvSLSFP0FzFtG1uR4NaIjkKwqFCpK5D7p13DKsKF0YCOI1XrZ1lxaOGRSE0r+4tiW0iPC+JHGQxGRnpnJTm0GMkW5QyebSfLjfJSviBc6eNHOfad2kSbEH3c87oEyIeqs9SrrtGc5eEN8pDLCM4yjGLhmTeF7k2iAigP7k+Dx3HyNAecBfG2sgDxwFZU6Uvun1bPmpNjri7NRCMtMbQxrp9d5rzckAbP295jB1HeRTM2TriOVt/D0oazkuReRI57Q1Eik19JC8AFI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7416002)(38100700002)(6506007)(6512007)(9686003)(26005)(107886003)(86362001)(6666004)(966005)(83380400001)(82960400001)(6486002)(2906002)(478600001)(110136005)(41300700001)(66556008)(66946007)(66476007)(316002)(8936002)(4326008)(8676002)(5660300002)(98903001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mChbVHOfMyIaLXzI3Flq43YB0oRQK6BAOVakYmTg4vwBPlOGP3VOHGZYcOdq?=
 =?us-ascii?Q?FwARc3ajF06SMMcgwoNKEJmgFigQNU55MwV4us2yOn7dr+TSYP+baWroT+kJ?=
 =?us-ascii?Q?0L3odW04G/F1QJWPrgqQgCFGzE6OgUNPoXwEW2G3RkPLtXWz0juMMC6T4veO?=
 =?us-ascii?Q?fZc5MbLdovj/D1h9BSKBAuV8tDM65LhCZru8HBbyQfj7PsVjaD64rb5Hno4E?=
 =?us-ascii?Q?wZrTVOTGWm3FD/5KNtSlmxqJPqoFSgnkkawqzYVn7lnHCG9/UONWTulsv0rY?=
 =?us-ascii?Q?iKsoGt47loWjQxXrKQElx8z2DOJ9IdSpJUC1DWH+srtwSLQRoL9XOM2c+TQY?=
 =?us-ascii?Q?dRERnRUWiWlD1ceWWF9ABzNPIN1BSldnPDHuJzcE4VPa2WlBs5nItoO498LG?=
 =?us-ascii?Q?Y0USZB43iUiMH4HB2zqCGhjkMnIWgoJEvqsRmWu7d66Mbygsshbm8akg9YWA?=
 =?us-ascii?Q?KnxDc8Hosz49WugzjEKoomcKrS1FWAtK9NaHCtWrw+Fo2M8UqyQHwfX137lT?=
 =?us-ascii?Q?s8DCcDVeZRaCCiKq1kmZrSmH8ytvmQJjZve5jj2E4DrJ/uVaGmLtnVU3WlE3?=
 =?us-ascii?Q?UFRrCiH7MiQGvri1EkoqrAqePuPyQVI094OEr/5OJ63GlFJ89iSyUUvqAhpY?=
 =?us-ascii?Q?PA/Be1TIwiksi7GQG/hV7PocEwlbr6wGSOIBQftvPeXW/OXVAdeFV3ktFTJM?=
 =?us-ascii?Q?ruiKrBRQKxACNQinqzy8/iH5e2+4K7n7Njc14D8MtMUR9DIxDTsp2HctY6si?=
 =?us-ascii?Q?h5q8U40nrRYP1Ts+j1k6xznMFkIPgoWOvzSxWLzqZTtgLDP1NmA6czvwgUF3?=
 =?us-ascii?Q?+LWcSC0rqMePDRHyW9bpj6Sl9cYiBI969TMZlHKTezgRHUkSBcOFk9w2S30h?=
 =?us-ascii?Q?bH1kGGurJequStVGGNw9+AKGj85G1N2/giD+2h7kxr8ND+Z5gSU35ydszP98?=
 =?us-ascii?Q?1555U3dpN2vb816NeRcxMEk84C/p048Z4uAmqyNFOyJG5B+1wqnRaCPeAXZB?=
 =?us-ascii?Q?Ss2jEMGOkT+QPN13hib2ttzdRrZt3VBYwfibJubX10TfLIFlp1etapGqDQ2W?=
 =?us-ascii?Q?LisOew7Oq25r5PltvRYhrOb0znIPjhL1i3yx52J6wwASaFd4lX41hhNFAHr2?=
 =?us-ascii?Q?SFAWCUec9BaapOtfndI3SlZQhpGlJ8TGhTbdwWWQcbBZWgSzdM75pZSMNw1D?=
 =?us-ascii?Q?pzFV75iDRPMwfJghuNqRL+1EQAveG1RtEZVQ2vCnnl5UcvRGwrabyJvS/nN6?=
 =?us-ascii?Q?yo/Ms66dyPAByn4vBnTW3BSET2erHV8J+HTxPFRU2QXm7Uegz4tLx061ELgP?=
 =?us-ascii?Q?EsLyYs2au+MrZN0z3zSJjNK0jENjoX8SVqlbUk8Q1EstgEbJkdwydIraD+99?=
 =?us-ascii?Q?CQly1JbXup+EFDWTnNU0bx3kKFWE728KlX7dMeAaU9WUxJAZeC+Vql0E8K9B?=
 =?us-ascii?Q?qprJ1qUD9ciTUyxXcL6qu/fuTdioh8brJyj9U6bQrcYUoRv+LfHPRFL9wyPq?=
 =?us-ascii?Q?dPZLvpUUFi/1Fngzt55ffA1DJ0CrSfE9bJpn5UpNzKIwLxrLhTWeN+Wj1B4B?=
 =?us-ascii?Q?GoXq5NluWNcB+Mjw1SrIvYZVLSHY2BJoNbP9Tl+ncDzdXXa476OpTLe8OfRO?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13555e45-a10f-4e33-8e5e-08dbda39667c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 17:47:07.1707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMh4SZYxXiycjzkZviDrUVFhsnf4tjo7ashhPI6mGzphEsZsYQgEegjyYGZWRb7lQ9qtB12BWZ6nwfwtu9CePX6QvF4G4b1lfA34oppRAQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5393
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas wrote:
> On Tue, Oct 31, 2023 at 04:35:23AM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > branch HEAD: c503e3eec382ac708ee7adf874add37b77c5d312  Add linux-next specific files for 20231030
> > 
> > Error/Warning reports:
> > ... 
> > https://lore.kernel.org/oe-kbuild-all/202310302206.Pkr5eBDi-lkp@intel.com
> 
> > Error/Warning: (recently discovered and may have been fixed)
> > 
> > Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/iio/imu/bosch,bma400.yaml
> > aarch64-linux-ld: drivers/cxl/core/pci.c:921:(.text+0xbbc): undefined reference to `pci_print_aer'
> > ...
> > arch/riscv/include/asm/mmio.h:67:(.text+0xd66): undefined reference to `pci_print_aer'
> > csky-linux-ld: pci.c:(.text+0x6e8): undefined reference to `pci_print_aer'
> > drivers/cxl/core/pci.c:921: undefined reference to `pci_print_aer'
> > drivers/cxl/core/pci.c:921:(.text+0xbc0): undefined reference to `pci_print_aer'
> > ...
> > ld: drivers/cxl/core/pci.c:921: undefined reference to `pci_print_aer'
> > loongarch64-linux-ld: drivers/cxl/core/pci.c:921:(.text+0xa38): undefined reference to `pci_print_aer'
> > pci.c:(.text+0x662): undefined reference to `pci_print_aer'
> > powerpc-linux-ld: pci.c:(.text+0xf10): undefined reference to `pci_print_aer'
> > riscv64-linux-ld: pci.c:(.text+0x11ec): undefined reference to `pci_print_aer'
> 
> I have no idea about the above (and all the similar ones below); I
> assume they all have to do with
> https://lore.kernel.org/r/20231018171713.1883517-13-rrichter@amd.com

Yes, I will get this fix folded into cxl/next:

diff --git a/include/linux/aer.h b/include/linux/aer.h
index f6ea2f57d808..3db310c19ab7 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -43,16 +43,20 @@ struct aer_capability_regs {
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
+void pci_print_aer(struct pci_dev *dev, int aer_severity,
+                   struct aer_capability_regs *aer);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
        return -EINVAL;
 }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
+static inline void pci_print_aer(struct pci_dev *dev, int aer_severity,
+                                struct aer_capability_regs *aer)
+{
+}
 #endif
 
-void pci_print_aer(struct pci_dev *dev, int aer_severity,
-                   struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
                       int severity, struct aer_capability_regs *aer_regs);
