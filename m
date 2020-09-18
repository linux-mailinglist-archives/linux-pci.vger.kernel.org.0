Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6CF26F68A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 09:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIRHPw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 03:15:52 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:51474 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbgIRHPv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 03:15:51 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A5E26C06F9;
        Fri, 18 Sep 2020 07:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1600413350; bh=K0pnqP/NoWZvoDNcXxHYUX7+sN1zA1QoIMC1mrbpv68=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kBB8ZLvvzl7ASsscgenBElkSfLgzdqO4PaaW3eORosPzPMhAV3/x+OnUfLbloYefn
         iHrtPsdf3xkSfB0gBPh6BL9CBPo7URhuQC4noBJikY8Uz9Ln1j2Yf1k+dZTug5uAZz
         WJvDe9JRmVPpkDqr0db+KdP3eQ4OFsiLWU1eM/i2gJAfsVBmxhFfXLhqjfE/JEaamY
         /MqD5NEbQsSqGLYizQRfiPqYtFa4/jmC+rjLMTyrygt9RWyjAuWwkFZd2oh4l6pI8d
         XdpdsiF36ilycMZUhIbchGCH2S9EDQXh2/7UYF+Qp+wOeI3hsSgCvN6YGbV0Iqe0bK
         Q1LZeOAsCgTow==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 59C64A0096;
        Fri, 18 Sep 2020 07:15:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DF01D8026A;
        Fri, 18 Sep 2020 07:15:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="gdYfV/MC";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eplQjab2QRAAFJfTrxTXY4WGfA8yHXXbIwO+pCLC7JtXQPOqbCHhYqu8f9gsgkEpDbagYIwnbUw2qLItt35MWv73qhTX5/CXfE1tquNg0XzQyUd7XX/BO+XuJNnVTfrhasjHRl4A4BfdJzXhwF0Fi2kEvPp0yFvG35yVLw7rStr6NlvaEZfNHfx2KYkk2qGPOUXolUjYInE8MwI6oWsS+GWOZZDkjwRale8WqHM9ILC7YboeyrkzW1+1sGcMcgExZdg6vd9tWC567lgSiZop/VkQuYK8L7Dnaae62jTE46K87ev9qOj7762qOpsczVrLiaSB3PlRtgXcrkOk5R/ULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qNZOiN5T0yWVdl26C0j3V5/vD4DiOD0G2IBa/3gvZc=;
 b=F/S9AjHqaD1PTLEX+wwiXFUggb2+qvPHYBnTbNonAoQN5ewmCJPXHYc20bwveG0zfgeTKt0grkro2PNMhkZO7T12J2xYW2HhBBgSgZzHzOx1AULgx6cBiI/zyMzzJVKk++cDKJif1lsYQ9cpOiloL3K5DDq4JUp3oC9fquxHSzEBZ5MJXfMkq8GIKO7Q8xwffOIqLs28g08zR0eHAWjnZvd0JPaz7V3kCPg3Hwzvc9ZmPbveCqspGfsPRChJaPTqzFSMpD88YcCwxdORakfeaqGeKr0GUJllVI6DZ3Ri8zrz16Vl/RF8IwYEfRKVRQMOfJm7tBOIKIbh/ASAuxjS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qNZOiN5T0yWVdl26C0j3V5/vD4DiOD0G2IBa/3gvZc=;
 b=gdYfV/MCqA7xGqPwWb9CqnuB1EP24u3tNUBln/fjY5dPSSQaDu4fh8T7qlZvd09Wz6K8+TVxxKr4segUGw6bu2ZtOvVNYNSFv7nmDC1dq02Su7D0AXOSMsqpcll5wiEqZL3lC5hRh+ZnitzRbwv2Lr62peCa4XlFlq9v0f9Msss=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM6PR12MB3193.namprd12.prod.outlook.com (2603:10b6:5:186::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.19; Fri, 18 Sep 2020 07:15:48 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::742c:dafa:9df7:4f4]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::742c:dafa:9df7:4f4%10]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 07:15:48 +0000
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
Thread-Index: AQHWjTlxgisFVhsuDUiUuIdgE663/qltXfiAgACW1zA=
Date:   Fri, 18 Sep 2020 07:15:48 +0000
Message-ID: <DM5PR12MB127636924B64202BCD8A2154DA3F0@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <7743c426ae2c34573d59636d4d6cefaccdb00990.1600378070.git.gustavo.pimentel@synopsys.com>
 <20200917214759.GA1741197@bjorn-Precision-5520>
In-Reply-To: <20200917214759.GA1741197@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWMzYWFhZjc1LWY5N2UtMTFlYS05OGNmLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxjM2FhYWY3Ni1mOTdlLTExZWEtOThjZi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjI4NzMiIHQ9IjEzMjQ0ODg2OTQ0ODI4?=
 =?us-ascii?Q?NTcxNyIgaD0iUS80SmNOTXJPLzRTNU1YSFR4RHlZL0tSZ05zPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFB?=
 =?us-ascii?Q?Vi9sMkdpNDNXQVJxSW1renZwZm95R29pYVRPK2wraklPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 7a5a918d-c10f-4650-09df-08d85ba2aaf0
x-ms-traffictypediagnostic: DM6PR12MB3193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3193629CB604E5484BD654A0DA3F0@DM6PR12MB3193.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7+wR7uCjz+pYvQ5YL5oRaOWLVbtx+NsHsiODnHpwJ3gPWjxm2qKYiAlkcZuiAhcnf/6gemTW+vTAqqJIupdY7GtYmXyo9rjmP6cPlx24Jd4YL24IimRoc/3DXBEy9lOHvtiERRN9e2rhU1NRJCvLSkkQxG2l3y/qaphUWrFWT4DIDASXmLFODEdBWjV4b51p77/TkD0v9gLHh6mQmVbejucjU6yX2kO8HmtH3DrUpHMmul4QB0qiuYJbiNIPHqpMPlGsvrg2TO0A4Rh9z3cH3ap34sYnNFcvZDhEZzuSFF2maYg46Yu/i0gjxvDND0el
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(136003)(396003)(64756008)(52536014)(71200400001)(33656002)(5660300002)(186003)(26005)(86362001)(9686003)(54906003)(2906002)(6916009)(8936002)(8676002)(107886003)(4326008)(55016002)(83380400001)(66446008)(66556008)(66946007)(7696005)(66476007)(478600001)(76116006)(316002)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: a42qvTDddl09BsqcuZrkDe2IBC0EIftAyFJa9ORUzL68qZNFKIW9IcqlhYJ7fl/oA7gHQm9GONtkPRhmaR3Z3RH/wXJe0ncBzqH+T78wNrmv5XSupWOKyV/tFeEb/mtfW+VXS+oIOZ2Z7fRVwblkeEyHubr6zl9HYKmLSOEAoSxOgniFGPdioCh4Y8h60ifFhcIqq+DuGbL+0vbJk2eoZfEogmdCYXhT47ZjfxNgCQJcNw1nM5TmGdDwOfA+fjXUCYEEKlRFBqFTIqr3+OKsZQ778vnaHCSi0p1d5eVGlL2FUEw6c3A7haoYHigQrXkm5shMhikunD7uzANoLz2D1EAvCgiU9qt2jHG/eKXes+TRmalcI/2zYRq9zurfVEWu0fIzbemdUucRnms1SeTT2eQOWYsBhU+0bIkIN7DXMKvjk1CZ5p75dLB/ZPndd81L3s2X3XXbKZK+ktIjchN68Z4FotXj1hjx81ev+K5CsVJ5qFJaGCbg2kIlHHLLkL55tT58rG2Hmh49Knxy3cVOBE6NhmmHPaB8XgZk9jqtozdt1XmvK4CgbRgDVdqs+znoGbJIz4VYSFWUTOPgwEtlxmD8lsH99DaCTSuR4TDJ0/evALQU139TmdWHimX7grAXhnkeRkmGBL40cGIOM6o+zQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1276.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5a918d-c10f-4650-09df-08d85ba2aaf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 07:15:48.2183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39dB5J7I2IVIzEEzrpsaXHuRAu5KFV7HHJ52jJF1YjMw4fzLCJLC+KOzfbvQKSxxWF5j3d5Mo8f+vqZKSuYwTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3193
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 17, 2020 at 22:47:59, Bjorn Helgaas <helgaas@kernel.org>=20
wrote:

> On Thu, Sep 17, 2020 at 11:28:03PM +0200, Gustavo Pimentel wrote:
> > Fixes warning given by executing "make C=3D2 drivers/pci/"
> >=20
> > Sparse output:
> > CHECK drivers/pci/controller/dwc/pcie-designware.c
> >  drivers/pci/controller/dwc/pcie-designware.c:432:52: warning:
> >  cast truncates bits from constant value (ffffffff7fffffff becomes
> >  7fffffff)
> >=20
> > Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Joao Pinto <jpinto@synopsys.com>
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index 3c3a4d1..dcb7108 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -429,7 +429,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int i=
ndex,
> >  	}
> > =20
> >  	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
> > +	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~0 & ~PCIE_ATU_ENABLE);
>=20
> But this cure is worse than the disease.  If this is the only way to
> fix the warning, I think I'd rather see the warning ;)  I'm hopeful
> there's a nicer way, but I'm not a language lawyer.

I don't like it either, I tried to see if were another way a clean way=20
that didn't imply creating a temporary variable, but I didn't found.
The issue here is that PCIE_ATU_ENABLE is defined as BIT(31) on=20
pcie-designware.h. The macro BIT changes its size from u32 to u64=20
according to the architecture and by inverting the value on the 64 bits=20
architecture causes the value to be transformed into 0xffffffff7fffffff.

The other possibility implies the creation of a temporary u32 variable to=20
overcome this issue. It's a little bit overkill, but please share your=20
thoughts about it.

void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
                         enum dw_pcie_region_type type)
 {
-       int region;
+       u32 atu =3D PCIE_ATU_ENABLE;
+       u32 region;

        switch (type) {
        case DW_PCIE_REGION_INBOUND:
@@ -429,7 +430,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int=20
index,
        }

        dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
-       dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
+       dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~atu);
 }

>=20
> >  }
> > =20
> >  int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > --=20
> > 2.7.4
> >=20


