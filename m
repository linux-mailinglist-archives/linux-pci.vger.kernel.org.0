Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C471F4F230D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Apr 2022 08:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiDEG0o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 02:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiDEG0n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 02:26:43 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724104BBA3;
        Mon,  4 Apr 2022 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1649139885; x=1649744685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZRMawgN3YrcE90Jt1lifwWHlfVhV34iPciFqcPjCuqk=;
  b=I+esvkbCjbLyBdbhZoGaUalcU+uBkS6xN8JvFpfJSbeyEKbHgY1pRN0Y
   jO+8IdsCWRYO9s3KGdLCI8rSrsjRkhgR72tnNBAm59PdM1ucA7Lr0x9Tw
   6jknrGwR5UVW3OBkSqIYNxZ6QPMl2gHIqayNWR+pd0JIlbCGWCdcmez+f
   4=;
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 06:24:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFKyGnA4wkiDKIieAuky2ouMd/hqe0T5H2yGexE50IcB89Wp4kSNIdjsdWaf3a4aHDqXmHQa8nfpUi7WPq/CLOsct8CSgJBNn1otsrtQ7FnOpqTrHyr4RGxttniryShq/jY2iPIXJhO4We99evTG0X8MNBdvb3mNQiDKLM9doI2rAsWVDWagbcNPn4mGmsToPEIvhqFK3sxLxZmPu2g6CtoJcz5nUiI52tIemqcIUsWCduiVvDUkOQJbswbCXvPZ0PgzPRryXeDHLdc/OBu4ewsCb91JpKIURUilBiqN84Dm4nb65uZSMCFnddUe4eWqQU+iDWKsupFJNU1AYER4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRMawgN3YrcE90Jt1lifwWHlfVhV34iPciFqcPjCuqk=;
 b=hF9Y9YbNu4P3A93Qof9NpMiJNV57XrcsJskm5ByN7AZSn/9Onm58WaLAuHKr237NJXBp7dT8DRTld4ANj+rGLCK7ktOkHHdtB8KmiA69QQ06iASM2XASE+DTa1Iks643JiNuDYddCjAB0gw3xtSOruPimoS6UY3Ads8Wl2+D2wOmJ6XNI69jWdP6KoTegvENXnoCZkcFWk/0qzPMS9Sjw3IJwiV5L5AVhWyiX1hcQ7n67RM3WNS31PB0ZuMfY+Q1Cj6+AxGz7tM1NFhE0hfWfCdRBs+fPKg5hLmvuNy+Z3+03jTMEH2eLa0MnOtAz7JPV+josVT2VjJdzEOsoFt3RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CO1PR02MB8537.namprd02.prod.outlook.com (2603:10b6:303:158::14)
 by MN2PR02MB7103.namprd02.prod.outlook.com (2603:10b6:208:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 06:24:39 +0000
Received: from CO1PR02MB8537.namprd02.prod.outlook.com
 ([fe80::6866:db4:9aed:f185]) by CO1PR02MB8537.namprd02.prod.outlook.com
 ([fe80::6866:db4:9aed:f185%7]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 06:24:39 +0000
From:   "Prasad Malisetty (Temp)" <pmaliset@qti.qualcomm.com>
To:     Stephen Boyd <swboyd@chromium.org>,
        "Prasad Malisetty (Temp) (QUIC)" <quic_pmaliset@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "rajatja@google.com" <rajatja@google.com>,
        "refactormyself@gmail.com" <refactormyself@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "Veerabhadrarao Badiganti (QUIC)" <quic_vbadigan@quicinc.com>,
        "Rama Krishna (QUIC)" <quic_ramkri@quicinc.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
Subject: RE: [PATCH v2] [RFC PATCH] PCI: Update LTR threshold based on LTRME
 bit
Thread-Topic: [PATCH v2] [RFC PATCH] PCI: Update LTR threshold based on LTRME
 bit
Thread-Index: AQHYMlV0r04gp/r+i0WhwsFtqz0ssqzD/8yAgB0GgoA=
Date:   Tue, 5 Apr 2022 06:24:39 +0000
Message-ID: <CO1PR02MB853729533D004EB671B273BAE9E49@CO1PR02MB8537.namprd02.prod.outlook.com>
References: <1646679549-12494-1-git-send-email-quic_pmaliset@quicinc.com>
 <CAE-0n51HZKXCtrzf3_5wnoCZfhRoq8AqmUwsdk31iaiteVRDYg@mail.gmail.com>
In-Reply-To: <CAE-0n51HZKXCtrzf3_5wnoCZfhRoq8AqmUwsdk31iaiteVRDYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fd4ab7a-1f3f-445d-dc26-08da16ccf6cb
x-ms-traffictypediagnostic: MN2PR02MB7103:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR02MB7103B71E5EAB6DBA5E3C5760E9E49@MN2PR02MB7103.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XnSf5XUQJiFn0wZ1m4v4fcAWOP6LcAcewdaPhIhVKBY+i9IFqzLF+xyJmqoxeg2Mdp1E8A3EckfpfBLhAOKwxL+siOSxnRPoidZkDLTgxjq/C7kav5Hixznkmc46FxruUsFsUm5W5gXIuNS+nO249/vxNQgCACJ7O/pAClTsQYtv517+GDNIfXiEB/RdvJyXS1e1Z4W75qRYSUU1peghYWB8B9OnWTLgGzBzt7zbxb7DqV/KpB6bqf3On4yklwq0fxG0C5roPpr9N9yfRvrk+NT3uJ8G/sp2Os85ShMAqIpf/NflNI9EJsrg+1GPFzj3iuzYJk5PkmQB2DgtWILBbZGssZ1RLtqe0IX3BdXh6K815fB0XyTX0AkeeEvtSGb2UoiSOY3lTxoO+n68RVyrfhkcDwy6WyGdQlr9vhINkIUPEWyrDw5wThHUalAg1EKWAAsN5QcxQ7JmFxNWEYvqvvkyQtzjx9nUQE0MEEanZJfsQ/wkiQ1CyjTwVGpLsQsYrlKh+Zz3C+3wJBfnWW1Q6ja12nW57O4xCzwQwklUQlsK7sstdPCvJ/ar/u/LqoDjOyFOUUHv9UbCkHjt57iI12jnxkJsbVCDKswqgs32VfFk36jGGs0Wk6kGKD4Lu0rY0EICiemN4Om+MFGDAk40Ka6aMW3F7K+CIN0OZVcdkCFDfA4Hk79RtPParBJK6u6KRnx6bV1a0ijomGyct7onlK55f06otU8vYmatPpFljXM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR02MB8537.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(15650500001)(86362001)(54906003)(9686003)(53546011)(110136005)(122000001)(55016003)(7696005)(6506007)(38100700002)(5660300002)(921005)(64756008)(4326008)(66946007)(2906002)(71200400001)(8936002)(7416002)(38070700005)(316002)(66556008)(66476007)(66446008)(76116006)(83380400001)(52536014)(8676002)(26005)(508600001)(186003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFowUGpXZXJqZ1FIWitaWjlmcDJOcGdtcTJPNU5HR1ZjSnVNVFRSM3RHTUJo?=
 =?utf-8?B?YTNYWWRHQlhPbkxpYUlyZlBNdnNWTEFSdTMvV3JPWkY5OGZBeFVJU2FSeFRn?=
 =?utf-8?B?eWtLZWo0Y3FoOXgwemE2QWxtRDBKNTBUcFNOb3YwVHZYcThvOE5EMWJHaTFJ?=
 =?utf-8?B?ZVlxUWJDdHFESjdmd1BhbTNxWTZXVmQ4ZGQ4ck9HazduY3M3d3JscWVYSUVi?=
 =?utf-8?B?UHRoWmY2WE5mNlhzMG9vbVFTV1FYVGphd2ExOWhmMy80OEU3T3F4d1VBazFI?=
 =?utf-8?B?bEJuZnlNWGxrT1A2aHFrVkhSbEpXK1JNazVzY3NDSEZmT3VUNG9PemNSbHNq?=
 =?utf-8?B?YnFwSy9pVUlmYktxdkFkdWNJQ0R5NHBsVmlCYm9lMkNCTS96NjZOOFJ2cDE5?=
 =?utf-8?B?RDYyWGxvOG5pQytWRE1RZkh6ajlRZ0FEQjFuME9qM1VScDZabk5SdWFQb2Q0?=
 =?utf-8?B?Wmpud21kaEYrMmpqTDZTdEl6dWpWbWtxb1JialYwckMxODlaOWV3WkFXVWI4?=
 =?utf-8?B?WUVxNmxrMmtaNGRiMXV4bkhFbDNPMlcxT2xtSzBHYXVSOFV5eWR2YmZzUjBO?=
 =?utf-8?B?bVBkOTl5YUhCdGU4Z3JoN0gxL2tsRXAzZHBKY1UyQTFsSXJtM2JGV2pVeGND?=
 =?utf-8?B?WGhQdHRCUUd4Q2wzNWpkNzdTY1BxbUVTWkVJWEp4MTBQY25Xb0VKMDBGdkJX?=
 =?utf-8?B?cWRGMS90bGdmVjVRazAyRE5PWVVmRmkxdnJnbTJ2VDRmaE5peUJDdVJpMloy?=
 =?utf-8?B?b3M5bWNoRGtIYUU1MEUzRWI2L05WbEZGeEo0Rkc0bi9tNFFHcTBKQnJuT1Jl?=
 =?utf-8?B?M1NBQThQQm95YkdOSkFuZDFlR2ozeGdVNmUzZzNvYzBzOGFYQVk0L0NHcHI5?=
 =?utf-8?B?a1BGRTJHbkk5SGdKM3lGaVlIL1grUVVSdTNVOEo4MGxod2NDWVpJM0pMdTNL?=
 =?utf-8?B?VEpjVG9VQ2JTSlk2TERiRGNsSk1BSHczTjMwMy9RcW5EZzNjUkIrYzBPbDMr?=
 =?utf-8?B?MC9TaUFFeW9FUm1hWmd6SmpCa1V3aTJReEptV1MwbWphQzcrV0xoTWUwdVhn?=
 =?utf-8?B?dnFiN01CY0lzNEZBaXdvNTdPMzdOU3poeWtoTzkrdlRKVHN1cVdlb1pqeDlX?=
 =?utf-8?B?Ly9NZ21NaVA2SjdJQjlQVmRCK3k5bFJFN3hjRUpQWE9EQzhUZElZQTJuOG1z?=
 =?utf-8?B?ZkI0OUVQaWtTa2RzWXJXQ0hWTUZjN3dOMEJpUy9OWUl5aHFwS1MxS2RQOEZo?=
 =?utf-8?B?VzJmZVU4RVByaXF2cWlTTnlMNUYvYTFoSkFwM3pFb081RVRyQ0hnck1HQnRL?=
 =?utf-8?B?eDErdUdnZ2hMYzJJQnBpcVBkZHlnbmQwNzhnQjRqWm9RakZHZVovMVFZZnd5?=
 =?utf-8?B?Z2s1V3FFYlIzZXp3L2EyK3JrWnBKK053THQ0emd2ckNEekt2cG0wVjVkcVJH?=
 =?utf-8?B?ejBaZXo4QzdmbVVRMG0zM25LUmhpVXZnWCtocWlIdEZwRVozRU5hZEs2WHhs?=
 =?utf-8?B?NVhkenFKcjVXb0xoSzVwcWw4V2JKaFdvY1l3a2tzd0xJM1Q1Y0ZyVy9ZMmlu?=
 =?utf-8?B?Wkg1Q2tON3ZkWGpNak9UOXFZQmdhZ2oxdlhBMnNvOFhCM0lJeFdJZ1diNzBp?=
 =?utf-8?B?d1FUL3RRR0pRZWdUQkpnL2RvR1J3eGttTVhsa3QxamlhSGtCVHE5S1h2YjJP?=
 =?utf-8?B?WUFYYmFiUmJEb0o3d2hweTdqYm9ZdFBWTkFndGExTTVGZ0xIYXZiL0wzbVRU?=
 =?utf-8?B?dlRwL0NrYTNYcVY3QXBETmpoT0hzUTVobXR5Ni9Ya1hyV3EzaFpuam54aTJn?=
 =?utf-8?B?eFBJUnV3RDdLK1IyenJ3bUpjTHp5SUZJT0pieHIzVUhsM04wTTVxK1gwRU41?=
 =?utf-8?B?YmtkNm40Qzc3aU9ac2pOTGNQaVYvVFBJdG1aMG93SitYdkVMdWRsSUlQY1F5?=
 =?utf-8?B?K0d4c25kMXEwc1VxWkZ1NmxRcStTL1FUaytCcWRGbVlGMHlWMnFFMHlXS0VU?=
 =?utf-8?B?R0lTZzdjTUp0amhOS2ZQZHdKTjA1NzRJVkNndDM3WTVYazRQL3BMS0RRTDkr?=
 =?utf-8?B?QVJ6bGduU09BenBROGpCZEhRVCt6bEt1MExydzFJdi9seVNtbTZZR2dCc0FB?=
 =?utf-8?B?ejNsSHErVUt4U1RlOTdpZ0dPdlVpU2VyNjAza3FtOHpmaW9DQjNzeVNaZGV2?=
 =?utf-8?B?V3FUTCsrVFh1bWtpMUVEN3NZTlNXdnNYSGlhWkVYeXZ3Rm5LRld4a1pBRHoy?=
 =?utf-8?B?Z215djBRT082ZVMxTU42NzVZL1h6cjZDaU5OS0FuRVpKa3hCd2NpMFFqQ2la?=
 =?utf-8?B?Tzd1MmV4MllDWDRTSWVDQUl5SEtmQkZSZEdMdTcwQ0NnT0xoQlY2cjhza0dS?=
 =?utf-8?Q?6mx2W043YV59qxBA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8537.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd4ab7a-1f3f-445d-dc26-08da16ccf6cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 06:24:39.4322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6kpEfjJETZ1712JnWIw9gi+I0SkfjRwoOeMjEb+3EBkhS/2oSPs0mVBVPiseRrnWepI5GI9YcAhVETJrEZFhQdE749nupWSWSSW4lm2RpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7103
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU3RlcGhlbiwgDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgY29tbWVudHMuIFBsZWFz
ZSBmaW5kIG15IGNvbW1lbnRzIGlubGluZSBiZWxvdy4NCg0KVGhhbmtzDQotUHJhc2FkDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxzd2JveWRA
Y2hyb21pdW0ub3JnPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDE4LCAyMDIyIDEyOjM3IEFNDQo+
IFRvOiBQcmFzYWQgTWFsaXNldHR5IChUZW1wKSAoUVVJQykgPHF1aWNfcG1hbGlzZXRAcXVpY2lu
Yy5jb20+Ow0KPiBhZ3Jvc3NAa2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgYmpvcm4u
YW5kZXJzc29uQGxpbmFyby5vcmc7DQo+IGt3QGxpbnV4LmNvbTsgbGludXgtYXJtLW1zbUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBjaUB2
Z2VyLmtlcm5lbC5vcmc7IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHJhamF0amFAZ29vZ2xl
LmNvbTsNCj4gcmVmYWN0b3JteXNlbGZAZ21haWwuY29tOyByb2JoQGtlcm5lbC5vcmcNCj4gQ2M6
IFZlZXJhYmhhZHJhcmFvIEJhZGlnYW50aSAoUVVJQykgPHF1aWNfdmJhZGlnYW5AcXVpY2luYy5j
b20+OyBSYW1hDQo+IEtyaXNobmEgKFFVSUMpIDxxdWljX3JhbWtyaUBxdWljaW5jLmNvbT47DQo+
IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djJdIFtSRkMgUEFUQ0hdIFBDSTogVXBkYXRlIExUUiB0aHJlc2hvbGQgYmFzZWQgb24NCj4gTFRS
TUUgYml0DQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRl
IG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPiBhbnkgbGlua3Mgb3IgYXR0YWNobWVu
dHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IFF1b3RpbmcgUHJhc2FkIE1hbGlz
ZXR0eSAoMjAyMi0wMy0wNyAxMDo1OTowOSkNCj4gPiBVcGRhdGUgTFRSIHRocmVzaG9sZCBzY2Fs
ZSBhbmQgdmFsdWUgYmFzZWQgb24gTFRSTUUgKExhdGVuY3kNCj4gPiBUb2xlbnJhbmNlIFJlcG9y
dGluZyBNZWNoYW5pc20pIGZyb20gZGV2aWNlIGNhcGFiaWxpdGllcy4NCj4gPg0KPiA+IEluIEFT
UE0gZHJpdmVyLCBMVFIgdGhyZXNob2xkIHNjYWxlIGFuZCB2YWx1ZSBpcyB1cGRhdGluZyBiYXNl
ZCBvbg0KPiA+IHRjb21tb25fbW9kZSBhbmQgdF9wb3dlcm9uIHZhbHVlcy4gSW4ga2lveGlhIE5W
TWUsDQo+ID4gTDEuMiBpcyBmYWlsaW5nIGR1ZSB0byBMVFIgdGhyZXNob2xkIHNjYWxlIGFuZCB2
YWx1ZSBpcyBncmVhdGVyIHZhbHVlcw0KPiA+IHRoYW4gbWF4IHNub29wL25vbiBzbm9vcCB2YWx1
ZS4NCj4gPg0KPiA+IEluIGdlbmVyYWwsIHVwZGF0ZWQgTFRSIHRocmVzaG9sZCBzY2FsZSBhbmQg
dmFsdWUgc2hvdWxkIGJlIGxlc3MgdGhhbg0KPiA+IG1heCBzbm9vcC9ub24gc25vb3AgdmFsdWUg
dG8gZW50ZXIgdGhlIGRldmljZSBpbnRvIEwxLjIgc3RhdGUuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBQcmFzYWQgTWFsaXNldHR5IDxxdWljX3BtYWxpc2V0QHF1aWNpbmMuY29tPg0KPiA+DQo+
IA0KPiBBbnkgRml4ZXMgdGFnPw0KTm8sIHdlIGRvbuKAmXQgaGF2ZSBhbnkgZml4ZXMgdGFnIGFz
IHRoaXMgaXMgbmV3IGlzc3VlIGlkZW50aWZpZWQgaW4ga2lveGlhIE5WTWUgb25seSBhcyBvZiBu
b3cuDQo+IA0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgc2luY2UgdjE6DQo+ID4gICAgICAgICAtIEFk
ZGVkIG1pc3NpbmcgdmFyaWFibGUgZGVjbGFyYXRpb24gaW4gdjEgcGF0Y2guDQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvcGNpL3BjaWUvYXNwbS5jIHwgMTIgKysrKysrKysrLS0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpZS9hc3BtLmMgYi9kcml2ZXJzL3BjaS9wY2llL2FzcG0u
YyBpbmRleA0KPiA+IGE5NmI3NDIuLmE2Nzc0NmMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9w
Y2kvcGNpZS9hc3BtLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9wY2llL2FzcG0uYw0KPiA+IEBA
IC00NjMsNiArNDYzLDcgQEAgc3RhdGljIHZvaWQgYXNwbV9jYWxjX2wxc3NfaW5mbyhzdHJ1Y3Qg
cGNpZV9saW5rX3N0YXRlDQo+ICpsaW5rLA0KPiA+ICAgICAgICAgdTMyIHZhbDEsIHZhbDIsIHNj
YWxlMSwgc2NhbGUyOw0KPiA+ICAgICAgICAgdTMyIHRfY29tbW9uX21vZGUsIHRfcG93ZXJfb24s
IGwxXzJfdGhyZXNob2xkLCBzY2FsZSwgdmFsdWU7DQo+ID4gICAgICAgICB1MzIgY3RsMSA9IDAs
IGN0bDIgPSAwOw0KPiA+ICsgICAgICAgdTMyIGNhcDsNCj4gPiAgICAgICAgIHUzMiBwY3RsMSwg
cGN0bDIsIGNjdGwxLCBjY3RsMjsNCj4gPiAgICAgICAgIHUzMiBwbDFfMl9lbmFibGVzLCBjbDFf
Ml9lbmFibGVzOw0KPiA+DQo+ID4gQEAgLTQ5OSw5ICs1MDAsMTQgQEAgc3RhdGljIHZvaWQgYXNw
bV9jYWxjX2wxc3NfaW5mbyhzdHJ1Y3QNCj4gcGNpZV9saW5rX3N0YXRlICpsaW5rLA0KPiA+ICAg
ICAgICAgICogVGFibGUgNS0xMS4gIFQoUE9XRVJfT0ZGKSBpcyBhdCBtb3N0IDJ1cyBhbmQgVChM
MS4yKSBpcyBhdA0KPiA+ICAgICAgICAgICogbGVhc3QgNHVzLg0KPiANCj4gQ2FuIHRoaXMgY29t
bWVudCBiZSB1cGRhdGVkIHRvIGluY2x1ZGUgd2h5IExUUiBjYXAgbWF0dGVycz8NCg0KU3VyZSwg
SSB3aWxsIHVwZGF0ZSB0aGUgY29tbWVudCBpbiBuZXh0IHBhdGNoIHZlcnNpb24uIA0KPiANCj4g
PiAgICAgICAgICAqLw0KPiA+IC0gICAgICAgbDFfMl90aHJlc2hvbGQgPSAyICsgNCArIHRfY29t
bW9uX21vZGUgKyB0X3Bvd2VyX29uOw0KPiA+IC0gICAgICAgZW5jb2RlX2wxMl90aHJlc2hvbGQo
bDFfMl90aHJlc2hvbGQsICZzY2FsZSwgJnZhbHVlKTsNCj4gPiAtICAgICAgIGN0bDEgfD0gdF9j
b21tb25fbW9kZSA8PCA4IHwgc2NhbGUgPDwgMjkgfCB2YWx1ZSA8PCAxNjsNCj4gPiArICAgICAg
IHBjaWVfY2FwYWJpbGl0eV9yZWFkX2R3b3JkKGNoaWxkLCBQQ0lfRVhQX0RFVkNBUDIsICZjYXAp
Ow0KPiA+ICsgICAgICAgaWYgKCEoY2FwICYgUENJX0VYUF9ERVZDQVAyX0xUUikpIHsNCj4gPiAr
ICAgICAgICAgICAgICAgbDFfMl90aHJlc2hvbGQgPSAyICsgNCArIHRfY29tbW9uX21vZGUgKyB0
X3Bvd2VyX29uOw0KPiA+ICsgICAgICAgICAgICAgICBlbmNvZGVfbDEyX3RocmVzaG9sZChsMV8y
X3RocmVzaG9sZCwgJnNjYWxlLCAmdmFsdWUpOw0KPiA+ICsgICAgICAgICAgICAgICBjdGwxIHw9
IHNjYWxlIDw8IDI5IHwgdmFsdWUgPDwgMTY7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsg
ICAgICAgY3RsMSB8PSB0X2NvbW1vbl9tb2RlOw0K
