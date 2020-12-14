Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A612D9E57
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 19:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502557AbgLNR6V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 12:58:21 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:1764 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502389AbgLNR6K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2020 12:58:10 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BEHm0cL000559;
        Mon, 14 Dec 2020 09:56:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=B72Xbwoy2qhOAMD4X7LSM6GdZC5KCqX2TI4vs079Qws=;
 b=kNtMDEaG/riEtsfrF/X4cA9OunNd+NVJqOFphGpt9DirjE4HS/P68ScfeUQmFYn8s6Ae
 L4t3Qi3aN0ojcBQx7waOXc6tgnv0WCVwPtQLfxM5khJMILQzajNu8tNbJWCo6LeKzfH+
 9pUd9OHcCVjAoPOS0b+k8C6RU7a8L2oIxuy0wzwKxzon4KCumavHBbiedv+DJq7Nxgw1
 zyPxAi1HmQovarjiUHPeBTlCJTGdlLZEhHIL9tqCefIDOr763MRtLxRXUjFuZOlascXj
 yvK3Yk1qPeMp72duxjUFzXVVA3w4kMM9SmQsOsjiX2Y/HoP9tvg40H5Seg/0wRudhacv 8A== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-0014ca01.pphosted.com with ESMTP id 35cua25vcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 09:56:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwnGoHN+d+R+dXEkBo8NrasxfMw8aA0Xrk4hIr8PKQh0mE/8uykshqWnyiAOYqeHtn+sp3geTHKQefzB6JHx7QH3eYvKGc1ut4TrxHkFBmalLlP5KXiDFKKhAuY4k6NioGtSkuHNePpAa40B2vxVu7jNXlxLMLIjv29UVL7zPWlOS3mkmn1kS8ZQfMYXWGKMJZICfqqu28X285l9ls9KKOBLC36XVe2FOKmJXomDiIIrD3RC3nPQsOhZljV/k9rK0YYgJ5eyyHoVKhn0HzTYbJh0tbf2mmr6Tf87Geb6Lh84MU7JisDfsDD6hxpzQ4kRCXBsbwPtk/jZgky0k96mFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B72Xbwoy2qhOAMD4X7LSM6GdZC5KCqX2TI4vs079Qws=;
 b=hbgfdtTS1CmoJ40HRYWQ5mrBYtvVmbvDSNrOCEI0KRXzLLGkQ9Rnqpljvfph6l9j5te12vbb7dsTqV3CohbffWZLh3vMiNqRjHf60mjrM7aaz9kigquKTll4GtWMjwTa7F7SHGJGEvBe/Lg7BDDFVWGbG3NUjbVGiq4BHNOfHcNdWneZcol8KfAfIlzWPTqsWvWpgocCmn43+suaGVdxKKT+e2qWFh0Evhu4YMf7TDkIotJeOX7NsOMDNevRv3mRu+Y2IN3j+OJoaB9gLyvZJEi9qnkwqP7yVOd29Y1KTOHSiIAZsxUnTFB6ju0R1yJ+72ye/UG8dAFAw4kYzwdZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B72Xbwoy2qhOAMD4X7LSM6GdZC5KCqX2TI4vs079Qws=;
 b=1d48Hk4p3+Bjmf0dCBZAeL1UH40o4ZlVzIIXxBCFpMYTrbUL1kUmZV1pM8sxxk9loLugc45zjfpwEBhMrgYsoUVTDohicjS4JAOlkSllLP7vFIUpjiHZVceHDUdFVfsLsIwUcsBgF2gh+44eGnLgw1OeZvt3RDdQKtXRp7NzdQg=
Received: from MN2PR07MB6208.namprd07.prod.outlook.com (2603:10b6:208:111::32)
 by MN2PR07MB6128.namprd07.prod.outlook.com (2603:10b6:208:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Mon, 14 Dec
 2020 17:56:43 +0000
Received: from MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::e80a:361:a186:f317]) by MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::e80a:361:a186:f317%5]) with mapi id 15.20.3654.017; Mon, 14 Dec 2020
 17:56:42 +0000
From:   Tom Joseph <tjoseph@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Rob Herring <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
Subject: RE: [PATCH v8 12/18] PCI: cadence: Configure LM_EP_FUNC_CFG based on
 epc->function_num_map
Thread-Topic: [PATCH v8 12/18] PCI: cadence: Configure LM_EP_FUNC_CFG based on
 epc->function_num_map
Thread-Index: AQHWuECgG+CdRZ/+iUKw/v4fvaCeqKn1mkWw
Date:   Mon, 14 Dec 2020 17:56:42 +0000
Message-ID: <MN2PR07MB6208137D0A15339D083FA187A1C70@MN2PR07MB6208.namprd07.prod.outlook.com>
References: <20201111153559.19050-1-kishon@ti.com>
 <20201111153559.19050-13-kishon@ti.com>
In-Reply-To: <20201111153559.19050-13-kishon@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGpvc2VwaFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWI3YTkwNDBjLTNlMzUtMTFlYi04OTNlLTUwN2I5ZDg0NGVhMlxhbWUtdGVzdFxiN2E5MDQwZC0zZTM1LTExZWItODkzZS01MDdiOWQ4NDRlYTJib2R5LnR4dCIgc3o9IjEwOTgiIHQ9IjEzMjUyNDQyMjAxMTE4MTY0NiIgaD0iNDljRjFXT2RPY1hLOEs3NTJFeGEwTWUwa0JNPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b25e279-5a9e-4ec9-f3fd-08d8a0599d8e
x-ms-traffictypediagnostic: MN2PR07MB6128:
x-microsoft-antispam-prvs: <MN2PR07MB6128942A9580CD90292C73EEA1C70@MN2PR07MB6128.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: As308KL9pkItdIBfJJP8kDC2bcpYmLxEZOglQEegZrD+eWstu8aNxA4gJr3Zy13893z9WHawMrL/EA/KXC/MGRFDkuqnehqdo3uAXRslYMV7YxQyzOt+U5Ej/SDfaqQUV374u0d0SMSADOScKjBap00KeGfJutFPgEPWI7u+/1p9Ryt5TlCC0/wc/mbEZeYiXNAkaqjDhmmjDChaRgEN+2W/28ldgCZpNcD51RZglWIbcKRMukBobqi3FBcrkAle6NAiwe3Yx6zVgmcMv/NfTVHHKua1+3tJg5KaSJcbOrmKUHg7qXF8Jwp0CSNOWqEZLhgO7B+TG1jggacE8BtV8EHUQS4mvicJXA81V9Xuu8roCduA5hc1EZC8fkBWBEPf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6208.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(36092001)(4326008)(6506007)(64756008)(9686003)(186003)(83380400001)(33656002)(7696005)(508600001)(54906003)(2906002)(7416002)(55016002)(110136005)(66556008)(66476007)(66446008)(71200400001)(8676002)(76116006)(5660300002)(52536014)(66946007)(26005)(8936002)(4744005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PlIUwBShDNKwnZ2gKlFEDgvpqfa2fhUx/QvlvrnlrM6eNutnRABuqHkvfK88?=
 =?us-ascii?Q?4UWAOzjC6J9/V3JuvUP2gIpg0HUzJzS1UpU/ECb/o5TE1tquV4APu50Xv0yE?=
 =?us-ascii?Q?8OVGwjq64F96WeNpsAgfkRrKTBY3y2hptACsvmtITj+CCsYQxuPjgjBhzBIj?=
 =?us-ascii?Q?zxfbKU9j4GXp1mBDkrP53lQAko2X4CbAVWn723cTpQVrD0/7UU7lMWJwX35q?=
 =?us-ascii?Q?OIi0Uteyxif4AiNMrhg7qNrL1YaBpU3odo3OAmc2hX0WpDMS3MiK74rxjFfz?=
 =?us-ascii?Q?HiZFjbagOJvc/lJVjMM28kjcb8oCZX0xRNJhjFHQAEtib5YNDSOK66S9lXqt?=
 =?us-ascii?Q?J16C6g7M28byAUuaWTJAc0FjVuSm/YZ5rbVx0+2Qtr4RJf0DqndBFBo9MaQt?=
 =?us-ascii?Q?82wldI6RHdUKhwEC2pg424f8Kt49q5y9749sMfDWABBtkWP3vhxhdn7aeUn4?=
 =?us-ascii?Q?0pzg50z9XafVeyO7tSj4Eybvm2agl7lIu7oCsGblqGeqmMpQJ8HXOyAc8E+d?=
 =?us-ascii?Q?W4tiEv97T6kAOxRRDAKRCl2YMG9vtQ1a1af7P+gju4elIr8OS6B8Z9/11fVV?=
 =?us-ascii?Q?IlXNcYIV4j8kUNl7oad+CcanwylBYbhADTgF6blh/mLBqaZFDj3KRn9lVVPq?=
 =?us-ascii?Q?rDnj6fLZPDFDft/iFiymlbJTdpbN3radUjvC88GuoZOlJ42qHgvFkofguAOe?=
 =?us-ascii?Q?wpCAdzKrL+/vZCSj/K2KNiWCThvsomof7X3AG6WGH9u+Yt2g6OAtKKCpfgNC?=
 =?us-ascii?Q?KyCpuW7yUtiy0/ihJB2pYMFCKcBWr1X+gJszQa+uALJ6RsldmPpfDlXfjioj?=
 =?us-ascii?Q?OGf8xEaxyf/y9Ow9FJ0soBtHv6J4vuUZXL2f5ZAhWsJKoa1AK/FULpKtPAm3?=
 =?us-ascii?Q?1xjrTVSBgCRRCKrZMLIJ3RTxtnZ0cUn+Mr2zMp8p0kEf2tKWijVQny9qrIDf?=
 =?us-ascii?Q?FTqj00rp0yphYNDvtNQZHUjMqq7dSOfHlB0F5oe6kOM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6208.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b25e279-5a9e-4ec9-f3fd-08d8a0599d8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2020 17:56:42.7730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kymXSxsRHlkWWZf/UKfLMSTcXlPfZeiyP+Isn00DpLb9NuH5S4KEu2tlQYnqT0RWmedjZ+RK78pDvt+FKFUxectY1pEXO5JQFe3xvCNit9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6128
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-14_09:2020-12-11,2020-12-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140120
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: 11 November 2020 15:36
>=20
> The number of functions supported by the endpoint controller is
> configured in LM_EP_FUNC_CFG based on func_no member of struct
> pci_epf.
> Now that an endpoint function can be associated with two endpoint
> controllers (primary and secondary), just using func_no will
> not suffice as that will take into account only if the endpoint
> controller is associated with the primary interface of endpoint
> function. Instead use epc->function_num_map which will already have the
> configured functions information (irrespective of whether the endpoint
> controller is associated with primary or secondary interface).
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20

Reviewed-by: Tom Joseph <tjoseph@cadence.com>
