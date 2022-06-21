Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7A553A05
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 21:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiFUTKN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 15:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbiFUTKM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 15:10:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F130E2A94C;
        Tue, 21 Jun 2022 12:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655838610; x=1687374610;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=q5lkSZYGMhUVLUD1y8XgQ6GVWz2Y7+JfJKiVN+E6OZE=;
  b=VwvOieK3/wNCOOY24EdSaVOWhfgEwcfxhEzBDEmB58TMsioxhTzukR5Z
   W8Q9YvT3y4a5ScIPzmUlUw1jWBaZcE04p06hgJqLjzOmfeihYXkJmsZNo
   eVTJ/s4WnFLjlyYyQf+hYzwsajv9vR19lz01+TOJAROVq/ZoIMBgxXLQ0
   P/Lw74bPJO988tIc3egFAiEmgzOmI7QrkMimrhxQ2pd/0xYDDg65woPvx
   iy2+Tr/i+qk4joikg17jg8R01Q9EmMyPLaqtlCY5pHITKU3Hndxf5mqEO
   FxScP+vLgtd7gL6xDRyEEtbWLlnVFX0a4QVzoJVY21GXNTux6JXybolPg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="277762769"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="277762769"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 12:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="620603138"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2022 12:10:10 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 12:10:10 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 12:10:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 21 Jun 2022 12:10:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 21 Jun 2022 12:10:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk6nW02rMqEqNARCCIvjoNiuxvk94UFAHUOWbHvek1ZC+6H/mJq0ECX80TqxA0gBeN0T9pKYxlqBGELpuj/qeNrjYeJSx1Kqgf8IFHEstDXrAcjRc+U752TUWod+mIChl5cyT9aKN+S2lpu3AxepLJMscR3Es+JRTlkrWoKtSpUQoNb6xHznBy0Min5AM0gNDeQK+8P8IVEGlqi6QM90aUtZ0dJWFgEhnhoE8copDU2iam2HoWctbfLimhFt50G6fEQBmrROG2Q9I8D7976l4Li2drjFaxjPME3qMNqQs4VH32/3WKDuPCQYuwpfwgbPhUMhlopOtNoogjzv3g2Ydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSUNDWoVF6M5RSKCNgbezV0a8l+bz1lbqxuh8/GJf5s=;
 b=Rwnol1lAog3OU5Pw/GZ27JTRTN/L4KJqyMMim17s3ErUhZVrgenwRZ+ft8Ky2LeMSxpStDaGolEy7modXEMQf6lc14D1LcOHfPmjPGFX6jyuCiIBBQG48iBPTzotsQ18nHNMJITDtZ8dlNrHCoYoBlfXqUtriSDxClM2W5L2bnU8pfJ/o6JZxAmeDwfIcl52TeP0Y0fZpmV57jUMUK2uRqHnftBYbd6ddtm3L8fUhQd6U2/VBMATlwN3ZIwES6XydJVxRj50lgSBBoqWZJOoRuO9vk4GO/yc3SRGLkB9mZy7/Smmh8d96cF3kzkXCrH8+53O/D8Mf6tny+algLs3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY4PR1101MB2231.namprd11.prod.outlook.com
 (2603:10b6:910:1f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Tue, 21 Jun
 2022 19:10:07 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 19:10:07 +0000
Date:   Tue, 21 Jun 2022 12:10:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V11 5/8] cxl/port: Read CDAT table
Message-ID: <62b2178bdcf5d_89207294ac@dwillia2-xfh.notmuch>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-6-ira.weiny@intel.com>
 <62ad1fb69d742_8920729490@dwillia2-xfh.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62ad1fb69d742_8920729490@dwillia2-xfh.notmuch>
X-ClientProxiedBy: CO1PR15CA0067.namprd15.prod.outlook.com
 (2603:10b6:101:20::11) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8511487-cdb2-4c97-1cf9-08da53b9a74d
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2231:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2231E085A3909344D1603A13C6B39@CY4PR1101MB2231.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dap9qtuBDZSNoendpnlwCBvx4xKGwKGcfP/GCQA/4Klp39x+yR20HZvTf4a8DHpeyL40M8bmEwRMHqzYU8igYqKkvb97NFkDeH62o+sz1F69kjsskyKgoPmGxCLFHUM0kfqG5mTNHrtFJTwn1cWXjScWppccFinXSzdLQI9hUREjLqgeXu6Yp/7DLiJ9phfCEtVxQN88lnB62eQcuHhDOevMHa6NNtc40EdyXz8ih4FZeMpXRXJbTpOtQ27UQcsEGBibxfukN49jUyka5i8ZPRxyP0zbxPLu8ItWEhX+k9XjLHxHBNLjgZJj4kDpJ3QjMr3T4s69QPAn/amaTu4uxJEbrlCeNLvdvb6iOPZfGinEKicyJ7oV/RDeeJTH+KdZ+nRHQuRwua4VJjkUmcdtlmwvHSxFo0VRyrdPi0g+TFmJQlAPr1lhs0/75w5tHJqrZB+JI4kjjl6hPJUEZBH22mAKH5ZHElTG4lpNAxnLpjoJXNyZhtKK/vgkBYi7xIvRUOWyJg2Cth8D3kOoAqCfCbjBY2q5c201M9NsAoCedJpRfa7YtFR/Iitkb+Scefw4rHQez4IKwT/8Ifen75WB2uBJv8GAJT6M4g7CYFsJTJDMmO6NR6W8bcKhzUAH1q/nZIQSaMdxlETerHXiVqGdiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(136003)(366004)(396003)(376002)(38100700002)(86362001)(5660300002)(478600001)(8936002)(82960400001)(6486002)(2906002)(316002)(110136005)(4326008)(66946007)(8676002)(6666004)(66556008)(186003)(83380400001)(6506007)(41300700001)(26005)(9686003)(6512007)(54906003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jxmT3u2HoIdLJ5CVbHBNkcKWdAGqQ+NRhzItEtqJomn2Jez6KO5P2o7Zw5hT?=
 =?us-ascii?Q?+8BZe4IvT101mOXfMfDC1g7aQBFK650hZpT1Z///vT6biQxLZweSSfpoI3an?=
 =?us-ascii?Q?NY+jSGWXnn8RN5+ORwivO0WRVQP/kUFScJ6LKQOKU0EIyPzfHvF4dDT0DVNl?=
 =?us-ascii?Q?0rYC0Rz03VW9Mp3l6VES2xPD0ne4gOR594w5tvxpbn14ul9WnIm6c8btLEM6?=
 =?us-ascii?Q?XrwPv4iJnvsd/D7xo/cTSYUClyXTy6hYM2K9/asAjCSfJ52ereWmp4hliD1d?=
 =?us-ascii?Q?AU6RGLZ+bfUDQg8ivZuUoGePvP+E3N7w750bDBnCGSuortTYAFFsJZBa93pd?=
 =?us-ascii?Q?EB6glhlmjFB2HZKH/5z4DeT2Al80naK4k/95tJi2nBeLv8LlRMKGEJdypbiM?=
 =?us-ascii?Q?uLiz/i4tSA7e+y1GDElJXuCCdEaTPLhtXhHLYOcaCItz5OTOZbIwiFvhyDth?=
 =?us-ascii?Q?tdQKwLvsL1SjQbP9mlbGns/L8HCvO/Ubd23GoAWp+q0GtrgXEk9btRMYuiQX?=
 =?us-ascii?Q?X+jPKdEwLta5wa/klennFhQgrrPAh/ePTo77Y0YlToWesPrmP7Gu9o/W/AZx?=
 =?us-ascii?Q?vPwTPakh+F7HjMp0V+4WwWVza/AVbi7ujvm0loydwimtdfxnhwerTgZVytlk?=
 =?us-ascii?Q?Z9Ve+bLy/GarEYZyEp5rHm+jVrsZEDbYfmKkeyPdHvHyXTuArAzbOCBhztt0?=
 =?us-ascii?Q?2OYUcHcX0hiogHcNfvrBGp9csh9U9NsE3XEIW+wKv145EQ6hBNtK59Xyasmu?=
 =?us-ascii?Q?xkiaQwQbP4iMmH0wmNk4dD5nc4S6qrcYtke5VbiGuxeNYW1oGJxxOnsnJ7t5?=
 =?us-ascii?Q?zOJw4pB3bfkFkae1Z+M5B+oBGONJLAx5Z55NG3GeQ4ieCOSbVgXpEnGnUMSO?=
 =?us-ascii?Q?Pe5BR7nevy1cOL1wLloVVHXtNHN67iq8WIbZkZpjPgOZ7BjZQ9qZ023yLZgS?=
 =?us-ascii?Q?VQILfVL83hhSdHHo1YsZAn9v985vhdTnQQQ3/u56lhjjYfGY09bNT8rDm3aa?=
 =?us-ascii?Q?OS7pE1jK0WF0FGegi0nWyobVitbvPJZgY5He0ZNncLOG4q0e0pyD63UCqsNj?=
 =?us-ascii?Q?FV2cbjyQ5imhfWT1aMkUIUf//6XijEclZjtthpJT1t318+Hi0EtdJ7Wfjssw?=
 =?us-ascii?Q?4s2d/7KVkip9eozDDcX+031h5IudVUq/99azB0+zf0GxI+rH6glzWK7vO/4C?=
 =?us-ascii?Q?xj6TgQZVFIC6FrHp+7zT6bnGxO51Y0q8KNWZlaN1E83ars642kXJp8ykrbIE?=
 =?us-ascii?Q?PMQZKX9QzmYMqG2G9CcSPYYDPAJT63ZVLjPfA6H2+uFtn/LKAAWL+rE+Bx6H?=
 =?us-ascii?Q?SpzIqyamUIx5TLhHon7nNjMsgxh7tfzBYGlw7CQCaVR6o3wU4IMbkqH2RymW?=
 =?us-ascii?Q?4PL0K9vWq7TIE4XGKSvvALo8Ys4HlLepEs+VZyUuXOZKrR4TsFDDwkCInv3T?=
 =?us-ascii?Q?bDpBDBXv1hayWgYNwbNN98wD6xauN0fbL15FIwqytHtbknwssABKqAnGljhb?=
 =?us-ascii?Q?gt3j52VGF1+Wsz1v7VHJMwl05aid/swNT5Ykfk7+1VrMZKBgXJ05DcMkXzyO?=
 =?us-ascii?Q?QDlViO4VVCYCPhnmKpGdNhnZZ1J6aSw1cEEbd8KshUiQ8lmssurVjdpVltee?=
 =?us-ascii?Q?DFDDNaSJNXdVomEL4SBVsIhEhcLXtS2UZyCfwXJGJcd81SN99yRF4YNBa9xX?=
 =?us-ascii?Q?LfiV1OqBISOgcehVHdEdZF2ElKm00VP0Tiv+LZCMqFQV9VfQEMtCWednVKh6?=
 =?us-ascii?Q?jCw82NJs+CNaJd3dky7JRTPjJ9MXsS0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8511487-cdb2-4c97-1cf9-08da53b9a74d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 19:10:06.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMub0rDcsM2SzFYbP+eGfY98IOHkHAGN0R2n8ND4hWtyVUARwj9C1AnBikbK2cqVlvVPLkTmb0yi3AX35x+jc0FeXY+SAwiXFEEzamIGHM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2231
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

Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
[..]
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index c4c99ff7b55e..84dc82f7dff0 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -4,10 +4,12 @@
> >  #include <linux/device.h>
> >  #include <linux/delay.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> >  #include <cxlpci.h>
> >  #include <cxlmem.h>
> >  #include <cxl.h>
> >  #include "core.h"
> > +#include "cdat.h"
> >  
> >  /**
> >   * DOC: cxl core pci
> > @@ -458,3 +460,173 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
> > +
> > +static struct pci_doe_mb *find_cdat_mb(struct device *uport)
> > +{
> > +	struct cxl_memdev *cxlmd;
> > +	struct cxl_dev_state *cxlds;
> > +	int i;
> > +
> > +	if (!is_cxl_memdev(uport))
> > +		return NULL;
> > +
> > +	cxlmd = to_cxl_memdev(uport);
> > +	cxlds = cxlmd->cxlds;
> 
> This feels stuck between 2 worlds. Either cxl_port_probe() needs to do
> the enumeration, or the attribute needs to move to be memdev relative.
> Given that CXL switches are going to also have CDAT data, then the
> former path needs to happen. Yes, cxl_pci still needs to do the vector
> allocation, but it does not need to do the PCI DOE probing.

It is really the interrupt setup that makes this an awkward fit all
around. The PCI core knows how to handle capabilities with interrupts,
but only for PCIe port services. DOE is both a PCIe port service *and*
and "endpoint service" like VPD (pci_vpd_init()). The more I think about
this the closer I get to the recommendation from Lukas which is that
DOE is more like pci_vpd_init() than pci_aer_init(), or a custom
enabling per driver.

If the DOE enumeration moves to a sub-function of
pci_init_capabilities() then the cxl_pci and/or cxl_port drivers just
look those up and use them. The DOE instances would remain in polled
mode unless and until a PCI driver added interrupt support late. In
other words, DOE can follow the VPD init model as long as interrupts are
not involved, and if interrupts are desired it requires late allocation
of IRQ vectors.
