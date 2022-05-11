Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB8952336B
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 14:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbiEKMwh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 08:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiEKMwg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 08:52:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CD26833E
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 05:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652273552; x=1683809552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tindY3HBRye3oSb9uewPqzU/T8m+5rK/FGdYDcp6ty4=;
  b=OtAIHTsxM23u4CRfFgUOvpW+a//0wMYL1QcoEWHLlSj0JufcOW0Qdi9Q
   PwNR16OfeWTzk6uBcmVEEe7SeBdLIe5HQrPg+rfZR9lIIULBzcAcL48NQ
   +2aj2Hzhxh7kYpPExdIiAttoxqAjROX06UeMxmZgcrCpLV3p3D3rOa+7o
   dAlaLr5/poDS73pA5WubUrY77CqrFuZW969bApkShpLlKEYK8KyEwcou2
   4Pf8eK8ijylASCB3BCeBOG5Yvtui5Nm1jfX/9uzJF+l+1aX4uIQN8lyWy
   JPeWEnExxQQyFnylZr63lrcDEQQPB7E14F50c9/C/4vM6T7tvAMQj2k0U
   g==;
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="163591873"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 May 2022 05:52:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 11 May 2022 05:52:30 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 11 May 2022 05:52:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AB/lzEdAxNQGyB9YH/dLvKR0LER0RbHyp9lBbplc1KD7V2Cu3su2brmEVW4WquNq5ZZ0ZGSnqDTfKjK80KgjAWaMfTj7rgZ3W0I/joDuLqZR7oYnACg/IkuZk0D/RVMFzYjku9Y2QCMLmTKw0igvcZJ+RGyppu9ihgDOUpnsSFFkaDPP+BmNBEX+xD2t6mcZQAU2N//i619/7QDKAcZdo034gzRSFw5LIwjtoNg/o41jVfw7Sctqmj0z7nDSNNnUF9VRopht/AJ9E1uTE8Io4ZRR5vF0VtJUjJPPXW1JyXqPHiCTuGqfsBnorqAdP0m54gb9lxgtaegECfSwq+uLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tindY3HBRye3oSb9uewPqzU/T8m+5rK/FGdYDcp6ty4=;
 b=nQ5SIJfMDanI9ZDJjOra2hr7p2WscuGpu4nLKpWIHrJbNE1s20TzEEhBJuaeRyTstVQoqkOo+WCA2zW+Ak0F8ExoqFsL9wpoKymrXTHbwAKfdHHxL+VY3oVbcFLKOwirxVZxCG+HAG5+QNP65ekowr91npDycf5W80lDUA3wtw0o5Ep4BYXjnpAnrkfksR3hkj6/rT09wcoy6PfllnrkeKl/eWF7uZRb3POSYOOa6mmmwm4qPBheJVuBiZ8gQMmWfgOFQvBN/76DvZQQlD4Z67jFkLRUzlpOfd0x7TbpiO6A8ICMRjdjixJc7LXUrs87Cz9lQE1NJSo/jqqsViC8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tindY3HBRye3oSb9uewPqzU/T8m+5rK/FGdYDcp6ty4=;
 b=hXmUeen1QBIHdtPW2kzZCtBGEswFRUY6ZVapNVlICt6R+IOOxX3/4qMuHhYjN5vBunUsdblCDOiaXj2zIc0+NCPwDVJXHNUl1neEmuaB6FLnTS2Ggi6nCDdHVw31V9/7Ov38sl9ev7190xB4VQhspy3+GqYaWr6aCdo/63fb2s0=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by BYAPR11MB2935.namprd11.prod.outlook.com (2603:10b6:a03:82::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 12:52:25 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d10f:cc33:cfd8:365e]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d10f:cc33:cfd8:365e%8]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 12:52:25 +0000
From:   <Conor.Dooley@microchip.com>
To:     <lorenzo.pieralisi@arm.com>
CC:     <helgaas@kernel.org>, <Daire.McNamara@microchip.com>,
        <bhelgaas@google.com>, <Cyril.Jean@microchip.com>,
        <david.abdurachmanov@gmail.com>, <linux-pci@vger.kernel.org>,
        <maz@kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH] PCI: microchip: add missing chained_irq enter/exit calls
Thread-Topic: [PATCH] PCI: microchip: add missing chained_irq enter/exit calls
Thread-Index: AQHYZR13aOcbGaLjqEKHhZWXKVkVia0ZoOEAgAAAZgA=
Date:   Wed, 11 May 2022 12:52:25 +0000
Message-ID: <565cdcee-bae9-48d8-2a8d-b5c54e0905d2@microchip.com>
References: <20220511095504.2273799-1-conor.dooley@microchip.com>
 <Ynuw2jiLB7+ZSd3z@lpieralisi>
In-Reply-To: <Ynuw2jiLB7+ZSd3z@lpieralisi>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6759c251-edff-4cc5-f74b-08da334d1958
x-ms-traffictypediagnostic: BYAPR11MB2935:EE_
x-microsoft-antispam-prvs: <BYAPR11MB2935E6927A9D82DFC22FD79998C89@BYAPR11MB2935.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3yt1pk8loj+HyU/+5zdlGw2goKheL0G4v3on24Pcd59WRqIPX603iCH19KzDShzh8AjZM3s02snRCZM+2zFw3AKSu74T7imTGKVgP4WIROscOEM1WKsENxmmM+GrZzpIk75J315mdIUS5+3TP6rrEJTeIcRstj0thNKLK7tliC3YGLje3QoV4sx28DjfMLVShKYuAj4ll7oSAGzGS43MqP2A4zX96u50LnUHNUjuviaa+FDi2FnO5qE0fKg2XGiS8Xx+7BshtO79GieLQ77tkDI1wu9bQSJatgGYFa6/gr0SORDAnZVJ8XDu+5nisxnR1npPJr1XgZH8AhkCmH4uogjTivFvJCyI+Hc8qGAepyw1WUKW7/MCso74ZTvkdg6VyrS1LMQf8cT1jsBJJFsmsQTWOcCyS6D9CRpbIqQsa0cLZR7ABWscd12yG15IILwRgQ8jEelUBpNZimvTBrAkun/l0V6mRe4/WnjyPHz5ZVOLiG746R4E1Iud4BJ1WaaJ5sESkFFRpthQ/5Qb5vUxe3tcmAkkT3BZhWgi8fNeevx/GoEdRxQCkXkHtitw+9E4bvmVc9FZUras/5QBQXuOLu48WOtx9gn0hCl8sEPBm5FZFrFG3h/XzN3rLxjrJwAkOzxfikBKT1QgGlHQ14ZPNHoju95EG6A67W5YuUPvDKK+J5MiSDmrKHHLskoyrGr8/wAiHeCKEfn65XkM5a7VnL1FuxaX9iYclelznpeXwsdXz9h2VSo7iXUCB5Fwm48Oo+4vtiEf8UWID+B9czezgb0Swn56mr4zNm60qCdXEBBuuaRrQkjAz9CUopABSUMSMyGO5ztD+fhdiV5QNJ7PAAThc3hbElr5QLxsEcZ8G8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(31696002)(91956017)(71200400001)(53546011)(6506007)(966005)(86362001)(38070700005)(508600001)(6486002)(2616005)(26005)(8936002)(122000001)(186003)(6512007)(36756003)(5660300002)(54906003)(2906002)(6916009)(316002)(76116006)(4326008)(8676002)(66946007)(66556008)(66476007)(64756008)(66446008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEpzN1lFYXZuK2dyaTRxSE1tZlByV1JPM2VDa21KbGNFUGxoY0p1K1FIRXlF?=
 =?utf-8?B?K3ZoRUxuUmFyL0RYeTVrbXlFRHBzT0FjOS9JQVp5V2FDNkNCWXE0TGx2bHdY?=
 =?utf-8?B?SlVQU09PM2NDTG5KZk8vT2tsSU5ndmdhRHphSHVWM2x4cStaRGRtVlRUZ2Z6?=
 =?utf-8?B?RGxJTjNMZkl4NjZJS1AyR3pYcmFDdmdMSnRxdkU3emtOS0loSERZS09vSUMr?=
 =?utf-8?B?T1E0S1UyQTRENC9LbFFWTEMreXhmU2VnREc1YllKaFlZVzMycnFGVzlwRTFv?=
 =?utf-8?B?NW55WmNZT1NYcU00L3FCNUVHT1pGVDBWSzJpdE0vWklXN0VsMHdZTngrNWk5?=
 =?utf-8?B?WHRieW82SUhzVGZubVlhRENsOHJ0Y2pwOTBFZTZTRm4rWHJFRkgyU2RLVi8x?=
 =?utf-8?B?NmVIcDNoSVRCSkZsRit5K2xINWQ4V3VOR0FmUUdYYk1JK1ovUEFReVBHVERy?=
 =?utf-8?B?SjUzNFlQUWRObHJReHdVYzlhejVhTzIreGpraTUzUUFsTTYwZUpJVFQwUHlU?=
 =?utf-8?B?a0dtdGx5Vm5BSXhlL0hNWXBVSEpPc3pJQTA4MlliRkkzbXF3Mnc4eHNTK1ps?=
 =?utf-8?B?QXBCTlgvSkdwOWd3ay9xeC82S3lsUm1JZmN0VzJzTFZPS1lEaklIcXZ6emJq?=
 =?utf-8?B?Qmo2ZnB5eE1SdTVlNTN3RTFiMURaSGFmbVF2aGtlU3NocFFZQXJhSEl3S1BQ?=
 =?utf-8?B?a2xyZk96TGdLNHhsbjRoSzkxam92ZFZVQ3FTMGF4RGx3cXlMeVZvWHFOOUNY?=
 =?utf-8?B?eG01a0ZtSUxZUUV5MTg0QldRUDRrNzNxYlRvcXBxNE5MdW12VkY5NkZrQzRM?=
 =?utf-8?B?bUVzMmZOaEhzSmQ2ZGpURjErcnVXNzkrcGIxTXlCZkVjK2VtcXBKbklqRUNX?=
 =?utf-8?B?YTRyYVVLTTF6UEJTS3dnZXdaRzFnMkxrUTFEdHhIU0VBd1R1Ujd6OTYyanZE?=
 =?utf-8?B?d3lKd1luZkhHeDJqSU4vekkzQ2h0T3Z1VDRPaktncHRwaDFLY3lmVnQ5U1Ax?=
 =?utf-8?B?VHIwWlFaNVdIdmdyWnlRcEwxVHBhK3NYOHBieGZwNGtOSG0weVU3bk5MSExl?=
 =?utf-8?B?Sm9LbGsyellEUVE4Y05EcDBxWkZKUVQrQ1BUb2t0eUhjT0JRTXEyWmhNbzVF?=
 =?utf-8?B?TExqUGpLZXlCVVRZMTZ3TVB4aEt5QUo2ODlkVVpyK1JsZVVocHJCd3c3WGVC?=
 =?utf-8?B?UmVSQkt5NGZDUWFqVkNhU2lJU0YwYjc2TkREZFBXbExDTmRMdzM1SVVSYVVR?=
 =?utf-8?B?dkdsTlgxNFgxbnhCUThJNlROVUJPcVF0dnFJc0FnQUdQdlJlSnlvMDB0aUZW?=
 =?utf-8?B?MXkyNDlkTVhFaHF5RE9tWFZRNnNuQTFEWERRdlpMdjh6ZEc2dkQrSzliOFlM?=
 =?utf-8?B?YXlhRm12cXcxQlROM0dCR25mQnM3UlVrc3E2eGFqVDR6QzZUY0lMSGQ0KzJT?=
 =?utf-8?B?a2R3VjNXc1F5NlhNZ1RiTHZ0YnkySVF2dTlsTUdoZnBLM01CV2dNeXFvVFl5?=
 =?utf-8?B?Y1EybktPd3F0aDFuR0NKdGlkSHlQdUMzSnZrT1RxS3NUeE8vbGg1N1NuU1Vl?=
 =?utf-8?B?bXAyRTQ5UTFCckxFdzJMVTQ4VElNaFBCRmhLZzg0YU5WZDRucWhqNExjNjlL?=
 =?utf-8?B?a1JwKzJKRWt5eHVuUWpKam90Q0pjOTdRM3l0NVgrQWNHb1NqZG5jTHVUM1FO?=
 =?utf-8?B?anV0cXZISG1vWE94RDF1L3ZHWGg4QnJpNDJkbndENXl6b1N5YkI0a1FwalNY?=
 =?utf-8?B?b2c5OHhWelp3UlMvNmp6NjZXZjZNc2FhdDhNNlFUOVRMeUpIL0VGRzNENi9L?=
 =?utf-8?B?VkFpUXc3N2pZUDJ5K3VsTGxyM0N1UEdaeUpFcy9TZDA1K1pNQzF4dmhCTVNt?=
 =?utf-8?B?VEpwM2ZUdHBmYi8rZmVwUnFxN3NTU0x3aitDdkhmV09LWTB5VXFzWHJ5VlZD?=
 =?utf-8?B?aXlsU0VSd2h5TnRqaTUvbTd5ejBCWlBER2o4dC9EYno0L01laFRPRmEzMERG?=
 =?utf-8?B?R1E2eW1qRDhWZHY3ZldDUjNqS296TWRGODdpU3JTOXNOMjNNYmU4eExWbUg5?=
 =?utf-8?B?bVA5ekprY1RkNnBQemNTMzB4L3Iya3NNdGowYnhJaEFCTWhKaGxacDFGMFpD?=
 =?utf-8?B?RXZnM1JFaE5URjFwTkozbkYzOHprYTBGQXpOYWtJYWhDeGVyRVVTcWw0U2hK?=
 =?utf-8?B?cVJldFBWRWhNOUc0YVRpQ2Z2YzNwMDNvWkcrZGZHaG1XcjVqYnFtc3Uxb0R0?=
 =?utf-8?B?SkQvR2RQd2JMT1phd2czWWF5ZDVYSzRrL2lBV1dhMHZvcDMzcVdIaW11MVhz?=
 =?utf-8?B?TFZuZW01YWZCYWppdHEvbEZoS0IwYVFkUkV3UytwR1dsdTBwa3VsUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C0B41AEFF5FAA4E93BEB635278DD52A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6759c251-edff-4cc5-f74b-08da334d1958
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 12:52:25.6949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ieo3d0oHDJVVCJKfFkujUZHLEq07WN0MpALgL8lFhwEC/1802ekwxC8fzpYUS0jzuEk/pyWXH5JHeyhHdRAtxpSUzDSFd76vdZZ33n/17JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2935
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTEvMDUvMjAyMiAxMzo0OSwgTG9yZW56byBQaWVyYWxpc2kgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gIlBDSTogbWljcm9jaGlwOiBBZGQgbWlz
c2luZyBjaGFpbmVkX2lycV9lbnRlcigpL2V4aXQoKSBjYWxscyINCj4gDQo+IEFsd2F5cyBjYXBp
dGFsaXplIHRoZSBmaXJzdCB3b3JkIGluIHRoZSBjb21taXQgc3ViamVjdCBzZW50ZW5jZQ0KPiBh
bmQgYWRkIGJyYWNrZXRzIHRvIGZ1bmN0aW9ucyBjYWxscy4NCj4gDQo+IE9uIFdlZCwgTWF5IDEx
LCAyMDIyIGF0IDEwOjU1OjA1QU0gKzAxMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4+IEJqb3Ju
IHNwb3R0ZWQgdGhhdCB0d28gb2YgdGhlIGNoYWluZWQgaXJxIGhhbmRsZXJzIHdlcmUgbWlzc2lu
ZyB0aGVpcg0KPiANCj4gSXQgaXMgY2xlYXIgaW4gdGhlIExpbmsvcmVwb3J0ZWQtYnkgdGhhdCBC
am9ybiBzcG90dGVkIGl0LCBpdCBpcyBhIG5pdA0KPiBidXQgSSdkIHByZWZlciB0aGUgY29tbWl0
IGxvZyB0byBqdXN0IGV4cGxhaW4gd2hhdCB5b3UgYXJlIGZpeGluZw0KPiByYXRoZXIgdGhhbiB0
ZWxsaW5nIHRoZSBiYWNrZ3JvdW5kIHN0b3J5IHRoYXQgaXMgYWxyZWFkeSB0aGVyZSBpbg0KPiB0
aGUgTGluazogcHJvdmlkZWQuDQo+IA0KPiBJIGNhbiBtYWtlIHRoZXNlIGNoYW5nZXMgZm9yIHlv
dSwganVzdCBsZXQgbWUga25vdy4NCg0KSGV5IExvcmVuem8sDQpJZiB5b3Ugd2lzaCAtIGdvIGZv
ciBpdC4NClRoYW5rcywNCkNvbm9yLg0KDQo+IA0KPiBUaGFua3MsDQo+IExvcmVuem8NCj4gDQo+
PiBjaGFpbmVkX2lycV9lbnRlcigpL2NoYWluZWRfaXJxX2V4aXQoKSBjYWxscywgc28gYWRkIHRo
ZW0gaW4gdG8gYXZvaWQNCj4+IHBvdGVudGlhbGx5IGxvc3QgaW50ZXJydXB0cy4NCj4+DQo+PiBS
ZXBvcnRlZCBieTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4+IExpbms6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS84N2g3NmI4bnhjLndsLW1hekBrZXJu
ZWwub3JnDQo+PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNy
b2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1taWNy
b2NoaXAtaG9zdC5jIHwgMTAgKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3Bj
aWUtbWljcm9jaGlwLWhvc3QuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1taWNyb2No
aXAtaG9zdC5jDQo+PiBpbmRleCAyOWQ4ZTgxZTQxODEuLjgxNzVhYmVkMGYwNSAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1taWNyb2NoaXAtaG9zdC5jDQo+PiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWljcm9jaGlwLWhvc3QuYw0KPj4gQEAg
LTQwNiw2ICs0MDYsNyBAQCBzdGF0aWMgdm9pZCBtY19wY2llX2VuYWJsZV9tc2koc3RydWN0IG1j
X3BjaWUgKnBvcnQsIHZvaWQgX19pb21lbSAqYmFzZSkNCj4+ICAgc3RhdGljIHZvaWQgbWNfaGFu
ZGxlX21zaShzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MpDQo+PiAgIHsNCj4+ICAgICAgICBzdHJ1Y3Qg
bWNfcGNpZSAqcG9ydCA9IGlycV9kZXNjX2dldF9oYW5kbGVyX2RhdGEoZGVzYyk7DQo+PiArICAg
ICBzdHJ1Y3QgaXJxX2NoaXAgKmNoaXAgPSBpcnFfZGVzY19nZXRfY2hpcChkZXNjKTsNCj4+ICAg
ICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwb3J0LT5kZXY7DQo+PiAgICAgICAgc3RydWN0IG1j
X21zaSAqbXNpID0gJnBvcnQtPm1zaTsNCj4+ICAgICAgICB2b2lkIF9faW9tZW0gKmJyaWRnZV9i
YXNlX2FkZHIgPQ0KPj4gQEAgLTQxNCw2ICs0MTUsOCBAQCBzdGF0aWMgdm9pZCBtY19oYW5kbGVf
bXNpKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykNCj4+ICAgICAgICB1MzIgYml0Ow0KPj4gICAgICAg
IGludCByZXQ7DQo+Pg0KPj4gKyAgICAgY2hhaW5lZF9pcnFfZW50ZXIoY2hpcCwgZGVzYyk7DQo+
PiArDQo+PiAgICAgICAgc3RhdHVzID0gcmVhZGxfcmVsYXhlZChicmlkZ2VfYmFzZV9hZGRyICsg
SVNUQVRVU19MT0NBTCk7DQo+PiAgICAgICAgaWYgKHN0YXR1cyAmIFBNX01TSV9JTlRfTVNJX01B
U0spIHsNCj4+ICAgICAgICAgICAgICAgIHN0YXR1cyA9IHJlYWRsX3JlbGF4ZWQoYnJpZGdlX2Jh
c2VfYWRkciArIElTVEFUVVNfTVNJKTsNCj4+IEBAIC00MjQsNiArNDI3LDggQEAgc3RhdGljIHZv
aWQgbWNfaGFuZGxlX21zaShzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MpDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBiaXQpOw0KPj4gICAgICAgICAg
ICAgICAgfQ0KPj4gICAgICAgIH0NCj4+ICsNCj4+ICsgICAgIGNoYWluZWRfaXJxX2V4aXQoY2hp
cCwgZGVzYyk7DQo+PiAgIH0NCj4+DQo+PiAgIHN0YXRpYyB2b2lkIG1jX21zaV9ib3R0b21faXJx
X2FjayhzdHJ1Y3QgaXJxX2RhdGEgKmRhdGEpDQo+PiBAQCAtNTYzLDYgKzU2OCw3IEBAIHN0YXRp
YyBpbnQgbWNfYWxsb2NhdGVfbXNpX2RvbWFpbnMoc3RydWN0IG1jX3BjaWUgKnBvcnQpDQo+PiAg
IHN0YXRpYyB2b2lkIG1jX2hhbmRsZV9pbnR4KHN0cnVjdCBpcnFfZGVzYyAqZGVzYykNCj4+ICAg
ew0KPj4gICAgICAgIHN0cnVjdCBtY19wY2llICpwb3J0ID0gaXJxX2Rlc2NfZ2V0X2hhbmRsZXJf
ZGF0YShkZXNjKTsNCj4+ICsgICAgIHN0cnVjdCBpcnFfY2hpcCAqY2hpcCA9IGlycV9kZXNjX2dl
dF9jaGlwKGRlc2MpOw0KPj4gICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IHBvcnQtPmRldjsN
Cj4+ICAgICAgICB2b2lkIF9faW9tZW0gKmJyaWRnZV9iYXNlX2FkZHIgPQ0KPj4gICAgICAgICAg
ICAgICAgcG9ydC0+YXhpX2Jhc2VfYWRkciArIE1DX1BDSUVfQlJJREdFX0FERFI7DQo+PiBAQCAt
NTcwLDYgKzU3Niw4IEBAIHN0YXRpYyB2b2lkIG1jX2hhbmRsZV9pbnR4KHN0cnVjdCBpcnFfZGVz
YyAqZGVzYykNCj4+ICAgICAgICB1MzIgYml0Ow0KPj4gICAgICAgIGludCByZXQ7DQo+Pg0KPj4g
KyAgICAgY2hhaW5lZF9pcnFfZW50ZXIoY2hpcCwgZGVzYyk7DQo+PiArDQo+PiAgICAgICAgc3Rh
dHVzID0gcmVhZGxfcmVsYXhlZChicmlkZ2VfYmFzZV9hZGRyICsgSVNUQVRVU19MT0NBTCk7DQo+
PiAgICAgICAgaWYgKHN0YXR1cyAmIFBNX01TSV9JTlRfSU5UWF9NQVNLKSB7DQo+PiAgICAgICAg
ICAgICAgICBzdGF0dXMgJj0gUE1fTVNJX0lOVF9JTlRYX01BU0s7DQo+PiBAQCAtNTgxLDYgKzU4
OSw4IEBAIHN0YXRpYyB2b2lkIG1jX2hhbmRsZV9pbnR4KHN0cnVjdCBpcnFfZGVzYyAqZGVzYykN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJp
dCk7DQo+PiAgICAgICAgICAgICAgICB9DQo+PiAgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgY2hh
aW5lZF9pcnFfZXhpdChjaGlwLCBkZXNjKTsNCj4+ICAgfQ0KPj4NCj4+ICAgc3RhdGljIHZvaWQg
bWNfYWNrX2ludHhfaXJxKHN0cnVjdCBpcnFfZGF0YSAqZGF0YSkNCj4+IC0tDQo+PiAyLjM2LjEN
Cj4+DQoNCg==
