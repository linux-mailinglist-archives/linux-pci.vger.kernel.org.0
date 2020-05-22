Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BEB1DE970
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 16:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgEVOrF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 10:47:05 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:34828 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729903AbgEVOrF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 10:47:05 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5EDA3409CB;
        Fri, 22 May 2020 14:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1590158824; bh=hZiLvxHPd2qcD1P7mi8yKuWYEN0khP3JjcPkvU3kT0U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XL+6hm60slxCpjNort4fVsQrpkPDcube5MZuxA1H0PNgwmE/74AYUXej3DnJvUWLi
         a3n5g/08BIffVkfQq2tGFZSjybPFtgrPkKbIH9RIRK1K8WakNEg0lDyAK68RgTY18R
         JhNNAAGTzgBn90MGbEPCqU1pUHAEI+jUHJuL4VF27Oj8vFLW+lGxrXpE64GHIHxu6c
         hLW/z0CXKKzuazb13IvWaWaE8JtHmpO9UCye9NV4ljFpsfGB6IDsZhP5ch1zVzZUPv
         jXZJD0bVS1oGtejw5XcOuwWe9p9Tbrmi03zseuQLhE63E0vwxjbBeLdDg76mpogchg
         TFpUhcNHyBJPg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 40DABA0072;
        Fri, 22 May 2020 14:47:04 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 22 May 2020 07:46:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Fri, 22 May 2020 07:46:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpaB5cuN7zpieqIDiiplso5fA60awt89hLAbrEIKHMDSwHUO8xI4TbcN7fZgMPypdxnEvT+A7NArOPONz6UsBi61zsFFn6AJNkA4EqKc51sW7TWl68Qpg21JpyaXj0lhPqicunoqrQqG75+UBoWk+KjehMY/iP+7+OBmEoqWgVDhCsZP87Z9pByKnVyezP5ee+iCShyaQ/3oZk6ddVN/guDeoLNByHHytqtGogGRD0OIbaI2kXwyD8jfNEDGh1QTcz8vneegr9o6svYXtpffN1PN4aL74n6i/wgaDoimT16Z1ZRDMK+rrLsJmxTQszNtvXQ8QzskTM84bFgCsxGU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYXmnWBotbVXCdnFB1iJsStpVfGEZOYY1eQsi5crtmQ=;
 b=F9X9VsCxxQP3PBFhLrbNmf60TlSWtH9glqhLanFr4t5iTloaD5Gzuig4d9PmI9XJyM9Nl9tE6Ca0X7YA29hddBLFD3WcdQ6iJYmpaWDfBknodyB6ghaLld6ysxfrv/q+NnYH1gXF2sdfITuYFqfC/yZJHEPMHXdickbHA63HB9BBEX1nUSCdRrDMRPLyfn5FFBtaY20pBvNE9iqfGoRVWvWFcRqdrhHtoPIyvX7TG42nCsEXJ8Vy5N8Zexh9wGl1cG30STaOYLqFeSuO+LEVcO16WLWdBusrvRfkGbZ/yor/Al93JBNaA+oblrVRg8y4blGZy6vk5rAmDFtxQHsFXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYXmnWBotbVXCdnFB1iJsStpVfGEZOYY1eQsi5crtmQ=;
 b=M6d6bwECj0dCVnm/sERROxkMyuSG4f75A4UvmalBGEJe8DYDdnrEqear8l/GDzVXcQlHkJTh+4qXCH0OwxGqAJyfcFbjttIneE632hFlifubiQwl+x73XLzzcgr8YU/MOb37GsXo2awDpJ1fzRVeF5hPxs1XmXPT7oa2NmwRGN4=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR12MB2568.namprd12.prod.outlook.com (2603:10b6:4:b5::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.27; Fri, 22 May 2020 14:46:33 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::2062:f350:1cd1:1023]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::2062:f350:1cd1:1023%12]) with mapi id 15.20.3021.020; Fri, 22 May
 2020 14:46:33 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Aditya Paluri <Venkata.AdityaPaluri@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: RE: [PATCH] PCI/PTM: Fix PTM switch capability evaluation
Thread-Topic: [PATCH] PCI/PTM: Fix PTM switch capability evaluation
Thread-Index: AQHWL3UToL5zkhrPjEmaEQUXFwAcNaizA+6AgAEsHaA=
Date:   Fri, 22 May 2020 14:46:32 +0000
Message-ID: <DM5PR12MB1276AA9D6ED3B737DD6C9F70DAB40@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <0b974380436d46ab3d8b7f4988f17e6f822079ac.1590068178.git.gustavo.pimentel@synopsys.com>
 <20200521205013.GA1181279@bjorn-Precision-5520>
In-Reply-To: <20200521205013.GA1181279@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTA1MmJkYzFjLTljM2ItMTFlYS05OGI2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFwwNTJiZGMxZS05YzNiLTExZWEtOThiNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjUzMjUiIHQ9IjEzMjM0NjMyMzkwMjEy?=
 =?us-ascii?Q?NTA2MSIgaD0icGdhVWh5VGpyeXdYWm9LQUN2WDdiVGVuV1owPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFB?=
 =?us-ascii?Q?RjFJUEhSekRXQVQrOWgzNWk0WWZmUDcySGZtTGhoOThPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFFbU1la3dBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.7.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e24146f-14ac-4b75-9ea8-08d7fe5eeba9
x-ms-traffictypediagnostic: DM5PR12MB2568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2568272C5C99597A43B4235ADAB40@DM5PR12MB2568.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dLK/Fv9hOjI4KeKR40jYalyGl4NhQUYdZW0i8/gUT8QL5zI1NnzYa8LeGDJfC+yopia8n8p0dzWWFg++44U8dVr09PQMPzoegsaS/k0y9b2kKbpZKwLARdTnbpla4LKEsG/+84ICe65TPwLVXlhSk6xdMo2JlS77i77zPwmDzF7bUrbqTuq8JQCEIn5yJcmCSnxNI2fJKYO5//j9frdwVBvuDUlCLA05hnbYtdzYbOeeH60hrihXnj2ni+6qFVntxgVeRfy4Xm4hiuT7fdKD9uHCCRfU4KMTNyV8hbOv2KtuE+7ctG4Sc7zEEToE5GrV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(376002)(346002)(396003)(366004)(66946007)(9686003)(6916009)(76116006)(33656002)(8936002)(64756008)(66446008)(66556008)(5660300002)(55016002)(66476007)(478600001)(71200400001)(8676002)(2906002)(107886003)(52536014)(86362001)(4326008)(26005)(54906003)(6506007)(53546011)(7696005)(316002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SdrfQukhCqetQaYTGuIVVCREE7RXnBsIG+yp7kYp/Tx2Q7CKWKOeXYZz9KQ7kVXNr+wALKLqJr8WviLvGRwsNNy7YAsQSuOJDT1G1RmbT/7nosoL6syHlVV4X6cbQzXeV43lngjK12iERVJfPO+rcN3ZDPNJXK2LMOwNZ943YnDvTh0JlOog9t0QjFjcxuqJ31DrhAtAOKkW/iPxPMX5dw98ATFytWg3Uv7C7OFhML/vWxUXiwDqab1P0W7drmLrkoNuPSOXY8+JJY9eVL7Y5x+eTAGgUdnaN7D/3EJUBW9J9ZPmChCxZknhZqjnkzFmetz03VUd+X3O6bOEFrIrVsTrr9X6T6i29LrVh46ZpvPeM0Fule9TFuHHdy2qq1ODkGUChNp2KOBXBrtxtcvTndWK2z07lVdcJBc63/2VZpHl2QngZdzZutZb+Ucdkn/KbXSbR+O6bzBJ6S3IVpW024tco1phynIY5F9c2AVAVqc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e24146f-14ac-4b75-9ea8-08d7fe5eeba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 14:46:32.9207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRgWsAn7qVBFBK0mYmHxhZ71xitGC9DZZGJTqPSIv55lAexLF5wGs2ghmLdvh7wHhptMhnKoBklB2BVZ43IHtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2568
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 21:50:13, Bjorn Helgaas <helgaas@kernel.org>=20
wrote:

> On Thu, May 21, 2020 at 03:37:30PM +0200, Gustavo Pimentel wrote:
> > In order to enable PTM feature in a PCIe Endpoint, it is required to
> > enable this feature as well in all devices capable (if present) in the
> > datapath between the Root complex and the referred Endpoint e.g. PCIe
> > switches.
> >=20
> > RC <--> Switch (USP) <-> Switch (DSP) <-> EP
> >=20
> > According to PCIe specification Rev5 (6.22.3.2) and (7.9.16), in order
> > to enable this feature on a PTM capable switch, it's required to write =
a
> > enable bit in the switch upstream port (USP) control register, which af=
ter
> > that must respond to all PTM request messages received at any of its
> > downstream ports (DSP).
> >=20
> > The previous implementation verifies if the PCIe switch has the PTM
> > feature enabled on both streams ports (USP and DSP). Since the DSP
> > doesn't support PTM capability, the previous implementation doesn't
> > allow the PTM feature to be enabled in the Endpoint, the current patch
> > fixes this.
> >=20
> > Fixes: eec097d43100 ("PCI: Add pci_enable_ptm() for drivers to enable P=
TM on endpoints")
> > Signed-off-by: Aditya Paluri <venkata.adityapaluri@synopsys.com>
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: Joao Pinto <jpinto@synopsys.com>
>=20
> The existing code is definitely broken.  I would prefer to fix this on
> the enumeration side, as opposed to walking the tree at enable-time.
> Can you try the alternate patch below?

Ok, we have tested your patch and it's working.

-Gustavo

>=20
> Bjorn
>=20
> > ---
> >  drivers/pci/pcie/ptm.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > index 9361f3a..cd85d44 100644
> > --- a/drivers/pci/pcie/ptm.c
> > +++ b/drivers/pci/pcie/ptm.c
> > @@ -111,6 +111,14 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granul=
arity)
> >  	 */
> >  	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ENDPOINT) {
> >  		ups =3D pci_upstream_bridge(dev);
> > +		/*
> > +		 * Per PCIe r5.0, sec 7.9.16, the PTM capability is not
> > +		 * permitted in Switch Downstream Ports
> > +		 */
> > +		if (ups && ups->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE &&
> > +		    pci_pcie_type(ups) =3D=3D PCI_EXP_TYPE_DOWNSTREAM)
> > +			ups =3D pci_upstream_bridge(ups);
> > +
> >  		if (!ups || !ups->ptm_enabled)
> >  			return -EINVAL;
> > =20
>=20
> commit b9e92258d486 ("PCI/PTM: Inherit Switch Downstream Port PTM setting=
s from Upstream Port")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu May 21 15:40:07 2020 -0500
>=20
>     PCI/PTM: Inherit Switch Downstream Port PTM settings from Upstream Po=
rt
>    =20
>     Except for Endpoints, we enable PTM at enumeration-time.  Previously =
we did
>     not account for the fact that Switch Downstream Ports may not have a =
PTM
>     capability; their PTM behavior is controlled by the Upstream Port (PC=
Ie
>     r5.0, sec 7.9.16).  Since Downstream Ports don't have a PTM capabilit=
y, we
>     did not mark them as "ptm_enabled", which meant that pci_enable_ptm()=
 on an
>     Endpoint failed because there was no PTM path to it.
>    =20
>     Mark Downstream Ports as "ptm_enabled" if their Upstream Port has PTM
>     enabled.
>    =20
>     Fixes: eec097d43100 ("PCI: Add pci_enable_ptm() for drivers to enable=
 PTM on endpoints")
>     Reported-by: Aditya Paluri <Venkata.AdityaPaluri@synopsys.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 9361f3aa26ab..0c42573a66d8 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -39,10 +39,6 @@ void pci_ptm_init(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return;
> =20
> -	pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> -	if (!pos)
> -		return;
> -
>  	/*
>  	 * Enable PTM only on interior devices (root ports, switch ports,
>  	 * etc.) on the assumption that it causes no link traffic until an
> @@ -52,6 +48,23 @@ void pci_ptm_init(struct pci_dev *dev)
>  	     pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_END))
>  		return;
> =20
> +	/*
> +	 * Switch Downstream Ports may not have a PTM capability; their PTM
> +	 * behavior is controlled by the Upstream Port (PCIe r5.0, sec
> +	 * 7.9.16).
> +	 */
> +	ups =3D pci_upstream_bridge(dev);
> +	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM &&
> +	    ups && ups->ptm_enabled) {
> +		dev->ptm_granularity =3D ups->ptm_granularity;
> +		dev->ptm_enabled =3D 1;
> +		return;
> +	}
> +
> +	pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> +	if (!pos)
> +		return;
> +
>  	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
>  	local_clock =3D (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
> =20
> @@ -61,7 +74,6 @@ void pci_ptm_init(struct pci_dev *dev)
>  	 * the spec recommendation (PCIe r3.1, sec 7.32.3), select the
>  	 * furthest upstream Time Source as the PTM Root.
>  	 */
> -	ups =3D pci_upstream_bridge(dev);
>  	if (ups && ups->ptm_enabled) {
>  		ctrl =3D PCI_PTM_CTRL_ENABLE;
>  		if (ups->ptm_granularity =3D=3D 0)


