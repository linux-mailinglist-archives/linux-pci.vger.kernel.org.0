Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA959664841
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 19:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbjAJSKl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 13:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238802AbjAJSKG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 13:10:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F002BCB3;
        Tue, 10 Jan 2023 10:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673374066; x=1704910066;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oio9zsHnI/73N88NsENqJ5oqxJoH132lFSRFQR7H5YQ=;
  b=awnbkZSimfX0Z0fWe4btjXWTW2QO22DFZUvXsNEftSkh357I7q/+Pvt+
   LpeBKZvzKQ5mcN/GOF5Th0ZPpcppgL3D4BnOibo+BeND0ZBmkx4wcTUWN
   1kiNRw42eBZpbPdIf6jiABopemcMHQCp2mc/ImYHhz6Hlgi2jUUv3vldl
   3ihwgZJA2JFVLb6zfmmmya4rQQNZ+UwHRPTETl8CK77RiEiEyzqbHFp3x
   xAB0QOqmzXVhIpacnUQjgHZh8JSdxarJJeSdgPoqFLLWD1JiqeLxRirof
   twCD+YNNx63NFUvNDZFPWEi7Cj/zG2bRn67vZeyYxlAbEeWam88Kb/4br
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321919588"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="321919588"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 10:07:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="799517377"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="799517377"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jan 2023 10:07:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 10:07:44 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 10:07:44 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 10:07:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfdzeTXxGPN2swx1YhvS1ZobS+Kz/fb5HYkhpuYjs/smL6cvRBuSaT3EaqJWTlc7ySj5DEH2bVB4+P+Ot3IAkVWeQrq8qG4GAAvFICHh7NU6wHec9tM08LBVY1XYUUlZvchvT2VzigaibAf1qBV7S1Tf8u/NKv6sqST2ez15zP0zopH0Dxd4gA6Dw1NVU/42gbINjAAE2RmBJ97nuRBv4coRE0sXsoPdRhfO4vIYPrTxKdq7yQ7EcI3eUP3RAmN/fFWTFORXLbwCL/lzTy3TnrlcuPGF+S/vKLT9tt8eOnAZ4hhZEw3MfFKW2VDO5iza/nWN3Bb0EUG1MfXo7ufFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMweoUNXPk/4zq7GoapBzzgeT719e0zgIkeg3Bcb2Qg=;
 b=PSjsdTNjQ8FFB94f52s/mS5XsTUlKuv2Q8gw3pHt+85BONCu+vkpwpNK4RW3bcc7us3OqPw2AsprffHXgHu5Q5MxIMsVaZ45T/14g5Y0dfznrdDMEfJ/GVisMx2XgsX56Kx9zVXCHbEOLdK94Fx+tZhuIaske6UuEKho5M9UkczaMpYTjL2kUNnxwBNh0AZJrDBkPtj9MNHu1Ai4Fk66gLoxK/V5HgbNrH9YlwG4PxxnD7or3Mii4cmtIkuk4lshUytVnpAKq3tjq6aHVJRPuzVVGmsnab6F/jVQfdvYsZGClqhAsl+sj7YfRTAE27zssa8rlCDvtRu4giNE8DVdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM8PR11MB5574.namprd11.prod.outlook.com
 (2603:10b6:8:39::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 18:07:43 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 18:07:43 +0000
Date:   Tue, 10 Jan 2023 10:07:39 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     Dan J Williams <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        David E Box <david.e.box@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        "Florent DELAHAYE" <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        <mumblingdrunkard@protonmail.com>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH 1/2] x86/pci: Simplify is_mmconf_reserved() messages
Message-ID: <63bda96bcb95c_5178e29418@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230110180243.1590045-1-helgaas@kernel.org>
 <20230110180243.1590045-2-helgaas@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230110180243.1590045-2-helgaas@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM8PR11MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 477e8a96-23b3-4151-45c1-08daf33591a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLDHARE4K5jaKHAHT4TjT9+lBXCIPh3CRd9bMc2x4vMDcn9IQFap2kHnf3f8EmgYOmaUrhP2YhSw6h9yKw6xohEcoOC9gcSCH5qmzUGmq8vZvISx/KesWxCzHBcqy3QbsA+zmmBQalppOSyWV4RxwK279CDf912eLF2FQ7Vzpe6APOen2zi6AP8gSZMIdOPHR6yebC+Sx/TzcNuqhVcycnz2S4PwECQP+b6AS7jsrzYAhH3mo9OLv+Gf99TT51MWsZ+mTjtIlLhvC8K7OH8RbzPfKgs6xY9EpBQRG9FcZrYpQ4HEEWvUhU4fXOHOKnMEtye70GuB5TB/gaZeKeF7IhlSyHcOpn5AcgNzPSLHttPV0y9NPHT/wZ+bJLmPj+kOf1zr6qHsHUL/GCr9C92a7XUWmumcjSzY2+8UAoLEnbjwlmuSjw3ps2hvJg9ooFIr6ABdW3c/l27/ZWY/1698AU6+U7R98dolWN3a/Z6F+GnHvaEFfo4T6rF5eDO87dW2LMBAYWo6Cde05MTAxi+HTq25QvzfbY55NQFy34iJ6HNes3fRQ44C3FHv1BB1YGE9OY1KyJbCEW012j6izypodjDFCTkVAH0WUN+QR2E6uJ30Gf3WOMlPKyF4YBYgJHijFUV1iFjeKN229YCg7lUlMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(6506007)(38100700002)(82960400001)(15650500001)(6666004)(2906002)(478600001)(6486002)(7416002)(9686003)(26005)(6512007)(186003)(5660300002)(316002)(83380400001)(8936002)(86362001)(41300700001)(8676002)(54906003)(4326008)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VlluctPTg9oGqcDvJC4BKDaAHiG1lrqCH5jNzu5g8QLbrHnc3QCKgEST5daF?=
 =?us-ascii?Q?zIv+epKThJCEQpnv9r0yYSR9hXnMO5Teea3bFtfTIwQd9+NwRbmDZLKhUtPW?=
 =?us-ascii?Q?jzuZg8dvbu/SPGLBCBPwBAr0KrOGgFKMRAPabvqeefe0ei79a2CBpjS9vAh6?=
 =?us-ascii?Q?yN2e8a5lKcPiGyvNm4wPPUdd5Q6uIlJOBzuLSKsReT9GZoTGl1HfX2RYn10I?=
 =?us-ascii?Q?qUwLNaT9p2vdBSF2VSpcILGPBFQd0bgrrM3TegspW6fzDLATNkTv7jAAJC6l?=
 =?us-ascii?Q?Ehf6YSYkU96O+Sjr+tgDxFfaptnURCx5q2pG42fcnDL0u/sJBBI8iyYzPMRZ?=
 =?us-ascii?Q?iOUXxcFI4LP0DSNuNJbc9/WJOJccsPF27LgNoZT3ArBch+DLXgcKR894pBmk?=
 =?us-ascii?Q?qipqKF5Rqsjf6wkLjx7R83EJo1gfxnBT4YTzmYsEIfzT33eYgkpnsZVjtEet?=
 =?us-ascii?Q?upk+dOysb+2hCrW+SCfPlM27IYKBFRQkuQBUPw9Ph+T/w2+ZECRkx29i/RU7?=
 =?us-ascii?Q?1mqbnQ5qdurIPJEJN7T4JWQRATQ5gyQMH9OV/JswC+YfYZq74JET0P8z1RBq?=
 =?us-ascii?Q?PoYRYmtOXq3jRF/GBC/DfVX89nW+2lb7z4Yv6R9CNSJKOmf2Zb1i+3pDUKMm?=
 =?us-ascii?Q?qcxNb3DUTw1jWBX5HO/bT+fi52+tB+cEZG9iSl/1hUBn1EL0EzvDImdCEBOj?=
 =?us-ascii?Q?C2IoO+CTnxvaLlzRgujzk94SLkz93Xanirz87gaaoutNaERZNCYL472nlPtu?=
 =?us-ascii?Q?YpluI5WicztRpsjYAVw3Mbw5IvmoClhaT78TSDiSLttLF1M0/lLtQU79EByJ?=
 =?us-ascii?Q?xo+EQmv+gv+ITwCDht8ljktYVnsURuM7T/gWVOTNwr6kn15qYXqPlQyhIjgu?=
 =?us-ascii?Q?6u0N9g1T7N3rG1xf4qCLdJHisIMK6UNmBC8UxRHee4Gsp/4aHNRPP3mC3296?=
 =?us-ascii?Q?vqgu3IteVG4qb+6d89bAUr6s6bWsJ/w8h+HjFGdXpFLDjvhz9+5w3MK+wbDy?=
 =?us-ascii?Q?9jSIgpsfIE1MxVspEWQZQ/hQ9NZZB15B3ICit8SCDBDP/cYlnMNzflx+LGzF?=
 =?us-ascii?Q?kWnZs3nwmAW2ZkRTYWJ2puMbgOm6ivc0SyWTbibqGhSWSYzxs7CvCCzml0su?=
 =?us-ascii?Q?dO4wVIsExcIx8EeNo+i4pX6EestOHGLOngDOatSVAcp+10xuHxKyroF4I3cr?=
 =?us-ascii?Q?vhG0iFjjvyFeBuuPecaIL72z9dTHy98UGkhWloz5Or6R/MY3lelNC8lpn1ZT?=
 =?us-ascii?Q?bXoyRO6apBlGxaFc/B6CgYpJjh+bKhyp/u9HeMbEMjW0zSuX2HQ5VAuth3dq?=
 =?us-ascii?Q?PeOWhLCoAr3iJwN/VcoYq6N+ipJyP3QxnV6/MD44RUpa+cEJB3OHT1WdaYXL?=
 =?us-ascii?Q?pdS8rca5RuC6AefZJJQ5p5YxdJ4uBAqPqSk7P9jiaR1ZFp2cOMYj2KU4gbGr?=
 =?us-ascii?Q?ZrC+xCAJ4UFq89pXmQsZzMi8AXccLMiONlWsuA6JdFsPCF0RJRS2HdhMtJl4?=
 =?us-ascii?Q?En5yGbogCwSZQCIoUQW7q0zlsUZtntMTCfJmtsFtcg2Hl/rwOT3UvCr3Y5Zk?=
 =?us-ascii?Q?LVhaYZRInlDZNRLHpQzWm++Nt20Sa87TH/hEm2oJQ9SMPADxIHETMgzyd31A?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 477e8a96-23b3-4151-45c1-08daf33591a2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 18:07:43.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cKeGoqHr6K0gvN1jZuoKlMUexDxCtNT2CmeMlpQyjKRe0y5o6JQr1e0KK9OUAmstGFp7EJTb08VEelIC8kl4c68dmyHlC+bXi+PE+VghSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5574
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> is_mmconf_reserved() takes a "with_e820" parameter that only determines the
> message logged if it finds the MMCONFIG region is reserved.  Pass the
> message directly, which will simplify a future patch that adds a new way of
> looking for that reservation.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/x86/pci/mmconfig-shared.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 758cbfe55daa..cd16bef5f2d9 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -446,13 +446,12 @@ typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
>  
>  static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
>  				     struct pci_mmcfg_region *cfg,
> -				     struct device *dev, int with_e820)
> +				     struct device *dev, char *method)

@method could be 'const char *', but either way:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
