Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCCF318C31
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 14:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhBKNhG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 08:37:06 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:41722 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230381AbhBKNfB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 08:35:01 -0500
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D36714009F;
        Thu, 11 Feb 2021 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613050385; bh=FkLZ4MH58UPauVxerd2NS5eMIEFakOr9nWnqzupNnTg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LNCd/oWHOfip2irGUZnQNPoOkw44qmeqM94nWaZBoAQ1Bxkznsh/2olrnjrf/UWap
         QO2NYfQE55lM6RFnjvVXFojCEAqPvhuuIuE26vGUxyhhJceFnq58HUefTiBYRHCLYc
         znCplo8GNkOnREv0/o6I37uCrYCyaq9/ANjmr+IUDDu5DyFyMj+ve5Myjvk9GmkKzd
         /EuQQBigISeMEeceM4gr0sAddfJUSr0iV6qnXzOjZA75PAtT9t223aE7aDVhHLJ9wz
         V80kdlbRMLfoM4wpW3EtaaflCG4PS3fBFFif6s+N/fq7T+tTjk0Ca6FloIeQI+4cn5
         TA7bN4ucnkKpg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7F6EDA005E;
        Thu, 11 Feb 2021 13:33:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9790380214;
        Thu, 11 Feb 2021 13:33:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="JF9YjIq2";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+TRJSKj0Gmosx3Wie7FpeF6BmJnRf1uFWVYymM9Vyjmqu+896KWmIb+4zFOsTGv0b7AE4Z31TZLCcBJgImyjFpBjPxy4YN9nXF+MG9IxCvQhP5/e/6TezEiwMetGJoA+Seut/6b0fYOR7qWuGZTnHbem29L64RzF4UcpFMuFdiQsSFUDkCz4lanppwtJ3OWXENfICj7Ec+duQLZSOwveL37ql0QHbZo6qwOeyjGZkfyGuqrBnLiUdEdckt6Yy5XYfqxXmo+HXnB4eZgdoA+xGHI3nEN0h5sQKZmJeD5pOy381TMA+QcpjhBaC6ukDSIxRX439pKLIs6j+MMqTxtFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkLZ4MH58UPauVxerd2NS5eMIEFakOr9nWnqzupNnTg=;
 b=MUICUs4EBr1VEd43SuEuhRwy1O+TXuFN3HzcrF5lr6O+mlMd35dDZr4tusMQg5qPZlIx5x4CFIg22rC7io0tmmYP7wKjluwKbPn+R5SFX4F3mOszOt4+St9etKiGv1IBTGn/hkEkP/147N62P09IdP+agIzzhC5LxLcN7xXbfCztydfWsCHw7V6Zncn7ZXKjLZxh24GJzpqPnqtx9GTPZToIswzGqNE5meF1Uume6GzNOLXF+sAL+cLekiboR+aWAJr9W9sMsgvkvWKWqHZ5zjXkD8EqSXrYQRGVRNhIEhHzGUIbiAk87L4YCO/jZWGuKtsjhSHr4L34sWr8wcRV2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkLZ4MH58UPauVxerd2NS5eMIEFakOr9nWnqzupNnTg=;
 b=JF9YjIq2C/cnkl/B76jC0OFx3j3cvDAJWEBJq0r3N86iyH7nOuf6eiN98HATdoCtx/HWm5oG57Q5qodnbB/wa0PvZsKsMZyvD5k7GCjGxFyPWw1IWBVPuXD/KNZJtUIqKeaxGcNKAbzgzsbf33fFDMKjZKA5hWDcsCjRrQVEvJE=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB3177.namprd12.prod.outlook.com (2603:10b6:5:187::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.27; Thu, 11 Feb 2021 13:33:00 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3825.030; Thu, 11 Feb
 2021 13:33:00 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v5 3/6] misc: Add Synopsys DesignWare xData IP driver to
 Kconfig
Thread-Topic: [PATCH v5 3/6] misc: Add Synopsys DesignWare xData IP driver to
 Kconfig
Thread-Index: AQHXAFWQTl5bJmx0wUiokstsEoq+OapS0beAgAAiXrA=
Date:   Thu, 11 Feb 2021 13:33:00 +0000
Message-ID: <DM5PR12MB18357F5C7B567E79264540BDDA8C9@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <1b76d5e1a47bf3a30a863319587195037ac3e4d7.1613034397.git.gustavo.pimentel@synopsys.com>
 <YCUVJ4TZRVfN1pEn@rocinante>
In-Reply-To: <YCUVJ4TZRVfN1pEn@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWjNWemRHRjJiMXhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MV0UwTUdaaFlqQTVMVFpqTm1RdE1URmxZaTA1T0dVMkxXWTRPVFJq?=
 =?utf-8?B?TWpjek9EQTBNbHhoYldVdGRHVnpkRnhoTkRCbVlXSXdZaTAyWXpaa0xURXha?=
 =?utf-8?B?V0l0T1RobE5pMW1PRGswWXpJM016Z3dOREppYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?WTBNaUlnZEQwaU1UTXlOVGMxTWpNNU56TTBPRE0yTlRjNElpQm9QU0l2Vm01?=
 =?utf-8?B?bVJuRlJLM0p1YkdsdEwxTXJORFZNTXpsUlVWVTBTa0U5SWlCcFpEMGlJaUJp?=
 =?utf-8?B?YkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNTRlV4VWxOU1ZVWk9R?=
 =?utf-8?B?MmRWUVVGQ1VVcEJRVUpwVUZkb2JXVm5SRmhCVTBseVRTODJPV1ZaVW1SSmFY?=
 =?utf-8?B?TjZMM0l4TldoR01FOUJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlNFRkJRVUZEYTBOQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UlVGQlVVRkNRVUZCUVU1eVUxWXpaMEZCUVVGQlFVRkJRVUZCUVVGQlFVbzBR?=
 =?utf-8?B?VUZCUW0xQlIydEJZbWRDYUVGSE5FRlpkMEpzUVVZNFFXTkJRbk5CUjBWQllt?=
 =?utf-8?B?ZENkVUZIYTBGaVowSnVRVVk0UVdSM1FtaEJTRkZCV2xGQ2VVRkhNRUZaVVVK?=
 =?utf-8?B?NVFVZHpRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdk?=
 =?utf-8?B?QlFVRkJRVUZ1WjBGQlFVZFpRV0ozUWpGQlJ6UkJXa0ZDZVVGSWEwRllkMEoz?=
 =?utf-8?B?UVVkRlFXTm5RakJCUnpSQldsRkNlVUZJVFVGWWQwSnVRVWRaUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlVVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVTkJRVUZCUVVGRFpVRkJRVUZhWjBKMlFVaFZRV0puUW10QlNF?=
 =?utf-8?B?bEJaVkZDWmtGSVFVRlpVVUo1UVVoUlFXSm5RbXhCU0VsQlkzZENaa0ZJVFVG?=
 =?utf-8?B?WlVVSjBRVWhOUVdSUlFuVkJSMk5CV0hkQ2FrRkhPRUZpWjBKdFFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRa0ZCUVVGQlFVRkJRVUZKUVVGQlFVRkJTalJCUVVGQ2JVRkhPRUZr?=
 =?utf-8?B?VVVKMVFVZFJRV05uUWpWQlJqaEJZMEZDYUVGSVNVRmtRVUoxUVVkVlFXTm5R?=
 =?utf-8?B?bnBCUmpoQlkzZENhRUZITUVGamQwSXhRVWMwUVZwM1FtWkJTRWxCV2xGQ2Vr?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVGQlowRkJRVUZCUVc1blFV?=
 =?utf-8?B?RkJSMWxCWW5kQ01VRkhORUZhUVVKNVFVaHJRVmgzUW5kQlIwVkJZMmRDTUVG?=
 =?utf-8?B?SE5FRmFVVUo1UVVoTlFWaDNRbnBCUnpCQllWRkNha0ZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJRVUZCUVVGQlFVRkJRMEZC?=
 =?utf-8?B?UVVGQlFVTmxRVUZCUVZwblFuWkJTRlZCWW1kQ2EwRklTVUZsVVVKbVFVaEJR?=
 =?utf-8?B?VmxSUW5sQlNGRkJZbWRDYkVGSVNVRmpkMEptUVVoTlFXUkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZDUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVsQlFVRkJRVUZLTkVGQlFVSnRRVWM0UVdSUlFuVkJSMUZCWTJk?=
 =?utf-8?B?Q05VRkdPRUZqUVVKb1FVaEpRV1JCUW5WQlIxVkJZMmRDZWtGR09FRmtRVUo2?=
 =?utf-8?B?UVVjd1FWbDNRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQmJtZEJRVUZIV1VGaWQwSXhR?=
 =?utf-8?B?VWMwUVZwQlFubEJTR3RCV0hkQ2QwRkhSVUZqWjBJd1FVYzBRVnBSUW5sQlNF?=
 =?utf-8?B?MUJXSGRDTVVGSE1FRlpkMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVG?=
 =?utf-8?B?QlduZENNRUZJVFVGWWQwSjNRVWhKUVdKM1FtdEJTRlZCV1hkQ01FRkdPRUZr?=
 =?utf-8?B?UVVKNVFVZEZRV0ZSUW5WQlIydEJZbWRDYmtGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJR?=
 =?utf-8?B?VUZCUVVvMFFVRkJRbnBCUjBWQllrRkNiRUZJVFVGWWQwSm9RVWROUVZsM1Fu?=
 =?utf-8?B?WkJTRlZCWW1kQ01FRkdPRUZqUVVKelFVZEZRV0puUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRV2RCUVVGQlFVRnVaMEZCUVVoTlFWbFJRbk5CUjFWQlkzZENaa0ZJ?=
 =?utf-8?B?UlVGa1VVSjJRVWhSUVZwUlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCVVVGQlFVRkJRVUZCUVVOQlFVRkJRVUZEWlVGQlFVRmpkMEoxUVVoQlFX?=
 =?utf-8?B?TjNRbVpCUjNkQllWRkNha0ZIVlVGaVowSjZRVWRWUVZoM1FqQkJSMVZCWTJk?=
 =?utf-8?B?Q2RFRkdPRUZOVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlNqUkJRVUZD?=
 =?utf-8?B?ZWtGSE5FRmpRVUo2UVVZNFFXSkJRbkJCUjAxQldsRkNkVUZJVFVGYVVVSm1R?=
 =?utf-8?B?VWhSUVZwUlFubEJSekJCV0hkQ2VrRklVVUZrVVVKclFVZFZRV0puUWpCQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVVZCUVVGQlFVRkJRVUZCWjBGQlFV?=
 =?utf-8?B?RkJRVzVuUVVGQlNGbEJXbmRDWmtGSGMwRmFVVUkxUVVoalFXSjNRbmxCUjFG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGUlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlEwRkJRVUZCUVVFOUlpOCtQQzl0WlhSaFBnPT0=?=
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 300427c6-98fc-4a2e-b5ae-08d8ce918cdb
x-ms-traffictypediagnostic: DM6PR12MB3177:
x-microsoft-antispam-prvs: <DM6PR12MB317729CDCCF73019189A226CDA8C9@DM6PR12MB3177.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6x4BAtv65fWlsG9p4rSkRfXlAYF/cEVlbgNfVvu+b3+7EDNEReVk/A8DxPqNYSREMuiitDR2rGlJiPaZskMHVmxzA4MXM1BLj6zGH7lz5OSyYPVAVHzxGVCm6F0yOxZhZiai2/jHhDmiGKb0LzoQ09BED1iLRcAFQVDZ2itKOJcsQt/ujSza8+2n+1pDlNeI0LcXGyacVYYvrlfRTk/Qo6Rvwukd2Pp9i0GeCdJGul4+Bsrxx+InCI9vPP4fMvR4N/7zTWu+3LLJlHGl5OcUNReGu524rWSrpfMe2iISX0f14xbbD39Cg9AbmuIM5yVWhWcWGMMtM2QJ3tkoP1f7EY3mw0A4RDkH2JKVyz90Zv0kpEtdC8DShrt7mNhAt+evcAo7wrSJmfvB7rDytdlcmiOKWBV8NQ8xcXMm+z0tr5q/+UP5HR8jsL239pKkBk9p3By9jgs+SWUI6nDkDSaGh+LsSfAcCTEoT7M8MxtT/V/H1KfEZdvXE1dNooucudZDpK8iWJlOQvulajsPCFaVtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(366004)(136003)(346002)(26005)(316002)(7696005)(6506007)(5660300002)(4744005)(53546011)(186003)(64756008)(66946007)(66556008)(66476007)(8936002)(66446008)(86362001)(76116006)(33656002)(9686003)(54906003)(8676002)(2906002)(55016002)(6916009)(478600001)(52536014)(7416002)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cDQxR3RCNUJyZy9WZUhFbmlWbUdYQWlQS2w2UTlUempvdmpkMjZ5L3RSWVV0?=
 =?utf-8?B?V2ZmZTMzZkJrUzk5QU84OVpFaGNLT3ZrSWdTeFNvcWIySVl5RmFUWHpzSkV4?=
 =?utf-8?B?VUJBSTJMVmhSUGF2bWhJNk9WUjE2MUc2VmNZakpudkltK2hMK1IvRzI3NTUz?=
 =?utf-8?B?STFxeXZKR1RoWEE5R3IzMCtZY0tlNW5yZVBESGFFcWJVR1ozSWlxdzlJajlS?=
 =?utf-8?B?cVJrcmEyUm1reG1WbXFlVFV0N284ZitqdFRBUHJvVEpnTUx0NW03Z3hpcGhq?=
 =?utf-8?B?QkNYSHU1dVRWL05aMkErdDdaRlhRNVU4UEI3N1pLbnJOK2tpZEpRcm1kSlJr?=
 =?utf-8?B?U09NcUVCZTY5NmRCQUFMOXZialBTRDI2ckNzU2lvaUo1enlJSGZ4cy9HVXR3?=
 =?utf-8?B?RTlWdVU3dno5T28rSVZJbjZQR0xQVkNkb1FWL0ZKbHZSQjdBMFovOEJWZlYr?=
 =?utf-8?B?Z1hqeWV6T3RmbTM5KzJDZndhdDk3dVNKLzFVa2FwNTY2Y1RFSzBhL3k2MWlI?=
 =?utf-8?B?Y1E4ZzNoemk1aWJFc1lqVGd6VXNNWm15Qi9Ya2ROOGtQczRMc0JXRXE4bkFK?=
 =?utf-8?B?emJ0dDR5a3EySW1VbS9Sazg2QTVxVFRNVE5ZUDQ4VjFlS0dPMjZRSDZYTDE0?=
 =?utf-8?B?NThSS0JDcGt1OGFpclJmUW5LRTZ2bHVEcW5FaHpCRHlEazJtbXNQUHJvNlgv?=
 =?utf-8?B?YTY5QmZhVUxUcHlweG9xOFZ2c1A2dkdTY2Zmc2FUa0llcU1yUEN6ZUxzV0pu?=
 =?utf-8?B?NG96ell3WmRneWZCVVp0ZEZjYjNpT3FoOWNaMklEeTcwMVhPOG5TY2wyWDZM?=
 =?utf-8?B?c3lkYkl3R0ExaXZWTTFsdVR0Z0dBS203NFJzNURsSjNqckFNbWV2b0tXV1Nm?=
 =?utf-8?B?MHpwUTlNK3hrU0hXM0hweEY0dmUxbUh4a1JPOXExMjVqYmt0YzlLRVhUeUVC?=
 =?utf-8?B?WDlJdEZJdnZYWkVLRHVjN1M2M3prTks0Zkh4ejVycVlmK3pMTUpJSCtqWGJC?=
 =?utf-8?B?djVGRkJzdWsrRS8wSGVtQUtIa1IyallZNldFRG5qNS9DdEVPcHVsRFJZNHhI?=
 =?utf-8?B?czF3T2FScXZqcGhZT3RDeXlRS29TeEdFNkkzWTdLUEJCRHBnZUgrSXFpTS9t?=
 =?utf-8?B?MFJFbVN0U1pLeVpERi9rMElpZkVZUXRxY2UrazFIVjdPT05HWmpybVY0VkVm?=
 =?utf-8?B?dHBqemJSWExuUUJvYUswaHVLS1N2cVBaNkJnNDJtL1hFb0lMb2VrZ3ZUK1pL?=
 =?utf-8?B?WU9IU0p1WHlZQ2dkeldoNzVBUXpUaXlVWWc0TDVLaVUwRkFlOEd1UGNBaTBC?=
 =?utf-8?B?SmxqU0hQY2hGeTk2QXRNa1l0Qk5uNzZmUUtUSmNRcGpDdnpqU1Fjc1JyNG9Z?=
 =?utf-8?B?bytML3Y5WE5iVzlyK0RvbFRVZm1uQ0ErZWRldU9ONmRxWlFrUmRqQm5QV1Zy?=
 =?utf-8?B?RUloalRzQkhiWGgyN0ZuMVd6MG92MDMvL1cyZFZ3bnpMRGtBUFIvNE1XMTNj?=
 =?utf-8?B?UW9aRXZVdGt1ZnZmaFBoUm81YUtyQlo5dW9nR1dURDc5YUxIK3EzOFFFK0hw?=
 =?utf-8?B?dkhIR2lYN1ZBT0Nyakg4NVBhdHlXTHZIVFhPV1dGR1QwMnp6TTIrSWFqZXJn?=
 =?utf-8?B?R3o2MDZzdXZGNEdsUWV3RFhsWlR5UGk4TXpPaFVCN1EyYmlVUWVtVk5GVlQz?=
 =?utf-8?B?TlJsOW5LeHJaSVN6ZVhsUGUzTHdHUFcvUGlOcmxmbG95aEhDRnMvR2VJL0Iw?=
 =?utf-8?Q?l/TMl6oz15mY6Yq1SjPsBHBr+eKeDfcsFKJhf0I?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300427c6-98fc-4a2e-b5ae-08d8ce918cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 13:33:00.1044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76AfS/2hzFQEcdMbbTiJBGQI0SNzyp4Q5IP84oQidMrMtxtY/4OST0ZVkmGzxeCYY6ZLF4716h/LwD0QMx8Wug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3177
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCBGZWIgMTEsIDIwMjEgYXQgMTE6Mjk6NDMsIEtyenlzenRvZiBXaWxjennFhHNraSA8
a3dAbGludXguY29tPiANCndyb3RlOg0KDQo+IEhpIEd1c3Rhdm8sDQo+IA0KPiBbLi4uXQ0KPiA+
ICtjb25maWcgRFdfWERBVEFfUENJRQ0KPiA+ICsJZGVwZW5kcyBvbiBQQ0kNCj4gPiArCXRyaXN0
YXRlICJTeW5vcHN5cyBEZXNpZ25XYXJlIHhEYXRhIFBDSWUgZHJpdmVyIg0KPiA+ICsJaGVscA0K
PiA+ICsJICBUaGlzIGRyaXZlciBhbGxvd3MgY29udHJvbGxpbmcgU3lub3BzeXMgRGVzaWduV2Fy
ZSBQQ0llIHRyYWZmaWMNCj4gPiArCSAgZ2VuZXJhdG9yIElQIGFsc28ga25vd24gYXMgeERhdGEs
IHByZXNlbnQgaW4gU3lub3BzeXMgRGVzaWdud2FyZQ0KPiA+ICsJICBQQ0llIEVuZHBvaW50IHBy
b3RvdHlwZS4NCj4gWy4uLl0NCj4gDQo+IFRvIGJlIGNvbnNpc3RlbnQuICBJdCB3b3VsZCBiZSAi
RGVzaWduV2FyZSIgaW4gdGhlIHNlbnRlbmNlIGFib3ZlLg0KDQpOaWNlbHkgY2F0Y2guIFRoYW5r
cy4NCg0KPiANCj4gS3J6eXN6dG9mDQoNCg0K
