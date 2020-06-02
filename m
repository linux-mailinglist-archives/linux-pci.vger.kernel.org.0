Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609511EB2D8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 03:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgFBBDC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 21:03:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:41786 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFBBDB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jun 2020 21:03:01 -0400
IronPort-SDR: mjvlVUtQG8YfkHVuJZslPUk4R03nG1GejbikrrYVOcGwkcM27boA6WUuVOAxpmSjfxZ/iW0G5b
 UHpTMwPCZTEw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 18:03:01 -0700
IronPort-SDR: nB/P7CIUedtXeUIRozIcKTjw82eyZ3Tckxcd4mt6M4I5J5sJA7eE9gILU4yaQFpjtzLELXAY91
 mLZ24+MvaJkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="303821374"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2020 18:03:01 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jun 2020 18:03:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jun 2020 18:03:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgRF916KFyRsWjrZ5rEcEND4SSXH2KOZRrHi5dJV308FFKPw2sFOp6pUdl2rNWvBQZmQWCfaIoAhfLi7novGQMpKsAw+0u0W94qlPaDG8CFrOiWtU38GqEB8ntG1j7fouRjch96dkYHMrvwL6SpOX9asePeOdx1H4T3rsabfl+grCYW7xyrsYyekorqbZCqZPZEX5nWd/QVk1zwgVPaiumYUjvGzmeH/E1LqWc50YqRAf76nZM+qofiBCLLjdiRBvnj24W+rRaqURyaBcfMl57tpKOQ6OAim/Fl6Vwzix7GJYrl9MCsQiAy/jt7hB6GE6Ekc43ZtD6z1TYPKI1+eeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a++Wakt12loSYki2jkbk0Xk2Sod/obKUGB/b7UEcfY4=;
 b=dFhs6W45JkXisPqE0gIOz3YuR6c7nzZK6AMAY8Be1DW0cmpXirmNlU+/n+VlEjXtp4Pzu3LwuKMhXJBgfNiq/qCwcrgFpcIZBIuw6BhvAgZMq05RARm0Gaedy4yLh3uXzlOrtjwJdBpAvt1uHkLKzwCbjvWMOvRxVrwNTUWLTav+to07XBI1tlrXZBGo0O5eyLQPfhULBiqtW73ZIllGmb2Ki/8sAs5O3IMLurq/p4uuoaVa3aKUKE91J8jkvg5xaxl7bnrxPQ8pxa8iz9N2g9xaUFukCZ9wncN2CAE8YfIazG0MnXcHMAcH/jan4t/mmmi/hC5uzMeIIrroCL4vRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a++Wakt12loSYki2jkbk0Xk2Sod/obKUGB/b7UEcfY4=;
 b=zezq8csqSBhLJZjA4nIX1Q2J/bQHmZbTmw8KB4OIQbdFxxr9Eg8tVsZAwkRwA6dALo+HJnXsWmERbGBU3lSdAhsUaLxpLG7ctLvB3kDGhzp/8tEMKZfr6b/YKnR726DX62t3heFmpnM0Kccqy5+egvhuz5yoN5iPGRtuumg9yH0=
Received: from BY5PR11MB3893.namprd11.prod.outlook.com (2603:10b6:a03:183::26)
 by BY5PR11MB4070.namprd11.prod.outlook.com (2603:10b6:a03:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 01:02:59 +0000
Received: from BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::65ec:b3c9:7f24:d067]) by BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::65ec:b3c9:7f24:d067%6]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 01:02:59 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>
Subject: RE: [PATCH 10/15] PCI: altera: Use pci_host_probe() to register host
Thread-Topic: [PATCH 10/15] PCI: altera: Use pci_host_probe() to register host
Thread-Index: AQHWMJOVynypNu7pUEW1r9ZQhIs4b6i+xnew
Date:   Tue, 2 Jun 2020 01:02:59 +0000
Message-ID: <BY5PR11MB3893C12C01D22AA440BB22D7CC8B0@BY5PR11MB3893.namprd11.prod.outlook.com>
References: <20200522234832.954484-1-robh@kernel.org>
 <20200522234832.954484-11-robh@kernel.org>
In-Reply-To: <20200522234832.954484-11-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98129c03-50ae-42e9-34f5-08d80690b1ad
x-ms-traffictypediagnostic: BY5PR11MB4070:
x-microsoft-antispam-prvs: <BY5PR11MB4070D5BB2E6649A235335B95CC8B0@BY5PR11MB4070.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qjer7vpklZ6tM6H19FgH93xW7F8fT+g7LCGKZqfs60Aa7pExHcxyL6t5bOCUkRs9/Zo05vCdHLWCRJ7hE0AVYvhpcNzoJQ5aEskMkt1s5Xifss/8zQjHlLo8hnAHrKNRn/FM4nBH+QR2prlYjXRu6Ng3aEbPi5b+2EZk/JK2axe88/SOxe3+wGRdrXr6jbZOmB8v3/4vHSGaiVN0YEKfN+Ii3XhJlmPFvPFK0RtBVczF0aFQ3++qQISWigMKROd+QGE8EEMIy8Sv+12c0xUOJxwFTR3CcDhYTGPGsByRYYvea2W3HUO4DlJw3wEa9doF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(376002)(366004)(136003)(346002)(71200400001)(8676002)(4326008)(2906002)(7696005)(26005)(6506007)(53546011)(4744005)(5660300002)(186003)(33656002)(76116006)(55016002)(478600001)(64756008)(66476007)(66946007)(66556008)(66446008)(9686003)(86362001)(54906003)(83380400001)(8936002)(110136005)(52536014)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cm9GdbBoeW6lujvRQrTkdqBsnsSmEWkK9FjSQ2Gv0FmQJM51G6fT8krbc6rWo3vIxRSdZZWo2O3Ph5mhcnE7KHeFJ4fvyVMdkGkt05EQlzIBN7Ri0sL4s6Uzmx05iYbC1iiQelOpyQI2t2kRKt87BJgQ+2pcpv358t4Rczba4j+1ETrjG/FzC/mjVu/6u3HFQ6qvbvOIZW9oPz1GuS3b5VT4qYTLzV2O072tDnzxWjZ0J8gvalc1NigLniwBcj9tZbIfCjdLGV3c2eDAWoradMNzaiYFVgs1YPGeCfFw9WgUBI0dIZOkRqS0FUNCLgKZ+zaaXjw0cbskEU7k1mkq23Yhz9N17SgMPmIOg9YZblKdi7YOUZ/I4rmOHon14/S1GU62imztjLgsJUwKrWnSebUk5WxjM83SQfZIPq/v3kXRCun2Gvy5EZW3SEjqZeaiDP6ZlN8+EBJg0KZEorcAFSp2da4T1eIS4yx2DJi46iZ+3NgzCgAlUVnhl/+YuL3U
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 98129c03-50ae-42e9-34f5-08d80690b1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 01:02:59.6582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWxZrDMNLMEWAnVHxs4qbRNbk/eKFj0126XXowM0VFGThrXfPFAgJPouEujjfqV9br1eXKBOpfMd9rNi/gaoFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4070
X-OriginatorOrg: intel.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Saturday, May 23, 2020 7:48 AM
> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; Tan, Ley Foon
> <ley.foon.tan@intel.com>; rfi@lists.rocketboards.org
> Subject: [PATCH 10/15] PCI: altera: Use pci_host_probe() to register host
>=20
> The altera host driver does the same host registration and bus scanning c=
alls
> as pci_host_probe, so let's use it instead.
>=20
> The only difference is pci_assign_unassigned_bus_resources() was called
> instead of pci_bus_size_bridges() and pci_bus_assign_resources(). This
> should be the same.
>=20
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: rfi@lists.rocketboards.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/pcie-altera.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
>=20
Reviewed-by: Ley Foon Tan <ley.foon.tan@intel.com>

Regards
Ley Foon
