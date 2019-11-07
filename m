Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F805F3069
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 14:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfKGNuk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 7 Nov 2019 08:50:40 -0500
Received: from mail-oln040092255024.outbound.protection.outlook.com ([40.92.255.24]:26028
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726754AbfKGNuk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 08:50:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyW4jD7c4aNhyBGCA/O9xmIUYbXzW79slfSIlIJUKIXVdnvj5fkuJsV2MsTorKxbrbJsTaEkDem+rRT82Bz4IGpwJuYx8jR4b1kSAFxfOClldRuqTKBO/81zLtZvopSsaWaoMhMvWDbh+ijuogkwtDUTTazcsqmvJXUrj3nFdZQu9ZQ/aN9ZbI5zl04+yKKCT1TIe03oLAVdAQ//t0AeFFnxryOQHujl+jEV7xxInwwd6Pl94q2BmrjTxR7ZKzRNFie6VCoNzacfzMVhbVd3YLyZoY96kd3B7w9bsB28Ct/mHIRldNVgvDd1eqSRYzbAj5Q685PETwSINBRuKDuzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lL1zA+7xxsDjv1AoC7YE0ERD3trobstTIUiXUuSMPvY=;
 b=gNZhEnmpHBJiIylDBqRKk4CxNTrS8LNyh0PeCCwJyTjAlHlvcbAAkkRJSis5YNikKxSUnMX1kaqZYHmINZ/ujJSCYtc0+H8siT4AhrmMIiTuzCT2NpfyDa/NLNjJwl5wS0YRJn94SOuxoOvdbcfAzCeJmlQGdpBIsUj7hS732iW78r6fP99xzQ2/HBNRtyqV6Om1QWu3RrgikTb5k2C5NVpUXC83VHW/u5PlHZyL4olQTCR1a654jhtxshqZ5pqGNfSXTlSGZGaoUbZ/vzto65KjdC9u+AHl/S6xsRQFnX9KTz+zQkcm6TPeCrSTX/UzxtXWAvnQUpAxvUhzs2dUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT033.eop-APC01.prod.protection.outlook.com
 (10.152.252.53) by PU1APC01HT128.eop-APC01.prod.protection.outlook.com
 (10.152.253.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20; Thu, 7 Nov
 2019 13:50:35 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT033.mail.protection.outlook.com (10.152.252.223) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Thu, 7 Nov 2019 13:50:35 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 13:50:35 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH 0/1] Fix bug resulting in double hpmemsize being assigned to
 MMIO window
Thread-Topic: [PATCH 0/1] Fix bug resulting in double hpmemsize being assigned
 to MMIO window
Thread-Index: AQHVlXJUhp9PbcoR4kC5jZUBBr2m9A==
Date:   Thu, 7 Nov 2019 13:50:35 +0000
Message-ID: <PS2P216MB075530CB1B7B099AAF9F42D580780@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0005.ausprd01.prod.outlook.com (2603:10c6:10::17)
 To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:4833630A5206E2BAAC844A20D74826C8B87B72E8CBF726BD549D133F4CD81F1B;UpperCasedChecksum:FA45B66410C2BB9C971AAE5F699130F017D86B9B335BFF3ECCF08B5CD4F4FB00;SizeAsReceived:7665;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [sbY4bW8gD5e+lSTvcFKb3azynKVSSTW4AH2T0YYK5b2xG4aQW+WS1YK5zYc5883REpecftTRPBo=]
x-microsoft-original-message-id: <20191107135020.GA2223@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 06c526d2-e7b6-4704-6efd-08d7638976c0
x-ms-exchange-slblob-mailprops: q+fD6XS3/UJ+cHfC79vTglgpmgHPQ8pO7kwHZOy/nL5Q8v/5m2RBRNEo5e0DEaYdXl7DHjrsOykSjswkNYnOLYaPlG6UExHe2D7YOu8hF48y1VPw54zXW6H3q/HnT98o7VwJUV8AUrNnTZPSJ+rPZFbk2MwFjtsmPgZbzQt6ur9H3H9/dt9w2QK+F/FImWMw9vFo7qCxaSE6kOl/3lfmcuvPqyaRkcjk2MC7P8IC3LsyS7B9k8t06nlcUchSLdel5OKg86m7OOYV7VnR10op8l8+g+0UA4rCCZUQMrAgD/djNHbGQ8nmVeaTK7OR51SW0gHsjb516qW3raae1us+jXya0sGTx9M3FQ3MmHST785eU96x8fsCB+ArPRa3+JGJzpr7hVcYsckwcEU6prTndFVwYpfBD8wII8MDn5oeJYh2ntx29dDMMpVcIarUz6r6DQntg1VdI0KC514kktC7ku4oOIzk6nR9uzsAI3L5mUNdUvaKxgT/qjUYpZoAi1NloRY0Q+QIwax42kkGYE2GBxqZmCJj8TXuZdYgzPfux7mGAN+oM9mV+ZCpjlFwMUhabGARcYwqtcT6Z1T8gH/oGu9qRBIvt5vCrZlm3yzfdAKsrOo1aheZ+7OE7QO0GwzBoH3WUkasY+Rx+sakJQwfKPy1tpWtzo1PSM48v5C4rwKHKNZ4CTCGGb7aY4eoH6KxEhDoFvfMS8ZtO7fNofC31A==
x-ms-traffictypediagnostic: PU1APC01HT128:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P7bipwHuplET77EHetdtuQFj+/2uGv4vwSXEQdLajNzjn9jnMf7uPFryZGGoxX2SFB09pbCJ7KZg8O0jhLCZ4clOzOHNyFf8TfKo9xW/WLuW2mMSOHzu/ENyAp+g4Fr2y1nSp59+vaKe1dNYMbN6FxY8SgYJXs6ElnVWCxmYa6htbcXoOyRx1sTJHYIC4yXK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <190531C10E9ACD4091B7CD6D3345C048@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c526d2-e7b6-4704-6efd-08d7638976c0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 13:50:35.3355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT128
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I have split this patch off my main series, as I realised that it does 
not need to be part of that series.

I have made some recent improvements to add assurance against it 
breaking existing behaviour. Instead of returning the first resource of 
the desired type regardless of it being assigned, now it goes through 
all of the resources and returns only those of type that are not 
assigned. Only then does it go through and return the first resource of 
desired type that is assigned. If none are found then it returns NULL as 
usual.

I have made extensive changes to the patch notes, also.

Logan Gunthorpe <logang@deltatee.com> has an alternative method of 
fixing this same bug. Please also consider his patch and accept 
whichever is best for Linux. All I care is that the bug be fixed.

Nicholas Johnson (1):
  PCI: Fix bug resulting in double hpmemsize being assigned to MMIO
    window

 drivers/pci/setup-bus.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

-- 
2.23.0

