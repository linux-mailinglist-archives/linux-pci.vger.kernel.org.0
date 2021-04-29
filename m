Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BBB36EDF5
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 18:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhD2QQg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 12:16:36 -0400
Received: from mail-mw2nam08on2056.outbound.protection.outlook.com ([40.107.101.56]:56013
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232004AbhD2QQg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 12:16:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nju8fZPsKpw5DFlY4K/A6dSwX/8ijBOQknkqJXWOmAsjLkGTKeaLVUhxAMVcbYtT/LontfjdncWYLDY9IUzqu7L8rTxVdipr3tG5BCGGutdcimL1mH7wpe8V5sHMUYto/bKya+j6JgtVov/WfOOzEQ53zloZS0GmbxUR41LDNOfThJnZvyeALxdKpqONqXL2BCkqy2unuynSfpw8gS0zlAYmLwrMYoNcivIchb3J7RsgQ13vu5QF7lwFesmlUBMq/FrT2GenWVIiNYqVZUV8T/pRRzW/CMMQze9LwdKkDNXFj4tqUsBsUPHsqBWMROB3m8AVMDH4Y+ggAE9aDvrLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekD00frLiNEsBHfgfXMf00XHnIDA4CM7nbJ/7bd62KE=;
 b=hy5d8UOho3bdvPZtZQVuNQSCoUaqC+J9FOzh9bSd6ifE/BBL6hz6PB860D+NtUdocbaWI9bWupTBVvP6NGkJdKI90EVoxrmR6L/CWv72zliKLERkP4D66Db+2oPWxjrGWDDV8mdvPZbL8XoIOZ6SygFkSDpjhQcgejOMOv3E4ZMmU7K1K/fHN87FxRnJ9uXyR559rZEq8sds0npm12Z2oEkiL0CVRJwKvAGyLrzInHHhtq87CKvS1kpBGkMlFgMdytONddN3xMpARDhApGI/UWxr8NDcJ+XZ+J5/OdgrW9I+X6XRuyag956YV8xH64lLaTmGFRWxFi9PtlLP3SUNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekD00frLiNEsBHfgfXMf00XHnIDA4CM7nbJ/7bd62KE=;
 b=gmxSjH9CgNy1+kEwEoA4gnFGYRbGXugyuT0TlKh13LwxqalaENQDGvru3bzNmroIzIg25LGg5l7POm4JvdGxFi2cmXEuqAWmx35Sscm52qu09pvQi33nkF94AbKPB/3EasnPc7m1F3WLlqRYUFM1byQWMXB5HR/Vg+QnuNGRm58=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 29 Apr
 2021 16:15:47 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 16:15:47 +0000
Subject: Re: [PATCH v5 20/27] drm: Scope all DRM IOCTLs with
 drm_dev_enter/exit
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
        daniel.vetter@ffwll.ch, Harry.Wentland@amd.com,
        ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-21-andrey.grodzovsky@amd.com>
 <YIqXJ5LA6wKl/yzZ@phenom.ffwll.local> <YIqZZW9iFyGCyOmU@phenom.ffwll.local>
 <95935e46-408b-4fee-a7b4-691e9db4f455@amd.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e760ada9-b4a7-c6ab-18f7-0bcc1b5442c2@amd.com>
Date:   Thu, 29 Apr 2021 12:15:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <95935e46-408b-4fee-a7b4-691e9db4f455@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::26) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24 via Frontend Transport; Thu, 29 Apr 2021 16:15:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 860978d1-bce4-4a80-04dd-08d90b2a0c27
X-MS-TrafficTypeDiagnostic: BL0PR12MB4899:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4899B5ADA170735FC5916BB2925F9@BL0PR12MB4899.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xX8yUSTTQZV0HWTEaDHjSDLc2RbBImuqiD7doUf76M1crD0G56HT6XMEOY5cvZ/Mx/W9ufu9xeRHklGGin0DTOMXH6eIkvF4BBFNalvXx/aKSAV7MtfbISMyzs1izd+aenrJKnatV9ocM5C/OWtDyXU2kOTm1slxuy/MD/gv1KDhSKsg2ziyWCTSG6pw2Ru9VXAr7Hcz8A5GWKmC8bBWiemF1vvajb4Od29vPj20mvstNY1LFDK9GfvZcvkPTyZv7CH4Qq49L6ldHYrsnupMvW79PTlfr2ab2CZ2pWpbQeGvDXQ752nmUZka69uLf213yWS5vfhj2hTBtgnwnDedkFgqWhuuxtRlA3zN02Kq/mHbx30hzhZdIMUoBb2TbQCyPB7Lt5UL1PSw1nZTXGK7CAFzaBagSQUoIOShrgYq+e8oNpUPx4fmp3h/r+fSddf6ob9i4kBz4OkdI/O2RohmQPG1FyWXKFAuJSO0hTecdVt/a7blvBz24pnRqejZenhqbzSbqiJCumYA15yx4CloAb3Sh2OYY+59mNFwEtZI0e7ckgNRel6wE06lU+iMXrHxahkqTTGN23ysWn3J+X7XKOM4qvTfOnMwduzNoicXM+GDjd2TwUEKhE2U8YNKPot4LNvyPA4rCK369iakv0OvnxZvjYkuBD2zC9j2eNaY4sV/RS0fO3HXLjSBHADTrPKF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(66556008)(956004)(26005)(31696002)(66946007)(2616005)(86362001)(16526019)(186003)(6486002)(5660300002)(316002)(66476007)(83380400001)(31686004)(36756003)(4326008)(478600001)(2906002)(44832011)(8936002)(16576012)(110136005)(8676002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N3d3bGwvNjQ2SXl3Rnp4N0ZJYWFJOTNNM0luWXI1ZGszZkFKeUxSbXdDbEhK?=
 =?utf-8?B?L2JWelY2dllsVTRVTTRuazdtQ0lUWGs1ZXltUm9TSGM4UEM2NE1WZjI4d25z?=
 =?utf-8?B?cnpYSUtBdVUyVEtyY3RwbFVTNnRhTCtBWGZuNGlJd1YzZ3JYWUwwbXpZekpa?=
 =?utf-8?B?a3Y3Nk1QcGgvT3NTS0Z5WmJqczJKMUlnS1hRM2ZMOHpONWhvd0RRYVJJZDV4?=
 =?utf-8?B?RWpPZ2NHWEJ6VTJQK1dwSmJsREYwelVGTzVYSFc1UEFDK2xld01XZzQ0TjdD?=
 =?utf-8?B?QjY2dHdmVnhHUmVXK21xZXJMTkE0djZxN2JsV1c5aXZDelNJWjdIZXdxZ01G?=
 =?utf-8?B?eHZwUTBQQm1hc0w5dTUvZ29ONmVTdlVwZXFIUjZDUm0vQllCUzByVXl1ZVlw?=
 =?utf-8?B?Z3A3SGI4WFZMd0FGZUZva1F4eXNrdEl6VFY5UGIwL2dnS3h3bUVlUlJTK29L?=
 =?utf-8?B?aXFlaXN2TjdMTFB3NW9YYVNuUzBmTjNmRzZvNTIydWkxR2g0MUJraGlrV2to?=
 =?utf-8?B?RFhFbUwxcm9ISVVwNEFVNGZpR1FuWG9YK3BlQ0ZjSTVzdEh3MnVjbUlBQmpW?=
 =?utf-8?B?ZGpNZnFaU0ZzRUROUU4razFDbCtndlBBOUJZVWUzUC9GRy9BT29FRjlDajVD?=
 =?utf-8?B?R00wNU5GWDVTSkZkaVZNVVVyUXVKT0VzNGtsWjlaNnZtWGZlU25mMlNOY21F?=
 =?utf-8?B?bVF3ZUtISGY3aDRkVTdDUUJEUmFTWCtEWVNXRVZ2RGZmcHRKdjBOdFl4aXZn?=
 =?utf-8?B?WVZLZUFaUnVaTHlRZE8ydE1zZW54VUV5cDI1Yyt3b0tnMHQya2JiMW91eEJp?=
 =?utf-8?B?OFZVNWhXOE9SandxY29jbjdHSTJrRWcyMmZtME5Bam5mNi9WWERmMWRxV1c4?=
 =?utf-8?B?TWRXT2VhQUE2bXFKajcyK3VobjM2c3ZaR3AwMkhwcjlXZGVNb2tEam1PZFh4?=
 =?utf-8?B?MzVacWtkdW1uQmNOclJwS1k0YU5BOW8rTVVMbVZaS250em1hZ3ZrY2NFbUNp?=
 =?utf-8?B?bjBYQ2FvR1dxcFphVXpsSzVCRTB5dWpndVB1dCtwNWRQMUJFdnNFZ2N5alVL?=
 =?utf-8?B?dmtZOFduS2hSUTNHeFRLQVF6Njk2N0dGNFJsK2M4WEZnOFlzZEg0c0N3eHZF?=
 =?utf-8?B?azUwTGJkRDN5anJEdUpMdVU2SWtobWZQRzE5VlZPcWw2ODdYTE1lOWh3Yy9k?=
 =?utf-8?B?VkZCZkRyaVVpc2cyTWZTTjNYa1BUTk92Z3lKb2lBc3ZuTTdPa3I3V3JkVXh2?=
 =?utf-8?B?S3ViVjJTS2N4UTNEYlgybEs4NHJ3dVd4cUJlWFFuTTVnTkc0VC9MYWZKNmFh?=
 =?utf-8?B?c2JWblNRYlprT2NUMERQTGV5WVJwUEpPOW8wZlRFSmF4S2ZJOWhkY0JEenYv?=
 =?utf-8?B?WTRqWUl5ZGN4eGQ2aGFkTDA5ck5nRjJMelhUWlF2YUVmc2NQbXY4NnFTS0Rh?=
 =?utf-8?B?cGR3WWRnUm9xOFA3QXc2U2VYTElUSmdQRDdVbmY5cnFlRjZJT0FXUHNwT01P?=
 =?utf-8?B?NUhNMjU2K2V3VGF1SEZxam1LRm5lMms2QkZsMTB3WFhaTy9yMjBMblVjMUho?=
 =?utf-8?B?U1lCczJJSkNYQXZWbVQ4S2EzOURZd3A3akFDeTBiMXRiSVJOU2lyZGYzRjdu?=
 =?utf-8?B?c1ptOE9qbzYwUHh0eUJkbnFBMXAyakZzVWpTbFduY0NmWWNSS0Y2bDFER1o2?=
 =?utf-8?B?V0cvS1BrRDNUMXhHV0Y3eUZaNWYwK0NOUzZxNE5SRHB1NWFzdEUxU00xNk5L?=
 =?utf-8?Q?rb4vh/VD1d50kiO+OfgZ/AmxDs24tTW08DDzXVI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860978d1-bce4-4a80-04dd-08d90b2a0c27
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 16:15:47.3207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFbcDIWN9aKcz/pju3dRmY/kUiqy5WMt81nCUK7LgnbaXAl8nzKitVq6JqxL98Yt+KJJJK3opDIP+13AcRS1qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2021-04-29 um 12:04 p.m. schrieb Andrey Grodzovsky:
> So as I understand your preferred approach is that I scope any
> back_end, HW specific function with drm_dev_enter/exit because that
> where MMIO
> access takes place. But besides explicit MMIO access thorough
> register accessors in the HW back-end there is also indirect MMIO access
> taking place throughout the code in the driver because of various VRAM
> BOs which provide CPU access to VRAM through the VRAM BAR. This kind of
> access is spread all over in the driver and even in mid-layers such as
> TTM and not limited to HW back-end functions. It means it's much harder
> to spot such places to surgically scope them with drm_dev_enter/exit and
> also that any new such code introduced will immediately break hot unplug
> because the developers can't be expected to remember making their code
> robust to this specific use case. That why when we discussed internally
> what approach to take to protecting code with drm_dev_enter/exit we
> opted for using the widest available scope.

VRAM can also be mapped in user mode. Is there anything preventing user
mode from accessing the memory after unplug? I guess the best you could
do is unmap it from the CPU page table and let the application segfault
on the next access. Or replace the mapping with a dummy page in system
memory?

Regards,
  Felix


>
> Andrey 
