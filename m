Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E62534CDA7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhC2KJe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 06:09:34 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:44660 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231639AbhC2KJT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 06:09:19 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8758C400DF;
        Mon, 29 Mar 2021 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617012559; bh=pd+V7yPlhbVWHU6MoRBbPUjZPyrS7anZQX5STvkOG1U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=mVCvVdwF11FdyA6Fk1cfEhpC1xpxuQ0Bui7GEY22qUR8fhunHRaWwGc4bvG4ANhU8
         SWpMOfhThLXjJx4HO8wc1H5iTJvcfjthFnkhZLYPTiAby8Ed9PpyGvVeckp+YvHv/0
         +zW6+KihV/RGtm5S+JUq6r4ix2o6xVEg/WHTYGzlfn9YsOHkWUnNz7PRVGm2pcMnOz
         tMm0sYaJPHnqE3pENBF/XABqS4MOHFWev7vaQ+WFK+2+J9iIgmuQi0bALEswxIpapw
         whOdVWFVXkEeIX0cPk86bnLPlOIv5RFXjdhut3Rgd44VDW/+s9vg9vlXyQ7EI9oGWc
         l8t8cYXX2QK2g==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A95C1A0077;
        Mon, 29 Mar 2021 10:09:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5E55040131;
        Mon, 29 Mar 2021 10:09:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="k2DnJMqz";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amAXRO9ls/je8sLaLhyRioSrNIJmhzplxK2kk1c7Y8Dh8Tj3Bv//w41xWboV6+mpgeFgL7+y5oK/0wwuKoV65NyKqlLLegbjRFfpndXnGN8qPlWpSe4weyTFwAhLMED/qIkf9ETsIqOOWK3rRSE1C7Q1LxjLAww0c4JexOijBxyy7W0bYwM/XR7ZpnAFHIB7HvifpNcEuqFgfc8NBuZBN2ayNtN6LWeuqZ92FDzx1GLPeBI6ZWOl1VSqSdUS/Pxz768zISevWbNjx4Ic5MpkYdrTpmQd50nVWSDwEsa9h6O8Egj9+UT7GwNkcdsJ7DhMjEJidKEk95uY9pX+F/9TXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pd+V7yPlhbVWHU6MoRBbPUjZPyrS7anZQX5STvkOG1U=;
 b=BIzUSoK955J29ItMD8knexgXbqClAAgJqB9uBTdnF9MUuwzaBbZ388QubMDzk5Qu2tskIIHqtpRjZA+KqgQTwiFSS1yg5QhFpxE5dry9NXT0nErJ1MsUS7Wq8UrVyWeaNXh72A97bmoWBZrCLGebAw+V+yT12Pwt22YdYk/qlJ2goKfbLyIpS5VJ+3VUoXeES1kqMYdsHNlfHeFSlVpcgvJXv6AbGDe6CizI2L9h+44kPyY5Act785FfXYlTDwhRnv53rBUNcjf+Nr1yBxJW+OsahHDP5bL0BwJRGXMjdKBJ7iAUP8ez33snuCMndb5Y3mEzaZYMsuuIA8pHI43sRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pd+V7yPlhbVWHU6MoRBbPUjZPyrS7anZQX5STvkOG1U=;
 b=k2DnJMqzovWoWaE+hfzy8DA0vr8/nzJ2Vi0U7J3S64zDDAM8DsuSfJzY5kSybHBl/yYocXTYQLSxpky9cqh2J432KW+UhR3rpAHzgHqhCzIKr3N4Qw+tcFj7fZxLWzgJw6/QNAkaZKLh20ORy8fDNvWGHuozxmEnSaSoWkMI9eI=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.26; Mon, 29 Mar 2021 10:09:14 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3977.033; Mon, 29 Mar
 2021 10:09:13 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Willy Tarreau <w@1wt.eu>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Wilczynski <kw@linux.com>
Subject: RE: [PATCH v8 5/5] FIX driver
Thread-Topic: [PATCH v8 5/5] FIX driver
Thread-Index: AQHXJIEqSs4tI5+Q4UqD+OWc0cM5aKqavGeAgAAA3VA=
Date:   Mon, 29 Mar 2021 10:09:13 +0000
Message-ID: <DM5PR12MB18355412D7190B6C5440B2D2DA7E9@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1617011282.git.gustavo.pimentel@synopsys.com>
 <20405596c759cf6cabca83e7a9cd90113fbea557.1617011282.git.gustavo.pimentel@synopsys.com>
 <20210329100303.GA21530@1wt.eu>
In-Reply-To: <20210329100303.GA21530@1wt.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWNkYmY5MmMwLTkwNzYtMTFlYi05OGVkLWE0NGNj?=
 =?us-ascii?Q?OGU5Y2YwNlxhbWUtdGVzdFxjZGJmOTJjMi05MDc2LTExZWItOThlZC1hNDRj?=
 =?us-ascii?Q?YzhlOWNmMDZib2R5LnR4dCIgc3o9IjgzMCIgdD0iMTMyNjE0ODYxNTA3NjI2?=
 =?us-ascii?Q?Mjg0IiBoPSJjaHBtTC9SOFlNV1BMZmRrdmViV2JCcmpiRk09IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIWUlBQUFz?=
 =?us-ascii?Q?aFJtUWd5VFhBY3ZVK1R4ZkE3Ull5OVQ1UEY4RHRGZ05BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFBR0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQWduTWh1d0FBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
 =?us-ascii?Q?aEFHNEFZd0JsQUY4QWNBQnNBR0VBYmdCdUFHa0FiZ0JuQUY4QWR3QmhBSFFB?=
 =?us-ascii?Q?WlFCeUFHMEFZUUJ5QUdzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FYd0J3?=
 =?us-ascii?Q?QUdFQWNnQjBBRzRBWlFCeUFITUFYd0JuQUdZQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJnQmxB?=
 =?us-ascii?Q?SElBY3dCZkFITUFZUUJ0QUhNQWRRQnVBR2NBWHdCakFHOEFiZ0JtQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFk?=
 =?us-ascii?Q?UUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBY3dCdEFH?=
 =?us-ascii?Q?a0FZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpBSFFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhRQWN3QnRBR01BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFkUUJ0?=
 =?us-ascii?Q?QUdNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHY0FkQUJ6QUY4QWNBQnlBRzhB?=
 =?us-ascii?Q?WkFCMUFHTUFkQUJmQUhRQWNnQmhBR2tBYmdCcEFHNEFad0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBY3dCaEFHd0FaUUJ6QUY4QVlRQmpBR01BYndCMUFHNEFk?=
 =?us-ascii?Q?QUJmQUhBQWJBQmhBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?R0VBYkFCbEFITUFYd0J4QUhVQWJ3QjBBR1VBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhNQWJnQndBSE1BWHdCc0FH?=
 =?us-ascii?Q?a0FZd0JsQUc0QWN3QmxBRjhBZEFCbEFISUFiUUJmQURFQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFjd0J1QUhBQWN3QmZBR3dBYVFCakFHVUFiZ0J6QUdV?=
 =?us-ascii?Q?QVh3QjBBR1VBY2dCdEFGOEFjd0IwQUhVQVpBQmxBRzRBZEFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?MkFHY0FYd0JyQUdVQWVRQjNBRzhBY2dCa0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
authentication-results: 1wt.eu; dkim=none (message not signed)
 header.d=none;1wt.eu; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 512377cf-e10f-4317-0869-08d8f29ab478
x-ms-traffictypediagnostic: DM6PR12MB4297:
x-microsoft-antispam-prvs: <DM6PR12MB4297FA2ED33E398DD0518BEEDA7E9@DM6PR12MB4297.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SJY2RUpXR6mUQc5wHMFobaPDzy9oXHgiK7P9dTxKKTX1uoKreEznVz+jOkNXjd5n8eBM6HxpltU5YLOhUz9PxtOfZe1foBH7sdkAIgYK2zJ9iclgKXp/eetOElUZz1Wwa4ei/M0yEV53j6k7RgjXMYDO3ZfVpCRkKbkxqANLeelO5EKlB9IOXu5EYcewMioxn90lxxhexsQZ1PWs2SpyshL8kf+fgt+HVATL63qC/oY9HtHwK4Gj/iEMVbSQP9xUmsR8aao6w6UOh+tOjRtDC4v9+lkp/94RBonJ4AUT0nx6xdR+zR/2prJ53OfdNQIFnZMVQkPDmSiM2rk1x2yXXgzg2uIulS/Vhitm8oDYtl/6iLJ1qlMVaIv+6S7JZfrytqt+0gpalDvzp79W1H2FJZECRKSVL0PDDm1qhBfqI5WsqZI8CPdgcTpW8w3QxCXM+iKHTOGYDJl1yGDQd/snFjkqVwiR08iGtZ1KksbF1lQXcnOUUldLdshP/OfkDBaAHPvdNrZlt0yoJaM5+D5A5sjcg3Dw4OpnyR5xiSb4azzEpkpRyDKl/IHsqma9FHh8s7CHxqgQVYHPratixT1dnxqYcqlEBSDb4ZOHI4LACUVYzKsrceCLqRB3lHl/9CYIVLFsHwE0dKJwF0SDEzbYsnoRVRYhw4mblWByrAf+5u9lzuOZLlY/OtdNFORDDdZB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(39860400002)(346002)(53546011)(6506007)(83380400001)(7696005)(8936002)(7416002)(478600001)(5660300002)(52536014)(316002)(8676002)(2906002)(26005)(66556008)(64756008)(76116006)(66446008)(4744005)(55016002)(71200400001)(38100700001)(6916009)(66476007)(86362001)(4326008)(33656002)(186003)(66946007)(54906003)(9686003)(781001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AEC3BW/7D0scecazUYmrM9wxg0k0/dpqAHi4BYckL8gKM7iD/wbL99B7F9pS?=
 =?us-ascii?Q?bhD7crnhWdcczkPndoDtjDS9xhXi97yfBaQWNVIMWz4VlOouLqIr9hn7zwes?=
 =?us-ascii?Q?oBPedztB5yXIJ774LkDD8yD7WAETg7X+ALStF9EhOUmWXa/BdKokfmnsjhBQ?=
 =?us-ascii?Q?MzN7DLNPjAOZAYXB13hfT/ZP+3HdQC93XKDf9UrJgK8e4e3/7eJLajl3UcyB?=
 =?us-ascii?Q?fMj3QiBGO4TTMUTHukCHYx6h3ydin+fCU8BpfmNGzOWMkFZdHTL+rNpUtzXu?=
 =?us-ascii?Q?CUnixxRhCHMYkWT8X/j2EjUXRdH78qDyBoOOkTWIHs+i3FSMRGFnIjs3JBkn?=
 =?us-ascii?Q?5+Wc/YALhJ38PjB5MwIXWIFSfZTwQjosogPViYX4HIPwHv4/PeIcfJBDpo7B?=
 =?us-ascii?Q?qKw5E+VHX29Vqae0uRF4fSHJlHCMu33kTB68DDCd7fqebyKUqqC2ioPJhwuW?=
 =?us-ascii?Q?JtOR1wvi0tV0cmznHQmuabLxawycGdu1qJtfhCgZJjCJJ1d0FmkWopEcwkHO?=
 =?us-ascii?Q?7LaBc8kZDsOVyCXHT/9sT2j695OXfrKY1C6F5DmhX+JvulK4HKqvNYnq4OBs?=
 =?us-ascii?Q?fTiWXzZKpG3uUEX9HwTABokJVq1jcA8m65JIh8PfZx8KuT14o0n2hNL7as/W?=
 =?us-ascii?Q?EWytVP8xlfuBKhc9GYezGz5PZu5K2Cfgbe2wHu8FUOLl45IbpvNoYJsj2t05?=
 =?us-ascii?Q?FwEp9OXM5wWgQ+FrZeckMpPKAcMSM66G/0wP7GZTm9o2xNgkRrGLh9s90/qw?=
 =?us-ascii?Q?xbe2CX+eZCzS4AFO7FoFh8d/d3n3M3C/LWdErJsfWQx7JtCT7in3EobPkVgL?=
 =?us-ascii?Q?ELP8ma/Khc5eVWYmKZysKiW5nL87/lbQbX0DIMVNjNU6OnrB9xZDCe7VMLhO?=
 =?us-ascii?Q?ccXNNDky8cVAAUiJt6pFhw5J13vYLKPYErwPu7OdBvPY2BNYXdkc6CvdpsD6?=
 =?us-ascii?Q?rYRhNx3Qb1XTltZwcreOKZVLon36AODx2GNLlc9yVt7SkAf7Iu83NOXX80Je?=
 =?us-ascii?Q?XzKr7w+MwEsfRCoymfmwwrSwgTE9CTgrNol1UH3SM72pzsbMBzZNlHP/iWCU?=
 =?us-ascii?Q?hNvxv4U3Y4qZkU8uddFmPhr7HKeZPaGmj0dqVqMEnQHqXvoiNKCG7/s/u0uo?=
 =?us-ascii?Q?sKVLcH75GFqmdDP/8D0XXpFvxu7C7cu0whkzBCvZoLQBuBikLqYZUY+Hgqh1?=
 =?us-ascii?Q?fBa/jGB2jA0F9+2kkcYEMI9k35mfTAn7G45TB7HnSkDGJ5+FEh5M4ESNTA5q?=
 =?us-ascii?Q?alrHvwiJGF1edmEGUoQZ/zeTGjfZ3Sq8NR/2qabJ1xN76rZP2BffJhGkKIhF?=
 =?us-ascii?Q?Nhw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512377cf-e10f-4317-0869-08d8f29ab478
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 10:09:13.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+he8EcfQVeZeDG25Dax0YALNgkvImN7T6ac+aHSl3k4+zj8uqHZqswkap/xPIzWmWoVWz0mnWlAyrAGwWv3fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 29, 2021 at 11:3:3, Willy Tarreau <w@1wt.eu> wrote:

> On Mon, Mar 29, 2021 at 11:51:38AM +0200, Gustavo Pimentel wrote:
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>=20
> Please make an effort, this is in no way an acceptable commit description
> for a patch. The subject is already extremely vague "FIX driver" with no
> context at all, and there is no description of the intent here. What is
> someone supposed to think about the risk of keeping or reverting it if a
> bisect section would end on this one ?

Hi Willy,

this patch was sent by mistake, it was already squashed on patch #1 on=20
v9.
Please check your inbox for the patch series v9, that was sent a few=20
minutes ago.

-Gustavo

>=20
> Thanks,
> Willy


