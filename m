Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE57DD5AB
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 18:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376592AbjJaR5e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 13:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376591AbjJaR53 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 13:57:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FC712C;
        Tue, 31 Oct 2023 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698775040; x=1730311040;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ulhSKjq76SGgHxPymClJpcNVPMtZHI8V9rRoyr4ii4o=;
  b=CzMovjOjy6qdRmY2r320LBuKEq0p58ipAPzP9rQdGfT2jJ1aW1NqgrrL
   x2hBlOwek4zze3Dg9l1CypCXQZt7LpIRAjiYkKECmdPcb7IQjvdHujXju
   uSf7mUF8vDjUj2vDeuB49tc64ecdZi/9FpAOtojyMUZZkJoKT8qIsJANm
   gvAPK995EA/5SEN5KDoFtcQtnJOUnUv79cbPicwW7XtU61KGjkWCED9Ma
   29ndyziQQL3e/QTle+9q1aoJAJwpxnQbQ6GXlvPD1I1xBaS7Cm+E3VpYP
   bCbgGunpBmlXz+fVWlsP1vhpaXomLmqqTyTXdUSfz8gy/KoX2o6Z9n7J/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="9872338"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="9872338"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 10:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="789864089"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="789864089"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 10:57:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 10:57:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 10:57:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 10:57:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/7OSczPW/a+OsICdfZxSIzvNSVqSATGF5anWMFida+GoDfWoC30tQmKuuoziAXNQaM5LWUZsue/KWpW/oqRRcyNqrGAKrSsA+8o0lhI5xFVOTew5Q6k9YmaenL0ZlFPS3/KgghoLn4DDOZSbOzX7fpZnGW1ln93u6tBm+rH/oUPxxJqqBGNP9UaZBGEoi11ThnTEimF4US2sj1NI2BPukSU7oFfXal91Vc2VygxzutCkn+Mcg6uLYFk5IVmWYqJmDIqa/jamd6AoBqVYWHI38RultVm4XFQa+4v4ls1Blmp6mUkxAKOETOXepFCi3hagNYDMGMiEVesrrxiNyZ9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywu+Z1Qx26NgLmVJJ1Na1Fm2gnnTlV/8PYD52pkks54=;
 b=lI/Dfm20lrIKPj6CPwieaIfLZ+kHcugp/2AH84G33+entHCholbddVl0+kVWBrOdD0UroAdE7mmOuZGjV396XbmyCBrQcFv/mzVnV1UVUbtjHVBmem9ga5ro4WWG9igk8Ho2iAlXYnhp7rT76JCx5ia2vH+5C9Tg6rs/UI7GhPDukU3bGWExuaRC/EfVuggWDAi5qQ78IkfLbtW5NAFavtLqa9pOvxbj2wc5p42c1zKaPtMBCVJW665aUh4dfrQiWpeUV0fPeMPXGCgssikFpispFENQirULIm0HmnWBlIjxFlU7pLAxzM1dgfJ+5T0ZEoutBddZen1iejn4eDzOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5377.namprd11.prod.outlook.com (2603:10b6:610:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 17:57:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6933.026; Tue, 31 Oct 2023
 17:57:15 +0000
Date:   Tue, 31 Oct 2023 10:57:12 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
        <loongarch@lists.linux.dev>, kernel test robot <lkp@intel.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 c503e3eec382ac708ee7adf874add37b77c5d312
Message-ID: <65413ff8dd849_244c78294c2@dwillia2-xfh.jf.intel.com.notmuch>
References: <202310310457.5LusQqF6-lkp@intel.com>
 <20231031161757.GA11354@bhelgaas>
 <65413d98d6d5e_244c782949d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65413d98d6d5e_244c782949d@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:303:87::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5377:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ad6ef1-a8d1-4b84-bd4f-08dbda3ad0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mgGoBLiLOg/xdCx3GQnNQxH92cd1myP2JbEcNFr409O222rdPRe4K6KrCQ+xj+IEEWYMJnGAcFlElj85OhUq9nIfQ0yDs+S37pBCrByEOfK6C9dKbQC+AlMkarJzbH6waFi5f3to/2W3dTZS+I+txMcRzmG3mO9JsvNsbp332TJbvDB+RFcvGycQpcShXdnoNanNwJRy/NtjgnNm6z9mbv5bhYPRa5xPKjQTrn+CK77Jq52WC9/IEGlh3GAPNim5qC7Mfge17+kaVXK08A3+FfD1+8Yp2tHkH1S7O7Wm8tCV4GMT9p1m52g/N0GQgUnUiwshKr3VdTTlg067KjJFqBw/lXDpULrtRoBeddMulOrXrsLrVethkF0li/xfv7PcBuoePTWjTkJcUuK1sjtz1JkGVFKK2FgRn/KRXv1FUzJ+zsGBgSQ7XsaSBgRL6N0dRITQegpiQS70Yg+Ut33fkIuxbAomI8qakUVAx/Jmi1XVwng1smhB07xBPSvsJSvbnSq01PO7AkCfcaMR7iZpte83PsZ8W4y3Qgt64mXnRefG+HvPWYoPtY/ALIPSHycj6Ignka9UHHwXNh/hEAMuwy3W22c+TRlSVbtU39OrVt6niypuq1cxgEZPGAr5jYuzzb6cVI6nqPSGjxS6x21+zgKdOxTvquIeJoX2Z+yerF40U7SZ6dBidv2q05m0HqW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799009)(64100799003)(451199024)(7416002)(9686003)(6512007)(26005)(38100700002)(86362001)(82960400001)(83380400001)(2906002)(6506007)(478600001)(8676002)(6666004)(8936002)(6486002)(966005)(66476007)(316002)(4326008)(5660300002)(107886003)(41300700001)(66946007)(66556008)(110136005)(98903001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tk+3zMopqdfmdVgPzjKx26UF7ycidHsb6R0Irx+WiLCzIBxr6O7Czg8XQG3m?=
 =?us-ascii?Q?O1A72qfrDGQHDkEbudJsbf3wfFCQ+tl9d7dgRARjfOBPZL49tXqRBlUYevmR?=
 =?us-ascii?Q?HXNhFfqvm5tyf3oJpCzPLVn7Cu+KvYNZqzKcyATxAhfdtW2cJ4CVP/2wrbPM?=
 =?us-ascii?Q?/ApN6Z+kXO2UGuP9PHpiGRdgZKKfQNhXRme7H6t16EBU+PxWoPo7U5M8xahE?=
 =?us-ascii?Q?DqF3L5xTyNkwkeSbFM34CqQ7JHPZtG9+iZ4hFK8wPLj5FoSjWh1CkvWE2Crv?=
 =?us-ascii?Q?MPVFOj5BBnRHimPDDoG07oSejRXqJRZJvLweKKKLif1HssRg68bvXCzvSUI2?=
 =?us-ascii?Q?xVw2PeDGiWeneO1E5l/AaPKpKArvR/aL+Q7+7FBcVcsPe0TfBAePJPbfGuHi?=
 =?us-ascii?Q?O5SKQ39EKqwCORD/1G6fICLtTg3aT3yg2sj5xLemNEB6L4/MAjVQRELfymj8?=
 =?us-ascii?Q?F9/UK29UKjIG6BDgklN1pSDqwwISxlYLXkIKtWYZt8iuMpz/aH+VXB5DgKvK?=
 =?us-ascii?Q?kjAZmY/Enk04PGQHMfNtzqwDkNMA2Tbyg2uRu+AXtxS3LK1CNFlk1Iy7fg5i?=
 =?us-ascii?Q?bE838ZmtXMYun0Zv6N8H8HrUhJveKM62pnFgCA7gl02TeSdLfi8GXI6ndoJX?=
 =?us-ascii?Q?um5IM9Z6Nb/i4C9MahDBBC9EZGsxfgjC826Bs2oKwarfaTdhAX7GxWW3A068?=
 =?us-ascii?Q?c9s1XzhuJN9j1lXHr883mefVIeonWK4VdEcsUHINQxNJ9A5zxNZ6TRqt5kzw?=
 =?us-ascii?Q?5q5zz4pQoJzluoJGrcs0EIcSmbxVWmCQfGekZQA9zkHYiiUywoCNFzUvnbUC?=
 =?us-ascii?Q?Qz0o4lTAoEjQEs7WzgIt9bODTAZ5KB68CKqXNuxjq0lkHYEU+fkqK0cRj/3F?=
 =?us-ascii?Q?IZL9WpU4UPYv/eogNiV9LgVY33yUd8zDY3fqqAFVALbEptmcwrya9bTt3yI+?=
 =?us-ascii?Q?qIjDDoMpL9tn3vbbERI6SorUCItJ5+6FIBA5yipiX9MrJb3tBa0w3Y2GMjFk?=
 =?us-ascii?Q?FUyQCvS9HFQ8xBlsFfXkqMm7Wzmlqy4685luIaB0EycYzQLHrWIK89EMWwVD?=
 =?us-ascii?Q?GoQRuwNk0B2I3MQEFCIj2BnW3ImtJUcZFzX10umiop05Y1r2v+IV3bAY2Bo6?=
 =?us-ascii?Q?SipMh8IIb9s4nX2GkNCwsVRGGZ3p2lrqWdHN4IgV0TwaSFUyFLdLZkmTgans?=
 =?us-ascii?Q?S6pE8DFJDSVGeTIHTsE5jjsltEi+DZN//FxEqNtwIBM3rX7b6PCtHMdBub7W?=
 =?us-ascii?Q?1zLbC/0BghsubHSmGKy1qdtj/3buU2PWI81JAxXuoRRT4nKexdy2qMUEM5Ul?=
 =?us-ascii?Q?D0VRtnsdB5a6hsbam0Isjs0Pcxu5LDWDe0QSsFzB33PFvLjCCp6uP1NspfKf?=
 =?us-ascii?Q?+asbhzC6GBTNkI1OVlbs44zF+96mJUGeL7VDhORKIgqkl8aUrwO4N6ESM1pa?=
 =?us-ascii?Q?NPdsur1+ZLGyU4OlLGrH8lOAIrr7so0DfOnjju6rFdcfgtDNJZmXn0FYuXQc?=
 =?us-ascii?Q?Zb2HGjJpspmpFNyH270OzFL8X1RvaMGEyHhrALyx0xBCtQGhEVauGqTkftxL?=
 =?us-ascii?Q?TQz6lI/Bvv9nWL9Wn7PaS4EduNA1XFojLmCex9lgJfo9a0Ar4t0D/ZGoMUea?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ad6ef1-a8d1-4b84-bd4f-08dbda3ad0d9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 17:57:15.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILWQvVVwr+0YfGSrKojQ4JxxPWuf9fuu59Lchd2oX8CKWb1KHZkNPq2T0TvhoHfk8WPANXP4meOu8r9hXzEH5awvsxLmFKN5HzUXqkq4rHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5377
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

Dan Williams wrote:
> Bjorn Helgaas wrote:
> > On Tue, Oct 31, 2023 at 04:35:23AM +0800, kernel test robot wrote:
> > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > > branch HEAD: c503e3eec382ac708ee7adf874add37b77c5d312  Add linux-next specific files for 20231030
> > > 
> > > Error/Warning reports:
> > > ... 
> > > https://lore.kernel.org/oe-kbuild-all/202310302206.Pkr5eBDi-lkp@intel.com
> > 
> > > Error/Warning: (recently discovered and may have been fixed)
> > > 
> > > Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/iio/imu/bosch,bma400.yaml
> > > aarch64-linux-ld: drivers/cxl/core/pci.c:921:(.text+0xbbc): undefined reference to `pci_print_aer'
> > > ...
> > > arch/riscv/include/asm/mmio.h:67:(.text+0xd66): undefined reference to `pci_print_aer'
> > > csky-linux-ld: pci.c:(.text+0x6e8): undefined reference to `pci_print_aer'
> > > drivers/cxl/core/pci.c:921: undefined reference to `pci_print_aer'
> > > drivers/cxl/core/pci.c:921:(.text+0xbc0): undefined reference to `pci_print_aer'
> > > ...
> > > ld: drivers/cxl/core/pci.c:921: undefined reference to `pci_print_aer'
> > > loongarch64-linux-ld: drivers/cxl/core/pci.c:921:(.text+0xa38): undefined reference to `pci_print_aer'
> > > pci.c:(.text+0x662): undefined reference to `pci_print_aer'
> > > powerpc-linux-ld: pci.c:(.text+0xf10): undefined reference to `pci_print_aer'
> > > riscv64-linux-ld: pci.c:(.text+0x11ec): undefined reference to `pci_print_aer'
> > 
> > I have no idea about the above (and all the similar ones below); I
> > assume they all have to do with
> > https://lore.kernel.org/r/20231018171713.1883517-13-rrichter@amd.com
> 
> Yes, I will get this fix folded into cxl/next:
> 
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index f6ea2f57d808..3db310c19ab7 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -43,16 +43,20 @@ struct aer_capability_regs {
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> +void pci_print_aer(struct pci_dev *dev, int aer_severity,
> +                   struct aer_capability_regs *aer);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>         return -EINVAL;
>  }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> +static inline void pci_print_aer(struct pci_dev *dev, int aer_severity,
> +                                struct aer_capability_regs *aer)
> +{
> +}
>  #endif
>  
> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> -                   struct aer_capability_regs *aer);
>  int cper_severity_to_aer(int cper_severity);
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>                        int severity, struct aer_capability_regs *aer_regs);

Actually, no this was my fault for inadvertantly including this patch in
the branch:

http://lore.kernel.org/r/653c7eb29265c_244c8f2944b@dwillia2-xfh.jf.intel.com.notmuch

...which had the desired effect, but at the cost of thrashing
linux-next. Apologies for that.

