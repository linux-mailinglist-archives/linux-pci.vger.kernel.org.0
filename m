Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A66E717C95
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 11:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjEaJ6O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 05:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjEaJ6J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 05:58:09 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD36E13D
        for <linux-pci@vger.kernel.org>; Wed, 31 May 2023 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1685527035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qCCIOthBd9AZuP+6Ul7azy1pptA/pbomsDw1VEUtMPk=;
        b=c6gzxVgZmfmfKCF+TS9BS8d4MRDue7wNb9G2my6i1daN1kWHLyu0zEXhGibLsAFLm20UNM
        3Waox9PbQ/0b45BoT9OjwiS+jbCGdzmnrI0/6B4bRJ8q71yCwq1my2mBVEcDqevutinrZE
        01gZtSaNCMy8gUhsMEWzl2AO+by0G/dEx4wKTadkIAxlVGcQQjLfDYAt2Eztl+tEc+N1gR
        ivqo90vFEgUNY2BJHaK9/Emkgr+M0/b9UATi/ErVKes9Y07mmiSzAm0QMSL0JKPh8lkce8
        bEv5lhiuRArJmY2oRt8MYykMkxAhB/2YV1Vi/W71qaqeJaeMQvVHcGyg9YGhfQ==
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-hbx1smnzOYGznmcUH_9WkA-1; Wed, 31 May 2023 05:57:13 -0400
X-MC-Unique: hbx1smnzOYGznmcUH_9WkA-1
Received: from BY3PR19MB5076.namprd19.prod.outlook.com (2603:10b6:a03:36f::11)
 by CH2PR19MB3974.namprd19.prod.outlook.com (2603:10b6:610:a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 09:57:10 +0000
Received: from BY3PR19MB5076.namprd19.prod.outlook.com
 ([fe80::b18b:9889:3c02:ed15]) by BY3PR19MB5076.namprd19.prod.outlook.com
 ([fe80::b18b:9889:3c02:ed15%4]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 09:57:09 +0000
From:   Lei Chuan Hua <lchuanhua@maxlinear.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Yi xin Zhu <yzhu@maxlinear.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Harliman Liem <pliem@maxlinear.com>,
        Qiming Wu <qwu@maxlinear.com>
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Update entry for PCIe driver for
 Intel LGM GW SoC
Thread-Topic: [PATCH v2 1/1] MAINTAINERS: Update entry for PCIe driver for
 Intel LGM GW SoC
Thread-Index: AQHZigzYpsJ0nkxDDUifXYko+lYXHQ==
Date:   Wed, 31 May 2023 09:57:09 +0000
Message-ID: <BY3PR19MB5076B3463AB1A00A43522ACCBD489@BY3PR19MB5076.namprd19.prod.outlook.com>
References: <ZG0UfTlgZqqy78AS@bhelgaas>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR19MB5076:EE_|CH2PR19MB3974:EE_
x-ms-office365-filtering-correlation-id: 25b2b0dc-5a1f-45fb-e092-08db61bd6616
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 92t34FZfb5aRbf4ymwCrbeUr7N1+33nMdgMTElY0jSuC3M4NytCC+iIE3BLOMA7SoK8BpOwHs2qhGQq6mmO9u9CU1br477lMitUlMbgMo276sHSA0pOWXccjhKQjgdIoOmmfj2LZvJIIaRDyiul/wpL8YCI2KOcAHmuVq8Et3GABGEK9Fm3Mm881mAk0g8ykdJOClyYIMW/vv+ufqPfJs4KtTzMSVNI1YKRp0DPzv/mmtomIveBOs5l7xO2dS1TUob9xdekeM1khcnoK1WiTxMVcyurRoMIVtwIxl5kU+SU+XIK0sKEUUiNGM2maSGT5noCj/NAUCt4baZzYluZWlPLtLNiLotYT+fLcaijBzPJgOmf4AZRemjjnZR7YTzcrol8oSCAm+NKx30zAViwCr+sKTDc51W/ATgodDXkgqJ1BYsLu7B1Rwh1rWG1QeEggTEod7lzUImNLGs0MgVxalSFO9c1MN5OOZ665TCjgzZoAlMrD9EUuGZLbCMUHD54Du+vMfBgy4h+hSUcbJYIw/E5+4rm8uUd7rgIwZZvzQRVLIFPPqfyHQNAtDixggIwF5HiiPk2woywj1e45Brws8MU8mRSAAxIeKthWEhNm6z0S2bi8zIBSP35urTN9Oa6V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR19MB5076.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39850400004)(451199021)(54906003)(478600001)(110136005)(8676002)(8936002)(52536014)(5660300002)(33656002)(86362001)(15650500001)(38070700005)(2906002)(64756008)(66946007)(6636002)(66556008)(4326008)(66446008)(66476007)(122000001)(76116006)(316002)(91956017)(55016003)(38100700002)(41300700001)(186003)(107886003)(53546011)(9686003)(6506007)(26005)(7696005)(71200400001)(83380400001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RUh668JhxAwD10f0IR9r+AWA58tXZnX8efO/apuyw4nc41jBLHC2G1cqLo5Q?=
 =?us-ascii?Q?qoy8E+8+OXSlagtY48s526JP1miuXWeSFhc8Oc1vf+sAMrn29kw4vMn3N+Us?=
 =?us-ascii?Q?gqrRKj85E3MKYLGkpS9ipD/JooIV4GIlK02UjjVq+ZE+Y54z7QIcBTQvgFtA?=
 =?us-ascii?Q?RJxFiiPDp9KBlQb2BLoHDPFEKtban74bxc4iGyp0lkW2ZsUQirdBGwDQUdg7?=
 =?us-ascii?Q?UAM+05s1exF7d9FbpsBWuntfapS1lpQyx/hdOQR1kIVN0fJv8FRJsDXsotSi?=
 =?us-ascii?Q?pZ2YRYJ/N8gXslteyGyLo6Q/E1m4aR2TjX7lDqEkoQR3Z9QvUsmqr3ZNugzQ?=
 =?us-ascii?Q?T8gk1oJi+Uwoc6wK1mNfhijxCcWn2SHhAviS6s2VUzmrUcccdhdnjVUYubLD?=
 =?us-ascii?Q?9ICTFXyLJ/vgA9QYaWhdcBWDiXjrG+/ZWQoD6F8zE0K+ZzbXa5YVxQYeM8Kt?=
 =?us-ascii?Q?sZFxI+MNcHGcCzDwxJxLW3wit53tF15hCDBsRJ5vw3ZktCs8Ct1qxuV84nkj?=
 =?us-ascii?Q?84uWRqX+WUE7vuqv2u20AajWvVscX4ph14raovzQNUddhv0l0p2Q0B4+G/aG?=
 =?us-ascii?Q?/KaOV6yY7wY8S+DtKknxL6N3m0uR3VhgPVNWW+SIcppuAwcMp4oOW4A5kRnQ?=
 =?us-ascii?Q?VBQWOYhdTkAAr9chXRGsoGjlGeBq3ZkuGTBVE07clEvMJeOfqy36ZKroCdno?=
 =?us-ascii?Q?7hkZmeOTN43+Yt4GCXHQc1P/CCY79LwcK6vBAM51y9X07GmF8uy9kkrppCuc?=
 =?us-ascii?Q?5Dv3oE5i9LNLE0/MGEqErs3Hmn3OlvVlUb7DfhUVkItHwCucbQMZ6od0mg0n?=
 =?us-ascii?Q?isrOdNhQofWQsk6ThLB4UF9pDvAEJqYUrJzEUwmtujkWg5Rc9JOgM2gksPp5?=
 =?us-ascii?Q?JPlvNc/qoCo7UVOvd8ed49bPwmQRIxZucPpxkkRsyYd0djBKu4aUElzvBHkT?=
 =?us-ascii?Q?F8FUoG0bQYYzbI013hYhv1js26W3SNN/3nNy8e1qcPb1lGcfICLTO48XRfNL?=
 =?us-ascii?Q?c71EUcNPq2BzjVOdN8TlT6sxyPUYQEmtPbvcct4CXqmARLZ9dKWFqi54X1v0?=
 =?us-ascii?Q?63BrpoIJ7vbAP0sILb/2q1xnfueTP9vHugrXvbXOwwN2HatdVymcI+Hgk/XW?=
 =?us-ascii?Q?wNsUyVRBp1Yoy6+bYlr7sSqEBx48ifvFvnxaAuYxp91eVV9OByGzAdVRkzep?=
 =?us-ascii?Q?8gQtUK6Nf/tmV8fLVOi5gg3Jfeg1dXoK88j7euBEuUJAXuMntVXs/5cZgb7h?=
 =?us-ascii?Q?LG82ObY0EUpCFUSQie9hZgOj2fxrT6CV2JJ/Qw9TM1EEtXop9qrSFjusJdOF?=
 =?us-ascii?Q?kk7Rw8wVh3ZSVIHvES+rjYnubjtpD/vegpBsqRt7I0Vk35WuyQ/49zZbv6kZ?=
 =?us-ascii?Q?0yV8vtWmPGdW1tC41nsBWXkW8SDT3MaOQq0SvLGal+MTsFHeLx9iBiWVKY6q?=
 =?us-ascii?Q?XB9NYuG6UcP7oQStBmP6ymRBymlxkKmEJsDsDL6lMD18YG0ESt9ZtgjxmwA/?=
 =?us-ascii?Q?h9H7hxJJn/bJS4HsazT9IOm0SKjBuaRAnXHq2gbfuPAQaQ1LX1kyGeRjSvQx?=
 =?us-ascii?Q?zShf/BmKyJ+hOhZjDRH6fcJNr2a9vojKERwlcVlyJum1hICxOWl1HJaS4GhN?=
 =?us-ascii?Q?Tg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR19MB5076.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b2b0dc-5a1f-45fb-e092-08db61bd6616
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 09:57:09.2021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0r3IZ/WwdAHfRQQqnTLi5cKU3X8eHRX/Yzz6ZDIhjn4TruD2SumjwN2GG1rVfysr8oG5eh7+cxy4G0H8AiC7xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3974
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/5/2023 3:38 am, Bjorn Helgaas wrote:=0A> This email was sent from out=
side of MaxLinear.=0A>=0A>=0A> [+to Rahul, which I expect to bounce, but to=
 give Rahul a chance to=0A> respond/ack]=0A>=0A> On Fri, May 19, 2023 at 12=
:45:55PM +0800, Zhu YiXin wrote:=0A>> Rahul Tanwar is no longer at Maxlinea=
r, so update the MAINTAINER's entry=0A>> for the PCIe driver for Intel LGM =
GW SoC.=0A>>=0A>> Signed-off-by: Zhu YiXin <yzhu@maxlinear.com>=0A> This sh=
ould also be acked by Chuanhua Lei, since I don't want to sign=0A> people u=
p for work they don't expect.=0AAcked-by: Lei Chuanhua <lchuanhua@maxlinear=
.com>=0A>> ---=0A>>  MAINTAINERS | 2 +-=0A>>  1 file changed, 1 insertion(+=
), 1 deletion(-)=0A>>=0A>> diff --git a/MAINTAINERS b/MAINTAINERS=0A>> inde=
x c8d274efff10..6091bbb0e1d7 100644=0A>> --- a/MAINTAINERS=0A>> +++ b/MAINT=
AINERS=0A>> @@ -16383,7 +16383,7 @@ F:    Documentation/devicetree/bindings=
/pci/intel,keembay-pcie*=0A>>  F:   drivers/pci/controller/dwc/pcie-keembay=
.c=0A>>=0A>>  PCIE DRIVER FOR INTEL LGM GW SOC=0A>> -M:   Rahul Tanwar <rta=
nwar@maxlinear.com>=0A>> +M:   Chuanhua Lei <lchuanhua@maxlinear.com>=0A>> =
 L:   linux-pci@vger.kernel.org=0A>>  S:   Maintained=0A>>  F:   Documentat=
ion/devicetree/bindings/pci/intel-gw-pcie.yaml=0A>> --=0A>> 2.17.1=0A>>=0A>=
=0A=0A

