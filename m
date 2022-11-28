Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0EE639F73
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 03:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiK1CeF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 21:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiK1CeE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 21:34:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6903510FEC;
        Sun, 27 Nov 2022 18:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669602843; x=1701138843;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VDUsk9a9gXH4bdwC6xo5D0YMPdaj6+Z725HaVXH8Jdc=;
  b=SAc6HA0yB3n6YyJa4MFUPOjT6ijcK8/lyt5eTY9lQCXT5OyE8G+cGrB0
   ApEdgsugL2f5mcsgs71zIJ3dJM9mYCsm19aT975sXEKE/fxhZxchVGEhj
   7AF9vQ626RxhIPCTdV75VnZER9tT/Ycc2ZooP6WbkaN73Ut/bg1yd0pAw
   nf9F7VXKVUPa2OXxuFV08B1+LKNACV0DYEvD+AR3a46ntaWEyHHB5O5vq
   K69bsDGQBAYcQZVh6EsDGrYsTtplTDVntXROhw4aGSA+II2WjFtGudhdb
   qyeh8rcKvJIsN9/ryvTTEepBHI+2Hx129P4bqIbpjQwx3XTteKWoC0VEu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="314767400"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="314767400"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 18:34:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="731968652"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="731968652"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Nov 2022 18:34:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 18:34:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 27 Nov 2022 18:34:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 27 Nov 2022 18:33:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XykfVms7Xa+hxzZ+B1bwe7wROy1oz8ALZ5QuJnsV5aMPopZHZy845yhnqnxN8R71H2corpozo0vnRlk7JSZIY9QLZoX7/n01WUg1sNDRWOilmImMYuFJgjO6yNev6QlcstYfCU0kcJQFQuoLBwuOtStRKsENxWXLZc8KeTAuWFlKbZuXGTdEcG4gN1uqfH/rfspOFOUcw9WWT5pyZ9qIXwuMGbwhl1StsnXbfblqJ879aGEiBTL0pT7qA2FC8xa57LaH6f8JZLm8UqNp73KaZe/tOUcKElpOLO2lscLxnauN6he5XK4fidMjs62qTF++6recgD6LrYWWEKc8sF6wgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YFh9xp/ufLCbMs0Ct7w/FGr16IhlAG4lKhTMLsagiw=;
 b=NsZ/H72jz/SfV3bvS2iqPRD+dkfX4Ju/TPcQfOOsqDoz+D/FCe/SeBKbxsjprnASbFYqAL8AEtVzkkO8yTOI7nKVFgAJm5wN5TQtQJG4KG6XRu3DS9EeQJUu6p8331quQKGc4uE57CAd3IA1pxyXrdx9wbiTAYL9h3NASYebLCY3NW+5EJycKSjzwd7v/LZTT39dDYXwCyR44V68h9KqTxwMrkGYPHZPtRPKbdXIRDgkofKWjs1j21TkhHG2MbhL6Y1ha+DmW0GzQVRQ3TZHB986YbZEjJdZrg/B3tFBSEv55prnMuzKEZ/yoHm6DEpfQUQir+8L6+1bBgyc2jdodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 02:33:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 02:33:57 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: RE: [patch V3 00/22] genirq, PCI/MSI: Support for per device MSI and
 PCI/IMS - Part 2 API rework
Thread-Topic: [patch V3 00/22] genirq, PCI/MSI: Support for per device MSI and
 PCI/IMS - Part 2 API rework
Thread-Index: AQHZAFvm330rC7indkKxPAycpb95SK5TobhQ
Date:   Mon, 28 Nov 2022 02:33:56 +0000
Message-ID: <BN9PR11MB527638D9C74A83FE1D0212D78C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221124225331.464480443@linutronix.de>
In-Reply-To: <20221124225331.464480443@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5530:EE_
x-ms-office365-filtering-correlation-id: aacaf593-bdfb-49bf-35c8-08dad0e8ffe8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u2cUwacE7Gr2D04WZ2Yy7ARe0NCmmltnnypX9sWrraCAUZ+A+dSK6BdztH4NQNeEYekOJ3KSa8S54PvAlvexfxcsvD/1BTArkOVQfQwNlCYLnq+49PbivZjbAJUetw0Qzq2qP5RBH94sN/4Z9xxt2gjZCH+yIVJGTdaggr5OPpYeNR497YgZxvUiz3isbPDrdjvA87czyIZ8Yyh7qin4hS+3eetn9Hea+2Ygp+RIR2zW3GxDVe3OOWcCpIJVgCwTvBB/G4Roe+afHAee4yC9i9EpA1RClKe6d47EuxhfcIpSy/kbWQkT3lZBjNSVtEuYUNM9SOOYBLqVyc/PEl/KqyaNQH8yvWNXfOYGbdQosOolkIHmpNA++GTVglyFtI7ZV/mOXiV9/gDZMsq5sA9Fq33C0jvSzqgLsOPhDEcZ2we5DuBj6ogHpUQYCC1XLAj4vJ0rt0JOLoIRMnY4W5Mnv87pUg37TTZt+w4YkVm6c3kaz69hURmenvVWdXYPCpD+DZtrttfNSJi59Cc2bjBFxd4n4sJFQ3jhId9Vt2r8VFG/ymzZZHJ6iFN5CQSmjF7tWaLKkUYc87CKaYk4xB7B9Bu3SR/IjCKZzhl8bClWyTa+sk1bcrpAOHlPoC2O9yaUZPwY7rlilrpE0MeeyYPOXEcXQjjHkmxEr9jbvezwf7JzDf2D/aDJcA3IuEH7DLL7aNshUhV0e/t3X+UsEIP5Rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(478600001)(316002)(66946007)(2906002)(76116006)(33656002)(110136005)(54906003)(71200400001)(122000001)(55016003)(82960400001)(38100700002)(26005)(7696005)(6506007)(86362001)(9686003)(38070700005)(186003)(4744005)(5660300002)(7416002)(52536014)(41300700001)(8936002)(66556008)(66476007)(66446008)(64756008)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sGCLORDKQ3BJXvFRci9SjpJJF22T/cc9ou8NEGR7C+1lC9Uh8HzdftXYJTDf?=
 =?us-ascii?Q?LodD1NEIer3yPjYQqDACupnSoI6HDd0sz7g9HqLLljvk03IG9htvH8rv7M2a?=
 =?us-ascii?Q?bTLm8LLKf/3/SKmRVe8bWs+2pNBcb0jWtztTgMw8KSaAp52aLpEGJgpbH6iZ?=
 =?us-ascii?Q?0fHnK2UGKCIoeUvR9/Fo7y0Gnc8g/ndUE9fygxTD+AVJyKHrdh0Oh3ZzgM7v?=
 =?us-ascii?Q?DUUX0zo07kNBLD7a4avVmdQxmJrsoVHOQiKeV4Dr2GSm3ijZ27CugBOY+3Rl?=
 =?us-ascii?Q?6qwUJXsMlaPnqlLu/+voT7E5nYILksV7VXHSrwv3TqNv8oYMvhk9rwGYpJ5b?=
 =?us-ascii?Q?JQ3Okw5tffnaZRTOhC47UoDN3wVtyOGmj1ih5t0C9MS2ZezrnNxBGTLIKcCR?=
 =?us-ascii?Q?YuhTx5x5tnmf9whmrYo73tLXExc0zvSk0FlND5n2RCzDOqki6pxBcQlYsSJX?=
 =?us-ascii?Q?P/m/08AhFhAXuy3jVKVnFXSa/hyxIkcKSRywRUOrl+aDl2reSak8QgNgEBPh?=
 =?us-ascii?Q?/91LSfsT0D92LrgF3gsoh86stw74HjKYv/M0S7tpT37LZ1GozbaIMkc8MQ0d?=
 =?us-ascii?Q?F6kImh/ZPHBEYn9qIPaQ0FkH/SgNUx6e0r1JfonogMwF/CnSx+WWp8ECA3kD?=
 =?us-ascii?Q?dN6Qm04VVhWXA6Oh6CMHrIbU2hRyC1Wc2OU3b6ACS0DXNNpCGF+GmKVw8t+b?=
 =?us-ascii?Q?S4le7o6NkM23H/BCI6DLM+9OOiiYtrr9w9PDs9+ygYojKZuDeRmnObPD/Vsq?=
 =?us-ascii?Q?KoZoiODXqRb4lfXKQyLsMdkPjdQUMSs8uU0NISrSK0AL7u8i6B8JDqzvUwmQ?=
 =?us-ascii?Q?G43YPvsL2R5BXoVWt2KySOGiitNKJiTnrF5aoUYLc4sz0IgeqC9oag/7JNXJ?=
 =?us-ascii?Q?zlzhzfxIrUFSdpg9KVMmx8opiGbJtfZlWGgGxdnavny5oykoCC9q9UA86IVk?=
 =?us-ascii?Q?7PSaVns4dqYEKb1DbOG46R+dJK2Zmg/RxFLp+XP9U7IOeHRbwyvJXAmC1tZo?=
 =?us-ascii?Q?dF5s3BD5P7RC7vIPoZrtGQCmruTj90SPEAZVA9tkwbdtoN19V8K6jB7JnXkE?=
 =?us-ascii?Q?G5gRtBMo6X6i+qGzuKo8M9GP8lE/j8wbj/H9a4l/rsJQpirfSZ9ZAUTyRygv?=
 =?us-ascii?Q?KwGCHD6PHYyEy3FehZAlaUa2w83Lp8OVBTe2ZF+pxBj8fo82WfTJw/MWFz0U?=
 =?us-ascii?Q?yZjQywwmGREkaR7o5PJbvbJf2F1Mu1ichFp8xpVODs6Y0idtYevJXRJurxDM?=
 =?us-ascii?Q?1+GKHdUb95aMBz3S2Eo0D2fu2kmUgZSx/8DDqqxDvSN1mg/dtJvfpZSa7bqn?=
 =?us-ascii?Q?KeEzV/GfI8LLONOyimTzDuQbkdH963zkVOUPaanAmMlC7CAgqH97ukb4EMvV?=
 =?us-ascii?Q?n05mhWbl371SvFPRWVEgBgF/hZl/l7TVNsAupmlgdRwqK1CbyBLCKglDY7lF?=
 =?us-ascii?Q?gg25gmsluLsQY199v5J73Xbunfgm5qulhF5Y5KRHmLK/yPGcHY+55//Zm4Oj?=
 =?us-ascii?Q?PZ1ZGXHTehiTWiYwMUiIWSIxFeQgKg8ZHnBQ0L2sLmfUUiam/hO9AnBTaz/R?=
 =?us-ascii?Q?W8Mx4wEi0BMsjeUOm5ju0DLKBaXZwxRVwAfWIsrt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacaf593-bdfb-49bf-35c8-08dad0e8ffe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 02:33:57.0120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCr/E/a+cfEhk/F8mKxpDM9Uzm5JAAnSqSeQExGxwuWFsx+q1meyked6+iHDVl3Q5Z3bQAxm/AlHdD/u25DIBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5530
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Friday, November 25, 2022 7:24 AM
>=20
> Changes vs. V2:
>=20
>   - Rework the xarray storage into per domain storage (Marc)
>=20
> @Kevin: I did not pick up your Reviewed-by tag due to these changes.
>=20

The incremental change looks good to me:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Just one nit.

>=20
> -	xa_for_each_range(xa, idx, desc, ctrl->first + base, ctrl->last + base)=
 {
> +	xa =3D &dev->msi.data->__domains[ctrl->domid].store;

Better to have a macro here given multiple references on the store
in following lines.


