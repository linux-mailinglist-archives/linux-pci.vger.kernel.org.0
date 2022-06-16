Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E706A54D844
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 04:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349354AbiFPCXn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 22:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350420AbiFPCXj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 22:23:39 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C99C47053;
        Wed, 15 Jun 2022 19:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOq7lU3A7DneaiwYWjF24gtRON/xaKhvHRcpGr0MCxjlSsdBMRmxFQHpT9j7+U3PbOa12oGe973QRP4DdpyUN5Yp49NLziS2LuYiuz+JV34vULxf+M6plxFltxdb36hu60wP80mW5s1HzHNkpHxVt85wingXyIeQ2ZCBm10Tt4O/G5MqTkrNYeJr9bsfWwte9Yq2oTf6DuF//ZNrbSUWs4/+V6UsJseVOBY8QdjZ/xknatT0ml7o1qiTDmwsgDl0qzZ5mRrF2A3yNj1qQ81e07+nEumxO7cUsqwATsNWW8D4yaxfXxSjROJMrWWrLxkQwR6LJslHyiDx/zaCcp4R3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L54mh8YCLIo9omEW5IzpvOIgB5UMeMwbu287TtMCmTg=;
 b=VyVIRpigfT8ZQgD7qVOkSpON/WanBY0FqorWBDV7hAicJcgYg9Eoqx7HI413bs+C0W96D+AD1S1d3NKxsl7GCKCNTACCa6iLxpmcwkF8H7S2v4E8sHOeiRY4TYpPfEW3U0I3lO6BlC8G+p2fBMli+XdxzSn8CMT/zEI8NR1aG/8v0dweApAG0i4jKGdMOllfMGL9Zk7rPI9SVr7XWyhUfOAUdceQXpRHkukyeOiSuYYuq0Bjtjx2RBuhpdLWSMH8zWFZPdhYFygcpO28rtb+q3KbuPr1gHdGKX5f9OK+a9bArVDYajS5cN7I2TpD4+kTAnDbpdT+Acbm1a/5Olql8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L54mh8YCLIo9omEW5IzpvOIgB5UMeMwbu287TtMCmTg=;
 b=d1zVCVmkEKByJ77+cV48wOwM4huOHbeM2LYBESbpVMff7ktAfChbBcUR+Y+6aWHNNvq8uYHNmoACmZGKRUxcVjq83Hf8GKt9aHQWBl7MzS+P0zVXDdqjGKZaQ2sHCNKnnKSVAjp9EBa8Pr26Pc+7dyJhTVVptOII4UweuyoUWpc=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 02:23:36 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a0fa:978c:2b40:2cb7]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a0fa:978c:2b40:2cb7%6]) with mapi id 15.20.5353.013; Thu, 16 Jun 2022
 02:23:36 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v12 01/13] PCI: imx6: Move imx6_pcie_grp_offset(),
 imx6_pcie_configure_type() earlier
Thread-Topic: [PATCH v12 01/13] PCI: imx6: Move imx6_pcie_grp_offset(),
 imx6_pcie_configure_type() earlier
Thread-Index: AQHYgQ3lDE1GJ2vmokykqIzDd52mrK1RQ5IA
Date:   Thu, 16 Jun 2022 02:23:35 +0000
Message-ID: <AS8PR04MB867681FD9A8043B982B7BB518CAC9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20220615231551.1054753-1-helgaas@kernel.org>
 <20220615231551.1054753-2-helgaas@kernel.org>
In-Reply-To: <20220615231551.1054753-2-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3b686f1-4fb2-4416-abc8-08da4f3f378b
x-ms-traffictypediagnostic: DB9PR04MB8252:EE_
x-microsoft-antispam-prvs: <DB9PR04MB82529DBA46B09665059536EE8CAC9@DB9PR04MB8252.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iirNz+ZDHrSQVozVp8lMwQl6oF7VwJtoo8UIDepyooodB5YaAY+RvjDKmLYV2BIQamCpZ9mX6w25JixIjeifZraAvQUKBAWoo1LXwPnQzgtwZ/A/HMsRMtlvhHGfDT1Vmh3fkQB0Q+lKz47oQxkrlae6ybq3KFNlrXD9wuHp7txVtCar3J+pdNDvN7fGh6BoyoHooK41Y268kmnQj1IqSNd0xwKapfDDKqKPoy8eWmqU8Qld/xVVKrnq/uu5kF3Z3tfM21JJW2reL3uqgSFoyep+ZdtpKyA0srgP8pLSvs5gkie/3+lSoG/dVSPqbFhGvj6efAprKRjpFV0pIkdG9xq3ued1PyhIfCGVTgTPksYxel1WHA326t98NZLUhA/ATwlW1GYFHfrFPb8xtcUvf8Kf98mFAqdpSIAJjccW/10kTMK1HUu8gOZSR1CvMRsJofNW74oivYib9ufzVrLVt0J9WYgNHr1cOeL1VGorWUEF8nA/Awj2oyFAnb96ipBBrUhUlxmhMRo73OP4pel2AnGPQuALFR9KY7SQOVV0jtYhatHDGlGtsLPkKpwD90Oy/OACnXHOTnwqitHOWZoAqbFRKKSMW5xDW8p5+23CRfHjWZwnMrAeAlvO0cnJMjTdLkltqjwvjKZrqZn1rqq7ghW4xNw9WkaM6fHn0cbh6AS9xWvyfNY3cCKtMNrZnG02jPt+rKQAjjsDfKv9j1EDjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(52536014)(8936002)(7696005)(6506007)(508600001)(2906002)(122000001)(33656002)(5660300002)(44832011)(55016003)(7416002)(186003)(38100700002)(86362001)(83380400001)(26005)(9686003)(316002)(53546011)(110136005)(54906003)(4326008)(76116006)(66946007)(66556008)(38070700005)(8676002)(64756008)(66476007)(66446008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MjR1SzdDNjViVXlSSnUrd0ZqZUV0aUJDQ3VJQmF6c2RoeTVNeFdEaWFYY0tz?=
 =?gb2312?B?Szg3azNZWDNXNEFFbDhhdE14b3N5eHVPOFhJQUptQVN4RjhPWnpJc3M0bGdm?=
 =?gb2312?B?NUxuM1Y5ZHJ1R1lFT2xWbXpISk5JU3JWWE1xbmhRbUtlakV4em0rSTJwaml0?=
 =?gb2312?B?TXdZM0JRK1VBZHN6Q3RVNlZjSFdRYzM3dDhKZ3RDU2FtYUsxdXpUN0dzYkpi?=
 =?gb2312?B?WmJGYmx2UzcxRVpVemxNb29NdXl6U3pmbXVLcnQ0NUtMaHU4WmNhL0I5Vlgv?=
 =?gb2312?B?WkVyV2VWa1lsc0owdmRmcnJkTm0wOWZNb3pkL0w5WEVQSG1uQjdqSm4yYStF?=
 =?gb2312?B?dzFPZzQ5QURPM0crVXVGZzJZSHZ2SDBWVU1UUXdqeEdYVGRvUFNDc1p3YW1k?=
 =?gb2312?B?MkNjUXFueEo2dTNKazgraEhaam1zOHk4eHBkbDhIZEViN1BJUjVDNVJ4ajVo?=
 =?gb2312?B?NElIcUtQVU1iSDdrQTNiWSsvd2dFNzJpU3VIS2dJa05DRG5Gc25SNjNJd3BM?=
 =?gb2312?B?Q3pHRllvSlZPNDBUT0hPb1V2Q0lXdk1JRW16ODBTVW9XTSthN1VtVDBNZGNm?=
 =?gb2312?B?SHRBTUhMVFk5Y3RVQ0JhUndoa0NkTDh6K3RiaGc4NjVPd2t5WVZ4d0xHNVh2?=
 =?gb2312?B?SEM1bXVzanpQdjBSc0JKMUlZTkJFUC95N0VMa3dTek85NS9ldFVjaU1KL1kz?=
 =?gb2312?B?T2VabDBvdGRSbGdOZTJ3ZjVwZzhjZDd0NVpDRzJ0ZFI3RXR3Qk9WOVFiK2pa?=
 =?gb2312?B?bktrcGNoN2RKaW11OGNpV1ZBZS9PNnhLZzVER004MlVuK0dFdEl6UUppVzNj?=
 =?gb2312?B?YXJOOVhybUZVZ1h1Qmlub0N1QXBkVkpIeVdDdGQwT3N1MUpNUFNFaE1MNjQ2?=
 =?gb2312?B?akU3UVVSMVc0RWxhSTdUa29mQ2ZPVFRPdkVwVk0xdFpkSWQvRi9xcExkS1Ra?=
 =?gb2312?B?QjgyMk9iRDNiWmFOL0pqSXpQYXJvYk5pOFAwMHp4dzUxa2JCRUhjTjR0M1c3?=
 =?gb2312?B?dmRLcVd4dkxDVXpScmVHNGtkVTk0T1l0YlREaFdEZ2lKRm9HZDBvbEdUQjlh?=
 =?gb2312?B?MnhmcGxENHlLNE9sZjVzemgyaUlkNUFhSGkycU80OGYrZGtEOCtMQUhDa0wr?=
 =?gb2312?B?Z2ZjS1c0QzBhc0pxTkZUeE9wL2JScUFkTEloampMR0ZYVUVGNDVyaytLMW9T?=
 =?gb2312?B?YmZObXUvRFVWbjhvSFB2TW00TENhMWNyYUFEdXl4elNEZFdBM2YvV0lYT0s1?=
 =?gb2312?B?K0FmaTYxc2RuRjdOU0RaZzNVcTJVRkQvSVhSMzNYYzlaRnUweWM1L0taZXBS?=
 =?gb2312?B?OGJWRStoZnhRU2ZWaXZzUSsxWHN1MTVON1I0WmtwTmJwak1yQmYyNXJuWHoy?=
 =?gb2312?B?ckhOMjdseEd1cXg3Nm8yTGhvRTlCWVpKVGl2NjlGSUc1amhWQzNiNW9relg2?=
 =?gb2312?B?a3E4Qkl5U0s3RnB6QXo2WE42T0pFODdNVjRLa1pmMng3MTVVMm9tOGY1MU1k?=
 =?gb2312?B?dG1OUXE4OFBBZlg2V2lXVGxnSDBpWlVIWnAraUtRbWNoNjV6WkJxWWVwVGRZ?=
 =?gb2312?B?WGpqMnFzVUF4YmRFdlozbVlTb2QxVGYxZFFsazVjTktSMytLOXNIL1FpVitV?=
 =?gb2312?B?b2tiZnRvZjdwbmJ1dTVTbVVTYStocVBMcjNMaW5kZ2JVcG5jYTN3ZGpiWDlY?=
 =?gb2312?B?cHBVcG5sQTVRdUVyeXJiOVJMOEV3UTl1c1RyazlIZUd1RGFUYUUrOEQzSTli?=
 =?gb2312?B?cktZclRXU1Q0SkJaU3U5bElGeWFIN2RJUnNRM3pPdENWbkR6L1k1YjBsYXo1?=
 =?gb2312?B?N1h1Ym5hUWJDZFd5NEUxNGpDNStmaDZLM2liZi9kNkM2K0V0bnlpV1g5RjZX?=
 =?gb2312?B?RnNEZ2tHeXRMeEx2RDBpNlNqOTN2Um92K2UzTGlJOHMvL29tczcyc1hrVDAv?=
 =?gb2312?B?bkNTZ0lNT2x1ZG1oRk4yMlFYWDdRVVUrb242MUZsOS9odVp1NlVtSFZIT3Zu?=
 =?gb2312?B?VHpuTmZQRnQ4NzN0SzQ1bUk0VWlnTUtIM2xUM1p2VWMvcVdCUm1PSDdTcW1r?=
 =?gb2312?B?Z1lzZi9kdkU0OGtvRng0amloRTE2YllhS0lIcERVRG9EZk80L1AvQmd2OVJP?=
 =?gb2312?B?K3NaSVVsSDh3Zi80NmFlaTBRUUFQT0hOb3lyVEExNm9WQlFwTWdKZHJHa0xL?=
 =?gb2312?B?b2Z0SnlHVVZDZzBSREdJUW1UU0cvcUZsaG1ha1VjdFI0NlZsbG1ORU94WU9R?=
 =?gb2312?B?a0JHOXlGZTNQTlVOS2N2czEvQ3RTeFZqV2lQS0hrVjBBNi9VazVyY2ExcFJw?=
 =?gb2312?B?M3QrazRNZUZZYUM1QVJHRlRjNUMyYVlhK2xHVklET1RXNHd1VkVzdz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b686f1-4fb2-4416-abc8-08da4f3f378b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 02:23:35.9155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpNxPN7xkZ9DsAWNyBvSkfD8Q74K4T7HUJrvUu7FJFEjTlzDG4gk7YJIt/rIDH3dYp8jmzD/hSWAektrfu8+dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJqb3JuIEhlbGdhYXMgPGhl
bGdhYXNAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyMsTqNtTCMTbI1SA3OjE2DQo+IFRvOiBIb25n
eGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgTHVjYXMgU3RhY2gNCj4gPGwuc3RhY2hA
cGVuZ3V0cm9uaXguZGU+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBC
cm93bg0KPiA8YnJvb25pZUBrZXJuZWwub3JnPjsgTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8u
cGllcmFsaXNpQGFybS5jb20+OyBGYWJpbw0KPiBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+
OyBGcmFuY2VzY28gRG9sY2luaQ0KPiA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+
IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47IEJqb3JuIEhl
bGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MTIgMDEvMTNd
IFBDSTogaW14NjogTW92ZSBpbXg2X3BjaWVfZ3JwX29mZnNldCgpLA0KPiBpbXg2X3BjaWVfY29u
ZmlndXJlX3R5cGUoKSBlYXJsaWVyDQo+IA0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fh
c0Bnb29nbGUuY29tPg0KPiANCj4gTW92ZSBpbXg2X3BjaWVfZ3JwX29mZnNldCgpIGFuZCBpbXg2
X3BjaWVfY29uZmlndXJlX3R5cGUoKSBlYXJsaWVyIGluIHRoZSBmaWxlDQo+IHNpbmNlIHRoZXkg
ZGVwZW5kIG9uIG5vdGhpbmcgYW5kIGFyZSB1c2VkIGJ5IHNldmVyYWwgb3RoZXIgZnVuY3Rpb25z
IHRoYXQgd2lsbA0KPiBiZSBtb3ZlZCBlYXJsaWVyLiAgTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50
ZW5kZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29n
bGUuY29tPg0KQWNrZWQtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCg0K
QmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWlteDYuYyB8IDUwICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGluZGV4IDdhMjg1ZmIwZjYx
OS4uODY1M2NhOGNiZmI5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2ktaW14Ni5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMNCj4gQEAgLTE0Niw2ICsxNDYsMzEgQEAgc3RydWN0IGlteDZfcGNpZSB7DQo+ICAjZGVmaW5l
IFBIWV9SWF9PVlJEX0lOX0xPX1JYX0RBVEFfRU4JCUJJVCg1KQ0KPiAgI2RlZmluZSBQSFlfUlhf
T1ZSRF9JTl9MT19SWF9QTExfRU4JCUJJVCgzKQ0KPiANCj4gK3N0YXRpYyB1bnNpZ25lZCBpbnQg
aW14Nl9wY2llX2dycF9vZmZzZXQoY29uc3Qgc3RydWN0IGlteDZfcGNpZQ0KPiArKmlteDZfcGNp
ZSkgew0KPiArCVdBUk5fT04oaW14Nl9wY2llLT5kcnZkYXRhLT52YXJpYW50ICE9IElNWDhNUSAm
Jg0KPiArCQlpbXg2X3BjaWUtPmRydmRhdGEtPnZhcmlhbnQgIT0gSU1YOE1NKTsNCj4gKwlyZXR1
cm4gaW14Nl9wY2llLT5jb250cm9sbGVyX2lkID09IDEgPyBJT01VWENfR1BSMTYgOg0KPiBJT01V
WENfR1BSMTQ7IH0NCj4gKw0KPiArc3RhdGljIHZvaWQgaW14Nl9wY2llX2NvbmZpZ3VyZV90eXBl
KHN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSkgew0KPiArCXVuc2lnbmVkIGludCBtYXNrLCB2
YWw7DQo+ICsNCj4gKwlpZiAoaW14Nl9wY2llLT5kcnZkYXRhLT52YXJpYW50ID09IElNWDhNUSAm
Jg0KPiArCSAgICBpbXg2X3BjaWUtPmNvbnRyb2xsZXJfaWQgPT0gMSkgew0KPiArCQltYXNrID0g
SU1YOE1RX0dQUjEyX1BDSUUyX0NUUkxfREVWSUNFX1RZUEU7DQo+ICsJCXZhbCAgPSBGSUVMRF9Q
UkVQKElNWDhNUV9HUFIxMl9QQ0lFMl9DVFJMX0RFVklDRV9UWVBFLA0KPiArCQkJCSAgUENJX0VY
UF9UWVBFX1JPT1RfUE9SVCk7DQo+ICsJfSBlbHNlIHsNCj4gKwkJbWFzayA9IElNWDZRX0dQUjEy
X0RFVklDRV9UWVBFOw0KPiArCQl2YWwgID0gRklFTERfUFJFUChJTVg2UV9HUFIxMl9ERVZJQ0Vf
VFlQRSwNCj4gKwkJCQkgIFBDSV9FWFBfVFlQRV9ST09UX1BPUlQpOw0KPiArCX0NCj4gKw0KPiAr
CXJlZ21hcF91cGRhdGVfYml0cyhpbXg2X3BjaWUtPmlvbXV4Y19ncHIsIElPTVVYQ19HUFIxMiwg
bWFzaywNCj4gdmFsKTsgfQ0KPiArDQo+ICBzdGF0aWMgaW50IHBjaWVfcGh5X3BvbGxfYWNrKHN0
cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSwgYm9vbCBleHBfdmFsKSAgew0KPiAgCXN0cnVjdCBk
d19wY2llICpwY2kgPSBpbXg2X3BjaWUtPnBjaTsNCj4gQEAgLTQxNSwxMyArNDQwLDYgQEAgc3Rh
dGljIHZvaWQgaW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdA0KPiBpbXg2X3BjaWUg
KmlteDZfcGNpZSkNCj4gIAkJCQkJaW14Nl9wY2llLT5ncGlvX2FjdGl2ZV9oaWdoKTsNCj4gIH0N
Cj4gDQo+IC1zdGF0aWMgdW5zaWduZWQgaW50IGlteDZfcGNpZV9ncnBfb2Zmc2V0KGNvbnN0IHN0
cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gLXsNCj4gLQlXQVJOX09OKGlteDZfcGNpZS0+
ZHJ2ZGF0YS0+dmFyaWFudCAhPSBJTVg4TVEgJiYNCj4gLQkJaW14Nl9wY2llLT5kcnZkYXRhLT52
YXJpYW50ICE9IElNWDhNTSk7DQo+IC0JcmV0dXJuIGlteDZfcGNpZS0+Y29udHJvbGxlcl9pZCA9
PSAxID8gSU9NVVhDX0dQUjE2IDogSU9NVVhDX0dQUjE0Ow0KPiAtfQ0KPiAtDQo+ICBzdGF0aWMg
aW50IGlteDZfcGNpZV9lbmFibGVfcmVmX2NsayhzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUp
ICB7DQo+ICAJc3RydWN0IGR3X3BjaWUgKnBjaSA9IGlteDZfcGNpZS0+cGNpOw0KPiBAQCAtNjE3
LDI0ICs2MzUsNiBAQCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldChz
dHJ1Y3QNCj4gaW14Nl9wY2llICppbXg2X3BjaWUpDQo+ICAJfQ0KPiAgfQ0KPiANCj4gLXN0YXRp
YyB2b2lkIGlteDZfcGNpZV9jb25maWd1cmVfdHlwZShzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3Bj
aWUpIC17DQo+IC0JdW5zaWduZWQgaW50IG1hc2ssIHZhbDsNCj4gLQ0KPiAtCWlmIChpbXg2X3Bj
aWUtPmRydmRhdGEtPnZhcmlhbnQgPT0gSU1YOE1RICYmDQo+IC0JICAgIGlteDZfcGNpZS0+Y29u
dHJvbGxlcl9pZCA9PSAxKSB7DQo+IC0JCW1hc2sgICA9IElNWDhNUV9HUFIxMl9QQ0lFMl9DVFJM
X0RFVklDRV9UWVBFOw0KPiAtCQl2YWwgICAgPSBGSUVMRF9QUkVQKElNWDhNUV9HUFIxMl9QQ0lF
Ml9DVFJMX0RFVklDRV9UWVBFLA0KPiAtCQkJCSAgICBQQ0lfRVhQX1RZUEVfUk9PVF9QT1JUKTsN
Cj4gLQl9IGVsc2Ugew0KPiAtCQltYXNrID0gSU1YNlFfR1BSMTJfREVWSUNFX1RZUEU7DQo+IC0J
CXZhbCAgPSBGSUVMRF9QUkVQKElNWDZRX0dQUjEyX0RFVklDRV9UWVBFLA0KPiAtCQkJCSAgUENJ
X0VYUF9UWVBFX1JPT1RfUE9SVCk7DQo+IC0JfQ0KPiAtDQo+IC0JcmVnbWFwX3VwZGF0ZV9iaXRz
KGlteDZfcGNpZS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjEyLCBtYXNrLA0KPiB2YWwpOw0KPiAt
fQ0KPiAtDQo+ICBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfaW5pdF9waHkoc3RydWN0IGlteDZfcGNp
ZSAqaW14Nl9wY2llKSAgew0KPiAgCXN3aXRjaCAoaW14Nl9wY2llLT5kcnZkYXRhLT52YXJpYW50
KSB7DQo+IC0tDQo+IDIuMjUuMQ0KDQo=
