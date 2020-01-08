Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4AA133F0D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 11:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgAHKQO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 05:16:14 -0500
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:25547
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbgAHKQO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 05:16:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLix1F+d+gEfOe2CgYoHhvuhhRxjqsyBqukP5YaMBoOC6w49gMQtiwAdgqS25mPimv2qeh88h7oOI/rZDY/CTZaNdYlyjv3WphcfYjy0TzX5taYAG5uL6fNF1bkINs97lXY7D3jVUBhrWcyAoa1YFIzot6sCCu2KOKv/FO76yt/oGcN81opcBidkgVHzXGMNu4ahZS9sVf/fgQQYw9pTNgD5c3Yad/Sej8WTr7fY4m5WYagW9aIpaN8Br55td67xaajCzEAnSovCQ2C7pC4gnXYMGDIHRsdwro479dJneHKDKpGQa++iYDtPxgIg6fQebHwPe7jiYaXcmg24KFxo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uW2ME2SQBf8qtWhxTuX5PJPTZjynWieGeugQDlrP7c=;
 b=XLUoJOX9cfKgHIRjiFmbe9OfskqnolRBuEEzO5E66IPWY5uPpbDT81/Hd+HgAUdA5WQp2HcioqME3/x+jO4VKgHJd1AxLhCdkFBhBAa+RfhFo8gz0o8ggQSJMhCHg4Dfb8hqmVnYU04l9SqOgT114HAIfFyfAsUFJRwFpM10Kosac+M+8OQ8G1nkT5S0Aoy80LfRLMPPJ94tOrD1G5RXeXwK0lFZ3TSF5XqyEcmMdexXGWjQ8lLDnKRgoPqdO/Qd1x8utKmKMQ2CEOXhbfNoxx6ACM5F/u2LH+iTEdUXVuiBZhAHPfFX1trpwpIpuXaMo9nJn/xlUi7YRr8KmPe0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uW2ME2SQBf8qtWhxTuX5PJPTZjynWieGeugQDlrP7c=;
 b=Rcy/Ctux4WONWt377CB5mjewg57/DhX+JetQJ/k/wyBPQuARjntU7fukhtRNtaII04pW4KJ1+41Z6DllXNsccNszjcz+3C+hb3BSBn9wzn6JMG0wNsOZtiTHUiGvarq+vAFg/T5zhb/vBhz26S7HZ0TobosWkoTsrwGbT+ShLgI=
Received: from MN2PR02MB6336.namprd02.prod.outlook.com (52.132.172.222) by
 MN2PR02MB7006.namprd02.prod.outlook.com (20.180.24.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 10:16:10 +0000
Received: from MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::f19a:a426:d2db:49ba]) by MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::f19a:a426:d2db:49ba%3]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 10:16:10 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH 2/2] PCI: Versal CPM: Add support for Versal CPM Root Port
 driver
Thread-Topic: [PATCH 2/2] PCI: Versal CPM: Add support for Versal CPM Root
 Port driver
Thread-Index: AQHVtypsQVCQA4Pdl0W2IKkLYMD11Kfcg4CAgAQnXkA=
Date:   Wed, 8 Jan 2020 10:16:10 +0000
Message-ID: <MN2PR02MB6336B69A0FE162C1D6D6370CA53E0@MN2PR02MB6336.namprd02.prod.outlook.com>
References: <1576842072-32027-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200105184953.GF3889@kadam>
In-Reply-To: <20200105184953.GF3889@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4384836-8f08-4bc4-ca4b-08d79423c893
x-ms-traffictypediagnostic: MN2PR02MB7006:|MN2PR02MB7006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB7006EBF4065C5645E068D1B7A53E0@MN2PR02MB7006.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(189003)(199004)(13464003)(8936002)(9686003)(107886003)(8676002)(316002)(2906002)(4001150100001)(81156014)(81166006)(54906003)(110136005)(966005)(4326008)(33656002)(55016002)(478600001)(186003)(71200400001)(66476007)(66946007)(66556008)(26005)(64756008)(66446008)(76116006)(5660300002)(52536014)(86362001)(7696005)(6506007)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB7006;H:MN2PR02MB6336.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 89pdBqayg+HAeeppJXwqfQxFCvY3gcT1v2fqPIca2Z6wAJK8I30SWgHNr5J2udD3MVfUbi6c3sd0tozp18D0/KQpb3DQ3+O9BEZ5tXWiZrqcS+ewTxiCpeZpOzeZ+89NBMZYyu/dVblFo6Uz7W7eJK7phuOHqMVh94EeCoQEz4dIxQhrL1XLTXx1UHR3PsK9DvQipK3FUb1EELQcxh7T6ozZITxkK2+a6D0D+DJ317OIJhcn5BaSWDt3vC8nPhUgCYnZva//ryV3gYfvNmmKK3h87yXRZXi9Q5AvNvCpnGsscevaxCPGua/Z5h6PtdEPz9R+st4DtUxUOmUIlpu/AJpRyF/2Fh4dn+awOwey3f/iUohp6zk97cXAYA1YxQA9EJGWVF2RJTLnUt8lY+sqXA456c/gfBV6T+LxrbzJclZUH+s2OKLt30QIkfS8QliQblFTSUhVU6dWREXmFjSkE5B5LEOxnYr3ZbOBxsCiQrYSUYtfmNVph/kJcJW3mMlHs0vaZox61z5O2oUjCDBiBw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4384836-8f08-4bc4-ca4b-08d79423c893
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 10:16:10.4630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxZJsb6luDW57b9FT4CQafyWf3IuxNNgRQ/K5Aha1cRs4gOq3MgJ9nI4bMjIgmDhaMC2MjcdTPDclsGbktx/Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7006
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Dan, will fix it and resend.

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Monday, January 6, 2020 12:20 AM
> To: kbuild@lists.01.org; Bharat Kumar Gogada <bharatku@xilinx.com>
> Cc: kbuild-all@lists.01.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; bhelgaas@google.com; Ravikiran Gummaluri
> <rgummal@xilinx.com>; Bharat Kumar Gogada <bharatku@xilinx.com>
> Subject: Re: [PATCH 2/2] PCI: Versal CPM: Add support for Versal CPM Root=
 Port
> driver
>=20
> Hi Bharat,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> url:    https://github.com/0day-ci/linux/commits/Bharat-Kumar-Gogada/Addi=
ng-
> support-for-versal-CPM-as-Root-Port-driver/20191223-193219
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git n=
ext
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> New smatch warnings:
> drivers/pci/controller/pcie-xilinx-cpm.c:330 xilinx_cpm_pcie_init_irq_dom=
ain()
> warn: passing zero to 'PTR_ERR'
>=20
> Old smatch warnings:
> drivers/pci/controller/pcie-xilinx-cpm.c:338 xilinx_cpm_pcie_init_irq_dom=
ain()
> warn: passing zero to 'PTR_ERR'
>=20
> # https://github.com/0day-
> ci/linux/commit/f107713acb796e598f16a23b33af74fa382921b2
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout f107713acb796e598f16a23b33af74fa382921b2
> vim +/PTR_ERR +330 drivers/pci/controller/pcie-xilinx-cpm.c
>=20
> f107713acb796e Bharat Kumar Gogada 2019-12-20  320  static int
> xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie_port *port)
> f107713acb796e Bharat Kumar Gogada 2019-12-20  321  {
> f107713acb796e Bharat Kumar Gogada 2019-12-20  322  	struct device *dev =
=3D
> port->dev;
> f107713acb796e Bharat Kumar Gogada 2019-12-20  323  	struct device_node
> *node =3D dev->of_node;
> f107713acb796e Bharat Kumar Gogada 2019-12-20  324  	struct device_node
> *pcie_intc_node;
> f107713acb796e Bharat Kumar Gogada 2019-12-20  325
> f107713acb796e Bharat Kumar Gogada 2019-12-20  326  	/* Setup INTx */
> f107713acb796e Bharat Kumar Gogada 2019-12-20  327  	pcie_intc_node =3D
> of_get_next_child(node, NULL);
> f107713acb796e Bharat Kumar Gogada 2019-12-20  328  	if (!pcie_intc_node)=
 {
>                                                             ^^^^^^^^^^^^^=
^^
>=20
> f107713acb796e Bharat Kumar Gogada 2019-12-20  329  		dev_err(dev,
> "No PCIe Intc node found\n");
> f107713acb796e Bharat Kumar Gogada 2019-12-20 @330  		return
> PTR_ERR(pcie_intc_node);
>                                                                 ^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^
> (This means success).
>=20
> f107713acb796e Bharat Kumar Gogada 2019-12-20  331  	}
> f107713acb796e Bharat Kumar Gogada 2019-12-20  332
> f107713acb796e Bharat Kumar Gogada 2019-12-20  333  	port->leg_domain =3D
> irq_domain_add_linear(pcie_intc_node, INTX_NUM,
> f107713acb796e Bharat Kumar Gogada 2019-12-20  334
> 			 &intx_domain_ops,
> f107713acb796e Bharat Kumar Gogada 2019-12-20  335
> 			 port);
> f107713acb796e Bharat Kumar Gogada 2019-12-20  336  	if (!port->leg_domai=
n)
> {
> f107713acb796e Bharat Kumar Gogada 2019-12-20  337  		dev_err(dev,
> "Failed to get a INTx IRQ domain\n");
> f107713acb796e Bharat Kumar Gogada 2019-12-20  338  		return
> PTR_ERR(port->leg_domain);
> f107713acb796e Bharat Kumar Gogada 2019-12-20  339  	}
> f107713acb796e Bharat Kumar Gogada 2019-12-20  340
> f107713acb796e Bharat Kumar Gogada 2019-12-20  341  	return 0;
> f107713acb796e Bharat Kumar Gogada 2019-12-20  342  }
>=20
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology C=
enter
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corpor=
ation
