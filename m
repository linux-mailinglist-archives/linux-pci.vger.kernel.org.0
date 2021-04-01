Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A9B350C7A
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 04:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhDACQE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 22:16:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53750 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhDACPq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Mar 2021 22:15:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1312F3St185828;
        Thu, 1 Apr 2021 02:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=i/lvLQo66gXSxmK7Uo4U04UT6Anz7u/lwnhUfPLCb5o=;
 b=vl1r4+f02pgRGb8+pKSqF1mUGslaOD2TpB4oeCUJrieKpphDvo4yjCkTSgNUTsVCLsKq
 xpOibz5aV3iIUekfx/Ns8X56y/Ld6l29LLweIIVM2OMfSMsZ5MtjhVPE1SAZQSfabqZM
 SJdG/GtSsSs0TakFnjaCRR5AVXeGamEnovrfbQM5St1HCR/W2P5Uxs/REtvF+shnfZDt
 yFr0F/suyhWEcaQFZr7l+cLxu6gr+m9wn1/+P4AUZhTExZt7xYU3Tc32mkfuazg4aXmh
 G67Tm73+Zfluxqij6yeZ1Cw+gxt2B6MjfjHIiduTsWl5O99JdFFtSl00W4SFdKoKmCMu Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37n2a0087x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 02:15:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1312Ef5k110747;
        Thu, 1 Apr 2021 02:15:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3020.oracle.com with ESMTP id 37n2p9v5gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 02:15:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huF6uEcSLhdxc492/hfpD2XF0uLYfm6TClcJlqfMAmUdLECbbyZ8/HUjxGA4iXTos+qkMIHpqtbo5YkpA98nBePFYByuVJFPVoLKmoTIN4F0F/duk5dVdBX/ZeGHOW8/e+14uibGc/FGfdXkZMDVqAL4hlcef2p8EPY4mEtJo0qwkNIbgbVs5aruazkgmUV32bP11YndToVxKMJMS++s4z/odjvi1d7g+Uy0HZNpzqyb7O81/xi3dV5yJE+egl9bGiwKeeLp26FyiTlGv1eu/gPOHocdab+QOyv8CZDsAN9pHOaBL/K2HLhjK6f362xhVoGbxeukd+IY4Nnk6+LEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/lvLQo66gXSxmK7Uo4U04UT6Anz7u/lwnhUfPLCb5o=;
 b=LLiZ7DCrW11nRGaxNYh74mIIOibciKq9ceIis5hqqQRBInge4VuE11/PdUvjtidkVSfNrzHNehXHSQlOlDGiwbop9zqnpJxbPY+Uw3GrGPtpUrHTiA3plXulLexpP+NrA8fEBMERlBZb/HB3J5iLQpIBD8ZRdSWkXAt9iQKgaDS2xNkxi1ISaXSowcdSTjVcv3VgioAthSjpzWR2lkIlLT0jHepYZNV5okXHimQNg2PTCazVSHmpjQjz7lfyt/p44YeDjQ6q8u8VAVH2YuiYFxYnl+005yzrnxjio+yMKXpDiOo+ixgRmGFt2n5stIWci6ETa5R7KxMa+cpQHXSRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/lvLQo66gXSxmK7Uo4U04UT6Anz7u/lwnhUfPLCb5o=;
 b=MGov8a6tC5ndRl+ZqXzC73aR6b8TfE7PyvFfyofRNqO2Z7KA7DA0GGDSp4X249MKtpYhm75U7qS1djbKJMsKdBtSBS+dXb4qtkiAB8TF4ai34S52RkLWI4mrZ2fxB1tJv4TDYAHBkuhgZhYOfXxq69FeX0w/+LDLVuv/5neLqyo=
Received: from MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25)
 by BL0PR10MB2932.namprd10.prod.outlook.com (2603:10b6:208:30::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 1 Apr
 2021 02:15:38 +0000
Received: from MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::1df4:a9f8:9cdb:42b]) by MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::1df4:a9f8:9cdb:42b%4]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 02:15:38 +0000
From:   James Puthukattukaran <james.puthukattukaran@oracle.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [External] : Re: pci_do_recovery not handling fata errors
Thread-Topic: [External] : Re: pci_do_recovery not handling fata errors
Thread-Index: AdcXgU62xtCQUzV6Rma22nuKU6yu/wADUkSAAAD3IeAAJl3igACfKSHwAAF+YIAC+3xLMA==
Date:   Thu, 1 Apr 2021 02:15:38 +0000
Message-ID: <MN2PR10MB409355791E03C3C8D66A9066997B9@MN2PR10MB4093.namprd10.prod.outlook.com>
References: <MN2PR10MB4093188B8CDC659AE68E5640996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
 <B2696632-CB84-420E-B072-044603A6D3B7@intel.com>
 <MN2PR10MB40933D5232D0F58ECAF4387D996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
 <20210313171135.GA8648@redsun51.ssa.fujisawa.hgst.com>
 <MN2PR10MB4093780C86ABFCAB54B1427C996B9@MN2PR10MB4093.namprd10.prod.outlook.com>
 <20210316215137.GB4161557@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210316215137.GB4161557@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [173.76.5.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36c9e778-9056-437f-23a5-08d8f4b40ae7
x-ms-traffictypediagnostic: BL0PR10MB2932:
x-microsoft-antispam-prvs: <BL0PR10MB29324380E96CC8A42C54B807997B9@BL0PR10MB2932.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YKGIR8cH6td80+2Z72syxm/K5PgR9hrc7nkMuWJabwfelC8jhVcbP4xGBRXBLaR74w1ta4jAFb2xpjo6GL890wpQPB0WY6wy+BNH0GjZIUPooDuyHr+1Vp6ts98P3DvxwwRoYNMvRFKFAqQiARqazMGPctbqpObD+wLXWSaJR3FveQ+GtDQpIRA5M1TWVRiETLaJGyN1kSixSQlkjlwRLavxs5USvIcZQ4jxDQnX69i9Mf6Djodl8c3+4/EKV0engLzrgnUQOdly3MPcCNwyzEEPztaS+ppEhPGBmo+eOqodw3dhyPJGfU/NXrOGxw3bwHg7S2MQlzPRBojLaBcKrzzNrDxSDyqtpcPsOmUs75t9qD9au4Z+pRmlZnOz+mdI3Q7g3qvhgAeOlbRVedoCBCO6S8kxJNn3CODASgI9Pj7FfHSiJAUIAxPEIsTRnD/sBj+g09ggNSMyMrIE/yudvdlzlBajdxOtwxFcd1O1lo0kYI8Zm3t+p6hKXWhx1a5yIH62Wkzkl0zE6OX4HaH+hH+viEbrROA2iyfZUZ6DQretAx9wvYX8YBNcfe5LLxsM+F67dNCf/STM3shSzmmV71uqB24Va9FAvvlqi0K0Sn24nJpagfE/PWK3+1fZvNYl6/7vj1j7B/2TdP6NDkaIJzuZ4wz1oaXTonGe3gZV30U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4093.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(136003)(396003)(346002)(66946007)(8936002)(83380400001)(64756008)(478600001)(66476007)(66556008)(66446008)(8676002)(55016002)(6506007)(53546011)(86362001)(54906003)(186003)(7696005)(9686003)(33656002)(76116006)(316002)(26005)(38100700001)(71200400001)(4326008)(5660300002)(52536014)(44832011)(6916009)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aimrm+XPWmJxaoGFk3rEV4W58mJYcMk75+gTWySI2b3DVerhHFBmOsZpWAGD?=
 =?us-ascii?Q?8a+M/cOFzqAHd42XOonALvo0Hge1C6CK97ulxXOOh0woG3VXcGWb6m4zKIct?=
 =?us-ascii?Q?p6HHr7SSYHyG+FPxt5sv0Pvc9gzC9umm+W+mtY9eddvuN5wmmVdw7jvyZTxb?=
 =?us-ascii?Q?k0SfKZBLdN2atN1yC6xIcEIqpOccX019ne3+I9KYJn4Njc6kOvoWer3upCxh?=
 =?us-ascii?Q?QmouA0nhIEtblLNFnVuB8YVk821MgiB1qWORSd8YAI0wuQPnpP/Tr17tqeDq?=
 =?us-ascii?Q?CzF7aUxsMk6+cqPYr8osO8JKJYtSQ0oz+iI1opv2k8bQNbbFpBLR0an50/up?=
 =?us-ascii?Q?WOCEjxcKurR1fi2IYpPGF5VWczwmXvrytke6uijJuMdJ5eItbl24PyaIyrhd?=
 =?us-ascii?Q?dQIh5/5Y+PWvC7Z8q0pDYqYzUskuFHbxAyXswYXT70fsKIEKbR90Y+3OHIgO?=
 =?us-ascii?Q?Ec2oO4U3mOfaaUNdeetZQqK0KkgdxlXPznNPg/k8xmApN3dcEL/bCC3OyOzI?=
 =?us-ascii?Q?ngSNap+gXFIHtDWDKUukQtBMCZtri6X+v+pua09IJplEaD0FmeIrTt+wOyEX?=
 =?us-ascii?Q?x1Qowvkk7wkDGq6HNFUAaHuYLUmBkQ29uLBCGP1SItC4X3vzQpB8sloEKmRr?=
 =?us-ascii?Q?kZforEKCZ0hZ0MrsGZG10b21LHwWA4QuL6K5Ez33MkFGOZs8vHv00rU0sDmE?=
 =?us-ascii?Q?7hEgG0v/MSykyMCaL1zpcG3hoEFuwgMmGMwJ25kbmCJP2guUfVzi7WSlCDwt?=
 =?us-ascii?Q?FSBcSXZIE1MIe0sbPOEfSVD7HAUXGpG7MTpWnyBw98Pwfurf5DcjVlhdqDny?=
 =?us-ascii?Q?NuSJ0JvGR1YdMREj3F4p5zUYAtKMzmR/p4nqJirwrMOBwzqSRvHS+jhBa3Jk?=
 =?us-ascii?Q?9MDLlAq4jPbuby7MBKSxjiLVjh1aYp9yGmjsVGyldwMOCncK5QvOkXq8MAha?=
 =?us-ascii?Q?XJpeKbo7ig+iyGsznAyWmvjPBewJzdvF0OZNXXb6BIosXgF7Rt0uBp+VjhSa?=
 =?us-ascii?Q?1BAcK6/kt81Btq5l8PbgEQbadZ6/YEzcmAwTq7KcwsWMRj5nEKiLi2jAJAr4?=
 =?us-ascii?Q?DBQH+YzUAaAt45iVy7OHnhtOVXJVBKKWM78WuALS+GfF3hzJlxxxrBi/NpPx?=
 =?us-ascii?Q?z6SXSsVutEEFl1+7NIhnlXIqS8yQQH3CBkZEaRI6FFp3RgRfnhngmoxBhTJV?=
 =?us-ascii?Q?6I7RTN4DUMRkIoaZhTF864B5wr0ofgzbJ+R0X1FGuRgL+NlsBnv6inO4yNRO?=
 =?us-ascii?Q?C7VUBKeSNkFRF15IkgB1L/EUoqdlZNhirMHcIfrGz8WziPaf5Otk6nQi0JwV?=
 =?us-ascii?Q?CRg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4093.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c9e778-9056-437f-23a5-08d8f4b40ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 02:15:38.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5G6laZd57c4nXpU9Eu4RgYj8AJxrNgXIjiA5SKzLnUZz6GHqaMN1U623aCdobgtGr4aj+Z0GL0KVplE33g68PyJUqkS/1XC8UfcIhZ/cAlUYxrEHCu1MBFG8onysKpW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2932
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010013
X-Proofpoint-GUID: -OnTVd-1tDby1ZoIkDD6p0lgc84xk9f0
X-Proofpoint-ORIG-GUID: -OnTVd-1tDby1ZoIkDD6p0lgc84xk9f0
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010013
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

What's the rationale for overriding the status returned by the err_detected=
 callback with the reset_link in pcie_do_recovery? If the err_detected retu=
rned a NEED_RESET and the reset_link returned RECOVERED (like dpc_reset_lin=
k), then the slot_reset driver callback won't be called.=20

        pci_dbg(dev, "broadcast error_detected message\n");
        if (state =3D=3D pci_channel_io_frozen) {
                pci_walk_bus(bus, report_frozen_detected, &status); <-- ret=
urns RESET
                status =3D reset_link(dev);  <--- call which returns RECOVE=
RED
                if (status !=3D PCI_ERS_RESULT_RECOVERED) {
                        pci_warn(dev, "link reset failed\n");
                        goto failed;

--James

> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Tuesday, March 16, 2021 5:52 PM
> To: James Puthukattukaran <james.puthukattukaran@oracle.com>
> Cc: Kelley, Sean V <sean.v.kelley@intel.com>; Kuppuswamy,
> Sathyanarayanan <sathyanarayanan.kuppuswamy@intel.com>; Linux PCI
> <linux-pci@vger.kernel.org>; bhelgaas@google.com
> Subject: Re: [External] : Re: pci_do_recovery not handling fata errors
>=20
> On Tue, Mar 16, 2021 at 09:13:56PM +0000, James Puthukattukaran wrote:
> > Keith -
> > I understand that the RP did not detect the error and so nothing to
> > clear in its AER register. My question is - where is the fatal error
> > register cleared in the device's (the device that was the cause of the
> > fata error) AER register? It does not seem to be done in
> > pci_do_recovery walking the hierarchy (unless I'm missing it)....
>=20
> Gotcha.
>=20
> All pci drivers that implement error handling should be calling
> pci_restore_state() somewhere from its .error_resume() callback, which
> invokes pci_aer_clear_status() to clear the device's AER status.
