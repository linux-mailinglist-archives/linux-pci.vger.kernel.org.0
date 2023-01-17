Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2C166E672
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 19:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjAQSv2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 13:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbjAQSsj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 13:48:39 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAAA4DCCB
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2023 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673979333; x=1705515333;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cs9PRyMKl+fTfibu3bFmjN91HAM0npT6zgM0PBXVGkM=;
  b=Zt7wUDFoOR8JzkVW6QTqWVJ+73wNVxtwY+Flw9sk3KD6U1V04210OM3R
   0lLcf5exUCUEoGtZyfFKgiYrpxj3pML9wrW/Bl8yfE1FxZuMqEJtKoWPd
   5tDRPThhI+giLTShzG0dP1V+MRAnTkG4388v28kitEpRnZM58sDhRNkt7
   ps5pr8Y9a2e10oFsQC0NbhBps/QtDtyKWNji3k9KecrQt+H5Cu4Z9yTqS
   mF+jHIBou9DRyG03mLaD0rJVm5T8qBA+3rPjMioma9JId+UJFl5FJPOlI
   lNj8bxPcxjY/S26kBqbVItzQ4LmlodB5UMXQfg4QRIIoQstFfDX+RCxHX
   g==;
X-IronPort-AV: E=Sophos;i="5.97,224,1669046400"; 
   d="scan'208";a="325343155"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2023 02:15:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRWkoZGYBhRVTnfrrxdfwJOi8ebC0AlUiuaz9ix0LQfV7fD1i27WDncexGQ61rImqL9TqtbfNYj30UZKN3MnZGMG4l+70RMV1/34TPRbULtzZCzUNK1xmD7MHVgFqqbQkF3GD5sYnc/Z1H/YPyXjR7z4a18/96dwIlIMiTUGk2svvIy47WU5nUZZe44h0EW4ba+Ow7FIAKA+jgepiDlL5bj45yzAVl9ICk4xWuJCJfUexvkPMlzC4+ImzOtJmokgCCSYHHgKJSEP9VpuQKvBw4UFbGSTWgHC6RrKZL7xAe3Yudpncyq3wLGCoEgTihcBtiPiw+nHx467oz2Yf66KcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lEEE51EaNQIPTbPFPnShg/11v24NWtXd0KL/V01xhQ=;
 b=jQPCzqz2FOYR4NV8RzBPZP1u3cnIW9dRT7MNKJNW3fib/rmX2at1iKj8PiLyRvPjUiv8AdesfFWL0XeTPWqSe+0A9Hj/ghmEaTh4MuCD3SG+YKvtkHVfGkl6LEBHp9RHgp2gPfQxIgm9oKpj1AOgjgN/gGsN746rQhgEjkX3I8ED4HvC2ddSQgDWxjdMYGn3OpXb1/E+Da0QkIJRjBYPli2+hWVqGWAVKlrwEdjBODJWWwVm0rQocVLfcQQPALTnfpY21cm7x9QtFABg2fhRjkKsAUCnp5zrJZ34lMFOmxaKoJAp6uIkjnBdRjTyA/+qo8ZtmPhW/64/zF8MDlKQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lEEE51EaNQIPTbPFPnShg/11v24NWtXd0KL/V01xhQ=;
 b=JiCQxMxLqH+HzPvRDRtNU+XtUWHt4eExJDYjG5zojWhinEk6QzKky945bYrLukRnsutq733+Z8mq7GOYEpRU7rco7Gi7hFpENuIDzZSuIsYTuO8Pd6BI3zl+T1ZQHFJx2CyvlFl1F45K/jsKPBWqRNW36IOja/XFM6SNnn6C86U=
Received: from DM6PR04MB6473.namprd04.prod.outlook.com (2603:10b6:5:1ef::23)
 by SA0PR04MB7178.namprd04.prod.outlook.com (2603:10b6:806:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 18:15:29 +0000
Received: from DM6PR04MB6473.namprd04.prod.outlook.com
 ([fe80::27e5:bc1:9b25:d24c]) by DM6PR04MB6473.namprd04.prod.outlook.com
 ([fe80::27e5:bc1:9b25:d24c%7]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 18:15:28 +0000
From:   Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "'hch@lst.de'" <hch@lst.de>
Subject: RE: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN730
 WD SSD
Thread-Topic: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN730
 WD SSD
Thread-Index: AQHZKdjydF/vmoLqekqeVIf5E6S3m66ixGcAgAAlMGA=
Date:   Tue, 17 Jan 2023 18:15:28 +0000
Message-ID: <DM6PR04MB647368572FC2A56C2869B1758BC69@DM6PR04MB6473.namprd04.prod.outlook.com>
References: <BY5PR04MB704131DBB47254C9F1FF12B38B409@BY5PR04MB7041.namprd04.prod.outlook.com>
 <DM6PR04MB6473197DBD89FF4643CC391F8BC19@DM6PR04MB6473.namprd04.prod.outlook.com>
 <Y8bE0gfBq0sxsefv@kbusch-mbp>
In-Reply-To: <Y8bE0gfBq0sxsefv@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6473:EE_|SA0PR04MB7178:EE_
x-ms-office365-filtering-correlation-id: 5764eeb4-f2a5-41da-be5e-08daf8b6d03b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 13tGMPRWTyqhzXv7bFudhs45EFf6BlRPKqEgjiFJ3ryV4R10Y1QzU2cyQJzwVXDUBKRs8oLoanUrddw2JVoiADqEcth6Ml9pDuw+CjlwANeoMWnEUiOjPUCmh9UgbjmT2C5mGECl4YR7wFoFtk5/R7ehNqxCWzgrWuvpHIW4p7abl8Ipy1vTDSid2PHm/7B7rZ3aZAi+AmD2nPwjR0coaX3EvtSEWUOZ0DKIFD9npnSdy1SIxt1jqKZLZ0AMdqFnZiHf0e7MjTCJCgTvqasIF2iz+zyscGE0c5buSqLed5iALCCcqSKRb1WqCkI12QtIqSVhIoC7Vy3rfezgLjg+0ZAxl2FdvLitzT9ceEcUoZYdoF81CHfQdQufN3SPvPaRpi6BOpyEowiNswOdAcpAkjCdZd069ZhDj2nO5HUzWn6TnvhqK7vVdHT1qI4S+BR9mYWDSH9xQZjAlKLX70DjRVx3j4tp1eMi9rZLzEkvzfYI2K1WvITwEXur4xuOeaMl0r6Y5C1y/hsfELc0+qeGcsgepDmLbgsm0yCpbUxdwovd1JJ6FeLTTmyeez5Ojg2E6Lnoook/iiSXI/cTV6PPAQVW1kI8Nby343s0G+dXmlRFZmkXnRBAq5AhCh60nvPcfrvjtGCJtP8GCXR2nxDd6XvIBHZiG+iciprIdKqYVQd7HJRWgGhVZtub4bra0T4iZzyUwcR7A+O/Ao3NViAy+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6473.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(82960400001)(38100700002)(83380400001)(33656002)(55016003)(122000001)(38070700005)(86362001)(2906002)(5660300002)(76116006)(8676002)(52536014)(6916009)(66476007)(8936002)(64756008)(66446008)(4326008)(66556008)(66946007)(41300700001)(9686003)(186003)(6506007)(26005)(7696005)(71200400001)(316002)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n2zbPrTc68Y7uMnhPpgIAWpYlo5oFrrqKfyyu+jM6OjuhWvLxB1lx6QcpLyU?=
 =?us-ascii?Q?E6uLqWCrJZNzCSTOEoIvFudFp3G7b4wZW8kvKj2fe5DcuBM6QjlXWpA4qukK?=
 =?us-ascii?Q?coTvM0pgoEck09CeIFzgojoqsn9xFWnpgz3dWGSIjK4xQQyHF4PkVXKE2Ucy?=
 =?us-ascii?Q?80x6fz6XznNQhSOax6wZ0SyF7IeBBz5lnje11W80/1WRRVsuD/QJYSRoSOX+?=
 =?us-ascii?Q?MW4XalwJS3D5B6Udp/1ZbZnWQNP4KAEkxgx7lbpcCqpRmPnhRu8erxebCVCL?=
 =?us-ascii?Q?Vx+jNsKv9bOCJAUcK+BG2QSllRJTbT0lrEHIVD2ElKLogiHBW5l82Fjmi97N?=
 =?us-ascii?Q?CS/XBJMcDaon3r1bc3xhiiXgHdy8h4qWI0rTpwcfbjsyfJ+rLPMuHrmBcvyt?=
 =?us-ascii?Q?MBbCMPiYvoUvGQojN8xdbJYjIccipu/08mIYOITUAixwgbFVMx/MjVyJFjd4?=
 =?us-ascii?Q?wDux5ZenfdDrExB3Qz7bFA4GXez4frsarLOeZLCD9NMOMnTpvSCW2fpcYeF6?=
 =?us-ascii?Q?Si65pEKFWnc3Xyx9c7AEx7U1qho2b43nsqXvhwczrBdn+MXRMHwwmCy19DD9?=
 =?us-ascii?Q?K7FNRO/LquOoWnSVtFZrAZlJg2xn24lCQmPqfSJdYbUEJqi48LtfgTOTS5qv?=
 =?us-ascii?Q?JUknohGIhksjcvVKydTKBVHcsd4gbP83Ovxkf964B0IQfocBRcxa18CK0Tu+?=
 =?us-ascii?Q?5JxqBi/mPysZ9cVXbPP/1PkEOMdAOMtxLKHKkS0zN6NwApCAApTAt7kk1UuF?=
 =?us-ascii?Q?ubSu31Y12WOd8ItMPD0vaq362YfC7SoLJ831Yt01c4bmi47TVLjX6Ojq/Rrl?=
 =?us-ascii?Q?uKdPaR1bTar4VS8BrM85ebymtgy81H2EMBcyS068Fg8qPVyT96NKA6jvMqMt?=
 =?us-ascii?Q?iSj8+/aynynm88GK4Rzsi9Yf56moEEJRBsFFLPYJuP6iTwHnlUz2EUht7us4?=
 =?us-ascii?Q?LUbI8OSOoIF0mwoe3fSajvzzwhSnH6GjGkpUdTDKgf3Kywxtb5seeZbHdOKV?=
 =?us-ascii?Q?KgANPswfBxkmMl8da28BdBa2qEs90esh745Z5h+Sti4BixZsrmVWPa+4o9xY?=
 =?us-ascii?Q?8PGtennBd5jiyAWLXvCgBunbeYgY24VxBsFKVE2mnyxEJCBZ+ZlJSDGPmMrW?=
 =?us-ascii?Q?8msP4wEx/Le06YARQs3Wrx0WnkitRMXUkTGWv/bLbqI5NCIiWRImeVbFGZGo?=
 =?us-ascii?Q?6ibufJB3G6U8sKg4lBtY/8VBqD0ntgsGCNLUvKxZraMi8aa9iYzo0Wu4gUNj?=
 =?us-ascii?Q?uJEDNWysyZCePJwUt57P05FjRdZIezFOVyOrnqx0EVVlq2KJOPn9ZKUd3jqW?=
 =?us-ascii?Q?27xxfJDc7AQufS8AyDXyv5ZefapIAWpB4pX83acc5Y8rqkArtg2oWJxCMVtg?=
 =?us-ascii?Q?E8n8cQnEw86jL+A5WrzYDMnaACBj5ZPVMeTJuHAtvp13jfcXRQ35qv/ynFfC?=
 =?us-ascii?Q?RAlavJooH4RkRHMxh56M6eAJy9WjXlI26PQcQg2SJTSwQd8TnxItPhexAnEp?=
 =?us-ascii?Q?b6uRKBs7bR5Lvq84uNbo7SBn6V9qDzFWb3t2RGsoHk2nN60l0/7CBHZqda65?=
 =?us-ascii?Q?vfc7zNQeGh1gARlD/iW5jLnv4fsD9nvpxJofZRng3fUnfqOxiXzr3fHydEF5?=
 =?us-ascii?Q?xQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fn0NATG5Bk5dVKgckq3yGZAmREyc78stVNjzK2zerV9LYBL6Q0aJeHyZYCebQPNHxurBpzkTHlDpNdhOoDw9pbAFuXH7Z6Y/Mntbo5UjwdUCVrcIouuLlRI2RO5koy5XMZX/IQ8rkPOyAi0SdLF1Ukw+RAxU4Jd4Zcb2J5AvW5WDTVSPoRCj7lcp2chCoccZZ3/bbL0W8xIzd5V2Ri0k0NN9QZoQBtBB/vhUL6Uc4U76mX50sXftH6nds8jZGI7m/ozHsJtN3zuWAZn0RTK0GF7Io+O2cP34VBEsE4HIGTc4jOsCWN7jM/L4DZmTfSyXbkBBpC8EM7h3MXSUXpzCXIr9HbdRyU66lZsByW6+J+mUHc2wC2SrIlWMhJSVbKUGqAlBkYnIzEgch5MdNyXdSylr7GwqipPEB1KkF3887KGuHmJ3peBbWn+mNriQOGhTL35nL5UFfGizklIjN0aayV9M1ToHjF4PuRdAjlWJ/KOHyzEYIQ5K7Yc49O8cb1QmuZao8a0JeadQYkRPGJ6QH53Vj+YD3uO231N+pqWV9NhxzBeSNlJSh+fXAFVZmBi/duWwT7jIzeS856LwwwAPwCeOzlHZh5bVTL+9WqGCEXH0vvafBcgdY17egfUMmG8cMmexupF1hNaff8kCazWwqliXrMPjOzKseQ+e86wvXpX+V3epsa9qyHJFe/CRlya0GDqowK2dFK1vMEh0rOPtC4Coy5CNxqjRg6VelaDywtAIx+UiT3uyvvQ32cDSHlyOg8FkgkLl+OqFjyuFkgyuu904WriQ29jJknCYT1NkmOg+ZFdgClkrVGutBtGzY+1OyPWTHwXKkXWHp3A8jiAFKw5hAmaZ99sgxTn3n9rYm90=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6473.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5764eeb4-f2a5-41da-be5e-08daf8b6d03b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 18:15:28.7502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7Rio903isCXhwb33hVt689G10FNN3UZgncMCoMtwOkcSiCLQ8AXFH0Voq4Lbbpx+bhLU9cWh7aW162fwA1tDRG88PAcD+YiLRwB4wmuRRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7178
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


>From: Keith Busch <kbusch@kernel.org>=20
>Sent: Tuesday, January 17, 2023 5:55 PM
>To: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
>Cc: linux-pci@vger.kernel.org; bhelgaas@google.com; 'hch@lst.de' <hch@lst.=
de>
>Subject: Re: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN7=
30 WD SSD

>On Mon, Jan 16, 2023 at 06:32:54PM +0000, Alexey Bogoslavsky wrote:
>> From: Alexey Bogoslavsky <mailto:Alexey.Bogoslavsky@wdc.com>
>>
>> A bug was found in SN730 WD SSD that causes occasional false AER reporti=
ng
>> of correctable errors. While functionally harmless, this causes error
>> messages to appear in the system log (dmesg) which, in turn, causes
>> problems in automated platform validation tests. Since the issue can not
>> be fixed by FW, customers asked for correctable error reporting to be
>> quirked out in the kernel for this particular device.
>
>> The patch was manually verified. It was checked that correctable errors
>> are still detected but ignored for the target device (SN730), and are bo=
th
>> detected and reported for devices not affected by this quirk.

>If you're just going to have the kernel ignore these, are you not able
>to suppress the ERR_COR message at the source? Have the following
>options been tried?

> a. Disabling Correctable Error Reporting Enable in Device Control
>    Register; i.e. mask out PCI_EXP_DEVCTL_CERE.
> b. Setting AER Correctable Error Mask Register to all 1's

>I think it's usually possible for firmware to hardwire these. If the
I believe these options were discussed but deemed non-viable. I'll double c=
heck anyway
>If firmware can't do that, quirking the kernel to always disable reporting
>sounds like a better option. If either of the above fail to suppress the
>error messages, then I guess having the kernel ignore it is the only
>option.
This could probably work. I'll discuss this with our FW team to make sure t=
he issue can
be resolved this way. Thank you
