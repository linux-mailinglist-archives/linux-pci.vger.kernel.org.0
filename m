Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B3C1C7799
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 19:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgEFRQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 13:16:50 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:13588 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbgEFRQt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 13:16:49 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 046HFf3A012841;
        Wed, 6 May 2020 10:16:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=dJy/LMohT4O+Fq6WtjyAILPqPwccX4Ptu8+lVfyVAPQ=;
 b=t+8NSH81Cye/ygQ9SDwnB6Ny8t35LUF15+MQEp3DmUmq1oxRh/g4MBPDX4KiXNNDbOKN
 nmDQ7TeFAeSJwPbjLgEQ+GZweKbEC72pdYJiofmI7Hh5KY0mOltyuGvaVKPGjoezy2rX
 Vh3s03e0Tuz5xhjHBN1XTDF5JmPhOLcxb3X3dvRcVeEwsIakw7cmHmExMA34IbBJuicq
 P9bUIC6xgC9g2E1Y5B26Q4XAn2yVqmb824T5oawvfjZmYM5q4ui+Thoo+V67Q9Y9uxfn
 NfJETcGOAUsjvpYArJ/RFFH3ad4IVgGtM5frlb2g7vIVMHoOi2NnTowA1XkXD/h90ZVr 9Q== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30s4exs9k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 10:16:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYZglAYql8zDy+JYdJR5Ox5k3JLPxdhvT+z3uDRw9La3nuuusnGuMUETlWpEVHBMTrEBDSiP18eLGi3e3O4XFZjE723Hbgk4JzOmIUMVAUrJaAXABW6Ap4jHyDOVlzKfwwaq5WWN9PXcIGZZgdJRZzGWQ6LlMEeJjqtOTGImQVhtDM9G7RlWNv8ib5hMTNEiC9pY6Ly80H2EpfUre1Qe0LXyOuER+2yo+fjP/A4oAmHOe79vF7MEXX2AGnRJV7ZBLi+YHJoJPGjM+bh5jbEFv8f47Qyun/UGDenz8s6lAatGISgy079oPVgc/GIqlTrBxb0gNvcVZE34IL9Zr31hHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJy/LMohT4O+Fq6WtjyAILPqPwccX4Ptu8+lVfyVAPQ=;
 b=OEcEYrJVNHsV+wQ8qxZKIvQZGUQHfM7Y54kutGHdEMZqTz0Kz2xACCSZLsEP7HAO/qVGRrUl/c7v12FMHKNOhlEzaw97hxrdtZMGvBDOk+HpVTRDI4iPhuP3CeQM+s4Voq8qlc6ppuM9fB5MXna9+Eny/oX27dnN39fbv7PVgIZn0ttboXPF3RprSe82Hxry4B1zN3O27KEqWp9qd/51oY1Pn5A3+fnCNRwG41pmceoRG5nP4yFYe5aiFOk73C1x3G5P+XysjUrf/JKKQjxnGhVA1qOuwjzkEJLhT1fxrMe74VgQrjoLJr/2kvBiA5HYLjC/ugQEHCgAtVC8fuJWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJy/LMohT4O+Fq6WtjyAILPqPwccX4Ptu8+lVfyVAPQ=;
 b=DHrGY3Gm1gLNT5J2pVSLcm6tHmI877sSV++NlMFETPVGD1tlQK5tCyKlXDINElVpQ1tlFQhWVqHsZwfnvYbq5mSk9vDQ/qRkZo2EmM5xNvXECqwyEYXnVaqpXmLdRZiqm3GMda6IibwwM8qkk6WbvrvGePqF3XX7UIAMgFY2PX4=
Received: from MN2PR07MB6208.namprd07.prod.outlook.com (2603:10b6:208:111::32)
 by MN2PR07MB6750.namprd07.prod.outlook.com (2603:10b6:208:169::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 6 May
 2020 17:16:33 +0000
Received: from MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::715c:e8d2:508a:e2e1]) by MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::715c:e8d2:508a:e2e1%6]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 17:16:32 +0000
From:   Tom Joseph <tjoseph@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/4] PCI: cadence: Deprecate inbound/outbound specific
 bindings
Thread-Topic: [PATCH v2 0/4] PCI: cadence: Deprecate inbound/outbound specific
 bindings
Thread-Index: AQHWFK1tK73RrSoXgkaVdJGJCCW8UqibaZ5w
Date:   Wed, 6 May 2020 17:16:32 +0000
Message-ID: <MN2PR07MB620800FD7334E8FCE795722AA1A40@MN2PR07MB6208.namprd07.prod.outlook.com>
References: <20200417114322.31111-1-kishon@ti.com>
In-Reply-To: <20200417114322.31111-1-kishon@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGpvc2VwaFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTUzNGMzMzVhLThmYmQtMTFlYS04OTI3LTUwN2I5ZDg0NGVhMlxhbWUtdGVzdFw1MzRjMzM1Yi04ZmJkLTExZWEtODkyNy01MDdiOWQ4NDRlYTJib2R5LnR4dCIgc3o9IjIxOTQiIHQ9IjEzMjMzMjU4OTkwODMwNDU4MCIgaD0iV0s4NisvOEtjUkhFUVBOaXNvdU8rYTg0eUZnPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b2161ed-4f1c-4445-aa70-08d7f1e13961
x-ms-traffictypediagnostic: MN2PR07MB6750:
x-microsoft-antispam-prvs: <MN2PR07MB6750CFD99E080CDBF6469A21A1A40@MN2PR07MB6750.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W9FqwN9lZSjmtiZBiM2BHA5XJDvLGX1gvfbKkKilrd14Rwbtckw6hkBqDXm9Pl7/nmf0km55pGws+25oFwsk8B6kTx9/JAgIdW0/Bv8SEUaefkdxqFyxD1NcULbsGGiPOOqpVdU5B5d0qg7kiJpIXlLUp6CYD7drFqoWTtZBFTVBEhZK82q4yUk7Wka6GibhYZ8dEG2ZnXNAqt98HcLv9qExvoYA+TfzHhdzR0P+FUkf0b48JVixPNBMv6genHodCDuvcaMbildPfAzTx+cdF3UgcWk4/6O9mmeBsR/mUFwKmRx9MoqWvg4pNWfqvhE+C1ToidnNQp1TrlACo62u3jf7SNN61rKTTP5FdzNz6I4l3ZRh3hSeeuaWE0jM+Q1yn+IydEVlbQ31LKZmO2O+ENQW0hOZJumGFpKW/fc02kIYusDg8i0jY4UZDpIxzgv4nGHDVC0mksphDfBASXfLfrQ0GzmKZ4/HdVhba857YsFa7BXIcfYzx7iwejcAD3+pnUtz6KqUOMTkDrPJ8tucS9hcSkBg47IGIi6Tc/DqEzokBFE0KkaSPL+eGT0IO5r7BMtILQCepvYp0jovr/itwrmQUHW+1TOOBFiPqkwCU9iBF4j07QmiC6E8qZnoEQyAnPOMO3PPtlU4ZHssB1z5OQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6208.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(36092001)(33430700001)(54906003)(7696005)(55016002)(71200400001)(4326008)(9686003)(110136005)(8936002)(8676002)(26005)(66476007)(5660300002)(66946007)(76116006)(52536014)(66556008)(33656002)(66446008)(2906002)(64756008)(33440700001)(53546011)(86362001)(6506007)(186003)(966005)(498600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SXGc2b4Mhqprjnr7oE2PZpCs+0Meiva8NmZgWAHi2CEJapQRJ4FiJcZ3X3WYyypIKdv4+TBr7vY/YZUaYUqpG9goiPcnIzOXTQWdZOufzTQDNkL1BIleex8zhbxx72fAA1BxrKnGr4HYeis8c5vRRzAEKmd6+uv24zlybYFE7ekkmhQvRsFhge3ahMX4Zc6y0itqWPh3A+UTi/AxjeFF7xLecKZP6ZyLDE6Dyx5ZzCUGYtHr4KWaYBG1QhYvG+axAjuH2kjtoFt2R8y1+Z+PU5hgJ6LqT2Ia9HxLl6zvqxTmzZuR7O/uoQbIFCZ45FAYcYIhnSAwzXU2MKkBKlrqAcU5dgyDNZ+dxVUt5GWbTqdLUI/D0HHF2GpIoIRLSr8+Ii1/atnqm5tpvEciRIPr91cjzSI3uOEetjKTJtbP6s4SqIj4TPa7KF3jp+WPlBh+HPInyrV3CsRdCn1Id8Smcm9+ZZwxHThtkyeMohQExDOhBoPgokBKuiUZTI3Om5FvMJegqiyBdTFpoMNAjQ22hYT+B/0Kq4K/FOk9g7WOk2QsM5I6Gqd/+vBSz/Rc53kqjsKicIRaPyO11ysT5e7NdBJWswLwayyHgRkKlWnwLy2QF0j6Hubn/VtkROjeH2VKR0sXHyC8RVFHc5u+8j8kJPkmbOudKaHSXPNfb8+GoILZhs9zRKG1PzCRf9BG3q+sFv1fXzTAsJiMe3T2ioqA+RGnAjRbnxRm31TVYQOQ21HHakmeCaKn3Tdi8DtFfBgAyv/PLbS2X/tkojnj+WQn1uVXJDhQx9nGai9q50btvGg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2161ed-4f1c-4445-aa70-08d7f1e13961
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 17:16:32.6383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpGRBz/vmLRASao01r+gUU1euke3YPLK+dHhT0VuCpsCEpjuIiMErgKRBcpS5DTAhaRhcPk8qZFfTOwjAgFFnJWFmeEzbjXoKbqvlGGHZWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6750
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-06_09:2020-05-05,2020-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005060140
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: 17 April 2020 12:43
> To: Tom Joseph <tjoseph@cadence.com>; Bjorn Helgaas
> <bhelgaas@google.com>; Rob Herring <robh+dt@kernel.org>; Lorenzo
> Pieralisi <lorenzo.pieralisi@arm.com>; Andrew Murray
> <amurray@thegoodpenguin.co.uk>
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v2 0/4] PCI: cadence: Deprecate inbound/outbound specific
> bindings
>=20
>=20
> This series is a result of comments given by Rob Herring @ [1].
> Patch series changes the DT bindings and makes the corresponding driver
> changes.
>=20
> [1] ->
> https://urldefense.com/v3/__http://lore.kernel.org/r/20200219202700.GA2
> 1908@bogus__;!!EHscmS1ygiU1lA!WloWcIaUFQabEO5FFWQOtNXLI_LZm6w
> 5hMqRP7KjVX7QEGHBX7W13D1hEXnRbEg$
>=20
> Changes from v1:
> 1) Added Reviewed-by: Rob Herring <robh@kernel.org> for dt-binding patch
> 2) Fixed nitpick comments from Bjorn Helgaas
> 3) Added a patch to read 32-bit Vendor ID/Device ID property from DT
>=20
> Kishon Vijay Abraham I (4):
>   dt-bindings: PCI: cadence: Deprecate inbound/outbound specific
>     bindings
>   PCI: cadence: Use "dma-ranges" instead of "cdns,no-bar-match-nbits"
>     property
>   PCI: cadence: Remove "cdns,max-outbound-regions" DT property
>   PCI: cadence: Fix to read 32-bit Vendor ID/Device ID property from DT
>=20
>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  2 +-
>  .../bindings/pci/cdns,cdns-pcie-host.yaml     |  3 +--
>  .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 25 +++++++++++++++++++
>  .../bindings/pci/cdns-pcie-host.yaml          | 10 ++++++++
>  .../devicetree/bindings/pci/cdns-pcie.yaml    |  8 ------
>  .../controller/cadence/pcie-cadence-host.c    | 21 +++++++++-------
>  drivers/pci/controller/cadence/pcie-cadence.h |  6 ++---
>  7 files changed, 51 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-
> ep.yaml
>=20
> --
> 2.17.1

Acked-by: Tom Joseph <tjoseph@cadence.com>
