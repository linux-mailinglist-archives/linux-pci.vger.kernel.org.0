Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B6B262BD5
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 11:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgIIJ2o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 05:28:44 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:59876 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbgIIJ2m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2020 05:28:42 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 867A3406B7;
        Wed,  9 Sep 2020 09:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1599643721; bh=N7034glkev40IXqAXFIM2nw/pRkDfuZiE6BdpHgJ2fY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=A/m8gQiM5AoJo46esvU1zg8iduIguNr3kd6a7lP/qSMpw/MqZVzeM+j7P6QjRQzk+
         dKDrgtgeV6DGpr/U/932/kFl5qj5mD7HJx2rKyxYDDPl8BsU2kClAGhuwMa5GUsgjd
         LZcKb+H67gQuWAs21n2D7+QLHkHeIURnZhY5SveNWBdH8QlL/SmA5k7bdDEmodSh+3
         AezYeng+kRneGgHh2lVrr+sLpjN469fACUne5WBdQ8aRcBiQt4QZlrV0hgVgB7Wgw3
         NOkl5VPbneJ14JshWwwEDb1d/KIDf5Szq6+/Y/TwNqqqs8JslkGEKnEGI5nWZY/3rN
         tjY/CoAC6Oi4w==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C5834A005C;
        Wed,  9 Sep 2020 09:28:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E780A4004A;
        Wed,  9 Sep 2020 09:28:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Kk08P35o";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqBs/Ym9MD+p7+AjqYS/iAzQ0vHp2j1kNhC+krI2t0HxYGLZwQaP9cgVIRswoxDcInNLfbvcpwFwSr7lema0zhK7zpU/bWGBVmBIL5sK+RJR+jhvts+QK2lA3V7dSmMeKRCnbZjUy1BFvZLDW5nlQRFuj5EnBXmTvtw8GHRisK5jOb38yHeu5Z/x+7a2Rk6ex52n794Ui9KR52dSvTKsQexRBXx6pu23BighCMByjG8wxeXLwbl9yhTNJH5H0DV3Rj6XVvxHhCOikoCCTMpDKwWL+CBsKzDaJSRfO0V+1rLHfliJ9CnPrL7lNfC2BoIvNRe7Q5B+xlN7EVQTw/572Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjFScixkWLUEV/DcDZmprPjtr6xzYrRPc2/99Vob1OU=;
 b=NxJQz9QuxsKP5rKtIPGMfs1k0Skdn50ABYi6tzSuN4ZXkqmysI6fsHjW8PQKsJSY3nE+rpDW8Kfk30LMbdlDVIR2nlWTTyNK/e0AyYHj7OQmTo8IirYIrVl/Nj3KfAUKPOCXyaZA8Ca1GSrwW1Nf3dC4dzmbuXCrLb3gmyHBn+H43nP4bxPI1g8GOE/QOoJQGpDvpTHzTZFZ70RNoHXooqao03Wvl5bxRcn8H99B4h2s+HZTsdMO8UUibZfxaRhFrhGeOkwCOhiiQw3FpARE3OTRW+L8Aa74QRPIp9NAUcCXzB7UW7Wp+7sMhoYYSjzykPzMYMxGOEUWzXNa2qy4sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjFScixkWLUEV/DcDZmprPjtr6xzYrRPc2/99Vob1OU=;
 b=Kk08P35oAp38v0iHwW0M6/Ozty4VOLvJfpfD5x1FaGtd1niQogg5Ij+/VoYaV3P7LhLCX2gT/QkuT5yhsfDntBBEmxtIxJg9BdGU8RSYGYafPsDOqpDxz9qWegthxoG6sfgxaqt8V7RUxpHLs7el+x85ekI98lRABqgMT4xcVIM=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Wed, 9 Sep 2020 09:28:38 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::978:73d9:3dd5:7421]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::978:73d9:3dd5:7421%10]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 09:28:38 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "minghuan.Lian@nxp.com" <minghuan.Lian@nxp.com>,
        "mingkai.hu@nxp.com" <mingkai.hu@nxp.com>,
        "roy.zang@nxp.com" <roy.zang@nxp.com>
Subject: RE: [PATCH 1/7] PCI: dwc: Fix a bug of the case dw_pci->ops is NULL
Thread-Topic: [PATCH 1/7] PCI: dwc: Fix a bug of the case dw_pci->ops is NULL
Thread-Index: AQHWhNotE6iPslxFPECRjCRZSsNVtKlgDUiA
Date:   Wed, 9 Sep 2020 09:28:38 +0000
Message-ID: <DM5PR12MB1276C5F2E31AC703C3AB67C0DA260@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
 <20200907053801.22149-2-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20200907053801.22149-2-Zhiqiang.Hou@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWQzOTlhOWQzLWYyN2UtMTFlYS05OGNkLWE0NGNj?=
 =?us-ascii?Q?OGU5Y2YwNlxhbWUtdGVzdFxkMzk5YTlkNS1mMjdlLTExZWEtOThjZC1hNDRj?=
 =?us-ascii?Q?YzhlOWNmMDZib2R5LnR4dCIgc3o9IjI2MjQiIHQ9IjEzMjQ0MTE3MzEyODIw?=
 =?us-ascii?Q?NjE4NSIgaD0iOXVtOE9uWVAvdWw0YWtXem1MMjB6Y2lVQng0PSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?cFYvR1ZpNGJXQWZQLzltUWpubmJkOC8vMlpDT2VkdDBPQUFBQUFBQUFBQUFB?=
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
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98fa1f46-3d02-4ee3-3945-08d854a2bbaf
x-ms-traffictypediagnostic: DM6PR12MB4281:
x-microsoft-antispam-prvs: <DM6PR12MB428183DA915938C51E2AF3DBDA260@DM6PR12MB4281.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /bSaWGQJ1TH1gUHFYoBiTn9Fxd2L5Bmyn9YMGzRnvNTfpJYpcMzc3vkaV/FBycaWoAWM/IOvMHljiuw6E8R5oj/Zk20mnjGaYEtNDQvCDyZjs+ymGBMvK1RZnUH1gPG3RUZoWM7Ox//toMqqDuGqt6dE3bwmMe6g9ib85chgwUF74hwq0fD4vxoHoai6JVHNkdTIQ0oSPIkuIMwunyUEavvBm3n4B5jlZkXC6sWxmOPsmz++TNYUMyw11ZzIva+LaAS4U4bpBUOtblp6PAg6/aV6TeY0dXMTjO4cXFx3AXvSuXHmWQUW5lAaT4jyS6CgH6XCX4uK/skrYdWPu1XR3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39850400004)(366004)(376002)(478600001)(316002)(66446008)(66946007)(66476007)(66556008)(64756008)(76116006)(7416002)(83380400001)(26005)(186003)(86362001)(2906002)(110136005)(71200400001)(52536014)(5660300002)(54906003)(33656002)(7696005)(8676002)(9686003)(55016002)(4326008)(8936002)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NIBQdUXkR5ul8LeKE4JYehjONmL1qQqg66SStdfBJMwZYYQHxErRtsRB42krChZ1mgazlWcniq9ggGdaDyvez/epMLc1WmZ21UCVuD63rbxRutwU+Yw8Rm3OeRHAlmPii+zMkMM3ZlHxhnZskbmLBld1FL6cYls9t/RETtkMPBeitDovUW57/I6cgGdcpA9XcXGbVP7LEiIduTgTGHMwPjG8Q45vrxPGrhux0hNXiGZUsypvsgKQH0HlMS8TfsKvjfKjRAQXQrpbxWbwGyL6rSUSKIEIKWqHzx6OKYsqLeSBK6AXFTm4SJJNFlVVnexO6eavEPPPDcBP7H3jfeF0daL9wprlOau6pEup8q8S2saSaARkW2l+/U3fall9ZxH7NeauSGRuFFR9nGos39foiKnQNfHgQNjDspIoXXrZL0KVlMDNRwJgHXVuCTpGzrZnN6tRWVPutHVuBfPEBa/jUp4o7BhPHBAoEE2QFIlfKPWwR31JhQL/FQK3dYaG6EyoDTjKREh80ICCRF9o6HHKpIntxPs+nkyoQqFNatYxx6kP7qyhOOhqOHIp+sk2lHaYHJvVP2WtMY+JHfm4eoTIPHM0L0E8QqhCsrpvwyTjUpTlWAJK5CgOfVm5Xl/Q2aXXiAOjF/JKKc4Y25G5TNzN2w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1276.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fa1f46-3d02-4ee3-3945-08d854a2bbaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 09:28:38.1503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9clM0lP8AHJvzIWx75mTRzddZZHC6mKj7fY8zFs3rK63NVh+igDwf/oBlKaapvHzuwaSZPV3vV2+pduYF0sRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hou,

On Mon, Sep 7, 2020 at 6:37:55, Zhiqiang Hou <Zhiqiang.Hou@nxp.com>=20
wrote:

> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> The dw_pci->ops may be a NULL, and fix it by adding one more check.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index b723e0cc41fb..bdf8938da9cd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -140,7 +140,7 @@ u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, si=
ze_t size)
>  	int ret;
>  	u32 val;
> =20
> -	if (pci->ops->read_dbi)
> +	if (pci->ops && pci->ops->read_dbi)
>  		return pci->ops->read_dbi(pci, pci->dbi_base, reg, size);
> =20
>  	ret =3D dw_pcie_read(pci->dbi_base + reg, size, &val);
> @@ -155,7 +155,7 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, =
size_t size, u32 val)
>  {
>  	int ret;
> =20
> -	if (pci->ops->write_dbi) {
> +	if (pci->ops && pci->ops->write_dbi) {
>  		pci->ops->write_dbi(pci, pci->dbi_base, reg, size, val);
>  		return;
>  	}
> @@ -200,7 +200,7 @@ u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, si=
ze_t size)
>  	int ret;
>  	u32 val;
> =20
> -	if (pci->ops->read_dbi)
> +	if (pci->ops && pci->ops->read_dbi)
>  		return pci->ops->read_dbi(pci, pci->atu_base, reg, size);
> =20
>  	ret =3D dw_pcie_read(pci->atu_base + reg, size, &val);
> @@ -214,7 +214,7 @@ void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, =
size_t size, u32 val)
>  {
>  	int ret;
> =20
> -	if (pci->ops->write_dbi) {
> +	if (pci->ops && pci->ops->write_dbi) {
>  		pci->ops->write_dbi(pci, pci->atu_base, reg, size, val);
>  		return;
>  	}
> @@ -283,7 +283,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, i=
nt index, int type,
>  {
>  	u32 retries, val;
> =20
> -	if (pci->ops->cpu_addr_fixup)
> +	if (pci->ops && pci->ops->cpu_addr_fixup)
>  		cpu_addr =3D pci->ops->cpu_addr_fixup(pci, cpu_addr);
> =20
>  	if (pci->iatu_unroll_enabled) {
> @@ -470,7 +470,7 @@ int dw_pcie_link_up(struct dw_pcie *pci)
>  {
>  	u32 val;
> =20
> -	if (pci->ops->link_up)
> +	if (pci->ops && pci->ops->link_up)
>  		return pci->ops->link_up(pci);
> =20
>  	val =3D readl(pci->dbi_base + PCIE_PORT_DEBUG1);
> --=20
> 2.17.1

Looks good to me.

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>




