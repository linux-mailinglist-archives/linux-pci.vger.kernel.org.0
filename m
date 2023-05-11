Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98A6FFADD
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 21:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbjEKTv7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 15:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbjEKTv5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 15:51:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E92C121;
        Thu, 11 May 2023 12:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+FCE+23+5Bg9L+oUOLvw0NIF0MnNdf8rMDxD5QB881CMCIidg2suqaOFRxSmGRLPIoF5vgXp3d1YpYMFQK99YP2StQiHEZOqXnNvt9H+GhfunPvnHMIxBIWOEhSH6y3V1yNOh1pnimoK/x0fqkodOuUDLmfsihHimqWAoxKLSPui8TPcq7Xr2HHY0hbnGUWQrFMflOUdfcS9hKyJYJ6PeJgLPWQXr4ZpqdRV/1PHDEsHpGyPCbJLaQbP9j0s5eh8lVF+VP4W3vKAEAIgP2CSLSAIILzgBXfhBsPPjXUo+tF2lI8Vb811TSa0kyX5pL+cGkD2LQRyuGCm+E02uucYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmJoU5mCRjsbPwCqNXxBn8mbl9Ohxu0lk64geCAl/Bk=;
 b=ZoJYGbc0fpPZ4a7loj7UOu80prUZBWj58FbxCDmu2j7d1D/1gt8sF7PKJIzTss+G8rFXblbZ/OQUc8eBh8ZB5GqfIWP5rEzRTyp0JR9FoohQGNfYNNtkuHHvaHRXjCrgp8eRCGJ+8giC8cHoF5p6oNqLKr9UIwpRl5cl57gYOoMUKGFuSl5VknPd4N8yAGefo+qzOT7vJGcR3zMDY08jjan/wWNcQS+jLuAwzeYCwH6IYzrqIqCJDwLLDdtHBqzCaaJ6cL8oAmP/3qucCRbCqVz+vZDHuy7wpnh0VXgzb/tGM88IUpclhpY0aOot6RpgXWiXILFQK2e02QI5DahhWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmJoU5mCRjsbPwCqNXxBn8mbl9Ohxu0lk64geCAl/Bk=;
 b=g7T8N2BXjCAoActZbS7S+w6NZuBZBngAsXVmzWSy1Pye9IyG5G9+EG3E90Hxvr6VQzKepi6N+bj8NuxZ2SY2v1JjYLPSLcN0ACNvC/M9V8rjfwxM80FoNTVkgSsEF9E1qb9JWEO+0d+TbZ69J2SQcj/7xO1jQMjMSuusDxukoiE=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB9033.namprd12.prod.outlook.com (2603:10b6:930:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Thu, 11 May
 2023 19:51:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 19:51:43 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     Thorsten Leemhuis <linux@leemhuis.info>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Guenter Roeck <linux@roeck-us.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
Thread-Topic: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
Thread-Index: AQHZeMne9ZdOCI5VAUibEWjErYT7K69NVfeAgAF9zwCAAXbQAIAAA3yAgAAiLoCAAASGAIAFG9Cw
Date:   Thu, 11 May 2023 19:51:42 +0000
Message-ID: <MN0PR12MB610132F2277B0F1DB1039A15E2749@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230427053338.16653-1-mario.limonciello@amd.com>
 <20230427053338.16653-2-mario.limonciello@amd.com>
 <7b74c389-97b7-4f56-851b-6ce17950a4d1@roeck-us.net>
 <f2b81356-e702-3026-660f-d9a88edff632@amd.com>
 <084837c4-72c8-be92-fd1c-5ccbd805c559@leemhuis.info>
 <20230508112543.GBZFjcN2oxk4do31w4@fat_crate.local>
 <a8b29619-f1da-4cb9-a5bd-a396b52e159f@roeck-us.net>
 <20230508134414.GCZFj8rieNwF1AOerB@fat_crate.local>
In-Reply-To: <20230508134414.GCZFj8rieNwF1AOerB@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4965e65a-9d14-40c0-94f0-db36db7b4a32;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-11T19:45:04Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CY8PR12MB9033:EE_
x-ms-office365-filtering-correlation-id: 76799601-22e7-4e42-a57a-08db52592507
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KnSdeEB+0ZhMA7Gcz4rMC7SdZpGnssLG4zadCazVd/h3cLEHQJdAuS6kc2mnxcA5PDxXh9bP/b25rolTg2BRsKDWvQgc8C/BfSIJ0OCfmtqyufkCcqEjrALkgBE269Ag3pWYR35VfwOYd/FNPd6TeenpNk5w2Pun98aroczXWHa0C3m8iX7cpZUT978Ns4Q6uGNonw6Zaoz4Pk/2OF1qlYAazke7Md4dr7MpjavSdux0MWkx2H1hGriA/axfurjB//FSfXEpDma0xyamuoL8bV994SlbVcIUUMvGU+PD4kj4qi5YOE9Ly/6Ymcz+UpXgT+nPkUrnqlEfjUSZSRUbjR59hJqwqrasOcxaaq5/Wjk8xQgAqXsXYRh7PcXZFU6F7aMvCnzHCZe3zUWuD8XDVAFmNGXzgnIsn+B7j5wbmSfiLcvcBTWs40yczp28h1dbfPBrGLC1HvmRL61qmw+9/OqZBpgr6qdgAPmIWM9td2UcyNIp7IWHX98BipGPBksI+aaiNic37Ca9Zlf66oHBzyftHvtHg79sNCFGH2AmaFUMasizcWQT2ft+r0TOwbKAFunzTQ1nfwmyjvQIRtGaLtOBO6L2iyEkVU43ryruQcs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199021)(4744005)(83380400001)(54906003)(52536014)(7416002)(5660300002)(2906002)(66446008)(122000001)(6916009)(66476007)(64756008)(66556008)(316002)(76116006)(41300700001)(4326008)(66946007)(7696005)(86362001)(966005)(38100700002)(6506007)(33656002)(8676002)(26005)(8936002)(9686003)(71200400001)(186003)(55016003)(38070700005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1N6eVBwelVKSTlWN0tqeE83OUwvc0VzdUVzYVlqZjgyNDQ5VS8vejBqbEF1?=
 =?utf-8?B?MGtYL2Q4eTNVWHRSWWc5bmJzZXpHaW9hNGlPcHdoT2t3U01IQ2czYWVUSUZQ?=
 =?utf-8?B?d1k2YWVpMmlLdTJIOS9RRzFjSXBXL1hodEErUXU4dlFFYTA3bzNnVnRDY3dt?=
 =?utf-8?B?eGJWVVlHNEV2Q1dIbS90Ry9BZUxPSzUrLy9XclhSS0gwenFCS2JBK2lKRUh5?=
 =?utf-8?B?ZnN5MG5xem84WUVab2h3WitINlVId2RZS3hUWDVueFp4YUl6azZGTVdRb3hZ?=
 =?utf-8?B?VzNTa0xuakg4cjRBT2lKQXF0NTJxWFV3dmlrYU1SQTJERFJFNXhjRFYrS1Z1?=
 =?utf-8?B?c1VKZUlpZTcxVEFTb1lWT1pmd095WXMxbFRUcmFiVHdwVkt6b3Vjd1pIU0JR?=
 =?utf-8?B?cDNuYXRVUTl4ai8wWXhZWWZUQzNhMjBHS3lJOGo0V29Pd1VoR3pGNktsQmJW?=
 =?utf-8?B?eDV4ZmhMdzNUNnlXbVV5SzgxR1Q2RDNhWWt4RlJVRXYxN0ljNGNLaXpOV3Js?=
 =?utf-8?B?VTJwWWdRdnlvdzFaT1daWDNoRGJoMlRSZ1VwZEcyeGkreHBUN2thYjFlelBz?=
 =?utf-8?B?WFVSRk95a0V2ekNnWGNvK2psZ0loUzJGY3V6Q09FWWtZTXNHc2lBaG9hM1BM?=
 =?utf-8?B?aDNXQlp4UVI2TmdEMGVESVRxenNXZDNiWnl2L2IxcjBLL25ZV2JtVXJZUTVD?=
 =?utf-8?B?eDZuclVmTFFSVmRNMk5NaElldHcrbmU4U1FpUEtyT2JUWFVCRkZtOTlMU1V3?=
 =?utf-8?B?K1hKdHhPanBLM09PSU5zeU1ZaUdaTFNJWXdIL1AyTTBXdEdqTkhCcDY2SzFQ?=
 =?utf-8?B?eDlyOXlVT0xiUUNwS1hZUUhmamJNeDRnVWpDNUxSVEtFb0F2eG8wUXhtcm9D?=
 =?utf-8?B?dktDaCsyOEgrdFNXbGNRR284MFNLR2JwVDBDSkpKY091NTJ2U0haTzRnTk94?=
 =?utf-8?B?anZnODN0TGxmRDFUWnN3c3BzSVZNSUJiVFZER2NkYTVnYU8wZkFjbkttU3A5?=
 =?utf-8?B?bi83cGNURElPRU5VbHNZeHN2aXkvbnFiMll4bGhRSHBXMEdDblJhOXViWEFi?=
 =?utf-8?B?T2lOQkZDQ2RQU0JlU1hSNVUrZm1iSE1TSjk5eVZtV2RRT2ZpejNUd1hqemtI?=
 =?utf-8?B?UmJCR0QwVTdSZGNGOCtXckNzQzZOTzJVcHlFb09SbVppZ2UvRXE3VUFkNlZH?=
 =?utf-8?B?cnRGVTJlRWxEY1A2UjMwK1FFbzIxWUQvalErUlNQYnFzRVJsQlhmVWNCTEZR?=
 =?utf-8?B?dXIwa3lRYnZ0L1cyTWdjWkREMlBJVlVtZy9ySTVQQ09sRG5WMEo0UW0rNm9z?=
 =?utf-8?B?RDU3US9xOWh3dDEyUXpIa2tyNmNFMkVjK1lSOGUwYUlnKy91eVBkVmVNc2tw?=
 =?utf-8?B?ZDNQSlJhdGtNOEowZlh0WkJzS3lPcVVYUE5JeHhHWFJoZnJ1WVV1eEVSUnVy?=
 =?utf-8?B?V1oyUzdjcWVtWk1uSzFoUkxEeEc2TXluODFoaXRmck4xKzZEczZRRCtuYU9O?=
 =?utf-8?B?NUx5cVV2UXVmV3J2U0c1TVFyL01INXJhV0QyWjhBUFU5VjdJUW1BcmJjMVZ1?=
 =?utf-8?B?Q0ZmQTNQMURldG5wdENzSkYzR1dXN2YzQXR6elUvV1pWaitvOEk0Q3NqZFE2?=
 =?utf-8?B?RUd6Sy9taGIwbnk3U0U3bzFNZlY4SFJXbEhPWkV5RU5RUHIyTVNhOEQ4QzFY?=
 =?utf-8?B?dDdiVXpWTnJ5QUJSSHFkeWNIdUt5UDFvYnhkOTRPZnM0Y2lmeDBBbVBTam9i?=
 =?utf-8?B?UDVCWVlsbHJQMFBNbStENXdkYjVJTlg5N3hJNGNZbXRoSDJnOFEzTGIxbUJY?=
 =?utf-8?B?VUowSHVLVVZCdW1hZHpsajlnN1RmLzI0OEpqQ3o5dkpoemtuMnlMUDgvMjEr?=
 =?utf-8?B?SFdvM3NUZmlGRWd3d1pVYjZseG1oRnY2WWlnM1g2U1lSMzV2QkJ5ZS9saXZh?=
 =?utf-8?B?clVGWnNtdldyME5hVTdmQTVpVDB3UnRkSjVTaVlWRTZDNDJxSWdBKzl0RUZC?=
 =?utf-8?B?VUoxN2tJNWp3YW9Nd0s1YjhkTkJ5OGg2OXhpQ1ZLYjVGdzF6NXJwcGQram9y?=
 =?utf-8?B?S3VMdHVUdkNBSWVyNVB4cFh1RGh4dENYODZRcHdDRXBHZHd4RGNQWjFSR2ZM?=
 =?utf-8?Q?XAec=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76799601-22e7-4e42-a57a-08db52592507
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 19:51:42.9611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXQMS+b5c0u0VwrNtCRI4PVU/O3n/NxDQkN8mRFRJf9OBxluLxcDRzd5GugRYruEhkYBW2QbK8/CUtVUNMd9YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9033
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCitzdGFibGUsIFNhc2hhDQoNCj4g
PiBUb2dldGhlciB3aXRoIHRoaXMgcGF0Y2ggdGhlcmUgYXJlIG5vdyBhdCBsZWFzdCB0d28gcmVn
cmVzc2lvbnMgaWYNCj4gPiAtcmMxIHdoY2ggY291bGQgaGF2ZSBiZWVuIGF2b2lkZWQgYW5kIG1h
eSBpbXBhY3QgdGVzdGFiaWxpdHkgb24NCj4gPiBhZmZlY3RlZCBzeXN0ZW1zLg0KPg0KPiBBcmUg
eW91IHNheWluZyB0aGF0IHRoaXMgcGF0Y2ggd2hpY2ggZml4ZXMgczJpZGxlIG9uIHNvbWUgcmFu
ZG9tIGJveA0KPiBzaG91bGQndmUgZ29uZSB0byBMaW51cyAqaW1tZWRpYXRlbHkqPw0KPg0KPiBB
bmQgcmVhZCBteSBtYWlsIGFnYWluOg0KPg0KPiAiU29tZSBmaXhlcyBuZWVkIGxvbmdlciB0ZXN0
aW5nIGJlY2F1c2UgdGhlcmUgaGF2ZSBiZWVuIGNhc2VzIHdoZXJlDQo+IGEgZml4IGJyZWFrcyBz
b21ldGhpbmcgZWxzZS4iDQo+DQo+IFNvIHllcywgSSBkaXNhZ3JlZSB3aXRoIHJ1c2hpbmcgZml4
ZXMgaW1tZWRpYXRlbHkuIElmIHRoZXkncmUgb2J2aW91cw0KPiAtIHdoYXRldmVyIHRoYXQgbWVh
bnMgLSB0aGVuIHN1cmUgYnV0IG5vdCBhbGwgb2YgdGhlbSBhcmUgc3VjaC4NCj4NCj4gLS0NCg0K
VW5mb3J0dW5hdGVseSwgaXQgbG9va3MgbGlrZSB0aGUgYnJva2VuIGNvbW1pdCBnb3QgYmFja3Bv
cnRlZCBpbnRvIDYuMS4yOCwNCmJ1dCB0aGUgZml4IHN0aWxsIGlzbid0IGluIExpbnVzJyB0cmVl
Lg0KDQpTYXNoYSwNCg0KQ2FuIHlvdSBwbGVhc2UgcGljayB1cA0KaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQvY29tbWl0Lz9oPXg4Ni91
cmdlbnQmaWQ9MjNhNWI4YmIwMjJjMWUwNzFjYTkxYjFhOWMxMGYwYWQ2YTA5NjZlOQ0KZm9yIDYu
MS4yOSB0byBmaXggdGhlIHJlZ3Jlc3Npb24/DQoNClRoYW5rcywNCg==
