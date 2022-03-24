Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097974E6B13
	for <lists+linux-pci@lfdr.de>; Fri, 25 Mar 2022 00:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355671AbiCXXPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 19:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355673AbiCXXPL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 19:15:11 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B764D2E9F6;
        Thu, 24 Mar 2022 16:13:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMdc/iwznIpysaTzK6PBcM+vaqR5Z/85AM79iErg6tEeZsmoXhY2nGnW+Zk5IV+ZM1hW9CPr/vW5FgMUp0CIYtinIhGKaFECOJ0OJPOxpFchLIcZelchjTelTKfM8ZfKkAkPoTcXcq368AjNdvTIceTxSbY5gO+l+ew5gSVxPv0qj6y8LbVHzEUl8YjlB9uhiL8Rqu/liHp/aX6gnX761eONiQKDmOE8dYRUK1lxuXbIlO33lzxaD0COsvdJx73MqftAgz7T9LdFSmQb9tPz/bcX2o1LlXMQHipzvKS5ixjcplQ7JlayYfTgUIY3ftY20fK/DbgF6FGT1A4XWNZS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFOP/9DaPWHMbsUnAZscU+1aiy7c0cCjYts0NGvGUUM=;
 b=Ba7KwsoTHno+f7mIEAdktbvAY7CCSPPDwovYvCQK/Z0OmsvF07eqO9Rp5EqZr9WO/6GdromRCG4mXMmNdaK2exgjZmDdAZbU7evQxSWiSrU/cyx52yek37/trYysw5hwIZ/bO2hZH/EJksSzvxYjOI/BgWas1/b7gxwhZ5Acdq8WVY3WGCnyDyR1ljoogRoKu0gdMxRiXqKSU3AqNhBIcz+Og+rCRdzLv3ggj94dC6TxMPEgxS2beYwEJgd7WtTb7djWTTL8oFb2jn+5I12dayzmtXLxrDpmQbWQlkpggWiCMXFBakQr8/g+/4OUwFXTBwPhkTsCheWH/yJpoc6Ywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFOP/9DaPWHMbsUnAZscU+1aiy7c0cCjYts0NGvGUUM=;
 b=sCZoIWNV4rcJ6i+HRjzgrPp1u8dipaW3pLAT1JUHsye++0XrmOkywaVATqjhbnlT2WeMZ1vkF3/cEh2asRnxbzTgT/B8hzHAPew3DB14/WKqb+LM5UFAT0hcGC+0q1du6Y7qROrEiJ5P1+LcEDWTBrO4lilABgdq5C5RfRQ8iLQ=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL0PR12MB2563.namprd12.prod.outlook.com (2603:10b6:207:4b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 23:13:34 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 23:13:34 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if device
 can wake from D3
Thread-Topic: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if
 device can wake from D3
Thread-Index: AQHYOIH4cjkXql1VyUKxzqcCT79LiazApEsAgAAAXoCADIi5gIAAUUqAgAAEXdCAAAnIgIAAAD8ggAE8GACAAAJrUIAAHkoAgAAFx4CAAATdgIAAQ8Ig
Date:   Thu, 24 Mar 2022 23:13:34 +0000
Message-ID: <BL1PR12MB51578C9CFF18412814C0E94DE2199@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <CAJZ5v0hVFkKXTJcrFqRR4FoK5v_k3zCacKPmurWm=sozt7GPiQ@mail.gmail.com>
 <20220324185237.GA1466503@bhelgaas>
 <CAJZ5v0j6xSBgZCWPAbVEK4X0Q8saJe+5xnKcgugA2i2Y5gm3Dw@mail.gmail.com>
In-Reply-To: <CAJZ5v0j6xSBgZCWPAbVEK4X0Q8saJe+5xnKcgugA2i2Y5gm3Dw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-24T23:13:29Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=afb9b7fa-b6b0-40c6-b18a-e86d3b75023d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-24T23:13:31Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 68502e6e-5c11-49d7-8131-75c6f4373b2f
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16e488a8-2890-43e5-82cc-08da0debeb56
x-ms-traffictypediagnostic: BL0PR12MB2563:EE_
x-microsoft-antispam-prvs: <BL0PR12MB25631728009FB8CA22E38639E2199@BL0PR12MB2563.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+E5v5xeOjIaWzLac00CEABMz85EUCX9M0YWZ4Fa23SgJqTwBqc60Boz2QKbkUHHmlCAAC0vpeHZFgIT1kYDzk5WaJ8mLO/QksE1ODEZJ6lxs2ixo6GWg9NYxIBFWfNG1N9n2p1zelkG9jkgK6W5RqL0yI1hJmqXRC899nd4waJkiilYNx28QHBeWytyNRjadxIU0uakpjFoWN1xVX09gldA26LC/f/KvqEdO9pV/rIg0qRdDWsFTrDv15/SSbtBH2iz0myWtD4TdtQHvD4ulgYXIGsc5xT8w6E4Gq0YdIyOo2H5UuW5kG7Mx9su2NGHxdq/uwXd9FV0t9voPTSXOETGE44fELYdOdyf0fV6otb0+OF5nsaqRyvlwF3Uu4CiVdk40MlPCE1cKP7q//FlzrKrx6IXPvciAd6dJ/Bz3BrWdz8uksCyzSBJmVvr4+2pVmGAAqM7D3+5wMKSV3H3RXueMXepD2eoTjLXb/OW8SnXVusM/oizdJ+IH2V7xHdSTet1s5qo4i+PxNph2e7qg47p3lrQVM1AKWKWXbsIB/rfhrcdV1ZSQHNBU5jgZmPZqYqaDBqrC/WctqVR6OWeVVJr7vXe01KpSHyNhQM7OpEMfu+HNlgMT7KlEwAbFBHicReS3gk/j4CXy7qIrAwBCMssNj/5OKEd8nlth0mI60LrIXIy7Fwgmz6GOLVioPZw1c7roUPxpdbPUBEvHmy/hTiB5q4li9m4exgh7RLvYvU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(4636009)(366004)(8936002)(5660300002)(38070700005)(6506007)(52536014)(122000001)(316002)(19627235002)(186003)(54906003)(110136005)(508600001)(71200400001)(9686003)(45080400002)(38100700002)(4326008)(83380400001)(7696005)(53546011)(8676002)(64756008)(66446008)(66556008)(66946007)(76116006)(66476007)(86362001)(33656002)(2906002)(55016003)(81973001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHhoWjdqTlQ2L0oxeU9QY0ZDTFM5K1ZYZjZPazdhK3lIM3UyTDhISEZGdkJR?=
 =?utf-8?B?UzlVZ1BrbzdJM1QveFVyd0JBS0VNdnVKUVR6OHdWamZnOEIzK09aRnNaNjhJ?=
 =?utf-8?B?M0NiYXk1akM4UlB1VSszWVJrN1JHOTRjZXpaK3hEaWNjZlVCNWpzM20yRDNI?=
 =?utf-8?B?dGxaS2ExcHk5QzRmN2pEV1g5ZmFMTC9FckVHaldxMUlNVkZrdUFBNmkyTkJF?=
 =?utf-8?B?Qm5kNnhzd0xDWitzYmo4WHBXODRaRnZkbTVuZm9Cd1FoQW13bTFPdG41L05K?=
 =?utf-8?B?YzNxREx3aDloalN5c2c1TitIeDI3N1NvVmswTjFlTnZEWWlQVUJVTS9nYmJS?=
 =?utf-8?B?RGNhaFJuQzNEMnIxeXB5ZXQ4WVJ6bFdDekUwd25HejhPdWdic3lHOFF6Tmtp?=
 =?utf-8?B?OW53bzVBdVFkWUVySkZFTkFrR1dOYUNCWFBKdkNLbUh6RUxGckMxUldkMFV3?=
 =?utf-8?B?MjBKb004a2VQanBEenhHeTZmalpQQWtCTHQvcXIwbGFScjNLYWxoTGFyb0g2?=
 =?utf-8?B?UGFnMjJ2ekxTRFdLbGxidmF2TUZVS21TNG5JWGN5citWZ2ZFWlNyOVZTOFNq?=
 =?utf-8?B?cXlaWGs0YVN0Vk8rTVVsUkU1cGRxQmZ5Ym12cVFsMmcwYmxMQUprc01LRjBY?=
 =?utf-8?B?NHJxRExhYk5ETTRTbEpHR2U1L1NnUzBKaERwVG9DOGNvNHd3UDRqSnJjOE5j?=
 =?utf-8?B?SXdDeWo5a1FxUUdycXpkVkhuNy8xV1lkRDNFUm9HRWVsWDZvdk1yYUF1dDIr?=
 =?utf-8?B?bks3MTZ3ODBpWU5kem9WeC8vTlVPTUNjTkdEVEoxN1BLZDU2Z0k0SkFHVmtV?=
 =?utf-8?B?dkwxemdUdjlrODQ0ZThKR3lWeW5LTFFtVSt1WGpTZmNKVkk5YytydHEyNGtt?=
 =?utf-8?B?U3l1Rk4zMWNTc2pqMHluR2srR0dZNzE3THVISjhuUWRRRUZkb254dDZWeEd3?=
 =?utf-8?B?MFIvSTh0SUpUc1RsV2xLWXNOamRjaVRHNnBPdktTbXRCajlJeXcwVnBQL010?=
 =?utf-8?B?REJjaFFxaUltVzluYko3bVBjd0t4QkZBVGNoSjdzNUllNWR5M1Qvb3NVSWpo?=
 =?utf-8?B?R1M0ckl5R2tNdDdzUURmRTJmUGwzeW5VNGdTZm5FTHZmZERRS3doZW1qTkZC?=
 =?utf-8?B?UHpmd1hGU3RsblFiT05iNzZoOS90b3VjV0VFS0w3cWFtbmtsU0FjL3gwQVBC?=
 =?utf-8?B?WHlWNDBXOFNaKy94TlZUTTlob1RZQW1XRnN2aUpvWjQybzZ2SWFWNEpRaE1G?=
 =?utf-8?B?NXhvYjM1dkNoTm1jbkltTTdJVGlXT3VLekpNTnMzcnRjTHpldmt6VnFDUjhv?=
 =?utf-8?B?K0h3dzRCSFo1cUVaUktRTysycjg2RkI5a2lKaEc5NVo3N0VhR2dORzJJZjMx?=
 =?utf-8?B?UGwybjVlOGtkZmRHNVNFUWhsMTEvWXpFR09RM1JNUTFuNlJMSjBiaHlSL21Z?=
 =?utf-8?B?NFBsanlRZjVKTWE5N21INXRHZ2UwdVc2a0JSeDlaSnpUTFdkNzFnUkFEczZF?=
 =?utf-8?B?NG9yRXlsTGhYQzhnOTRUMXQ2eTFYT0syYkxZOFgrait4Nk1YVm9ncDEybHcy?=
 =?utf-8?B?ODJiWS9jZDJRMmFtY0p4NkRQN2R5TldRV1hKQUYvbm83QjBNQzB3ZFRLNWE3?=
 =?utf-8?B?ZUEzTXpEZW1iTmoxQUY0Z0R4aVVFbjNWdHlLSEZKUlV1dEpZTzBwWDRUZy9X?=
 =?utf-8?B?bTRsZHIwNnduUm9reS91Z0V1Z3RzYUxBZC9COFZQUi9zbDlGZFpIUjYzbjE4?=
 =?utf-8?B?VFRvaFZURTVzSk8xUWFXaDVEVkpUcHhKNUVmTTZTL1l5aTJ1Z1RJTnBJZ21u?=
 =?utf-8?B?MExBY0VsSUpNOExkVGsyb3pUa0lNcjMrNlJmMlJobFZod0sxNTU0TklqejRa?=
 =?utf-8?B?bEFIclhGRm56K1JJNnBmYTM0bldLQzR4dmdKZVcxNmNqNmxzRnVKY0VlVTdH?=
 =?utf-8?B?UDRma1FjRnpNSUlKRWpRbG05QTVVdmRRMDdRM2tnUjJpeVlCdlU0Q1lCZUJE?=
 =?utf-8?B?Z3ZvM1BpZ1BnTWxMdWhGcWpIU0lzcVYxT3pPOHpKYVEvY09LL1k1UzVrZjVJ?=
 =?utf-8?B?eFhpUmc5MmNaVURsMnZwT2RnQ2RRYitUZjZ3dStJWjE5ajJEa3Uxa3c5c1Np?=
 =?utf-8?B?bXRJejdUZjN5SUNoa21CaDBtcitGUWFKelFEYllWdkQxY0JOVEpHRXA2cUFU?=
 =?utf-8?B?NmxhRkRlcDUvZGREcVFLUnBhcEZqNGttRjIzUkFvd3BNSUU3MzYyQ241clgx?=
 =?utf-8?B?elZPZXk1MGEydlRlNm42R21GaTNOSXhCcHNKUm9YZDFBWFQvTnJxOWtyQmlJ?=
 =?utf-8?B?RUhtVHhQMjh6WG1rOWRzazUwUTFkcmRMZTB1aHdQTjJzY282Umx3MkZyQnRl?=
 =?utf-8?Q?W3TvJSoYKesGp6sBOW3sjRHMALKVCTLM30g6g?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e488a8-2890-43e5-82cc-08da0debeb56
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 23:13:34.2043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/og57DjlCiiqSRh90Spyyhw/B89+O6aF7yBd0dsST7CzMGkfnONCWZ05eR95QYXLJqaIhY3DF01x6+62Rv3dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2563
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFm
YWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWFy
Y2ggMjQsIDIwMjIgMTQ6MTANCj4gVG86IEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9y
Zz4NCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IExpbW9uY2ll
bGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IEJqb3JuIEhlbGdhYXMg
PGJoZWxnYWFzQGdvb2dsZS5jb20+Ow0KPiBvcGVuIGxpc3Q6UENJIFNVQlNZU1RFTSA8bGludXgt
cGNpQHZnZXIua2VybmVsLm9yZz47IExpbnV4IFBNIDxsaW51eC0NCj4gcG1Admdlci5rZXJuZWwu
b3JnPjsgTWVodGEsIFNhbmp1IDxTYW5qdS5NZWh0YUBhbWQuY29tPjsgTWlrYQ0KPiBXZXN0ZXJi
ZXJnIDxtaWthLndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY0XSBQQ0kgLyBBQ1BJOiBBc3N1bWUgYEhvdFBsdWdTdXBwb3J0SW5EM2Agb25seSBpZg0K
PiBkZXZpY2UgY2FuIHdha2UgZnJvbSBEMw0KPiANCj4gT24gVGh1LCBNYXIgMjQsIDIwMjIgYXQg
Nzo1MiBQTSBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+
ID4gT24gVGh1LCBNYXIgMjQsIDIwMjIgYXQgMDc6MzE6NTZQTSArMDEwMCwgUmFmYWVsIEouIFd5
c29ja2kgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIE1hciAyNCwgMjAyMiBhdCA2OjE1IFBNIExpbW9u
Y2llbGxvLCBNYXJpbw0KPiA+ID4gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+IHdyb3RlOg0K
PiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogQmpv
cm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiA+ID4gPiA+IFNlbnQ6IFRodXJzZGF5
LCBNYXJjaCAyNCwgMjAyMiAxMTozNQ0KPiA+ID4gPiA+IFRvOiBMaW1vbmNpZWxsbywgTWFyaW8g
PE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4gPiA+ID4gQ2M6IEJqb3JuIEhlbGdhYXMg
PGJoZWxnYWFzQGdvb2dsZS5jb20+OyBvcGVuIGxpc3Q6UENJIFNVQlNZU1RFTQ0KPiA8bGludXgt
DQo+ID4gPiA+ID4gcGNpQHZnZXIua2VybmVsLm9yZz47IExpbnV4IFBNIDxsaW51eC1wbUB2Z2Vy
Lmtlcm5lbC5vcmc+Ow0KPiBNZWh0YSwgU2FuanUNCj4gPiA+ID4gPiA8U2FuanUuTWVodGFAYW1k
LmNvbT47IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47DQo+IE1pa2ENCj4g
PiA+ID4gPiBXZXN0ZXJiZXJnIDxtaWthLndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tPg0KPiA+
ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjRdIFBDSSAvIEFDUEk6IEFzc3VtZSBgSG90UGx1
Z1N1cHBvcnRJbkQzYA0KPiBvbmx5IGlmDQo+ID4gPiA+ID4gZGV2aWNlIGNhbiB3YWtlIGZyb20g
RDMNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFsrY2MgTWlrYSwgIkhvdFBsdWdTdXBwb3J0SW5EMyIg
c2NvcGUgcXVlc3Rpb24gYmVsb3ddDQo+ID4gPiA+DQo+ID4gPiA+IEZZSSAtIE1pa2EgaGFkIGFw
cHJvdmVkIHNvbWUgZWFybGllciB2ZXJzaW9ucyBvZiB0aGlzLCBzbyBJIGV4cGVjdA0KPiBjb25j
ZXB0dWFsDQo+ID4gPiA+IEFsaWdubWVudCBhdCBsZWFzdCB3aXRoIHRoZSBsYXRlc3Qgb25lLg0K
PiA+ID4gPg0KPiA+ID4gPiA8c25pcD4NCj4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gQ2FuIHdlIGF0
IGxlYXN0IGxpc3Qgc29tZSBjb21tb24gc2NlbmFyaW9zPyAgRS5nLiwgaXQgYWZmZWN0cw0KPiA+
ID4gPiA+ID4gPiBrZXJuZWxzIGFmdGVyIGNvbW1pdCBYLCBvciBpdCBhZmZlY3RzIG1hY2hpbmVz
IHdpdGggQ1BVcyBuZXdlcg0KPiA+ID4gPiA+ID4gPiB0aGFuIFksIG9yIGl0IGFmZmVjdHMgYSBj
ZXJ0YWluIGtpbmQgb2YgdHVubmVsaW5nLCBldGM/ICBEaXN0cm9zDQo+ID4gPiA+ID4gPiA+IG5l
ZWQgdGhpcyBpbmZvcm1hdGlvbiBzbyB0aGV5IGNhbiBmaWd1cmUgd2hldGhlciBhbmQgaG93IGZh
ciB0bw0KPiA+ID4gPiA+ID4gPiBiYWNrcG9ydCB0aGluZ3MgbGlrZSB0aGlzLg0KPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+IEl0J3MgZ29pbmcgdG8gYWZmZWN0IGFueSByZXRhaWwgbWFjaGluZSB3
aXRoIHRoZSBTT0Mgd2UgcmVmZXIgdG8gaW4NCj4gPiA+ID4gPiA+IHRoZSBrZXJuZWwgYXMgIlll
bGxvdyBDYXJwIi4gIFRoaXMgaXMgb25lIG9mIHRoZSBmaXJzdCBub24tSW50ZWwNCj4gPiA+ID4g
PiA+IFVTQjQgaG9zdHMgYW5kIHdpbGwgYmUgdXNpbmcgdGhlIFVTQjQgU1cgQ00gaW4gdGhlIGtl
cm5lbC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBXaXRob3V0IHRoaXMgY2hhbmdlLCBlZmZl
Y3RpdmVseSBQQ0llIHR1bm5lbGluZyB3aWxsIG5vdCB3b3JrIHdoZW4NCj4gPiA+ID4gPiA+IGFu
eSBkb3duc3RyZWFtIFBDSWUgZGV2aWNlIGlzIGhvdHBsdWdnZWQuICBJbiB0aGUgcmlnaHQNCj4g
PiA+ID4gPiA+IGNpcmN1bXN0YW5jZXMgaXQgbWlnaHQgd29yayBpZiBpdCdzIGNvbGRib290ZWQg
KGlmIHRoZSBwYXRocw0KPiA+ID4gPiA+ID4gc2VsZWN0ZWQgYnkgdGhlIHByZS1ib290IGZpcm13
YXJlIGNvbm5lY3Rpb24gbWFuYWdlciBhcmUNCj4gaWRlbnRpY2FsDQo+ID4gPiA+ID4gPiB0byB0
aGF0IHNlbGVjdGVkIGJ5IFNXIENNKS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoYW5rcyBhIGxv
dCBmb3IgdGhpcyBjb250ZXh0ISAgQXMgZmFyIGFzIEkgY2FuIHRlbGwgZnJvbSBncnViYmluZw0K
PiA+ID4gPiA+IHRocm91Z2ggdGhlIGdpdCBoaXN0b3J5LCB0aGVyZSBhcmUgbm8gUENJLCBVU0I0
LCBvciBUaHVuZGVyYm9sdA0KPiA+ID4gPiA+IGNoYW5nZXMgcmVsYXRlZCB0byBZZWxsb3cgQ2Fy
cCwgc28gSSBhc3N1bWUgdGhpcyBoYXMgdG8gZG8gd2l0aCBZZWxsb3cNCj4gPiA+ID4gPiBDYXJw
IGZpcm13YXJlIGRvaW5nIHRoaW5ncyBkaWZmZXJlbnRseSB0aGFuIHByZXZpb3VzIHBsYXRmb3Jt
cy4NCj4gPiA+ID4NCj4gPiA+ID4gVGhlcmUgaGF2ZSBiZWVuIGEgdmFyaWV0eSBvZiBUaHVuZGVy
Ym9sdC9VU0I0IGNoYW5nZXMgYXMgYSByZXN1bHQgb2YNCj4gPiA+ID4gWWVsbG93IENhcnAgZGV2
ZWxvcG1lbnQgYW5kIGZpbmRpbmdzLCBidXQgdGhleSBoYXZlIG5vdCBiZWVuIHF1aXJrczsNCj4g
PiA+ID4gdGhleSBoYXZlIGJlZW4gZG9uZSBhcyBnZW5lcmljIGNoYW5nZXMgdGhhdCBzdGlsbCBt
YWtlIHNlbnNlIGZvciBhbGwNCj4gPiA+ID4gVVNCNCBkZXZpY2VzLg0KPiA+ID4gPg0KPiA+ID4g
PiBTYW5qdSAob24gQ0MpIGhhcyBzdWJtaXR0ZWQgYSBtYWpvcml0eSBvZiB0aGVzZSwgc28gaWYg
eW91IHdhbnQgdG8gc2VlDQo+ID4gPiA+IGEgc2Vuc2Ugb2Ygd2hhdCB0aGVzZSBhcmUgeW91IGNh
biBsb29rIGZvciBoaXMgY29tbWl0cyBpbg0KPiBkcml2ZXJzL3RodW5kZXJib2x0Lg0KPiA+ID4g
Pg0KPiA+ID4gPiA+IFByZXZpb3VzbHksIGlmIGEgUm9vdCBQb3J0IGltcGxlbWVudGVkIHRoZSBI
b3RQbHVnU3VwcG9ydEluRDMNCj4gPiA+ID4gPiBwcm9wZXJ0eSwgd2UgYXNzdW1lZCB0aGF0IHRo
ZSBSb290IFBvcnQgYW5kIGFueSBkb3duc3RyZWFtDQo+IGJyaWRnZXMNCj4gPiA+ID4gPiBjb3Vs
ZCBoYW5kbGUgaG90LXBsdWcgZXZlbnRzIHdoaWxlIGluIEQzaG90Lg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gSSBndWVzcyB0aGUgZGlmZmVyZW5jZSBoZXJlIGlzIHRoYXQgb24gWWVsbG93IENhcnAg
ZmlybXdhcmUsIGV2ZW4gaWYNCj4gPiA+ID4gPiB0aGVyZSBpcyBhIEhvdFBsdWdTdXBwb3J0SW5E
MyBwcm9wZXJ0eSBvbiB0aGUgUm9vdCBQb3J0LCB0aGUgUm9vdA0KPiBQb3J0DQo+ID4gPiA+ID4g
Y2Fubm90IGhhbmRsZSBob3QtcGx1ZyBldmVudHMgaW4gRDNob3QgVU5MRVNTIHRoZXJlIGlzIGFs
c28gYW4gX1MwVw0KPiA+ID4gPiA+IG1ldGhvZCBBTkQgdGhhdCBfUzBXIHNheXMgdGhlIFJvb3Qg
UG9ydCBjYW4gd2FrZXVwIGZyb20gRDNob3Qgb3INCj4gPiA+ID4gPiBEM2NvbGQsIHJpZ2h0Pw0K
PiA+ID4gPg0KPiA+ID4gPiBZZXMsIGNvcnJlY3QhDQo+ID4gPiA+DQo+ID4gPiA+ID4gSSBoYXZl
IHNvbWUgaGVhcnRidXJuIGFib3V0IHRoaXMgdGhhdCdzIG9ubHkgcGFydGx5IHJlbGF0ZWQgdG8g
dGhpcw0KPiA+ID4gPiA+IHBhdGNoLiAgVGhlIE1pY3Jvc29mdCBkb2MgY2xlYXJseSBzYXlzICJI
b3RQbHVnU3VwcG9ydEluRDMiIG11c3QgYmUNCj4gPiA+ID4gPiBpbXBsZW1lbnRlZCBvbiBSb290
IFBvcnRzIGFuZCBpdHMgcHJlc2VuY2UgdGVsbHMgdXMgdGhhdCB0aGUgKlJvb3QNCj4gPiA+ID4g
PiBQb3J0KiBjYW4gaGFuZGxlIGhvdC1wbHVnIGV2ZW50cyB3aGlsZSBpbiBEMy4NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IEJ1dCBhY3BpX3BjaV9icmlkZ2VfZDMoKSBsb29rcyB1cCB0aGUgUm9vdCBQ
b3J0IGF0IHRoZSB0b3Agb2YgdGhlDQo+ID4gPiA+ID4gaGllcmFyY2h5IGFuZCBhc3N1bWUgdGhh
dCBpdHMgIkhvdFBsdWdTdXBwb3J0SW5EMyIgYXBwbGllcyB0byBhbnkNCj4gPiA+ID4gPiBzd2l0
Y2ggcG9ydHMgdGhhdCBtYXkgYmUgYmVsb3cgdGhhdCBSb290IFBvcnQgKGFkZGVkIGJ5DQo+IDI2
YWQzNGQ1MTBhOA0KPiA+ID4gPiA+ICgiUENJIC8gQUNQSTogV2hpdGVsaXN0IEQzIGZvciBtb3Jl
IFBDSWUgaG90cGx1ZyBwb3J0cyIpIFsxXSkuDQo+ID4gPg0KPiA+ID4gTm90IHJlYWxseS4NCj4g
PiA+DQo+ID4gPiAiSG90UGx1Z1N1cHBvcnRJbkQzIiBhcHBsaWVzIHRvIHRoZSByb290IHBvcnQg
b25seSBhbmQgdGhlIHBsYXRmb3JtDQo+ID4gPiBmaXJtd2FyZSBtYXkgbm90IGtub3cgYWJvdXQg
YW55IHBvcnRzIGJlbG93IGl0Lg0KPiA+ID4NCj4gPiA+IEhvd2V2ZXIsIHRoZSBwcmVzZW5jZSBv
ZiAiSG90UGx1Z1N1cHBvcnRJbkQzIiBpcyB1c2VkIGFzIGFuIGluZGljYXRvcg0KPiA+ID4gdGhh
dCB0aGUgZW50aXJlIGhpZXJhcmNoeSBpcyAiRDNjb2xkLWF3YXJlIiwgc28gdG8gc3BlYWsuDQo+
ID4gPiBFc3NlbnRpYWxseSwgdGhpcyBib2lscyBkb3duIHRvIHRoZSAiSXMgdGhlIGhhcmR3YXJl
IG1vZGVybiBlbm91Z2g/Ig0KPiA+ID4gY29uc2lkZXJhdGlvbiBhbmQgdGhlIGFuc3dlciBpcyBh
c3N1bWVkIHRvIGJlICJ5ZXMiIGlmIHRoZSBwcm9wZXJ0eSBpbg0KPiA+ID4gcXVlc3Rpb24gaXMg
cHJlc2VudCBmb3IgdGhlIHJvb3QgcG9ydC4NCj4gPg0KPiA+IFNlZW1zIHdlaXJkIHRvIG1lIHNp
bmNlIHdlJ3JlIHRhbGtpbmcgYWJvdXQgYSBob3QtcGx1ZyBSb290IFBvcnQgYW5kDQo+ID4gYW55
dGhpbmcgYXQgYWxsIGNvdWxkIGJlIHBsdWdnZWQgaW50byBpdC4gIFdlJ3JlIGJhc2ljYWxseSBz
YXlpbmcgdGhhdA0KPiA+IHdlIGNhbiBhc3N1bWUgYSBwcm9wZXJ0eSBvZiBhbiBhcmJpdHJhcnkg
ZG93bnN0cmVhbSBkZXZpY2UgYmFzZWQgb24NCj4gPiBzb21ldGhpbmcgd2Uga25vdyBhYm91dCB0
aGUgdXBzdHJlYW0gZGV2aWNlLiAgSSdtIHN0aWxsIG5vdA0KPiA+IGNvbWZvcnRhYmxlIHdpdGgg
dGhhdC4NCj4gPg0KPiA+IEF0IGEgbWluaW11bSB3ZSBzaG91bGQgYWRkIGEgY29tbWVudCBhYm91
dCB0aGlzIGFzc3VtcHRpb24uICBUaGUNCj4gPiBleGlzdGluZyAiLi4uIHdlIGtub3cgdGhlIGhp
ZXJhcmNoeSBiZWhpbmQgaXQgc3VwcG9ydHMgRDMganVzdCBmaW5lIg0KPiA+IHNlZW1zIGEgbGl0
dGxlIHRvbyBzdHJvbmcuDQo+ID4NCj4gPiA+IEJ1dCBpZiAiSG90UGx1Z1N1cHBvcnRJbkQzIiBp
cyBub3QgY29uc2lzdGVudCB3aXRoIHRoZSBvdGhlciBwaWVjZXMgb2YNCj4gPiA+IGluZm9ybWF0
aW9uIHJlZ2FyZGluZyB0aGUgcm9vdCBwb3J0IGF2YWlsYWJsZSBmcm9tIHRoZSBmaXJtd2FyZSAo
X1BSVw0KPiA+ID4gYW5kIF9TMFcgaW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UpLCB0aGUgcHJlc2Vu
Y2Ugb2YgaXQgaXMgcXVlc3Rpb25hYmxlDQo+ID4gPiBpbiB0aGUgZmlyc3QgcGxhY2UsIHNvIElN
TyB0aGUgYXBwcm9hY2ggaGVyZSBtYWtlcyBzZW5zZS4NCj4gPg0KPiA+IFRoaXMgcGFydCBzZWVt
cyByZWFzb25hYmxlIHRvIG1lLCBhcyBsb25nIGFzIHdlIGhhdmUgZ29vZCBjb25maWRlbmNlDQo+
ID4gdGhhdCByZXF1aXJpbmcgIkhvdFBsdWdTdXBwb3J0SW5EMyIgKyBfUFJXICsgX1MwVyB3aGVy
ZSB3ZSB1c2VkIHRvDQo+ID4gcmVxdWlyZSBvbmx5ICJIb3RQbHVnU3VwcG9ydEluRDMiIGlzIHVu
bGlrZWx5IHRvIGJyZWFrIGFueXRoaW5nLg0KPiA+DQo+ID4gSSBjYW4ndCBqdWRnZSB0aGF0LCBi
dXQgSSBhc3N1bWUgeW91IGtub3cgdGhhdCB3ZSBkb24ndCB1c2UgdGhlDQo+ID4gYWNwaV9wY2lf
YnJpZGdlX2QzKCkgcmVzdWx0IHVubGVzcyBfUFJXIGFuZCBfUzBXIGV4aXN0LCBzbyBJJ2xsIHRh
a2UNCj4gPiB5b3VyIHdvcmQgZm9yIGl0IDopDQo+IA0KPiBBY3R1YWxseSwgdGhhdCBpcyBhbiBl
eHRyZW1lbHkgZ29vZCBwb2ludCBJIGRpZG4ndCB0aGluayBhYm91dC4NCj4gDQo+IFRoaW5raW5n
IGFib3V0IGl0IG5vdywgb25lIHRoaW5nIGlzIG1pc3Npbmc6IGEgY2hlY2sgaWYgX1MwVyBpcw0K
PiBwcmVzZW50LCBiZWNhdXNlIHRoZSBsYWNrIG9mIGl0IG1lYW5zICJhbnkgcG93ZXIgc3RhdGUg
c2hvdWxkIGJlDQo+IGZpbmUiLg0KPiANCj4gV2l0aCB0aGlzIGNoZWNrIGluIHBsYWNlIHdlIHdv
dWxkIG9ubHkgYXZvaWQgdGFraW5nDQo+ICJIb3RQbHVnU3VwcG9ydEluRDMiIGludG8gYWNjb3Vu
dCBpZiBpdCB3ZXJlIG5vdCBjb25zaXN0ZW50IHdpdGggdGhlDQo+IG90aGVyIHNldHRpbmdzIGFu
ZCBpZiB0aGF0IGRpZG4ndCB3b3JrLCB3ZSB3b3VsZCBlbmQgdXAgaW4gdGhlIHF1aXJrcw0KPiB0
ZXJyaXRvcnkgdGhpcyB3YXkgb3IgYW5vdGhlci4NCg0KSW4gdGhhdCBjYXNlIHNvbWV0aGluZyBs
aWtlIHRoaXMgaW5zdGVhZD8NCg0KKwlpZiAoIWFkZXYtPndha2V1cC5mbGFncy52YWxpZCkNCisJ
CXJldHVybiBmYWxzZTsNCisNCisJaWYgKEFDUElfU1VDQ0VTUyhhY3BpX2V2YWx1YXRlX2ludGVn
ZXIoYWRldi0+aGFuZGxlLCAiX1MwVyIsIE5VTEwsICZyZXQpKSkNCisJCXJldHVybiByZXQgPj0g
QUNQSV9TVEFURV9EM19IT1Q7DQorDQorCXJldHVybiB0cnVlOw0K
