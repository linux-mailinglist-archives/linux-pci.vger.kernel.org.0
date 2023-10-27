Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7E17D9DD2
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjJ0QOk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 12:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0QOj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 12:14:39 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B539DCE;
        Fri, 27 Oct 2023 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698423276; x=1729959276;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2bdMw7r5MBaektGwEVP3JgS4mlhBuoUMYEeD1JsNGaM=;
  b=lLeRgJL3AW9K1ys7HPyE9l5nJKmggGgCXQazhhIGRNarvCqdEu2HFmrg
   V/htXK09MbaGU11ocj/St0Yvxu3U5/eMIySsF/1gVKheDxZUyZdPqMfeb
   cwBfLwE1hT41DcGP2IQDrHIWjcB4bwan4VQRigoX/Aa5jgFXJfO/H1tWX
   yu8rRjxGUqIktQDRmd4LJQSx0uNuverqljDbBT0xd3cUPWcyxvZgOuV6k
   OOLzmVkM8I9xibBuUk+121p9BjJSzWIqjwGi00xdJXi0GEROiOmdk9eXj
   4R9fyIgADph4zYnid+/iuRP7SMXX1Az0YY1D44r78KTCfhvPGYl0uyf9u
   Q==;
X-CSE-ConnectionGUID: 0lcPJG7KTVqPG+HDGzQuQA==
X-CSE-MsgGUID: VkCHZoWJSbORa7x59f+KtQ==
X-IronPort-AV: E=Sophos;i="6.03,256,1694707200"; 
   d="scan'208";a="851044"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2023 00:14:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REoeIdsZiMpK5VxoDqWVMR1rd8ZGIs28qlcJwdQrfF0CFVjLL1K24SihP1qFkxxvKYa0vTsQU4FdGiHBZYl7WxJMV9RzpduhbrAhnwS/FXgLjd/utCR3A339qlXF2Q7rpVpUt5KQTo+0tIMktHOxxwUpShtvyj9PqbN2Wa8iJVRr3usrko6Z1+dAISvpePJGwJoqmnHUI3zlDYvw+RnoGj9m8gYnUqJWG7HQmGQuFdH7/tsekFV2jZiJglfuvdjyj78FmTrO0e33Re+OV36HZyKcmjixBYbV96LHWO0sbmko6FJ+O2WjzIRKwxEAHkTT9k5KMdfTcpg8owfaI+CTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bdMw7r5MBaektGwEVP3JgS4mlhBuoUMYEeD1JsNGaM=;
 b=RQQohlBqZtARqsKKkbwCUpdhi+gP3xZ6lkIcdly99CU4PqD0IOLO0eB5zAURbzXZNsOfj6iPZg4F9+asnebIqPM3lB77ucIzGFsVrxMAe7Udc2MysO2Yc/EwD3WIPog+ORf7+T+Lx+neZVxxROmQjqfz4q9FsaSzUP5SNFvjvybAjYILFuUvakzZQheAxvUX1zT9HYOkLOWbD0706VvccZ5a8GDeaKmfiC/CNPbTtxi1obuxIrw6IJheyywxDgkQPa91Tf+l+1e2CseTPpWBzknrib2PO/LytezNfzkEjjg3RbsEJVuUNWst1mqAna1kfS4QedVbtxRyEAmc6MmtXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bdMw7r5MBaektGwEVP3JgS4mlhBuoUMYEeD1JsNGaM=;
 b=wWHg4K24cjb0GUkcUaH+LyRyHts+BUS+q50Wjvdtk/g6ZKAdTnZqoYLktXoS+0210gYhbBDvRd6AVR8F+iy8S+dE94ESxdF8r3JnLh2W4mRh1Ae5a9PtwgFNbNjSVkT2izNHaMXUHDaAEQPDbPhbFOtmGp1GUDkeeAL+IRj/7x0=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SN4PR04MB8368.namprd04.prod.outlook.com (2603:10b6:806:203::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 16:14:32 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 16:14:32 +0000
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
Thread-Index: AQHaCOW0DNtJxIPHQ0SmB6+3W+fCubBdyw4AgAAEfIA=
Date:   Fri, 27 Oct 2023 16:14:32 +0000
Message-ID: <ZTvh51PGCBhSjURY@x1-carbon>
References: <20231027145422.40265-1-nks@flawful.org>
 <20231027145422.40265-2-nks@flawful.org>
 <CAL_JsqJh6aJb7_qsVnVNEABBg2utf0FPN+qYyOfsF2dAfZpd0w@mail.gmail.com>
In-Reply-To: <CAL_JsqJh6aJb7_qsVnVNEABBg2utf0FPN+qYyOfsF2dAfZpd0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SN4PR04MB8368:EE_
x-ms-office365-filtering-correlation-id: 076e0b96-2eac-4552-d39b-08dbd707cdf6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6dXUtwiiF4Weol7BlRehUcuys1SqBfPikehG8Ml7yDnIABxhSkevkqejSw+3ISmNkhuUR+8JoLlGklsq3hayQLyH2Z5s6gqNGcVCdElcZs4MhYQasndRf5nnyPkfmJckPTuDoyyiEMnuPUtiYkoloCV0BhreeOdXB3NAOEYo3fkgQvzk0SFwXJdzxo/cyHxWMunVnffpCQrRcrLmUwytQHxD3lDBML+8nTAgTzmO1PSTAsFmKr8VEMPS5h+zilId8jMPfd13LZJmfknFXvGVjnGAKSKZk+Uvj99XAohufJiH8iPlWZDCuUjW7kZSN/a47uPCiASvSTI2U9SzHd0XPnOvC6ePP8Mi5QrQ5AkVSyKVTfI+IbBrMRhbKyKm3t9gWw5FbI6K15/lUxJ8r+uKTCTPfW4cVqpp3ifbVlsBje6wqXIa0lUR6oULY2TBeM7ODDio6eK0EYsV6H47/Bh4Ff1odzCZqfnYbGUhBmPjlJU5KrZrejoqbOq+nS1+xly7PCiD4EN6x+5ZLaxpe5y1xMFu2HpygUwA+ROps5Am1LZat8GhNmY/i3iIDBSf3kKsm81I0IBCgJsnrneU1UhWBb0+ACXC6GE0cbaGLs0kjQmFTui9g+kK+tGSsnqQJDZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(41300700001)(4744005)(2906002)(38100700002)(76116006)(64756008)(316002)(54906003)(66946007)(82960400001)(6916009)(66556008)(71200400001)(478600001)(26005)(66446008)(66476007)(53546011)(9686003)(6512007)(6486002)(91956017)(83380400001)(122000001)(6506007)(7416002)(86362001)(5660300002)(4326008)(8676002)(8936002)(33716001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YThpYXN2MjcwZE1wTzhvc2VzSkdRbDdSSlZvQkVPMk0rVkZUZVhzV0h0OXhY?=
 =?utf-8?B?NVdTbGlRTzdMcGM4TS9pcmJQMTIyTVZtSUwvbytrOUlpN0tYeFBwc2RoQnJr?=
 =?utf-8?B?UWp1dDhvRTRKM0t6eFVRRXBZbzRZS3pURGoxemFIMm9HaDF6Vkd6S3BiSVU2?=
 =?utf-8?B?ZytFbndSUTZHNDBqdFNucjdxdG5wMFg3RWl3Q2h4bkcrL0lrekVsSGNNTnov?=
 =?utf-8?B?UFl0a21qYXJ6T1JaYTJDSjE1T3ZZZG5kbnMyUFkzZVZaNXUzSG9sWUdCSlR0?=
 =?utf-8?B?akxSUmVpZ0UwMHRza3oyMkd4VC9vNWV3bkNyZXBuN1V1VFExK0xLeitSN0pU?=
 =?utf-8?B?N0Q5dzZwekVmNEpCcy9VU3MzZEgxbURMNm5neERoVzlBVGQ5WDZ6NStYSUlZ?=
 =?utf-8?B?aEczRFJ6eVlwMXV3alFYR2pzRDdIWFQxNFdkeWZKMzNOc0VqYUdneG1NRXJW?=
 =?utf-8?B?RlJnbGpWNlpTT3RCSTl4QUk4cU5ONHR5YjE2b2k2NXBhL1JpUm1RQXUxK3pF?=
 =?utf-8?B?YmoxU2syOGtyQlVTb1E0WG5Ibk9KUnBBT3ZRVkhTRjRrWlUyTVY0Mmt6MjFN?=
 =?utf-8?B?d3VWMUdRRkdtRDZYNW9aSi9uTlp5akVDR1FVbnJydUVtaDhGSDQ4LzRXVk1D?=
 =?utf-8?B?MmVEdlZ6azNMb09zb091NU4wdVZYNnA1RVNSZyttVUhGOEs4RDhKY1FGb05v?=
 =?utf-8?B?ZTNvSDBML1FmOTBqeGk4UlFEdzlXcFppeENLNXNva1Yremtoam5NcXJNRmtZ?=
 =?utf-8?B?WWxseFVCZDJLMTJ0cUtXMEhJNWJWeHdxcXN4MzBvSUg1S2l0Nyt0T3NYMzh6?=
 =?utf-8?B?aGEwNjdURy85eUtuYk55dlBZZWdiVlNHQi9Yc1dVaGpTM1l5T0pYR3BKSDRY?=
 =?utf-8?B?Yk05M1IzTlZRcWZmcmJXRUlHQmdrc00yM2hzOENXNlR1L0tmaFoveUlDQ1F6?=
 =?utf-8?B?YVBNZENrVVNqaEdHQWE4UUh1R3RTUEpOQWRBQ1pNQldpb1ltWHNSbGVSck9q?=
 =?utf-8?B?Qm5pNGQ2VG9PcFJ2bXNiNDBZN0ZyakVSempnV1ErT2s4ZDQvQ1N6cnBqclZh?=
 =?utf-8?B?NGdDT0hyMWN5MDFMVENobzM2UkNYaVV2NFpqMWtabFZmR1Y5SDhnWWw1bzAv?=
 =?utf-8?B?YVoySGx0a2tsZnpTQ1FoUjdzZzZ1eUJ5bjNxUGlSdjU0R00zQXcyQk9EUC9x?=
 =?utf-8?B?UWduYTdKVkZZT0ZQUkhaT0lkUzBQUzZ5c1d0cFpWaHZmbWc2LzVMSW9qeDRl?=
 =?utf-8?B?by9Fd0tMVXJPamtXMVpMenRBcm8veUhWVUFGRncwT21jd3BVUldhQnN5VWg4?=
 =?utf-8?B?c2E4bGxDMnQrdE5oVjFlWGtJeGUxQkdVbkppSW1uL0h4RXZ6SW5CV3hCUDNS?=
 =?utf-8?B?NUpxdHdITE5RU1B1YUF1NTVKdWNvbCtraFdhdGFKbi9PdXp5MFNBVm1SN2VL?=
 =?utf-8?B?blJPbHUzYWo4N1ZCZWJrZC9iajVEUXRoYmthOGhiZVNyeGE0VkpDODdSand4?=
 =?utf-8?B?Zm8wVURIUEE2Q0VhditrbWV2NWVHeEk4SkdLeHpNbjQ4cG1MU1lHeEZsZTcz?=
 =?utf-8?B?c201TVVtUE9KVHQvNHpZRFE4RXVwMTNSTmRoTEIvaXBINXR3K0E2QXNjMlR2?=
 =?utf-8?B?Z0JPTnBKT2ZWZlNnckRoNEpqK1NWWHMzS0s3eGdBWHBwL3lSUHpEbjdDUW1y?=
 =?utf-8?B?TlBiTnJETjRCZDFFbm50SExPd2hvL2VGK1NGdVVnM0UrMFVSeGRaM1hMZjRI?=
 =?utf-8?B?elNNSW9UWGZ5NnJMUXdQTG1WdnNvaElpTmJDd1hkTTJPc05yWmdsOVllenVJ?=
 =?utf-8?B?TmF6M05yeEw4ZHVjRnYwVXB1eVVnaUc0dktFaG53MHJQMUtldU1YZVA2K2VC?=
 =?utf-8?B?ZlNPdjJ1UWpMekM4WmJNT0VKc05EbGUzb3VoNFJhWW9WbnFpaWlXWUFmQXVN?=
 =?utf-8?B?eUNUNW12NDliNzdVNnJ1Mi82YzJoeEt4Z3g3dzRpODRGM1Jna1kyOG5VRjJQ?=
 =?utf-8?B?RXMxRkVrZXpSWExGOGRrYmNTWHZTdjJRaWRCU3JTZnRDcWJqUnJxcEdYcHVM?=
 =?utf-8?B?ZmNNamhMYlMyemNZdmxRdkNRbTY3WVRtM0dVUnJROU5qcUtxQTQwL1FLa0Fh?=
 =?utf-8?B?M2dQVlVGcG1KSFUzS1pVQjFOVm0yaUVtUGhHUDBZQ0dmSWRDdWZWMUFEemFS?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11E1D144B4AD8247BD95946D5357DB9D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WjRoUi9UcEZFRmVETEs4ZXZNT1BmdVNiY0ZjWlNramp0ak5JRTNVeXZ0SDVT?=
 =?utf-8?B?TU9tTXloSk5qZ2QzNWVYaHI2UFE4RkVMZCtXek5uVm1zYjdETFZoWE9aQmNI?=
 =?utf-8?B?dk1admNXNk9nMHpGUm9rZnpuT2tZcHQ5WkJOWXJpbU5YMXFTTll4VlFTVkRy?=
 =?utf-8?B?ZHVJUHAvaEFWT05nNUltTlFEbll1NjVBazZZSWNLaXJTNm9qUFlFYldYTS9u?=
 =?utf-8?B?NHJMem5WS0lmclZtWTJ1WnBqc1FHVGtuZmczSzkvZGJxbmIzYXpQeHFnaWRL?=
 =?utf-8?B?WE5nblFFTHVmS3YxNDgrbTk1cm9neU1jSEpYTk5PVVVvdU5VdGNwQjNhbElW?=
 =?utf-8?B?dlZ1YjdDQmpUT0p6NVBoVmdweHRmelhlT1hmYllUcmF1K0c5MVh1dytSWmVQ?=
 =?utf-8?B?eStvTXdmOXBMeGptN29henlyanlHaEpSQzVCT2o2bThSdkRZalRlR0FNNmM5?=
 =?utf-8?B?T1ZCN2t6bnV0d21uUWNmOXNwQUdjRjIwS2R6ak1xOW8rUmJDclh3WkRHV2I3?=
 =?utf-8?B?ZzJpRWJaT1QzeitBT0NkOGcxKzdhcUpSNXdUQ0ZQdnVOdDQrczZYTTY1OExh?=
 =?utf-8?B?MElmRDFZMkdML1lXZjVFaXZwUzl4b3VLL0c3aHFVNE9PbFBsT0syWUVJMndv?=
 =?utf-8?B?TGVXaEpoS0wrTC91WnJPeGdDVHJnc05Zei9yT1AwanYzdTJLSWM0aEtUVTdB?=
 =?utf-8?B?VzdyVDRFVnlNNlBiK1NyWVFFd0xKc3M5STdxd0V1TVZhWmJ5YW9WNEY4RVZi?=
 =?utf-8?B?dEU2a2hBcmtUL0JLQy9UeUxEK0dBNW1jV1BiT2l0UjZiZjVwSWhEakdVbnZ4?=
 =?utf-8?B?WXJDdFlYcW92NXcwaTNvQ3FJL2FyZnBPeEFwQldLOTQwL2E2ZXZYS2dqZnZy?=
 =?utf-8?B?cDZlREpVSWVxeUJSdFQ0T05oM25MUVVSUGszaDlOK0pMZ2JTTEphV0JKM2FG?=
 =?utf-8?B?d2wyNFpjcjN2SnN6eXlYY3FodXhEYmxwNGxGNi9PVGhlUVowdUxNSHhhL3E3?=
 =?utf-8?B?L3JzdUtaaUU3c253NHJJclBBT2Y1c2hPcFNJcGpiZFdDOGFqL05zRnNQNVhN?=
 =?utf-8?B?UnhseXBCd2tYZGwva3RrU2QyanBSV2drSmFwdWpJaGErR0NiY3JLcVlWVDZB?=
 =?utf-8?B?ekdGU1JRVDE0ekl2dGFwNUE2RVpsNERndmp0dTVIRWVpZU1wT1pBYVZmTGp4?=
 =?utf-8?B?dVZpZ1FGS0tqYVVYU3lDZUpFN3hzVlljWmdWc05teEZLZDN0NnRBRFVxUEhk?=
 =?utf-8?B?bG9pTGdrejVmbUx3eFRwRFdFY3hlOHZjT0o4SjYwZXh6OUI2RE5vUXl1MzdK?=
 =?utf-8?B?VnRpNXJ0Nm5RZFphdlRmclMwcmJCUGMvWnFjcDd6THhuZVRRditrRjdMYXcr?=
 =?utf-8?B?TUxDREJUdVZxRXRiMTRIK21kV2JpZmRPb3lpUEJLRGxLSHdVMUFNS2N2VFp3?=
 =?utf-8?B?S3RhRUs5ZVRtOFg1aXl3WmZlaHdKZktHZE5kc3N5MzR3aDhVNHJ3NmNZUkZC?=
 =?utf-8?Q?HlrgGk=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076e0b96-2eac-4552-d39b-08dbd707cdf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 16:14:32.2720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0okKZqLgsaAeAK++knan8vlc9b/P8be2QhLWUev2Bikm4KcCOFmVeK1/Kpt+8i6c5GS2kZWMouMWELAVxZuxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8368
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGVsbG8gUm9iLA0KDQpPbiBGcmksIE9jdCAyNywgMjAyMyBhdCAxMDo1ODoyOEFNIC0wNTAwLCBS
b2IgSGVycmluZyB3cm90ZToNCj4gT24gRnJpLCBPY3QgMjcsIDIwMjMgYXQgOTo1NuKAr0FNIE5p
a2xhcyBDYXNzZWwgPG5rc0BmbGF3ZnVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBOaWts
YXMgQ2Fzc2VsIDxuaWtsYXMuY2Fzc2VsQHdkYy5jb20+DQo+ID4NCj4gPiBFdmVuIHRob3VnaCBy
b2NrY2hpcC1kdy1wY2llLnlhbWwgaW5oZXJpdHMgc25wcyxkdy1wY2llLnlhbWwNCj4gPiB1c2lu
ZzoNCj4gPg0KPiA+IGFsbE9mOg0KPiA+ICAgLSAkcmVmOiAvc2NoZW1hcy9wY2kvc25wcyxkdy1w
Y2llLnlhbWwjDQo+ID4NCj4gPiBhbmQgc25wcyxkdy1wY2llLnlhbWwgZG9lcyBoYXZlIHRoZSBh
dHUgcmVnIGRlZmluZWQsIGluIG9yZGVyIHRvIGJlDQo+ID4gYWJsZSB0byB1c2UgdGhpcyByZWcs
IHdoaWxlIHN0aWxsIG1ha2luZyBzdXJlICdtYWtlIENIRUNLX0RUQlM9eScNCj4gPiBwYXNzLCB3
ZSBuZWVkIHRvIGFkZCB0aGlzIHJlZyB0byByb2NrY2hpcC1kdy1wY2llLnlhbWwuDQo+ID4NCj4g
PiBBbGwgY29tcGF0aWJsZSBzdHJpbmdzIChyb2NrY2hpcCxyazM1NjgtcGNpZSBhbmQgcm9ja2No
aXAscmszNTg4LXBjaWUpDQo+ID4gc2hvdWxkIGhhdmUgdGhpcyByZWcuDQo+ID4NCj4gPiBUaGUg
cmVncyBpbiB0aGUgZXhhbXBsZSBhcmUgdXBkYXRlZCB0byBhY3R1YWxseSBtYXRjaCBwY2llM3gy
IG9uIHJrMzU2OC4NCj4gDQo+IEJyZWFraW5nIGNvbXBhdGliaWxpdHkgb24gdGhlc2UgcGxhdGZv
cm1zIGlzIG9rYXkgYmVjYXVzZSAuLi4/DQoNCkkgZG9uJ3QgZm9sbG93LCBjb3VsZCB5b3UgcGxl
YXNlIGVsYWJvcmF0ZT8NCg0KDQpLaW5kIHJlZ2FyZHMsDQpOaWtsYXM=
