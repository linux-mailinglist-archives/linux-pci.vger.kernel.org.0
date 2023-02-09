Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87347690F93
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 18:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjBIRx0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 12:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBIRxZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 12:53:25 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860582823C;
        Thu,  9 Feb 2023 09:53:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LneHlZF1YU7V/9KEm2aGCbfJZUA3P0bN7kgACreXNX7r2WXXbegIhbsC/KOUSKxzJkGU6J8cr5OnH8cfWmee6Inbf8vOAko9VFO/r6bAg3vCvtj93AnYE2yuz5cZ1urbiCJkRC5lkhOEJXh06pGdiuj80dl1wU68GpzFFHch2AA24wwT3Wgq2AOeXg3UFVyHyrqs5tYJDU7XjAtoQPyX/7eEbcuVnlwxVNWurV9HdNuh16BRPJi10RDzAUJpD3gt9Z38PGLaBCKbgo1/G7BChrUHOjhiDSnKFaCFqi4DXI0OFz9DBj+y6OFWdMfNuj9voyPIxTe9MrQlfa8iEULP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+Gv75YvhcstsbNVLl2GH70mVp3u0+s5zzVND+CVC/A=;
 b=YZeJr//N+oMGuokkeT/kmklL6dP0UTdnmBLLS4Ztl41JjRIbcynP7FEiiZyE4pjmu8kKKu0VJA1cxvi8WGIfeG24/qbg4x5aVNfa/PsrLLZ3e8R0TQ3d8st5LLJRz3FjT01vcMDE37ABz0C7+ZAi1Dg7sXTM8m7ZMjCMXdeW+mpzxgr3JYES5WLyPor8AD8v8qoE78Mwu8p5PU+UE8ePHIbSnD05QTurB5XHUhWgEBFFxEaLhKPCQobGr/F4rCkR0PbMNJunlIdSVX/y3dkBDe2JbmqfGXuzAGGp1mEABiO4Bn0F2mdjuJOLZrXAj9SKs0krSPFZ3crIXM6jEfDA6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+Gv75YvhcstsbNVLl2GH70mVp3u0+s5zzVND+CVC/A=;
 b=R2QPqNEGqbN8q8+QwtUoBjErcnTZZP8z3bOknY0hCb/8XkCv3Ek0TK1MynoYAV/fCnqM/XEVgZSkVtYKPkouzwcp2P378LQuRhamjq8avClxGx1Jm67vZ3S+GnlsDoSgGquLdHo0x3wfn09XCDdQi1yFTf7Qzu+m3T4u2taQKoJHRZLv5mG6ax3089974xPHNVDPZ1NaKMf5UmSFw1wH8Xfq9hl0pJJG0ooqKbhSokn+5PJHxlOYOr9ioUUmR0Oy+0CYQWFExpoBMhqfdjoLaNBalIwSA86QDbhLE4kTRSgZGfJZFmtkaPpIhv+stNFefhFwnqO4Yse9b1um0hT0Cw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 17:53:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 17:53:22 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] PCI/P2PDMA: Annotate RCU dereference
Thread-Topic: [PATCH] PCI/P2PDMA: Annotate RCU dereference
Thread-Index: AQHZPKwpRq6zY5KQv0iKdRV4YufCGq7G5XOA
Date:   Thu, 9 Feb 2023 17:53:22 +0000
Message-ID: <e0d780e8-03b5-f2f2-6b3e-49794628dea5@nvidia.com>
References: <20230209172953.4597-1-logang@deltatee.com>
In-Reply-To: <20230209172953.4597-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB8270:EE_
x-ms-office365-filtering-correlation-id: 46a7e79b-d7a5-446e-f6fd-08db0ac68904
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qedTSpngQherUSydvG04KkqYNAjJXu9SPKUMrNxACILoEAI5Flu8Gt6jtmXpS0tmH8vGTO+9SUJ/DGtUsa9fIGQwGJuI/teyMUpS0n5jNJyYEs92uFkygTdWO700Zd1iYfyF/4GVP+Kxiuo2E2gk99piRjhzsyAkaEPnn0iaNkqNzZZP+TgP9NCDOrn+AGrBlEd7LsXJ15PQs4vH6i0R7o+POa0UB5HqnOxOpZvZMzDEYP2b6DD4o54bXH7mBSqysFx20obdEhUqcWvgEevDxZi5XVWhuu5E6hR/B9MTymP7OKPijObfdtxT2xFRaP0rpppSUQBft1ysoZfOLYp54iF67iCjMxpvfKIjEN3lGyQp1F3kyhFABMzIBDzcpoSzHAxnprbQDd8sElBiut3hKeDCQxqvU7pLsYOcRjZKTE1ViDtDkOQwe6xSSiXp6N15a0Qvixue+FmdRpxTROgxG2F0GDPfp8vO3g6DeHA3mh1yOHmTn8kfijHffhFB5Nd1kVQm4Dv/ILYzxxuv5KDdHNfWNrsnrCcpxfQoRV9kYDhsXQzE2yL0lOt6O4NyPJx8RF1w/j7JPfI403Yly1h8SuOBHhwp0L6yIjK3ds/9iTuYT/fvofCK+TnbTj/4JY7A/xDA4jweZ8lUm3iHaNUGpycV6wwKw8ON+xnQ8cxc+WKNAST4Hc7ASP3ljLYrrlqXy6IEsXn2hzMP+vehbwMo1lIi8gln0XVxek+nxk2R9IdvUzrBZxLc4eb3FIBvjCfl06gcp8h6CfP2yVdF9dwUMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199018)(38070700005)(122000001)(186003)(38100700002)(6512007)(2906002)(4744005)(41300700001)(86362001)(6506007)(5660300002)(8936002)(31686004)(53546011)(2616005)(76116006)(8676002)(4326008)(64756008)(66556008)(66446008)(66476007)(66946007)(31696002)(83380400001)(110136005)(91956017)(316002)(6486002)(36756003)(478600001)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU44a3pGNUEzOTUvRVk1bVpISmxjbXFQSzlDZGg0aUMrOHVOeWJvSHJmN1Zp?=
 =?utf-8?B?cW5vV0tJbGo5WVE1Q044WXBvUTR5aVdsdWZOd2p0cnkvZEZ4aG56UDBlZTZX?=
 =?utf-8?B?am5rSTEvZHg1QUcxOVdYK1JXQVhieWdHMUlYM0lsYm9XNmFrUUdYblB3ZkF5?=
 =?utf-8?B?eWdaaTZKYlV3eHVydTlvRU1DcTNmQXZTWmY3NE5KcWV1QlVROHYwUlF0dTRN?=
 =?utf-8?B?OW5wUGwyVzBNajFxV0M3OVRMUzlTbXE3T0k0bDN6dmpwZVdRQ21ETFdPVHBi?=
 =?utf-8?B?YnBlaUtERk52emx6eTkxVC9HenE2cGwrc2JOUFg0ZzdybmJWTGhtSVJ1anFC?=
 =?utf-8?B?YUxJdmtWeGlxN2QwV3pRT1hGYTFRSUZyQ2pFM3A1MmJFd2hJeXZ2MHVBSVF5?=
 =?utf-8?B?dkoxWk83ZkQ2THZzRHdhWEE2OU1aNGNubnBSbDkyNkdWbXhBU2ZGeWlBeDgw?=
 =?utf-8?B?NmNRZDROTGtKcVNLSkx6S2xKSmtYMFJmODRXelU2TEpsaFZ4SFh2eitoSlo0?=
 =?utf-8?B?N2pWMUJraVBGWUtxa2VsSGxKOUVOa3ZlT0ZZbzVoWUFSQUhwR0FGajhHNHMz?=
 =?utf-8?B?VEN0Mm92ZUZRNGZkbkVFSHVLc2lmd3VkSWorWDRGRTJ5cmUxR2taT2wwYWgw?=
 =?utf-8?B?VVNRY2swT3lwbFErKzY4eGEzc0pYY1NJQ0VveTBIc1ZLSEJldHpFcVk3SEEv?=
 =?utf-8?B?WEJDUmV0MDdCYTl0UkRIV056Q1RKMnl5Ni9kUHpmalJTell1TGN1QW5rcElY?=
 =?utf-8?B?Y0VPcWd3SEgrRHFkVmdmcnkrU2wzWDhCUlBScStHMm1JSzYvMEp6QWduMmpG?=
 =?utf-8?B?ZzBrL3BLNmh0dTkwYXNZNVRFT2wrb3NicnZYSWp3aUtScnhYV2sxem5GUGtG?=
 =?utf-8?B?aWVJeU8zbjl5bUhKYXQxek9iSWFBNnEvWjhaaGYrc0k1RUQ4Y25KSG9WWEpV?=
 =?utf-8?B?bjNJQTgwM2wyaXZKcHNSYnNVOXpPWldGcWpSVnNUNFRhTUdZT0xCKzRybW94?=
 =?utf-8?B?Njh3MnpsVmx2NnhKWmZWSGRNSGQ4SUVEY2I0b2VWdk1MSnZKZE1ncEw4MW5i?=
 =?utf-8?B?YndPZEFmeld1cHhZTFpVUE1RNHh1UVEwMVdUU1FVd0xIUWNYVGt4SVhTRUtS?=
 =?utf-8?B?TFd4c2hEMmh6dW9uZ3RmdzRvTDZhOWxoSnJaeUdsT0hCRmlwTmdjZkxyUHd3?=
 =?utf-8?B?d2l0RFppOVdVQTdxQU9PSXFIUDdBNDVGQm1LSDlZRXFJNWIwczBiRlFXNGFL?=
 =?utf-8?B?UENXTXlCMnhVeERVWDNocm9QVDNqMHFXaDBmME9rQUY2QzRYMlBjVE8vODZC?=
 =?utf-8?B?Uld2M0xDUjc4MXkxck5ma1R4ZGhXT0VaRWpiejFZbktNcHhrbURpdmNJdVkr?=
 =?utf-8?B?YmxrQ3VXRUFSUFN1ZkQ3N0RoN1ptcE81YW91VWh1S2o0aW80Q2FZUGdjTUYw?=
 =?utf-8?B?YzR6QmVIRFJTM2JicXg0cEpreHJxbDRUUkdOVkFSYmdnTG1uV0FMVmpLL3Q0?=
 =?utf-8?B?VS9oNkFyUzNPZy9Td0Y3VFBSeWsvOVI1V1ZnSDBHTE9TSytRSk52YjNxSmow?=
 =?utf-8?B?STl6WUdjRGNBckJpaDlmUDFyeHpGeURwcEFXQkt5aVdWRktjSmxBSmFpcUpB?=
 =?utf-8?B?WmVuMEU1d0JUMTk2b2JvbE5vc0NvdlNFZWdnRHh5eGRNRTZrd0lCSlFabjR4?=
 =?utf-8?B?cmVTMDhTZFFoTXBYdlNKL2czTzVuenhTbENwWkhhVFlaT2RRa0dKZkdZdUoy?=
 =?utf-8?B?aW02YkdnRGRZbjRJM0FQMThDWmJPazFpTjlXMmp0c1FzYkh0V3VZWWxGdjFP?=
 =?utf-8?B?RU1kMlNjUmpkeVc3ZERZSzVsb2pFUXd2UkxzR3lRbkJ2eUdSNXczZ3NWY1F1?=
 =?utf-8?B?M3FRMlhEWXpJS01CQllPcnV4bjhZZnB4dHE4aUFNbk1tYWZuQXBtL0lFUU55?=
 =?utf-8?B?QWFZc3hxdU5sTkxVamtkNG5UbFBFdEswZmM1YUFFdEhUYmxRREZZTEtFWFkw?=
 =?utf-8?B?UzFibXpxK2NNSURpbDNYcVZkbUpPdktxNy8wRmJzaU5OMXFpRmhqQ1dvQ3Yw?=
 =?utf-8?B?Z2VDd2IzQlc3MjdsV09kb01lamVkNXMrSlV1bXJjcmlLTDFlNUFFR3FsR3Rj?=
 =?utf-8?B?RkxSeHV6RzJLbmxCVW1yM0p2Y29aMndFcS9qOHBLMHluSUlETWJvN2FBSVhN?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FE4ECEB04D55D4BB419BDA19E82291D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a7e79b-d7a5-446e-f6fd-08db0ac68904
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 17:53:22.1507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3HPcuojTOajgmdY6LbuOmcc5r8PJzc0Qd9+Tu5Lkq7ssV8UYNFd52FJM5yC6UCEkdV9lzs6SI2a9XLGjIXlJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMi85LzIzIDA5OjI5LCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6DQo+IEEgZGVyZWZlcmVuY2Ug
b2YgdGhlIF9fcmN1IHBvaW50ZXIgd2FzIG5vdGljZWQgYnkgc3BhcnNlOg0KPiANCj4gICAgZHJp
dmVycy9wY2kvcDJwZG1hLmM6MTk5OjQ0OiBzcGFyc2U6IHNwYXJzZTogZGVyZWZlcmVuY2Ugb2Yg
bm9kZXJlZiBleHByZXNzaW9uDQo+IA0KPiBUaGUgX19yY3UgcG9pbnRlciBzaG91bGQgYmUgZGVy
ZWZlcmVuY2VkIHVzaW5nDQo+IHJjdV9kZXJlZmVyZW5jZV9wcm90ZWN0ZWQoKSBpbnN0ZWFkIG9m
IGFjY2Vzc2VkIGRpcmVjdGx5LiBJdHMgc2FmZQ0KPiB0byB1c2UgcmN1X2RlcmZlcmVuY2VfcHJv
dGVjdGVkKCkgc2VlaW5nIGEgcmVmZXJlbmNlIGlzIGhlbGQgb24NCj4gdGhlIHBnbWFwJ3MgcGVy
Y3B1IHJlZmVyZW5jZSBjb3VudGVyIGFuZCB0aHVzIGl0IGNhbm5vdCBkaXNhcHBlYXIuDQo+IA0K
PiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRlbHRhdGVlLmNvbT4NCj4gLS0tDQoN
CkkgYmVsaWV2ZSB0aGF0IHRoaXMgY2hhbmdlIHJlbW92ZXMgdGhlIHdhcm5pbmcgaXMgcXVlc3Rp
b24uDQoNCldpdGggdGhhdCBzYWlkLCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRh
bnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQo=
