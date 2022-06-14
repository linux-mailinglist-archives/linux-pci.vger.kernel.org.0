Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875E654A357
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 02:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiFNA6l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 20:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiFNA6k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 20:58:40 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80047.outbound.protection.outlook.com [40.107.8.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C8B2C652;
        Mon, 13 Jun 2022 17:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgoIJSFYO39mrjbhM27SHF6t9qdJ5F3oqaPh7eKiIg2x7FBTYRwXxMP37gKOTf5QfLAjEJCqPetd2Q6JJ/5L9VfW8dLrtkHQybhmjticCOLFm4vn4MT89GUfmoFvtI1l2LGHi3a+sZP4Ca+IzGuDaZgct+bpE6AnxUb6yBCx6tcmqU4H1wTDjSqsgIH8spzUwQirfKj0f+0H+HOXsNO5xhAY7iv5667C5czwRAfU0vVyNQCWLFFD9B95//eqePbEaJ0DJa4uBB6q+pNUWpP9VDGsejiNhGnSponI0syDVZG0ezFda9TuUCDbCTrKVvP2H4IrmraHSm6EGf/avQpRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzRPQ1tUUUZcwfTRvQ13O3JRY1APVErU/2S2y8cbxLA=;
 b=FiwgWWrZg+RISsBcArn2vNy5UZWfCTrZI7T+KGJlqX8npITgCznfSoakYQbMjD9Xz/RE5D2Bdp6pHqAT5JbNrxCo0T592Gk/NOVtCUEbse0BcExbgvyuUMth4mOuB5Ph+JqUFlMto3i6+1HYNcQSLa92XUKY1TisRCfZwxNR+Y86C96rYzFG1no/n+hc+7aN86A/mqK+r0GQobzSGOOhG+osh+8z5nZFh1WdSAypAZg6VSaVhDVsM/fZww5JfDocUlVXHZPZU2UkSaKRq50LgPe6YhShmwX02kHR3gB9r8NH79aM5d+dK8Vfe7apv8Eqjbv5TMuHnHtfURSgtyRAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzRPQ1tUUUZcwfTRvQ13O3JRY1APVErU/2S2y8cbxLA=;
 b=JarqBfJ/nVYajMURsCQDuTxY7hJZkzfjDQOvHWz7Uj3FwWwzMdAvYI3gdw+gy+OnC/u6mWpIPkZeTgRDIYLuki8tGyZARZKv4196WxQiVrxZNedV+n+lOnAuLeo/55QTiHFMhS+R+Lpijw6KhmmSx/OeUR+ukeAiK8aundpc+r0=
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by DB8PR04MB6537.eurprd04.prod.outlook.com (2603:10a6:10:10c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 00:58:35 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::8589:5e05:4fcc:ccf4]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::8589:5e05:4fcc:ccf4%9]) with mapi id 15.20.5332.021; Tue, 14 Jun 2022
 00:58:34 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v10 5/7] PCI: imx6: Turn off regulator when the system is
 in suspend mode
Thread-Topic: [PATCH v10 5/7] PCI: imx6: Turn off regulator when the system is
 in suspend mode
Thread-Index: AQHYfwVNIQhrC7fLwUCkJT0MqdZvK61NH3MAgAD0iXA=
Date:   Tue, 14 Jun 2022 00:58:34 +0000
Message-ID: <DU2PR04MB86774EED49C2928B48A4B7228CAA9@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1655110538-10914-1-git-send-email-hongxing.zhu@nxp.com>
 <1655110538-10914-6-git-send-email-hongxing.zhu@nxp.com>
 <20220613101712.GA20538@francesco-nb.int.toradex.com>
In-Reply-To: <20220613101712.GA20538@francesco-nb.int.toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c9f6ebb-d479-4f42-a190-08da4da10232
x-ms-traffictypediagnostic: DB8PR04MB6537:EE_
x-microsoft-antispam-prvs: <DB8PR04MB65379BC326D566482F27771F8CAA9@DB8PR04MB6537.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YhwG8l7gPSupmKsopdTPCVaZ5Qzj9/QjxGXaYJxcMymSjWlwk+k9goFH+Wj/ZiOF426NE3subGe2EF3HnQeKOChR/QmW9fbZfH/Y13TeMGaQ8qBLQM2Ya+844X27k5p/1QJQrNyZ6ysbm3d3RX9PpG9bfLn0n/jXc3D7ZjoTnTC3O6h2WAHxynse1ypLcgUe0ebal9apJTR238zLX7/n3LsP+6VjAN+WpV5N6lqPAt6EhI7p8oKPZa3vvuwFey/tMq+kDkl/oU2T51liDoYP7ixVD2+Tzs7oSgigGBNXHXbWv3Tk9jw9CNLknNIUhTBxGAnhzI4n+ZZ1mekAzhmUWq9ONgIcBBLN7tGzFS9b4XPTp6SijrONpbrhXaHb572DqAueXGEHY9/VCmBeYuo4YeFSdd3/8kPS10J+X1ZJfsL6rrUjyZ6O3EpuA7BW1pcXrJQ0oG96+H9prJZfzda7EekKS0f6b1QTt8oa97pZQIwUqm/hyXGkdgr7PMbl2/KiFhmccRbWpGBCBUjQrwktitem1lW7ROtmeH6GJDcy51n1yJxvwUVCChyKOgI9BkGuRLI1+3wSI/+/jb9kNUF8toYDc/44RbMH+RWL9X8wNMXYcWNDP1WkeqvDqfvQRMMeTqT82/VhmSSw16JlD8XegZO4gRIbW+aFWjIBBN8EaO9u3nvDGXd9ehTfSYj9OFjip8eHVAjW01ij8HdoCFhHvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(54906003)(26005)(316002)(7416002)(6506007)(38100700002)(53546011)(7696005)(71200400001)(508600001)(86362001)(44832011)(66446008)(5660300002)(33656002)(110136005)(122000001)(186003)(55016003)(83380400001)(9686003)(76116006)(38070700005)(8676002)(64756008)(4326008)(66556008)(66476007)(52536014)(2906002)(66946007)(15650500001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?c3VLNGtWWGdRTFNsQmQ5R0hTZi9SL0F0dFJHbjJoczdIdXVIV2ZiM1ZmWUIw?=
 =?gb2312?B?a3VEZGhjSzZMd2RjRnZNSVAvWXlpQzd5Q2RuS05KSDY0dWlPS1VXc21pMTF4?=
 =?gb2312?B?TnRWeWg4OFJibk5HU0txeEE0cm51U2FJN082ZktuWDM0WlNKbGdCOUJ4ZFhh?=
 =?gb2312?B?emZ5Snlsd2pKcGRZVnRKMW9PZWhvVCt1TSsyRjZWME1IdHhOT2ZpM1IvNGFD?=
 =?gb2312?B?bEhRUHg2TWNJblI0SkdqUmhoYjNKTUoyeldJaW1EV3lJVVlPUjRyYVYxMkRR?=
 =?gb2312?B?ekdtbkpzUk1VaktlcHRNeDdKaDJyKzNzeTJlNHAvVXhEZVFUdGZ0eE42UGx0?=
 =?gb2312?B?N2JGSmY5dWxMaEtWZFpERTdWNTVXWnNqWmtjdWJTaWdtV2FtZkM0NFpQWE5a?=
 =?gb2312?B?OHdabUIzYnhRZ00wZzFUK016UEtkelFBZ2N6NW4vOTUrZzJBVUFtdmI3YzBw?=
 =?gb2312?B?MmlJUlZtMHR3Z3ZvcFdnaUIzVHBDUEw3VU1wSURISmZzY2x3YkUwbEx5cjds?=
 =?gb2312?B?ZFo1ZDhobWE0aHlWTnJVcUYyYTBpWEFTMldhQWU0LzFTcllTa3Z1SEdNTW9n?=
 =?gb2312?B?RG9qV0s3Qk9lOVc4SDZKTzlxc3JTSU0zRjdNN0V4QTlqeTV4SjNSYWp1YWFk?=
 =?gb2312?B?cWFiaDVnSklzVnhTOUhTbWJaN1AvTlZuNmIxVlRObFUyTGZmVUtZVEN5eVQw?=
 =?gb2312?B?ZEprdm1GNEFndnk3NlZEUzJ3OUF4OCtRd2YyWk5KTFlnd2p4Y1d4YUZYcE9y?=
 =?gb2312?B?ZC9JNXFXanBaeVE5eXFuMjVzWThWVVY3a09aTmNGdmNkKzNRbG1QYWV5NFVv?=
 =?gb2312?B?YTlDQ3plOWhhVk5Idkx2WlpLK1hDcmtqcjlQRXRIZTRTa21PY0RrV1BzQkxH?=
 =?gb2312?B?bS9sSzJXUElEM2lIbG5OdCtNOUxZdklwZE1vbGxSbFF2U2NaRlVlQ3FVSnpC?=
 =?gb2312?B?ay9XSkZZdHVpS29vYlJhS2w5cjNSdlBFd2lqNm40R1c3RGphclY5VFJ4djdU?=
 =?gb2312?B?elV3QXBKSFlyUVRzc0NiWmtNRDAwKzYxU3BnaGROdTViTU5hbEViRjl6YWR3?=
 =?gb2312?B?b0tjNnFWVDFIam5VaW95YTVFMUJDUzl3NzF3eC8xdmR5bm4yMkV5c0x0MmNW?=
 =?gb2312?B?dThJekhBRlhCOUg2R0tjbTljSzB2Sm9lV1RhRDNFVk1GRjBsbm5LNGtpM05Q?=
 =?gb2312?B?M0ljREh3ak1JRU82Ylhwa0YyRmU5d3VrVkZ0emVYUlhYOGdJNXcybCtkMGQ3?=
 =?gb2312?B?WkV4NXc5Y2NwNzlKd0gxUVc4eTR6WDdpUmZQaHo2UlNUWi8vbkFpYmcwQlpu?=
 =?gb2312?B?UG5VUFN3bWNiaG1RS2RqcUFtRlN5Z051VzhhbmlVTVMzaXN6SlgzazVuUkRR?=
 =?gb2312?B?aUx0aGVMOFN0SjZtNGgvVTV3RjF1M1E0a2NINnAwUEw5VTJuZjZBOG43amto?=
 =?gb2312?B?d2pFR2NoUGQ2cHBoYlZJSkJpckxQL2RDZ3MrL2s0c3p4UDgrRzhUWlpuTjVK?=
 =?gb2312?B?bTZ6RVlYUUt1enNoUkQ3N2Y0cU1BNWgxYVJFV1J1Vm5jZkpsaVNxaDNYSTh6?=
 =?gb2312?B?UzdhblFHQ1ZWbFEwU1oyanNJTzdEeXRHaDE0WUNYUFdPbmFkeEY5Uy9UaGVo?=
 =?gb2312?B?eTVQbER1NUR0NU9RV2xpVXVmOEFXZnlwN1ZHUzZnNjVMOUV5aVFRdER2L29l?=
 =?gb2312?B?Zk13YWZzUVhYWGFYeklsd2JPbU5RK1RCb0Q4UFZ6bm52eFpHMDJKejIwZEw5?=
 =?gb2312?B?ZFBSYWE4UFJWZnptMk5vOTQzelRLQU9XVlRER0hHWnd3aTIrZFZTK3dzMC96?=
 =?gb2312?B?TW1hNUR1cmF1MTROLzFqS1pON3QvMFJ6Y1QyWlYwK2lxeFRmdm5JcFF4UXZB?=
 =?gb2312?B?M3F1QmRGcmhqUFZRdmpOQkdtWWp5a0tDT3lMd2JCbHJBcTZacGw4R3ZMY0VQ?=
 =?gb2312?B?bXZGb0Z4MFN6c3Uybk9iV0FJYXNkLzEwMHFad0t0RmIvR2tJMzBBTThTNkR3?=
 =?gb2312?B?RVJCVFpBaW9GSDhFNU0yVTdRUTFoY1BITnVmK1ZxcFRrUzUzanFQdGE2Smxw?=
 =?gb2312?B?Z1Jka1NMbFN2V203VWxNQXBvWWxLaTBCdlNtWVVMOUdXVjR2Qmp3Z09aSm1s?=
 =?gb2312?B?NWd5dXVjb0FHWG9RNHNyWU90V3VsOUptUDIzcGw3SUhDTStvMHFUM1JlbTZH?=
 =?gb2312?B?eGx1TDhLSFg2c2Fkd2U1cHV1VlJFdXZYSGRhZXFaYnRTTnE0WkthV0FiK2ZD?=
 =?gb2312?B?ZkNLckRWb1lDc2p1Z0ZTM2FOZFJPSEt6NzFhNnV4OHRDVVhtWGxieE5SR2Nj?=
 =?gb2312?B?VENXWVdDZXhxbEZDS1VZQnRnQWd4RnFGRXZKUWtVQXFXNUlGYjhNQT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9f6ebb-d479-4f42-a190-08da4da10232
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 00:58:34.8136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+L9x6Cqk/MhbcScqKHGt27lT/TUKq0ZtrtakWijyGvdyj0Q/yYDrY7wSoEig29TszKvV+cuFJ0ATbnVhOA0LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6537
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuY2VzY28gRG9sY2luaSA8
ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IFNlbnQ6IDIwMjLE6jbUwjEzyNUgMTg6
MTcNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBsLnN0YWNoQHBl
bmd1dHJvbml4LmRlOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2JoQGtlcm5lbC5vcmcNCj4g
Q2M6IGJyb29uaWVAa2VybmVsLm9yZzsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgZmVzdGV2
YW1AZ21haWwuY29tOw0KPiBmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4LmNvbTsgbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7
IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djEwIDUvN10gUENJOiBpbXg2OiBUdXJuIG9mZiByZWd1bGF0b3Igd2hlbiB0aGUgc3lzdGVtIGlz
DQo+IGluIHN1c3BlbmQgbW9kZQ0KPiANCj4gT24gTW9uLCBKdW4gMTMsIDIwMjIgYXQgMDQ6NTU6
MzZQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gVGhlIGRyaXZlciBzaG91bGQgdW5k
byBhbnkgZW5hYmxlcyBpdCBkaWQgaXRzZWxmLiBUaGUgcmVndWxhdG9yDQo+ID4gZGlzYWJsZSBz
aG91bGRuJ3QgYmUgYmFzaW5nIGRlY2lzaW9ucyBvbiByZWd1bGF0b3JfaXNfZW5hYmxlZCgpLg0K
PiA+DQo+ID4gTW92ZSB0aGUgcmVndWxhdG9yX2Rpc2FibGUgdG8gdGhlIHN1c3BlbmQgZnVuY3Rp
b24sIHR1cm4gb2ZmIHJlZ3VsYXRvcg0KPiA+IHdoZW4gdGhlIHN5c3RlbSBpcyBpbiBzdXNwZW5k
IG1vZGUuDQo+IA0KPiBBY2NvcmRpbmcgdG8gdGhlIGRvY3VtZW50YXRpb246DQo+IA0KPiAgIHZw
Y2llLXN1cHBseToNCj4gICAgIGRlc2NyaXB0aW9uOiBTaG91bGQgc3BlY2lmeSB0aGUgcmVndWxh
dG9yIGluIGNoYXJnZSBvZiBQQ0llIHBvcnQgcG93ZXIuDQo+ICAgICAgIFRoZSByZWd1bGF0b3Ig
d2lsbCBiZSBlbmFibGVkIHdoZW4gaW5pdGlhbGl6aW5nIHRoZSBQQ0llIGhvc3QgYW5kDQo+ICAg
ICAgIGRpc2FibGVkIGVpdGhlciBhcyBwYXJ0IG9mIHRoZSBpbml0IHByb2Nlc3Mgb3Igd2hlbiBz
aHV0dGluZyBkb3duDQo+ICAgICAgIHRoZSBob3N0IChvcHRpb25hbCByZXF1aXJlZCkuDQo+IA0K
PiBJcyB0aGlzIHJlYWxseSB3aGF0IHdlIHdhbnQgdG8gZG8gKHJlbW92ZSBwb3dlciBpbiBzdXNw
ZW5kLCBlbmFibGUgaXQgb24NCj4gcmVzdW1lKT8gT24gb3VyIGJvYXJkcyB0aGlzIHBvd2VycyBh
IFBDSWUgZGV2aWNlIGNvbm5lY3RlZCB0byB0aGUgaG9zdCBwb3J0LA0KPiB0aGF0IHNvdW5kIGZh
aXIgYWNjb3JkaW5nIHRvIHRoZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIGl0Lg0KPiBBbSBJ
IHdyb25nPw0KPiANCj4gV2UgZG8gaGF2ZSBpc3N1ZXMgd2l0aCBQQ0llIG5vdCB3b3JraW5nIGFu
eW1vcmUgYWZ0ZXIgc3VzcGVuZC9yZXN1bWUsDQo+IHdvbmRlcmluZyAoSSBkaWQgbm90IGhhdmUg
dGltZSB0byBwcm9wZXJseSBkaWcgaW50byBpdCkgaWYgdGhpcyBpcyB0aGUgcm9vdCBjYXVzZS4N
Cj4gDQpIaSBGcmFuY2VzY286DQpZZXMsIHlvdSdyZSByaWdodC4gVGhpcyByZWd1bGF0b3IgaXMg
dXNlZCB0byBwb3dlcmVkIHVwIHRoZSBwb3J0LiBJdCdzDQogcmVhc29uYWJsZSB0byBtb3ZlIHRo
ZSBkaXNhYmxlIHRvIHN1c3BlbmQgcmVmZXIgdG8gTHVjYXMnIHJldmlldyBjb21tZW50cy4NCkJU
VywgSSBzdXNwZWN0IHRoYXQgeW91ciBQQ0llIGZhaWx1cmUgYWZ0ZXIgc3VzcGVuZC9yZXN1bWUg
aXMgY2F1c2VkIGJ5IHRoZQ0KIE1TSV9BRERSIG1pc3NpbmcuIENhbiB5b3UgbWFrZSBhIGRvdWJs
ZSBjaGVjayBvbiBpdD8NCkkgdXNlZCBmb3VuZCB0aGF0IHRoZSBNU0lfQUREUiBzaG91bGQgYmUg
cmUtY29uZmlndXJlZCBhZ2FpbiBkdXJpbmcgcmVzdW1lIG9uDQogc29tZSBwbGF0Zm9ybXMuIEJ1
dCBJIGRpZG4ndCBpc3N1ZSB0aGF0IGZpeCBwYXRjaCBpbiB0aW1lLiBTb3JyeSBhYm91dCB0aGF0
Lg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gRnJhbmNlc2NvDQoNCg==
