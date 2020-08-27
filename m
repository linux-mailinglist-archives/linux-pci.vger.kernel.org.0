Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0E254C62
	for <lists+linux-pci@lfdr.de>; Thu, 27 Aug 2020 19:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgH0Rt6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Aug 2020 13:49:58 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:11622 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbgH0Rt5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2020 13:49:57 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RHhOaW012008;
        Thu, 27 Aug 2020 13:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=8FtBnFzsCc542ZImAcZQiNSkKLCK4rEfUJRxSDulfHs=;
 b=jcEQ1ct1OZXd/7WEsdSMe4VQJ6uQRSBznhnygqqbb4NgMQNQfoPFblrTDq47tO4t1mZ2
 exXlkdLWyYMx8qe/8xfCEGaZVMSnVw0w1mNAN8OA7l48Ib7BP64J+WkrcOso5HZtx+qK
 7LvIXEP2brMGv9Ct6xHckNuL+svhP4hSChe5GXDHfN6wBz6cXWPav/1HwAErcCUl8TvQ
 8muA32NKu41PrwM8JkpOWhahefA69E2nNcNfxJV7JyhePRJJGfURU2aMXB7Dl+H0UGsP
 BcRdlejptfU4hoitLbTzT5Qi2z7/TRJMsCpf4pCIDgOUqQjOMGT9+fSI8shMIc4zLnqp hQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 332y6xbe8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 13:49:43 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RHiB8Q021877;
        Thu, 27 Aug 2020 13:49:42 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00154901.pphosted.com with ESMTP id 336bvdn8r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Aug 2020 13:49:42 -0400
Received: from m0134318.ppops.net (m0134318.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07RHj5bM023616;
        Thu, 27 Aug 2020 13:49:41 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-00154901.pphosted.com with ESMTP id 336bvdn8qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 13:49:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHAXtfE5sYV6yyMxja/uwfCsX6XpRnJuBwQGliedorcu0dsAYQP3vR8ZYyvHqSKHWTAl449WLqYDx1Cx0VAS5TTkaDX0VG7nOcq/0DRzSns7tY/f9ZkR2wzLx5jrT5O3bOXm9GHQEJC2ZvkSOcBtTx6ZU0VJhxZ+z1BTv/inFZbaA4qBN83zIRPW8pq32HQgwAf3sHX9iiEGKI89uhYUOvgYFzyxz2wxKwC+svX8ueMnrGvEvKB3A9N1FBW1SJZRs3DRQsMLSRcg6X0dFVVcR4RrnxW7bwAIT3wV8w6+AIQGFQMP7Y8MUvSCT7KwKKyNnOUNaYITw+jQZL/3EMq4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FtBnFzsCc542ZImAcZQiNSkKLCK4rEfUJRxSDulfHs=;
 b=LoJ2ts9SxR7+gMs+UXDEkQIu/mv4D94xMMV9ySTu+SFQ3Nln1j3kTt08UpkC30ixxzWAd6fu3CXYZTwT2yzsu0D6cFxmklxFDU0DOvI5ZwM77GwJMjGdpV16cUJAerrAipePE8oELgGTjoZV2HrJfqng9Ewe/NDof0Vh06HKsCY1Xx4p4DRuoWKGEjmczlq5+ToDjX8wSYbuLJVgrd51+5DkdzdPNLGLI49zkM06zctNYqB0WU6kwMwa/VopIG31tyxIdtnsjdXyzWEeuOG8lb7gt//xtvpSSS8knIJa+VT3gJqbwrXqvz1iCU79+CcGCwHGMuLKkjkPFda8TNBQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FtBnFzsCc542ZImAcZQiNSkKLCK4rEfUJRxSDulfHs=;
 b=CeOmMlx9A3nweuST7Dn51b3kjGYF4DKMaSVswGLfnYtP970Rk5i0NX6b/ETEjknNy8oCj1FHY0xnjmcXVzhixQyQedL9ulwGYzRBJtfWeZF4dEReYvkibAomTHFVcCyu2Cd+QuRB9nD2KwgY1P9CP/DoN1IT8ZYZqe1UZvwu1t4=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB3420.namprd19.prod.outlook.com (2603:10b6:5:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 17:49:40 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3326.021; Thu, 27 Aug 2020
 17:49:40 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>
CC:     "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "kw@linux.com" <kw@linux.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Huffman, Amber" <amber.huffman@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Thread-Topic: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Thread-Index: AQHWd7cqq6HMs1LBTUq6KKcYZd/puKlIYQUAgAKTaYCAAJRDAIAAofMAgAACvoCAABV5gA==
Date:   Thu, 27 Aug 2020 17:49:40 +0000
Message-ID: <DM6PR19MB2636ACECA16E43638B502A6DFA550@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
 <20200825062320.GA27116@infradead.org>
 <cd5aa2fef13f14b30c139d03d5256cf93c7195dc.camel@intel.com>
 <20200827063406.GA13738@infradead.org>
 <660c8671a51eec447dc7fab22bacbc9c600508d9.camel@intel.com>
 <20200827162333.GA6822@infradead.org>
In-Reply-To: <20200827162333.GA6822@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-08-27T17:49:39.0440399Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=78539c74-8619-4100-bb9b-67a55a9a2287;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [24.242.93.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b25f845c-6941-4321-3dd5-08d84ab192e1
x-ms-traffictypediagnostic: DM6PR19MB3420:
x-microsoft-antispam-prvs: <DM6PR19MB3420EE2BD490EE4F8D4E743CFA550@DM6PR19MB3420.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EEgOlH4mW0z9Uc7i1jKbFHYAWHAJduj387NwLc6qvlhmepZZcqyXS43R871cE2f+1Rkf1K+/wdJRA0L7YwuTmiEZFS1OxEgm2SFkoierOF8Jz0cqcdGTxxCTfF+3JTedK8qGQiLdYgnOpY/i0Ae/5vzd38lFCsg5nkTAbVbrq2bsq72kjBcJxuStgGVB5cItlIXjEQYb7a6Fl+7MWt93ofdjRiJBxolj67wWw6AZ8kVRawWD7mSX4fPqbLtISaqo3ZoYb4jd8+2LcpAtXNQGgeBGYDXZAwvekC3APmnMcTEhtEoWgX7CundrXQWTK1p6p7TNf7ZmxfJVu5F4EJPGtnzbJ+CmqDn+z+ZxQsuX9eyDiYoa+0wIRFK92c2L60MODfIRjX7GptzXUDDnQxSeJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(136003)(396003)(366004)(7416002)(33656002)(26005)(52536014)(186003)(71200400001)(4326008)(86362001)(316002)(966005)(64756008)(7696005)(66446008)(66556008)(6506007)(786003)(66476007)(8676002)(2906002)(54906003)(55016002)(478600001)(4744005)(66946007)(8936002)(5660300002)(110136005)(9686003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: CuHzT2xrJzAfY0KvzKsMEV6gpKnsB2mwY0IUvN17M53cSg2IeZ3NRKplaCFeyqsydicAnCiMgHhi5jWTC1/bO13AM5iGdTBkt/UiXLgceQsbNIpeDiD38mPFpd8B11FzMJOlJJgpf4h8ZIpSqo+09VgIV96ExK2oCtNIZgyaSALsLVHb93iASLivQvpBFaCfcKHBEftuW5IJn9ewqK83hFA+iKsn6TKGeSWbnjqFrS9KtvUbMc66fmEq2sDXN8jo4w+mp+1qYvmPVhPl92RTmrf+gKlDbmi8q6miBNKdb3JVmrEwo7ArlskNhlwxdZTGgVAeoJS7EglKEnM/G4nG3jBK1/hr0NKxKEjNIsSzJuc8bmFkhi65wbKnBRdFxVA0/XTLETzLlytae36xQdovZhuFWc3CAqXwkmD6hIF6PIpuLRPw4Wt0ZVSH7j3mZ8DR9agk0w1Bg62i3vdsA1UKO1N64h8WQCZ1QDuA12mxecZpFuYhQQa8+uTi4b0CCNzE+MasYCm7ZMF5+PpLVpyeJrNfgMqqYFCClmYJS3O0HzKgM70dAp8xxKt5WP/VtJ6IAdcpJSwOkcyVAQfrnelX/mpnytciT34TWNdbKz67aq0wEsUABJTTKSWuO4XFNz5Bw4aYGAt6VxFwj2U+gtEdcg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25f845c-6941-4321-3dd5-08d84ab192e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 17:49:40.5787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+oG/yH2aF+39LiL8voabkfEKl0PDlJHiphZlETZeZ6+uaoZ77MxxUqUzIawifCGb3bFiUquQ8NXJtxvYTav2+Q0nOuuLeRtEbx/GlUDIUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3420
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_09:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270132
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270133
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > I don't see the purpose of this line of discussion. VMD has been in the
> > kernel for 5 years. We are constantly working on better support.
>=20
> Please just work with the platform people to allow the host to disable
> VMD.  That is the only really useful value add here.

Can you further elaborate what exactly you're wanting here?  VMD enable/dis=
able
is something that is configured in firmware setup as the firmware does the =
early
configuration for the silicon related to it.  So it's up to the OEM whether=
 to
offer the knob to an end user.

At least for Dell this setting also does export to sysfs and can be turned =
on/off
around a reboot cycle via this: https://patchwork.kernel.org/patch/11693231=
/.

As was mentioned earlier in this thread VMD is likely to be defaulting to "=
on"
for many machines with the upcoming silicon.  Making it work well on Linux =
is
preferable to again having to change firmware settings between operating sy=
stems
like the NVME remapping thing from earlier silicon required.
