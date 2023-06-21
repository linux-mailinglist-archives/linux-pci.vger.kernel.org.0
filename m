Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C107387A5
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 16:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjFUOsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjFUOr6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 10:47:58 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2115.outbound.protection.outlook.com [40.107.212.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CFC19A9;
        Wed, 21 Jun 2023 07:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqMwgfVecBxa4iSz751oOEqyDE2ktDPaLb7JyReVYkZy2zR41wgpptc6Oq72nowObyhEG8iAEU29biYho2Ckpe8xY+BfsJbPNjdw5Hfmb7WgxldM1PzeqGQp4nuWIBqAVJmVt0oBzNoo1fYHVnCCMNC3XlFnZbE2hMJKMtzfLcPax+rQgZONE7riQZzl6f6flf2UKQyqZMqfwNViyPAWycIJMF9seWzv1tfw0VrlNIrMEw3vAIadOS3ApsnybeTcq4oI57I8z/PjEkJx/vVFFFdxn+fikWBNkgafpRyBlFQ8fI6IwY/gu7fRMui+RJh/L4jDXrSpKIoFUHPWlu1Byw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYRsYvQQAcwl8l4e2oqtGhwwKM50VJTc4FdQiWhzSJM=;
 b=l1Q31W0p2QnyPoZjo9cB+KFGlGKXIF4OiDnJnnGyEIylcpDL2wYcrZZXCzJrnWMQoU5DSnMLPR8b4894sboTQHEfXgDAGjh8G2VEkYRjbKtmokIsfpaqCon6ay7U6fTr1jTsF/XDf+wXhwroRVlQYMIdWSFlBY12ho+x3Fcx2uYgZqracWB7wO+RpiAXMKBrQ827cavI03AsyDZdmESoOcFuJRifGxqCWNb9/rcTiLS6sOd+dGM2M7uDVhn8DEGNxxRqZqI7HBn7vB/xCWwe+0XpgNoZzcOWmmihamXRwCLKdMspYphZ6ziAsAxTNVZ1m3oHBXh9xp4Ov2NOxvY0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYRsYvQQAcwl8l4e2oqtGhwwKM50VJTc4FdQiWhzSJM=;
 b=anhVUnG1Sew8WSkGDdNlLXrdTO/yX8mU3esTgi89htLdvWEesaW6n35fZ5YAeJCmL/B3zWkqsci8GIbWAxuogEEUIlJm/OrIYcIwlBJFDzAemUKo/piMtLLwwjPqi8JfyDgaNbWa67TBtRIv2AGUclkotzZVutHicr6Q+m9EPXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB4475.namprd13.prod.outlook.com (2603:10b6:610:62::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 14:47:45 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:47:45 +0000
Date:   Wed, 21 Jun 2023 16:47:36 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 09/10] wifi: ath12k: Use RMW accessors for changing
 LNKCTL
Message-ID: <ZJMNiEw0IekR684V@corigine.com>
References: <20230620134624.99688-1-ilpo.jarvinen@linux.intel.com>
 <20230620134624.99688-10-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620134624.99688-10-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: AM0PR02CA0007.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3833a3-cc70-45c9-bf1f-08db72667975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yi+yv7jcOl8V2Z5m4yhgZNNaj3gn2zJ72wLHXYUuZMvKvz+1gXMknJIjV7GapdFUBQWFhl3ckLHDi4uKMglEJvl33pxosGovhNjvoSo8D79wVLsl6CUtGdjY+w78vck0NuHlMzoJpyjhilDADJwY21zdWUh/B0dorgnt+XB8VWONkaK21YlgUjEualEmYxqyokYeN8od7F3OneDujZdr9DA3UAs32toN+B1u4fV5hn9QMiFW2+wtGzMg3V/1wu/ddpJaA193F3qltn4YZXE5J6mahKBlfEIyDrw77PFaJli5LeFKQ4X1uT1qZeX2JW8heWBeHn8z8ThyrKULRf/R4q56AwmdFn7UQe39s/gN/+ltoTO0clZlalvxY9vp+0PwMKLettTyaRKOAe6K2X7TL8+3rKseNI1yrwqjm83Cby1TbqDTGZW5VPKHlMRQXwrER28KvYLA4Nb0nS66Pa5nfWd2omO0is15qiHS2oyLnwbEvPviF+EVw2HHHhckgUXTkvtwy8Dpj9Gd9G9fHVsbRhgLj76A3FBELZlAmixe/B+M2VWNEWzzHNf69wg9eySjHXPJBtLxU/9FyhI9KlSwMDb+TMRTM8EhNzFJEkeBJeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(39830400003)(376002)(451199021)(478600001)(6666004)(4326008)(54906003)(6506007)(186003)(6486002)(6512007)(4744005)(2906002)(8676002)(8936002)(41300700001)(316002)(66946007)(6916009)(66556008)(66476007)(7416002)(5660300002)(44832011)(38100700002)(86362001)(36756003)(66574015)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUE5cmZ1cHg0WDV3M2ZGWFl0M2pEdjZWZmhpTjVHT3hNV0hSMVl1ZFRLUlBr?=
 =?utf-8?B?bEZQeDJ3dml6YkRURy9HbFpKSGt4Z3NCdHRBWXFaeW5oQ042NzVjQmtkZWhY?=
 =?utf-8?B?bHlpd1VNU0NNTURHTXZLcnJYUElEaHpTdnp0T2dHWGRQa0YvayswVStGQjIx?=
 =?utf-8?B?RHRka0NFVmsxWnU0OWw2aXMrTlFLeFB5dUNlaG9xNVlZWnB4blR3Z2NWUTdP?=
 =?utf-8?B?ZnhKbzdSV3RCc21NdU9ORVp2aUpWblY0aFRybkR3b1VWZUxjSTJzcVVUVlkr?=
 =?utf-8?B?eTVxK2Y0K1V6OEhpUUFPblBVQ09NUzVyc0FtMlBCTEZ4TFVGSHVua240ZjFU?=
 =?utf-8?B?WnM2SWxhaWcwZXZST0poSjNYaloreEY3MVpXcHJRYlVHYnZVSDB0dms0d2VC?=
 =?utf-8?B?M0p6ZTBaUUJMeXc1SVBFSlc3SVYvUzMzM012MzUya1k3NDFTVktGR3ViMDhi?=
 =?utf-8?B?L21VZngzTDY2L3VlK29sZUU3dGh1eVlseEphNDhlK2RsY0FQVng3ZExVWlgz?=
 =?utf-8?B?TmhRZzE3ZTdyZFY5MHBRcmlVSm9jeUh0TU5xSTgyTFR6d3Fsa0tleFpERm9M?=
 =?utf-8?B?Z1BxV0pmWk1hWk1tRXBrcVo2cHN1d2MzT01CeTE4SEZFbDRPT0kvTkdhNUtX?=
 =?utf-8?B?dHJVQktyblJpRmYwL2RYbkN4VVorRy82cWlXVkNXOFJIbDNvbGZQcHpDTjZ3?=
 =?utf-8?B?Y09Lam5WL3RDR1JXRnd1blVzRzJYTFcxQnU5cWhqZzJZdVFCVmVtNHBkazBv?=
 =?utf-8?B?aXdrUVZIZ1N6UzZIRXRhUVNMY2J3MHdHVDFybHlyYmUxV09EalJ6S3hsWjRu?=
 =?utf-8?B?VGJZV1pFL2ZnZFlPMWVVY0x0MzRZT3p5M1M2aTlJa0x1bWM1RGdZYWFEUGhL?=
 =?utf-8?B?ZzVray8ycEcybitXajZCWVZCODBKT0doTUVWK2FUMXEzbzZYM3hlK1pxUGdJ?=
 =?utf-8?B?NHlXMGxqN3VLNXpVVCs3a0hxaFFXaVBuOS9pbXhLdnp3WmFETjRXVTU3eks5?=
 =?utf-8?B?eGRVbVVlVnRKL0dFb1NDTTJXd2tyb3Mrenptck4rWDMvanN2bjc4c1VxZkIz?=
 =?utf-8?B?azUzRlgrRFJvYThjazhHZGt4UHg2SzFnR2hVTytXZTBjVmFOQk9tS0x2QnBw?=
 =?utf-8?B?WUEySkt0bVNTa0xmRFcwaDc2d09xa0JwbDZ0d0c4Nk03Tkpuam4rKzdrTmVY?=
 =?utf-8?B?RFdWUXlPamgrME9LOU1iaUxYbEpLY052MUt6eFBtck9UYW82aktJQk1NL01P?=
 =?utf-8?B?UnhTUGdJQnpFTnZIUUZ5NnVpejZ3YTVDWG9GVkVscW96MDcwTmoyQnNad1RD?=
 =?utf-8?B?MW1HNUhZZlZZLzdUTkNlcDV3RFFtQ0ltaFBFWFFCQnE5SGtZa0hLS2xtS0V4?=
 =?utf-8?B?T0xCNHQ2N29zSS8xQzVFa3YzTVpCRUt4US9oblJvb1hValZLeWNZdHpwWGUy?=
 =?utf-8?B?NUlJM0hzNDRwUHdHa2lKYk1UMTQyNENPZFFabGcvQkhyb1JHOU1iVmVuZ2V1?=
 =?utf-8?B?NGJSVDcxQWEvbW93SE16WjZObkh4OE5qNGhySmxLS3hwbEJjMDd3YWYzT3FZ?=
 =?utf-8?B?OG5kTFNPL2greTlzSXB4T3VnM2tqZTV4TGZ4WlJRem9KQXBHblpvT0w2N0tL?=
 =?utf-8?B?cDYyb3M4MmRCWXU4bnJWKzEweXBKV3gxMjNvTUNDcFQweUNsTXNuUFVvS3M4?=
 =?utf-8?B?a3VlMC9IVVdIbkdGZW9HTlEvVWNuVlFIbzBnODc5L25FS3FsZ2lYSk14SFY3?=
 =?utf-8?B?V21ncmNJajM1V3REdmRZK2N2bTYySTRGWWpDMDVNVUxoMmVTdEVZclc5WmdO?=
 =?utf-8?B?NlRmbUdobW44QTZ3ZXZYM054Vjd6SXovUmszTmtna0VqVU02RW9jUGtvL2Jx?=
 =?utf-8?B?bTVCWWl2VTYrdFZWZWp6Nzlnb2dWbG41TmNuaEJ0eXZVOEN3eUxuZzJIUFZB?=
 =?utf-8?B?a2hzbFM2aUhKUHdlMk83aDdJeGRXWE1EMmNtUUVhckhEK1A5b0I5V3plL0FT?=
 =?utf-8?B?ajdlVVVtWk9sRXVpMjIrZlUyYW02Z1grbktnMlhoU2pXci9qT1BXSEI0R3hI?=
 =?utf-8?B?MVczc2NNdnBMcENjcUhMaDJlTXNVTER1RElwMjBwS3hsT3J4Y01VOVZaOE5u?=
 =?utf-8?B?SUhpeFBvM2VTUjlaRUYrTFpkZWtJdGFNRFlaNnlLTDY2dmdRdlVrcGY1a083?=
 =?utf-8?B?bUNJVXBEOEJ4QzNqc21LOHMzbE5CQVY3aEh6Z21vZEJzZWwweUFTKzdSOWlr?=
 =?utf-8?B?N2lQUk82TWZiUUZKT2pvbGRlemtRPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3833a3-cc70-45c9-bf1f-08db72667975
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 14:47:45.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygmJJTUIp+0lfjP5wL0hi34n76LF3I5kpajTNWeddd4i6pvQKuzuJOCkkXOcn02IFdAqAJJcn9hsYB8Wh1m58Q2Dv6RvwwtD5K+HlQuGS+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4475
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 20, 2023 at 04:46:23PM +0300, Ilpo Järvinen wrote:
> Don't assume that only the driver would be accessing LNKCTL. ASPM
> policy changes can trigger write to LNKCTL outside of driver's control.
> 
> Use RMW capability accessors which do proper locking to avoid losing
> concurrent updates to the register value. On restore, clear the ASPMC
> field properly.
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Kalle Valo <kvalo@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/net/wireless/ath/ath12k/pci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Simon Horman <simon.horman@corigine.com>

