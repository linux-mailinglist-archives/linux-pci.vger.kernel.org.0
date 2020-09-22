Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE0B273F08
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 11:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIVJ5c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 05:57:32 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:59352 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgIVJ5c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 05:57:32 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7F8E940350;
        Tue, 22 Sep 2020 09:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1600768651; bh=nAmdJlHIMb3V7X+R5APUwBC+IiJZFnaJnrFiqKV5ZNE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LaeYadOGy2V4pxZasIM7yu2vcN8+J2j/J8fTAKxQOQ7jxsXw2j/Q2w+kRF8gAYqOd
         bFokAEVGVOGUP44Ca3xHsLW2agOKIxpacR9creyAvbJnNqWaQ9mH7LFZehHMKzBxtw
         2udHpI/WsZrbFh2dxXhZ+9+P0/uIbI0DdRSepFLm9NcegSEEqQISSTQ2eSnvJvqmqF
         RoGx4rzTsgkWNZ0o9PSRwQY7w1wScm/2OPYwQ1xxrWco3gObB26vr7ADKHmT/y8cv2
         KOEZmiVDrC2T0rlvk5w8y8EtV6totUhpaN6aj4BAV4HcEsDqm/SqpNfPt5KaRAH+6N
         sAUDKcftzOTBw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1D395A0067;
        Tue, 22 Sep 2020 09:57:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C140A4014A;
        Tue, 22 Sep 2020 09:57:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="pg/8JW60";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj/9L+PcVb4Kbpz9jW71gvEl6TeoWJZJkjx1zpCBYoT+XeWfAi+Eqf8rgRez6EWXrla8/LdB0726jnV94qzKqYT2qXAug2TZ1oRC/pu3SUR04YZfdvXVLzqdBU5jH7qwodj/WC8X1tEBfKbgSCvjqabNWm+MadhFHED6NB3Nnyd+vUY8csYeM1NLhc/2b6utK+ZBSn51D+k6pPw5rkPP2Fmqtf3ePwOh11Eky5SS3y/UifPAmnQAu/fY5u/jNQHHE0JeF9zuGUrFiJQ13uSfeMTw2xJv1KHiv9NfIIS7As9rxh+qZvvGOZ8PuaH5bHOrFbyvPzsL9eKvFLTUV4bg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TNIAsZ0kuk+x0ycICGQfsM1JN67hoKz2WAw50LcNTY=;
 b=B6HsngzVOluRy43mm/JDBuU7WeMSX3KGVEDYFslYoeR/OYQkypz28YOAJv20ThcSYP9kAZEyCs/zakTUGXo2tK9FWdx8a0TtDQP3kLZrO48MFi6U2jT0sd2EFQl9x+gQ7udKnoUKVMGPW48mgNF+oAXQoEL7swBsG9p7RRCfmA7pBHnH3UAFRRxdHKqXd8nrBwZ2Ko3GUdbtKSQxYL6Nbk6RQLC+Av110TxMl+MjFSIU609Wr+Lj8N3BmpFw3r2bJYH5CERZJOMBDyzhjQKQsC3o+/F5bpZvYEMRyvdEUFDG7wG64FjvDRObc+AUK0jHwxUENZtQXPTcefS0lPDzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TNIAsZ0kuk+x0ycICGQfsM1JN67hoKz2WAw50LcNTY=;
 b=pg/8JW60T8Gnk3Ey8z2Eda6QFxU8XrtcGPYzUE+8O0TNLLdrAj1NfOgbBYgWZC7Z3ulY38Gp3eYoU2BuFefRsiVycjHiUQibBeB5JO2R6cgOlX6OBvdsAryKyyC3cLVqDbGip2JVQZGtxfQU+Wuy8VnnhZdX+5m1nHBC07w4nXY=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20; Tue, 22 Sep 2020 09:57:28 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::742c:dafa:9df7:4f4]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::742c:dafa:9df7:4f4%10]) with mapi id 15.20.3391.025; Tue, 22 Sep 2020
 09:57:28 +0000
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
Thread-Index: AQHWjTlxgisFVhsuDUiUuIdgE663/qltXfiAgACW1zCABQVXkIAAVhcAgAEhBXA=
Date:   Tue, 22 Sep 2020 09:57:28 +0000
Message-ID: <DM5PR12MB1276471D3E4B3ECB5BE1A798DA3B0@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <DM5PR12MB1276E15164E0793E623BACEBDA3A0@DM5PR12MB1276.namprd12.prod.outlook.com>
 <20200921163624.GA2117267@bjorn-Precision-5520>
In-Reply-To: <20200921163624.GA2117267@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTA0MDRiMDIyLWZjYmEtMTFlYS05OGNmLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFwwNDA0YjAyMy1mY2JhLTExZWEtOThjZi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjQzNDciIHQ9IjEzMjQ1MjQyMjQ2NTgy?=
 =?us-ascii?Q?NDcwNiIgaD0iMERNbGhjUlYvd1NQWEl5WVJaMTRwN2trc21VPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?Q0o3Zkd4cERXQWFnSHlqa21rL0RZcUFmS09TYVQ4TmdPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: b7a15b53-e845-444a-9acc-08d85eddea7a
x-ms-traffictypediagnostic: DM5PR12MB1947:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1947D71DFFEE83021528D93BDA3B0@DM5PR12MB1947.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:370;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hJ1AoHDMYS5ijpS6qpJS9cybck2LgW2CPVormmRlLD1ccZPIcyMoMC+yGqhPPVCHd8oUdLnJUk82F+WC0kopv4jCdZQRT6PC+s8lo8lyjaOPFHroBKYzM5Zqv3m0n6zrLvGYxYf2ioSlPMBQnKy3z9OctEkcff0wqQskYRkRdeyBsqrkmjmnh0ehTVgW9/h8riN51GahPpcPT5vOoDcali7aImeA2UTwb4UgDSGdZ7EXzeXGGWRFKRWLath3DYDxBzF2AK1+rVePR3H3i6kK/k+l0uwwRVT4faKKAL7vlo4dZXBgsnxzJoO9H8uMX+7/+JGaJXIJVcSBuoCcrEnQ7TBX1JoWSiF06yVqzfapICaIVwtpBIf6eluvBPYFAKfT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(316002)(186003)(107886003)(33656002)(53546011)(9686003)(86362001)(7696005)(478600001)(8936002)(26005)(83380400001)(54906003)(5660300002)(8676002)(6506007)(6916009)(52536014)(71200400001)(55016002)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(4326008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0eRlg1Dt+ojkJAx0Gz8ipaWShJpjYU9/KiGmP8OeuSfKIJcNFLeUK5OKAnDJOnpuN3uSiUtJOB4dceeVA5v7Cg9ThQOnBDXTeorKnCimS6gtwS/zQdnEIYqdpcUaYs2u+bMXzIp6zQKZ87vF22KObfMqLKJda1fXyIt3C40OpeN2oPNDyS+nVNA5TYnn+K0vGr1lg+wDOseVIQoqQRmJPGR0BRNQ4B4UkI8Nd7Z3IzGjjaBRON2nY9++p9iGDLxgDkzIPEv6aGJNshHiMrnmNjkvgHSsns3du34hoKSOM2d1V7CrnKqgXBr+WlGXqFGEwfLHzgRHODCiG6hY9nf99EUG/UpGyK44Xm1IVotpDyvcd4LtA34+sgItscyn8q5E4wbUNaWyHiHdzNnTjAl3HKQa946Kso4XwkV4A9dMPF/F6ynrKmQfsTQ0lUQz7nANzCy/KTDCW11EMEYndx5sw6T/dsmhtsxdFkQ/G8QgtZbA+oHCi3cdH8GDEHNCiDQrtNdwN5uyj3WK/RML8TGvuF11E4ZkoEnMbLKKfUVWKPsM2cn7zUwMbNnNHwEpWOyBrmRjl3R/mlAP8KvQa09ZEnvaNpzMG18zfPUI92hIYvhwIH/cZjgkRutbkmHiu+lsh9QEow4HfuowXK2ieWhY0Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1276.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a15b53-e845-444a-9acc-08d85eddea7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 09:57:28.6932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OfOjwcjR8GVKCGLflr6j8R9WXmTiPoaQr061aMblOWrI8zKLnFpn+sXUL0iCEH2U40Y5kVuqoETxVJDJ5iUICg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1947
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 21, 2020 at 17:36:24, Bjorn Helgaas <helgaas@kernel.org>=20
wrote:

> On Mon, Sep 21, 2020 at 11:30:48AM +0000, Gustavo Pimentel wrote:
> > On Fri, Sep 18, 2020 at 8:15:48, Gustavo Pimentel <gustavo@synopsys.com=
>=20
> > wrote:
> >=20
> > > On Thu, Sep 17, 2020 at 22:47:59, Bjorn Helgaas <helgaas@kernel.org>=
=20
> > > wrote:
> > >=20
> > > > On Thu, Sep 17, 2020 at 11:28:03PM +0200, Gustavo Pimentel wrote:
> > > > > Fixes warning given by executing "make C=3D2 drivers/pci/"
> > > > >=20
> > > > > Sparse output:
> > > > > CHECK drivers/pci/controller/dwc/pcie-designware.c
> > > > >  drivers/pci/controller/dwc/pcie-designware.c:432:52: warning:
> > > > >  cast truncates bits from constant value (ffffffff7fffffff become=
s
> > > > >  7fffffff)
> > > > >=20
> > > > > Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > > Cc: Joao Pinto <jpinto@synopsys.com>
> > > > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drive=
rs/pci/controller/dwc/pcie-designware.c
> > > > > index 3c3a4d1..dcb7108 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > @@ -429,7 +429,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci,=
 int index,
> > > > >  	}
> > > > > =20
> > > > >  	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> > > > > -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
> > > > > +	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~0 & ~PCIE_ATU_ENABL=
E);
> > > >=20
> > > > But this cure is worse than the disease.  If this is the only way t=
o
> > > > fix the warning, I think I'd rather see the warning ;)  I'm hopeful
> > > > there's a nicer way, but I'm not a language lawyer.
> > >=20
> > > I don't like it either, I tried to see if were another way a clean wa=
y=20
> > > that didn't imply creating a temporary variable, but I didn't found.
> > > The issue here is that PCIE_ATU_ENABLE is defined as BIT(31) on=20
> > > pcie-designware.h. The macro BIT changes its size from u32 to u64=20
> > > according to the architecture and by inverting the value on the 64 bi=
ts=20
> > > architecture causes the value to be transformed into 0xffffffff7fffff=
ff.
> > >=20
> > > The other possibility implies the creation of a temporary u32 variabl=
e to=20
> > > overcome this issue. It's a little bit overkill, but please share you=
r=20
> > > thoughts about it.
> > >=20
> > > void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
> > >                          enum dw_pcie_region_type type)
> > >  {
> > > -       int region;
> > > +       u32 atu =3D PCIE_ATU_ENABLE;
> > > +       u32 region;
> > >=20
> > >         switch (type) {
> > >         case DW_PCIE_REGION_INBOUND:
> > > @@ -429,7 +430,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int=
=20
> > > index,
> > >         }
> > >=20
> > >         dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> > > -       dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
> > > +       dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~atu);
> > >  }
> >=20
> > Hi Bjorn,
> >=20
> > What is your verdict on this?
> > If you prefer this approach I can send the corresponding patch.
>=20
> Having a u32 temporary with no obvious reason for existence is kind of
> unpleasant, too.  Surely this is a common situation?  Maybe other
> instances just live with the warning, too?
>=20
> I'd say leave this alone for now.

Hi Bjorn,

After resting about this topic, I found a easy and clean solution that=20
will please for both of us.

-       dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
+       dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~(u32)PCIE_ATU_ENABLE);

Basically I changed the cast instruction position, this way the=20
PCIE_ATU_ENABLE flag defined BIT(31) on a 64 bits architecture will be=20
casted into a u32 and the binary one's complement instruction will act=20
upon a 32bits variable, avoiding that error.

I'll send the patch for it right away.

-Gustavo

>=20
> Bjorn


