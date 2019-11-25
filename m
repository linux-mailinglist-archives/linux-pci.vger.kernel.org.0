Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9044108D45
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 12:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfKYLwd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 06:52:33 -0500
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:51712 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbfKYLwc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 06:52:32 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9766BC03F3;
        Mon, 25 Nov 2019 11:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1574682751; bh=uTNu/+eAw0b+5R+LAGy4PUjZ/guVd2if7uVrZPdmKD4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bGDs6/wKxNvKbjGTvsHnURqmgzpZKOIQbXMBEu44D16SkB5qSnrtfdMFa+RKF7knq
         Gs7EKfc0NGPbZ+cviM6QoWzm5Gcu7V67s8TZZICaJf333OZdk/dhIyGOh1je5PUC2N
         0ruHMTZXW5XnV/ASGWL5ToRqrWDbPtobTZUyhEaveZ1svJxAzDB/O3EoFKYWh7VLhF
         IbjSXZ/Xe/0tA99TYyHh0pya8Srd5SMt8vsJVntKvdraUoHeo9dgF95Hf9X2kkY7ul
         LsMm3pi4Cn1KLiJqA7nLctumexh6F5wu+dhV8I266cX2Wh/hACodAkHDmlFqVYR4Mz
         unhfxjsGVsKOA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 20F01A006A;
        Mon, 25 Nov 2019 11:52:30 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.13.188.44) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 25 Nov 2019 03:52:29 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.13.177.249)
 by mrs.synopsys.com (10.13.188.44) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 25 Nov 2019 03:52:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyOQxLyv4OXYixrdblaw4DsRKIjVz7fTdX723P1Q2+AIBsRJqGnv1DQY0ntMoObKlssQixUx8bVbggR/yFeOzWVmGrATnPaoVudtKiUn2MEGck1O+4ANr+A9N3YgvME9pOdTaNMj+07i1dbjXrVDDpfmEOb0663YoY5xl76vD2M27y51F12SJAuDGIF9joAHb9k9MbSU03vAt17JOZflkgXD1mipWJLaCFWN2BW005bk9+1UUYSJwFW8W2tCdUOgCATTWcUMWXjs2Rs/OzHOT5TFSWWkJFMpbvE+NvhVczfrwpSnBAcwqrJw/DtKi+fs0JWDLzWTx8f2iSq/TV8P+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpuBNxs9hVVxc2EJgktXOTkPVNRGZ/i6Un3IXhTzIns=;
 b=KdR0v5Ym0ni2kqXa+mNPnbPmVnO7GSofFLxwJQUL1ZhXql3XIdK4Z+LrfIV14sDdVrK52FR71qholv69Eihd1kgsSvcZlYGf+RrfFaQt7kV/p6d/hZKN/YOd92KesBKImBYoAFzMgCu7//KcZcoPRTutNaAi4NWwR5LbTqHSn+/IoqklA26RbtR6Q2K7XDIMarks6fEIVMgkG7zj1EwBffRDQ0yNx230hKYraACcHdS8ZRJtGr2xfkfAWMV2fnOCuErWx3qur9oqvbbahJse1KWE/LrDJIXsa7n4SKZfs+1W5R/sV8RK1+sa2Poks51pzQO0knghfj6rSzLG9XhtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpuBNxs9hVVxc2EJgktXOTkPVNRGZ/i6Un3IXhTzIns=;
 b=JXR2WmvBgo+wcZhjuWn0rpB8i8WgRQcfDeuKlG+l8rwXh75J0Z9QRGKX3ffw4H1JuF5+Sk/8BSroOIt53hVrKeQ4gRe3i7CpLTxY4hBGq/ednWRwAWh/RnQKdgtKfyuyzRFIO6VDfsSp+3R1xf694mbWeXheiQiqtJtqk+nqbLU=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB3450.namprd12.prod.outlook.com (20.178.29.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Mon, 25 Nov 2019 11:52:28 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::b0c9:8724:cdaf:10b1]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::b0c9:8724:cdaf:10b1%2]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 11:52:28 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: RE: [PATCH 2/6] dt-bindings: PCI: tegra: Add DT support for PCIe EP
 nodes in Tegra194
Thread-Topic: [PATCH 2/6] dt-bindings: PCI: tegra: Add DT support for PCIe EP
 nodes in Tegra194
Thread-Index: AQHVoSIGRtupZ2C36ki3nP3a6spYt6eXLK6AgARTlQCAAALfgIAAQhmw
Date:   Mon, 25 Nov 2019 11:52:28 +0000
Message-ID: <DM6PR12MB401074B85B9E9E592648FF65DA4A0@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <20191122104505.8986-1-vidyas@nvidia.com>
 <20191122104505.8986-3-vidyas@nvidia.com> <20191122131931.GB1315704@ulmo>
 <8fbdda8e-84af-576c-e240-61c381c85a8f@nvidia.com>
 <20191125073359.GD1409040@ulmo>
In-Reply-To: <20191125073359.GD1409040@ulmo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTBhOTdhMWEzLTBmN2EtMTFlYS05ODljLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFwwYTk3YTFhNC0wZjdhLTExZWEtOTg5Yy1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjEzOTY5IiB0PSIxMzIxOTE1NjM0NTcy?=
 =?us-ascii?Q?MTI5NTAiIGg9InZoUnFmV3RLdUpHZHJwa2dMRE1kTkloV3Ixbz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFB?=
 =?us-ascii?Q?QVdzaXZPaHFQVkFmNEtGL2ZxUFVKLy9nb1g5K285UW44T0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBRUdJWXpRQUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0Fi?=
 =?us-ascii?Q?Z0JoQUc0QVl3QmxBRjhBY0FCc0FHRUFiZ0J1QUdrQWJnQm5BRjhBZHdCaEFI?=
 =?us-ascii?Q?UUFaUUJ5QUcwQVlRQnlBR3NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3Qm5BR1lBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhNQVlRQnRBSE1BZFFCdUFHY0FYd0JqQUc4QWJnQm1BQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFjd0Jo?=
 =?us-ascii?Q?QUcwQWN3QjFBRzRBWndCZkFISUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCekFHMEFhUUJqQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFi?=
 =?us-ascii?Q?Z0JsQUhJQWN3QmZBSE1BZEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1B?=
 =?us-ascii?Q?RzhBZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWRB?=
 =?us-ascii?Q?QnpBRzBBWXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFI?=
 =?us-ascii?Q?a0FYd0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0IxQUcwQVl3QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFad0IwQUhNQVh3QndBSElBYndCa0FIVUFZd0IwQUY4?=
 =?us-ascii?Q?QWRBQnlBR0VBYVFCdUFHa0FiZ0JuQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHRUFiQUJsQUhNQVh3QmhBR01BWXdCdkFIVUFiZ0IwQUY4QWNBQnNBR0VB?=
 =?us-ascii?Q?YmdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BWVFCc0FHVUFjd0Jm?=
 =?us-ascii?Q?QUhFQWRRQnZBSFFBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUNlQUFBQWN3QnVBSEFBY3dCZkFHd0FhUUJqQUdVQWJnQnpB?=
 =?us-ascii?Q?R1VBWHdCMEFHVUFjZ0J0QUY4QU1RQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFB?=
 =?us-ascii?Q?QUJ6QUc0QWNBQnpBRjhBYkFCcEFHTUFaUUJ1QUhNQVpRQmZBSFFBWlFCeUFH?=
 =?us-ascii?Q?MEFYd0J6QUhRQWRRQmtBR1VBYmdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFIWUFad0JmQUdzQVpR?=
 =?us-ascii?Q?QjVBSGNBYndCeUFHUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFB?=
 =?us-ascii?Q?QUFBQUFDQUFBQUFBQT0iLz48L21ldGE+?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gustavo@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abee0de2-e5fa-4cbc-7690-08d7719df235
x-ms-traffictypediagnostic: DM6PR12MB3450:
x-microsoft-antispam-prvs: <DM6PR12MB3450B7FD79A41AC8E63E04E8DA4A0@DM6PR12MB3450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(14454004)(76116006)(66946007)(8936002)(2906002)(81166006)(81156014)(66476007)(305945005)(8676002)(25786009)(14444005)(256004)(229853002)(76176011)(30864003)(6506007)(54906003)(316002)(6436002)(66556008)(64756008)(66446008)(7696005)(186003)(99286004)(52536014)(110136005)(26005)(5660300002)(53546011)(33656002)(478600001)(66066001)(71190400001)(71200400001)(446003)(11346002)(9686003)(6116002)(3846002)(86362001)(74316002)(55016002)(4326008)(7736002)(7416002)(6246003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3450;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ITP4ZENoAzjZVxoqwbkgGEoH861nv5IeRW6pr8K9mbRUnOgQqZIePmTlcRYDdh2uIwDVluicOgNMgcC9hDSovYc5UUyBnjEH1eIDou/U1s6mo417RF2cs8J2qDtOO1lIekCfffXqnT8jTwPWmVYwXbFJdWDuaFNmjkHQ6/E05rHzOMsOmmt9kCRRWlnYVmqSeXQy736wLPlqn7EReNvC9j9U46Uc0+BtGc+dhfZOTeE9KQj7Z2fEH4G/swBH3KIsyKCQoD7KX0KRnpHpdDk8WiuV0LJDy2wGO03+2jyF8m4faJa1TywAdkReR4nBVVXxgpXo6QPgvNv1X6Y9VQE225BUaGEx5mU29yTtpuUM9qDoQ+8dHoMyzYsGXfAj7q4MBakDRCzIKe1G4ynQr1Arlsj+zP8FxgoropMQZcyxE//88X1iPhB51WtsKAe/V3m
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: abee0de2-e5fa-4cbc-7690-08d7719df235
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 11:52:28.1110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RkZyVMSfjPyXEIszdIXDl9rPm9AvhljjUis80I34SHhkhJqBvblOXOTIxNkn0A3uYhO422UqBMIeHaf5Z+gkaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3450
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 25, 2019 at 7:33:59, Thierry Reding=20
<thierry.reding@gmail.com> wrote:

> On Mon, Nov 25, 2019 at 12:53:42PM +0530, Vidya Sagar wrote:
> > On 11/22/2019 6:49 PM, Thierry Reding wrote:
> > > On Fri, Nov 22, 2019 at 04:15:01PM +0530, Vidya Sagar wrote:
> > > > Add support for PCIe controllers that can operate in endpoint mode
> > > > in Tegra194.
> > > >=20
> > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > ---
> > > >   .../bindings/pci/nvidia,tegra194-pcie-ep.txt  | 138 +++++++++++++=
+++++
> > > >   1 file changed, 138 insertions(+)
> > > >   create mode 100644 Documentation/devicetree/bindings/pci/nvidia,t=
egra194-pcie-ep.txt
> > >=20
> > > The vast majority of this is a duplication of the host mode device tr=
ee
> > > bindings. I think it'd be best to combine both and only highlight whe=
re
> > > both modes differ.
> > >=20
> > > The designware-pcie.txt binding does something similar.
> > Ok. I'll merge this into the host mode bindings file and in that differ=
entiate between
> > root mode and endpoint mode.
> >=20
> > >=20
> > > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-=
pcie-ep.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep=
.txt
> > > > new file mode 100644
> > > > index 000000000000..4676ccf7dfa5
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep=
.txt
> > > > @@ -0,0 +1,138 @@
> > > > +NVIDIA Tegra PCIe Endpoint mode controller (Synopsys DesignWare Co=
re based)
> > > > +
> > > > +Some of the PCIe controllers which are based on Synopsys DesignWar=
e PCIe IP
> > > > +are dual mode i.e. they can work in root port mode or endpoint mod=
e but one
> > > > + at a time. Since they are based on DesignWare IP, they inherit al=
l the common
> > > > +properties defined in designware-pcie.txt.
> > > > +
> > > > +Required properties:
> > > > +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
> > >=20
> > > The device tree snippets that you added have "nvidia,tegra194-pcie-ep=
"
> > > for EP mode controllers. So either this is wrong or the DTS files are
> > > wrong.
> > DTS file are correct. This is a mistake in this file. I'll correct this=
.
> >=20
> > >=20
> > > This device tree binding describes the exact same hardware, so I don'=
t
> > > think we necessarily need two different compatible strings. It's fair=
ly
> > > easy to distinguish between which mode to run in by looking at which
> > > properties exist. EP mode for example is the only one that uses the
> > > "addr_space" reg entry.
> > >=20
> > > Rob, do you know why a different compatible string was chosen for the=
 EP
> > > mode? Looking at the driver, there are only a handful of differences =
in
> > > the programming, but most of the driver remains identical. An extra D=
T
> > > compatible string seems a bit exaggerated since it suggests that this=
 is
> > > actually different hardware, where it clearly isn't.
> > Since all other implementations have done it this way, I just followed =
to be in sync
> > with them. Even I would also like to hear from Rob on the rationale beh=
ind this.
> >=20
> > >=20
> > > > +  Tegra194: Only C0, C4 & C5 controllers are dual mode controllers=
.
> > > > +- power-domains: A phandle to the node that controls power to the =
respective
> > > > +  PCIe controller and a specifier name for the PCIe controller. Fo=
llowing are
> > > > +  the specifiers for the different PCIe controllers
> > > > +    TEGRA194_POWER_DOMAIN_PCIEX8B: C0
> > > > +    TEGRA194_POWER_DOMAIN_PCIEX4A: C4
> > > > +    TEGRA194_POWER_DOMAIN_PCIEX8A: C5
> > > > +  these specifiers are defined in
> > > > +  "include/dt-bindings/power/tegra194-powergate.h" file.
> > > > +- reg: A list of physical base address and length pairs for each s=
et of
> > > > +  controller registers. Must contain an entry for each entry in th=
e reg-names
> > > > +  property.
> > > > +- reg-names: Must include the following entries:
> > > > +  "appl": Controller's application logic registers
> > > > +  "atu_dma": iATU and DMA registers. This is where the iATU (inter=
nal Address
> > > > +             Translation Unit) registers of the PCIe core are made=
 available
> > > > +             for SW access.
> > > > +  "dbi": The aperture where root port's own configuration register=
s are
> > > > +         available
> > > > +  "addr_space": Used to map remote RC address space
> > > > +- interrupts: A list of interrupt outputs of the controller. Must =
contain an
> > > > +  entry for each entry in the interrupt-names property.
> > > > +- interrupt-names: Must include the following entry:
> > > > +  "intr": The Tegra interrupt that is asserted for controller inte=
rrupts
> > > > +- clocks: Must contain an entry for each entry in clock-names.
> > > > +  See ../clocks/clock-bindings.txt for details.
> > > > +- clock-names: Must include the following entries:
> > > > +  - core
> > > > +- resets: Must contain an entry for each entry in reset-names.
> > > > +  See ../reset/reset.txt for details.
> > > > +- reset-names: Must include the following entries:
> > > > +  - apb
> > > > +  - core
> > > > +- phys: Must contain a phandle to P2U PHY for each entry in phy-na=
mes.
> > > > +- phy-names: Must include an entry for each active lane.
> > > > +  "p2u-N": where N ranges from 0 to one less than the total number=
 of lanes
> > > > +- nvidia,bpmp: Must contain a pair of phandle to BPMP controller n=
ode followed
> > > > +  by controller-id. Following are the controller ids for each cont=
roller.
> > > > +    0: C0
> > > > +    4: C4
> > > > +    5: C5
> > > > +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signal=
s
> > > > +- nvidia,pex-rst-gpio: Must contain a phandle to a GPIO controller=
 followed by
> > > > +  GPIO that is being used as PERST signal
> > >=20
> > > Why is this NVIDIA specific? Do other instantiations of the DW IP not
> > > also need a means to define which GPIO is the reset?
> > I'm not sure. At least I didn't find anything like this in other implem=
entations.
> > My understanding is that, controller handles assert/de-assert on the PE=
RST line
> > automatically without SW intervention. I think it is for the same reaso=
n that other
> > implementations don't wait for the REFCLK to flow in from host to confi=
gure the IP.
> > I think they just use some internal clock for the configuration and swi=
tch to
> > running the core based on REFCLK as and when it is available
> > (i.e. whenever a de-assert is perceived on PERST line by the controller=
)
>=20
> That would be somewhat surprising, though. The IP used in Tegra must be
> pretty close to the IP used in other SoCs, and the code that we need in
> pex_ep_event_pex_rst_{assert,deassert}() is pretty significant. Why the
> other instantiations wouldn't need something similar seems unlikely to
> me.
>=20
> Perhaps Jingoo or Gustavo can shed some light on this.

On my current FPGA prototyping solution, I don't need to control the=20
PERST line and it's very likely that I don't even have access to control=20
it. I guess due to some particularity of my solution, the HW team=20
probably has decided to wire it up directly for some unknown reason to=20
me.

However, It seems to me that exynos, imx6, keystone, meson, al, histb,=20
kirin, and qcom drivers controls the PERST line in spite of others driver=20
that doesn't do it like in my prototype solution.
In the end I'd says that depends of how the IP solution of design by the=20
HW team.

Gustavo

>=20
> Thierry
>=20
> >=20
> > >=20
> > > > +
> > > > +Optional properties:
> > > > +- pinctrl-names: A list of pinctrl state names.
> > > > +  It is mandatory for C5 controller and optional for other control=
lers.
> > > > +  - "default": Configures PCIe I/O for proper operation.
> > > > +- pinctrl-0: phandle for the 'default' state of pin configuration.
> > > > +  It is mandatory for C5 controller and optional for other control=
lers.
> > > > +- supports-clkreq: Refer to Documentation/devicetree/bindings/pci/=
pci.txt
> > > > +- nvidia,update-fc-fixup: This is a boolean property and needs to =
be present to
> > > > +    improve performance when a platform is designed in such a way =
that it
> > > > +    satisfies at least one of the following conditions thereby ena=
bling root
> > > > +    port to exchange optimum number of FC (Flow Control) credits w=
ith
> > > > +    downstream devices
> > > > +    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed=
 and MPS)
> > > > +    2. If C0/C4/C5 operate at their respective max link widths and
> > > > +       a) speed is Gen-2 and MPS is 256B
> > > > +       b) speed is >=3D Gen-3 with any MPS
> > > > +- nvidia,aspm-cmrt-us: Common Mode Restore Time for proper operati=
on of ASPM
> > > > +   to be specified in microseconds
> > > > +- nvidia,aspm-pwr-on-t-us: Power On time for proper operation of A=
SPM to be
> > > > +   specified in microseconds
> > > > +- nvidia,aspm-l0s-entrance-latency-us: ASPM L0s entrance latency t=
o be
> > > > +   specified in microseconds
> > > > +
> > > > +NOTE:- On Tegra194's P2972-0000 platform, only C5 controller can b=
e enabled to
> > > > +operate in the endpoint mode because of the way the platform is de=
signed.
> > > > +There is a mux that needs to be programmed to let the REFCLK from =
the host to
> > > > +flow into C5 controller when it operates in the endpoint mode. Thi=
s mux is
> > > > +controlled by the GPIO (AA, 5) and it needs to be driven 'high'. F=
or this to
> > > > +happen, set status of "pex-refclk-sel-high" node under "gpio@c2f00=
00" node to
> > > > +'okay'.
> > > > +	When any dual mode controller is made to operate in the endpoint =
mode,
> > > > +please make sure that its respective root port node's status is se=
t to
> > > > +'disabled'.
> > >=20
> > > This seems very brittle to me. There's no good way how we can detect
> > > such misconfigurations. If instead we only have one node describing t=
he
> > > hardware fully, the chances of configuring things wrong (by for examp=
le
> > > enabling both the host and EP mode device tree nodes) can be reduced.
> > >=20
> > > So I think instead of duplicating all of the device tree content to h=
ave
> > > both a host and an EP node for each controller, it'd be better to jus=
t
> > > have a single node and let the device tree bindings specify which
> > > changes to apply to switch into EP mode.
> > >=20
> > > For example, there should be nothing wrong with specifying some of th=
e
> > > EP-only properties (like num-ib-windows and num-ob-windows) all the t=
ime
> > > and only use them when we actually run in EP mode.
> > >=20
> > > As I mentioned earlier, there are a couple of easy ways to distinguis=
h
> > > the modes. The presence of the "addr_space" reg entry is one example,
> > > but we could also key off the nvidia,pex-rst-gpio property, since tha=
t
> > > (presumably) wouldn't be needed for host mode.
> > >=20
> > > That way we can just add default, host mode entries to tegra194.dtsi =
and
> > > whenever somebody wants to enable EP mode, they can just override the
> > > node in the board-level DTS file, like so:
> > >=20
> > > 	pcie@141a0000 {
> > > 		reg =3D <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K) =
     */
> > > 		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K=
)  */
> > > 		       0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K)    =
   */
> > > 		       0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)     =
   */
> > > 		reg-names =3D "appl", "atu_dma", "dbi", "addr_space";
> > >=20
> > > 		nvidia,pex-rst-gpio =3D <&gpio TEGRA194_MAIN_GPIO(GG, 1) GPIO_ACTIV=
E_LOW>;
> > > 	};
> > >=20
> > > Thierry
> > I like it and fine with making these modifications also but would like =
to hear from Rob
> > also on this.
> >=20
> > - Vidya Sagar
> > >=20
> > > > +
> > > > +Examples:
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +Tegra194:
> > > > +--------
> > > > +
> > > > +	pcie_ep@141a0000 {
> > > > +		compatible =3D "nvidia,tegra194-pcie-ep", "snps,dw-pcie-ep";
> > > > +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
> > > > +		reg =3D <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128=
K)      */
> > > > +		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (2=
56K)  */
> > > > +		       0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K) =
      */
> > > > +		       0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)  =
      */
> > > > +		reg-names =3D "appl", "atu_dma", "dbi", "addr_space";
> > > > +
> > > > +		num-lanes =3D <8>;
> > > > +		num-ib-windows =3D <2>;
> > > > +		num-ob-windows =3D <8>;
> > > > +
> > > > +		pinctrl-names =3D "default";
> > > > +		pinctrl-0 =3D <&clkreq_c5_bi_dir_state>;
> > > > +
> > > > +		clocks =3D <&bpmp TEGRA194_CLK_PEX1_CORE_5>;
> > > > +		clock-names =3D "core";
> > > > +
> > > > +		resets =3D <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
> > > > +			 <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
> > > > +		reset-names =3D "apb", "core";
> > > > +
> > > > +		interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;	/* controller i=
nterrupt */
> > > > +		interrupt-names =3D "intr";
> > > > +
> > > > +		nvidia,bpmp =3D <&bpmp 5>;
> > > > +
> > > > +		nvidia,aspm-cmrt-us =3D <60>;
> > > > +		nvidia,aspm-pwr-on-t-us =3D <20>;
> > > > +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> > > > +
> > > > +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> > > > +
> > > > +		nvidia,pex-rst-gpio =3D <&gpio TEGRA194_MAIN_GPIO(GG, 1)
> > > > +					GPIO_ACTIVE_LOW>;
> > > > +
> > > > +		phys =3D <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
> > > > +		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
> > > > +		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
> > > > +
> > > > +		phy-names =3D "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
> > > > +			    "p2u-5", "p2u-6", "p2u-7";
> > > > +	};
> > > > --=20
> > > > 2.17.1
> > > >=20
> >=20


