Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F97ED883
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 01:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjKPAa1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 15 Nov 2023 19:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPAa0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 19:30:26 -0500
X-Greylist: delayed 739 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 16:30:19 PST
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7BDA9;
        Wed, 15 Nov 2023 16:30:18 -0800 (PST)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 3AG0I0r32851137; Thu, 16 Nov 2023 09:18:00 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 3AG0G4lg2824237; Thu, 16 Nov 2023 09:16:04 +0900
X-Iguazu-Qid: 2rWgaNhqp1LtXmaEeP
X-Iguazu-QSIG: v=2; s=0; t=1700093763; q=2rWgaNhqp1LtXmaEeP; m=pjKFLuXQrV/G5HSWdlGtF3PVFWl1kTR4m9gwlnBaq4M=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1120) id 3AG0FvJg2092951
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Nov 2023 09:15:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6XLrmU1Y+nN3etO11LRYLcR0ifz2mDxqYbieZFzpsn4RTOSoTknjxFkdSyzePu7xqNtRzPr/lMTVvy2Bz8mGH4sN80IMP1xSbGFu2MDcvjx3B2kLYduOUYz/rEH7rBRvqKatmnSo6qVGxgDgEtc3eTEzoK61PSgEXp0EM5624o24OPm4XaHzcsWtLzHnuo5y6oh9kQf3xQfVUPTxkWScdx0rtVa9pcTeI89DUGDknj1mYkWRpr9vaJ+V6SomE/aBwFnmn5W2T4LRU825BO89DrRDZYDZuAo1u2RqX/Z0t1U+vY4gSPu2mzCRrJa5UZl+vn/nKzpmwl8ASnPArWkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFL5c/0F2ixCIuQC9SELo03LPPZfDkosUx3wtonKmMo=;
 b=cj00x8Fz1iWktfsUB1lco9jIoY39plmOs6H8jCDLhe0GrWLZNwXPpgas0ZAe64WV9JsT3VtWbUsiT+5AA4h6oYxHqN2i6NBq/eSzDqGjCES6Q4tiuiw63aHOmr1SEv25+rEJ6CKyHJVyCCk+rpg9LM98q1S4HpgZGrzMgTGcImzVWwsRA8BeLQttGTxv415rRHEHiq9HDKQVjhrOkzcEx8af9VzH172VBJibdDsoecqSdTuhK3rWNoSwi/fykKsXPkTZOzgnA6u7hdXaephIbo93ACcSqTg2ilrXNSYpCfSdNlsqR7R1A44igTjPtYtNMzD0UfbVLPJdC4X5QYgAVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <yoshihiro.shimoda.uh@renesas.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mani@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <vigneshr@ti.com>, <krzysztof.kozlowski@linaro.org>,
        <alim.akhtar@samsung.com>, <hongxing.zhu@nxp.com>,
        <l.stach@pengutronix.de>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <festevam@gmail.com>,
        <minghuan.Lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <yue.wang@Amlogic.com>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jonnyc@amazon.com>,
        <thomas.petazzoni@bootlin.com>, <jesper.nilsson@axis.com>,
        <heiko@sntech.de>, <paul.walmsley@sifive.com>,
        <greentime.hu@sifive.com>, <lchuanhua@maxlinear.com>,
        <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <marek.vasut+renesas@gmail.com>,
        <pratyush.anand@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <hayashi.kunihiko@socionext.com>,
        <mhiramat@kernel.org>
Subject: RE: [PATCH v2 1/6] PCI: dwc: Drop host prefix from struct
 dw_pcie_host_ops
Thread-Topic: [PATCH v2 1/6] PCI: dwc: Drop host prefix from struct
 dw_pcie_host_ops
Thread-Index: AQHaFr8he6AG9IJOJ0yv1tK95ivwK7B8FgCg
Date:   Thu, 16 Nov 2023 00:15:52 +0000
X-TSB-HOP2: ON
Message-ID: <TYVPR01MB11245A96BE6937181281849C092B0A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <20231114055456.2231990-2-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20231114055456.2231990-2-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|OS7PR01MB11964:EE_
x-ms-office365-filtering-correlation-id: 468c4e92-8ca1-4931-08a6-08dbe63931f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7RFGV3KYJ0eBkc+44TAsQ7vqbpgxH3jqj9BZszB0U0jnbUOxWJfDO089RleXR3GFNbuCV7xHXhgU2Y5XFEXHU0NVKOsRv21nM1MboNGPC9Km73NMhabW7rz2UjcaswP/PW5Dt9SknpYkwfOjnzsOMvG3f56uNlac6oMjYE9c5eQcNMWDlTHh8iKdc22g/DLgHrkHKPjYre1N0tb21UjGeghyTTOwp2RbIqPtFzsXZReAVvm1FrPJB4cm1CQSDncejmZt1bORwPNWWlHi9rYyuJ9YgsvmrH6W8WYOrB6aBRqsshFsWmWut+73xi7hE7DVnMk9NyoWipNFGZZ0HN4D5hCEYG3t/oeR/cDT/deO7opZ994Wwc2MCJ8MeJp2tdzyN8w6pGlIAQiBSG/DShFzVbawUcQ5lCJEYApeUOB59EutEuCXh0qhlRy7UVLm9bxCLnOg4mJvYk/R1AK93WyTlVMjhea9IoFuSCR2cmeK+/FK7r8M9JUBUx1nOBOY45Vmbcy7NJYWUXVBSHr0mtJRNVjoXnObdcAChsAcF4/Jet1DhOXUSeqRzDzXyN/sRUgK/5iZ9zusC4/Q2/7pgJLL3XCP0BOkxgCTkLdFLsxoWn7QPkRRLsk4EPVPYtzriL/q1eY6miFjZznP6NWZJG9Mbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(7416002)(7406005)(5660300002)(55016003)(52536014)(2906002)(41300700001)(8936002)(4326008)(8676002)(316002)(110136005)(66476007)(54906003)(66446008)(64756008)(76116006)(66946007)(66556008)(86362001)(478600001)(38070700009)(26005)(71200400001)(53546011)(9686003)(7696005)(6506007)(122000001)(33656002)(83380400001)(38100700002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?T0YrVk1tdnMwTGNMLzNNbEczVUt6QTZCbGN4dWpOSXV2TmpkVlIyWCtL?=
 =?iso-2022-jp?B?NVBWUjkzNHlENFNlTXBOTFlBVVREWElhb3VZenZLc1RVMW1rUWpSYW1u?=
 =?iso-2022-jp?B?UVBQVjZ4SUlodzVNTFh0SzcwQTE5bFNFek5Ddzg1WnBlV3pLMVNEbkpF?=
 =?iso-2022-jp?B?VXI5b2ZqcnZhOHB4aUQ2WEpGa2ptQjdkblI1RmdZOHZveEZMSnU1OGN3?=
 =?iso-2022-jp?B?TDNnVHhlbzBhUDZSQ29tZ3drMkpFdTcramhNb290eVJlQ29kbk9RaG5m?=
 =?iso-2022-jp?B?NWo5MlFlQzlqNlpvNWI4OTNDU2RuSVI5Szcxd245eG11ODJFVS8vUWVX?=
 =?iso-2022-jp?B?MXgydVUzQlYraEdGU3IrY0tyTkJGekxwOG1iUFNjL0NKVWFFbTBTUW1Z?=
 =?iso-2022-jp?B?dlh2NDVORTBvS1Y3U0M2TlFkV1F5MkdIdDZxYmZkR1VLS2hDSDluN3Z1?=
 =?iso-2022-jp?B?Z3FZSFZxQU1qYVZhVnJodjFqbnRLS1dwRmFmblZJY1pVaFc2K3UzQjJt?=
 =?iso-2022-jp?B?NzU5M295d2loQzdLM1JDYUNGcmpYWktwcG9GZ2lFcnZuZFFPRXE5TE9S?=
 =?iso-2022-jp?B?S1dYYXdSVytXbFg0U0ZVczVOSm5PeXZWMU5VcjA4MmlJbjgyNklWdk1z?=
 =?iso-2022-jp?B?TmRsZW1YVE1SMUxUc0VLOFFiNnNNR2xCZUhNbmJiV3FlcjFRSHhlakU0?=
 =?iso-2022-jp?B?STlRTWRlbnhEZWZGVkpiTE13MmpXbkpKanM3b0NvVUMzYWFjQyt3OUFD?=
 =?iso-2022-jp?B?ZkRYc01ZNEhCSWJsNmxhS1JNbEFoMGFxS3NnTjVuK0dDWlMzYmtXRURX?=
 =?iso-2022-jp?B?WDdwU2YwRWEvU1NpMmVFelhyeG1mOVFKcWdJQTN5NWlhbEJrL1U0dGNU?=
 =?iso-2022-jp?B?V3k5dWlBbmpSVkVLcW9uaStZLytjbUljN2l1TWoyQnVNWDVCNmFqZW1T?=
 =?iso-2022-jp?B?ak9pTjhmTCt0QnpLYmlNYTF6dUY2TGtBeXVtcVgrZzh1QnowcFF2M1NN?=
 =?iso-2022-jp?B?SFk5dG5pQmc3QlQvZlhUMS9SamYzTFdjYk9CS1FvbVdzemhLYm95NWth?=
 =?iso-2022-jp?B?YTl1MXQ4Wk0zcWI2SWpKaGxJbG12cHFsaFoweFZtc1hiNkZzVUNrblFn?=
 =?iso-2022-jp?B?b0VLSnlOZFRZWVd3blFPeVlMVFlPSU1nSVkxcEpQR3NIdHNwa0pYWFVZ?=
 =?iso-2022-jp?B?ZTkzQnA2S1FKcjA5QUdYTjdyUEsxMzRCOXRVSzFLWStOMXhEMy9ObHhz?=
 =?iso-2022-jp?B?OStSb1BHWVdmSGQ3VDJnOHBlZmJvbTV6U2d5VE5scDZSbWY1ckhaRTB5?=
 =?iso-2022-jp?B?MGt2dnhMTk81M2l6bkZ2QjVIQ0s0elNHTUIwcHhEejBoWU9scGFtUEpk?=
 =?iso-2022-jp?B?UzFEUExoVHJkOEQ0NC94R1ZKWGlwVGtJYTBHb3pEVE9QQ3VBQmQwZkhU?=
 =?iso-2022-jp?B?aHZ6dytFZVg3V0tqVzVmamNrZGlGVVpCU1Qya0VxZ3JPN0xUZ2Z4cDFE?=
 =?iso-2022-jp?B?bDBtaFBVVmFwVkE5RzZabk9pZ0tqRTR3NE04bHMrY0tyZ2pFSlF5NmVK?=
 =?iso-2022-jp?B?eEdCTWZZT1cwNElXZXErUTBCcFdPbllSVDBSRHlwUGhRek9OUWw0RUdm?=
 =?iso-2022-jp?B?WmE5STJUakZucW1KeHFTRXpOZjBxempIUVFWa3BTdXY1UXNTSncxZ1lQ?=
 =?iso-2022-jp?B?NU9iMmM5S1hvc0doeVZuOU9CbTFYbm1ETGFUMXJXOW0yWE9mSEwzcWJD?=
 =?iso-2022-jp?B?T1dZK25BSENwY0kzQ0RndTc1ZjEyY0dsNnl5MVVVVWFYYTZXRDNBbVhv?=
 =?iso-2022-jp?B?bVdXd3JYcXlMUjZlcDAza1pSV1BCQU1TR01yNnZObkFxaU9wUElMKzZz?=
 =?iso-2022-jp?B?T0RxaDEvMjc5c3kySzB6NzJ3cmpxV3dKVy83Zko3N3RicSt1emdTankz?=
 =?iso-2022-jp?B?YzVodnBPNkZZS1BUMThlRHo2NXJldE9LM2NqMzlGb1NQQ1NId05HSS8r?=
 =?iso-2022-jp?B?RitSNWcwYjNjNlJQNHlja1RTM0F0M24rdmM2MnFEczF6Y0I5emxBbCt0?=
 =?iso-2022-jp?B?T1ZRUTJUUW96a3c0ajlJcmNjMFNXYnpPbE5vdEVvR1I3K1pNWWVHN2xL?=
 =?iso-2022-jp?B?T0ZzQmMva2ZSY25Nc0VXMW5vNnlNTGVqZjJTWGt5aS9PWDNKeUdkaG9M?=
 =?iso-2022-jp?B?cTBWQ1YvZDdKZGUxOFBOdVN4ZGRJV2xrVGpqWjQzbmtNMS9VS0ZFajl3?=
 =?iso-2022-jp?B?R3BiNVJiOWE2VzVWNWVmQlVZNUltYjVHVWczM3laWlhSa2ExSnNnczRK?=
 =?iso-2022-jp?B?RjExOHRuWW9HOWdvV3o4TlcvQVAxQThMOUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468c4e92-8ca1-4931-08a6-08dbe63931f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 00:15:52.8390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dBoWSZMDBiTN7g1SoXq1n33vc+wIYFkyX5wLjRIPntzMYIVxe69lKbyBMlSVyyVeII7JGK4a1RCIb0VCF/0z9CLHoXZcUCehbTtX16Ht0fcwtjveytz+wTNANL6n/H9I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11964
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro,

> -----Original Message-----
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Sent: Tuesday, November 14, 2023 2:55 PM
> To: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> bhelgaas@google.com; jingoohan1@gmail.com;
> gustavo.pimentel@synopsys.com; mani@kernel.org
> Cc: linux-pci@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Yoshihiro
> Shimoda <yoshihiro.shimoda.uh@renesas.com>; Vignesh Raghavendra
> <vigneshr@ti.com>; Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>;
> Alim Akhtar <alim.akhtar@samsung.com>; Richard Zhu
> <hongxing.zhu@nxp.com>; Lucas Stach <l.stach@pengutronix.de>; Shawn
> Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Fabio Estevam <festevam@gmail.com>; Minghuan Lian
> <minghuan.Lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang
> <roy.zang@nxp.com>; Yue Wang <yue.wang@Amlogic.com>; Neil Armstrong
> <neil.armstrong@linaro.org>; Kevin Hilman <khilman@baylibre.com>; Jerome
> Brunet <jbrunet@baylibre.com>; Martin Blumenstingl
> <martin.blumenstingl@googlemail.com>; Jonathan Chocron
> <jonnyc@amazon.com>; Thomas Petazzoni
> <thomas.petazzoni@bootlin.com>; Jesper Nilsson
> <jesper.nilsson@axis.com>; Heiko Stuebner <heiko@sntech.de>; Paul
> Walmsley <paul.walmsley@sifive.com>; Greentime Hu
> <greentime.hu@sifive.com>; Chuanhua Lei <lchuanhua@maxlinear.com>;
> Xiaowei Song <songxiaowei@hisilicon.com>; Binghui Wang
> <wangbinghui@hisilicon.com>; Andy Gross <agross@kernel.org>; Bjorn
> Andersson <andersson@kernel.org>; Konrad Dybcio
> <konrad.dybcio@linaro.org>; Marek Vasut
> <marek.vasut+renesas@gmail.com>; Pratyush Anand
> <pratyush.anand@gmail.com>; Thierry Reding <thierry.reding@gmail.com>;
> Jonathan Hunter <jonathanh@nvidia.com>; Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com>; Masami Hiramatsu
> <mhiramat@kernel.org>; iwamatsu nobuhiro(岩松 信洋 ○ＤＩＴＣ□ＤＩＴ
> ○ＯＳＴ) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: [PATCH v2 1/6] PCI: dwc: Drop host prefix from struct
> dw_pcie_host_ops
> 
> Since the name of dw_pcie_host_ops indicates that it's for host obviously, drop
> host prefix from the struct.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---

For drivers/pci/controller/dwc/pcie-visconti.c:

Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro

