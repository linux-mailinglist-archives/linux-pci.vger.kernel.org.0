Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454954EFE10
	for <lists+linux-pci@lfdr.de>; Sat,  2 Apr 2022 05:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbiDBDE6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 23:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiDBDE5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 23:04:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67737689BD;
        Fri,  1 Apr 2022 20:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikrOWZHwxGAkneZFlvuXXA6at9QudaRFGN6AuHUuX4UeT6wA260Je2gOYHFjq0uJDGK4sj1j3uQzPZHDgUdHmiHFLmUyDxPSpC+uklHUe1lMOhdjs6Xe1jbMIxEHF4N7N5Gl/yFtfyddVR2mJWmKOI0TpMi+mBQ+XfEJOiTbxn6DVth45ajcqhvm47n23J8/SLyjcGZQxcOGg5ZiG6+lRmuk/oLP6rX0f5zbhgRHT79lootxaCvJKPU9uNWcBw7CT9yLjR40ndE0Ljinztj4F3puYHadiW/Tx0aNzyIdn8NV3AeWo9JYUQAblW85ZZ1qnSSB8kEjto4qx8wVoC+zQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yq2YBFq1yTeJDtv4Ec/FnYnQgXQHQPN7417MJLSlPLE=;
 b=PKay3MUC+7bAWriamGU4gQhZ+kwOjkolYWOQyx32zswsxyKCDm9ORNdSpB3ixJcJOKcDNP9iUJqXfpctrwkrp7Ogd5nN0QRdYJnEl7RtPJgdGkaG8pWE6HBbtHPJu8u3Fnu1Ga5iUULWj7JCdoGirOsWuEALQZxSJEr/jpqJTlBb6oZTe4b8MkoyEg4zDDAdtz6BXyp1773FtEYDu/48nysu/9Md6rnoKNP3jrbVFAoCf+7b6Hnldq01kEakAdxBFL9C2/GQ9TDL4bMmnSMOcsFelKGVZozxdJ7VWSy5d7NoO7mlU/dKZDjiWaHNj5XMVTmrlt0ZYWQqXibFSVhYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yq2YBFq1yTeJDtv4Ec/FnYnQgXQHQPN7417MJLSlPLE=;
 b=CGb/0cK3waAxNLw8vZQ4RwZ3/tWjabY/rQhYN4bCjoNAakYwx9orM10sq3CRX4SRFFoKO8/EJzs+oB6qs2o6NQ7DHSlgKM3QIYuq0aWmgq2Ms0c9/2oNggZ0Qnnn4bfQ00uyw7GZLG22Rn4ayPSvHWHSPiOHETwMdGgK/tL52w8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VE1PR04MB6349.eurprd04.prod.outlook.com (2603:10a6:803:126::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Sat, 2 Apr
 2022 03:03:04 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800%4]) with mapi id 15.20.5123.029; Sat, 2 Apr 2022
 03:03:04 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v8 8/8] PCI: imx6: Add compliance tests mode support
Thread-Topic: [PATCH v8 8/8] PCI: imx6: Add compliance tests mode support
Thread-Index: AQHYKfsxOpUoV8+AFEmmJ2PcxoYI36zbuZeAgABmz0A=
Date:   Sat, 2 Apr 2022 03:03:04 +0000
Message-ID: <AS8PR04MB8676331ACDAF56CB8B43CD678CE39@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com>
 <1645760667-10510-9-git-send-email-hongxing.zhu@nxp.com>
 <Ykdf+dQE10fkK3K6@robh.at.kernel.org>
In-Reply-To: <Ykdf+dQE10fkK3K6@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fffa6c6c-4843-4d38-1320-08da14554e2d
x-ms-traffictypediagnostic: VE1PR04MB6349:EE_
x-microsoft-antispam-prvs: <VE1PR04MB63494013CB2718C6B788562E8CE39@VE1PR04MB6349.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DJTEatickJspzbafQWqAMx33qc0ehkAzfzK0QMicD3Pn+w7RlR3knUU4rGa59MHAXm6VbYIIcKqBmHTxutjtueN2OYSYURkVTynuRAozDek6QJakLmf0Kev4UkeVL0VUJO1KJLBPPhl/LyfOazmPGJEZubsCj1UDSEowsqWtXpPGeqG28tqlfpQz+nRUp1+VwsZA86y8qcnlJZeaNx4Znvfz3zTf2XcSyUK2qA9YTKl0jFpn38x/EkwU6JHEcOX2pQJ30nxYIoa7fnxAmeRoSaZEDf23vQYAT0J0OpgaXXiB0Wr0SWZlA72ZnIWK09GdO+UJzmuvVbdIByr4cuFSx5VUPLWLGVfKWp2svdbqTHm6BKKiuea1SZ4aJO+le48oGotHypxH1L1Oc+sAyH5d6wGKM2z1/HA/qoHY3+X0h8J/47Qh+IvGQIULhSsRcy7aln4zZt+B9unpp0SbDthMDqGGLgMQshhwES1fLZ6s9Gw516YG0mvyDFHEmIzB/5kKK9TDPR9K69dCxOW4GUkpk47uodZq3uWhWW96dxClKrT2OwgDCaHi5UJOl8qeTLXOHAJ+jNh0AYcFsG6liKOkEwePUXGnsXjdBWG7ykMIn/rqsBfZORQ6aupBzIIWB/q6K1tQs3HsM4OX87Uivo20IVzHDAAx+LfzhBQPTWLgAXb1iLXvLNcsaG2Q5up3cZc/Slz2ku4c3uQRKa8KR4EpFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(2906002)(55016003)(52536014)(8936002)(86362001)(508600001)(316002)(7696005)(6506007)(53546011)(33656002)(66476007)(38070700005)(76116006)(66946007)(54906003)(71200400001)(64756008)(122000001)(4326008)(6916009)(66556008)(9686003)(66446008)(8676002)(38100700002)(5660300002)(44832011)(83380400001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VjJ4a1ZqS3JDeUw1cVpJRUhiV0tTZitFbDNBTW83MXhsM3ZaclZBZVdvVHM3?=
 =?gb2312?B?djFMMlk5a0pGeXZJd2Uvc0ZvSGdST1NFaHdEbWVxanZJa2xwaDlNaVlMWVNE?=
 =?gb2312?B?RzhTL0QzQW5PWElVT2xoanBTYWNXYzlZalYzRGNETTZnZ2JjYk5XNEdqZytt?=
 =?gb2312?B?OVBXOGZhaWJsS0ZLcU5kVCtIdFpkMzVCRXBGeTB3VjFNZi9ISU1ha0VmSE0r?=
 =?gb2312?B?NzRWdkR4dERGU3JkNUNKbWNESndFcjM0VXNxejlGZDZHek5pSk1DTElOMFQr?=
 =?gb2312?B?LzNFcitHckJmNE9JSWNvc0RVdlM3Nlp1Zmx2cmpJTFp4TCsvUFB1dVkyU0po?=
 =?gb2312?B?M2FCb1FBYmRhbmpoVksxeDQrSjVLREZwSk8yMzFkU3lnT1pvL09LaXF0ZjBH?=
 =?gb2312?B?dC91RmMwL1dDMXE1M2U2TzcwMkUvSTFlQkFZa2srYm1JNk56UGpjNzVmRlc5?=
 =?gb2312?B?MmpZUHF2UmczZlFZYUI0aW9EbmhGdHdwRms4eDcybVVwTkhSanpTVjZwV3Jn?=
 =?gb2312?B?VUFDRDJacmdYZ2drQjFSNU41QkpjL1hJbmVsVzUyMHh2elNOdzlLUDZaMUFB?=
 =?gb2312?B?N1o4bVM3OWdzOC9sc0xtOHhteC9nK1RPaml3STh5cnFWWVp4YWFUby9wakQ0?=
 =?gb2312?B?UTZGTUFJYXIzOGtqMzJpSGViSEFVNDJmV0hNU0tpcU9ZSnJmM09GbjRyV1lk?=
 =?gb2312?B?RDAvSW1RTmVJRWlMVlBoQWhIUmp3UHkvbVJqY09IQTlLWlExZlI1VXlHaDlY?=
 =?gb2312?B?Zy9ZREp2ME4vVTR6S2VNUUFaU1FoTW5EVlBHTTBMaE9jWmhNdTFIMkVUNVBO?=
 =?gb2312?B?OVBqTHNEcUdJd25jRHlIVm11WDVab0xRRjhPRzJWUVozRWtuNGlhY09hZ2hW?=
 =?gb2312?B?MzkyVG10VjFFN2pISWZlZ0NBb0ZkZ2R4UVFyTnlZc09WR2dQRFBtN1UvZXI1?=
 =?gb2312?B?TXRGdHkyREo1aTZ0Ty9la3ZVeXhyRDV1c0ltc1Zhem5JOVZQK2RyQTMweGVL?=
 =?gb2312?B?aTJEUHpyNWc1b25VSHhZbEFCcnIxOTdZekhEYnUyRDZHa2FucmlXKzIydnFv?=
 =?gb2312?B?RU5aUXN1MXlaV0VqNFh6Vm1vOFBBTkczb2UzUFNqTHZEMitjOGZqQjVOYXJG?=
 =?gb2312?B?MTJ4c3JKQzEvMzVPOFRHMnc5UjRnM2R0T3dtSCswejBYdlRjZWpXbWprUnlS?=
 =?gb2312?B?K0V2UUdjMEpqQWJIT0d6b3Y4UG5MOGVmTHVad1ZLOUJLcFVBeit4Y01Selpr?=
 =?gb2312?B?WGRmdTRQWWxpNVpFV01KenR3cHlWM3NrazRhZ0Z4dFF4ejdJcnpCY0t5Um1V?=
 =?gb2312?B?T29WSmNwZ0VZeHFMcHJhQktxTHkxZXlHcVE2aENxTXlMOHNzclczU3c1TEFL?=
 =?gb2312?B?ME5BSXM1YzhuSEROYkJFZGUrNElOcW5kZHpOZnhSMVZ6aU1ocUhDYit6Yjlx?=
 =?gb2312?B?TU5mVEZpT2RZMWNxTWtpUDZjVW8rNU02OUx4dXRINkNiVmpPMzdyc2NjeVhm?=
 =?gb2312?B?UFU1OVhvY01pdEExYVFSQmdFNlF3SHFIVkl6L2NxU2MwZWF2aFpuWm9DRFFu?=
 =?gb2312?B?RkFsNXRxaHU0RThsUWE1WVphdTR3SEZ1SlJZVW54ZHBHZXpQcGlsWm5hSzFD?=
 =?gb2312?B?Vll3WU1PRnNRT294bzcvVm95anZWbERxUkl6M1U3eDlrVWFLMkFiL2JKSDlM?=
 =?gb2312?B?UkFVQUV0aUpuMk1qUXVUOWNwK3k0ZWR1dkNpL1JhalZzSEFRaHg2ak5QM0ln?=
 =?gb2312?B?MjdSanNFUjZKc0ZqY00vOVA4d0swL0dhUTRTWk16VDBCKzVBQ1hyMWRnVnMv?=
 =?gb2312?B?QU9GZTZpNmxTaGlmSE54M3VNZDVubUZDSFJnNlJVcUdlYk96dXdtT3BCZ0dI?=
 =?gb2312?B?QVJxdm5ZcTJOTlV1QnMxcGlUSVZkQTQ4NzNoc1pyU1J0K293VWRIUllHaHFR?=
 =?gb2312?B?UHdPeVZLTGZkbDNBSGNvUzFoQVg5SEFRc25LZmtWMzV5cUcwdWZaWFJJLzln?=
 =?gb2312?B?OW4zTFhzdEIvTUs3bVhiWmttSWxiRjVvN2kreEZUcHo2ZG4vd1NKc1RPOSt2?=
 =?gb2312?B?S2o3ck9DK3oyRmhJZ1kwQVdpTUhhbko4ZGlqc2tlMUh6Z0VFVHRRTGhtWUpZ?=
 =?gb2312?B?U2JIYzMzSEE0N3BsQ1hLaU5KNlpkQ3dQbVFjREtMV0JZeXNmSk1FVmVvci9Y?=
 =?gb2312?B?elo0Um01ZHJiTUVpY0JFdFpERnQ1WlNRNUhxbkxRVlk3cTloZkF2ckxsdElu?=
 =?gb2312?B?NVJzZmtDdkhINzlPRnpqbWtkWitkWWVWMFN6ekVza1M5RUpvdmF2OWI4OVk3?=
 =?gb2312?B?RUZjNEp1NFlCd0NrU3Y5RnFGQnJlS3VwOXpaQlNqMTFxMWdRS0NZdz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffa6c6c-4843-4d38-1320-08da14554e2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 03:03:04.1462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vaJqIQ1vx1T16yMwHxUPNwupBlQ42m2XNHHcysPDVXE7+WhGZqU27nID7ilJ3YefTYRPWULplWgHBKkFqlxJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDIyxOo01MIyyNUgNDoyNw0KPiBUbzogSG9uZ3hpbmcgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGJo
ZWxnYWFzQGdvb2dsZS5jb207IGJyb29uaWVAa2VybmVsLm9yZzsNCj4gbG9yZW56by5waWVyYWxp
c2lAYXJtLmNvbTsgamluZ29vaGFuMUBnbWFpbC5jb207IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4g
ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxp
bnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDgvOF0gUENJOiBpbXg2
OiBBZGQgY29tcGxpYW5jZSB0ZXN0cyBtb2RlIHN1cHBvcnQNCj4gDQo+IE9uIEZyaSwgRmViIDI1
LCAyMDIyIGF0IDExOjQ0OjI3QU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IFJlZmVy
IHRvIHRoZSBDaGFwdGVyIDMuMiBTeXN0ZW0gQm9hcmQgU2lnbmFsIFF1YWxpdHkgb2YgUENJIEV4
cHJlc3MNCj4gPiBBcmNoaXRlY3R1cmUgUEhZIFRlc3QgU3BlY2lmaWNhdGlvbiBSZXZpc2lvbiAy
LjAuDQo+ID4NCj4gPiBTaWduYWwgcXVhbGl0eSB0ZXN0cyAoZm9yIGV4YW1wbGU6IGppdHRlciwg
ZGlmZmVyZW50aWFsIGV5ZSBvcGVuaW5nDQo+ID4gYW5kIHNvIG9uKSBjYW4gYmUgZXhlY3V0ZWQg
d2l0aCBkZXZpY2VzIGluIHRoZSBwb2xsaW5nLmNvbXBsaWFuY2Ugc3RhdGUuDQo+ID4NCj4gPiBU
byBsZXQgdGhlIGRldmljZSBzdXBwb3J0IHBvbGxpbmcuY29tcGxpYW5jZSBzdGF0ZSwgdGhlIGNs
b2NrcyBhbmQNCj4gPiBwb3dlcnMgc2hvdWxkbid0IGJlIHR1cm5lZCBvZmYgd2hlbiB0aGUgcHJv
YmUgb2YgZGV2aWNlIGRyaXZlciBmYWlscy4NCj4gPg0KPiA+IEJhc2VkIG9uIENMQiAoQ29tcGxp
YW5jZSBMb2FkIEJvYXJkKSBUZXN0IEZpeHR1cmUgYW5kIHNvIG9uIHRlc3QNCj4gPiBlcXVpcG1l
bnRzLCB0aGUgUEhZIGxpbmsgd291bGQgYmUgZG93biBkdXJpbmcgdGhlIGNvbXBsaWFuY2UgdGVz
dHMuDQo+ID4gUmVmZXIgdG8gdGhpcyBzY2VuYXJpbywgYWRkIHRoZSBpLk1YIFBDSWUgY29tcGxp
YW5jZSB0ZXN0cyBtb2RlIGVuYWJsZQ0KPiA+IHN1cHBvcnQsIGFuZCBrZWVwIHRoZSBjbG9ja3Mg
YW5kIHBvd2VycyBvbiwgYW5kIGZpbmlzaCB0aGUgZHJpdmVyDQo+ID4gcHJvYmUgd2l0aG91dCBl
cnJvciByZXR1cm4uDQo+IA0KPiBIb3cgaXMgdGhpcyBzcGVjaWZpYyB0byBpLk1YPyBJZiB0aGVy
ZSdzIGEgbmVlZCBmb3IgY29tcGxpYW5jZSB0ZXN0IG1vZGUsIHRoZW4NCj4gc2hvdWxkbid0IGl0
IGJlIGNvbW1vbj8gSG93ZXZlciwgd2hpbGUgeW91ciB1c2VjYXNlIGlzIGNvbXBsaWFuY2UgdGVz
dGluZywNCj4gdGhlcmUgZG9lc24ndCBzZWVtIHRvIGJlIGFueSBuZWVkIGZvciB0aGUga2VybmVs
IHRvIGtub3cgd2hhdCB0aGUgdXNlY2FzZSBpcy4NCj4gDQo+IEluIHRoZSBzYW1lIHNlcmllcyB5
b3UndmUgYXJndWVkIGJvdGggd2F5cy4gWW91IG5lZWQgdGhlIGRyaXZlciB0byBwcm9iZQ0KPiBz
dWNjZXNzZnVsbHkgd2l0aCBubyBsaW5rIGFuZCB5b3UgbmVlZCBpdCB0byBzaHV0ZG93biBvbiBu
byBsaW5rLg0KPiANCkhpIFJvYjoNClRoYW5rIGEgbG90IGZvciB5b3VyIHJldmlldyBjb21tZW50
cy4NCkJhc2VkIG9uIHRoaXMgc2VyaWVzLCB0byBzYXZlIHBvd2VyIGNvbnN1bXB0aW9uLCBpLk1Y
IFBDSWUgd291bGQgdHVybiBvZmYgdGhlDQogcG93ZXIvY2xvY2tzIHdoZW4gcHJvYmUgZmFpbGVk
LiBUaHVzLCBpdCdzIHNwZWNpZmljIHRvIGkuTVggdG8gYWRkIG9uZSBtb3JlDQogb3B0aW9uIHRv
IGtlZXAgcG93ZXIvY2xvY2tzIG9uIHdoZW4gY29tcGxpYW5jZSB0ZXN0cyBtb2RlIGlzIHJlcXVp
cmVkLg0KVGhlIGNvbXBsaWFuY2UgdGVzdCBtb2RlIGNhbiBiZSBlbmFibGVkIGR5bmFtaWNhbGx5
IHRocm91Z2ggdGhlDQogbW9kdWxlX3BhcmEgc2V0dGluZy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNo
YXJkIFpodQ0KDQo+ID4NCj4gPiBVc2UgdGhlICJwY2lfaW14Ni5jb21wbGlhbmNlPTEiIGluIGtl
cm5lbCBjb21tYW5kIGxpbmUgdG8gZW5hYmxlIHRoZQ0KPiA+IGNvbXBsaWFuY2UgdGVzdHMgbW9k
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhw
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
YyB8IDQ3DQo+ID4gKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAzMSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCg==
