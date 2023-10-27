Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F4C7D9E18
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjJ0Qho (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 12:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjJ0Qhn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 12:37:43 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DB1128;
        Fri, 27 Oct 2023 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698424660; x=1729960660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DfRX//YkJh/DVWgv6JM9g7qC+95vrrusc7xpgBq8m/g=;
  b=ozB0csis/DUX0Ag2BACYx1GL852DbvsRCaZIaE3E9GpF6QZroCIrKWKs
   49U1FPvz045a/a85RJr4pqmBTaL0quKcXrBSEtZlpwW4JJCespEoOi8zj
   uuygc/wX9jltPbJjbuJ1F01DTwntd7FxlfAd1H1jlq0cjoq5PgCp6mA7R
   mjTm/8JHKxK5J0d9z7rihot/V3zksAuh3E1ZqFe3fejNpzrl4iJbb36kW
   6jP8+6mSIYH21YAx3RyINx80HcFsUS9TRm3m7MFj/twLegyHKc7iRbL+Z
   4PwtLG2/L2UkYmGylTPNv1SKBcLwIrCFwO/h3+lZgLiiv3ITc9LSTDoqe
   g==;
X-CSE-ConnectionGUID: 4IeDjsttSZ2Hp9M0+XHGrQ==
X-CSE-MsgGUID: YwhADuC9QWKFG0+Xf7zzgA==
X-IronPort-AV: E=Sophos;i="6.03,256,1694707200"; 
   d="scan'208";a="854027"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2023 00:37:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+EHqq7unYlz15RRGLJ53gDzSoxut+Bh3kAjHZ/VoVSSdTbmBGJiQdb2j+fxvJQCV/jIq4fII0qubMPXWLIEmWx7uRWD1pTkYzHTF1Io0jEts5BewubBkfX0IpDg2ID/Z8G7uHmh+3BisO2ZoWRbeGHZeaIFRJqvrHzxgK9jar//1Ow0N6vc6dKzO3nwUVdFWFVy1f0HHVItLP184Rw+eL8FSCUozkGdT03fZV7izyf2kIbWszai6hEH3E79Tn+dh6yKHqkoIl1Ijb789zbnA41+6M0RUYSPeNVXP6DWNLofai18Iz0em4dMW7IkVeWLx3W90+cj9eQVTglihRHqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfRX//YkJh/DVWgv6JM9g7qC+95vrrusc7xpgBq8m/g=;
 b=Mf3bdPfL1Xm8+C5Vy+uMvRQ/ISeNnlNof8saZPejrpJWE+P55y2GgpSkTIOWrnEG8YUvCZJZ29rudTNDpHauA+MCgJoa0UsJ5nqD1wQqan/QRTB7nN+/Nj+C0eehlL2HeoPXL+fojA6TAuVL+dtemFLIWeB8gQZUq8CMsaDj0oAkrwBnKNRX4QVWDNimomw31JCL6N3LWm0KCFTivKVoViA1k5VAn1yCYxnt5mIU8AjcUIT+g9Njc5gheDObJO2PgsINHBa5b2/BIbBCDZoFUmPsRGNSsK5/APgXUtTzvwmaloJ0PtsJK+kr00HlniMFQw2J0cbGlWBs8Lb7n1hjEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfRX//YkJh/DVWgv6JM9g7qC+95vrrusc7xpgBq8m/g=;
 b=ropt3iDCBdmDICiamIcgIB5qufzZn1hlUsaDmt3FcRyuAH2D+uhWaO5L0qsbYecFAqwmFkboGNzAD+P2ikLC1H5QlhwdatQn+Gl2bJmkvXz5E1NEdwpFDBVplq3RIXSkioowOKEMscEEpODyhGMY1ACthNgkwsBd9noz7btFJK8=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM8PR04MB7942.namprd04.prod.outlook.com (2603:10b6:8:1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.24; Fri, 27 Oct 2023 16:37:35 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 16:37:35 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Conor Dooley <conor@kernel.org>, Niklas Cassel <nks@flawful.org>,
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
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: dwc: rockchip: Add atu property
Thread-Topic: [PATCH v2 1/4] dt-bindings: PCI: dwc: rockchip: Add atu property
Thread-Index: AQHaBoxoQTs0JHhg8kWC9n402P+JBrBZIWsAgAHN24CAAXnjgIABTyWAgAAW/QCAAAtiAA==
Date:   Fri, 27 Oct 2023 16:37:35 +0000
Message-ID: <ZTvnTvxjGBxToujt@x1-carbon>
References: <20231024151014.240695-1-nks@flawful.org>
 <20231024151014.240695-2-nks@flawful.org>
 <20231024-zoology-preteen-5627e1125ae0@spud> <ZTl0VwdFYt9kqxtp@x1-carbon>
 <20231026183501.GB4122054-robh@kernel.org> <ZTvKeeYpfX57A+yd@x1-carbon>
 <CAL_JsqLvBuFcbXR-2OHLwQ1a28DwTGXUgAOgsmWofSFrmTsNJw@mail.gmail.com>
In-Reply-To: <CAL_JsqLvBuFcbXR-2OHLwQ1a28DwTGXUgAOgsmWofSFrmTsNJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM8PR04MB7942:EE_
x-ms-office365-filtering-correlation-id: 7b0170d6-baf4-4ade-05a2-08dbd70b0657
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V4PyfFxVtBnqEMKa1UNUHhtAVzmCsiCXgrQ2deDFgEUiVvcVmeL7GaCITvQDRatO4wJZSpYoyWFjvqg3DBEI5XwGNGrJDQoim4P/X/CcPJSugDULo7DFrWjDqUFmtEW1smhTzk70Mz73kcO3LALPB2X40Y4O6KKJ2haU9qJjczNzPmq8fLRmU1QnkN+GE/kAaRQn+hjoGEfKl8ZUoSL2RZOhvil3DXl3Tk3aAqf5xq1ckmPRSykwqGkAwRaOZ6yxFkXgMX3Kjb1ihobsJ6E+c5IH5XHl2N6xYaJUmclL13eEA3D2VmzcsssWqaq2Fo4td8IxsRZt2xTFukHQL0dF87XmmYZKrOWFppGWZ5MsXLpGGew4DzvvTUOWNtLvdS/wzND5YZgtVS6CQa+AvOTMh1BF6V12x8hOU06T54UtpwDLqQzu2MITJ+x9QQ8cdZ6iL7FKY9QCNbL8nW30yjC+vY9CyARTzxnvzPrQiq/KcM+7878gzlZZ3D330pALmAxksQqbMFfTjH4pz6qwz7ffF35IOjpSmPcBbTI208/IZiaQ/NS3hhmkywmnQSL5613gfabU9YnKvXxfKFSL30Erv0bsbnhgYxHp3ISV3Xt3HpE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(9686003)(53546011)(71200400001)(478600001)(83380400001)(966005)(6486002)(6506007)(86362001)(38100700002)(82960400001)(122000001)(33716001)(5660300002)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(6916009)(26005)(7416002)(316002)(2906002)(41300700001)(38070700009)(8936002)(76116006)(8676002)(4326008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnRzS0VnamZ6VzJFNWpxQ3ZmNXJsTFNOQnprdng5aXYwRFVCWHh0L3QyNkxD?=
 =?utf-8?B?eGhTaVNDNFVCaGptZnQyZVl3OTQvQXFQWWtBQTF1alNId3ZwMGsvZ3d4Mm5j?=
 =?utf-8?B?UWd3K1dDdUducWZMejhNMmxsUDhldFJsK0xlS0liZUsxQjF3clFENkZtY3c3?=
 =?utf-8?B?M3plQUE1VG10VXhZdlpPaXU2a2tkVmphVDExbGdnc1pKUkJhV3BVbHk0amQw?=
 =?utf-8?B?dGRDK1M2eWUyVEhKMmFJQ1JWeDhHZjRzZGFXUFNzVldUbFlPWHJCRVVROGln?=
 =?utf-8?B?bnFpOTNKYkpURE5LZWJEazJwamdnSVNPd0JSekUwb2R1cGlXdUx0YnBxMW9P?=
 =?utf-8?B?cGxmZmNwc3lrL3VkeW1zalRDdG5rTUJyMlBsaUtJVFNUVXVvdUI4R1cyUDBm?=
 =?utf-8?B?UHN4S3E4OThzeC9ZeE1SNWJ2Si9SeGU3aE02UlRNM0lMRXoxL2ZxQ1NYcVFE?=
 =?utf-8?B?SnJYaE4weHlXZVNpaGdxTmNMY0w3L2tla0xVbW9PeGRFTW9hRGZLNmhjOHZi?=
 =?utf-8?B?U0wweW1xZ0JZWHZwYmc0NjdOcXo3dFF6VWVrbGw5L0NBZzBuMldYdTNEM2Rz?=
 =?utf-8?B?OEV4MEd3TjVyUW1kMzBaVFBnTlEyeFhIZTRmYWtZUlh0bVJVVzRGd3AxY3B4?=
 =?utf-8?B?ckRYTnJTMjBoYUpkbFNnQ2ExNVY1NW0rQnFZa1FZckFWcDB3dnkra3NxYlBm?=
 =?utf-8?B?WEJsbmxhdnhuK0kvWW1wU05zUmh5dWVNM0dCQyttWEZ6N3JDSE4rdFRJSmhZ?=
 =?utf-8?B?bWpRZ2pJeHpWallNMmg3S2paUzd1ZVZkYUFPbWF5YUlqWjU5TjRhbjZaWEE5?=
 =?utf-8?B?SVowNnR4SW9ja2FvSitVd0ZsVnAvQmluMERQZFFXUkZVRjhkeTVheHlJMjFV?=
 =?utf-8?B?NDZTWXpmTkdBTTU0MkI0OWw2eW9SZ1k0RDlvelhCeGVrNEtmSVFtaHdKWnVK?=
 =?utf-8?B?Rm4zb012L3U3YkRRTUNBMURybHZMMjBoQzFvOS9DUkN4aDByeUNIRWs1ZDZk?=
 =?utf-8?B?QkloZ0JtNU1NZTFWUk1BZ0s4a3JsQlpzbFhyblpKV0JITFdRU0RvS3Q3ejNl?=
 =?utf-8?B?ZitSelVOQmtaMUhZS0lPUEJjRFoyUGtZWFVzalhhNXhtQWxrU0k3eFlGZk85?=
 =?utf-8?B?OXlIajNqQjVtNXV0bmNJN2hVMkUyankvN0FFS3JrMmcvelZuWUMzREZ5MUxB?=
 =?utf-8?B?T2NSaW1pTkVFaDF1Um8rSUMvL2c1MVFYb3crSnZYQVArL0s4WEJTYmhpMkx4?=
 =?utf-8?B?eGtFbitFYUI1QkM4UkZFenlrTVVqQ2M2d0RYR1hyZW5JUFlWZ3NLdnd5bXFh?=
 =?utf-8?B?TEcxREVZZ1J5TlVYRkVjRDdrQ05DMVoxdGxqMUh1Qms3ckJOSVBQenV2aThZ?=
 =?utf-8?B?Mko0SmdFSGc3Q1pOVFg3Vmt1d3BhckpGeFozQncwZytoaXpkdFQ0SHl1YVhp?=
 =?utf-8?B?eVpKWnQvNUQzN00zTUR1N0svZmFmVlZ0bUNDTFluTjlPRWFVZEZ1REFrdCtK?=
 =?utf-8?B?dG1wLzdEUHNLY1c2Q21Ua3cxamtoYTk2N0hIMkNGQmU0eTBQNnIwOERRUklF?=
 =?utf-8?B?NWlHV0hSdFRWdW14eWtqZGsyMjltQXBRVlVpZzd3T1Q5bkl1bzRIREV0MktU?=
 =?utf-8?B?dm5qcFkwdkhYeHhXdEJxOThZY0ErejBrVkRlcy9LMlZRVzRiQzNoRlpINXJB?=
 =?utf-8?B?R1FxUk5FQU9lckFRNlVqWDh5TEllL1hFSlBCVkUvZjJyK3dTTys2UUFPaWlM?=
 =?utf-8?B?T01XcFppRWRDeUVNcHFtM1pJSUZQcms3eG9IV0kxQzhiVFp4TWtaSEczWHRj?=
 =?utf-8?B?WFlzNUtrQ051UG5ZUjJteS9POXErc3ZTdTdZNWN3YnFrQVUvdkNNMy9pQ0lD?=
 =?utf-8?B?cE1Nd21wWmVLYjZQR3hZYW9VQWlJWUVUTTZxZk9XL0EyWU9KZTQrdkc2L2Na?=
 =?utf-8?B?V2VsaGV3Q2wzbzFHUWlKYVYrS2xDRko3ajZ5Q3hPRkpJNWU3YlNVd212blJ0?=
 =?utf-8?B?T0swNG9OZnZDKytGY1FQTldQeWZuSEpvL1VMb0JRQ3FPSmNzRGxmZkVsSG43?=
 =?utf-8?B?VlpLcVZPSHRvSSswblFmalNDVDB2d1BENk9rN2l5dWp5U0RnMVlVbjhhNGdF?=
 =?utf-8?B?cHg5cElBcXZkeGFFZHl3SUo1bnZnaXY5NENEa2h5TFplMzhkejVObUJuVHd3?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E795B8347746E742AA50A2F62AEB46BA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RFRvL1NWem5zNnJ3Y1RiWXlEcWRYdEtWQVg5NkZId01HTEhwci9NalpWK2Zs?=
 =?utf-8?B?T1ZGVGo5dVFsVWNDUHZvSUFIT3ZvMDNLSUxuTllxSHoxK2tJa05PNGhHOFhy?=
 =?utf-8?B?MFBHZEVodC9SSGYwTHpNaldDc1VTaU1jbnBya2JGaWtBQzZpY05lOUdvWjVX?=
 =?utf-8?B?MyswRG1mbE42RnRMR045Ly95dWltLzR3YmtncUxRYy85NlpyWnJUUzZNUXVX?=
 =?utf-8?B?MzBzbTg1TVFJOFo1N1FQV2hYVjBVMnh6djhxNkNscjlyNmpEN0NWdDBPL1Fy?=
 =?utf-8?B?alRDa1pkWDlVN1VpOXpucVpBMnV1M05ZK3FXSEY2OVg5SFlJMGZ1c3lZbkpQ?=
 =?utf-8?B?R0gxMlZBSnU2cm1JRnpyMGsxWVFCR3dkWUltcjFFR1NpU2N2aVkwT0tBbjEy?=
 =?utf-8?B?WVl3K05US2pJTGwvMlMwZ200eCsvNG1kcm01ZWFRVmxWOVpnUUlvbGtVMEIy?=
 =?utf-8?B?U1JSYjltVUY1TjYxczFDUU1jaXRia3NyQXpBV2Q4aFBoQ1R0VEU0OHhhYWhr?=
 =?utf-8?B?Tjlwd1BtWlVKcmRxMS9aZ052dWU2SGZOZGprN1lETkM1a3AzdVZ6elB1VWQx?=
 =?utf-8?B?NFRvRVU0R1daUm41K2RCOFdNamhpUXBDdWcxRHJKdXdnbmRxLzJKRTVqU3cx?=
 =?utf-8?B?Z0szZGF1WEVWVi9aNmNRekFHdUpQTlo0b0paQUpsOEdWak9XdnZuS3k0Y21S?=
 =?utf-8?B?a251ckNXd29JVzg2WXN0c0Z6N0I1Z0VaU0dNbFBxQlF6aEp4Q1dNQ2REeWZm?=
 =?utf-8?B?K0FBTEtKOXkxRHhDM3d0aWlyaWFPZk9EYjFzZWVqcHdvajcvMElOVjYrOTlJ?=
 =?utf-8?B?RktrWllCYm5udnJ3WUZ4L09NM2VLbWRJbjRic1htQUR3ODc1cnQ0NFp3Z3FT?=
 =?utf-8?B?M0YreEZMem94UFlIMGZ1VUkvSXRrU1ZvYkZJVDJsTkZTZW9rWTFxWmJvVVZr?=
 =?utf-8?B?dGJjNkNQYWZXWHBNZEg3dUpVVEU1M3N3NG01YkdpTWQ3eHRmR053ZmZoWUht?=
 =?utf-8?B?U3NyQ1ZKb1FtTHMvUmUzVy90eUxxdXF1cnhqc2c3aEdMQThhZXNkOW8rb2d5?=
 =?utf-8?B?cHFRQUNkdUk1TWl1NVUrd3pnR1JBL082UmM1ZitMRFlGZUhFR1RMQWczdHRE?=
 =?utf-8?B?NFMyYmFhNEM4R3I4UnRVUWMzVEpZRzEvQ1I3d0x1ckM0RGdEdDFTTldUd0R4?=
 =?utf-8?B?a1A0ZUJVWDhCSUFXZHZzMnVuTW5vRTE4WlZwVTlzR2czYzd4RVlQck1XVWpk?=
 =?utf-8?B?N1NXVWNqdjBZeEs1M0JRM0h5TmxFOE5KTE1JZzNUV01IeFdwb09KeGVBaGJn?=
 =?utf-8?B?ZWsvTE5FOFZlZjNxS3VtMkw0QWpjTTY5dE13amZyV0lMSVg5OVFFTVA0R0Fl?=
 =?utf-8?B?T1N2NmRLMnZoZGZPL3NSQUlwUm5qeHpLTGlqZkpzQm5qU041c3BCa3BwcVVC?=
 =?utf-8?B?NXdBMnlnaVJwdk9IVnhpa0ZGaWNkVGtpQ3Z1c2dRPT0=?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0170d6-baf4-4ade-05a2-08dbd70b0657
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 16:37:35.3590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDsaRq4eGjsDtWDW5p8R5KPJiMpQQzH3uEQWDIFdRlvey0HUVu42S3A257VIkaabCo4fl7jf0YMpgn+36oN0Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7942
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCBPY3QgMjcsIDIwMjMgYXQgMTA6NTY6NTBBTSAtMDUwMCwgUm9iIEhlcnJpbmcgd3Jv
dGU6DQo+IE9uIEZyaSwgT2N0IDI3LCAyMDIzIGF0IDk6MzXigK9BTSBOaWtsYXMgQ2Fzc2VsIDxO
aWtsYXMuQ2Fzc2VsQHdkYy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGVsbG8gUm9iLA0KPiA+DQo+
ID4gT24gVGh1LCBPY3QgMjYsIDIwMjMgYXQgMDE6MzU6MDFQTSAtMDUwMCwgUm9iIEhlcnJpbmcg
d3JvdGU6DQo+ID4gPiBPbiBXZWQsIE9jdCAyNSwgMjAyMyBhdCAwODowMjozMlBNICswMDAwLCBO
aWtsYXMgQ2Fzc2VsIHdyb3RlOg0KPiA+ID4gPiBIZWxsbyBDb25vciwNCj4gPiA+ID4NCj4gPiA+
ID4gT24gVHVlLCBPY3QgMjQsIDIwMjMgYXQgMDU6Mjk6MjhQTSArMDEwMCwgQ29ub3IgRG9vbGV5
IHdyb3RlOg0KPiA+ID4gPiA+IE9uIFR1ZSwgT2N0IDI0LCAyMDIzIGF0IDA1OjEwOjA4UE0gKzAy
MDAsIE5pa2xhcyBDYXNzZWwgd3JvdGU6DQo+ID4gPiA+ID4gPiBGcm9tOiBOaWtsYXMgQ2Fzc2Vs
IDxuaWtsYXMuY2Fzc2VsQHdkYy5jb20+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRXZlbiB0
aG91Z2ggcm9ja2NoaXAtZHctcGNpZS55YW1sIGluaGVyaXRzIHNucHMsZHctcGNpZS55YW1sDQo+
ID4gPiA+ID4gPiB1c2luZzoNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBhbGxPZjoNCj4gPiA+
ID4gPiA+ICAgLSAkcmVmOiAvc2NoZW1hcy9wY2kvc25wcyxkdy1wY2llLnlhbWwjDQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gYW5kIHNucHMsZHctcGNpZS55YW1sIGRvZXMgaGF2ZSB0aGUgYXR1
IHByb3BlcnR5IGRlZmluZWQsIGluIG9yZGVyIHRvIGJlDQo+ID4gPiA+ID4gPiBhYmxlIHRvIHVz
ZSB0aGlzIHByb3BlcnR5LCB3aGlsZSBzdGlsbCBtYWtpbmcgc3VyZSAnbWFrZSBDSEVDS19EVEJT
PXknDQo+ID4gPiA+ID4gPiBwYXNzLCB3ZSBuZWVkIHRvIGFkZCB0aGlzIHByb3BlcnR5IHRvIHJv
Y2tjaGlwLWR3LXBjaWUueWFtbC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBOaWtsYXMgQ2Fzc2VsIDxuaWtsYXMuY2Fzc2VsQHdkYy5jb20+DQo+ID4gPiA+ID4gPiAt
LS0NCj4gPiA+ID4gPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3Jv
Y2tjaGlwLWR3LXBjaWUueWFtbCB8IDQgKysrKw0KPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9yb2NrY2hpcC1kdy1wY2llLnlh
bWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3JvY2tjaGlwLWR3LXBj
aWUueWFtbA0KPiA+ID4gPiA+ID4gaW5kZXggMWFlOGRjZmEwNzJjLi4yMjlmODYwOGM1MzUgMTAw
NjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGNpL3JvY2tjaGlwLWR3LXBjaWUueWFtbA0KPiA+ID4gPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9yb2NrY2hpcC1kdy1wY2llLnlhbWwNCj4gPiA+ID4g
PiA+IEBAIC0yOSwxNiArMjksMjAgQEAgcHJvcGVydGllczoNCj4gPiA+ID4gPiA+ICAgICAgICAg
ICAgLSBjb25zdDogcm9ja2NoaXAscmszNTY4LXBjaWUNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiAgICByZWc6DQo+ID4gPiA+ID4gPiArICAgIG1pbkl0ZW1zOiAzDQo+ID4gPiA+ID4gPiAgICAg
IGl0ZW1zOg0KPiA+ID4gPiA+ID4gICAgICAgIC0gZGVzY3JpcHRpb246IERhdGEgQnVzIEludGVy
ZmFjZSAoREJJKSByZWdpc3RlcnMNCj4gPiA+ID4gPiA+ICAgICAgICAtIGRlc2NyaXB0aW9uOiBS
b2NrY2hpcCBkZXNpZ25lZCBjb25maWd1cmF0aW9uIHJlZ2lzdGVycw0KPiA+ID4gPiA+ID4gICAg
ICAgIC0gZGVzY3JpcHRpb246IENvbmZpZyByZWdpc3RlcnMNCj4gPiA+ID4gPiA+ICsgICAgICAt
IGRlc2NyaXB0aW9uOiBpQVRVIHJlZ2lzdGVycw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSXMgdGhp
cyBleHRyYSByZWdpc3RlciBvbmx5IGZvciB0aGUgLi44OCBvciBmb3IgdGhlIC4uNjggYW5kIGZv
ciB0aGUNCj4gPiA+ID4gPiAuLjg4IG1vZGVscz8NCj4gPiA+ID4NCj4gPiA+ID4gTG9va2luZyBh
dCB0aGUgcmszNTY4IFRlY2huaWNhbCBSZWZlcmVuY2UgTWFudWFsIChUUk0pOg0KPiA+ID4gPiBo
dHRwczovL2RsLnJhZHhhLmNvbS9yb2NrMy9kb2NzL2h3L2RhdGFzaGVldC9Sb2NrY2hpcCUyMFJL
MzU2OCUyMFRSTSUyMFBhcnQyJTIwVjEuMS0yMDIxMDMwMS5wZGYNCj4gPiA+ID4NCj4gPiA+ID4g
VGhlIGlBVFUgcmVnaXN0ZXIgcmVnaXN0ZXIgcmFuZ2UgZXhpc3RzIGZvciBhbGwgMyBQQ0llIGNv
bnRyb2xsZXJzDQo+ID4gPiA+IGZvdW5kIG9uIHRoZSByazM1NjguDQo+ID4gPiA+DQo+ID4gPiA+
IFRoaXMgcmVnaXN0ZXIgcmFuZ2UgaXMgY3VycmVudGx5IG5vdCBkZWZpbmVkIGluIHRoZSByazM1
NjguZHRzaSwgc28gdGhlIGRyaXZlcg0KPiA+ID4gPiB3aWxsIGN1cnJlbnRseSB1c2UgdGhlIGRl
ZmF1bHQgcmVnaXN0ZXIgb2Zmc2V0ICh3aGljaCBpcyBjb3JyZWN0KSwgYnV0IHdpdGgNCj4gPiA+
ID4gdGhlIGRyaXZlciBmYWxsYmFjayByZWdpc3RlciBzaXplIHRoYXQgaXMgb25seSBiaWcgZW5v
dWdoIHRvIGNvdmVyIDggaW5ib3VuZA0KPiA+ID4gPiBhbmQgOCBvdXRib3VuZCBpQVRVcyAoaW50
ZXJuYWwgQWRkcmVzcyBUcmFuc2xhdGlvbiBVbml0cykuDQo+ID4gPg0KPiA+ID4gV2Ugc2hvdWxk
IHByb2JhYmx5IG1ha2UgdGhlIGRyaXZlciBzbWFydGVyIGluc3RlYWQgb3IgaW4gYWRkaXRpb24u
IFdlDQo+ID4gPiBoYXZlIHRoZSBEQkkgc2l6ZSwgSnVzdCBtYWtlIGF0dV9zaXplID0gZGJpX3Np
emUgLSBERUZBVUxUX0RCSV9BVFVfT0ZGU0VULg0KPiA+DQo+ID4gSSB0aG91Z2ggYWJvdXQgdGhh
dCwgYnV0IGl0IHNlZW1zIHRoYXQgc29tZSBkcml2ZXJzIGRvbid0IHVzZQ0KPiA+IHJlcyA9IHBs
YXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9NRU0sICJkYmkiKQ0K
PiA+DQo+ID4gYnV0IGluc3RlYWQgc2V0IHBjaS0+ZGJpX2Jhc2UgZnJvbSBub24tY29tbW9uIGNv
ZGUsIGUuZy46DQo+ID4gZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWRyYTd4eC5jOiAg
ICAgICAgcGNpLT5kYmlfYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5h
bWUocGRldiwgImVwX2RiaWNzIik7DQo+ID4gZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWRyYTd4eC5jOiAgICAgICAgcGNpLT5kYmlfYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9y
ZXNvdXJjZV9ieW5hbWUocGRldiwgInJjX2RiaWNzIik7DQo+ID4gZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWlteDYuYzogIHBjaS0+ZGJpX2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2dldF9h
bmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwLCAmZGJpX2Jhc2UpOw0KPiA+IGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1rZXlzdG9uZS5jOiAgICAgIHBjaS0+ZGJpX2Jhc2UgPSBiYXNl
Ow0KPiA+IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmM6IGRi
aV9iYXNlID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JFU09VUkNFX01F
TSwgInJlZ3MiKTsNCj4gPiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2Fw
ZS1lcC5jOiBwY2ktPmRiaV9iYXNlID0gZGV2bV9wY2lfcmVtYXBfY2ZnX3Jlc291cmNlKGRldiwg
ZGJpX2Jhc2UpOw0KPiA+IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBl
LmM6ICAgIGRiaV9iYXNlID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JF
U09VUkNFX01FTSwgInJlZ3MiKTsNCj4gPiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2kt
bGF5ZXJzY2FwZS5jOiAgICBwY2ktPmRiaV9iYXNlID0gZGV2bV9wY2lfcmVtYXBfY2ZnX3Jlc291
cmNlKGRldiwgZGJpX2Jhc2UpOw0KPiA+IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1t
ZXNvbi5jOiBwY2ktPmRiaV9iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5
bmFtZShwZGV2LCAiZWxiaSIpOw0KPiA+IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
YWwuYzogICB2b2lkIF9faW9tZW0gKmRiaV9iYXNlID0gcGNpZS0+ZGJpX2Jhc2U7DQo+ID4gZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1hbC5jOiAgIGFsX3BjaWUtPmRiaV9iYXNlID0g
ZGV2bV9wY2lfcmVtYXBfY2ZnX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gPiBkcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWFybWFkYThrLmM6ICAgICBwY2ktPmRiaV9iYXNlID0gZGV2bV9w
Y2lfcmVtYXBfY2ZnX3Jlc291cmNlKGRldiwgYmFzZSk7DQo+ID4gZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmM6ICAgICAgICAgICBwY2ktPmRiaV9iYXNlID0gZGV2
bV9wY2lfcmVtYXBfY2ZnX3Jlc291cmNlKHBjaS0+ZGV2LCByZXMpOw0KPiA+IGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtaGlzdGIuYzogICAgICAgIHBjaS0+ZGJpX2Jhc2UgPSBkZXZt
X3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKHBkZXYsICJyYy1kYmkiKTsNCj4gPiBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXFjb20tZXAuYzogICAgICBwY2ktPmRiaV9i
YXNlID0gZGV2bV9wY2lfcmVtYXBfY2ZnX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gPiBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LWFjcGkuYzogICAgICAgIHBjaWVfZWNh
bS0+ZGJpX2Jhc2UgPSBjZmctPndpbiArIFNaXzUxMks7DQo+ID4NCj4gPiBTbyBJIGRvbid0IHRo
aW5rIHRoYXQgd2UgY2FuIGFsd2F5cyBnZXQgdGhlIHNpemUgb2YgdGhlIGRiaS4NCj4gPiBBbmQg
YSBzb2x1dGlvbiB0aGF0IGRvZXMgbm90IHdvcmsgZm9yIGFsbCBwbGF0Zm9ybXMgaXMgbm90DQo+
ID4gdGhhdCBhcHBlYWxpbmcuDQo+IA0KPiBEbyBJIGdldCBhIGNoYW5jZSB0byByZXNwb25kIGJl
Zm9yZSB5b3Ugc2VuZCBhIG5ldyB2ZXJzaW9uPw0KPiANCj4gRG9lcyBzb21ldGhpbmcgbGlrZSB0
aGUgcGF0Y2ggYmVsb3cgbm90IHdvcmsgZm9yIGV2ZXJ5b25lPyBXZSBjb3VsZA0KPiBzdG9yZSB0
aGUgREJJIHNpemUgYXMgd2VsbCBpZiB3ZSB3YW50IG1vcmUgdGhhbiA4IHJlZ2lvbnMgdG8gd29y
aw0KPiB3aXRob3V0IGEgJ2RiaScgbm9yICdhdHUnIHJlZ2lvbiBkZWZpbmVkLiBXZSBzaG91bGRu
J3QgaGF2ZSBuZXcgdXNlcnMNCj4gZG9pbmcgdGhhdCB0aG91Z2guDQoNCkZvciB0aGUgZHJpdmVy
cyBsaXN0ZWQgYWJvdmUsIHRoZXkgYXNzaWduIHBjaS0+ZGJpX2Jhc2UgaW4gbm9uLWNvbW1vbiBj
b2RlLg0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLmMNCj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2ln
bndhcmUuYw0KPiBpbmRleCAyNTBjZjdmNDBiODUuLjNkYzcxZWE3ZmE3NiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gKysrIGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gQEAgLTEwNSwx
MSArMTA1LDEzIEBAIGludCBkd19wY2llX2dldF9yZXNvdXJjZXMoc3RydWN0IGR3X3BjaWUgKnBj
aSkNCj4gICAgICAgICBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2ID0gdG9fcGxhdGZvcm1f
ZGV2aWNlKHBjaS0+ZGV2KTsNCj4gICAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2
X29mX25vZGUocGNpLT5kZXYpOw0KPiAgICAgICAgIHN0cnVjdCByZXNvdXJjZSAqcmVzOw0KPiAr
ICAgICAgIHNpemVfdCBkYmlfc2l6ZSA9IERFRkFVTFRfREJJX0FUVV9PRkZTRVQgKyBTWl80SzsN
Cj4gICAgICAgICBpbnQgcmV0Ow0KPg0KDQpTbyB0aG9zZSBkcml2ZXJzIHdpbGwgbm90IGVudGVy
IHRoaXMgaWYtc3RhdGVtZW50Og0KDQo+ICAgICAgICAgaWYgKCFwY2ktPmRiaV9iYXNlKSB7DQo+
ICAgICAgICAgICAgICAgICByZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYs
IElPUkVTT1VSQ0VfTUVNLCAiZGJpIik7DQo+ICAgICAgICAgICAgICAgICBwY2ktPmRiaV9iYXNl
ID0gZGV2bV9wY2lfcmVtYXBfY2ZnX3Jlc291cmNlKHBjaS0+ZGV2LCByZXMpOw0KPiArICAgICAg
ICAgICAgICAgZGJpX3NpemUgPSByZXNvdXJjZV9zaXplKHJlcyk7DQo+ICAgICAgICAgICAgICAg
ICBpZiAoSVNfRVJSKHBjaS0+ZGJpX2Jhc2UpKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gUFRSX0VSUihwY2ktPmRiaV9iYXNlKTsNCj4gICAgICAgICB9DQoNClNvIGZvciB0aG9z
ZSBwbGF0Zm9ybXMgZGVmYXVsdCBzaXplIHdpbGwgc3RpbGwgYmUgNGsuDQoNCg0KQnV0IHN1cmUs
IHRoaXMgd2lsbCBhdm9pZCB0aGUgbmVlZCBmb3Igc29tZSBwbGF0Zm9ybXMgdG8gc3BlY2lmeSAi
YXR1IiByZWcsDQpzbyBJJ20gYWxsIGZvciBpdC4gQ291bGQgeW91IHBsZWFzZSBzZW5kIGl0IGFz
IGEgcmVhbCBwYXRjaD8NCg0KSWYgeW91IGRvLCBjb3VsZCB5b3UgcGxlYXNlIGFsc28gdXBkYXRl
IHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUgZHQgYmluZGluZzoNCmh0dHBzOi8vZ2l0aHViLmNvbS90
b3J2YWxkcy9saW51eC9ibG9iL3Y2LjYtcmM3L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvc25wcyUyQ2R3LXBjaWUueWFtbCNMNDEtTDQzDQoNClRoYXQgc2F5cyB0aGF0IGlB
VFUgbWVtb3J5IHJlZ2lvbiBpcyByZXF1aXJlZCBpZiB0aGUgc3BhY2UgaXMgdW5yb2xsZWQuDQoN
Cg0KS2luZCByZWdhcmRzLA0KTmlrbGFz
