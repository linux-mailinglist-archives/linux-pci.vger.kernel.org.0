Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74DCC131513
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 16:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgAFPqp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 6 Jan 2020 10:46:45 -0500
Received: from mail-oln040092253027.outbound.protection.outlook.com ([40.92.253.27]:28620
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbgAFPqp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 10:46:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBbDs4sym7hTrKVfxPK1cPYgFH+gdFB61zTrxA++zbVeZis/fwcloCdqpOl/UKJadfC20e/5UkO7MT6we7OxuYaig7pvN6VbhMsae1SNGSnsiWyOl/2R7XpIMS8o2ZfQS2PKb/eBbQWHF0fXATZaUwY6RxDlxqkfWiMtA3sEzo5UAf9OJSTja8vEe7jzlwt5B48Y9bxFsY8pY7ZmWIPqomVw+HLjlgKKamSUknJ1/SznpRxgDUI7ZY/ZRyebkzAeGwG5N4AoWR488KnhwfL0994NAwGLPuITzDvNut8qtwHCO00r4Ta8gkUQp+JYqaH94zAUoEOd52M6mGHuv/FNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzbb2GQbKI1ad7Gq9JnVJmi+t+mRDucPbw299YxHWVo=;
 b=MROMh0am8TFel+a69nTs5hxFkr1YQtgD/f5Fmn9MT+ImD/gkvrJWKTugerRdGPZkFeWyWQMBdIiHHExw5Tqe4IMTGnKb3+TIC6sHwJF6FIQphA0vSSxQs7aRqP3trWHctu0OBjVXRchcXSRc1J7N6UTK2erv0W2WLLfZrNvkemhKr9puYr7glIEl4p2A68hm6QtEz8wIf832GKIfRpvlMbK6kJndbDNfU1R5Fndo4tllppoxBOrzfY7qkACHSprVYRXpBtWVr5oBmOzpOfCKDx2MVOl0ypoiDXiEJSQvxi7Pk37gcs1JDLAYedQP++FdsLOsiz7hY4cxXCkWq+6bpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.57) by PU1APC01HT212.eop-APC01.prod.protection.outlook.com
 (10.152.252.157) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 15:46:40 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 15:46:40 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2602.016; Mon, 6 Jan 2020
 15:46:40 +0000
Received: from nicholas-dell-linux (49.196.2.242) by MEXPR01CA0129.ausprd01.prod.outlook.com (2603:10c6:200:2e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10 via Frontend Transport; Mon, 6 Jan 2020 15:46:37 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 0/4] PCI: Allow Thunderbolt to work with resources from
 pci=hpmemsize
Thread-Topic: [PATCH v1 0/4] PCI: Allow Thunderbolt to work with resources
 from pci=hpmemsize
Thread-Index: AQHVxKh8eb0M17AhuUSbrr8EOc1Lyg==
Date:   Mon, 6 Jan 2020 15:46:39 +0000
Message-ID: <PSXP216MB043852808CC6A3B169D4955F803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEXPR01CA0129.ausprd01.prod.outlook.com
 (2603:10c6:200:2e::14) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:F0C713D29773DD0B77C930B65429B24A489C1AD148CF2C312D8192530115E6DA;UpperCasedChecksum:22D2957B0E87A0AEB71CA7610F4A0D969FFA36EE7B622D39CBD67CA36FE89AB9;SizeAsReceived:7787;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [FYIEcB42bem9xgPMn+Szz7P0sFgz+zjf]
x-microsoft-original-message-id: <20200106154631.GA2548@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 6d4abf73-6f3f-4c94-7381-08d792bf9e9d
x-ms-exchange-slblob-mailprops: =?us-ascii?Q?kNrQfc5EacYVTVQnmnYyZSuADa1TavtXMw8OW5X+vz6FAdJTr0UX1VJz1iFX?=
 =?us-ascii?Q?HbgoHLlMWYuhS+E3lrfxmduPWqVAqHTm7DKsr0J8puV02sICvkx1MNVzA2aA?=
 =?us-ascii?Q?W4NMtGbCL2dD1Hy/26koPDAfjt/F7B8fxX+4JYi8gxhcSrYyzpxxYNe3RrTB?=
 =?us-ascii?Q?gu24fUzyvtHveq8TzNvNSkkz2hjkRYzvqQR/6zp1BumBI6TIKNe/IiItcIpg?=
 =?us-ascii?Q?XpoHJxUt8YZ2uUI3op8xifUDGc0veO0bTJ4C+PJNgZ2rCggb8E6O3xe/Vl3z?=
 =?us-ascii?Q?1hHPiBo5aTaboKX5XbMUCNNzOu+86rN0vWX0E6Ozb7lp2SpxZqj2Bh6MlvfM?=
 =?us-ascii?Q?ttPX0Wqr+OVT1C9gjvpgmjE1Nt+qNR7ZeGTXZtiAejBBbyif+XUNbazL8U/X?=
 =?us-ascii?Q?fsRX/VHLjuijEkNf/bEldhg8afkVVesQ2Gg3fAkgSvMhth2ZXGikYx6JYNEx?=
 =?us-ascii?Q?0k8UF0/G1lNPeBa21cnpRAzLdXVTq8mKjIB/xv1GiSu+VsFzgy/6VkrZFV4S?=
 =?us-ascii?Q?rcAIUirm8+AUSuGyY7H0s/02wCZl/4IoT/0zYwL+r0JMu6UqXAMGudCAUGuR?=
 =?us-ascii?Q?T4MxBp33cK+VdlQqgjiON0qpToEvNCOjsi27JIPzmEIx57fQyHs9N5lLlL7H?=
 =?us-ascii?Q?pjEnGs4imfJv0Oys/OnrvIRhulP6Xa4E2tqeI9Pz/i7f1wzUKIN6gdE7AgUa?=
 =?us-ascii?Q?AyfqnlrTOkvebndjsVKF8429v6n+QJ2pF4ONDjcMcIy5spwMgCfK5cG0tSzz?=
 =?us-ascii?Q?lkcMm+0jrP/f9MhvnXSD7Zdq4J3qKYAPariK6qwDdVqs+BpTbwW7LPuPUnup?=
 =?us-ascii?Q?MnyG8cRAaSDk36vnvocnDYqn0A/SGW+hAWMOdwdafxn93WSLKN3IOLwSDyUu?=
 =?us-ascii?Q?H4qUKpaH4oSqTQ0XxtvwV0vtYbuFV5MD/PKt8C0AdOBCJWMwm2/Uo8LrZ5Tp?=
 =?us-ascii?Q?lMLb890PBh5BxA3rqieY9tWku4BjZeGbVBudDjbjjXU=3D?=
x-ms-traffictypediagnostic: PU1APC01HT212:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fBWcmCbRLZTweVgu4Rq3cbuwGO1BcHyeHPJoCyqIexWT7dd9WQmaWQWY0/7Gj/qzGHY83pdEiHQFIaG0HewEa2gY5bIUZxlPKsAY/Cc301MI2S/Y9lbn5E0uFlMkMbKpsBVvwh7BALD37aQSeN7vQIIPb6Lm5bg5+Rl0zV3nqSvicMsPA+n3wEDoDtk3xDjq
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <478ECE469948DD4F840D9E76B4A42D53@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4abf73-6f3f-4c94-7381-08d792bf9e9d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:46:39.8969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT212
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series is split from from [0] to make sign-off easier.

There are not a lot of changes here, but I still removed Reviewed-by 
tags from Mika Westerberg so he can re-review and give the all clear.

Apply this series after series "PCI: Fix failure to assign BARs with 
alignment >1M with Thunderbolt"

[0]
https://lore.kernel.org/lkml/PSXP216MB043892C04178AB333F7AF08C80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM/

Nicholas Johnson (4):
  PCI: In extend_bridge_window() change available to new_size
  PCI: Rename extend_bridge_window() to adjust_bridge_window()
  PCI: Change extend_bridge_window() to set resource size directly
  PCI: Allow extend_bridge_window() to shrink resource if necessary

 drivers/pci/setup-bus.c | 46 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

-- 
2.24.1

