Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6D37AD46C
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 11:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjIYJWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 05:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjIYJWO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 05:22:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92D5AB;
        Mon, 25 Sep 2023 02:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f13yFIDIefiSadnrXAFFBTVS7LwBNPOA0SuOv8hERJbuulzMYIrMpq24ziz6yzzhdq/e1bv6faXXN9iy9R1IwaM7rsccgILIGlw1otSrCsPOH/vshUAuMnvAZ325CI9Y0BYfyGGPg3INfOLUSAZC74yDzllmdSOSXRPKfs9vW8QuiF81BEK2nOc8MCvIbZFzEPfFkF8TWbgYdw4sCG+4Q1++q36tun0qURXhSk9rGKlFiW/wMIUhI/NRHbWEY8m4yzfE51PgZb4t51NrEOVd2PV2B21/yqHKUlBeh4zfTVKAnKxFMztNSkiH1rMbyqrN2bpsNWK7toP2FNyNJA8zaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjhaNN9b4cPMWG2zXi/EiRfvtos4kref0qVLF+q9zlU=;
 b=SN6gFRc5pwJn9uQaYvaSGiXUV7IAkkWOskiCsbZtH3F1ne8Efy6EynCUb7gm6Z/bzbbKrlqOfuaNMYxqMUk8wSTHS7bKojy4jaW/YxOYK5xcWGIDpoJIgLEqvn2j4H4k6lanomdZLaGfLtMfGI8rdFrzrWPFKWxHE2KNJVNqnLlZhlfa9YUtrRYn1YvyEH+8sY19fPBu3q2R5drX+qvdP379YI15dXFFpmm9oNuM6HG1HXOypDc70PDFxagf3+tHQfph0mC0M4SL4hr6ytfon3qdvPhsajS9SRs1EXe3oVaaTqkUECzEDDUTQulwIUbRGcKCvOb1cqSxavUWkNPshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjhaNN9b4cPMWG2zXi/EiRfvtos4kref0qVLF+q9zlU=;
 b=ySel0UoxN50sWhHAdSZIFjfYvlDd6LzXbPjagWc8cpuMze52wkTTO4DFuBH8YLeFR6rMNVufzJ4uRIjxfxQRoJqWzUPAGipUttd9ntLDICsMz+dz+ykjBfiEFNv66DbeVkAAeCqYHUsJhDuqPLupksN1BgfiBPHSK5oM1keC/Cg=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 09:22:05 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::167:7f5a:82a1:e2b9]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::167:7f5a:82a1:e2b9%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 09:22:05 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "kw@linux.com" <kw@linux.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v7 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Thread-Topic: [PATCH v7 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port
 driver
Thread-Index: AQHZ2yFzmgP1DqzAKkibvVhsFiULHbAOF90AgBQp44CAAZIlAIAHmMIA
Date:   Mon, 25 Sep 2023 09:22:05 +0000
Message-ID: <SN7PR12MB72017F144833876216DE74F28BFCA@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230830090707.278136-4-thippeswamy.havalige@amd.com>
 <20230906172500.GA231799@bhelgaas>
 <SN7PR12MB720159F33F53B40453111D128BFAA@SN7PR12MB7201.namprd12.prod.outlook.com>
 <c53958d2-d7bb-c859-b4d1-37e7c61f6107@linaro.org>
In-Reply-To: <c53958d2-d7bb-c859-b4d1-37e7c61f6107@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SN7PR12MB7911:EE_
x-ms-office365-filtering-correlation-id: 0e0ef9c3-d0a1-4e5a-0390-08dbbda8e263
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kvokDqOmvIw9ngUvVuCao1UgPzqR02ThRD+M+eL1lVPpvJUdg6GYBSP+7TRSEgsGNlZe1uVAnoyX+4mIU6yYPXAb0/1vOpz9spTh62BwQDwBWqpGkeQBHZuQYzRE14u0a2dgUVzsHfTkyGvDGaPvXtA8dl6MapfW4UVxfiSaj2DsPCHRNZEsluVLFsGOMRBlZa7ZFf0rmvVCqzsmOHQEAuWZ6U+jJzQPrAvDQtI61mmCtbJfgtTMhNedV/mn5BHoXGh4Cp66Qkgjz7T8Nr0nt1MfJG35pc7rz9CTf4TR5GKnoWfl1LE6oN2DGjSs5/XkoxR1LL3X4Zx5MXY2KrvZl+qcslhtDNIg8mQGPZeYcN8zG2v1Ann4J328Zh4k0tBoanzE39VRW+1LBh8QQ+l7ww7lySHFiQQ0zKxKc4gtugRseRXXo+fVbfrCPo+SpvB6wQoovdPnmnCN1ulGIwm/ktRqB2Rh0hoQEHq3AR4GvNVoVrudZ6cF8EWb6Su+jYybT5O5lMhdJjGAo052NMAYJvLMZHK6IeVFR+G1hegV6BOj1JY+oeffCCnPuVuQ6G7J0GeUK9o0emJwErDeX4mElYJp3QgRbKqnIOug8WhRlTEpe8KQm9D/a7svFJhM0eBa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(55016003)(2906002)(83380400001)(7416002)(38070700005)(122000001)(38100700002)(7696005)(53546011)(9686003)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(110136005)(76116006)(71200400001)(6506007)(52536014)(26005)(5660300002)(66574015)(41300700001)(316002)(478600001)(8936002)(8676002)(4326008)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW55Y2Nhdk1qamZwaXd4SURwRGd2ZHZnV01hQ3hlTndPRFdFQk5EcVNJdWM5?=
 =?utf-8?B?RTVqYUg2K3c5OEFKRUhLUkpheFVmUGNWTkdhaXg2UFVlYS9uK3NNMnVIMlNn?=
 =?utf-8?B?eDBsUkZRODFnd2U3NDVnVEpzaDRtTUZMbkVyakxqS1R4T1VLSTRLU2xEV0dF?=
 =?utf-8?B?WHdoMmpLVDhqenl1L09pdkh3d2o0Z09wWGpveDY0UkErR0xObnNsQTZHMUE4?=
 =?utf-8?B?QWJoQXFhNXVEdDlDcTkvTDNyMGFWWjdMV2tBRG9udnNGVW5CZHZqajhKbDZC?=
 =?utf-8?B?MFoxRHFMRDBzWW5hNSt0VFphc1RCQXF4VWgxTEFvcXVTL2lESUkwdHhOUnVO?=
 =?utf-8?B?c3VpWlpJN0p3STcvaTl1WS9Sa2x6RkhPZWovNlRuU1R0azRnZWFQbDJCbitr?=
 =?utf-8?B?M1I5Y0ZudmFQN0VJQzd3WnNKQnFFa3R0Yk9YTk9FVi8wMThUSi9EVlVBa1BU?=
 =?utf-8?B?cnpYZmFEVlJDaEkxSTBJU1ZhYnJJZkhjYXoveGgvam5JQUVacXl1MTd6VFlF?=
 =?utf-8?B?SWpXQVRIVDREQ25ITG84UFQxWkoyQ1R5Yy9pTVJ6NUI3V3cybzBRNTFsNWlM?=
 =?utf-8?B?bmVmNTdSWk9oc2d4SmJhQ0l0b1YwRnlEbzFXQVcyL1VzOFlOK3RSRXNCdHJm?=
 =?utf-8?B?WHBlMlIwMi8yL3lnLzB1c2F4cGM1NHBGZ2FqdVpwNzJIYzVxSXhNc0tROUtu?=
 =?utf-8?B?d3Y4d3lwcVdzMklKWEpWV21kSHV0OGVCMXB0OEl2S0k1MW12ckNlU3ZYSm9o?=
 =?utf-8?B?RXV3c3U5V2k3bjc5U3pnRFgyS282K01GNHM1Lzl3Umh2eEpkK1JpZkJqVUMy?=
 =?utf-8?B?YnlkRlRtUHBKa0xidTlHNExxSk1waUZERmJVczF4ZlczNFpnRDFwNi9GUXBZ?=
 =?utf-8?B?Zjl3QVk4NUo4ZHlUZTlDS0tnYmJ4K1VGRGlhNlFYMmErU01QcWpqWXRnc0sz?=
 =?utf-8?B?ZkVuazR5N3BTSTA2RzlpVFVjUmZBN3hCUEJnYkM2M3ZKVXFEMXZ0N0pmVVVv?=
 =?utf-8?B?TzQ3cGNqNmZRZmxONm81SS9TZHZqTHJXYmZ3UStSSldSUlFWNnRNdHAvaDJ2?=
 =?utf-8?B?NktPUEJQVG1YNUpZdGpEME5tQU9oclhENHFrd1pRNzVZTTBTRjB1aVR0ZHZ4?=
 =?utf-8?B?VWF4Zjh4ek1vaDRFb09ZaVdSZ0JkOFByRGdrK2RGMnFmN09vcE82R05GSWgr?=
 =?utf-8?B?dTVuUHFUN3loUWhXQzFCQVIrMjlrbmJyc1BCUVNPaGd2aFVxVGhSdFlRbGU2?=
 =?utf-8?B?WUZUTkY5MTM0T205T0VtV1JqMzE4bnBlR2tRK3JUcXlqU1hmS3BGQTZRSTBJ?=
 =?utf-8?B?dm9GWFgxd01SMXk2RmJJYmJRK0F3TzNEeDBMSmxuWXI4U1hWRlZBYnlLRzNI?=
 =?utf-8?B?bG9CbmE5Wk1od0hISUVpSWVKYU9iWWJ1K1hBMTRadFhFeENoWUMyK3lnR2p0?=
 =?utf-8?B?empScmFobVJPTVVoOEd1ajBtcUhDVmM4OFNlaEJvekpRdEJqaGxGZ0UreHV2?=
 =?utf-8?B?aG1vWTdDbjhvN3U5YklycUc2SGtOcFlCd0FLbzY3L1Z2a2FxUVcvcis4eTU4?=
 =?utf-8?B?NUFibFRBdHg0YUdvMFduNnFHdjdFT1BxRVFtZDlxdHRpSlI0MVc0QUx0eXlx?=
 =?utf-8?B?Qmw4ZzIrc2c5bGNreUNDQ29oOGljVVhMUDFDdzE1YzZJRjFMSjI1MmF2b3N5?=
 =?utf-8?B?ME5zUUJOaUxZSFBKeG1BOGE5K2drbDVEUmVvMWg5NTBVaXdXb0tDRTBTNFNU?=
 =?utf-8?B?dW1RZ2k5YmtmQ0xKZk9NVTg3cFdERXJuNWtUSjkxL0x6LzFNZDVRckZoS3Q4?=
 =?utf-8?B?ZFZkN0x1V1Q1aUphZ2dJcFd5NkIrbmlVTG1wQ1N5V295ZjNqK1JwWFdzdWxG?=
 =?utf-8?B?dTlaUnROZGRHWHozbWNKSGZlZ1ZycE5xejBiQVE0bEw2YkZ0bkVMQm5DTURX?=
 =?utf-8?B?NjQ3YlFIak5nL25CL0NZLyt5TVpldlYyVDVhY0ZBYWRrWTZUd3R2TTQralNk?=
 =?utf-8?B?QXVZTDJHYUlRNVQ3cGY5MUE3VnF2amhDY0pvMWs2UXVOSXVkVWdiN0VnTzJu?=
 =?utf-8?B?bGdHQkVUZkV2UVNEZWh3RFVPbjIydUFMR0xIZlpMbFhjKzVUejk5bko0VGdR?=
 =?utf-8?Q?kEic=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0ef9c3-d0a1-4e5a-0390-08dbbda8e263
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 09:22:05.3227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQRMRXLtPwHxxNk1MWoZWaAdo0HZJ+KiMaBeol2OcSERibJBU6rK1E7H+1im1d2rVeD9wTkM+7pWidR8Rihzhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

KytLcnp5c3p0b2YgV2lsY3p5xYRza2kNCg0KQ2FuIHlvdSBwbGVhc2UgcHJvdmlkZSBhbnkgdXBk
YXRlIG9uIHRoaXMgcGF0Y2ggc2VyaWVzLg0KDQpSZWdhcmRzLA0KVGhpcHBlc3dhbXkgSA0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVt
YmVyIDIwLCAyMDIzIDY6NDkgUE0NCj4gVG86IEhhdmFsaWdlLCBUaGlwcGVzd2FteSA8dGhpcHBl
c3dhbXkuaGF2YWxpZ2VAYW1kLmNvbT47IEJqb3JuDQo+IEhlbGdhYXMgPGhlbGdhYXNAa2VybmVs
Lm9yZz4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsga3J6eXN6dG9m
Lmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiByb2Jo
QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IFNpbWVrLCBNaWNoYWwNCj4gPG1pY2hh
bC5zaW1la0BhbWQuY29tPjsgR29nYWRhLCBCaGFyYXQgS3VtYXINCj4gPGJoYXJhdC5rdW1hci5n
b2dhZGFAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAzLzNdIFBDSTogeGlsaW54
LXhkbWE6IEFkZCBYaWxpbnggWERNQSBSb290IFBvcnQgZHJpdmVyDQo+IA0KPiBPbiAxOS8wOS8y
MDIzIDE1OjIxLCBIYXZhbGlnZSwgVGhpcHBlc3dhbXkgd3JvdGU6DQo+ID4gSGkgQmpvcm4vIExv
cmVuem8vS3J6eXN6dG9mLA0KPiA+DQo+ID4gQ2FuIHlvdSBwbGVhc2UgcHJvdmlkZSBhbnkgdXBk
YXRlIG9uIHRoaXMgcGF0Y2ggc2VyaWVzLg0KPiANCj4gS3J6eXN6dG9mPyBZb3UgbmVlZCB0byBD
YyBoaW0gZmlyc3QuLi4gSSBtZWFuLCB0aGUgb3RoZXIgS3J6eXN6dG9mLCBvciB3aG9ldmVyDQo+
IGlzIG5lZWRlZCB0byBiZSBDYy1lZC4NCj4gDQo+IFBsZWFzZSB1c2Ugc2NyaXB0cy9nZXRfbWFp
bnRhaW5lcnMucGwgdG8gZ2V0IGEgbGlzdCBvZiBuZWNlc3NhcnkgcGVvcGxlIGFuZCBsaXN0cw0K
PiB0byBDQyAoYW5kIGNvbnNpZGVyIC0tbm8tZ2l0LWZhbGxiYWNrIGFyZ3VtZW50KS4gSXQgbWln
aHQgaGFwcGVuLCB0aGF0DQo+IGNvbW1hbmQgd2hlbiBydW4gb24gYW4gb2xkZXIga2VybmVsLCBn
aXZlcyB5b3Ugb3V0ZGF0ZWQgZW50cmllcy4gVGhlcmVmb3JlDQo+IHBsZWFzZSBiZSBzdXJlIHlv
dSBiYXNlIHlvdXIgcGF0Y2hlcyBvbiByZWNlbnQgTGludXgga2VybmVsLg0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
