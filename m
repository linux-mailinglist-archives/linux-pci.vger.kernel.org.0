Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9636C54E8F1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 19:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiFPRzr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 13:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243374AbiFPRzp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 13:55:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212514EA30;
        Thu, 16 Jun 2022 10:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exzl/GashJDSLtPLnB1k4a1CjN/hIMg4FJkGyS/ADxrfbByunPewT8ea9JZVh57m2f+S+cwQ+tf8SbVyP99o7Hrfnq1d/7RmnhlAf4jdx5pD9oDiYUcrZNteUhAr5+d1/rb5kM62LgC61JvzzL9S/p4/BqcXXNcECpJQ14n/PGVKtqLvw2k0dN18/5Pg+tlaEBTQ7RbD4quDdd/ugwLGOUAmHnQxy7R1ST26KzwXNZw2P05XeUmycsy4GGWcH8kvlNHxrfEWXWBUn3rK8TZUDinlqPd03AzdfHVlzGtv3U/L1zSgYC1HGeeroA52UzCJcp18eOHzqgvAroQj/DRoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XK104z+AmHqAjZ+CVOze+S6jkrbhDNbGwKU91YTY1KU=;
 b=aa3KsCPxax9w/ARCWQ7ORbax9dzVBSMA50mhTlUgLIRvWgUdlmhKS2ShM9EyOa/5QI23DK95g2WCS88zYBxpdtJ326mTwFhQuzKN58Wk0G8ETKxC0T/fytNVKjHjlvTNHbrWzlqB6xLD6XKIp2agduS1IkH2PDk3AyvCTqKKKtOhbK7tVmjvyTBFyDlguxOfmRzjyGwcmJav5Sw22QGgX1sFOIZsoX0Cz+Wo8EUGVYKngqfhlcM/1AYLKIbB6O/3gguNbZ5kqYhAUMWc5UnXnDAhRO0zTSeBxxoy2I8Dcd/q/OxtsSN1kHwQYcc59oW5ClRuA37TPg9gW/wj2Veplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK104z+AmHqAjZ+CVOze+S6jkrbhDNbGwKU91YTY1KU=;
 b=Nook3FCMuryl/GWwFmq7zw0BOxzobg8WWtak0CZUSsp3Sy/NTPjFw8/nhoCKBq/XHrcOVOX5eidMRySXqkPlzhU3J9/olLwu0P7/CwkNCbxya+CbehOztgXGXinxIpSO3XCvur6SydEiD+ZtNVRcfp09yn35QZMIRFjwwBDVbKBfB4b5cRpqKOtrtYL9vyuT9uo6U5XGX+YESXTC0wChM1sE6GntholU9Cnzi812ZQKt2O+NFDk6F+viNtE2xfnuf4r2pu0VF61G7vHLSuy6SmirGWbsEvmKAfhNGItKztOu65AL1L0GE3HNItQGFVNZ2q0N3gGoLNZbWqP2Cxb61w==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Thu, 16 Jun
 2022 17:55:42 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3cc0:2098:d2fe:5f56]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3cc0:2098:d2fe:5f56%7]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 17:55:42 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Yi Zhang <yi.zhang@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mstowe@redhat.com" <mstowe@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Thread-Topic: blktests failures with v5.19-rc1
Thread-Index: AQHYfFwe8PMwMXtEZEqIJFDj8WJWFa1IXnmAgAACxQCAADBSgIAAJ8QAgAEp9oCABDqugIAAFNGAgAAEQoCAABbgAIACmtiAgAAlfQCAABQHgIAAW+OAgADdtoA=
Date:   Thu, 16 Jun 2022 17:55:42 +0000
Message-ID: <c104060e-bc7e-817a-9b84-5303d55f6838@nvidia.com>
References: <20220615194727.GA1022614@bhelgaas>
 <cfaee02b-0390-6e1c-e26c-fa0ba3689704@nvidia.com>
 <CAHj4cs88gLYMMefQVrH_+kSsrZhV+VJa5yapEaYXc1Cjnd2w_Q@mail.gmail.com>
 <20220616044211.3c3yspyxfnay5q2i@shindev>
In-Reply-To: <20220616044211.3c3yspyxfnay5q2i@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea2b9d78-e306-45e0-6edf-08da4fc16e41
x-ms-traffictypediagnostic: PH7PR12MB5976:EE_
x-microsoft-antispam-prvs: <PH7PR12MB597685C642DDC70C30E7D78AA3AC9@PH7PR12MB5976.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3KTZbYDSitbZ02PMhdY/ZjX3D4vGn0G3yt4YJPVTHewQkaHax+sBauXXPK6vZaJ48VxecOM62xhu8GdxuLEhcrhYo0JcAmK/jzJOoGJDWIJ3ecfP9UwbFz/B87o4gzNHvj4ajUoDPvD4XEI/dqjnP3FbEj7QySo/w4vUgCYH2uS/aUvO1Sp+buPVGzOpcPQpZvsZzcUQoEu10VGHC9gkdjon/RwVLs4yfflrfn3PrLV9efjTQC5EzFZt4DN306PidlaFBKI96aFdUkCHG9pzbcKQZjXHAcgzTHoeg5Rsi2NM8qXYZ6CzPVLxGNDgoXgMU/hg6yyRo/nNznciqnr3cXCNvp9TeWmKnAUpiHrsQndEl1I9+GucMKkyEKOjZkR6ttZV1CiiaOKfC40Nt2sMvNhF6/JWizQKRPX067dh5D7E06MXnDnfR8lhig8e/GeDHq0PxfZ7OntxirSkd0kkCHXjdQHkAE66T8d5Z8NvV5W055NjIEvZTb79AAXGiXkHWGTljz+Lktystt4GdXQhMCZcYfOKOytlzYq+YziKhBjYFvJJyZEsJvGsrsO3ttIUxcIN6sqOIXrMRnA2ew8bQgvvBSndYuaeDP4sRNhL8s6OfxHh1H2W/w/HQlZnzIiOIODPUzH16plNCe8RPik23g39YOCtH/PYDbsvLDFmLidcbzjPSJAoauxow25LeZJgRa4CEdnjdo14UW3ubXWLIn1h70tobgCZ3yKaYUE1IHMOlhNJJCzYUfBRS4Xl4XyGPJRPom+rJQxUhC9P5HTwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(8936002)(6486002)(6512007)(66446008)(508600001)(66946007)(86362001)(110136005)(38100700002)(76116006)(91956017)(4326008)(31696002)(36756003)(31686004)(316002)(8676002)(2616005)(66556008)(64756008)(38070700005)(54906003)(66476007)(53546011)(6506007)(2906002)(83380400001)(122000001)(186003)(71200400001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnM4OE5mc0k5eXBpY3QwY3gwRzVHR25tUVZWTUt5MExTT3Fhb2Yzd1JxaXBN?=
 =?utf-8?B?MHR5MFF3citPUUFvT2pHeXd3RGFHMktjblVBMnVJLytvdFpGL2FpSHVpUWFl?=
 =?utf-8?B?TzhOQU5TOFU4QlA3Q2Qyb1NjeHdTUFErdmJDMkhiSmNNZ2VEQUdqVzNxOXQ3?=
 =?utf-8?B?L01tZ2FKWXNLMWpmS0ZoVGl2UUZVanpYU3REdlhPRVJzS0Y3R0F5VThlSG5h?=
 =?utf-8?B?T0ZxTlE0NVJ4NDF0RWNNbng1cXVhVVRqc1gzOTVJRERwcERhWmt6MGRJZFdO?=
 =?utf-8?B?aDlmSXJ5NWFGQXZPdWpJSVRqMi9maElBZGM3NW8xNVAwTXNMNU0vM3RNUEFJ?=
 =?utf-8?B?VGdWYW5naENKNzRiUG51VmdCLytOS3pMdnpsek8xYUZYd1lobTF3dEl0U3Ba?=
 =?utf-8?B?YXVMYkg2dFowbHEvZThUdVBqSG1zOGZZWmMrS2w4NTFkaDlacG1sVnZHek5U?=
 =?utf-8?B?ejNndW0zRENWeGhueWdVUG5rekgwa3dYQ1NJVmduTVMyYzBnSnAwczR4cm1T?=
 =?utf-8?B?eVZoc1AxWmE5NmdSZmt6NTFBL3ArSFFKYzlldVVFTE82eVZaemlrWm1vYTh3?=
 =?utf-8?B?Kzk0bmtpWTN6N1kxeEVZQUVQRFNVOEo2SFd5YjhBVk43RVdxT2FxRHhyTGhw?=
 =?utf-8?B?bEFLeGp1OHpyaldIMXgxMmNPRDgwejVFVkxSK1gyV2tHSmFYQzh6N2w3MnM2?=
 =?utf-8?B?WlB3UEpBcm5iOUtlWVVVeWQ2cU9jR25SNHhtTU9qczRDTXEyUVFMbGMzOHNS?=
 =?utf-8?B?aHU3M2pzZEJXQ210VHZYY29Fcnc3OVJISzVNa28rWWtOTXhzUk9QUlMyS3hQ?=
 =?utf-8?B?USt4aG5GNGRZSGEyZXRHd1NWUFdkeWpTYnlFRGx4b3ZxR3VpdDZybjc5NFlp?=
 =?utf-8?B?cTlTdjhEL21xQ3dNbnhySlRPVFgwNUVJT1NTb0dzWW4vM29tZEJXbllLMTZq?=
 =?utf-8?B?aW1VUHBJYUN0dnBhVWo2Vk1aODA5V3R0TzdXUFR6NUJjN2I1UENUREJGMGFi?=
 =?utf-8?B?b3hUMXZXVEx6YzNxY04wT3hYVjdoMXd4N2NqSTFGZGVObjRxUEZYN0dCYXJL?=
 =?utf-8?B?ZlprSkpDcHdkMEJUOU0xeHhUM01qT0QxSDIrZWR5ZjEzQ3VJRmlIWnc0cUto?=
 =?utf-8?B?andqMnhtdGxuWDZFS2ltc25OUjE1NkIxcW1Va3lWZDRDQmUwbHMwOUlyYzlF?=
 =?utf-8?B?bG1qTDQwNlFkSWQzK1BtdXpNWWxMMkd5ZTE5OVZjVElvR0J2Q1JqTzVuYnpJ?=
 =?utf-8?B?REVwcVZzOHhnUS9pUFBSUzNZdlJMU2dEK2JOVlYyZWlPNWZaNzNsT3RneFd3?=
 =?utf-8?B?S1lwRHoxOHRFcnpaTG5qalVwa0hCM0Y0TDBGNmJVWVkrM2xjQnRLdjQ0MU9J?=
 =?utf-8?B?NGs4T0dlSmUrSEQrYlV3V1F2M3N4MERxQWV0OXh1U1VpTXFnMmp0STVGaFhz?=
 =?utf-8?B?VUl5S0tiVkdjZmtWWFIwTUc4U2dYVTlBbWxBYWhIbUZ5Qk1WVDZVaDExMzlR?=
 =?utf-8?B?NUhGckk0eml5L2prS2g3ckw4Z3VVdER2ZzRRZTJJZm9Na05DQVNGMVFsUXA5?=
 =?utf-8?B?c0RZaWJSZ29UdFZGRk82bXBSaEUxUXo5a2IxV3hIT2dVRzlPVDE4YUhLWG1K?=
 =?utf-8?B?dUd6K01uMTA5WHpUVURNL0dnUFVsT3BKWitEVE5RdVphZXJxNXp4WWhjMkRw?=
 =?utf-8?B?Zk5wd1Vka0FZd3BRSmNmQ2lzMjJQMy9waThQdFQxS2lUaEFWWnRETUM5cFMx?=
 =?utf-8?B?N0g2Q0lxemZZdCtHTlhDcFY0ZFFHWmR6d1haVW9uU3pvNE1uTnZ1Tm9SUGQw?=
 =?utf-8?B?Y0FjbjR1Z2ZWaUxsUndVaGdrZXlKbTdmQ1FGUUN4TGRWZmtUZCtCUEU3bnQr?=
 =?utf-8?B?MS9qWDVpdmRLNXdWaGZ5Ui80dWZYRmUwempZNnMxZXpRR1lqcEpFRjFTN3cr?=
 =?utf-8?B?MGVGRyswbVR3T3F0OXdBaE1ORmhTaGhaM0xtdXZ5UzcyNXczdGlqMEN4RGZ6?=
 =?utf-8?B?akpxMTYzRHA1V0oyMUNhdjJrbURtTGtBSDZXV1J5dEJEbk5zSXNrRldtVXFT?=
 =?utf-8?B?ZWZJZndqL0FoZXRvS0hyWTNZZGFiVXIyVEJMcjB0NWt3WHM2ZHU2VVBsbis4?=
 =?utf-8?B?KzZuNnY3WTJBVmVVQkJlSkZ2Z3h2VytwdW9rT3VaTm5XTDR2bElzYWd2a2tE?=
 =?utf-8?B?b2lyRXdES1lvU3kwV0NQcmRSUVQremNyYjBNNnNMcUVPcVJTdE03Zm1mT0dX?=
 =?utf-8?B?dzJIdTAzQ3BMUlFSc3Zzek1OT09rNFdYRHROSFlucUl4a05MVUdrT1NjVysz?=
 =?utf-8?B?MFlzQURLWFZGVWpUVGxabmZFSXBkUXNLUjlob21MbFZRK2pNOTdYUVVxMTlu?=
 =?utf-8?Q?vf0w2QgE8jQKFZntubdAfl4+156jVzlK7+vypZBzhNXLb?=
x-ms-exchange-antispam-messagedata-1: pAZ3+z5JkhtSdw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <223890DEE315574E8EFEE4EDB1902FFE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2b9d78-e306-45e0-6edf-08da4fc16e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 17:55:42.2785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDSSXVVsn+b4JmCi1E6Beomr5cjVADYVymUuDMIrMjKm7u3QFkJNIEqTUWFlGQ3RSmGOpq9C2un60Ux9gL8TkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gNi8xNS8yMDIyIDk6NDIgUE0sIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IE9uIEp1
biAxNiwgMjAyMiAvIDA3OjEzLCBZaSBaaGFuZyB3cm90ZToNCj4+IE9uIFRodSwgSnVuIDE2LCAy
MDIyIGF0IDY6MDEgQU0gQ2hhaXRhbnlhIEt1bGthcm5pDQo+PiA8Y2hhaXRhbnlha0BudmlkaWEu
Y29tPiB3cm90ZToNCj4+Pg0KPj4+IE9uIDYvMTUvMjIgMTI6NDcsIEJqb3JuIEhlbGdhYXMgd3Jv
dGU6DQo+Pj4+IE9uIFR1ZSwgSnVuIDE0LCAyMDIyIGF0IDA0OjAwOjQ1QU0gKzAwMDAsIFNoaW5p
Y2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+Pj4+PiBPbiBKdW4gMTQsIDIwMjIgLyAwMjozOCwgQ2hh
aXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4+Pj4+IFNoaW5pY2hpcm8sDQo+IA0KPiBbc25pcF0N
Cj4gDQo+Pj4+Pj4gSSB0aGluayBpdCBpcyB3b3J0aCBhZGRpbmcgYSB0ZXN0Y2FzZSB0byBibGt0
ZXN0cyB0byBtYWtlIHN1cmUNCj4+Pj4+PiB0aGVzZSBmdXR1cmUgcmVsZWFzZXMgd2lsbCB0ZXN0
IHRoaXMuDQo+Pj4+Pg0KPj4+Pj4gWWVhaCwgdGhpcyBXQVJOIGlzIGNvbmZ1c2luZyBmb3IgdXMg
dGhlbiBpdCB3b3VsZCBiZSB2YWx1YWJsZSB0bw0KPj4+Pj4gdGVzdCBieSBibGt0ZXN0cyBub3Qg
dG8gcmVwZWF0IGl0LiBPbmUgcG9pbnQgSSB3b25kZXIgaXM6IHdoaWNoIHRlc3QNCj4+Pj4+IGdy
b3VwIHRoZSB0ZXN0IGNhc2Ugd2lsbCBpdCBmYWxsIGluPyBUaGUgbnZtZSBncm91cCBjb3VsZCBi
ZSB0aGUNCj4+Pj4+IGdyb3VwIHRvIGFkZCwgcHJvYmFibHkuDQo+Pj4+Pg0KPj4+DQo+Pj4gc2lu
Y2UgdGhpcyBpc3N1ZSBiZWVuIGRpc2NvdmVyZWQgd2l0aCBudm1lIHJlc2NhbiBhbmQgcmV2bW9l
LA0KPj4+IGl0IHNob3VsZCBiZSBhZGRlZCB0byB0aGUgbnZtZSBjYXRlZ29yeS4NCj4+DQo+PiBX
ZSBhbHJlYWR5IGhhdmUgbnZtZS8wMzIgd2hpY2ggdGVzdHMgbnZtZSByZXNjYW4vcmVzZXQvcmVt
b3ZlIGFuZCB0aGUNCj4+IGlzc3VlIHdhcyByZXBvcnRlZCBieSBydW5uaW5nIHRoaXMgb25lLCBk
byB3ZSBzdGlsbCBuZWVkIG9uZSBtb3JlPw0KPiANCj4gVGhhdCBpcyBhIHBvaW50LiBDdXJyZW50
IG52bWUvMDMyIGNoZWNrcyBudm1lIHBjaSBhZGFwdGVyIHJlc2Nhbi9yZXNldC9yZW1vdmUNCj4g
ZHVyaW5nIEkvTyB0byBjYXRjaCBwcm9ibGVtcyBpbiBudm1lIGRyaXZlciBhbmQgYmxvY2sgbGF5
ZXIsIGJ1dCBhY3R1YWxseSBpdA0KPiBjYW4gY2F0Y2ggdGhlIHByb2JsZW0gaW4gcGNpIHN1Yi1z
eXN0ZW0gYWxzby4gSSB0aGluayBDaGFpdGFueWEncyBtb3RpdmF0aW9uDQo+IGZvciB0aGUgbmV3
IHRlc3QgY2FzZSBpcyB0byBkaXN0aW5ndWlzaCB0aG9zZSB0d28uDQo+IA0KDQpZZXMsIGV4YWN0
bHkuDQoNCj4gSWYgd2UgaGF2ZSB0aGUgbmV3IHRlc3QgY2FzZSwgaXRzIGNvZGUgd2lsbCBiZSBz
aW1pbGFyIGFuZCBkdXBsaWNhdGVkIGFzDQo+IG52bWUvMDMyIGNvZGUuIFRvIGF2b2lkIHN1Y2gg
ZHVwbGljYXRpb24sIGl0IHdvdWxkIGJlIGdvb2QgdG8gaW1wcm92ZSBudm1lLzAzMg0KPiB0byBo
YXZlIHR3byBzdGVwcy4gVGhlIDFzdCBzdGVwIGNoZWNrcyB0aGF0IG52bWUgcGNpIGFkYXB0ZXIg
cmVzY2FuL3Jlc2V0L3JlbW92ZQ0KPiB3aXRob3V0IEkvTyBjYXVzZXMgbm8ga2VybmVsIFdBUk4g
KG9yIGFueSBvdGhlciB1bmV4cGVjdGVkIGtlcm5lbCBtZXNzYWdlcykuIEFueQ0KPiBpc3N1ZSBm
b3VuZCBpbiB0aGlzIHN0ZXAgaXMgcmVwb3J0ZWQgYXMgYSBwY2kgc3ViLXN5c3RlbSBpc3N1ZS4g
VGhlIDJuZCBzdGVwDQo+IGNoZWNrcyBudm1lIHBjaSBhZGFwdGVyIHJlc2Nhbi9yZXNldC9yZW1v
dmUgZHVyaW5nIEkvTywgYXMgdGhlIGN1cnJlbnQgbnZtZS8wMzINCj4gZG9lcy4gV2l0aCB0aGlz
LCB3ZSBkb24ndCBuZWVkIHRoZSBuZXcgdGVzdCBjYXNlLCBidXQgc3RpbGwgd2UgY2FuIGRpc3Rp
bmd1aXNoDQo+IHRoZSBwcm9ibGVtcyBpbiBudm1lL2Jsb2NrIHN1Yi1zeXN0ZW0gYW5kIHBjaSBz
dWItc3lzdGVtLg0KPiANCg0KVG90YWxseSBhZ3JlZSB3aXRoIHRoaXMuDQoNCj4+Pj4+IEFub3Ro
ZXIgcG9pbnQgSSB3b25kZXIgaXMgb3RoZXIga2VybmVsIHRlc3Qgc3VpdGUgdGhhbiBibGt0ZXN0
cy4NCj4+Pj4+IERvbid0IHdlIGhhdmUgbW9yZSBhcHByb3ByaWF0ZSB0ZXN0IHN1aXRlIHRvIGNo
ZWNrIFBDSSBkZXZpY2UNCj4+Pj4+IHJlc2Nhbi9yZW1vdmUgcmFjZSA/IFN1Y2ggYSB0ZXN0IHNv
dW5kcyBtb3JlIGxpa2UgYSBQQ0kgYnVzDQo+Pj4+PiBzdWItc3lzdGVtIHRlc3QgdGhhbiBibG9j
ay9zdG9yYWdlIHRlc3QuDQo+Pj4NCj4+PiBJIGRvbid0IHRoaW5rIHNvIHdlIGNvdWxkIGhhdmUg
Y2F1Z2h0IGl0IGxvbmcgdGltZSBiYWNrLA0KPj4+IGJ1dCB3ZSBjbGVhcmx5IGRpZCBub3QuDQo+
IA0KPiBJIHNlZSwgdGhlbiBpdCBsb29rcyB0aGF0IGJsa3Rlc3RzIGlzIHRoZSB0ZXN0IHN1aXRl
IHRvIHRlc3QgaXQuDQo+IA0KDQotY2sNCg0KDQo=
