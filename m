Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE2F65EF23
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 15:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjAEOrG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 09:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjAEOqh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 09:46:37 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4DA41016;
        Thu,  5 Jan 2023 06:46:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOCCuFLWHGLqFUBaOtnIXt+6IfIAeIvwCwhFDWDpfwg+4pJDmtJsfJ+A+GU2Rwfh4paQ9PUYcobjmuvYuh+s9k1XYmCilL3Kw/lKY9JD+XERbOjtNm8smJJiDlVgfKuu/k8WHtecYfB7Y8ZUqcRFG7cicB93GnMrR/h1faMfqCFMDAzR/CkC0UIw/pn27Hrpf5Ta1wlSOJc0WYMBEHX4SXaZ1+6I/wWX3Pfb/pJDk4jiID3lYMCQQpsqfW3rP67DuJWyJuvtwQHWsqMrSHhmGf7aKZvkyy5f6w+bUPKpiXTMjRflsV7kd8CXp/dlW59prQpvRwL35UcQVHAUyIsH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf2ApM+kLEQRtvNbe5RLy65qXsRaN4siFAZZFETrc50=;
 b=Xv1tM4zVXApoZJH6GGj3zpEiL3G+Qvfgwjbqg8TJ0pAJ+vpJpShRnlST5zzBvgv0zdCMC+8QVrlKe2P8FFS7l1ak7Ge41MB5f6jXzJTxeveUHqsNV6OsHrRKsJabNN7SaLz3DSaoC0aCoru7rzL6naDU9AFl7rL+CAzUob3jZQ9i5UuNF/Ech0k/o76lOtCyKIKavngscewk71dpGB76vGlsosDHUOcVQjyDNK7MkaWGOhnjRdc5W3V+QMiAGEqSWJkdNVheX9HiZQ80PuTqtAiUDH+WpN8yi7OrPCIoMDOLZHbj6PaJr6a0Z+ps29Xe1acb1fkthhjdynKrF8Cegw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf2ApM+kLEQRtvNbe5RLy65qXsRaN4siFAZZFETrc50=;
 b=zzVwYSrnVsx+3AlhvrkvNd50bbzOwPmH3OUWitHCIBnVsR0JNXbOgKqsjx8hm47IwqsfV5YAucYKgOm+ezWoFx15vZI3KHEpW6qwbwrCZb1JxF60+gtyNGSavSphg3T5ZkU7cUng1nrG+FcdrqcFlN5bfCDx7SfYiCLb/X/B+XQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 14:46:32 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::35aa:857a:d89d:c06a]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::35aa:857a:d89d:c06a%9]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 14:46:32 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     "Hegde, Vasant" <Vasant.Hegde@amd.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Joerg Roedel <jroedel@suse.de>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: =?utf-8?B?UkU6IFtyZWdyZXNzaW9uLCBiaXNlY3RlZCwgcGNpL2lvbW11XSBCdWfCoDIx?=
 =?utf-8?B?Njg2NSAtIEJsYWNrIHNjcmVlbiB3aGVuIGFtZGdwdSBzdGFydGVkIGR1cmlu?=
 =?utf-8?Q?g_6.2-rc1_boot_with_AMD_IOMMU_enabled?=
Thread-Topic: =?utf-8?B?W3JlZ3Jlc3Npb24sIGJpc2VjdGVkLCBwY2kvaW9tbXVdIEJ1Z8KgMjE2ODY1?=
 =?utf-8?B?IC0gQmxhY2sgc2NyZWVuIHdoZW4gYW1kZ3B1IHN0YXJ0ZWQgZHVyaW5nIDYu?=
 =?utf-8?Q?2-rc1_boot_with_AMD_IOMMU_enabled?=
Thread-Index: AQHZIPL7+nD0Eiui/0C02pqzT7uy9q6P5gvQ
Date:   Thu, 5 Jan 2023 14:46:32 +0000
Message-ID: <BL1PR12MB51448996E36254ADC80B5BF6F7FA9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
 <6b5baa30-c218-0845-d6c2-32ac21ed6a6d@linux.intel.com>
 <86099ef0-5a8d-bd1e-4e38-a3b361a68f10@amd.com>
In-Reply-To: <86099ef0-5a8d-bd1e-4e38-a3b361a68f10@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-05T14:42:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=deb44ded-8f72-41d4-b594-34f6dbd699f6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-05T14:46:29Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4c814a34-6327-4ac1-bb7b-441efb94ba8d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ0PR12MB7066:EE_
x-ms-office365-filtering-correlation-id: 91efec33-bcf2-4a26-9374-08daef2ba2d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rM5tVqfGHdaceL29rnMKux3w9VnxCG0Cn7b8lmzl3Sk5NZBc/dBKiaOYhNKUPTH5mHW6eHQya6v3MDf9GokFIKvmnWdxRlloIXFlXcNB5pg+z+4yIWsf50g5FYgdrFCs98N3bLUOq800ALfHGktXy13uJmzufwPEQQH9AreA0xxzI1cMjj3bi14jIX+Qady8DnBRa9EyiHa+cxtzlwyQ0w9srNdZM+em65FPP3EVcK19gzT9u6EXpPSR5Ojy4Q95hjeA/MtIcuJwyDGbdH8VxAarV1bJ/IX/hPKoiGjNa92luiDFI+1IKqbONnkV8CT9z3G7Fz2dYmZOyUbZVhGi1JKxDhWwvpOgTAOcplgySv+Uzztn4qkd7E/EcL4j99MzND5wVwoaN7PKercQegmCC7noNk0QbuBkheK95DWVHTvbNdriX8rVzJbKlMl8N+d9jVKcknKqFn2pq2Q7lx0T+1Px5aq8JEiVvZ9jX3toiAFoE76KpkbFu2MjVE61shzJFqfIGtuwmBSE7owbEfdf1vVROAqPtaWUGBhGGUv/WoYEVCaQauPVERopQ9R2KlBV5C5QRvUuzxsZcLV5eBMDvM1MfZDay6FkMCBOFUwzu7dv1QhsspCi7UnI7mfq7OYEZgEpikrIt+5sfcHj+nHfciJIZrSzCGhxk4Rltiv4bO4bMSy2FdyquiLEBJXHMabvXuU+WBpVpqOx2D3jQA9UbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(38100700002)(33656002)(2906002)(5660300002)(8936002)(52536014)(41300700001)(83380400001)(122000001)(110136005)(6636002)(54906003)(71200400001)(66556008)(76116006)(66946007)(38070700005)(86362001)(7696005)(53546011)(66476007)(4326008)(6506007)(26005)(66446008)(64756008)(9686003)(478600001)(55016003)(316002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEZhMUlPaUVuODdpdnZlTURaT2FPZThxdHB6dTFIY1lOUmNaVCtBdG1BYWpp?=
 =?utf-8?B?ekpnZi9wcU9VaDRsazllaFBOQVY3QXZQUzVIdm82cU9iS0pqWnlNWmZ3U0xz?=
 =?utf-8?B?T0tuYXIvbHdob2FVY1k4ZlBEelhsRmdoSHZmZ2tjWll1MFE3UHB5OElzS3pj?=
 =?utf-8?B?bXVFTGlGMHR4ZlRlckdqbmZaa1RkckNyUHBYV296Y0UrY0JPR2U2eWYvYStk?=
 =?utf-8?B?MnlNRWkrNm9zQkIxaFN0SHdkL3NTQjB4SHk2aWRxak1pUGRBSGUwSDFQSVRB?=
 =?utf-8?B?M3ZieDNNQnVvNTVRSkFaSU5vTDJrZzJVZGt1TGhnOTFtcVpCUEZjVHo4bGNB?=
 =?utf-8?B?MjNEN2Fyb2hFTitKY0RmK1g1Y2MvOUhheVlLb2h4bm9haUdFeTJYMXVJUlhv?=
 =?utf-8?B?Z0NDUGdwVzlRb0dzcmh1MTF1eGpOcjFjTjB0UGlweThTU2NFYW55VmJQdHJZ?=
 =?utf-8?B?TUExRTE2bVA1dXFjajVlUmZCYTd4M0ZLc1ZxaFdtc3ZRUTR6Rkt5bWQ1bnlO?=
 =?utf-8?B?VmhYQldDMUxtaDl5YUpkWXlOQlFMM0xDWTVmT3lzSW5kaHhsaG52VnVudVRO?=
 =?utf-8?B?K2MwTFdCQjFEUFBkSjhlamZaOXQvbGxnMHdhVDFmMy94RjJaeTdwdlpUbisz?=
 =?utf-8?B?UkVBWVZxQzdyNzFvWE5wV05zTWMwOEhBdlRzV0VKUHRvWi91UlVIZzBvcFlH?=
 =?utf-8?B?VUlBNWc5YzVVdHl5M0FrMS9qZFl2eHhXbyt4UXpDbWRjWmtySWRaUnF0TWYw?=
 =?utf-8?B?MFBYWXEyYUVsOE9nVW8vZ0NjOEtiRlkvZkg5NUIvWFhMNmo0cGttb3Qwazlw?=
 =?utf-8?B?SVJRZ2dibHhLTzV2UG42SmRiL3JQZllYYUt5RUJoczZLN0NuTFphNVJDa29z?=
 =?utf-8?B?Q29TQ2xhRUxCVnpSdXBHS1AzNS9URm96djRlcjdYVGtRcFArMTFEZUhrY1pY?=
 =?utf-8?B?T1NvL2s2amF1amg5cXlYRWpEbUQxbVk5SkVzemlwRURqZkRBb0tlWFhCNEow?=
 =?utf-8?B?Mko4aFlFREtVeFRJMWFsYlRRdG1aZGxEU1EwN2lnZStTdTMyM3JvaFd5NEdW?=
 =?utf-8?B?N0FzZ1RUaUI4THVGUHJZK0lxR1VEZjNicG1ZWHRlWktYVFE1K2ZlQmFhTHJo?=
 =?utf-8?B?SFhrTllCaWVTZmhVWm1YK1dzMTEweFVJVlIrc0tnM3BqMlBxbmliellhWFhU?=
 =?utf-8?B?ZEkxbWhOUHk4TFptWTBYL0hCOGY1cVFpSk1FcHFKaUh5MXN5eldybkNVbEFX?=
 =?utf-8?B?SzBNak5GdnZxVVJSeURKYWtHV1UyV0VyK3dvOHJzWHc2NWQ5L1JLZ09PQnZm?=
 =?utf-8?B?UFhVR2N3bmpadVhHYmdlVTY3a1Z5bjN0bzdrZ3RhcWJlcEtJY1R5bnViVmxF?=
 =?utf-8?B?bFBSNXRVVEVTWTBtS2hBRGdHaXY5VHFlS0VaTldrWmhLaE9HTk1kNHlVL0Jv?=
 =?utf-8?B?SkhmakIxTU5qWExqdVVOc0ExUW9kQ1pLOG5Zd2dRNzBxR25WZElXYjlhRngr?=
 =?utf-8?B?TzhzUVpEcVEvMlpKZDB1eGpmTjM2ZThyY0RMSTV6YjVmZ1NRTUEzL0tZV1dM?=
 =?utf-8?B?b1FpMk9qak80YXlDUmdrMDRwS2xheTlRRkxiOUN4SkRUQjg2cXZiS09KV3hR?=
 =?utf-8?B?OU9BL0NJVElWL3VVZFZoOC9rS0RDdjNocXhsRG9YUVlGb0w5bjNGdzJpcE1I?=
 =?utf-8?B?dEhFVGJMTkRiR2tFOTUzcmpyQXZGKzhPeUZFdTZ3MUwrU3B4RjBaN203ZnVE?=
 =?utf-8?B?ZDdsZ09UejMyaW14T016SnVKeURrN1lUVjRDTzZRWlBsRjZkN3hrUzRiL1hR?=
 =?utf-8?B?ZXpjVkNwNzhDaEpMa1IvYmFuUnovRy83bEdWd0E1OTcvUnBKQnhTWktoMjJT?=
 =?utf-8?B?eG8ycjBVcGZNek5uQ05INEF3RWpTN1FoRzZLWXRyTFFhUVNBZDd2Q3krVHFL?=
 =?utf-8?B?cG5NOERhbXBDUG56UmxKelVlc1o1c052dDZ6YmdyY3lxblV0aEV6Z3M4NWFm?=
 =?utf-8?B?NEg5YXpsd2dtMldMN0g3Mkt1Qm51NzNhUVNnNHFLanU5VGtCcExBZ1B0cFZP?=
 =?utf-8?B?cDVkUVJKQUlETFJKSm10dnl0a0dNa3lZTVRkTXdmQUhLVHlQd1IwcnB0Ym9i?=
 =?utf-8?Q?f0wU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91efec33-bcf2-4a26-9374-08daef2ba2d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 14:46:32.0637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6hNYkDNb+e++d7i4WSqvZboSzbRZ/SslZYErJgVKXkkyh/jIO7da+F5Y8Ql4Ndy9Wwb0+RzxTAffLnhC5OOMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogSGVnZGUsIFZhc2FudCA8VmFzYW50LkhlZ2RlQGFtZC5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDUsIDIwMjMgNTo0NiBBTQ0KPiBUbzogQmFvbHUgTHUg
PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT47IE1hdHQgRmFnbmFuaQ0KPiA8bWF0dC5mYWduYW5p
QGJlbGwubmV0PjsgVGhvcnN0ZW4gTGVlbWh1aXMgPHJlZ3Jlc3Npb25zQGxlZW1odWlzLmluZm8+
Ow0KPiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBKb2Vy
ZyBSb2VkZWwNCj4gPGpyb2VkZWxAc3VzZS5kZT4NCj4gQ2M6IGlvbW11QGxpc3RzLmxpbnV4LmRl
djsgTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQo+IHJlZ3Jlc3Npb25zQGxp
c3RzLmxpbnV4LmRldjsgTGludXggUENJIDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnPjsgQmpv
cm4NCj4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtyZWdy
ZXNzaW9uLCBiaXNlY3RlZCwgcGNpL2lvbW11XSBCdWfCoDIxNjg2NSAtIEJsYWNrIHNjcmVlbg0K
PiB3aGVuIGFtZGdwdSBzdGFydGVkIGR1cmluZyA2LjItcmMxIGJvb3Qgd2l0aCBBTUQgSU9NTVUg
ZW5hYmxlZA0KPiANCj4gQmFvbHUsDQo+IA0KPiANCj4gT24gMS81LzIwMjMgNDowNyBQTSwgQmFv
bHUgTHUgd3JvdGU6DQo+ID4gT24gMjAyMy8xLzUgMTg6MjcsIFZhc2FudCBIZWdkZSB3cm90ZToN
Cj4gPj4gT24gMS81LzIwMjMgNjozOSBBTSwgTWF0dCBGYWduYW5pIHdyb3RlOg0KPiA+Pj4gSSBi
dWlsdCA2LjItcmMyIHdpdGggdGhlIHBhdGNoIGFwcGxpZWQuIFRoZSBzYW1lIGJsYWNrIHNjcmVl
bg0KPiA+Pj4gcHJvYmxlbSBoYXBwZW5lZCB3aXRoIDYuMi1yYzIgd2l0aCB0aGUgcGF0Y2guIEkg
dHJpZWQgdG8gdXNlIGVhcmx5DQo+ID4+PiBrZHVtcCB3aXRoIDYuMi1yYzIgd2l0aCB0aGUgcGF0
Y2ggdHdpY2UgYnkgcGFuaWNraW5nIHRoZSBrZXJuZWwgd2l0aA0KPiA+Pj4gc3lzcnErYWx0K2Mg
YWZ0ZXIgdGhlIGJsYWNrIHNjcmVlbiBoYXBwZW5lZC4gVGhlIHN5c3RlbSByZWJvb3RlZA0KPiA+
Pj4gYWZ0ZXIgYWJvdXQgMTAtMjAgc2Vjb25kcyBib3RoIHRpbWVzLCBidXQgbm8ga2R1bXAgYW5k
IGRtZXNnIGZpbGVzDQo+ID4+PiB3ZXJlIHNhdmVkIGluIC92YXIvY3Jhc2guIEknbSBhdHRhY2hp
bmcgdGhlIGxzcGNpIC12dnYgb3V0cHV0IGFzDQo+IHJlcXVlc3RlZC4NCj4gPj4+DQo+ID4+IFRo
YW5rcyBmb3IgdGVzdGluZy4gQXMgbWVudGlvbmVkIGVhcmxpZXIgSSB3YXMgbm90IGV4cGVjdGlu
ZyB0aGlzDQo+ID4+IHBhdGNoIHRvIGZpeCB0aGUgYmxhY2sgc2NyZWVuIGlzc3VlLiBJdCBzaG91
bGQgZml4IGtlcm5lbCB3YXJuaW5ncw0KPiA+PiBhbmQgSU9NTVUgcGFnZSBmYXVsdCByZWxhdGVk
IGNhbGwgdHJhY2VzLiBCeSBhbnkgY2hhbmNlIGRvIHlvdSBoYXZlIHRoZQ0KPiBrZXJuZWwgYm9v
dCBsb2dzPw0KPiA+Pg0KPiA+Pg0KPiA+PiBAQmFvbHUsDQo+ID4+IMKgwqAgTG9va2luZyBpbnRv
IGxzcGNpIG91dHB1dCwgaXQgZG9lc24ndCBsaXN0IEFDUyBmZWF0dXJlIGZvcg0KPiA+PiBHcmFw
aGljcyBjYXJkLiBTbyB3aXRoIHlvdXIgZml4IGl0IGRpZG4ndCBlbmFibGUgUEFTSUQgYW5kIGhl
bmNlIGl0IGZhaWxlZCB0bw0KPiBib290Lg0KPiA+DQo+ID4gU28gZG8geW91IG1pbmQgdGVsbGlu
ZyB3aHkgZG9lcyB0aGUgUEFTSUQgbmVlZCB0byBiZSBlbmFibGVkIGZvciB0aGUNCj4gPiBncmFw
aGljIGRldmljZT8gT3IgaW4gYW5vdGhlciB3b3JkLCB3aGF0IGRvZXMgdGhlIGdyYXBoaWMgZHJp
dmVyIHVzZQ0KPiA+IHRoZSBQQVNJRCBmb3I/DQo+IA0KPiBIb25lc3RseSBJIGRvbid0IGtub3cg
dGhlIGNvbXBsZXRlIGRldGFpbHMgb2YgaG93IFBBU0lEIHdvcmtzIHdpdGggZ3JhcGhpY3MNCj4g
Y2FyZC4gTWF5IGJlIEFsZXggb3IgSm9lcmcgY2FuIGV4cGxhaW4gaXQgYmV0dGVyLg0KDQorIEZl
bGl4DQoNClRoZSBHUFUgZHJpdmVyIHVzZXMgdGhlIHBhc2lkIGZvciBzaGFyZWQgdmlydHVhbCBt
ZW1vcnkgYmV0d2VlbiB0aGUgQ1BVIGFuZCBHUFUuICBJLmUuLCBzbyB0aGF0IHRoZSB1c2VyIGFw
cHMgY2FuIHVzZSB0aGUgc2FtZSB2aXJ0dWFsIGFkZHJlc3Mgc3BhY2Ugb24gdGhlIEdQVSBhbmQg
dGhlIENQVS4gIEl0IGFsc28gdXNlcyBwYXNpZCB0byB0YWtlIGFkdmFudGFnZSBvZiByZWNvdmVy
YWJsZSBkZXZpY2UgcGFnZSBmYXVsdHMgdXNpbmcgUFJTLg0KDQpBbGV4DQo=
