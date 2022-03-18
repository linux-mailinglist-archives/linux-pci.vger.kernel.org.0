Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062094DD8F6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 12:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiCRLb4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 07:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiCRLbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 07:31:55 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2041.outbound.protection.outlook.com [40.107.102.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72B81ED070;
        Fri, 18 Mar 2022 04:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDef0HFWNumR/lkKsKjixSLg4rYj4K3+zXXt7O7m1kCBdRf49JpcOeV/BccFYJe4VUs9FjjAv7AxrF1GSEbWx1omtUREL08BI4qzkiHTss0N8ooNkF/6jdDXmMzIRqKNiNsnSIAYHSpTq+3TUalbIfTXeY22SG17jIDYibvpfYOg/o5cklxBOzoR10T8mJVruOpTOFy18st7/PVI73346MYktYqxMCdTFK+JryeJ6tciJFhSklvnSTwgCJcfV46fVCWanflPZihwPj3AB5Lgw6ZwkLT/rNcMUXA617l7T74NvpKdu2Dq2ViJ/6Id+XksyV/nksho88XaoeyH1pzCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Dl/qJ00AevrnaZik0Saf28O9ii5XTlLY6KoRUm90qA=;
 b=G4RPJJ03QRGmZFxH8uKrf6MupaQvbGkN/HHjkukGn6hav7zAA0rMUeZ8mU5ELJDAcMn2/XkHviImIIswHwtHHvDbt/U8U7DCcu/Wrft4MukT/58RIRH5XSfcO5tiH4813KYbD4VooNTakzaUsb3iIaqQIgUoKKYs6abDMtTA+RUEbeMMBWEeHCWYhD4n9CyNTBCO935OQ4kqayXUXJNreVkb+ERFBuCxom6DEaSDN1oCEqctmCItbWLbFudOptg4YWrxOPFhrvHZS3QiBiJHWiwUE1xR3R3tUTtbdU2Ay6CSev9ChyRT7mtBkA3hxCe1SjKz/3WMiOJlgdX+Z/Zo+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Dl/qJ00AevrnaZik0Saf28O9ii5XTlLY6KoRUm90qA=;
 b=u5HtLFp4pMsKt8pqAJuzv2Ly3MyeRPDIed/uw4CRDVU4jpwne4eM8WseLArma6aQzkGD/CpPnst2IbiXb0JAvqXUQorA2ivyRqgh5X42ejzuW29jpBzmeRDgcz1D9OF1BtCg5RKNLePkSdaqcmbKWLZDxR1x50FmbleC9qJXbqM=
Received: from DM6PR12MB4649.namprd12.prod.outlook.com (2603:10b6:5:1d1::32)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 11:30:31 +0000
Received: from DM6PR12MB4649.namprd12.prod.outlook.com
 ([fe80::3561:7423:a392:4dc9]) by DM6PR12MB4649.namprd12.prod.outlook.com
 ([fe80::3561:7423:a392:4dc9%4]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 11:30:31 +0000
From:   "Huang, Patrick" <Patrick.Huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: Disable LTR on suspend for SSSTC 0x9100
Thread-Topic: [PATCH v2] PCI: Disable LTR on suspend for SSSTC 0x9100
Thread-Index: AQHYOnHv/VQzQqwNeE+h2g3jCJub/6zFAWAg
Date:   Fri, 18 Mar 2022 11:30:31 +0000
Message-ID: <DM6PR12MB4649C94064FA22BFF9D12332F0139@DM6PR12MB4649.namprd12.prod.outlook.com>
References: <20220317131008.6395-1-mario.limonciello@amd.com>
 <f2c9ea68-17d2-f58e-25af-e98a56bb96a2@amd.com>
In-Reply-To: <f2c9ea68-17d2-f58e-25af-e98a56bb96a2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-18T11:30:28Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=04f008b8-9b19-4183-a342-042739d1fabd;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 081cffce-2fe9-4cbf-8b33-08da08d2b5ce
x-ms-traffictypediagnostic: MN2PR12MB4407:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4407C7D3F3039278648B4F7EF0139@MN2PR12MB4407.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ywPMcGyeZcsPwIrLLzD7qFqoiNbI7oS62pp405Y2zFvLX7HdHNkSqf4+K1aWeDF1Sg9vI5D5Hjsa9NBGYU5kFVNtXkSf05sm3678vYHU3op7zfcyPmRCMdK+iLJBQj88NGNwPPHo/1+Mj/8oKvTpYzS6NeATpF8rwy2ZldHeugE4fqn9SwqjBMP3TzbBd0JatlbwUbKgO+ozCbmpAa1BbwSj868HWviHKzujEYzgzldFpaVEQILS3HQsn+TLxidfXzh8LRlki8StrP+jh6DGNM4VBfAflERo+PiwlK/NWtChlyjhxRNO6ZkLlwHf+cZ+ARCdIien+lxM6g/khYckycHBuBGM5H29exgIKygqgNbbmX8cnP92SO9l93r+WtzM2+h+JXbl6CbciLKwJ+hL46nKWg0PfxROH7214EloplQ+SISeLLDJ3f99+a1L5kxnEpgDBy/lV7d0pZJMXPzCidy9U4JYSS82mw+ouQE85T3Pb1xLfAuDWUNV4qsf3Tqw4ENNkURnQQjdWPX0elEGHo79ssFoaYRhr3OtN7ITi/w9VLI/CwPB9PUheceRBeLrKbmQGRBuz5/Z2yZkIeDHmYYZ+mI+lLILIAQfzy/5TU1pgudsTwW2B2t3tlq4PKxNNeUyitXl6HRYtCKjoqmqj6bs+3lAgqPJaNgvv/mfhgo9vFgi2LSW5tZ+j7lwaAzRr+z/P6/7lcuKMP0ogjvu+ecx0Wt1t4ksahueLkO7LDsbnitykSz36En4NLvNDB6fhhmPCCJ09Og/QHtxPGNpYObgu9028OYu64Pkzcg77Ew=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4649.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(122000001)(38070700005)(83380400001)(966005)(33656002)(55016003)(9686003)(508600001)(15650500001)(71200400001)(2906002)(76116006)(64756008)(86362001)(8676002)(26005)(66446008)(66556008)(66946007)(66476007)(5660300002)(186003)(110136005)(38100700002)(7696005)(6506007)(8936002)(52536014)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG1kTWR0Y1pUZHRNa2dRdWFGSWlFbTdyWkdGNzBHMjR2bHZIb2RTUEtMYnA0?=
 =?utf-8?B?bXQ2YVl3K3pHUmJGclJEbmZHYTRFTCtpaTBHcWt3eFFiME55clZzc0lnZW9K?=
 =?utf-8?B?YUlMRnh1QVVEdENkZUN4MjYyVnpqMDJJeThKUno0MWw0S2dDekFKTXlweTJK?=
 =?utf-8?B?ekttZkRmbGNERUlCYWxYNGtUMjZpR2VWV0QxelM2YlFPVW54U1lDelhvNWR1?=
 =?utf-8?B?YUhUYXNzblFVTUxwTDJ1cUd2VHlTVVJtaUhhQlUrNkMwSkM1ZklnZmlRN1VS?=
 =?utf-8?B?L3ErenllZzlVQS8yV0d2YlV5MXVNeit6Wk0vb3JlVTFYWGhhVzJidTVmWGVa?=
 =?utf-8?B?bnFpTnpuN29sYUJqbTlNR3NjdkRlNVJ1djJuY1plR0lzb2NkMFBrTy9iN3ZI?=
 =?utf-8?B?L3k5VEsyeXltMzhzbnhkY1F3bjVtcWhjTHFLQW94VlczSjlNdnZKS1RxRC8w?=
 =?utf-8?B?MnZRdzhSdVlTaXFhUndDWS9Qb0JaWXMzSmpwaU5RT1ZSdTBaM3dIVm1oNWNB?=
 =?utf-8?B?azZWdXJiOVZDRjNVVXFJd2JXTG9pTjRiVTJucm1pMzBkVkVsQisySUxDMGxr?=
 =?utf-8?B?K3M2SzA0TVptbGpHSy9qUnNyNldHeERrSEY4S0Urdi9sSWkzQUF3UUtVbnVm?=
 =?utf-8?B?QnlVNmc4NmhXM0YwWXRVYkhtbyt6QWhLOUhyVklSSXZtQ1NzN0czUVdTajI0?=
 =?utf-8?B?OFlzT3Z3Q0FKZkZuV2lRTkR3MUlUWEttOHdPVU5KUTNjRzNuOEg2N1lFYnY2?=
 =?utf-8?B?enp6THNRb1E1cnVDM1hwWUt5dkxCeVdrdEovc0NkQmF5ZXRBLzhYOC9HRm5y?=
 =?utf-8?B?dUFzVkJvbC9JL3ZyVUROVXBjUGRSTWtMeEVDUzB1S2lyZi9aQmx1WFZOK0dl?=
 =?utf-8?B?c0FmTjZONVNJdVY2eTQwK0ZFRklEbG1pMXYxQUdnOUJLQTN6NGREaXpab1VZ?=
 =?utf-8?B?VWt4SHJGTWRhdjBXazBYSlcyTDBIeTRSQVBkd292VThpVUxiVUd4VHBmUWZi?=
 =?utf-8?B?dkJkSU5lNVJ6YnJVRWxOK240ZHhoSnpKNmV3TEs0cEFSbWUvcHZPNHJvWms5?=
 =?utf-8?B?Z1RwR2NOd0FmdEdzcEpib08yMUNtNVFkWTFmZ0F4Y1JZRzhvVWp3ZjRmQWJ0?=
 =?utf-8?B?Tk5lSEZPQWdKQkUrVWdNVWtYbjVlYUhUMlJIVjAzZTdTTkNYN1lqYThjVGZX?=
 =?utf-8?B?UE5LQUFiVlpDQjZGTVdzKzVGY1JBYTVLL1FyYkxnY21VT2xQRFRQMnZLeERG?=
 =?utf-8?B?WVRCVnhUOFo3WUhYbitpenpkYnpQNGhnbTJvNE9ybzhOQ2FVd1NwTVFCdVp1?=
 =?utf-8?B?M3BiM3FzYXI1Q0t6a0FPSXgvZzQ0S05hVkpYWHFpVTdGUEVSSTA0S3VtWEI4?=
 =?utf-8?B?VlVJTDBxODJOWjhHaWpKQ0dYZkJubzlhSFhrYXJEaVU5QkpRc0QrVXBEbm9O?=
 =?utf-8?B?Z0l3ckd6ejYyTE12NlZWOEQvR2RlS04rUW1DbnBKZDZHdURFZEt4eEJQNTRM?=
 =?utf-8?B?R1Y2ZEhZbHVpWVpxNE5GSUxMdXg4MWR2RHVjbFNiRE5GZVNEZ1hNWjVBaGhI?=
 =?utf-8?B?NCtPS0lEQ3BjMmpQS2d2bWhmRzQ3TTlpWDR0SnFIZUo5NFRhZGcxUEorRTRx?=
 =?utf-8?B?TWtSZkhNb0k0Z3M2dlBiMnIrYjlPWXFHTUZsNWEzUWpMSVpSTkNnd2ZiZDBP?=
 =?utf-8?B?azdwcWFqRkQwK2lBVGdzM0hBMFcyYm5IU2U1aW9uMzUxZ0N3bXlsdlBFeUhV?=
 =?utf-8?B?d1N5S29RNklNRnBSZnhpdmprSURmOHpPQkVRTGdZeStmUFd3NHlGYjJubTRq?=
 =?utf-8?B?eERGM0pkcFpmeUswTnNqRitSa2lxTkRHT09BdGJLRjB6ZkVSYUU4MThIdEYz?=
 =?utf-8?B?T3pmMTlvYnNoMUMxa0k3N3B2alFOUEt6V21MVUZldkFnN2pMc3lyYlcyblpr?=
 =?utf-8?Q?iK+szERPr83V7bHKKayM2IukHu8KO3V5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4649.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081cffce-2fe9-4cbf-8b33-08da08d2b5ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 11:30:31.1463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/+gAoCVLcLur3Cic17JHsIAQKVntUuTnvWkRHgpX6Tj8jovkZJSZwM59YzYIrLbxFw/C2AKWI3XoCznoiHNoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgYWxsLA0KQWZ0ZXIgcmV0cnlpbmcgc3VzcGVu
ZCB3aXRoIHRoaXMgcGF0Y2gsIGdldCBzdXNwZW5kIHRlc3Qgc3VjY2Vzc2Z1bGx5IGFuZCBydW4g
b3ZlciAxODAwIGN5Y2xlcw0KSSB0aGluayB0aGF0IGlzIHRlc3QgZW52aXJvbm1lbnQgZXJyb3Ig
YmVmb3JlLg0KVGhhbmtzDQoNCkJlc3QgUmVnYXJkLA0KUGF0cmljaw0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9A
YW1kLmNvbT4gDQpTZW50OiBGcmlkYXksIE1hcmNoIDE4LCAyMDIyIDEwOjQzIEFNDQpUbzogQmpv
cm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IG9wZW4gbGlzdDpQQ0kgU1VCU1lTVEVN
IDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnPjsgb3BlbiBsaXN0IDxsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnPjsgSHVhbmcsIFBhdHJpY2sgPFBhdHJpY2suSHVhbmdAYW1kLmNvbT4NClN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIFBDSTogRGlzYWJsZSBMVFIgb24gc3VzcGVuZCBmb3IgU1NT
VEMgMHg5MTAwDQoNCitQYXRyaWNrIEh1YW5nDQoNCk9uIDMvMTcvMjIgMDg6MTAsIE1hcmlvIExp
bW9uY2llbGxvIHdyb3RlOg0KPiBTb21lIGRyaXZlcyBmcm9tIFNTU1RDIGFyZSBzaG93aW5nIHN0
YWJpbGl0eSBwcm9ibGVtcyBhZnRlciBzMGkzIGVudHJ5IA0KPiB3aGVuIHRoZSBMaW51eCBrZXJu
ZWwgaXMgaW4gczJpZGxlIGxvb3AgaWYgTFRSIGhhcyBiZWVuIGVuYWJsZWQuIFRoaXMgDQo+IGxl
YWRzIHRvIGZhaWx1cmVzIHRvIHJlc3VtZS4NCj4gDQo+IFRoaXMgYXBwZWFycyB0byBiZSBhIGZp
cm13YXJlIGlzc3VlIHNwZWNpZmljIHRvIFNTU1RDIFNTRHMsIHNvIHF1aXJrIA0KPiB0aGVtIHRv
IGF2b2lkIExUUiBiZWluZyBlbmFibGVkIGR1cmluZyB0aGUgc3VzcGVuZCBwcm9jZXNzLg0KPiAN
Cj4gTGluazogDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52bWUvMjAyMjAzMTUw
NzIyMzMuR0EyMjg4QGxzdC5kZS9ULyNtYjkNCj4gYjU3ODIyMjBhMzJlMmM2OWZlMzdjZjA0YWUx
NTAxYjBmNDgyMjENCj4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxp
bW9uY2llbGxvQGFtZC5jb20+DQo+IC0tLQ0KPiBjaGFuZ2VzIGZyb20gdjEtPnYyOg0KPiAgICog
TW92ZSBpbnRvIGEgUENJIHF1aXJrLCBoYW5kbGUgZW50aXJlbHkgaW4gUENJIHN1YnN5c3RlbQ0K
PiANCg0KUGF0cmljayBoYXMgYmVlbiBydW5uaW5nIHN0cmVzcyB0ZXN0cyB3aXRoIHRoaXMgcGF0
Y2ggYW5kIHJlcG9ydGVkIGEgZmFpbHVyZS4gIFdoZW4gaXQncyBmaWd1cmVkIG91dCB3ZSB3aWxs
IHJlLXN1Ym1pdCBWMy4NCg0KSWYgYW55IGNvbmNlcm5zIHRvIHRoaXMgYXBwcm9hY2ggaW4gVjIg
dGhvdWdoLCBjb21tZW50cyBzdGlsbCB3ZWxjb21lLg0KDQpUaGFua3MsDQoNCj4gICBkcml2ZXJz
L3BjaS9xdWlya3MuYyAgICB8IDE3ICsrKysrKysrKysrKysrKysrDQo+ICAgaW5jbHVkZS9saW51
eC9wY2lfaWRzLmggfCAgMiArKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3F1aXJrcy5jIGIvZHJpdmVycy9wY2kv
cXVpcmtzLmMgaW5kZXggDQo+IGQyZGQ2YTZjZGE2MC4uMDA1MTQyZDU3NGU3IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3BjaS9xdWlya3MuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9xdWlya3MuYw0K
PiBAQCAtNTg3OSwzICs1ODc5LDIwIEBAIERFQ0xBUkVfUENJX0ZJWFVQX0VBUkxZKFBDSV9WRU5E
T1JfSURfSU5URUwsIDB4MTUzMywgcm9tX2Jhcl9vdmVybGFwX2RlZmVjdCk7DQo+ICAgREVDTEFS
RV9QQ0lfRklYVVBfRUFSTFkoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgxNTM2LCByb21fYmFyX292
ZXJsYXBfZGVmZWN0KTsNCj4gICBERUNMQVJFX1BDSV9GSVhVUF9FQVJMWShQQ0lfVkVORE9SX0lE
X0lOVEVMLCAweDE1MzcsIHJvbV9iYXJfb3ZlcmxhcF9kZWZlY3QpOw0KPiAgIERFQ0xBUkVfUENJ
X0ZJWFVQX0VBUkxZKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MTUzOCwgDQo+IHJvbV9iYXJfb3Zl
cmxhcF9kZWZlY3QpOw0KPiArDQo+ICsvKg0KPiArICogU1NTVEMgZmlybXdhcmUgd2lsbCBjb250
aW51ZSB0byBzZW5kIExUUiByZXF1ZXN0cyBhZnRlciBkZXZpY2UgaGFzIA0KPiArZW50ZXJlZCBE
Mw0KPiArICoNCj4gKyAqIFRoaXMgYmVoYXZpb3IgY2F1c2VzIHByb2JsZW1zIHdoZW4gZW50ZXJp
bmcvZXhpdCBzMmlkbGUsIHNvIGF2b2lkIA0KPiArbGV0dGluZyBMVFINCj4gKyAqIGJlIGVuYWJs
ZWQgZHVyaW5nIHN1c3BlbmQuDQo+ICsgKi8NCj4gK3N0YXRpYyB2b2lkIHNzc3RjX2Rpc2FibGVf
bHRyKHN0cnVjdCBwY2lfZGV2ICpwZGV2KSB7DQo+ICsJcGNpZV9jYXBhYmlsaXR5X2NsZWFyX3dv
cmQocGRldiwgUENJX0VYUF9ERVZDVEwyLCANCj4gK1BDSV9FWFBfREVWQ1RMMl9MVFJfRU4pOyB9
IHN0YXRpYyB2b2lkIHNzc3RjX2VuYWJsZV9sdHIoc3RydWN0IA0KPiArcGNpX2RldiAqcGRldikg
ew0KPiArCXBjaWVfY2FwYWJpbGl0eV9zZXRfd29yZChwZGV2LCBQQ0lfRVhQX0RFVkNUTDIsIA0K
PiArUENJX0VYUF9ERVZDVEwyX0xUUl9FTik7IH0gDQo+ICtERUNMQVJFX1BDSV9GSVhVUF9TVVNQ
RU5EKFBDSV9WRU5ET1JfSURfU1NTVEMsIDB4OTEwMCwgDQo+ICtzc3N0Y19kaXNhYmxlX2x0cik7
IERFQ0xBUkVfUENJX0ZJWFVQX1JFU1VNRShQQ0lfVkVORE9SX0lEX1NTU1RDLCANCj4gKzB4OTEw
MCwgc3NzdGNfZW5hYmxlX2x0cik7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BjaV9p
ZHMuaCBiL2luY2x1ZGUvbGludXgvcGNpX2lkcy5oIGluZGV4IA0KPiAxMzA5NDljM2I0ODYuLmFi
NDdjY2RkMmVjZSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgNCj4gKysr
IGIvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgNCj4gQEAgLTI1NjgsNiArMjU2OCw4IEBADQo+ICAg
I2RlZmluZSBQQ0lfVkVORE9SX0lEX1RFS1JBTQkJMHgxZGUxDQo+ICAgI2RlZmluZSBQQ0lfREVW
SUNFX0lEX1RFS1JBTV9EQzI5MAkweGRjMjkNCj4gICANCj4gKyNkZWZpbmUgUENJX1ZFTkRPUl9J
RF9TU1NUQwkJMHgxZTk1DQo+ICsNCj4gICAjZGVmaW5lIFBDSV9WRU5ET1JfSURfVEVIVVRJCQkw
eDFmYzkNCj4gICAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfVEVIVVRJXzMwMDkJMHgzMDA5DQo+ICAg
I2RlZmluZSBQQ0lfREVWSUNFX0lEX1RFSFVUSV8zMDEwCTB4MzAxMA0K
