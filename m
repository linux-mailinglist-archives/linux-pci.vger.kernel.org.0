Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60880306DCB
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 07:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhA1GpP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 01:45:15 -0500
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:9313
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231211AbhA1GpO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 01:45:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvc1sK3n6pO/s+VwxPjIHk3+Gc2G1vFZtJhA7m/3tiDfy7G4NaSgTRHQJSUEXl/FRTHA4JReyG3JOuva2mZSrCcQFsiIe/1F4RWQT0MAZEIVlLFqCZo2y23WfEjLePwB4dgL4EIiB+TwLdoGHbIsnMuHcIkAWUSpMa+vSNrPuAlqI8ROruwrq5FJp06xOGK2WS8SZxa1+a5tT+Q/uJTzoRdolsewYw9HNz7NgKwpIcNKEz0hKDk01YCCo9Wm4/pfUcIAVf6nk6c4y0ETBs0yZqaiW9L+L/nwIQENnBkcAQOtbyUQ6x4AWEt4DhrC8OMGai9wEwIGRiu0+bkc6oShPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGVj0uvuru8og+89fOk9Wmhf1/IG1d+RJpMwSe1hs9k=;
 b=hkcGH5H3fbn0h2Hl3saSjEFbNPILlkEt42y0TinxSy8BkghMLHt33lJex7sYHUj38TBOllhTBJFxRo+ihZQNjn39Q0lLWL8o2rWGTnoN2StOMi7XXjKZN6v8XDRKzrSNBKu1mh8jATfvkPqn3OVU7CV0ydV0O10Q60e1+pdav7qN05TWSY9MyoENEjENap2QI57t2o1m2h+hy+UuifTTwhJ1ys00PMSpSOD3UZBBl63ex4wKCWasmLouj9Vjin+Ds6OBtxrtIbJXGsDI+HWUBwNSe26+5YtMfaL0OTyDDHJ3QaULf8hA/UWLGH5+9SO2QXWnFwIH10VPgbmCbJHYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGVj0uvuru8og+89fOk9Wmhf1/IG1d+RJpMwSe1hs9k=;
 b=jhU1neCzPCVnAY5D+MwTdK9pjRrpyRPdEOcgM12MJdfRbYv5Ax8pKkGcakPnoTC9vTCWEXSjZlpP8HWK8iGW4RZjwqFsDijF44UqrpZWfS/+/wrr7Lz49HBnPkWLKaiAFe+TQyZB35jQwiPUV5mE0IlQCxPito+56isdY72HinQ=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN8PR03MB4724.namprd03.prod.outlook.com (2603:10b6:408:96::21)
 by BN6PR03MB2563.namprd03.prod.outlook.com (2603:10b6:404:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 28 Jan
 2021 06:43:54 +0000
Received: from BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::f80a:407e:46ca:e6ce]) by BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::f80a:407e:46ca:e6ce%5]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 06:43:54 +0000
Date:   Thu, 28 Jan 2021 14:42:13 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jonathan Chocron <jonnyc@amazon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] PCI: dwc: remove useless dw_pcie_ops
Message-ID: <20210128144208.343052f7@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:a03:100::46) To BN8PR03MB4724.namprd03.prod.outlook.com
 (2603:10b6:408:96::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR08CA0033.namprd08.prod.outlook.com (2603:10b6:a03:100::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 06:43:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f54434c-3141-48b6-e56c-08d8c358149b
X-MS-TrafficTypeDiagnostic: BN6PR03MB2563:
X-Microsoft-Antispam-PRVS: <BN6PR03MB25635999C0D0704A6634C525EDBA9@BN6PR03MB2563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiXLqpSGXBU6HDSfZpBGqNYxs3nOBJUlnTKFedbjtA6VMCfSVdLZv0NuPxNzFkgnHh3USxTXcJ4pIzRd9V98ZYr6eQsTaSH0/L7uGOxlo4AlTFzHmYWzOYBpvK0qCQjJT93MBLcYJp8bqImQRHunkl4gh+Lll37dDZ6JLGWGj05/17N8IzVjUjc6AnmKOIDO6A1dj4wcKbDuEYs9gpu8JWJNIjbf7eDQVzMR1jmL1rNtxu4WSfP2ZVcQYlP+vMmBYMZ7RzInpYjIK1u5tsSE5PDvDK9P0ze+T+viUA3AOY5MfM8p9Fifq3SL9N7PeqdUS6A1TOvUQqN1u7ggFHMTs8qotnIffay8FNe0QF398+ncvPVS2OEbz0E1obf2gLiWhVdNiidtw5qBYqIrZ4AF3upCLlsJY0Suko77o267aKEKV20XAfNWE98Jc12tqJqG4PF4OKUgPEIcahwkGZC7ptBqlfuiRUkX4yoKYdRoc9sMZx6bPth+Kto2PMRXeU8cMnovx7KEvKP8Zu3NzbcpEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB4724.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(396003)(39860400002)(8936002)(956004)(110136005)(83380400001)(66946007)(4326008)(9686003)(66556008)(55016002)(7696005)(66476007)(5660300002)(316002)(8676002)(16526019)(1076003)(6506007)(86362001)(2906002)(478600001)(4744005)(26005)(52116002)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XyFjx6RyWlCiZKIocx1RqHKsB1Bhc2BuKUaUmw+WcFjA1HCjPG4PhH7mLJhe?=
 =?us-ascii?Q?06guf14qQHJlHez0B/21TVOUkmgDqHoi/GIZFQTQBgDtARtmaFL+u6WFYEIg?=
 =?us-ascii?Q?rQhG9TXRoL0s6aIElEioKLvhL3ZmKvY+xd+ApuiK3Af68K89KUI79+66ZqXM?=
 =?us-ascii?Q?9PMeN/bFgJEeK+bXr26QeiATYWFyThLg/DfOO7LjhXXsqc82I2pN/Szg24kM?=
 =?us-ascii?Q?UWMPF1BUSvCIcwW/Ru4M//CYNIbCLEABOM6Cv1zngen6GRX99MjWdOl+Of/b?=
 =?us-ascii?Q?iL5oauCJcksfA2dYC33dhZJMxYCJHWGrdWytwsO6Ft1OE2lrFgxN+kIEBD3O?=
 =?us-ascii?Q?v6cpuPVK0mPqUob0qAHBF8oVxmlwbVrGWAleGZEzQuwVXyKDVh1fRp6BReQf?=
 =?us-ascii?Q?hFsv3T6D+Xtsz9lUyuPsmXlGS+7k9yrt38qbPsAgnkJxXDgT89D8dQnw3fuO?=
 =?us-ascii?Q?4OEO7+l6mbOrdmmOwhvZJB82k13378bg0Fi6LmsNMxg+/2EcJZgEdMWGBqq/?=
 =?us-ascii?Q?XkIZ/f8g6kPXMB6Ts5ZeZ4rh4ya8eVrVmXYI1is0ITCqXWZLRlBV7ouXOTQ9?=
 =?us-ascii?Q?I9cyorE4srYOUC/TwU33yVQxXL30WPs1+KqHP4Bzi31xTKgtJU7+0siDp1TU?=
 =?us-ascii?Q?nLgSK8z9pL0uU8joPB4/9sVZ427KWHbmkn3TOfniaA1Zxtu9NoAdbVtqIiYP?=
 =?us-ascii?Q?YNdmTyMon6t+4i7mgg+EYLM6DGJej5+zzWpVAOGuSho06C1b12zzbw1Jf0O7?=
 =?us-ascii?Q?NGO9edwDNakJ5KhO8oQfIIxbNMCroA83HlaPZtB6rQieu9mUhSdEDFzyLNJT?=
 =?us-ascii?Q?AmCS8Z5DRSJRVKz3jqOWDqyY+/BU9PuRT74T759Oo7Eh5mpoDK9hx6G0UJUy?=
 =?us-ascii?Q?m50Iyb2OjsNChAjr+9+QE+BSKBmd0l39CFe12eiXTaMSSv6TjtbS/0GOPr8d?=
 =?us-ascii?Q?dpP7tZQ//cjqLiw0lbu12Stz7cZ9srPv54fQ8HzOxgnai92xi4Cpv95pePh+?=
 =?us-ascii?Q?TuISRgMPYBK3+JRk7/5YckJ2I66/dDNUPtxQ282+01LgyHGuILK32sUpmcDD?=
 =?us-ascii?Q?MGEwVb4i?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f54434c-3141-48b6-e56c-08d8c358149b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB4724.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 06:43:54.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IzFzrBg8lAELJXTATAAIDqL1G92271O+qy90nK7Y9G5XDBxIX8F4IclzDdtA36qkIWeKIEaU20xVbB1bCv23Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2563
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some designware based device driver especially host only driver may
work well with the default read_dbi/write_dbi/link_up implementation
in pcie-designware.c, thus remove the assumption to simplify those
drivers.

Since v2:
  - rebase to the latest pci/dwc
  - add Acked-by tag

Since v1:
  - rebase to the latest dwc-next


Jisheng Zhang (2):
  PCI: dwc: Don't assume the ops in dw_pcie always exists
  PCI: dwc: al: Remove useless dw_pcie_ops

 drivers/pci/controller/dwc/pcie-al.c              |  4 ----
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  8 +++-----
 drivers/pci/controller/dwc/pcie-designware-host.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c      | 14 +++++++-------
 4 files changed, 11 insertions(+), 17 deletions(-)

-- 
2.30.0

