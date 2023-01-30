Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FAE68167E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jan 2023 17:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbjA3QeJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 11:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbjA3QeI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 11:34:08 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5659535240
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2023 08:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675096446; x=1706632446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ky9rdQZrVuV224GA8nRKmIT529lW9WNziT8hI6Q98o8=;
  b=GnbvZnUVjW3SAlXUByScpMZhwbTQdEywhKPjsdOhGrXEupSNRa14faQ6
   7r94u9qAxb4iXQSIzBPp+lj321G9emHbnueCSJ0EV3coSnVzvfV189759
   mv35QAoes9A5bGBmNghHsggVx0bcAcB1XBzLx8jg+Io73lwbh1XXQjYe2
   EHs9GzccSGZG9rPgZfU5fHbRLkz9T2MDyprznhlW4F2mhEMdnVrkdFgJl
   4imLrba8m46MbCntIrupKj0cVoegaljXLRHBEi4Y+9CtEB21utKvzhX5M
   it0ffLG72PpEFzn3V6y5GHAc5TuvA+CplLuLjwe9rtCvK/N/oW8IDs68Y
   g==;
X-IronPort-AV: E=Sophos;i="5.97,258,1669046400"; 
   d="scan'208";a="222149989"
Received: from mail-bn1nam02lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 00:34:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwQJn3kmRDLIgqjDhlZBv6DVGQUsPr/SnXUjoyqF8HVVHYOx3t5+7ZAPyVsCscyGpqOg7eAhEOBtluxvXA6tuIzxFlhZhh95/BDMrYaVzrdWMZZyMce4KEXGXEX207BbJqa7AxEnOXsCtRHLSmvDI1che4gh+io/ib2dFufQIZQvpV3v8TKBrOrohWNq6RTykCoClR9HwfpCQHVjQkekDJfDlgmEflRKnQUerBxriFOXZUgjWpl1ZTO/iWBDqm9HzoXyjoVk+p58nxsxxvL7AdbSAlv6aKihYXD1oWErBPGcRM0smSUT1WVCze0KPiM56p16NatIpqKlv5hHe3QXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4E15FuHbYvhMi6pRAa6c7VBlL2qzF222OBaFFlu2gik=;
 b=APdkVGPoOOicwMLgnWRRFP7A3AyZyiyfah3rolWBMBMwksWhetFKf8SSg3TwWkYCdmLelZQrwgUl8gAb/q7wDXvIcHMsfWUD/l18yNQdWbtVKI6t5dTorQ5ULxvq5G+chzmeNt297uP/nrQtS7RUXFkpXi7fOTdEwLO0lYuSt2kmOcKrDhy2Ap9ET1kDO9ZqylJkHpkZ5UYoKWFVdbUm5P4o7AkQ9Y3kOszdnmNYmh2nZN1KlxieI8rS9srDc+usf6RyWuaxXDz15UC5PlycMsBWFEjehlykpNJwpj7Gja63UatZe6mLf4p5ibpwxBhu434+QrTV8V2KKcnQ7IytRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4E15FuHbYvhMi6pRAa6c7VBlL2qzF222OBaFFlu2gik=;
 b=BRjNmoJpBq2kDSkeFS4JtLNrvgB5S9a4Zx75WklQwhT28YeYqQm4IhQsQ1KTywBOrVrIHOEGCILJc1via1gdiQW5V6YeSpR18DntiLdPBlQkZuInFn8yfaTOXUgTiGeYGXVSzDubsBwWRo4WIhJdsLZVTiCjg4xT+kl5KgMkTH0=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY1PR04MB8776.namprd04.prod.outlook.com (2603:10b6:a03:535::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 16:33:59 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a%7]) with mapi id 15.20.6043.023; Mon, 30 Jan 2023
 16:33:59 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] pci: Avoid FLR for AMD FCH AHCI adapters
Thread-Topic: [PATCH] pci: Avoid FLR for AMD FCH AHCI adapters
Thread-Index: AQHZMrlvb9tc/cweD02gtKkaj6nZ/663F4SAgAAOXgCAAAX4AA==
Date:   Mon, 30 Jan 2023 16:33:59 +0000
Message-ID: <Y9fxdvDg33oAFT7A@x1-carbon>
References: <20230130152111.GA1673431@bhelgaas>
 <6bcf0e30-8a33-dbe5-415b-593f916f0fa5@amd.com>
In-Reply-To: <6bcf0e30-8a33-dbe5-415b-593f916f0fa5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY1PR04MB8776:EE_
x-ms-office365-filtering-correlation-id: 953c8020-2ad4-4ea0-2d8d-08db02dfc9f6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vc91BQ3kALbS8DpSxhljYBRAgtDDieujTLJBzdI0NR6a9Nh20jG/b3gh2dRU4MzmaHA3I/cLBHzjyPI7EOdrCTCbKQaDmQpgFLJlvuyc2fZAB51ZPq4MkVrEZUE6I1MN8IWQfKvDySJINxjnncLpR5TfZdiXPOjq3YiJTJUD9ecKsDcdvrbNLFaitJeK07+MdHuyIa4tQdBhVoHuE7/mAI+cz+vZh9JZDnDyUNY9SUfJhbY96umKXlGIaT9fFniX66tcMtAuXlrXN+qELAQaSOTAQ8oX8mlCSi8na67pt4TF37hgBL8EHIY+4Sgh5e2/uge7wxmuVzSyyvy+ggHs7NCt0Z+3jfzyaW8dFu/hjGmYJAxRB1zaQDDyLn1K0qX4PqkZMW0m1PjJj8815ijqwxE+q4f9yQvtQyuII1XdwTEK/MpsU0IKxRIkLYG2EgXSDK1EfFzzNfrXXoAklPVL13y2laBcz5XKgdlJn2lx9cbAJVHdgD0zUvLTiB2WoeXE2oxcZIl0xPqqEIceXPKpqevITVQNL2HbR6wEgkY5QY6x1Ml+2eDgxvxrkrFD8S8uhbAn07Ag3WsAzQTfCkpM2yPNk+ECxlfdWBK6etSGzKvmhvzNofVOOZWfym22ZHpH4Yo16tvZuMpt3H980ZFaGDtgn4LVehaUHG/p0u7/F4e6hnJtrzOuO9dP6FUhLjhdnLm5Dxr5CariZszy9NwGLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(54906003)(5660300002)(41300700001)(316002)(8936002)(91956017)(6916009)(4326008)(66946007)(8676002)(76116006)(66476007)(66556008)(64756008)(66446008)(71200400001)(2906002)(6486002)(478600001)(6506007)(53546011)(26005)(6512007)(186003)(9686003)(83380400001)(33716001)(38100700002)(122000001)(86362001)(82960400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zq2417tPurZ7ZJY64NcXTBTqGOKgNkyy3w74N+oQut9slM3YdZWhQZOQqjqr?=
 =?us-ascii?Q?i8ZrU7o2vpqlqoa1v7DoOD6JMKhFoX25JLyG5h3+3XGav5DpqsRKycW8K3c/?=
 =?us-ascii?Q?ElcYXXpCxtUlq9iV10SgZV3JCQYhdOElUlL85E1BUL66JbnYH1nsBI96BnEh?=
 =?us-ascii?Q?HBHfCB3C+guovFXNRyP8x+GwVNqWcieIdosIei1EwIn9z8QpxEG7oR7s1SC5?=
 =?us-ascii?Q?785T7VMzvwlqvg88WfvMgdZe10TLCnwTgxP8+uVBhsY1Xhht3V0uNwm3FXyk?=
 =?us-ascii?Q?EAYApWNJzVfl4W9DxmfW3e/xad9bOcfcid4KvZUiRu+sUdG48pEYgdkaPn2V?=
 =?us-ascii?Q?aPJWfuSovYYV0seGTT2mQhFJa427wQVdT8FOiCP2NXW9Xi8AJslJp3Wa0bOs?=
 =?us-ascii?Q?2F1hEeurzDOhqOj8uzMEtn7evbAv56Sdy4tom3sMzze1frXULadtun8QFJj+?=
 =?us-ascii?Q?Fejk5yAzUMdE4oDvNDuJPB4O7C6VsoW8Ropzv8/xYX+81IGy8iJ9wgZXB8xO?=
 =?us-ascii?Q?iCTL7gndx99QYOFuK1S468X5zerRKjrvCXTRS3kCjS6OvCx1hYfIOt4c2lR3?=
 =?us-ascii?Q?B/dc0xD5WP3VI62N2P17iP9neiFhkVzfuM736ZRtGD73wLaCaCYuKLl5bxS8?=
 =?us-ascii?Q?6s2NNiyhfa15Qu4GERactFhbU8m8g+vm6kU3ZNTqzcIMkoiPFYLdtoISiZNx?=
 =?us-ascii?Q?ltmlPRQgW6+DrJ651MllwsVHWvAPG3NoYrsQsNPhkxz5TDXZDnFX7KzU4M0B?=
 =?us-ascii?Q?lFrfS3VJBOyU44TsAhcSbvMcoxzMDXz8cn8tKBjKi1Jxrn4VU/jEGRKq1stk?=
 =?us-ascii?Q?RTd6WdjCTezIVb4jg5XtisHS9mX5ol7dn4LSszJUn/Vs6ch1n34I5M8kveRQ?=
 =?us-ascii?Q?ShA1XcbvnYxGzdXY+mfNfvxnR78EUaFvHaf9DbygMU0n1H3oejYUGZtIsxoL?=
 =?us-ascii?Q?YfVNQ8mE+vi74lx7xYcc8lmpALyLM3eX3GNB0mn9Vuuo178Qrc8Ck9UyQfRV?=
 =?us-ascii?Q?Qp8jvine3xMBZ30n+DhFpKr6IUy9AXLbnbryiPmref8CFfiWixvLi0bSUi3g?=
 =?us-ascii?Q?k+oP0CeXlm0jp9ZOmAVi0WcHvrVAYWF16oJsonJmJmPXAs6BsHI0Dl3q1zaG?=
 =?us-ascii?Q?oKfQa9zwOrcf2A7wJVIiSItZMI7nkDLBlKoRKScqNh31FSUVVlD10iIjzNkg?=
 =?us-ascii?Q?d3qIU1P6HQOXE0dBNzG1tK8KdArCX0EZVzS3evFGEml+TvHxJz4MEvfA12DA?=
 =?us-ascii?Q?Ga8CtIp426IYcOUiBwFwKERo85GV1EEH284aRGuf0rSZ49Cey51dvBCbx607?=
 =?us-ascii?Q?fWdKoOx44P/8CiJy62E3439ZBjQgLL+J7DUbaZsqGb7gHFpdOuFT6P74QLaC?=
 =?us-ascii?Q?hPv7iyVG38SR7AI5aAWWdn2tLD6M3sSFqYUteVSn27tbpjCtdmNtdgRvLxIJ?=
 =?us-ascii?Q?TFQ6/pQyCSWoSQa1sFAdWCHbD5iG8eBsfKso8dP1bAiLg0Yoh5os4mP0G4xY?=
 =?us-ascii?Q?9zQx6ObXx151jeOcWmVZClA70rBKOmjIasNq0olyjPFZFdj2L3koLb3CYr2N?=
 =?us-ascii?Q?QdKItk8eGS+r8JHPi1xQ6g34EJ7ybbFU1xfDF0q7MkZyMLsIFjgYTPMHbFs6?=
 =?us-ascii?Q?rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2B2F2EBBF2302C4A868C60D7E8053300@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iV3phS6mIOGDbOpHyAPc/pmap7BxsUUvn3rkM7ksBzporqLQw36uhGM27j2deRUL9Dn29YEpv130WRkLqlHhcb/QgFPxs6p8760i49mWevpQAtDtlZE+88m+lR/z9Ek/hqSyWolMWKjw4h2D0PUOTXkS1Mm6334kwaSlt4YNKbQgZs5pp5ZftOK08UGJV1rF69QISfD/DgagtnWP3MDRZre//Sy1kPd9bvdk+vA5H4oRpDfnG8wDqZBukfEnFtvLJN0KI3p22vV7v6dqcd3PYkMm3L36XblDure8IM2kMMyAdPvHDUnJO3l8T7pRNqi+SroyNSsD0cvJS5Fs+RRZQfROooZaNrtpUMrULWprNqhIVA0syryqkA5lOvUe2LT9DhEoGgGL/R5MWF//qEgp8TGmp55zNunZJLrEIBXUv8zK0aLAiWc/FXy3dgq9qup3JdQQSsG4YbbP2gh2hud9bqfUBCPBxulT/wvKT1oVRIfZ3ncauqqVhx6ZQH/u4tyM61cmN4l5t2OeB0cO80yjW2plDLUBwzBUNSZLgO33lBa27GQxNJD5sFLAXB2CB8XXbgtQUcUMip+kMb52gttPfTxk1QmvhZDxXZhIV2w7bc+5a706QT5SZs86JJXAdxhKyre9KsOx/pOB2fm2vTwkedAkQyI3VNACe3eukQCyApaxJBnJlGdMDqh8U5JGHnb+xAOp89biqftAuPLSB9NECPNd67u6QRJqUfxcKYtJaCWOob50Zj1kh7wO76bs7/uzfeI29NLXkw9oPcALCAEX6ZZihJKA4mO4tQYC/ZjryT14+oBqsWGW0EqYReYHjXQ266QsTZgVxuAm3Fdx/obRI0lEqqrm5oGl1JSacvGfkCU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953c8020-2ad4-4ea0-2d8d-08db02dfc9f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 16:33:59.2217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPptPoweOJswIcHVGBWNK+SGmNOxOCMTXMEJb9Gkfir039mOto020adP4fYQ19u8fVHER5lxNgtqQJ8hAFsOnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8776
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 30, 2023 at 09:42:36PM +0530, Shyam Sundar S K wrote:
>=20
>=20
> On 1/30/2023 8:51 PM, Bjorn Helgaas wrote:
> > [+cc Mario, Shyam, Brijesh]
> >=20
> > On Sat, Jan 28, 2023 at 10:39:51AM +0900, Damien Le Moal wrote:
> >> PCI passthrough to VMs does not work with AMD FCH AHCI adapters: the
> >> guest OS fails to correctly probe devices attached to the controller d=
ue
> >> to FIS communication failures.=20
> >=20
> > What does a FIS communication failure look like?  Can we include a
> > line or two of dmesg output here to help users find this fix?
> >=20
> > AMD folks: Can you confirm/deny that this is a hardware erratum in
> > this device?  Do you know of any other devices that need a similar
> > workaround?
>=20
> Niklas, can you send the list of AHCI device id present on your system?
> perhaps a lspci output?

Of course, here you go:

# lspci -vvvnns 49:00.0
49:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA=
 Controller [AHCI mode] [1022:7901] (rev 51) (prog-if 01 [AHCI 1.0])
        Subsystem: Super Micro Computer Inc H12SSL-i [15d9:7901]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 76
        IOMMU group: 48
        Region 5: Memory at b1500000 (32-bit, non-prefetchable) [size=3D2K]
        Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [64] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us=
, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ Slo=
tPowerLimit 0W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLRese=
t-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- T=
ransPend-
                LnkCap: Port #0, Speed 16GT/s, Width x16, ASPM L0s L1, Exit=
 Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 16GT/s, Width x16
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrP=
rP- LTR-
                         10BitTagComp+ 10BitTagReq- OBFF Not Supported, Ext=
Fmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyPo=
werReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-=
 10BitTagReq- OBFF Disabled,
                         AtomicOpsCtl: ReqEn-
                LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Reti=
mer+ 2Retimers+ DRS-
                LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedD=
is-
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB de-emphasis, 0=
dB preshoot
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationCom=
plete+ EqualizationPhase1+
                         EqualizationPhase2+ EqualizationPhase3+ LinkEquali=
zationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [a0] MSI: Enable+ Count=3D16/16 Maskable- 64bit+
                Address: 00000000fee00000  Data: 0000
        Capabilities: [d0] SATA HBA v1.0 InCfgSpace
        Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=
=3D1 Len=3D010 <?>
        Capabilities: [150 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr+
                AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECR=
CChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [270 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                LaneErrStat: 0
        Capabilities: [2a0 v1] Access Control Services
                ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamF=
wd- EgressCtrl- DirectTrans-
                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamF=
wd- EgressCtrl- DirectTrans-
        Capabilities: [400 v1] Data Link Feature <?>
        Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
        Capabilities: [440 v1] Lane Margining at the Receiver <?>
        Kernel driver in use: ahci



Kind regards,
Niklas=
