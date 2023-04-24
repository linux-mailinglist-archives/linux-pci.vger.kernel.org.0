Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4164A6EC643
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 08:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjDXG0Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 02:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXG0P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 02:26:15 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2127.outbound.protection.outlook.com [40.107.114.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0515810C0;
        Sun, 23 Apr 2023 23:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIKyHnlxe2JMpQKwukkWTZ8PqjO+EYA5Kbv1ZD2+Q1NZv+gDq11rh7Mtt1aOyzTjegYvHh+XRb3e07awjNGldhFyni/XSUtCwwIGGvgtO9yJ2bysP2e2FHla6cNWq8edHEBjT0SpLfAxND3GwzCKp0VWHHSa1rrg+/mEfF//iKpbAS9JFlB6g5SWeXKWT3N1RxIDrchjR5N+x1adjsoJjRhfBrs2cbp5L84j08i1Ew6IRiVWkRGSkN8FhZgvqmsFaBZ7uF81H1v6UiGrUlLx286fmyZy0+OfA1see1/bzHzKdaPC9gwdmX/e1NwptYvFykBGxsDKSW7sXRJ2GSdLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th7Gm4vPY1R5g2scrlaSojr35ngUgAmj/uZdatpLJ28=;
 b=HxLsszbbbUPcifF2rVYF2gGfUaxCgM+UpyMRDF/+83lef6QIlV6C4aUQRIC+4uDt9IVBauAOXzE4B+1s9A2Pjg5WHo1BzYU5nlLv0FsRhMiaRL+uj6NG5ciZujDMsT5g24jZX6oqP8uN8EWkLv6L1LaxQFebgpmO6uVz7mBVy6z0Ds1UXypHBJRitbZTB1/8y4bLkYg6Ys5ySaZ7LWBs3T6K1NVuXvWxD4N7mPfRXIiivK14luORA5LyrdRm23KZle7tbwhIQKprmazS9CgUAogxsdynp7uvhY6knhBZgn23vL1kkvFacU+2MUMg/gk4PJHMgCwqjIRwj4we1EPePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th7Gm4vPY1R5g2scrlaSojr35ngUgAmj/uZdatpLJ28=;
 b=YngO2IIV+7m9TI+aHd/T/OqFhoibr9Z9t4UTNM+9eetFwwtZVE5KZkUY+Nav0KwuiVtcvxQMSP1B9xf1iBUGePrD++a9zMnn4OlHwsJeeOPU93C7MO4JTD0fOglVKm4LxS35ugOMXRQcJoZ7vpAPm45/oraHpiX1d24mbqP6asM=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB10193.jpnprd01.prod.outlook.com
 (2603:1096:400:1e5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 06:26:08 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 06:26:08 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v13 14/22] PCI: dwc: Expose dw_pcie_ep_exit() to module
Thread-Topic: [PATCH v13 14/22] PCI: dwc: Expose dw_pcie_ep_exit() to module
Thread-Index: AQHZcfCxqfa4Qw7wHkam/O1GA2MENa83YTeAgAKgoUA=
Date:   Mon, 24 Apr 2023 06:26:08 +0000
Message-ID: <TYBPR01MB5341C7BF87DB9DB1FD73D54FD8679@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-15-yoshihiro.shimoda.uh@renesas.com>
 <20230422135843.GK4769@thinkpad>
In-Reply-To: <20230422135843.GK4769@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB10193:EE_
x-ms-office365-filtering-correlation-id: ed00d6b0-abf8-4141-8966-08db448cca91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zXbPJSO5P9xyDlRkP+GXRK1hMxXjRLtKOriCf9Ayxc8pkckJ/ouy/FWRk8zg6bJtVq++vE70GXAAIM7z+CtGyqaV+FXbpniqJWmX/R2uNzBvy+aXBClUxTZaG1k9h/g0iORCeMojkSHhSFvtSs237aMJxKFe9XSJX4AwMYaUeLkI3hUDf4eixCS4DxLdxoiR0ZUx1jj/VUh1IrBpetBJwFZDj68nun3MfA1rG8GlpMjJJfNcccWDwH6ZJWk7j1ypDBwBrEtjtvbk5luPm1ur5XkrjICNLHNLA8mefmec3/daJdGVocAiFKQkM0QyUxAshD8B6pjzEDZDoPseO8loxnIh1dHWD+C3Yy6185kamBshtoTSYGBZX+RvXZRnq40B6sCPbn6NkCnnpRQYuj6FDhXeTdRTOYS91UABS7xmP521oxDX09oR/YFm+qUCqZyxKkV49tK4fNxTT2G8wdYDJoQjH9HZO9oicjpqLz3YWuNC6l4btzZMPnz8fA5IAHQJdGgV2n4vRYsbdZzR4MV405hNrMauuxexp8Bnon6TDCQc/czW751Zk2CTG3Zq6I3rPMZMErGT3njBd4Gl9apYR3YnQ3w5PFxSqQA6yizBm3zpFNsDRyvD7zE53yjcCAWq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(54906003)(86362001)(186003)(7696005)(9686003)(6506007)(55016003)(33656002)(71200400001)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(316002)(83380400001)(66946007)(76116006)(2906002)(38100700002)(122000001)(41300700001)(8676002)(8936002)(38070700005)(5660300002)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG5JNG1reFZWaUpuQ05RWmI5OGtSU2ZON2hnS0JWbEgzQVpZRmxqSHBGR3Ny?=
 =?utf-8?B?SGpwV3hIbHBacWc1c2kyZ3NLcU9hRm5vL3ZmZzVuVUpudzB5NmZwZm0yZjdL?=
 =?utf-8?B?SWhvZk5ZcExKdHl4TzNIUVlZQkR5YTlhMjB3ZUlTMzNZZVFsOGVQTy9uUWNq?=
 =?utf-8?B?M2Q1OVJFS0Q5ZUNJUEx1K2pwbEtBc1Y2ZHAwSDc2Tk5UVW56NlhJRWRmYTZ3?=
 =?utf-8?B?MHc5VkxHczJOZy9OWGtWNmJTZ3JVQmc2NzJIbitCaXNMTDNudTg1dkUyNTli?=
 =?utf-8?B?YUpVeUlPeEtJVi9wMVJxRFdGUElJaU5MSVI5WnJXMEovdXA2ekNKMlVyZUtv?=
 =?utf-8?B?d1RzSW1EL3lTRjNkTStTZGVaeVJ0dWZ6NldKTk5CY1FLTUlHMHJDQVhCOFM4?=
 =?utf-8?B?cW9Pb29PM00vTVVDU05xZm9oc3U0aC9RVUhiZll3aklzVWR6NVd4QjNFWHV4?=
 =?utf-8?B?TWhldmFPUXFvek56TkRkQXJLQTA2L0ZlRHFJbThtY3RhUExLTmg5Z2JkRjJp?=
 =?utf-8?B?WW1Vbll5bEhlbXN0UU1OcHkzOXlJc1dTV1B2dVJubkFZSGlZRHQ3OC83WmFD?=
 =?utf-8?B?VXNNaWp0UzRNaHRKbCttU2hVK2hiRjQ2ajNOR0x2Mm40L1ZmVGdkVnA1NDRk?=
 =?utf-8?B?NUVZQldyRlFETGowa0ZERHRvQmU3ellkTjRuUldzbVhBTzRrdDlTVVAxdXg0?=
 =?utf-8?B?Nm8rTDRnZ215cjdDSExqS01DRHUzaGt6TnpyaE0xZmNtaFFMK1IydkxsSW9T?=
 =?utf-8?B?M1JGQjFjQkxXbjNxcDB1ZUZMVmI0bTZpVW5kYXpmWkFLUkw4aHRydGlqUys3?=
 =?utf-8?B?R3psMTZVNUxBWDRjVm95cTFqTmdUVXY1WEp3ckUybWlLdGZXRFpZa1NsWXFr?=
 =?utf-8?B?OGRoL3ZNVDlNRUhZMFk0OVZ4R0tMREJ3NUZHcHZBUmFOWWpoeEpOUjNKSTNG?=
 =?utf-8?B?RzhWd011QXczbVFmWE1TQWk3cW5xN0NqZlFZSVE5KzFBVnVjN2RFSGExOGhx?=
 =?utf-8?B?UUsxVjdQUkVJYVBCdldHWDI5SFJ5S1JzbU12bmxZN0ExY0dqNUpoVEgxUkc4?=
 =?utf-8?B?WTRQYTE0N0lkVkJvTTZJcDhySHoyM3BUNUJlcGRjMXpuVFBJSFFXZEg3cjg3?=
 =?utf-8?B?ck80aEtiQVVzakJRMHlrSnpybXQ5ZUZRWVdSZDJ0NEFKWTRRbURrNEFSbU90?=
 =?utf-8?B?UHE1Lzc4T25GaVJoQVlvQ1RWNThlNjNJMzNuZk1iZGZYR1NJdmI3M2F5L1k3?=
 =?utf-8?B?MWlhNGlIR2ZGYUFxQ2gyK2wzdjczS1lVdDlGOFc3Q0xxN2ZITWJYdHlGa2Rx?=
 =?utf-8?B?N2VyWk9ZT0FtdW9vNVBmNHdpaHlWWkxGZVMrUUNwRElPSGVyc2ZqL2dlbFEz?=
 =?utf-8?B?K3RpQlJWWUVKTTdrNkpTUzFDNm9CbDRGUDN2bk9kcmZOVU11eDJyR0VwYVVZ?=
 =?utf-8?B?QzdkcFpRMnJoQ1ZHcjdzTmxZU2h5eG1HZXFLWFlzOTdvL3N4YlRFZ0xjN2cw?=
 =?utf-8?B?bWVwUW45RXVyTUNleWlZWWdUZkJ2VyswSmRLSEtLdHB3a2V2cGwxZUVSZ215?=
 =?utf-8?B?dlZmdGkwbHZud1Rad3BOYnhmT3YwMXcyU215Uis4MGtJWDdxUFpyZ2VxK240?=
 =?utf-8?B?MTlra2YxZDlnaFJTTGxybmVpUm1HcmluWDloUHJHV2M3YjBVQThxT3l6RWZJ?=
 =?utf-8?B?TzZva3UxQXh2bjJiRk5vMlNmZEZ0R2RFN1NucDQ3Q3lTdXRvSE93OVdkMjhN?=
 =?utf-8?B?dEU1c2ovSDNSb1Y4bFRtcFdwa0RMZXRqa2lpZG1FYjZ1R0tKd2ExV0EreHF5?=
 =?utf-8?B?QXBBUUdjNyt3R010bkhLWjNlbmFJYUNHOVNYL3F0VnJ2eDRpeVBZamNTcXRM?=
 =?utf-8?B?N1FzYTRxSDRpUFlJTjk3Uk0vbHcxc3o3dzE2OUI0VGZvK2pFb3N3ZWlTOVhR?=
 =?utf-8?B?VTJkMmZXVlBmVG1Pcm9HNytZM1g3V2xHY0x2WmVGVXJ0cmhTY0lRZTVQeE1F?=
 =?utf-8?B?ekE0bU9idm1vWVl1N3VHbjZWU0pmZmRoUU5DY1hjcUo1eUhyME15MVhWYUdz?=
 =?utf-8?B?Z3g4RFIwS0IrM0JHaklPSHN4eE5CejMxaVN6OWN5dHZqT1FwcEc1ZG9KTy93?=
 =?utf-8?B?eHdRdjk1TlNXSFdONmpCMGZmakdqYzVuNkVtT0F0YzZuYTUzMUViT2NyN3Rv?=
 =?utf-8?B?aGI2M3hzVmtnUnRtRUJpekhNOVpJVi92S3RES3phQytMUjU0QmtsYmVDNzhV?=
 =?utf-8?B?REFWOTA4cllsdklvR0tuRVRpdm13PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed00d6b0-abf8-4141-8966-08db448cca91
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 06:26:08.7505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ochaK7uVlEMTzekRluN3pxDBXX73vtKcamUNKJzPYTGgP9wpafQsUP9n4Cq5wxVgyZgQOSD/uAnZVzKAI7yfjJo4OknbSR/v4/UOvuFVYBNX1M0woqushK0CVwXqy6L3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IFNh
dHVyZGF5LCBBcHJpbCAyMiwgMjAyMyAxMDo1OSBQTQ0KPiANCj4gT24gVHVlLCBBcHIgMTgsIDIw
MjMgYXQgMDk6MjM6NTVQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gRXhw
b3NlIGR3X3BjaWVfZXBfZXhpdCgpIHRvIG1vZHVsZS4NCj4gPg0KPiANCj4gVGhpcyBpcyBub3Qg
YSBnb29kIGNvbW1pdCBtZXNzYWdlLiBZb3UgbmVlZCB0byBtZW50aW9uIHdoeSBpdCBpcyBuZWVk
ZWQgYW5kIGxpc3QNCj4gYW55IGJyZWFrYWdlIG9ic2VydmVkIHdpdGhvdXQgdGhpcy4NCg0KSSds
bCBtb2RpZnkgZGVzY3JpcHRpb24gbGlrZSBiZWxvdzoNCg0KU2luY2Ugbm8gUENJZSBjb250cm9s
bGVyIGRyaXZlcnMgY2FsbCB0aGlzLCB0aGlzIGNoYW5nZSBpcyBub3QgcmVxdWlyZWQNCmZvciBu
b3cuIEJ1dCwgUmVuZXNhcyBSLUNhciBTNC04IFBDSWUgY29udHJvbGxlciBkcml2ZXIgd2lsbCBj
YWxsIHRoaXMNCmFuZCBpZiB0aGUgY29udHJvbGxlciBkcml2ZXIgaXMgYnVpbHQgYXMgYSBrZXJu
ZWwgbW9kdWxlLCB0aGUgZm9sbG93aW5nDQpidWlsZCBlcnJvciBoYXBwZW5zLiBTbywgZXhwb3Nl
IGR3X3BjaWVfZXBfZXhpdCgpIGZvciBpdC4NCg0KRVJST1I6IG1vZHBvc3Q6ICJkd19wY2llX2Vw
X2V4aXQiIFtkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXJjYXItZ2VuNC1lcC1kcnYu
a29dIHVuZGVmaW5lZCENCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiAt
IE1hbmkNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGly
by5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jDQo+ID4gaW5kZXggMzA0ZWQwOTNmNTUxLi4yNDU4Y2Ey
YmMwZTQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLWVwLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWRlc2lnbndhcmUtZXAuYw0KPiA+IEBAIC02ODEsNiArNjgxLDcgQEAgdm9pZCBkd19wY2llX2Vw
X2V4aXQoc3RydWN0IGR3X3BjaWVfZXAgKmVwKQ0KPiA+DQo+ID4gIAlwY2lfZXBjX21lbV9leGl0
KGVwYyk7DQo+ID4gIH0NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoZHdfcGNpZV9lcF9leGl0KTsN
Cj4gPg0KPiA+ICBzdGF0aWMgdW5zaWduZWQgaW50IGR3X3BjaWVfZXBfZmluZF9leHRfY2FwYWJp
bGl0eShzdHJ1Y3QgZHdfcGNpZSAqcGNpLCBpbnQgY2FwKQ0KPiA+ICB7DQo+ID4gLS0NCj4gPiAy
LjI1LjENCj4gPg0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCu
pOCuvuCumuCuv+CuteCuruCvjQ0K
