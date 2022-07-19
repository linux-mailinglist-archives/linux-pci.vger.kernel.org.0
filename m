Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF3957A72D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 21:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiGSTXK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 15:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiGSTXI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 15:23:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B88545E9;
        Tue, 19 Jul 2022 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658258587; x=1689794587;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0Xi6eqaAf6cmS7pAYYPT3Lp71eCSo7jo1qwwZa2YCEQ=;
  b=aid2cgogVTDEpxpRWY5cPo/Tfo5u77oTSb9uSCaIRdRPO2dumWD+H7c5
   kMbCh5hWLu/Engn8XqSO1OyFlTTNiHjfAdj+SSvqzfuoJrKj4nibwhPUg
   zVrt282B5ZyEDhqn1oEcjRtWMjJVogUmAPCoJYBCdDOcAkLv0pSshqWCV
   VSLJS1/7v4bnynYvW48gmervrkXp2og+eCovw0bo4aMMRR3Ei0kxC34tt
   +VIFQysayrBNDIiBBmmb3NpGcv8KQ8MiRLVmgUFxRpxrRhzwFmx/WUN50
   Xhc0ys2dpYf1vZMMDAlFTj7xCVnlujf9mmMcH08ZUHBjN/30cSWrdufP6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="266356137"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="266356137"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 12:23:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="724374519"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga004.jf.intel.com with ESMTP; 19 Jul 2022 12:23:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 19 Jul 2022 12:23:06 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Jul 2022 12:23:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 19 Jul 2022 12:23:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Jul 2022 12:23:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=damsonWcVVcVHVhF7XXcdNBi0PFOUJ4w7AkJxq6lswwcxqAETde6+L1VtGXNeswoUkeLRDhgF7o5+NhBgzhGrnvp+W4pXh3nTqMl7TAR99gQxIT14kRGwsbopAggENGwrm5E491LEg4pZs8TqRr4gVruBd/DtiHW5D2QJHWHiHqDBrpNpWnIsYYcovQL9ydLF/pfKnP/Wn/QrWnjKLh3zSSyqM0fXIQhR7GnJ/KnoqCHMmmo369QDKMVdfHW2k2ZTZ9lu0vWQz5GJYeDzs71++nw4CwHiMZmKuDMbPL+pg+2yl5uQDgsRoKt73LPi0HVnDhv5k1akg6Rv99PwkqM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfv3DbK5nQErLw7R9XzMvC/o6/uKsWVX4+nvhFVrSB4=;
 b=Y7TXtCJonbHVYfaPn2X+SCkm/Z0f8YEScOIcbFePsFUWJT1ierZbCfnL9iiGmGC1uqLi4yp4hCuXZ8YDgs9CInhYYoOEpkuoX8mqE3puJoF0BezmvwWtFJY4yO8kzAnxK9V3wbi6+gu8js8qJ23H8XA7qcnQ5eZwsja4YT54nVVApqn7cBsRhy61d/1CRz40ZpcDVz0p0/ODrQ+im6A2qm4oDoQ0uyZvfCORRLXGIxOef8SpX/oS/MI/CRTiA7CShP1ZzZ9644KtIlEW4turq9n2l70Kli8XwB0m2zPyZQExAgJLxfe9kpiLwy6j10u4fvHVQl5p105ggD6Q5yB8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CO6PR11MB5635.namprd11.prod.outlook.com
 (2603:10b6:5:35f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 19:23:04 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.024; Tue, 19 Jul
 2022 19:23:03 +0000
Date:   Tue, 19 Jul 2022 12:23:01 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V14 0/7] CXL: Read CDAT
Message-ID: <62d7049572607_97b64294d3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220715030424.462963-1-ira.weiny@intel.com>
 <20220719162145.000054bc@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220719162145.000054bc@Huawei.com>
X-ClientProxiedBy: BYAPR01CA0007.prod.exchangelabs.com (2603:10b6:a02:80::20)
 To MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb96830c-9928-41cd-e6bd-08da69bc19e9
X-MS-TrafficTypeDiagnostic: CO6PR11MB5635:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9r45p4AMQWQZV0cstFRTfPWoHHovUINn5XfEHIeofUEl6J+zm4srdYEgP/hx7zrUFz/BNJdUm5O8RMP9jTR7WtpkWWAVLlmdaTNCE5mrJGRXiYQqBAZntTyY1nRE0T+oB7AkAv6fh/VHTjEXmBspb4ffB3jDWKzkYXlumLLmTXO1rhbJ/m19F9S0AyDdX4vxUWwOVZcCuNS0L0IAyW53HHC8AB60n2f68kXYC5TMC3z8uStZXi+ANPPhP1fHtHOmkLVfXL6bwPmI69wqh5RXnzibtsYGmn/sTXxjL+/Y23JoTsoIELSoP+VvdRvPltQQ2BFScTrMutaLJoGlrbUweop7C1tJuHqnIMXKjnTmKhKheOfedGEg2FuUyhJ5zzfQ8q/OOrLuvb2dcR1YCpsidfz4DGSG8dZ+Zdj0CEa2ZhjiM571kem35wmtgv+xqNRFywMUaHUXjSPygwCkNixEv10L+q2P/Y+e8e5JgghCvEfyzBUYeGBGdwu+1lT82KHmpXWX6I8Mgf4Nljd4CQ5qIO4AGZRFOG3Q9NfNPxlW1WiOZ3MoeNYpFo0eJUviMi531YSPrtyGcLheVf1N/8wl99hgEnAOjgaI+ehSTE930346bLZ6bOosYkuFq2c8Fy3Hkro3bq58Q8g4rBtCfj3NdStBPbo40zGYyZ9yyWz+HcHkYPfRn26O70+qcmql2f0FRhex1yupFVS8prfhI54b73i/3UrPNGYLw81TfvgOnvRjEZRfSRnSqxCyadGDj7CI1LSTJq3BuXcNKPDhR5NldJ1jlYAujUPDdXIsBPNt6QRqeoEUwqTXkBWsagvw3mH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(366004)(396003)(136003)(5660300002)(8936002)(6636002)(8676002)(2906002)(66946007)(54906003)(86362001)(316002)(4326008)(66556008)(66476007)(186003)(82960400001)(478600001)(6486002)(966005)(41300700001)(9686003)(26005)(83380400001)(38100700002)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PhEXZgOFVU1Tq2+mreBosuz2h51pmFfw5+dZmEhURxdjRwprldOyik01LnCl?=
 =?us-ascii?Q?6BHxMD0ni0ioBhNpZHAXTbX9ijffUsjUKEDQHnkr9octGaWMJ0E3TaWsn7xX?=
 =?us-ascii?Q?jpIOuGvDa/4gsse8XlAcqv/yhOPLAsSJHnJLQYq9npNDXzJ2CIPdy9+u0eIq?=
 =?us-ascii?Q?2KJHReNzEk/BF88/ZqaZgq1020mCy1z5lyP33VwSiTI97KbYk520FCh1aXSX?=
 =?us-ascii?Q?k8eA4/HMLNZJH9GF2XzMK962F1g3pXUs2SIcwGl9J4uIr4icKqAPtJM4fJ21?=
 =?us-ascii?Q?X4AgaBKGFWGAnAiO4bvWlnceTNUUN8FJr/h6OuB0KlXHPJPl4sfyiccokdZ7?=
 =?us-ascii?Q?Ue2MNH2T/F6hR0jB0cF8k9KNaGyXo34groB00DOMcyL52S2OhcsUwUX2w+eP?=
 =?us-ascii?Q?pExZlhxcM26iFaPN7ME2CnJeEuNkhvzsvuYFYsnIVSKw8bi1YuoCaWtLOCNY?=
 =?us-ascii?Q?0rS2TRo2mdhsbdy3XJBhopgbe2LYlZMdFt0AUp+2DrrhyjY/OTx5Rnwtfzt8?=
 =?us-ascii?Q?eRypTBqUeP23taU47HtmPun04+IJCcJtMILnLwppD3eP88HVtIACHTAF/jXa?=
 =?us-ascii?Q?2x3taNcyqeRY2Yx4qz5CoZeHFuCvw5NjsEIS00OSrR7Z+TM+dI8F9OSckRR9?=
 =?us-ascii?Q?Ts+tDqS2vPHtaQc2UB2yVsHj6l9YyDu6VtVzgX7t7VdcHfDChS6WVQRmu9k8?=
 =?us-ascii?Q?GjpftYOvdX0Lv3fsm1iaY1tHb8uPG5N06pUeYfoHBtPsxtlRnN7RB1HNGVAP?=
 =?us-ascii?Q?jXao4EK+VVP5V7iYZb1bAx8FcuV53U7WzFaenl5B4Fb/pw2CRASylTj4E7eN?=
 =?us-ascii?Q?jnv22H0BkyZWqpKkxQdXghSWsw6mdTAV/+b+tB44P1ubIqEraltR8JAqoycF?=
 =?us-ascii?Q?fMbJFiK8qC0MHLgblUSlvBeUlmjYVGcV8Mv/isQS+xhT34FCUp4+6xQkkHs0?=
 =?us-ascii?Q?Ku4N3aengQ3WnuIEprMVKUhRRiccCZqPiLeAxhtRr9mgMDqOZWebOH5jLpwQ?=
 =?us-ascii?Q?oQcJ0dbEwZu4Hl7HAnTBKdlaJVJq+gpO3KN05Y4V/A1JkIJK9JUdoEtDvy3F?=
 =?us-ascii?Q?lRNl4esi/RqV23nehpaw3/hHihRhn5W1sG8GW1ORy8Q5fFUPTWd/5xEXa8q4?=
 =?us-ascii?Q?/1Rj9nFHUJKlgw9FDYW1P8cikFKkE2IYc16J35i/yP878xCZrE2UK1my6MtZ?=
 =?us-ascii?Q?4q+/jizISlA1GOt+Nb9mgeAoTbhwnLKkMhP/0dnbEcbvqa7pr4OVsP+JNH8S?=
 =?us-ascii?Q?6Eopw0gjMnZRJ4p2WLAe+dcQUZLVbezT6Q3XdPOiOPkwX2af/0i0LlLHhda2?=
 =?us-ascii?Q?OjQEi/dU/DwNxOSVjGVbP4pRqdEioE3G3pDUOsauaqqm+VnfXXaMMKS+kjVs?=
 =?us-ascii?Q?yWyKCuB/kzYPGME+WLU8qRsYJyMcfm/cI58SQgE78dlPC16R/8wRj3JXajuD?=
 =?us-ascii?Q?FnSmJ5IproFhxljd41dBnv21IVjEvDCRtqMfHSbznfP6TVJrBfG5SD8TD3jX?=
 =?us-ascii?Q?FwKGnc1csRrtOYiqDmn3jbLaPRTt+yUVteNLGse5XTTRDdkD6hnX8PI6A6J+?=
 =?us-ascii?Q?F8/5Bf0X3nyJ5ZeKpfrbzRcNUwFSP+pSBcUghp2JC7P0Sbg7nuXT+QdOU7ZJ?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb96830c-9928-41cd-e6bd-08da69bc19e9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 19:23:03.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaAmrLgsgIII/l7lVtm3wjcrW/4G5yllMKp0ru/WeDyZX27w/+zfTLIiyXXflYye7nzNVT0WLi0Qs8MFhRsrfyBWciu8YMxEKerWfz/Vfds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5635
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 14 Jul 2022 20:04:17 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Details of changes are in the individual patches.
> > 
> > Major changes from V13:[10]
> > 	Dan minor updates
> > 	Willy's suggestion of documentation is good but I'm deferring it until
> > 	we get the location of the PCI mailboxes settled.
> > 	Drop retry CDAT patch
> > 	Drop DSMAS patch
> > 	Rebased on latest cxl-pending
> > 
> > CXL drivers need various data which are provided through generic DOE mailboxes
> > as defined in the PCIe 6.0 spec.[1]
> > 
> > One such data is the Coherent Device Attribute Table (CDAT).  CDAT data provides
> > coherent information about the various devices in the system.  It was developed
> > because systems no longer have a priori knowledge of all coherent devices
> > within a system.  CDAT describes the coherent characteristics of the
> > components on the CXL bus separate from system configurations.  The OS can
> > then, for example, use this information to form correct interleave sets.
> > 
> > To begin reading the CDAT the OS must have support to access the DOE mailboxes
> > provided by the CXL devices.
> > 
> > Because DOE is not specific to DOE but is provided within the PCI spec, the
> > series adds PCI DOE capability library functions.  These functions allow for
> > the iteration of the DOE capabilities on a device as well as creating
> > pci_doe_mb structures which can control the operation of the DOE state machine.
> > 
> > For now the iteration of and storage of the DOE mailboxes is done on memdev
> > objects within the CXL stack.  When this is needed in more generic code this
> > can be lifted later.
> > 
> > This work was tested using qemu.
> > 
> > [0] https://lore.kernel.org/linux-cxl/20211105235056.3711389-1-ira.weiny@intel.com/
> > [1] https://pcisig.com/specifications
> > [2] https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/
> > [3] https://lore.kernel.org/linux-cxl/20220201071952.900068-1-ira.weiny@intel.com/
> > [4] https://lore.kernel.org/linux-cxl/20220330235920.2800929-1-ira.weiny@intel.com/
> > [5] https://lore.kernel.org/linux-cxl/20220414203237.2198665-1-ira.weiny@intel.com/
> > [6] https://lore.kernel.org/linux-cxl/20220531152632.1397976-1-ira.weiny@intel.com/
> > [7] https://lore.kernel.org/linux-cxl/20220605005049.2155874-1-ira.weiny@intel.com/
> > [8] https://lore.kernel.org/linux-cxl/20220610202259.3544623-1-ira.weiny@intel.com/
> > [9] https://lore.kernel.org/linux-cxl/20220628041527.742333-1-ira.weiny@intel.com/
> > [10] https://lore.kernel.org/linux-cxl/20220705154932.2141021-1-ira.weiny@intel.com/
> > 
> > 
> > Previous changes
> > ================
> > 
> > Changes from V12:[9]
> > 	A couple of bug fixes in the new XArray stuff
> > 	Remove the IRQ support because I did not realize how that worked and it
> > 	was complicating things.
> > 	Remove busy retries and replace with an error as there is no good way
> > 	to ensure it will work.
> 
> This is fine for userspace access, but I think we probably will want retries
> once we are using it in kernel.  Whilst we'd not expect it to be common as
> per (very late) reply I sent to v13 discussion, the CDAT table can change
> all on it's own (as far as software can see).  I'd expect it to be a once in
> a blue moon thing though.

It had better not change outside an explicit remap of the DPA space via
a command like set-partition with the immediate flag set... or maybe
after a firmware update. Anything is just unsupportable and broken and
the vendor of a device that changes the CDAT without the OS asking for
the change gets to keep the pieces.
