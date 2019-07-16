Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3C156A786
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 13:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbfGPLfX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 07:35:23 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:23962 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733067AbfGPLfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2019 07:35:22 -0400
X-Greylist: delayed 1125 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jul 2019 07:35:21 EDT
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6GBBuT7018790;
        Tue, 16 Jul 2019 06:16:36 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2053.outbound.protection.outlook.com [104.47.46.53])
        by mx0b-00010702.pphosted.com with ESMTP id 2ts0cd1wn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Jul 2019 06:16:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9Z09jp51JHyvim8wAJTb0xZDufl8ff1Jvqfjv4YHA9denT2E4ZKZItg0NwdkEhR6zFPzuZOgiOFY761dyWSN5T1oKG+zBySzV/gSlCspUyfHIYzjJQIWORxBN3Ssx3R7TOkf1BGZZ/MsymOw3TGAi55uZzKxXnZsWx+w/JAUvC6WsRJ4VB7wNR6tnXA3PQR6XC29mAlocABCgc2RzIZ6nbakIMb5UwijHttzelB6PqvUYg6PLpGsLbRdvEvv3/yzQJjCXDS4dIwxo9DOcf+URCZMgGRSuw2YZQdjHVTsomziyObNikf0Ct4n9yd8AtCNvSrQle9BbKW1cq2rah++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNr3kzVhwMK6+UhX6hIAZbop7fOeZlcFRw0fn43z3s4=;
 b=f/hiuqJo8ahl7eXRbfMWSRgv2JE5A50XLq+AnLTizeCcIEFi6MuGnpTtM4gVwFhfEetiyt7ne2qF3olZVVCWHek0V5WMEZiBThR+DJBAgHWpWLS2mhLSx++Auao8wFu5WmDXYWaml+WeuLj62aAo7boLupMFF8CFdxsAvtWTJ67lNZhNN9XvKTUFRKFoXkKm0qAqsyk4SfIknUhVu5uk5pgLC31PNDgj/moeJLP21WfHBIHtiTAuco5zK7YcNCNMQ8CgLikQVQJLCDZscBdxFQhdp4BV4VcxykTgUPsxJw5K1fnemBwLKBKymWkr2PbwKINTwuRUDYmRbShT/lxVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=ni.com;dmarc=pass action=none header.from=ni.com;dkim=pass
 header.d=ni.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNr3kzVhwMK6+UhX6hIAZbop7fOeZlcFRw0fn43z3s4=;
 b=kgqLzAWhq+EtsBVISHrdjahV1L7phTzT7S/8m5vKkutriTPSZ0h7oxXmNF59LvdqqKqMgSYk4dH3N1z/TJlI+ZtC1d9bQlkI1tS1EYflVG4TqY7n9Oqp4w0BqxEwTHOXQ7GawLX/cI88vJjiC1NXTKIgkFtNKQrn2b27CEePuMM=
Received: from MN2PR04MB6255.namprd04.prod.outlook.com (20.178.245.75) by
 MN2PR04MB5821.namprd04.prod.outlook.com (20.179.22.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 16 Jul 2019 11:16:33 +0000
Received: from MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::c592:ee6f:7749:dcc8]) by MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::c592:ee6f:7749:dcc8%3]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 11:16:33 +0000
From:   Kar Hin Ong <kar.hin.ong@ni.com>
To:     "linux-x86_64@vger.kernel.org" <linux-x86_64@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Keng Soon Cheah <keng.soon.cheah@ni.com>
Subject: Firing an interrupt pin induces the occurrence of another interrupt
Thread-Topic: Firing an interrupt pin induces the occurrence of another
 interrupt
Thread-Index: AdU7xXHhnNl8aRO4RPO0W4+pOfkZoA==
Date:   Tue, 16 Jul 2019 11:16:33 +0000
Message-ID: <MN2PR04MB6255ED23FBD06326084DA2C4C3CE0@MN2PR04MB6255.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.75.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d72563eb-8e53-490c-42bc-08d709df0f36
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB5821;
x-ms-traffictypediagnostic: MN2PR04MB5821:
x-microsoft-antispam-prvs: <MN2PR04MB5821211DF86F5EE8FB080057C3CE0@MN2PR04MB5821.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(39850400004)(136003)(199004)(189003)(4744005)(4326008)(81156014)(81166006)(8936002)(478600001)(25786009)(5660300002)(52536014)(6436002)(53936002)(71200400001)(110136005)(450100002)(8676002)(7736002)(86362001)(55016002)(71190400001)(256004)(9686003)(316002)(305945005)(2501003)(2906002)(3846002)(26005)(186003)(74316002)(66946007)(14454004)(476003)(33656002)(7696005)(102836004)(6506007)(68736007)(76116006)(66556008)(64756008)(66446008)(66066001)(66476007)(6116002)(486006)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5821;H:MN2PR04MB6255.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nvdfoOODpA6bwhgwMV9zP59x3hW0BmGHXGYq8Ccu/vqBlbqv9OXgFWqXKMv3iLiGNhFO4pdmfoqUsJ+/2SZQU1JNlAJz5hCAsjxZ/E4lzZktxvYQUDVh8lKroF0EtaLg98sqtBGchTSJGU/LMKOUMjvWRd0JroLTsdipsWiKk8gBsi9KVL8H/jRKEU/dcNchJCm0cULY3RUVphyHaZRp/6l1K43GXWxJPuYAz9wvJQrD8MzkfH+8Q6xo58qzTxm2I+9xSjj9kAjPXomot86LGoVVEuUteEqcqQauoiT768FZ4nJQCQGKCN4UXd4hJo0okRyAGwo23YNzMg8Y94kHSADlEUAqnEXxz/WdYbrrlajK1XgHKM8GplBrYKZ6DTVmOZMa8/hlIqNvMeXre0CV94Ndw5QZBCin4SA9GMsmLNI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72563eb-8e53-490c-42bc-08d709df0f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 11:16:33.1547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kar.hin.ong@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5821
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-16_03:2019-07-16,2019-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 malwarescore=0
 clxscore=1011 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=679 priorityscore=1501
 adultscore=0 suspectscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-1904300001 definitions=main-1907160142
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,=20

I have a x86 system with Xeon CPU running Linux with preempt_rt patch (kern=
el version 4.14).=20

When a PCI device firing interrupt to GSI 44 (ioapic2, pin20), I noticed th=
at GSI 19 (ioapic1, pin19) will get fired as well, and then it went unhandl=
ed.
I can reproduce this issue by using another PCI card or swapping the PCI ca=
rd to other slot, as long as the device is driving GSI 44.

By putting traces on do_IRQ, I can see it's being called once for GSI 44, t=
hen being called another once for GSI 19.

I tried to reproduce it on RHEL 8, it is not reproducible initially. Howeve=
r, after I added "threadirqs" kernel parameter, this behaviour appears on R=
HEL 8 as well.

I would like to get your advice on whether this could be a kernel issue or =
hardware issue.
Inputs on how to further narrow down the issue are most welcomed.

Thanks very much in advance,
Kar Hin Ong
