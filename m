Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690CF25F8D7
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 12:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgIGKvk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 06:51:40 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43092 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728406AbgIGKvj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Sep 2020 06:51:39 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087Ap0r5018829;
        Mon, 7 Sep 2020 03:51:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0220; bh=7BfysIuiW5N33FzqUqbIKPtJPqRnUgFhksM36AkjCVQ=;
 b=NGJY21ZutAlGvL1g+/dP9qqHw1gtpOKzl/Wmahd75ju4EyJMqll/vX6Ust88mL5jxqjC
 kJqXrwqlCx+hNh5z179AYDccMSjk+0PyXgC99dubSODDXX83S/7+u9Y9ZLIrqJcA3zvW
 U1CYMSrJYQjv+gc8ZOVpTFCDCXz7JxzWbTKJZn9hZWyAj4XDbjGJyTG1j5QrtWhcGmXI
 wS06JuVPzoGxHzeA0r+AkbrVdwHmry0L8IKBVjM7kXyj7kTAyD7MWewBrUIq5SQlGzfi
 Zff4TmhoDc9yP9hRp4NwOEohiy/z6xBL7QPNZlamq+FYhFJYyB0KANHBW5Og6l1YDeG+ 6Q== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 33c81pqn2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 03:51:24 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Sep
 2020 03:51:23 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Sep
 2020 03:51:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 7 Sep 2020 03:51:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jmautmb0DBhfLgrcEVnGyDCdFRTdNczTG2X2d8KySbF0xuhZW699F289KNdDrNjuq+B9+0ZoEPVPlu/G1afD7N3O/24aT9F0GFi1gbwcQD8rg/cQg1OqPXuyZhL2s4Q/QHVEzuoyQzWTqlt+eJ6uUw3et523nMvNg19ALr+AN+RdSaM6f5vB50OIKD/JDSYIKxIAJhhvZJ3KoBNyxnpK+6ozTy+5/dDaFUP0AQYCm8m7wXrra9U7UBrzld4UFJPmEbQtVM5hLu5hX9BxN3XleX+Gy0hwNlpquaCK7BD4rhVCZ3b0sxZ0zASS764gRuSUUjaomCz6utzI5hPWa3o6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BfysIuiW5N33FzqUqbIKPtJPqRnUgFhksM36AkjCVQ=;
 b=GgxA/GdU7oBJhV9lD4NO0nbOizvSEiHBqqQXyYT6jy+gh6FX16sUf4+sSHEo0xvU4UknrJ0Bfqgm4LbqmcO1pQ+iiOIEbHJsHQc42F1aBSvAWFwXOcQngHCo5FHwRYM/QEC6tQQ+ZPRg/sb0DA3rdFqAcaAmZfW2ms/QRxwqOi8Rl9YKvYa0DfYNM3mKTnRRsEOLuvLhQt9W1RoJfBft28h3xLl+4tXFlkwyUR3QTXYwKTOUZ8xJ1fHU8gElEe1SzKCTgmZiU5EwqSBUJnkEERapzsotVLbGF33KzYuSrnfzkUkfhpWAATZhNO5OkgN5bwo8YPFmw6LQaSCoyv+SWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BfysIuiW5N33FzqUqbIKPtJPqRnUgFhksM36AkjCVQ=;
 b=i/4z+lrgduHgQpexnrvvz9QaWyOsHY8xEzFwLFpkkWDDXFPs9mBbYoQh5cLezZ0oCIYoXKu2ZfFeN/lCINi3LhGYwwjvhMaoXZkef27sFxkqcuHV3A5B3FwqeI+CiyvY/w3Znwc/M1UZrQ2Bo23771iR42yCzlhwFRah6iYm2A0=
Received: from BYAPR18MB2679.namprd18.prod.outlook.com (2603:10b6:a03:13c::10)
 by BYAPR18MB2776.namprd18.prod.outlook.com (2603:10b6:a03:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 10:51:22 +0000
Received: from BYAPR18MB2679.namprd18.prod.outlook.com
 ([fe80::2ded:ad90:8fc1:5c9e]) by BYAPR18MB2679.namprd18.prod.outlook.com
 ([fe80::2ded:ad90:8fc1:5c9e%4]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 10:51:22 +0000
From:   George Cherian <gcherian@marvell.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Yang Yingliang <yangyingliang@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>
Subject: Re: [PATCH] arm64: PCI: fix memleak when calling pci_iomap/unmap()
Thread-Topic: [PATCH] arm64: PCI: fix memleak when calling pci_iomap/unmap()
Thread-Index: AdaFBDhPXXK6TjsQQ/qPAPTk6uGfWg==
Date:   Mon, 7 Sep 2020 10:51:21 +0000
Message-ID: <BYAPR18MB267959E6FE4BEF38D0A4611EC5280@BYAPR18MB2679.namprd18.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [49.207.215.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e35e3a9-dddc-4f4b-66dc-08d8531bf581
x-ms-traffictypediagnostic: BYAPR18MB2776:
x-microsoft-antispam-prvs: <BYAPR18MB277614144F3F79C9111F7CC9C5280@BYAPR18MB2776.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AEWdgB9fUwFKmRHSvP6rAraJmhKRsGC4PQDLUYW8lc+E2chL5MKdCzkSp6RZGlA+yga49pSRsXAKj1/+MacpkRv5cDjBo4+lUwVqlz1mjxd8evzfgJhdhXBnoarNESvdJyk/l9X3puAINlwwoqDv9EbtKKzZPRaiFEr2dpnL12gfAbM8FrXuRUzIe8bq4nlbVFyJQ+2t1pxetwskh7rZcFyozokV9f34j4wqjlIk8Kjpwi13tU20zVqXOLXmnbxHYiGhB8At80wLubyRY4vAPd9TtSa6W3KY5uKrjeF1KRUyOvOBnY5ppDgwAfR1vb+AIVBm4069tP0uyUi+nKQm2oxvx/kqjYuBfqWw7zL9gNwY75o8kSFEiDavL1CnwcxkCQCbJtutqIVUYw94iyXIHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2679.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39850400004)(136003)(366004)(396003)(33656002)(8676002)(55016002)(9686003)(54906003)(110136005)(6506007)(186003)(55236004)(478600001)(7696005)(53546011)(83380400001)(26005)(4326008)(966005)(316002)(52536014)(5660300002)(66446008)(66556008)(71200400001)(66946007)(8936002)(86362001)(2906002)(66476007)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bOP+kW2IpnhOApcjLNyEUHh1tSR+U60k5LA8zE6gE9+/4PhE0xWqjaox59rL3ZdTf/65omGTwZ/SZPAOpLqV72rzRFI+KusHDKAzLROFFuvDoa+EA0SEFrDH5CfpC89yGdcBGQnFSoAIFQD0lT+yhKEwZCQRga2Yr41R4Ism0tVdCMIy7dLJp1c7+1CZ8oem/Pua1NwYuTlyPWOnSMYxW3XXwNlmtiCq8F/8KnRoEFs4L34dH2oOkf35M3kd2GELEWpNrUswH/PxCV88W7SEYJZubuaqmshjgPohvbpn0G5oGYp7+StNnyikuVNYizeLwe6qjmb7r9clb24vVI1Lzj8zj3pRPsKyTt2NWUGR/qKRPTa7+OeIFI4kMbMeXHkPc49DjyTDGoA2WiosWq5AzD46Mnx/0R3EgbPyWfuE05dRNN+Z14BouZ54gJf4u+4EC5JFBi0fBbm/Fa/2aivtznKS+rivkgvqgQ+lJzagFwBNJFRrnmX8DstPytHD2hHnyp2OXgSsB3gtl8/wCjTJ+wXxQwQmu8akpWJQplsZ5+JFk5aLRSGXZAxPgifL4DFHHYMN36MCM8ojRdgqhzA97fl09PR+sOdbWiNYzTuIlenex2c0zaU6RYCta5lKD2tchn4z3xhq5qXi4LNBgUWoPg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB2679.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e35e3a9-dddc-4f4b-66dc-08d8531bf581
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 10:51:21.9956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqsHSiTfERIlUxA+JtHdfVwnG9CyNYni4MmO7l6yRjuofUv0Qy4t+F9su7nzzU7sTBDS3/jC4EcP3fuZgezvbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2776
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_04:2020-09-07,2020-09-07 signatures=0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Catalin Marinas <catalin.marinas@arm.com>
> Sent: Monday, September 7, 2020 4:16 PM
> To: Yang Yingliang <yangyingliang@huawei.com>
> Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; will.deacon@arm.com; bhelgaas@google.com;
> George Cherian <gcherian@marvell.com>; guohanjun@huawei.com
> Subject: Re: [PATCH] arm64: PCI: fix memleak when calling
> pci_iomap/unmap()
>=20
>=20
> ----------------------------------------------------------------------
> On Sat, Sep 05, 2020 at 10:48:11AM +0800, Yang Yingliang wrote:
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c index
> > 1006ed2d7c604..ddfa1c53def48 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -217,4 +217,9 @@ void pcibios_remove_bus(struct pci_bus *bus)
> >  	acpi_pci_remove_bus(bus);
> >  }
> >
> > +void pci_iounmap(struct pci_dev *dev, void __iomem *addr) {
> > +	iounmap(addr);
> > +}
> > +EXPORT_SYMBOL(pci_iounmap);
>=20
> So, what's wrong with the generic pci_iounmap() implementation?
> Shouldn't it call iounmap() already?
Since ARM64 selects CONFIG_GENERIC_PCI_IOMAP and not
CONFIG_GENERIC_IOMAP,  the pci_iounmap function is reduced to a NULL
function. Due to this, even the managed release variants or even the explic=
it
pci_iounmap calls doesn't really remove the mappings leading to leak.

-George
https://lkml.org/lkml/2020/8/20/28

>=20
> --
> Catalin
