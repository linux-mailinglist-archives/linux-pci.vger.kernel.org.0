Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B10F402844
	for <lists+linux-pci@lfdr.de>; Tue,  7 Sep 2021 14:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhIGMLz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 08:11:55 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:20123 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229604AbhIGMLy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Sep 2021 08:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631016647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=buzMPiRLo4X6mtdDWgXjttrreVWYxdvGTL8smO8qNkM=;
        b=fBP9BQnQq/B2VvsrqCbDJBR75WwH+Yb7QuCUbkRCnCZUBHrxpEKlNUr+xVT3eHQZa5okiX
        tFWVza7/7ASznenRlGQyjOa8bOUbRopuqgISsibDWZw15hB7MbLJ5qvyLZ3hPO4cMW4Sx+
        G8p00F6wdTEgyckR0aIM+/boXZKrWyk=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2051.outbound.protection.outlook.com [104.47.6.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-31Ji2ZHLOkaVTUI_6HUsoA-1; Tue, 07 Sep 2021 14:10:46 +0200
X-MC-Unique: 31Ji2ZHLOkaVTUI_6HUsoA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGFfI5pOHudYsCXPNFmYDflsm9wZBoUuRnhxbfea8ryF/O+5IwR8zKXWSRGFWOwt+jw6mGeb/3FK7u7SyNedIIqp0XeK83N/3JWWnnOKlb7tfu0GMQF92SL4KU8XXEj9clG0A5xyBj6PJR21apusrWdeeLfpjh6TO++TkAM1HCL44GXusdnqIXiBAifFj5JF/VmlI2z+qeNLphnP36jIakOheXpdL6PDyNrOxVLBWe1SJeVgYBoqIhPhvLvmyB7c2GCTqp+BG1GQtnVpOzeMUJPjOK7zpbDRlYH/Ny7y5ag1Qo5ER9yWPCs1YRlLR70FALd/WFdiUuXx6kVt81wpVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=buzMPiRLo4X6mtdDWgXjttrreVWYxdvGTL8smO8qNkM=;
 b=ij9RxK0H9a9ZGFFPKH1dMfbKGuWzcdP5uWCEzVXHlVphkaKNR9maympd/yaX1aG7nP7qMMIetnnELaisC1V7ge/Uy0oBkLk0RNhA9wZKxJJPTK3quY8unFsMBDgJWHWxw5rSZ/iUxFKuXiGoZmVLS94ZHfmdo8WaiEjy9dRghuyH6wWhkG2YHN/iSZu/eU2i0H8GN6a66vZbq9TX0H4Qo19eXQRjGcNaheckmnp0FNCZhDN0yz0zQeFkt8KzzAwnlDpBKdwJ6M1/G3wdKkFOiMgQniG3lEt1MCBNfMTW9/EUe5vqqTKC7IikwPCPmLge9rXzGYQS3aiVZznu3eIXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by VE1PR04MB6670.eurprd04.prod.outlook.com (2603:10a6:803:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 12:10:43 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b%7]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 12:10:43 +0000
Subject: [PATCH 10/12] xen-pcifront: this module is PV-only
From:   Jan Beulich <jbeulich@suse.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
Message-ID: <bbfb4191-9e34-53da-f179-4549b10dcfb3@suse.com>
Date:   Tue, 7 Sep 2021 14:10:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR2P264CA0034.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::22) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.156.60.236] (37.24.206.209) by PR2P264CA0034.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 12:10:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1227db84-abb6-4da7-c80d-08d971f88451
X-MS-TrafficTypeDiagnostic: VE1PR04MB6670:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6670E4AB564B1F5BDD9E0C35B3D39@VE1PR04MB6670.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7EAqm6GcEk0ur7TGJ1KZyyN8K3PN89uiz3gqAxJ9J1nOzPj2hc8dOnXprwzfy3gXqZqq5vHI5U4ZazQ5KwdXarQm6nASmvbcN6iTnjqzSOSwJIG5Gjif7Fqh0MuFMptCyiJYlNVci9h7ONjQZUeUkV8MIp4hRs1qAmKdPeoiJEvU6WFVQrvNI/y4aceIRe66/51smGTNj5QgCyu5ddAqGI+s4ocP4aySnEveTPusykjEU4j1khnETIBOt+77m1yVKsh+3FZBIPeQ8asEJZzu4vvDg5ShEdEy4eeJt9pJZcDJkavQih/ADDcO53BX0qJsydcvg1fizVKHSHuI8te0roO22eH68tPlZ/aaGpKhnes9p0IV+7js0K8p+Zoi7rYcbtLbWCN9LB9Cygyg+aCf6rR5Ket8izPO5S6DqaR+XXwZ8iFCQY/qQ/ogoE6Gpk2KQeT4XBeBI296RPD4hD6Q2keaGKze4Hmv2r5DzGgWIr76ofsaRrT8hc1MXfVNgG/SfWpZB1p8cJICfXGbyBQJFRzoVwbTMchqs/reHC8xO4CoqTPL63+DdYNiuQeQGbDxN8xezIRvx8PCngE77q1Y9jneDON/sQb+PtU9cc8/s7e2fLFOtqFdgyL7j/fvmsOBzu+lT0gQeyIxBhQ0tRgzfp0vN8WyP79S/Js8TibzmlICrFcvzxPIrLjn9CbHD3eqG4FHBEY2FX802K/bShGnNJH/EOcTuPiZf5Xg2iOj7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(366004)(39860400002)(31686004)(8676002)(2616005)(316002)(5660300002)(4326008)(6916009)(8936002)(478600001)(31696002)(66556008)(66476007)(38100700002)(66946007)(54906003)(186003)(4744005)(86362001)(2906002)(6486002)(36756003)(26005)(16576012)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2dEUFBtcjI2ek1vVS83VkNHWXVQL0ZwMFRoRW9rcHBISUMxMXE2MFlVWU1q?=
 =?utf-8?B?YWpLdjNUcU9YcDJBaVFjZzdjMXREWDdGaUJ1T1h4UUxFNktPM2JybmRsdHZr?=
 =?utf-8?B?Z3A0bVJjKzdDTUpFVllhYkpoWDJweTlHaEJidzRWdzhYeHU0YXQvY3UrNnUz?=
 =?utf-8?B?K3haRUd5SVZYZndwaDN3eGRJcmNLd1RuZVFsVGFOTTBiQm81ZmdzOUt6L3ZC?=
 =?utf-8?B?MGprWU5qeVZZTlBISDd4NnRHMVhFWFZFNzc1eEJWejJqdVA5bjFMZ1VWeHJo?=
 =?utf-8?B?Tlloa2RQTS9DbzJGMmJDRkE2dWZxdWZ4b3dhRURzYm5oNElOZjlWeTBlMG5Y?=
 =?utf-8?B?ajlMeHJTeTZ1VFU0ekxIZSs5WXFlUkd1RTVjU012LzBYdTZpU1c4UFVRNFRW?=
 =?utf-8?B?ZFBVRWM1TW0wcjZPMG9XQzA1cmNMY3ZwNG9URm5JYVNHbzVua1RXOVgwbWpV?=
 =?utf-8?B?RHZTOTUrWkNzWE9uMzFDQnJad2piVWZoKzRnOUN6dGExWEJxd3JjaWJIMXA1?=
 =?utf-8?B?c3ZnWHNQcU5TUndTdXovdEJTV1d6UEpjNGR2bGV2Q3FhSVhwampBdERTaHlX?=
 =?utf-8?B?NnVBUC81QTRWK2s3ZTJWc2NjSUJDa3Q5QlgyTGlYQWdGSzJTdkVqYXk2WmZS?=
 =?utf-8?B?cUZaOGg1TkZVL2lTMURJNmhpUEQ2OFVwYXZ5a0QyQSt4VU9zOWx6c0pqTEFM?=
 =?utf-8?B?MmhnQ1FVRHByRHd3N09XMzlOTEcxQUNPU3ZxMXVwdGZXcFhqNTByVGJyVnhX?=
 =?utf-8?B?NDdVRlo3ZUhnSXFJUkUzSHlvNzZ2eHlFREhTMk5IdFRFYVVDNjhTR0ViWC9Y?=
 =?utf-8?B?YVo2SWVpTEdHQW0relU5VzNYVGgrRW4ydHdDb3N3V1R5RjhndExHQkUzeDJj?=
 =?utf-8?B?dmZ3aHZ6RlU3VElkV3RJWmRVNHlzQXU2bURDK2h4ZWNDSnQ4aFU1VnArYXRI?=
 =?utf-8?B?aElHUUV4KzBiWTBkQ0tkTXNSa2xBelc2U0lxM1YzVTA4OTZ2cHlULzdkYVc0?=
 =?utf-8?B?RWhhTm5LdWV5QmxsSlJ2aUZ1b28rR2Rja3pqVjRtWWp1K3FsTkVmZk5sQ29r?=
 =?utf-8?B?d2F0dkhjYzdON2xHMFlaYXA1MlRTSUpkYUpuSjdPUVVZRzB0YUJUdkNnZzc2?=
 =?utf-8?B?R2FhSk1MTTE1eFgzT0dDUEZ1OU82NGkxQTBNSG1JeFY1WkE0OTFpZTdTdWJW?=
 =?utf-8?B?a2labmQ2ZEtmY2FDMzBoR0Ztb2JCSWhDSXlGQVhORHNCL1Q3ZEZHc1REVlRi?=
 =?utf-8?B?bFNOY1luS2FObzVWMVZua3F5d1lSQ20zQkFYdVRhUTUzQzRod3RibzdwQTZs?=
 =?utf-8?B?bmlYbWN6ZU03K1Vzd2tFMTlSRTR0ZmtoZXVVQkVuNFEvWHFhU292OURuaTl2?=
 =?utf-8?B?OVJXckZ2MkllcEN1aW5ycWdHaXBZRG1aRThaMk1KVldSQXU5ZkhHamJOY3hJ?=
 =?utf-8?B?QzZBVHNhb24rdlMxTG1tYkZvWWhYRHhjQkhmTE42RDJKdnlkQ05ORHFBQ0tE?=
 =?utf-8?B?MTREU0lHWndSK1FldFBKeFR5RlVFVkliYkxNUnhqK1JndDcrWVQrL2VqUWJD?=
 =?utf-8?B?ejBTRkdHV3N0OHk2K1A5RVpSRHZrTCs3VHdKWlo3Z0RiUGo1TTFFUEM1SE9X?=
 =?utf-8?B?ejFJYS9zelNhS1lFRWdUQnRmejlwdHoxaXVEWXIvdTRBN0xvRFpsSjhLRDVi?=
 =?utf-8?B?Ujl0R1B2QUdFMmxKTE83b1BoRmNxR0hib0g2dTVSRnlkUjhMZ3J2b09OSkli?=
 =?utf-8?Q?Kz5RxVbryVNtDaBh6Im1Twyr3j3aEdy9lofUnsF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1227db84-abb6-4da7-c80d-08d971f88451
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 12:10:43.6715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5oVfv4KKz7Sfl7MsVyluQn1Kj7eJyGUHCjIUpIYyXZBezIo2cWXP/iZ3IgskLgXkzW8iTWz8Tcmd7aQhGvW/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6670
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It's module init function does a xen_pv_domain() check first thing.
Hence there's no point building it in non-PV configurations.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -110,7 +110,7 @@ config PCI_PF_STUB
 
 config XEN_PCIDEV_FRONTEND
 	tristate "Xen PCI Frontend"
-	depends on X86 && XEN
+	depends on XEN_PV
 	select PCI_XEN
 	select XEN_XENBUS_FRONTEND
 	default y

