Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA6C54D848
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 04:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350964AbiFPCYF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 22:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350629AbiFPCYF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 22:24:05 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2075.outbound.protection.outlook.com [40.107.104.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32E24C413;
        Wed, 15 Jun 2022 19:24:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ML9DsfKYIvf0X5fgyi+UuDaOrbGiH2VIL1IK3x6OBGlYAeA0iZN1q2LL3QplVCs2MkULDT4Swb1zdt9Xmcdl3d3/+tFcTqGxvtjnoIqCxSv+tAx7bm6/lKtUaluPpZQYDXn3Do0htckwezIvRg4uoM3pG0s076SdoAx0KtMgQ/ojH/8H9KpMwTFbYv+BX/tPo7sivwh5iQkLKxt4cqwNg9hb5VgLtCtUn4HzWJdRj+T6zDFj1NIk4gwNepn0xiXPzWDqj0mYRcklvUd5n5quKdU5vYNSzaCqpAZO78ZuVmZ1AUUD6MepVbLF9vDlTwpeuAqLJ8cvL757v229dJWLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6LzhcuN1jU4rdWYoch+k6DDsHRD20Ib56oOpEPOUOY=;
 b=Ts/EOul9Ipxbf1xNwMNWg3UIHWuqz+qGUcwzoO9chMiq+Z47uHyIv8nbKg/E6X8zVlw5S6nSEr6OsmzHY54g5k6au3Ih91xjHRQo3hrDuGfbmgTPLhA02CyWM7ddcjyOhzNDVIY6jdt3cDEMjOWyyqz7TVLFOQPtS6i2psTgGnIo5tYTGnRpW10sHZc3PDHc1/NWcGpHqJj4Ifi8hoqi7QVWZCbDF5MG8ua9EWpuFN6K9kSbcwD27nvCeDmUvzZIhE77YNBL0zSmQZScWbiAi44Yu+Ivyxl4G1BQy2OgwE8xHx62iO59yjyMOnccoREgGyiW+KbZBnOcg+jmrkNsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6LzhcuN1jU4rdWYoch+k6DDsHRD20Ib56oOpEPOUOY=;
 b=lI0AcVvqS18M7heyt5kqdXYKGYsR/QvFwNjfJlpjGUYlT6zylTY7IMPJSRi/qmzqzg6wRAXKK3KVztxsHCYDloeQzQ7vhYoG4Ii/ftN2SPL1YiETQgGbzNxkeYEsS3gGFV9RrlySGs8XJeY/HQlDFHiDuozZOUbusvNsf7rKj4o=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by HE1PR0401MB2474.eurprd04.prod.outlook.com (2603:10a6:3:81::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 02:23:59 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a0fa:978c:2b40:2cb7]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a0fa:978c:2b40:2cb7%6]) with mapi id 15.20.5353.013; Thu, 16 Jun 2022
 02:23:59 +0000
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
Subject: RE: [PATCH v12 13/13] PCI: imx6: Disable clocks in reverse order of
 enable
Thread-Topic: [PATCH v12 13/13] PCI: imx6: Disable clocks in reverse order of
 enable
Thread-Index: AQHYgQ30yoBpFgvs6UKpE4i05KSqh61RRS0g
Date:   Thu, 16 Jun 2022 02:23:59 +0000
Message-ID: <AS8PR04MB867642A785CD47559879AE6B8CAC9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20220615231551.1054753-1-helgaas@kernel.org>
 <20220615231551.1054753-14-helgaas@kernel.org>
In-Reply-To: <20220615231551.1054753-14-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edd3c09a-9804-4ec4-4392-08da4f3f45ab
x-ms-traffictypediagnostic: HE1PR0401MB2474:EE_
x-microsoft-antispam-prvs: <HE1PR0401MB24742FDF1218FD27850626FC8CAC9@HE1PR0401MB2474.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jwFxRRCL0p4zY8G3Z9VwoWBg+4xFK1iuVHZj1uSjAUZoMx0fl+7Y+n7VKexFh6Nf/TlsEmp3FnrvgA7Rj9oZn5fSj4vG29LhuP6/YDcmlEeA9M09aZ7AU6cIAelh7w29OJEbfvCMok2mAKVJDvHFwZNVjdUfj7DqFLXVIBkbg4oBdg5R+VbHBNeWxW1QwDeR1qM7+ISQw31LQSiONtdPtdtbMpJpw627bnxqLjlckhBniD0XEG+M8CiB1f/fZsj6RRRlTR5eW/H4NJe1vZ0x1NpGbdvSn7Hbsb5rb3iHPrCxP4Y9W3dJ2ecIY8IBSDBgtt2oEmPYu+CAOPLTz9VataVN/1LzKhhRH2vBToYPuSofjPv+rJg+gqweXP1RVDsDqxMADUhUBhyk20+OodNq5lOcDLhPnSS1ox8II32wJMD5ph90BNkZDI1d0oaFf5SXXsbTlnhWjRHDItqATVdjsCD2D0dh8PCc8JmMkHEFOuVZbecURiZJAh851T+T/XsCB1fZlSLRtpaLUWO9DFw4pg8YoGn/pI2NMLnibMkAohPaGuVw/+PUSxXSKknipo6MXfAXd181LmbS78D87ZkqMKkPKsBliDbnyZ2xO2Qw+eB61gRm/L1zRGFF3l6HYHN5pv8ENhMIKgH7wRA1kBjO1p7RGTkW8liwk4eWt2hTzmwG9g1Xq8u3XMaw6m1D9vIuuP9zfMt3fcIN1q8zBXSI7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38100700002)(2906002)(26005)(6506007)(86362001)(52536014)(508600001)(8936002)(53546011)(33656002)(7696005)(9686003)(7416002)(5660300002)(44832011)(83380400001)(38070700005)(64756008)(66446008)(186003)(122000001)(55016003)(8676002)(66556008)(66476007)(4326008)(54906003)(66946007)(110136005)(316002)(76116006)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?c0ZpYlF0WEgvNjBXWmM5N1FvRkppeGV6WmM0M2N3enYwVnJVeFdtV0Z0T1cz?=
 =?gb2312?B?NmQ2cXJvTXJDSFBTUk1rVGlBVnd2ZDRWT21NS2tvY2pweDBmUktZc0tKNUxX?=
 =?gb2312?B?YnI4R1BtRGwrU01jTHFRMy9QMEhuTC9YMFlZSDJ1OGlxZHBkN1RucTB0RHhT?=
 =?gb2312?B?TitXRUJUK29tUGdpSVhWeDAzbjBWR0hrVjJxMjgrSnZXekl0N2ZYTXRpWDZn?=
 =?gb2312?B?OFk4WTZTdWdKYWNSOUcvUS94aVRJaE95ZFBGVGR3ZFBranUvSUJSNUJ0VGhT?=
 =?gb2312?B?ZkIyTVpBdGoxSzdZeFhyY050V3dWMWxCS29BVWFqaWpGcUtMS2JZVzA5bVBR?=
 =?gb2312?B?Q3JkcmJTZ1RSSW0vRXQvU0U5N1JMNHBrTzFYTjBVMWhMRldGbXpFMWg0TTFh?=
 =?gb2312?B?WUZBQUxVN2NWUEZPckRoRVFNYWptcGllRDg3dDV1Wk9VWHQ0T0pDVkNlNkQv?=
 =?gb2312?B?a1FrbHU5cEhnUkI1VjBrbTllWG9qd3Z6T2kxMlJzZ2pnYkZXVmVWYXduR1R1?=
 =?gb2312?B?SlI0UCtMa3ZET2VhRHBhd0ZDRW1pY0JOa0RpeENWMmtkSW8xSjU2OWJsNkw5?=
 =?gb2312?B?ejBZOWlHYmxWYTR1elFNM1ovWDZYYmhJS1QrV3hkRkNTQWVURHlCUkpPWTNS?=
 =?gb2312?B?S045eFk5YnhJc2J6SUVBTU1IZDRtb2VvSXVJOGZSNyt6NExaRzZRQXpoNlFj?=
 =?gb2312?B?KzQ1cmVCSnplWW5FVCtpZ1NQWDIwUEZnM3FOTk1jQVZWV3dPUVhJa2dKRHhh?=
 =?gb2312?B?U2U5cWU3bGRFM2tKaEZEQ2ZBZjVVNFVCTjN4K29Dclo0RW10aWh2TlRibHVo?=
 =?gb2312?B?UXU3VVN2VmM3cFQ5aGVGckdaRCt2MnB5TGM3U3JNUElPWnBPUVJPTDFnQWxW?=
 =?gb2312?B?SWdvLzZ0aEQzVTdlT2pxdlpKWkJpTzRwdW8wNjVnV1FDQkhqZ0dqdXJtWTFy?=
 =?gb2312?B?Vjl6YVI2d3F1Y0xBdnFpU0ZmbmU0Mm9udHdNcEl1cWo0MDdBVlpoNzU3WVFx?=
 =?gb2312?B?WFZaU2FvUFcwSHFCVXhuQUVUVXBhRjZXb0xIMXRKTGZjeWh5WjZ5K2RnaGVC?=
 =?gb2312?B?OXUwYkNDTlRseG5vVHRaa3MwRDZaakhvU3REbEkrcnl2T2dHWUFGTXR1RDVV?=
 =?gb2312?B?cWVRSlFNdm5NdjdVUlAwRXdUU3VkQUd4cnBkaFZFaFRVVjJPSWpJZUtzZGM1?=
 =?gb2312?B?ZmZla2RaRVBYR2dzQUs4RVlwVXZGM2lBTlJ6SmJFeER6dHQzWUI3L2ZRU0ZD?=
 =?gb2312?B?YU5QcytLeWJGZDV3QjQ0OXR4WWFnSU9OYW9CalNOWkR5QUh3bVpMOHE3WUFk?=
 =?gb2312?B?YXRvR3hpdnNsc25Qb05JOUg4dTRBTVBPL2FpMU9GUjRuTExHMDJrK2dPenlh?=
 =?gb2312?B?YngzKzRrZ2lSTmFGSFVOaWxNRVp5YkpCdE1ZQTdXWm5HN0VvTGJxN0hYMVdi?=
 =?gb2312?B?T2MvUnk2ZFNjVGdKU1kyMk5GbzdXK2Yyd2xhMy9wVXZPeGxtYnljdjlqK2k3?=
 =?gb2312?B?dElaVjR0TVRGelZoTnZraVR5RDJZNnB2ZEF4QWtnYUt6ZUpiOG9oWjROSGwv?=
 =?gb2312?B?WHZSMzRqTDVZbEVCU2poVWpGMWpvbG56OTFxVUM0cEZwL3d1UmdWM2hpcmJX?=
 =?gb2312?B?cjNOMjJKand0bTBIQkYyOXg3bE1qd1RENmk1SXBxTE9IRmRBRDlFakp0QTBU?=
 =?gb2312?B?OUJRNjBmVXhlaUtQODd2ZmpjZjBidHFKa1JQOG5wVVJOYVhUaWV6Z3dLNW9J?=
 =?gb2312?B?dnhBR0NDUlA4bEkzODV2d09QZmZITHpiOTU5cE9Ca1ArWCtjcG04aEpRRUlO?=
 =?gb2312?B?V0FNMjU5ZU84ekZnWEo5YXhYZ3c5UVIrVWYzbE11Q1FKRUR6MFN2QXQ5Z2Fm?=
 =?gb2312?B?dWhjVVRtcy93TzdsRmJHWVVzVld4Wk5XdEd6RjlGQzN4aXVLdkloOUpqODYy?=
 =?gb2312?B?QU4xckJ6Q2h4MGFTdUZtdnJ1YzRUS0xKcmp0Mnp5OUFQS3lNd3pTVzNQK0xS?=
 =?gb2312?B?NENUSnM1QUFBU2dvRlV0d2g5MTNxWFg1Z0tFOHNpemJETVJ6c1loaVVOR3Mx?=
 =?gb2312?B?a0xVUlVhd1AyYitKNVNEclk2Qk9IbGRPUjVsMlJDWWNIVlpJckNFd1Y4dlpk?=
 =?gb2312?B?Q3cvT2R1VHE0MWwvRE40SnpkSDhJVUVFZ2wzWUNwalh4cC8rclZabWtobFlE?=
 =?gb2312?B?R2hUUHdicG41T3FqaXFuWGtYR25MdllGSGliUytMcGc5K1V6MXp5dlNscEJY?=
 =?gb2312?B?NmppeWxPRjh0OGJCcWkyZlZQRFcvVFVDWWwyWUYyL01POWYrZkFRK0ZNVWNw?=
 =?gb2312?B?WTI0bW8rQUxmVEdWUVdlZGd4YkJCWTREVzRiNTF3MCtZZ2JkdjVJQT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd3c09a-9804-4ec4-4392-08da4f3f45ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 02:23:59.6263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4BujWN7NfD6uH9JEyqgFsnELskZwAQgrMsY45pIuKElIRA/R5wWDZ2aHqd7IhvM8ZRhOCNCOcFJUmX5Pokfq/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jbUwjE2yNUgNzoxNg0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IEx1Y2FzIFN0YWNoDQo+IDxsLnN0YWNoQHBl
bmd1dHJvbml4LmRlPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgQnJv
d24NCj4gPGJyb29uaWVAa2VybmVsLm9yZz47IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBp
ZXJhbGlzaUBhcm0uY29tPjsgRmFiaW8NCj4gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsg
RnJhbmNlc2NvIERvbGNpbmkNCj4gPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiBD
YzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBCam9ybiBIZWxn
YWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjEyIDEzLzEzXSBQ
Q0k6IGlteDY6IERpc2FibGUgY2xvY2tzIGluIHJldmVyc2Ugb3JkZXIgb2YgZW5hYmxlDQo+IA0K
PiBGcm9tOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiANCj4gaW14Nl9w
Y2llX2Nsa19lbmFibGUoKSBlbmFibGVzIGNsb2NrcyBpbiB0aGUgb3JkZXI6DQo+IA0KPiAgIHBj
aWVfcGh5DQo+ICAgcGNpZV9idXMNCj4gICBwY2llDQo+ICAgaW14Nl9wY2llX2VuYWJsZV9yZWZf
Y2xrDQo+IA0KPiBDaGFuZ2UgaW14Nl9wY2llX2Nsa19kaXNhYmxlKCkgdG8gZGlzYWJsZSB0aGVt
IGluIHRoZSByZXZlcnNlIG9yZGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVsZ2Fh
cyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCkFja2VkLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gLS0tDQo+ICBkcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgNiArKystLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gaW5kZXggYmQ3MzZhZmY5NGEzLi43MzhiNWE3
MzJjZWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBAQCAt
NjU1LDEwICs2NTUsMTAgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfY2xrX2VuYWJsZShzdHJ1Y3Qg
aW14Nl9wY2llDQo+ICppbXg2X3BjaWUpDQo+IA0KPiAgc3RhdGljIHZvaWQgaW14Nl9wY2llX2Ns
a19kaXNhYmxlKHN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSkgIHsNCj4gLQljbGtfZGlzYWJs
ZV91bnByZXBhcmUoaW14Nl9wY2llLT5wY2llKTsNCj4gLQljbGtfZGlzYWJsZV91bnByZXBhcmUo
aW14Nl9wY2llLT5wY2llX3BoeSk7DQo+IC0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNp
ZS0+cGNpZV9idXMpOw0KPiAgCWlteDZfcGNpZV9kaXNhYmxlX3JlZl9jbGsoaW14Nl9wY2llKTsN
Cj4gKwljbGtfZGlzYWJsZV91bnByZXBhcmUoaW14Nl9wY2llLT5wY2llKTsNCj4gKwljbGtfZGlz
YWJsZV91bnByZXBhcmUoaW14Nl9wY2llLT5wY2llX2J1cyk7DQo+ICsJY2xrX2Rpc2FibGVfdW5w
cmVwYXJlKGlteDZfcGNpZS0+cGNpZV9waHkpOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyB2b2lkIGlt
eDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUpDQo+
IC0tDQo+IDIuMjUuMQ0KDQo=
