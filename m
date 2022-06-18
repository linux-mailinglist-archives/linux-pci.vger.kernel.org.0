Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD083550206
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jun 2022 04:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383711AbiFRCgD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 22:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiFRCgD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 22:36:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9554EA0A;
        Fri, 17 Jun 2022 19:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFFIKGma9spwcWA5TZNWG9RI4HvVmybN+nodcHs2CImsctwR2pP53GJBvROWkafGr/dcxlaYaEAuBvbdXkOUn7DQuWtbSvJ3bDbuySO2gTiBVHX30uA7Pvb3dy5p6OqfzMMjfuYNsG2hFx02A/x9rqra7JLq9jtzCqjFcAZSdQgP9Kh0sxMWVK3J51e6FphPiAPb/x43rNwkQ/sXt9Ke3f7X7OJ7yqMvEzWxFwytRoGB2L28ppqDf7R9HQ6ixanZZDwdguZW60gWm5NU+MsdmfRV/fgDriGrepXCdJDS270NzEvOusTwx8T/AjD6ytJcpgeeAiCX7sPbW1eAmfw4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtP7AjUHMliagza3GbRtJA73oIJNcuUdBxFe7lk5Hjg=;
 b=mBl6CqQf0v7NFF36vBsFl7M525IUJkoN1oVKl1YenLHOZuf1O1jDEhChdiJbBZc86uCl14LPVIRvxzLiP72sOvXLznXtdb/zE9RQswmP0rTbyPxrPS61fuR4oc1g7ZyrYeFtQ0A7FgH3hAY8wRLC2oIfDl2ghkxX3No+S/vpbtFBI9+GQ4ncJhIbS4xcJvxaLnxHkqvU8jpU8gr+zbRZkwFz8zvSCiIYM3m0fPbTXwsYiUWGP3V9y1kqLE/l9/z5LnRbPmsxFmnZp4lpI2IAtFJDZvT9MmqId4XvKJBCTkRnPWRBDMFi6m9GkXYy3b2Q1AZc7EDi30JIm1HNm4HvzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtP7AjUHMliagza3GbRtJA73oIJNcuUdBxFe7lk5Hjg=;
 b=bnFIu0LTOZeeh8uToZatldD4hTIoBKvwAgKP59iDf8QcJjZT6H+yzKaEDZkVIACjt3AWRKD4EBgAUNpX6NcaFxowIXguK5jGs8NYFhAkWo1nkFA89sbZgZoVBQsOYCfGjkKYx/eReXNmKR4ZRmy38yHoGdrGQmq0x3OoXTXo158=
Received: from MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 by BN7PR12MB2739.namprd12.prod.outlook.com (2603:10b6:408:31::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Sat, 18 Jun
 2022 02:35:56 +0000
Received: from MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::5913:7dab:a686:710b]) by MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::5913:7dab:a686:710b%6]) with mapi id 15.20.5353.018; Sat, 18 Jun 2022
 02:35:54 +0000
From:   "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v5 0/2] Add support for Xilinx Versal CPM5 Root Port
Thread-Topic: [PATCH v5 0/2] Add support for Xilinx Versal CPM5 Root Port
Thread-Index: AQHYgX7ZyqV524NBuEaYF92mjmwPz61SW38AgAIZedA=
Date:   Sat, 18 Jun 2022 02:35:54 +0000
Message-ID: <MW3PR12MB44114BCB9676CA63AF9B4056BAAE9@MW3PR12MB4411.namprd12.prod.outlook.com>
References: <20220616124429.12917-1-bharat.kumar.gogada@xilinx.com>
 <20220616183108.GA1101056@bhelgaas>
In-Reply-To: <20220616183108.GA1101056@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78dfafff-bb20-48a1-2b0a-08da50d34468
x-ms-traffictypediagnostic: BN7PR12MB2739:EE_
x-microsoft-antispam-prvs: <BN7PR12MB273921271BA5DF4DEF962774BAAE9@BN7PR12MB2739.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MaSjKFGwLDZbVXxHQsuL9Wj4+5sdRi9ELglXAW7BYuA+IhQ1HAhfPhubXJHKBedMNoOt2ivP5V6+hZZoANWQ7jPnAuIR4AtBCqQoTBNb3TG0XLpbcdNDByvOuPP05FdlzfEx1J3Dr3dwadrwbKwAgqdwJJ67gNpfhpwbm14cOnz2W00KcPwmt2GTufk3cF5a82wemGiJHh6CWee+iK4yRSDibvmzhSIakousOAQZNOU9AfxZc6etC4dChRp7I/SPlxQ/XuQVyRED6Bt5V/mGva7oz7fFpOQa4B4L+dd8Eq6MM/bbL7fqhznT0lVX8vyixluQWR9GuYvITmg+3cpqkniZbjL6GSZD70jWltSYfj1Vysyuakzu4LWPYdmhmpciQutdE5BPVa+qWvQ6MAesWVj4qQ5Ni5pKokJ1YPfFCFeteE/OUfB9ZXb2qcXbNTMXomAoA+S9IBxhi5VHmL1dogOElrU7wvKQC3CT3zRgQu+XnlwJ4ZUJmuz+IUjxq0/JkKRcS3FkyVy27tqUbgMUnTyQmihhowXTzs9kcKACqk6kUmsEtnUK8N1aMEOdVwQnPjkU5kEKDs9mRoK8wzqpQ71uDLEud1P4SUrfb3f6gN4ZYlcrC9tiNbIjkbhyyrKICg2CeIs/4Zk//RtinCHCoO3S487xcSAJKLhv0WbK2f+Fej3bUOesYwxWOfQZSuPZiJkY0/pKI0qH8DOiWzjPLMfI/ocIKWGOcGDaBS6uzJHjJSSQc9IimfSBGQrqgt2Cd/0mVr0GXRLvLA8IrHoNv/Thtj8t39BX9SRkwLSon8g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(8936002)(33656002)(316002)(5660300002)(52536014)(64756008)(38070700005)(76116006)(55016003)(4326008)(498600001)(110136005)(2906002)(54906003)(8676002)(6506007)(66946007)(66476007)(966005)(71200400001)(66556008)(38100700002)(45080400002)(7696005)(186003)(66446008)(9686003)(122000001)(83380400001)(26005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f6IDdGiU378bwcXhBfdoYdJJuC+L9DMjKVgcqjJCqMvWLK5avemLJm2o0NRo?=
 =?us-ascii?Q?fnpkxjQqSNnhsYgKf5YEwvI/P/bvbyppqfT8L/YJyCpGd7Tw6B1btW5QuUNP?=
 =?us-ascii?Q?HyOMNodJLgs0YwWWO5ULTShjsWgJXYNb1dyvJQropX1DiYznk7mrByHrU+nD?=
 =?us-ascii?Q?aLk0pc7Jg39AA3eSapBwEMOMTfV1IVKtw7MKdbXb4wWfqs3RJkP0vN9tvXNK?=
 =?us-ascii?Q?dfS5b2wGqF7QugFRzlu0dRfbzez9goDsGTcDbvVzOSdtOLCLP1Nbl/VgHwRV?=
 =?us-ascii?Q?oZ4pWS0HvuYERbbkzaLA9EE9kzL/U7m266dEXAtfFhdknGyYEmNWQMwaqYzJ?=
 =?us-ascii?Q?Qq1LO49EFwq94H5i6TJbWYPu/9yG5pIbnWnYFpDjmf4sq4HK29FHeni2qq1p?=
 =?us-ascii?Q?gypqxTwav8Ua9nzxLEU+PS8bqQTCZ+oDeWaV1Td9caf5te+JEw0w/iuXggcC?=
 =?us-ascii?Q?uWYNNOx6QatXeJGTnuVGFquL0OyOmIoWwxJ7Jc41zGfp4XfngXKfd1eTgSr+?=
 =?us-ascii?Q?W+IfDgKBvGge2czZW5jZPIiwAz3ebVFRgVrtNNBmWBZCzamL1WJIKxVYeSth?=
 =?us-ascii?Q?Y/B1cRXMZw8ZLq17hgIsnYKAobDw+crZpmzLZn/IofudO7yWA5KXqilJFLXu?=
 =?us-ascii?Q?HrjySKQ/XVJKEMz+taRhotUqFgKZTGdCfByKmPoygB/mGZgehiLiwHdL359W?=
 =?us-ascii?Q?+8DcufNdM+bKg1ArR/7NAAmgr+FSY6Y4pFC6kEdjbnJ3NSL2lE4prClaA8yD?=
 =?us-ascii?Q?zU/lej+e5SASRw/OiRLcjMlQ9YuMRs18ogCMLQu5gj+rtKqjYSA8mAc5Qab7?=
 =?us-ascii?Q?qQ3SavgojqqeK3Qw07JjYeMRROHiNphvv+88/czh7Tkk17EcZn8Lt+7mPc73?=
 =?us-ascii?Q?ClL/N4/bwpfOFJJvIUA23kSRuZMMQV6kNwp1noj+Tc+7nhoo8l+A4Sf6ahpv?=
 =?us-ascii?Q?bEVJSlURZEwTfGx6EJaotUd9dyzhV/B/hX8jhi6lQYCVA9Vt+scH11n8WOPQ?=
 =?us-ascii?Q?by7uatE2ZtWwfMQowSF5WfZZn9V2gg45A1+UJRaCRDyZ7OlXjgyyNOwrD12k?=
 =?us-ascii?Q?pcQqr15r4QQuEr5uqt1Xhe80H8UnjMHox777BVUTqX969SnBF/OOMjbJ3qX2?=
 =?us-ascii?Q?H9+zbMZInkLZ+THFHY2sXjd5vsJbo2mLG0uKUmYds7nBli5+c07fwaCLhMDI?=
 =?us-ascii?Q?DMOSBSiQEuKRV95fHNV+qJippLX51ot1ABB+PQ8WCxbioUDXQrCQqVNlGt3q?=
 =?us-ascii?Q?M5yrhr9SEbw7FQOOtguPis18HBjG/22Fv/H+n/4e8QAahGbdyYpR1QNCaizt?=
 =?us-ascii?Q?uYfa7aDMi0QMgDSXl4SQwObatwfduuq1k8HkUaATogm7/6RT9uOcOtXRQDoj?=
 =?us-ascii?Q?KQb7LhYBEhsXIEMl652WpRuWsVcwU6sh/LkC9LE9AJ7xAGSoPcyPtf/2DjT9?=
 =?us-ascii?Q?3lP/immHkTMt6aFZ6QPcZd+7adNuljtkHPwWpVIz2Phl87kJmVsXXfxd+Lkb?=
 =?us-ascii?Q?G3zb75NeTPNYJf/QBU/+SSbeoFZZ/uV5aq7llp8iHzi/UwwflJ43V5R/S0nU?=
 =?us-ascii?Q?jicbMdmyJZatxTZygk626DpwYQUq7CH3EJ8otsEF23XWMXOGXzYLTDeL3aH/?=
 =?us-ascii?Q?SYaDnYbgpkrj7HhQgfIS6Kogs3yydXb2KhIvVGyei/UHeDCDcm1ASg2YeE1M?=
 =?us-ascii?Q?SkJWa48kAhwE5jt64VOCk+PyzkvQmmbYu8vqLsctp6sHiYW7CBuMw7kwkKJF?=
 =?us-ascii?Q?cWFU9V4C9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dfafff-bb20-48a1-2b0a-08da50d34468
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2022 02:35:54.1876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJ9SmQX0UXm0daR0UgKl/z1nEFyzpdH6dTW7hAqhDxlpgkctbAOxWiNwhm4q8GH1JtCahPpRCtGaZ4zXW6PKoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2739
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> On Thu, Jun 16, 2022 at 06:14:27PM +0530, Bharat Kumar Gogada wrote:
> > Xilinx Versal Premium series has CPM5 block which supports Root Port
> > functioning at Gen5 speed.
> >
> > Xilinx Versal CPM5 has few changes with existing CPM block.
> > - CPM5 has dedicated register space for control and status registers.
> > - CPM5 legacy interrupt handling needs additonal register bit
> >   to enable and handle legacy interrupts.
> >
> > Changes in v5:
> > - Added of_device_get_match_data to identify CPM version.
> >
> >
> > Bharat Kumar Gogada (2):
> >   dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
> >   PCI: xilinx-cpm: Add support for Versal CPM5 Root Port
> >
> >  .../bindings/pci/xilinx-versal-cpm.yaml       | 48 ++++++++++++--
> >  drivers/pci/controller/pcie-xilinx-cpm.c      | 62 ++++++++++++++++++-
> >  2 files changed, 103 insertions(+), 7 deletions(-)
>=20
> Weren't you going to include a MAINTAINERS update here?
>=20
> https://lore.kernel.org/r/BY5PR02MB6947C5B34801AD5F289127ABA5A69@B
> Y5PR02MB6947.namprd02.prod.outlook.com
>=20
> Maybe I missed it?
>=20
HI Bjorn,=20

I planned to send it separately. Will send this soon.

Regards,
Bharat

