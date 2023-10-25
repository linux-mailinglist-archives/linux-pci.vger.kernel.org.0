Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161817D7616
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 22:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjJYUzo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 16:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJYUzn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 16:55:43 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2B0CE;
        Wed, 25 Oct 2023 13:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698267338; x=1729803338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h5VpRTQ4v9aWVWKktbCvyJM8w3cIJoWne+A5GO0q37k=;
  b=GBnmvqjCItteGHiUOoAnwe25xaJCyOXhB//UDiQUwtPepwmoOhamqsOH
   ZLEFSyASlfc7Tp+O8BdudwYFLRCDqnqoMzVTtB04k3xgI/d5w9XyMPH2D
   YHnAhwe43b8lf793i/4Wwo2RVdmH8fXrXZL3ARykaCU+FjZ5mFQks7oDm
   gymChYWr9OYgRDgkGF00WqOzv8K/uESBXMH7FhzyAvnBmnOLt6mT9tvEK
   CrVPcjDLVg/Ha9KDpZf+QuU2/OdS5ZLGLIlW0f+717kkDUeDnE1KPD4s6
   RT8ZvI+spvviQfHuxe+5dvkt2OG3eouyDO3oSktLEG4tQmgUhEVm8hWeZ
   w==;
X-CSE-ConnectionGUID: CvDVCayHSeeYIrQLIpXQIQ==
X-CSE-MsgGUID: 7hzOKzPeQAeIT/p5jMOmgQ==
X-IronPort-AV: E=Sophos;i="6.03,250,1694707200"; 
   d="scan'208";a="633012"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2023 04:55:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFsgJ51tcmWAT/OzUgWraZBpun67bru/KIaF+6zL+ApnCNMPeG2hC3CgQCNYVLOdVQ+aQCCcc+uqbGeUktOIW8jYcUnTW9OkBFIdGBAopxMjS7Uw6NOqPqO6w8seZjzF4SCcrKnNrYPT1A0EAdoDJeg89+qt2LICyXcFMjME6N6+W0FahVHcK5PEM9He5ylnukMzmSteXSZYpftsKd3qrUuTFihXINXhTaQXHRvDBnCzBX5C6m+MSbCOmcwB3u/5myXLYgGPxFyx6nxNHW7BGq3205bv7KmHt68wxDk3HTb4ipV2fmq7tnfIcdPYdEaVUiT/FA1sH71Z1xQp783AHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyt+ZwAi1nrHBbTm6h3XIRDIq98+3+9CcQ1oBBWU1KI=;
 b=gWeNGBEprTsTlNJGgR4rMdRvZTrSOpuz2fCZCmiC7bHF83+WGROAuEJGnXsRp+USaIi0Fm81cijDOMT2TW9j0cMH76nTXbNufMGhJ+vKfOZNABEHFK5Ux0lH3sM8jFqdFt9myjYpFc0bZHkprIUN/+X8UvO9ud4rt8LUKFIL2hQia5ILPhhchgIpd3GG2T+2/dBJkuvmd5ckgep1LqVekouruzRUE8CfsgTFA9pTtEcCpp6KfJrfucSU3Qfxgf/rPIv9YXAFnj77av7oiLKBZse2t+dU5VoytZ3CrPfFt810OoMuKzaDHjkYjkWMo5pJ6gkbFJahSCfClyBaXJ3SQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyt+ZwAi1nrHBbTm6h3XIRDIq98+3+9CcQ1oBBWU1KI=;
 b=QQrTBeB4kw8B+XUPF6iXPvMASarchezQzZmfeepd+ZgehG5Yq79VVOG63OHTArufdKOqfxycv6S3oM4GfKDGHhbVmZekViZFF6uFSg9AXhSkxbT4kzAv1eim4t/uWr2ID3U9R/7CYNrqkO6HASn6jkxm3zlswXmS6xQmo9aYTAs=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CO6PR04MB7762.namprd04.prod.outlook.com (2603:10b6:5:355::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 20:55:33 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6%4]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 20:55:33 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Niklas Cassel <nks@flawful.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v2 3/4] dt-bindings: PCI: dwc: rockchip: Add dma
 properties
Thread-Topic: [PATCH v2 3/4] dt-bindings: PCI: dwc: rockchip: Add dma
 properties
Thread-Index: AQHaBoyNd+UCFjyqgU2gBHlMOd/MHbBZIasAgAHO3gCAAA2NAA==
Date:   Wed, 25 Oct 2023 20:55:33 +0000
Message-ID: <ZTmAxH0AXpCN1+G+@x1-carbon>
References: <20231024151014.240695-1-nks@flawful.org>
 <20231024151014.240695-4-nks@flawful.org>
 <20231024-glacial-subpar-6eeff54fbb85@spud> <ZTl1ZsHvk3DDHWsm@x1-carbon>
In-Reply-To: <ZTl1ZsHvk3DDHWsm@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CO6PR04MB7762:EE_
x-ms-office365-filtering-correlation-id: 38d486e9-5990-423e-b069-08dbd59cbb18
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dgzqo3BO7o6Cs1oLc4iDwazwyG90YeoMzoWbFaNLP1HDbWPEWEUgveWA/lAPtm/TgSESzfRStgEtRwglnB+HKYfiiFHEaN9M9L3oK05kuEc5hEOf/nsrn5k7xTG0B+USmP3uvaUnUtkaUa6PJpbQnRh/ovm9ouJTwQqMMlSSC+DnFwSxyZHOti40sNCOycAEciVEvPvLex4XMVd4hAIQtRIBq1nlbCa5/jGL31ANfvRf//93gIZdfVaF7ecKPbuMGhP4dEfodR/cBLvgni2x2z1XqaF0pF+FQbIjx4JEGNFkLzbKMM6NgcSTPSxARIoW8C5JDODG9784jKWsnSh2UIXwXCIcTpCYXDsGDqAXRmRsQT6BhQ3GCvHh26RTzp7pZ5Xoc+drm7gyqsEVml3u5LWHgLMeqytktSutSwhY9dtgcrAIuJ71jUc9eGi9s2k6c2wFooBzZYaSRjgvVzobKiD0XWXutQ/o/SsqsY+zN3R8kuAenQN0b7TdoPfV1cHeh8EcB1wJX1fAmLK3TdfY0p6ZR+R+GWzP44BrJac/DaDGwiY+4xAzXulKawARJHxQhWGgOe38LlcaD3UgNrMUUDyfd6RhaHrHqgAKjgiyCWg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6506007)(5660300002)(71200400001)(86362001)(41300700001)(26005)(83380400001)(7416002)(38100700002)(82960400001)(9686003)(33716001)(6512007)(122000001)(2906002)(478600001)(66556008)(91956017)(316002)(66946007)(6916009)(66476007)(76116006)(66446008)(54906003)(966005)(64756008)(6486002)(4326008)(38070700009)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?34RkGuTaehCWx8mO/qbielg6gbSFpl4Fau8urYjwnGSPR6drV8FfFDIWHQ?=
 =?iso-8859-2?Q?RzWjwLDMrmkq5ZoJhe+gVJIdaf6Q1l1MW5+8UHzt3c5s2PqSkCEWqHp0wy?=
 =?iso-8859-2?Q?v+wGRGkiziZv8sVJCqPH2iQxJxHE2HQgWJVyCNzGmfr5HGGswUAsD6qhcT?=
 =?iso-8859-2?Q?yeEPH/kSEA+hWxtdcg9XOZQpxXkiKMeMznH9pT60gmzleV4OJ8tPxaP2Yt?=
 =?iso-8859-2?Q?aIkHSeOfNBQIreldXerw7oeeOELtTrW1eShtxzaSiWL6mWg+uhIUQaV+AY?=
 =?iso-8859-2?Q?Sxx4m+ITY1zZoWmtdhuXRgfOXRKwRoPBw1rwrNMXfbro++HWZYkG2YtVGT?=
 =?iso-8859-2?Q?Pu/ofbnqtsPp6/1LOz4/6eqqdYJ/mgfpNuJJGCxPakrlbXm4ERKgek9LUN?=
 =?iso-8859-2?Q?Qdc5/AC5+StCCLNx9eQm0U9q0iySs9nZT/6jZGqSsDJ9fDkAaS46dBTYLW?=
 =?iso-8859-2?Q?5nCpqJ90P4RlmHXSNahqrKpQBMxi1lTf4MKnSTCehOLEf21AwxsuG8bv03?=
 =?iso-8859-2?Q?g8eFusUEX/WVz7Fsq3JUnWE1xgxSZjdKCa0PDw69MdgHiuNjqcf0PtWLR7?=
 =?iso-8859-2?Q?OmKZNohgEMmQJ4CtrykvI5isb8M4CycZj7PTDKkm8JdnIHtCfd3iGWjspw?=
 =?iso-8859-2?Q?lFro19xPZbwzN/Kfr00f4stlLQXY/K1ekfXtBveip6IvTOXlDywPKAAk/N?=
 =?iso-8859-2?Q?i2ybiuiEJMHW2jE6HIXunY/hjBDri14uar3yttTVBwUF98pUR+icoIM6ud?=
 =?iso-8859-2?Q?AVMmiCvUUrQRZB9e0aBil43TgubaJ1C0npbutTXTAktyDPA7V36g1OBFS9?=
 =?iso-8859-2?Q?tGFJgjkOF8wN92JrkLxoZ3azSh347+eL33Z/64qIhAADbGXr1Tscri9/Uw?=
 =?iso-8859-2?Q?4+m6U49imro3513lX8nmKisEQjYP4hkqRY4KfoNkjp/BufY8MWuAatOAEE?=
 =?iso-8859-2?Q?BriLV37/O7NIj1qI+g0V5flPr8XWOtdjlUv8QBSKXJnlFVdj6tDb3LmUk7?=
 =?iso-8859-2?Q?5quFsa26hR2N2GNWw61/V/IHjwkgOl+GbehcwjbDmdtgumtWP6Erx9vzVz?=
 =?iso-8859-2?Q?Y5aOE7BEwvrZF6wNs5xuu4X+tiKNu94BIlwHy+iiPllMfoRkA2crgpNDQq?=
 =?iso-8859-2?Q?OusS05HJC05hoUtO/whOlEbOvWH4TUlj2PqjWbmuSUdCleRPIvgIvp+AO9?=
 =?iso-8859-2?Q?gVUB1F5maQSpzVhR+X4DuZr38WZ5mZiPrHZcyD3YSaByIGABrHSVSP/6d6?=
 =?iso-8859-2?Q?pBswH/0E9+EJ783BkVUz4va/bRUF6ZVkkLtOmvtAPmAuqxHGDcdJ4aWzSZ?=
 =?iso-8859-2?Q?DOgndNXo4juXSQXThAJDVr2GpC7rIufUKyG6K09Jj+hJ6O9Cx+LvYGsdPJ?=
 =?iso-8859-2?Q?pRv5oltMpvV+hF417Q+ntpFM/yPAOYjZ9O7CTxzfmcFpN8o5vTOPx2Dr1k?=
 =?iso-8859-2?Q?hGobCN/RqLDCbwmuWiPFkNEVsvsTqPIGlo85QGlJC9vPDTvOkV/3gFwkG6?=
 =?iso-8859-2?Q?Ljy6sOdvA+xsq5rYm18YRmu8NQ4SGlyBWsw9Qk3j+mTQXf1c4iUQgI6Q3e?=
 =?iso-8859-2?Q?0+qtkY9GUiWfX9djW8ZFvyDl9QOxorqonES0JRDCOmHplVBWQjZvqRNnA+?=
 =?iso-8859-2?Q?Xzf++VlQVeGriyrp8/CukfjMUs6HAMpd7KdrNB6whpQOa9N9RzZGjAog?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <785930916D6A1B4FBB9BB7A596C785C9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-2?Q?gcPLKQ9sgSHz9DM20vP7fr/DNTs8YizHxWw7NAG3/VGGy0q5C23Q065VnD?=
 =?iso-8859-2?Q?Nnq2u+nRRPPkEFbX3NzWvCxl4ASX+vZ6Up/yQM82Z3gpMhGm4Sa85bnQzW?=
 =?iso-8859-2?Q?21DyT+rdVl7+f3BUiUg1Xd0FuPElXXCEtO3h+f0rsB5hvnp9ZaCYWjGoux?=
 =?iso-8859-2?Q?go/eqiKTMqOMwdJFBURmg4M7rKeFG7La7S6n5ay17Ipd5g2LV2FMjdVtMZ?=
 =?iso-8859-2?Q?dBrqUyscywoBEsK+vxUIiisPY01sdjTK7bC5iMZMrWCYsPyF/Oryu3UHfu?=
 =?iso-8859-2?Q?WxMroJ3T2C1+AYXOaE8YceLI85bC5on8XdbuQM3RhIzfxR4jLu1d5DXSg1?=
 =?iso-8859-2?Q?teLCgdqw4maDvtx3QbcdCE7Rlz9DHF0AaLpG0cceGF8WSc9EWcDUP+/iuk?=
 =?iso-8859-2?Q?XbxLnpikVdh+nQFCG3uXW27yOvK33tJ3sKjif+vZ5uWXKw489cHlm2pz0h?=
 =?iso-8859-2?Q?nSKGLXL+UonbITvPWNkHWED7gR0dJY1g6AKVWzsUOQswmxzhpQe5i54VmQ?=
 =?iso-8859-2?Q?zc96ohHJPuhyKulkueRjfshZtyqJu57YucVjMKA7VPSgkjcRFBiENAXV/G?=
 =?iso-8859-2?Q?+cT0MqQOFxnEjKNvbili/7U6pbiJylmdNPm2PcDm8eSfjNn8K4Y1fymrdn?=
 =?iso-8859-2?Q?gygxK3cOBT12UeXOFBhfgLDzzRBH/4n5uqV01VTjHy8mzCJsB6bZHe+FiD?=
 =?iso-8859-2?Q?k1n10UXMTsKPv4lWr7QKbI8pgMhPJf+7lNQ+lKhL+YJESGzm2jjjYi55ac?=
 =?iso-8859-2?Q?GPGmswGXkQlqYfAFLChIxehZLAJvVgzz+lQ8nndSto1SldFtCPeekdz9Hd?=
 =?iso-8859-2?Q?p/fpNsW33I6QiE6mTmk0vuoRY9e/ivJit39LlKPgeHk3GThXCC4B/rOLmn?=
 =?iso-8859-2?Q?dJH8Evcsf6qxP9aaAOSd5leGq0x1lXDR00pUt/iR5i7RJ6wiUmQ2qJE5sO?=
 =?iso-8859-2?Q?viuZmV9VINMGUs9ihVzSiMO5VPVDTC1S8n+3wHBBhn9us4bAZBsaeDkMjL?=
 =?iso-8859-2?Q?lHzsrm1cZxqytUc0xUA1jYHdYcUs7BtO1bvtZgd6SNGvznvnapDbf5b3di?=
 =?iso-8859-2?Q?+GPNgKy6XUg0RQdliq+hBt0EWJzvbW8MouBPvubmdRjMeiS4Er76odSoJh?=
 =?iso-8859-2?Q?AsmItwLg=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d486e9-5990-423e-b069-08dbd59cbb18
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 20:55:33.3275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccMlBq/bWFVBOmpO+daF0d2jIPZtRWLKOaNKT3frAgXSZUKmYF2sQc235n2vbRl/YHACw/5IIFWwaTkBWFY+4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7762
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 25, 2023 at 10:07:02PM +0200, Niklas Cassel wrote:
> Hello Conor,
>=20
> On Tue, Oct 24, 2023 at 05:30:22PM +0100, Conor Dooley wrote:
> > On Tue, Oct 24, 2023 at 05:10:10PM +0200, Niklas Cassel wrote:
> > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > >=20
> > > Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
> > > using:
> > >=20
> > > allOf:
> > >   - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > >=20
> > > and snps,dw-pcie.yaml does have the dma properties defined, in order =
to be
> > > able to use these properties, while still making sure 'make CHECK_DTB=
S=3Dy'
> > > pass, we need to add these properties to rockchip-dw-pcie.yaml.
> > >=20
> > > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > ---
> > >  .../bindings/pci/rockchip-dw-pcie.yaml        | 20 +++++++++++++++++=
++
> > >  1 file changed, 20 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.y=
aml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > index 229f8608c535..633f8e0e884f 100644
> > > --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > @@ -35,6 +35,7 @@ properties:
> > >        - description: Rockchip designed configuration registers
> > >        - description: Config registers
> > >        - description: iATU registers
> > > +      - description: eDMA registers
> >=20
> > Same here, is this just for one of the two supported models, or for
> > both?
>=20
> For the 3 controllers found in rk3568, this range exists for all
> (all of the controllers were synthesized with the eDMA controller).
>=20
> For the 5 controllers found in rk3588, this range exists for only one of =
them
> (only one of the controllers was synthesized with the eDMA controller).
>=20
>=20
> > >    interrupt-names:
> > > +    minItems: 5
> > >      items:
> > >        - const: sys
> > >        - const: pmc
> > >        - const: msg
> > >        - const: legacy
> > >        - const: err
> > > +      - const: dma0
> > > +      - const: dma1
> > > +      - const: dma2
> > > +      - const: dma3
>=20
> While all the PCIe controllers on the rk3568 have the embedded DMA contro=
ller
> as part of the PCIe controller, they don't have separate IRQs for the eDM=
A.
> (They will need to use the combined "sys" irq, so the driver will need to=
 read
> an additional register to see that it was an eDMA irq.)
>=20
> For the rk3588, only one of the 5 PCIe controllers have the eDMA, and tha=
t
> controller also has dedicated IRQs for the eDMA.
> (It should also be able to use the combined "sys" irq, but that would be =
less
> efficient, and AFAICT, the driver currently only works with dedicated IRQ=
s.)

We could go with Sebastian's suggestion to define a 1MB range for "atu", se=
e:
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bind=
ings/pci/snps%2Cdw-pcie.yaml#L76-L85

Which would allow the driver to probe if the eDMA is there or not
(even if this is strictly bigger than the real ATU_CAP size, the size is st=
ill
within the PCIe core's register map).

That would solve the problem that some pcie controllers, with the exact sam=
e
compatible, has a "dma" range while others do not.
(All controllers would have a 1MB atu range, and none of them would have th=
e
dma range specified.)

However, we would still have the problem that for the exact same compatible=
,
some controllers have eDMA irqs specified in interrupts, and some do not...

But perhaps having mandatory atu range (and no dma range) + optional dma ir=
qs
is better than mandatory atu range + optional dma range + optional dma irqs=
?
(At least from a DT schema maintainability PoV.)


Kind regards,
Niklas=
