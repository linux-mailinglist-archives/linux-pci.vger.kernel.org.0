Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6275F16A3DD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 11:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgBXK06 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 05:26:58 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:64244 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgBXK06 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 05:26:58 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01OAPHMM024077;
        Mon, 24 Feb 2020 02:26:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=rwyTeoFkSkKpb+yKNfh1/RiEe4+6DwPvTwU2MpxR9iA=;
 b=u+9JZhJN+h4Q8xgh0Ppcfz8wMk9awqIykm52eS39pUjdM6OGLuJZRlLwCp4OfVVOjU9y
 TTC8XME3VuQscWYumkRAx7GFuD2LmHRFV+Tv+BW2ZZMwQJeWm0U0m8oFwPVFg2NiV837
 iWtHMRhKUzS6gzvHCwURUbn2eGLBXIIR87znz9qPe1l/CxpHOfW/f+tn8jGpHX0I1UL8
 LHmf1Y6Impqjhiq+i424a9YzJHdq8k6dbN0FIQIEso0KtEnaBPDEzg/AZ7l4w+BGmsRW
 tMlujdJre/cDHFLfY9pOPGX6mUnXonwvEbuj7PRpVipTmhTIP4LtOfsRuo3RGebj22zu JA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yb4pt5sdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Feb 2020 02:26:42 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 Feb
 2020 02:26:40 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.50) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 24 Feb 2020 02:26:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKZmgrzdKKDrSo+oMtMJD37rVixhcpcL1XGpBjIVa8oo5XYnmeED6FvoujDTfPrxwRBCCs7mm8dbDfw2k+6mfbTEOk51OdElmYf7TMRYiQln7SslycrOsv19/N22tnFYv736WWEyyjidLYG1D39Q7BgRil2VuqA3+YuoPoLMJxxFIcQsYZdw2UX7GQOado4oiYv7q9fJNu7lqrQVUNGDLdHy/yrenwE8w8hPIv4e08UFXiCU4pWHiFlF0fQiw8k8y2v9aXWc6s8k6zeXmBs4Bzn/TzW5tCY1cYXjyAH73tbfk+cRiq6PmWmOacB6AEbX5FjwFJeX0pIRg5GXPwMhdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwyTeoFkSkKpb+yKNfh1/RiEe4+6DwPvTwU2MpxR9iA=;
 b=G4f+8gorMmb54ftcgD/SpHYaa0ygGrae5HQRZpX1ete94mSywwL00Z0v1Oocki8bDXkKVJuZRBrKsPY/+VQx/D7BLxrvekVKmtyTLGfoeg3c1Xou4S3R/YKRUfx1HgMhECfFwvJXBDXBZqPq3hrb0cBbn+tOxqkzIGqxaAhuF1ChdKcZK0DmJDql+Pl71AbVeaebBa3L8t25UM9IDk/y0G3blmHcrKu0SAD8F3aB8w8Alz7FnHVsmJnQo96bDtxmdAdEPF1EPaY1aLUmoxNymyYlrC8rpP1gdrq2NiXlkynkXhBI6vXFN5HNCb+oLIIp4p+wcPSpy5aylQmWHa6xQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwyTeoFkSkKpb+yKNfh1/RiEe4+6DwPvTwU2MpxR9iA=;
 b=OGCdSJgTt1xBjNlJutWKR24ZBTW4VhT5ULs9vaQybDwiXhiy48gN7+RKlsRw3FSFYv9bbVfJdlxHovWBQBS8uJyw4aubKcsGmWP75sF6Q3K/Mia2v0HRV+jgSQXrEZjGpMjFrzLWxpyl691bpp7dJ8glySMRo6i+R/xANF1wBWQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB3248.namprd18.prod.outlook.com (2603:10b6:208:16c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 10:26:39 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 10:26:39 +0000
Date:   Mon, 24 Feb 2020 11:26:31 +0100
From:   Robert Richter <rrichter@marvell.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Joe Perches <joe@perches.com>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: clean up PCIE DRIVER FOR CAVIUM THUNDERX
Message-ID: <20200224102631.c5yluo6u5ipghyz4@rric.localdomain>
References: <20200223090950.5259-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223090950.5259-1-lukas.bulwahn@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR0902CA0016.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::26) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0902CA0016.eurprd09.prod.outlook.com (2603:10a6:3:e5::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 10:26:36 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbc2b49a-9060-40e0-740b-08d7b9140850
X-MS-TrafficTypeDiagnostic: MN2PR18MB3248:
X-Microsoft-Antispam-PRVS: <MN2PR18MB3248FD63358A92416E31E6CAD9EC0@MN2PR18MB3248.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(189003)(4744005)(53546011)(6506007)(86362001)(54906003)(8936002)(6666004)(478600001)(81156014)(4326008)(6916009)(8676002)(7416002)(81166006)(16526019)(52116002)(7696005)(66476007)(26005)(186003)(5660300002)(66556008)(1076003)(956004)(316002)(55016002)(9686003)(66946007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3248;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcbjnANNbe0y6EasU91hh4AToRZy1Kr4obBDFIFtjC5fgqSJ0DliaEsA4jfoBbkuywXgagXshvcx0Ra5jPlpbwAIK82KBBYvv8h9JHnlmJSkqxmi/s7Lxs+QI0ZS1kOmwoO1cgbMTJ7lATgaZvKZEU2ygOdMYVjiW05iaWli6p2dX/Y96Tse6trWbyaeVAKiysThasjEtLQEoc/uLA1+KCIuyX9Szk7qhQA+kmFOCjx6dvgLNO96z2aLHohsDKXbDebRbm0vendvxyv7K+L4e3WZxqk2osAKwsVfeTTIKCfLux5oBg0vO4Cvx+Tbt08YANBSwrVrATyUD5j926RSC56GOPEzPtiyybTZoSPgDlHoIq+N1IGRNNlB1F+KeocXm84l9VZfe9AvLDLX8G+ovVL5p2MhwLwwIC0ssuwTbGKdgAzCTBLFEjd+aiR7FHTs
X-MS-Exchange-AntiSpam-MessageData: ENropoDvTVnM2vdcYAZvvhbbRvlGYTptLW8l2VhabOEdyyHmejlcWEV7RrMlRjepzJDNnO5EJpxOUu6zxJkkECmAZ7AHiRy95pYTasMAjNt3kxQRPH54DmqsJKUajTrEVRXm11xjCrqM7M7cyd331A==
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc2b49a-9060-40e0-740b-08d7b9140850
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 10:26:38.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ha3TaM+RftgQJenvcs4eFrBVsK0SJulT4trcZSzEepBA4KslhOueJ6z3ni0W824/CC//r416bhdoTE+x8XaXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3248
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_02:2020-02-21,2020-02-24 signatures=0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

On 23.02.20 10:09:50, Lukas Bulwahn wrote:
> Commit e1ac611f57c9 ("dt-bindings: PCI: Convert generic host binding to
> DT schema") combines all information from pci-thunder-{pem,ecam}.txt
> into host-generic-pci.yaml, and deleted the two files in
> Documentation/devicetree/bindings/pci/.
> 
> Since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>   no file matches F: Documentation/devicetree/bindings/pci/pci-thunder-*
> 
> As the PCIE DRIVER FOR CAVIUM THUNDERX-relevant information is only a
> small part of the host-generic-pci.yaml, do not add this file to the
> PCIE DRIVER FOR CAVIUM THUNDERX entry, and only drop the reference to
> the removed files.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Robert Richter <rrichter@marvell.com>

> ---
> Robert, are you still the maintainer of this driver?

Sure. I inherited the driver a couple of months ago from David who is
no longer at Cavium/ Marvell.

Thanks,

-Robert
