Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A516CC0B2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjC1NZl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 09:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjC1NZf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 09:25:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73314C14E
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 06:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsOKKY5IQ2WKBunlYQb1RoNwIKA7gl9r11sGCa1kMScPpbXkPHEhtz2xTmTXVVpy7TanOvbohyA3JniIkgr3LF0UZkS1uCmd0Rl5tMQaAyaRL4tnS7eTTvr/QP3bb0YO9hjDAtmBf9FdocW3mSdZbs9DNPBLWkkuxCTpKCsA9uYIiKmMjsjNavE59dRS82z5bd0PgGBdZPgFgF1F0YEyGn+XToXDtrmZq6HRKxFGarRqfPD4+7yuXPB8UYuIl5vjc3RH5r758c6awko7lsY7Uyw3XileCuZ+Av7FAfbv+O1/8FsvdDJGI001cigM9imxa3r28u0ZuHjtHsiArZ5ODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6W3+QTMLtl3yIQzl9AD07nBI03QxBaVNHlF2hIcmCHE=;
 b=LrRUqJI4TluHd6/vDHBkyXbrRPJ+QsvoLbLZ1bzpRY8VHSVO4Kme3mCx7CNbIDWkdl5+Y/4xGo1EwKH5hwBF4K5qcxJ/NI/KUq1UmOkNMksdmO17K7vVlwkhJaowfar9r6mlAias77fMrkUGEJigJkGjskDbrMmVFSRiHHKKp0gdN0GgEGXm2bNqsTA6H2BJ1EdF1R22nnhv7/78zZ58hM/GBlSvY3Yfka8guv+/hAq1jLa++0b1He193NW/eBPQF1g5KYYloZ/3qLwcvN/xBLptZjuec/Du0bwHqw/n1yHSWUEhzDP1qjv988bz6hkUSScYQHHp8WMOUoc/zXof1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6W3+QTMLtl3yIQzl9AD07nBI03QxBaVNHlF2hIcmCHE=;
 b=FBHmQkI3SuNwntNfUq73QnVy+/j7tofZ4Dq/QFyiSJsYmxXnzsV+dYvFKJQW0O35K10V0jmfEmeNrYo9Ou98iaygkVpdCT7eOq10L9Fla4w1sfnVtKRxblsch5yRikqAG36qR6afzkFloC9yZsunFddviUujnAmTwcfHIXCxT6E=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Tue, 28 Mar
 2023 13:25:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 13:25:19 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: RE: [PATCH] PCI: Add quirk to clear MSI-X
Thread-Topic: [PATCH] PCI: Add quirk to clear MSI-X
Thread-Index: AQHZT/y1Z53wI/N1kUuWSAR9Qbt1I67xfxoAgAAC5BCAAJEkgIAAtd8AgAACFYCAAEKLgIAAKQMAgAFkgACADltzEIABCGGAgAAAwGCAACbYAIAAAygAgAAcrwCAAAHogIAACJcAgAAMjgCAAM1OgIALJBcAgAABtyA=
Date:   Tue, 28 Mar 2023 13:25:19 +0000
Message-ID: <MN0PR12MB61017D57ED01AD051FCE3780E2889@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230321110747.GA2368837@bhelgaas>
 <1f0829b5-09fa-54ec-f441-1bd7bd93b791@amd.com>
In-Reply-To: <1f0829b5-09fa-54ec-f441-1bd7bd93b791@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-28T13:25:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bd6d0ed8-2a3b-4ab1-a1cb-5f8c50d8567f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-28T13:25:15Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 48e92758-fe3c-4db3-a2c1-e15a189e75f4
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MW4PR12MB7286:EE_
x-ms-office365-filtering-correlation-id: af9af226-8cc3-42d6-fcac-08db2f8fe02c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E1nma3hfNO0w4rMsSrsqQryA+C0L1urK2oePCibukF1OgmR/685pZTBLJrRARv4k2gorDvtT6q1JAsXBuzsMYoPLtQanqRMiRA1cwdylyWKCpUvC6lHQtyPhxVzcRVZ6eLvbkDlN/ZUHhfy9xiI6nL5WewXK6haN/dgNjULu4VMsQohQ7IjC6bNNBbmFL6xxvjq1+NkUuINFTlDtkNYFyyh8PdYdD4OHJniAfk6++wHD0rpJif5UByteQq+f8nHkLvhFhliZ+STe8rk/Hr7MnjWD4NrXCwv3jNNIbm7DeqSBKR8bxDFF9pReSQIu04pwcKmGn/zihIde+i8HFApPPNQsetOr5bEX5COwpm1bIKuvVVycyYta5EBTUYfNhz/qv/6QaFKLTOruQYoMiHq+I+jE9mbywLST+W0gJFAZE0Upp1lYQf5DR1Uq8eV2dXvz3Ubw7XX4GfvGM3y0o89QXCyQhCqZg9lJBstnhyXXJMaVCvs5M6rqOeA4GbC6d/DF441bYY8+4zM70ifnnvSE0Y4rILAC9Msqtf5Q8JnGQNvhH0ANvpxoWEJnvkQEvnHjPFYFTtu36hk/17GPTlJOrest39z83EkPQBCbQxsfVvWEsJ2vmQsvxSoMYX2MaaA3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(83380400001)(64756008)(2906002)(8676002)(66556008)(66946007)(4326008)(66476007)(478600001)(7696005)(76116006)(54906003)(71200400001)(38070700005)(316002)(9686003)(110136005)(55016003)(186003)(6506007)(52536014)(86362001)(41300700001)(66446008)(8936002)(122000001)(33656002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkF0UUJhZlczZmdlZnBkV0V5L2w0T09JY0J1K0x4NloyN3U3UzJYVlM2NS8z?=
 =?utf-8?B?bTFHUmFwa2RnMjJZNDNpbGN6QWozVitsaTBNdmR6SEJQMVhhSDd3T24zbUgx?=
 =?utf-8?B?YTgwektuajVhZTd2aExyTTQvZGxZY2VLUTh6aUxyL2FkbHBMa0dHWXJ5b01q?=
 =?utf-8?B?eGVBVkl6cW9rVzBnS005WnpONW04YW5pdm9RVjdYRUowOFVneUxoRlVUdUty?=
 =?utf-8?B?UThwd2VnVXQ5TzE3RjNRanFHTWJJZFRBSkNmcEZNZHlXalBvcWczdnJMUUpu?=
 =?utf-8?B?VkdUS0hLcStSODBmUTZTZFhodkF5TTBZMktMaHVsTy9OTzNJamUwZDRYUjY5?=
 =?utf-8?B?dEp2RXhBWG5KdHc0ejBvMXJoOHNvUHZSb1pzbHIvOTZIWnpQUG15UGEwTGxy?=
 =?utf-8?B?Umt5NFJyaFJjb01id2tndGc2UCtRTWpUanVOYk0rR0tXbzMwMFMzOVlNclNJ?=
 =?utf-8?B?Z3ZmQ1dRQ1U2ZStxWVViMERkL0RqbXVycXVreUhMOUN3Z05sbXJHTDdUS1k4?=
 =?utf-8?B?aXQzLzgzTFI4Tm5MZFhkRnR0dTdqV0Q4YmlBN1JraldmREhFejNsWDZsbGVN?=
 =?utf-8?B?VmhTcE1FNmxKelhTbTc1ZjBqbmVONUh1aEdwYmNQTVNCTDlCV1p3cDNYYldF?=
 =?utf-8?B?N3FETHJ5YTd0SDRseHRONHBxRjdINytQeDcxUDZqZ3lKMVgwT3pkU0hJQXA1?=
 =?utf-8?B?eE53K3MwQ05VN0ZQMjNiWXFTZS80RTRoQy9sUnRwT0I3WUEya2N5VitmSTBW?=
 =?utf-8?B?SGl3VjdFaHozV3FRZ2d6Y3BrNytWM25CRVZ2VmM1TFZtUmFUWGZsbmUrdlh2?=
 =?utf-8?B?UjBqNE1sL1JQd2hBOFNrTktGZ0tEY1l6VS9QbzVCeDF6am9GV0dsTjBKelFX?=
 =?utf-8?B?b0NjSHQxK0IxNDBrcVU2eEwzZ244MHFndmhQNVBLNVZXNzk3SW1uMzZDRjVl?=
 =?utf-8?B?aFltdEgraU4wcXQrVmh5Q2Z5ZXZPeTVzL2dOZ2M5TW41UnFDNmhLeDR2WFV3?=
 =?utf-8?B?UEkzZE9FSS9mSHRObFBic3NEQXBSWUhFcjRUbUdkc3ZXRk9Jc2pWNHFKM0Ry?=
 =?utf-8?B?WncxMzgzMnJBeFNvMU5mYW9rd2pRejZQWU1qRWhqb0RQZFQxTllINFBxSDhP?=
 =?utf-8?B?L1ZZOGRYNmtNVWh4TkFxS0tXK3BxTlVMeG5uZFQrZTRPckdkMGFlMGlleXBt?=
 =?utf-8?B?bWpwUXgzL2lka0twUVBHN2VDUnVXSjZWV2QrTnRZRmxDQlgyZ0VQbmtCZ0t0?=
 =?utf-8?B?M2pkd25RRUtwUFhFOWxPdDV4aWkrYkFvZzVOdzZVZHZBeTQrTC9ZR1NYWGx1?=
 =?utf-8?B?L1VqWUxxVGdzN3JiZHFsNlFlUDNzTDlmSU9xN1RlSmdhSmJZemZ0NWRTckta?=
 =?utf-8?B?N1Nsb3hpRXFsNEVKQnF5NHlub3hDYlVIUVZ2ZzZSS2VVL1hiMWMrQXVXeG1G?=
 =?utf-8?B?SVJUR2FEWVFNME1oNjVoNzNLS2hGeE10T0dmNkFyY213ZUpZL2ZSMmg4aVQw?=
 =?utf-8?B?alBPNDBNN1lEN3Fqc1ZtOGlTcU1mb3RZQWJYaHIvT1ArdDY1b0U5Q0VXS2N2?=
 =?utf-8?B?Mk5Sd0Ziamh2V081Nkh4V1JDRDhicnNiZTJUbVBSY2JlNG1VN3hCTWp4aXRx?=
 =?utf-8?B?RmU1ZFcyQTVOTmswNys2amNla040TU5CNVdQRXdDZyt2Z0ptanVGMlpkeWhS?=
 =?utf-8?B?WDQ4anNqTXhlSEh6YVFySHBNWFF0dUlOazFZTm43NzJMNFZ0WmppellrcE5X?=
 =?utf-8?B?K1ZmeVJSKzJaalJidnc5SUNmWm9NVStQajk3amo1VkhDZmowY1RWYVVmc0ZJ?=
 =?utf-8?B?WE92dEQrMURkY3VsQXF4V2JkSU1tM1dBR0FjSEU0azYxU0lzUVA2TWRtdllD?=
 =?utf-8?B?cmNEeFF3N01oRjA5eUEvUlNQeS9jUFozVTRydDRlaW1pZUx3WTFmeEYreXpn?=
 =?utf-8?B?MGY2RUxDc204Uzg5SjEraUEyUDQ0SndFdStpQWQxVE9hUDZWQ09NaGQrSmpF?=
 =?utf-8?B?aFVIUUtFY1YzTTZERWRsWTh4Tk9PUnl6WG02eE45T3pLd1daa0U1aW0zd2Jk?=
 =?utf-8?B?cWFvSW9sVFJmS1Z2dW8vU3E3Yk40S09kK1dHTTBIWVVSY0pVUGgzNmR2Wk95?=
 =?utf-8?B?ZzNoczladWxSVThBeG1tTURoR2Rzb2VLZTYwMzVnNCtVcUlIYkhlVlg4Y1F5?=
 =?utf-8?Q?SrqgZbLREP5ls/xKXQMQWgBnPsuk+H251vDpVacWnj+C?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9af226-8cc3-42d6-fcac-08db2f8fe02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 13:25:19.0538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSe8txpj5tu6J4Q3Y8HzN7Be3KgdYShXK+IoHuNSQpmndkMCgmVkUmMEhyP3AzAKnIxPQLzBdWD84zU4Y0CRXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gV2l0aG91dCBrbm93aW5nIGFu
eXRoaW5nIGFib3V0IHRoZSBkaWZmaWN1bHR5IG9mIDMpLCB0aGF0IHNlZW1zIHRoZQ0KPiA+IG1v
c3QgYXR0cmFjdGl2ZSB0byBtZSBiZWNhdXNlIHdlIG5ldmVyIGhhdmUgdG8gd29ycnkgYWJvdXQg
Y2F0Y2hpbmcNCj4gPiBldmVyeSBEIHN0YXRlIHRyYW5zaXRpb24uDQo+IA0KPiBTdXJlIEJqcm9u
IHdlIGNhbWUgdXAgd2l0aCBiZWxvdyBzb2x1dGlvbiB3aXRob3V0IHdvcnJ5aW5nIG11Y2ggb24g
dmVyeSBEDQo+IHN0YXRlDQo+IHRyYW5zaXRpb24gYW5kIHdvcmtzIHBlcmZlY3RseSBmaW5lLg0K
PiANCj4gUENJOiBBZGQgcXVpcmsgdG8gY2xlYXIgQU1EIHN0cmFwXzE1QjggTk9fU09GVF9SRVNF
VCBkZXYgMiBmMA0KPiANCj4gVGhlIEFNRCBbMTAyMjoxNWI4XSBVU0IgY29udHJvbGxlciBsb3Nl
cyBzb21lIGludGVybmFsIGZ1bmN0aW9uYWwNCj4gTVNJLVggY29udGV4dCB3aGVuIHRyYW5zaXRp
b25pbmcgZnJvbSBEMCB0byBEM2hvdC4gQklPUyBub3JtYWxseQ0KPiB0cmFwcyBEMC0+RDNob3Qg
YW5kIEQzaG90LT5EMCB0cmFuc2l0aW9ucyBzbyBpdCBjYW4gc2F2ZSBhbmQgcmVzdG9yZQ0KPiB0
aGF0IGludGVybmFsIGNvbnRleHQsIGJ1dCBzb21lIGZpcm13YXJlIGluIHRoZSBmaWVsZCBsYWNr
cyBkdWUgdG8NCj4gQU1EXzE1QjhfUkNDX0RFVjJfRVBGMF9TVFJBUDIgTk9fU09GVF9SRVNFVCBi
aXQgaXMgc2V0Lg0KPiANCj4gSGVuY2UgYWRkIHF1aXJrIHRvIGNsZWFyIEFNRF8xNUI4X1JDQ19E
RVYyX0VQRjBfU1RSQVAyIE5PX1NPRlRfUkVTRVQNCj4gYml0IGJlZm9yZSBVU0IgY29udHJvbGxl
ciBpbml0aWFsaXphdGlvbiBkdXJpbmcgYm9vdC4NCj4gDQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kv
cXVpcmtzLmMgfCAxOSArKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTkg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3F1aXJrcy5jIGIv
ZHJpdmVycy9wY2kvcXVpcmtzLmMNCj4gaW5kZXggNDRjYWI4MTNiZjk1Li4wYzA4OGZhNThhZDcg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL3F1aXJrcy5jDQo+ICsrKyBiL2RyaXZlcnMvcGNp
L3F1aXJrcy5jDQo+IEBAIC0xMiw2ICsxMiw3IEBADQo+ICAgKiBmaWxlLCB3aGVyZSB0aGVpciBk
cml2ZXJzIGNhbiB1c2UgdGhlbS4NCj4gICAqLw0KPiANCj4gKyNpbmNsdWRlIDxhc20vYW1kX25i
Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC90
eXBlcy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiBAQCAtNjAyMywzICs2MDI0
LDIxIEBADQo+IERFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX0lOVEVMLCAw
eDlhMmQsIGRwY19sb2dfc2l6ZSk7DQo+ICBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZF
TkRPUl9JRF9JTlRFTCwgMHg5YTJmLCBkcGNfbG9nX3NpemUpOw0KPiAgREVDTEFSRV9QQ0lfRklY
VVBfSEVBREVSKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4OWEzMSwgZHBjX2xvZ19zaXplKTsNCj4g
ICNlbmRpZg0KPiArDQo+ICsjZGVmaW5lIEFNRF8xNUI4X1JDQ19ERVYyX0VQRjBfU1RSQVAyICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MTAxMzYwMDgNCj4gKyNkZWZpbmUNCj4g
QU1EXzE1QjhfUkNDX0RFVjJfRVBGMF9TVFJBUDJfTk9fU09GVF9SRVNFVF9ERVYyX0YwX01BU0sN
Cj4gMHgwMDAwMDA4MEwNCj4gKw0KPiArc3RhdGljIHZvaWQgcXVpcmtfY2xlYXJfc3RyYXBfbm9f
c29mdF9yZXNldF9kZXYyX2YwKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ICt7DQo+ICsJdTMyIGRh
dGE7DQo+ICsNCj4gKwlpZiAoIWFtZF9zbW5fcmVhZCgwICwgQU1EXzE1QjhfUkNDX0RFVjJfRVBG
MF9TVFJBUDIsICZkYXRhKSkgew0KPiArCQlkYXRhICY9DQo+IH5BTURfMTVCOF9SQ0NfREVWMl9F
UEYwX1NUUkFQMl9OT19TT0ZUX1JFU0VUX0RFVjJfRjBfTUFTSzsNCj4gKwkJaWYgKGFtZF9zbW5f
d3JpdGUoMCwgQU1EXzE1QjhfUkNDX0RFVjJfRVBGMF9TVFJBUDIsDQo+IGRhdGEpKQ0KPiArCQkJ
cGNpX2VycihkZXYsICJGYWlsZWQgdG8gd3JpdGUgZGF0YSAweCV4XG4iLCBkYXRhKTsNCj4gKwl9
IGVsc2Ugew0KPiArCQlwY2lfZXJyKGRldiwgIkZhaWxlZCB0byByZWFkIGRhdGEgMHgleFxuIiwg
ZGF0YSk7DQo+ICsJfQ0KPiArDQo+ICt9DQo+ICtERUNMQVJFX1BDSV9GSVhVUF9GSU5BTChQQ0lf
VkVORE9SX0lEX0FNRCwgMHgxNWI4LA0KPiBxdWlya19jbGVhcl9zdHJhcF9ub19zb2Z0X3Jlc2V0
X2RldjJfZjApOw0KPiANCj4gDQo+IA0KPiA+DQoNClRoYXQgcGF0Y2ggbG9va3MgZ29vZCB0byBt
ZS4gIEJqb3JuIG1heSB3YW50IHlvdSB0byBzZW5kIGFzIGEgZGVkaWNhdGVkIHBhdGNoDQpyYXRo
ZXIgYXQgZW5kIG9mIHRoaXMgdGhyZWFkLg0KDQpSZXZpZXdlZC1ieTogTWFyaW8gTGltb25jaWVs
bG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQpTdWdnZXN0IHRvIGFsc28gYWRkIGEgTGlu
azogdGFnIHRvIHRoZSBvcmlnaW5hbCByZXBvcnQuDQo=
