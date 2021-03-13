Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DC3339B12
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 03:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhCMCUr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 21:20:47 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:12940 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231597AbhCMCUf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 21:20:35 -0500
X-Greylist: delayed 1078 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Mar 2021 21:20:35 EST
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12D1vTeq030991;
        Fri, 12 Mar 2021 18:02:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=whC7+PaZ83vQHwkXzPNvDeG3+D+4ZaiXjBqHPyGX8v0=;
 b=VFzpe6ZC58Wb8WcTaO5ucqkUKVeqd7l9yY5EkJk1Tj8jthvBNraDrx2d8oiU38z+qPqi
 TpzRAF7+80ZF4yuqYBT7nZsrfy94p984LobZssvKJBWLNNkb/Cgo0U/4E+4W+wUpYL9k
 1CouZHUpFUvuQQiDwHj16TryNWFeZMxBC689lxCIbFIL1fay45/U/CeZfgq3v9tYIixp
 GujfOdsgQj+aiOgcHKwxnxIHtTwm56JL04kqbsyeqyvZw2jOxF6b8mF7GCrJPuzoPAmO
 xywIDdyDmKGMxlqBonhaHgkypGP8golbmNmbjX1yadH2T3deOdG8cJeoKJL8tXntMZdp mA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-002c1b01.pphosted.com with ESMTP id 3749pnr14t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Mar 2021 18:02:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0gz5Ef9S1lEcS7gi/7xtkhc+2FoH+XOeNm8Dl/1lZ/srLlK9U2KB3C/peWPck0A2V2ic0FDn7iJUnOAbtObFyvecZt03iOvd08J74VZU/nNbQP0sNFT5+28O02iwxR0PPfy8PcEKJKUUBvaDgYDjMzQoYbGyObjbJRq66Jyp4owdXvJX3BGxCkDagb6HMKQR0w80pn8n1jWHcfyrhgTiFbb4Qw6LMol1tNSMKYIZjGr5GDqSC8tPyftJ6bHg89XP6PZoS/UETba3y6VlpZ96ROeU1JF/xcdGgDu4BdSAqGf+R9EMzVfpL48VpUAOgYbFUVIfKEjnA/xpBbhaiPDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whC7+PaZ83vQHwkXzPNvDeG3+D+4ZaiXjBqHPyGX8v0=;
 b=Z8xZoaNzcZEk6CU54K+ok88Bvf+t3lgewjT8gVs/tSk1JcNs0KdBl00/HUDDabPXxhdbDS/MaP44tH9IS9cMAmtJFXQQoMakwXG90DIzWYVVJXf3nZndsxa8+Fy1i6UNt20Tb+7OQw6KaFkrzTLys40vyKH9f85fBK8tNkzBUcpVFPmubijhTC9vMF4GEylZPhCun8pOonDL1feQtzcpHfxGf5n3Y/NYOl+aVJMHwfGTF9yTbiRxVg7r8k21dj2/vMFVNGSqJ2IUyRpxQq0GUKHY8uiGUR15MNTa1bsxSBNlR7O9UEJIy8NbdDe7MvUolpM6JsigI9cTr1zSViI9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SN4PR0201MB3454.namprd02.prod.outlook.com (2603:10b6:803:4f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Sat, 13 Mar
 2021 02:02:27 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::7139:d6a4:cf94:c4b1]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::7139:d6a4:cf94:c4b1%4]) with mapi id 15.20.3912.030; Sat, 13 Mar 2021
 02:02:27 +0000
From:   Raphael Norwitz <raphael.norwitz@nutanix.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH 0/4] Expose and manage PCI device reset
Thread-Topic: [PATCH 0/4] Expose and manage PCI device reset
Thread-Index: AQHXF2ZE/LvDVo7+5kmE6xrvpc1b6KqAqgeAgAAFkACAAHtqgA==
Date:   Sat, 13 Mar 2021 02:02:27 +0000
Message-ID: <20210313020221.GA14334@raphael-debian-dev>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312112043.3f2954e3@omen.home.shazbot.org>
 <20210312184038.to3g3px6ep4xfavn@archlinux>
In-Reply-To: <20210312184038.to3g3px6ep4xfavn@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [24.165.18.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccc5fd38-3083-434b-5336-08d8e5c40d9d
x-ms-traffictypediagnostic: SN4PR0201MB3454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0201MB3454560AA53970E34A1FCF3BEA6E9@SN4PR0201MB3454.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cEps7ddIWzjA4wJtYoV+QBEr6Ay7ENWTagb/joEjtwNrnnAR+h58ksO+u3Zek+YyLb9wSwUpi3YsFxhP/qIBxR8/QcIhhEmA3IMCSRDKSVoNKTVfvDJwB7rZfffpiFt2lZ4wnYA6CULa+YFdEVG370dsVzT/2Zhx9zRQa5TRvNcEV9D9IghNDyIuyp0CCj+XFkyQUExNL+hrnX8yJ0a57sIY3s+HNP+JJxXnG6jLoZzzVrFzNDvYPfMmZCnJ1EzlCH9sQvDdr2RVEf2hit0WUfpllP9/mNGMgBEEah162agNNJKhdsrI4xv+gjHdwpLuFyVAc802jvdDYqQmN2fPHc4hlI4zBcBP0eq50VO+khR/b6seqCwbdRlx6NLlevt99qw9l/6GKCsjnyoqPE2zP980btJJnR08ypkFH2AAUaMQyl8dvcgr1Fy5SNOQ/00DEh0gl7DDCi7Ae+quGziv1Xw79dn5ZdownD7tkKCeVPAAevb3TEhNgi+92fq83RGUCjdDgC4H0f3GcJzPJNaFpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(39860400002)(136003)(396003)(366004)(346002)(316002)(91956017)(66946007)(76116006)(66556008)(6506007)(2906002)(54906003)(86362001)(1076003)(478600001)(33656002)(33716001)(5660300002)(66476007)(8676002)(9686003)(83380400001)(64756008)(4326008)(107886003)(8936002)(6512007)(44832011)(26005)(6916009)(6486002)(66446008)(71200400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?15Ooj80u/XSK7cWKtlRYxdYH1oCVZOO0ZMe/lbXWQy8c7bruv3j5XfbfCaPr?=
 =?us-ascii?Q?Qj4ecjL/Br5/dmy5KAVWvTH5NjleuRg6XdIptPxUQHBDmPLoQ05Uazg+pH/Q?=
 =?us-ascii?Q?qKHTIU+VpPiZgg3qnwJXfIeTpUg8KZ1AtCuUH9sgFs4xn0S7MylyGdx/ENTy?=
 =?us-ascii?Q?mhY1JCm/4MXkCSdCwXvSUGscdF4J5FqcuE1ThounLoduOVvxCLYyDQtHnlQs?=
 =?us-ascii?Q?AqA+XUVHsBBGc970qHcnM/c0U6lVNkdY7fZ4wFQ1tiQmCC4iYz4206X5UQ+q?=
 =?us-ascii?Q?gJZJPO7cSbBL/Qxl+9hChT7ZsPc3UIZjQmmr/uP8EIoF1K8o8gxUIx2otTTl?=
 =?us-ascii?Q?mxQ5NbNJFliVCrRgjIMWg2zSTeD9T0XXR/0WrAq3f65RqAjP9KTaDA2QBNhP?=
 =?us-ascii?Q?OuU/esQ1+eUffV70x/467mjoGPJDAcbGn2f0ZbPQxdph1/fmiKYOzfUB/hvQ?=
 =?us-ascii?Q?C9FTPYnfMbesk5NPLDN7338z8wM37e9kt+YRa/OZ/MXRZ6rCsojelsTkyFio?=
 =?us-ascii?Q?GrkoIXjTcISbNQPe4w00bMjSQPws7Jrr6NKfW+0w6yHoY6HO0P00ZoENQweA?=
 =?us-ascii?Q?3GPrWPUUKDLg9oyXGywWhpRpD6i86tE+oFL5TFQQn+INMGrWweijwUOb+cal?=
 =?us-ascii?Q?3Ihu5amTd55d5x80vnItL4DcChinuGLlwU46FQJu9Ic3JthUgBBEeRlAFb35?=
 =?us-ascii?Q?xQTa1EnFvgx5C12W1m6gJ8FIWUN1r1PdyFXwjrt+zAEYzpkCNFhE0A8qWF0K?=
 =?us-ascii?Q?1MGsjOKFMBta5HBlAqywhs99qrtzH+wJwJ3FoK8XoH3AnMbhZ+6fgQ32EU0x?=
 =?us-ascii?Q?mtoFn4x6iQDeC8eF3WEt/IisbY7l3Tl7kOCEoOifqQbKqGnWvRc2dfap7Wwu?=
 =?us-ascii?Q?eT9+BUYoh4kE+2+qZktlPV0JG4wvuMVfaDdB0Qm+7ap7W8wJ9/o7KBTkvtLg?=
 =?us-ascii?Q?v+ITv/rtRatG3g369uxAYULldr9JKa8p8zFWyWGaDjNZO8rcniayVdaR+8rm?=
 =?us-ascii?Q?F1SU66uGpgEg9fheupchQfADaeOgQE9rstXxGVUIzVXyu4D4RgzVUonA5cR6?=
 =?us-ascii?Q?IY4MOhJdo6tRMJ5opqlbuAovcNLQMzuNTkQhhKc2cAB1pi2f3Uz/pydeu5h6?=
 =?us-ascii?Q?zkH6lO7xgCYEg1ZxMvre6WvxFHRvKs9Xzjoc2H03wp6azbNHwSD/OWy2hTMS?=
 =?us-ascii?Q?eaPsPL9MxRsw0qd7pqLu+dEww16Tk+5/K95hSnw2mtttRTclqDWMpGGcp7cN?=
 =?us-ascii?Q?Sfpg4tbCpbho94Mxc9UPCWe3jrSis5OjJKxeUzcEUGI9EfilMIp1Gs2aFQUa?=
 =?us-ascii?Q?cCi+VwS41rAVDNXD3F1VQAux?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D126753639FC844DA0AAC54566DB7708@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc5fd38-3083-434b-5336-08d8e5c40d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2021 02:02:27.6230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c35R39Kmb7sANNyNQZ5K0VZ4SX2ZTLe4HvwCivZH6OVB2vpEe76JHDJK6p5xWDFW3bk0qI47ujz3g7kl5uxOMySPbBJCuAq1C1AKa6HXJ08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3454
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-12_13:2021-03-12,2021-03-12 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 13, 2021 at 12:10:38AM +0530, Amey Narkhede wrote:
> On 21/03/12 11:20AM, Alex Williamson wrote:
> > On Fri, 12 Mar 2021 23:04:48 +0530
> > ameynarkhede03@gmail.com wrote:
> >
> > > From: Amey Narkhede <ameynarkhede03@gmail.com>
> > >
> > > PCI and PCIe devices may support a number of possible reset mechanism=
s
> > > for example Function Level Reset (FLR) provided via Advanced Feature =
or
> > > PCIe capabilities, Power Management reset, bus reset, or device speci=
fic reset.
> > > Currently the PCI subsystem creates a policy prioritizing these reset=
 methods
> > > which provides neither visibility nor control to userspace.
> > >
> > > Expose the reset methods available per device to userspace, via sysfs
> > > and allow an administrative user or device owner to have ability to
> > > manage per device reset method priorities or exclusions.
> > > This feature aims to allow greater control of a device for use cases
> > > as device assignment, where specific device or platform issues may
> > > interact poorly with a given reset method, and for which device speci=
fic
> > > quirks have not been developed.
> > >
> > > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > > Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> > > Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> >
> > Reviews/Acks/Sign-off-by from others (aside from Tested/Reported-by)
> > really need to be explicit, IMO.  This is a common issue for new
> > developers, but it really needs to be more formal.  I wouldn't claim to
> > be able to speak for Raphael and interpret his comments so far as his
> > final seal of approval.
> >
> > Also in the patches, all Sign-offs/Reviews/Acks need to be above the
> > triple dash '---' line.  Anything between that line and the beginning
> > of the diff is discarded by tools.  People will often use that for
> > difference between version since it will be discarded on commit.
> > Likewise, the cover letter is not committed, so Review-by there are
> > generally not done.  I generally make my Sign-off last in the chain and
> > maintainers will generally add theirs after that.  This makes for a
> > chain where someone can read up from the bottom to see how this commit
> > entered the kernel.  Reviews, Acks, and whatnot will therefore usually
> > be collected above the author posting the patch.
> >
> > Since this is a v1 patch and it's likely there will be more revisions,
> > rather than send a v2 immediately with corrections, I'd probably just
> > reply to the cover letter retracting Raphael's Review-by for him to
> > send his own and noting that you'll fix the commit reviews formatting,
> > but will wait for a bit for further comments before sending a new
> > version.
> >
> > No big deal, nice work getting it sent out.  Thanks,
> >
> > Alex
> >
> Raphael sent me the email with
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com> that
> is why I included it.
> So basically in v2 I should reorder tags such that Sign-off will be
> the last. Did I get that right? Or am I missing something?
>

Just to confirm, I did send

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

for the latest version and I'm happy to have it on this series.

> Thanks,
> Amey
>=20
> > > Amey Narkhede (4):
> > >   PCI: Refactor pcie_flr to follow calling convention of other reset
> > >     methods
> > >   PCI: Add new bitmap for keeping track of supported reset mechanisms
> > >   PCI: Remove reset_fn field from pci_dev
> > >   PCI/sysfs: Allow userspace to query and set device reset mechanism
> > >
> > >  Documentation/ABI/testing/sysfs-bus-pci       |  15 ++
> > >  drivers/crypto/cavium/nitrox/nitrox_main.c    |   4 +-
> > >  drivers/crypto/qat/qat_common/adf_aer.c       |   2 +-
> > >  drivers/infiniband/hw/hfi1/chip.c             |   4 +-
> > >  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +-
> > >  .../ethernet/cavium/liquidio/lio_vf_main.c    |   4 +-
> > >  .../ethernet/cavium/liquidio/octeon_mailbox.c |   2 +-
> > >  drivers/net/ethernet/freescale/enetc/enetc.c  |   2 +-
> > >  .../ethernet/freescale/enetc/enetc_pci_mdio.c |   2 +-
> > >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   4 +-
> > >  drivers/pci/pci-sysfs.c                       |  68 +++++++-
> > >  drivers/pci/pci.c                             | 160 ++++++++++------=
--
> > >  drivers/pci/pci.h                             |  11 +-
> > >  drivers/pci/pcie/aer.c                        |  12 +-
> > >  drivers/pci/probe.c                           |   4 +-
> > >  drivers/pci/quirks.c                          |  17 +-
> > >  include/linux/pci.h                           |  17 +-
> > >  17 files changed, 213 insertions(+), 117 deletions(-)
> > >
> > > --
> > > 2.30.2
> > >
> >=
