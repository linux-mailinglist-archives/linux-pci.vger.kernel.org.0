Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF6543AB69
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 06:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbhJZEra (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 00:47:30 -0400
Received: from mx0a-00622301.pphosted.com ([205.220.163.205]:11734 "EHLO
        mx0a-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233481AbhJZEr3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 00:47:29 -0400
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q4iaa9025829;
        Mon, 25 Oct 2021 21:44:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=com20210415pp;
 bh=Es/LgqvvH1PWKLZHkueSvTvzJfyEaySsRlILIgbg7CM=;
 b=IlrjPA1At9J6+welVMuuQxgfREOvZBhXpp/sFLc6ygKNjzHsfcTZ+7d9sPT45Gm+ZI5n
 +PubvlajKmBOPj3wtQaKJww4Puz5rmb1vc8n4X9sbKbTpHCTSq6jGCIrvKlSpxp81xoL
 96R/RWtXD6RzB6zwNwYZlpcqpUEDS2G6HHUKGNWeuSZzoLqVkIyEEDKRIVqaNs2/339h
 UOGYF+I0N8kC9I4RlOWdQdANOmEdoS614pmUQ/R7wl84MKi5B+UNv9NzEThPVZSmUjQm
 2YXnA4KbjGVUQR//dc/oPicX0pwdoej0R29JSHvLcIzHUxDdSBeU7fKEwEK5XI8IOyeo Dg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00622301.pphosted.com with ESMTP id 3bx53gg4q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 21:44:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpzoHwaEBkkxQHbjueKyRYD943CxJ88s1th8JKqwB8TvHBrgGe+Ue0vFcRod2BwKrRN9qhTSMKQ0qaLbfXi76Qp4ZL/R/opaKxHD4jG0S+v4ul+RNpXtwJTdwL9yfQxwnpt0ReTof1rMS2aegTQtykb2OZ7pZ7QR6N1gib6P8F5SVpJ994JlNxGzzWZVBVULTvSOUYsFpybhbiH8Qqpgj4T3PkdkRsRYoNyt+7Jl9Zf1fm7jcANqyQH2FhzG36QKKrzwfTo4c7cGNrzi22G1Ccywg9XhwHH+hnExi/O8GIG2ZZKdK8jQMcUze2hSr1Hj/QLYrHaQ7VNg0RBIlvUVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOMJCGeVsbMI9Q20c4MwmZhXLiGicOdJ2zfnJYehObU=;
 b=nWGAPBkDad5lBVnLJTMD9WLQpHSFnxLFhp/mE1jNrRiyIWy7JE9Hccfga8w3mO+evIxiMts0hEqEbbkf/kr3sIeVXsvJrvyWKtPT7q0qCygkwMOY82pUs5/5URO8WTny/6S9DcPitxokeHREWmlEgL+OaLfcO/DkGVCAPMCYkBQlB7iC56ZLPrMsR9h2zrbS1VRriXNAFYBtL7a6HFHpwaCpKCvHtE8ga11xGH/c+DgVsGgu+E9/J6iYsHtlxecMYdebXP2cpRGdLVQPbfiM1K+QMLg4h13dfmHW4jjK1ABE4Nz8ymJ1ClBkMy4C0C4WlobhPxXRIttkyNp/r5HG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOMJCGeVsbMI9Q20c4MwmZhXLiGicOdJ2zfnJYehObU=;
 b=h5+ka1zbesoYat3IlGdwnQhfZJ2JQbSTXLGxljpSlAMGnoOVjY1wY3CrWN2f4KpmVII160AqeY+DMzbZj09sawv1QYTiW0loo/CBvCQEqa3VrF0ptH/J+wggJqMlzzYGndeMre/vXMYvuUKbXJV2bLkEKhRI1elB6y1TIqnkvuI=
Received: from CH2PR19MB4024.namprd19.prod.outlook.com (2603:10b6:610:92::22)
 by CH2PR19MB3672.namprd19.prod.outlook.com (2603:10b6:610:45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 04:44:32 +0000
Received: from CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7]) by CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7%5]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 04:44:32 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [EXT] Re: nvme may get timeout from dd when using different
 non-prefetch mmio outbound/ranges
Thread-Topic: [EXT] Re: nvme may get timeout from dd when using different
 non-prefetch mmio outbound/ranges
Thread-Index: AdfHKUVD4pdAQATdSnyIoo960S9VyQCjl4+AAAEy0AAAFvQC8AAB+KwAAADI3xA=
Date:   Tue, 26 Oct 2021 04:44:32 +0000
Message-ID: <CH2PR19MB4024FEB7A178841BD7EB85F9A0849@CH2PR19MB4024.namprd19.prod.outlook.com>
References: <CH2PR19MB4024E04EBD0E4958F0BBB2ACA0809@CH2PR19MB4024.namprd19.prod.outlook.com>
 <20211025154739.GA4760@bhelgaas>
 <20211025162158.GA2335242@dhcp-10-100-145-180.wdc.com>
 <CH2PR19MB4024372120E0E74C8F2CB685A0849@CH2PR19MB4024.namprd19.prod.outlook.com>
 <20211026041538.GB2335242@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20211026041538.GB2335242@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=ambarella.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f3dcee5-6e78-4cd5-0245-08d9983b4dff
x-ms-traffictypediagnostic: CH2PR19MB3672:
x-microsoft-antispam-prvs: <CH2PR19MB36721623C8432260D78D8DDAA0849@CH2PR19MB3672.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RVbHC5PWon6k0PUqTC2vabzzMp7pQsEQhive8hU9HRNfyiiIocIVVpWMZU7Vai9E8RTKK62GdUIcLkvEylW/wYK2kPVBWYJfwlIV+vYG3J60kdAaztsAa5ddmcGXg29T1uwMrU6B42lnlRQ4htlyertvNs49cdxtRHUHbwM8bt4rVXogywrKSDjQSvjRsZ/CQnuf/ALCJlyi5gnhNRpD91uG73KVHAYUJKU3QYOvBOD7RZWfv2wINpTTmei0AThAurWiLTgFR7ucPXbflxu8XVCSlaxiGzcKH7Z3u1sDXcrPPWtwemsZmgoKgg/JDHW3FrCeRt5Dg6Nz9t5S0iEXbLnPSYoWo2X4O0enV8AJVpFEztiyRYt9c7nDOEOwqdMhn7GBSfbiWkht30ihmAETOKgH6WYuEB1fg40ki4gMmKjpbZGmDzUg8CxpKgC/qOmuwLAHpuywV7pek3KfgIFalCfE3ywrJ+4vFP9GXKk41weB2a1NE1kB/jHuURIrFNcDG8Vx/VpWfHmtW7jpqWzT5ICkkFnPBsSulIkd1wnubdL/iazpxJyKAGUHT16OC1SU+VXeDfjsxWvX7bzP4R0EPPX5sCOCczwh86dGNoN0Z9XIv9zMYl7GVX1S//0o00Q9rbjQcUUZfGDF7AmjY99axsRpHcS4W/1J6GOCe0j5DH3qwanWfVGvmpvw/+57YQn2y0HTLwquufM910AOXJ/2FbwZ2+NtFmwCYDGEYpNHt1k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB4024.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(186003)(26005)(7696005)(6506007)(33656002)(83380400001)(5660300002)(55016002)(53546011)(9686003)(66476007)(38100700002)(966005)(122000001)(66446008)(7416002)(316002)(66946007)(4326008)(8936002)(66556008)(88996005)(508600001)(64756008)(86362001)(6916009)(54906003)(8676002)(2906002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mBbfSf/jjHIqPfz5wCG5HvJQ1nnM9cK/KpUZ5sWWgQDwO1Qd35DwN4PJbH+i?=
 =?us-ascii?Q?mEPHftsmYLJU3gAfEUl1MtC+n4r01fUOjUHohipfG+0iTm37jSOZN/4Bnhh7?=
 =?us-ascii?Q?ldFg57Ra8225rG9qkb2NwNRs0PSB0SLIQ5H1h7Qzu7gPvmOOl+UOToGl1u1n?=
 =?us-ascii?Q?VG1tnl+1OELhwwZSmdKur8q0sQwChRvYnLwruCHEih5uCTh3ByHcHnGgD8NI?=
 =?us-ascii?Q?vUHD/MHKe8rd0kpMa9VaZv/MvPuqMo802uDdI174KLysf/Z6iAM9GO17+M/K?=
 =?us-ascii?Q?5NR71UJINbh8tO+An0DIdwFCMerNyG2V+7I6y51vtsWBAbSs9u5iy8FNgpIO?=
 =?us-ascii?Q?maOZv0x9WH0RdzrqT60to3hJ2e2SgP2bFJcahHjnfrJ9zzIjGcjfgzrN89fs?=
 =?us-ascii?Q?PFhAoZWxoE4uCM08sWcgX3r9W4IZTJPq/SJx63RkAfMW4lCFp4Nn/odGb/it?=
 =?us-ascii?Q?szlCr8kKgVvihxLEyGLXiDYRAKjNLS558ihb8leHMdyX+PfmJjt5/3ZuYU3Z?=
 =?us-ascii?Q?2XwHcRWKpMXW0ki8O3h3LyhMm3+lK0OBDjJXDwiaGH4P7disEBIgTK0D8lha?=
 =?us-ascii?Q?+rpiOuv6Zy4tnFBMYQ5huvwqhoKRGvSYUJK3cDvPlp9SAJL4tGq9pDKwTxTA?=
 =?us-ascii?Q?AFcJkPYOqEXhD7N5gTOCM5nIrVU5/6mNrYevYimdowfO2eS/MlBeMdWNTjKz?=
 =?us-ascii?Q?VfgKFCScW4vc0FtST8vi0+/Ig9KORrSOiYw39aOmOvfx92AW785Fz+wpeBu5?=
 =?us-ascii?Q?BPWZSzj0RSnz+8j6HBYZpH1M9l3BKMJk/Ora4PXJfYICahakFSQwe2haDkPn?=
 =?us-ascii?Q?PJYu3uv5zjkVBU10KICQfdi5P2MDtxwiNPhHYaSSbNe6mQ0PbCrPyDVNx/qF?=
 =?us-ascii?Q?gFVKFMzdi+oY2qRWPnofAs3E7f62WFdLg0XlqdeXkoMivP5mVb82K85BxcTn?=
 =?us-ascii?Q?FMYCs/qUTJ3xzQ8wlVolWqu2MzNXOFSLSi7ugaYzJf9NyOFzq0oH7g7jBxPx?=
 =?us-ascii?Q?ERIb2hxvj0GAvEZsr8mkT6AGulNzy/8XdPWTR8MbiikB9As5KnVuQMw9lfds?=
 =?us-ascii?Q?7Z/FI6Hlxqpzem/gNmfF0P1dMCIu9/rj8PUOeuo19xDfdST9/Yfw9BvqTp5u?=
 =?us-ascii?Q?98sVo5hpzVJkDzzxuuSzvckxqtJRBCAU2ObRUOKj3mhxCCmFnHSdwYT2Mn3E?=
 =?us-ascii?Q?WiwToen5pENGmtEbQPNcnTDpOqvn0K9hLM2mbxJRywdi41wauAZ2SRfAUe7l?=
 =?us-ascii?Q?hkQrOeGzTkM6svw1E6vrew7XjsWinN4Rm6666O00IgxbMCzFlYuTZQEN4EX6?=
 =?us-ascii?Q?3C0crhCaiyqWoIKvw/rHxSVz/qkIZ6b3uanr8GjnKRIN+PNMKS4KiUCDpZhD?=
 =?us-ascii?Q?EnB/3rJrO8CFk8PEpA0AOMxndu+bs11L9m43Hr0K/IwSGr9rvmxqVBpXso0w?=
 =?us-ascii?Q?P49TbdgY1CRzhDxbD9nkZxPGO0XcfBJu6ar7XfWfQaZj/Z+9qG+D/smPgrhM?=
 =?us-ascii?Q?yZ6N0CmylUvJslaKO5vxH+TVseidXUdjLtNb5MIecwSf1TKLWC1UV6Uhmd+i?=
 =?us-ascii?Q?afZHH5uYSgBydMyL2acKBb7afzV+vWej8BgVkwv5EEe3d9XZItb1R6qcH/ei?=
 =?us-ascii?Q?1iltoyBL1aDJzZDJ/UJpz0k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB4024.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3dcee5-6e78-4cd5-0245-08d9983b4dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 04:44:32.6645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UbhUEGVS+xoKAkNQ4JXKoMOOIveZ8CtuG8Uz1GC38rNIDribws2l5SMb+nb1oe1Tjzm8r5x9NSghMRsFjryq8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3672
X-Proofpoint-ORIG-GUID: HPJj5TW_nMghPZ21KRGKCoUmzB71p3U0
X-Proofpoint-GUID: HPJj5TW_nMghPZ21KRGKCoUmzB71p3U0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110260025
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Keith

> -----Original Message-----
> From: Keith Busch [mailto:kbusch@kernel.org]
> Sent: Tuesday, October 26, 2021 12:16 PM
> To: Li Chen
> Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; Lorenzo Pieralisi; Rob Herr=
ing;
> kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom Joseph; Je=
ns
> Axboe; Christoph Hellwig; Sagi Grimberg; linux-nvme@lists.infradead.org
> Subject: Re: [EXT] Re: nvme may get timeout from dd when using different =
non-
> prefetch mmio outbound/ranges
>=20
> On Tue, Oct 26, 2021 at 03:40:54AM +0000, Li Chen wrote:
> > My nvme is " 05:00.0 Non-Volatile memory controller: Samsung Electronic=
s Co
> Ltd NVMe SSD Controller 980". From its datasheet,
> https://urldefense.com/v3/__https://s3.ap-northeast-
> 2.amazonaws.com/global.semi.static/Samsung_NVMe_SSD_980_Data_Sheet_R
> ev.1.1.pdf__;!!PeEy7nZLVv0!3MU3LdTWuzON9JMUkq29zwJM4d7g7wKtkiZszTu-
> PVepWchI_uLHpQGgdR_LEZM$ , it says nothing about CMB/SQEs, so I'm not sur=
e.
> Is there other ways/tools(like nvme-cli) to query?
>=20
> The driver will export a sysfs property for it if it is supported:
>=20
>   # cat /sys/class/nvme/nvme0/cmb
>=20
> If the file doesn't exist, then /dev/nvme0 doesn't have the capability.
>=20

# ls /sys/class/nvme/nvme0/
address            model              rescan_controller  subsysnqn
cntlid             numa_node          reset_controller   subsystem
dev                nvme0n1            serial             transport
device             power              sqsize             uevent
firmware_rev       queue_count        state

my nvme doesn't cmb.


> > > > I don't know how to interpret "ranges".  Can you supply the dmesg a=
nd
> > > > "lspci -vvs 0000:05:00.0" output both ways, e.g.,
> > > >
> > > >   pci_bus 0000:00: root bus resource [mem 0x7f800000-0xefffffff win=
dow]
> > > >   pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff win=
dow]
> > > >   pci 0000:05:00.0: [vvvv:dddd] type 00 class 0x...
> > > >   pci 0000:05:00.0: reg 0x10: [mem 0x.....000-0x.....fff ...]
> > > >
> > > > > Question:
> > > > > 1.  Why dd can cause nvme timeout? Is there more debug ways?
> > >
> > > That means the nvme controller didn't provide a response to a posted
> > > command within the driver's latency tolerance.
> >
> > FYI, with the help of pci bridger's vendor, they find something interes=
ting:
> "From catc log, I saw some memory read pkts sent from SSD card, but its m=
emory
> range is within the memory range of switch down port. So, switch down por=
t will
> replay UR pkt. It seems not normal." and "Why SSD card send out some memo=
ry
> pkts which memory address is within switch down port's memory range. If s=
o,
> switch will response UR pkts". I also don't understand how can this happe=
n?
>=20
> I think we can safely assume you're not attempting peer-to-peer, so that
> behavior as described shouldn't be happening. It sounds like the memory
> windows may be incorrect. The dmesg may help to show if something appears
> wrong.

Dmesg has been pasted in https://marc.info/?l=3Dlinux-pci&m=3D1635222810246=
80&w=3D3

Yes, peer-to-peer cannot happen, nvme is my only ep:

# lspci -i /usr/share/misc/pci.ids
00:00.0 PCI bridge: Cadence Design Systems, Inc. Device 0100
01:00.0 PCI bridge: Pericom Semiconductor Device c016 (rev 07)
02:02.0 PCI bridge: Pericom Semiconductor Device c016 (rev 06)
02:04.0 PCI bridge: Pericom Semiconductor Device c016 (rev 06)
02:06.0 PCI bridge: Pericom Semiconductor Device c016 (rev 06)
05:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD=
 Controller 980

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
