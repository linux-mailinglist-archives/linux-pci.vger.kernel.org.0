Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F582EE669
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 20:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbhAGTzn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 14:55:43 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:10662 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726541AbhAGTzm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jan 2021 14:55:42 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 107Jn97Z031782;
        Thu, 7 Jan 2021 11:54:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=PhDO97Y0G7meDmao+AF0FphmPJFAq+ve7WNzQu1Sp9s=;
 b=oPEYgCFBBInOYOjDT9N62Mu+RLKRmnSVNknQyAJ3infWc7HdlgSXMfsEiYpusGrDz8AG
 8fEzZAClBO5cCuF8p5+yzxOF/ixfkxio3ocLvqlMLhtLfC8XwWiXhdJ272M4a0cVK51l
 gaXs+1NVt4aYk+DyiCh1x6pyz4AhpZpPow/1Xl82oOkegNMKM4mhhVkApzNHWUXsu30I
 f/Io5+ONugYW1x5gl8NsmWsenFMI/c+n58xZn0rlhebZ6zaTVfZ16lbTY4+tUYqfiMcR
 wIsHYtDCpQhzjsL+mg9GRw1bRwuwT9CBJBj85u4X+yt1kAf0DVy7uQjxEkA4gvMbIsHu UQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 35tna3h09d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 11:54:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvuXFzGb37e9d9kFdvCPNpMIy7Dja5oqY2nFrgoqiDg9pAc9Xj+ezjNJYKodJ11sxiyaXeXmnQ+uh1z0/8wqrIAwLPZy+wtut7EccKw6YrWjhJdJ7kVhRWKfwpDg2HsIdaFMnYFuGfITJ7dcP3buaYB7z9leQg1ya0ZiSr4Xd/Rai2ZJANSYT3BoHRnVfLtjpYirjW2A/mQICEr+K3qDpjavhLpfmY9eGE3NOQnqeJ3V1km7eFbruMMdyXsdso0meG3zuhZEgTriG90jKPLijfk4phe3QQRIUT2VKndv0om4RRnwLU1vBjNPtG6osr8BVD24Yvnqsv0DdIa9Pcyjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhDO97Y0G7meDmao+AF0FphmPJFAq+ve7WNzQu1Sp9s=;
 b=JSU24URgZGo8cLSeYnB8bRehvigoiZrE+EVfWB45OgsLBZwmZmXsWVH6IXgofJ8793QTJOFa3m4hdD+oAMBlFd7qa5hgDYwaP4fBEDZlGP4mzS44StoYMUjcKemF18urkV1NiSTMSX2W3T4w8x1N+JBW7rKs6l9mk68YZaq6FtpK8fTjUj/WvN64/+zyviuazJ95Qu3kIyG6dfIyhX1Y1J6T4MqOax0NJ1wBASq6zMCXje6EprUeCdVhtxUGLNkPIbyaqQ9SShkwbgqT9GqEmn/5+iiOduKh+/pTDW+pkOOAhxaCfA2f40J0jB+qjjMw2c8QrkDmmINFOkeKs3GOug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhDO97Y0G7meDmao+AF0FphmPJFAq+ve7WNzQu1Sp9s=;
 b=DEKBNWj1WOQAgL63r1kHgFAi0w+uJv/hr5iL7r79GuiTW6clqVHPgIChs8OGcjZkDCRHlLJgo4xJv/DRyR7T+1z8WX3kAYQAkGUDpjm18Vy645OLDm1qXx1ws8mbaSrdLm2RFQ4+iCRTwKtdC80xkwWAFlhy0AzWp+e/HvONmro=
Received: from SN2PR07MB2557.namprd07.prod.outlook.com (2603:10b6:804:12::9)
 by SN1PR07MB4014.namprd07.prod.outlook.com (2603:10b6:802:22::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Thu, 7 Jan
 2021 19:54:43 +0000
Received: from SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::e164:6aec:aed1:1e2a]) by SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::e164:6aec:aed1:1e2a%8]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 19:54:43 +0000
From:   Athani Nadeem Ladkhan <nadeem@cadence.com>
To:     Athani Nadeem Ladkhan <nadeem@cadence.com>,
        Tom Joseph <tjoseph@cadence.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Subject: RE: [PATCH v7 0/2] PCI: cadence: Retrain Link to work around Gen2
Thread-Topic: [PATCH v7 0/2] PCI: cadence: Retrain Link to work around Gen2
Thread-Index: AQHW3qQOEOO3xLnov0GUSEHX9bvYeqocoECg
Date:   Thu, 7 Jan 2021 19:54:42 +0000
Message-ID: <SN2PR07MB25579DFA16FFFEFB7B6F61B1D8AF0@SN2PR07MB2557.namprd07.prod.outlook.com>
References: <20201230120515.2348-1-nadeem@cadence.com>
In-Reply-To: <20201230120515.2348-1-nadeem@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmFkZWVtXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMmNkNzk0MzQtNTEyMi0xMWViLWFlOTMtZDQ4MWQ3OWExZmRlXGFtZS10ZXN0XDJjZDc5NDM2LTUxMjItMTFlYi1hZTkzLWQ0ODFkNzlhMWZkZWJvZHkudHh0IiBzej0iMjQzMiIgdD0iMTMyNTQ1MjI4Nzk4MTg1MTk2IiBoPSJWeTZpTmhKckxYZUd1QkFFWGZueENsd0pUcGs9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97507f53-84a1-4235-cc37-08d8b346139b
x-ms-traffictypediagnostic: SN1PR07MB4014:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR07MB4014FD47CB03BCFDA3676929D8AF0@SN1PR07MB4014.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /zFKKyJZ2IPIMeOJz6iuv4e0gMCoaxx53yPztLt6teC4oda66xgDju/nLNfqgYvE8Fo285Dy+sjzIR39RHndmcHol+ifUwspuYDa2qoPocWAR/9f9Ss1n3QawiP4DtHxRQgoQgp4Jc8S9HfUYb9Fw8h4sOA5TBEXg6C0NlO2r0f/+MgQU3hjJslMMz+7aagva/1+7DFObJAJ53grPUG/f0mBLvR1yEnZqXogPKj36pdMRBx2NujjN3z0ICoiCGziHnmPQdetXs7/ryp4Y999hWmrS7J5DVgQ2EfbjII7fKJhWjrep7LtKzwlJXwhJbwRcwR1CCXiFvCg0i65oemVn08c8R9IjIZS3xIrsgnR4YYmhI4sV5q34ZE+GqhUtldZjk1KJV+xSVBX1y1MqWir6TRaIFzssujp7BZ8QWdo6kdjvwIW6HjHTlo1cCSq9QVOLO+uyjFDMS+rw1lnQ7jTNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR07MB2557.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(36092001)(5660300002)(2906002)(107886003)(83380400001)(316002)(4326008)(86362001)(53546011)(110136005)(7696005)(33656002)(76116006)(921005)(71200400001)(186003)(66476007)(478600001)(9686003)(55016002)(8936002)(54906003)(26005)(52536014)(66446008)(8676002)(64756008)(66946007)(6506007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qFW9i55nZp7kWCNDyFpPPDzed2bUhj7Es+tDUCEH3OC3Ll1qyqupWGznweIl?=
 =?us-ascii?Q?alPTa86x/CfPmL20iMwVlWuER72JG1vagzN0HkVlDxAqOqUf2RrDoKDEYqo4?=
 =?us-ascii?Q?1RsbCEfIP7ArNW/9Ogwm+07yC8i93+u03l2167nJXGjkYJtGjCsCn8BXJ4MI?=
 =?us-ascii?Q?JU+hwj80RhZ29jtiK5NZ9XIdnj2h8e2VqaqiQjZgDdylhQkbw7NouyGXTiN5?=
 =?us-ascii?Q?ybFViFhBEzrfHtkPXLO4wA5d8hZU0GxqOy1RksZSfg9RGPEjVbtqgHSOblEd?=
 =?us-ascii?Q?M70/1g3YJzXfsVteu9uoxYJpzHehMYbCHiTjXar3JKDlD67KIXe97cNanf7E?=
 =?us-ascii?Q?vP6dYRigDntacxCfAYHLXES/cOYK3A6Kh0esGzCucRGx39saaEjHmwZ7wRul?=
 =?us-ascii?Q?h77ot7OMD7ksy2cXWEm9K2W5An2ARyzmQmRoSqbE1+GeCC5EWyfrFSZIPmSz?=
 =?us-ascii?Q?wtYYSWsK3iGirecl0o6kBEPkiabLSQnvo25/evhBec/YsySXMGsZpcjpwLCh?=
 =?us-ascii?Q?34+aYXaO7YpVKLW2N4pq7UH7rTBJztuCwxJ8Ko0aY7GH/ULQYQhQgs+mCm1C?=
 =?us-ascii?Q?h1fZLY5l+fkE/HiZMLHAErpxJAeMZq+0J+qokWviqgEkSdrmlX/NHcfY/r1J?=
 =?us-ascii?Q?ySnd19Pt8IWVqcd4RjQ+6M6KsHG4BSC2I5xDT8r64A8hZscFEQqMGD38x/kG?=
 =?us-ascii?Q?8ThQHS8y0DHC5gvvtC0+6npPGnXbEjqxemM4/8yNlwIqoPgVF6zK0ngfKItQ?=
 =?us-ascii?Q?aUjh9Q77SwrupkXf+hjsnOh45eesda3xDz7LxXmfIV2Qx2v9BRfQ0/dXWsws?=
 =?us-ascii?Q?NP0aP61815Er9hr2bbq9/e4jnmuEZ1dOuNpK16K95G5XWkagFmgIJzGTYT2p?=
 =?us-ascii?Q?OEOlXjPoevYbUTgcpDMmpcp6iOsMn5iZLuoEmv5Le+H/MzUb5fvqs9sEJXpL?=
 =?us-ascii?Q?l+ChXT3DysRRC2yoiKsMsfkaDHxFboWwWBgL5V3cae4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN2PR07MB2557.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97507f53-84a1-4235-cc37-08d8b346139b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 19:54:42.4558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufcgVIun8BGB8ZiZRgDt/Z4XXJH0MHzK9mPfVKWr5vEGXpTshPaFgcC0WVs+Z1XbH1Nbqvq3qjKCZoN7/5KaZPea0hVYRZRCo+Cgl7D3pxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB4014
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_08:2021-01-07,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011 adultscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070115
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

Requesting to provide review comments.

Thanks & Regards,
Nadeem Athani

> -----Original Message-----
> From: Nadeem Athani <nadeem@cadence.com>
> Sent: Wednesday, December 30, 2020 5:35 PM
> To: Tom Joseph <tjoseph@cadence.com>; lorenzo.pieralisi@arm.com;
> robh@kernel.org; bhelgaas@google.com; kishon@ti.com; linux-
> omap@vger.kernel.org; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: Athani Nadeem Ladkhan <nadeem@cadence.com>; Milind Parab
> <mparab@cadence.com>; Swapnil Kashinath Jakhade
> <sjakhade@cadence.com>; Parshuram Raju Thombare
> <pthombar@cadence.com>
> Subject: [PATCH v7 0/2] PCI: cadence: Retrain Link to work around Gen2
>=20
> Cadence controller will not initiate autonomous speed change if strapped =
as
> Gen2. The Retrain Link bit is set as quirk to enable this speed change.
> Adding a quirk flag for defective IP. In future IP revisions this will no=
t be
> applicable.
>=20
> Version history:
> Changes in v7:
> - Changing the commit title of patch 1 in this series.
> - Added a return value for function cdns_pcie_retrain().
> Changes in v6:
> - Move the position of function cdns_pcie_host_wait_for_link to remove
>   compilation error. No changes in code. Separate patch for this.
> Changes in v5:
> - Remove the compatible string based setting of quirk flag.
> - Removed additional Link Up Check
> - Removed quirk from pcie-cadence-plat.c and added in pci-j721e.c Changes
> in v4:
> - Added a quirk flag based on a new compatible string.
> - Change of api for link up: cdns_pcie_host_wait_for_link().
> Changes in v3:
> - To set retrain link bit,checking device capability & link status.
> - 32bit read in place of 8bit.
> - Minor correction in patch comment.
> - Change in variable & macro name.
> Changes in v2:
> - 16bit read in place of 8bit.
>=20
> Nadeem Athani (2):
>   PCI: cadence: Shifting of a function to support new code.
>   PCI: cadence: Retrain Link to work around Gen2 training defect.
>=20
>  drivers/pci/controller/cadence/pci-j721e.c         |  3 +
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 70 ++++++++++++++++=
-
> -----
>  drivers/pci/controller/cadence/pcie-cadence.h      | 11 +++-
>  3 files changed, 65 insertions(+), 19 deletions(-)
>=20
> --
> 2.15.0

