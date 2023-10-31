Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465AB7DD0F0
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 16:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjJaPvL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjJaPvK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 11:51:10 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F82B8F;
        Tue, 31 Oct 2023 08:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698767467; x=1730303467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DPJHABdy7AD1bzpkj3/T4x7I9/Th9YICGyWQEA8wcwY=;
  b=bFPoi2tmEs9trAuH1YkPNUvr1lVSmoBdXVkkIsbhj8/+oFCUB3npAjFZ
   AdOZaQ9dVi+CAc9dsj3V+d5MM5CFDR/2FcNDdO60iVZefxskazJACUs5f
   EDWVgrulRL20KD8s1ur+kPfjmf787tRujE4jOCqtZLCtMHClFnd3zbVjJ
   6mehZjht4Z4W3hbYa8dsHYWSrWTh2OPfcz/NlxG0FuKaVS6jtGb4v/fbd
   2b0WLSveM0LLRJl6Feifl1fplkFIfjp4EiSGV+gKeejFzkyQCmxpTbxe1
   msXOzU9Fn9gj2hz7AhlSuXBWfbMgBQ7pPy3skAiYoYEWhoS7qZ7V0kUoS
   g==;
X-CSE-ConnectionGUID: jcOnT0F0T2OjwvhCCLV+aw==
X-CSE-MsgGUID: N6hHAwuvS72evYRnI+8H+w==
X-IronPort-AV: E=Sophos;i="6.03,265,1694707200"; 
   d="scan'208";a="1049929"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2023 23:51:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggVPgywu++/IzMh5kuX+8CcWSSg76ayblEukJ0kP1x+fWgbmJEtb1JwAQDdmajmya5McujGAxtWrgw8Ev+yhawgMlyHo63I+swwHrP1PtVKKn+4Qd+W6S/0K7geC+nyiadZTKgXTrTCQ8edSFsgATWCCgrKXz2AfZTTy+uM6Q3DnfZNpUDWGj0hkeios2/cc32uv2wGJeGi9tLI6LxpghdBzaBMKYmW6MFFrqIgRMbofBTi74w44qLuUne3Xu3mQqgGvW4PhIQ/fXtD36u3tQsVxHOEMRjshD0jf4Cf9cIT6LfO64lNSKICDgmwYnMbw3gpXhUaaNWHwa0vAFo+fTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OacOOX2Nsm1kCBr0yR8V81vWM41vHx0aE4S2n51KTQw=;
 b=OWUR0jCZseeSIwnTti5Q+GgQGeqjRg5itAtwxuIoG4Fz5Bg5EE5sBMBvegRoIXnDZBqGBBsWC3gm+X8gLuoxnrT+Ub2Tcu4uxn3sHR346Jx82G1Qjzwi8UYVSVi9GaYkBNbNJZw9UhCDs+ZLebpsgMZr/QDiPC9/cE1lpjBoNsjIWdZtUVTl8j8iRm9oE+QFgWAeQ7bVDUEXZyBir4kIw4lsh/5hoYnTnDBGLzPnXQNNEgwbkSukog53w5d3WplUWH3hAH1iRZe052b6omh/hWwfealMz5iD1U28XP3VLAwhNQFvvNTrfVxbB8QFJ5t0C20vCimVVyLbWSWpQH97ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OacOOX2Nsm1kCBr0yR8V81vWM41vHx0aE4S2n51KTQw=;
 b=HzlNiMRwzTp6d0kDrFxH/+JLpuA15cuT21I+66K0khY6aegC83lPEkittSkCcXZAOgh9HiTzxuNhnvkMlM3MRFP9Q8W9W5gc9tjXQh6MM9iTFe5n/InaWH/G5DN0qAP9IQT7peiai0dceJhzl6XHksOpPBJtTugpzQ7Fj13+tVs=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH0PR04MB7905.namprd04.prod.outlook.com (2603:10b6:610:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Tue, 31 Oct
 2023 15:51:03 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6%4]) with mapi id 15.20.6933.026; Tue, 31 Oct 2023
 15:51:03 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Niklas Cassel <nks@flawful.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v3 2/6] dt-bindings: PCI: dwc: rockchip: Add optional dma
 interrupts
Thread-Topic: [PATCH v3 2/6] dt-bindings: PCI: dwc: rockchip: Add optional dma
 interrupts
Thread-Index: AQHaCOXD5lFnH3cp6kCcuWNGHBAs/rBjHDmAgAD2EIA=
Date:   Tue, 31 Oct 2023 15:51:03 +0000
Message-ID: <ZUEiY5i7DUWThhNX@x1-carbon>
References: <20231027145422.40265-1-nks@flawful.org>
 <20231027145422.40265-3-nks@flawful.org>
 <jxsrtqplojsab4a64erm7ojjdm3kq5ohb5l7vf3lf7gzvx3q3d@ilyu4vg2xeze>
In-Reply-To: <jxsrtqplojsab4a64erm7ojjdm3kq5ohb5l7vf3lf7gzvx3q3d@ilyu4vg2xeze>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH0PR04MB7905:EE_
x-ms-office365-filtering-correlation-id: 45360982-d290-444f-9d25-08dbda292fcc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FN1UKJHPun81f70+ZEiitt+HULyekcJyLj/2NcM0esepXITV517Z3moh2IV+QMvob1vhGYHTaWN/aHE1E0zs5I86uFUhCrpNk+G2q38W82WRxq/idgdi7mXM29NOsTth1JOIpQI/B8b/k01jWaBbKmhYn2MZK/nFM3m6KINxHuPLF0eWkb/+g63Z4sGcsBPv8MgQaF4aDDvS3wHwzksrmT31dllaMHH2OyDb7Gb8FT6Jx5hoJnfrKZKHzWOk8mZSUsPkb/PwfMtOMQFyd1K0CmlliitFCOEy16ud1BUNIOpt9lkhhSlBav8THbRiQlaVTvRbDBBmiH4SxafpoUACJP5TUTMn6ulAunHyo3ktqUbs9NLm204PMcasLiMhJ2EaOvGZjvmUY0LA7YyR/epNsUunDX3PIHPDyX6QgcakV8B9Jpx4mrL0dEtp6zX04keJ3T1Ex1wuJ9LtiCeBZQkScEx1UVQ23W/qQeM5yOYfrPadA/iUM/kCUJA4y4UaookMWHaRLCt4RL/4KmpGd/c06Os7TRBJMSDDtiMela4q+zodcSPTySLiiMdD5VabmxzQF/APCyuUFFHu0IYltDJtRQwJgJRciC8vE67tJiuuXoz7aPO+OrWDPOd3croeyEW8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(9686003)(26005)(38070700009)(38100700002)(86362001)(122000001)(82960400001)(316002)(2906002)(6486002)(6506007)(4744005)(8936002)(5660300002)(71200400001)(478600001)(7416002)(33716001)(4326008)(6916009)(54906003)(41300700001)(8676002)(66556008)(66476007)(66446008)(76116006)(64756008)(91956017)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?qNNkXPUF2zHP3vyd5oXPqA/wZ8fTxPzijEwkxTnCpkOof8XZJNkGKiN0KA?=
 =?iso-8859-2?Q?W1IEnt+2/ijzbOfErRQux64By6EFbPSC38GUmUuYRSnE7OwQWfqrC1Frcu?=
 =?iso-8859-2?Q?cWM2rO505p+GCU7fzWXsLLGZHQw8iQykeRtfAlgp6LSl/QkIxeorkfoPNq?=
 =?iso-8859-2?Q?GWjRe0vQCjizY8iohHhFkm5KiqfDWmyglAwaMmZB9sJGWWijZk8xxOhwee?=
 =?iso-8859-2?Q?WnEpxpq+ZM6RuiMcLbqvHqKCyYSCYuyrZ7+EyfTrwl+x7IcbktUiRmZpFD?=
 =?iso-8859-2?Q?+0UhMo6CCdzJAUEZogyu8UF1mn0vvSJ3hmAhVLl+VOwb9NzWPuc0ZtOZB4?=
 =?iso-8859-2?Q?L3hQyztylr9xUNSymZ93s03QTQO4sBLSlZDAh3ZZi0nwwSjaVqukkQ+H3K?=
 =?iso-8859-2?Q?YnKK5ofU2eXAwcyB3UDs9g2RX688QEoRZSQw6HkVLun1coTnkn49NYfyVj?=
 =?iso-8859-2?Q?Ljyd89ckClblX6LF9LsEIgmWimn/BjhnMsX1NktvnF2nQ72aA6EKepVz6q?=
 =?iso-8859-2?Q?1EtFTpHnkgRZQ52ZKZkby7D3UFU0gD79mF8AwEhI7mxce5Tp4kkrx2mVcD?=
 =?iso-8859-2?Q?YYSSo3BedFcm2dXWNTauIiBotHuIeKY1g3VOd20r6cxUd7Y2vdGKaMB3S+?=
 =?iso-8859-2?Q?OrGHcDlLhDx/V4j8c3etR6coAkNvnDE/IkhnC3aY/7ZyaXmRjRN72Oa7rj?=
 =?iso-8859-2?Q?OMTYAQbI3GkN163WJyv7NiyJrPAeCw/jMDfjYIMwNHN4cY6VWaCRdmPmiz?=
 =?iso-8859-2?Q?EmT2aXZfv9NsCUo/h7UjkSqE/iaqYz4ZEw2Ex9lJ4Jw+n/FOsRJ4knntQA?=
 =?iso-8859-2?Q?heQ5xAxJfBMll3MuHKBPs65sOXrZZX6HB6HdkMTWyLPEdlQg2yRONexYfs?=
 =?iso-8859-2?Q?uzllKLN9muoXjcksQ96B3i6dUBTjuw96igoMxP6u/lnBj8fmWt/DFmoejm?=
 =?iso-8859-2?Q?Ks4wRXXCo974F3p/3BX3GQ/xQCAd+vl/c4u2F5Q1uVUWIznlkxLx2hODqn?=
 =?iso-8859-2?Q?KjhrmoLFo5fyZevGP4/Ww5MgwYlXpwZB3MD84/a2YhnIjJCIyXO+qmKb5b?=
 =?iso-8859-2?Q?nqQ+vmbO2+6epm2MBi7EfbBi8sbytlIr1g41/Xuxarh/vzwOFASCXsnFHK?=
 =?iso-8859-2?Q?HMzpzZRsoHDWTfoG7W8l+KcXRlDU5ntFme7Pl6FxE3B5iGrc/3CuSw5+P0?=
 =?iso-8859-2?Q?IEui8pj5nTnkImBcJerObOLEfhUs1oyZiDqSRwTVn9jPbT2Cu4VIxxryga?=
 =?iso-8859-2?Q?4SidNfA0/myToH1cpi1h9oOzwBqJ1PD5LzY3L9MshG7+DJm93WIhIINNE6?=
 =?iso-8859-2?Q?+UH3J4htFPi+eXHKWQqWyefHzc6AVteSQ/mfEbU5tTGQj1vudMyC3rz+hi?=
 =?iso-8859-2?Q?aWC9QF13kJieUMXMjF5i35omFYQqJ3SCLfYovt3hcBP0dlJ9FXroKFj8fH?=
 =?iso-8859-2?Q?cOiVnBLnzhvQQZViUFglT67W3nhuc7aj1nGmB/afsMoDv5LR4OMTGuBIz7?=
 =?iso-8859-2?Q?LsbleiqAhFTIbHyTxUM3h/nfzWcsFA2iHLr+NxTxYzAjxzdo6/RODmL4zn?=
 =?iso-8859-2?Q?Z5a2YH8WP0fXOpNzih3npHRq1MqDjNcC0crWbYNqgXso1ZOcuTXGdugTdM?=
 =?iso-8859-2?Q?v4GHTrq2WZNXTHKivmDbFjApi6JNF/hnaeQhwKmEZnTByOJZ+S10Kbsw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <47DD8025DCB0D648B335631D566A264A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-2?Q?7NukG0vvPRqzqPCFQLPHwdBEMkv/tTCMpL8Aa900n6ekXCgAo+Y+kObFER?=
 =?iso-8859-2?Q?GNInfvEzZ9BQHGhySwCtOSA5aPP+sD5UIcFKlLiK5hGIGBawOaew1kXGN7?=
 =?iso-8859-2?Q?me2g1+sRvuziFu/eGRihn805ZuUPq3MCpj1iULgd0qEtRl0Aq6G9Re9diD?=
 =?iso-8859-2?Q?8j07n+OLjb2mLAGGd1PO58x7ebQkQYnSgCpjBHJArvzYmqqpXUoBAkDopX?=
 =?iso-8859-2?Q?opaXlSfEFX7tvyfRWuIeyYmbZjWIt3fcYzNnqls3RU43FVBL8dHaKFALQQ?=
 =?iso-8859-2?Q?xEDKG+HznlBEmdzXbpa9Qig9eLSezRnaIIWxXph+WsjCqwuaTk+2SFYOxS?=
 =?iso-8859-2?Q?Jsno4gKAZYx4mIT7CNo54SzmWfHoH3R9hwX3by/+xeXnNCO24IloZvDwx0?=
 =?iso-8859-2?Q?jvN3IHKX+Lfu+NXZghEKjITgUBZ0Zn5HOOA70uYQPVaSlAT8mPm6erqLtF?=
 =?iso-8859-2?Q?rmuhxcOOAB+rf5FIk6PAMKLv8awnuCZp3lGsWLr3TqFMHOk951F7b9MPGf?=
 =?iso-8859-2?Q?jv8vejYOIEUMw5K84DHe7yZhU7+cfeqr+jaT+NdQ8OwPhgXDixTHElEdbP?=
 =?iso-8859-2?Q?GkyfVgAApZIibKp5PpdTGsWUlwtQeWwFINOPxq3Qif70WKwWUK8Z6PNKOp?=
 =?iso-8859-2?Q?N1ugJNT4OztKqS8TFdT5EjaGG6bfEqZF2B8TG3EopYhSLWtQKWK8OQJ4rO?=
 =?iso-8859-2?Q?6swelxyMsdhMI8/5DP1vT04rcV8xApI2WrdPZ9U4p4q27mMGZGlvaZhJEO?=
 =?iso-8859-2?Q?Z9OUJJbzkRQlOQdgHDMBz+zEyHJ0SmGvnI9jX0IafjnxarWTZQHvSiepEa?=
 =?iso-8859-2?Q?W9hItqdNjV7h71zltdcijEF1zSnVRZOJeCbNnPKNLbVetgeFodZQ+TGvpJ?=
 =?iso-8859-2?Q?AIOXdlgSNDhTmt3V3E4ur4D5sfpAm/IyQq4gvpnorUflz1I56A1vrL9C6J?=
 =?iso-8859-2?Q?OQpTR4qCKrAGsiqgs1ikh5wMShkP74xw6k40fPOq16mXOrdyHCv50cEt6n?=
 =?iso-8859-2?Q?rfiNLL95bfOEe0Fgv496yQHg6m+AYxzqfJPhvmU1fOBRkppUHCeMboSwmv?=
 =?iso-8859-2?Q?KxOLtr0OseZC9k3GgVeanRO5IPkgwDE/VMVhxH7Lax/oA3rJAGDRkVNx9q?=
 =?iso-8859-2?Q?hYCJ2sFytOoiFMyNT7YTLo1A66Ias=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45360982-d290-444f-9d25-08dbda292fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 15:51:03.3267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 251/ho9k/9ecrXiyOiqP7P1dqE2co7Ve+repA95DOOXRft+EeBuIY4M8Y098zdAzreTv/RHHu2DZVmsaPtQdoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7905
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 31, 2023 at 04:10:17AM +0300, Serge Semin wrote:
> On Fri, Oct 27, 2023 at 05:51:14PM +0200, Niklas Cassel wrote:
> > However, e.g. rk3568 only has one channel for reads and one for writes.
> > (Now this SoC doesn't have dedicated IRQs for the eDMA, but let's prete=
nd
> > that it did.)
> >=20
> > So for rk3568, it would then instead be:
> > dma0: wr0
> > dma1: rd0
> > dma2: <unused>
> > dma3: <unused>
>=20
> rk3568 doesn't have IRQs supplied in a normal way, as separate
> signals.  Instead they are combined in the 'sys' IRQ. So you should
> define the IRQs constraint being device-specific by using for example
> the "allOf: if-else" pattern.

Thank you for your review comment.

I agree. Will fix this in next version.


Kind regards,
Niklas=
