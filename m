Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D018A493740
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 10:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352925AbiASJ2b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 04:28:31 -0500
Received: from mx0a-00622301.pphosted.com ([205.220.163.205]:10278 "EHLO
        mx0a-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352766AbiASJ2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 04:28:30 -0500
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20J9MAUA031130;
        Wed, 19 Jan 2022 01:28:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : mime-version :
 content-type; s=com20210415pp;
 bh=rCbFwC20omt0AmuDE6InlHT79uM30qO1GI5hQCe0l5o=;
 b=j4OeCs/9t3/s6hzDrXzCZc4w3zlDKAJu0CmAIqxt/FXg5Y12tQe+TZDW/PCCnZ0mjiG2
 kk4H96I5udCoaunGX0QW8Tamzt82UAJvJr1I4n9fn6w7qFLQijCOuD1sy+3gqBjMHbif
 39hcYNzFvX5bw5/x8eMHJJv9XNoMAdBrtyvy/nk+iQP/P1UoebWo0O26dEBS1XBGxWba
 b94FQzXIxHxmQa9fVVDxO5RgzGf8Vx5Yprftj2Hffe716fLge9cCB8ogzF+Hf3yXOsnV
 gf78bYYYlCHRCKKowSSELRx8l5YndLloW44b+Rdvj+ZSymXqnQZiLzrtOCMTUGWPmNHg PA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3dna2r0s49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 01:28:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWHkGWmb4Hqh5J9YGzwLyIQsyUGdtM0xIxYpGYGCLiUgr3Zr8fcV5mNW6ECom4otH0nkq0EYfMjSYiZYIFFqya+Sc7qFPagtXzib0f+PCMGe7HpPKGztf4mhMl2aH8JXISm0SaknpSJBOLA7nTVVV42EB145eWp/QtQp42ao8v+/idalN7v9w4pSiMMIDmnrEKT54kXpYqVnDnnMThSLrIcCDH01D5ngBUJxCkFhQN5oPiDNxKQ5WqprHIXmDklRnXkd6Vt3hsv4A9dEK3PkKW9jchSDHqnmFfelFYGYBMToGIiyTS1Hg4HtmxRuJgsnBuuI7PaVuN01XyVVuL1Gng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62TQrvx9MNwRgOkABvYehmr8zcMSjqzdukfvuxi839E=;
 b=RD73/MgMLbLFcRpKatxnbmBHTfPrMiuIGJ7vKcPVv/z7+2gt1daPot6IY9BpsXUS0sNRYzBA2n7zNOdwNiGh04qm9MgXCyaYcr7VvKPFhemZMYMdHuNvN9tyrtIBAfFn24SeryWOX4/cLLk++NDgsDpBslYRmw3p2wCl16PpW8Ypk6HwRtrmH7HRCC5GMwUGRuMbqrSAOOnXtTEwI7Wr5GnT5nV6xpdG1pKXRW8Z+Q9psqOL2gkJAyLSLPL9fOQsAVrJIIinisX/q4aokNIijWdHHZoMN/cvcst9L+S2NvwuQQlp+TNj5Jze//agT7FMgPKazKOO6hLBr0olC2hFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62TQrvx9MNwRgOkABvYehmr8zcMSjqzdukfvuxi839E=;
 b=aioq8vCAe+HTEhpkveZajpdxYXF5j3/Ul/FUwUGxZHB3LlsVctfW1uL3utJFsyI5UoSHIZP584nENAELxnPCUDDiAtLEMrI5etWaxpoSJEGTmlxqCJOHiQLn88lpoRXUtigSDg3OEWO84L9SA4DPOnfhYG6QUE+F5oE7NF1AdJwVGGWLWy1cOLrazv+sLVakXhfpaWazjBCQRWbnwTBq5LWMXmF2+YeB/GmdHE/mihmVG7elQ29TgoJ42Ya0I8/DdA+FTFwF3oAYHT8jqFHSXCT3AdcRgC99R75e680RqabaUFl4KRavg3KnP2GqpnzSklvLTBt66zoZiWsffY7Adg==
Received: from PH7PR19MB5562.namprd19.prod.outlook.com (2603:10b6:510:132::22)
 by PH0PR19MB5621.namprd19.prod.outlook.com (2603:10b6:510:143::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 09:27:45 +0000
Received: from PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959]) by PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959%6]) with mapi id 15.20.4888.013; Wed, 19 Jan 2022
 09:27:45 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Tom Joseph <tjoseph@cadence.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for is_64bits in
 pcie-cadence-ep.c?
Thread-Topic: Why does cdns_pcie_ep_set_bar use sz > SZ_2G for is_64bits in
 pcie-cadence-ep.c?
Thread-Index: AdgNFhFdLIAJoUumRauHA5pdsoTIFw==
Date:   Wed, 19 Jan 2022 09:27:44 +0000
Message-ID: <PH7PR19MB55626CD5D22EABDEC879EF41A0599@PH7PR19MB5562.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a0a1d17-c91e-425b-8e80-08d9db2df34b
x-ms-traffictypediagnostic: PH0PR19MB5621:EE_
x-microsoft-antispam-prvs: <PH0PR19MB56219D5B242F971CB98C2A5FA0599@PH0PR19MB5621.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IODRRQSbCrbpxAG2brNyLU3uF0J3uQzQlGvCRB6LGwirtHB+IK4fnDFWc+7cdtFrAqSnifsR1oKjrhp5JZ1L9/97+3L+Rz1CbjEtAs2AzCouzgkAueFw/wLfvu3n57+eNKZ7yDLOETMtamnbbMnERec5TreoPSLin2dq4BirHRWiXGgosTRrcDJufqPX7h90pKGok1k4PYIMIFWv+YvodQQ+jHqXCig2/9paAPmF9jx0KFCSDwCjbprCBdzVrZFb3QuKMkoOsZb9r5FaMULoP7wcX2HEoAhbmOy68RWFQ5jDl8CwwHKf2VSaZo7zrFkxRIFBkh431wZp7wYWeiMJkATedz8c74u8jc/naOsEIG6G/amPfutqWipQnyOyD65l6uQGwyM3M1AKN+GLKBXm+m8zVg1mLQRA4bWWIq1NPb1DKGwMvUcHEe8ZkhAKR71ZLrYpK4A3KYZJzwFuGlcUP9upZUjZ2D2wkIz3a4HVuXdrTls+p2AtI8Ue8p+uJOVeDwrbUKwSgdAsfVX2DfiT+Mh/7MMqocaSqOHDZHkMxRcnZWgupzMdBu2Wqg0PkXN65DvW4IaggsXGFnkv0YVdnUh+Bxtws3BN8sLsFTgBbSjwzWodts1Oo/G0svTzf0Wo0NdPl/emhIyZA5l/lGkhgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5562.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66446008)(83380400001)(33656002)(88996005)(8936002)(6916009)(316002)(9686003)(66556008)(66476007)(66946007)(86362001)(64756008)(5660300002)(26005)(8676002)(186003)(52536014)(6506007)(2906002)(38100700002)(122000001)(508600001)(54906003)(4326008)(55016003)(71200400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?8v0WbHvAkwtLqkj0pCicea9PK19od2D278FZCswmgi6PTjVVpq/C+KWjw3?=
 =?iso-8859-2?Q?5b9m3KMWkr4cydIYL6SzwOaAdPOQbLWfwEGsBUdpHVFWWupiJLAv5jkJYg?=
 =?iso-8859-2?Q?TFVxZdOet5iqX9c1xM1+hZSY+/56wK3yGkdwnTsh8drD5xdF5LuJ8yB2AA?=
 =?iso-8859-2?Q?x8YYfmrW386NYGQWLKO9WsGu+VJpKSDKvXmlFlBEeqbHy1LhuChDUMtm4R?=
 =?iso-8859-2?Q?6zHQF9318p5wH4oc8DQju2PPQEVWrA84Zz4ZJSnEaLuYJbVc+3hQEqRnBu?=
 =?iso-8859-2?Q?ZvRFyR7oDWo8w7eJCjK7j6YnuhVrkBvSloF9teyTIqGkX868GUisqfGWM4?=
 =?iso-8859-2?Q?1hjJqUp9r4ot0izgiTSRUBwFfOucCjSK/qo01WUqO1kys1Eh1oOa6kAhgA?=
 =?iso-8859-2?Q?oFgL0wIS/EhBn0/ISLIUZwIqVEVvXGoVSrmL5Hk44XW73hqo1Iegsd8spA?=
 =?iso-8859-2?Q?24v6oUU9SmWzio/+PrPz+G+5vo+zKRdoEs8fjLB5TvFC6ZwfaG982j4it2?=
 =?iso-8859-2?Q?N3vFQRFVjuivstVbxQn+pAC/gw6ZRhAaL7+Fmw9IWj3/DqKZ9sqR3uTLaP?=
 =?iso-8859-2?Q?ywnsomXO8VxdIWfx0D3ssJIWrSmymkAFOrNDum5PPTctBiKjfEb/oiRMrl?=
 =?iso-8859-2?Q?bAuyVkKXRg+hzqN5qMR7MFrNB3oZIoGWJPSx5K6NMSR5by3oQSQQC7Myjq?=
 =?iso-8859-2?Q?AqfGdXbO2kweGJD87JufsOjY1VJ3WjkbQwJyNp+ye5agquwtjENby1m2/p?=
 =?iso-8859-2?Q?zuGk43JrrNPHI3ZchCByx3scShSHxwUTo/ubUbnuUu/595G6B3niSitsnp?=
 =?iso-8859-2?Q?7vFcSkkrXZxVzF3UdPudm+OUFSKCzahXM/r6ZEj/f796REyH3kHw55Qvuc?=
 =?iso-8859-2?Q?Vq2qN6CJ0gS3jhYeYNBjvxHIGzgO2J4R3D+B7hwat+LAP5fpenQxCLOtTw?=
 =?iso-8859-2?Q?2MXvhNHRsVG++23vGIW4aeUKHglNEenRgLpokN8GhA3nXojG/ROB6Qa3TQ?=
 =?iso-8859-2?Q?nUrP/s1C6JWzDwr1lFITizW+QWs9RpBVTTYMhxgPztpoHftpFq+RdHSR27?=
 =?iso-8859-2?Q?kQTadFexZBpLXPXV5nJyNTN5Xc3DwpFGIekywcFzDd4Pane+G5AbXOtKcb?=
 =?iso-8859-2?Q?68rQu4GTfCOkVQ6KrHvhbL2gBm7PRoJabN/q2PKZCJ1Id1ESqfsGd8oDjO?=
 =?iso-8859-2?Q?S6MCYYnOILTpxaTbT34qI7LbO/5kIh4F8Jh1oBMTlCQL1wtKsiOIR63l19?=
 =?iso-8859-2?Q?B5o1zbeSYd/m7IE5G2ngGpFTsEzNr1HgfLANmDE6c3UIb62uGMcKeSe5uC?=
 =?iso-8859-2?Q?A+UXKxHhbVwh3KDZZ8fZJ+sVCiOwr6BCtVTa5aO4rzMAFrZaKWQZ6I8Jy4?=
 =?iso-8859-2?Q?Mnsniqv8rxnukGCXKXeBa2K8EnOTRwNl491nAjtp8pMeVgYyT69zkWY5at?=
 =?iso-8859-2?Q?f7AnKm8NAGP6OLLisjTCd+CqiTe/k2a1+lTCJ6t/D73KsW5bF3l5QSQuc1?=
 =?iso-8859-2?Q?76m9cd4yWzV02uWrP1NlP1GJrYVlue8fY7/0nTheVx5fwAwM7ZgxMh5TBt?=
 =?iso-8859-2?Q?OSs8ACOyPSJ9doojdy8dOteFz47TURt3ifO3aCsEwvyCxqgA/G3zWSK30q?=
 =?iso-8859-2?Q?BQ2/EHGA0ENJGrwHQy8IRiKbsPhdPb/ffnRbZrJ2d6wRYYudwLUax1B5LV?=
 =?iso-8859-2?Q?cRnqc/4mtweexg4MsiM=3D?=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5562.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0a1d17-c91e-425b-8e80-08d9db2df34b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 09:27:44.8806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9MWjkdtWZQH+53V8dx9CFHqvO9GsYnX2HLA5L1R0V+g0ztxNNaUBg0rnRJJdW/7dfSIpAL2z6GrLc9w9jSLIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5621
X-Proofpoint-ORIG-GUID: hSN8hWWH4Cx8FSnA2Bl1DyQAEcMx1vFY
X-Proofpoint-GUID: hSN8hWWH4Cx8FSnA2Bl1DyQAEcMx1vFY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_06,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=456 clxscore=1011 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190051
Content-Type: text/plain; charset="iso-8859-2"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Tom

From these function:
static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
				struct pci_epf_bar *epf_bar)
{
	......
	if ((flags & PCI_BASE_ADDRESS_SPACE) =3D=3D PCI_BASE_ADDRESS_SPACE_IO) {
		ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS;
	} else {
		bool is_prefetch =3D !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
		bool is_64bits =3D sz > SZ_2G;
		if (is_64bits && (bar & 1))
			return -EINVAL;
		if (is_64bits && !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
			epf_bar->flags |=3D PCI_BASE_ADDRESS_MEM_TYPE_64;

		if (is_64bits && is_prefetch)
			ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
		else if (is_prefetch)
			ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS;
		else if (is_64bits)
			ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS;
		else
			ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS;
	}

	......
}


I don't understand why should sz > SZ_2G be taken into account for 64_bits.=
 From my personal practice, there is no problem to use CDNS_PCIE_LM_BAR_CFG=
_CTRL_MEM_64BITS or CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS when sz <=
 SZ_2G.


Regards,
Li

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
