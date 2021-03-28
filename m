Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460AA34BF2A
	for <lists+linux-pci@lfdr.de>; Sun, 28 Mar 2021 23:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhC1VHP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Mar 2021 17:07:15 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:55124 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231318AbhC1VG5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Mar 2021 17:06:57 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6194CC008C;
        Sun, 28 Mar 2021 21:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616965617; bh=UStOgYUwatnZteisRqQJn64hzkpFAVoAe5oLwUM9jeE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=T94jHaCDKR4PXqDh1G1XVW2XHFo+oGBfs9cCtgzoCBBWZIo+ThFYAS7YfJkJC0ynA
         ZcfUmI4CabFNP2A42Uy+nDVjyHJgGw1pvZMXayjxx2r6hxEpvqxC6Ynm79s5bPPGtx
         5qxLqRoTXEvqu50jS31S2kTyiDweNUx/cQ3FaNs0RTQWqMuB4+3JZrjOlJgvGkag+S
         vsU+6pZWFzF/CC2l44ThtdekslilbUm5qmQ2Nu/dV3k+t55lsVVW1WV5+5Xe8ERupG
         eeVFmU/+BMI5INITl3K8PMcgEKZ4mZv1nz2cA+4hdaBX5lbqoImoNc1n2bUL+nz29T
         5CQKKxuopWavg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 59D2BA0077;
        Sun, 28 Mar 2021 21:06:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 12B5B800C1;
        Sun, 28 Mar 2021 21:06:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="TcaadIDa";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXvNmr3Ro2YgKaVP0rz2HUcIadKy4yWoTgV2OzD9xz26JsdtEz7tiHTOBlQ+FsTLX7eCE5NRL0GplPXICUIrpf2/+tYp+MIzILRnAhswawXuf5sp+nDWv87n/fsqq4LjJ5AvVag252OvMnO/G7Di28xNmzvEkrwF572Pg0NRpFHiJbWiNUxZgrK3CGBLwAFGxBk7yPv6MoM1uTpr1ZzlLq4GH+FvQTfBixz79q6HM8LiRQZDxibhB0X8wbXYE8GQv+yGlFD4RYM2x4BMgUz9QzURStv3cbVXzH8nUhEDZNWRhMn79wewtxLkCtP9qFsP7i8DPhnrj/bztz49oZpO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvNLRVGNvqSrvfJDRHow5WttgkKZZCwQHbbjZRE3lIM=;
 b=Js5YWRYHgarG7YhxkmNg7aU5UohmZvOmZV1oTBIMRRZR+j9QbLHG74hNrgbiO1UZKMd5aF7Ih8PUht7VAgXcNBm7VdzyM3qmbGTu8ifvq3Zs4iJYbDZCd8dXEd1saPMzHfRVIuuD9wnOO9UN1glw+khZ9cg95B/fPjtKEA7Yn33yyrwSwsqSrcRYpSr8zA2U2A2zivJ+trlNkBGa1DO9qxmrjwa5xS2PXYn/XliRdrzOYzgj6ya//3YsrCRx9jTBnzK9GwaeYEtoDXf+bFpyEjMt86iCT5B6sNBx7vncBgfLpS+N9lNLdtPPnd6Kr4aHaE8WXnz7xgNWkvjuHuPpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvNLRVGNvqSrvfJDRHow5WttgkKZZCwQHbbjZRE3lIM=;
 b=TcaadIDahrdzdvqqPIM4GMO/dNDvLA0+viTF9q3iniGkWOzP1+mKgYblRgmEcaSUJKGp7hs1SE+liK/x1HuLoch6GAEHfwJNQoAtzyBqvG7v0ICXG1qPJUgOIL8HmVrG6lxf/1X8QU4EZ4pYIysrUtQc+1u4Q8+xB05w+fG8IQM=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (10.175.88.9) by
 DM5PR1201MB2504.namprd12.prod.outlook.com (10.172.87.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25; Sun, 28 Mar 2021 21:06:48 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3977.032; Sun, 28 Mar
 2021 21:06:48 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
Subject: RE: [PATCH v7 1/5] misc: Add Synopsys DesignWare xData IP driver
Thread-Topic: [PATCH v7 1/5] misc: Add Synopsys DesignWare xData IP driver
Thread-Index: AQHXIrZG4Qxt2UUhoESw4A9mCnQJL6qZXBWAgABDN4A=
Date:   Sun, 28 Mar 2021 21:06:47 +0000
Message-ID: <DM5PR12MB18356331B588B123FC0E1F56DA7F9@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
 <726feba26faebc2620b36d57859aa526bef1c0b9.1616814273.git.gustavo.pimentel@synopsys.com>
 <YGB7SfmrJkLLoL3B@kroah.com>
In-Reply-To: <YGB7SfmrJkLLoL3B@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1?=
 =?iso-8859-2?Q?xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?iso-8859-2?Q?NGJhMjllMzViXG1zZ3NcbXNnLTdlYWIxY2QzLTkwMDktMTFlYi05OGVkLW?=
 =?iso-8859-2?Q?E0NGNjOGU5Y2YwNlxhbWUtdGVzdFw3ZWFiMWNkNC05MDA5LTExZWItOThl?=
 =?iso-8859-2?Q?ZC1hNDRjYzhlOWNmMDZib2R5LnR4dCIgc3o9IjE0OTUwIiB0PSIxMzI2MT?=
 =?iso-8859-2?Q?QzOTIwNDI3MTk1MjQiIGg9InJNQ3JBNFNLZTN2R01uV0RMak9PTzIrYnVa?=
 =?iso-8859-2?Q?OD0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUhZSUFBQWtpYzlCRmlUWEFXNC9qRm5rbFF0S2JqK01XZVNWQzBv?=
 =?iso-8859-2?Q?TkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQUFHQ0FBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBZ25NaHV3QUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBSjRBQUFCbUFHa0FiZ0JoQUc0QVl3QmxBRjhBY0FCc0FHRUFiZ0J1QU?=
 =?iso-8859-2?Q?drQWJnQm5BRjhBZHdCaEFIUUFaUUJ5QUcwQVlRQnlBR3NBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-2?Q?FBR1lBYndCMUFHNEFaQUJ5QUhrQVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhN?=
 =?iso-8859-2?Q?QVh3Qm5BR1lBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpnQnZB?=
 =?iso-8859-2?Q?SFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdCbEFISUFjd0JmQUhNQV?=
 =?iso-8859-2?Q?lRQnRBSE1BZFFCdUFHY0FYd0JqQUc4QWJnQm1BQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4QWRRQnVBR1?=
 =?iso-8859-2?Q?FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFjd0J0QUdrQVl3?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?iso-8859-2?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCekFIUUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFDQUFBQUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWV?=
 =?iso-8859-2?Q?FCeUFIUUFiZ0JsQUhJQWN3QmZBSFFBY3dCdEFHTUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSU?=
 =?iso-8859-2?Q?FBQUFBQUo0QUFBQm1BRzhBZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFC?=
 =?iso-8859-2?Q?dUFHVUFjZ0J6QUY4QWRRQnRBR01BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFu?=
 =?iso-8859-2?Q?Z0FBQUdjQWRBQnpBRjhBY0FCeUFHOEFaQUIxQUdNQWRBQmZBSFFBY2dCaE?=
 =?iso-8859-2?Q?FHa0FiZ0JwQUc0QVp3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFjd0?=
 =?iso-8859-2?Q?JoQUd3QVpRQnpBRjhBWVFCakFHTUFid0IxQUc0QWRBQmZBSEFBYkFCaEFH?=
 =?iso-8859-2?Q?NEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCekFHRUFiQUJs?=
 =?iso-8859-2?Q?QUhNQVh3QnhBSFVBYndCMEFHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BYmdCd0FITUFYd0JzQU?=
 =?iso-8859-2?Q?drQVl3QmxBRzRBY3dCbEFGOEFkQUJsQUhJQWJRQmZBREVBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQ0FBQUFBQUNlQUFBQWN3QnVBSEFBY3dCZkFHd0FhUUJqQUdV?=
 =?iso-8859-2?Q?QWJnQnpBR1VBWHdCMEFHVUFjZ0J0QUY4QWN3QjBBSFVBWkFCbEFHNEFkQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUlBQUFBQUFKNEFBQUIyQUdjQVh3QnJBR1VBZVFCM0FHOEFjZ0JrQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQU?=
 =?iso-8859-2?Q?FBIi8+PC9tZXRhPg=3D=3D?=
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e64cb98c-3066-4368-59e3-08d8f22d66a7
x-ms-traffictypediagnostic: DM5PR1201MB2504:
x-microsoft-antispam-prvs: <DM5PR1201MB2504608DAAF72C68947F35B6DA7F9@DM5PR1201MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RnM3Y7Ttf54acwDAON4a8dtuEHDB77vYC5tlm3o1apx/geMYl3a9oL8oRDLqXunfAjFY+QZ7ITLI0xmdci+EEXT0Un3yDaukbdXTQnt2FtdpML3DhTB2JQHga4qo1ZuFVvVU/CLSDD6Nrarzf0NyzcyeTLF8JCwiru4q7srIRUmmuRj8bJwom1MPHu42w3EQw62OGbzb8Zo5fFfWYUxzqQ7a9H91EtGwpD+Sjvm8zFrCvlMVliFY74/N4+8Js5OfUEW+4nrH89HC+VYldRPnPYjCfzHPpaalDo0g2PruDXi7TrZPe6C2+fSiR6Nzl7fOSe1xVE1Col037k6YB48QCrb+3xFGks7/GKkkRsZ0qYw3Ej7WqdpTKatFqSCHVYEIxqqm3FUi9V/zvu+J+I65mRtTPdqzKkmAdfXEJPZ6+jK05YLQqoOc5F2y8m47kECOyhwHRIsph4OCJwRtpw76ZbPK/C9TL+wlmt2S3pDi85y05eaXNm6CFo7vyN7GuW4f++U3qbMK5Ebg7O68x9n5Bb+VDQ+HM2sdKqXBuV/u0Vlipd48NXEfHMaI9mkGHGx1jOHJI9dcea3YNg4LxogTuUj/ucCSRKWzfluhLMcHfpAcbJEorMQZPG8L4avHCbbDkEqMeTaP5AP8pveul+9An5ihU35I3EMoZfunJfgOJVg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(396003)(39850400004)(38100700001)(6916009)(86362001)(4326008)(186003)(7416002)(478600001)(71200400001)(6506007)(2906002)(26005)(83380400001)(30864003)(7696005)(52536014)(9686003)(66556008)(64756008)(66476007)(66446008)(33656002)(8676002)(54906003)(8936002)(316002)(66946007)(5660300002)(53546011)(55016002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?Mu5fHRLFHvDsP5Kr5j7q699IU2l3qia3/tbV48Sd4YNAHtdQTTN04oBRXw?=
 =?iso-8859-2?Q?7sg+n2ZA9ybFoQiSJfRaCu6iX511T9zMAZ5aS0lu5mERor7sQ60/6qP4ES?=
 =?iso-8859-2?Q?FBVLIWPSV/CO6K8g60y1MaqE0CStSiKhIukV2R1uGWvOkPF2q3TthEiT+n?=
 =?iso-8859-2?Q?tdF9lRUImOrQoUoIKYA5tY6fRyiOo4VVP30GPs/OnYWSg/5lna8NXZ+o1M?=
 =?iso-8859-2?Q?WJZWQTND3C///6EnQIHf13v3Ne6H0YojP0mOWF5e9HNc5zJWbNdNtJTuSS?=
 =?iso-8859-2?Q?uOfvxRuFt5wBszWdZme1eMFTZgTB7u31P3MqPZep1n3v1lDGPfG8tzV/lQ?=
 =?iso-8859-2?Q?aqqwqRhbtPGC0VEejFrQhuy0CUqwADYpgF+rjlJGReS2GM1uSjRAuUhGmk?=
 =?iso-8859-2?Q?mUH+M1YG1GCVVoNEOY/bzxXSQE4C6J681yWJ6R4QM6/Csv/k6pDh20AWHi?=
 =?iso-8859-2?Q?o9FtXLwHZJo+i6NHEeMKOXQ/TKi7XizVn2CayzsUAHgGkp316jmq+f8EQp?=
 =?iso-8859-2?Q?OH+ceZd9M8jDLdyrDGSTGuahcRPE1ipHrsOzY5rZ0LMJvygdqvnzIkkmDz?=
 =?iso-8859-2?Q?cXJ6tUroOdoaAKrJ6sKaDyQzWi/yD2UxGqj6m3HnMMgCMlnwqm9K/KdG6n?=
 =?iso-8859-2?Q?p+aWxwh6yFY62AOhYcZz+8hxNgb/Y0bBZrSACJvm4cZnVnkJGyB3PBjrE5?=
 =?iso-8859-2?Q?QNV8PU1w/xSFr9wnE4lfmP0LTztUvIwYTw2WLJD2UShLrtC5MEhF8su3Cw?=
 =?iso-8859-2?Q?FG2na1/ExCWAnqji8REXsCmp4/9Cj2/rkPKqyQvnqubtxrDzmy3UZn7cYU?=
 =?iso-8859-2?Q?2pVwhc48mnCpXBp6MJEg0Cen3VGxUCRoJljOxa6eOV+13VzeFSUTAkUhWc?=
 =?iso-8859-2?Q?zY4NmeJKTMJOtikBCbAFQZEUptn8gFZs4ZJgTYp0q/CwTQU6QVLzh2woG+?=
 =?iso-8859-2?Q?E/mNdL42p7HdHKuz92VnCue0V10MRnaWvnO32v+U3PKcI0ix6VnbTIRU73?=
 =?iso-8859-2?Q?CD9FxEphiQf2wSYdVHUlPILAV09JdlA0+8eAjRm5zSjCtxMl7asgirfGWW?=
 =?iso-8859-2?Q?jkuPMJOMI960mhDLzRBaQioiJCOJQRCX1ePph7wzquQ86mwLRAOxS26oMH?=
 =?iso-8859-2?Q?OeR3ah6mNqTMKPCaNTpRjYgJsiwY5+5YnNV5pBgNTA4l8DyqdJc5R2p07Q?=
 =?iso-8859-2?Q?UHDmuf/eQyUfOXn6pT5qqyyaRr+CgBlQg2oHULb6RD5u6yO58I5ZeZ2CKB?=
 =?iso-8859-2?Q?ZLJS6/gX/i1Xbq+Scyp7ODTm7T9jucXaIMAJZxNCJm68On9hT3hLUrXAF8?=
 =?iso-8859-2?Q?xUWhcE1Ii5ZThw0wHC7L3gdrTYSyH53sWNG70s0dx5o8G+4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64cb98c-3066-4368-59e3-08d8f22d66a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2021 21:06:48.0079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +J7usN32gKd2YpNdmRB+qlPy4KFTjN6ZOwaWPh6OREJ3EH92Q+PgrGnliJVDVHmy7y9wQRoACEyzCUDJrm5aNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2504
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 28, 2021 at 13:49:13, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> wrote:

> On Sat, Mar 27, 2021 at 04:06:51AM +0100, Gustavo Pimentel wrote:
> > Add Synopsys DesignWare xData IP driver. This driver enables/disables
> > the PCI traffic generator module pertain to the Synopsys DesignWare
> > prototype.
> >=20
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> >  drivers/misc/dw-xdata-pcie.c | 401 +++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 401 insertions(+)
> >  create mode 100644 drivers/misc/dw-xdata-pcie.c
> >=20
> > diff --git a/drivers/misc/dw-xdata-pcie.c b/drivers/misc/dw-xdata-pcie.=
c
> > new file mode 100644
> > index 00000000..43fdd35
> > --- /dev/null
> > +++ b/drivers/misc/dw-xdata-pcie.c
> > @@ -0,0 +1,401 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2020 Synopsys, Inc. and/or its affiliates.
> > + * Synopsys DesignWare xData driver
> > + *
> > + * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > + */
> > +
> > +#include <linux/miscdevice.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/pci-epf.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/bitops.h>
> > +#include <linux/mutex.h>
> > +#include <linux/delay.h>
> > +#include <linux/pci.h>
> > +
> > +#define DW_XDATA_DRIVER_NAME		"dw-xdata-pcie"
> > +
> > +#define DW_XDATA_EP_MEM_OFFSET		0x8000000
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
> > +#define STATUS_DONE			BIT(0)
> > +
> > +#define CONTROL_DOORBELL		BIT(0)
> > +#define CONTROL_IS_WRITE		BIT(1)
> > +#define CONTROL_LENGTH(a)		FIELD_PREP(GENMASK(13, 2), a)
> > +#define CONTROL_PATTERN_INC		BIT(16)
> > +#define CONTROL_NO_ADDR_INC		BIT(18)
> > +
> > +#define XPERF_CONTROL_ENABLE		BIT(5)
> > +
> > +#define BURST_REPEAT			BIT(31)
> > +#define BURST_VALUE			0x1001
> > +
> > +#define PATTERN_VALUE			0x0
> > +
> > +struct dw_xdata_regs {
> > +	u32 addr_lsb;					/* 0x000 */
> > +	u32 addr_msb;					/* 0x004 */
> > +	u32 burst_cnt;					/* 0x008 */
> > +	u32 control;					/* 0x00c */
> > +	u32 pattern;					/* 0x010 */
> > +	u32 status;					/* 0x014 */
> > +	u32 RAM_addr;					/* 0x018 */
> > +	u32 RAM_port;					/* 0x01c */
> > +	u32 _reserved0[14];				/* 0x020..0x054 */
> > +	u32 perf_control;				/* 0x058 */
> > +	u32 _reserved1[41];				/* 0x05c..0x0fc */
> > +	u32 wr_cnt_lsb;					/* 0x100 */
> > +	u32 wr_cnt_msb;					/* 0x104 */
> > +	u32 rd_cnt_lsb;					/* 0x108 */
> > +	u32 rd_cnt_msb;					/* 0x10c */
> > +} __packed;
> > +
> > +struct dw_xdata_region {
> > +	phys_addr_t paddr;				/* physical address */
> > +	void __iomem *vaddr;				/* virtual address */
> > +	size_t sz;					/* size */
> > +};
> > +
> > +struct dw_xdata {
> > +	struct dw_xdata_region rg_region;		/* registers */
> > +	size_t max_wr_len;				/* max wr xfer len */
> > +	size_t max_rd_len;				/* max rd xfer len */
> > +	struct mutex mutex;
> > +	struct pci_dev *pdev;
> > +	struct device *dev;
>=20
> You do not need this 'struct device' pointer at all, please don't store
> it as you are not handling any reference counting correctly.

Agreed.

>=20
> > +	struct miscdevice misc_dev;
> > +};
> > +
> > +static inline struct dw_xdata_regs __iomem *__dw_regs(struct dw_xdata =
*dw)
> > +{
> > +	return dw->rg_region.vaddr;
> > +}
> > +
> > +static void dw_xdata_stop(struct dw_xdata *dw)
> > +{
> > +	u32 burst;
> > +
> > +	mutex_lock(&dw->mutex);
> > +
> > +	burst =3D readl(&(__dw_regs(dw)->burst_cnt));
> > +
> > +	if (burst & BURST_REPEAT) {
> > +		burst &=3D ~(u32)BURST_REPEAT;
> > +		writel(burst, &(__dw_regs(dw)->burst_cnt));
> > +	}
> > +
> > +	mutex_unlock(&dw->mutex);
> > +}
> > +
> > +static void dw_xdata_start(struct dw_xdata *dw, bool write)
> > +{
> > +	u32 control, status;
> > +
> > +	/* Stop first if xfer in progress */
> > +	dw_xdata_stop(dw);
> > +
> > +	mutex_lock(&dw->mutex);
> > +
> > +	/* Clear status register */
> > +	writel(0x0, &(__dw_regs(dw)->status));
> > +
> > +	/* Burst count register set for continuous until stopped */
> > +	writel(BURST_REPEAT | BURST_VALUE, &(__dw_regs(dw)->burst_cnt));
> > +
> > +	/* Pattern register */
> > +	writel(PATTERN_VALUE, &(__dw_regs(dw)->pattern));
> > +
> > +	/* Control register */
> > +	control =3D CONTROL_DOORBELL | CONTROL_PATTERN_INC | CONTROL_NO_ADDR_=
INC;
> > +	if (write) {
> > +		control |=3D CONTROL_IS_WRITE;
> > +		control |=3D CONTROL_LENGTH(dw->max_wr_len);
> > +	} else {
> > +		control |=3D CONTROL_LENGTH(dw->max_rd_len);
> > +	}
> > +	writel(control, &(__dw_regs(dw)->control));
> > +
> > +	/*
> > +	 * The xData HW block needs about 100 ms to initiate the traffic
> > +	 * generation according this HW block datasheet.
> > +	 */
> > +	usleep_range(100, 150);
> > +
> > +	status =3D readl(&(__dw_regs(dw)->status));
> > +
> > +	mutex_unlock(&dw->mutex);
> > +
> > +	if (!(status & STATUS_DONE))
> > +		pci_dbg(dw->pdev, "xData: started %s direction\n",
> > +			write ? "write" : "read");
> > +}
> > +
> > +static void dw_xdata_perf_meas(struct dw_xdata *dw, u64 *data, bool wr=
ite)
> > +{
> > +	if (write) {
> > +		*data =3D readl(&(__dw_regs(dw)->wr_cnt_msb));
> > +		*data <<=3D 32;
> > +		*data |=3D readl(&(__dw_regs(dw)->wr_cnt_lsb));
> > +	} else {
> > +		*data =3D readl(&(__dw_regs(dw)->rd_cnt_msb));
> > +		*data <<=3D 32;
> > +		*data |=3D readl(&(__dw_regs(dw)->rd_cnt_lsb));
> > +	}
> > +}
> > +
> > +static u64 dw_xdata_perf_diff(u64 *m1, u64 *m2, u64 time)
> > +{
> > +	u64 rate =3D (*m1 - *m2);
> > +
> > +	rate *=3D (1000 * 1000 * 1000);
> > +	rate >>=3D 20;
> > +	rate =3D DIV_ROUND_CLOSEST_ULL(rate, time);
> > +
> > +	return rate;
> > +}
> > +
> > +static void dw_xdata_perf(struct dw_xdata *dw, u64 *rate, bool write)
> > +{
> > +	u64 data[2], time[2], diff;
> > +
> > +	mutex_lock(&dw->mutex);
> > +
> > +	/* First acquisition of current count frames */
> > +	writel(0x0, &(__dw_regs(dw)->perf_control));
> > +	dw_xdata_perf_meas(dw, &data[0], write);
> > +	time[0] =3D jiffies;
> > +	writel((u32)XPERF_CONTROL_ENABLE, &(__dw_regs(dw)->perf_control));
> > +
> > +	/*
> > +	 * Wait 100ms between the 1st count frame acquisition and the 2nd
> > +	 * count frame acquisition, in order to calculate the speed later
> > +	 */
> > +	mdelay(100);
> > +
> > +	/* Second acquisition of current count frames */
> > +	writel(0x0, &(__dw_regs(dw)->perf_control));
> > +	dw_xdata_perf_meas(dw, &data[1], write);
> > +	time[1] =3D jiffies;
> > +	writel((u32)XPERF_CONTROL_ENABLE, &(__dw_regs(dw)->perf_control));
> > +
> > +	/*
> > +	 * Speed calculation
> > +	 *
> > +	 * rate =3D (2nd count frames - 1st count frames) / (time elapsed)
> > +	 */
> > +	diff =3D jiffies_to_nsecs(time[1] - time[0]);
> > +	*rate =3D dw_xdata_perf_diff(&data[1], &data[0], diff);
> > +
> > +	mutex_unlock(&dw->mutex);
> > +
> > +	pci_dbg(dw->pdev, "xData: time=3D%llu us, %s=3D%llu MB/s\n",
> > +		diff, write ? "write" : "read", *rate);
> > +}
> > +
> > +static struct dw_xdata *misc_dev_to_dw(struct miscdevice *misc_dev)
> > +{
> > +	return container_of(misc_dev, struct dw_xdata, misc_dev);
> > +}
> > +
> > +static ssize_t write_show(struct device *dev, struct device_attribute =
*attr,
> > +			  char *buf)
> > +{
> > +	struct miscdevice *misc_dev =3D dev_get_drvdata(dev);
> > +	struct dw_xdata *dw =3D misc_dev_to_dw(misc_dev);
> > +	u64 rate;
> > +
> > +	dw_xdata_perf(dw, &rate, true);
> > +
> > +	return sysfs_emit(buf, "%llu\n", rate);
> > +}
> > +
> > +static ssize_t write_store(struct device *dev, struct device_attribute=
 *attr,
> > +			   const char *buf, size_t size)
> > +{
> > +	struct miscdevice *misc_dev =3D dev_get_drvdata(dev);
> > +	struct dw_xdata *dw =3D misc_dev_to_dw(misc_dev);
> > +
> > +	pci_dbg(dw->pdev, "xData: requested write transfer\n");
> > +
> > +	dw_xdata_start(dw, true);
> > +
> > +	return size;
> > +}
> > +
> > +static DEVICE_ATTR_RW(write);
> > +
> > +static ssize_t read_show(struct device *dev, struct device_attribute *=
attr,
> > +			 char *buf)
> > +{
> > +	struct miscdevice *misc_dev =3D dev_get_drvdata(dev);
> > +	struct dw_xdata *dw =3D misc_dev_to_dw(misc_dev);
> > +	u64 rate;
> > +
> > +	dw_xdata_perf(dw, &rate, false);
> > +
> > +	return sysfs_emit(buf, "%llu\n", rate);
> > +}
> > +
> > +static ssize_t read_store(struct device *dev, struct device_attribute =
*attr,
> > +			  const char *buf, size_t size)
> > +{
> > +	struct miscdevice *misc_dev =3D dev_get_drvdata(dev);
> > +	struct dw_xdata *dw =3D misc_dev_to_dw(misc_dev);
> > +
> > +	pci_dbg(dw->pdev, "xData: requested read transfer\n");
>=20
> dev_dbg() for your misc device, not for your pci device, as that will
> show the proper device that is causing this to happen for.

Ok, I will do a general replacement.

>=20
> > +
> > +	dw_xdata_start(dw, false);
>=20
> You do not even look at the data written?  That feels buggy :(

By data written, you mean the content of buf?

For this particular use case, I don't think that I would need that.
The goal was just to provide a way to trigger/initiate the PCI traffic=20
generator on the read direction, which doesn't require to have any=20
particular value, that's why it doesn't check the input value.
On ABI documentation I've given the example "echo 1 >=20
/sys/class/misc/dw-xdata-pcie/read", but it could be "echo abc >=20
/sys/class/misc/dw-xdata-pcie/read".

The same applies to "write" and "stop" on the store methods.

Perhaps it might exist a better way to do this kind of operations, any=20
suggestions?

Of course, I could merge the "write", "read" and "stop" in just one=20
device attribute as "command", but I think it will be more complex to=20
understand and work with it.

>=20
> > +
> > +	return size;
> > +}
> > +
> > +static DEVICE_ATTR_RW(read);
> > +
> > +static ssize_t stop_store(struct device *dev, struct device_attribute =
*attr,
> > +			  const char *buf, size_t size)
> > +{
> > +	struct miscdevice *misc_dev =3D dev_get_drvdata(dev);
> > +	struct dw_xdata *dw =3D misc_dev_to_dw(misc_dev);
> > +
> > +	pci_dbg(dw->pdev, "xData: requested stop any transfer\n");
>=20
> Same as above.
>=20
> > +
> > +	dw_xdata_stop(dw);
>=20
> Again, you do not even look at the data?
>=20
> > +
> > +	return size;
> > +}
> > +
> > +static DEVICE_ATTR_WO(stop);
> > +
> > +static struct attribute *xdata_attrs[] =3D {
> > +	&dev_attr_write.attr,
> > +	&dev_attr_read.attr,
> > +	&dev_attr_stop.attr,
> > +	NULL,
> > +};
> > +
> > +ATTRIBUTE_GROUPS(xdata);
> > +
> > +static int dw_xdata_pcie_probe(struct pci_dev *pdev,
> > +			       const struct pci_device_id *pid)
> > +{
> > +	const struct dw_xdata_pcie_data *pdata =3D (void *)pid->driver_data;
> > +	struct dw_xdata *dw;
> > +	u64 addr;
> > +	int err;
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
> > +	dw =3D devm_kzalloc(&pdev->dev, sizeof(*dw), GFP_KERNEL);
> > +	if (!dw)
> > +		return -ENOMEM;
> > +
> > +	/* Data structure initialization */
> > +	mutex_init(&dw->mutex);
> > +
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
> > +	dw->pdev =3D pdev;
>=20
> No reference counting?

Since this driver was developed for internal testing purposes and=20
normally it will be used just with one prototype endpoint, I didn't think=20
on that, but I'll include that on v8.

>=20
> > +	dw->dev =3D &pdev->dev;
>=20
> As mentioned above, this is not needed at all.

Ok.

>=20
> > +
> > +	dw->misc_dev.minor =3D MISC_DYNAMIC_MINOR;
> > +	dw->misc_dev.name =3D kstrdup(DW_XDATA_DRIVER_NAME, GFP_KERNEL);
>=20
> Where do you free this memory?

It's not being done, I noticed it after sending the patch series. On v8=20
this will be fixed.

>=20
> > +	dw->misc_dev.parent =3D &pdev->dev;
> > +	dw->misc_dev.groups =3D xdata_groups;
> > +
> > +	writel(0x0, &(__dw_regs(dw)->RAM_addr));
> > +	writel(0x0, &(__dw_regs(dw)->RAM_port));
> > +
> > +	addr =3D dw->rg_region.paddr + DW_XDATA_EP_MEM_OFFSET;
> > +	writel(lower_32_bits(addr), &(__dw_regs(dw)->addr_lsb));
> > +	writel(upper_32_bits(addr), &(__dw_regs(dw)->addr_msb));
> > +	pci_dbg(pdev, "xData: target address =3D 0x%.16llx\n", addr);
> > +
> > +	pci_dbg(pdev, "xData: wr_len =3D %zu, rd_len =3D %zu\n",
> > +		dw->max_wr_len * 4, dw->max_rd_len * 4);
> > +
> > +	/* Saving data structure reference */
> > +	pci_set_drvdata(pdev, dw);
> > +
> > +	/* Register misc device */
> > +	err =3D misc_register(&dw->misc_dev);
> > +	if (err)
> > +		return err;
> > +
> > +	return 0;
>=20
> How about:
> 	return misc_register(...);

I've reworked this part to include the kfree of the variable=20
dw->misc_dev.name

>=20
>=20
> > +}
> > +
> > +static void dw_xdata_pcie_remove(struct pci_dev *pdev)
> > +{
> > +	struct dw_xdata *dw =3D pci_get_drvdata(pdev);
> > +
> > +	if (dw) {
>=20
> How can this ever not be true?  You never set this to NULL so this check
> is pointless.

It will be removed.

>=20
> > +		dw_xdata_stop(dw);
> > +		misc_deregister(&dw->misc_dev);
> > +	}
> > +}
> > +
> > +static const struct pci_device_id dw_xdata_pcie_id_table[] =3D {
> > +	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
>=20
> Why do you need a pointer to snps_edda_data here?

The structure snps_edda_data indicates the location of this IP block (BAR=20
and offset) for this particular endpoint.
It's very likely in the future to be more variants that for HW design=20
reasons might require this IP block to be on a different location.

-Gustavo
>=20
> thanks,
>=20
> greg k-h


