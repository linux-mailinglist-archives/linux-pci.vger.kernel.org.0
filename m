Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB8C4CA0F7
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 10:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbiCBJip (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 04:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbiCBJio (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 04:38:44 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD9F3701A;
        Wed,  2 Mar 2022 01:37:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ3elwJxEyD2tiXWiQbMYQtjuk3hFjtAMKu8o8E35cRRF3czzJZ6yGIqVFVlEko9Zc3VtSYWjmBLZ4qPyvm/csvSvH6nlUwSJB44Bu9/nF9iCiGlTzlQ7ijPsav2ilpujbxkaj0RVeBU+KcGKZVJEQa4GpieJaBNBBTfWYX5IH20LcQ/7gnx+siRXUkMveRk1SdXhxDeAnAhFrowNW7RGNohDsBEsQcJUseut8dZMe7cIsFP1BoCII4aQuh0h234smUr2FIga3iCX2WLkkrI6XGvlcaIAocmp40G0pev5K0jvUHJ0Y3HEuzs3XYOBeVwfZ2COzIEAMq69o7bidJGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCP4yt9FV1ENCBB9jP2kVhgt1K95mllS52F3er+HPmY=;
 b=ndojJDjbLI3U6wVKbSGcVhCa9n7Inc1jv+OhnmKtd7FjO5dexjUFD8Hva5oSe3KmknW8lZ9ERf4ULkya+IJhi0dZxQv2sHLMr2GwRyMRHW1sOiQENC6OUEz0RThUW2oLfSDN/UBb633/W80EALxtQJyP/EUmf2uNEVUPDkkfnme2aRxbnq5bTFCXhLjbAUIYPWU9h0LPuAgEldybdD7Ysxqj91lsyyCGc+iFT7DqtRw6qCCJwBNOgSeCVlW64X5rmD7Dk37xG7+uDl6ywMmYMlZi7SuM6UPpO3FI5k4KET/vKyRbdm2DxqjacjVw4ZDgl2aYrSx2QAQkRbWEcWbxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCP4yt9FV1ENCBB9jP2kVhgt1K95mllS52F3er+HPmY=;
 b=WBwiEYZ8kX68L3A6ltNE+rnE32zcgu+4+3SaRotHFdlDjxdezoB8btsNbBY7Tz22tkvC43Fcq6eD2a4whCn/4Fc1yVa4TrfZuzNiLBLKnrB7GbpCVxbX4NIS+L6415GP8hAoC6XaxtZ71Gh0WTRAH3oshmwLVPph2veIrkZCdhI=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by CY4PR02MB3190.namprd02.prod.outlook.com (2603:10b6:910:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 09:37:56 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::5898:b7fa:9930:10a0]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::5898:b7fa:9930:10a0%7]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 09:37:56 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [PATCH v2 0/2] Add support for Xilinx Versal CPM5 Root Port
Thread-Topic: [PATCH v2 0/2] Add support for Xilinx Versal CPM5 Root Port
Thread-Index: AQHYImoE3pb2GFdwQUWqg4KWDgZ5cKyr7YRA
Date:   Wed, 2 Mar 2022 09:37:56 +0000
Message-ID: <BY5PR02MB69477EE1159C7C1DB1155FE1A5039@BY5PR02MB6947.namprd02.prod.outlook.com>
References: <20220215124606.28627-1-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <20220215124606.28627-1-bharat.kumar.gogada@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1135edf-a89d-4aff-4c4b-08d9fc30550d
x-ms-traffictypediagnostic: CY4PR02MB3190:EE_
x-microsoft-antispam-prvs: <CY4PR02MB319069F59A2A09643713E100A5039@CY4PR02MB3190.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CP4t2SiUdo6K37x5fijJnlt/SW8EAxQcXMRpSl47ZNbJEefo2Vuw4BI/qmXxP31AGbxGcXeBTfcP10Q/AjbqLRA9G6lJLM3MywYPfZhRTmA5/aQSTVgh7C0e/sYtNCJxcHcSfgmIZBVLWD8Hvm/u3DSEoA9s21crq8NfY7nYWGfmUi/4PdhUwztLnDsmA4SDob9s43uwYvdc5LVD35i1YPnVQWMsuI10n4tAFu3EHM0iotoKSZM/u85GelM/6i9AU4Oiy6huUR0c0+wEXiJEDADPzQwhIaXUSx35Nb1CR20qdR1TjHnt9kCgfgAIyQM1qnErNBd/HbjMlyvmA+cl2ENEm40v0Oe6mGytA6AIgfzTFM3g5stYe5UXIm+GpqT146Nx5Zp//tRjRhE2NBunNUidDiDAtwJOwMLJWYJEvK5ZZ9rwkmcGqvmbPYViVNdldWXpYs4GeGUy66e2nVexQf4cZYp+goQ0fueUQoEWMU8h/mY6NZExCK84LVvKb9mI8CEWnWbnqoFJtTBDuWL/bojSTOJtEPmsOwyINg8Zg+6ihNwJQ9HzDT4mRfrAR52G9UFvfzEAYRXHOzFB7V2BUtd29jtdE7U5pzxT1BPg4HIPpLjcSTX3NM6X1m1mBT/zX3LRKiKheGA8xEqC96RUXD8W6+4c/J43MVXZ5+9OcNqefmCFO763QIWZkbOCrcCUON0LPJ+uN+BrpBmVkhs2tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(76116006)(66556008)(64756008)(8676002)(4326008)(86362001)(316002)(66446008)(2906002)(83380400001)(33656002)(107886003)(55016003)(110136005)(54906003)(186003)(38100700002)(26005)(122000001)(8936002)(7696005)(5660300002)(53546011)(6506007)(9686003)(38070700005)(52536014)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?35AqI//17xogsrMNFw9e7+oT2Dm/1BXYt0IVaQPKz8NFGfnawni4L9m8ijA5?=
 =?us-ascii?Q?EG3GJCf3R1Hftv63fCL7SYX4v5Qe/J3VToAqY48D8Z0HI2qS6wqRuGYPBSDV?=
 =?us-ascii?Q?reQJDhLgwCLUwYlafsPNwbpdk8xvcflVrVV+LPfGAKLVKwvp5w08gRUYi4/q?=
 =?us-ascii?Q?RSb93k8jqDKB21i7b1Ypl0Zqf92HLJIIULV9bOyOuo0fWOUJjEe2U/P+1+uk?=
 =?us-ascii?Q?IUz3VkHvgxIPNOCY31vfpSm4fPmIHpQOy2BuLtDufSb2sKHK1sRuUvjiHvDr?=
 =?us-ascii?Q?M38FucRv2tMjZO64iXov1bF8SeFll2ZCGA3xeKLn6c6nT3NSWiw2gQYBuW8y?=
 =?us-ascii?Q?G3gRPQsVTDDIuWGJmvtvqvgCJ65Z5w5vSQM6bUxjrcledyTaXfioDjoE1EsD?=
 =?us-ascii?Q?l17kfrHZKbn5mrvBTYcJJ1TyOZNt88am7EY5EiSOoJrL7qWZKpKs25SwhCsX?=
 =?us-ascii?Q?U240IL1rI/f1XRNMrD4AkzaVMZQfGNV/bOLU/gpxvzcTG4MKWcwNJB2EfBd0?=
 =?us-ascii?Q?ui9aRBjR85sG6mkS9ybzbh8s1NeuMudEFjjtA7teKYOL+mdY1yX+SnS6e4kL?=
 =?us-ascii?Q?TOA5C4PcGPAPcjBnd1HPdTeG6AeesQF0lwvL10bVnEXnmS0Ax/mKojPBDZb2?=
 =?us-ascii?Q?to6dj+otgaCmJ7m0rMy0VYFHPABGTzGio85nx7fZqB0ANOiYaj+c3guZNKON?=
 =?us-ascii?Q?DGBFzUddRyrcaUQm+TVowAzXD8okNYV+8hARBrxbYNMQ9DqT6HyX90tfxqwS?=
 =?us-ascii?Q?7ZJIusc8zmJe4AlSaXfe7q7YX0V5m2kd+dYVLBrxKzQCxrII2I8J+BC1OU/Q?=
 =?us-ascii?Q?xP9wBjN6TswDFiaXMMeRRcueIeLdSISEU6LnpcHHGEfdl3lSj2AM0LxniWow?=
 =?us-ascii?Q?esJuqfHK14Hqgvy2Q6w3i7XAY8b+99RrRnGaZq6ZCT/lK1iqzYDhCgqtVsuh?=
 =?us-ascii?Q?4Glb09H5SiaZdIokkXPjhJodES8bkZe+Sac6sNTrq61IdaZK8YLQ8HfBXJDN?=
 =?us-ascii?Q?MWFahLTPav4mgqsWVCpj0j2PNUqpGy+q6mqVnOkOGEIRK9fdvvuPaXzCMX1N?=
 =?us-ascii?Q?QPFWKHBTECZGwtqAp/Aq07YC4woczjeYwcTJ2pqq4/o8o28C2WppfJx1hkez?=
 =?us-ascii?Q?7nKP7052ezG99+xMlUKigSCj2n7VikSAg6dfPyJx9zslEZ7c+bCV/TlwZfI9?=
 =?us-ascii?Q?+S4BgmfWu/jUtaNo5ryaxE8zvHM0JBwqgSRRVhtjl6j6Lro8kanztHE65jEl?=
 =?us-ascii?Q?F3WzQXEZkooEtSsc9HeqRALE4XIyW7aTlA4zpRHeeTmSdHCXGeLbYiyQIKcb?=
 =?us-ascii?Q?Zb4xJrxBM1mi5L8LB0KMJE6y7easEfziFODx1ETTWWy89/6wUL9LO5IDcBxf?=
 =?us-ascii?Q?cgf6MSulSJYltM6qyHyrex0M3T3jmX6bkrtYVCRSoxt1gH1UhRLT64LbpXmJ?=
 =?us-ascii?Q?tBwk+i2C4XYWp952b87FpX/XFf/JzKhNhAnKwMD0GCCi2ZTAdkKFrKBFpuum?=
 =?us-ascii?Q?EZUvSIz4teFcroCmfqQ39Ho4W44sd6TaWzENQAVeZ4Yt68tXaM9zpP0wmtu+?=
 =?us-ascii?Q?RuqkOkbCpL9t9xNyPjXRA/UczN4Q+Wulx0LaiAB2GQzBpRv9pwPKHgZiL+6X?=
 =?us-ascii?Q?oGF6RxXOp7sdgzsW4XMNV/Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1135edf-a89d-4aff-4c4b-08d9fc30550d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 09:37:56.4106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CdDQRoNGzG9MnBCAumN3OdJopiNeVapXDrkvVPpTiirIevYMUza3l+MIU+LAVGUxPNGGdW9zOlD9gEebIn75BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3190
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping

> -----Original Message-----
> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Sent: Tuesday, February 15, 2022 6:16 PM
> To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: lorenzo.pieralisi@arm.com; bhelgaas@google.com; Michal Simek
> <michals@xilinx.com>; Bharat Kumar Gogada <bharatku@xilinx.com>
> Subject: [PATCH v2 0/2] Add support for Xilinx Versal CPM5 Root Port
>=20
> Xilinx Versal Premium series has CPM5 block which supports Root Port
> functioning at Gen5 speed.
>=20
> Xilinx Versal CPM5 has few changes with existing CPM block.
> - CPM5 has dedicated register space for control and status registers.
> - CPM5 legacy interrupt handling needs additonal register bit
>   to enable and handle legacy interrupts.
>=20
> Changes in v2:
> - changed commit message.
>=20
> Bharat Kumar Gogada (2):
>   dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
>   PCI: xilinx-cpm: Add support for Versal CPM5 Root Port
>=20
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 47 ++++++++++++++++---
>  drivers/pci/controller/pcie-xilinx-cpm.c      | 33 ++++++++++++-
>  2 files changed, 72 insertions(+), 8 deletions(-)
>=20
> --
> 2.17.1

