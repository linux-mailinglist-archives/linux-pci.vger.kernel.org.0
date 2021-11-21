Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26BC458261
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 07:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhKUGmG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Nov 2021 01:42:06 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:2704 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhKUGmG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Nov 2021 01:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637476742; x=1669012742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=a95RVhMF/B23vVQCfwHmlTdAV4Kxsapprykm7w/3Lms=;
  b=WWlWzqMRHrMS45IXSfPSj7GrPPbaowqifcOH5PsBzPB7R0zDRllFcVdw
   bmOXvnFFudG7DTalOtcnOf8TFILkEcsa/scVXijVYlaL/vriLoqdW29gu
   FUleWqIlnUNMbFMWqve30OrexWgemiJIjCHCxnSkMpEeEkkQ3JU+VsChv
   G8qSc3+iQu2+ftltSMuj59BRxh2tARIyf8vuAdJ9ruFOzK/mWZ5EE+01M
   dt9lAdWJB1YjWA5DI3TEOYR/i1Fcfh4TKK0LrVS9bE7xuJux5cr8I8fyH
   DSYqAcs9E8l4JbLNpxwODZbFQttc0ozhZjnRBMFw99CQR12idW0JDciB8
   A==;
IronPort-SDR: 9A9+u+3TlNhoNuCAAHQ1isMCueselG9LldNlzWYJy3v9D6VZgnoUL1o9YHyO0onwGVdPYDPJuj
 jylKSYRr2YEjTfcWAuHH+gF32neim2VuPJkEnUwecXK69kpWFdcJ30abDSpKoVZ/LOokiUF0r5
 O+8qogVbUV6K1lJz5eOXEJQrSXIACZkKylgxMuIChfrdr5/aZ7twZmk7Xl5mLE/OIauy8tTWIf
 5ZVU0Nrmpma2kB1IAI096wwMtvrpD4MxsE9gCJHTd8Rpk/Yo2CE+1wrhV3wMP/Y8XLKXJ2dppT
 YARNyxww/qAoRFSncWQNpCVh
X-IronPort-AV: E=Sophos;i="5.87,252,1631602800"; 
   d="scan'208";a="139818511"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Nov 2021 23:39:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 20 Nov 2021 23:39:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Sat, 20 Nov 2021 23:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7cYEMfnEEG/QfmxIV02v7aG6bNuABSu1YoIeCqu04YhsREs7mOHYZctm4MspaLevWZ4AIeXvfo7DPCs7L6iLIJhjsilBAXVeXJ/hJmZ3zy0M2EBhouhBqhBh3YyckVCkLwQcN/567GL0xhA4BOoHIUHJWazeLfJsVKUjOuLR1dpLwC13k87gp+/p6w/r1YIft6WXvlXOaXaqvV0Drc3LQUW7m89OkQxmdvhuv+4TERXGGv/7orSkO2iGXTFEons1uC2k1+Mi/tEyqu8Etai041PetlFUfm60s23aLziCg9ZyvmuLyAfmg6A5ARn/FgoPjY40mBdBQ77GIo3rowT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a95RVhMF/B23vVQCfwHmlTdAV4Kxsapprykm7w/3Lms=;
 b=C8ldy/r0xQ1XGi8UAkqsQHY0vb2cI+pAByR/uIELlvWBcb8EsLJZ1Bu5MRNAcXjUZ0A3XDsKzBWxSkn5GGKCboHHCfKUvVMeznHleYBGVIV4ehe+8RJjDoWSEnvWgM9rS7kBhyNCJkPswKUGXtnvMT6jNopmQ+QIBELX9GNMzXVdeHZNmJJVHVvowzapc49KmXNhjCekr96Ja9BTeIBLrMc5c0sNXwZdP3HlQr4XKX7lSuPhpgRIVjsPjD77pLJQCBP9UhucOzbzCkTmY3+0IwbC8e6AzPYLBh4W9epgGHPoPXR8xXBLjhgmaV4d8qC95DgE3Sg/H/y5MY1EtJhYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a95RVhMF/B23vVQCfwHmlTdAV4Kxsapprykm7w/3Lms=;
 b=R53XAaNZhmfCjPaQ/7WlhZ6IQXyyRXat4BlEuQVKZsuvbXoNICpEiIGgp758VEfdxMzXvPu2gtYDQ3qLXi8mEx7+i3GRB/zbUj/ED1oikdIzyRsQJ8SiwIG9E9Yt+PJvA/9vsj9iLkSCIxJEE3Y0VJWS8+UR2XmAMBpULrw5BxA=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Sun, 21 Nov
 2021 06:38:55 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::c538:7e6d:9618:80e9]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::c538:7e6d:9618:80e9%4]) with mapi id 15.20.4669.022; Sun, 21 Nov 2021
 06:38:55 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <kw@linux.com>
CC:     <kelvincao@outlook.com>
Subject: Re: [PATCH 0/2] Add Switchtec Gen4 automotive device IDs and a tweak
Thread-Topic: [PATCH 0/2] Add Switchtec Gen4 automotive device IDs and a tweak
Thread-Index: AQHX3N3ohEj9wBWaD0693QUzFBaCw6wLESaAgAJ5roA=
Date:   Sun, 21 Nov 2021 06:38:54 +0000
Message-ID: <af2931c923a23301ad5c91009806449548c54ba1.camel@microchip.com>
References: <20211119003803.2333-1-kelvin.cao@microchip.com>
         <cf1bc79c-718c-ce23-fae8-178d0f545901@deltatee.com>
In-Reply-To: <cf1bc79c-718c-ce23-fae8-178d0f545901@deltatee.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 595c7c0e-2d36-4afe-45a7-08d9acb99708
x-ms-traffictypediagnostic: CO6PR11MB5636:
x-microsoft-antispam-prvs: <CO6PR11MB56363A0C9DBF6436663C00F48D9E9@CO6PR11MB5636.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMkBUPsCn8ekk644N7rTEGpdaJd3ZfmbOaEV2n/8ZERIlaRk/H1EYwhv+X6wOLeLi5fke5TI7qFXuhSXushktJEcWTuw/hc1gE6HqMhpn+rsCXa/C7ZSXiDnU/e2V1R15wdnB87nvpPeWfi2wfisiZeis0B9obCEM2HXHl0CZirk6LvzCuUZWTFYt77b+Ry4aYOASFRPfW7PVBTmNafw4VPgHQRwCb9JeSa8hcPa8qF+v26gbfCQWMEkggHYQWCvvpxG7nZj3RFka7bmlA8Y4iq7F8WvgJSxev+mjvAth1dtoD9JPtnQRTHnRO2G7yszHUfkReoeNmhNNeeyQanaHBjGIWNlUMn1ImFgo2qT+FkbMparSsdPfUUC/X19a4+i77CNNqtKJvG12Ie6c+Jq6JWd/3phLzs2yj/YQw8yz6fcUNwlLpiJw0QqsCkdyBygT2x5vLUcqGXQ8tzjjhWRvDFxKgxfjlSoWSIUoJ+UX3IltlX9jLCCtMH4NCnpw69NBy3qZvgURpvD9buFvsaOMQoIvVl9FFSzR/ueUvg1/uGldJOL4ymZ9rFAlLP8q1RRBbRQdsocYcMkIpjrWbYOkoLPD0YaptN5z/fk6iFS2qRQ88M8yZpcYOYutoIHqqWPiFRs0N41UEqqJlbkWUdjdIG4DxvYMq9XHkB+wUcYnOe2jO9mQaZElB+7Qd94uN9Q+Bxo5au0LzbRhZ6eei5zut+byk5JG41pDDA8CcQ5pwd0LC/zjKrti3UGYG0IdF1+Up+6S130HOkomvKOmwRuUzLRe66abn3IflK2K7tYvc4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4001150100001)(8676002)(2906002)(36756003)(8936002)(110136005)(6512007)(4744005)(83380400001)(71200400001)(316002)(6506007)(64756008)(66476007)(186003)(53546011)(66556008)(66446008)(76116006)(66946007)(26005)(86362001)(2616005)(38070700005)(508600001)(6486002)(122000001)(4326008)(38100700002)(5660300002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2poVUg1UlJsWnlGWUFGc2NFY040N3hleVVKdG1TQlFPVGVzcTV6K0kzNUJ3?=
 =?utf-8?B?SzB3a3J1YzdoQ1FBU1YwMmp3UmlUVmp5WC90VXBqemZkOVZuTWJuNEFwSXVZ?=
 =?utf-8?B?OHJXalY2TGpicEJ1VkE1aWlqRjdhbkxFeU11SkE3My82UUxxajRYV1h6MXZ5?=
 =?utf-8?B?NWE0Yno4dm4rQU04L2lpNC91U0dQSlR3VHZVblEvc04vWWEvYmlTRVJWYXZ6?=
 =?utf-8?B?enJJT3MxQlhCMDhRQUtsd1hqL0cvT2ErZVJ4T2RhRjVGeHBEL1UwUVBPYWho?=
 =?utf-8?B?UG93RjlDdU5pd1puR0c0UmxVNmhKTGVQZnVOT1JhY0FaODZvdTZHMGRTSWJE?=
 =?utf-8?B?QXRLSXV4UXdHdEpNS1NqR2NPL2RaNkdOQ1ZmeWt0c00vdlNTdzc1Yml4Ung3?=
 =?utf-8?B?MmJTSitMbzRia3FvY1NWeHhhZEZDZXpMU0drcW1kZkJKWXFlMERCcmhlY1g4?=
 =?utf-8?B?amdoWlR5Y2pMcVBRYkxoZ0UraGF5ZWt5SWNCTjZHWC9aMlgwN2ZxRHZiSmhD?=
 =?utf-8?B?eEJ6UDA1bVNLakQxV1l0Zk9pcDNQYlA0a0dLbEpOWFJSc2wwNVRsSy9xMzBr?=
 =?utf-8?B?bFRYaHZpdGJSOGdhK05mV1dzMFFEdVRuU1ZJQ0wxZ25lTTNhVnV1bE9DR1gr?=
 =?utf-8?B?ajAyKzBrSkd5N0N3Mm1GbE5qemU5TWQwbnE3YW9zc1BxbDhPV1hPSjBFOU9r?=
 =?utf-8?B?dU5taUhwcCs4SmVqV0RkNG5hMzlPcmcrZTRmY2JjQWJXYlp5dTdzNFNuU0x3?=
 =?utf-8?B?UzFKNHlXenNNY0RlRVRNcEwweXB2YWgyeDdUbEtFUzQydm5lcTVqdnJGSWE3?=
 =?utf-8?B?SHA3bHpzVm1GbFRQZTF4N2lVU2hsdktFdkprSEtoUjlwN2J5QWN5VzBOcXhH?=
 =?utf-8?B?T2QzeTN0T3lubThjUEhYeXMxdG16cFFWTUpzSGNMMWozcWJyeTRNeElZZ21h?=
 =?utf-8?B?YlA5WWJCVm5acDJDUVlKUzlJVlIyc1BDbFJ0RFNRRzJ3K1lzS3RFbEFQT1hj?=
 =?utf-8?B?UEhOdW56akRiRUZiNXdnVmYrbFpDejZrWmg4VFFPOTlsS2FCMnBQZEtFdGRH?=
 =?utf-8?B?OXFYMEV3Z3RyOFF3VWlZWnJ6L1BkMk5ma1hUU0R0cWZNSEhCbXIrQVpUMW9C?=
 =?utf-8?B?eHQ5eG9vRzJzY09hRVhhOTJIUVhRbndjSUV4TkIyY1NNUU9zelVraDBLUm94?=
 =?utf-8?B?S1lUcnVnZXFFY0pSTVMvWktLdVhmR0YxWXo2YWdycFVpUjNrQVFRSEZjWm90?=
 =?utf-8?B?YUhhbzltR3J5UUw5cjRwTW1uRmN1RlhNclV3ZU1rdWNremFmWnloUWNSSEdx?=
 =?utf-8?B?MFExZ1gzNlE1a1hmOWdVWDFhakF5MVFSYnpJSzRkYUd1bHpiU0V0S0Y2c0d0?=
 =?utf-8?B?ditmQlQ0RHdDN25Md0dtN0g0MGxRNlhERERnQnNxakVDTkRvWUJpTFVnSHp5?=
 =?utf-8?B?blhXb1BWRjZHRHVxbUVUanNpa0pDR0JoTmFHTnBCbHVlclRKNGdRbHVoL3Fi?=
 =?utf-8?B?TUkvZUFLZEp0dE5HRnNvYk95RmxuSE1qSEptRkVZeHREemgwRVVNdUVnUS83?=
 =?utf-8?B?WTNoVm81ZXhxZFVpWlN4SEp3UUlqbll1RndlZ3g3eGZyMmN3YTZxU2R4bXUy?=
 =?utf-8?B?Vm9KTysvY3QyMmpwNTN3MUdUQ0MzZkU2c2ZDSG1SaTZvNTlmR0FjaVBmZjhs?=
 =?utf-8?B?VEZzdDVYdy94VkQ3MVozOGI1ZHVJU2NqTkNic0RGMzEyV25mdG9nSUkzbTJv?=
 =?utf-8?B?ZmZpcnRLUEhXVkEyOThscndxYittbFFvNm5ZQVZmbDRiTGNtdEpDK3NEWjVW?=
 =?utf-8?B?bHJqaDdyTFphUnRmNU9wL0ZsN2E3MWpRakN5SHNqRXh3dTRkbVVPY3RxdXBF?=
 =?utf-8?B?YVhqSmh5NTdFRXloZEkvdURwS2xsNDJnWHpNS3dJbEZqSU11RFM1ODlxN2Vp?=
 =?utf-8?B?QXdvR3A0UXZnc0tRU0p3Z3hXR3NnNW03bUw0aG9JU2pyNzF4MkNURHc1ZmZ5?=
 =?utf-8?B?aHJxYVJBUHFnU2VlWEVWeWQrM0FhUTVqenVHa0tIeGtaZThaa0krK25tTVFq?=
 =?utf-8?B?S3oyaHorMk92ZFV1cVIxOXFISGc0c2tob21UcDlEOS93dks5SnZPN2V3Umh0?=
 =?utf-8?B?THFXR1VuYlVzRURuWjhCQ29jcUY1MC9kMFBJZWNGY3UwaHd2Z3Ziay9jYU0r?=
 =?utf-8?B?WUtNbUdLTlNwWjYyclhwaGVscWNqNmVOanE1YmZJUGZuamlCeGVVNFBLY0dU?=
 =?utf-8?Q?/RjNXWOl9IztmLhgHBb5JC5VWLmAEEf4VPhaIvyv9s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA8F9F33BD62C14CB442B2375F5A1182@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595c7c0e-2d36-4afe-45a7-08d9acb99708
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2021 06:38:54.9637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fseFIBAdtEM8O0FxBGEZiroEBP0BSjYVmB8BNvyQ6srh0ZFKBC6+74NUP+6kunKe+QZfrGIGx4FzkoUGLk+d7EbtkAR6MCWyKG9TIVUR8I0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5636
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIxLTExLTE5IGF0IDA5OjQ5IC0wNzAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjAyMS0x
MS0xOCA1OjM4IHAubS4sIEtlbHZpbiBDYW8gd3JvdGU6DQo+ID4gSGksDQo+ID4gDQo+ID4gVGhp
cyBwYXRjaHNldCBpbnRyb2R1Y2VzIGRldmljZSBJRHMgZm9yIHRoZSBTd2l0Y2h0ZWMgR2VuNA0K
PiA+IGF1dG9tb3RpdmUNCj4gPiB2YXJpYW50cyBhbmQgYSBtaW5vciB0d2VhayBmb3IgdGhlIE1S
UEMgZXhlY3V0aW9uLg0KPiA+IA0KPiA+IFRoZSBmaXJzdCBwYXRjaCBhZGRzIHRoZSBkZXZpY2Ug
SURzLiBQYXRjaCAyIG1ha2VzIHRoZSB0d2VhayB0bw0KPiA+IGltcHJvdmUNCj4gPiB0aGUgTVJQ
QyBleGVjdXRpb24gZWZmaWNpZW5jeSBbMV0uDQo+ID4gDQo+ID4gVGhpcyBwYXRjaHNldCBpcyBi
YXNlZCBvbiB2NS4xNi1yYzEuDQo+ID4gDQo+ID4gWzFdIA0KPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3IvMjAyMTEwMTQxNDE4NTkuMTE0NDQtMS1rZWx2aW4uY2FvQG1pY3JvY2hpcC5jb20v
DQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IEtlbHZpbg0KPiA+IA0KPiA+IEtlbHZpbiBDYW8gKDIp
Og0KPiA+ICAgQWRkIGRldmljZSBJRHMgZm9yIHRoZSBHZW40IGF1dG9tb3RpdmUgdmFyaWFudHMN
Cj4gPiAgIERlY2xhcmUgbG9jYWwgYXJyYXkgc3RhdGVfbmFtZXMgYXMgc3RhdGljDQo+ID4gDQo+
ID4gIGRyaXZlcnMvcGNpL3F1aXJrcy5jICAgICAgICAgICB8ICA5ICsrKysrKysrKw0KPiA+ICBk
cml2ZXJzL3BjaS9zd2l0Y2gvc3dpdGNodGVjLmMgfCAxMSArKysrKysrKysrLQ0KPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IExvb2tz
IGZpbmUgdG8gbWUuDQo+IA0KPiBSZXZpZXdlZC1ieTogTG9nYW4gR3VudGhvcnBlIDxsb2dhbmdA
ZGVsdGF0ZWUuY29tPg0KDQpUaGFua3MgTG9nYW4hDQoNCktlbHZpbg0KPiANCj4gTG9nYW4NCg==
