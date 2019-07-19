Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E76E342
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2019 11:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfGSJRz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jul 2019 05:17:55 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:45700 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbfGSJRy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jul 2019 05:17:54 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 334C3C120C;
        Fri, 19 Jul 2019 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563527874; bh=HH3y4NbmGqKeo8VKux5wiFHzmzM4+ArcZrm53piLQuY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WqcJU7qF7KTn1yDk2RibkbOrxWA/Css7AjPvHlIAdQOyGVEjl+3l9y1BSBxzmYjAH
         dMg4/fW9V7wDu7xcmYw3V/dvTWv5CEeokq3pgJfLnUUwIyKSktfzXOjSH1nMHu+4ps
         gQ311Sdzx+YAPdL5jT2mXsyJ+Td3lult8sA0l1BCfroUlnDXYu2n6DX9DxYi0JHe3j
         Tfbz7H7wg6+BGfIEZvo4AtvL02/9nqUekwP+ZiDZdMtrMqbl2jdGnYDqOBMkInnqPj
         cXZvUM56DFZ9KLujY0nea9C2MUBrE2bKrevdZQWp9otsG5Bk7DrIz8BS97R97cobtB
         vW67viIbnHbvQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8009BA0097;
        Fri, 19 Jul 2019 09:17:52 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 19 Jul 2019 02:17:23 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 19 Jul 2019 02:17:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+Zvtp80eJmh14/DjpUQ53atVy34w6K2HeaQjR1bYYw7aHvIe2yAx5Q2H++nifCwhfm0P6xKiUe9l6NDtrOsllDMoi+JjFKNga+C0MlRlCa9fBvSAlY8gXRwt0cOWLju1KNGfgD9FsYxdeSQ45/VTm4kbOQiAZ3VprgTvPccccC/qGF5mTb1a0HL/1BaxRGDmHcMwU60gidoeN51nGhkWOis5G2dqn35T3LE3FIAeD5aSEa4K3cLnqJYpim85m3wamgyUK9TwBrAGe01MioXJto9icILxTmcdgFdQbVWGYqmFStnrOiNSP/O8Tq3bgQMwUsJ9UYu0dQoLPeMABZQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvNA94e/08xcILh+KDiH+/f8U5iAk8PD/Uebyy1fHCk=;
 b=D0FWZ4vkHMPFsdV9Drfsb2VWd+Yf9kR84aPzXUTWHi/yBfp699XXjZf546H4oVVAsiE8HGa5mQS43zR8N3yGYUuvIQb1Go/VDN8JiLzH6NERbxcMJ+VUJN2bi7uZlCa6Cg7Zpf/sP+vwmr8TsDlWwAh2/scdBS5c2XQv5njlLSI2GgfRPUdC6DxF2gw3vBN/9s5rV7XMhySMIwFC77c3WZV1oYZyoadZdO6xSzG077lw6EjqY3QHkkJ5sFtt5blIGOyPqn0H/1T7Im0fsT3kRGtRIkCSyGZ/33kI6z+0lZ279QIRL4LsoI41G6HnxwZYUe0BZRdHToWsjArIpl0C9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvNA94e/08xcILh+KDiH+/f8U5iAk8PD/Uebyy1fHCk=;
 b=M4PYZJNmkB4Vu2U0ByYZK55wVMmihhJC1KCw66RymQgGScUbYl7SE56yzeACHyURbvHF5vV1UicAp9H4T0MSaqiQyaLb9ZUx9kDq4Nnl9TLQacm96ShP8PLnggDAKSM+84bA88POJ1i/yRizyRQfurySN8+QulwDrCkUC2C3HZc=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB3515.namprd12.prod.outlook.com (20.179.106.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Fri, 19 Jul 2019 09:17:21 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::2dc8:6bc4:3d9d:9203]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::2dc8:6bc4:3d9d:9203%4]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 09:17:21 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Jonathan Chocron <jonnyc@amazon.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <Gustavo.Pimentel@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "alisaidi@amazon.com" <alisaidi@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "barakw@amazon.com" <barakw@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>,
        "hhhawa@amazon.com" <hhhawa@amazon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 4/8] PCI: Add quirk to disable MSI-X support for
 Amazon's Annapurna Labs Root Port
Thread-Topic: [PATCH v2 4/8] PCI: Add quirk to disable MSI-X support for
 Amazon's Annapurna Labs Root Port
Thread-Index: AQHVPU3dR9uQZehrjUO2TSbxknslaabRqrNQ
Date:   Fri, 19 Jul 2019 09:17:21 +0000
Message-ID: <DM6PR12MB401060B62453CA171166FE64DACB0@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <20190718094531.21423-1-jonnyc@amazon.com>
 <20190718094531.21423-5-jonnyc@amazon.com>
In-Reply-To: <20190718094531.21423-5-jonnyc@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTAxNTczMjBkLWFhMDYtMTFlOS05ODhjLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFwwMTU3MzIwZi1hYTA2LTExZTktOTg4Yy1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjQxNDkiIHQ9IjEzMjA4MDAxNDM5MDY5?=
 =?us-ascii?Q?MzU3MSIgaD0iYU1uNjEvbktJZEt2aGVGdFEwa1NvRzRGL0lrPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?RGpxL0RFajdWQVIvRGw2Rkc5TDhnSDhPWG9VYjB2eUFPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFGdGJCcHdBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
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
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 510158f2-8166-4a3b-741e-08d70c29e7d9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR12MB3515;
x-ms-traffictypediagnostic: DM6PR12MB3515:
x-microsoft-antispam-prvs: <DM6PR12MB35152B7E281EA50E371BEB6FDACB0@DM6PR12MB3515.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(396003)(366004)(39860400002)(47630400002)(189003)(199004)(478600001)(14454004)(7696005)(76176011)(66946007)(229853002)(66476007)(66556008)(64756008)(99286004)(476003)(76116006)(5660300002)(25786009)(14444005)(256004)(7736002)(2501003)(66446008)(102836004)(186003)(33656002)(74316002)(8936002)(305945005)(81156014)(26005)(81166006)(446003)(66066001)(486006)(4326008)(11346002)(53546011)(6506007)(2201001)(7416002)(52536014)(9686003)(54906003)(110136005)(86362001)(6436002)(6116002)(8676002)(3846002)(316002)(68736007)(53936002)(2906002)(6246003)(55016002)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3515;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C83uJZlcUmhZKWuAqDEVIDURQgUVhiGGXtxJjoDsm/mCYA2tnHyAFiIuR5wcDgo20wX37wvzr22nhI42MexOtEmqG9pMAJzyzOcGy8fXeseHJKtbEMRDnnTI8tmnzNprtkTxergwg2i7CzMENJfFNQcIUElFIkAldA6lZh0rAmjJV3R+eP38jrkvLBOBKHPX91Uow63jCEom5bI0CeqjNoAtJSldBWQI8SXfOlzmNTW8q1VkoDjTpND+l55s+9q01gRBANZNF3HAkzdCasE6Qb9nu7seAvfRTse6vy4MT5uiieWEdU3dkFnWV7+GSwzpJ1CBNMaBjh6qY32ca735jafZTDz8TMadZS6u3kzCweWiPPtBjhClggW1jEEqOyqvhFtNn0dzZ0c9PlVoRVUxATZ+L7rs8pa1CMYZb/3qp4M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 510158f2-8166-4a3b-741e-08d70c29e7d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 09:17:21.7475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gustavo@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 18, 2019 at 10:45:27, Jonathan Chocron <jonnyc@amazon.com>=20
wrote:

> The Root Port (identified by [1c36:0032]) doesn't support MSI-X. On some
> platforms it is configured to not advertise the capability at all, while
> on others it (mistakenly) does. This causes a panic during
> initialization by the pcieport driver, since it tries to configure the
> MSI-X capability. Specifically, when trying to access the MSI-X table
> a "non-existing addr" exception occurs.
>=20
> Example stacktrace snippet:
>=20
> [    1.632363] SError Interrupt on CPU2, code 0xbf000000 -- SError
> [    1.632364] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc1-Jonny-=
14847-ge76f1d4a1828-dirty #33
> [    1.632365] Hardware name: Annapurna Labs Alpine V3 EVP (DT)
> [    1.632365] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    1.632366] pc : __pci_enable_msix_range+0x4e4/0x608
> [    1.632367] lr : __pci_enable_msix_range+0x498/0x608
> [    1.632367] sp : ffffff80117db700
> [    1.632368] x29: ffffff80117db700 x28: 0000000000000001
> [    1.632370] x27: 0000000000000001 x26: 0000000000000000
> [    1.632372] x25: ffffffd3e9d8c0b0 x24: 0000000000000000
> [    1.632373] x23: 0000000000000000 x22: 0000000000000000
> [    1.632375] x21: 0000000000000001 x20: 0000000000000000
> [    1.632376] x19: ffffffd3e9d8c000 x18: ffffffffffffffff
> [    1.632378] x17: 0000000000000000 x16: 0000000000000000
> [    1.632379] x15: ffffff80116496c8 x14: ffffffd3e9844503
> [    1.632380] x13: ffffffd3e9844502 x12: 0000000000000038
> [    1.632382] x11: ffffffffffffff00 x10: 0000000000000040
> [    1.632384] x9 : ffffff801165e270 x8 : ffffff801165e268
> [    1.632385] x7 : 0000000000000002 x6 : 00000000000000b2
> [    1.632387] x5 : ffffffd3e9d8c2c0 x4 : 0000000000000000
> [    1.632388] x3 : 0000000000000000 x2 : 0000000000000000
> [    1.632390] x1 : 0000000000000000 x0 : ffffffd3e9844680
> [    1.632392] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    1.632393] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc1-Jonny-=
14847-ge76f1d4a1828-dirty #33
> [    1.632394] Hardware name: Annapurna Labs Alpine V3 EVP (DT)
> [    1.632394] Call trace:
> [    1.632395]  dump_backtrace+0x0/0x140
> [    1.632395]  show_stack+0x14/0x20
> [    1.632396]  dump_stack+0xa8/0xcc
> [    1.632396]  panic+0x140/0x334
> [    1.632397]  nmi_panic+0x6c/0x70
> [    1.632398]  arm64_serror_panic+0x74/0x88
> [    1.632398]  __pte_error+0x0/0x28
> [    1.632399]  el1_error+0x84/0xf8
> [    1.632400]  __pci_enable_msix_range+0x4e4/0x608
> [    1.632400]  pci_alloc_irq_vectors_affinity+0xdc/0x150
> [    1.632401]  pcie_port_device_register+0x2b8/0x4e0
> [    1.632402]  pcie_portdrv_probe+0x34/0xf0
>=20
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> ---
>  drivers/pci/quirks.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 23672680dba7..11f843aa96b3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2925,6 +2925,21 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x=
10a1,
>  			quirk_msi_intx_disable_qca_bug);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0xe091,
>  			quirk_msi_intx_disable_qca_bug);
> +
> +/*
> + * Amazon's Annapurna Labs 1c36:0031 Root Ports don't support MSI-X, so =
it
> + * should be disabled on platforms where the device (mistakenly) adverti=
ses it.
> + *
> + * The 0031 device id is reused for other non Root Port device types,
> + * therefore the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
> + */
> +static void quirk_al_msi_disable(struct pci_dev *dev)
> +{
> +	dev->no_msi =3D 1;
> +	pci_warn(dev, "Disabling MSI-X\n");
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x003=
1,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_al_msi_disable);
>  #endif /* CONFIG_PCI_MSI */
> =20
>  /*
> --=20
> 2.17.1


Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


