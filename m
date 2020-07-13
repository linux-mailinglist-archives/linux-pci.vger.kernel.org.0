Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4877B21D7AA
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgGMN7p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:59:45 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59120 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729457AbgGMN7p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:59:45 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5E507C008D;
        Mon, 13 Jul 2020 13:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1594648784; bh=ZdQD2reGBwoVvm4LZ+4rURPKNKVpDDaiSYiWEnkqybM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GGBb/eszEZ6f5q1Rhlr1/s5aIrT0Kg7DCiPxia4jc2XRVb4Vnxu/86cSZPzk7jJhH
         9HPiF48kIh0WPw29hY7w34BZ82nZtYB0/MS5l4EyZ84WJv3HIS7nJ5IWxwUlyiDbQe
         N84oyKpGLuELAlKbRIdWODcfLMEzdLMcJ7tmGiocK9kJLPg7uL6BAS53UNGeUwlcPH
         uXDyn2fF5Un9YdplEbuBogR+wsiikY9qmpivL67kErzfn5L3USoPrhURlHW4jHeWI3
         UV9mJt6quQBZ2GxgooNpMWVjfFQHSFk7Dskqs8yICRUs21Q5p4SpPeQOMQfwbAHe1f
         vxNsaqA5MqcbA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7DEA2A0066;
        Mon, 13 Jul 2020 13:59:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1029680FAA;
        Mon, 13 Jul 2020 13:59:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="QxjDdwYf";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I27SvXUCzCRsPR2Ri5nK4w3Yo7dxFjXFuLU+YokBYHDJhxwyStDznzLq6HBY+ZScBpWg/73hEz/ymZYmMpqVJzKA6WURWkq5vmtZp2eUEUKYcAJmvTK3JAgNkU23h6vKzvIBmDk1h6xTH4Y+3a0KfodJRh3CmuMmnUHtSxrg2DQwmA15u9RN5oIcKy4M6gKJ0/sQW9d70QlmMGxUNUdiLNLASv71eUNUT4g0+3dKipG36rTwtusDoskWvqbHkZg8iRpl1wnwQfi5wypyZ4XiKG0jiISuwiuelJgZFCn2fw7xsz+pyMwoSqOVBMccZR09NJdbzDCRC1ylm4oBfJjR8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHZpWKpZPBc2ens3iN4C17LgD+OlD6MjveOnQCh3Hdk=;
 b=iZtkob7D5Zf+lUSirIScdS8Z8yVQNS+4seKgU1Ne74sV5s/j89wiyBiRf/MhMmqPNVWtUdijobEmo/a/RuDwb64KLA9BMU65a9zKKjOL0TUoNHi69KLCUogr1iIkGcYNRphVWnhQV4jC8IGbXpLydMnfdJUXa/f+DNEodRMktV5BRhYEGcRGVV/o0vACv9tttQIDGJXANH/MbSi+QGeqKIYpFpvejyxzACXjugajtxsEFdZA1P89iieWrWEeYxbWpJk3/q5ucjcQdQYfcU881TdovPkm/FXmOhbRafxdoE0NBeco9XTXqW9KPPSeRQobw1Zt2LelY2IklwIi2Kyseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHZpWKpZPBc2ens3iN4C17LgD+OlD6MjveOnQCh3Hdk=;
 b=QxjDdwYfaCaNAhDD2QkCT3g/LjlR6G0CgREUTq/x4GxsDHah3GnUlTeF3sKguqPx52VtDi1VYUuCjbp3ZONnoNUB4DgULZES2Ollq2Vqy74ClEz+ubHPQAwfbM2SpG6qKHbH88oqZHPuoFT8Iy95yf1U8c1gkFBEj+FguffmUfI=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM6PR12MB3386.namprd12.prod.outlook.com (2603:10b6:5:115::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.23; Mon, 13 Jul 2020 13:59:29 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::f533:4c74:1224:cd32]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::f533:4c74:1224:cd32%5]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 13:59:29 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>
Subject: RE: [RFC PATCH 06/35] PCI: Tidy Success/Failure checks
Thread-Topic: [RFC PATCH 06/35] PCI: Tidy Success/Failure checks
Thread-Index: AQHWWRi0LtmdnIuTt0+75Co5EBpArakFiOMQ
Date:   Mon, 13 Jul 2020 13:59:28 +0000
Message-ID: <DM5PR12MB12762A48A839874F3CC59AEEDA600@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
 <20200713122247.10985-7-refactormyself@gmail.com>
In-Reply-To: <20200713122247.10985-7-refactormyself@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTBlZjViNDFlLWM1MTEtMTFlYS05OGMwLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFwwZWY1YjQyMC1jNTExLTExZWEtOThjMC1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjQ2NzEiIHQ9IjEzMjM5MTIyMzY1NDUy?=
 =?us-ascii?Q?MDI3MyIgaD0iTU1naHJkUnd5Y2ovSjJxRHp3VGVJMHkrVUo0PSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?UmxVN1JIVm5XQVQxU1BFNmk5TEFMUFZJOFRxTDBzQXNPQUFBQUFBQUFBQUFB?=
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
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc29951c-38b8-4796-ead7-08d82734f605
x-ms-traffictypediagnostic: DM6PR12MB3386:
x-microsoft-antispam-prvs: <DM6PR12MB338661DB8D3E2CD46BA313C0DA600@DM6PR12MB3386.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g+lFojWEfn116GK8usRMgpMDlCOiY+Kss6PIyyvxYgwDhkpb3X/yBtO2SOmhwREpswvm2utZdZuxbqtwhKfOkSN72kexDYoEmXT86u29aVrpPVKP9Bv7eUQ5ez3TvputKGHEnbQlBpxBkzfFkPbuJ9h1bgyFU1HxAmfMLcbE4pTd3geJ36c7Zm8Qy8gDwQf+z/ZHUAKUep68hPvXez+d0tKkXwIeBESx1MvHoT6MMwHV1QI42JDYp3GcndrMWy6OF6OV85rYSRMfxDwtfEnC/siAQjAJ5Mgkd6KzmYZ5l7AQv8bcY4Tql3KFD8qM9VqCWVlAokbjGr+MFiLi8l9S2gOZ7v3xRkGOrZ/mwVaj7FLb73ZusP239zasvFWP+RdX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(346002)(39860400002)(366004)(136003)(8676002)(53546011)(8936002)(6506007)(9686003)(2906002)(186003)(55016002)(83380400001)(4326008)(76116006)(71200400001)(33656002)(86362001)(7696005)(7416002)(66556008)(26005)(54906003)(110136005)(66446008)(64756008)(66476007)(66946007)(316002)(52536014)(5660300002)(478600001)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: f4s/xSlG6QbhWkRqwMPMESsK1E1hrMi87q84S7p+xTEGDyW3zgJZm7Pb/SSwbFD5QUU4HC+C0KhLNU+6Vv7tCzqdVUbo5cmR5zVb6ncFo47J75I3aUPlOp8vsptQJhnYq7Pik0+PVEhZ52bhMCZ0VJ6BE9+HRSeYY2n25t7uBZUDYNxuiRgZ8RGyL/rAVrBJdup5pJrUaFs3lWTpJsRITgOmzpPTlfgNbqCyBpar0rYIF/EFLmLQao3wVXkvQHKhA+fCaG9pimikYB3uwEBAUh6lodkXey0nDpIXrEz64y/OcWfKXhApmqQiaxzxs+eAFJfVKeW47Wt5vOtk4XfyLQiuGVnmbkrBk9In01s68eUKljbgz/sq5NRzZr4QtwiJwbTrdPZfYyknv9Ka2cB8OXdxDArU8y74l4KIBkQ62JogIZJ+0hGq8ggMse7Lcw4UNz6X57ACd5CNyCtYNLGDFWWCODFK5we+5oyNNzOyhgk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1276.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc29951c-38b8-4796-ead7-08d82734f605
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 13:59:29.0421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yudyHR0KbbDEMbpsNUHexikJt6XfGuavDmMwChgT+3NL/Um1wTztnIMYFQeShuezVTQopxP5ZjyE2RfceDwPPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3386
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 13:22:18, Saheed O. Bolarinwa=20
<refactormyself@gmail.com> wrote:

> Remove unnecessary check for 0.
>=20
> Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
> ---
> This patch depends on PATCH 05/35
>=20
>  drivers/pci/controller/dwc/pci-meson.c            | 2 +-
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  drivers/pci/controller/pci-xgene.c                | 3 +--
>  drivers/pci/controller/pcie-altera.c              | 4 ++--
>  drivers/pci/controller/pcie-iproc.c               | 2 +-
>  drivers/pci/controller/pcie-rcar-host.c           | 4 ++--
>  6 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/control=
ler/dwc/pci-meson.c
> index 58142f03d300..8203d5f95d28 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -390,7 +390,7 @@ static int meson_pcie_rd_own_conf(struct pcie_port *p=
p, int where, int size,
>  	int ret;
> =20
>  	ret =3D dw_pcie_read(pci->dbi_base + where, size, val);
> -	if (ret !=3D 0)
> +	if (ret)
>  		return ret;
> =20
>  	/*
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index 7c97c54f787c..2dd3965365f6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -459,7 +459,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	}
> =20
>  	ret =3D dw_pcie_rd_own_conf(pp, PCI_HEADER_TYPE, 1, &hdr_type);
> -	if (ret !=3D 0) {
> +	if (ret) {
>  		dev_err(pci->dev, "Failed reading PCI_HEADER_TYPE cfg space reg (ret: =
0x%x)\n",
>  			ret);
>  		ret =3D pcibios_err_to_errno(ret);
> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/=
pci-xgene.c
> index bf74f0a8b451..8d55cfc4ff8a 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -167,8 +167,7 @@ static int xgene_pcie_config_read32(struct pci_bus *b=
us, unsigned int devfn,
>  {
>  	struct xgene_pcie_port *port =3D pcie_bus_to_port(bus);
> =20
> -	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=3D
> -	    0)
> +	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val))
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> =20
>  	/*
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controlle=
r/pcie-altera.c
> index 96f5bda32b58..9f7b12ad0c04 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -367,7 +367,7 @@ static int tlp_cfg_dword_write(struct altera_pcie *pc=
ie, u8 bus, u32 devfn,
>  						    value, false);
> =20
>  	ret =3D pcie->pcie_data->ops->tlp_read_pkt(pcie, NULL);
> -	if (ret !=3D 0)
> +	if (ret)
>  		return ret;
> =20
>  	/*
> @@ -453,7 +453,7 @@ static int _altera_pcie_cfg_read(struct altera_pcie *=
pcie, u8 busno,
> =20
>  	ret =3D tlp_cfg_dword_read(pcie, busno, devfn,
>  				 (where & ~DWORD_MASK), byte_en, &data);
> -	if (ret !=3D 0)
> +	if (ret)
>  		return ret;
> =20
>  	switch (size) {
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller=
/pcie-iproc.c
> index dac9352c0cb2..d34c9457fbe4 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -584,7 +584,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus=
, unsigned int devfn,
>  	/* root complex access */
>  	if (busno =3D=3D 0) {
>  		ret =3D pci_generic_config_read32(bus, devfn, where, size, val);
> -		if (ret =3D=3D 0)
> +		if (!ret)
>  			iproc_pcie_fix_cap(pcie, where, val);
> =20
>  		return ret;
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/contro=
ller/pcie-rcar-host.c
> index 363a8630de28..2bb250c6f767 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -157,7 +157,7 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, u=
nsigned int devfn,
> =20
>  	ret =3D rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
>  				      bus, devfn, where, val);
> -	if (ret !=3D 0) {
> +	if (ret) {
>  		*val =3D 0xffffffff;
>  		return ret;
>  	}
> @@ -184,7 +184,7 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, =
unsigned int devfn,
> =20
>  	ret =3D rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
>  				      bus, devfn, where, &data);
> -	if (ret !=3D 0)
> +	if (ret)
>  		return ret;
> =20
>  	dev_dbg(&bus->dev, "pcie-config-write: bus=3D%3d devfn=3D0x%04x where=
=3D0x%04x size=3D%d val=3D0x%08x\n",
> --=20
> 2.18.2

Seems harmless to me.



