Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E51710506B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 11:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKUKVo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 05:21:44 -0500
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:46145
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbfKUKVn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 05:21:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORD4aowqkMClf9cIsE7Xy7Quv0EOBTDG8ZeQyj9MfHu8a5z384jzflPu1oLcJFGRFipbD3WSFjTe/WtFWZXejWky95zP+AA2LOryq1pxxistzU0d4RrDvAP4hJ+ZAQm3ZBxaycmSb6evwoE3OLr+IXSZ4oW1LO6ZYSTQMFo3J3vkOWhw5QBlNaw4T8P9GOkC5zhlGuGTHGPmID3OzayvOnn1qe0jEDCD49u+ZqoUupXiQ7MR6HqAu6RRHnuYIAVmR9H2tL6ynOyQl1SosaaDppE6JDtOW8COcvA6y/WNYWeJ2hfUQT2DMG15batSEDFqZOhen2bC3pGX+5mOif1PSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8hc+28gH3bqU4i5ZcAFkEOq1J6VWbVZ1ypDeqe9WWY=;
 b=e4j4mUTGM8szk0rzzfLV4uYpaAG64h6AVCw+AyuljB2nixsNBi5MBWg6tWcrjDZ1XdiyeKLzFjeSf8oVOFIlb5posuzHBtfe9zb3m4CiWaTzj/s7BLEuttTz9SO4zuWGugOoqO5i8zeyipGtOU9vPUKGe3NgMSXQsiF68KmX1i4kIDjdrr2uyn8uBwoG2KpEEagiwSGDvFGG1OkFPR/843SLUrIG4A+XCs9b0CnzoG7RWd0XVlOqqT0CBSOXKCkCnEF05hx2wyh4J+RA3yO67i3CajbfVCim2bfYDuJsUwbCKn4Q8PmdqOkPm4ocmTZEDR7Cz72YW1UBmVcAaRrrPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8hc+28gH3bqU4i5ZcAFkEOq1J6VWbVZ1ypDeqe9WWY=;
 b=s40Y17sZ4ViICQHgIPqhgTMRTuXVrwCnCr+mcIRgj188WVuuJYuq0K4MHvLsQ797iiCu6zjsx0t3vmzusEIMBHe8wTUWgMpFOcw9AbQ5voNJQmrGWOijvAw6aGr/7wNwAE2ZV68SeCKh5eAMofpcO/37RSXdPigJqOiwQXRh0R4=
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com (20.179.234.141) by
 VE1PR04MB6703.eurprd04.prod.outlook.com (10.255.118.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Thu, 21 Nov 2019 10:21:37 +0000
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::e5e3:ef9:4ad0:ecc]) by VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::e5e3:ef9:4ad0:ecc%7]) with mapi id 15.20.2451.032; Thu, 21 Nov 2019
 10:21:37 +0000
From:   Wasim Khan <wasim.khan@nxp.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Query: PCIe Interrupt handler support with ACPI
Thread-Topic: Query: PCIe Interrupt handler support with ACPI
Thread-Index: AdWgVUVbudBBk8n6RQWK9roXbj7qOw==
Date:   Thu, 21 Nov 2019 10:21:37 +0000
Message-ID: <VE1PR04MB67029FB127DBF4A725CB9698904E0@VE1PR04MB6702.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wasim.khan@nxp.com; 
x-originating-ip: [92.120.1.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78f60045-840c-4d61-9288-08d76e6c977e
x-ms-traffictypediagnostic: VE1PR04MB6703:
x-microsoft-antispam-prvs: <VE1PR04MB6703F3ED3616FB3B932625AC904E0@VE1PR04MB6703.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(2201001)(25786009)(186003)(66066001)(102836004)(4326008)(14454004)(2906002)(3846002)(6116002)(33656002)(6506007)(478600001)(99286004)(74316002)(6436002)(2501003)(86362001)(52536014)(7736002)(76116006)(66946007)(64756008)(305945005)(66476007)(14444005)(256004)(66446008)(66556008)(5660300002)(7696005)(81156014)(81166006)(8676002)(26005)(8936002)(71190400001)(55016002)(54906003)(110136005)(44832011)(9686003)(316002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6703;H:VE1PR04MB6702.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nhYXzacw0M0jlYP6jkke6wgxnYsS8Um9mbnVqtThnB+4Kp1PIk+1cjRDpySNvAOXOYdbjvckqRmU2NivJwtHplQ75ZA2av/DTYov/xEKMQMrdWmEeHuMr8o0Hgy87AGQ7WF8SswXzQhHE4gLCYXLrEy/ZXIWeGvui3Nr0nWSYKea4zRAj2y8nLJJkCDKbVONU/AqYs4p68cyvee5xhAyGJ6xQ8y7/MccG7LJ5iLAHtBwRGJraupTsj1waEkWQwXEcui/4CJld/xNoavgW0/EF8dahSKC2gu7jlsZkBS2eIzHdIxfxAc9DQjgHNo+J+iFcrbIevU6EwTLvnIqLuGsXgBMueW6LY3SckPlCvuDZ1r0Roae1UmsgZdnEdMFlzCAf5S8lTa/TrkN99ymODD5y0L9xbh3e0d6chfI1/kzE98UZvbT3wqYE8R8w+VNfNsb
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f60045-840c-4d61-9288-08d76e6c977e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 10:21:37.1093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTtgdiWEzB7u/gkH34kwZvm6OKYsjV5a7eGJ3xIDdRtDsgbdXeVW1GChrS5aSRGHQ03GOdvAZhLH+gfRHMMBbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6703
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I am working on adding ACPI support for our PCIe controller. Our controller=
 is not ECAM compliant so I had to implement=20
MCFG Quick for our own config read/write/map/init function. After this devi=
ce enumeration is working fine.

Next I am trying to make the legacy interrupt work with our controller with=
 ACPI.=20
With device tree , we enable interrupts using below routine during driver p=
robe and we register our interrupt handler(ls_pcie_g4_handler).

static int ls_pcie_g4_interrupt_init(struct mobiveil_pcie *mv_pci)
{
       struct ls_pcie_g4 *pcie =3D to_ls_pcie_g4(mv_pci);
       u32 val;
       int ret;

       pcie->irq =3D platform_get_irq_byname(mv_pci->pdev, "intr");
       if (pcie->irq < 0) {
              dev_err(&mv_pci->pdev->dev, "Can't get 'intr' irq.\n");
              return pcie->irq;
       }
       ret =3D devm_request_irq(&mv_pci->pdev->dev, pcie->irq,
                            ls_pcie_g4_handler, IRQF_SHARED,
                            mv_pci->pdev->name, pcie);
       if (ret) {
              dev_err(&mv_pci->pdev->dev, "Can't register PCIe IRQ.\n");
              return  ret;
       }

       /* Enable interrupts */
       val =3D PAB_INTP_INTX_MASK | PAB_INTP_MSI | PAB_INTP_RESET |
             PAB_INTP_PCIE_UE | PAB_INTP_IE_PMREDI | PAB_INTP_IE_EC;
       csr_writel(mv_pci, val, PAB_INTP_AMBA_MISC_ENB);

       return 0;
}

Can someone help me how can I add similar support (register our interrupt h=
andler) with ACPI  and how to get the pcie->irq  ?
I am using below ACPI table for my host bridge in firmware (UEFI).
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Scope(_SB)
{
  // PCIe Root bus
  Device (PCI0)
  {
    Name (_HID, "PNP0A08") // PCI Express Root Bridge
    Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
    Name(_SEG, 0) // Segment of this Root complex
    Name(_BBN, 0) // Base Bus Number
    Name(_CCA, 1) // Cache Coherency Attribute
    Method (_CRS, 0, Serialized) { // Root complex resources
      Name (RBUF, ResourceTemplate () {
        WordBusNumber ( // Bus numbers assigned to this root
          ResourceProducer, MinFixed, MaxFixed, PosDecode,
          0,                           // AddressGranularity
          LX2160A_PCI_SEG_BUSNUM_MIN,  // AddressMinimum - Minimum Bus Numb=
er
          LX2160A_PCI_SEG_BUSNUM_MAX,  // AddressMaximum - Maximum Bus Numb=
er
          0,                           // AddressTranslation
          LX2160A_PCI_SEG_BUSNUM_RANGE // RangeLength - # of Busses
        )
        QWordMemory ( // 64-bit BAR Windows
          ResourceProducer,
          PosDecode,
          MinFixed,
          MaxFixed,
          NonCacheable,
          ReadWrite,
          0x0,                           // Granularity
          LX2160A_PCI_SEG0_MMIO64_MIN,   // Min Base Address
          LX2160A_PCI_SEG0_MMIO64_MAX,   // Max Base Address
          LX2160A_PCI_SEG0_MMIO64_XLATE, // Translate
          LX2160A_PCI_SEG0_MMIO64_SIZE   // Length
        )
      })
      Return (RBUF)
    }

    Device (RES0)
    {
      Name (_HID, "NXP0016") // NXP PCIe RC config base address
      Name (_CRS, ResourceTemplate (){
        Memory32Fixed (ReadWrite, LX2160A_PCI_SEG0_RC_CONFIG_BASE,
                       LX2160A_PCI_SEG0_RC_CONFIG_SIZE)
      })
    }

    // PCI Routing Table
    Name (_PRT, Package () {
            Package () { 0xFFFF, 0, Zero, LX2160A_PCI_SEG0_INTA },   // INT=
A
            Package () { 0xFFFF, 1, Zero, LX2160A_PCI_SEG0_INTB },   // INT=
B
            Package () { 0xFFFF, 2, Zero, LX2160A_PCI_SEG0_INTC },   // INT=
C
            Package () { 0xFFFF, 3, Zero, LX2160A_PCI_SEG0_INTD },   // INT=
D
            })
    //
    // OS Control Handoff
    //
    Name (SUPP, Zero) // PCI _OSC Support Field value
    Name (CTRL, Zero) // PCI _OSC Control Field value

    Method(_OSC,4)
    {
        // Check for proper UUID
        If (LEqual (Arg0, ToUUID ("33DB4D5B-1FF7-401C-9657-7441C03DD766")))
        {
            // Create DWord-adressable fields from the Capabilities Buffer
            CreateDWordField (Arg3, 0, CDW1)
            CreateDWordField (Arg3, 4, CDW2)
            CreateDWordField (Arg3, 8, CDW3)

            // Save Capabilities DWord2 & 3
            Store (CDW2, SUPP)
            Store (CDW3, CTRL)

            // Disable PCIe and SHPC hotplug, AER and PME
            // And (CTRL, 0x10, CTRL)

            // Capabilities bits were masked
            Or (CDW1, 0x10, CDW1)

            // Update DWORD3 in the buffer
            Store (CTRL, CDW3)
            Return (Arg3)
       } Else {
            Or (CDW1, 4, CDW1) // Unrecognized UUID
                Return (Arg3)
       }
    } // End _OSC
  } // Device(PCI0)

  Device (RES0)
  {
    Name (_HID, "NXP0016") // NXP PCIe RC config base address
    Name (_CID, "PNP0C02") // Motherboard reserved resource
    Name (_UID, 0x0)  //  Unique ID
    Name (_CRS, ResourceTemplate (){
      Memory32Fixed (ReadWrite, LX2160A_PCI_SEG0_RC_CONFIG_BASE,
              LX2160A_PCI_SEG0_RC_CONFIG_SIZE)
    })
  }

  Device (RESP)  //reserve for ecam resource
  {
     Name (_HID, "PNP0C02")
     Name (_CRS, ResourceTemplate (){
       QwordMemory ( //ECAM space for [bus 00-ff]
         ResourceConsumer,
         PosDecode,
         MinFixed,
         MaxFixed,
         NonCacheable,
         ReadWrite,
         0x0,                               // Granularity
         LX2160A_PCI_SEG0_CONFIG_BASE,      // Min Base Address
         LX2160A_PCI_SEG0_CONFIG_BASE_MAX,  // Max Base Address
         0x0,                               // Translate
         LX2160A_PCI_SEG0_CONFIG_SIZE       // Length
       )
     })
  }
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Regards,
Wasim

