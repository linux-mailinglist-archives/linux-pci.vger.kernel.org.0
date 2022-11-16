Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2722D62C2C1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 16:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiKPPjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 10:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPPjL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 10:39:11 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C643D23388;
        Wed, 16 Nov 2022 07:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668613149; x=1700149149;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Kx/IjIAqt7b8nhY7mJGe48UwnrePb1opmGH4+7mfIl0=;
  b=NmAqGs00MfUhswKYhgbNM0iPtUhpQH0WMNwXxl4Lx+FjVcq7NuVnT5uJ
   8UnqmJQWb663QG67JlRcZ1w5BQBFoprhPS84Tr61Q/PWRwWDKRJyMprE7
   SunW2xo6xeiujtp5b/H24oKgXoKuJoQDrcbcJ02pxaHkIPZ22t5yQi65T
   EDmCsDcyXfFZvcWJcLMsHp294Qwp+Xl+tEzeAEA2pTlCNpAJ7yxOdn5hA
   +mbb6fBIA6iQvhLqHlSf8+VhAvDo3yx7au7kuk1I8sOi4q4DxeMBXs+Qd
   GWDwL2htDIKyxSLtPmyG+HeUks/FLAdi4MBPVW19fltZ+Ln3K+fiE4tJB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="292281418"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292281418"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 07:39:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="728411615"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="728411615"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Nov 2022 07:39:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 07:39:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 07:39:09 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 07:39:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEpfce4XmFPRBJR8YemecSX0Ieru9gE8qvB6WjQYOyNxnKUWbbIe1/UZjrpozbTnYWva9iaxIUphDRIg1+8gvrUTfYNVqw8OvwKSCNPZQECMz0CqDBaWU6eoqOtvIHtrvx+Nc/T2nSCEZvXARjEzbwkCusel3RDroaUXbLBjAAIGwZ+gpU2GtakUp5+apO2eg1V4TIBD8AtcSEKgWH/4JPlh+Rdpap9n+HWp6UnLuO5W8L00TQpF/I/A6JGx6TPKf/VmWvvEed9lctXrO+u21ssLXV0XdtT5u4F+hL61XXsBtNvuNmOJD2N2suenHzHh04KBJNSQeWoAoYZzuiwTcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLwNm5C2WAWN8+Q6jkht/BhU5JRWyirTxPmRIbnV7yk=;
 b=dpb/gqVprqMvq00s6+fYyX2Ah93JzWaw6jto7cxd7emd+4qGdPRfGA74nZSGP54Mcil6WOYJM08MdsGl4WD7WUJzxULL/uWAw4yT1ukI2ZHfZEScdeoflUXdfzYlJfpjp6LQTkoDEuoyXeDn2K+aktGgDqsswZ8ijpyZbuvY+1PbjNOlC3Ub1aOzF+lyzA1Y8NT157fQbjoYU1kXPBcpo1yViHJ6IJQwiD455lf4ShmMNds0fczjIYJGw6eBHZTa/ZZE+IWDp4w2l0a2HSrbDsknS4xlKKhH7qdfxjguCOqcE/gXsoVY6A/BbJPWwK5cg7pzwdxD1iNA80xm+tR5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 15:39:06 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5813.013; Wed, 16 Nov 2022
 15:39:06 +0000
Date:   Wed, 16 Nov 2022 07:39:00 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        <linuxppc-dev@lists.ozlabs.org>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 01/39] PCI/MSI: Check for MSI enabled in
 __pci_msix_enable()
Message-ID: <Y3UEFBJW1toFJZGn@a4bf019067fa.jf.intel.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122013.653556720@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221111122013.653556720@linutronix.de>
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|MW5PR11MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab4bb54-1e5e-45c0-37c1-08dac7e8b1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKzc40MDTc1pxQ18+OzH7oSaMWGWZL4u4dUaaypHd5pFxLKqLQGTQB4RtVdcGo3s1xzljFzBEzrPRGuFNiGwGdZdf/4m9m/tcRHOnMfwCBSTJWydMsRfJ4hq/V2v1M9OeGa5R7pGYkmKJ7M9SVGTF81mdaIRn/HOlJ6tMHMVnl3nChxHXu7MYJ8zIzLSa4bskJGZ8bSnKqJkIc/krq9DpXtSBtS6lttZt9l1msuEqgSEesFN3uz5dcXxYA8rxBCZw6f9FYLXRJyweROIKDBz+nzr13lGpVD05SiWMcBCzJI0l384Hx7QFzFEILLE6CvfqdzC4yLJBdtWt6kVqlwCHEpdTrF01UYENLescqWqPkOiUG8AjYpUXTlBfWoLEOfGwwPojDMpza9IJpXHql3sIsTfeCfOXlYAbB6qe+9OwokecBFoe7vy/D1qFbNH3gNyxwdAmIBWH9f3kLWfBfRsGnjl/pCmAnWh1ysxVW/7zUPy62jPIn7lzSB+yWzZdSTv/8uI2Khj1hVVNOxDpPJ/qJBZJjg+DKJA8Sbh+SeTBG4E67xdvYYMBadTBIc3HN2Sr7QpAtFw+HyQroWb+GO5RIVWeT9LyM/PBCKThuU62+1SKCLVXwNHYkei9S/Tu+ezDsGaCdpaIuLaFmkivROCJvCnqF3uOKGlu4jXaM4vmFfKHP5EUc2sK66CjxN+o8GYS2CobKXH88uhxxbQC6+bWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199015)(6666004)(107886003)(478600001)(6486002)(4326008)(26005)(6512007)(316002)(6506007)(6916009)(66476007)(8676002)(66556008)(66946007)(5660300002)(186003)(7416002)(4744005)(41300700001)(8936002)(86362001)(82960400001)(38100700002)(2906002)(54906003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R80onSgKEsRqoxl6kIQ8wA2H8hkVQ0+5v1JqH3pAmfKLe0+WqsxNuohkFmAI?=
 =?us-ascii?Q?9qT6eWYU7D+65YDBoh0oxj738I3PLbHgk3KfF2roINDh1ob1IXehVG8789jS?=
 =?us-ascii?Q?rrTuhBskfwmAn0slS6wxsWAucHpU5HPEeQMEf/VWrpa2G3pi150RLomumauA?=
 =?us-ascii?Q?+wF5VEG+wWfK/wYOcgCWH+X5/dnZ8xgEe/X87IlveXwdVL0NuAxMEY1MQPV7?=
 =?us-ascii?Q?rWhwr+b0KrpHf/ofxfx3c2FRQtvM5VxYYAgNppcTyjhnCvtm4pt9qraNV5Qf?=
 =?us-ascii?Q?445Jvt9odsQ2FJUHw2UXZmFWTElIUtrxgYmh900Z3qZCrZXr9t9wEszFiyj4?=
 =?us-ascii?Q?V+/LV1Aqb4+mT09GpIM7RBeSvC9A4TgxhHWoU+mvDHwyGeZQ6WcilKHADmUg?=
 =?us-ascii?Q?ghmVhpSGBZ1Q18XRcgMC7g5eds+x23lrgkDwzdLFhMQXPFQ1jqtZtCMORcdJ?=
 =?us-ascii?Q?SPHu1bFITMoHPQCVSLxM7k8hqmdYH4dWLhUet1Zvx1MvY5WDKoiTLFbr3BcW?=
 =?us-ascii?Q?hDyWuKHq0UfWl68ywicyO3nnvpB69O79yY50GHo/wXLMY2antKjuirTyLtYw?=
 =?us-ascii?Q?nDpP/VucVHD/9vEL384wdf245q/aH+kzMnlk7LBGg3OL1GVgGfRpCUdD3hkf?=
 =?us-ascii?Q?DBV9Rg/cdP51cUiHr975qm5Ba3PCDd05rzou0R6Lj/57LCjvkYAXYLxlwc6C?=
 =?us-ascii?Q?3C/xiG9frhRBY+3Qjqw7nKKDlF4kCAXAcFd2XTMgYIEB0f/RS/EIbxB5AcV5?=
 =?us-ascii?Q?tHVI5BcyNB1tn+Gmaua0/ehC8BfXTHZZyzixIyBfITwOILrAqM4gh7znNjN2?=
 =?us-ascii?Q?PcFIEDQvHj64oFL0AdrQsBj9O++Fbm7JfpgPowQBVaPYTxzeBtwxvg8pOHGS?=
 =?us-ascii?Q?Ao5uLYU0dSWl7yva0WA/45BdGSmQ+EL2fepT0Kd7qtzVPoFAEzIe2Fu2ljPK?=
 =?us-ascii?Q?EZ8Mz12WAyaxOD0g/2pljl3lxqg1+Uq478G+D6E8BnqREz6LijWOqGOn6Vcr?=
 =?us-ascii?Q?uSGWpJlXLKXVJZb11XrEggG7estOeKbyk8KD0WYLPiWIzKWZEs1Te5lIFsFd?=
 =?us-ascii?Q?3NCicVyH/wOkyufMoQD4jKGAIHFeaWXY/ky221DLp1ZzK1MnNs+Y8Js9RDmN?=
 =?us-ascii?Q?YQ9TL2CNSVkBjuhIqV8nGGoqF+uxb4wQCPsDiPozzaDjwW7VHyQsx7C4rbMR?=
 =?us-ascii?Q?3srxzUXuq1Z4K8YKBrbnlyhNCOvl1XyNSxiVrn7Sbku7ElT4P82Hz51otasM?=
 =?us-ascii?Q?ZXDJKvLqu6NOibu7hpR4crhMa9yfzq8wAMoodv7iXQcJD76YlVpQ+u+EWaqh?=
 =?us-ascii?Q?D9L1+g4Lbz1iVMgnvJbY12v/FhRzcdIE4FgtvcsCBHpzVFsizYIpqTLSF9x5?=
 =?us-ascii?Q?5N40uSjUw8VHXX/YzA4XC7OTy2t7APt7+ZNwbAp/M5wHrCxMGyqFX4sFxNIV?=
 =?us-ascii?Q?kiyF8MW3wpMMVFgkWduHVPgqkGlUTwTNPACR5ibDsvWfudNSTT5xoafDMO6R?=
 =?us-ascii?Q?ssLXFxWxnrZokQrTAPkH4Q0S4qbldNgMEadheHxe9soAuAod9Rbzsz7Qaqbn?=
 =?us-ascii?Q?kwwmW1ZBVjo1E3mFNZGjHVfkItg4OHREuJcYUQPC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab4bb54-1e5e-45c0-37c1-08dac7e8b1e9
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 15:39:05.9256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwUBT2mKUBeFRXcaTxNodXPEMkDWCXzVn2UKSEboxUQetMK9Cywy2yKpel4tIIALtQp2LXcEvMpIa0AvVQS9dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5810
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:15PM +0100, Thomas Gleixner wrote:
> PCI/MSI and PCI/MSI-X are mutually exclusive, but the MSI-X enable code
> lacks a check for already enabled MSI.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/pci/msi/msi.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -935,6 +935,11 @@ static int __pci_enable_msix_range(struc
>  	if (maxvec < minvec)
>  		return -ERANGE;
>  
> +	if (dev->msi_enabled) {
> +		pci_info(dev, "can't enable MSI-X (MSI already enabled)\n");
> +		return -EINVAL;
> +	}
> +

nit: 

Can the pre-enabled checks for msi and msix be moved up before any vector
range check?

not that it matters for how it fails, does EBUSY sound better?

looks good.

Reviewed-by: Ashok Raj <ashok.raj@intel.com>

>  	if (WARN_ON_ONCE(dev->msix_enabled))
>  		return -EINVAL;

