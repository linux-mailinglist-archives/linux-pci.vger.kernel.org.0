Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83C95B145E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 08:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiIHGF1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 02:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiIHGFZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 02:05:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50852A407A;
        Wed,  7 Sep 2022 23:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662617124; x=1694153124;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KqQMMCJBnQIsFl6WQv4mbaw7aImXH+WW/xBBT+njNGc=;
  b=etoMXKcMbSSrNFSuXGfgfg28e/hA8tQly9jVIAXb35EvW6h1XFCgGzh2
   glMP60OCu72dEAfCwx76NcDXrjD4jHKVXKBwZzaYju5F1BhgrMUqVf5vS
   wAtDEwebevYxrBYOLLh+SLdhUc2izcZuTISFbkdzSNlaGDzBFeiIQhXIh
   Sx29YXWWasZAdMhq7mMT3WGEMy5EPXdWmVMsKEiGaH79drzE2IEUc29Sr
   OIG8hXIwnSLZvIAyl02ElUkxsRWaCMZr8OHfFCYUmuW0VoZmPR0PzdLNh
   gKCLEcKfoBImT4+Mt0WyKF2l51ImOoKb2ZcFF+2unU6YwWfpzDf9H0/EP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="294661679"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="294661679"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 23:05:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="943203453"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 07 Sep 2022 23:05:16 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:05:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:05:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 23:05:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 23:05:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcGwSPToLJ/y459PqUVpJSvOntMbAo2JA+M6LIJ+YitMrq6hRpGyRFxT4X4qqSEYLgBtjfK9Nyo6rnTO2pvouwm5igHn61QhFISb6nvreN4+x6uDjtZhoF8DfYmZQAILNlcqQxTDhEZK9aNvB03jYSImrGbmglAHgMJRg41tMTCjU17HRtiPfrIsM6NaGICla8xHOnVE0OqdbUIuUVHdO26waoglGgJ2jlI4i96hQN8oZGyW0Z/cP71kZ7sJD49sRKrl+AWen46ApHRI+uQfCfzc85ffrmYv377d/Yhr7K68NFrhasOAVEyRT+ptiNKoGDBEHlvMyUPXVMI99TkJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoGdvXhJwPYzbmC22sksnPm4FBxvZwogn/bpeuK3ms8=;
 b=iYLrxNGtPyLCNXoZ0SV3MVIR3NFGb//hEGlcTaSg/LtYmirY6paVVs1KoIVTxJCs1314QIw90RTpfhTVRzqLtzIzUm/Ce6weEsHz4Z67IICBO1GKSctWeaRNdavlAfrpXpmXlEkc8BV3+hOHue0bKV1/xM79+BNOKQ013hG9u1we2+vmM690IEDApeOcfp+075SZmfI6wGfnjmsW5B3JaTcVeMuXyH+e9pTEpW9AnY8FfBvCqS7otTVzSwRyB2DlTdeagUUmwDIqslI4qDCbxzdNGmSZsNHOk+WP912dlLRVH+f8mzFswNFyRe2jT/I3Wxwm8dpV1Ih68UniEgJXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB6100.namprd11.prod.outlook.com
 (2603:10b6:208:3d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 06:05:14 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 06:05:14 +0000
Date:   Wed, 7 Sep 2022 23:05:11 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 06/15] PCI/ACPI: Link host bridge to its ACPI fw node
Message-ID: <63198617c7854_5801629450@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-7-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-7-rrichter@amd.com>
X-ClientProxiedBy: BYAPR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:a03:80::15) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecbc5975-f070-4df8-2a68-08da91601892
X-MS-TrafficTypeDiagnostic: IA1PR11MB6100:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y9JrYKeZ9RsM4wJIC52x48mctSM4JoFNqcH8Q1fwkLYRWT5aqkELz+cZ8Qa+NLQLKAmsiS1pobhcTCjYGlldnihJf3p7V3GAaCz3P9/Xwz8BD0X5OjPQEwJ/edS03q1VZDzUNdWBvetN22jMp6l2+gDCTe25/cmDyHWovuJuQcEMPGIV8i0RpU+KPO930waXzacaE//rKYwwkSMFi72EHJOtv6jjrbtWFeIvc40Z6IBBoKEpXElihgFwKZvsakXkS0xx8/wKArpr6sjqnp1Ymn8O/VytwMEBoOTr0Af6+istcWkTXTblLvhleNx3Nxclr+pQHMDaWrkdQG9X09eplb2fj/hJHb1busvOm3Szc1wuhpb3CqNhlnmJ3Kh2jdivgeK/I0B73tUEYCO+qble2ak7UzUHRyBsHYTjrdehtLb70UWdbexlvctwbkLIdhJHHRzf8yVLAEd72djwfEDguK+B9kCi1sAZ2GR7WoZnH9TOxkQAwzJaxxywvF/8oLP82FOkDDv1mePTtCEvlf32vS1LL2uuEaqOucUUk9Vi1S6NMuMhl3ZomCWqZOTMzS87dscM6d3Co/aHfdCwnfE8tifEvxzRG+GheCkZ3CNczAOP3fW5aYJzldXO4VbQ1UX22YrUCwN11+fUPWxbbSXtKk2yTyOojJ38uICn7P0/rS6/x16Z/1OKWOwdq6yBoOhFegodRYA4yLDQ07OpyefTuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(366004)(396003)(39860400002)(110136005)(6486002)(54906003)(9686003)(41300700001)(6506007)(186003)(26005)(478600001)(6512007)(66476007)(6666004)(66556008)(86362001)(38100700002)(66946007)(4326008)(8676002)(2906002)(5660300002)(82960400001)(316002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OpU5Vxh+Edz15cHyRzOijV6iRq+vyu4VgH16/kt8clxqT29w7/HCpvIv2PKb?=
 =?us-ascii?Q?D2F+AjbMA9Lm9KlqCo9FPkM5x8X70/33Kyh01nPsNm0/FjtDvnMUzkggCTbd?=
 =?us-ascii?Q?6agXxWISr1hAsDIMQAyNDbdi87hundFonQs9/nLqyGsYEZwFivr5AtdtUsJ5?=
 =?us-ascii?Q?zRZtBWEBJqWT6c5XKl56jLYa/tLQ5ePBx12QpoX2y+d5LvLC2WOV0Ksu3UaI?=
 =?us-ascii?Q?AfzpDj/2IgZWwZAJWoXuXOXRToMTRyQB8h+Adz+1VahNEnME/z/KdB6tWQYH?=
 =?us-ascii?Q?j+YS2Wf+BwKi+JoQ7hK/jN4YqywGWNGDESdDVSYTQt6bslyCPhvIaM4Y5xdr?=
 =?us-ascii?Q?1SDpnRIrfy21mXvdJZnmC09CGHETFYmrOFNfTZEhJf19UcVlYpEaR+kz4hHz?=
 =?us-ascii?Q?216mW9o+3w12dzoU25zYvFzfCnJG/nHKnAtdPNwTOqa8XOQWhePxQYkPp0et?=
 =?us-ascii?Q?rwEHl+G9xinEp7Q8fu2DFM1Vf9VVNDae2Lvas8LLV8uu+RSefG6jY5VplY12?=
 =?us-ascii?Q?pRjk0xiArnZqrBhy8zOpy1K6cc4zFkgEdq//gMHMipn6/3Iu1x4pxcfA4WKY?=
 =?us-ascii?Q?UzPyArTN3rxRCbZ4kKA0nyi27eZpLAKKpD20QCd+Lwo4+dwNBRq7fHSWJCKU?=
 =?us-ascii?Q?T6SfWItT634H0i65ZMuh89d40D81U4RGdL/pr1gDhsHz+Z6m+rJZc7hT8n8F?=
 =?us-ascii?Q?4ZASLROlqO7FwGs1QJO950VEPI8zjyD7GdESAZR7pYzOl117oO3g5Dh3AmIW?=
 =?us-ascii?Q?gVotYvtNSpvbVzK+AftE5S6eIAyhOwh9//AWdiF2N+YRQlvd8ULHAhgWW9m8?=
 =?us-ascii?Q?kjmhrhUMSyXBbjOf/j7b6itbxYdhyo+hnwXU30cch12MbQ4kHvlg2vtOkAjW?=
 =?us-ascii?Q?F0hsgrTKcxP4xpkqgY0MflPeXLJZgujAtP0ALnFJGlks3XUErN1gYHNqUdeE?=
 =?us-ascii?Q?8gICUb6WDsyWa9Sl2Hh9kgH2EGsyrBthFRKKH7yi2lxro0Sm53jurnv73AwF?=
 =?us-ascii?Q?GG4sfeG49SvX6EXBp+UzU2/FtPqj/TL4LzfJi5PkDm/muyY1k/8b+uRjLU2/?=
 =?us-ascii?Q?zgS21mEJbX1QNnxpGj+5icMQlGFaXaVzDfJ+jLEDlrKNAiNZgnyRT4vqazL3?=
 =?us-ascii?Q?rmJLBLNC3Y/gVlLgLD1zJMjuXfFbzdyf1XxmdZ4zpndr0xY3P6QDjAKAWUbU?=
 =?us-ascii?Q?oMQQ3fxYhexQ1hnmrg3AhygfwPyr+GNGSO3IGHpUK4a5PYabcIRYY5P6x4aF?=
 =?us-ascii?Q?WOo3kbktT83qNxWcYnp9Jh7U30yMEZZLmFXFY4npBLaZmyfXX/emB3+MG2r7?=
 =?us-ascii?Q?o2R8/eX5RDpV2pIhndq1P8fWhodcqwVifkHmIRIBWNVpZ79IcvHZw3dVCS6A?=
 =?us-ascii?Q?E6P3whgv9Pl1sICEtPmj5c9XAOIf6QsCGyt4SOOHvCeah9pk+D27tfEuCC8S?=
 =?us-ascii?Q?hFr0/UiII0d/XwOGYHSnk+6CKLNnYmJzOyaf9phsbvRPQN9pxMtwRlzNj6P+?=
 =?us-ascii?Q?QVY89ANJLzMBFlMUetV0roM17EILZZGUg14agHI3fQvEI1zz2UcirfGqv/ov?=
 =?us-ascii?Q?jaKRm8xqmkycf0/2XF6e99bQ8szoN3nN3uj6E555QEsd3jNBHLAyGugWD9Qr?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbc5975-f070-4df8-2a68-08da91601892
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 06:05:14.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mrVbt0iYhiGWR9+jaa5qUgASVAM/K59svgHyLFwlN5QVOJ4s03F0VPW3d4FhHkFrJuA1a/Ga+TaWv3wBMtBePXuHctMu+THMhZEqTlOFUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6100
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Robert Richter wrote:
> A lookup of a host bridge's corresponding acpi device (struct
> acpi_device) is not possible, for example:
> 
> 	adev = ACPI_COMPANION(&host_bridge->dev);
> 
> This could be useful to find a host bridge's fwnode handle and to
> determine and call additional host bridge ACPI parameters and methods
> such as HID/CID or _UID.

When is this explicitly needed. "Could be useful" is interesting, but it
needs to have a practical need.

> 
> Make this work by linking the host bridge to its ACPI fw node.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/pci_root.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index d57cf8454b93..846c979e4c29 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -1083,6 +1083,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  		goto out_release_info;
>  
>  	host_bridge = to_pci_host_bridge(bus->bridge);
> +	host_bridge->dev.fwnode = acpi_fwnode_handle(device);
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
>  		host_bridge->native_pcie_hotplug = 0;
>  	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
> -- 
> 2.30.2
> 


