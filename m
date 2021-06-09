Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD5E3A2065
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 00:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFIWuj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 18:50:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:58712 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229534AbhFIWuj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jun 2021 18:50:39 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 159MgRpT023612;
        Wed, 9 Jun 2021 15:48:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=z1qsi0fj/fpA3H2h4vilVCgSOdGzern/hcaTcw835zY=;
 b=nyIEsuCK+/jW+RazX5dz9t5g0pefHUdAlbgHV0ZLcxIcvuzDIlNzqHOXUb8+eY6JBdSn
 sTtvodESgFrq5k/vRGKedYf2ZJP3ocWHZob7REFXSSOCZwlWxAtUbPisAvCyH15lwssl
 8DHojz4925TMgvX+KNtsWg0162Sd1Ngut1SzwnbSpD+UbySs3QTDAyBWMr+YLRvLFIJe
 NLDQCNcLYwFkGe9elm+CNsLInDY0k6tDx2eYHC2lL3H9hqzw/1hAzwiATXVKBCiBSgRo
 kxWUj0utyd9hCsMGPRUqZjHuZHDBUb2KMvDf7e5IseJJkK5mSzMLcxmPXvZDIOK2XnVK bw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-002c1b01.pphosted.com with ESMTP id 392fbwk8re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 15:48:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zdvly5kCVyBSiUbJBRIJ3pBUQixvuVW4lV1tRWDHJnQ/zEPXAYXOrksF099ImPvdX7obX/IQO7nWJGWfP/99/q1ey8FpMqS+t4iU6tEA2oNpgHZq9NNWBWiFTil0m20rIHdIXtLzroM1g8Go247Da7v0ofidMjrpjCSF/rs8Lst1sE5aKGiFW3AlXMwQ8ddn75L24ISiNOP+1MWLH8l9B/RQtTY2ImMKKOPODWaeaaMeZZG7ToauHJMnlzr46hX1cm36qtJQuIvE5tuJNcwy2JKaxTmiCrdoHZOkWyGy/PFaNor07EfIpTJ688U3VU9I9pJ57bCTWgfXUh0ePZM0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1qsi0fj/fpA3H2h4vilVCgSOdGzern/hcaTcw835zY=;
 b=lCbrMnvjKpwDJE401PlP4XN25WHRiD26B8Gx5yrfaoNPFAnPSZcKw41d12Qo6wjhOn0vUzbSgidrBE3RBoOIYUdCcR/X5B+yFci1yUAvUX+6wNicVQq9h+NtGTEvPiGKImmcMv3xVJivK/MMVQwRestsRyuHv+NkxwkiGd7TPiaxCgCFV4jAAmdQBkiMZW74sh4BtSPR8kYrSaVaoxqhMtqwzmjQoi7V7eqWVTWFoB4r/KfIF0aD7/+3vrSvdNq0wVXxq9Xu3K9WJ/eJAEPfVAVPWWgQ+2gxGJvMIivyaeI2hH+L9tGheCqeZHOS0AavXNqTht6cbFAkk9sT1nU0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SA2PR02MB7851.namprd02.prod.outlook.com (2603:10b6:806:137::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 9 Jun
 2021 22:48:30 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::bdbb:69ac:63f9:fc33]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::bdbb:69ac:63f9:fc33%7]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 22:48:30 +0000
From:   Raphael Norwitz <raphael.norwitz@nutanix.com>
To:     Shanker R Donthineni <sdonthineni@nvidia.com>
CC:     Raphael Norwitz <raphael.norwitz@nutanix.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kw@linux.com" <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Thread-Topic: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Thread-Index: AQHXXCoL0P5HbzLU706U/y8QJTrdCKsMPIcAgAAK6AD///dNAA==
Date:   Wed, 9 Jun 2021 22:48:30 +0000
Message-ID: <20210609220518.GA25895@raphael-debian-dev>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
 <20210608054857.18963-5-ameynarkhede03@gmail.com>
 <20210609215724.GB25307@raphael-debian-dev>
 <712afcf7-5a46-8747-2fb1-ee167f406847@nvidia.com>
In-Reply-To: <712afcf7-5a46-8747-2fb1-ee167f406847@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [24.193.215.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7d8d69b-6fdb-40ae-a883-08d92b98b3e6
x-ms-traffictypediagnostic: SA2PR02MB7851:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR02MB785124001F91EC34BDA5C7EFEA369@SA2PR02MB7851.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fR8hnD0ZqqoXKL31Y+H0exnrnMCP3J/t8wD6pHG+lu27PHdTDrAue7lnfSTOI7X2PAdLNjMeerXmNWSkSiiv42zBXR3nuqbGzBOqhbvbAh935rNXQXSztpHt/fDa/Oz4GnYx893vAtfZxzJQXipfMWMTnskZ+jWLC7t6cVy+tA2NsbYcnZ4WTVBeqgzRtXjq431G2Z7+pflQy76PS1Dn0B3s1MqQ6FG/o11K2GmtTsSEhpdsLEwZ+AcKWHabG3kLcYfHltZStjl/n4chEVA7/8Nx2F9trDiUXX26xLAv4DpfznZNMQWvq5eMD+/ZpiTChdw/uCZACi5dXTrh9o2v779Ta71dgZsKXmwNjG83avwVUdyHBunToWujRtMMNO6RACKFOySS2+1J/run1l8pCkmly+FQ8cZj9BNCMKZtyR6RrkIwnlWunyEJhbLnkdglqQ2DCicd4Z2KPSD8xEfsld76HfFbaavtHkTqJuppZu0g4omUhKY7W0eRMjEeFIUaIMa2lqEL7+XYJdG+ATIS6jNhKOfe87cXH6YUnlApaEZGJsPP/rUWTy/xhvbWoagMwc+s26OUk+5V6Zlr0yS0wtDwA7J93qJqKSpQE2ev734=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(39860400002)(366004)(136003)(346002)(376002)(53546011)(66946007)(91956017)(76116006)(7416002)(86362001)(66446008)(8676002)(66476007)(4326008)(66556008)(6506007)(54906003)(64756008)(6916009)(44832011)(1076003)(33656002)(5660300002)(122000001)(38100700002)(316002)(8936002)(9686003)(6512007)(33716001)(2906002)(478600001)(26005)(6486002)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hqz62FFpEK74klKv6BK7Hr1cAvebn7UwadVHj3lo/8hKmxn8/vnvdKxSSe+5?=
 =?us-ascii?Q?nztx6sqN5DyfpV8GuoLHf8FoOuPNvZ5dG6E2CIc9vmPTx/IirjGBsIsOJJuj?=
 =?us-ascii?Q?h7SKAoUr1aRizQzOunFODYqwHTrD6hriNdBkSsujOoOHL8mWLVI3Zo7MTbUi?=
 =?us-ascii?Q?dG2UR8+4g6r+6IY3fSY0ryIUWnGQP74qXkaYO/ZndN/XZ454qPjZoNjpx/vd?=
 =?us-ascii?Q?hn9YdLke6HILYpNsgLf1/tBX55+BkUbZpd4xbbIVDX445T+djlqmwKTeLqkT?=
 =?us-ascii?Q?LSf3MJpOYDFMluSogx9+/dhqpvqQTte78LJcfuenBsdpJ3h/hhkzswIlNJRP?=
 =?us-ascii?Q?8qBdS6JYyRlaE3H5kzxyuofS5Li4hDHDAibYYDpCdwB1fnd+ogF9VtohDheL?=
 =?us-ascii?Q?GN5I6DTNFAKmcpucqrL8YrBOQz6XiUScETOI5RkI0Mk6Ss28Tej9ciJnZPTI?=
 =?us-ascii?Q?13tRokk0ngRaWPiGqvdzFDHBIpQ9M+NOl1edNElx4JY3N3Yo6kjlaV9982w/?=
 =?us-ascii?Q?j9WdmcrkeTAOrruGUF9+0zeSFadQJasGE6vSZKcviLAorBB4363kVGFJpvbL?=
 =?us-ascii?Q?LSlEUnfUeJCKGnTAvGridQap6mO5RuvmWPyM9UW988YJlzTmjaMs35gzE2NG?=
 =?us-ascii?Q?FhPBVqqe4Bn1uwzC7HmkeGhYlL/4zfQdrnH+JTA0NbQWZHWHB4rK/2ihY+V5?=
 =?us-ascii?Q?/4gzBczOU9WQ4/xjZnkQ5fnK/HHSPjiDBa+h0cRCfqAwwu5Zmayk96Pu6kyF?=
 =?us-ascii?Q?zWofFGDthBTpApUgxNAHb+jkDePdmnuERAcQIEi5Hn1ewEibJZFpP7wkHclL?=
 =?us-ascii?Q?16vVpfvD2ZhWGWTuarN/yTl+j44x6ngwTuLik5sUzEZBIgf3PUjwGYUG8vwU?=
 =?us-ascii?Q?yi+Z32Gv3Bb2Wubcxe7vazQeE1PdEo6t71uPAxOJaA0XvaO0wHm09Dj8C6dn?=
 =?us-ascii?Q?slM4wL22e+kPNcrlPyIDdzaKyX6XI/sJte6fIFe7+kik2Fm/jOwGhfuwEM5d?=
 =?us-ascii?Q?VMfn0eqL2zouuP1Vfx64P2OmWzAFdcEWi9pOpULUEZUZVILRnZzVggiZG8vb?=
 =?us-ascii?Q?zTN99lTvJRNDUb59XbWxrdHkIKvxwdTFIn4jyv7fniF/CAd0FBfXhmgeZgOt?=
 =?us-ascii?Q?czud6npuMeusDun79vfLP157cCf2xv7HFTNyyH1pVF3W0dVhQFLNgFoxIXfq?=
 =?us-ascii?Q?aHVrRuFYkTxANQPhHI3JdRQJ762HOUZKl64+fq4j2z63ehNan6wvBLKgyMye?=
 =?us-ascii?Q?rUUghX63LoD44GGVUHMyrXBqMGkSadquXQ9d67MD1yv/X1/O/Vma/xocS3cz?=
 =?us-ascii?Q?rxipDqPBYH/cefju2HbSlmEDDm780jBy6oNuCw9ZSTfvuQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14973C395F3CED42987D06295CBC0F30@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d8d69b-6fdb-40ae-a883-08d92b98b3e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 22:48:30.1328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLpUrzxnpIQpjIQJw1B4FU0qek5pEroaTdqkL3fkf8ki6w7p9FblgHDlsIzjLeiu0J9mas4mRhKIYQeEpiXxGbsienk575f/ASICyfotnY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7851
X-Proofpoint-GUID: DWD5F5mEu7S6-tZVsVYaBpjulH6wA_nD
X-Proofpoint-ORIG-GUID: DWD5F5mEu7S6-tZVsVYaBpjulH6wA_nD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_07:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Yes - I got this one wrong.

Nevermind, looks good. Just the punctuation NIT.

On Wed, Jun 09, 2021 at 05:36:26PM -0500, Shanker R Donthineni wrote:
> Hi Raphael,
>=20
> On 6/9/21 4:57 PM, Raphael Norwitz wrote:
> >> +static ssize_t reset_method_show(struct device *dev,
> >> +                              struct device_attribute *attr,
> >> +                              char *buf)
> >> +{
> >> +     struct pci_dev *pdev =3D to_pci_dev(dev);
> >> +     ssize_t len =3D 0;
> >> +     int i, prio;
> >> +
> >> +     for (prio =3D PCI_RESET_METHODS_NUM; prio; prio--) {
> >> +             for (i =3D 0; i < PCI_RESET_METHODS_NUM; i++) {
> >> +                     if (prio =3D=3D pdev->reset_methods[i]) {
> >> +                             len +=3D sysfs_emit_at(buf, len, "%s%s",
> >> +                                                  len ? "," : "",
> >> +                                                  pci_reset_fn_method=
s[i].name);
> >> +                             break;
> >> +                     }
> >> +             }
> >> +
> >> +             if (i =3D=3D PCI_RESET_METHODS_NUM)
> >> +                     break;
> >> +     }
> >> +
> > Don't you still need to ensure you add the newline even if there are no
> > reset methods set? If the len is zero why don't we need the newline?
> >
> > Otherwise looks good.
> >
>=20
> sysfs entry 'reset_method' will not be visible if there are no reset meth=
ods.
>=20
> =
