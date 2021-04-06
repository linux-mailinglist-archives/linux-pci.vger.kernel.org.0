Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5563550F0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 12:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbhDFKcl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 06:32:41 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:65466 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233025AbhDFKck (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 06:32:40 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136AR8C1026067;
        Tue, 6 Apr 2021 03:31:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=jC0YyPX74JjDn2FRGPBJ4UZjcWHzfme0mr8ebDHmBss=;
 b=PUAIQUVnV3K6jO/w9tCghEdUgCgt13339JYEtlU2oFh3tAMkQEwzUE4bdHVly7Rr7nVS
 Tq0prtgAqBfazDqUC10KJI7k6x2GIdLZ/0HqP+wWq3H3Q5tVzWmlpy5bku6vgD4VWExR
 1WjEoeWytByNGYpglc/f43WUIKLaVtSy7hJzS9EqZt/Ko5FfpyKrUoTJFp1KNYV1lfjF
 jzwQ4AdPfCAYLgwrSyJYtyM4jqv4GMFu+F8wnv/6XE5CDBlOt4PXPMWuBRL+SLj4SFYI
 Ss8wlcPMgYFgUfYY85780Uwo9LtjgLYl7zq1ketldBMuHYap0bJOvpRHLgF1ohs5Ubrr 3g== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37rh02ruy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 03:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXDyVUFhj1sS3GeRoo4Iq4yFPKQI0V2Yt+QucFPnMk8jKR65PStwJprz7mP+v0mhU0Y5jrSU6QBiqquliHpq0Ts5mwkWwEc8Bzy9nZuuTKKpikkXQomZnV2tal/H7aWtuMlopxY9MZhDu+WiLvGJ0E9X+K95ViwqnZOWj9PgaK/7vIuUPqrq3AFH+02exqFl431AaI0ftD9Lx9si/KhjBJyP+j2+/zG93dSaOwzUEan7r9WVRRbE/2Yog+zuUCFHpn9+hAak7H5zo8fcIOxNolszig663P+B+bUpHequ5LyVsmsj2ypg3EFRlPL5az5iph4QZfrxGmFEn9WZ9xbH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC0YyPX74JjDn2FRGPBJ4UZjcWHzfme0mr8ebDHmBss=;
 b=SCNmlbI3PZycJN11jr1ZAT9aGnJdJNR90Wvy5lVlx4txGPKo+dfo/9Tb4j/GRpO1IGjpZyjiFzpKFoonY4FcBXGQcFZobr/iQ+ln8qDtc5157aXd3KG/BYRBH94qT5dy8+Z6651nf3pPE/ycSqmzPnyD9PrxY+WUls18aHTxludpw0ONEoE/3C+Q0oI5kuUT4NZdN/sR2rTpEq/6zuqA7LyHLvnOzNE239d17ZfwmI+qTf9bH8bETFFfMB0NL2Cmiq51c0R9IzdH02cqVP9lzzLLHowRavyXAwP9zFSYOzzy7KvQCak6Qmdk9T845NsW82jOulv9ro2B4NEgiwLjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC0YyPX74JjDn2FRGPBJ4UZjcWHzfme0mr8ebDHmBss=;
 b=uD93RIGT12KZnjURg42sPcAp4UyhiSBCC2597vhxnWgdpsZqObqV9S2ov0qOo4YTdfWwRpSMRBhAc4LwnVtjmCm6sYErsPd0CXMZa2stX9UqY+zSDWdn6rVncRQV6b8Xv3mz52ylLSoZGq6uqabvsDVlz2Ubg8VbqjRrLX6tG4w=
Received: from MN2PR07MB6208.namprd07.prod.outlook.com (2603:10b6:208:111::32)
 by MN2PR07MB6365.namprd07.prod.outlook.com (2603:10b6:208:119::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 10:31:50 +0000
Received: from MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::79fd:abf6:7b49:e2c2]) by MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::79fd:abf6:7b49:e2c2%5]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 10:31:48 +0000
From:   Tom Joseph <tjoseph@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Athani Nadeem Ladkhan <nadeem@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: RE: [PATCH v4 5/7] PCI: cadence: Add support to configure virtual
 functions
Thread-Topic: [PATCH v4 5/7] PCI: cadence: Add support to configure virtual
 functions
Thread-Index: AQHXFcfrU70Ry7+PnUif6l0rSHy4YaqgCVQA
Date:   Tue, 6 Apr 2021 10:31:48 +0000
Message-ID: <MN2PR07MB6208CFBF96B74CA8531E21CCA1769@MN2PR07MB6208.namprd07.prod.outlook.com>
References: <20210310160943.7606-1-kishon@ti.com>
 <20210310160943.7606-6-kishon@ti.com>
In-Reply-To: <20210310160943.7606-6-kishon@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGpvc2VwaFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTQ5ODVjMDVhLTk2YzMtMTFlYi04OTQxLTUwN2I5ZDg0NGVhMlxhbWUtdGVzdFw0OTg1YzA1Yi05NmMzLTExZWItODk0MS01MDdiOWQ4NDRlYTJib2R5LnR4dCIgc3o9IjY2MyIgdD0iMTMyNjIxNzg3MDcxOTAyOTg4IiBoPSJELzVkRmhmVE0vaXFaeEMrZlpBcHVHclZHeWs9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d54b4999-9be6-491d-5e5a-08d8f8e72f42
x-ms-traffictypediagnostic: MN2PR07MB6365:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR07MB6365C73B14200E3DA7071FB9A1769@MN2PR07MB6365.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UgZZd30JS4ahgEYVwSWdJ8d9ybf+mmI/Q7ZVPAMHE9M2zq18QMBq8z67zwXnH1Q9pAW1w4GK3el1sWUVEfVBGru8ua1wo80B6fPYETvNMWS6v3Lyt/tv1NETwuK1OvFDtLULJNONwZbfizZvcNpw5xciq4NhANpiK9H0KnHkeJ4vrmCIyGKPjIh7GSDMJPTOip6invE48M/ZI8KnZFfcT101lYRLXE5afo1TuiohjhoMZT8ICrqmHpo1IO8gBHNQIbBxBGqq527b/xmvwA1vqIUBvJEAo6wiMQP4/mogbSjFXO767bh83LNU3CwkNyzRsW/r6xChQmS5O8v9aVJ/KmxdLYtSA4preEnfijT34Zsx+QyxcTzaU7/cooLcROcj5XTPc72EHvbhhOaxuTNu/kiHXcpxuuVxOELo4X3Z4FMwwH0U/aZiyOrzCNwOPHa4v60OBoadpGci5F4gJ98Mcunl/Ve256BlJe1c2Mt8M8wXizMQEBTkvnN4A/DgQJnhY0LUqC2pxfVhbSC2ir+X74wTcjlbWMD8WHKb7g0Z6RfHKfpy037rJswWWAS7Exb0DEn/4k+ndK5uuLSUcIrto7edwBLGtToLRVLx3PBcgVyLLa0P5RuoH6kC43zW5hSdEZsOk89Nh7WFi5u/bQWaxPC3d+zjZ+PyHtBm9PZqSLVayYifYvOn9AkeGt/rQKL7ARJsV5hM5t+dw4WAaF1Wxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6208.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(36092001)(76116006)(8676002)(921005)(6636002)(9686003)(8936002)(186003)(4326008)(66476007)(38100700001)(26005)(110136005)(71200400001)(4744005)(33656002)(83380400001)(55016002)(86362001)(316002)(54906003)(7696005)(2906002)(6506007)(5660300002)(478600001)(7416002)(66556008)(66446008)(66946007)(64756008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pubkSshVI/z3TY0MeRnbnNL12Up9NfCOEMcZoeruCfFtKYMoos9o6YYZMgcq?=
 =?us-ascii?Q?U0u0yn60KRsZiR0PvOax0s/ye3wtkLWJC7APaWbwAwj2tsWzebib8PodMkf0?=
 =?us-ascii?Q?XU70VLgICapsCVrRR4+WMByRA4TqfpV404rf6ph+j4KmBqE/RYSKPiIfqsny?=
 =?us-ascii?Q?2qafPSJUtelrgv8WPRbh3P67MbEAZe5kwXnl+ZFj3FcjIL/Idf2nIs2gdpEo?=
 =?us-ascii?Q?XwbIBT0leDmFbD0/ZlKLwhp0qzn9Ryqo9wktcA7L9LQT6YrYgmR2PptqC/AM?=
 =?us-ascii?Q?02bjNjsyYj/KQ1I0xZND3MPzQ0Ww5+FjhquhyFxCanAzJS/RfaNBJYXlY0xf?=
 =?us-ascii?Q?uKqR+Njt9bhZyCnUUtxRGToTQahz6jO2LZWS4OKDvYv/VJ1ohz6OzhfsKCjQ?=
 =?us-ascii?Q?B64vD5S0sCippXURtPRmMmv+IXZjdARhx+aM/5/KSSBwLH08sTCGt6pfWc5i?=
 =?us-ascii?Q?jNU7X/idgHlCvAYbOQqYcVmAL4QtUn7Ktz5IA/Mk59JQd1uNM4PUPumorOy+?=
 =?us-ascii?Q?fdHXByYDMz+i1fvsifCadzPkYjs+GBrFFAVTkZ8CI1cbl+UWtSmYFQQDzMag?=
 =?us-ascii?Q?Ks5Kt05YP1TthlCAcm65Hi38DUDR6XSH1yQmnZUII49Op6EdWV/XzTzbI2U2?=
 =?us-ascii?Q?t2ZuU7+2WU/k46vjFDDHx44iEv6YR+iYu9foIqflsTpMmWlQLsmqj8SbmKuP?=
 =?us-ascii?Q?T7OcDlJDuJlv+sJ/hgnqERQdkYfcso7fbwYw9b2rsKzlen3EBdXXlSz3hnup?=
 =?us-ascii?Q?d3WY15MB10ajzJ77FvIpJmKEC14z+Y+7k3eu2xyBt5zihX5H5GXPG+qETAlP?=
 =?us-ascii?Q?BbKZXS3H8kuck2ledt9r3M8wBo3quARouwZ+srTOBOLsWFDM/YQfk4w/Iol8?=
 =?us-ascii?Q?xapijitqIoa4K/95OfptoHN0LmW1UdSVd9gYe+nV4ee+E1P23NzedWxxa81+?=
 =?us-ascii?Q?JvCRTDp73+XjXF3lqjGvyubI5vo5RmmSqp/1pMWl1BHq+fUGo53sWvxNoJc9?=
 =?us-ascii?Q?USt/0cEIXDXY8ygTxPyWNGialLA2DJNUT5iC4uz3iUbynm2QL8B3xh61BCUQ?=
 =?us-ascii?Q?K+ruO+MtCF7u7vR6X6JWdwX4dbLaz/iWNE1O5P5fL2IdUsBj7cHDjFzX2dzM?=
 =?us-ascii?Q?r5SHjOQRORjLht5EITIjgO3WcwY7aj0crBU5xMo6cE5qtxAOGWbFf+3/jX4z?=
 =?us-ascii?Q?xgkokK95jmVpMP2SW7sMkRZTvYdIWmNtcOBLjWMWvGZZJ2x3IIleyuinmxwd?=
 =?us-ascii?Q?6QxtheYRtvEivL51Z+W8Yid1juYmP2U0Tmy3fj4cEjto/Tq0dmkOahPa+nvU?=
 =?us-ascii?Q?M9IFNBfXlTuT0am9DVdeJ0Qr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6208.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54b4999-9be6-491d-5e5a-08d8f8e72f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 10:31:48.6467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4it1ta8ymo5iNNUKuEFeGa03luI/73UOX9aTnWHxQfViuhN+GkGk0qV/5wBRmROs3fhjT+AnfYUbCA+Kub0peioFd+UW5JxA4wQoX7jLyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6365
X-Proofpoint-GUID: AIH3SF8bDapgLhh7inckgJSbOF8jTuxH
X-Proofpoint-ORIG-GUID: AIH3SF8bDapgLhh7inckgJSbOF8jTuxH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_02:2021-04-01,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1011
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104030000 definitions=main-2104060071
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: 10 March 2021 16:10
>=20
> Now that support for SR-IOV is added in PCIe endpoint core, add support
> to configure virtual functions in the Cadence PCIe EP driver.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 207 ++++++++++++++++--
>  drivers/pci/controller/cadence/pcie-cadence.h |   7 +
>  2 files changed, 197 insertions(+), 17 deletions(-)
>=20
Acked-by: Tom Joseph <tjoseph@cadence.com>
