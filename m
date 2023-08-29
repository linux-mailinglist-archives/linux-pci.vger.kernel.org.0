Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FBD78BE00
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 07:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjH2Fjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 01:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjH2Fj1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 01:39:27 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89B5C3;
        Mon, 28 Aug 2023 22:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkMdSProa13G/L2JQ5UgCEg9NDTyPvrQTI2jvIDJaRSSb8sBQXvzrP4+fclpIba8Pnmh1cFQrbrxH47SeObEF38Cdt/Wr0aIkPWknzNo8FRRW6fjx1mo0/UxkkserUpT+JIK3fbg9uJ2D4uzcqCounj9jnJhLlNC7SlZfajOA4nBSTJFdPcdpGdy/7cVw4L9VQuw+wXeyVdLwvjIhAA3/zxwxNw7TaDy0p1EjPUOhSwZzx0+s0S5OxP/TP3yclfD/BaahDtSP+LXXKg8GtBxPYBMp+2srt4QghO3SegOuNG1VnbKN+4vbk0zuyg38MUNDAtBzd5g7KoTmOZD6tW6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijFPucyABGEWRDgLUAoXVQBrjKtpk5fkhTCM4LLY2So=;
 b=ISHA+vfmckBQ5GmSuMesGECoSDmTpsxIkAZR0aITUPJEbRtdqEWc51jazuMy4Emo6SJQRMVexBX9vhqqi/tQ5iVpgsdhXT14LGIPz0eln+mxIVTySs1iNe+vqFJlImbp2Mzyx6PLiosFhZH/qRWpRs4SY+ztLnR8bR/WSKNVA3DwcH4qJqNjYzOIjcm7dKndP812u43KNhpmNKhMHHnEMmkW70ptcVHzKt+K8TCfngUA1e88fsnHrmbTPjNBEyvZcqOBOl7l397X8V8OZ6QruTLz60uy5zLZFJrFsE8g2R7oFbzpoKvBMBaq4HTmhl3Dz7IVKvDlVQ+Rd9eLY6maiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijFPucyABGEWRDgLUAoXVQBrjKtpk5fkhTCM4LLY2So=;
 b=INrg6KJUcLyTAaxFh6OwHPeVP7FtNjTCYlimqTOkCOdOEixbHu80lNtKvFce6vTaNuE1g5MThzz3GJNGZpLLnDOdSXNWclyjVfLozZAvHpLuJoNkFk1RtupEnkLGhSIXUfEA+EjtWvVbtvAbf+V1q3N1e2UptRjZTvEFzN9imrwRbLOcYA0eaY7xxO3QZdJ32eREtgurFiat0pUagWONLPtFAuXn3lAwnMA7HWLa/iU8ZxNRw0G/kEy3C03dbURkf/TrffeyrnnN8/tpiS7Z8IoS8ij8k4MJ9ypc7wT+B+XMhfM4X9AM3A4uIl5/pQI8ewje3KPgNPptAsBfSE/Vvw==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 05:39:18 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::5fa6:31e7:e6fb:3beb]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::5fa6:31e7:e6fb:3beb%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 05:39:18 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: RE: linux-next: Tree for Aug 28 (drivers/platform/x86/mlx-platform.c)
Thread-Topic: linux-next: Tree for Aug 28
 (drivers/platform/x86/mlx-platform.c)
Thread-Index: AQHZ2e9IpU/X0JHUSUePE8AhAQPCHLAAwguQ
Date:   Tue, 29 Aug 2023 05:39:18 +0000
Message-ID: <BN9PR12MB5381C39F394EA2E292A057BFAFE7A@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <20230828150220.31624576@canb.auug.org.au>
 <ad664c17-9bd4-08ed-6a23-54de4a94e0a3@infradead.org>
In-Reply-To: <ad664c17-9bd4-08ed-6a23-54de4a94e0a3@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|CH0PR12MB5369:EE_
x-ms-office365-filtering-correlation-id: 8b873273-fd05-4174-c1c2-08dba85249c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lWUXgCV+gAJsRC9JtE8/sHzQKQhnac0FEyLmEXsiNbRoUNrsxspjemdI5wEV7h6upRMvchUG4HF8KHmIeMHI2BLrngVavwu8Jngz3NCsWAsJeoqd0gALN3uTJsfGh2NTWLjoxba/TDWFFVMjX3OTheKeMwVDJRrAJoQ+zUPoFebu6QOqxqPzNSjC1WAXWKUqEW0+6alfKM2Fy6JJ/sbbn4tjThOJeyE9Pv/2SaTdsq7vrlBvHuZbyHpRlt6w4k5+jmesp8eIGmdzphxtpz2y0C2eZzW4KQ4mDLk2ZtIk1OnuiWnibupWx/mIH6LlMxm79NmCbEvup8cJBryjGLezxiHnxAZ1di0q3He0IGQYZythUroZIEaKfKSmiUNWq/s+xHj07Bw8dHdU7XNtDAbea3zEPMJdA4yOWtz4UAoNcsBqn2TOnVLh9SBWk0egyDHvHFXV5BLNtUj+bGZRTlY79KG5fWYjaYcu2dKicG9QUHWhqZflHxaGnPYNRciA2qzGE7eDjD9OiIxO89uwgRCBmd0eZ2+Mu556RBe5XbmEPWDi+Y9wQtUA9JJmd1HUqQ0q4XFHZV6oTM5gu42KA11UFysApvYxMS94roJAfYr58WzthyZiVE9Rn5Bvmc8i7aod
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(1800799009)(451199024)(186009)(9686003)(38100700002)(316002)(38070700005)(41300700001)(4326008)(33656002)(2906002)(83380400001)(86362001)(52536014)(26005)(5660300002)(8676002)(55016003)(8936002)(71200400001)(6506007)(7696005)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(53546011)(110136005)(76116006)(122000001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V093UlVQNFlDemlXQ0UzSlN3cGxtbVNETHRSS0Z2clJWRm9DTGRCVVRWOFRB?=
 =?utf-8?B?OVBoSlMwSTQ4N1oxUXh2dEpTY2NOclZHQWY0NUlQdmZpdThUS1NtbFN0aURW?=
 =?utf-8?B?RnpyS1cvenFYNHBNQll3cEZPVjZRRnJ1b1FpV1hIWGxtS2kwdmFhQmE0cCtJ?=
 =?utf-8?B?WXZHMnYzTEhQcjBTV1JlWGtMVEF2QXpWUjJaNGRiL29EeFZ2WUVOTVM5Q2Vj?=
 =?utf-8?B?S0JUa1pZZHRuRGN4ZGc0cTkzU0FkYzFDM3JZYzRwWW56R3F5cjhuWStsK05r?=
 =?utf-8?B?UGk4NnBWNHA4azA4bVZtbmJnRmFZN0F0eXh4NWVLUXFzQXhTNkc5TVcwMTRC?=
 =?utf-8?B?UHlyT25tL2tZWUZkSk9jNFBXZ0c0NGxIM1JQMXdOYWVVU0x2bDNSUjVmdjVG?=
 =?utf-8?B?RUVtWVBwWHJBSENnVnZBZFY0dnNvajBWRmpQbjN5ckhUZEgwTTRsWDFERnJw?=
 =?utf-8?B?NUJHandwRXNxOE41RXNaeFRacW9sUElSY1laK3VHeHE4UXBSbDNZRGtTdXky?=
 =?utf-8?B?aVJLWXJRTTJzR3JJTWhRcFYvdldQdDZlMDhGT1lwZlFYa2wxMkpHT3U4NGVR?=
 =?utf-8?B?M2hNcmtMdXUwRHhKRnZnUk9lTE1JN21zWURBQStPNXA5dk41Q1BMcitYaW0v?=
 =?utf-8?B?YkhidDVUaXNQYVRqOE1Ta2hQMWl2S2t0aUw5SHl2MU9Vb1dJVm1keGYweFRW?=
 =?utf-8?B?SkhMOWlNYkkxWUp6TXF4RlNVdHpHWHE2SVp6Y29RbUd4dXVRNjR0OG5pTUkr?=
 =?utf-8?B?anRQcFVRTGp6ajZ1YzYxVUpxMnB0bWMwenNVMUZxbEpUZm1hRzFUcGh2TUJB?=
 =?utf-8?B?SHJGTS95cTg3dEQ4U2JCQ1V5cS9Rc0ZRa09aRjQ3UWc3RVRhMVQyN1plcFYr?=
 =?utf-8?B?Z3F6dFdMOVJJZXNQOXFCbnlWV3dHYWwzLzFzQVZxMHJScmM1bnYyT1Zveis4?=
 =?utf-8?B?RGxreVM3aDJvNnU4V3AyMjVoaVFCS3BwUUNJQjRUNDdjc1BwZktLaldqTWlz?=
 =?utf-8?B?ajY2Zk84MWxHSVpSVnMyT2NJdDF6Rko5OW84eklsUmV1eDJ3MVdtMFJLVDZi?=
 =?utf-8?B?eSszNHBkY0VDVVMwUTZDU3ZYWCtKYitBLzVDMWpud1pxY3E4RkxKNUlHYlMw?=
 =?utf-8?B?NlJQL2cwZ1RHNEZVVCtmWXZlRjUzUVhlYU1OWlBuY0hXR0N0M21YdjZLVlNP?=
 =?utf-8?B?ekw3NkxuSVM1WVJObE9ZWjJjN3Q3K3FJd2grWU1aWWZDVVZ1UzRCMXFQbTJP?=
 =?utf-8?B?TmM3V0VrcEl4MFNXSGM1dk1pMUc3eGJZbHpQelJSb2FpZGd6N0VGRjNwQXRQ?=
 =?utf-8?B?NDUwbXpjaEVYOHNxOWNiN3ZObjRFNWd5bVlGcWFFWXhoVFFmdVZCK0pZcVlU?=
 =?utf-8?B?cm9idzZZK2hoQmFWTnFOTGpyU0J4ZjMxek9RRWxSR2o0ajBjSG5KOHVqNDJx?=
 =?utf-8?B?ME43RlRtMTh6TXZGTTcwellpQmZyTGhkNDAvV1ZwcElUYUhWWUdndjdIbFhY?=
 =?utf-8?B?bjVIUEFTWEpwU1U3TWpURGJrekthU0d4eTFoUi9JUnhQOUtzeVJPUllHNXdQ?=
 =?utf-8?B?bm0yQmZQcnk0V2M1VXRKV25oZVRkT2JONGoxLzVmdlBjLzVOMnlQcW9oOXc2?=
 =?utf-8?B?d2N2Z1prK0xhbFl3K0ZIOVkvRUF5OVNXUWtjZDlZSks4ZUg5aTNDclBjWUVa?=
 =?utf-8?B?QW1rMEpiSzJaM3BVbGFHb2pqNnloUW9rV1YzeHVNVTE4a3NhWHZTL0NQZnY1?=
 =?utf-8?B?bTQwUmJ4T3FDL01kT3hKSGVpa3JuYmRvL1hua2xwbTlyS0RJZzF4NWp1TEFy?=
 =?utf-8?B?akJlWmdaMDhTalQ3bnpiMFVrZjBoazBGdWhiZ3Jta0s4YkhXN2VDRE9OSzFP?=
 =?utf-8?B?R2xMODZTWm94dWpMWlFmT2xneXFnQkJPVWVIM1BiUVBaMHdnbE1IbWJtbHFH?=
 =?utf-8?B?SW9UalU1ek9CMmh5QnRyeGFkS1VCbFF4WTA0N2J3aUZ6QSt3K2l0aTFJeTdn?=
 =?utf-8?B?QWNOYnJjSUFvL2V0TGZNZnRWUGcxam5BQThwMkszSmFXejM4M25GcGJLVWkz?=
 =?utf-8?B?a3krZ2FaL0Q1ajdsc1NhVTlsVmJIVUV3NlV5SmVsM21VUjcwOXRNOGpReTND?=
 =?utf-8?Q?xydg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b873273-fd05-4174-c1c2-08dba85249c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 05:39:18.0913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kY8RvgguOcrwEcv6BNyNojbxpuyY9q/vrawxvKvdANEybrjgYvqhxlzbg5uvxeIW4gQPjtNyvU9/Eudd7fpICg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgMjggQXVndXN0IDIwMjMgMjM6
MzYNCj4gVG86IFN0ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5iLmF1dWcub3JnLmF1PjsgTGludXgg
TmV4dCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBuZXh0QHZnZXIua2VybmVsLm9yZz4NCj4gQ2M6
IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
OyBvcGVuIGxpc3Q6WDg2DQo+IFBMQVRGT1JNIERSSVZFUlMgPHBsYXRmb3JtLWRyaXZlci14ODZA
dmdlci5rZXJuZWwub3JnPjsgVmFkaW0gUGFzdGVybmFrDQo+IDx2YWRpbXBAbnZpZGlhLmNvbT47
IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBNYXJrDQo+IEdyb3NzIDxtYXJr
Z3Jvc3NAa2VybmVsLm9yZz47IFBDSSA8bGludXgtcGNpQHZnZXIua2VybmVsLm9yZz4NCj4gU3Vi
amVjdDogUmU6IGxpbnV4LW5leHQ6IFRyZWUgZm9yIEF1ZyAyOCAoZHJpdmVycy9wbGF0Zm9ybS94
ODYvbWx4LXBsYXRmb3JtLmMpDQo+IA0KPiANCj4gDQo+IE9uIDgvMjcvMjMgMjI6MDIsIFN0ZXBo
ZW4gUm90aHdlbGwgd3JvdGU6DQo+ID4gSGkgYWxsLA0KPiA+DQo+ID4gUGxlYXNlIGRvICpub3Qq
IGluY2x1ZGUgbWF0ZXJpYWwgZGVzdGluZWQgZm9yIHY2LjcgaW4geW91ciBsaW51eC1uZXh0DQo+
ID4gaW5jbHVkZWQgYnJhbmNoZXMgdW50aWwgKmFmdGVyKiB2Ni42LXJjMSBoYXMgYmVlbiByZWxl
YXNlZC4gIEFsc28sIGRvDQo+ID4gKm5vdCogcmViYXNlIHlvdSBsaW51LW5leHQgaW5jbHVkZWQg
YnJhbmNoZXMgb250byB2Ni41Lg0KPiA+DQo+ID4gQ2hhbmdlcyBzaW5jZSAyMDIzMDgyNToNCj4g
Pg0KPiANCj4gb24gaTM4NjoNCj4gQ09ORklHX0FDUEk9eQ0KPiBDT05GSUdfSVNBPXkNCj4gIyBD
T05GSUdfUENJIGlzIG5vdCBzZXQNCj4gDQo+IC4uL2RyaXZlcnMvcGxhdGZvcm0veDg2L21seC1w
bGF0Zm9ybS5jOiBJbiBmdW5jdGlvbg0KPiAnbWx4cGxhdF9wY2lfZnBnYV9kZXZpY2VfaW5pdCc6
DQo+IC4uL2RyaXZlcnMvcGxhdGZvcm0veDg2L21seC1wbGF0Zm9ybS5jOjYyMDQ6MTU6IGVycm9y
OiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZg0KPiBmdW5jdGlvbiAncGNpX3JlcXVlc3RfcmVnaW9u
JzsgZGlkIHlvdSBtZWFuICdwY2lfcmVxdWVzdF9yZWdpb25zJz8gWy0NCj4gV2Vycm9yPWltcGxp
Y2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiAgNjIwNCB8ICAgICAgICAgZXJyID0gcGNpX3Jl
cXVlc3RfcmVnaW9uKHBjaV9kZXYsIDAsIHJlc19uYW1lKTsNCj4gICAgICAgfCAgICAgICAgICAg
ICAgIF5+fn5+fn5+fn5+fn5+fn5+fg0KPiAgICAgICB8ICAgICAgICAgICAgICAgcGNpX3JlcXVl
c3RfcmVnaW9ucw0KPiANCj4gU2hvdWxkIE1MWF9QTEFURk9STSBkZXBlbmQgb24gUENJPw0KPiAN
Cj4gb3IgZG8gd2UgbmVlZCBhIHN0dWIgZm9yIHBjaV9yZXF1ZXN0X3JlZ2lvbigpPw0KDQpUaGFu
a3MsIFJhbmR5Lg0KDQpOZWVkIHRvIGFkZDogJ2RlcGVuZCBvbiBQQ0knLg0KDQpJIHdpbGwgc2Vu
ZCBhIHBhdGNoLg0KDQo+IA0KPiAtLQ0KPiB+UmFuZHkNCg==
