Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49369468EF8
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 03:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhLFCHO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Dec 2021 21:07:14 -0500
Received: from mail-eopbgr60086.outbound.protection.outlook.com ([40.107.6.86]:38579
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232591AbhLFCHO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 5 Dec 2021 21:07:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEq6nnRUg7kbNETw/v9gwzBze9j6ltoTNMSz2KVUl4N42AozRXXrl4Vm40g2at1E93i80fidJENIoPTeqQxc4cqS0dUsHPwfzbMruZoW4u4ZqL1JuZtoyAQuboUB0KOm3Uu47o17hFA/D65YdkC6cViEPbet3mXX/jbq7FFP3cPxg7I2fH36gQqh2vVuatojm8iM2H3RnTzwwQ7pXD2NmT/drqxggnrLZnoG29HoSwH7aahmQ1ueTmkkG/HDxJ9H1kB8X4BtEQiQA7Y1rYkznzHEdCn1BMJ61AntHFdhaLpKxDDb1Z5Ln4ZZMwcFubYueszJAkeOlJam28cHYVlo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3NqH9CDCtMle8dmzBPNac68SxqV8Rw5h9/1cAAGvwI=;
 b=WpnRFtURoJCyGhNHEjtkIV4P40+8xsDq/2+m+PynkJfRrwdOzO8hNm/FFSYau6ghg6glMQ7T/QMSlxAIP4QTJnGi2Fmx/b0UIlbMP8lzWmJOz8B4L4cYDrMmlKyFLtZMAn/ieluu2zP5ZHEjTlPYyoTjBbdOgI03JwNMPIm/m4V/dbNE7fyNro73UdT/rXNyT6S/8d+hT6EzGIAH6N2cWdI9RWaUEHutGj6Flv0512N7Ak0/NK11ZaNk3jaFhEcYY7rk2iuXQafHtLQPhFsPxSeNR7zT5hu+JWsT0VD+bJo8SWaBIlkry/daKHJe5RmELkT4tLiYIraN87CUuANUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3NqH9CDCtMle8dmzBPNac68SxqV8Rw5h9/1cAAGvwI=;
 b=sP9sESWVD/8TWZBrgJVGTN44y+IcAHc7pztDKxo/yGEZ2sULKRT2MCSHi3yQwKyikBmX6Yiyk4wgxfUEMLEBpHldydfEJzoe17ct7yDfkshWwvvwqeVxLvi0ft4E3EjEotiHMTNNCbQgPogjGqoVObffHGXOtW+mqdUawrTeodk=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8754.eurprd04.prod.outlook.com (2603:10a6:20b:42d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 02:03:44 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 02:03:44 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: Allow to probe when dw_pcie_wait_for_link()
 fails
Thread-Topic: [PATCH] PCI: imx6: Allow to probe when dw_pcie_wait_for_link()
 fails
Thread-Index: AQHX0Q86pmFTFD0HQ0+vlkapkYarDKvyiKYAgDAeMICAAjjjUA==
Date:   Mon, 6 Dec 2021 02:03:44 +0000
Message-ID: <AS8PR04MB86760CC96C1A50776DA48C558C6D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20211104000202.4028036-1-festevam@gmail.com>
 <AS8PR04MB8676C527C11B6E0BCB455E1B8C8D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAOMZO5BcinSC=h+uTGiYJqhE7qHeQa7NwYZsSiKgC_Zkm5XROA@mail.gmail.com>
In-Reply-To: <CAOMZO5BcinSC=h+uTGiYJqhE7qHeQa7NwYZsSiKgC_Zkm5XROA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8a2c16b-0f2d-4115-63d4-08d9b85ca20a
x-ms-traffictypediagnostic: AS8PR04MB8754:
x-microsoft-antispam-prvs: <AS8PR04MB8754B20DFD18A28271DE961F8C6D9@AS8PR04MB8754.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: my4X2+9AcANVNjXlT2xc0W0IFPtSSea3ARQk+bsevqjF92OElMXGNEEavIC4k+Is8c1oRCyP67pCWfR+Tbx/TgX6iBPvO8tUHbche+ZkUEFHJuNJ/K1EsI0C0GpIpiiAonKLAT14uVH2dJ+dEictI2VDIrw4JbECzaezCTWTj4iUr+3kf2KaIA15LiP3pXDYaYc8gSL8iuLvHuVdbJg0rQcWYhuN4A67ZxHfWtI5snBH+mLMKzq4T4SGhowx6v3IJAD2sptm026RbmpqCQBEkCSF07Vt8vzF0QmjO/Q+8rZk4GAtCS7h2xxcd4/+TIQK0tuD7uYaAinXRNvy7xc4RkGqfbVGyH2Cssmix4Quxyjd24Jx4jIEuyDFefTKQE4LLIoaJNxkhN5VamEWUXkG3quARwO0YrAWJxhKe8ZPMixNlZK2fyV17G3T2PQEYw13/vsf8k6YG9DfdDOCrRICF5n7GFSIuXcfxB7CSUosQjz6YHTuNbOD7Y62DgKa6BKZ0I7FtRCvBzAyJK/HJPRd+0riCG2674zQmDrrVGHdEVVmKET0XtTQFZolkBdVD2KwwNuIZRsxb4RINel3888qczg6fhG0BZpThwrhvIGo6fihVPxHlMdprpX/PnhZEWyhJOThstb04Ku5Ej/Bh1R94XNVtEVGrOpeC1rGKwLftuvNB2s2GEN2XCAlIKkAPmSfrM8jmI4VIG1YO3bHiFzKo3gUTGdRMIg4lweUnVciulki3aIV+VE9Gw+nRismjr+PVWXanuPQkFQOuqh+j8OS/5m1Qs5L2folDTgc5bF6sx4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(64756008)(8676002)(71200400001)(122000001)(6506007)(508600001)(186003)(66446008)(9686003)(45080400002)(8936002)(66476007)(66556008)(38100700002)(53546011)(52536014)(4326008)(38070700005)(33656002)(83380400001)(86362001)(54906003)(5660300002)(6916009)(76116006)(55016003)(2906002)(44832011)(316002)(26005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IMsCCzhDy9J1jxkkZD5ugzfb79TAUeo+eofQfpCR9twyqcSa/F+FD+OVZ0z+?=
 =?us-ascii?Q?Oi24nsjXhd/o0AvTRt3hWFNHwsUVX9KaxsY0iSEWp69yQFhYpGZrwYzOJJI+?=
 =?us-ascii?Q?qtSnEA+MarDc3i4DgYnsijYSxYUEBQhGoXIWuxwd6QsGseoHt7zCnW2tNBr+?=
 =?us-ascii?Q?Mt6hJqnghZ7XZq9QTAI0UMpMhf3DcpXxnwF9PmI86s0rCAnMTfdmxMhdDifq?=
 =?us-ascii?Q?kCS7UTaGO5sBwVOs08wBzGyeTXYm0qohwc9yU1KmqBXTumCgcEuGA549MbyS?=
 =?us-ascii?Q?riIem9Q6VDPhd/SbkUskOp22Ln0Xl7nwSCfpZgIytOxySbHVqug6jv3hSvry?=
 =?us-ascii?Q?qlcV8VN0S3BE96U48xOV+MpDBU9GzO0MB7j48UmAcKLWMcC3qy/GBlRwKvRl?=
 =?us-ascii?Q?Bes4d8i2iFjdRPbS4JQ+k4jLtETscuVzRFLefLry2i1pW616CvnL6Dn/Hgzp?=
 =?us-ascii?Q?IgVMnHZmyI52Ry1cne12CKiHMtUOTJh+TDw/tpWnqQqvP7K01liMA7mMUSXh?=
 =?us-ascii?Q?JQc0I7IuLyf6V6O4hrxlUVXWWbzvyiY4DqdLV8qElw0hjRRWNzvC5pRxrfJo?=
 =?us-ascii?Q?PT7tjJj+zDH0SbJF21omKuaMycabQuZOF44fs8rOjn3+y8S7ISodN2YDrzF3?=
 =?us-ascii?Q?mqJHO6kQalpyI8AH0vO8f57PY3zieYwn6eFT3loFkY2jnlppEZcGgiElFWya?=
 =?us-ascii?Q?GnLqr3OxQp8dC9AWxOaKrVemfrivciYxYiZfzn34gnheh0eKGgsro1mn0azY?=
 =?us-ascii?Q?3g+6vKJfqunmgxdppPxWOao6mRIkR27OWWXDDFLwxAJNlmHFQobYXIkuEaaU?=
 =?us-ascii?Q?/HjMrPs5mt7NhD+AyqiVChNPvxcnF7fB4uQmezq0s3m0+WKhLn9AEO3U3xWV?=
 =?us-ascii?Q?+CYqxs8XAxppTW55zvIyg5yhLqmkEI1RO0Gzw1ltlpM8DA+YzuSWbo2khXkw?=
 =?us-ascii?Q?SHBYnlHbsK75FskP+RrGAkMVnwXhaQaPAs1D+Aq3E/dhatdVkj5PnwycLEmy?=
 =?us-ascii?Q?CkOZtPILyUYMP+3WFyhe/eqVhvLL2OtDaEnAstjRNDFVkMwCIxwzat7+5/m6?=
 =?us-ascii?Q?qGowanoa2SvfeKJOGbjQ0AkR+WOf+DcH2M5AzLVTzRN+HgOReGypP1JU218B?=
 =?us-ascii?Q?ymF3LfbhJ+yN4T1LWA86zP139vYWWffGdpm6sDf3vXkZsUsq+a7uVADKotE4?=
 =?us-ascii?Q?oI4s93YixUaGtfg29bTmlbIkKuWvcSQIASj5rN25EJdyf1GW5+idTjIS2Rlq?=
 =?us-ascii?Q?W8jMRskNhaxz5IsRjYD/C2jRdQC4YIBycNx4bhn8QoYGJuX0TPF51blKgx0R?=
 =?us-ascii?Q?XaMZ/l+5dbIMMKIJ7rlxKm1YedyMGUt8grZdBBg4gecT33xC9ugXkdTC56jo?=
 =?us-ascii?Q?iQrTDQJW59wrdIoYPsrvSagbMWwgDjg1uy5TJMVh1cup0ksI8FmNwSZUWkqz?=
 =?us-ascii?Q?XK7pxwUZfMZZjc0mejhy/bsvbU08mdpOdUfkO/2q8aIjkcJojGZ6xfofzTXk?=
 =?us-ascii?Q?t5qsWxycT38rxemCQ0zfnAB9l31hl+oxb2iBPoDjN3s0E5RtBmgEJeH94gAE?=
 =?us-ascii?Q?gvyV0ffQvLztLMBddk657RQOXtIvGVVoFoyZUrw8huDamvb89iEwu6GGEAkR?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a2c16b-0f2d-4115-63d4-08d9b85ca20a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 02:03:44.3821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGOTWx4LQ3+yG3mSd0rn78DYSOAq4YzCo3vvwtoMnG5yXni2B41xfMoZb0yiXbC5OId/ZDpxBamSZiIO+qNDWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8754
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> -----Original Message-----
> From: Fabio Estevam <festevam@gmail.com>
> Sent: Saturday, December 4, 2021 11:35 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; lorenzo.pieralisi@arm.com;
> robh@kernel.org; bhelgaas@google.com; linux-pci@vger.kernel.org
> Subject: Re: [PATCH] PCI: imx6: Allow to probe when
> dw_pcie_wait_for_link() fails
>=20
> Hi Richard,
>=20
> On Wed, Nov 3, 2021 at 9:58 PM Hongxing Zhu <hongxing.zhu@nxp.com>
> wrote:
>=20
> > [Richard Zhu] Hi Fabio:
> > First of all, thanks for your help to care this bug.
> > This dump is planned to be fixed in the #5 patch of  '[v4,0/6] PCI:
> > imx6: refine codes and add compliance tests mode support'
> >
> "https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fp
> atchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F163574
> 7478-25562-1-git-send-email-hongxing.zhu%40nxp.com%2F&amp;data=3D
> 04%7C01%7Chongxing.zhu%40nxp.com%7C5ead6c09df204e65988908d9
> b73ba44d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637
> 742289061098040%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am
> p;sdata=3D%2FbJokqkG1jyolTO1%2FmZhxLhmzcBKUQqU4fNx%2BoKnhGg%
> 3D&amp;reserved=3D0"
>=20
> Any progress with this?
>=20
> Since this problem affects the stable kernels, would your series be appli=
ed
> to the stable tree too?
>=20
> Could you please resend your series so we can get this issue resolved?
[Richard Zhu] I'm glad if this series can be applied to the stable tree too=
.
And I can re-send this patch-set again include the stable kernel tree.

Unfortunately, I can't get contact and response from Lucas for a while.
Without his ack, I'm afraid that this series wouldn't be merged.
Lucas might be on his vocation and limited to access the email.
I will ping him from time to time.=20

Best Regards
Richard
