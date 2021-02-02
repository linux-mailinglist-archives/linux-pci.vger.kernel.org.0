Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088F330BA5B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 09:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhBBIwW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 03:52:22 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:35804 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232801AbhBBIwT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 03:52:19 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A92AC40170;
        Tue,  2 Feb 2021 08:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612255877; bh=EywgE8PperGyqPJOyXJqXoIARC5pj0Na/nlPQV1lrWM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ApOywu2huptheJpyrbYOe9aV2AeDrZV/2ZWpbHyAibuvTg3/P29j0R9Jz+uu8VFr8
         V+4WIpdPHxzW7Q2fr9EFVX6CyWnv78fEb43PFVvAfqvnOOV9HqwehN28gviD7+UoVV
         Bbj5nDrE/fIXxAW1Uv0xY2bSDLdWCCTPJMkFY8brv83CqsQ11QRiff5U9H7MHHIv8P
         yoHzRIUImYFSAOdwvvLS3dwNyZ08nb+Eguc6eHgWJQ7/oWIHuGmjn7UILaDYLvCDDj
         k1Miwcr1gJUqDNssh/NeuwqglfbldbvA2mgXfSiMu5YoEiuELtuB7h/PVkGur3BMlf
         SQ8x1MplMJ6pA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2FDAAA0067;
        Tue,  2 Feb 2021 08:51:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6DC96802BE;
        Tue,  2 Feb 2021 08:51:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="vfz1yvGw";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNg11LH45i0xKCiInRC+Rd8tMGvU2kCShrFdscuCn5Loc5qeWH5dhgJpl06TmBRCkyAthryN+JRSVJLWghsMOPLUdaNeXPn3lmsyv7dA5DUav1BKFUzLmAIom/BHJ8humjSt7pY9T/Nmz+SJGwUX4It04ctCQigJC3Pl7KZOn5AAs+53Iu/5wYAnK0y84GfpqHjHi+1HyyQwP2SZMnqq4Jl6MFJ1HlMmvl4fM6d5VI2ZRAtLm6i7chHhrUhD8N38oIk2Rc3E51pMHCod8jOR5iwhyWFBeF/iQ1pqUREy1izoLPBKzSC7RxOIvbLJMygvWuEIHU/l/L25nlroj+aJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0JGephDHPSBZyj1v0ruQepru5+yQB3Id1qI/XFq5iY=;
 b=iR1oxLUqS35W2n6cwljZCdqC/HQF8A6fsgylx2A35fkM8PEZ/wflHnbQDMUp3pjujYl8QrHOJrufAWjPBJZPXkHvXSYK7NG9nkUacG0Ih6T3UesxyP5max6r8Wk83B13YfzlhtggN/087x1YN/nSNMpTI+nCi5gKKn7MDcvwpOYzlM75+VAjrkftLEtCu4s9mLujHy6ipirG4O4yuNXM5z9Q5REYFI6p8WTpstvw5uyjZI8Ii2pCB/blO0an3aVDkLnvre6rmT4vqARo/yJi1irsYQjkbPcBySe/PbPTbXq8hN23akvnIFfTX1cn+oVKm3WmPwn+n8B00Sl/wVoPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0JGephDHPSBZyj1v0ruQepru5+yQB3Id1qI/XFq5iY=;
 b=vfz1yvGwbtRfx7m4OTiPMV8ng3PTn/5LBE+x6vYnlKxbuTx8YEfNfLa1H77Cqg7KYINiXQGcl8LGlLZtc5M9G1CFemLU5JLWKdtySzuVmemYZkR/P0bGDO9t54ocgYNd77HTyy/8oZNyudeO7XMkIDzGTP3DUf3vzva2r660Yq8=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16; Tue, 2 Feb 2021 08:51:11 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 08:51:10 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/5] misc: Add Add Synopsys DesignWare xData IP driver
Thread-Topic: [PATCH v3 0/5] misc: Add Add Synopsys DesignWare xData IP driver
Thread-Index: AQHWvlUnrEoqwwtzmk2HTCBmG0B2lKpFBCnA
Date:   Tue, 2 Feb 2021 08:51:10 +0000
Message-ID: <DM5PR12MB183527AA0FECE00D7A3D46DBDAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWM5ZjlkN2Y0LTY1MzMtMTFlYi05OGU2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxjOWY5ZDdmNi02NTMzLTExZWItOThlNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjE5NTEiIHQ9IjEzMjU2NzI5NDY4MTQw?=
 =?us-ascii?Q?MzM2MSIgaD0iVWREQmZ6VE1EUS9MdW9IdlFneGI2Nktramd3PSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?aHoxR01RUG5XQVZPWHEzcUFkTnZBVTVlcmVvQjAyOEFPQUFBQUFBQUFBQUFB?=
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
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cac6c91-e867-4393-5098-08d8c757b04a
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-microsoft-antispam-prvs: <DM5PR12MB25041EBC02386E0F40838FB5DAB59@DM5PR12MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dyNMejtqJdbShxX9ladgD1cLezkpeWoLZ3Seo86QLLYyA27MVs2RCDa7XXNGQjn4TaYRKFmgZrP0Ooja8MGPdrvI+JXfDsjX48qhUoTb0HJS5qA2SZp9vvk4BwSe9FPKHrFDgbTdB1as8lclqbwWcOUnHxQe8DTvkn/IN1niuO370XjWRQZJeqh8QhM5qKzLcmDANAVA9KwVRa9LcieyGABkD7oB2d/WgCaj9e7rf8whQjiHWewtwRufgLHCVPtnMDs5pLTb7lmn548/BZHyzlKOG7Hf4UYY0NoYvDLCBlCMN5J4geh4mYz9dTi00nfeK822k6blCkOT+D/kdwJcL+l9T48qELb4Q14sZ1klvs2HfPyFgB3swU/5TlW2jMH8R4CwFu8FZgbzPctcqs6AF1Nh7eD16ZkFedthYobaD2QwN8ezBBwvqo6MB/xImCCbU8lITjYBniSgpwVlyy+IOwU3Jnmv76+kLrQum4LomTSZLKrrzfXB2m2t1XeiSupcquC1ep4riyGCQqoUnfOHQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(39860400002)(366004)(9686003)(2906002)(66446008)(66556008)(55016002)(8936002)(71200400001)(66946007)(478600001)(8676002)(66476007)(52536014)(53546011)(6506007)(76116006)(5660300002)(186003)(64756008)(26005)(316002)(33656002)(83380400001)(7696005)(54906003)(86362001)(6916009)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0uW4MHQ0wTd/b/DOQh5oqTJxdJQGs/PaiPvbI6S1/gW2y/NPxt0Mt7EUFtoN?=
 =?us-ascii?Q?C6nhCGMz8U0mtme/IjMYGdBkwuz445bFsungR7oXtzskucDWOv+a4NlgFamG?=
 =?us-ascii?Q?wa3cY+ualof2sSTmrRE11PB+nkpvHOajhP6l0vuXlNx6DbC0DaEUIC/At5Cb?=
 =?us-ascii?Q?+3xy8xItvqJYCcXpWDa9Jk7NqslOXpf4HTRkrSq6fNX0xJMXw0SLuFgNmW+8?=
 =?us-ascii?Q?87Y9qGcIoRSnKTDCB5x8h19uMcyyELwclfmM/ZnoZ5+KrjBUtFErlacCjs0z?=
 =?us-ascii?Q?ntxr4RmQbKAW/R0K7h0XbAKQ1Tp4MLTIL4f69stGW9lofJB8vk95713rISoS?=
 =?us-ascii?Q?k5YhTn0t3ipG628OZ7R9FPwkoyl7y+O21oKl4w3tyFh3P+rY7LbPBIL4bpg7?=
 =?us-ascii?Q?Sol3VpmqWIoBbZViDuSqn7Vs0oE6LzZ1s9b114W34pyG7/VFTgMHUbGJvXwU?=
 =?us-ascii?Q?3d/Y90LN/sgSEca0dMwHVSgD0SHxAormwFA8ryihgkqmv64b9hurMUlgrV5B?=
 =?us-ascii?Q?gdGVoHfkYqrvYP+w20qhuHycvLmXG6LQmkfX4Rf16ob2Mydio48gbcndO0Gj?=
 =?us-ascii?Q?fVtQ6dISxw1Xfa5yywP9qEfQdOoBwDTf12zIh6au5HhOclLP4sn48rGri5EU?=
 =?us-ascii?Q?S1Wu+avUJmM/RzA7gxguvIpovRdIYgT2CBXhe5iL6XCJzBYepuwUmav7G0Il?=
 =?us-ascii?Q?V7UmlQWsGgiU7fBazOAPLrb3V99W2bQ2nE6G+ensz4DDv5myVVTVZUAiYB5q?=
 =?us-ascii?Q?MVQESdSyq7xJ7nOHS8YEjq9i1Biep+AcV6UliLv/32B8Ge5Kcu3z6zYJn0ov?=
 =?us-ascii?Q?+mCj7JzM8um2uLSAxguVOWXYwoZWrPDzE0yvzDZnNYcfDkv7oUfXhlowoTbt?=
 =?us-ascii?Q?XbSpdZ5FWtPEPriBvgw1uAzrI6p3CDFePOS0AhfFu51eiaenDWe4PhAoW/Ns?=
 =?us-ascii?Q?iD5nsFHdcLFwyTQkKK0aqRHPqURFtYsWSFaeak+9BiPSmu9bXwt9DrBZ0259?=
 =?us-ascii?Q?H1O87MY63mn2hWPO+pBH7d8Ma8bRlHYwTNc0R5dVjf38cDSje+KHK/Wp9hv7?=
 =?us-ascii?Q?qH6Qr4/7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cac6c91-e867-4393-5098-08d8c757b04a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 08:51:10.5508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpxgndfBZmdbGBd0T3FzE24Ajxm/M77kcApOx+AdFOUeDsrjuBgzr+jCL5hKyajFdwwfjmIjUsG8I7NPcUcyhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Just a kindly reminder.

On Thu, Nov 19, 2020 at 9:19:37, Gustavo Pimentel <gustavo@synopsys.com>=20
wrote:

> This patch series adds a new driver called xData-pcie for the Synopsys
> DesignWare PCIe prototype.
>=20
> The driver configures and enables the Synopsys DesignWare PCIe traffic
> generator IP inside of prototype Endpoint which will generate upstream
> and downstream PCIe traffic. This allows to quickly test the PCIe link
> throughput speed and check is the prototype solution has some limitation
> or not.
>=20
> Cc: Derek Kiernan <derek.kiernan@xilinx.com>
> Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>=20
> Changes:
>  V2: Rework driver according to Greg Kroah-Hartman feedback=20
>  V3: Fixed issues detected while running on 64 bits platforms
>=20
> Gustavo Pimentel (5):
>   misc: Add Synopsys DesignWare xData IP driver
>   misc: Add Synopsys DesignWare xData IP driver to Makefile
>   misc: Add Synopsys DesignWare xData IP driver to Kconfig
>   Documentation: misc-devices: Add Documentation for dw-xdata-pcie
>     driver
>   MAINTAINERS: Add Synopsys xData IP driver maintainer
>=20
>  Documentation/misc-devices/dw-xdata-pcie.rst |  40 +++
>  MAINTAINERS                                  |   7 +
>  drivers/misc/Kconfig                         |  11 +
>  drivers/misc/Makefile                        |   1 +
>  drivers/misc/dw-xdata-pcie.c                 | 379 +++++++++++++++++++++=
++++++
>  5 files changed, 438 insertions(+)
>  create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst
>  create mode 100644 drivers/misc/dw-xdata-pcie.c
>=20
> --=20
> 2.7.4


