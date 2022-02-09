Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D153C4AE966
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 06:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiBIFig (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 00:38:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243142AbiBIFbM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 00:31:12 -0500
X-Greylist: delayed 1799 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 21:31:16 PST
Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3B8C03C180;
        Tue,  8 Feb 2022 21:31:16 -0800 (PST)
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2194a7J2005229;
        Wed, 9 Feb 2022 04:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to :
 content-transfer-encoding : mime-version : content-type; s=com20210415pp;
 bh=0Ymc9WgzR2TXB7GZ71V9IkwodSLtQuTnlj6tKi04T6E=;
 b=VtV8McK8vAK8ydg1YPeWFFgGeCbymuIz30oOYqZqkkMbPUIB30awG2NxVjYVPWWQ2HZx
 yAUvDITZMHWWewhiIwFomEyQcdCCs8BGwhTgSpPdHSGZOwVh4x36rjsAC4gTYY0JcGRw
 RA04ORjdQuhBKhn1kgzgXV6q2UYBNHSpWtBMfzEqL87Qy/tvhdkxCnbhVdA0Xd+e0Aog
 ac7SjqWwMyasvkTDQAjxm/wNch6yF0ixzCN3oFZeYQD8uKeXUjqu9vOyJUVDLwSebFek
 P6wMTjUwJj6kv9kXT7UbKaB1snWnwi1naVi9onr/5YubvjlSNyi1hC7hGs9F6lXVRHit AA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3e38tv0k77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 04:48:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYZ/zlDbsL4UCHBfDyl6K1XaqY/LkLu5vguvZ2IR8PxHxgqvOyKiPSlmLxzO3OZLdAgxBx9CEiDgZ+ztWrZlVusIPlooEFm6bDDYgcd5h/hdLuEEOaZ3AeYmJBYFfLdtEGPZHtgrGqeYAnRtAaJ7OkLvY/RrXWv7o00F+YSAx+elBEZN1+wxDlNS2b0UcJoHvdCwjsTaZISV9oJNri8bzoCc44cRr8DzujoZv+h8LMlH0vkG7CFzaCgwtfjkKmLQ12cFCNQa8WChdpY5tkKMbt9aYZa/Df/IAW4UrrXoBTYySn491u+5e+rkFk1scwhMPR+gfUGLsq+KAADVV0flhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM0FcZgaT1OBln5ioaTbIAJ5DiskVu5htFnnmhbkdpE=;
 b=fhu5KiwqwqfaVGD0K2eGPzQaBNd0LoacXLpx3ixprgNmBZKozl0HiKSJNd+xQ0bLj9HJBCmZJAr+a+kMOZta2dMm4kZq5jLMa5aBVYZV4wZC8x1b55dvl2zATBahCOqDX66AO34CsXSNkdOdCNRCQv+RBnJZ9I+s+F5RI/h16bFiYmo1WMrqq4ZKzUVW6kM3Ay0uy4QiuEAB60YHzAZk0j1AAgnId+DpNNmzxA6Qele29gBcKkr5Ra36/M3r7q2xQ+OqTB0I2oaS7x2L5V2XbzXoQBfQVtQydzaui2LwRvyt0bBHhfGe74OHiUpmI3/4MFQkatz0Z4JLNjT7WHCRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM0FcZgaT1OBln5ioaTbIAJ5DiskVu5htFnnmhbkdpE=;
 b=VyQrKT71YjDssDeYMX0HavePA9YFmBtE4Onn0XUCx7Ba9NfdjZosKk5do++iBIj6gb4Y7IOSoy1VUkyRTqGpWMAOp/gUq224EgjMYz2LyIg20QikUbaq8impYEAvTU+2xqFrPv6Yu/8e7lNzRZpP92xtj6Tv7cPeV4E1ebvjeziMMUwo2dmLtJNTP0b7EY94Ul4TGMF2LaHCtDTJWZUdeLhsfnoG0E20850qAOHtEXv9qGs1J7I/PEzfqgUTZCbGU9SeWMoiSkcoX0exUrFwRLnD+p6mGMZHxqEQCp0jMyX7foRDZc8BIHs3qP2b1+8ps2WaagjtVPp93zrAbGAdfg==
Received: from PH7PR19MB5562.namprd19.prod.outlook.com (2603:10b6:510:132::22)
 by BYAPR19MB2696.namprd19.prod.outlook.com (2603:10b6:a03:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 04:47:59 +0000
Received: from PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959]) by PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959%7]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 04:47:59 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [EXT] [RFC PATCH 0/5] PCIe EPF support for internal DMAC handling
 and driver update for R-Car PCIe EP to support DMAC
Thread-Topic: [EXT] [RFC PATCH 0/5] PCIe EPF support for internal DMAC
 handling and driver update for R-Car PCIe EP to support DMAC
Thread-Index: AQHYEu4MYMvm5IZXhEWkJNuh/Cvz1ayKuTKw
Date:   Wed, 9 Feb 2022 04:47:59 +0000
Message-ID: <PH7PR19MB5562AC3C5E7BBB7730086CC1A02E9@PH7PR19MB5562.namprd19.prod.outlook.com>
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4acf72b3-37fa-4dbd-c21c-08d9eb875909
x-ms-traffictypediagnostic: BYAPR19MB2696:EE_
x-microsoft-antispam-prvs: <BYAPR19MB2696237E65DE3D808751F195A02E9@BYAPR19MB2696.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I0dwZ02KAHTsAiEiOk85kEHEdSL3ZR0znd6sGOOGj85wJQhgDEQ5m6+dye24FgitBnJaRgVx+WFFyL7mtHL1Sl+h4vyXWNf+6clXVNdLR+8fX1CGYu9AFpiWOHEBJVmruXgNGHwi8uMmVQid7FeJSDjGxGbOOqGB7xBFbFCng1u98GI79al6VUrDsaI+V37P2EnAMgqVsIM5tDMALQGE9Ik40GDrLcNkAE2aDf9P8iu5WXUZ3Ht5Thwndcp6MPDm6B64o1ZpzHrbd2SEXx3Mc3yG2UJz4wxHCQLyB3HHZdYnvm/xvhVpxUAP9iBWwDZjfEbnu6mFk6xmlfg2jFI7dDvoqCR68/ShtXHlr3QSPL8qSg4qE/krYXBoAoIfefL1ei1sFv447Of7GXZjPSMSQzyapxTclcp3Qihy8/GEHASk9CtzHH5oRl0DIDMvqDukeUDhMP6rQBiREPN3N2jryQXQqK6SSnNNxNGZWDkK4xikDAqke8PHJ8/ZUAXRDN5r+Dope+tBqyWhxolHay9HLUj27dooXvh/45diC+tL3MS0kx/PcpdiDOWa33KZhVTNQFE9KAh1kbjnDnHD1Ong5kFi2N6voHlhFv5ngWpMZYkAQJbSRncfhIJLvc5Z5KW1I550Q7LX3WhJgFsjBzp5ssqIFpPzGcef5+XmUh0/5cejglDWlIG100VJt8G5z/jnFsS5ji2inGDptvtmculNI5a8LS/2nceeosgi7QMP1v93WzOrEp46fWY0dvh1OGYFuQXoAP5/FT/KEHAm9GCPTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5562.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(8676002)(4326008)(966005)(8936002)(7416002)(66446008)(66556008)(88996005)(66476007)(921005)(66946007)(6506007)(7696005)(38100700002)(26005)(186003)(122000001)(33656002)(5660300002)(508600001)(110136005)(54906003)(316002)(55016003)(558084003)(71200400001)(9686003)(2906002)(86362001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?1++kR95/0IM1gAjo1hj/EES5m2N4AWGHrKJY5p9gX/TegWACjIQw4KOorR?=
 =?iso-8859-2?Q?HhLZ1oHDj+LQypuFzMg0bU3sYmGd752lSFcQOYvlW9SQIaBuc9/GJNDeXX?=
 =?iso-8859-2?Q?hKPDEVcXHfRADgI9Y34HWcFay1UBx7A8S3fTt8HJprC9pQwbhq1voCbL6x?=
 =?iso-8859-2?Q?sKYQfHPKo8OL354aCwRiOwDUjQ8NV6PyIm+LnKv5DcgWJtApeGQ3Nq4LoU?=
 =?iso-8859-2?Q?luNSLyUjgwc00BL2qTqG7na+KybXQgbhBsOZpKAHgkNDQsJex8AMz1XWAY?=
 =?iso-8859-2?Q?4A05O8mdDqIxhk9mzUdi8jrpqYBTKndCCUTd7D+oNAdTY3VJJ4kKNnTM3P?=
 =?iso-8859-2?Q?ELqBkdR6A0gnASTTTThfLPwyfkbFnoiNL6vgt/EpeIBizU9iisiiU2Y07H?=
 =?iso-8859-2?Q?2ExwgmGJi3nzCy05LP/Qs6jN1Il91P8lbmaAdJ8zBzKKJey0U+NDeQTfRn?=
 =?iso-8859-2?Q?WG03V1Ww/cwomaJqqbRr6nOo0YTO5krBpOb0wRTdvNQRMENpuxPjd8z4Ip?=
 =?iso-8859-2?Q?EVouIW8jmPLNWK8Q4oXtVtiEvUoDus4rRY57htcSMWF9po3bMRTTXochva?=
 =?iso-8859-2?Q?IeRYMu/8U3kNmyB7eHsnxjd9t0O9oIXCwvyuCPpJHupx9ohl6pYFnvnZng?=
 =?iso-8859-2?Q?iARDkN/C10EFmGk+sXdoJOKM2z3uAeOLgkn0lQZFnEw/d1iXZATm3/acPk?=
 =?iso-8859-2?Q?eHjsJRgTKzyKZMBjjQG3JrsQIW4EuaVUTs8fTJO/idZgHPNJ7yoZkgnyDw?=
 =?iso-8859-2?Q?sSfP0Rlipk6M2wauczx2pYLqS6yYFWLzSYR6a3Loi+W/g5QkI/FROAhz1f?=
 =?iso-8859-2?Q?68SIqbvtE3oCRNqfNBhbHCD53R2eozr854rTpUPwON+RMuCL1xqLUsAMsJ?=
 =?iso-8859-2?Q?BVLPsfB1qW89Di/6uE+nI06BcptBSrfwktRnZ/fWUG+M0C1je6pALg5J68?=
 =?iso-8859-2?Q?EP20g3N8/QAgcf4H78rSCJvIBN7eVMwCsJTCkccMAznCQhx8c7EAyN40FS?=
 =?iso-8859-2?Q?lx6uyVTS90ugtNqsGuoKn2gZMlVC66vvPJARx2TJ4X+PH12PzKcM4udSOj?=
 =?iso-8859-2?Q?U4iS7Gmnxg6AyqO2slDnfzxhWq/ofPy8FcqC/f5ZJPIWc5N787UBA+t8k1?=
 =?iso-8859-2?Q?3UY3wGPTvuUvTIwYQVU8hqImmJDV9cswDYfNRDssnuCHR4YCeiksgMn7Un?=
 =?iso-8859-2?Q?O1vs2H563qYHHoca6DN/04zODYPCj66pO3wh8uzDFEZLHZanA7ONccexZb?=
 =?iso-8859-2?Q?PMxEBsVAEZ/kQgUS0im26Fi5FRjh/xAaWIxiPQOrUgIv2Q/YypLCwI9b4n?=
 =?iso-8859-2?Q?Rwz+j/VQHbhtx77r8HbVW0fGkeu7vViyeajzAfgO6x1npnj2oNFWwRrNQ4?=
 =?iso-8859-2?Q?KhBIMaEkpOYkUyCx20PmbvBlnooLjzWERJrNpAYHt5hadSrXL7/AMRzt39?=
 =?iso-8859-2?Q?fxVPOabVg90BtrXztCapOhBSO8SWOOOI/3QKQbz07klOcnDox3QTXutkfi?=
 =?iso-8859-2?Q?U13qdvQRsZTgAGM/ZPnrnUlCmSOGnxNEbTcko10+ayMc0IxPHBs/sfS27w?=
 =?iso-8859-2?Q?8vXb8bEZl1ZwfqxPnva6TSLSll7b2MhgEC3JUN5R3bml2B5bcnXYBo0Ngl?=
 =?iso-8859-2?Q?NNLBe0rgCTul+eU+y5p8DQ6OPpSVZ7+t2Y4/Mn6oRlUO3kwDEk7iDD65L2?=
 =?iso-8859-2?Q?QCc2eucJPTivxDLTR1w=3D?=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5562.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acf72b3-37fa-4dbd-c21c-08d9eb875909
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 04:47:59.4595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RpvLW65ExupyrGa6LOa8nS92y3a0pxJWRIL51V5qF4tUcAs1ja7wnS3r9UbAYHEybtsOXGPmNf1l9oObHMv9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB2696
X-Proofpoint-ORIG-GUID: xMjBFLdnyNatdTOCmKKuGY4iIorAT6EJ
X-Proofpoint-GUID: xMjBFLdnyNatdTOCmKKuGY4iIorAT6EJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_02,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=788 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090035
Content-Type: text/plain; charset="iso-8859-2"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar,

> [0] https://urldefense.com/v3/__https://www.spinics.net/lists/linux-
> pci/msg92385.html__;!!PeEy7nZLVv0!yP0WqYs165riCjWRhZprjgMVVLfQLtkkPfv_
> R7XCoqkqgMsOyor90EZp0YAdxu0$

Can your streaming DMA test case(-d) pass if you use EP's internal DMAC ins=
tead of external DMAC?

Regards,
Li

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
