Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3220236740A
	for <lists+linux-pci@lfdr.de>; Wed, 21 Apr 2021 22:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbhDUUQ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Apr 2021 16:16:29 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:49800 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235541AbhDUUQ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Apr 2021 16:16:28 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LK9o6l031866;
        Wed, 21 Apr 2021 13:15:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Jiwamfba4aLtn0OWbNSjBjkUl2wLufkwft5tKqQFv90=;
 b=EcUfnd39EOw9+1VKCJlDjpGWqKtwS2jVZu+1+6VXQBTfoD9cefS5FlHV/QdREgfpAYpm
 fuVoS0fhA5phAvG5nqev5zmQgKaBQv+vKQ9s6l+c8io4WKw3EycSf64n2jquQurpgyqX
 NZtF+sX5eFTOUEjr4ZrzgXC7yeY6e6W/GqzhNziK6G0LP/xNjKEuP+e3L4IqWRTS+gKT
 Q5BmBwKMCTdb2cIQyxybp+zSAbNdhZ69NIUV0l6KFOMBytST14zjzgD5NsMCQXgmI3Bh
 Z8I4Xy/XTOgx9OjYZSRo25m8XELGcBOsqur9NNfX8LVNVGXE7vmiY/e6cV1zdalz3Eth qw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 381f2srhrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 13:15:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNQ+WmmPeNuoqrA+wvJAa3TkdAAo6kb33shQ4GeHK7axMignarX/p33qNdoC4wX/Kted4EpOV/5eUqUYkU9aCZUDdU7xSKObXji1BhLmvNNtI04QPCEcrS2uOQR+wej6Vm4hQeLndtMAfJBgFuXcPuDZmVioyPVgAbT+LUyGk8mUO4j7Ep4frJjOIIQJDK094Atl0xIz4S40lt3ocd3zjHWjo9cHWenq8Nm6FG1zdA/oWCezyGJxo4sCUjiKSzTAly+wgIkZtk1i2gtOQKHwSNfVRDUdC0JC2tuIKp8h5FNtfF7Ho6mzZXcni27whQlKpQOdbwp6HokttawP6VOWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jiwamfba4aLtn0OWbNSjBjkUl2wLufkwft5tKqQFv90=;
 b=eJ6AjXzzf9wdPPYvztadI58DmlvAZkF3HFSuBKyCmHHzFf50ozd5Xq0vmYBkrv2xyg1xmKFjvi/hl/23qE5shLQE7EYwaVof9Ac+wt/LOeaVa4lK6FNrtDCm0GPnYlm8OMweup6MsfhHWJYCKeB3oAePozIPMezF18wT8niBBdXM1JFAxHKn16ssjKXU3ooSYVPfvP17tIzwywXcSfCos/C/jLxV9w816CZNpRLXsSd0Eh5hmHiHrSHFpjV6WSS+ipLxhmzRyiPbXLl5TjVBXZJE9WksoK0piie0vrFKbsXi3svkPmwvUgf5ZxNwt7UeNcaKjn3wJOyN0sr6ibj86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jiwamfba4aLtn0OWbNSjBjkUl2wLufkwft5tKqQFv90=;
 b=qtQ2xjuBEBawt9IbHBqhrquVy4bklKYAp06Wv7umPGq8cWhTdL29TXMhYo5MuLyodiiEnlFUdNp6/5LYyGSw6e5gQExNCpSranGEuuSmHeQW1gNCAYYW/hNvUi16OJW3zEkRqY4JR4EIoWibkFlxbeY9se7Dm7NnQisjjSlcBu8=
Received: from MN2PR07MB6208.namprd07.prod.outlook.com (2603:10b6:208:111::32)
 by MN2PR07MB5904.namprd07.prod.outlook.com (2603:10b6:208:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.23; Wed, 21 Apr
 2021 20:15:21 +0000
Received: from MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::79fd:abf6:7b49:e2c2]) by MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::79fd:abf6:7b49:e2c2%5]) with mapi id 15.20.4020.027; Wed, 21 Apr 2021
 20:15:21 +0000
From:   Tom Joseph <tjoseph@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: RE: [PATCH v5 5/7] PCI: cadence: Add support to configure virtual
 functions
Thread-Topic: [PATCH v5 5/7] PCI: cadence: Add support to configure virtual
 functions
Thread-Index: AQHXNPbh2HzGga4aoUerGuBNHbbprKq+3V8A
Date:   Wed, 21 Apr 2021 20:15:20 +0000
Message-ID: <MN2PR07MB6208290615344DF297E2E277A1479@MN2PR07MB6208.namprd07.prod.outlook.com>
References: <20210419083401.31628-1-kishon@ti.com>
 <20210419083401.31628-6-kishon@ti.com>
In-Reply-To: <20210419083401.31628-6-kishon@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGpvc2VwaFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTQ5YWYzMzQ5LWEyZGUtMTFlYi04OTQ1LTUwN2I5ZDg0NGVhMlxhbWUtdGVzdFw0OWFmMzM0YS1hMmRlLTExZWItODk0NS01MDdiOWQ4NDRlYTJib2R5LnR4dCIgc3o9Ijc0OCIgdD0iMTMyNjM1MDk3MTc4MzM5Nzg0IiBoPSJ6VzJYMHhzbWlGY2UyWUR0R2pURnJiNVFCQjA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46f65259-dcc0-4210-457b-08d905023093
x-ms-traffictypediagnostic: MN2PR07MB5904:
x-microsoft-antispam-prvs: <MN2PR07MB59041CEB495992D3D96E07C8A1479@MN2PR07MB5904.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Zh1GMKY+C03dzFoqzw8o5wwJ7tm5d5waztETyZLsxvgGMFDCoRJCtEQ7nR7T8DOwI71jnDU+1zcWPoSN/TukRca/7eaNRQcWMIsNaQC9dTiPLHp38tZOKoHiacPp9H2EwrSpsvQ+Ze3xfImplfkkVa2GN+VFmQJSKg/+cRIc6gIP842puWb4GsqwhwMe6nYVeMNATed6i8dUKyFXHTqJoLIs1fI/EuTxGq5jS+dADInexA0qPNlmwXOCc3U0dKVoplZknAHzeg1gbHz0wSOswLQeQ/QI3RAHkasKjOWgfTl4YNkTfqADjGWmPKLfwehHXlnL5lql4THmi6DhKc0SEb+ifjfFLxiLZPTayVKsULioSZsSjG+6wT/AslPiz/3W69amASPhHqif8j1/AmryEhDfYRtPaDGCBO7IXTZdC5TBG/m9EfAMG1vsP0evTbWimJ0GiRqi2yr0cA993y357Ngp32ELjzKr/8dObJ7Ubldd+lGmJVQ83UYM8NvfsJDZK5WrUMKLzRWaCigbobXa2w7ZDXzpmKLqhl8YCOVSCPnMugCKEM6mKBM7XksrJtiYZK/ohtFNrzn8/VMPSI3y7yr0Rt+1aKcTKDAL9Hq0JsYP6PSoOwBPduiaCQMSJL28HXCxFfxIUk8bhy2XSsDZW35nMKFCi2vTSKiyhrU6U12199uD9RO1gJWs9MO9wKb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6208.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(36092001)(83380400001)(38100700002)(316002)(26005)(2906002)(71200400001)(122000001)(55016002)(478600001)(6506007)(9686003)(110136005)(4744005)(33656002)(8676002)(186003)(54906003)(66476007)(66446008)(76116006)(7696005)(66556008)(52536014)(8936002)(5660300002)(921005)(4326008)(53546011)(64756008)(86362001)(7416002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nzjfkRXercARusCQvX7FWVsy8MBS1svTwrw0mTeQxiob9lZoDtYBMgKStqEL?=
 =?us-ascii?Q?nbd5n3HvO35AatStU/5TZgZ65TlpolJ90B6yFIx1Wsn3N5M2fEq9zFmcHQiz?=
 =?us-ascii?Q?xPkJgoIGxWtz5aYavDlxRsrU6BwBmkZFL7lDCAOz2GQScBnOgFlIyLm5vyJe?=
 =?us-ascii?Q?JJ/+lPfKTtOUIS+4b2zKIzL54IaO/R0ORNvhXhLryxeBtom06jEgiwXFJubb?=
 =?us-ascii?Q?WH54jBsUkUkOJCW4XbnmeVU6qI5ADHwZpwH1HTg9Hd9dLnwfTp1VLsqKY0Ma?=
 =?us-ascii?Q?qKf8XPFKwmi9VF2Hz1eOndWVg7aOU+y4aMMwecSj3VMmaLU9GqdJi3fTxIOL?=
 =?us-ascii?Q?1g6y6075E79pZ7PjBBh8IDhU8a7EG9d1cHh2s+Ps0qXpd1Vn1BruU1FZxaDX?=
 =?us-ascii?Q?CC2lXdhYI/sokWx+peeJqz9dPEoikYCl2fRQ6BDH9ohD1nX0j6c8MlPSjYdx?=
 =?us-ascii?Q?UXbfv+tMIaY2DitnjbIx51QoQzWFKEbOH1hRTYxhRIjIlse8plNJIeq1S0xP?=
 =?us-ascii?Q?YmzcRuwa1sGwDLqri0WuWMOJS2XYGCKoBLibve8qFNhicusgF2aNKoHTx1Sc?=
 =?us-ascii?Q?pyuUHEJ1j6miH2OHG/vp3Hh2vgLM9EyxKug/PCdVSGleE1TpCKVytv+xM5cZ?=
 =?us-ascii?Q?x8vABgctkHnly7XHSODmBgWWy8iTGX1KpAa1rj3JrCKqk+JgMcSyB7Nibk/r?=
 =?us-ascii?Q?N+ZAjw9ZgDA+lhvfj+4pjQ/xv15AMyq0tdLcAPBzYdOdGeCATLqGKOgiA9/j?=
 =?us-ascii?Q?Iic5Xi4SOb2MzTc6QclKNR8BY6wG/YVjXRSNsZoPRjqpdYuGVqo3cfE8KgVC?=
 =?us-ascii?Q?xt5mfn4sqdCJwSVfpBADpQDaWF5Yj5+UpS0JN84ebZ7bj02Z1QzzM8bN8K9A?=
 =?us-ascii?Q?T5Is2SWPQVL93vtzyGfpeXRn539bgzalMTMt9EhnGivCBbKpm3FOx/9uBbkp?=
 =?us-ascii?Q?Hwa+AleDgghmGOr3iEHmL7XMKMyUe8uTa0rtxVY2ik3DptcvXoF9J5pCXk3i?=
 =?us-ascii?Q?yGnTK0p+fAObsbL+rUSvWKKXkceDiFNaCKghjI6y2CEV8lfZtSJ3gekIvsSq?=
 =?us-ascii?Q?tEEIZzrLdooWpvRjsTSq1Bc3IiIMMvi/Rctx95Y0aj+2Mi4zzEJQ4+kR5d7n?=
 =?us-ascii?Q?GoZetszavWQ78eep6ikGzwhc/ntFTE6DhLIj2Y7sCQFSliYZIlfjtRRrrSWc?=
 =?us-ascii?Q?LxKwoXPwApXIY0K8qCGqh7TyzqweRHqOd3bf2ree4V6fCHmF102GqNaa8C8k?=
 =?us-ascii?Q?zzc7nFJ7i3t7fdH7RxedM5KPPAZLrrjkNhbUTd/uSPXoCMgChTUtfK4lkdlI?=
 =?us-ascii?Q?ZtlvHQPxiGYO/MSbzKj1T/FT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6208.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f65259-dcc0-4210-457b-08d905023093
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 20:15:21.0408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01EqCvFcCFB1V7jfSZ3O/JOsmJio8o9b5z9QLtGcCd8wnie5IdN3zzlJ47zk+gb/g11QA4u0yzSQCph3V+uoMWNkIBhFpIkj5Yx1fOWcHs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB5904
X-Proofpoint-GUID: qlg5Pxe6C-jGC8-1THyI052q2Zt14maq
X-Proofpoint-ORIG-GUID: qlg5Pxe6C-jGC8-1THyI052q2Zt14maq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_05:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 clxscore=1011 adultscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210137
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: 19 April 2021 09:34
> Subject: [PATCH v5 5/7] PCI: cadence: Add support to configure virtual
> functions
>=20
> Now that support for SR-IOV is added in PCIe endpoint core, add support
> to configure virtual functions in the Cadence PCIe EP driver.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 241 +++++++++++++++---
>  drivers/pci/controller/cadence/pcie-cadence.h |   7 +
>  2 files changed, 217 insertions(+), 31 deletions(-)
>=20
Acked-by: Tom Joseph <tjoseph@cadence.com>
