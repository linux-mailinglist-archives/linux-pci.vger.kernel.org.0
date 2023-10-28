Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5F67DA6DA
	for <lists+linux-pci@lfdr.de>; Sat, 28 Oct 2023 14:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjJ1MLM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Oct 2023 08:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1MLK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Oct 2023 08:11:10 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640BBED;
        Sat, 28 Oct 2023 05:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698495068; x=1730031068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l+a6BkNK9wAAk5Kc3aQopMORVN7NbsgnD8FgTBfeUWE=;
  b=bcvjO8cW+hpoL1lqgTdgozF/TJzauOKC3Zm9MNc2+d+4wDv2GPll3psW
   FTQbBqntQExZrk7FjCQHXHa13FUJrBOnGOLrVCxFh/kXiuE1rYAYNoeT+
   HZraGlO8LZKN1Fo1x6Q66lMQZ0lmv3M/kWMxCFNIDp8x39CgJkpgjc++2
   KiPOA4TTQN9XKzQwnLvpildsBRHC2T8ecEKCN79q+SfPoK3/WwKBIo0Sy
   9AvYS67ZfU17rd0HmtE521rGks2S6OR6YYVOHL5nr5D0U7yPqHmsNxjuY
   TRFwP3ECf4WAQ+TUTB6ENlMCQhzDKdHIWIvl2s6ohAR7kM2rPYCJ4EhrL
   A==;
X-CSE-ConnectionGUID: y2aKXO4TRGqZJ9xnBiG7OA==
X-CSE-MsgGUID: rJVsWGEiSoOHC/YDMx6l2g==
X-IronPort-AV: E=Sophos;i="6.03,259,1694707200"; 
   d="scan'208";a="935054"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2023 20:11:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+RkvRdMkaUr4sLO44mOE8H50fNG6xKmIFK331+NunP8TfqVjns+iRPNlMimOI5fEJPEFGbJM4mhycfXzdWFGwwGJ+cnygQtvCnmG6LWI0SMnmKyKeHqzZqHVHXVL/DxiYRYkfy2xytJff5UMjDxNygrU/v05KSOueSDAQEaCGJkDwjqCvN2XeiWSCsQ5yDpKZZhCOyo81+cLz5u2wC/yRPZ8013tULZVKli9DW+CPazAZA/lFkVu/oO4kp3+W7zvjNl45/nSXsbQSw8h27AtU82CVwh++s06wBeWtDHlh486CAS9OTtNz3M4MSPguCnpZ5DL2ONQBdATdY5TTKP0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+a6BkNK9wAAk5Kc3aQopMORVN7NbsgnD8FgTBfeUWE=;
 b=F9EBe8183vVGIjfoSm8X1J7GNFaD4Di1k4knakxAtMTzO6ylUgK+O7MpT7zB93NjohJtGg/ZBQNan0wvCrqg19PtKCd+/CLLJhZnAe64phsCle0oTMe4Ob/tHdI0L6H5WrfRM4uHB8e+rWQMjR5MIkMPaGmAxYdPJnZ8XhSrklZjCFXI4w6uZhM+fpgGT3OZS00MCGrVropr1PPXclPBzuvKQiHzJRQy3zR8wLiUabhlahGxDna4U+cWJbWdGnud1J/uQyztfmygSDibBT+ZZ0jruJp8Vgpk+imQ26NrBWhLfk6EOrBaLvmKk+QH7y7ZkkHgHa2882R+KG2dnKuG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+a6BkNK9wAAk5Kc3aQopMORVN7NbsgnD8FgTBfeUWE=;
 b=kuc0MqnezVBHERgMAp4CS0x3XIXVKhR5J+zks4BioqrXmafmt8x4M/M28bNIuUqJ9TpmcJvskJy5WXokx/5sI37Us/5oG2pHgTpTZQmVqXezcCKyRcOK6MW/lObvyxBIz15PYuszhdBSQZXekZ5v83D8Tt54LY1XotINlVn9kac=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM8PR04MB7927.namprd04.prod.outlook.com (2603:10b6:8:3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.24; Sat, 28 Oct 2023 12:11:03 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6%4]) with mapi id 15.20.6933.019; Sat, 28 Oct 2023
 12:11:03 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Niklas Cassel <nks@flawful.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: dwc: rockchip: Add mandatory atu
 reg
Thread-Topic: [PATCH v3 1/6] dt-bindings: PCI: dwc: rockchip: Add mandatory
 atu reg
Thread-Index: AQHaCOW0DNtJxIPHQ0SmB6+3W+fCubBdyw4AgAAEfICAAA2dgIABQK+A
Date:   Sat, 28 Oct 2023 12:11:02 +0000
Message-ID: <ZTz6VaFtO28JZw48@x1-carbon>
References: <20231027145422.40265-1-nks@flawful.org>
 <20231027145422.40265-2-nks@flawful.org>
 <CAL_JsqJh6aJb7_qsVnVNEABBg2utf0FPN+qYyOfsF2dAfZpd0w@mail.gmail.com>
 <ZTvh51PGCBhSjURY@x1-carbon>
 <CAL_JsqKu9VxUrEbvyV0EFi-HhXstitu1sk0jQpbYqTDKY4N3=A@mail.gmail.com>
In-Reply-To: <CAL_JsqKu9VxUrEbvyV0EFi-HhXstitu1sk0jQpbYqTDKY4N3=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM8PR04MB7927:EE_
x-ms-office365-filtering-correlation-id: 6c69f4d4-338a-4c8e-e774-08dbd7aef48f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jOxYtSZVV+Xbk3pxjcy6mkVptAmQyZG/4ojM+SRK0teZlG3SbPgGDiY0vTHsMqYXx8UZjSx1rzot8wtY2r+NNin30XEr480lS4ysjyZZKwhr1kr03+cn7ahQPGtUIR4IH140z7KF/rkeVLte16LAK1tcf+1QHtrkvXeU6B3H3B4exAFxkYsjSR6VlkxSzAn8BTaUeXPfqKw8BPoLyyX09gTkv/NdKQe6BJT2a6iXZFe6wwOKE5IzfVwmMvVtXmAOiUdNoqNvg6SrnWyarGFYJzK3QzV3wZpUW7Jr9e3T17m+lQvBpq+fR8xFN1rqrZNehQtz7Z415d1QJ24hyRsXiS3+ww1ewhn/auQTd/g6q2q720LDeua/nmZNFWJLeSq8K8seFfNA/pjNxCMje5gQ6Pxre3uxfXyr1TgPhFXTJDxeE8+zewM9jPf9WDYW0rfFdKYf0/ayYVUiLLnGJQkIdeKrynyBgXZy9peg+6U58iWTVFTLs85T6tkILpr9oOxZY5t5jA7Gq35jNa/2m9nyZQ90+Azo1TRKfJYVZ6eHRB6QDk5jHheksB78aFCYBAiuHvJobmVeVo8m/Wr2pzpBDeeICN+XybZ/3upiFWCJYbRR5HgKsyt0aiHr0N92PytT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(83380400001)(6512007)(6506007)(71200400001)(9686003)(478600001)(53546011)(6486002)(316002)(26005)(7416002)(2906002)(5660300002)(33716001)(54906003)(66556008)(64756008)(66446008)(66946007)(6916009)(66476007)(76116006)(4326008)(8936002)(91956017)(8676002)(38070700009)(41300700001)(86362001)(38100700002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVF1cUxvSCtWWlc5RnNFc3NiRkFKUHVvdXJac1BGcWJkbGJVejRieUhhbUNF?=
 =?utf-8?B?K3gyRTEvREVkeVJmWTJ2YVJEOWFPbmtzYkttV2I2dk1FZHNETXRmdE1aZFZY?=
 =?utf-8?B?R2gzWlhxS1owdE5hTlVOZldlQkxvVHVMZ0ZzM1J1U1ppQ3p2emZRbTZKajRu?=
 =?utf-8?B?Y2JBU1hGc1U5WmplWnNkb25JWmZDTVhWYkdOeFgwZklvMWRxeURPMm1WV0FW?=
 =?utf-8?B?VzJlY2tsaFpvT2xnMnlUNjRNV09wOUltZDRGS2hFV3RHVi9XK0ZiOXZqNFdF?=
 =?utf-8?B?U2hvOUU1VUVtUGVlWmh5QkFPSUdqSXJiVHUyMnhWYjkvTFprT0tOR0pSc3VV?=
 =?utf-8?B?WGFFRjB2cGszcTIrdG4rNzFyWjR0S0VBS2g3bnRjNmlrMHhPYU9hdUlwQUQ4?=
 =?utf-8?B?RWNTMStCcExPUHJONzBkNXc5SHRhcGdjZmNZVWROK01QVWFuU2xjMmlucWdh?=
 =?utf-8?B?Q2N0ZjlMK3NKTklibm1uRW5aLzlpN1gxSTExUFBMMGlhMjRTQWdPSzlSb1BW?=
 =?utf-8?B?TTJTbzJCSkl4blBNTTFxcFJ6QlJWazJMNitlSDcyTTBaSmRnZ1ZuOGNNVW4v?=
 =?utf-8?B?YzFjSE00R1F1K2tIYzJIYmtBM3R5Mm1XdmRkUDUveWJwdGlxbVE3ZE8vYlpN?=
 =?utf-8?B?Ly8vN0FpN2J0RkJkeFlvaDZLTTh5OHlXWXVWdUZNSmt4aENKMnFWUjJNbmFO?=
 =?utf-8?B?cXd2ZU95Ky9Ud1NNdHRNelgxUWNvbWFyUzQyejJyVEQvd0xlWDFWU0R0Sng3?=
 =?utf-8?B?U3YvMytLaUUrYys0b2hlaFJnK08wK0Vubmt5WkxUM1hHMnNmNmZQNWlzVmJL?=
 =?utf-8?B?cU9QWkN5Tm92eDkrWjJPcFdGaFRvWElqWXpTOEVQdVN0cGlvWnZDQnFlN3Jy?=
 =?utf-8?B?SEFtRlVua1hTd3dZVDRSN0N0UEZqcStaM0FKK2FoR2dCeXAwbUpTYnV1VVZL?=
 =?utf-8?B?WC9FaERtWnNiOXB0cHkzQitMRjEybEF0OFk0ZVlwY2hCTUVkcGVwdytJQlZw?=
 =?utf-8?B?eUhrcDU2eE45aFFGeWZJRTlicHN1emFIa1IyWlBkOTRqT1MyVlVJUXlUd2Rt?=
 =?utf-8?B?V1ErV3EzQzF5TThLWkkyc08xVTVJM3BLNERERmlBbTRCbjBnaVArbXFJK2lk?=
 =?utf-8?B?UmdpMXRTY2REMlZXMjYxT0xOcFpmdnlwSm1KdTdZK3A1OXNpNFBnaUhkL3Jz?=
 =?utf-8?B?L01yZ2puODloMlhXYmZNSXR6bEErQ0NCM1ZGQXYvRnFFWTFhZlRFcGJ2TjZw?=
 =?utf-8?B?NTlOZ2k0NUVJaktGVmhSRjVvRFR0cFhQbG4reHZRK3Y4WFFzS3licTZoQ1Zm?=
 =?utf-8?B?TXJ5dWlkUXBGUHVJSXc3R0VBSDhGQllBZmhTRGJud0R2SkpyWkE2N2tFVUhP?=
 =?utf-8?B?V3laZnFRcXdqUVVXU3I5cENzSC9hMHgzRU56U0ZNaHZxaEJYL3pObEROclJ2?=
 =?utf-8?B?eldXS3VqZHNSRlJNejFMVHI2L2x4MHFkdWw0L3BoK0lTajdTRGVvNHoySlgy?=
 =?utf-8?B?d3ArS1QxblNYVnZUbEpmZXFMRU5mRFN3dEVXZk40NGZucjBjYUw1Y3A3b2Q4?=
 =?utf-8?B?YXZDTTdjeHVMdC9PRllRVy8vc2hWQ09INHZINzg0b0Vna3lDenFYWEtpU21n?=
 =?utf-8?B?YW9hYmdwTk1wNmZ2OGhNQ0Z0NURocG12VDlycEZVV09udUs0T1htejdYYzVl?=
 =?utf-8?B?em5iaVVHRWZMVnNDbWtGczNrOTFTQzkxclVzeTNWS3JhQjlPUnpEU09CYmVN?=
 =?utf-8?B?SEJoYmkvdHdURFV4QjM5QVgzNmlkbERNMTVYblhYSkdJZmJsSUdQOUpMeVVk?=
 =?utf-8?B?UTcrSmFreThoNU0yK0ZUb1hRenFySjFWTVBDeHlSbEpKSmFOU3BEU0c1N3pz?=
 =?utf-8?B?MGhJQXNwOTU2SVl4SzBLSDB4ZjZPajVkWjZnZk4vZGk3eURyREVjK0NjV1R4?=
 =?utf-8?B?cXI3Y0ZEb1RpU1FDc3BGSUNhczVqMWFGV0VZM2VycnUwSzNmNFRCZ3Z3cVRK?=
 =?utf-8?B?QU9BaDdjYUMrMTBtcW16WjhpSDh1bWZaSjY2dU56NS8rekpOWUxUL0p3Yyty?=
 =?utf-8?B?RXJkcFFPUTRKZ0NMYVJ0OXk2NUhLUVBiM2tMK2d0VnVYODJnbFFaWTM2NW9G?=
 =?utf-8?B?QnZTMUdpaEgvSlZaTnlVTXdJUWlwSkFON3FET1oyOWV3NVRMOSt0TlNwblcr?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26590E636C55A9478C3179B942B514F0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a3hxQ2J2NmxBV2s3cTlhdzg4QnF6dkNTdmtnMDlFRFRVeXRld0tRN1d3RGZF?=
 =?utf-8?B?c0lDdFNwTGVhSkJLUTdTY1RTYW5Ob2RNNm5Ja1VHSXJHeXdNVXpzUzVLWndH?=
 =?utf-8?B?ekxQdE85MUFOWHhxSXQ4ZEJxbGVlTVFsK1hjUUYrZGN4ZE95Uld3bEtPbVJ0?=
 =?utf-8?B?N3d5VkVDV0V2dm81bnA1WCt6dllWZU0zd0c5UTBSd0JpdFg2WTg3aHJzcDBj?=
 =?utf-8?B?c0hOc0Qwbmd2K05XWVRXQlVRQTJISzdFQmtvWDRRdkNVeXdaM3hXOG4xMlg0?=
 =?utf-8?B?NHFhODFoWktwYmJaZk0xOGlVNlZxdTFsUXVXdFdYMVRUSnF1NTVkMHh4Vmt0?=
 =?utf-8?B?dDJLeUwzcjBKNjBhWm1MZ0pDT1VNTG9UaTBlY2lhVG1ZMml1VzRQMDJUVWRu?=
 =?utf-8?B?TGo3b05GRnBkQmFlVWZJTHhHaFFCc3M4SUVnLzA3c0RtektOOEVoUXF0R2ts?=
 =?utf-8?B?NWdNdFZFY2xLZ0diMmI0blV2ZzR5QUFtZXIxMlFyVytpY2c4bVpKSWF6OHU5?=
 =?utf-8?B?ZTdLdWJoOVVIYklJb3NGK1V3NlNTR3pLNWk4ODJ1MDNlOUZTR3g0MjVUMlk5?=
 =?utf-8?B?VVpIUzJMdE13dFNYQTViM1pSaGJYWHgyQlY5VGluZzIrMGs2YU5YcmhZNGYw?=
 =?utf-8?B?REJLSDVmTDVpcDlvSUJnUjZ1TDJDd3FpNGRqRFA1NXJuNjdlOFZ4SDRqOC9y?=
 =?utf-8?B?SVR6WmQxSlRrSFFEUDFpQy9NQzlPMFFnTzYwMGxFL2RVU2U2UkxQVlZkdGla?=
 =?utf-8?B?OU93N01mYnVSanREcXdQZ0ZwZ053c3BiVHdMam1FVDVOZ2dwYTZkSkovcVRU?=
 =?utf-8?B?Rkp4L1VyYXRUbHFGcEV4NkU5WkphQXExQ0d3Ym0wcjJuUm1Nc1dTVmJhYm04?=
 =?utf-8?B?VGpBemt1Z21MWUFEZnA1YU5sZ0pWV0lwKzFJTzMxcTRERnZCamxHL1dlRldY?=
 =?utf-8?B?UlZxMjJzb3hQcERBelZBcWY5U1Nud1VYWFFYSWFMQ3JSd3BzRUVsc0YydkhS?=
 =?utf-8?B?ZVJ5TkdVS3pkY0Jra3lRbEE5TXZITmV2c1A3Nk90SmxYWlVQeUlSMzZNdWEx?=
 =?utf-8?B?VUxOQjJhcmJwNDdXRjdwcTRWMVFtWDdldmF1TTgzakhHSDlWckRGVkhOTW9C?=
 =?utf-8?B?cjJmSkRSY2h1ZCtnK1ErS0c0SDNPdmpaL0szR25ZR1IrQkdhMXd5VzljQmIw?=
 =?utf-8?B?Uko0ZlJpNjYwQk1MMTkvb1ZJWDNFMURMbVFHelVKdnRJWUM3ZmNsK3V2VnNi?=
 =?utf-8?B?NEQ1N00vZWxrNUtuTHlQSXN2ZC9iME4rb05VMmtWYlBsSzFPbGNkUDZ3WWhO?=
 =?utf-8?B?R3VtMlQ1cVFaY3ZmVVM5VmZvT3NWQXF1RjR2TDlRd2x1T0hKdHl6SzBCSHVl?=
 =?utf-8?B?UUo1NHVTelU1QkN0V3VFN0hjMzEyQ0QrT2kxOUNrSitkL3d3a1JQRFFBSXYr?=
 =?utf-8?B?bS96NGlTS2daSVBTT3Ewa3I2ZnZVTXNDVWgxY29nSytPaU1xUU5WVWhlTHNx?=
 =?utf-8?Q?iBEvJo=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c69f4d4-338a-4c8e-e774-08dbd7aef48f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2023 12:11:02.9824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDecATKpWfkcvR3aGt0+URDGKweIo91FRC2EExTPrmLowEUambo027j6e6xh3Rd6Zp8R7cOI5ytHjho0jeME4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7927
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCBPY3QgMjcsIDIwMjMgYXQgMTI6MDM6MTVQTSAtMDUwMCwgUm9iIEhlcnJpbmcgd3Jv
dGU6DQo+IE9uIEZyaSwgT2N0IDI3LCAyMDIzIGF0IDExOjE14oCvQU0gTmlrbGFzIENhc3NlbCA8
TmlrbGFzLkNhc3NlbEB3ZGMuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhlbGxvIFJvYiwNCj4gPg0K
PiA+IE9uIEZyaSwgT2N0IDI3LCAyMDIzIGF0IDEwOjU4OjI4QU0gLTA1MDAsIFJvYiBIZXJyaW5n
IHdyb3RlOg0KPiA+ID4gT24gRnJpLCBPY3QgMjcsIDIwMjMgYXQgOTo1NuKAr0FNIE5pa2xhcyBD
YXNzZWwgPG5rc0BmbGF3ZnVsLm9yZz4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEZyb206IE5p
a2xhcyBDYXNzZWwgPG5pa2xhcy5jYXNzZWxAd2RjLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gRXZl
biB0aG91Z2ggcm9ja2NoaXAtZHctcGNpZS55YW1sIGluaGVyaXRzIHNucHMsZHctcGNpZS55YW1s
DQo+ID4gPiA+IHVzaW5nOg0KPiA+ID4gPg0KPiA+ID4gPiBhbGxPZjoNCj4gPiA+ID4gICAtICRy
ZWY6IC9zY2hlbWFzL3BjaS9zbnBzLGR3LXBjaWUueWFtbCMNCj4gPiA+ID4NCj4gPiA+ID4gYW5k
IHNucHMsZHctcGNpZS55YW1sIGRvZXMgaGF2ZSB0aGUgYXR1IHJlZyBkZWZpbmVkLCBpbiBvcmRl
ciB0byBiZQ0KPiA+ID4gPiBhYmxlIHRvIHVzZSB0aGlzIHJlZywgd2hpbGUgc3RpbGwgbWFraW5n
IHN1cmUgJ21ha2UgQ0hFQ0tfRFRCUz15Jw0KPiA+ID4gPiBwYXNzLCB3ZSBuZWVkIHRvIGFkZCB0
aGlzIHJlZyB0byByb2NrY2hpcC1kdy1wY2llLnlhbWwuDQo+ID4gPiA+DQo+ID4gPiA+IEFsbCBj
b21wYXRpYmxlIHN0cmluZ3MgKHJvY2tjaGlwLHJrMzU2OC1wY2llIGFuZCByb2NrY2hpcCxyazM1
ODgtcGNpZSkNCj4gPiA+ID4gc2hvdWxkIGhhdmUgdGhpcyByZWcuDQo+ID4gPiA+DQo+ID4gPiA+
IFRoZSByZWdzIGluIHRoZSBleGFtcGxlIGFyZSB1cGRhdGVkIHRvIGFjdHVhbGx5IG1hdGNoIHBj
aWUzeDIgb24gcmszNTY4Lg0KPiA+ID4NCj4gPiA+IEJyZWFraW5nIGNvbXBhdGliaWxpdHkgb24g
dGhlc2UgcGxhdGZvcm1zIGlzIG9rYXkgYmVjYXVzZSAuLi4/DQo+ID4NCj4gPiBJIGRvbid0IGZv
bGxvdywgY291bGQgeW91IHBsZWFzZSBlbGFib3JhdGU/DQo+IA0KPiBBIERUIHdoaWNoIHdhcyB2
YWxpZCB3aXRob3V0ICdhdHUnIHJlZ2lvbiBpcyBub3cgbm90IHZhbGlkIHdpdGggdGhpcw0KPiBj
aGFuZ2UuIElmIEknbSByZWFkaW5nIHRoaXMgc2NoZW1hIHdpdGggdGhlIGNoYW5nZSwgdGhlbiBu
b3QgaGF2aW5nDQo+ICdhdHUnIGlzIGFuIGVycm9yIGFuZCB0aGUgT1MgY2FuIHRyZWF0IGl0IGFz
IGFuIGVycm9yLiBJZiBpdCBkb2VzLA0KPiB0aGVuIGl0IHdvdWxkbid0IHdvcmsgd2l0aCBleGlz
dGluZyBEVHMuIFlvdSBjYW5ub3QgYWRkIG5ldyByZXF1aXJlZA0KPiBwcm9wZXJ0aWVzIG9yIHJl
cXVpcmVkIGVudHJpZXMuDQo+IA0KPiBJZiB5b3UgY2FuIHNheSBubyB1c2VycyBvZiB0aGUgYWZm
ZWN0ZWQgcGxhdGZvcm1zIGNhcmUgKGUuZy4gb25seSB5b3UNCj4gaGF2ZSBhIGJvYXJkKSBvciB0
aGUgYmluZGluZyBpcyBub3QgeWV0IGluIHVzZSwgdGhlbiBpdCdzIGZpbmUuIEJ1dA0KPiB5b3Ug
aGF2ZSB0byBzdGF0ZSB0aGF0IGp1c3RpZmljYXRpb24uIEkgc3VzcGVjdCB0aGF0IGlzIG5vdCB0
aGUgY2FzZQ0KPiBoZXJlLg0KDQpGV0lXLCBJIGhhZCAiYXR1IiBhcyBvcHRpb25hbCBpbiB2MiBv
ZiB0aGlzIHNlcmllcy4NCg0KU2luY2UgSSBtYWRlIHRoZSBlZmZvcnQgaW4gdjMgdG8gYWRkICJh
dHUiIHRvIGFsbCB0aGUgZXhpc3RpbmcgdXNlcnMgb2YgdGhlDQpyb2NrY2hpcCBiaW5kaW5nLCBJ
IHRob3VnaHQgdGhhdCBtYXJraW5nIGl0IHJlcXVpcmVkIGluIHRoZSByb2NrY2hpcCBiaW5kaW5n
DQp3b3VsZCBoZWxwIGVuc3VyZSB0aGF0IGFueSBmdXR1cmUgcm9ja2NoaXAgcGxhdGZvcm0gZG9l
cyBub3QgZm9yZ2V0IHRvIGFkZA0KImF0dSIuDQoNCkkga25vdyB0aGF0IERUIGhhcyB0byBiZSBi
YWNrd2FyZHMgY29tcGF0aWJsZSwgYnV0IHRoZSBkZXZpY2UgZHJpdmVyIHdvcmtzDQpmaW5lIHdp
dGggYSBEVCB0aGF0IGxhY2tzICJhdHUiIChldmVuIHRob3VnaCB5b3Ugd2lsbCBub3QgYmUgYWJs
ZSB0byBkZXRlY3QNCmFsbCBpQVRVcyksIHNvIGFuIG9sZCBEVCB3b3VsZCBzdGlsbCB3b3JrLg0K
DQpCdXQgeWVzLCBydW5uaW5nIG1ha2UgQ0hFQ0tfRFRCUz15IHdpdGggdGhlIG5ldyBiaW5kaW5n
LCB3b3VsZCBub3QgcGFzcyBmb3INCmFuIG9sZCBEVC4NCg0KSSBnZXQgeW91ciBwb2ludCwgeW91
IGNhbiBuZXZlciBhZGQgYSByZXF1aXJlZCBwcm9wZXJ0eSBvciBlbnRyaWVzIHRvIGFuDQpleGlz
dGluZyBjb21wYXRpYmxlICh0aGlzIGlzIGluIHVzZSkuDQoNCg0KSWYgd2UgbG9vayBhdCBzbnBz
LGR3LXBjaWUueWFtbCwgImF0dSIgaXMgb3B0aW9uYWwsIHNvIHRoYXQgY29ycmVsYXRlcyB0bw0K
dGhlIGRldmljZSBkcml2ZXIgYmVpbmcgYWJsZSB0byB3b3JrIHdpdGhvdXQgImF0dSIgc3BlY2lm
aWVkLg0KDQpTaW5jZSB0aGUgcm9ja2NoaXAgZHJpdmVyIGRvZXNuJ3QgZ2V0ICJhdHUiIGl0c2Vs
ZiwgYnV0IHJlbGllcyBvbiB0aGUgY29tbW9uDQpjb2RlIHRvIGdldCBpdCwgaXQgc2hvdWxkIG9i
dmlvdXNseSBiZSBvcHRpb25hbCBhbHNvIGZvciB0aGUgcm9ja2NoaXAgYmluZGluZy4NCg0KSSBn
dWVzcyBteSBwcm9ibGVtIGlzIHRoYXQgSSBqdXN0IHdhbnQgdG8gaW5oZXJpdCB0aGUgZW50cnkg
ZnJvbSB0aGUgY29tbW9uDQpiaW5kaW5nLi4uDQoNCklzIHRoZXJlIG5vIERUIGtleXdvcmQgdG8g
ZXh0ZW5kIGFuIGV4aXN0aW5nIGJpbmRpbmcsIHNvIHRoYXQgeW91IGluaGVyaXQgYWxsDQp0aGUg
cHJvcGVydGllcy9lbnRyaWVzIGZyb20gdGhhdCBjb21tb24gYmluZGluZywgd2hpbGUgc3RpbGwg
YWxsb3dpbmcgeW91IHRvDQpkZWZpbmUgKG9yIG92ZXJsb2FkKSBhZGRpdGlvbmFsIHByb3BlcnRp
ZXMvZW50cmllcz8NCg0KRXZlbiBpZiB0aGVyZSBpcyBubyB3YXkgdG8gaW5oZXJpdCBhbGwgcHJv
cGVydGllcy9lbnRyaWVzIGZyb20gYSBjb21tb24gYmluZGluZywNCml0IHdvdWxkIGJlIG5pY2Ug
dG8gYmUgYWJsZSB0byBpbmhlcml0IGEgc3BlY2lmaWMgcHJvcGVydHkvZW50cnkgdXNpbmcgYQ0K
ImluaGVyaXQiIGtleXdvcmQsIHN1Y2ggdGhhdCB5b3UgZ2V0IHRoZSBzYW1lIGRlZmluaXRpb24g
KG9wdGlvbmFsL3JlcXVpcmVkKSBhcw0KdGhlIHBhcmVudCBiaW5kaW5nLg0KDQoNCktpbmQgcmVn
YXJkcywNCk5pa2xhcw==
