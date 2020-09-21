Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA92722BF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 13:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgIULja (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 07:39:30 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:33308 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726384AbgIULja (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 07:39:30 -0400
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 07:39:29 EDT
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5543840562;
        Mon, 21 Sep 2020 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1600687851; bh=A3k2aJRYqmuBON+byJXuGU4S4sPsRHHXVhSmu/NHEE8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ElD98WTceRUqebD8qomRi0n4wP28NB2xruXoN1qswSa84cD29GP6oWaTzff44M+Ae
         LntNgY+/ESK5ekkoAvNl74QvHJcExE2iCD2UOT/RqgVtEA/CDvN0B0jFxvZv1n8wsR
         rS2tjx0qS7rxBEUZkJHyC8hWXdMKhojaBWQcO0OxsRKMij6pG8wZicifMt+RdsJEmg
         FeKLp5ufuk2Mfk5QjOQbyzBtVTlQar3jyJxJoqnCuENF8IGKBAyJPjNHQXvF4F3OG4
         iy7dW6eOcr1Q5ZyQX1qeDCG+vTOp03hIvV2yloVEP6xE1gTsmQog8tjI86RKsiKrRq
         ZeILKPwm5IOEQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0750FA006D;
        Mon, 21 Sep 2020 11:30:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B8CD9400B3;
        Mon, 21 Sep 2020 11:30:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="u8DLverK";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGHrYjCFm/Fw320JCzSuKlHCwnTZUvd2r+9RX5Sa4GEVeTOVhyI2+hgZKm0sI1ZwITo8MtpXdJ4g0nzEZhbrfSPLjVFk9G4EQIzhzBtpBGeCu6KG+S4FcqHT4YJYzZQQ05EHAJd8xtsi1gzuwoKSjC9t4lGAbNwQehVbHgcFCeC6fGrP4q6Yd9PpIbzIa2LPwZuhJHvHBHy1hA/bu/foTRKtsKM80feXT231sqCiGsX+R1loP3KAOsBLPA4DboS8yHO6Ma98DfIrb7kW+pwkyM1fHjHU6vQQY4/uo63RzHjJFgzqZjQJpBg3LI25GimU9J+g04usxUZKJ+GAauJxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIk/hocjwJMG9es5ExfXjuLxCjod6c16EDUds8IzPPw=;
 b=H3RmBaJkBrj2r+eHdjQB/uzzS08/99mBqFI8/TySfplNr7RNRFEnfOQtBjr08IGSQMFOwjpVuNXWeL3dQMWSvhY14lq7PLdxDcENG98kPQ9gD0KpVn6gml9Ledfl27j1hDDML+Rhr3My9LCHdXpBdpErkFWYzVjQuGNHLaWo/aZpNjz9kPB+ka80//L2yBlssQKzgM5LQUGIywtZ0n9uDkrgM3nA69LiF8x1M/ctAmnWQvjMkn43+1hwfuDletlgkSzEhPK7Neaw2f4LY0EWTl8Ftx6/lykm00FYYfHoKwOgObXJLFILcm9RtHUbY1C71RXNU3gTtE+Dgmm1HeKq1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIk/hocjwJMG9es5ExfXjuLxCjod6c16EDUds8IzPPw=;
 b=u8DLverK79a1cD6h/LB5tbJ9AE2eDfI6NzHUiEgTG4gFMwSUsNdT9Y3WbKhB5tTpPNqAvzy/WG4WidvPAf7utZIqZgGHDUa5UWFc0zmC9AlcRpMEG8hBMDOHgunat23FEX+g3t5FrpFVInYYaQZV8Ci7tVzrCBnxp6Ic7M2/S98=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR1201MB0236.namprd12.prod.outlook.com (2603:10b6:4:57::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Mon, 21 Sep 2020 11:30:48 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::742c:dafa:9df7:4f4]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::742c:dafa:9df7:4f4%10]) with mapi id 15.20.3391.025; Mon, 21 Sep 2020
 11:30:48 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: RE: [PATCH] [-next] PCI: DWC: Fix cast truncates bits from constant
 value
Thread-Topic: [PATCH] [-next] PCI: DWC: Fix cast truncates bits from constant
 value
Thread-Index: AQHWjTlxgisFVhsuDUiUuIdgE663/qltXfiAgACW1zCABQVXkA==
Date:   Mon, 21 Sep 2020 11:30:48 +0000
Message-ID: <DM5PR12MB1276E15164E0793E623BACEBDA3A0@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <7743c426ae2c34573d59636d4d6cefaccdb00990.1600378070.git.gustavo.pimentel@synopsys.com>
 <20200917214759.GA1741197@bjorn-Precision-5520>
 <DM5PR12MB127636924B64202BCD8A2154DA3F0@DM5PR12MB1276.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB127636924B64202BCD8A2154DA3F0@DM5PR12MB1276.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWUzNmRmNGVlLWZiZmQtMTFlYS05OGNmLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxlMzZkZjRmMC1mYmZkLTExZWEtOThjZi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjMyMjEiIHQ9IjEzMjQ1MTYxNDQ1OTI5?=
 =?us-ascii?Q?NzUwNCIgaD0ienlxd3N2WDZBMlJFZlVxdHJicHZDcno2WFJJPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?Zy9zV2xDcERXQWJGNEZVbUV1blhhc1hnVlNZUzZkZG9PQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFOclNWM2dBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
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
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95d37c90-8aba-4b33-2816-08d85e21ca08
x-ms-traffictypediagnostic: DM5PR1201MB0236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB02361438316241A91D3C113CDA3A0@DM5PR1201MB0236.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wucBIJIOXqltPhnBsRfECNFwE3uW8V0WBscm+D3wX/bq+9LqEYxTsS+B3mRDza/HdDpWtys6mEbqUuIxYdwOQTHWsI5U4G2K0vxHlzi5NBu8ZFqOw9GFAed0xA7cqlSHFMy+vtd5f0PW+b7yxAi1Kc9pjWNnIk77tZq96dgx02AnmFlxuKdM/smGgR/ctoxUmSL1NTS0evBku5S62JcyUjyRtVDc/wHHjoJGOeFAo26zFRNjc3jpa9Zj5Bz3bdxxpeuk0Bsyr0d73550Aqg55jYhunYDKJmi0VGd/9KQb6xdaH0iS3fxQ+Dfl9hD88GxveW/KTdRN0gzExQknZSBOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(9686003)(55016002)(6916009)(76116006)(53546011)(6506007)(7696005)(2906002)(66446008)(33656002)(86362001)(66946007)(66476007)(66556008)(64756008)(54906003)(478600001)(8936002)(52536014)(71200400001)(107886003)(316002)(5660300002)(26005)(8676002)(4326008)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sSPa+Lk4ZsVmlazESD0PFsiDwv4oQ/YMkuivFRsQy+eOiS9vAlu8qYOY2GZ+WUz4/NYkiT/lZFlXhgNvpecy5KXk5j6eu+CiNrIrMEHZ4SlEEDdYs2QeWMKmgsv5zidO1w0+F6Zq+kuI5v3rzMGNFgN+KwOVKFkwDgn3fBGuEwxnqd0EtPTkpz2EpsSzoCV6U+Cl12ACWXwuOFjzHP4VWXEgR5VaDIev297bZw2pmDBtrll4NH2I05vgKe8QTNt02b196BEPi4iw0wsMQLyXQXkMTIGXz54HjSLcf7HKbm63Mbw0oi0LXZqpa+/+N9mkthbnfFI8Y6v24Zyr1MwoaTFpwjW3njACJ/I95eyRBh+62e/9C/cxgeNhmxbSn0wr+sJhky+HTVf9Pw3/SVOPmeKbAdjJcktSLjOHIogqlRiARRFVssqcdY0I8GOqDw04a6/4Y7bLJO9OaqUfOmPoz3SGuKnOnkD0tqwQz0tc6BwwnbdhTUH5GGBnBPhiSZJnUMcpar2hfYXZj8U8yrImYLbglRDS3z1p4HiAZkuJNBU7RFXDLtT6X53DX8gV6dSCOzgynqVjEjI/8w01Fbllla6X8EPJLOXbAITJghG1hFgZCXiBp+iUPiHbJrNk4iKjzplIKQYsxozWzlmRRVyZhA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1276.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d37c90-8aba-4b33-2816-08d85e21ca08
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 11:30:48.8489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGwzpS8EedriJNpGd5HML8OnyvmoBfTer79hgRe7w3BbNXV6Ul9uAnBDcBGCguSmP8lWEDzwcfmTB1/ruIfvtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0236
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 18, 2020 at 8:15:48, Gustavo Pimentel <gustavo@synopsys.com>=20
wrote:

> On Thu, Sep 17, 2020 at 22:47:59, Bjorn Helgaas <helgaas@kernel.org>=20
> wrote:
>=20
> > On Thu, Sep 17, 2020 at 11:28:03PM +0200, Gustavo Pimentel wrote:
> > > Fixes warning given by executing "make C=3D2 drivers/pci/"
> > >=20
> > > Sparse output:
> > > CHECK drivers/pci/controller/dwc/pcie-designware.c
> > >  drivers/pci/controller/dwc/pcie-designware.c:432:52: warning:
> > >  cast truncates bits from constant value (ffffffff7fffffff becomes
> > >  7fffffff)
> > >=20
> > > Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Joao Pinto <jpinto@synopsys.com>
> > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/p=
ci/controller/dwc/pcie-designware.c
> > > index 3c3a4d1..dcb7108 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -429,7 +429,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int=
 index,
> > >  	}
> > > =20
> > >  	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> > > -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
> > > +	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~0 & ~PCIE_ATU_ENABLE);
> >=20
> > But this cure is worse than the disease.  If this is the only way to
> > fix the warning, I think I'd rather see the warning ;)  I'm hopeful
> > there's a nicer way, but I'm not a language lawyer.
>=20
> I don't like it either, I tried to see if were another way a clean way=20
> that didn't imply creating a temporary variable, but I didn't found.
> The issue here is that PCIE_ATU_ENABLE is defined as BIT(31) on=20
> pcie-designware.h. The macro BIT changes its size from u32 to u64=20
> according to the architecture and by inverting the value on the 64 bits=20
> architecture causes the value to be transformed into 0xffffffff7fffffff.
>=20
> The other possibility implies the creation of a temporary u32 variable to=
=20
> overcome this issue. It's a little bit overkill, but please share your=20
> thoughts about it.
>=20
> void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>                          enum dw_pcie_region_type type)
>  {
> -       int region;
> +       u32 atu =3D PCIE_ATU_ENABLE;
> +       u32 region;
>=20
>         switch (type) {
>         case DW_PCIE_REGION_INBOUND:
> @@ -429,7 +430,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int=20
> index,
>         }
>=20
>         dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> -       dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
> +       dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~atu);
>  }

Hi Bjorn,

What is your verdict on this?
If you prefer this approach I can send the corresponding patch.

-Gustavo

>=20
> >=20
> > >  }
> > > =20
> > >  int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > --=20
> > > 2.7.4
> > >=20


