Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D8E4EFE0F
	for <lists+linux-pci@lfdr.de>; Sat,  2 Apr 2022 05:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiDBDE5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiDBDE4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 23:04:56 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B4A67D25;
        Fri,  1 Apr 2022 20:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sn3FBRSbF63hwdskTQvn9/FiJtOmLNfC2Jl5r8ed13WGRoveQfC47GpP8BBEUcXHIcXVKQmQ3B5pgInF4pLCnq7n9jc6uwWb+wQ6xmMiCQ1OBhS80zb6SozrK0nqtUyceSygeXDPkZKT3DkS2QQTb6rmoTwXWtX9B4/j+u/sAZhlgYTf8ygokjMDG01Zw6YfRe0z0sjm0+UhyvpKO1ratlk+xo3j1fi0NK0W57E/1jN2zGknBkYj76exh/nLg7f5CWrhJAkb9jI+rzJBSODfHXq2bgR0tT8+VkjY2m8cZXZGlrWGtbIeYTwHCGKFHCuee/d3SKmcrHPa2GIZzthXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJvzAhilncfclm9K96bOehGLqXFJ8bQr1dZBMLgIRck=;
 b=QW3Ynqouqo9GhOOBW0CJhTpXgNAHXK4zOyzBNKs/u7KUY9gkwW0LDrh4c2kCi0E6IugPCy36GJjShP1ZDTUMJBmxUFYaJFsr9duQ+t+8hxo+uS44DnG5D9WDlFi+v6ClaKrxxwiAr5Uw+dXpktVPE7uJvePiIB1oGjjjCRiU7qW0wDIX/fSFtRCHxNt+Ck5OPTnVBdUjSWhQybtrpC2Bolz1lkXkhezew296gaYssuMAglHj+mZ2CXc0dDHajdMGAYy6LgqdYtYlYzYYeJn4PM+GQDRzpm68BvWDbBlndL6LeK51KbZoDjRd9YX7n01PimQ9QVCIgtUfb96M417ezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJvzAhilncfclm9K96bOehGLqXFJ8bQr1dZBMLgIRck=;
 b=Z3fDXNIEEdxCY05CssMZsoT7vEwmEIyashPJ6n3mxj4ZitSCC4XnPzMn24j55UP2A6WR1g1OtNqzoYh/uDr3xOJcc00xp/NCwg9a6RIja4G7hA+V7Ndvu5xHxWvK3ZZ4Bs4p+EdbUiuiDBSm20h26d8HQgV5m/HQQ5HXi8dLx88=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VE1PR04MB6349.eurprd04.prod.outlook.com (2603:10a6:803:126::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Sat, 2 Apr
 2022 03:03:01 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800%4]) with mapi id 15.20.5123.029; Sat, 2 Apr 2022
 03:03:00 +0000
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
Subject: RE: [PATCH v8 6/8] PCI: dwc: Add dw_pcie_host_ops.host_exit()
 callback
Thread-Topic: [PATCH v8 6/8] PCI: dwc: Add dw_pcie_host_ops.host_exit()
 callback
Thread-Index: AQHYKfsvJHlP2AzW8UGmcNH944mEyKzbvl0AgABOesA=
Date:   Sat, 2 Apr 2022 03:03:00 +0000
Message-ID: <AS8PR04MB8676A8E85BBDA507481E12C78CE39@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com>
 <1645760667-10510-7-git-send-email-hongxing.zhu@nxp.com>
 <Ykdj+oJ+0k8UZCwK@robh.at.kernel.org>
In-Reply-To: <Ykdj+oJ+0k8UZCwK@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b93a5e6b-947f-470e-8516-08da14554bfa
x-ms-traffictypediagnostic: VE1PR04MB6349:EE_
x-microsoft-antispam-prvs: <VE1PR04MB6349DC84806FD6D9F3BFD2688CE39@VE1PR04MB6349.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QKMF/X1WTVKsCGe1e7srjDbzoR9g0V/L0gtc9bH9i6QPCFsI37XNQn1cjxzjp1UgfmiGvyVGGh0a3KNCe7l4Dyy5t+MBt3Qu0JkHmSnmUGfaD11nOQXz8Ffr2EBNto2z65v6VBXrs4Y/4dXPiD3nzdoO2oD8ZaD6xzZYfejEBZgGoidZy2iTc+DryYlygbtgCrDX9yQSxTYAAfhgt1YuX1Lt46PWohLX82/B4mKSJ2ycTs7O81ZWAlOeut5sFO7darPR6zOk5+M40ItBj9lWIS5UAU+lmkoVq6op7RgpabuvrrHxlB/MMbgLsNA42evUpZgVJ27r/ne1l0g7P7MsjIc+QTIgKi+mr4J+hEuvBzJQBm3DjXxvSGID4SFmfDo5QJTBZOWC5TS0joqa7nWk5zCDQkphfbOrSQdBZ6r+9Cvgb5tOoKQ8vz7I86vkFSjWBcorWo4Le4RWElPwB+ae3xcAp8uyiERz/RQUAuI4tg2du+FuhNw7kHHI6S00mqNavMqR0o2g0N1WZKmnGGD64q/XTYaTctw3POrSs+PS6Ru41JAfW37txRzzgraTxs/u3eKoA/OJWZNa4FleLNNlqARuvjiIc/yp6JP4ZQvsUYvNIUlVUFlL2P13dazygA/ffYxrjNpb18UDrCh2ds96qGiaqQ674ppV1ZlikPc+WRFrP8VkRncPetzmCMhLYNmkeE06MXKYWKlg4+GBfGqH8WNSfcSILzBKudpJzAH4NfGkhgykotnoc57MZ32kTYDjeQkV6Ol2xmnEqp24tJbqV0SHDxqMDJr62hIbVooTYbDGAh9YjUSe3I/CrYI8/iUD0ynWDb28Fm+MJh8YYab9gA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(2906002)(55016003)(52536014)(8936002)(86362001)(966005)(508600001)(316002)(7696005)(6506007)(53546011)(33656002)(66476007)(38070700005)(76116006)(66946007)(54906003)(71200400001)(64756008)(122000001)(4326008)(6916009)(66556008)(9686003)(66446008)(8676002)(38100700002)(5660300002)(44832011)(83380400001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZHFEVWhRV2JSdmVyL25IbUVGcmlLeVpDSVlOVDR0azZoQ2RoYmZvQ0ZTSksy?=
 =?gb2312?B?UDJtQkRxZVRMVTV1ZmtNMUNkTytoUWdtTG1RQnhUUlBVYUJQL0N2bWNxOHBk?=
 =?gb2312?B?OFFPRERSaFd6ZEVVRCs4emx5NHp3SjIydy83TVE3Tjl6RDdLb0FveldQcUJp?=
 =?gb2312?B?SWwwMnNLNkpVS3FoUVVUV1BaclplZ3ROZEpUSmRBMG9FR1hVL2JBSDBVNU5o?=
 =?gb2312?B?aEJ4L0YrM2Q0YXFZVGtiRXAvRGN0cFlBMHQrd3d3VERWU2ZJNVJTZ2JSZDY5?=
 =?gb2312?B?L3IraVNXK05tMGFYL0ZRUHU2Y2dLMnp2cHltTEJ4eDRwTHRENkZQTjBZNWN5?=
 =?gb2312?B?VDd4aE1QWUtIeUdTZmtEKzlDb2I2Y3NVelVxUktybXFqbXFBdjlFUXhhclEr?=
 =?gb2312?B?RjdJcjJPbFJWMFliYXdTNHF1NUN1RzlRLy9tNzJPdmZoUkZQOVQzdEZ5Vlpp?=
 =?gb2312?B?Nkd4K2M4c3BISUhOUkZoalNCMEtZUjYxOEhwQXBQb0VTc0hiYU9NS05Naks1?=
 =?gb2312?B?Ni9lQThXL3JGZThDbXI2NWJySzc5UmVBYTU0b1lxb2oxTDFJNytKWXdXQ2RE?=
 =?gb2312?B?c05XN2VMY0E0TDg1VlZNNDVPRWt5aEJmMmxlWlJnaWg2dnlNR1JyYTVwSm5s?=
 =?gb2312?B?OEVCZjNiT1dSR2pNOFZpbVp6QjVIVUtCdDQ4SmxOb1lFai91VkV5dWI5YTdQ?=
 =?gb2312?B?MENUNEN3K1RDRlJoSml6VDJKMW55Q3NoQ2JMMm5CdjB0Rm80SVU0RUJJWVp5?=
 =?gb2312?B?TEV6WXd5WU05RWhXS2c5b25BOWoyeVp0ek4rRytqM0hhMVFGeUlHZVpHdmtN?=
 =?gb2312?B?d0ZuSjZrN1JQdDVScFRaMXhJbXRhemJZUlEzS2ZDWG9mVGMveC8yVmZJL1Jy?=
 =?gb2312?B?U3RqclVvdjY1T3pzV0hJb3ZqeTdMQk5ZRmhhYXNXM0NBdXFMQ2RDYzNDTXR1?=
 =?gb2312?B?MTAyVExOUFBoU09aYVpYdmxnWVEydzdkdWxIZUFGbzBWT1hVQUdjeXdCQkNY?=
 =?gb2312?B?RTdTZUthaDBGckhnUTR6ZUhBeEIwMUJTZzNhSnBUMTkzOVV6bkIzYTIreDBO?=
 =?gb2312?B?eW9HRmtXT2NHRDJhOW5mOGw1S0JWUEJ1VzYrazZUN3BDOVFqUU9MQ0dnU2FF?=
 =?gb2312?B?S0F3T21yNWZCRjNST3pVUEtPamdDd0JFakswZVJobXJCdjh3Q2NDbUFpM3gx?=
 =?gb2312?B?bVZRT29LR3g3M0IxOWl1MDVaQzlqNUR6UHJtWDFNWk81OXFwTFNxYzh4d1A3?=
 =?gb2312?B?bEc5K3lOYzVheGR6akU2alNsRitTWlUyWFB2QXVvZzRqUWFFS2IzMUpvWi94?=
 =?gb2312?B?bk1SNy9TRCt0bUFQTC91THlmQ3pKZUtlK1NHV09hYmh3U24yQkJpT2c1NlFE?=
 =?gb2312?B?K1dodVBwWVVkR05CS2RhUS9KbGEzdkFoeWpaUlJVYkhCcWhtSmpXQUJPTzlI?=
 =?gb2312?B?UUdxQVYwRm9oTldvMkhhS0NFNlVjYmVZWGcrVjUxaGNOOWJRcE1VclBoVWVZ?=
 =?gb2312?B?ZmpPTmFBVSsxUEZha0xwMWdDTzNCT09aVUw0NGZ4Z1RIQ1BNZGJ3N0V0MnVE?=
 =?gb2312?B?YWtMcnVFblJVY1BGNGorKzZjQU1RU1h4NlA4SldtSnV3bHFqVHNLTmtRRmpR?=
 =?gb2312?B?YnFpbHFleWV2KzN5TlN0K1drNTF5Zko4cE5UWHpNQmFlbXYrYTFEYk1MczNs?=
 =?gb2312?B?ZitrZlJiT0JXY25JeXZza0pjNUFxbHhnZFcxbzhTbCtpNWJMTXg3WlVFZXBr?=
 =?gb2312?B?a2twN2hQWDN6MHdBY1p3SFU2a0VuYUI4NnZSZHNCUkdqeWlNRFZrNWh0WkpY?=
 =?gb2312?B?YWVJeVBWQStyTGpvN3BESksxTUdLWC9Qek5HUE9HZ0YvYTl1alNDSERQMGFD?=
 =?gb2312?B?WGlCNHVxSll4UVRIU2wwY0djQXhSdUgwcHdJZnZ2VHJCbUZVR3dBYU9qZlJp?=
 =?gb2312?B?clRmNmMwUEo4bDAwU1R4WHpkdkxBOWUwZy9ZSUZTdTVHb3RZZ0RXS1pUcWFk?=
 =?gb2312?B?dFlDbVh4WW1BRjhLcTBLZU5za3h1Z20yeExRbDVObWhSZGl1SEU4aWZvaVB5?=
 =?gb2312?B?VExhTmw3UC9RZlFYMk0rb2tlcTBsdFZOYVFKcmJkbzJ0dUZZUkdHNERNc29K?=
 =?gb2312?B?M2hCNUE1VDdvM012WDN6Kzl0cUJDZUJReWRsT3RJOEVWSjM2TmVjakphZWtH?=
 =?gb2312?B?U0xIR3d3Z1BkeDlCdjdMeWRRSTBqMmRMSFVIamU4ZkM1YVczY0NLRXdxV0w5?=
 =?gb2312?B?cU1XN3FFOFVIU09WT0dwdmpYQk81czRvelNiT2dxaWZoVUJmTG1nb1hOVlNx?=
 =?gb2312?B?VFdsdXZ0UVdXMVRBY3ZqQzl1YTNDbEFBRE0ySUFRN1JQWDFnaTlodz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93a5e6b-947f-470e-8516-08da14554bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 03:03:00.3800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3Q5n1vECAfiOcTEf7hUMwUVG+h8x7V2EzZBXH5PuPd/wYW5V6USpbz6/adSZLHSGy/SkmSmbhxtQjCyOTsoiw==
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
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDIyxOo01MIyyNUgNDo0NA0KPiBUbzogSG9uZ3hpbmcgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGJo
ZWxnYWFzQGdvb2dsZS5jb207IGJyb29uaWVAa2VybmVsLm9yZzsNCj4gbG9yZW56by5waWVyYWxp
c2lAYXJtLmNvbTsgamluZ29vaGFuMUBnbWFpbC5jb207IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4g
ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxp
bnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDYvOF0gUENJOiBkd2M6
IEFkZCBkd19wY2llX2hvc3Rfb3BzLmhvc3RfZXhpdCgpDQo+IGNhbGxiYWNrDQo+IA0KPiBPbiBG
cmksIEZlYiAyNSwgMjAyMiBhdCAxMTo0NDoyNUFNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToN
Cj4gPiBXaGVuIHRoZSBsaW5rIG5ldmVyIGNvbWVzIHVwIGFmdGVyIC0+aG9zdF9pbml0KCksIHNv
bWUgZHJpdmVycywNCj4gPiBlc3BlY2lhbGx5IHRob3NlIHRoYXQgZG9uJ3Qgc3VwcG9ydCBob3Rw
bHVnLCB3YW50IHRvIHR1cm4gb2ZmIGNsb2Nrcw0KPiA+IGFuZCBwb3dlciBzdXBwbGllcy4NCj4g
DQo+IElzbid0IHN1cHBvcnRpbmcgaG90cGx1ZyBvciBub3QgYSBib2FyZCBsZXZlbCBkZWNpc2lv
bj8gQW5kIGhvdHBsdWcgZG9lc24ndA0KPiBoYXZlIHRvIG1lYW4gcGh5c2ljYWwgcGx1Zy91bnBs
dWcuIEZvciBleGFtcGxlLCB5b3UgY291bGQgaGF2ZSBhIHNvbGRlcmVkDQo+IGRvd24gUENJZSBk
ZXZpY2Ugd2hpY2ggbmVlZHMgcmVndWxhdG9ycywgcmVzZXRzLCBjbG9ja3MsIGV0Yy4NCj4gZm9y
IHRoYXQgZGV2aWNlIHRvIGJlIGluaXRpYWxpemVkIGJlZm9yZSB0aGUgbGluayBjb21lcyB1cC4g
SWYgdGhhdCBkZXZpY2UgaXMNCj4gaGFuZGxlZCBieSBhIG1vZHVsZSBsb2FkZWQgc29tZSB0aW1l
IGxhdGVyLCB0aGVuIHRoZSBsaW5rIG1heSBiZSBkb3duIHdoZW4NCj4geW91IHByb2JlLg0KPiAN
Cj4gSSB0aGluayB0aGUgd2F5IHRoaXMgYWxsIG5lZWRzIHRvIHdvcmsgaXMgd2l0aCBydW50aW1l
IFBNLiBJZiB0aGF0J3MgYWxsIGluIHBsYWNlLA0KPiB0aGVuIGVpdGhlciB5b3Ugc2h1dGRvd24g
Y2xvY2tzL3Bvd2VyIG9uIHRpbWVvdXQgb3IgdmlhIHN5c2ZzIHN1c3BlbmQuIElmDQo+IHRoZXJl
J3MgYSBjaGlsZCBkZXZpY2UsIHRoZW4gdGhhdCBzaG91bGQgcHJldmVudCBzdXNwZW5kaW5nLg0K
SGkgUm9iOg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIHJldmlldyBjb21tZW50cy4NClVuZGVyc3Rh
bmQgd2hhdCB5b3UgbWVhbi4NCmkuTVggUENJZSBkb2Vzbid0IHN1cHBvcnQgaG90LXBsdWcgZnJv
bSBjaGlwIGRlc2lnbiB2aWV3Lg0KDQpUaGUgb3BzLmhvc3RfZXhpdCgpIGNhbGxiYWNrIGlzIGlu
dm9rZWQgb25seSB3aGVuIHRoZSBpTVggUENJZSBkcml2ZXIgaG9va2VkDQogY2FsbGJhY2sgb3Bz
LT5zdGFydF9saW5rIHJldHVybiBhbiBlcnJvci4NCkZvciB0aGUgcGxhdGZvcm1zLCB0aGF0IHN1
cHBvcnQgdGhlIGhvdC1wbHVnIGZlYXR1cmUsIHRoZXkgY2FuIGp1c3QgcmV0dXJuIG9uZQ0KemVy
byBmcm9tIHRoZWlyIG93biBvcHMtPnN0YXJ0X2xpbmsuDQpJbiB0aGUgY3VycmVudCBzaXR1YXRp
b24sIGkuTVggUENJZSBkb2VzIGp1c3QgcmV0dXJuIG9uZSB6ZXJvIHdoZW4gcHJvYmUgZmFpbGVk
Lg0KU2VlIHRoZSBkaXNjdXNzaW9uIGFuZCBjb21taXQgaXNzdWVkIGJ5IEZhYmlvIGJlbG93Lg0K
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXBjaS9wYXRjaC8xNjQx
MzY4NjAyLTIwNDAxLTYtZ2l0LXNlbmQtZW1haWwtaG9uZ3hpbmcuemh1QG54cC5jb20vDQpodHRw
czovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXgtcGNpL3BhdGNoLzIwMjIwMTA2
MTAzNjQ1LjI3OTA4MDMtMS1mZXN0ZXZhbUBnbWFpbC5jb20vDQoNCj4gDQo+ID4gQWRkIGEgbmV3
IC0+aG9zdF9leGl0KCkgY2FsbGJhY2sgaW4gZHdfcGNpZV9ob3N0X29wcyBzbyB0aGVzZSBkcml2
ZXJzDQo+ID4gY2FuIGNsZWFuIHVwIGlmIC0+aG9zdF9pbml0KCkgZmFpbHMuDQo+IA0KPiBJJ20g
bm90IHJlYWxseSBhIGZhbiBvZiBhZGRpbmcgbW9yZSBvcHMgbm9yIHRoZSBvcHMgd2hpY2ggYXJl
bid0IHRvbyBzcGVjaWZpYw0KPiBhYm91dCB3aGF0IHRoZXkgZG8uICdpbml0JyBhbmQgJ2V4aXQn
IGNhbiBiZSBhbnl0aGluZy4gSSdkIHJhdGhlciBzZWUgbW9yZQ0KPiBzcGVjaWZpYyBvcHMgd2l0
aCB0aGUgRFdDIGNvcmUgZHJpdmVyIGluIGNoYXJnZSBvZiBzZXF1ZW5jZSBvZiBvcGVyYXRpb25z
IGFuZA0KPiB0aGUgc3RhdGUuDQpVbmRlcnN0YW5kLiANCmkuTVggUENJZSBjYW4ndCBoYW5kbGUg
dGhlIGVycm9yIGV4aXQgcHJvcGVybHkgaW4gdGhpcyBjYXNlIGJ5IGl0c2VsZi4gU28gSQ0KIGFk
ZCBvbmUgbW9yZSBvcHMuaG9zdF9leGl0KCkgaW4gdGhpcyBzZXJpZXMuDQoNCkJlc3QgUmVnYXJk
cw0KUmljaGFyZCBaaHUNCj4gDQo+IFJvYg0K
