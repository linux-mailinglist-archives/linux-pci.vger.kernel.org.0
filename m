Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A2E4426A9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 06:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhKBFVb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 01:21:31 -0400
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:48986 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229486AbhKBFVb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Nov 2021 01:21:31 -0400
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A24uNwF021399;
        Tue, 2 Nov 2021 05:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=com20210415pp;
 bh=ciHq54YJ//X/cXA1nW8MdtF81DCx5kSHyXT0Ylk5GCM=;
 b=dlZCuaZ+tRvWPapiS0jSfpZNIxoYEyvuVO+Vr+6qQYaeksqsuKmG4YinnZtcayfLwmyY
 hat3Smw8v5F2fRYxJpFxmY1HHfA9mb+r5Fy3L5FakeZIEk+xnyKvwU+hCLN5w+0sEa9I
 BZ+33C+qe1lNxbhxt3vcDm8eqLu31R/uplYMLcm/KbOJGYzRoOhZUNz6vmxnqsi/lCPd
 yJhp7SQlgnzNg6eQD9u6Ol8Do1Qr2EXsJ4kn+Fho93y7emDbKLhyS5Q8GaoBRwmWfaDB
 7+0SXlQeYtgz+mDG7fynLjapa9IP+ZF4o9wnASkTo45vSlNYkaG3tP1JxDcL4xTbSUgH WQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3c28c88hn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 05:18:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVQEwCbK1OQO3JhGgGdJs+wkFGrPq3ITn1HrUfesmJr/BW4SL/im1LQKVeW3XAFy4udVg2pwjUj2wUVLLzWuTdEdK6gamZV9tkQkgGPD7PdEATVjYL2VzW4rXwtB50Tj4BnMN4LX4Zcnkc0eHRGpExOQqqSz7GyLAHHMUdUzp7nMIutGMiRFzqFVB6bHoZPt5EdzmSBr7fby8soP8d0q/zzm0fIb+C1/iYjR+jZxKKUzlUDtOWi/i/NJfmCncd3+Y6JAg6FZ06TClZfYn26qxkUgeXhIMuqZmpjobHhSWGoGFl0KZvaCuSAPOmTE37Sv2wz8kZPSjUwWAipg2lkw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XvA5HTTnDvl0OkP+mCnK07XkJDSbPNzHNR7JaDbknA=;
 b=Ui5g2wGJzqBEKj6MoBv3G1ajvei1euxRye3Yfvz/ylo1uwlz/XU11i17i/LRl8UQ8chGOt69lxQsP8TWukW/3MyPxQN/xYEhaccCX+QVIlhXlLi4VfTj+a0qOad4qpEMShA7GQHk5M+oKDiTaMWDpzukWH1G1XFrREcDLnIIz/jpF0Rz+e39VGLh86O60KoV7mg/eu/QgoxtGJDT5XfSfniirnz1Dzj7uTuBzZRiRIMrx2WFyWi05Q9dF4c5vtsQymsYpseefET3huWnGvJPLjyjlJosE/Vs/fA44A1Z4O6Xfy8FeaSQGqy82CtsEp+6IUkf70U8gfo8O1AQz6xwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XvA5HTTnDvl0OkP+mCnK07XkJDSbPNzHNR7JaDbknA=;
 b=jGWVWgvKpKdF+bjKrLfvXL0JHs8dZCjQ9NNm096SWK3UiHJs19fFgoZdFqrWgeDcjXM3y5e1geaaRWdpKFxFz+puzs9RXbu58kTrAmMV88j3aIDg5LIsK4sLXucFkymjMq4Dc/keA7nnH8gFAltSOy9ph1bZ1pXrd+V2fCmYFk4=
Received: from CH2PR19MB4024.namprd19.prod.outlook.com (2603:10b6:610:92::22)
 by CH2PR19MB4087.namprd19.prod.outlook.com (2603:10b6:610:a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 2 Nov
 2021 05:18:14 +0000
Received: from CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7]) by CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7%5]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 05:18:14 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Keith Busch <kbusch@kernel.org>,
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
Thread-Index: AdfHKUVD4pdAQATdSnyIoo960S9VyQCjl4+AAAEy0AAAFvQC8AAB+KwAAJu5nUAAG4h1gACqLnSw
Date:   Tue, 2 Nov 2021 05:18:14 +0000
Message-ID: <CH2PR19MB402445CF3AEF3529E9041211A08B9@CH2PR19MB4024.namprd19.prod.outlook.com>
References: <CH2PR19MB4024F88716768EC49BCA08CCA0879@CH2PR19MB4024.namprd19.prod.outlook.com>
 <20211029194253.GA345237@bhelgaas>
In-Reply-To: <20211029194253.GA345237@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=ambarella.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03d94325-4891-4e6f-c556-08d99dc02c04
x-ms-traffictypediagnostic: CH2PR19MB4087:
x-microsoft-antispam-prvs: <CH2PR19MB40876DB6E024DF7C76D00616A08B9@CH2PR19MB4087.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m8P1tnSzjmcGP/JTWgxaPmUqx353sH8x/pc0YJJjJ3/LR/fDLlYu6oKyH01e4q5gwaL67foJsAXsE3dOZP4fQ2DFNmlTVupBwNECe034iA1nNvt3AUREpI+OgdkP0JcdC6RsQGnjNERPFp1g6ZDUWJDqPmoR6GKzBEoOxkw+Bqi6tt7OuthsQf7aHKQ6IjVKliaZj1IDEQjC1I2vPwnmHRkiAMT42Ne6lt4eiU0oRR94wsxyaWJDmxdwZJPUgdhaokLETBHQxf0W10j6REfOAv1+y4sSgPCZ+0HD2+JmwXTD5NYQ+xQ3ZRn71gM8a6n0SuV/FwbvlQ6yAxuCqPJFgya+DZbn0+hg0Cu6LHSi0whXjHXRamthNvt20b6gDRPS3EdmoJiT3MmFh8xSs0o8O047avMFSL6r22PfgDIb7l2eWhaRcb7LNhIQNWgDoRBa5El9WKtuuh5bYekxoRmMhe0qimjVCvSla/vnKoR7oEDUGu+zP2A4g4cYhTMAfEGwQeV03Z2F7jE1r1wMmHlPw+AMAU0YTo6QVJL2aysrAL0WKqdtE/CODeXeB/Ks7Wah6/ymKM1Rro38WA5iYssrgy7LiIV4Q9uj1/Yk568MRpI5a/BXauRQhIMiVEn070CWQyd9ISsglfMOptdpVv3Grqq+bStCNV4WqPwbxo2V3dTRXG+FbEETrYY6BcN4u1S7/O/6vqNCrXd92DlZJmrT0MkQZepS2JiJmAJOqBK/a4r7pBEg1ERSKgJ9eDOyutSZeY6ZWiVDCRIPZGLjJG6mRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB4024.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016002)(7696005)(53546011)(66476007)(86362001)(6916009)(6506007)(64756008)(88996005)(66446008)(66556008)(30864003)(508600001)(7416002)(8676002)(316002)(33656002)(966005)(83380400001)(122000001)(52536014)(4326008)(186003)(38100700002)(9686003)(8936002)(5660300002)(2906002)(54906003)(71200400001)(66946007)(26005)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HJuGVKmkk97ru+tb/7RXCjXIvKw7ci4i8WvnM7CryrylkMdpFR1XSZ899afS?=
 =?us-ascii?Q?npEi5IqaIjCfXIbH+GeWTa1LOyfCJmKRVOgbO3kb25c9MI3XoVgUClLdXNhi?=
 =?us-ascii?Q?EJepWXOL7W8V9CvEZROfes6y1GKZpzcgGTteXkgMCbCdiK0IBYh5QJaiK2T6?=
 =?us-ascii?Q?tQJOxKKc/sopJhd4U/JyTMHdEygdzxB0Fk8Eo2jWAUSPEcC0kxj9VR/Z+RpC?=
 =?us-ascii?Q?085PJX/0eWdQhBevOlilNCGc7fsmgIYY4DoCeGeq+52DqLjZUPEPATahWV0L?=
 =?us-ascii?Q?BBkaKgqi754kg8n+3MEhKs6QwiEIrdf/M/vpTLMWboyJoEHFFy4ymuTogDhd?=
 =?us-ascii?Q?ptwbDAXEau0+RHDZYIcUhi3+Ji6/9WfoSry6xdldMo40DSCXiJbukz2hebrL?=
 =?us-ascii?Q?Q3jAsbEr/llAG+85Hb2dCL4QcydFLXmZY3mKLAGhToW2lt0ZkSkV7W4q0LYi?=
 =?us-ascii?Q?w5pYcYY0RnRMtvPZ3QCkP42v6Q7pP19WU0I9osmn4BNEmkrfKbYn5u3Gx30v?=
 =?us-ascii?Q?yGxkN6NksEMLWm6LMNcjNwnO/PlZlR75GD5hHeDDG6zK0FOtie/IqKT0ytps?=
 =?us-ascii?Q?zyZfbVJQsU5JbMKS6Spk9Ssq50ietGLHcFHaAdMCWLTtURvHmgkwKl73yJz5?=
 =?us-ascii?Q?ScxlDvGt+F7j45RLeiSr4+TqiQqAq6pL2EzYJks7bK+C9QZAzO5XEIL4jc4L?=
 =?us-ascii?Q?oLpfJUJWz3x9LizL+pSOo76h7VTsnreHXhBDOT3w3kfGdtZAvVZJvUc+ei3d?=
 =?us-ascii?Q?AMnFCdVNO7YJAnotLfnqQqaydKwknZSxoZtDIPgPnYNRJN3Ilz22ccK2OaPj?=
 =?us-ascii?Q?2PiOoEI3lSgGVJKHgQOIWFch7Ufy4HeabxpL2q84boUZjEhK7JxxDKOYg1AU?=
 =?us-ascii?Q?U8m46FIWccBS0l+ZUpINDw6FGcPGfgFzg24K635ynvYleFjmQvYBmKdh6A57?=
 =?us-ascii?Q?5Tl5VFCOZXbaEQto3zeCjnTLB4RcU2jLNlmB+C33lQJh9qP7QIa1EbCXj0C2?=
 =?us-ascii?Q?1HeWnC0jL2tzew3Ig2KsD1KYbn2odxqIPLqooY5IOv6xgd6CXoPKb7gggSLO?=
 =?us-ascii?Q?EpiZ1yA6rgKlJh3u7DXSFtu39lN0DQdzh0HfC0kHFjt5fK0/l5Uqjxx2dklR?=
 =?us-ascii?Q?Ugo6eNOs+T9gbBRvud+0SBKLW5ufNw3DbDJUq0bzHaA/qaV/EfvcQmCSHeRb?=
 =?us-ascii?Q?4gQYrjyhZV35SyHCPCcOEfr8+qylwn1OWS8RxUXluGHautqESkns0U4j2mVt?=
 =?us-ascii?Q?hRn7rDfpxCjB9YaiZzl78byEazId2eu7Go+HlPCJJr3bVHgAr5Me/vZi96Kj?=
 =?us-ascii?Q?aXEFZzDbIKXfDqT00RG7gq+5NbvzhbUhh9xcKpAeJtLrvQWlFFc0+PT4rl/L?=
 =?us-ascii?Q?ty/wZ5prfkXhRPGPnLcXERhssyB+tCYwq0lIaAVIOxl29dGfQyF6LMBaZgs5?=
 =?us-ascii?Q?XuQEuBWI85O33qWiOC+x1XKsqqlRV6PqLEtsRUz0T0kZ3sUuGkYok0TjhoqL?=
 =?us-ascii?Q?aE0odR4eqr8fu5u2ay/Cp4VX3PC+im9JBjVVX3ZjdIztOlI5y4pMp2jDr37M?=
 =?us-ascii?Q?hvT+zomYZZrkfqUynrpGlMpdimn/Mp9moWXVBMV5yiQTpv25t2y0Vxo/7AnX?=
 =?us-ascii?Q?GmJNTUmF5Ax7Mszsd63RrfA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB4024.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d94325-4891-4e6f-c556-08d99dc02c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 05:18:14.5804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8I97VaPVtl/29auTGtAHEoVDjRnVzeSRvENX704PJyWMD7oBKljuhvmGf42NU14f6uNtznraOHgum2ojjE87g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4087
X-Proofpoint-GUID: 4dsmBpy9hCG_DhwPwgfMgIGxu9KFP5e-
X-Proofpoint-ORIG-GUID: 4dsmBpy9hCG_DhwPwgfMgIGxu9KFP5e-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_01,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020030
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Saturday, October 30, 2021 3:43 AM
> To: Li Chen
> Cc: Keith Busch; linux-pci@vger.kernel.org; Lorenzo Pieralisi; Rob Herrin=
g;
> kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom Joseph; Je=
ns
> Axboe; Christoph Hellwig; Sagi Grimberg; linux-nvme@lists.infradead.org
> Subject: Re: [EXT] Re: nvme may get timeout from dd when using different =
non-
> prefetch mmio outbound/ranges
>=20
> On Fri, Oct 29, 2021 at 10:52:37AM +0000, Li Chen wrote:
> > > -----Original Message-----
> > > From: Keith Busch [mailto:kbusch@kernel.org]
> > > Sent: Tuesday, October 26, 2021 12:16 PM
> > > To: Li Chen
> > > Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; Lorenzo Pieralisi; Rob =
Herring;
> > > kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom Joseph;
> Jens
> > > Axboe; Christoph Hellwig; Sagi Grimberg; linux-nvme@lists.infradead.o=
rg
> > > Subject: Re: [EXT] Re: nvme may get timeout from dd when using differ=
ent
> non-
> > > prefetch mmio outbound/ranges
> > >
> > > On Tue, Oct 26, 2021 at 03:40:54AM +0000, Li Chen wrote:
> > > > My nvme is " 05:00.0 Non-Volatile memory controller: Samsung Electr=
onics
> Co
> > > Ltd NVMe SSD Controller 980". From its datasheet,
> > > https://urldefense.com/v3/__https://s3.ap-northeast-
> > >
> 2.amazonaws.com/global.semi.static/Samsung_NVMe_SSD_980_Data_Sheet_R
> > >
> ev.1.1.pdf__;!!PeEy7nZLVv0!3MU3LdTWuzON9JMUkq29zwJM4d7g7wKtkiZszTu-
> > > PVepWchI_uLHpQGgdR_LEZM$ , it says nothing about CMB/SQEs, so I'm not
> sure.
> > > Is there other ways/tools(like nvme-cli) to query?
> > >
> > > The driver will export a sysfs property for it if it is supported:
> > >
> > >   # cat /sys/class/nvme/nvme0/cmb
> > >
> > > If the file doesn't exist, then /dev/nvme0 doesn't have the capabilit=
y.
> > >
> > > > > > I don't know how to interpret "ranges".  Can you supply the dme=
sg and
> > > > > > "lspci -vvs 0000:05:00.0" output both ways, e.g.,
> > > > > >
> > > > > >   pci_bus 0000:00: root bus resource [mem 0x7f800000-0xefffffff
> window]
> > > > > >   pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff
> window]
> > > > > >   pci 0000:05:00.0: [vvvv:dddd] type 00 class 0x...
> > > > > >   pci 0000:05:00.0: reg 0x10: [mem 0x.....000-0x.....fff ...]
> > > > > >
> > > > > > > Question:
> > > > > > > 1.  Why dd can cause nvme timeout? Is there more debug ways?
> > > > >
> > > > > That means the nvme controller didn't provide a response to a pos=
ted
> > > > > command within the driver's latency tolerance.
> > > >
> > > > FYI, with the help of pci bridger's vendor, they find something
> > > > interesting:
> > > "From catc log, I saw some memory read pkts sent from SSD card,
> > > but its memory range is within the memory range of switch down
> > > port. So, switch down port will replay UR pkt. It seems not
> > > normal." and "Why SSD card send out some memory pkts which memory
> > > address is within switch down port's memory range. If so, switch
> > > will response UR pkts". I also don't understand how can this
> > > happen?
> > >
> > > I think we can safely assume you're not attempting peer-to-peer,
> > > so that behavior as described shouldn't be happening. It sounds
> > > like the memory windows may be incorrect. The dmesg may help to
> > > show if something appears wrong.
> >
> > Agree that here doesn't involve peer-to-peer DMA. After conforming
> > from switch vendor today, the two ur(unsupported request) is because
> > nvme is trying to dma read dram with bus address 80d5000 and
> > 80d5100. But the two bus addresses are located in switch's down port
> > range, so the switch down port report ur.
> >
> > In our soc, dma/bus/pci address and physical/AXI address are 1:1,
> > and DRAM space in physical memory address space is 000000.0000 -
> > 0fffff.ffff 64G, so bus address 80d5000 and 80d5100 to cpu address
> > are also 80d5000 and 80d5100, which both located inside dram space.
> >
> > Both our bootloader and romcode don't enum and configure pcie
> > devices and switches, so the switch cfg stage should be left to
> > kernel.
> >
> > Come back to the subject of this thread: " nvme may get timeout from
> > dd when using different non-prefetch mmio outbound/ranges". I found:
> >
> > 1. For <0x02000000 0x00 0x08000000 0x20 0x08000000 0x00 0x04000000>;
> > (which will timeout nvme)
> >
> > Switch(bridge of nvme)'s resource window:
> > Memory behind bridge: Memory behind bridge: 08000000-080fffff [size=3D1=
M]
> >
> > 80d5000 and 80d5100 are both inside this range.
>=20
> The PCI host bridge MMIO window is here:
>=20
>   pci_bus 0000:00: root bus resource [mem 0x2008000000-0x200bffffff] (bus
> address [0x08000000-0x0bffffff])
>   pci 0000:01:00.0: PCI bridge to [bus 02-05]
>   pci 0000:01:00.0:   bridge window [mem 0x2008000000-0x20080fffff]
>   pci 0000:02:06.0: PCI bridge to [bus 05]
>   pci 0000:02:06.0:   bridge window [mem 0x2008000000-0x20080fffff]
>   pci 0000:05:00.0: BAR 0: assigned [mem 0x2008000000-0x2008003fff 64bit]
>=20
> So bus address [0x08000000-0x0bffffff] is the area used for PCI BARs.
> If the NVMe device is generating DMA transactions to 0x080d5000, which
> is inside that range, those will be interpreted as peer-to-peer
> transactions.  But obviously that's not intended and there's no device
> at 0x080d5000 anyway.
>=20
> My guess is the nvme driver got 0x080d5000 from the DMA API, e.g.,
> dma_map_bvec() or dma_map_sg_attrs(), so maybe there's something wrong
> in how that's set up.  Is there an IOMMU?  There should be arch code
> that knows what RAM is available for DMA buffers, maybe based on the
> DT.  I'm not really familiar with how all that would be arranged, but
> the complete dmesg log and complete DT might have a clue.  Can you
> post those somewhere?

After some printk, I found nvme_pci_setup_prps get some dma addresses insid=
e switch's memory window from sg, but I don't where the sg is from(see comm=
ents in following source codes):

static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
		struct request *req, struct nvme_rw_command *cmnd)
{
	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
	struct dma_pool *pool;
	int length =3D blk_rq_payload_bytes(req);
	struct scatterlist *sg =3D iod->sg;
	int dma_len =3D sg_dma_len(sg);
	u64 dma_addr =3D sg_dma_address(sg);
                ......
	for (;;) {
		if (i =3D=3D NVME_CTRL_PAGE_SIZE >> 3) {
			__le64 *old_prp_list =3D prp_list;
			prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
			printk("lchen %s %d dma pool %llx", __func__, __LINE__, prp_dma);
			if (!prp_list)
				goto free_prps;
			list[iod->npages++] =3D prp_list;
			prp_list[0] =3D old_prp_list[i - 1];
			old_prp_list[i - 1] =3D cpu_to_le64(prp_dma);
			i =3D 1;
		}
		prp_list[i++] =3D cpu_to_le64(dma_addr);
		dma_len -=3D NVME_CTRL_PAGE_SIZE;
		dma_addr +=3D NVME_CTRL_PAGE_SIZE;
		length -=3D NVME_CTRL_PAGE_SIZE;
		if (length <=3D 0)
			break;
		if (dma_len > 0)
			continue;
		if (unlikely(dma_len < 0))
			goto bad_sgl;
		sg =3D sg_next(sg);
		dma_addr =3D sg_dma_address(sg);
		dma_len =3D sg_dma_len(sg);


		// XXX: Here get the following output, the region is inside bridge's wind=
ow 08000000-080fffff [size=3D1M]
		/*

# dmesg | grep " 80" | grep -v "  80"
[    0.000476] Console: colour dummy device 80x25
[   79.331766] lchen dma nvme_pci_setup_prps 708 addr 80ba000, end addr 80b=
c000
[   79.815469] lchen dma nvme_pci_setup_prps 708 addr 8088000, end addr 809=
0000
[  111.562129] lchen dma nvme_pci_setup_prps 708 addr 8088000, end addr 809=
0000
[  111.873690] lchen dma nvme_pci_setup_prps 708 addr 80ba000, end addr 80b=
c000
			 * * */
		printk("lchen dma %s %d addr %llx, end addr %llx", __func__, __LINE__, dm=
a_addr, dma_addr + dma_len);
	}
done:
	cmnd->dptr.prp1 =3D cpu_to_le64(sg_dma_address(iod->sg));
	cmnd->dptr.prp2 =3D cpu_to_le64(iod->first_dma);
	return BLK_STS_OK;
free_prps:
	nvme_free_prps(dev, req);
	return BLK_STS_RESOURCE;
bad_sgl:
	WARN(DO_ONCE(nvme_print_sgl, iod->sg, iod->nents),
			"Invalid SGL for payload:%d nents:%d\n",
			blk_rq_payload_bytes(req), iod->nents);
	return BLK_STS_IOERR;
}

Backtrace of this function:
# entries-in-buffer/entries-written: 1574/1574   #P:2
#
#                                _-----=3D> irqs-off
#                               / _----=3D> need-resched
#                              | / _---=3D> hardirq/softirq
#                              || / _--=3D> preempt-depth
#                              ||| /     delay
#           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
#              | |         |   ||||      |         |
    kworker/u4:0-7       [000] ...1    40.095494: nvme_queue_rq <-blk_mq_di=
spatch_rq_list
    kworker/u4:0-7       [000] ...1    40.095503: <stack trace>
 =3D> nvme_queue_rq
 =3D> blk_mq_dispatch_rq_list
 =3D> __blk_mq_do_dispatch_sched
 =3D> __blk_mq_sched_dispatch_requests
 =3D> blk_mq_sched_dispatch_requests
 =3D> __blk_mq_run_hw_queue
 =3D> __blk_mq_delay_run_hw_queue
 =3D> blk_mq_run_hw_queue
 =3D> blk_mq_sched_insert_requests
 =3D> blk_mq_flush_plug_list
 =3D> blk_flush_plug_list
 =3D> blk_mq_submit_bio
 =3D> __submit_bio_noacct_mq
 =3D> submit_bio_noacct
 =3D> submit_bio
 =3D> submit_bh_wbc.constprop.0
 =3D> __block_write_full_page
 =3D> block_write_full_page
 =3D> blkdev_writepage
 =3D> __writepage
 =3D> write_cache_pages
 =3D> generic_writepages
 =3D> blkdev_writepages
 =3D> do_writepages
 =3D> __writeback_single_inode
 =3D> writeback_sb_inodes
 =3D> __writeback_inodes_wb
 =3D> wb_writeback
 =3D> wb_do_writeback
 =3D> wb_workfn
 =3D> process_one_work
 =3D> worker_thread
 =3D> kthread
 =3D> ret_from_fork


We don't have IOMMU and just have 1:1 mapping dma outbound.=20


Here is the whole dmesg output(without my debug log): https://paste.debian.=
net/1217721/
Here is our dtsi: https://paste.debian.net/1217723/
>=20
> > 2. For <0x02000000 0x00 0x00400000 0x20 0x00400000 0x00 0x08000000>;
> > (which make nvme not timeout)
> >
> > Switch(bridge of nvme)'s resource window:
> > Memory behind bridge: Memory behind bridge: 00400000-004fffff [size=3D1=
M]
> >
> > 80d5000 and 80d5100 are not inside this range, so if nvme tries to
> > read 80d5000 and 80d5100 , ur won't happen.
> >
> > From /proc/iomen:
> > # cat /proc/iomem
> > 01200000-ffffffff : System RAM
> >   01280000-022affff : Kernel code
> >   022b0000-0295ffff : reserved
> >   02960000-040cffff : Kernel data
> >   05280000-0528ffff : reserved
> >   41cc0000-422c0fff : reserved
> >   422c1000-4232afff : reserved
> >   4232d000-667bbfff : reserved
> >   667bc000-667bcfff : reserved
> >   667bd000-667c0fff : reserved
> >   667c1000-ffffffff : reserved
> > 2000000000-2000000fff : cfg
> >
> > No one uses 0000000-1200000, so " Memory behind bridge: Memory
> > behind bridge: 00400000-004fffff [size=3D1M]" will never have any
> > problem(because 0x1200000 > 0x004fffff).
> >
> > Above answers the question in Subject, one question left: what's the
> > right way to resolve this problem? Use ranges property to configure
> > switch memory window indirectly(just what I did)? Or something else?
> >
> > I don't think changing range property is the right way: If my PCIe
> > topology becomes more complex and have more endpoints or switches,
> > maybe I have to reserve more MMIO through range property(please
> > correct me if I'm wrong), the end of switch's memory window may be
> > larger than 0x01200000. In case getting ur again,  I must reserve
> > more physical memory address for them(like change kernel start
> > address 0x01200000 to 0x02000000), which will make my visible dram
> > smaller(I have verified it with "free -m"), it is not acceptable.
>=20
> Right, I don't think changing the PCI ranges property is the right
> answer.  I think it's just a coincidence that moving the host bridge
> MMIO aperture happens to move it out of the way of the DMA to
> 0x080d5000.
>=20
> As far as I can tell, the PCI core and the nvme driver are doing the
> right things here, and the problem is something behind the DMA API.
>=20
> I think there should be something that removes the MMIO aperture bus
> addresses, i.e., 0x08000000-0x0bffffff in the timeout case, from the
> pool of memory available for DMA buffers.
>=20
> The MMIO aperture bus addresses in the non-timeout case,
> 0x00400000-0x083fffff, are not included in the 0x01200000-0xffffffff
> System RAM area, which would explain why a DMA buffer would never
> overlap with it.
>=20
> Bjorn

Regards,
Li

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
