Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4DD700AAD
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 16:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241294AbjELOvb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 10:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbjELOv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 10:51:29 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC0926B7;
        Fri, 12 May 2023 07:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmPJ366+RZLB7QMowUvQzr8+m0GZKsuDwheAsIWlb02HjzjFipl5PWtDirTWck/Bye2HGViGeok8QpojRFeH1++MwTkCKwai4rkO78bORWNWVClmohiHZJfShzQuA3LeM+SiVRg5w+gDZgl6htANsr8LdWlq1i6CDKLbeL3YDNAA7IrtJ4Q1f5cL5VskFdL7w2awSy4L30Pd+uXHo/LU3RD2Dmti+sWh1YgV6Hf1+yCrOCMd9DLGTzBAsfljV7ZRR5tVz5JBYG7rAxbw1ojzRAZTl+C271PTqlFVSxSKPhPGjx5C1zZnw/RLPTSL4OrsXmIrlAEmEQYns+DEPy3rwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9OHJlMkGgW3nOwbTlrD0NNQ8za9X/p+8vQ8xQWpFRQ=;
 b=ggCUXe0TQbiEkZO3c6ZxRXq6RiMwKT9GLTKq5Dm1H5q6emLS91YHrTmx+GlJ/Gdm1LDFauZTpuxvlSpnveMB+Dmz8nKZJS4vQJr9zl8c/HARKcsyBSxk0vrD6iop9dSkZ+t0SWByHcrpi2iiZbmqO2uoz3l5SYuEA+mLg54L+O4hlCWkI7mWJllxEeaJlCUs97/he1ikMNhbCOwrXi1NEhd3nWuQVvpNBFTE/EFHgngNEdOeKQnaYzkHC2+k3PD904ox8MrxTjNJn7/bPVMaw4Gh4xhXyeW70nrmq56MvRlx/7dmyMl2GSMC73gG0Vo89CZ03HUQfGSmM68KSmJdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9OHJlMkGgW3nOwbTlrD0NNQ8za9X/p+8vQ8xQWpFRQ=;
 b=plgF0Gli32QUg6fuI5BIz2ebzUJEVVeQQM5M50BluV/Z4VAMz6ZreYRVyn/Riiq1Xo+zouIVdMFgiNCBBlZTY6wqk/gbwsn+l9gCtTjf1U93zcDMNjKQOzfCF0XIQ+YxdNyRmTBwANZGKb5BmZ4eYqWhOr4A9Ahbf78ETLOL+eU=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9519.eurprd04.prod.outlook.com (2603:10a6:102:22e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 14:51:26 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 14:51:26 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>
CC:     "allenbh@gmail.com" <allenbh@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kw@linux.com" <kw@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH 1/1] PCI: endpoint: pci-epf-vntb: fix typo span
 in comments
Thread-Topic: [EXT] Re: [PATCH 1/1] PCI: endpoint: pci-epf-vntb: fix typo span
 in comments
Thread-Index: AQHZD+C/PN18RSdcf02dRof7zAQM1K8h24EAgBHFQkCAJAGbwA==
Date:   Fri, 12 May 2023 14:51:26 +0000
Message-ID: <AM6PR04MB483811AF4DE87D78412053B788759@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20221214172254.668282-1-Frank.Li@nxp.com>
 <20230408093644.GG11124@thinkpad>
 <AM6PR04MB48382B6FDA347EE8A0E65F7B88629@AM6PR04MB4838.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB48382B6FDA347EE8A0E65F7B88629@AM6PR04MB4838.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|PAXPR04MB9519:EE_
x-ms-office365-filtering-correlation-id: 1e63dce5-5be6-4986-fd1d-08db52f85ca7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDsleTzkVcihQrnU+U04RWjdtr/LyiocI8l02tuXjojT4m3575U7Ajaz6WmHstp0hH0LBTp8TbailkqgXSbSQLQ0mdy6VLnyuIOGeOHNK2BBzVJlM3sTvd+zO1NpsNTuCwcugiVof8AHggtA75gn8b+vTx1r3ygQwy4YlJt78o+ATJtSnyKKp2hfTLnzkk0vCGsqq8mKHdm6JABmAs/9+Nt36JJVkvyfAuVoubH6eeh+Lcpqrw50DrM2VcYBy/6ltNL5/fQLqe49Hx0TVklCVeRDYO4LaMIcVAhrhqZrEBc8+iuhd9uDwrhfF2CHRxMtRzjgpAafxdcZPxlAru0m2oxI8JvH7UfSl0nTvAd85Hc7URC+PN0L7iq6P79PIRbvEKb0+au5SR0vVyQHqyajV5rwLz+S6fvNgyjf7Hqcv+LR7vLncx/UiF+BgMUM3cDR36xvd87QRydU3/Cyv2F9CQMSJrxapt1nz1wwAb3/sKJoaLlfO+hHcpS6r4EDdHn04BIbyb4sggZ4cdb0S8Vi3HdfgOsRj+HR9apUESKBVbp3nzEzMeDcNG1Wv2djDKDsCkXKB/cxOTHecnzU8FgTsY13kFpncvxzF4SZlfS2RRhm/8LiR/wUF6Krao018c6Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(186003)(55016003)(66476007)(66446008)(4326008)(64756008)(66556008)(66946007)(38070700005)(41300700001)(52536014)(5660300002)(7416002)(8936002)(122000001)(76116006)(44832011)(8676002)(26005)(316002)(6506007)(55236004)(9686003)(54906003)(86362001)(478600001)(71200400001)(33656002)(7696005)(558084003)(110136005)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTRiREdzYnllbEdmdTJHdUlUbTdmSE0rNlJMd1lZNUdaSENmVEZXKzZLc3BN?=
 =?utf-8?B?cUVvWFdFWWpWVDhISWpYaitXcEhBNXoya2VlcE93eEtlS2lucXYrODJMa1Vq?=
 =?utf-8?B?dTZBdHVZT3VEampDNGoxdU05Z29RZ2szYjNkTkk2Y1prMlB1Qi8xTFpZK3BW?=
 =?utf-8?B?c2FXT280THUwZDhSOVpxamVzT242KzZxM1pxN3dPU1IvNW5JR3NVaFlhS0RL?=
 =?utf-8?B?NWRiR3JhbXVDQ0hnS09hOEpMbXprUnJIMStrdFRvQVNvL3NYQ0IyQTR4Y3dw?=
 =?utf-8?B?RkdSRWRrengxQTY2L0xEZmhyMjNjSzE5U2dNbk9hWFRrTWFrbkxlTGUvbFlP?=
 =?utf-8?B?dzNobFlaQWpMUkFlWFoybGI1OFFETDdZdU1jQ0ZiSGNuT2lrQVZkS0hsaWRa?=
 =?utf-8?B?Q2pzU09YMXc1OWpyNzZJZW1sY3pEellHNS9aTGNBejk3QlBxTnArTGZyVTY2?=
 =?utf-8?B?am9zVEZ3V1JtRkovWmwzVEt3cUNlQUNqMUdKdDdQNU5hR3h5OEJYMGRnNWwy?=
 =?utf-8?B?Sm5sN2ZWSkl0Q0lWSFBmZWRlK3QrWlNpcTd5VjZBMGNZZnNmWUd0ODlOUUhK?=
 =?utf-8?B?ZVZXeGdVeVJxMElSRnhQaWtoVmFrSjNiOHFOM3JtVGN3c2hvYk9Cem5jbmx5?=
 =?utf-8?B?U1ZlVXczVFNJUDRhQ3p3aS9PZk8vSkx6NzVxck13b1lqYjlrU1lxeGJIVDFY?=
 =?utf-8?B?eFZUK0lKeXNvVmduQThiT3dOSnFEcUtCV0RjZG0zMFZxYitqekFORFFScVZk?=
 =?utf-8?B?WHZ6TEFCVCt1aGhMV2pBM28rNGMvTVVEVGNSaFZPdUxxVGhMaGYyT2ovOUJS?=
 =?utf-8?B?YzMyeUJPUkREeEpCZDlHQkRBblRhR05CVXFPMGZnend4UkFzYTZSaU0yVVli?=
 =?utf-8?B?MTh5SmRjK1ZhaGtrVFBGR3N6RUx2M2VUMmFhWldNS1VITXVISkpKRk9uZXhJ?=
 =?utf-8?B?aURuTGtGZXNON2NHQ2ZhV0paRWNYOFFsUnRrM2RhMWs3amN2emlyQTFQS2Iy?=
 =?utf-8?B?WmtqRzFERlNUL04vZnFqVldXMGQ2WXhiWnJPNi84b2gvZTRxKzNNaHh3V2Vn?=
 =?utf-8?B?VmZWN2MzT3pJZitDdVJTMkVOTGw1T0hxK2ZTT3hLYm9aM3pyQVZDUFZ1d1BY?=
 =?utf-8?B?R0o4VkM5UXZuaXVId0lDU2kwMll6L2dPVFpXMUxMVk0rRnJmbnExTW1idjJG?=
 =?utf-8?B?Slh2S3Qra0VwdXZ0cVZGSWxHV1JCRlFSQjdiOC85RGNkdjEwU2I0N1NPK0M1?=
 =?utf-8?B?MnIxUzBKbEhIUUo1WVQwRThrYitQdlpQRUFOYURHNEdHN2hieGtKME5aaWF5?=
 =?utf-8?B?QnE4NGxzdEs2UWgwdW1wdTRVbXhpSnhQemdyNGcyQTRXYXZiODVWQ0xxb3FN?=
 =?utf-8?B?TUkxSGl2WlF0d2VPRWFEVmNsdDBUOHpSdy8rSXNpYmwyRVBGV3pNL0t5eDlk?=
 =?utf-8?B?U3ByRmJKZzB2emFpRUJmM2U3aXFLcVFEbk9ISHU0WjlCbktQMkFpeitUQWtD?=
 =?utf-8?B?UW1pOWY3ZmwvVEtOb0cweVBHSE5OU25pSkh3WlFPRjlURUlQQTNiSiszMVhZ?=
 =?utf-8?B?ZTFCQzhlVHl1RXpOdTUwTUd5cmt6ajR5WURqTUt2ZWwzNW5SL3c1MDhUVDJP?=
 =?utf-8?B?ZFU1Yk5sTWFSOEVHWXhXeGkvSTQ0Qm5pbktSdDlUQ1l1QWh5MmdlN3lGMjlT?=
 =?utf-8?B?eWlFdE9QeS9IbDVQZlFXNFhRcXM4YUd3bkU4S0ZHazQ1K3dVN0h4QkUvY25K?=
 =?utf-8?B?S1ZHTkhKMVl2RXVwNW1sc3pMUk9jOWV6Um5HMTYxM0FzUk1xbFpwdUNzL1Nt?=
 =?utf-8?B?dTNNZkVOM1FkT1NqNmVNMnJ6aDl5Z3ZGdTUyYk9YWTcrT0k1Y3pEelY3Sm5w?=
 =?utf-8?B?RHJ1cWZhRUVsL3FFUUwzT2pZOGgyWkJlakVVcFExRTlPT3NHekVRRlZmaEo4?=
 =?utf-8?B?bEtnb3l5OFFmMlZrYnpsQXJBd2hwU2xkbnU5Q3A2dXNDZDV0Vk1adExpVW1l?=
 =?utf-8?B?dUhFWGRoQkRXR3J3dnQ0ZVNibWgwZWNsN0dXSWJObUU1SnFuNHZoUnlHVlp0?=
 =?utf-8?B?T0swd2dxYU1GZmtqRmNFYjJXd0NPeFVJekMzWnlaZmc3aW4ySVdmOGNUcVBx?=
 =?utf-8?Q?c0uw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e63dce5-5be6-4986-fd1d-08db52f85ca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 14:51:26.2537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4+DumWRPk3d/pCc4UxqGsAPzf5MOagMOvwo30Tvp3cyVkx9qSpgSuRyLvFNKlZiKv0tqMhDgpd5yPx2VbiC4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9519
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiA+IE9uIFdlZCwgRGVjIDE0LCAyMDIyIGF0IDEyOjIyOjU0UE0gLTA1MDAsIEZyYW5rIExpIHdy
b3RlOg0KPiA+ID4gUmVwbGFjZSBzcGFuIHdpdGggc3BhZC4NCj4gPiA+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gPg0KPiA+IFJldmlld2VkLWJ5
OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gDQo+IFtGcmFuayBM
aV0gRnJpZW5kbHkgUGluZywganVzdCBjb21tZW50cyBjaGFuZ2UuDQoNCldoeSBubyBwaWNrdXAg
dGhpcyBwYXRjaD8gSnVzdCBmaXhlZCBjb21tZW50cyENCg0KPiANCj4gPg0KPiA+IC0gTWFuaQ0K
PiA+DQo+ID4gPiAtLS0NCg0K
