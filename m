Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6801E681578
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jan 2023 16:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbjA3Pqt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 10:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbjA3PqZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 10:46:25 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A46F3FF1F
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2023 07:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675093570; x=1706629570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J+svhZAY0dm7i6p2b8BvENNQYj5+Tj9sxnTu2Tx8YVU=;
  b=DgEYTIaV+XC2O4QFkPdc6UI0Q/DO1Gt+9IvqI7dXw/GPoU8O2Ai4CkvX
   24bzeFs2Et2bRwjmiQTwBPZCXO5r/AVFSxssDFBNeUA8qqyC+nSd6Wjr+
   MlRddRDlwsn9WIf8tSNBZU99W7MM5ZldnSYzMhdnh1B6asb53cz25bBAB
   SYAUZtfdlc+0Qb708oFCUsj5Zi2CRuAaFJ4aLVSB7QkP19aq9WMUHSeuR
   xudrQ8X5ItkOMSJaOeXCJxZ5LW0YuyFCgzx8Rrcn8E7EKLre3kcRS4rTP
   Wcdq4E7dx5tHArdsxIi07ainhyEIKnuzVfUa5XOWlqojxmN+vZHuQsC3J
   w==;
X-IronPort-AV: E=Sophos;i="5.97,258,1669046400"; 
   d="scan'208";a="334055321"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2023 23:46:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKJsBxkQ0V0LAZTrKFD4i0ZLLI/uVNFZxaTmGPpoA/id9BNG2Zeeo4sK05jx2VlPwrvLZeuyXh/nH+1gaxIMV9lPZMli77kP4HWtgv748LlO2xi77LPqjFewzewnoo0nFLuDfQiMLGewtJXUNAx3yKGHevpckPfG1+dBEAlxWVTUfCkHvGlSmrCs5OSJ6FczBCcK2LWqXGR6I0084/TkJWwGl/ogCmoo4h/n5Lwuo75qC7rvqf/8S9c9ZSBWHdqOr9hF5Z0GeM1W0oWFaFw4362zYxceiDGgF9wjeKHklf6u3it5Mltjl7BeHvyEmaY0UsWM69uD1EOMdQgoY2nVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZt9j8tw/QbarjW7I4biBIzieNtbqfQ8qvOtv4gmBWU=;
 b=gGfkyck1vRZfPgy1QH/oulxVzWl4J4Kwvny8y3sOqO7LI3HJu08PkbhkBGbik8rRfDfwpc5ck1Xo+b3HEMOaaJonDiKB+H2oO0FK7OZ5GUA6CO7ARQiaPvTRvpr8gqQZ4VdJzQP87JtDT66b8uUVbw6w0ivyzClPCX9qkkMLtWvIVka1i3B5Mwf4TKz+0a1kNFfYkvw+vJNjctcLQmfKB9P/qFtN+nQ0xg+JeUobNqKgm8cABXzcoS7H0wLageymxEFGGcnfTZjloutssJKao8VLHl7KULSlv8CNpuER/WRSKwXbxVfognq/Sm4xx5X1SQIiTKr8djnrKz/SE/fsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZt9j8tw/QbarjW7I4biBIzieNtbqfQ8qvOtv4gmBWU=;
 b=MGaP5gXSywti+bwDx4UkA24xnyX5BO0bACzrQUDi8y0mOM1EGvDxOTgZxSKGH7RNUVMDeIRy80OD5/lavmA1PQsnVDiAwzihjYlOJZPZfKDpQNkqVAUW/CAXzNyHMubbL/cn1qExJ1WQ57A16xJpZ0i2HCkkZJjqikGrmYtdQmE=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM8PR04MB7911.namprd04.prod.outlook.com (2603:10b6:8:3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Mon, 30 Jan 2023 15:46:06 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a%7]) with mapi id 15.20.6043.023; Mon, 30 Jan 2023
 15:46:06 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] pci: Avoid FLR for AMD FCH AHCI adapters
Thread-Topic: [PATCH] pci: Avoid FLR for AMD FCH AHCI adapters
Thread-Index: AQHZMrlvb9tc/cweD02gtKkaj6nZ/663F4SAgAAG9YA=
Date:   Mon, 30 Jan 2023 15:46:06 +0000
Message-ID: <Y9fmPef6PyBfcqt1@x1-carbon>
References: <20230128013951.523247-1-damien.lemoal@opensource.wdc.com>
 <20230130152111.GA1673431@bhelgaas>
In-Reply-To: <20230130152111.GA1673431@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM8PR04MB7911:EE_
x-ms-office365-filtering-correlation-id: 0944779c-c4e7-4939-fbd8-08db02d91981
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MsbHuxqxyEAzhoaOMpFcopzl7qyml7Gu+uNtn3krVvu8WGHItmvnmwSqF/lAAzKChFQR1CFDB0VxA7dPg7PQkZ/xvtNg3FfGrX3gMiNGoKe34c/OpprpDbi6Hf+LR9TW37pJq3BTXrrWLkTqRSRc2TOJE4+/2lnrvQmk7Mk8V+yEpRmsokRdTxre2aoWFzj+Zwp/MLBhaIRLcwgGgmIDxNrM6LUifTKLZTN0UxUXPMroGSS7bKYfS+IScmU1tzLIoP7pFCO1HoogTzngwdqz4leubhTzHp5IpykcD6dDtdrLpRZpLUbD4Z0svlMVGxHIxrFwT1yUubwn9HoP/q3XRVounhXgm2y24m5PBaIBKtde96tf/n+8IdYCwm/wzIV2WYLLUCCLw27keqBSYpMPb7qu+NPKxzNpI9YPgSRHRSaw9E4DtyUvANK43nC5XbWfJEMwXxivemGrvRxF1DaRQnr630F6UDcORZYI/711OBHlJg8yn+H9TAaLoCbL6YvjptVo8WOKV3g+Riev5iPf3NYCpRQPosASi2jsEYP3J+w3avl/TK6b9iE1eTFh/9Rqb9mp6ElMZ/PDE/lnCBLYgaXYQZqhtzOZVYekmGzU7wSRLrOVusVaurlCmB75XaNVEJ+ygRowmFTVaQLnQn0iVUSrZ+StuMLpBuNOTOT8rLR6fm8wVRBxfL9xgKOOLPl2k/Hbg694To6QCpfylGRzHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199018)(8936002)(41300700001)(5660300002)(66556008)(66446008)(83380400001)(122000001)(38100700002)(86362001)(82960400001)(38070700005)(91956017)(64756008)(6486002)(66476007)(71200400001)(8676002)(316002)(66946007)(6916009)(76116006)(4326008)(54906003)(478600001)(186003)(6512007)(26005)(9686003)(6506007)(33716001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H/znc0hZ25Tk2CrEb/5kU5Aw40SNVP059bB1pzWUktc7gpKOCx97m/PELxes?=
 =?us-ascii?Q?CXqHjymwaWHSwkFgAlAqBlr5QozQ4Bl7rrQDHGtERsH37lbqwQIthgdWVh5R?=
 =?us-ascii?Q?MoAs5KqerK5Mr3hafuj92FwhIszV+1HpcdV4WeEBNHJpK8V3kpZC2VP7RSOY?=
 =?us-ascii?Q?1RdzXjGdTyD3VjpmF+12wlPnJV+RZjDtlKxUaSXrS0zbVK+nzhpxZmPdKH6S?=
 =?us-ascii?Q?CoqATXzPUZSDeJwv30RSiFSUmdzD6apSmTyH/refXHEcIcvuG1ocpadN5Y3t?=
 =?us-ascii?Q?nD+sFyGJGCVgTCdqnyXpK7WGd/9BOkgyH42CkOkM+iRUKNKQZNfZ1Xd+W6tU?=
 =?us-ascii?Q?bpfa96xrMJvNRASmY8p2rxkUhJQRD6DGlxSKpJdxMUO4ejcv/I4oxUkRspu3?=
 =?us-ascii?Q?vXIPDOGt/TlRBydMoZDUulGpNYSL1nUhtYURAF1C+DhD5J2CT8JVrqPci9Ug?=
 =?us-ascii?Q?8DKCWlddwmhNPzG6lLYuMvHBvnvWyBTgzlhbdPi1jvMO1p6EPorU4ndXtJ+L?=
 =?us-ascii?Q?5GhzznCezDDgVfhPFQmcrHNiVOoxFCIkLhQByKleAwQ/NqvDOpTrJfv44Wwh?=
 =?us-ascii?Q?omejwym5jGMlTso0g3tpdr/9ENNfvaFvIJLz43oCDbMKB7HaD3XDTq9P8RgP?=
 =?us-ascii?Q?Xj/LVpIFGRQL5ZcMadNKl12gc53mWLBnYZTSxzyLHaYimkWO9sdzBtk6XzeJ?=
 =?us-ascii?Q?PoSdPsujHzkBS2bOs8JEcyFu2MbYMu5lSRyAbtGczPUnr8l9xRr2t5ttfOpz?=
 =?us-ascii?Q?+GNH4NUKwEsdsS712npPxY4tV+j2ShO+MKjG23WqH9uFehhKUC7nz0j6x/iM?=
 =?us-ascii?Q?OdUgbXgLuP5UrVp/Q4qU7tfzZhja51j9OeSewtp3HzQ78dCM6cP086rUtCYR?=
 =?us-ascii?Q?FAepdqx9YIKEFjAgjMYksWmz1JJVZAAMxmSN4pxiw/rjJRoiM761QxwL1lcV?=
 =?us-ascii?Q?TmLDYF7qsgcusSJ0As/VulNavIjL2ZTpdhus6Kt3h6OIWNwv8TXdbUfkc3a1?=
 =?us-ascii?Q?qp+h+xHrvY5qfq2X5T6HGTfnLB0dgU5oQT5pHw26W/rcitJUu095FKK2J/NO?=
 =?us-ascii?Q?umimXht5wVb8QuLjmgwAbPBEUg5c/n7i60/yyIXYEEj8KyvHgfR3MDjHsgUu?=
 =?us-ascii?Q?fKT7WRye8s9XIWockWbMoYoDEtdIRfZjJFQf6bbP3POb3FwBOLTVuWwHmVes?=
 =?us-ascii?Q?k+eRIc2VSgcQLAEPW1xw641dsxAF/k0VDqWSCp7F7/8d1GzSCON0qsd2iupe?=
 =?us-ascii?Q?/5HwhQWcWeGts/pM5blSxklE1JU1xJIm2yrB9Z9RpZXZCgO4eJoxID+Fbph7?=
 =?us-ascii?Q?Z/NAOse45ZA6eGNRG7MzCbRl4BM2DmODjlU3QHz6IPJI5ApYH8NHW7TUkF9H?=
 =?us-ascii?Q?eG0GNovTELeGjGS8VQQ+2T1g7EyajECRkG6Tlkg9QtlUo7pbAHE3SyQdHeGT?=
 =?us-ascii?Q?EgI+hrpwgvRyYyy/k/78lOWDQsTbxjvaRLxCgMdjaBCRQ/FOYj4fcyTlQPJf?=
 =?us-ascii?Q?KsOrDFIGNqB59nl3tclYXd1wkkjhPcsykYT08tmP49pB0i7C8w96r5gDOVia?=
 =?us-ascii?Q?xqyFSGjRg6Ph5edlxVLvHe4LkNxn3VyHfiYX8OMgeSVMHok9BypsKLtArQK+?=
 =?us-ascii?Q?Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C29B1BC64E5F6A4D980BEA78F5F378A1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zACP4n/ZbgDdPOkIxhXjqgOtHxlEBd1owg3Idbu7Iy4YtU0Ic0gRqo/4tRSYunigDkOmlT7uMmSNC036YuYV8FhfPDnDBgJVFcMjkZGbev3VPeV5qKJQkD/xFg/ck+R3n/vKv3Dd5htX+4nYDHr50o/uE9qTj7SNO7wUARn/GOQDXsi9VrOPY5Ziqp6utnqi6c5MUd1B8wvfjP+RJKlAkbZ/vP1VNI5Cfh5v3rcJna8PeBc3KiUkBika2dlWnp37xamIKlkFeuw0cYWBxs6oP5kMOLa10lg8tH11AA0DCTuh9AP2yqBYTn2KcTzElib7J6jF9wsuBWqivafxMjaSr//gKxVrKzgKHrVJU/YU6V3p53Byv4PbTJycATUF8v0s1V3IUn5wBUXaFSdRvFB487R7r1nu/RDlWWlviW167XiYG8KCNGs3a5ZPMoEifiE6dYCgEKi7tgUVUhtQhHjvtHa7P4sv6wx4z3dSLDlXO1MW274P23b5hbPgSNe7+ak6RcoJNJhZI0NzEkKpFLF2Jn8rwmrJE+JoNkkPtftirh6f2zIG3TxP2lkCergAPa87edpx+srfF7hhWfvcAB1QdlNMfRd9thRw6xXtFE3hACsx2scIDKAqZd9frPvvMCYB/HXaBAudc91j++RwGZ7QH7oy2CFwNRH+k22Xh/LjsMmDRGLHI/44r7M7arB39mrfS08u1A5+3KfXb9aCTWzPOkQXT5hwsTTnJquflFREPdX3gI+Ncd2skU8Cx8iCf/dx+ic+LypEY4bys/I0AYJGiMtYHZxH4W6ev3GGNXUPje+3TVWFGlgPCXC6JfRIzIGN02ELt7Q3GmFF7H7+VSigseRM0moxoD1hiCZcDCrl8Hg=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0944779c-c4e7-4939-fbd8-08db02d91981
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 15:46:06.1539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ZXTiGJdkKeE8NmtqAzIm+SSCnLXC82pIDtGxQ/HPWIZFwEkpk4UvCme3DftsmZK2wcJjfbm/cFL/yl3a39Jdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7911
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 30, 2023 at 09:21:11AM -0600, Bjorn Helgaas wrote:
> [+cc Mario, Shyam, Brijesh]
>=20
> On Sat, Jan 28, 2023 at 10:39:51AM +0900, Damien Le Moal wrote:
> > PCI passthrough to VMs does not work with AMD FCH AHCI adapters: the
> > guest OS fails to correctly probe devices attached to the controller du=
e
> > to FIS communication failures.=20
>=20
> What does a FIS communication failure look like?  Can we include a
> line or two of dmesg output here to help users find this fix?

Hello Bjorn,

It looks like this:

[   22.402368] ata4: softreset failed (1st FIS failed)
[   32.417855] ata4: softreset failed (1st FIS failed)
[   67.441641] ata4: softreset failed (1st FIS failed)
[   67.453227] ata4: limiting SATA link speed to 3.0 Gbps
[   72.661738] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   78.121263] ata4.00: qc timeout after 5000 msecs (cmd 0xec)
[   78.134413] ata4.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)

Basically, we can read and write MMIO registers in the AHCI HBA,
but the communication between the AHCI HBA and the ATA device does
not work properly.

(Because the AHCI HBA did not get reset when binding/unbinding the
device.)

The exact same kernel, using the same generic AHCI driver within the VM,
can communicate perfectly fine when using e.g. an Intel AHCI HBA.

(With both the AMD and Intel AHCI HBAs being bound to the vfio-pci driver
in the host.)

We can send a v2 with the above dmesg output.


Kind regards,
Niklas

>=20
> AMD folks: Can you confirm/deny that this is a hardware erratum in
> this device?  Do you know of any other devices that need a similar
> workaround?
>=20
> > Forcing the "bus" reset method before
> > unbinding & binding the adapter to the vfio-pci driver solves this
> > issue. I.e.:
> >=20
> > echo "bus" > /sys/bus/pci/devices/<ID>/reset_method
> >=20
> > gives a working guest OS, thus indicating that the default flr reset
> > method is defective, resulting in the adapter not being reset correctly=
.
> >=20
> > This patch applies the no_flr quirk to AMD FCH AHCI devices to
> > permanently solve this issue.
> >=20
> > Reported-by: Niklas Cassel <niklas.cassel@wdc.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > ---
> >  drivers/pci/quirks.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 285acc4aaccc..20ac67d59034 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5340,6 +5340,7 @@ static void quirk_no_flr(struct pci_dev *dev)
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
> > =20
> > --=20
> > 2.39.1
> > =
