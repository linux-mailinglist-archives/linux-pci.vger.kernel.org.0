Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305962ADA2B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Nov 2020 16:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbgKJPSF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 10:18:05 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:39668 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730594AbgKJPSC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2020 10:18:02 -0500
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C7FEAC00AB;
        Tue, 10 Nov 2020 15:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605021481; bh=dcoxAkfH+z4y28tUEYWjXwRbzROC0UGRnJsnLbVE3fk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=TvmkSSr1cDhZQNAbSWCIw+ulbFDCAuCh2u/4e5AZngmRzPXpVXZUalEaAneokaaQY
         YqBJmXJuQHsctdCjLv1tABdBsupsCTdIJjio3bbZEiOIJ8edT2GYO/6CMDexxrhTw6
         uIwTvg6v9Z59zbVkpeIezd8R168eaCGjrsYRx5Q+2hBvx0ewiAaMdWQ+Xmgyee6qQq
         aogKIGZttampDnOWDBhkzJlV9wqMcOL3rRbXQDoWGpPJYHC4d2GfQOB+f0b3v35DeB
         U7sRtIR1sPgryVZtAIYiM5x23HkqZaHEtukm4p9dES1uaMqw7GwBZTQy3SI4T4smGT
         yEUbiO0j82Pew==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 81260A0077;
        Tue, 10 Nov 2020 15:17:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 778E9800C8;
        Tue, 10 Nov 2020 15:17:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Lj23nugY";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdqgigOdcG5mWa9u4kLSfPj5L9U+4pevg45ftsVznNtqIursBZfZic8TvXNzOqGnzDiKFk1UyZzx6DP4NoIA2J6TWqtS6Ci7pi0sMEQEQMOt+G672zoPNAu3qTQZ48k0Ibpg1LGpqZfS34d57Te0Gvd2VXN4H6nQW21aacIl8rfaHRSqgijGhou0C824vucFmmUrxOl4YiitAXQ54ALaimoGu3FAzfuMcVz94ZNh9xFKg1ve5CGjgG/Uj8MQQqBpMYWloIemd4bae9o+Y9oY0mZXU5ZiqCEQC2QTRkvGz+ey/gBtiDp7uTri5lXgDYK7N3e9tCbW/bqskcAjFvvOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1Z0yWRs0CaUTUHldZqF2WEJkuTiV65K+m/ttqF4e0U=;
 b=P/UiwXgx0MzbHKkLz58YNdWXqJc5yqFVse4/7C0BB+YLkSXtbl5GzJ/JsZTX+rkK/Ea7YRjoD/CUwIQtPKtB9ZyQNr8gIhh88fXVMBv8kKkGKvvRjw99E4mh7lCduTR7UzlZi+5lzFEBx1yA+OZKANH25hc0m6Mx4hQdHiWycEc7YPuaxUXaTp8FEnJ4f3xGTCROsoir+mnIsG+5pdCdsY7yFuLGrP0kFhNMk1dE8iXNB7KcDHJPq33AQvxyeIQyWWxTHAFz+/jO6wxyoPc1jtebc61ZN+fYLISFyc89fAJI4LNRUxdjJO0O54F3gKZIKAfdzPAB20vpFOyZ5nybcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1Z0yWRs0CaUTUHldZqF2WEJkuTiV65K+m/ttqF4e0U=;
 b=Lj23nugYbP46b2zCoXJmUPI4ajkcss0DXxv+m8xwWRN4wEk7VW0XSMD89L+jA3+vXtOnFXaMiYCsLFQvnAZX/o4wAk62AZn3qT4kChO5TGjUK1MwqFJTy0aBC+CR4WX8uopZb4nG6YmtrxOcilPvd0/SZqkT3NBKwhlaY2ZWhXE=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.23; Tue, 10 Nov 2020 15:17:54 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::48e2:11e1:d2f:d12f]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::48e2:11e1:d2f:d12f%8]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 15:17:54 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 1/5] misc: Add Synopsys DesignWare xData IP driver
Thread-Topic: [PATCH 1/5] misc: Add Synopsys DesignWare xData IP driver
Thread-Index: AQHWriel+eqJsOA+OU+SbQ480k3k0qnAH+gAgAFbN0A=
Date:   Tue, 10 Nov 2020 15:17:54 +0000
Message-ID: <DM5PR12MB183554F4B1DF1AEA157401BFDAE90@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
 <f60c0cbb87bd1505669bf0cf62c56cbaa8d4c1d2.1603998630.git.gustavo.pimentel@synopsys.com>
 <20201109173108.GA2371851@kroah.com>
In-Reply-To: <20201109173108.GA2371851@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWU0NjEyYjUxLTIzNjctMTFlYi05OGQ2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxlNDYxMmI1Mi0yMzY3LTExZWItOThkNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjEzNDgxIiB0PSIxMzI0OTQ5NTA3MTE3?=
 =?us-ascii?Q?ODgzNzEiIGg9IllOcW9JQmFIS3Y1aWRTYjh6czhjUXJaWVMxYz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFB?=
 =?us-ascii?Q?QlRnN1duZExmV0FScWFya2NvTVNuYUdwcXVSeWd4S2RvT0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBTnJTVjNnQUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0Fi?=
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
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6e35797-bd6f-4db8-dad1-08d8858bcc2b
x-ms-traffictypediagnostic: DM6PR12MB3083:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3083358CEFAB0BDD930EDC40DAE90@DM6PR12MB3083.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C9o9EDZ9WixUg+iVf3AzKo/W66FKEPUMQWysDhkDvvQd+3kZvnC6oRyg48nRC6Ms12Y67Alenm104FBozgzhj9/214/5zSvl3xADp98NEp+MKTuwlpuggz1b3b77jr3yNOjHwWb20P945dVy2SILwZEwRj1r/44uLXtZ/4nV5vD4D6vbABD60p8ug2k2v+HZH8F/fzj/sCcfNTlZtdlNVr/WGOOEcZCFNBMR9ZqtCrCmyKInmttyaXh2LFND203C1X1k18dRrXDcxUosLz+IIvH6YgaSKLpOp3kXbdCquh0czVr2vPHf1SK1ESZs26wpQzAS6cqOZg/fXUgbZ2YZwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(53546011)(478600001)(186003)(55016002)(54906003)(7696005)(66556008)(33656002)(6506007)(86362001)(316002)(83380400001)(2906002)(26005)(9686003)(8676002)(5660300002)(76116006)(8936002)(52536014)(64756008)(66946007)(30864003)(66476007)(66446008)(4326008)(6916009)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: volVJu09rZv0C3OateO5KPmbQ/4u8+Pw8FcocudFdVJBDmLBnXSfId2TWbzKhFA5Ih+I1NMCtWD4Cz+AZyQ9EqSxqK4J5OKevSeaDVRknMH0zOdtWp9x6NDqu8MsLlf4RIaOIGaXd8cq1EEBY/zrACnXMY3KwXCEkHer0Yo5Vs9FPJeADrnAjp9VZ0vr2yO0/2wbHrOdbjKaByEauweUDzlw5qN6jiSolSCd+f1Bxm0Uxgzpwtfj41q0FmrdH77vHX+ILXUuYFQ0TX1HnyEbJqmJYMXL+p8dg6TtaSF3jiogo1PusCQth5at5l6taS1LPCRX0jMT29wEvaCY6M6HtWNQEyAu1b75DdhpK4uw7+gwewkvux2o1fDJN33kixfyvftjinQRvXmPVdmYiteb/RkJ6zHJpf8K1gJadPyVJQoTm0v5FnA5GuIw5mq4nGmJsvtrf5sVwUoE53FQjCba1kDkk8PcBUfz6NPqQbDRrDv1jDgTSPszyEwtyBAv8WdlfB9N2f7AzmWAkCo+5G0+xkki3wG8nl28wm9JHCfFCTPuMkUG4tgsuxK/QvItpS1I3RMximCjUopldT2Pr0w14CYZT5dKunifrKY4rEH/4UWGTyCtNZNUcJ/sqL2Mq2QtctJ/MDGOeMsQsmdQdfmn6w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e35797-bd6f-4db8-dad1-08d8858bcc2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 15:17:54.3930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqkXStbjMNNDYM9GUQz0inZp1AfcZDgo4qWCBjMv+5wDRFL54HIVI5FgibCIm6rQhe0iIYfc3HEK+hy/fXiqlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Greg,

On Mon, Nov 9, 2020 at 17:31:8, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> wrote:

> On Thu, Oct 29, 2020 at 08:13:36PM +0100, Gustavo Pimentel wrote:
> > Add Synopsys DesignWare xData IP driver. This driver enables/disables
> > the PCI traffic generator module pertain to the Synopsys DesignWare
> > prototype.
> >=20
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> >  drivers/misc/dw-xdata-pcie.c | 395 +++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 395 insertions(+)
> >  create mode 100644 drivers/misc/dw-xdata-pcie.c
> >=20
> > diff --git a/drivers/misc/dw-xdata-pcie.c b/drivers/misc/dw-xdata-pcie.=
c
> > new file mode 100644
> > index 00000000..b529dae
> > --- /dev/null
> > +++ b/drivers/misc/dw-xdata-pcie.c
> > @@ -0,0 +1,395 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2020 Synopsys, Inc. and/or its affiliates.
> > + * Synopsys DesignWare xData driver
> > + *
> > + * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > + */
> > +
> > +#include <linux/pci-epf.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/delay.h>
> > +#include <linux/pci.h>
> > +
> > +#define DW_XDATA_EP_MEM_OFFSET		0x8000000
> > +
> > +static DEFINE_MUTEX(xdata_lock);
> > +
> > +struct dw_xdata_pcie_data {
> > +	/* xData registers location */
> > +	enum pci_barno			rg_bar;
> > +	off_t				rg_off;
> > +	size_t				rg_sz;
> > +};
> > +
> > +static const struct dw_xdata_pcie_data snps_edda_data =3D {
> > +	/* xData registers location */
> > +	.rg_bar				=3D BAR_0,
> > +	.rg_off				=3D 0x00000000,   /*   0 Kbytes */
> > +	.rg_sz				=3D 0x0000012c,   /* 300  bytes */
> > +};
> > +
> > +static int dw_xdata_command_set(const char *val, const struct kernel_p=
aram *kp);
> > +static const struct kernel_param_ops xdata_command_ops =3D {
> > +	.set =3D dw_xdata_command_set,
> > +};
> > +
> > +static char command;
> > +module_param_cb(command, &xdata_command_ops, &command, 0644);
> > +MODULE_PARM_DESC(command, "xData command");
>=20
> Please do not add new module parameters.  This is not the 1990's, we
> have better ways of getting data into a driver.

Ok, I'll move this towards into the future, lol I'll use debugfs instead.

>=20
> > +
> > +static struct pci_dev *priv;
>=20
> You are only going to support one PCI device in the system at once?
> That's not needed, again, this isn't the 1990's, please use
> device-specific data and you will be fine, no "global" variables needed.
>=20
> > +
> > +union dw_xdata_control_reg {
> > +	u32 reg;
> > +	struct {
> > +		u32 doorbell    : 1;			/* 00 */
> > +		u32 is_write    : 1;			/* 01 */
> > +		u32 length      : 12;			/* 02..13 */
> > +		u32 is_64       : 1;			/* 14 */
> > +		u32 ep		: 1;			/* 15 */
> > +		u32 pattern_inc : 1;			/* 16 */
> > +		u32 ie		: 1;			/* 17 */
> > +		u32 no_addr_inc : 1;			/* 18 */
> > +		u32 trigger     : 1;			/* 19 */
> > +		u32 _reserved0  : 12;			/* 20..31 */
> > +	};
> > +} __packed;
>=20
> What is the endian-ness of these structures?  That needs to be defined
> somewhere, right?

What you suggest? Use __le32 instead of u32? Or some comment referring=20
the expected endianness?

>=20
> > +
> > +union dw_xdata_status_reg {
> > +	u32 reg;
> > +	struct {
> > +		u32 done	: 1;			/* 00 */
> > +		u32 _reserved0  : 15;			/* 01..15 */
> > +		u32 version     : 16;			/* 16..31 */
> > +	};
> > +} __packed;
> > +
> > +union dw_xdata_xperf_control_reg {
> > +	u32 reg;
> > +	struct {
> > +		u32 _reserved0  : 4;			/* 00..03 */
> > +		u32 reset       : 1;			/* 04 */
> > +		u32 enable      : 1;			/* 05 */
> > +		u32 _reserved1  : 26;			/* 06..31 */
> > +	};
> > +} __packed;
> > +
> > +union _addr {
> > +	u64 reg;
> > +	struct {
> > +		u32 lsb;
> > +		u32 msb;
> > +	};
> > +};
> > +
> > +struct dw_xdata_regs {
> > +	union _addr addr;				/* 0x000..0x004 */
> > +	u32 burst_cnt;					/* 0x008 */
> > +	u32 control;					/* 0x00c */
> > +	u32 pattern;					/* 0x010 */
> > +	u32 status;					/* 0x014 */
> > +	u32 RAM_addr;					/* 0x018 */
> > +	u32 RAM_port;					/* 0x01c */
> > +	u32 _reserved0[14];				/* 0x020..0x054 */
> > +	u32 perf_control;				/* 0x058 */
> > +	u32 _reserved1[41];				/* 0x05c..0x0fc */
> > +	union _addr wr_cnt;				/* 0x100..0x104 */
> > +	union _addr rd_cnt;				/* 0x108..0x10c */
> > +} __packed;
>=20
> Why packed?  Does this cross the user/kernel boundry?  If so, please use
> the correct data types for the (__u32 not u32).

The idea behind this was to be a *mask* of the HW registers. By using the=20
packed attribute would ensure that the struct would be matching with what=20
is defined on the HW.
Since the used unions definitions are already packed, maybe this packed=20
attribute on this structure is not needed. What this what you meant?

>=20
>=20
> > +
> > +struct dw_xdata_region {
> > +	phys_addr_t paddr;				/* physical address */
> > +	void __iomem *vaddr;				/* virtual address */
> > +	size_t sz;					/* size */
> > +};
> > +
> > +struct dw_xdata {
> > +	struct dw_xdata_region rg_region;		/* registers */
> > +	size_t max_wr_len;				/* max xfer len */
> > +	size_t max_rd_len;				/* max xfer len */
> > +};
> > +
> > +static inline struct dw_xdata_regs __iomem *__dw_regs(struct dw_xdata =
*dw)
> > +{
> > +	return dw->rg_region.vaddr;
> > +}
> > +
> > +#define SET(dw, name, value) \
> > +	writel(value, &(__dw_regs(dw)->name))
> > +
> > +#define GET(dw, name) \
> > +	readl(&(__dw_regs(dw)->name))
>=20
> Just write out readl() and writel() in the driver, it makes more sense
> to anyone trying to read the code.

Ok, that's curious. I made this exactly to turn the code more readable.=20
I'm okay to put like you said, no problem.

>=20
> > +
> > +#ifdef CONFIG_64BIT
> > +#define SET_64(dw, name, value) \
> > +	writel(value, &(__dw_regs(dw)->name))
> > +
> > +#define GET_64(dw, name) \
> > +	readq(&(__dw_regs(dw)->name))
> > +#endif /* CONFIG_64BIT */
>=20
> No need for this #ifdef, right?
>=20
>=20
> > +
> > +static void dw_xdata_stop(struct pci_dev *pdev)
> > +{
> > +	struct dw_xdata *dw =3D pci_get_drvdata(pdev);
> > +	u32 tmp =3D GET(dw, burst_cnt);
> > +
> > +	if (tmp & 0x80000000) {
> > +		tmp &=3D 0x7fffffff;
> > +		SET(dw, burst_cnt, tmp);
> > +	}
> > +}
> > +
> > +static void dw_xdata_start(struct pci_dev *pdev, bool write)
> > +{
> > +	struct dw_xdata *dw =3D pci_get_drvdata(pdev);
> > +	union dw_xdata_control_reg control;
> > +	union dw_xdata_status_reg status;
> > +
> > +	/* Stop first if xfer in progress */
> > +	dw_xdata_stop(pdev);
> > +
> > +	/* Clear status register */
> > +	SET(dw, status, 0x0);
> > +
> > +	/* Burst count register set for continuous until stopped */
> > +	SET(dw, burst_cnt, 0x80001001);
> > +
> > +	/* Pattern register */
> > +	SET(dw, pattern, 0x0);
> > +
> > +	/* Control register */
> > +	control.reg =3D 0x0;
> > +	control.doorbell =3D true;
> > +	control.is_write =3D write;
> > +	if (write)
> > +		control.length =3D dw->max_wr_len;
> > +	else
> > +		control.length =3D dw->max_rd_len;
> > +	control.pattern_inc =3D true;
> > +	control.no_addr_inc =3D true;
> > +	SET(dw, control, control.reg);
> > +
> > +	usleep_range(100, 150);
> > +
> > +	status.reg =3D GET(dw, status);
> > +	if (!status.done)
> > +		pci_info(pdev, "xData: started %s direction\n",
> > +			 write ? "write" : "read");
>=20
> Don't be noisy if all is well.  You have a lot of "debugging" messages
> in this driver, please drop them all down to the debug level, or just
> remove them.

I understand and I agree with that, but this driver will be only used to=20
assist a HW bring up. It's focus will be only on FPGA prototype=20
solutions, restricted to only some cases. This help messages will be=20
important for a HW design or a solutions tester to find a problem root=20
cause.
In this case can this messages be an exception to the rule?

>=20
>=20
> > +}
> > +
> > +static u64 dw_xdata_perf_meas(struct pci_dev *pdev, u64 *wr, u64 *rd)
> > +{
> > +	struct dw_xdata *dw =3D pci_get_drvdata(pdev);
> > +
> > +	#ifdef CONFIG_64BIT
> > +		*wr =3D GET_64(dw, wr_cnt.reg);
> > +
> > +		*rd =3D GET_64(dw, rd_cnt.reg);
> > +	#else /* CONFIG_64BIT */
> > +		*wr =3D GET(dw, wr_cnt.msb);
> > +		*wr <<=3D 32;
> > +		*wr |=3D GET(dw, wr_cnt.lsb);
> > +
> > +		*rd =3D GET(dw, rd_cnt.msb);
> > +		*rd <<=3D 32;
> > +		*rd |=3D GET(dw, rd_cnt.lsb);
> > +	#endif /* CONFIG_64BIT */
> > +
> > +	return jiffies;
>=20
> Why are you returning jiffies???

The goal of this function was to acquire the number of packets on a=20
determine instant, returning jiffies was a pretty way of having all the=20
info grouped. But I'll move this outside of the function.
>=20
>=20
> > +}
> > +
> > +static u64 dw_xdata_perf_diff(u64 *m1, u64 *m2, u64 time)
> > +{
> > +	u64 rate;
> > +
> > +	rate =3D (*m1 - *m2);
> > +	rate *=3D (1000 * 1000 * 1000);
> > +	rate >>=3D 20;
> > +	rate =3D DIV_ROUND_CLOSEST_ULL(rate, time);
> > +
> > +	return rate;
> > +}
> > +
> > +static void dw_xdata_perf(struct pci_dev *pdev)
> > +{
> > +	struct dw_xdata *dw =3D pci_get_drvdata(pdev);
> > +	union dw_xdata_xperf_control_reg control;
> > +	u64 wr[2], rd[2], time[2], rate[2], diff;
> > +
> > +	/* First measurement */
> > +	control.reg =3D 0x0;
> > +	control.enable =3D false;
> > +	SET(dw, perf_control, control.reg);
> > +	time[0] =3D dw_xdata_perf_meas(pdev, &wr[0], &rd[0]);
> > +	control.enable =3D true;
> > +	SET(dw, perf_control, control.reg);
> > +
> > +	/* Delay 100ms */
> > +	mdelay(100);
> > +
> > +	/* Second measurement */
> > +	control.reg =3D 0x0;
> > +	control.enable =3D false;
> > +	SET(dw, perf_control, control.reg);
> > +	time[1] =3D dw_xdata_perf_meas(pdev, &wr[1], &rd[1]);
> > +	control.enable =3D true;
> > +	SET(dw, perf_control, control.reg);
> > +
> > +	/* Calculations */
> > +	diff =3D jiffies_to_nsecs(time[1] - time[0]);
> > +
> > +	/* Write performance */
> > +	rate[0] =3D dw_xdata_perf_diff(&wr[1], &wr[0], diff);
> > +
> > +	/* Read performance */
> > +	rate[1] =3D dw_xdata_perf_diff(&rd[1], &rd[0], diff);
> > +
> > +	pci_info(pdev,
> > +		 "xData: time=3D%llu us, write=3D%llu MB/s, read=3D%llu MB/s\n",
> > +		 diff, rate[0], rate[1]);
>=20
> Again, be quiet.
>=20
> > +}
> > +
> > +static int dw_xdata_command_set(const char *val, const struct kernel_p=
aram *kp)
> > +{
> > +	int ret =3D -EBUSY;
> > +
> > +	mutex_lock(&xdata_lock);
> > +	if (!priv)
> > +		goto err;
> > +
> > +	ret =3D param_set_charp(val, kp);
> > +	if (ret)
> > +		goto err;
> > +
> > +	switch (*val) {
> > +	case 'w':
> > +	case 'W':
> > +		pci_info(priv, "xData: requested write transfer\n");
> > +		dw_xdata_start(priv, true);
> > +		break;
> > +	case 'r':
> > +	case 'R':
> > +		pci_info(priv, "xData: requested read transfer\n");
> > +		dw_xdata_start(priv, false);
> > +		break;
> > +	case 'p':
> > +	case 'P':
> > +		pci_info(priv, "xData: requested performance analysis\n");
> > +		dw_xdata_perf(priv);
> > +		break;
> > +	default:
> > +		pci_info(priv, "xData: requested stop any transfer\n");
> > +		dw_xdata_stop(priv);
> > +		break;
> > +	}
> > +
> > +err:
> > +	mutex_unlock(&xdata_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int dw_xdata_pcie_probe(struct pci_dev *pdev,
> > +			       const struct pci_device_id *pid)
> > +{
> > +	const struct dw_xdata_pcie_data *pdata =3D (void *)pid->driver_data;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct dw_xdata *dw;
> > +	u64 addr;
> > +	int err;
> > +
> > +	priv =3D NULL;
> > +
> > +	/* Enable PCI device */
> > +	err =3D pcim_enable_device(pdev);
> > +	if (err) {
> > +		pci_err(pdev, "enabling device failed\n");
> > +		return err;
> > +	}
> > +
> > +	/* Mapping PCI BAR regions */
> > +	err =3D pcim_iomap_regions(pdev, BIT(pdata->rg_bar), pci_name(pdev));
> > +	if (err) {
> > +		pci_err(pdev, "xData BAR I/O remapping failed\n");
> > +		return err;
> > +	}
> > +
> > +	pci_set_master(pdev);
> > +
> > +	/* Allocate memory */
> > +	dw =3D devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
> > +	if (!dw)
> > +		return -ENOMEM;
> > +
> > +	/* Data structure initialization */
> > +	dw->rg_region.vaddr =3D pcim_iomap_table(pdev)[pdata->rg_bar];
> > +	if (!dw->rg_region.vaddr)
> > +		return -ENOMEM;
> > +
> > +	dw->rg_region.vaddr +=3D pdata->rg_off;
> > +	dw->rg_region.paddr =3D pdev->resource[pdata->rg_bar].start;
> > +	dw->rg_region.paddr +=3D pdata->rg_off;
> > +	dw->rg_region.sz =3D pdata->rg_sz;
> > +
> > +	dw->max_wr_len =3D pcie_get_mps(pdev);
> > +	dw->max_wr_len >>=3D 2;
> > +
> > +	dw->max_rd_len =3D pcie_get_readrq(pdev);
> > +	dw->max_rd_len >>=3D 2;
> > +
> > +	SET(dw, RAM_addr, 0x0);
> > +	SET(dw, RAM_port, 0x0);
> > +
> > +	addr =3D dw->rg_region.paddr + DW_XDATA_EP_MEM_OFFSET;
> > +#ifdef CONFIG_64BIT
> > +	SET_64(dw, addr.reg, addr);
> > +#else /* CONFIG_64BIT */
> > +	SET(dw, addr.lsb, lower_32_bits(addr));
> > +	SET(dw, addr.msb, upper_32_bits(addr));
> > +#endif /* CONFIG_64BIT */
> > +	pci_info(pdev, "xData: target address =3D 0x%.16llx\n", addr);
> > +
> > +	pci_info(pdev, "xData: wr_len=3D%zu, rd_len=3D%zu\n",
> > +		 dw->max_wr_len * 4, dw->max_rd_len * 4);
>=20
> Drivers need to be quiet...
>=20
> thanks,
>=20
> greg k-h

-Gustavo

