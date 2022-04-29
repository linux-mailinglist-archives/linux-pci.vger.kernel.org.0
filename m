Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC86514594
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbiD2JqZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 05:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356680AbiD2JqY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 05:46:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D11C1CAA
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 02:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651225386; x=1682761386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0EdjRGADDIevGFDb0smK3FSMrVTuKmmzQAzHM7xBaB8=;
  b=dJA37IGA5smovNY0gqadlV/p4ikcm1+XO0y4FV9qZ+wVVH1EOoWp3Vje
   cCCl068BeepPiKR4wJmR7XW5/uTz4iMPOe5WQmgwLwgdFqgCY/k0/mfro
   L5d1Lb1xdjYtEeDbLBFUmKL6ev4po6xAPf8fGDFlUYsH5bTxitco+PbRe
   PTLLFpDVNsZJ8d0oCT+UpYyUdM8Bh44LAygEjxZUbHc0xbOLTRexveaoN
   xmvhzFoU0dcCN3YKVkWDrChiWOj08EDacFCy9SXj/AWS7aYBLHa/stNUr
   hojuFajVkwTzSUArbgs2ZX7NCYh4hNhiZmSQOAQZO6KPO3EP/mwXs2Xuw
   A==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="161794033"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Apr 2022 02:43:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 29 Apr 2022 02:43:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 29 Apr 2022 02:43:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB+GjyAaLL1FftiH4AbylAAW8qfc/X4KY6xdul1Z77gFL7NlvNAyo/C/0Jc0P3Y0AyqD+kwEKLwCyaKdApD1PxeuDjJPDmRwPYbn8nW1gcOrkXWglF6uUUQR8KVYclwfU28Mr2bshw14hIVvQezsl3PTOIMXFPWDaC6fNT5pmxvFZk+SmoIzZeZ4FRabjiOOHxvfngQn/o+6AeFQ3f4k04ZhHYir3vshIgCqF7Wsn/tTe0nQqcww+o9eDv70qE66I/yKTq5xer4hY7Nux91NJlky665SUo06Dm1jkJyOfrR0HRMEZVMRqvkPTt29aN29IxPH01jkLXOkhJ/pbzcoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EdjRGADDIevGFDb0smK3FSMrVTuKmmzQAzHM7xBaB8=;
 b=mY/p1CTSjJHkx0CuR6tdZv2qyUpE89PJSDOu/7vL+6qzijFOti/dAxvxAUx/Zntb5Ax2wjdqLTI4KhrGYEKbd7PTZBTqki2iBbV/cwfwKD1DRpS/qKo2Xs45VCgyhPB4UVTwOrZHtqSisRHp30SIhR6NlU2w+ITE9lP/kfoYNjDVlD74yluuTMGkgG5GvNPhMAyHaO27P097xsWfoobpliHe/7k87dfZ+sYp+7xDZ4KZhC7f469VgyVYCAplROdgLAcbcjSuJFKttNs8tgeb8IkKC3Shar6z2jxYFe5z+zAxXw+peJzWwNv3lJZk5DRGQkZT66ErT7OuF40CneQWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EdjRGADDIevGFDb0smK3FSMrVTuKmmzQAzHM7xBaB8=;
 b=c+iKKxNbcwNQjRVfXL3FJ5SUxQf9HxPt0RRw617jnnDgjijtQktREMQjJOfJ08Kvx3uU8paer44sx0cXiY1uXDLxIpOmNA2bVl97OYmOtUd6rzLzE7rOE2Crti1VMHnDAiyF7kG8+DNY1UjTJbRpDr3UuUDeQ8qTLA5yC2FuIFk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by BN8PR11MB3716.namprd11.prod.outlook.com (2603:10b6:408:8a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 09:42:52 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%9]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 09:42:52 +0000
From:   <Conor.Dooley@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <Daire.McNamara@microchip.com>
CC:     <helgaas@kernel.org>, <bhelgaas@google.com>,
        <Cyril.Jean@microchip.com>, <maz@kernel.org>,
        <david.abdurachmanov@gmail.com>, <linux-pci@vger.kernel.org>,
        <robh@kernel.org>
Subject: Re: [RESEND PATCH v1 1/1] PCI: microchip: Fix potential race in
 interrupt handling
Thread-Topic: [RESEND PATCH v1 1/1] PCI: microchip: Fix potential race in
 interrupt handling
Thread-Index: AQHYSN7WdGxuspPXV0KaH+H3O3rn2K0FMzeAgAGV8AA=
Date:   Fri, 29 Apr 2022 09:42:52 +0000
Message-ID: <79102463-adc1-9555-70ba-bdde58a77401@microchip.com>
References: <20220405111751.166427-1-daire.mcnamara@microchip.com>
 <20220428092937.GA12804@lpieralisi>
In-Reply-To: <20220428092937.GA12804@lpieralisi>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55abe35d-0039-4dd4-f16a-08da29c4a180
x-ms-traffictypediagnostic: BN8PR11MB3716:EE_
x-microsoft-antispam-prvs: <BN8PR11MB3716B8182011AB4493D7D8DD98FC9@BN8PR11MB3716.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4smFxdRa8uMpzgNRgC1tzA2Rp9MoNRFYX8LjaulYbObVclSqLtORsPlDyGAkiSsBgUqhhXr1A2R21EqK9ZbncGWbmSIiiZfNa8N5WwIeMvFrVRPEdrCZEGYFOCT+oz3SerLtHo6oGRXjuM1qWFIOD/kwoA/IDCOyaP83RvPeLQvuCWaaGO3zoQD1L83lZ6bDMWsH3PF12LTTCY/kNMsaDjBqKiSGQYtGde8J6IE4sdZVo8CFEv97iA+rfongJBcls4Gqozu2p+04l0dA2uWnmb2DhaagirEP/Elc5vnlXJYnMa5n+VNWf4PwMxDjliFZBNXdkhgSlcc0m5jigqjUm8HH2Ym5FTpGM0UEVZ4tmXN5WXNfmVjUi5szB2PU8L6GM/Oaqb3CONq2w0SXWFKssiXLyDrGUaBI5Ptv1nVenddb6bNcKZ/TGeHcRkc/eWODO/r3BjnKDFpSVRpa/KxJHdzRVIG66ODvmZ4zW3ClLHp1bM2Awf4VWAkl1rvA+pbKa+UMP9AQNBkwbFHqxj8BWjTuILPmECyggdthRcTb7BUXHCC8FjChOzZRnxgCyKCmep9yKSiOPDlVlYIejxBoUtJwV8lV6YNdmuy7To68rp2rj2IK86Ufc9fV4+HugE1XDqhioTAcnrnsI1860ZsRqt8Dg9HG7yzIz5bT6LeiQCNWLbiwSsIz+DDjEsOZRvCZPzX9P4/0TJoYnwX5zD1rWvh8U/5b98QCnw7BwmOAJ6vxTf20VGjIJu60kaTdXVWVamgzPGRFy3gKBYcLCZ3UDMVTJn7IPVuPoqVC5RsmwPP2Iiw+u91YQyrKAO04lHwcX2bKfEs+Rgypvos2VKSTLvi6Dh7juL9FJjoXVa9ui60=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(6486002)(6512007)(508600001)(8936002)(4326008)(86362001)(8676002)(26005)(6506007)(91956017)(122000001)(66556008)(66476007)(66446008)(76116006)(64756008)(66946007)(5660300002)(110136005)(54906003)(53546011)(71200400001)(316002)(31696002)(6636002)(31686004)(2906002)(38100700002)(38070700005)(36756003)(83380400001)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXRGM09hempjNmptZERXb2p4YU9rTDRIZ3dySkx1SmlVK24zVy9aNk9UV1Mz?=
 =?utf-8?B?UmFNdWc1VHUzbXRJY3lNRTNIMGJxS1IrRzg0bmtLbWNGRnh1R2ZjeU1VSHlK?=
 =?utf-8?B?N2tSdWZ3WGRGK1dxd1IzczJ4OWpZbkZpSEFGNlVROE5vY1JZaVZDalJJQTJl?=
 =?utf-8?B?b2ZwaHgwTDlndnI5T2VsNXV1NEh2M3ZSa09LZ0pQUkdqNStWeDl3b1B6QVBo?=
 =?utf-8?B?bm9iVmoxSmc0eDdLeklxc2JucU4wS1dqWHRUcTRCNkE5bnJodDBKWnNXd2hU?=
 =?utf-8?B?aUN4cGpJSVI2NVZVSzNaRlcxeTNLZldDaldFS0oybVpvUklldktuZFlCY2lO?=
 =?utf-8?B?YlRldk5Bc0hDSnliRm5tMGZjVFg0ejVRTnBqUzZ0SVNSUDZqcWVIRndKQmI0?=
 =?utf-8?B?YVJ0R3BjZWN3YWMxRVZ2WjlRSlJGYVE4SWRsaXVqUUw3ZVdObVo4SWNpcyt3?=
 =?utf-8?B?L291TEJieWVCbFJpVkRNSWs3UndVUUlqRm9BSUwvQXA2bDlvQ2ZuSnA0bm5h?=
 =?utf-8?B?blZ4NWtQVm1Bek1ETDk4dHFReUcvenJseURHcmgzQ2p4dXpBVmhRcWpac3dm?=
 =?utf-8?B?U1JpUlVnYlNDVVFsTFgzMzZsTzJsMXVTVjNDOEk1YzBJbnM4dWVqYjRWTFNY?=
 =?utf-8?B?VWZQOHRvTEtYaUF0NjdtdEZ1RTA0ZHBjekgyVUJoTWlSc3NiRWVDZnd5SmVW?=
 =?utf-8?B?WXNuMzBka1JJNjUySGVtOUNEbUhiZys5N1pCU1FXWElHS2l5Z2lWaDVQVWR6?=
 =?utf-8?B?bFBZT2o5VUpyTmJFVkR1cEdKbVFHb3p1TVl6N3drelh5V21RMWZpaHNxSkdW?=
 =?utf-8?B?TmowcE9jNUtxOE9WK1ROVGJkbWxEMzMxc3FYUzErRTk4WmxFbExyY05VdWhS?=
 =?utf-8?B?YXdVZDNYL25PcUNzOHRGQkdkTThQYnE3SDQ1eHRqcERMZ0VXMDEra1A5K0tK?=
 =?utf-8?B?bVdzNXlHT0VxN3FYb29vb1ZQMWd2V2VBbzFrRERjeEZwTWEwSkpZdnJuVWV1?=
 =?utf-8?B?WXdjVE9RajMrZTRHZGZrWjdTeHZKeVlPYXplUWx1Tm5LdTRvdFZxN1pPcFY1?=
 =?utf-8?B?YkhobnFVaGZndXNOaExtb1JJVDY1TW1scDk5RDRMa0xXYlpXRGxISlRPdmJv?=
 =?utf-8?B?U1M5a0VVZGNLeXRxWWhvWEI5bDhSQTRRK1dlMTRLSkpVUW5aSzNicTRYTWFo?=
 =?utf-8?B?Y1dDbDM1M1lRdDBQSGVKb2g5c1dYNVM1bXFSM0tLeEFveDRCMjJvYVg5R1cz?=
 =?utf-8?B?ZUxpWm14eG16T2ljTzMyVit4alZyVXlkUWsxc1RlSzlUd2lGN3c2WlZEV1Mw?=
 =?utf-8?B?U1YwY3NLamZJVnVKUmlsUGNkOEswSzZxaWE1UDg5aTdvc1VBRGliRlBoZXBD?=
 =?utf-8?B?dkRNNVpubDBXYUtxTUJhaXk2alVJSXc3cUdnUVhQSEcwU2NOZytybzhQM24y?=
 =?utf-8?B?WHBUVkNzejFxY1ZFOHlxVG1vbDFrRlpDbnQxV2VZT1dvTVZXT2lpVzNjYUpO?=
 =?utf-8?B?NnNBY1R5WGJNUjFSSnl6SFV1YzZlRFhZYm1lRTFWYkNFSUJHakVlZ0c5NXNH?=
 =?utf-8?B?Sm9xdDFuS3NqWURUY3AwTTNwVlQ3SDRYWTEvZHZ1MDRHcVNpVTJaMzV2K1cr?=
 =?utf-8?B?YlVCcWZWSlVkYkd6WGx6ajdRWXFaNzJyVjdDc21UYUpzU1o5MTJ0ckxJNHlu?=
 =?utf-8?B?T3llVlNlVWU1Z3d0aStaMVBWeFJqenVpL0ViL1VodEM1UHZ1dHVUeGdFWFpN?=
 =?utf-8?B?TkRSZWtjM1V5TGdzN1F4SFZZbjJBZFJYUW10WitraGtISWd0dk9RZEx3bGcy?=
 =?utf-8?B?SGxrMEJmNHliSjRMYjBRd1VpbjVSNXpPSnZOcmhESGI4dzVHdWZJSkpQeERw?=
 =?utf-8?B?K3FqNEJYd1FycFEvWVNRbTV1dVRBSFNVVFBWTkV2amY2TzVOZlR0TXFXWE5z?=
 =?utf-8?B?Q3dNbEh4V2I0akZ2eUd4ODA4M1JJUko5ZTRkd09GSHVkR3ExSVJoZlE1c3U5?=
 =?utf-8?B?ODZLMmVUbzg5NTE1YXNaK05oK0VNUTArWDNLMXlOUHIvV2JaV1ZudHFOaW5w?=
 =?utf-8?B?ZUxId3Y4Y2NWZW5ZUkthYmhLeVVQaDU1VmhoUWtyZ0RYWVdxdmYzWWlYOFpK?=
 =?utf-8?B?R2N6T3F0QVQyaUhuSkJqWXExQ09HSDNwMXBMSHBtYkVwd3RmRGdSSGQ2aC91?=
 =?utf-8?B?YzFLOGpuTjRjbkhGdHFybEg1ajNTOWYvZzIvRlJMU00wazlGN3kyb2w1VU1Z?=
 =?utf-8?B?QUxVYUdrdDZWN0Zkd0JDYlcveFJvenNQcWcwL1pNWFpmKytkV2t5K1pIdTFG?=
 =?utf-8?B?c25SaGQ5V0l1cFE4NjFQZnJ0cEF5NlNHUnB4eGQxK1orRjdGbjh3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD35E194F782824B8AEF533721DD0754@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55abe35d-0039-4dd4-f16a-08da29c4a180
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 09:42:52.5632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: noXkeAXoydhBuLgEb0p87IzsRg/bsktlCTtmj0nDOvfBjOOvsSEeIpsGmxdPSQRtePy67f7NKp+AEFZ/nNFu26cM2Pnf5crXHd+skj5/b4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3716
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMjgvMDQvMjAyMiAxMDoyOSwgTG9yZW56byBQaWVyYWxpc2kgd3JvdGU6DQo+IE9uIFR1ZSwg
QXByIDA1LCAyMDIyIGF0IDEyOjE3OjUxUE0gKzAxMDAsIGRhaXJlLm1jbmFtYXJhQG1pY3JvY2hp
cC5jb20gd3JvdGU6DQo+PiBGcm9tOiBEYWlyZSBNY05hbWFyYSA8ZGFpcmUubWNuYW1hcmFAbWlj
cm9jaGlwLmNvbT4NCj4+DQo+PiBDbGVhciBNU0kgYml0IGluIElTVEFUVVMgcmVnaXN0ZXIgYWZ0
ZXIgcmVhZGluZyBpdCBiZWZvcmUNCj4+IGhhbmRsaW5nIGluZGl2aWR1YWwgTVNJIGJpdHMNCj4g
DQo+IFRoYXQgZXhwbGFpbnMgbm90aGluZy4gSWYgeW91IGFyZSBmaXhpbmcgYSBidWcgcGxlYXNl
IGRlc2NyaWJlDQo+IHRoZSBpc3N1ZSBhbmQgaG93IHRoZSBwYXRjaCBpcyBmaXhpbmcgaXQuDQoN
ClNvbWVvbmUgaW4gdGhlIHBhbnRoZW9uIG9mIElUIGdvZHMgaGFzIGl0IG91dCBmb3IgRGFpcmUs
IHNvIEkgYW0NCnNlbmRpbmcgdGhpcyBvbiBoaXMgYmVoYWxmLCBidXQgaXMgdGhlIGZvbGxvd2lu
ZyByZXZpc2VkIGNvbW1pdA0KbWVzc2FnZSBiZXR0ZXI/DQoNCkNsZWFyIHRoZSBNU0kgYml0IGlu
IElTVEFUVVMgcmVnaXN0ZXIgYWZ0ZXIgcmVhZGluZyBpdCwgYnV0IGJlZm9yZQ0KcmVhZGluZyBh
bmQgaGFuZGxpbmcgaW5kaXZpZHVhbCBNU0kgYml0cyBmcm9tIHRoZSBJTVNJIHJlZ2lzdGVyLg0K
VGhpcyBhdm9pZHMgYSBwb3RlbnRpYWwgcmFjZSB3aGVyZSBuZXcgTVNJIGJpdHMgbWF5IGJlIHNl
dCBvbiB0aGUNCklNU0kgcmVnaXN0ZXIgYWZ0ZXIgaXQgd2FzIHJlYWQgYW5kIGJlIG1pc3NlZCB3
aGVuIHRoZSBNU0kgYml0IGluDQp0aGUgSVNUQVRVUyByZWdpc3RlciBpcyBjbGVhcmVkLg0KDQpS
ZXBvcnRlZC1ieTogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0KTGluazogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpLzIwMjIwMTI3MjAyMDAwLkdBMTI2MzM1QGJo
ZWxnYWFzLw0KRml4ZXM6IDZmMTVhOWM5Zjk0MSAoIlBDSTogbWljcm9jaGlwOiBBZGQgTWljcm9j
aGlwIFBvbGFyRmlyZSBQQ0llIGNvbnRyb2xsZXIgZHJpdmVyIikNClNpZ25lZC1vZmYtYnk6IERh
aXJlIE1jTmFtYXJhIDxkYWlyZS5tY25hbWFyYUBtaWNyb2NoaXAuY29tPg0KDQo+IA0KPj4gVGhp
cyBmaXhlcyBhIHBvdGVudGlhbCByYWNlIGNvbmRpdGlvbiBwb2ludGVkIG91dCBieSBCam9ybiBI
ZWxnYWFzOg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpLzIwMjIwMTI3MjAy
MDAwLkdBMTI2MzM1QGJoZWxnYWFzLw0KPj4NCj4+IEZpeGVzOiA2ZjE1YTljOWY5NDEgKCJQQ0k6
IG1pY3JvY2hpcDogQWRkIE1pY3JvY2hpcCBQb2xhckZpcmUgUENJZSBjb250cm9sbGVyIGRyaXZl
ciIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBEYWlyZSBNY05hbWFyYSA8ZGFpcmUubWNuYW1hcmFAbWlj
cm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gQWRkaW5nIGxpbnV4LXBjaSBtYWlsaW5nIGxpc3QNCj4+
ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1pY3JvY2hpcC1ob3N0LmMgfCA2ICstLS0t
LQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDUgZGVsZXRpb25zKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1taWNyb2NoaXAt
aG9zdC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1pY3JvY2hpcC1ob3N0LmMNCj4+
IGluZGV4IDI5ZDhlODFlNDE4MS4uZGE4ZTNmZGM5N2IzIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2llLW1pY3JvY2hpcC1ob3N0LmMNCj4+ICsrKyBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvcGNpZS1taWNyb2NoaXAtaG9zdC5jDQo+PiBAQCAtNDE2LDYgKzQxNiw3
IEBAIHN0YXRpYyB2b2lkIG1jX2hhbmRsZV9tc2koc3RydWN0IGlycV9kZXNjICpkZXNjKQ0KPj4g
ICANCj4+ICAgCXN0YXR1cyA9IHJlYWRsX3JlbGF4ZWQoYnJpZGdlX2Jhc2VfYWRkciArIElTVEFU
VVNfTE9DQUwpOw0KPj4gICAJaWYgKHN0YXR1cyAmIFBNX01TSV9JTlRfTVNJX01BU0spIHsNCj4+
ICsJCXdyaXRlbF9yZWxheGVkKHN0YXR1cyAmIFBNX01TSV9JTlRfTVNJX01BU0ssIGJyaWRnZV9i
YXNlX2FkZHIgKyBJU1RBVFVTX0xPQ0FMKTsNCj4gDQo+IFdoYXQgZG9lcyBJU1RBVFVTX0xPQ0FM
IGNvbnRhaW4gdnMgSVNUQVRVU19NU0kgPyBJZiB5b3UgZXhwbGFpbiB0aGF0DQo+IHRvIG1lIEkg
Y291bGQgaGVscCB5b3Ugd3JpdGUgdGhlIGNvbW1pdCBsb2cuDQo+IA0KPiBUaGFua3MsDQo+IExv
cmVuem8NCj4gDQo+PiAgIAkJc3RhdHVzID0gcmVhZGxfcmVsYXhlZChicmlkZ2VfYmFzZV9hZGRy
ICsgSVNUQVRVU19NU0kpOw0KPj4gICAJCWZvcl9lYWNoX3NldF9iaXQoYml0LCAmc3RhdHVzLCBt
c2ktPm51bV92ZWN0b3JzKSB7DQo+PiAgIAkJCXJldCA9IGdlbmVyaWNfaGFuZGxlX2RvbWFpbl9p
cnEobXNpLT5kZXZfZG9tYWluLCBiaXQpOw0KPj4gQEAgLTQzMiwxMyArNDMzLDggQEAgc3RhdGlj
IHZvaWQgbWNfbXNpX2JvdHRvbV9pcnFfYWNrKHN0cnVjdCBpcnFfZGF0YSAqZGF0YSkNCj4+ICAg
CXZvaWQgX19pb21lbSAqYnJpZGdlX2Jhc2VfYWRkciA9DQo+PiAgIAkJcG9ydC0+YXhpX2Jhc2Vf
YWRkciArIE1DX1BDSUVfQlJJREdFX0FERFI7DQo+PiAgIAl1MzIgYml0cG9zID0gZGF0YS0+aHdp
cnE7DQo+PiAtCXVuc2lnbmVkIGxvbmcgc3RhdHVzOw0KPj4gICANCj4+ICAgCXdyaXRlbF9yZWxh
eGVkKEJJVChiaXRwb3MpLCBicmlkZ2VfYmFzZV9hZGRyICsgSVNUQVRVU19NU0kpOw0KPj4gLQlz
dGF0dXMgPSByZWFkbF9yZWxheGVkKGJyaWRnZV9iYXNlX2FkZHIgKyBJU1RBVFVTX01TSSk7DQo+
PiAtCWlmICghc3RhdHVzKQ0KPj4gLQkJd3JpdGVsX3JlbGF4ZWQoQklUKFBNX01TSV9JTlRfTVNJ
X1NISUZUKSwNCj4+IC0JCQkgICAgICAgYnJpZGdlX2Jhc2VfYWRkciArIElTVEFUVVNfTE9DQUwp
Ow0KPj4gICB9DQo+PiAgIA0KPj4gICBzdGF0aWMgdm9pZCBtY19jb21wb3NlX21zaV9tc2coc3Ry
dWN0IGlycV9kYXRhICpkYXRhLCBzdHJ1Y3QgbXNpX21zZyAqbXNnKQ0KPj4gLS0gDQo+PiAyLjI1
LjENCj4+DQo=
