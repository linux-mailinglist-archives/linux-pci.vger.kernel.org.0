Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1477A6662
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 16:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjISORl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 10:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjISORk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 10:17:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C667AD
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2023 07:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE0Lw5TSDvHkmY7BgurdWD3KhN4tSoqgthtgwhJU//ozX3wPR7zW1YmaCN0xC0cemyCNePsmCHUqNw8rDapXx26KKb6vBXi8j9OSKbJjY3j419gJVaiC/sjMexuxIvMnsHYEdxwlFXWcwZz8tCMOOVwMJDMIctkAslC2+LC5b6cUWaVKSgacI4miXEX8QcKDmCoZs32nBZ5F0e/gbGzOvd0CeA+uDBy4bMzYA51Sn+r4Zln5a7wuremnfmZWotyerDf8E5h24Nzr52Et2oAihP05emgt4GbVSRKFMDVAmtnDyTRa5ZfaN2zY9wRI4vtXdHXJcyeG2G2+w/jGBZVIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WnhzMgrJy4T4T025gKJa2Th/G0D+QaPO1IsMgRKFRM=;
 b=VfaXrfl626ySnrYhdN66NZQB1O2WjXSFRAhb/NzNhs/+94S7faGvDoJB+GEpoejVSLaf86toH07oAi23iQUOLjZA4iMtiF4y+pk/lnv9garSzRI3dkvuI5vtAQ0TFb1byQZvvuCPk8Zr0mpxbnAEaYf++l5isYXZPFs7EoD9DgONwWxLUmF6UzkEWcCjDqLTTHwUFCKI0Sskkf7a6zFLb29pzeoWxFjb0sW1D25R/nwFl9RoekyUBeyR9q9Cbv+up8DWoAFbUQ1oQDP784BFXW4me1x0yTUDfaDckXwK/rt9Y7JBkXxyGWzN33Ce227ooqfGZ97xv/FdqYHo/CfY5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sonifi.com; dmarc=pass action=none header.from=sonifi.com;
 dkim=pass header.d=sonifi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonifi.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WnhzMgrJy4T4T025gKJa2Th/G0D+QaPO1IsMgRKFRM=;
 b=n4Q2FTafIfuCK8rOEg3ffcBREGZhqYwMbhv6e/oBe7pCz4MWok1HJweUZfFNRdEE8fuyxTdDWK393O+p4lRtgSQ3jZlA/Op7SmMXmGZ9pB3oKhBHfbJ7pazzPVq0hmH4tbFWSobT+9px4OgThMufQ9FiMQpAJbjS7G9lOsce7zg=
Received: from DM6PR16MB2844.namprd16.prod.outlook.com (2603:10b6:5:125::22)
 by IA1PR16MB5360.namprd16.prod.outlook.com (2603:10b6:208:44f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 14:17:29 +0000
Received: from DM6PR16MB2844.namprd16.prod.outlook.com
 ([fe80::cf1c:eef5:f2ac:14c6]) by DM6PR16MB2844.namprd16.prod.outlook.com
 ([fe80::cf1c:eef5:f2ac:14c6%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 14:17:29 +0000
From:   "Schroeder, Chad" <CSchroeder@sonifi.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Schroeder, Chad" <CSchroeder@sonifi.com>
Subject: PCIe device issue since v6.1.16
Thread-Topic: PCIe device issue since v6.1.16
Thread-Index: AdnrA833YItLbJ18RoeS78Ya55oDog==
Date:   Tue, 19 Sep 2023 14:17:29 +0000
Message-ID: <DM6PR16MB2844903E34CAB910082DF019B1FAA@DM6PR16MB2844.namprd16.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sonifi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR16MB2844:EE_|IA1PR16MB5360:EE_
x-ms-office365-filtering-correlation-id: b63878f7-0b9a-4703-abcd-08dbb91b2841
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FJbT5Dk/LFhpFYpgsVpc+9Kgakk8qObi8SXzKmbPJ2BNiYg7ydTNEuBqwabYescZc4sew6NfzmyYlY6xqNSY63ToXUwLys0LXnrr9XC/MvYHyk03nVyJMTT+3cFgzyyXj7scbLt8ExcJaS9Od5IxcFRvryRmD7YjC0I+Q9BQaTYuAgJF6ZxajL+9u/h3GpzsysemtTLH3u6rEA0ACTEvDyRBr6vxDWaHMouIFlz4TVwhDcJ83ldpp3rlQcxVUTB2kndx/GQGQ8CPVPDwm5HnBhbCWwh2Jjt0esxOXNl4S8C3VkQt4N5IJcEc8PhEx4R0ZJNDqfiIXiwNQa8j8CX28uBnTDgm0imVVjr7b2Sjxz/pqKI/mEfCUtPohz54HtWijXDWF7GbBaJyB2c6Bvuiw3XaYrBc2zSgoFEsQeerOVbmQaDrohsHWHieyQeaBWSPvS1FVmef3YxiYS277Am3T4O1yUXPZ2V8WY9jikFpQi51Uz0P1EuSi9ElTgT5EGKSryVsCWriyvZ9rvDO+A3KXxHZwhU7AvGJFvHvKZbcuLRoeJsty3DR2/Fs5nBmpLN41vmoNW7N5BojIScOQIaztnby9d2zao2fX5NhhqfoxVM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR16MB2844.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39850400004)(1800799009)(451199024)(186009)(4326008)(2906002)(8936002)(8676002)(316002)(6916009)(41300700001)(26005)(55016003)(52536014)(478600001)(64756008)(66556008)(66476007)(66446008)(966005)(76116006)(66946007)(54906003)(5660300002)(33656002)(9686003)(7696005)(6506007)(107886003)(83380400001)(71200400001)(38070700005)(38100700002)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xhbsKGpb35u4BaF5UI8R3MDOAiS4jPXuER7Kub7FF3RWkPtGqXlzO+dcsc9j?=
 =?us-ascii?Q?/QOiczUXaKBH9vnNyAJ+AD8p3AX11LozfFiyCtHcSCnGN+8mC9rf3EzY8WfZ?=
 =?us-ascii?Q?JIrD4K2WOAQs956XMfk32udvzTjaduA3uSHKqXdlP3KjnIzdqdSAqV0g4Kj3?=
 =?us-ascii?Q?ZWps15iwfDpnZ48IF3TOWlXtPOXerPYegXa2hyuBSpQ++m6l3oe6esdOKUpN?=
 =?us-ascii?Q?jViP6nTOsnJQxnFFaWgchzGgtEWF8iYCeNl0Bor7jxRBoGzAeIxcMOmbjLp+?=
 =?us-ascii?Q?ugEm579G0G3doSGwhJXKUPFbVqh2yZZhu4O9KayV2cGr1PrNCXTDt7wl39Xq?=
 =?us-ascii?Q?qQeY5VaS1iQzgWtqHiRh3r8BsrxFfE6tuIIge8/nhhOTBf9TmYyqwInJ2v15?=
 =?us-ascii?Q?IWJROLUXQlv/SCJVxZFGHJOxiXmyuThJkFCP+KD7Jfxm3Y/SKI5lidSG4FXg?=
 =?us-ascii?Q?c5cGyXxAm72k0XYjtIHw7AAcZp9dSemnvnyJ9E/kgmpkoM4ZGaa+BPgUzkrg?=
 =?us-ascii?Q?CG/K23f8lZJmUnUFw8afeVE/agPmy/TmzwscjCs1zRKidH+KjjTuGHiERFp7?=
 =?us-ascii?Q?0BuwZsGDu5/j3PHeDZvwJNfDkJbjsnUH/aUAFKYi3LVdXuhFe4/jYUlpAvZg?=
 =?us-ascii?Q?HPH4gYtP9bGaUB+4hfXeEpawpmLAbEOOHjs25tjPkjUkov3NmjpOAgoDVvLd?=
 =?us-ascii?Q?vSi0Ss9eYsScla0ypM8ScYiHvCUV+V1mjEsKTjU+QwcJPUGZCot9thFCViPX?=
 =?us-ascii?Q?kie+yPfiFQh7A4b8GP4tQ8alVYhbvJWiKPXcVrZtvO6DKiEPZWPDmCpjKWuA?=
 =?us-ascii?Q?24vanpAgFHIp9DkrIjgG0Z9v6iGONM71nAv04ljYT8kScxm0Oa0nOlNcr0OX?=
 =?us-ascii?Q?sCigrCQPq1es45Yw2BZeUKtEoeuHoNn0wrHilcEEcS1eaqRAkDuT0lM3QCEe?=
 =?us-ascii?Q?MVbiR0SuEXzg/4kpO07cWAReQmetQL4bTlzCKdVa2VogPS+XHNh0Vx43TtL+?=
 =?us-ascii?Q?kgxnr7Z+p++wmUJMUEmQuNJesdGJwwbkSZ2WnVyDHsYhJ3AHncCHulESPvyO?=
 =?us-ascii?Q?baEsUHuUazrWY8qEUiod/mF6Vv3iJT+P5t/7/TMrcUg0SHdEhNf5oxiAL++o?=
 =?us-ascii?Q?IXwAQAeoeRRfuM3nO5FheI/IpC3mp9RE0HA1iP2QVLvcUxbJ28zn6r3pL5Gn?=
 =?us-ascii?Q?EShbTjyNFFPMWNT1r04FgqNU/rlb9vXqPHHZuGSaS8dGF35m3c0hof5V5aSe?=
 =?us-ascii?Q?rv65xrteDJqJ5RfDZ3s0OxmGmwItz0bqF0ZYe56aHsIZhuBGoMIesW6jnbp8?=
 =?us-ascii?Q?iD8/56+K6mHi8DMBaEm36t4voTgJDhfDa7Hl0GCj4ho0A/9ialPndhxo44jY?=
 =?us-ascii?Q?pDQuX2Q4jjmUHW74WtJotJqz+H5j24KtvBYJEEv9Cljwi/OD6lOje6J1BLeJ?=
 =?us-ascii?Q?Mqi5+4bOPMtpaxpAVk/rJ3+DyzpSctQPfEkKjQmEpJYuP5IisYwaxAiGvRgR?=
 =?us-ascii?Q?RjihJGagNuvGiHOz4ejSsMIC8aZgRFCV87mrDZ65VrK8o4W/9c267J5bERkw?=
 =?us-ascii?Q?gKkAlcDID+Wl0KwR77iWA7cvhCZ0HJwdeU0yC+eV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sonifi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR16MB2844.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63878f7-0b9a-4703-abcd-08dbb91b2841
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 14:17:29.3495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d7d50e09-0988-4b46-977a-bbfbd3e792a4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQBiKJAawCBxHWu+g6QzYnQKDfm+iXHSI/eJVPXe3WyAr9Na1zccibzL+NaN1RkVF7OFAHaESMc41y88Zy8DBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR16MB5360
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recently, I discovered an issue with a PCIe device and recent kernels.

Background:

	Using a Linux host system, the PCIe device, a Torrent QN16e PCIe 16-128 Ch=
annel QAM Modulator, is passed through to a FreeBSD guest.

	Until recently, this was working as expected.

Issue:

	Starting with kernel v6.1.16, when the guest domain was started, the kerne=
l would immediately report errors via vfio-pci.

	kernel: vfio-pci 0000:65:00.0: vfio_bar_restore: reset recovery - restorin=
g BARs

	The guest would boot and its driver would load.  Then, when guest user-spa=
ce, would access the device, a PCI system error (PERR) was raised,
	as reported by the impi event log, and the hardware itself would suffer a =
catastrophic event, cycling the server.

Discovery:

	After researching the issue, I found the commit that lead system error:

	https://lore.kernel.org/all/da77c92796b99ec568bd070cbe4725074a117038.16737=
69517.git.lukas@wunner.de/

	Specifically, this removal:

	- Drop an unnecessary 1 sec delay from pci_reset_secondary_bus() which
	is now performed by pci_bridge_wait_for_secondary_bus().  A static
	delay this long is only necessary for Conventional PCI, so modern
	PCIe systems benefit from shorter reset times as a side effect.

Resolution:

	I reintroduced the 1 second delay to pci_reset_secondary_bus, recompiled a=
nd installed and the system is now working as expected.

	void pci_reset_secondary_bus(struct pci_dev *dev)
	{
  	 u16 ctrl;

	   pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
	   ctrl |=3D PCI_BRIDGE_CTL_BUS_RESET;
	   pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);

	   /*
	    * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
	    * this to 2ms to ensure that we meet the minimum requirement.
	    */
	   msleep(2);

	   ctrl &=3D ~PCI_BRIDGE_CTL_BUS_RESET;
 	  pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);

	   ssleep(1);

	}

PCIe Device:

	https://www.videopropulsion.com/content/torrent-qn16e-pcie-16-128-channel-=
qam-modulator

$ lspci

0000:65:00.0 Multimedia controller: Genroco, Inc Device 0004 (rev 01)
	Subsystem: Genroco, Inc Device 0004
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 349
	NUMA node: 0
	IOMMU group: 1
	Region 0: Memory at e0e00000 (32-bit, non-prefetchable) [size=3D32K]
	Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [80] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 75W
		DevCtl:	CorrErr- NonFatalErr- FatalErr+ UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <4us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- =
OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- Equaliz=
ationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
			Status:	NegoPending- InProgress-
	Capabilities: [200 v1] Vendor Specific Information: ID=3D1172 Rev=3D0 Len=
=3D044 <?>
	Kernel driver in use: vfio-pci

Regards,

Chad Schroeder
