Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF0B318782
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 10:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhBKJzF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 04:55:05 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:58074 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230106AbhBKJwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 04:52:08 -0500
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 06F0FC00B8;
        Thu, 11 Feb 2021 09:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613037040; bh=rRkqKidtnAdvGZvAV1+nyxStNBGCTkW+kASx3ZZBsGY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kv+iY/FnqWJBm9kZtF7qOkmxLhajk3bUvwAZ9rYA/j2QObdAPUn9IIU5ytEjL81Pr
         QZupu8ZeSbTyK5XOdwmAzq0kMd6YOduyHLH87BKDUV97e3zIs2B/01KjMFoSmFcDOH
         +rgLKZrHmYpibUdckNpptUxFsP5LnCK93NitJ4YNrKXO4dpbGfxBCDKLXqCMO1/Gl7
         kQErhIFFafqIxXDuGUl7BUUFb1KmZ04a+nQLkNA2PuiUfBYp9DnvV6GlxTQrICCTCU
         76L92r56JhxJ21+q/m5/G1gqu0iUxNRKszRYgM0xpZXOGdeeRDeLvuk3svsuUz6Sim
         ZCjeoSHNg+iRQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1ECEFA0081;
        Thu, 11 Feb 2021 09:50:38 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2055.outbound.protection.outlook.com [104.47.38.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4D14C400A6;
        Thu, 11 Feb 2021 09:50:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="wUlLqfXz";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGE+0C4XEdRhSZM6s1XMWT8Ht8W6eyLzbDehY4KlWC+NCXzB1GpoXCivUuaRLLKgxXfzCVV6s/48o6GfWFeMtuVM41GBxta/U3o/ZvvI25qmu0zezYwdUwWGUKSP4AqA7NLTEw3TU3d03LAtUjnxH29Kp1OV+Mq4bTysHPgSO16trqi/OnJHN8wMhTC3wevVc0BjIm+HV+LGI1iqDP9VhXOQlHS1xgS/53pn25KndnvHbadV5LAELgVxYAr9RUs2/9+cvlcmEYd0n8eJQPV+h3YEXwe/rPyujFLONBDZYU1ng85thycdqCWcnoznBZANE8K7cVq7bJCkzy2OrD1skA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfO+gJaGgUE9duodfIuxwck1ccQl7htjHJb6F/BIGv8=;
 b=nr6WOSoWCJj90o+S7kTAMSK4BvzNFrhQGKPKDtqVNJNkeediXWcpT6AMq28BvPbG+dGZfZD2iXcqi9CwYYzxh6TXzQEvMqSlZF22H46ZU6NP0dpRVrGkwnsAI1Zs0AkhyPXGcIGTmSlbnkp1/+1p5FX6d1YdurXzGXQ3NTlY1gUM6xy2afce9622NI8LcMTCMJZ4Of3R6LnL6QQsqCAlEaIiM9BC3am7TOEO42kYpVomWJvETb9pPTfve7Bq/AbrMUW5UVgwwVTg+wABJI6xPllboufIRBRbOHyAoG+qSkVkn1Jn8ulQNzlLeVPicj8IwjHPuXhrjQyeV1L6lk3iMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfO+gJaGgUE9duodfIuxwck1ccQl7htjHJb6F/BIGv8=;
 b=wUlLqfXzaMfobPniFZJG4Juu0BUnITtMCu1V+5OhKmUctJWNlZVEuwhLn6jdmqeNRyFmUQnzbaX4VZK0AVWFcfzRVKOyg6l1GgVAgjJwzuqqTd9gvHyESFXBL9pOdWOlsByfTEtkGQhyqCT/CLVQDAYMhch7eO4/i9eJgc52ack=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM5PR12MB1834.namprd12.prod.outlook.com (2603:10b6:3:10a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.30; Thu, 11 Feb 2021 09:50:33 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3825.030; Thu, 11 Feb
 2021 09:50:33 +0000
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
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v5 1/6] misc: Add Synopsys DesignWare xData IP driver
Thread-Topic: [PATCH v5 1/6] misc: Add Synopsys DesignWare xData IP driver
Thread-Index: AQHXAFWPyAqykiKVp0+x9nNcxSm5BKpSsFcAgAAErwA=
Date:   Thu, 11 Feb 2021 09:50:33 +0000
Message-ID: <DM5PR12MB1835A23E60363C730E4D69AFDA8C9@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <02835da8fc8c9293fecbe666a8db3fb79276fdde.1613034397.git.gustavo.pimentel@synopsys.com>
 <YCT5KDnAWex8fvbz@kroah.com>
In-Reply-To: <YCT5KDnAWex8fvbz@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTkxYjllZjM4LTZjNGUtMTFlYi05OGU2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw5MWI5ZWYzYS02YzRlLTExZWItOThlNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjExODIiIHQ9IjEzMjU3NTEwNjI4MzI1?=
 =?us-ascii?Q?MTkxNCIgaD0idFhNTzRFLytGR2hvOXFrYmFEWjhOeFhLVE5FPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?S3FCSlVXd0RYQVFTN25MUXRCYmgrQkx1Y3RDMEZ1SDRPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: c3e70cf2-2baf-4b6c-8359-08d8ce7279d8
x-ms-traffictypediagnostic: DM5PR12MB1834:
x-microsoft-antispam-prvs: <DM5PR12MB183498DD467B7426C9A0A4C1DA8C9@DM5PR12MB1834.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xi+apCVHcIQC3xff9PnQBdugryHgi3NnoFwkeGZ4c8Vp2uhPuy5pcTwBwURMN7ebWkc22XApywQ1tjU7jA5SqceCpseh+D07zGovg0b4lvSIgaS2qk2deqemIqFZN9GHYihu7aZHHy3Ov/pBrSGs7IGAmpDoW5YbETWPIuwFTfsw+ofwVnTL4pMYQLkS7eZHVUF/c9qCKey/FErjhvsWXr33y6fJEpn9OHefbzPX/UgPl+7vv1XJEy4hyG+lpssrIHm48gBHtO6mqoHZAmegk3V3UBxDXyZvgyUyxg0Yjl3JqvreQa3kGkKSnxzJCd7ln0u7G4FTuZOygtN7QgLXN6q0kTgxyf2NjCJlGmVMfr2mr35blV5kXApYdotcpPE8G99rmnCdmuuq3+pGgp7B/Aj9h9gm1J6UCPfSmskUqeuBgNZmlPBCKGBMASaBgOlIcTZ+W2IrRzMeWljS2a5jAYK7VCnOx1qTSMfVBhrmwBKrfxfxdqwW/BvRoqVKhiswn0qiwagBI0C0hQWdGfQCIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(366004)(39860400002)(376002)(5660300002)(26005)(86362001)(7696005)(478600001)(186003)(4744005)(6916009)(66946007)(8936002)(55016002)(316002)(9686003)(7416002)(76116006)(53546011)(52536014)(71200400001)(8676002)(2906002)(4326008)(6506007)(33656002)(66556008)(54906003)(66476007)(64756008)(66446008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?daPGkMuMOub3kjoTL7R6bEXnyLioBTv1OB4OvNZiz0Bx8Wlvo82hwW95iunx?=
 =?us-ascii?Q?sxRCWDT9QWd7gf4ii/5RRP7D2ZGkU733P8IXeCDbJAFVmUv9JytZSbjq70SU?=
 =?us-ascii?Q?ptR1tcn/qPFhtSi9q11LxwtoaYdttsFipJDhV6fbItRhYnSPzYSmzzRVAto2?=
 =?us-ascii?Q?FVCOZWl8Lp66LQMe9tBa0e3dCQLitH05QOLd8TjEE4ujxh3pfkgiHte5XZIr?=
 =?us-ascii?Q?KfmGfSdr0fZ3EeoLSvDgDmeoXK15GwDZjGh2U6c8P2ux+Uj+Q0P++bjFYZKh?=
 =?us-ascii?Q?7+jjqbYRlFt23EdhGE8ZlGffZrVj+aKral1eWBgIILR/odrZF4pKLW5utZXw?=
 =?us-ascii?Q?7eNTSTzH4+JrX3mdU2dlJF2aBmnIrkCfj1h58tEAbsH+QY6l9xRlA4GPa9mo?=
 =?us-ascii?Q?IOWHl76cgYvcIyeqzq3zzgY37daNRKiybmkdF4bkGSzHfobSOqahKUdSgbY4?=
 =?us-ascii?Q?/NVBJvjtgVKP3W5z0zh2ZquKjAN4JaDXJvDVHFBfIe2wP7nHxOc4ao+xS+l0?=
 =?us-ascii?Q?SXZcYY/4RKkQYUc2L0PltzdHPip/ZXobKqw+DLGgOPphaqQwNMH2GkXJPFDd?=
 =?us-ascii?Q?65gPGRcrYQcbrFdtu9WBEcmMCLWkFPBj5hHB0YjaADd8aZGYu0JN9S/WBV8E?=
 =?us-ascii?Q?d9YsjYNPiNN2V3qcpD8lm8/+5cVPl8OtI8O3C2JwdLN1FUfHtKkfScMKIb8Y?=
 =?us-ascii?Q?3d56ao7+5lOxf4yVj8CVw16LWY8un1xN8CHUiRzPtM9zl/iCDZ8ZtD+w3KUL?=
 =?us-ascii?Q?3ROC6GGo980TII4VZ5V1RwloPg+uloFDv9by1fFU76YQ1pXUf+n7ssvdxDCU?=
 =?us-ascii?Q?Iv0CBbkDjXeOI+RjyUediDGmz6NOciQ8CMJ+vD28AnAXk93kkFqQgNue336P?=
 =?us-ascii?Q?xo81f+xxh17UHQl2OmhX7G+dqHZ+h72GWabvWzDy/7qT3PNU2EMZ71f2tFF2?=
 =?us-ascii?Q?gjT/oDl9cwwy+zDQjfTYuu+3Lf8qSZzgfcJGuyHv0uJ6sLSCVkJsHL1D1vpY?=
 =?us-ascii?Q?7Q1VvMqizZhtIwAadJuByaeHuhWE/6WnMDKtF+SxyTNh+LDkq0GYay9utwR9?=
 =?us-ascii?Q?9q+G8P2bysxdLkjcwDgqS4JWLYC12VbFxdnEW7hx6u3EnbV+6uCLZ0Gm78ed?=
 =?us-ascii?Q?ZBQPvIJrwZeb/43FRCFgbII2GBCH7eBZEEQfhFZi0zslL+mZJlxQ/AvIhbo2?=
 =?us-ascii?Q?nkvpWV7ZS34aherxVKSLlkcjLdIDt56ROj52zRkT4I4TcgRULrYiovBfDXiW?=
 =?us-ascii?Q?L+TkKz7D9p01jqGpACKc5ujBPksjwHfILzhQMolBX+aGDBKenjorHwv7+jLJ?=
 =?us-ascii?Q?By6oKp2gFO3+sehlWB4/SvGl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e70cf2-2baf-4b6c-8359-08d8ce7279d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 09:50:33.7721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9XH/oxUl/RaM9Xg4myEDccncDwwFtyRYqV8XoSEWIWr53/+zbzC5uuhxsuqBzbcCcR5D3b6AUEmZH4UbRRnLYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1834
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 9:30:16, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> wrote:

> On Thu, Feb 11, 2021 at 10:08:38AM +0100, Gustavo Pimentel wrote:
> > +static ssize_t write_show(struct device *dev, struct device_attribute =
*attr,
> > +			  char *buf)
> > +{
> > +	struct pci_dev *pdev =3D to_pci_dev(dev);
> > +	struct dw_xdata *dw =3D pci_get_drvdata(pdev);
> > +	u64 rate;
> > +
> > +	mutex_lock(&dw->mutex);
> > +	dw_xdata_perf(dw, &rate, true);
> > +	mutex_unlock(&dw->mutex);
> > +
> > +	return sysfs_emit(buf, "%llu MB/s\n", rate);
>=20
> Do not put units in a sysfs file, that should be in the documentation,
> otherwise this forces userspace to "parse" the units which is a mess.

Okay.

>=20
> Same for the other sysfs file.
>=20
> And why do you need a lock for this show function?

Maybe I understood it wrongly, please correct me in that case. The=20
dw_xdata_perf() is called on the write_show() and read_show(), to avoid a=20
possible race condition between those calls, I have added this mutex.
Thanks.

-Gustavo

>=20
> thanks,
>=20
> greg k-h


