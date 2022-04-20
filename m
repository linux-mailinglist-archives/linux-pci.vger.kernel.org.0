Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AF55082EF
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 09:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376572AbiDTH5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 03:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376568AbiDTH5n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 03:57:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E858C29C
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 00:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650441297; x=1681977297;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Nr3k+5xKDgT5XLNj+l4hzwqU3ab1sNd8PWtln/L8vQk=;
  b=IrM3rOAfdA6qejv2jRng9Xc/FHlq5Pf+jGoYaKWwSX/iTKsW6B9RN1yg
   q1sz9fIxbnQzsy9niu0gIQsL9G5c6fAd0Xjn6oHTtlK1Cm+cLspfIgaq2
   WoFiVnXcRiEoHYO2oa+x/A0n6CHVkIN3KO5eDeioSTfuV1kqW+9L6rXq8
   8ATXKWs9TcxiQEWEkuSU+pyKZVVwZXw/ktQrdm6UjDbHub6QUoeu37rvW
   XhvfUm7P8sjBRbcY7KLPbCRjiiydS1yJGqf0a79tugYWbgc2ClviisUNW
   AQV/IMt3ZoTwn56dPUvkgBWUAd4ykNGDBUNFtRt/JCsZ2nUW7kai1e5jw
   A==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643698800"; 
   d="scan'208";a="170227241"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2022 00:54:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Apr 2022 00:54:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 20 Apr 2022 00:54:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahvbcdcxPiyEkPvXKPph+fqMWwzSA3LLv06hy/Ooy9zxo/mDQFsrw05tSX1ok4uRzT1ZEqm5W5JGon5h3MPe8y3L30JfvMoScw44h9Gky047B0/74sPhpt+UqKOMDElSZJJuAYDi3GEdOttJl8AbshpUN8UaP3dfVMqLePT6FQtYFDU24JJpENB0k10/inlVQgVeOcuDe/b6vym69UfmbDCf0m39ROzUGJ0A8TKp7DDvEPtNWSoJ/ZV3bJlhQUj+VsaKPY/G3v4UOlQnAaYJpgsw6+UOgmzQc4dWiGA+OXcjFpzOUhTTF9ARALF8/VQaLcjBXseSX57COfj4bUB5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr3k+5xKDgT5XLNj+l4hzwqU3ab1sNd8PWtln/L8vQk=;
 b=dJuTBRttsbCaR6Acjqx3g+wHYyoLWoaR9dUrmiD7UdPNxTHBVWUR4W4AwOMImtGA/d83mjPis3lP2gnTcZebSe0O0rSGidvCft85J5k1d2bNyYjSzxKr+bMqbzdLHw0WK+FKBhiBjKjnV7bMxG0WgQcEgUpcKIuEppO78BpASXyuA2UBe5pozgDzwO/R8xw5t5zJ9J7z6RLK3KRdBtzFufnsVY8vNUAE9Dk+2ujJ/mt83V0Yj4DhTb9zob9GCilePwl6GHavYtb+ThqwgubxosN7Pti5MDCyV0XoKPhH04r1XLAcs+PHBkKu7MKO3GywaCriHH94ZAtWxaJ882nyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr3k+5xKDgT5XLNj+l4hzwqU3ab1sNd8PWtln/L8vQk=;
 b=q55ILfmb57A+tl13JVf1QMWQ0UZll7y58cMhUKzGc55wOJV9TpUP95pRIx9NC2QV8GOt0SRKcZ2MpTQUTpFr+L/6MiC0zvMQWv+i9Sdr8jj/UqdHfrXDZYs/825hmYRQtRHbqMq87Me7LDTKDV/ThFiPqQyQUO8Qkw6WiKod0dw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by BYAPR11MB3574.namprd11.prod.outlook.com (2603:10b6:a03:b1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 07:54:50 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::dc95:437b:6564:f220]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::dc95:437b:6564:f220%8]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 07:54:50 +0000
From:   <Conor.Dooley@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <Daire.McNamara@microchip.com>
CC:     <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <kernel@pengutronix.de>,
        <ian@linux.cowan.aero>, <gregkh@linuxfoundation.org>,
        <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: microchip: Add a missing semicolon
Thread-Topic: [PATCH] PCI: microchip: Add a missing semicolon
Thread-Index: AQHYVIvpYszeUWv8akmcS6aCh7wTMQ==
Date:   Wed, 20 Apr 2022 07:54:49 +0000
Message-ID: <818179c8-a3b9-acee-9243-d0e39d262316@microchip.com>
References: <20220420065832.14173-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220420065832.14173-1-u.kleine-koenig@pengutronix.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccab789c-df72-4105-5310-08da22a30bee
x-ms-traffictypediagnostic: BYAPR11MB3574:EE_
x-microsoft-antispam-prvs: <BYAPR11MB357451209DC94CC08DC76CA298F59@BYAPR11MB3574.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MxZOmbCnVpRHXTo+kJ6fkLFFK8DnnF3yRwfFPQG5OLHl7+eQaNLvLE2DytfIbpJyTTcPGaG6eiyLnDV82v/wd+FcoiXeBbXeNI523lYtMcA59Uyd6MBc3NRAZemfwqfjxoHws6w6l/cHMKwBll1KUSxyIXJdx0qoFH3Y2a0awngwv8O7a3V1wrXc8xT02c2Gy6BHYoBGGqpYDxRLoAsY3q+031x+6oH6hYJXW1mybn/MoZ2YH3mKEtucJSH3GefYqQW6kKbHXbbcwQ8rS/kkjpSLTrXibZ6bvu8zHX+gkAgDhZSCQPjt7Qd9EGle+VonoFtUo8Bo/NPGwGuxfTeGWB+n8eeESXypzB2o4mndLmhn7aei/ZagWyAD8vi8JNEK1bHCtW6PbQPSXUqp4p8IUaXjG64dvXXq33hWc/88AxEq7Ie6Cr4heGajNCZW8EsNxYNf1mTXRsAidNqoIGfET/3lMKbidntXYnAZFH9w2BdD4HinTQqdT3k1293Kt9P51nCNsKNUcGPePAGPWFmaroVJxeWcMXHUcHXj75ZwimQXg4+tK99V2mxuwvqzQ5uvpfmyzcy/UbMe+o57Jii8dVrEiqhWGKVIuajOAxBupgN3m0Uu994Xo6gzYD7gx0sFDRomwZ2KD64fzBqbEL2x+bjSEk2P9dIZRKo74YdHJ1Ny5e9lz/yYX9QnfTQCKbM1GTin9luO5bn+154ZPjDukfjCsm5aHvbrYzvUP74qoK5ghJgd7DFsx583VUp3skSvbmfNJRICY2939XtQMUU/jA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(86362001)(31696002)(186003)(122000001)(26005)(66946007)(71200400001)(64756008)(110136005)(54906003)(76116006)(4326008)(36756003)(316002)(31686004)(8676002)(6636002)(66476007)(66446008)(91956017)(66556008)(508600001)(53546011)(6506007)(6486002)(6512007)(8936002)(38100700002)(38070700005)(2906002)(4744005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1pBbittSzgvR2FyVUpKY3BhdWxNZHpLM21Ob1p5Z3UxNi9IMGlOdUMrU0tV?=
 =?utf-8?B?OWM0NlptTmxnOEF0VzBzd0NQejM1L2c4Sm03WC9rRi94MUNRbUFtWXlaU0pK?=
 =?utf-8?B?SzRLQmpjazhiR2kxTCtmS1d5WVFmWVlpeWNvY1doTXpxL1ZPYU1yd0d0emg3?=
 =?utf-8?B?bFRXcTk2MlIyazRhcXBPYlA2YkRrOEYvaGFoWmhhaFpySXZsbmE1ZXRjZFB2?=
 =?utf-8?B?OG9xcEtsUGFZTS93RDhzYTQ0bk5mREJQZkowRlpKQW50S3dIWGJBRnRyaUZU?=
 =?utf-8?B?MXpaNVpxZytIMFp2aE5iNHJvTmh0Z2lLTFhMeEdFSXMzSkQwZVkwVE82b2xD?=
 =?utf-8?B?WWJTQ1hVQXJFKzdCa2c4L2VKclFkUjRmak85cExJck9iUWh6RzVDeURpVmZ6?=
 =?utf-8?B?MGtIZHpZeE14L2xuamQ4WE5tMVhaS3hwZFJrMjBmWVFYNFlidEF3c2hJRjhN?=
 =?utf-8?B?STJkUDBQcHdCTWtmUTRhc0FPUHV4SXFqemVkUmFtQzBLNHdtQUkxQkMzT0hU?=
 =?utf-8?B?b29UVXJTR2dManlkaDJnSzhXMjRwZkJSS2JnSVRSZ3BaUXNLZklqUk5UTjJt?=
 =?utf-8?B?WHVRK2hyVklLVVk4UVNQK1dVbjFkQ0xhbTdVYkNqS0Y3b1crc084MXJKN25t?=
 =?utf-8?B?YmxQazVIKy9LTi9iWHJaR3BlcTJnZWJVMVZyRDcyalRYNEdONWtyMk9McVFu?=
 =?utf-8?B?MGg5V1V1Nm1WQjljOXdPdncreHA0RWM0R3VHSUkzY3VwQ0U5WiszZ2pPMmZL?=
 =?utf-8?B?NHFvS3RPMzE2VFM2aS9INVNrdzR2WDdWU09nR3ZUd2JJcnErc1A0R2Q2dXlC?=
 =?utf-8?B?dFBXU2NxdSthelRlNHlsV0YzSW9xY2twK3R0VXNLVUl6TXlJZFlKYXRBaTgz?=
 =?utf-8?B?Q0FFa2p6ZFM0VzIrL1dsczNmTWlkUlZBdzB0RHZxbytSM21ZU2JNanlHcFRy?=
 =?utf-8?B?ZU9jRmpKT2Z2aUxVYzErRFRZRTBiQWhyRmx6aFRhRys1Z1Q3ek51K041M0Mx?=
 =?utf-8?B?RDEreEQ4VGVhd1kxZUg0WnU3cU9ORE90S21LUUlnbm9KSmNLSVBucVVjdkFj?=
 =?utf-8?B?TjBFN2FNNjBjQ0hLNDlBMGUySUYvQ1E3UnRWK3FlS0FGUkJ2YmN3Szc4dTEz?=
 =?utf-8?B?c2w3cTRNaVI3SXhzN2tNaTQ2VXBWa3BrYUNSOEE4QkE5b2FuYUhJZTVmNmtI?=
 =?utf-8?B?UVBQWVNaNGhaVjhuNWNPNFhPZ3BwWVp6WUV0eFZJd3MyNEJLZlBxMG1sNXU5?=
 =?utf-8?B?VTV1a1ZrYVBSOUsvWm5uUmZNeUNNS1gwSzBQMU1nallDMjJxVW1LQi9mSzF5?=
 =?utf-8?B?WElWOGM0RFlpanFETzlFcHoxQlZKODlGRjB0SkN2ZndVK3FLUm50a0pvQjNo?=
 =?utf-8?B?OGJOOFpqV0lRUzlLMGVJcmhIcmx0ZFJNeHJKbWk0TStkcVlQdFE3NFJCdVB2?=
 =?utf-8?B?a1g3K3d3bEd5cXU1RkllR21yeElBcmRBWk1rZFdzcG9mUlMyS0RYTkRUSnNt?=
 =?utf-8?B?TDFGbTNzMXFtL2tEL21ZNmc5YmF6ZEd5bmhYVWZYb0ovSHNoRUZXc3Rvc1JE?=
 =?utf-8?B?YlpKTVRKSE9YeC80NTFtd2JxT01Rc3d0MjZWbVdWUndqSE1XbGtlZmtOUEpm?=
 =?utf-8?B?WmFGNWRuL2h1UnlTLzNDL3JpSDhQUlZnRjl0bkJxR28xT2ZHamdscUpDZHlL?=
 =?utf-8?B?SGlxVG0zaSs1cTRhcnhJQnJVNFQ5UG9ZdEwvVGcyZnlJL2lZeFQzS1J1MlE4?=
 =?utf-8?B?aTFxSHNobHh1VUpjbktON0Q4SEdGamxhOFp5bWpJb3pDbHd5UzlpVmt3dWE2?=
 =?utf-8?B?dFVpRkJyMURxckptT1ZkcXcrNFp6MWtBMk5OamJqeldQUUd1RUlLNTVBQUpL?=
 =?utf-8?B?VC8yOVQrdFVTYjU4TW5PUTZFdGc4WW9xUG82RFNQVmRwcXgwZ09xWDg1ZjF0?=
 =?utf-8?B?TXR0aHJvcmdJbjMwdmNERzY2L3ZvMnBKdmtiVTFmMEcrZnFNOE9ucFFXcUhK?=
 =?utf-8?B?Qk9kY3pmK0NwUGNyL1Nycll5NFRPR0djdExRVlFhbmNSU0xrc0Y1MHJyV0dq?=
 =?utf-8?B?VmF4aHVYeFNwblkzOG1wQnM2Q1VRaW9NVzBkby8zVStBejZMb3pxWmpJS3Ar?=
 =?utf-8?B?UXlsZzZKNkQ1RXBEMm04TmpaQTVxQ2N3L3pkL1hCQ05DYzY3WWRhTGNsenVm?=
 =?utf-8?B?RWp2eEVyUVliNTdqKzBjTmxKRVFuMmFsUnkzN2x3R2xtSVZjZUNQRDA0UlJE?=
 =?utf-8?B?dmRBQ21BWEQxUFhYUmVtM0FNSmtsZmdqYk02dm5jZ1hUUk1IKzd6UTB1dHJ1?=
 =?utf-8?B?TTR3YkRCUEl2Um5TNmtCVG1DSWc0RXg5UE4xZ0o0UU1EbkRsTEpSQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <913E3D7DCE6F24449D6C49A4EDF8E413@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccab789c-df72-4105-5310-08da22a30bee
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 07:54:50.0122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pICDyCRlUD9RlpZrGhU6CTCyoMXcd7TdvDyruGOAAUQ2DHIhgmqYcmCNzVXtvx5qGJwKBMmgISI8CZA0lAyKKZghI99OoyGyd212Ev6t4KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3574
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMjAvMDQvMjAyMiAwNjo1OCwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IElmIHRoZSBk
cml2ZXIgaXMgY29uZmlndXJlZCBhcyBhIG1vZHVsZSAoYWZ0ZXIgYWxsb3dpbmcgdGhpcyBieSBj
aGFuZ2luZw0KPiBQQ0lFX01JQ1JPQ0hJUF9IT1NUIGZyb20gYm9vbCB0byB0cmlzdGF0ZSkgdGhl
IG1pc3Npbmcgc2VtaWNvbG9uIG1ha2VzIHRoZQ0KPiBjb21waWxlciB2ZXJ5IHVuaGFwcHkuIFdo
aWxlIHRoZXJlIGlzbid0IGEgcmVhbCBwcm9ibGVtIGFzDQo+IE1PRFVMRV9ERVZJQ0VfVEFCTEUg
YWx3YXlzIGV2YWx1YXRlcyB0byBub3RoaW5nIGZvciBhIGJ1aWx0LWluIGRyaXZlciwNCj4gZG8g
aXQgcmlnaHQgZm9yIGNvbnNpc3RlbmN5IHdpdGggb3RoZXIgZHJpdmVycy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXgu
ZGU+DQo+IC0tLQ0KPiBIZWxsbywNCj4gDQo+IEkgd29uZGVyIGlmIHRoZXJlIGlzIGEgdGVjaG5p
Y2FsIHJlYXNvbiB0byBoYXZlIFBDSUVfTUlDUk9DSElQX0hPU1QgKGFuZA0KPiBzb21lIG90aGVy
cykgb25seSBib29sLiBXaXRoIHRoaXMgcGF0Y2ggYXBwbGllZCB0aGUgZHJpdmVyIGNvbXBpbGVz
IGp1c3QNCj4gZmluZSB3aXRoIFBDSUVfTUlDUk9DSElQX0hPU1Q9bS4NCj4gDQo+IEJlc3QgcmVn
YXJkcw0KPiBVd2UNCg0KSSBrbm93IH5ub3RoaW5nIGFib3V0IHRoZSBQQ0kgZHJpdmVyIGl0c2Vs
ZiwgYnV0IEkgZG9uJ3Qgc2VlIHdoeSBpdCB3b3VsZG4ndA0Kd29yayBhcyBhIG1vZHVsZS4gSSBn
YXZlIGl0IGEgdHJ5ICYgbm90aGluZyBoYXMgYmxvd24gdXAgaW4gbXkgZmFjZSBzbyBmYXIuLi4N
Cg==
