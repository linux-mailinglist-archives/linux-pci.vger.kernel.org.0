Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5E2659807
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 13:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiL3MNV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 07:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiL3MNU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 07:13:20 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74E4E07;
        Fri, 30 Dec 2022 04:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672402398; x=1703938398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ADo+yzXb9rQtFHJxZhl6tU3KxWtaPu7tkIgBD89HkfI=;
  b=gRNoBa+uNIE14LOJpy0Kz4IC70kiJYYDQ8gV01iZ/p2XQulyeluvaxKD
   0dvD7ETXFfcIQZtkRiUybhJPjt5LZlg7/fD0g8UMwJ/4OKxakKkf9YAIc
   btybvakCXaoNFRZAx7QbN+H3SG/y2vjOh7mLXu21VPXLVSe5VgC9MmQnt
   JhTsHj0EFbC1CPwlNmtm8bq4SIImysWt8XVQ8dznZ6BCi9jNCOu/SNnQy
   vJyGhcS4a3aL3K30bkFB7RfK+vODR83CNSoLg3ZycGR/fPZjzZ2WoBoBD
   QELZiCAU2IPaj870vFIylg6zPqIX+aUWkFMOA3fbS48Nkajlxdbg5R6+d
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="300891324"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="300891324"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 04:13:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="777945906"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="777945906"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 30 Dec 2022 04:13:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 30 Dec 2022 04:13:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 30 Dec 2022 04:13:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 30 Dec 2022 04:13:14 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 30 Dec 2022 04:13:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcO0Il2xzc54ZDmDBVhXIlnX2lS36aRdGWLDTMLY71a39qeBB1EQxl07KCM1e+CargwXf2oplwODDWNU8bnLMmsJzBEo6110f0hadHgEvX6clfT9iiC3GOSZFeEko+ysckG46UFdCqVqyftgKyaLDfK9NsxwygYcByZB6gvdGqEBHJ10tqKwxq1HKM5SVr1fgjtwD6Cq4pYingFEs+fc/pgjcuy0HwDcji4hMH3L94e9bQzHSJHSkXSIo8hr5vVOUL5ECA3796L5lsS8Xe5NFy1iMQ78aOTDLsGGCrgeZkj1lTmmMYX984c1+LICRc/hq83n2L+GqwOrexRIDiAVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLUKFCZVNdMrL4ThIAHNHt5OJ3Y749wHarWNaXRxOLE=;
 b=mBROBXi+7WLiOQzeN4eIonfdIRHGekkHnQNFMwMIMtxMlcagYL8r6RUYrjQqjGzo8XLxxA/9qp9ebwQfQQKi2J9KPhtA62j2I6Bl0Sf1rDiYDyU1il8wO6XZeYAd0oSYnKiincef4uTKRhkdScBh8y1Y7XvxvgRY8YE4zFrEBhF/ajUEfckUsn4YQs0NFns1U7L9fhg+v5m2+Kdqlgm+kgaZcZW14iv+nd72ItK8XBIhLTV2z7syEkXg27xm33Al3DPyWSXUdWDOABSyVictILF8t4IW/xFazpU/pqaMaN07MLwfZJlvyw2E4/fbtb3L3wCTRZNUykMUDYIK127I2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3457.namprd11.prod.outlook.com (2603:10b6:208:64::24)
 by DM6PR11MB4546.namprd11.prod.outlook.com (2603:10b6:5:2a7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 12:13:11 +0000
Received: from BL0PR11MB3457.namprd11.prod.outlook.com
 ([fe80::c8a4:588c:d831:f6aa]) by BL0PR11MB3457.namprd11.prod.outlook.com
 ([fe80::c8a4:588c:d831:f6aa%7]) with mapi id 15.20.5944.018; Fri, 30 Dec 2022
 12:13:11 +0000
From:   "Lee, Ron" <ron.lee@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lmajczak@google.com" <lmajczak@google.com>,
        "Jain, Rajat" <rajatja@google.com>,
        Ron Lee <ron.lee.intel@gmail.com>
Subject: RE: [PATCH v2] PCI: Fix up L1SS capability for Intel Apollolake PCIe
 bridge
Thread-Topic: [PATCH v2] PCI: Fix up L1SS capability for Intel Apollolake PCIe
 bridge
Thread-Index: AQHZEGWaE406GK/6VUCqucUZkFrJaK5vD4AAgAGUZSCABd9bMIAOzYeAgAEbzOA=
Date:   Fri, 30 Dec 2022 12:13:11 +0000
Message-ID: <BL0PR11MB34579A5F2BEC634F2F546522FEF09@BL0PR11MB3457.namprd11.prod.outlook.com>
References: <BL0PR11MB3457C04B0BF3E0F06A8607F2FEEA9@BL0PR11MB3457.namprd11.prod.outlook.com>
 <20221229190725.GA620646@bhelgaas>
In-Reply-To: <20221229190725.GA620646@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3457:EE_|DM6PR11MB4546:EE_
x-ms-office365-filtering-correlation-id: 2fda9157-4164-46ab-5907-08daea5f382c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qVe08iHEjMP+NUILrsDavhFJVpCYQMTNgnZZte7iT6hHaJW7tN8W+f+wkxstqN7PI9yQBSyvZOGzLHwL6gPn/JKkkRpHxcUJ4B5Z/AtU3e5SWzapsDKYQTOdxTwNfc8YlXhZv16enGMBriUGlCr/r2pQu0KXvB1gVlVHAlpUmz7Xg0MkDnu7vLkEJXguO740bADWMBglMuv0of9eiuaFuBz/QaAfcHgB3zr+zqCaR+b0MIm3SIxQAgSXc+8fjX64sF+q+oSIt3M8cANrZNU0MjKys1A5FY8ulMXFHFv0HEiTJetugKCUNDQCRQScesUPBvNTcNxWjfiPYkSo6OMAd7/bJ3KJ3sCwJi3jgi6kJnpdnQg9gTFFeY4RwDoSMJBL9XGzuFFQgobeiSPyMW94I1owX2j4U7L4tGk9PnV1ZDIXZpv2sBRPKzuvNqguFV79y6CMjf2iMlvkNLMypvAgx/Oo+2Gxqt3JY+vptTQWcoOR6quNS/1he0QlGtYuC207w2Bo3NmNFAJyZ1/QAkyHPlf5En6t5yl0StwvxkdqVmmgnZhbbBaD4fKb7EY4jUFa6McZjntAGKuLvt+fGVUxA7BXaOtsXTMjsXhRT0Ih47g6oRbWFfTHeEcjXQ9+76h0XMcaKIhm57jfinGHKP2uk/BiwWsOrQtkrydcMqLCht4/PEXeEbkeeW7ZerJqjEeDN4vRWvd7pf9dAB7o+CW9fw9nzOXUgzMcuSBFWAZCiuKBoATCvbnwF0Ol6jsX3kft
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3457.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(33656002)(71200400001)(478600001)(316002)(6916009)(54906003)(2906002)(6506007)(38070700005)(83380400001)(38100700002)(82960400001)(122000001)(55016003)(86362001)(7696005)(66446008)(9686003)(26005)(5660300002)(52536014)(8676002)(66946007)(76116006)(66476007)(66556008)(4326008)(186003)(8936002)(64756008)(41300700001)(32563001)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WRDjy6O0v/CxDHtlCKFdWN8XoSWWg/sl1tUlg7ClRP6EMZXxhRSMQUb3WX0H?=
 =?us-ascii?Q?ZsP/ZctmSpbEsx9EcxL5yxbOOqdCRFWQlzGVpyDzYv3T2RmoSIN4wamrIkrP?=
 =?us-ascii?Q?qsNgeQlvm/XBrxiOXyNxDQ/2eZPvQQz9wyYFLMhLHVYHGXIW/qs7a9F1axB2?=
 =?us-ascii?Q?5DXd99MGfqfuYXuTlEpoBiETsUkwTRIRXHdKS7J0xX1Cekc7upwWyxLHQ6hX?=
 =?us-ascii?Q?ZF03NDNR1I4oZYYaBGon+J2SqidfgqCtJifTK4Er/cnXVr5XbmFwih/TvbAS?=
 =?us-ascii?Q?b5zS90kzh2H5ti0QCnRWkdAa4N+B+t6Cq2/tApND8o+e9STWVB6GwBOT0CTE?=
 =?us-ascii?Q?LkBJsflKKpVFYxrhH8o5T1fA810iwHvrFSgnfa1E/h5yYS7/uBHtc/O3AkBy?=
 =?us-ascii?Q?facdfx1fEDRWc9L4GYoyfC+wqOanT0b6Fa7CUFk095+jMQV1sz8aUpWx3P5E?=
 =?us-ascii?Q?J+SnLfi3CUaDlYGtLFFxuAeLF+w4ZrHuegNQ81ATnx13HsF5BIdRX1H3LWiZ?=
 =?us-ascii?Q?SX2Uzc0L8ajdJYTVP5w5vyEIcne28NOE/bEfhtxL3E6gDMRAFqPCrQKKQK5F?=
 =?us-ascii?Q?deykC+wCmW4HPic6u1SPnGveDUnbRO/IBcxQA5ul3/Kat9QZcbX9GqoNv1xx?=
 =?us-ascii?Q?ymK3FHZdbRLpuYEoCIm+YjNyas6MVdL7fO2rXs6lVTG/VFdl/eicFfE74krG?=
 =?us-ascii?Q?k+ngunGfxEzR7LuzhhX7KRQMO3sH9rGIEE9Dwcd41NxBaF18nBm7L+DqvR/0?=
 =?us-ascii?Q?Ruv0Qo+7lZtVY91nI2BCTNlZFEF67tn8zJ+IpUj/a2f0waFJx228ZS3F1M18?=
 =?us-ascii?Q?pnCJ2COig6wvFDuvpASUOqXE1b4Ck3fMpdx64rU6RbUTArKtmfOVoDZYpVYs?=
 =?us-ascii?Q?mKW/90P1PGyLl6mjgMwVnETUqgmD0EHrWuR4YKaBWp/YRq/+Ezsse2DgtMPc?=
 =?us-ascii?Q?TLlFbiJMJhJHah3UQeD0Mod7ki10rOqzu1nqLHmQlvei4cSy8FCeo8dqMrzt?=
 =?us-ascii?Q?hGFlaaSe+r8gDSl5FczO1MyNmTn4HaUgq18Y9Ebrpy/w0I0mAzM74xpqYYRt?=
 =?us-ascii?Q?Zo3C6o6izwQxEu94ckEB+YLBFxiA6//qgHFhBa70qO/jDtozn+5ZziNMETM/?=
 =?us-ascii?Q?OjWL+L3WCF9B4pugQaxKMjeFjuohAhiXdZkYD8yOoVTID9VX4K+UQUZPnZeX?=
 =?us-ascii?Q?OWedgN7SPkbW8ppjVPGzoWUSwDXSdJZ3JnxLzgPJdVeXf2DRu2bApYwXfDgL?=
 =?us-ascii?Q?5PUsdCPkuwlowBUAloTJnWHGvdB7kL9YHGL/VVPIkhWVJq9vWL4kI6C0kEg0?=
 =?us-ascii?Q?CoQa80bL0pdijgz6rHTvS+ByJDx6w5a1390hSGvU1et+/Ei72IGHuwrmwVfa?=
 =?us-ascii?Q?Yo7f41tqtlUBrRIVuh12xv06NV9t9v8/v0S1xQ4m8wu7q1C28WV/miLKnCog?=
 =?us-ascii?Q?WIibkD4zkZkts0APHZjRa8c1TxtwlcP+eN74KotmuBoCwr8vswTaZMG/nBvO?=
 =?us-ascii?Q?I9GwG+f0UhEfJ4/NzK0n8Aiu0BZoCo9Sg6piAEMS4u7UAVCwsPXtbAc+bLHu?=
 =?us-ascii?Q?eqLxeZRSCz+QS6kjfos=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3457.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fda9157-4164-46ab-5907-08daea5f382c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 12:13:11.0944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8P/twzZqVuXU0o5+mskEFtX2saz1hlRxKmgWPvLpOr1weytgw6g2hAZfLsWjzGZA1uXcbqXhi8tbAVYEL9H1wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4546
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> The issue being "lspci doesn't show L1SS after suspend/resume"?
>=20
> Is the point of this basically to fix lspci output after suspend/resume? =
 Or is
> there something else this fixes?
>=20
> It sounds like ASPM and L1SS works correctly after suspend/resume even
> without this patch?
>=20
> Bjorn

Yes, that's my point.=20
This quirk is going to recover the display of L1SS in lspci output, but not=
 recover the L1SS contents and change its ASPM behavior.
If the commit title here make misunderstanding, I can change it per your su=
ggestion.

Besides, with power measurement by power meter, I didn't see significant po=
wer consumption and battery life difference w/wo this patch.=20
With suspend/resume stress testing, the system can pass the testing w/wo th=
is patch and the its child iwlwifi device work fine in both situation.=20
So I believe this quirk didn't change the ASPM behavior.

I have a generic implementation for this quirk.
It save the L1SS header and the link offset to L1SS at system booting, and =
restore them every time after resume.
It also check the L1SS header and its link, only recover them if they are m=
issing and do nothing in case system has BIOS fix.
Do you think it's practical ?

```
#ifdef CONFIG_PCIEASPM
static u16 pos_to_l1ss;
static u32 l1ss_header;
static void chromeos_save_pci_l1ss_capability(struct pci_dev *pdev)
{
	u32 header;
	int pos =3D PCI_CFG_SPACE_SIZE;

	while (pos) {
		pci_read_config_dword(pdev, pos, &header);
		if (PCI_EXT_CAP_NEXT(header) =3D=3D pdev->l1ss)
			pos_to_l1ss =3D pos;
		else if (PCI_EXT_CAP_ID(header) =3D=3D PCI_EXT_CAP_ID_L1SS)
			l1ss_header =3D header;

		pos =3D PCI_EXT_CAP_NEXT(header);
	}
}

static void chromeos_fixup_apl_pci_l1ss_capability(struct pci_dev *pdev)
{
	u32 header;

	if (!pos_to_l1ss || !l1ss_header)
		return;

	pci_info(pdev, "Fixup L1SS Capability\n");
	/* Fixup the header of L1SS Capability if missing */
	pci_read_config_dword(pdev, pdev->l1ss, &header);
	if (PCI_EXT_CAP_ID(header) !=3D PCI_EXT_CAP_ID_L1SS)
		pci_write_config_dword(pdev, pdev->l1ss, l1ss_header);

	/* Fixup the link to L1SS Capability if missing*/
	pci_read_config_dword(pdev, pos_to_l1ss, &header);
	if (PCI_EXT_CAP_NEXT(header) !=3D pdev->l1ss)
		pci_write_config_dword(pdev, pos_to_l1ss, pdev->l1ss << 20);
}
DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_pci_l1ss=
_capability);
DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl_pc=
i_l1ss_capability);
#endif
```
