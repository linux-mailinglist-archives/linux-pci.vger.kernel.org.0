Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921BC1BF0E3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 09:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgD3HLg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 03:11:36 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:15705
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726337AbgD3HLf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 03:11:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/n4xTaGFIJQV/meUUD5gHISLJ7SmlIJpUyDKCd4uyUIh4zpbquSQ6xdblW9q0Lap5ODpKMvGSsZ9THI8npPoZrxXzGpe4l8VwfWLo0wS8t9gMUUFb3QhPt9+M0U6ZUyHjAjCKvDE5feM9VLED6FqKgqk6C7nGoljR6m8IWrhP1aVrCh1+Sdbj7bDBZ7k6kXkHMaezRVM8JRpxfumtRAaljDCLWTUn60aCD6AxiLe2mpukZ3N/F73DUx170y8jD73qw+TH/2kwG59KCMKoidUJ3pgHy8A1Vvq9wHVID3oiHYJvdGGGY+l3jLTJuWXfaqLXVCP2Lkdn54AKbnXaC9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g37YLx/Tm5SRHdI3aOdu3lkfOVC+LX9a5RseocchgXk=;
 b=Yc1ud2IbDX/Y3mW5FKWtsvj33sXLAO668Qdg0JrsXlmZe8vvNyViT1pghKM8GHHpq31BGJT7d6x/Qgai4/C2Ymm1YQvAlZq/ozW+d5KzbRulLvD/fOjOVqwKcdXLRVm/Pc6SpjxjT2lNuLvJgmItEg0u8Yqo4KR8lyzHKaCjPptTEnurz16+8hu3HsgPtU41mbuQrcn5Tjy9f+YYtP8hQyBlklTP2999+q/rd0ZtBsGdo2bw2txDzjakTCIufh1CREpVK+PN4bN6oXlxz5Q0Cqm5f7A1nEEjL3QMnkRzRKjCdditaw560eZW8R/Fud/huWUke/5v3+NWv/cnFm57GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g37YLx/Tm5SRHdI3aOdu3lkfOVC+LX9a5RseocchgXk=;
 b=pYE/2oRF3xyJ8bZHi/EiFqdKWpCp+iNOGxfady9tbtscmxXeTzPuXQS9Z0rxv8wHjrGNOH084ZcXwdHIp20Gs8E78GQZ+YYNEEHy/VMnuMgHoGTLPrGlkt/CesGSfKLKe9sUsw2LMhs3cS+yagKB+eNVZfBhQUXN0O8IotSUTAE=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB4631.namprd02.prod.outlook.com (2603:10b6:a03:12::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 07:11:33 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::a1bc:4672:d6ab:d98b]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::a1bc:4672:d6ab:d98b%6]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 07:11:32 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v6 1/2] PCI: xilinx-cpm: Add device tree binding for
 Versal CPM Root Port
Thread-Topic: [PATCH v6 1/2] PCI: xilinx-cpm: Add device tree binding for
 Versal CPM Root Port
Thread-Index: AQHWGjB+ikn3pdln6kq5oTCz9BkyqaiQey2AgADLnxA=
Date:   Thu, 30 Apr 2020 07:11:32 +0000
Message-ID: <BYAPR02MB555903ED7FECE191179EEE75A5AA0@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1587729844-20798-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1587729844-20798-2-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200429185541.atk5k4j7rgh7ipmr@bogus>
In-Reply-To: <20200429185541.atk5k4j7rgh7ipmr@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a2d49ff-908c-4e1a-4756-08d7ecd5b678
x-ms-traffictypediagnostic: BYAPR02MB4631:|BYAPR02MB4631:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB463186D929901F585AF9DD35A5AA0@BYAPR02MB4631.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l8CPBlk5OmtBNlk70xbYp69m5dieOwGxsVtsfQ5Z4vnUqJTk6ucMDHREm88OICUC4rqcvR0qHYAlkkvYX01LlJoLdeT+r1w6NX4tnPpuujmbcEp/5YdTivYqw8U89fkzJF6HbgkiKhB5ooO/6WAzpruCbI3lkVhWJoZDijystc9rz3nNyHQhJr9Ue5HuEQxxpMdYoZgkJRZ2uCNVShRCoUmMTJxCNL8plAG4wKfsd4gNWViasUKDwqSfSsZWCnL/7y0QPFNPsWPMToxCvsRZAc5wGCYSwnIh9mX1GRHwFPcd8pICEtHYfIr6udbvieAST1FF2dmWLIhnbvTC+EV1gOGzl2cPU40l9ZHsi41KCqkH/rOlJ7nBuTT+B9A/txCjqdugCtkivjoAzG8HB4ZFs9NlsqLL+u0pcX5R4A/b0u4jriWRIWLvbVVTTZTm40EW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(186003)(71200400001)(86362001)(2906002)(33656002)(54906003)(52536014)(478600001)(76116006)(66476007)(66556008)(64756008)(66946007)(66446008)(8676002)(7696005)(6506007)(55016002)(26005)(5660300002)(8936002)(316002)(9686003)(6916009)(107886003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JmieLXetybiyL3A3o03AKDQmrnKXYlybKgD7/+KQ7Y5al3SZttv0+bgQnzpFVAswPJ7hxpgdt/CHfenVRd/ExxJWUNBp+sd8s7xET/DT8d0V08agK14P1seNeYzUgZm6sqQmeKjzJgfXZa+XgquUs251h6d6Qyt/yVoBnlFzg589skSX0JTz9TNJkwf06RLWjw1RBOyQxeBTY9IUJEMIHvbHeAWIjjF8RBKW5nDDTbHZTlwmIL4AzY7g8Zj10k9TCmZaMb9cBMZRbFqn+KzrXUajh+1NGtBo232ZsY0CaEwaYffVpgDczJ9oLXkEMkTGpzw6Jadb6oPKZG0RTqPaVdIDXET0cCqbQz4toioHpn7RCGHuVumtwOq2+Nw2GCsjWCUpZx2FPMWJMIJCeNOAKf747kXtr5cb6ExwF14w4IkaQqKFUT5xB2wIqIJeYq8UthLL7JJphU0kUw7dwrDR+GBN58fzzLf03aYiVO9bZZ8Sr4RtY5oFhQ6H94d4nxIOb4hVAgxukl0H3RlHlgm1M2DanQaTmCeAudVHmIyyzfRtHjw7LzgoA1uTuTVadbk4kaFvOSHROETc1x8xx9RVcRyaTzK4gBJzvYXwC9kVMul/hzzOWE1GqPKMBIBhxSs2xpjbumIMUsQ6xL8XSYiSuZPRDJ4yEkhRfLq2Dp8vBXfIVbtWsUVSoDTfUbFHNoS7flfmTAnKzxym+j65GP37YwSHx+ZkppSREGcb3TwlxKNA7pqkCY+kBr5TpktzMVspz8vt6B3tWxJOijalJE5gOF1qWtqVUQyIJkShQFsxSpg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2d49ff-908c-4e1a-4756-08d7ecd5b678
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 07:11:32.8610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rfTcJoDxyL0Zv7w7NNHw/W4wWcSu2WG88yNC+yLFc62TtKvyPU1vT9Fuvb6yPqthE4GcGTdif8JK4DIE07JNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4631
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Fri, Apr 24, 2020 at 05:34:03PM +0530, Bharat Kumar Gogada wrote:
> > Add device tree binding documentation for Versal CPM Root Port driver.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  .../devicetree/bindings/pci/xilinx-versal-cpm.txt  | 68
> > ++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
>=20
> DT bindings need to Cc DT list to be reviewed. Bindings are now in DT sch=
ema
> format. See Documentation/devicetree/writing-schema.rst.
>=20
> Sorry to tell you this on v6, but first I'm seeing it.


Hi Rob,

Thanks for the inputs, will fix this and send with schema format.

Regards,
Bharat

>=20
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
> > b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
> > new file mode 100644
> > index 0000000..eac6144
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
> > @@ -0,0 +1,68 @@
> > +* Xilinx Versal CPM DMA Root Port Bridge DT description
> > +
> > +Required properties:
> > +- #address-cells: Address representation for root ports, set to <3>
> > +- #size-cells: Size representation for root ports, set to <2>
> > +- #interrupt-cells: specifies the number of cells needed to encode an
> > +	interrupt source. The value must be 1.
> > +- compatible: Should contain "xlnx,versal-cpm-host-1.00"
> > +- reg: Should contain configuration space (includes bridge registers) =
and
> > +	CPM system level control and status registers, and length
> > +- reg-names: Must include the following entries:
> > +	"cfg": configuration space region and bridge registers
> > +	"cpm_slcr": CPM system level control and status registers
> > +- interrupts: Should contain AXI PCIe interrupt
> > +- interrupt-map-mask,
> > +  interrupt-map: standard PCI properties to define the mapping of the
> > +	PCI interface to interrupt numbers.
> > +- bus-range: Range of bus numbers associated with this controller
> > +- ranges: ranges for the PCI memory regions (I/O space region is not
> > +	supported by hardware)
> > +	Please refer to the standard PCI bus binding document for a more
> > +	detailed explanation
> > +- msi-map: Maps a Requester ID to an MSI controller and associated MSI
> > +	sideband data
> > +- interrupt-names: Must include the following entries:
> > +	"misc": interrupt asserted when legacy or error interrupt is
> > +received
>=20
> Don't really need a name when only 1.
>=20
> > +
> > +Interrupt controller child node
> > ++++++++++++++++++++++++++++++++
> > +Required properties:
> > +- interrupt-controller: identifies the node as an interrupt
> > +controller
> > +- #address-cells: specifies the number of cells needed to encode an
> > +	address. The value must be 0.
> > +- #interrupt-cells: specifies the number of cells needed to encode an
> > +	interrupt source. The value must be 1.
> > +
> > +
> > +Refer to the following binding document for more detailed description
> > +on the use of 'msi-map':
> > +	 Documentation/devicetree/bindings/pci/pci-msi.txt
> > +
> > +Example:
> > +	pci@fca10000 {
>=20
> Unit address is normally the first entry.
>=20
> > +		#address-cells =3D <3>;
> > +		#interrupt-cells =3D <1>;
> > +		#size-cells =3D <2>;
> > +		compatible =3D "xlnx,versal-cpm-host-1.00";
> > +		interrupt-map =3D <0 0 0 1 &pcie_intc_0 0>,
> > +				<0 0 0 2 &pcie_intc_0 1>,
> > +				<0 0 0 3 &pcie_intc_0 2>,
> > +				<0 0 0 4 &pcie_intc_0 3>;
> > +		interrupt-map-mask =3D <0 0 0 7>;
> > +		interrupt-parent =3D <&gic>;
> > +		interrupt-names =3D "misc";
> > +		interrupts =3D <0 72 4>;
> > +		bus-range =3D <0x00 0xff>;
> > +		ranges =3D <0x02000000 0x00000000 0xE0000000 0x0
> 0xE0000000
> > +0x00000000 0x10000000>,
>=20
> lowercase hex please.
>=20
> > +			 <0x43000000 0x00000080 0x00000000 0x00000080
> 0x00000000 0x00000000 0x80000000>;
> > +		msi-map =3D <0x0 &its_gic 0x0 0x10000>;
> > +		reg =3D <0x6 0x00000000 0x0 0x10000000>,
> > +		      <0x0 0xFCA10000 0x0 0x1000>;
> > +		reg-names =3D "cfg", "cpm_slcr";
> > +		pcie_intc_0: pci-interrupt-controller {
>=20
> interrupt-controller {
>=20
> > +			#address-cells =3D <0>;
> > +			#interrupt-cells =3D <1>;
> > +			interrupt-controller ;
> > +		};
> > +	};
> > --
> > 2.7.4
> >

