Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D39738783
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 16:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjFUOrF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 10:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjFUOrD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 10:47:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2129.outbound.protection.outlook.com [40.107.220.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EA71994;
        Wed, 21 Jun 2023 07:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh5s4AIIUAjrvvur7TkuIjxUvTcmLG/YEnruye6vQyUFFGMF889wxNgTLG50cYhosT+XM5f64kZespODpUW/aBS2obfi5gnbec+MFKINDcAiLUZ8rOpNleiFrVAs/tqe/86iAv6as9oUX3RbaEQ+dJqeU4Tq+3cdhahqikrp5+x0tdj/qHjKLKqmq8DuX/qpQFnXaFiHwZJFSl1LE5c4HVh4LIcH+jG63NlKoTzgZ8sSVpB0t62zJ+VfJI0NC/4tsKbzUti94sQ1gMC+AnylaRVw2lU1gS+nUuudaDxzNtBJN1z9znCTc05mcS2/5GIB9rEOI/S1ODeZZzeBdNpnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTx4yr5zOUv6/g95RWxYZKqmlfA6l6ALWBewrqa9VWQ=;
 b=IsvB5Wz8j2uh0wCWzaTjnFKJj+L6ep9pJxY0/H43IYVWozjiJNPoSOmeHOD8fIZD4xAObVFkH033hompebJtjuSH0I5lC8YEhgB9NQ+VVW9o+OCSgY9n2/2v//rM+CYUnyzBafMNjrkqOCVGBVUD5W7FLxci5WHq9PtUlJm0gja5s98FN6k9XMRr097xWiLc7TpQpcOmIJI3Ypv/M6Xb3zjDI6Wbq7jdfz2+KGP/JZazL9q1667eG1GIGyHttrDj5k9BL1Z+B4kGtWq0aj0NcalcwfNVWJnZABJwuntM1BPEs6rcV5Eb/x8CJJDvBR93mfqsE49qEG5RZegVzxvCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTx4yr5zOUv6/g95RWxYZKqmlfA6l6ALWBewrqa9VWQ=;
 b=TgrrhAosGdrdNX6hhaqCwqwlc7aFweT9QRzcPshL/B8KNuOdl025r4mU05GfQz9QwwaYPSBAIyiM0eWaYVQ9uc5tK3ZhC5uqeWdC28TRxIIlG8CKhrLrHJ4HbUR4KRh7tscJR/PpSrXpg0mRxHldMr3yCBVphtr8B5HIrY2KGBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5623.namprd13.prod.outlook.com (2603:10b6:a03:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 14:46:55 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:46:55 +0000
Date:   Wed, 21 Jun 2023 16:46:44 +0200
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
        Michal Kazior <michal.kazior@tieto.com>,
        Janusz Dziedzic <janusz.dziedzic@tieto.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 10/10] wifi: ath10k: Use RMW accessors for changing
 LNKCTL
Message-ID: <ZJMNVJ/87pJ7OrXd@corigine.com>
References: <20230620134624.99688-1-ilpo.jarvinen@linux.intel.com>
 <20230620134624.99688-11-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620134624.99688-11-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: AS4P189CA0042.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: f42bcbc0-cb09-45c2-0fab-08db72665a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88TPZyFlOaOXHzQMXlIL6rXWztiizpQyutDk83w4CWYDPpkBoA6Nr3QGodHoSzx5GcfO+SFipWhWiGo8T5gHaJYE2fOJxotK3loAwuSNeNjSuIclp15V943vQbfRZmbOHD6MeqUtJISHYGJkpMh1i4UqPjtpxvYblfaI1CR5uWnL9wNJn0Zu5mpGJb3WiLV6WtRcN6rlMRoIHDv8k+EVq6Mf8rXvo6i9nzlSxQHoF9pZ6Baxwl5lMk4543sR+oq+gu6Ua2fakCF5BlpT8ZbrIAT4QqIwEiXc59jMyaqGcBfR5oTLADRL2h5natUCcFJ2/o5EWUVkTA2sQz+6KWbNztpRAxabYyZdWMt6Sl1SP5DfjwKdbCsFUO5PHaYRi19UDmTOPD0wAtp0aaIKpnoSSJXeumY3NasruuhXl6b6+gLP5nhD4UEKzbPhM20IOvJzhlyb6YE2MRRtHMEweO63cpTmfPY5/VrOQwjgWc8Mzp+7Jq4yceei1o+fk77ohgBNIT1xPpl9QkmiA0qRlcP13DCTcK5n8byjduVn6/WxX7bya7YX+sgBnic5ebiuDk3qqfFex0Mxj7rw7JfGPI3mEL7NQ+OgMEXk9imUibAcZbg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(136003)(366004)(346002)(376002)(396003)(451199021)(7416002)(8676002)(54906003)(36756003)(2906002)(4744005)(86362001)(66574015)(186003)(6506007)(6512007)(2616005)(478600001)(41300700001)(8936002)(83380400001)(6666004)(6486002)(4326008)(66476007)(66556008)(6916009)(38100700002)(316002)(66946007)(5660300002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1EreGNoV01SVmwycVJkK2s0bmpnTXVabTEzZGRUL2IvaVRMZEVCcVRmY0FQ?=
 =?utf-8?B?K3dwYkZ2TmgzdjhiVmdEbTFIYSt3c2RwVGNDK0NPYnZSdUo4NnlCMXpYWHNp?=
 =?utf-8?B?eWxkVFVnWkpOWkRILzdqLzhQSzd3MkoycHNtTWRJOHpvMzM0VXprbEg2YVlS?=
 =?utf-8?B?c3NvdGI4anNYTTc2cEZPSmlKSmRZaUI1ZXFWWnNsWmkwci9YQnkxNzhRVzBu?=
 =?utf-8?B?VW1lM2xtRDNVbktCcnJOZlA5V1N6Mzk0VWpyTVlPMmEyRGFUZDhZR0kxNVZv?=
 =?utf-8?B?bndWNDFZTEtNYUNlazUza2FLUEd4Q2NxclpCcUliRGR2bFlSSDNsZGZYWDNM?=
 =?utf-8?B?RGtFbnhaN1dBZlhybi9MekhTejNEVkZsYW0xM085MHFOd3hiYUtHenY5dWlF?=
 =?utf-8?B?RitJSGlOZnI5b0xmcXZCUmM5RWRka0kwNVdtRVhROUczK3dBQm9zaktqTkJT?=
 =?utf-8?B?YVNQdDgrQmVPUDgvY09MOHVBdGFiYjFjQWZOSDlaRWZrbjZITUIwT1REWW91?=
 =?utf-8?B?RXdpc0JZTko5ejU1V0JoWlVTdjRmcE5OZkVJenFKOEVmcUVvOGN2aW51SW1B?=
 =?utf-8?B?UnNPeWdhS2tCeTJQQWtMMWR4dFB5OEQvYjJRbVV0M0c4UzYzNjQ0WmtOTDVx?=
 =?utf-8?B?cEtXa2FGdUZ1UXlOT0o0dUg0N2drcXh6Nms3aHVncWt3RW5CcktWUm85Nmdz?=
 =?utf-8?B?NjlJYlpjeUFkbzRxZ0ZzeUFIK2RycnNaODI3bjFCVldSL3VRY1pBblhDUkdl?=
 =?utf-8?B?emxSOEFtZzNnWlIxckdmZHVnV2E5N2w5aUZaRDEzQ2JvRE1wS0YzRmVHZ3pV?=
 =?utf-8?B?SWNHMWpNeWJRQjVyZUE4cVBNbkZQUTBCQUxLbUl0SnFVZzZ1L1RnVDRvUDQ4?=
 =?utf-8?B?WktWSnNmN0NMRTJZa1Z3aFRkdEVHak1xNkoxdmp3cE5BeWJseWhwOWxWT2FI?=
 =?utf-8?B?Rk1JaWhQdGVVcENVclVabm9ualVlOU1LZFdVU0pwNitqL2ltTnA3ejRqOUpV?=
 =?utf-8?B?UjFSSGZmbE9tZXFFRDhGc2l6N1MzcjMzdFZuMytaYjc0RUFKcWZCNlVVUG93?=
 =?utf-8?B?K3FKeE1xQ2NEYm1IWFNPbERxN0NDd3EzSW9sSjdLbDluSmtOQ1YyZDR0RWJw?=
 =?utf-8?B?L0xXQjB1ZTlzQWVLaDNiZk9pb2U1Z3I3ZWUzQ1FIemlYNEZGRDByVDNVWDlr?=
 =?utf-8?B?ZTN4ZU9OTmVybDI3TElRZllON2JiT2owMWtseGpud2tsa0QrektBT2NwdXdB?=
 =?utf-8?B?aEI2OWozVmU4YmpJelExcEY3RXpMUjU3Mm9UVlJmajE5OW1McEIyUGVjdVYz?=
 =?utf-8?B?YzVLRkpoRFB3V3V6WmZ3S1JlL3JuSWFyRW43STV4TlV5VXlpTGE0cHJkT0pK?=
 =?utf-8?B?ZkhLdWkyS3hHNVVYc1BMZVR0eDFhaS9JdXNtZkxmaytyY1M0dDEzT2RUYXhV?=
 =?utf-8?B?SThNdldVUEo0Qk9MNU0xQ0pUdUpqclhBdEkzdmYrWWp0bXluaWlmVkdSbDhV?=
 =?utf-8?B?NDBBL0VOWk1Wd1JrZnhCa0FxVWRpLyt5THIycHJzOXdKeUVCenp3aXR2L3lN?=
 =?utf-8?B?eFpLaFVDVzM2MlJKWjVZbEFYbXdYMVI3VHVxQ3UxQW5DUTFMTWV1L1JvZzhn?=
 =?utf-8?B?OTluanBxSVV1YXMxczAwYzlJWVV4NE5uT3U4SHp0RDhMNEtaeldvQmpuelNx?=
 =?utf-8?B?ZVVWRW9OWnl6bThRRXN6MXQ2Ykp0ZFdmc3d6cnVmUG1FRXU0SzdjS3EwTFU2?=
 =?utf-8?B?ZEc4aC9pUzFSdDUxQ2pCWm9FaGJOb0ZpcFlLaG1kR2dnOGh6RGpBNWlvNXNW?=
 =?utf-8?B?c3JsUi9xeE9ybHpzUVk5QmxHUUpDaU5VY213YkxrdE4vajhIamVUelk1ZEEr?=
 =?utf-8?B?VWZPYzJGRXV3SjRkMHhDSlBSanE5VnJTOTNIelNTbFZMR0MvMU5kOHQ2b3hh?=
 =?utf-8?B?MUliZEFtNktYeWw5emdPMEpIUnNta0N1K1V4dGY1TnYySWZvWU1SOVFiU2pm?=
 =?utf-8?B?NnpFbEQybnJDaFMxRC9EcnYzd0MwcjIvVVlCOU9VbzJ0a2J5MkpYanZGcjRk?=
 =?utf-8?B?eUg2bmxsdmxKcm5DTnh6VFRGaW1GdU1iNmFFVHRDRWdmTC9DQjJnRzJNeVVT?=
 =?utf-8?B?TEtsdHdCRDQ4d0gzTTlkRnFGcDh6alI2MGhkMCtnN3dRdUhBbW4wTFdlMnNX?=
 =?utf-8?B?OW1sZE9pVk5VbzlrS2pEVEFhZHZHbUs2ajBaeUhjMWxBdzNKRDQ3cDdMc0wz?=
 =?utf-8?B?c3B5SkRUNGcwM3RibkZHSU1lMjlBPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42bcbc0-cb09-45c2-0fab-08db72665a3d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 14:46:55.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIaUai/HG2MolK0T+RAaWteoRfWK6iwf36hoyzubwSryxZEc17a5C9mm4/0r5YDHZDU3mlkiWtH1FRUiqIaa4chkq/yU6E2dCgsvU1dA2sI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5623
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 20, 2023 at 04:46:24PM +0300, Ilpo Järvinen wrote:
> Don't assume that only the driver would be accessing LNKCTL. ASPM
> policy changes can trigger write to LNKCTL outside of driver's control.
> 
> Use RMW capability accessors which does proper locking to avoid losing
> concurrent updates to the register value. On restore, clear the ASPMC
> field properly.
> 
> Fixes: 76d870ed09ab ("ath10k: enable ASPM")
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Kalle Valo <kvalo@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/net/wireless/ath/ath10k/pci.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Simon Horman <simon.horman@corigine.com>

