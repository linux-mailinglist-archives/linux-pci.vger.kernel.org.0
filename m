Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A182315E3A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 05:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBJEeZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 23:34:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:41560 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhBJEeY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Feb 2021 23:34:24 -0500
IronPort-SDR: 4jbqIJd47mV347C5yniagTVO9AE3nQl8hDFdu39dOGfNdPZeQoIqqLL99EgSrK2B1zei9xzUJ8
 0cljFi/A2w7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="182076797"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="182076797"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 20:33:35 -0800
IronPort-SDR: fHQvCnhlOtpRt/EKP5B3+VPI2dGSObwzKuNs0Lq9H3QS1KyzWTsijlzy8VHsMgSshoDPp1Ls93
 aUUTFNv06Ifw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="436534725"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 09 Feb 2021 20:33:34 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 20:33:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 20:33:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 9 Feb 2021 20:33:34 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 9 Feb 2021 20:33:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJghI8/jLJOML886yEBB0TkSe2yXxlfoq8VnqdasnY6syHlEZq8XK0tG0o8b7Cy/QaOb7GVQtjwkn1EbsV4K8iNZbb/ySXP6kep4GqiHBmLe4h7/HMhJXK/lLsBLHRyPyZP8E1Fe+7y1unrCKRpKh3VkasKQyqGQErJGJX0CrLw+7TjndArJ0EN9m7sLsF1UjZMC3IvSSrRwGplO/EojmCLu/HqqerLhW1K+67xkSalIFzEQ/Fol1wKkGrd0I5q5i9TklZUOU94m3rlLwwDmSboK7pRycbYhvJgEsVAzoyCrqdnHXptNrQ9gV9g3x/dbU+leTRp1L13KS5uq+Nxw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pOdBLKUYHkNv0iCQ/6CcPU1GOcQ3T+W70fg3H2KRH8=;
 b=GIt/jtXpocWPEosInxdgk6p8vFw2BIncPzj/0UJmxko3NOnrt3nTi01EBy3jUwgKdR+Mplwgvt2xpnhV1M6s7/G+fBL0vJpZw4718XpFNe1RG2qGOXfX/5vfD9v7sEUj8uNrGWkyNLm0M3znoRdrHZcwS5NVXAPiW+X74FwxL4DmLApOgyGzTvJKVUgD0QZJksMp7VdDvX31DeV+ByZt0BLgAzB1DppYkHn6MG7D0Ya05N/OeZbP1li1ZkILCbGX/TQTFESbLofcROscV6DNLJdzxi0Y6A7wRnQzWLnUjghuVKZQdqaBKnDnHJojGmWwpL2T6iVuwOxaNo4wUHO+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pOdBLKUYHkNv0iCQ/6CcPU1GOcQ3T+W70fg3H2KRH8=;
 b=TMpDUaxr5scFmckTCbioyBsfdHSWesxvIBlqQtELYFj0/7PF5ll8JXH1G11YFvesuH4nRk2gPYIrocCX5FhRXXoTLqJVhvI0YSh+FiOmLelER++Zw9P57TcleYsYlv3pe09AU1cc6PuUNp3D/Vc+64VLu6Nxg9mRuWEDrIz8cXo=
Received: from CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19)
 by CO1PR11MB5123.namprd11.prod.outlook.com (2603:10b6:303:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 04:33:29 +0000
Received: from CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::ddb6:ec7f:2548:efdc]) by CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::ddb6:ec7f:2548:efdc%4]) with mapi id 15.20.3846.026; Wed, 10 Feb 2021
 04:33:29 +0000
From:   "Kelley, Sean V" <sean.v.kelley@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Jin, Wen" <wen.jin@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Linux List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI/RCEC: Fix failure to inject errors to some RCiEP
 devices
Thread-Topic: [PATCH 1/1] PCI/RCEC: Fix failure to inject errors to some RCiEP
 devices
Thread-Index: AQHW/1Fz49ox/DonIU+F7sGLouNbVqpQzR2A
Date:   Wed, 10 Feb 2021 04:33:28 +0000
Message-ID: <131C9BC0-87C6-48EF-A07F-1B4537BD2671@intel.com>
References: <20210210020516.95292-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20210210020516.95292-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a55b57c3-b594-46cd-d44e-08d8cd7d03d0
x-ms-traffictypediagnostic: CO1PR11MB5123:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB51230BA7F3EB994AE7541A1BB28D9@CO1PR11MB5123.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8q1/WXFYjKNSzksFTp0WWMn0g/U9Dl4o9mUlnHlZkS7Cl8VkJU74DVKXuXapuHk9EJ5QSZ6Tnx24yRZNHBi30qF/O6vRan8vkdhisfuJI26Njddj5L4XPQijW33+hRqbHcg60lARjsgidCiVMX/LTbs1daozOq7PKuUUAdl81gFh6AW1/ePqR2Vl2VZ5uPZ0zUbBEgoMpXTXR+j1GLo7kWIbKf8tS6lSAg3ZBa6lUf4IC+W6RKrhjqEUKau845vndNglcyKkAjM6CtIOmqQFU86SCcypOO8963QgZb5z+mvwqeddWMugOlrZrYCnn5xfu+W3LHajmOkbGYBBi6t5lbGI9/MlzEVTT/Gz1An9SnHmVjMzGFkN1CAwyHHRzHYRMnye2GuG3MqGBGzo1lX9NEXDpVW/BV5U9gw2G8NVPRk/ixxJMPvc0AMcyFMTR2kuvRwyB/l+jML1LpSqB8U+wVTo1LCpbOgiC7RpSjwqRfhDg+yfy/VprxYVnl9Su9rdAMrMB+mRnpWG9M0WrG0LRQXfm/H+j9EUY5n86J24OQLrWz1A7862fHth+ErDWsOYdpnA6ao8SYlm7+ayrdNseg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4929.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39860400002)(396003)(346002)(33656002)(83380400001)(4326008)(6636002)(8676002)(6862004)(36756003)(2906002)(478600001)(54906003)(71200400001)(6512007)(316002)(6506007)(76116006)(37006003)(66946007)(2616005)(26005)(53546011)(186003)(64756008)(8936002)(5660300002)(66556008)(6486002)(66446008)(86362001)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GoH8VNrpV0hJQMr6ptECEKOr6fOVm22OjgTU6yZzuBehxIobThowgp+qLk9Y?=
 =?us-ascii?Q?fuiukp9V99pE0NWEmGaSrFu0uwOs7fKMsmZmowhW/Ncofx6M3LD5CZDgjLKi?=
 =?us-ascii?Q?macd0DdSLKe/bqm1D4XZp52Jc6O0fDfl00M7W0CnOA+5ao0EuG5lgpPAER8X?=
 =?us-ascii?Q?lKLZZXN/G2CrR9A778PhYWK5M42PuEOQlV5BWjDzBMEDviA6CHxd9dQgJche?=
 =?us-ascii?Q?uQ9DKT7fd46OV4fkyiCNj96xz+LcM2RKy+zQcAbtrXwD5mIIiMu0KDPH3pyv?=
 =?us-ascii?Q?IM3ZeUuajkNA9FkfB0H6svE7nn8LOR5nGViCXIRy9121OwJb0FnhsZ+MGGxn?=
 =?us-ascii?Q?FwFbCW2SxbA4CYHjYSarDVC5Pn7J0MP+ez29VtWhhjoTBZ0VGoSk6sj3hL7Z?=
 =?us-ascii?Q?yL2OHViurf2VUiWCb91NfFJEZjIEXNLsf7Ms6HID1gPQndXwR/wQckss7YAh?=
 =?us-ascii?Q?X2I+lI4CCrTVihJgoGH/2BM/Ayh1HzWy2YkfWsnkZ0/DzFv31T4HEqZ9IlfX?=
 =?us-ascii?Q?mS9BBlcFbGtpDf6IX5ycEMjSubtMTit6gyuFPPU4RdeKeGCM9HgB4JZo4UN+?=
 =?us-ascii?Q?U8QX6BrZKF6DzrvJ/GOlFdPLrIgwgMjYnXDqsZko34ikreYq7ABRTct7t9WE?=
 =?us-ascii?Q?SwNlEn95SlDg8Cw0bd3jYOVnxneMjokPx9ydx+6pimDmLa41/pIHZ4BN0liG?=
 =?us-ascii?Q?OwIyrIXpfVXXF1LB/KOlFTlJUlFhuUfj2oWmRj3QPt95XwFhVo746pVgJcfB?=
 =?us-ascii?Q?UF/kAxaOyiZHsBgRT0IwLUIeWp2c2ZI70ROgflUlcoPMFMU99Fi1dgWl/RTv?=
 =?us-ascii?Q?bSUwN0cbP+2oPs6Cy6win/2XHNrnNr9t+E7rRgRrkVps3de5/FmV+I7AGpi+?=
 =?us-ascii?Q?XgjAFcCxaOmk50cXsX2ls4Xoc4Myg+DNwzsEVDDkO/v/JrX7STvUQQCFMANK?=
 =?us-ascii?Q?kwarR9+cUgQulWaES21ifuEMSts9Syg9wI6b4ywYk/5PX3GU4w0A//zLMyU+?=
 =?us-ascii?Q?t5yRngTHOUUk4AH7PpCSUS3gCDMHCdB0MdSaEeTSMjGn4FlAcgX1w+lrwfpB?=
 =?us-ascii?Q?AWUYUnNv+ypLftwpBkfFHpzwDhFzW6efCQV8Rcdqrn2XFFdse2+abNgC3XWo?=
 =?us-ascii?Q?UzS47n1YcTNGnM4zj0k1CthbmlY6BYobX8YORCNXDvw3J9Q3gzwcq0i4Iu6/?=
 =?us-ascii?Q?BXGyQIl+q/On1pDIupT9BSkYM3+Ht7N480KzmOEj6a970wfzHHPx4UMnMkm8?=
 =?us-ascii?Q?LTmUsaRcdPid+P7L9xK6vSikOzDBdw335OCcB0tJzIZPgKL81UqOcyzcmE9Z?=
 =?us-ascii?Q?oG0b+n+x9TW/6fXvVw1YJhJM?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BD697AE6BC7BB4186256437569B0F60@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4929.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55b57c3-b594-46cd-d44e-08d8cd7d03d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 04:33:29.0234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DzrMOOxUqARinU0zCgEcXdsx97EZ4kb3N4GmHKCsAffGZ/nbQIl3BZaY55xts30Cxsih4KFAwvJbHo1DMr5dPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5123
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Feb 9, 2021, at 6:05 PM, Qiuxu Zhuo <qiuxu.zhuo@intel.com> wrote:
>=20
> On a Sapphire Rapids server, it failed to inject correctable errors
> to the RCiEP device e8:02.0 which was associated with the RCEC device
> e8:00.4. See the following error log before applying the patch:
>=20
> aer-inject -s e8:02.0 examples/correctable
> Error: Failed to write, No such device
>=20
> This was because rcec_assoc_rciep() mistakenly used "rciep->devfn" as
> device number to check whether the corresponding bit was set in
> the RCiEPBitmap of the RCEC. So that the RCiEP device e8:02.0 wasn't
> linked to the RCEC and resulted in the above error.
>=20
> Fix it by using PCI_SLOT() to convert rciep->devfn to device number.
> Ensure that the RCiEP devices associated with the RCEC are linked to
> the RCEC as the RCEC is enumerated. After applying the patch, correctable
> errors can be injected to the RCiEP successfully.
>=20
> Reported-and-tested-by: Wen Jin <wen.jin@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Reviewed-by: Sean V Kelley <sean.v.kelley@intel.com>

Thanks,

Sean

> ---
> drivers/pci/pcie/rcec.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> index 2c5c552994e4..d0bcd141ac9c 100644
> --- a/drivers/pci/pcie/rcec.c
> +++ b/drivers/pci/pcie/rcec.c
> @@ -32,7 +32,7 @@ static bool rcec_assoc_rciep(struct pci_dev *rcec, stru=
ct pci_dev *rciep)
>=20
> 	/* Same bus, so check bitmap */
> 	for_each_set_bit(devn, &bitmap, 32)
> -		if (devn =3D=3D rciep->devfn)
> +		if (devn =3D=3D PCI_SLOT(rciep->devfn))
> 			return true;
>=20
> 	return false;
> --=20
> 2.17.1
>=20

