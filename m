Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A58578A3DB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 03:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjH1BT6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Aug 2023 21:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjH1BTZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2023 21:19:25 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FF912D;
        Sun, 27 Aug 2023 18:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLX7w9OsR1vtFmxRZ78CY2Y3ScFLoI+rT6JICqZnQkO/s1BmYBRnoacB43IASJ4F41GG31KVDYLzkWKh71715cFPrFe6ue3OD1fshTMiPVdD6xEn22BxJLniIbuYgRXz0ihaD+unn422yGN+toIQBrCpGP9lhggYWw+PPc9B/QXoqNFkvNq/c4SszN5CY3zZ7PPPRLo8h1XzFRdumvQH7ckJEL9xSy3OmvOaAECL6JioeqPkpuwzNfqySZXVg9K+NtncJurD3OHN9WIW1EpMxRN+Qqb5zLVO2hfoLEcBQkRneQnJ+Na8i0lOvBNgO759jbPVctuhbQQ/Zu/OPNm4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyXSjBRf2hOF4YJcowj9vRTvtWLPoYzrE2OPm2abLmo=;
 b=ZYFD7MB2lCfE3ap5i5pLre3N6zCI1e+d+HNjnF0BXZS7mW44bKrN3/Ie+jpY5IM5mn8CbBjfOgywwzxBbXh3WzWZR7rJXRqKAq9grP5cpVMSkNcvouWvqjWK5AVZ7ouu4bu+ev1v1mx5eHJkCQ07z5m09XwOjU2WkgxqV8idKyXU9dqs112o7g3UNb+aqKzUB3zRucOWOPazLn9pkDW09piRYz0JMYnbobCBQvaVQmpGRMb5U6034F2l8vZLVhc/912noSYugyR48kW9IPvOFbwIm+xMw7nv7Kk2HDtCl4EfKMEOcPzB6iHloEaYHsTb3KuKcb2Iy+H7gP+Y9udz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyXSjBRf2hOF4YJcowj9vRTvtWLPoYzrE2OPm2abLmo=;
 b=OhIpFJE0BQLIaFUtkG5veWBTakQYoZzCwFzykWdgLVjTB8cP+1ZtHWUVW9JX7E9NEXDSHWKDTkglcEndWL6qvdLaIMofBioWIcDeya7WKxSDu15hDtqaNLmXANT5o1XnpJ6sJ4UrsKZGVM07owhKQt/QuqJFykgrriNKUaQbiBc=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS7PR01MB11966.jpnprd01.prod.outlook.com
 (2603:1096:604:23f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 01:19:17 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 01:19:17 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Topic: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Index: AQHZ1zcNtDThJaZvc02SH965eUO1lK/7VSoAgAJkVICAAS3c4A==
Date:   Mon, 28 Aug 2023 01:19:17 +0000
Message-ID: <TYBPR01MB53416B179CA1C6709B216136D8E0A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
 <dgxpl5ubvpdgtgtkokgtn23kski2j57dwjddsthv6flza7bw2j@gp6rnifrxpbr>
 <20230827065903.GA1514918@rocinante>
In-Reply-To: <20230827065903.GA1514918@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS7PR01MB11966:EE_
x-ms-office365-filtering-correlation-id: 940c591d-8978-422a-1e53-08dba764cca5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FayRbcxNlizZII51En1KAAz1xuxThPvk5bFYBd9S+3Qc5uDMpCyRwJIbvCSXkm4qcHRN9zujje+gyUhAGrgG4O3kRSYft7k/jJcDn434jW70QpOU5lvylSNhiqj8a63jIGEwTmbppcPbWwZk6rIGHd0RvlihnCgPKwR8QBXwrL1nFXC8HhWR+0Ro6HwYmiwpYz7XwqD6ro1g7hAcSl4bJVa+DdNcL9Bpt7Qb+8tuSgvnlxwZg/55UN5+1NPkZ+zlrRTTDph82LnAhsx2E06wdQvsQz5YPT02Lro+PC1IA2Hv98uZffbqWOw6KAhIJbiMGHhWjESCuYE/Pmluq4OBL4ieqtaYlPeoe3QFNGzp62cN9fnWmKbyBsQOBxnGrtDpivhnnk+z6jGXaxUfQNhKElTbBK/lHh/RIpKymPopXbcxZW24NEXFP5REW538e9iJw33Ck1/tXe0ay0Ziu4UF2rXaE2qwGXAUs+jEEBmjZotUft/SPVl8xx1plEhTo4pPj/ATV019HpWv2zvbrEm/oz4gS37+uq8jKY+SR5v7TJja/rY6M8quDDTaKMLlTU6jhXmG/HLenrsFo3CvG872BaqAMVj3HaNRi4LvFsdjmtggrxkeFAEXzBrDFhiVLpLP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(39860400002)(376002)(186009)(1800799009)(451199024)(41300700001)(7416002)(122000001)(38100700002)(38070700005)(86362001)(478600001)(71200400001)(83380400001)(66574015)(9686003)(6506007)(7696005)(55016003)(76116006)(316002)(66446008)(54906003)(110136005)(2906002)(33656002)(66946007)(66476007)(66556008)(64756008)(5660300002)(8676002)(8936002)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGVnM2RoYTBOQTB6TW84QkNmM0VzblFzUlA5NFBQZ21wak5SbnFIeTZ2Z1d0?=
 =?utf-8?B?TWh6R1dydUt3SE56bGxWRk9iOEpKeXRMOXNwQkFXbHU0S2thYUVrOHluQ0ZN?=
 =?utf-8?B?RFFtVWpnaU80QysrRUNtUVdPeUNkRGQ2S2g0Z1pWN2hHNGlKQkp0SXc2Q1By?=
 =?utf-8?B?VzJQYkpkN2J0b0h0Q3QyNnZxamdOc0E0TGZaK2NhRFFxRGh1U1h4akMybXh6?=
 =?utf-8?B?ZWhKNmRHRW5hSy9oR3dlYUpXVzE0dkxmNWdLM1BUWlQ3QU5QRDZlL1NDaDQ5?=
 =?utf-8?B?dEY0dzdiQVJTd3I1YzFLcFJZVGorNGZiTmxwRlUxWUR2alV1aTNCaTYxcTlj?=
 =?utf-8?B?RG1vUkJsbjdYdnlaZlZ6QlFncyt1d2FXT1A3Qk9DRS9FT1RJZURITHlBblNa?=
 =?utf-8?B?bkF4am1obWdHMkVVMnJ1R1JnUkpBbDFNbStXTDlFeGJRbE9sc1VwOU93UVRW?=
 =?utf-8?B?WFFXRnM3RXh5V1ErODhVc3AvMEpKY1lZOUd6VTdNKyt5eDRBd1JJd2dwSERO?=
 =?utf-8?B?TzJXeUtNajhUaVVHTHk0T0hIZUFVblZ2NGdaNHM0YmFJM3dEVEdKU2NyNW16?=
 =?utf-8?B?VnUxYTlWT3V2aElmLzNZbzNlQXhkenBJbmlRdVNFKzFDT0VMYnM5bm5ldG1p?=
 =?utf-8?B?ZjJoOFFGUVY0RHk3eHlEUWhDTHNEeWRxT2pvcCtCN3BUTUd3VFN0SGxmc3lZ?=
 =?utf-8?B?T2VWcmlRWVk5U1BFWElJa3JUVVFwMGtKQXIzQUdEQkFSeStLaE9JNHIxNTVs?=
 =?utf-8?B?Sjh0VFA3Q2t0UGFYUWEzWDQvOVBDaHhOOGR3b24vUTJnSzNxc1dvdjcrNFJh?=
 =?utf-8?B?RThDT1Z6a2VpL2hoVUxydTdidW1lQmtUV1dYWlhVYXBPLzE3YkYxYzhwalR3?=
 =?utf-8?B?eldyMFJpUVcvQ0R1cXNEOTFGMkk0dmdCKzIwYTlRalFTRlkrTjhXYmxFU0ha?=
 =?utf-8?B?ak9Tc2RzSm01K3ZWSWFWa2tlUWR0a2xESktDT2tIS3NyWnZrMm1QaVRTVWFu?=
 =?utf-8?B?YkMvbmRrNkJ3YW5ZbGdCQUdIdXpDOHlHcUhtZ1VhVEVUZmhBSGtEV0R4VzNC?=
 =?utf-8?B?ZGRIWS9zekloLzJHcjQ5OERyZEMrTm1OSC9nL1JISTdwRUJTSTg1dFVzOWIx?=
 =?utf-8?B?YXZvczAwcFlDWjQ4UkxuNENnSXR4Y1hadCswcjdiSFRTaFFyT0hXWmJWeXY3?=
 =?utf-8?B?Yi9XbWxhWlBoTXR4TkdPUkJrOHV5dGd6akxodDhuOS9hUjNEdTJJQVhKZGxL?=
 =?utf-8?B?aU5IMHIydTBuTkVQSEZRanJWekJWay9saFFqbHVxdjdiNTErMGJDdWg3d05Z?=
 =?utf-8?B?SHdNRlR6Nlcxa1NadTdmTXNqV1FITWpuc2xRVDVKOG9MZ2Z6WGxYRHBpbUFY?=
 =?utf-8?B?cE1sd2pyQlArUkZ6aUpFdGNZalYrQisydC9zTzJXUDF2Y0dyei9lTDB0Znlt?=
 =?utf-8?B?S1dhQ2I2SGl2d01UMmpmdmhyUlplaFVMUDZkWHE4UDIwWlREeTlUK1ZpU1No?=
 =?utf-8?B?M3VSMGl3TkNYRkluRTFKcFZJT3Q2Y0pFVzlsTTJLcTFUdkNBc0ZoOUZkMnJS?=
 =?utf-8?B?N1k4K3FNNktOS0MrRHoxSjNRMnE0MGNBMk1laXI4cDdGcTVYSFg4dkhPYTVq?=
 =?utf-8?B?a2c1ZW1BSGdkYUFXVFd3R09BREd4aTkydVg5Nk5HYlRTalUvVytyYnU4aG8w?=
 =?utf-8?B?Y2VCRC9WWGNSanEwclU2SGxoV1dJd25Mb25PSFBlZVk3dEhDU0VJck10M2Rj?=
 =?utf-8?B?Vko2dnZlQVVuMzFPRktBWk1jTGRiWGNLcFZiVzhHVzZ5a1M4RXNNSFhVbzI4?=
 =?utf-8?B?YkU0SXd0L0FNRjQwL1FxRXViTzMrb0E3MGo1Q1dJcXp3WkwwTFFMRzZVeVRt?=
 =?utf-8?B?dmRONUdJeFJvZ1FiR1Evb3ZjTHk2MFJDMy90SVpwaXJCZi9LT0ROQitzK1I3?=
 =?utf-8?B?MkkzOHhDMEFnamxlYlkrZ2Z5c0tVMGhOckpKc2s4ZWtnMUM0cGl2K3FNU0xX?=
 =?utf-8?B?M1ZCUEs2YlZoYU5UN3krQTA2WWVGaTJad2k5VHJGcTNNWFhUV3VlSHN6QzFa?=
 =?utf-8?B?NUZVTXJ1cUdmWCtTS2FzSDdiU29idmJ0NEFSUnpHWnMzcVAzTHlKNDV2Q3Fl?=
 =?utf-8?B?bE9xbHpoOWp5NFViV3V0MVRPZzZIc0NKZjhOUTlzTUdDSEtvOE5KSk1oUGlH?=
 =?utf-8?B?SEtPa0F4M2N3Y3o2UlF5UHc0M01Gam9aU2JnYlNpMFM5ZCsxNGhYeTZTUXdZ?=
 =?utf-8?B?WXNrdHJYV2pUMURPcFpvaTI1QXN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940c591d-8978-422a-1e53-08dba764cca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 01:19:17.4649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdHddX29dyh1xk44+EWY/hO3k47D4VtHAvetpbBmAsYk6cMIjiEWKhdvjbP+25t0OOLZJJ/hnmFXhm0/m8fJbe9t4lgMuyIoqEsDYTPY+f9oMTbnbMgKfCHkLfYAMc51
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11966
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mLCBTZXJnZSwgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBLcnp5c3p0b2Yg
V2lsY3p5xYRza2ksIFNlbnQ6IFN1bmRheSwgQXVndXN0IDI3LCAyMDIzIDM6NTkgUE0NCj4gDQo+
IEhlbGxvIGV2ZXJ5b25lIQ0KPiANCj4gPiA+IEFkZCBSLUNhciBTNC04IChSLUNhciBHZW40KSBQ
Q0llIEhvc3QgYW5kIEVuZHBvaW50IHN1cHBvcnQuDQo+ID4gPiBUbyBzdXBwb3J0IHRoZW0sIG1v
ZGlmeSBQQ0llIERlc2lnbldhcmUgY29tbW9uIGNvZGVzLg0KPiA+DQo+ID4gTm8gbW9yZSBjb21t
ZW50cyBmcm9tIG15IHNpZGUgZm9yIHRoaXMgc2VyaWVzLiBJdCBsb29rcyBnb29kIHRvIG1lDQo+
ID4gbm93LiBJZiB5b3UgaGF2ZSBub3RoaW5nIHRvIG5vdGUgdG9vIHBsZWFzZSBtZXJnZSBpdCBp
biBlc3BlY2lhbGx5DQo+ID4gc2VlaW5nIGl0J3MgYWxyZWFkeSB2MjAuKQ0KPiANCj4gWWVzLCBp
dCdzIGFib3V0IHRpbWUgd2UgcHVsbCBpdC4gIFRoYW5rIHlvdSBldmVyeW9uZSBpbnZvbHZlZCBp
biB0aGUgd29yaw0KPiBoZXJlLCBlc3BlY2lhbGx5IHJldmlld3MgKFNlcmdleSBhbmQgTWFuaXZh
bm5hbiksIGFzIHRoZSBzZXJpZXMgbG9va3MNCj4gYW1hemluZy4NCg0KVGhhbmsgeW91IHZlcnkg
bXVjaCBmb3IgeW91ciBzdXBwb3J0IQ0KDQo+IFRoYXQgc2FpZCwgc29tZSBwYXRjaGVzIGluIHRo
ZSBzZXJpZXMgZG8gbm90IGFwcGx5IGNsZWFubHkgYWdhaW5zdCA2LjUtcmMxLA0KPiBzbyBJIG5l
ZWQgdG8gaGF2ZSBhIGNsb3NlciBsb29rIGEgbGl0dGxlIGJpdCBsYXRlciwgaG9wZWZ1bGx5IEkg
d2lsbCBiZQ0KPiBhYmxlIHRvIGdldCBpdCBpbiB0aW1lIGJlZm9yZSBCam9ybiBzZW5kcyBoaXMg
UHVsbCBSZXF1ZXN0Lg0KDQpJJ20gc29ycnkgZm9yIGJvdGhlcmluZyB5b3UgYWJvdXQgdGhlIGNv
bmZsaWN0IGJlY2F1c2UgbXkgcGF0Y2ggc2V0IGlzIGJhc2VkIG9uIHBjaS5naXQgLyBuZXh0LA0K
bm90IDYuNS1yYzEuLi4gQnV0LCBhbnl3YXksIHRoYW5rIHlvdSBmb3IgYXBwbHlpbmcgdG8gY29u
dHJvbGxlci9yY2FyIQ0KDQo+IOOCt+ODouODgOOBleOCk+OAgQ0KPiANCj4g5LiA6YCj44Gu44K3
44Oq44O844K644GK55ay44KM5qeY44Gn44GX44Gf77yBDQo+IOeJueOBq+OAgeS9nOalreOBjOWw
keOBl+WJjeOBq+mWi+Wni+OBleOCjOOAgeODrOODk+ODpeODvOOBleOCjOOCi+OBvuOBp+OBq+aZ
gumWk+OBjOOBi+OBi+OBo+OBn+eCueOBiuaJi+aVsOOCkuOBiuOBi+OBkeOBhOOBn+OBl+OBvuOB
l+OBnw0KPiDlhajjgabjga7opoHmsYLlpInmm7Tjga7ov73liqDjgavjgZTljZTlipvjgYTjgZ/j
gaDjgY3jgIHjgYLjgorjgYzjgajjgYbjgZTjgZbjgYTjgb7jgZnjgIIg5YCL5Lq655qE44Gr44KC
5pys5b2T44Gr5pyJ6Zuj44GE44Gn44GZ44CCDQo+IOOBlOaLheW9k+OBhOOBn+OBoOOBhOOBn+S7
leS6i+OBr+e0oOaZtOOCieOBl+OBhOOCguOBruOBp+OBl+OBn+OAgiDph43jga3jgabjgavjga/j
garjgorjgb7jgZnjgYzjgIHjganjgYbjgoLjgYLjgorjgYzjgajjgYbvvIENCg0KVGhhbmsgeW91
IGZvciB5b3VyIGNvbW1lbnQgaW4gSmFwYW5lc2UhDQrjgZPjgaHjgonjgZPjgZ3jgIHjgYLjgorj
gYzjgajjgYbjgZTjgZbjgYTjgb7jgZfjgZ/vvIENCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJv
IFNoaW1vZGENCg0KPiBUaGFuayB5b3UhDQo+IA0KPiAJS3J6eXN6dG9mDQo=
