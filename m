Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA6D583BD6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 12:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiG1KMC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 06:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiG1KMA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 06:12:00 -0400
Received: from mail1.bemta31.messagelabs.com (mail1.bemta31.messagelabs.com [67.219.246.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9823AE7B;
        Thu, 28 Jul 2022 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1659003118; i=@lenovo.com;
        bh=GUa990eFHw/GUI0Fy1EZQ1l3DBw7rq2UZTP3oBWhWSQ=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=YLOU+jflOdxmPRefI6EDuEuPucD+RAeJtU7PBOjNRt0o2lGG8iYZjxKkRq3CzsT6T
         /eKgtI7Dqj87Rz21SExMycDBgYoaqbU520aURNMABZUChwrG7JEX8WJRp8qpwbzf1z
         4DjdZ2QXw/kWCV93SlJGBAdWcF8PsD7xIibWDXhBGpUvZnvaccS68nSId5bJqYzHJ9
         6m8xso+mR1+KgSipJfmky1wf1pdKSNCjjQ54uQW1KXXGMJY9MIqXGDHLL5yuKw8jb1
         rKYUI3kWrPV7DXliT6nQLu1TkRg2Al/AmQ/jILXb5Q6xWa40FZJZYsO95LS8tAHWkr
         BDSCfe6Qpqmrw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRWlGSWpSXmKPExsWSoZ+nrfs24VG
  SwaVeKYslTRkWl3fNYbM4O+84m8XO873sFu0rr7A6sHosXjGF1WPBplKPeScDPT5vkgtgiWLN
  zEvKr0hgzdh0tpu54LJZRc+MOWwNjD9Muxi5OBgFljJL3O66yAjhLGKV6FzyG8rZwCjR/eszm
  CMkMIdJYu+zXijnPqPE+dcvmboYOTnYBLQkZhz8ww5iiwisY5Q4tKoQxGYWyJfYdHofWFxYIE
  7i02+Qeg6gmniJcz88IMqNJM4f+MMCYrMIqEqcePyXGcTmFYiVWPtvB5gtJFAvMf/EBFYQm1P
  AWaJr2SywOKOAmMT3U2uYIFaJS9x6Mh/MlhAQkFiy5zwzhC0q8fLxP1aI+hKJWy/Xs0HEZSUu
  ze9mhLB9JZ68a2OHsHUlZhxZDtUrJ7Gq9yELhC0vMW3Re6gaGYkHN7azgcJBQuAJm0TPre1QQ
  3ezSBx4HwVhG0jM+3YEquiGiET7wT4WkOeZBTQl1u/ShzhaUWJK90P2CYzas5D8MAuhahaSql
  ngYBGUODnzCcsCRpZVjJZJRZnpGSW5iZk5uoYGBrqGhia6hroWhnqJVbqJeqXFuqmJxSW6QG5
  5sV5qcbFecWVuck6KXl5qySZGYHJKKWIM3ME4o+en3iFGSQ4mJVHe7LhHSUJ8SfkplRmJxRnx
  RaU5qcWHGGU4OJQkeA9EA+UEi1LTUyvSMnOAiRImLcHBoyTCywlMlkK8xQWJucWZ6RCpU4zGH
  Fe27d3LzDF19r/9zEIsefl5qVLivE/jgUoFQEozSvPgBsES+CVGWSlhXkYGBgYhnoLUotzMEl
  T5V4ziHIxKwrxrQKbwZOaVwO17BXQKE9ApWxQegJxSkoiQkmpgSv40KdcsqnhRkh2TjLOvAEP
  Xlj5ujf03bhzYVbBrC6uJ8mPRbeo/t+k/8XkbGnbcJGvTrc6AuPellu37/epeJ9ZPbv+0WUn4
  f/XyqJdK3gVNz25McWe90/yVb31n88X1CkEae3OuC2Y++XnZLr5+3kTmCu7Anywcl94cD3ctL
  O0R3cR+ZaVubk/5Mg4Vi3f+XYJqS9xTtyqI1Hde2hV647sD4+JHzta7dXbPvuahFC7d6vPW4+
  M18YwtAkXXMtOYjyeGeDYZinJ+ZZ7rVnPwOrvS56MP/icwlJ6xMPz0m/nEqRunV36YdjHs1bp
  lIl1NW1/kTt9+zfWywOoLDSXPZY9sWdvNxRRmvKLjs0K6EktxRqKhFnNRcSIAFiUg5VsEAAA=
X-Env-Sender: lixc17@lenovo.com
X-Msg-Ref: server-6.tower-686.messagelabs.com!1659003116!1016707!1
X-Originating-IP: [104.47.110.43]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26062 invoked from network); 28 Jul 2022 10:11:57 -0000
Received: from mail-tyzapc01lp2043.outbound.protection.outlook.com (HELO APC01-TYZ-obe.outbound.protection.outlook.com) (104.47.110.43)
  by server-6.tower-686.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Jul 2022 10:11:57 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz0laE7zsnreeTxsZnUSERqiE5MBJiAVh6k2xY1YA/RNcKa7tWWOWWqfXXsscna+wiWaKuyFpRINgFS5oygQ7Jk3B5n37f29cfZuMN+jsH0oMqqng8rlqIOWPn17m/uSPPcRYlK7dWJcep+yyyXVuNl2+5DfRFgMdnO/Fbq7I0yrAkylRqNjdAzzaw/Ek9CjCpUWq01VCOWKk1XW9dugvA4m2izPdG+bhw/FZ9ahHMAlk5KRzITEo5da52x5kJai/KKwFq73M0jzjHzBg9aayMrrGKLB3CnYby2Ji+hX7EsIglVUsMRlKjCRd/cov0DYaWReh+WXRQfYlWgrUGUfvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUa990eFHw/GUI0Fy1EZQ1l3DBw7rq2UZTP3oBWhWSQ=;
 b=oJ3EKiJu3X9qXmQv5NA7HY539b1kQE9p3AjpzeDRyFvjagGWcZRqA/mx5x84JmjG3BMJPnzf9i75CAgwP0SvEnsxNJj1PjLqw+dEkUou2sxfGV/qe56KN1Lv4bSZt9COPzp14M0qGhYGmFyUGYVQ58/V+JTN/wXu4i6emi4gpC918QUiHLJNgI3gM8B3ekuarZIt2vDdg0I2ynRX115t9M8gEm3AyF9bNwWPsYZAgJh4z8iBbJPrr5E8V8iSGbtddPj8J8YoJCPhI6Bu29LQItCcxWbbfr3X1RBFfAEOTLsTdJ+yo00nqUcU7WrKffulvxMRW6k6te/wggf1LLUjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from TY2PR03MB4557.apcprd03.prod.outlook.com (2603:1096:404:e9::14)
 by SG2PR03MB3563.apcprd03.prod.outlook.com (2603:1096:4:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1; Thu, 28 Jul
 2022 10:11:54 +0000
Received: from TY2PR03MB4557.apcprd03.prod.outlook.com
 ([fe80::5488:6e0f:3065:cd1c]) by TY2PR03MB4557.apcprd03.prod.outlook.com
 ([fe80::5488:6e0f:3065:cd1c%3]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 10:11:53 +0000
From:   Xiaochun XC17 Li <lixc17@lenovo.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Xiaochun Lee <lixiaochun.2888@163.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [External] Re: [PATCH v1] PCI/DPC: Skip EDR init when BIOS
 disable OS native DPC
Thread-Topic: [External] Re: [PATCH v1] PCI/DPC: Skip EDR init when BIOS
 disable OS native DPC
Thread-Index: AQHYocSVOV+3ryfrfEO0kRyo9BQHNa2TS05Q
Date:   Thu, 28 Jul 2022 10:11:53 +0000
Message-ID: <TY2PR03MB45574010689A675444CCFA98BC969@TY2PR03MB4557.apcprd03.prod.outlook.com>
References: <1658919957-53006-1-git-send-email-lixiaochun.2888@163.com>
 <3dc43f00-0b01-1b02-74dc-6938f6db6e29@linux.intel.com>
In-Reply-To: <3dc43f00-0b01-1b02-74dc-6938f6db6e29@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d929a7b-04b0-40b4-bca3-08da70819890
x-ms-traffictypediagnostic: SG2PR03MB3563:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2z0/4RwOzwU0tJWXm7DzTIzpGdRjaAkY1pY97nuhoztVCu4QqUxLR+eaZhl90G4XJnFsJmHBYEpOBeNh5Zt3CbHmXdcx0h01uyJ1IvXDYmHTF22nItGDhO0Boz1h3IcvH121K4jfVIWWCV+TH6GOa8HpNqDEtwxhnaX/VT6mi+N9hOw1B+DOmqndsSp+5UXW79Qh2jct5PTK7vjQGEkDyGKd9QR6LP712SGMpPrQkF6wjfhqpuYjlqobLMBsLNRP4J2DwnaSnCeibTSZx8YXmtoUQt4vtj+3P5IoPNQjwnCj7FudAO/avSMKDwbWlQN9Ps15uazLEGJ6UvvT+vvUB1zKYhn/HDPql+0KFU5Xp8Fw4kh7GwH8+epCCngU2x6+yV6bNf7KYK5idTPXroC/DSVFSmoSJ7AhVpmONQo7rhu0befzJ7bxNWj6pTzMBxty8FqS67c6GyrA5Sgt8+zpzNGKMfJ1r4tVsmfS6sZmP/+Pcsdgv629KbTkqoNNWHs9sP+ujEceLYvbAWCr7CInh8Q/vAt+KomTTFLLKixfuZriVtdUAkJjZxI8Dpa0eVQz/A60jK6wQJl7TwLi/rgbtCRlTrbxdD2NxwB7S2VVMQfgfVghrHz2RUehvwtZsvECUXYaHp4FV2Ja8gSgdZNeUqdpaE4lJ8DnpBhxcPEXceX9nmS2RB2ynBtSE/RtXmVtuKxzUaSejJvtwrgkyLAMuW98nPGZYz6Ys0wma3Avqgd34sNSIQtAsAOQJKOtCVGLibsaY5YIwJAeo1oA1LnPcRMZGzJM6qai9zq5cMgnZKruqOtQyVK9ehcSLUCqHA6d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR03MB4557.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(33656002)(478600001)(64756008)(8676002)(52536014)(8936002)(122000001)(71200400001)(2906002)(66476007)(5660300002)(26005)(66446008)(6506007)(7696005)(66946007)(86362001)(83380400001)(4326008)(186003)(76116006)(41300700001)(82960400001)(110136005)(53546011)(9686003)(66556008)(55016003)(38100700002)(38070700005)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG5JQjN6bkZIUXYwREZkM1BzT21LZzB4di95amlQYjlJbHVlSHZlUDd1TlVq?=
 =?utf-8?B?U3JDM2k3bk03NjN5Z2pCRnpOVVN2ZmN1cW9NTlNNWnBIeEZlRVk2Vm9RRk1p?=
 =?utf-8?B?bnBDczhDZFFFUnBFL1dRNVk2cVdhRjlOalF2Z3Y1Tkx0Qyt2RFMwNi83dXNR?=
 =?utf-8?B?U3dIZTdtbFlBMDdtclNnR083RW9lNnE3T2dCNzU1U2xXd2pKZXJlU3NhaG5M?=
 =?utf-8?B?Nk5IZFlKZzJtMmN2NXUwQnp2LzhXVVpsc281WXhRbXZnTkJmYkFEN0lVWWZ3?=
 =?utf-8?B?RHVVaHJBeWtlRzNkWEU4RVhDaXR5cjVKMVMwV2lwcG1VWkZNa0tCTHgxbXhY?=
 =?utf-8?B?d3lqaE9uZFplSHduYlA2VDVVYXVBQzNyQ25PTkZLTFRSazdaTENFTzZrWHor?=
 =?utf-8?B?V0VlWXBXTVo4QlNOWStsWE01VVh3RGFBc3Y2eW1Bay9GSkdNMXNyUWhCWmtw?=
 =?utf-8?B?OWh3aStMSXY2R3ZmKzVzZllVUDVhVGxwcUFxd3NkSHk5R1h0b0U1aTZxbWU3?=
 =?utf-8?B?ay94Z25LUmsrbEdBdGhrR2ppMjE5N1k4SFBoNEFHVjZoOXZGSUNCRVFrSFN3?=
 =?utf-8?B?UEJoUDRtTEVPczRkY0hBeEMzam4xanJmRUJkVU9NNWRMMEtleU9taE1hc1V0?=
 =?utf-8?B?a2NiQ0wvZUVFZExtU2xiemdYTE04NGFzUFRNaUVtOXpMZ3lUR2hOTlErUmdF?=
 =?utf-8?B?eVljdGRvZHNvOUwvbG9WSytvYUl4b3k5cWZOaFVDcnhxS080WksydHlpbVlH?=
 =?utf-8?B?Vk5JNThlQlo4RkdzRytYYUUyWlAwV0JmcVpzd0poV3VPNlg5VnhMUTFlK1dC?=
 =?utf-8?B?NWpldjVFbU1JUjZvR3UxNE9hcUxINXRZYzJ0MlFRMmlyVWk3MzZIU1FqYU0y?=
 =?utf-8?B?bzhTMUM2VEw4YXc1OG5DYW9SNUViTmt5VHpObTRGdDd6aFlJTmtoMk5OQ0JF?=
 =?utf-8?B?d21kS3NTL3pxT3c4MnplNWNVUFZJaEUwV05lSXdUWVByb0JRK1NldzQxZjh6?=
 =?utf-8?B?Wk5OaHZCSWNNSkNJdU5iNWN6Z3prMTdzRFB5RXFMdjFGek9sTXFQV29abnhL?=
 =?utf-8?B?VlBXcU1JR0xUQnRQSWw0N1lXcTAyT0Z1WlRSbkg4NTFJLzRjY2UrMjB1ZnE0?=
 =?utf-8?B?a1Q5TWhBeVFoZ0NNdlJ1OEloUGkzSUdtT1FJS2x3SDJoRGZYaXNyV2VjWmdM?=
 =?utf-8?B?cTFqczZzQXA1QXB6bzlyN051TVFLVFNGblhqaFN1d3llSVpkTzdza2RWN255?=
 =?utf-8?B?UFJhUHp2R3lSaUxaUkV0N2xjMXJNdmgycUhFSktIUGZnd3VnV3gxRWhDcGxO?=
 =?utf-8?B?MzJNdzZjZ0gvMHdkUUFGclk0R1RBVUlScHBUaGZpaHNDVmM5L1JKMmFVaC9t?=
 =?utf-8?B?Q0ZQblVPUHkvTlBScDNrQlI3ZXd5bnBCY3ZrMGVNK2tIakhZNmF5cWdUb1pX?=
 =?utf-8?B?OUtYZW93c1U2RkdrdnBwdmNtS3ZycWhWajJSaDRtWXJOMWVnSll5VWVXUWw1?=
 =?utf-8?B?UzZZUWxhdFdneUhCZGNhS3M5d3NmdXAxbUlBcUZPcWdZbS81TUZRRU4xUzI2?=
 =?utf-8?B?aVM1RzZMeEpaWTFRelJrZ0NTVTRFc1VMbHRBQ2tjeWd4c0pDQWxiVXE1Sitn?=
 =?utf-8?B?ZlExQjRaejcyaFdIWkQxVFJPNmtwS3Qzd1JkVlE5SU9ZQm51R1hFK3VVMGR1?=
 =?utf-8?B?NHhmUWRyeTE5MzJOclZ5VFFRU1VacG9CWHUzRDlhMU1GRXRvS3REWnZ1ejcw?=
 =?utf-8?B?WHlDbnh5ako0UjBpODVkUlFZNW1xdkdnYTJqMHplbDZBRkk0KythVlVpQWY0?=
 =?utf-8?B?bkRqRWc2bGh1ZjNHNTluUG0vVW50bUNUR0JRYk9mSlN5ditDZWttc1NxdWRj?=
 =?utf-8?B?SW5CcU5vZm9lZk5wMXpQblZCenhKdW90bU9YMGRjZ2wvdkV1MTRwOVVlOFJv?=
 =?utf-8?B?RU5jZG51dHV2cmd3ZTgvOVFGbkxiYmNxVlV2TTFHTFhIMW41T1d0RGhrK1VR?=
 =?utf-8?B?bStWajdTRUVCbklZR3FxZTAwZDdSRlYyN1NMNEIxN1EvRzVqUitMLzYzVGQ0?=
 =?utf-8?B?dVBDWEhyOGNxZnNoaGhwNjZZTGlHOGxIWTBqRWptQWMya3lDMEhEdUU2WXQ1?=
 =?utf-8?Q?gcHo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR03MB4557.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d929a7b-04b0-40b4-bca3-08da70819890
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 10:11:53.8748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIsxSlCcgpCv88adZIJZ16j6uPs6e1JWHZBmD5R6ZmQpmsDa8xNkT0Wz32hvmRWUABoJftD4fZBE7Rh1os1csA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB3563
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksIA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYXRoeWFuYXJheWFu
YW4gS3VwcHVzd2FteQ0KPiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwu
Y29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMjcsIDIwMjIgMTA6MjQgUE0NCj4gVG86IFhp
YW9jaHVuIExlZSA8bGl4aWFvY2h1bi4yODg4QDE2My5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnDQo+IENjOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBYaWFvY2h1biBYQzE3IExpDQo+IDxsaXhjMTdAbGVub3ZvLmNvbT4NCj4gU3ViamVj
dDogW0V4dGVybmFsXSBSZTogW1BBVENIIHYxXSBQQ0kvRFBDOiBTa2lwIEVEUiBpbml0IHdoZW4g
QklPUyBkaXNhYmxlDQo+IE9TIG5hdGl2ZSBEUEMNCj4gDQo+IEhpLA0KPiANCj4gT24gNy8yNy8y
MiA0OjA1IEFNLCBYaWFvY2h1biBMZWUgd3JvdGU6DQo+ID4gRnJvbTogWGlhb2NodW4gTGVlIDxs
aXhjMTdAbGVub3ZvLmNvbT4NCj4gPg0KPiA+IEFDUEkgQklPUyBtYXkgZGlzYWJsZSBPUyBuYXRp
dmUgQUVSIGFuZCBEUEMgc3VwcG9ydCB0byBub3RpZnkgT1MgdGhhdA0KPiA+IG91ciBwbGF0Zm9y
bSBkb2Vzbid0IHN1cHBvcnQgQUVSIGFuZCBEUEMgdmlhIHRoZSBfT1NDIG1ldGhvZC4NCj4gPiBC
SU9TIGFsc28gbWlnaHQgbGVhdmUgdGhlIGNvbnRhaW5tZW50IGJlIGFjY29tcGxpc2hlZCBwdXJl
bHkgaW4gSFcuDQo+ID4gV2hlbiBmaXJtd2FyZSBpcyBzZXQgdG8gbm9uLWF3YXJlIE9TIERQQywg
d2Ugc2tpcCB0byBpbnN0YWxsIEVEUg0KPiA+IGhhbmRsZXIgdG8gYW4gQUNQSSBkZXZpY2UuDQo+
IA0KPiBObywgRURSIGlzIHVzZWQgd2hlbiBmaXJtd2FyZSBjb250cm9scyB0aGUgRFBDLg0KPiAN
Cj4gV2hlbiB0aGUgRmlybXdhcmUgb3ducyBEb3duc3RyZWFtIFBvcnQgQ29udGFpbm1lbnQsIGl0
IGlzIGV4cGVjdGVkIHRvDQo+IHVzZSB0aGUgbmV3IOKAnEVycm9yIERpc2Nvbm5lY3QgUmVjb3Zl
cuKAnSBub3RpZmljYXRpb24gdG8gYWxlcnQgT1NQTSBvZiBhDQo+IERvd25zdHJlYW0gUG9ydCBD
b250YWlubWVudCBldmVudC4NCg0KVGhhbmsgeW91IGZvciBjb3JyZWN0aW5nIG1lIG9uIHRoYXQu
IENvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgbW9yZSBpbmZvcm1hdGlvbg0KYWJvdXQgdGhlIGJlbG93
IHF1ZXN0aW9ucz8gTWFueSB0aGFua3MhDQpBcyB5b3UgbWVudGlvbmVkLCB3aGVuIEZpcm13YXJl
IGlzIHNldCB0byB0aGUgcGxhdGZvcm0gbm90IHRvIHN1cHBvcnQNCk9TIG5hdGl2ZSBEUEMsICBz
aG91bGQgT1Mgc3RpbGwgaGF2ZSB0byBoYW5kbGUgRFBDIGZsb3cgZnJvbSBhbiBFRFIgZXZlbnQ/
DQpJbiBteSBzeXN0ZW1zLCB3aGVuIEkgZGlzYWJsZSBuYXRpdmUgRFBDIGluIFVFRkkgQklPUywg
a2VybmVsIG1lc3NhZ2VzDQpzaG93IHRoZSAicGxhdGZvcm0gZG9lcyBub3Qgc3VwcG9ydCBbU0hQ
Q0hvdHBsdWcgQUVSIERQQ10iIGFzIGZvbGxvd3MsDQphbmQgaXQgc2F5cyBPUyBub3cgY29udHJv
bHMgY2FwYWJpbGl0aWVzIHRoYXQgZG8gbm90IGluY2x1ZGUgQUVSIERQQy4NCg0KWyAgICAyLjQw
MDk5Nl0gYWNwaSBQTlAwQTA4OjA0OiBfT1NDOiBPUyBzdXBwb3J0cyBbRXh0ZW5kZWRDb25maWcg
QVNQTSBDbG9ja1BNIFNlZ21lbnRzIE1TSSBFRFIgSFBYLVR5cGUzXQ0KWyAgICAyLjQwMjIyN10g
YWNwaSBQTlAwQTA4OjA0OiBfT1NDOiBwbGF0Zm9ybSBkb2VzIG5vdCBzdXBwb3J0IFtTSFBDSG90
cGx1ZyBBRVIgRFBDXQ0KWyAgICAyLjQwMjUyMF0gYWNwaSBQTlAwQTA4OjA0OiBfT1NDOiBPUyBu
b3cgY29udHJvbHMgW1BDSWVIb3RwbHVnIFBNRSBQQ0llQ2FwYWJpbGl0eSBMVFJdDQpbICAgIDIu
NDAyNTIxXSBhY3BpIFBOUDBBMDg6MDQ6IEZBRFQgaW5kaWNhdGVzIEFTUE0gaXMgdW5zdXBwb3J0
ZWQsIHVzaW5nIEJJT1MgY29uZmlndXJhdGlvbg0KDQpBZnRlciBJIGluamVjdGVkIGEgUENJRSBD
VE8gVUNFIERFUiBldmVudCByZWNlaXZlZCBhbmQgRFBDIHN0YXJ0ZWQNCnJ1bm5pbmcgYXMgeW91
IHNhaWQsIEJ1dCB0aGVyZSBpcyBhIGxpdHRsZSBiaXQgb2YgY29uZnVzaW9uIGFzIHRvIHdoeSBJ
DQpkaXNhYmxlIE9TIG5hdGl2ZSBEQ1AsIGl0IHN0aWxsIGJlIHRyaWdnZXJlZC4gDQpUaGUgaW5q
ZWN0aW9uIG1lc3NhZ2UgbGlzdGVkIGFzIGJlbG93Lg0KDQpbICA4MzIuODM0Nzg1XSBwY2llcG9y
dCAwMDAwOmE3OjAxLjA6IEVEUjogRURSIGV2ZW50IHJlY2VpdmVkDQpbICA4MzIuODM1MjMyXSBw
Y2llcG9ydCAwMDAwOmE3OjAxLjA6IERQQzogY29udGFpbm1lbnQgZXZlbnQsIHN0YXR1czoweDFm
MDkgc291cmNlOjB4MDAwMA0KWyAgODMyLjgzNTIzOV0gcGNpZXBvcnQgMDAwMDphNzowMS4wOiBE
UEM6IHVubWFza2VkIHVuY29ycmVjdGFibGUgZXJyb3IgZGV0ZWN0ZWQNClsgIDgzMi44MzUyNDZd
IHBjaWVwb3J0IDAwMDA6YTc6MDEuMDogUENJZSBCdXMgRXJyb3I6IHNldmVyaXR5PVVuY29ycmVj
dGVkIChOb24tRmF0YWwpLCB0eXBlPVRyYW5zYWN0aW9uIExheWVyLCAoUmVxdWVzdGVyIElEKQ0K
WyAgODMyLjgzNTI1M10gcGNpZXBvcnQgMDAwMDphNzowMS4wOiAgIGRldmljZSBbODA4NjozNTJh
XSBlcnJvciBzdGF0dXMvbWFzaz0wMDAwNDAwMC8wMDE4MDAyMA0KWyAgODMyLjgzNTI1OF0gcGNp
ZXBvcnQgMDAwMDphNzowMS4wOiAgICBbMTRdIENtcGx0VE8gICAgICAgICAgICAgICAgKEZpcnN0
KQ0KWyAgOTAzLjM5NDgzN10gcGNpZXBvcnQgMDAwMDphNzowMS4wOiBBRVI6IGRldmljZSByZWNv
dmVyeSBzdWNjZXNzZnVsDQoNCk9uIHRoZSBjb250cmFyeSwgaWYgd2Uga2VlcCBPUyBuYXRpdmUg
QUVSIERQQyBlbmFibGVkIG9uIEJJT1MsDQp3ZSBjYW4gc2VlIHRoZSBtZXNzYWdlIGFzIGJlbG93
LCBPUyBub3cgY29udHJvbHMgQUVSIERQQy4gDQpVbmRlciB0aGVzZSBzZXR0aW5ncywgd2hvIHNo
b3VsZCAgaGFuZGxlIERQQyBpZiBhbiBlcnJvciBpcyBjb21pbmc/DQpJcyBpdCB0aGUgRURSIGV2
ZW50IG9yIHRoZSBEUEMgaW50ZXJydXB0IChkcGNfaXJxKT8gDQpEb2VzIHRoZSBCSU9TIHBhcnRp
Y2lwYXRlIGluIHRoZSBEUEMgcHJvY2VzcyBpbiB0aGlzIHNpdHVhdGlvbj8gSWYgQklPUw0KZG8g
bm90IG5vdGlmeSBPUyBFRFIgdmlhIHNlbmQgV0hFQVNDSSwgZG8gd2UgbmVlZCB0byAgaW5zdGFs
bCBlZHIgbm90aWZpZXINCmhhbmRsZXIgaW4gZnVuY3Rpb24gcGNpX2FjcGlfYWRkX2Vkcl9ub3Rp
Zmllcj8gDQpIb3cgYWJvdXQgd2Ugc2tpcCBFRFIgaW5pdCB3aGVuIE9TIG5hdGl2ZSBBRVIvRFBD
IGVuYWJsZWQ/IEJlY2F1c2Ugd2UNCm5vdyB0cmlnZ2VyIERQQyB0aGF0IGJlIG5vdGlmaWVkIGJ5
IGFuIGludGVycnVwdCBvZiBEUEMgQ29udHJvbCAoRFBDQ1RMKQ0KcmVnaXN0ZXIsIGluc3RhbGwg
RURSIGhhbmRsZXIgc2VlbXMgcmVkdW5kYW50IG9uIE9TIG5hdGl2ZSBBRVIvRFBDIGVuYWJsZWQu
DQpUaGFua3MhDQpbICAgIDIuMzUwNzA5XSBhY3BpIFBOUDBBMDg6MDQ6IF9PU0M6IE9TIHN1cHBv
cnRzIFtFeHRlbmRlZENvbmZpZyBBU1BNIENsb2NrUE0gU2VnbWVudHMgTVNJIEVEUiBIUFgtVHlw
ZTNdDQpbICAgIDIuMzUxNzk5XSBhY3BpIFBOUDBBMDg6MDQ6IF9PU0M6IHBsYXRmb3JtIGRvZXMg
bm90IHN1cHBvcnQgW1NIUENIb3RwbHVnXQ0KWyAgICAyLjM1MzE0NF0gYWNwaSBQTlAwQTA4OjA0
OiBfT1NDOiBPUyBub3cgY29udHJvbHMgW1BDSWVIb3RwbHVnIFBNRSBBRVIgUENJZUNhcGFiaWxp
dHkgTFRSIERQQ10NClsgICAgMi4zNTMxNDVdIGFjcGkgUE5QMEEwODowNDogRkFEVCBpbmRpY2F0
ZXMgQVNQTSBpcyB1bnN1cHBvcnRlZCwgdXNpbmcgQklPUyBjb25maWd1cmF0aW9uDQoNCj4gDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFvY2h1biBMZWUgPGxpeGMxN0BsZW5vdm8uY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9wY2llL2Vkci5jIHwgMTYgKysrKysrKysrKysrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL3BjaWUvZWRyLmMgYi9kcml2ZXJzL3BjaS9wY2llL2Vkci5jIGlu
ZGV4DQo+ID4gYTZiOWI0Ny4uOTdhNjgwYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9w
Y2llL2Vkci5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvcGNpZS9lZHIuYw0KPiA+IEBAIC0xOSw2
ICsxOSwxNyBAQA0KPiA+ICAjZGVmaW5lIEVEUl9PU1RfU1VDQ0VTUwkJCTB4ODANCj4gPiAgI2Rl
ZmluZSBFRFJfT1NUX0ZBSUxFRAkJCTB4ODENCj4gPg0KPiA+ICtzdGF0aWMgaW50IHBjaWVfZHBj
X2lzX25hdGl2ZShzdHJ1Y3QgcGNpX2RldiAqZGV2KSB7DQo+ID4gKwlzdHJ1Y3QgcGNpX2hvc3Rf
YnJpZGdlICpob3N0ID0gcGNpX2ZpbmRfaG9zdF9icmlkZ2UoZGV2LT5idXMpOw0KPiA+ICsNCj4g
PiArCWlmICghZGV2LT5kcGNfY2FwKQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCXJl
dHVybiBwY2llX3BvcnRzX2RwY19uYXRpdmUgfHwgaG9zdC0+bmF0aXZlX2RwYzsgfQ0KPiA+ICsN
Cj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIF9EU00gd3JhcHBlciBmdW5jdGlvbiB0byBlbmFibGUv
ZGlzYWJsZSBEUEMNCj4gPiAgICogQHBkZXYgICA6IFBDSSBkZXZpY2Ugc3RydWN0dXJlDQo+ID4g
QEAgLTIxMiw2ICsyMjMsMTEgQEAgdm9pZCBwY2lfYWNwaV9hZGRfZWRyX25vdGlmaWVyKHN0cnVj
dCBwY2lfZGV2DQo+ICpwZGV2KQ0KPiA+ICAJCXJldHVybjsNCj4gPiAgCX0NCj4gPg0KPiA+ICsJ
aWYgKCFwY2llX2RwY19pc19uYXRpdmUocGRldikgJiYgIXBjaWVfYWVyX2lzX25hdGl2ZShwZGV2
KSkgew0KPiA+ICsJCXBjaV9kYmcocGRldiwgIk9TIGRvZXNuJ3QgY29udHJvbCBEUEMsIHNraXBw
aW5nIEVEUiBpbml0XG4iKTsNCj4gPiArCQlyZXR1cm47DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJ
c3RhdHVzID0gYWNwaV9pbnN0YWxsX25vdGlmeV9oYW5kbGVyKGFkZXYtPmhhbmRsZSwNCj4gQUNQ
SV9TWVNURU1fTk9USUZZLA0KPiA+ICAJCQkJCSAgICAgZWRyX2hhbmRsZV9ldmVudCwgcGRldik7
DQo+ID4gIAlpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykpIHsNCj4gDQo+IC0tDQo+IFNhdGh5YW5h
cmF5YW5hbiBLdXBwdXN3YW15DQo+IExpbnV4IEtlcm5lbCBEZXZlbG9wZXINCg==
