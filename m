Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765EB7C9F0F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 07:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjJPFof (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 01:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjJPFoe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 01:44:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99603D9;
        Sun, 15 Oct 2023 22:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqkE5+Y0JUDWD3e5cPqGn8Vt+QvQWoXQbkX2S4jjOB5/976n5T/7BXD3bEkJIo1ARPIvfYBlvoh4fhdgYqpy9CO10spHgaSdJWormRCY3qM83gfZgydvzPerJSs59Xl/B39J5N7ppMnvLJomuGOE1FzjVltYDZTazITL1zXpr2EXEDqA47HxfASnM7r3IQKGcvgrC6AxSJERE/o16Lnp0k2Wsek4+SyOUVSfXyp7lZzIzkVFcZVjbww0/9GIZ4gzpFdd3ABbfq4VtXe4GGdS8Rbgb/E/3eS65NYb0/7AsUkdNxO1u4KEBA8Xn2MW1raxD4UlMl/+EUAjWvZ/m7sA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruqjokg/FFKI7YjJ66M+KjzP14+7ETZwDK3MLMFWgE0=;
 b=gP/+qdaRAMIKTOQ04ocvQrkziWtGhfKRbgD7pm6ZftKBGXg08bb/eQhYPYJxJmRu3lJYJIrLnhLBqeXqz7WZSIwytAMgFYKOmVcUs6NgucJ5pgTx3hbnUKND7M22bUp6mWJEp7p1+22tXRjdiCXZ1qaJWa2gNk6pAngm5+72scwIUfHVUgJ5WuBjw/1eBFQeOyuC3eqRgRIS9w7NOouyJFCfbketMCvqkw4/wtbxhWePHKQxglHqf4ttdxJIDJDtWeppBJy+sk9y6i8RG2heRcBp0l9fdFamekDkamLmhCkjOd+aFu2NnRvcS6vMyj46Opzw0/ECvP7L3LKRFzQmkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruqjokg/FFKI7YjJ66M+KjzP14+7ETZwDK3MLMFWgE0=;
 b=25+pwCqC5bzledG69Kp4bfD2uF94qJoMYI25bto5dQWu8hfg5aXwkDXdtCqz8VX0s9eFDE9ZvsXam4gb7Xmp69lFV8HwFWIYwx/JYc334w7JABIHWJGX9ACs/o8wPvSGyVCjjD46vD6dEt50eJqEvBT7ZgAt299A4Ml10Mfg7pI=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 05:44:28 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::167:7f5a:82a1:e2b9]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::167:7f5a:82a1:e2b9%4]) with mapi id 15.20.6863.043; Mon, 16 Oct 2023
 05:44:27 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v7 RESEND 0/3] Add support for Xilinx XDMA Soft IP as Root
 Port.
Thread-Topic: [PATCH v7 RESEND 0/3] Add support for Xilinx XDMA Soft IP as
 Root Port.
Thread-Index: AQHZ9iAav8GpnnhtikuLDTUsy/E9P7BL+v3A
Date:   Mon, 16 Oct 2023 05:44:27 +0000
Message-ID: <SN7PR12MB7201035D9E8F21AB4E2B52038BD7A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20231003173453.938190-1-thippeswamy.havalige@amd.com>
In-Reply-To: <20231003173453.938190-1-thippeswamy.havalige@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DM4PR12MB8558:EE_
x-ms-office365-filtering-correlation-id: 62987295-1e83-497f-fc80-08dbce0af60e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fiVi2BYUjECVHANivVTNO2B2oo6YpqwaWCFmbLMcxeGpxVWvmt0LjV8iMEHR8D+/og02uTuW8SONum1OBq6UZ907ecERh04yuOejZoUBkV9KdIK9aaRJmHCPsT14JFTLHAP2sGKguT3ky4do2muDwSnMeYrw9Rg7o5jPx+BsvCX/TkgQpFErd4Cs3a81i7oD7cXdjFLmQwDQhAogSlMfqcahprzT4HETXqdthM4uQqF51O4w6Roifk5plyIAtngRcwvsAmGF4I5VKLG7B2euZ3gMJEV+edwXpHMYgIsPzwGM9qFOJ1+SzMV5vkzPM8rHkWX5aeO8vUmS/DKsYQ2gqh2ZwH9qS+kDCRypdYCPuG8Jn+o9JqX5B0xhmegWAT3SFwHNj+jM84qLVnlF4gYerYn2u+LPR+ICLh7YGwMusjUVqHKwXmu37HphM1flRFuJDUT0fJzUedOSI9ROsL81HT7sJzWqajR02zqDgPcin/7LFU2SYq36T2ARo3hHBpiDrBEgr2q11w/lMYq11tizPpEeFB1UApNsPrXoacKvzOB13lXSPcLEDLQoQm/84teKHdXx/7V6PYTdRfBqed4HT3L0p+j6aqvOX0SLYShu3xoxhGtRHo/rGt/ZDO84DXlJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(478600001)(76116006)(66946007)(110136005)(66556008)(66476007)(64756008)(54906003)(316002)(66446008)(71200400001)(83380400001)(86362001)(38100700002)(9686003)(26005)(53546011)(7696005)(6506007)(33656002)(41300700001)(5660300002)(38070700005)(122000001)(8936002)(8676002)(4326008)(52536014)(7416002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+M8dAuv8ka8Lba+oyGkZgHSAvmcNr1bTXlEt+8TlaBEO2ooRGCsndzvW4QKf?=
 =?us-ascii?Q?KpgXYhaNvrli0BrRyWuYvp2vq9Swu1cpCWxrgg7ELKXPF5qmniPqnoH7JjEv?=
 =?us-ascii?Q?vQZuYfZBljxoIz6QQmtOO4s+XRp7Si3AOpP8/nydzdlEaGar4APl4i5DAFFc?=
 =?us-ascii?Q?hu4s36XnPtyhN8LvibmEggol7ZLgix32ZwD+UBQi41C30JEV2otZAIBc8IVX?=
 =?us-ascii?Q?IH6fmPpOmwLcZn+O1Ux95pyL+hrLpKXSDrbRM4q3nf0od9oCe+QhR6GDn9b2?=
 =?us-ascii?Q?4p5wmHRAfm9SJFFt0x68AkjwUU6lUsuVW4d6EbZTSZ5yC9Eo6JOumjzFyPYQ?=
 =?us-ascii?Q?2Y6w62YZn6zDk9VUnxwFWbfAZBpHfO6am3fO449BM54bn0vT2WV3E9XfFIQe?=
 =?us-ascii?Q?5GEGuDUEcKSwiNTYQaj463pl+wSNX4eSIpSh3oivqbmRg5QvEPmrAlpND1jG?=
 =?us-ascii?Q?dvFrCUSXkZpjfq1NzcnPzoc12QLqQC19M0F3zYtt9F8qPHf5WsB0SV2VfLn3?=
 =?us-ascii?Q?1cAPAJX21xsiUtOWOdU5szrN7LtXD0ELnBzidq7z9YP+YzTqxBf4uFtVr4jb?=
 =?us-ascii?Q?/ScxvjNDVUnEcRhGI3M3aaQTdeA+zdm/aAkssx0Uz4iQcqpVWo5cGxjcVuUd?=
 =?us-ascii?Q?WUZDVYt1zNnv30tebc2ZWdE860nYaasIJ3BIxEJX8djk8OtZFDMNUC66R4a8?=
 =?us-ascii?Q?1L9JXiwo4nbymcNszYC1VDWwq0Kv2cX7xa9y3HyqDWpwM36YkfE0jmAXi7fN?=
 =?us-ascii?Q?s25gG4kT6MlMbUICWxHKaE255jn8QjXLGMDN5JHYyy4RfomSVnKwUIsnxxkv?=
 =?us-ascii?Q?K1hf1acGVyd9naHr8tOulqUPmwSvFHEHzjwrN9Kvc+KfpZSOFKotlLeb4A5s?=
 =?us-ascii?Q?KKN091aNq/Jp6jWXtvgGmUrL/X5wJrcsb+dYVP+QajS2L4k1NY+ut0UAEjek?=
 =?us-ascii?Q?y19qVxahYgCMISlTw66K5hmnmKihQb/JeGR1ZAH5l5PtnNklRSvgB+8WqmOC?=
 =?us-ascii?Q?lFNuhAIAIBV5RdoVeLSjUhj7ggcHQwvHh+l0PyYzZWSHxbz9gSC3yIfg2CHY?=
 =?us-ascii?Q?mCLtgXAVK9xR+7NmZQdBXKsGt1VU2PXLKG55dSG9QckX1lpgf1NLMYcm1Jai?=
 =?us-ascii?Q?GT1CCfzNqQ+JHe5osWn184MECh82gSlHUxhPv+0CmpLb1sOd8gWBvDqysgd2?=
 =?us-ascii?Q?pHendDneJe5fzRmX+rwUD2d0Ed+W3lfmi2LwzWI3IYVQtBNlGzbETbSODmls?=
 =?us-ascii?Q?AKdDNDmcoEZT6mQ9AD35oVHlUBUCD7SJ1HK26rJktBCQBMSZF3iMbzUrP5dK?=
 =?us-ascii?Q?CNvkQLF93MFVts02yg3Zq7d0MC83AbUDwBiiP1dSS/DYIcu6EQ+imiOXdmA9?=
 =?us-ascii?Q?1cdvzLj6yb7Efa7TCKJSLzFP7t1/TCkC1CSSpPKXQ4pbl2dRH2MPhyU1FR8d?=
 =?us-ascii?Q?njhSnam8aZ39Ngff1wSp2sebdEyVNy6wSQvVi7J7aokoWLHewe16xNDaslcx?=
 =?us-ascii?Q?lFvYw1Z5K/poxjUgVst6+iSRKm/Misq4bOLEuGLH2KfDZ1NQ7aVI6tyoEILt?=
 =?us-ascii?Q?F18q7kniolnV1D2XG78=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62987295-1e83-497f-fc80-08dbce0af60e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 05:44:27.5979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUuc6wjLoRXN1LkTHUugs6Nh9xQVXQtoTcY41ZCRjWLbu9dELpScFNQOsxJLrBqliOn/t5qbIvaiUNjxMEw5gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn/Lorenzo/ Krzysztof

Can you please provide update on this series.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Sent: Tuesday, October 3, 2023 11:05 PM
> To: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> robh@kernel.org; krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> Havalige, Thippeswamy <thippeswamy.havalige@amd.com>; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: [PATCH v7 RESEND 0/3] Add support for Xilinx XDMA Soft IP as Roo=
t
> Port.
>=20
> This series of patch add support for Xilinx XDMA Soft IP as Root Port.
>=20
> The Xilinx XDMA Soft IP support's 32 bit and 64bit BAR's.
> As Root Port it supports MSI and legacy interrupts.
>=20
> For code reusability existing CPM4 error interrupt bits are moved to comm=
on
> header.
>=20
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
> Thippeswamy Havalige (3):
>   PCI: xilinx-cpm: Move interrupt bit definitions to common header
>   dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe
>     Root Port Bridge
>   PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
>=20
>  .../bindings/pci/xlnx,xdma-host.yaml          | 114 +++
>  drivers/pci/controller/Kconfig                |  11 +
>  drivers/pci/controller/Makefile               |   1 +
>  drivers/pci/controller/pcie-xilinx-common.h   |  31 +
>  drivers/pci/controller/pcie-xilinx-cpm.c      |  38 +-
>  drivers/pci/controller/pcie-xilinx-dma-pl.c   | 803 ++++++++++++++++++
>  6 files changed, 967 insertions(+), 31 deletions(-)  create mode 100644
> Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
>  create mode 100644 drivers/pci/controller/pcie-xilinx-common.h
>  create mode 100644 drivers/pci/controller/pcie-xilinx-dma-pl.c
>=20
> --
> 2.25.1

