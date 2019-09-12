Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22ADAB0DD0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 13:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfILLbI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 07:31:08 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:49570 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731146AbfILLbI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 07:31:08 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1471DC5658;
        Thu, 12 Sep 2019 11:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1568287867; bh=I8Xx9CRqU8YvddOwOhYEVcl5oSbTLUa598gaCoE4Xo0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iTw+DPJxBu+ahsYfpJgbqV9B9BTgEFYkFFly+i71VrHV3Gw8KasWKzIaMJDnKg9fW
         /k9e/IzXzWfK+XHmimt+mZp6pJOn6aV2G7lTG1vcHfcsYweRWMrq4JkiG+1GhOkAm2
         sLb88SxsV0Nl+qu6hVwassObW7Eh9njDb7I39trMyXqk/hyM/BmjAtLEalwoXkGjz5
         hsSE2phmHHArIrxJcYw8JXHIynMct/tcbOS1jiuL1Mog5jg2Q0qN0CqZS3g7R8X876
         qbyeD3ziEfwraWrU8YJUsOSgPRkXvOskNqw8kpyOdtdMksqwCLukk3KR1v6H0o058P
         VqPJlU1QtHlew==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 97434A0066;
        Thu, 12 Sep 2019 11:31:06 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 12 Sep 2019 04:31:06 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 12 Sep 2019 04:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P56tQjVuBYE5dPxndMFBDPNxXkQui5PY08s15pvJ0QXojbSxHmHttB/DlrlRoQE/5YIiujvNJ3m56ixIdv4l95DC/00CnpO0SNjszC1u7Sdo8x32y2XFTIzqKkn+5bKwjjlq2EtxSlmDA6fhgK4cez5Pogwo1QGhD5uA8iUv4ukadHZz6utNoXn3rouf1X5sT3lVw0FVoJO6RixMyVrxmoo286FAlmUlF3qLDePchkZ9GjlrPcTTqwFCEbaFJ5uaJb3yD0LgfPorcDQCwlq1KLPlSu7pfRoFqRkICHPdfsdyW99G56RAmQObr5V8lvrh56yufDwgdFlhnqYRYi9NHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eRgtaeh5IyE2/DMu0xADplFfEnktFI3MRzO3rzCR+w=;
 b=d0HEv519Wze9B5GqN/RO4zm3AsyMWTIF3XW3nnNkE3DYgkBLpDwzW4c4/OX7urucph9tkNwurM3fV6Q0y1cinYUbcM0Ultniz6WBywKjfuy9Yz0DZftoQ3WR/r5Ag3YyAv+2xI73RlRDj1AliovVYqf1oGzwLBzMFT80dbkAEwFRB1LcLsPlm5MxVVZ3Q6qekDCP8NKLSHLD4MuDok/bWU2jNMO7MLljoXs8Tuw1xOWSc7SejjfYx9DqOglpIB2FIml35gLEpzXoCUbhQInNWBtnCOP/vUjOQ1qnm9Wt4tw7buuiMhpGD1GYYP4Dw9wa4xpWTt1INyClZjDQFeV6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eRgtaeh5IyE2/DMu0xADplFfEnktFI3MRzO3rzCR+w=;
 b=eEoVriCdHXwFemtGkR1gq+uykIFzqYLJwulEV9C9EYCJyp73t5zg3EWfgqutud96mEorYXDO76+dLGX26GPh+cSIrzF6IXiI45Lh377cCLvBrCeS+0B01wgOMXIe3ZEIddGhYGCdk3ljGop+P2NcQwnsiGhTb70R4a/pCqQ0LfY=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB2683.namprd12.prod.outlook.com (20.176.116.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Thu, 12 Sep 2019 11:31:04 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::dd4:2e5:e564:8684]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::dd4:2e5:e564:8684%5]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 11:31:04 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: dwc: fix find_next_bit() usage
Thread-Topic: [PATCH] PCI: dwc: fix find_next_bit() usage
Thread-Index: AQHVYzr9o4q4N44vQkaJ+DLOPrHWPqcn9EzA
Date:   Thu, 12 Sep 2019 11:31:03 +0000
Message-ID: <DM6PR12MB4010586571FF5CE3BCEFA3DDDAB00@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <20190904160339.2800-1-niklas.cassel@linaro.org>
In-Reply-To: <20190904160339.2800-1-niklas.cassel@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWNiODdkOTRlLWQ1NTAtMTFlOS05ODhmLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxjYjg3ZDk1MC1kNTUwLTExZTktOTg4Zi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjIxOTYiIHQ9IjEzMjEyNzYxNDYxMDQw?=
 =?us-ascii?Q?Nzk2MiIgaD0iV2dUS3p1cXgzU3lyQ3pUOGVsck1rV1Znd2lzPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFB?=
 =?us-ascii?Q?YWd0K05YV25WQWQrdGs1TVVsWk1hMzYyVGt4U1ZreG9PQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUEvSG9zaVFBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
 =?us-ascii?Q?QmhBRzRBWXdCbEFGOEFjQUJzQUdFQWJnQnVBR2tBYmdCbkFGOEFkd0JoQUhR?=
 =?us-ascii?Q?QVpRQnlBRzBBWVFCeUFHc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtBWHdC?=
 =?us-ascii?Q?d0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCbkFHWUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0Js?=
 =?us-ascii?Q?QUhJQWN3QmZBSE1BWVFCdEFITUFkUUJ1QUdjQVh3QmpBRzhBYmdCbUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhB?=
 =?us-ascii?Q?ZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QmhB?=
 =?us-ascii?Q?RzBBY3dCMUFHNEFad0JmQUhJQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?us-ascii?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6QUcwQWFRQmpBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJn?=
 =?us-ascii?Q?QmxBSElBY3dCZkFITUFkQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFH?=
 =?us-ascii?Q?OEFkUUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBZEFC?=
 =?us-ascii?Q?ekFHMEFZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhr?=
 =?us-ascii?Q?QVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QjFBRzBBWXdBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVp3QjBBSE1BWHdCd0FISUFid0JrQUhVQVl3QjBBRjhB?=
 =?us-ascii?Q?ZEFCeUFHRUFhUUJ1QUdrQWJnQm5BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6?=
 =?us-ascii?Q?QUdFQWJBQmxBSE1BWHdCaEFHTUFZd0J2QUhVQWJnQjBBRjhBY0FCc0FHRUFi?=
 =?us-ascii?Q?Z0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFZUUJzQUdVQWN3QmZB?=
 =?us-ascii?Q?SEVBZFFCdkFIUUFaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VBYmdCekFH?=
 =?us-ascii?Q?VUFYd0IwQUdVQWNnQnRBRjhBTVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QnpBRzRBY0FCekFGOEFiQUJwQUdNQVpRQnVBSE1BWlFCZkFIUUFaUUJ5QUcw?=
 =?us-ascii?Q?QVh3QnpBSFFBZFFCa0FHVUFiZ0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhZQVp3QmZBR3NBWlFC?=
 =?us-ascii?Q?NUFIY0Fid0J5QUdRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFBPSIvPjwvbWV0YT4=3D?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gustavo@synopsys.com; 
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64361937-5a0c-4465-3256-08d73774b22f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR12MB2683;
x-ms-traffictypediagnostic: DM6PR12MB2683:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2683FC817B5616CC8027CC76DAB00@DM6PR12MB2683.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39850400004)(366004)(396003)(136003)(199004)(189003)(66946007)(81156014)(3846002)(6116002)(25786009)(74316002)(2906002)(7736002)(66066001)(305945005)(99286004)(256004)(86362001)(54906003)(110136005)(486006)(11346002)(5660300002)(316002)(7696005)(4326008)(446003)(14454004)(476003)(6506007)(66446008)(55016002)(76176011)(6436002)(6246003)(229853002)(53546011)(52536014)(53936002)(8676002)(102836004)(26005)(6636002)(81166006)(33656002)(71190400001)(71200400001)(8936002)(478600001)(186003)(9686003)(64756008)(76116006)(66476007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB2683;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TLowhLnFj0nqjZdlMCr4ANVeGgtw543HesoWF4aFvwFsGJkpcepWdXZwJCarA5enr4/RCCHFRwStRuDutmxjD7BXPXV3MbrKS3LigXpmyWacp+1cOZ2p6KBMJRgLm2VmTgi31mpI0trYUe2PRd2ek4lL04bVWIgkbkGkudKNUCxwIcBPmLh9jAaTajMfjLStCdUSGhFWE/mduhWaG7FIMhQ9yTz3d3svp6KiE4KUyv6phLAUlQ2QsSW6z+nMOyQ7GGbWp80tzn4VdnE/3/b3CH41LDSPf1Lwgyih8UAeDg3uchORAX3uyHL59J1UoyP02smNr4dXTZ7LwTNV10CI1PzmivLrGRE5By836w6mt96AAjs1SJy7Nn70HeS8Yi4Hw72xVaBDEMllPiy12HP6oAnJFwTGwpkJzDg8ux7lHcY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 64361937-5a0c-4465-3256-08d73774b22f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 11:31:04.0016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Ou/fkExqu9E/TvTHUleeQzFIhQ3DGhyECtzFfMa05kTEB0PlHWKpA13hs3vBTftAD1FDpOXZeSJbMsvsELGcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2683
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 4, 2019 at 17:3:38, Niklas Cassel <niklas.cassel@linaro.org>=20
wrote:

> find_next_bit() takes a parameter of size long, and performs arithmetic
> that assumes that the argument is of size long.
>=20
> Therefore we cannot pass a u32, since this will cause find_next_bit()
> to read outside the stack buffer and will produce the following print:
> BUG: KASAN: stack-out-of-bounds in find_next_bit+0x38/0xb0
>=20
> Fixes: 1b497e6493c4 ("PCI: dwc: Fix uninitialized variable in dw_handle_m=
si_irq()")
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index d3156446ff27..45f21640c977 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -78,7 +78,8 @@ static struct msi_domain_info dw_pcie_msi_domain_info =
=3D {
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  {
>  	int i, pos, irq;
> -	u32 val, num_ctrls;
> +	unsigned long val;
> +	u32 status, num_ctrls;
>  	irqreturn_t ret =3D IRQ_NONE;
> =20
>  	num_ctrls =3D pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> @@ -86,14 +87,14 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  	for (i =3D 0; i < num_ctrls; i++) {
>  		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
>  					(i * MSI_REG_CTRL_BLOCK_SIZE),
> -				    4, &val);
> -		if (!val)
> +				    4, &status);
> +		if (!status)
>  			continue;
> =20
>  		ret =3D IRQ_HANDLED;
> +		val =3D status;
>  		pos =3D 0;
> -		while ((pos =3D find_next_bit((unsigned long *) &val,
> -					    MAX_MSI_IRQS_PER_CTRL,
> +		while ((pos =3D find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
>  					    pos)) !=3D MAX_MSI_IRQS_PER_CTRL) {
>  			irq =3D irq_find_mapping(pp->irq_domain,
>  					       (i * MAX_MSI_IRQS_PER_CTRL) +
> --=20
> 2.21.0

Hi Niklas!

The patch looks nice! Thanks!

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


