Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531A6435EDD
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 12:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhJUKUt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 06:20:49 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:51368 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhJUKUs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 06:20:48 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L5JEpG019672;
        Thu, 21 Oct 2021 03:18:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=gfhxrGBwWVjBRpTWPvTDeGMy4MeU7AL3eb9qIv7riYw=;
 b=K0RRSyVa+mKr6I/njktJyq5CbOJaMUfwl13dUSXMgzH0JX7LFIbCpJ1jew6BeCYR5GE4
 lS2x6vuW1NoHc6y/hw9avh+ZxvXdIiXLWkQqzJ6U5CwLeXehMK7C9nNomckEIPYN5Fp/
 tfJkF/wUT4YIE0+NZIHXCNgOvs3U/j4WaXgABlDohoBEhoPzef9fT/txH4x31W3PXilG
 OmZTRX+0pLch6299lgmVku5LXqckLT3Gz7kLN7T//iAveY864emOplPIWdBaj2UQ4Fk1
 F6hlFXd/G9fqUj/cl5OsCOAOveE3Eehc0uIyRdSl9P+01DjDlzQKfM2ROflwWwpXPvFn HQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3btpcpbvya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 03:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJJ1hSZZLStUW9RdJ0xrdDDyxcxYJUow87TG+uGqcGE7ICOq+YxM9xaUzgTP13AaPJaD2I0t4uu/Gqyj/lA7/q9rCQfnOAfX87dOESmkH5yAfsKBjYaexfAqehO+wvLDnn4xUbOGNV5dwvtf7R/ml5IcDsc6nRsRGfLoN0cL1cWJ6FsthocRBPneaOvXi0gPTYkibQceJKI4q/BN1tHwx49Ds5n4oPpOC58wpxLtoI4RiyqWcAOY3nPMm3tOr66onu4d8Nem3WOpYWGxn1lmhHTm5HU0E3YIlvuHDXTeZ4fqVpHYnJxYoXH1av1mn2UMK7CVIK3NHW49EoBBmyukiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfhxrGBwWVjBRpTWPvTDeGMy4MeU7AL3eb9qIv7riYw=;
 b=JEbMmgGtUhVOrp5SDynuzU4vqIFupyTy8Y67QyVE9LGdi4DE91oRyAMti6YSlvi4FC2kfY7A4cvYZou990THaApmRDAs8K4CU+okgdx9F6GWOQ5P8A+KXvU0P10yosca0R2V5KUt9T50KwAHG6486124q01zRuG2sgfEDe5L5UHMf4K6kHL6VDIDIWOQSV0o2Kf91Fd6We1p7O2dMNOXUPZHQgW2+ZC/RJfunC2F7EQEfs5sSPDFgh9+3RNmMT8klGGzETOa+SilRm01AML43s/yr2pr1f3Ah+sK1FFr9MOyfuWZ1mpj36840fI1v0GqPNvqYhX05fyNKh/C/qGSlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfhxrGBwWVjBRpTWPvTDeGMy4MeU7AL3eb9qIv7riYw=;
 b=dfDqyw8PMLhgZeBKsS1rBju/5EMakKNWxprvTVgiaKW2YLuaub1OMwGYs5DRHK/fHUuX4mvmWTw6QldUfxyv2P0nrztgpjptwHDs6ovP+I/i+L/eoTuoVSj0NB2oF+HplpW3gB8/HEsGU66WUhrkbnzaZF6/OHBgHEy9KxQF6SU=
Received: from MN2PR07MB6208.namprd07.prod.outlook.com (2603:10b6:208:111::32)
 by MN2PR07MB6014.namprd07.prod.outlook.com (2603:10b6:208:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 21 Oct
 2021 10:18:20 +0000
Received: from MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::f4cf:ee63:9681:a238]) by MN2PR07MB6208.namprd07.prod.outlook.com
 ([fe80::f4cf:ee63:9681:a238%3]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 10:18:20 +0000
From:   Tom Joseph <tjoseph@cadence.com>
To:     Li Chen <lchen@ambarella.com>, Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: cadence: Add missing return in
 cdns_plat_pcie_probe()
Thread-Topic: [PATCH v2] PCI: cadence: Add missing return in
 cdns_plat_pcie_probe()
Thread-Index: AdfGJXsneGNhzEUJSnSJFpIT3qRvIQAOh/JQ
Date:   Thu, 21 Oct 2021 10:18:20 +0000
Message-ID: <MN2PR07MB6208A13335A5C2458E8DDBE3A1BF9@MN2PR07MB6208.namprd07.prod.outlook.com>
References: <DM6PR19MB40271B93057D949310F0B0EDA0BF9@DM6PR19MB4027.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB40271B93057D949310F0B0EDA0BF9@DM6PR19MB4027.namprd19.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGpvc2VwaFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTM0Y2Q3YzQ2LTMyNTgtMTFlYy04OTVmLTUwN2I5ZDg0NGVhMlxhbWUtdGVzdFwzNGNkN2M0Ny0zMjU4LTExZWMtODk1Zi01MDdiOWQ4NDRlYTJib2R5LnR4dCIgc3o9Ijg2OSIgdD0iMTMyNzkyODUwOTc2NTA0MjE4IiBoPSJYb2tOU0U5TEdDTjZ3WElZaVpza1ZUaVZqNzQ9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ambarella.com; dkim=none (message not signed)
 header.d=none;ambarella.com; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15916d09-9d68-4c89-e4e4-08d9947c1b37
x-ms-traffictypediagnostic: MN2PR07MB6014:
x-microsoft-antispam-prvs: <MN2PR07MB6014D8456FF1F085CE8857AEA1BF9@MN2PR07MB6014.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: itUEgKQ5vkMGk2clrTD+UzoPcUx+V+r1avtAAjVZHlXZUkxh0lqR0DaReBkPYaAV8/ElT7d6h1itf4jVoHgMD3nI3fLQZ/+8tT1/0oqJ1uR9ChDF7XboGL9Ll2f0vdUQufHUi1aekmksXOx+ExB4e2vE7ryXanzqMmTD29w8kmP2q6ya8i9cbJmNz4FMBNNlYCHxwksQ63I8/eTZsWjtBp/jB6gpKRZ9y1FHZJqJDtXRO5HfPytFsCLeo0SthrBEj5cRCA9iYKU3dRr/om9N+0bX2PMqyb6Qk7sv3zUQ/S0mMYA2/W1ySqTwBsU4LHJr5npeiQxOQVXhwErbJvUXKzmvra+akF4B6muMldTBVql7g0ZtzgGR9ec9cphDF73MqMAlnaS2nf9SrZTg96GHtzI97Unubpx2rwztfe0ZW99DqrRaFLm4MGKBItotwpaE9aJXFDtiXLb1KdrTuUc1Vfa2VWxprrKPkhZGUcbL5lkBjmtYNPSXIE/mhDx6v2oFVCkPTE4Z5yHlnjWmRFgbp+9uQuHKSkNMiuADvUDcjGEcXQRoS8LNSxSUXt/rRbUz6wKYuudQQK2OqbFiTFMSK55VHF0CCxDBFKfQL6pvKkKTI0P4EKxbnALamcFt1hhyYalyXAZdJUBc5ASwbt0BzPfeh6bBNn1PyryPo87EZP2/hOpCIR4PytrxyhrrcziZawXvSGboRwcHPiQuPyQmdcmrn5Kr2GVfefElWRHnn32fb7KCNQg06aitCC7loq1D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6208.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(76116006)(186003)(86362001)(8936002)(6506007)(66476007)(64756008)(38100700002)(110136005)(4326008)(8676002)(33656002)(55016002)(66446008)(53546011)(9686003)(5660300002)(316002)(83380400001)(2906002)(122000001)(52536014)(7696005)(66556008)(508600001)(26005)(66946007)(54906003)(71200400001)(38070700005)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+S/8MZma1/4toiNbwQMEHPwgrVzAuVHXYwe0NX8u7vCc261MJmLkpvIHVvRX?=
 =?us-ascii?Q?NgaW4IA4aeKXTa2su1BQshlOiE7UHOc9lxxc14Wme3cLwMxUTt5iaBggIqCl?=
 =?us-ascii?Q?Hah0EHbH5CKfmcacaKsaJFZ+PVWzNwQCKvN+i/eR1gS7B84Dwq41o+aCNMpq?=
 =?us-ascii?Q?DlD6JtwXIarpG86SC49z01qoOBm3t/u6vw9uIBrhnjEP6JmSTUhlQrARnvzP?=
 =?us-ascii?Q?4OQr3AR2hMa4PSmPeqf2sUASA0X9NWr2CPDu95pDjdQNmD9KhdEx0jDieVe/?=
 =?us-ascii?Q?3P/BBtteHXj8n3ra27fHr35zIAhItfT7MTPtO99I/1bjOeIDaq8mrTzzZ0yK?=
 =?us-ascii?Q?0HLz0yJ8hedW//b7Pp3ye6FAw8xot4+eO8fuBfSf4SdEkg0ubUqftyWC/BG2?=
 =?us-ascii?Q?asQrtvif/NTThUTam4lO5x5z4QbJzcR6OWO+nSyYMkqV8WpTC8kMtb7opIMo?=
 =?us-ascii?Q?BCm6/6sh7o3iCMDWwZvojSvYrltWlzl4wJ5mutk2j/XNlm/pXbGyq+RcUun3?=
 =?us-ascii?Q?6ZtKKX5tLzZUo5xf0K4y7BSgaJeeNuJtunXz92JQeNcEN/FORqatGK/gsdX1?=
 =?us-ascii?Q?JIfRhgAUbyHsZfmB5JEDwATe77+en/4QpSgoHazeSnNFZ9GgheUfG8F4c/bB?=
 =?us-ascii?Q?asCwc8KiOvibc4Zrc947OXQwPO1LIlveqtOvoDfg6PTqjbAqtklT/rXI+7U+?=
 =?us-ascii?Q?W6di5QjlKaCQ0k93+9sj8yieWtGKjlbmj8GgazWPOhRUXNaidSKUNVZIViIk?=
 =?us-ascii?Q?nGBrEUxNg3u7yn7erD4cjwFnDNmxn/ZdYot3y3N2VBc4Bflh19oQwnmrUY1i?=
 =?us-ascii?Q?rVnqwNgVEfPvC98v0p0+TVx3758jPg/U2yyolABITmHrZtM+0ql6QrNLq3XN?=
 =?us-ascii?Q?Jr11Cy6wtxUI/nzI3KFQHlm6h8DOksi+4YLSUmTdnpM8AlrOOKK1pSbtSU5N?=
 =?us-ascii?Q?o51cVPgmT8vD7b84nhhGfH4RjuhKkmpPmQsmVrOhByE8idcxcwSZxDvbVJR6?=
 =?us-ascii?Q?c++3CVjjkLUUbrP7Q2ttTuWeqIR+FVZ/0Wpl0lZeue0ZPMBW3vUKU2PS71Jc?=
 =?us-ascii?Q?1ST3IZx/HfjOlQokv8qBR+nT2cNvfZuJILb7a4fDSmDPv/BOrtvytLNsfmf6?=
 =?us-ascii?Q?fXWpL+Mv4BwZ+vfZ90bRDZz/MQvxuHIu5ATbJ31weQjPRh1oG80Luntq2z+k?=
 =?us-ascii?Q?8wqnjnNiC9MW3QAeE4RdgTs5OWADtFEDgjVlh+8UEHO75wTW4UHSJAqpWua+?=
 =?us-ascii?Q?DKKVdnStxL3OcPvp7kEPhgQX0gy+dYl1obZ4jXaM9My+5bH/pRySHUugHpEF?=
 =?us-ascii?Q?wCZIdXPS5hK9jRh9UWtUL6Fv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6208.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15916d09-9d68-4c89-e4e4-08d9947c1b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 10:18:20.2779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjoseph@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6014
X-Proofpoint-GUID: Q3NO_HN6KWa_co8MuGVbaOYkxHNuAO0D
X-Proofpoint-ORIG-GUID: Q3NO_HN6KWa_co8MuGVbaOYkxHNuAO0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_02,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1011 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210053
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Li,

 Thanks a lot for the patch!!

> -----Original Message-----
> From: Li Chen <lchen@ambarella.com>
> Sent: 21 October 2021 03:50
> Subject: [PATCH v2] PCI: cadence: Add missing return in
> cdns_plat_pcie_probe()
>=20
> When cdns_plat_pcie_probe() succeeds, return success instead of
> falling into the error handling code.
>=20
> Signed-off-by: Xuliang Zhang <xlzhanga@ambarella.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core libr=
ary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Chen <lchen@ambarella.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-plat.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
Acked-by: Tom Joseph <tjoseph@cadence.com>
