Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2636B6DDFEB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 17:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjDKPsc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 11:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDKPsb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 11:48:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503642723;
        Tue, 11 Apr 2023 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681228110; x=1712764110;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kpmb7vEFgTqXzslHHjM8c9Hv5FgN33dFrZNHAMo7U/U=;
  b=K0bJK0qibWnIX5IpPRZPgQBhCIwsk2BpHKy1x+veQl8racNsGPaslADi
   osuPKVU8uzVsUz8GHunlgI7Q71Is1dYtDNhxfQpFwXVIjGuNhTLGVDqY3
   bK9UPaSQEKvt4JL4IkJFwcfh+bxj65947uKdJk4XW6hmis6tkDoaHHmiv
   vQqL3uf8Dqdy0GkMEXwtiQkfGo8Qga5V5fukpgLc28PFwvDvxvBBcvtU/
   ZGTsYqK3H3c272Dqi2KokSXZfHmF+W1WPRXC1E5VUZVoBTssmOLDCIe9v
   J7RUE2xOW0Hbt4pMetE/Pi2SQZx6F74SPMdS9rsJOEqIN66SU+cDJpZ2A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="345441248"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="345441248"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 08:48:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="832386595"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="832386595"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2023 08:48:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 08:48:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 08:48:28 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 08:48:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezCWnTZfWME1dotK3cx34fb3MDY+KHBrgn9t4l+UkfXuGwF26XuPcLC3eDX5jOUF98ONmpQ2Fy0CYL/eappR0gEfpqNW9Nio1DU7MYPaLGqimF6pur+0q4W6C+Usom7pz3mNzWJkqn/eVEcUIZY4unYyUqFEiFXvzGC4PwqU1g3GM8ZXxq42bW2OEek9I0I2v6KxH5s9rWTMjgRu3V9UnhvHOoJZKARY3NXbsHbCol7BVoo13pTWKxLHS+D29rkdQAgBYz8lZC4xdUNmZ9381AWgu7TsbCkLRqaZlgqkA2du81M2uqJ/+P3NplHBsjt82me0J6OS30bwh637PtMG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvicbpffLadSX92wbJ2wLssy7u19UTWwnO1A+uAHg7g=;
 b=Y2ck8fbZGCnK4qgR67rioifCD69DovoG6tdAwnfTpvgwzwFdiWA5eoSWoAwo70i2LCYCrSmgUjlsxdNXLqrZmTJEEMx68gS9CVnPjLtz1xrUJwH4JCdUG97MdNa6HVPLZRmDT6sLZRT76mesebRjoXCDyxut3JrJA/XHITOUKsz3GAtXRllLMpynMozaGHdvDObcIwXMtuz0f9JQahSJ5NWGKymyEC6h3M+owI5zsb6YKp1fxsGVFKUDHSfv//HLR7ls/bTTg4EwQbUNr4w6MkA1ZOWHCg61OVYIg8pVYgK+omehA94FQEV6Cvf1pYelh5RjcVb69x9Mf84xlOHMww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3457.namprd11.prod.outlook.com (2603:10b6:208:64::24)
 by SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 15:48:25 +0000
Received: from BL0PR11MB3457.namprd11.prod.outlook.com
 ([fe80::ece1:dda0:e3f4:8414]) by BL0PR11MB3457.namprd11.prod.outlook.com
 ([fe80::ece1:dda0:e3f4:8414%6]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 15:48:25 +0000
From:   "Lee, Ron" <ron.lee@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lmajczak@google.com" <lmajczak@google.com>,
        "Jain, Rajat" <rajatja@google.com>,
        Ron Lee <ron.lee.intel@gmail.com>
Subject: RE: [PATCH v3] PCI: Fix up L1SS capability for Intel Apollo Lake PCIe
 bridge
Thread-Topic: [PATCH v3] PCI: Fix up L1SS capability for Intel Apollo Lake
 PCIe bridge
Thread-Index: AQHZOjhfGpa8Ts+SOkWWnjUqajW2Fq8aguUAgAwc4BA=
Date:   Tue, 11 Apr 2023 15:48:25 +0000
Message-ID: <BL0PR11MB3457D8D26AA0070FF966CAD8FE9A9@BL0PR11MB3457.namprd11.prod.outlook.com>
References: <20230206143540.15325-1-ron.lee@intel.com>
 <20230403222852.GA3471710@bhelgaas>
In-Reply-To: <20230403222852.GA3471710@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3457:EE_|SA1PR11MB6565:EE_
x-ms-office365-filtering-correlation-id: 8e9805ce-bdf3-4746-f0df-08db3aa42fdc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U13jO1i3hnFe4pHt5WIYRtUkrgcEf/nzM0nZpbVZ5u65CnQ5WkjP2FrnMPfBF8/doSRXptWCqShHNHdbJe6aAoImot5Li+IGvH0Ics0zpH95+hG1uNefsyaJgfEb0ZMuI6OCldvFxLv4cDFqVdUQO47xFXKZAXsKBUHpajEe9nLkFhX6Iy1UQtQP0+Y0mab3u1usKy+YAgu+Dyq88EVVOnE0VF2HZR9kGLLlbD8bQcpADtmSCpvblP/jc8GrTDhANgpRSJjmm1+sKhYjgXad33DFpUOK4Ri8W/NvVkuZGR908TgXCmS5BzYg63oK8abfq+MNEv3q1k/01y4HTI9L25qST7pnOEkp3LL69c44Y2ZJki4Qpo+JJ8Zfbb91sbC5DxcTy5Abx72HypgslrOnypjJkOxk9ujEq1tIY9L8P8di3W3SBsjacQGZV8m3PvFn95obai1ZC6B0079/M11ZMhQryIdkFV8v/FDJUvn7uRkl4e6dLbtnT8DXQKsaq5jNMTHLGa2jXhMWMGUfqanUskpZBeDAEac7xq2fQZYu4VyhZVGgzwbyGFSVTJGwzfctBVZZ5Swrcx8l935Hchhvgz/YDFGJf5IFljn7f5q0STjnJiCQG+9114d4yp16nM8T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3457.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199021)(5660300002)(41300700001)(8676002)(8936002)(52536014)(55016003)(38070700005)(2906002)(82960400001)(122000001)(38100700002)(966005)(71200400001)(7696005)(83380400001)(478600001)(33656002)(186003)(9686003)(6506007)(26005)(86362001)(4326008)(6916009)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?042HHZ0dS2RW4Hojgp9qH92BJu6rXwZHPM62kO7yv9TBm+q6Xm/PZS/rjAv5?=
 =?us-ascii?Q?6VueMjwl2uzGX/rIIhO2uaBF5WnU9TvnkdeT0Zowo7NxV3EIex6vGJLriy42?=
 =?us-ascii?Q?6d5fELI32uPH+wGXUPRhPoNpC3zIQPY/wqu1xMCnUfC1IkM1mT3/GZTbSmnA?=
 =?us-ascii?Q?VJ638DZN5hU28IJ6Y2n9Uly6MCoqlixDNDPcn6eNueqXYGnkJ0YdDGMqOUcr?=
 =?us-ascii?Q?MCSbtH4QnGSNY5mPJEQRHp51QjDrjcMWJYoDrKnamn2FF4OIBHWa7P8nlwvt?=
 =?us-ascii?Q?MmOwqJZ1SXCeJYhIXL75E/7mfvzs9P4ed1bcQ5WMiKwa1taX8HQ/2iIWSoUE?=
 =?us-ascii?Q?4wlNm1tLxk94UozHqySm5oqa6/OOV4vjQ96FJLun3/TXeS5KR7A8K8yJHfMz?=
 =?us-ascii?Q?7FDUqWDpmpJUIGgdbStRXwZVBWT9ESGGnvXEg2T4+p65Fl1Kimp8GZxZrtse?=
 =?us-ascii?Q?9e7feED7sVpdBN7dEGgqf4e6GkWOyCRfmZgzgc/5DQamlm1sk1x4Tz4a6P8Q?=
 =?us-ascii?Q?De69VbENS8mKP/dJyMtw17rfAfDxEgIV/RFzE56Nb0RydKZ32oVAB0/psNbT?=
 =?us-ascii?Q?Gov9hstZAnSyg8ow/7S+PcN77HHnLDzY66N0rjc0INgvFx79tmq2YxQbhVvN?=
 =?us-ascii?Q?P8nLViG8+vpchr7TzbVMkxde2UXGUt6q1rNR6tvuia3Dn0DD8FB2z2I2MPjI?=
 =?us-ascii?Q?FoULpRIHyGznJAPSDwavGxzm/VInamA+yLXw7wCRey+R2VUzP5VxbwT76L1h?=
 =?us-ascii?Q?3RyK+NxYvPHEZGLFK/WMNd/ndTMPUHGWyq6yIHe7q2HHN5KGX1TBekomzGOS?=
 =?us-ascii?Q?YRLrASToY/NHo+zWSTOV4Z6wLTRBlFz+eYGh4yI60XG8B2+pqMte8FpwvjxO?=
 =?us-ascii?Q?AF4zjYnav2j6vxEVGzZe0DUOoJeKdbwtMzsY+kLgsmfvHuK9eEA7df2HBOhb?=
 =?us-ascii?Q?EVq11g2qby4IfCtWpRGY7Mst0UN79puygzVtJkHqdIsM1eEmp0rR0BHpk47h?=
 =?us-ascii?Q?ItAHdiIV1lMOFOanggdn1TIrXdv3kk6ToTLN+z9FoDABFQz7UGayKsbMGBHa?=
 =?us-ascii?Q?2rE66oiQB4PQrPRmE521WOOKpx0HsJd16FXxBzrfPpo8xPPAC/9yk2O30VCC?=
 =?us-ascii?Q?dXgWgX6BJ0tIFI4GMVfVvwWUZxRsurLeT9l/LqDCzb53/mcbDf/Ygu+CKRk4?=
 =?us-ascii?Q?EeDU1U/u66j49ZQyEnKP/xWKrsAXFQRUYp/2ngDLV5DA9FDY6obFh4sOzDqs?=
 =?us-ascii?Q?QmLV21fH1I9sAVYWBKKIqI+ZOLyNESK9yzb5T6jcDmm9H5e8Ct3OYJE1oABc?=
 =?us-ascii?Q?byniK0wELWhqBbSaKtBV7WlLmO3WGK50+HAil7HonsXZjLZZQ6vXEvCUJZgn?=
 =?us-ascii?Q?IsvX+j9//FxOnYYwq26BSVmxYUkE7nC2pf1NWMlebKD6c/dWxr3h4qqN7kMn?=
 =?us-ascii?Q?fBE1ClrRLTfwPttWnIc63E9DcoQbm3vKLXYDQtOcOsfQQX90JVYmaRYUCRIa?=
 =?us-ascii?Q?V8z5kEGQrw8iCNSRmxuQg91A0mF+jWHR2rIANh8EaE0itx68+pMGYQqFNZfg?=
 =?us-ascii?Q?OumlPr+uMN6rdYchkoI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3457.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9805ce-bdf3-4746-f0df-08db3aa42fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 15:48:25.4976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: miYjKN+fTSA1xYcKleijfPNJdXf8QbhfqVZvD8dGt9L3BFPnimh5/YtmtRxa4zHzOKGroMNl9uncpmLkz7RN/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> What do you think of the possible revision below?
>=20
>   - Moved to arch/x86/pci/fixup.c since this is x86-only.
>   - Save prev cap offset & header, L1SS offset & header.  This means
>     we can fix up even when CONFIG_PCIEASPM is not enabled, we can
>     restore the entire previous cap header (not just the link), and
>     should be safe since only one device per system should match the
>     Device ID.
>=20
> Bjorn
>=20
Hi Bjorn,

Thank you revise this patch,=20
it is more concise and make sense moving to arch/x86/pci/fixup.c
I corrected the following statement in the loop.
> +		prev_header =3D header;

BTW, I add "return" to stop traversal once L1SS capability was found,=20
will submit the v4 patch later for you review.

+	while (pos) {
+		pci_read_config_dword(dev, pos, &header);
+		if (PCI_EXT_CAP_ID(header) =3D=3D PCI_EXT_CAP_ID_L1SS) {
+			prev_cap =3D prev;
+			prev_header =3D pheader;
+			l1ss_cap =3D pos;
+			l1ss_header =3D header;
+			return;
+		}
+
+		prev =3D pos;
+		pheader =3D header;
+		pos =3D PCI_EXT_CAP_NEXT(header);
+	}

> commit e082cb8ab59f ("PCI: Fix up L1SS capability for Intel Apollo Lake R=
oot
> Port") parent 52589007b243
> Author: Ron Lee <ron.lee.intel@gmail.com>
> Date:   Mon Apr 3 16:30:16 2023 -0500
>=20
>     PCI: Fix up L1SS capability for Intel Apollo Lake Root Port
>=20
>     On Google Coral and Reef family Chromebooks with Intel Apollo Lake
>     SoC, firmware clobbers the headers of the L1 PM Substates capability =
and
>     the previous capability when returning from D3cold to D0.
>=20
>     Save those headers at enumeration-time and restore them at resume.
>=20
>     Link: https://lore.kernel.org/linux-pci/CAFJ_xbq0cxcH-
> cgpXLU4Mjk30+muWyWm1aUZGK7iG53yaLBaQg@mail.gmail.com/T/#u
>=20
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c index
> 615a76d70019..ad0dfb22b4a6 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -824,3 +824,61 @@ static void rs690_fix_64bit_dma(struct pci_dev *pdev=
)
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7910,
> rs690_fix_64bit_dma);
>=20
>  #endif
> +
> +/*
> + * When returning from D3cold to D0, firmware on some Google Coral and
> +Reef
> + * family Chromebooks with Intel Apollo Lake SoC clobbers the headers
> +of
> + * both the L1 PM Substates capability and the previous capability for
> +the
> + * "Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port B #1"=
.
> + *
> + * Save those values at enumeration-time and restore them at resume.
> + */
> +
> +static u16 prev_cap, l1ss_cap;
> +static u32 prev_header, l1ss_header;
> +
> +static void chromeos_save_apl_pci_l1ss_capability(struct pci_dev *dev)
> +{
> +	int pos =3D PCI_CFG_SPACE_SIZE, prev =3D 0;
> +	u32 header, pheader =3D 0;
> +
> +	while (pos) {
> +		pci_read_config_dword(dev, pos, &header);
> +		if (PCI_EXT_CAP_ID(header) =3D=3D PCI_EXT_CAP_ID_L1SS) {
> +			prev_cap =3D prev;
> +			prev_header =3D pheader;
> +			l1ss_cap =3D pos;
> +			l1ss_header =3D header;
> +		}
> +
> +		prev =3D pos;
> +		prev_header =3D header;
> +		pos =3D PCI_EXT_CAP_NEXT(header);
> +	}
> +}
> +
> +static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *dev)
> +{
> +	u32 header;
> +
> +	if (!prev_cap || !prev_header || !l1ss_cap || !l1ss_header)
> +		return;
> +
> +	/* Fixup the header of L1SS Capability if missing */
> +	pci_read_config_dword(dev, l1ss_cap, &header);
> +	if (header !=3D l1ss_header) {
> +		pci_write_config_dword(dev, l1ss_cap, l1ss_header);
> +		pci_info(dev, "restore L1SS Capability header (was %#010x now
> %#010x)\n",
> +			 header, l1ss_header);
> +	}
> +
> +	/* Fixup the link to L1SS Capability if missing */
> +	pci_read_config_dword(dev, prev_cap, &header);
> +	if (header !=3D prev_header) {
> +		pci_write_config_dword(dev, prev_cap, prev_header);
> +		pci_info(dev, "restore previous Capability header (was %#010x
> now %#010x)\n",
> +			 header, prev_header);
> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6,
> +chromeos_save_apl_pci_l1ss_capability);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6,
> +chromeos_fixup_apl_pci_l1ss_capability);
