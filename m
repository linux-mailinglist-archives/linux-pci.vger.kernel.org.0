Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391EA49F60B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 10:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347520AbiA1JNO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 04:13:14 -0500
Received: from mail-dm6nam12on2088.outbound.protection.outlook.com ([40.107.243.88]:41024
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234281AbiA1JNN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jan 2022 04:13:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbGBIp3cIrkbLiSjtFvGUqtcUGsE+KFemZWyVsogzGOhBaMqS1szRiR7uWCUbIFCEqTGxz+dLt9Dq+wvEdlzkzWb7nHA/dwVxrWQlQy6H+OUkWs71fk6f6jXKJKAmt2ZUGfC3BIP1NfywfxsvSH1g2PFEya2e7XFv58s8eHq6WewIcss/p853WRLOwmsWWfPZXMb/GrbPlj1hFIEeyodrU3Z/4JAvMMXddHKQjYSGzF3cvFiFnr5kgeS6OCsItDcZe9pL4FdagxH+m/TOuvlMrYTAJ9j63AZyVBjqV/IWXJ7C1ZwpevNiurmh2CMHwgoY2fzCl+d5auQTHnHREHm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDDGO9l+GHDDD7OjVPtfLIcoHpug1HFQU/Kz2QCg7/A=;
 b=V7oK/nyAdrBjJ9UVE+JWq3UP56wI0FE+hZC0o8/Bgv7fCAB2bCqhkL34R3oCg8ZA4l3r7IiAgyXyl63Q83J1STfrZtJKcTIFq9ZlgoJWNohn0jtn2SoVcNUZaK9N/9vIKK+FIpZUlhWmOcjchK6Lk/dtFG5561FFkgpnK9sshn1mdqamQnZ6PyBORVDSCDQf4r8tvL5g0U1vibP36LDxcYDOocDolNR9XBaNXi8gc5rvpTaHDMYkub4I5LldLoemD86H5gok5JWHu+KhcJ56Pw7Q+T6ALfpL22PdgKrqCfYWIo+RZ7IzfTGpEl49wMuQpBY95I4dX8v79V9cAUCDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDDGO9l+GHDDD7OjVPtfLIcoHpug1HFQU/Kz2QCg7/A=;
 b=bOmE/QbpQ8DU71VOD3WQ5Ja0ag3EqbsjK6dawh7SlztdwmmbMXAKgJnrgT+YfMXKkf2b2CVsl47edB6w9hCW+goQgQ9MtYoQfswvb0oLxPW7t3q78eR09vU8XVz63Af33/XKNfYWapNDAWHxSGFkWiC5d7ROL97YnnNCRIZSlg78gTnz2NEK/pUX6uCslt7vBcPZDC/qBndLWRQZp9S9GkX7TT9nynl7uoRnQSVeY2UMVqRdhQTR57kXDTQ24tOeDYb03CE+yh8khW0lw2OlEt4ujjIglSKDRBtD4GJqhBggVMJ/x/vZI3MguUbfhFo8VooecRcFoKHd+DG5IOu6Hg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BYAPR12MB2631.namprd12.prod.outlook.com (2603:10b6:a03:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 09:13:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 09:13:11 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 12/24] nvme-pci: convert to using dma_map_sgtable()
Thread-Topic: [PATCH v5 12/24] nvme-pci: convert to using dma_map_sgtable()
Thread-Index: AQHYE93DRXAPGacM40q8QY5Zypteeax4Js4A
Date:   Fri, 28 Jan 2022 09:13:11 +0000
Message-ID: <8ea7b917-e8b9-2bed-40bf-276c8a0b1f2c@nvidia.com>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-13-logang@deltatee.com>
In-Reply-To: <20220128002614.6136-13-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a97b3ac-8f71-4d97-c878-08d9e23e6828
x-ms-traffictypediagnostic: BYAPR12MB2631:EE_
x-microsoft-antispam-prvs: <BYAPR12MB263176D6DCF808CBBF261045A3229@BYAPR12MB2631.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FxNC72RfPCPnBNfX67COYfQRDLVZj0GWWwPThisBQgjqfwNZEIW8ZKvyuvPXlsvyg36DMEI2C0c9gAVId5lBE54RK8vfFFq4PkSb2lhVjOyjG/IYqeyKGWRa9ZNwtm8ZlARN39Go2e+Zf97QkcejH5lVnxzoKKnDMd80ylCUsSeN2AhRqvwY185j2V1LW+AUJR0cn/244TVk5QtfY9HAEw0g5SwIZvgJp7NSzqNihtzWhWrb932p4fP6mAqHttlPfUyoR0ZT6U3nYg+m+NGFlWYCydMGZMTlpAVh9PyXjpLn6wi4RScZAphelAjmUN6OzY/H9FgwAi41lGz5plL5ftkHCI5UAax5YgwZ/Fmr4hn9dTIvaf8u5n7DDUIwZ1re9CaIO2hWjUG7Rl+LWQrMe+nlv8NREwEmwzvzLFGamlLmiO35K4ZxgqcZLy2+0yGbZyxBfJdt6kr5dd6XFweW4bTj6SRndBv555dIe3XmdK3RHF23WL7V0An2t4XNfoIfynN9nmz6MKY7oNDM//7BAWPyNzMtn+RityXU6DUM6KKH7dDTfCx40KIwiBG+YesDAdw+5ZvV668W+npSq2HlnSrtjQdAftcYtaTMLeJsvv971E5ibxwCoFTz9ILjmn6NIz4KnX3ZeFTN6OWa2clD7S/6gxN+L4/lko+DupqWSmrXZI3A63vbaVK+DnH7APoQA/S8Lf1XUxCb1Ab6+uEXYve+ycGakN4XkaClYqw+hDxc2VuqToZQLzGLXWOfXQVTNq7/okYFOJq8/SgXEpZ3mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(76116006)(4744005)(2616005)(6512007)(6486002)(53546011)(5660300002)(91956017)(71200400001)(508600001)(6506007)(66556008)(36756003)(2906002)(31686004)(38100700002)(186003)(122000001)(6916009)(54906003)(38070700005)(316002)(26005)(66446008)(66476007)(83380400001)(8676002)(64756008)(8936002)(4326008)(86362001)(31696002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEo5RmxWbUxsbmgrcHdvNVlnZFZNMm5yM1pxamtuWWR1TldIejEwU0NIZ2RI?=
 =?utf-8?B?VXAyQmptV2loK0NpaGNieUhiTEFFd1BCZE9RaDg1b2lISmtUdTJzS2l6cXky?=
 =?utf-8?B?dWN6MlFNM21raVc5MExkeVNkNkxad3dVdzdKdGZwV0pWYVFvTVUrL0VTK3BV?=
 =?utf-8?B?ek5HNldVVk9IRGVXN1A3R0ZwWmg3c2gvZXZSMnk2eVI2M2FXWlN1dmlhWm9h?=
 =?utf-8?B?a0Y4cnVsZk9VR25mUnlEREFBRVdBNm1qbDQ0NHU0aGtPbEhWR0RFTVVVNkMv?=
 =?utf-8?B?WWFYcUNnMlViVHI2TlRQWVc4RE1lV2lTOWJDOGtjQzRhZzZYVnc4U1l4VDZx?=
 =?utf-8?B?ZlZwT1hGVkpUWlArS2V6R1dobDcvNEo5ZmJkWHlaT0EvcE00S3lERlNvSjZu?=
 =?utf-8?B?dS80K3laY2N1YThXS01uV0F5a1FTNGk1SjhBUTJqNVJpcjFKaDFoSnQraUk5?=
 =?utf-8?B?VmNyMUpQSGhvd293NmJRc3lZRmNRdGZ0NTdKeEVqWmozeFpUMEhtVUFKM3F2?=
 =?utf-8?B?alJXYndsRFN6VmNYTkpoQzZzZStXVHdSYU00OXNYWUVzbE9FZEJXVTRIS1U5?=
 =?utf-8?B?ejF5UUY5MExXWkUycnphZnBtRVNhYmxicjBoMy9EcnhpNDNvaFF6QjUrNFZY?=
 =?utf-8?B?T0hOWjl3cFVXYXZhbkpUemNyaWoxbldzZEE4cmQ4T1BRM2lxNkNHa3BRemdC?=
 =?utf-8?B?cU5JRHQxWHBXVnc3Q09QOWQxNkV5dXV0UnNheXVVVzh1c2p5S0QyYnJmTENy?=
 =?utf-8?B?Qkl1NTJIWk1DMVl0cVBlK3JLaUFLdjR5amtSMUVNNFB1QWpOMWpPSVJOd3Ns?=
 =?utf-8?B?T041VW16U2h6MzF1QnArMHIrVDJid2JKZFJ6N0RZV2ZEVUlWMFRHQVRMOUdN?=
 =?utf-8?B?RnZ4WXROQndSZnJaVlE3bytXV0tmeGZiQVFEWDFxRlFuaFNUd2xFdkpDUCty?=
 =?utf-8?B?L2pUdWQ1ckJ0NkExdEg3Smlxc2VmVUY5V0RrdnhIVjkyWkNQZ3FGTkVFaDR3?=
 =?utf-8?B?a3pBazE0bXgxdnRJczB0NTBXWm5EeUlmaFFLaExvb1k0RWdoVHp3bVdkbitS?=
 =?utf-8?B?Z3kxN2RPa3VSUmhSTUl4cEc1R01EYVBFQlBBSVBOVmRTYzBXOHU5dWVTOGhw?=
 =?utf-8?B?TzFrYXcxbXBtTTlTTnlhV0JRclorVk5GbzJGQU5kRVZ0cGhUSU10K0tVRHdE?=
 =?utf-8?B?NEV1Z3ZSUXR1T0t5SzllUXJqcGRNVWlYaXFBWCt3TDlTaFVjbDVIVjFXWHlL?=
 =?utf-8?B?OFppOHpWQXlQQjNOTkVCT0xiVkViczFGZkVjdDgrNEx0aHgwcmxFcVAyeE5B?=
 =?utf-8?B?Tks4MHpzKzFWSVM2VXVUMXRKYnVVQjhLRVVoNm9nUlN5dUt6K0hZMWgrZThl?=
 =?utf-8?B?K2RsRFIza01pZWNCWEk3V3VsUVVaekhDMC9jL2lOUjRneTZGbTVhMTQwdU5t?=
 =?utf-8?B?MWN6QTNOc1pkbGt4MUdYOUZlR3hVYmJ6QmVtQ3hhcmd5U2RkUE1aM0xVNjF0?=
 =?utf-8?B?SFlLaWI0QVJZNFEvcGRselZQZnpoalZxSUYzbk1MOS9MRVpXaTkwNEFBcW1N?=
 =?utf-8?B?blAyOTJCaXFNUGFQbG5Pb2NpVHRUdlBEeFdDTzQ2NnpQS0ZlRW5Va241Y1VN?=
 =?utf-8?B?d0R6S0M2MUQrMkhENUpIUjZDS0pMNjkxOTUwTFA2R2hiZ0tqamdEalZRVVpv?=
 =?utf-8?B?VWZHQ2pqWmRzTGJJTm84L3RXY0lkeWN4UnZDSkhnOUs3UUhwenNML09nMFJO?=
 =?utf-8?B?MVFiaXNvU093NjlHWHAvN3o1N0srVFJWNDd0OUVQTThteVBTRkJhL2lDVWhj?=
 =?utf-8?B?Mk1QWllIZHB5aGtrRkMyUnZ6QVVWTkdjbVRRRG9zNVJwbVNSekw2cHd1aU5F?=
 =?utf-8?B?b1p6Y28xSEF4ZGVYZjhPYyswcDV3MzFBcGhJRXpncDVtYmY1SStvVW1PWnQ5?=
 =?utf-8?B?Z2NVbUt6YVZhZGxvZEptRXJWZnBTMWZDeWVZYUFqZzIwbC82eUxNT2hBSkFP?=
 =?utf-8?B?K2JKbTRsd3ZxeHppdFZXOUlIb1IwUGZrTzB0a1FwblhPWk5SZHV4bUFqUkR0?=
 =?utf-8?B?eGNUYm5XRGgvK09SRG9GMDZHQjJFeEw1YStJcVRTNlpmSURLZWx1R2s1MXBj?=
 =?utf-8?B?dVZnUThRdGVCSVk1b2s5a3Viajl2UmVpaWQrQlhxdGQwYUlHSW1xMHZDTkNI?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B315B704E0242243970070E55F91CF40@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a97b3ac-8f71-4d97-c878-08d9e23e6828
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 09:13:11.1738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f0hTNwwnRDK0aLpuKmNMZtks21K5zltKtcQ8BI6+1cvTfGCzGeUCHuz/1iRddoNVuaxb/ByY36lRTW2WV7pLTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2631
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMS8yNy8yMiA0OjI2IFBNLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6DQo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4g
VGhlIGRtYV9tYXAgb3BlcmF0aW9ucyBub3cgc3VwcG9ydCBQMlBETUEgcGFnZXMgZGlyZWN0bHku
IFNvIHJlbW92ZQ0KPiB0aGUgY2FsbHMgdG8gcGNpX3AycGRtYV9bdW5dbWFwX3NnX2F0dHJzKCkg
YW5kIHJlcGxhY2UgdGhlbSB3aXRoIGNhbGxzDQo+IHRvIGRtYV9tYXBfc2d0YWJsZSgpLg0KPiAN
Cj4gZG1hX21hcF9zZ3RhYmxlKCkgcmV0dXJucyBtb3JlIGNvbXBsZXRlIGVycm9yIGNvZGVzIHRo
YW4gZG1hX21hcF9zZygpDQo+IGFuZCBhbGxvd3MgZGlmZmVyZW50aWF0aW5nIEVSRU1PVEVJTyBl
cnJvcnMgaW4gY2FzZSBhbiB1bnN1cHBvcnRlZA0KPiBQMlBETUEgdHJhbnNmZXIgaXMgcmVxdWVz
dGVkLiBXaGVuIHRoaXMgaGFwcGVucywgcmV0dXJuIEJMS19TVFNfVEFSR0VUDQo+IHNvIHRoZSBy
ZXF1ZXN0IGlzbid0IHJldHJpZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMb2dhbiBHdW50aG9y
cGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+DQo+IFJldmlld2VkLWJ5OiBNYXggR3VydG92b3kgPG1n
dXJ0b3ZveUBudmlkaWEuY29tPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg==
