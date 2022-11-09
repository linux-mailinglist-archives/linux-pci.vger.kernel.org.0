Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202FD622325
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 05:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiKIEdb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 23:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiKIEd3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 23:33:29 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CA5DE3;
        Tue,  8 Nov 2022 20:33:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU8tZrGyT95+l4Nd9lTRQilu2Sq3DJmMmNAauXI8WWe9EziZp0ssA28IZO4ksVoPK3WKbdqk6eWJ5ntI9PZ3U1udOoldPKE/fS3maK73Q3ixbhSwk1dX4kGyO1BIc+UXvqhn35OIKf1Uc5nffBMvsK+/xt2R060dDm+UC3mMhFBsHQeJs68NbmaITJ4RGu5CHiwaZSu4H48eNTCXaYsKdBSEfbTyCWxf76o7jmlTfn+pj/XBINMr7Yg48pB89Ijxsjdg/HwWbDsI5wkAZC65UwJX/MZOt/vDOm89Xludv81OrdJTMYTvyiy2ZnuHJs2ag4JLLnb1nFzYrhGy1e/jjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGKCY/o/tQC7T+S6l4s4m/8j6tPLB4Ky7G9TZkyh30A=;
 b=DaX9PcGHWaS+uByqXqGnfSaYR3UnbL+Nm1MhNqGTCdTub0iv2aI95eMVHrdN9gQxlq+QziCVnq1nv7tkCUVf7DK6ozO1xv3pDHKJC0zk1CARHMhavR2UVaJl0XdnstcKqC9B9rVnUxKrYVcun3pNgsrebgz0MVSswYkZrW7sfdAY9wN6MYUyEiGq38DXLJH19obSZKdvS20DOoDxAHkm2jLITmq+nlIAnjRPZ8ecffoMaSKpqqraAIYnjIiNQ9Ws0nGSuSAhtIzA9OK91jMfmnBnQ/vXkBX7VN4HD1T1bjYLtSyniMGLYBCRDu8fzQzmXsrnTFITjpr8XGk2pamlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGKCY/o/tQC7T+S6l4s4m/8j6tPLB4Ky7G9TZkyh30A=;
 b=bC/wLTgph+ghrDvbgCLUEafdN/BLsPvaOqZ4kGmzGtVUlOPirhXg2KAeBnDMS/0j29gE4sXgOsDa8aBGhLYscrQCAtZZzj+YcaLA3+nU3L0d1DpyTs8AGXEadAL7zYzQcZdLNX5OM1NJrReJfuFsIiF4MFLGZp+Ao/YBimhHfpw=
Received: from CY4PR1201MB0135.namprd12.prod.outlook.com (2603:10b6:910:17::8)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 04:33:22 +0000
Received: from CY4PR1201MB0135.namprd12.prod.outlook.com
 ([fe80::29a6:375b:4987:c029]) by CY4PR1201MB0135.namprd12.prod.outlook.com
 ([fe80::29a6:375b:4987:c029%9]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 04:33:19 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v5 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Thread-Topic: [PATCH v5 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Thread-Index: AQHY8yVkJp864laPcESv85G6ysuAya401qeAgAErA3A=
Date:   Wed, 9 Nov 2022 04:33:19 +0000
Message-ID: <CY4PR1201MB013577DE905AF12D1F5E03BA8B3E9@CY4PR1201MB0135.namprd12.prod.outlook.com>
References: <20221108035030.1040202-1-thippeswamy.havalige@amd.com>
 <20221108035030.1040202-2-thippeswamy.havalige@amd.com>
 <d45ea394-5c51-2f95-e5ef-641af663fbb3@linaro.org>
In-Reply-To: <d45ea394-5c51-2f95-e5ef-641af663fbb3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR1201MB0135:EE_|BN9PR12MB5180:EE_
x-ms-office365-filtering-correlation-id: 497c9020-33cd-4f9e-ee54-08dac20b875f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TD1qocq2q5/HuJbRab2hMfRhpreVImkhiV6nI8szx3DKmyVid/f1i10qvzH8go+58Q08cHBiGYyueB70JjYAXvNTNPJ3GlIUqIkwI/z/aGlPVGv8CfoIOZ6I7LoBL8lwXOPYu676L2JuwJLGaCncJ/dlW3FvNv7fgv+QktJz/4w7N6oUMs0WFhDWqgEJd33fQAHeyneFv00TBSVImWHn1LxNtXdey6qWbJRuEqUDpIpSjmdbhLpwn90zJcxoj3D4dfaFKXP2nU5u3wfJicQ+IWcWEOPjWmOMxvVTavrp1rS+ijfQ3fzsUXLdHE+wO8ogrRlvmMtsnRcxCkQmY9dKgxQ8x3I1uBHZ2e1Cq6AmOg6MdgirqIiTIm177rgO4FyqgeUcUj8y7pXagJCq/W/DHEH1IWQehRcQ8asUhezoMmAl5d2OaL381J/uk92j3m2R2MK6lpbHE0e+iaiIZPjTYo/3IaBvBmO6svEpr4GmtThSiLY/xQ2ltHLC2kTYdM6h9RLVpJDa1fBDnmNAP7PZ2DVk2nNoy22yiqos6VF1sApft6Xx8w70lJKWSEzIu32u/L+P//PmC3ENapJCNUu7Ao4JjY2ajUhyn8Uol4fioZwgO2QnSUwVX9ssWY+q07u3kgu6G6k0/iDvNMIPdZ9MMA3xWVp8GWRhJFNHaVCcix2ziUDLA7Kjq9Qn3YtEoel6U2ojX2loBmV12A1tyWcBM1aJRlCrUdcBkROQsWiNwSSt4FEFbI6icmI5nBWCF2KnaM5NrdLuUyESWgKc4/2Now==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0135.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(83380400001)(66446008)(66946007)(55016003)(66476007)(122000001)(8676002)(54906003)(110136005)(316002)(4326008)(76116006)(5660300002)(38100700002)(64756008)(66556008)(38070700005)(4744005)(26005)(9686003)(6506007)(86362001)(7696005)(71200400001)(186003)(52536014)(33656002)(2906002)(41300700001)(478600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUIraFhxdEhyVi9qSWVndlhmUzAyT2puMncvNFkwSStHc0hhSDhYOW9kM1pY?=
 =?utf-8?B?RCtNckJ0SVJQVHRlb1ZCTnQ5UVdGVEd6d0lXdjQ5UCtveUhFb2xkekc4ZUFB?=
 =?utf-8?B?TmtKalY1RTkwOHlsYW03QkRiaHUvdmNueFJmTmRyU1VhNURHa2VlekR5RkdW?=
 =?utf-8?B?TkI3amIxaVBnNDI0MlRORDJtNWUrdklJaE56bFVDbEJKSThtVEVoSnlUbUxO?=
 =?utf-8?B?NDVLWXFnazZrcnZmRHdwcnhPSVI1VEZuZWtPNEZ4SFBoRi9ZejZDZTQzSCs2?=
 =?utf-8?B?MVBuTFdkR2o1WHpudjJnNk15M0xxbjc4d09wNXZ6WE1Va2VobnBRSkk1YU1h?=
 =?utf-8?B?cFlxbFYxNCtiVGwyRlRDa0VoKzZaY05sTEVGa3orb2VjN3h0OUtnb1NSU3hK?=
 =?utf-8?B?dTNsVU04MXlzMzdYZWoxM3BDU08xSUpMcXhkVVhmaXVoTDAwOVJQWUJzS1p5?=
 =?utf-8?B?ZlBSZHgwSkQzWkVHdTNsUTUvTTY0bkxNYVBoblYxOHRDSWdVUnpqN3h0WTU3?=
 =?utf-8?B?T29Mak9rUEYyeXBnZTVTOG9nZXUyVEJESWRHNGdIQWJhOFowb3MrWjRtZDF2?=
 =?utf-8?B?UTNqTGtTWEJKN2t5VDl0SmlEdXVmOVMyYndBeFFDQ2tKZTBiUHpXNWxoQUJu?=
 =?utf-8?B?dlIrT1FJcDVFNFR2RzNaUVFuZXkzQ1VEbTVFUEsxUk0rT05Fa0JYU0VSN2F3?=
 =?utf-8?B?VHlNa1ZoeEpoblpaQytrZHF3aXhUZ0tJbHVGNGJiTnNWNGFrMTlqaEJ6VG53?=
 =?utf-8?B?eTllTFBZcVhTR25FVmc1eUxwekRWakZKRVhLQnozTEhTWWsvVlhqS2xnQ0ZI?=
 =?utf-8?B?Q3p0MW4zVWtFMmZqWGFwNkVlNjZhTjlRZmdmVENocE9PQU0wZjlwaVRTODhk?=
 =?utf-8?B?VmVSR0ZPN3VNdHM5VjJ0YTRKMkNRMGUwSWRWUHdKQVhGb00weHZ0RThNaCtW?=
 =?utf-8?B?QWZHaTRoNjQ0Z0Z3YkhjTCtRYUt0b3FXb1NDemU3WEp4Rk42T0FsZUlPODZF?=
 =?utf-8?B?eGJDNjMxUlZPbnoxRGZlTmdrbkdHN1JTOFgvOEI5NGdlTjVGaDYwMzZUMVhO?=
 =?utf-8?B?TVMvN1ZEaUZSdFowMjQrbzExVzE4Smx4blF5eEhjdWdpaDRnbDNlYk0wbXkv?=
 =?utf-8?B?Z1Q5Wnl1RkNTZEZaYUJGSFJkTElGQ1FiUGhmWGdxZkt3eUlvYTZ5aXQrNVVS?=
 =?utf-8?B?SkNzSUdlRENVWTllSmhjaHV3SnVORlZXMjNTTllKdERJdFo3QlFtQ3VERk4y?=
 =?utf-8?B?THhBczdJNitOek11N3kybTFyM25iSURscXpkV0xpUmZYeFpiQk80UUw3azNR?=
 =?utf-8?B?NjMwc29GWURHN2xESFlXbFBTanlNNXNSQzl1c2dxT29VWmtWUytQWFdwd2RS?=
 =?utf-8?B?ckRPRFJ6R3k5c2lzdURhWStXaWxrMTlEY0NXOTFndjJ6L2tjbytNbzB2c08v?=
 =?utf-8?B?YUZMVUFmd1RGNlJ3YWhLMHQva0FIcUdVc0FIZVhCQW1oM2tTaTcvbmczbXBB?=
 =?utf-8?B?VlVjQ0lyV1M0WkZ1aW15TVZGZFlCL1NWdGVIbUZyeEVNZVJidmkxN1NGbWxx?=
 =?utf-8?B?K1Budis0SW5oMUE0YVdCbWFhRGV1L2hzTWNzSFljQm1YYWlvbGpTdEFKU2Zk?=
 =?utf-8?B?aDhFdzRKMnBKVXA2dTBqRTJTa1NJbS9Ubk95ak9qbWh4YlVVL2tDUVFmRHlv?=
 =?utf-8?B?eXB5TkV1UW00Y01xanhtdTU3dDhUWnQ5dlRBeXZZNTNPM25ualQvYndRU2dX?=
 =?utf-8?B?Q0kzd3YwajB0MkRwYmV1QjZFZmFvZGRYcSs0QkI4R1lQWUh3NjE1Wll6SHl6?=
 =?utf-8?B?VlRCamFZbmY5Q0tlMy9JUjhENUk0S21Wakl1c3ordnVpSHdld09NZkMzMTdj?=
 =?utf-8?B?S1JnY0lEQlo0RFhNNVA4RTBKMkNHSTl5Zml3UWxrRWlDeUVSRWtuWUZ5VEFq?=
 =?utf-8?B?c3NFeXZxS1N6enRkOGNlWmV3blAxT0EvbFVQMFdOUEFmbVpJYnF5YzY0THE3?=
 =?utf-8?B?Yy9ZKzQ1L2dwMG44TG43Ry92UXBTbVUrQmtVU2ppbkRnNG5qcmRrUzFrcFNU?=
 =?utf-8?B?U21kM2k0SWFjZU0wTTlDTjB4Sm1uQlAwblFTV01za1ZqS2tsSVl0b0tLQjNa?=
 =?utf-8?Q?mtPI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0135.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497c9020-33cd-4f9e-ee54-08dac20b875f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 04:33:19.7673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pu00YKaCvLMfeqYWFmaK3qQw1IEUSDkKcSZCsMBSMBsos7MnAGoDWJOsslVVIPRIAPxnsGHV0KhCnB88K5Hjrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQoNCj4gPiArICBkbWEtY29oZXJlbnQ6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogT3B0aW9u
YWwsIHByZXNlbnQgaWYgRE1BIG9wZXJhdGlvbnMgYXJlIGNvaGVyZW50DQo+ID4gKw0KPiA+ICsg
IGNsb2NrczoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBPcHRpb25hbCwgaW5wdXQgY2xvY2sgc3Bl
Y2lmaWVyLg0KPiANCj4gVGhpcyBpcyBhIGZyaWVuZGx5IHJlbWluZGVyIGR1cmluZyB0aGUgcmV2
aWV3IHByb2Nlc3MuDQo+IA0KPiBJdCBzZWVtcyBteSBwcmV2aW91cyBjb21tZW50cyB3ZXJlIG5v
dCBmdWxseSBhZGRyZXNzZWQuIE1heWJlIG15DQo+IGZlZWRiYWNrIGdvdCBsb3N0IGJldHdlZW4g
dGhlIHF1b3RlcywgbWF5YmUgeW91IGp1c3QgZm9yZ290IHRvIGFwcGx5IGl0Lg0KPiBQbGVhc2Ug
Z28gYmFjayB0byB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbiBhbmQgZWl0aGVyIGltcGxlbWVudCBh
bGwgcmVxdWVzdGVkDQo+IGNoYW5nZXMgb3Iga2VlcCBkaXNjdXNzaW5nIHRoZW0uDQo+IA0KPiBI
aW50OiBzYW1lIGNvbW1lbnQgYXMgdjMuDQoNClNvcnJ5IEkgYXNzdW1lZCBpdCBvbmx5IGZvciAn
SW5wdXQnIGFuZCBub3QgT3B0aW9uYWwuDQoNClJlZ2FyZHMsDQpUaGlwcGVzd2FteSBIDQo=
