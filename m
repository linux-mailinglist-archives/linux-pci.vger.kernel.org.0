Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A3752E563
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 08:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbiETGxE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 02:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346070AbiETGwv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 02:52:51 -0400
X-Greylist: delayed 3605 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 23:52:43 PDT
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02hn2205.outbound.protection.partner.outlook.cn [139.219.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268DB5DD30;
        Thu, 19 May 2022 23:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DijlEq3DIVS0MrIsKoiw6VE9wojWDidz+lLIIkCF1DzIh/ZvBdLk1cnZuIFuUCWyHiXQ6AZpY3tdkEDevDYDfjqXSPMRtqgMuAQWsofeBxR8VFplqVAVM96EP7d9iSJjegfcCRj3KUb2mbTC0tCrz7HRVCG34PSrmXRvyhtCJRvUCc5z3Y3AuGScKNRYPn6/t1AAprtFIFDGKZNvwDTsoH2DTzt6J3j6F6R3s1YyZO6aWYIsAYm8JpHeTYbnerfk4ibtPQLdPKllNa/ibkE0CzECvMbaPjBTgMc9tvKNxcPw8IzfWIhJMqupnGmymMBQtWANR/2WFzzn9s1hbdfVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=X8C0I8wXWzk/h1b68CpR/1FhhbmA1l5QU8/NCIkCfLwXu19Fv1FkHVY3b21/aKLkEUiBBqSV99gcDfg4fQht73keZ5P0TZ4kCK3r1ejdgr5xHC2yrCHMp6888wHX334G7kPKdoAepoS69OlK0DC5HtLppgOJuo4gFhnIvG3+Bmm4h3be+YpJnGerEhRkxwvcCth/JkAsYSmNau9kzL+P0mp+/iOMGrLXxjDENbK6nvxfdwp9rXx5YtI80gSwMLPicpBECVde48lr8IC3GxI3mZJaX8OWqz5vdELezwRvO6EPQXTE4NhLPc1vvuiVcATTCUrmyURLrskjQHFusDCmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gientech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=pBOfCmd6Eax4Dix1KIJ5OoeMlNKvga3lOqW8aN4d1DoFGf7mNvuE8stIbEQ9kwV2SHb2UZmYdg08VXaQUVepusy9gjg0TFLwwXbN/nHY8AMBZ31fOmz1FjVNaa7O65SIMIxb2grTZXtobFQAjMgRfRskdsNtvfph2RFoAC/dGIJIyAxsPHHRAYStQGuNahtGFXyY8IxsE16K2ptJz/Nd60up+Rw5Yjly3iaUtYqg6GpFKJHwCQey7sMutXrjS6ihC7hrrlocExpVAgrbtN/MUzr7xI/fO4WpgsLPnRX9VynfYBMdw+X9o/8YivK7O9V7kXTE+XmCKY89jJK/r2xaiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn (10.43.110.19) by
 SHXPR01MB0877.CHNPR01.prod.partner.outlook.cn (10.43.109.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Fri, 20 May 2022 04:18:33 +0000
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19])
 by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19]) with mapi
 id 15.20.5273.017; Fri, 20 May 2022 04:18:33 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Ree
To:     Recipients <cuidong.liu@gientech.com>
From:   "J Wu" <cuidong.liu@gientech.com>
Date:   Wed, 18 May 2022 21:19:13 +0000
Reply-To: contact@jimmywu.online
X-ClientProxiedBy: SHAPR01CA042.CHNPR01.prod.partner.outlook.cn (10.41.244.49)
 To SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn (10.43.110.19)
Message-ID: <SHXPR01MB062327BA74E7CF340D4CE6C489D19@SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f2fd228-075b-4dc8-8710-08da39141b97
X-MS-TrafficTypeDiagnostic: SHXPR01MB0877:EE_
X-Microsoft-Antispam-PRVS: <SHXPR01MB0877E1D1087FCEE9BB2C20CD89D39@SHXPR01MB0877.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?hAGH2Ch5uoYHeWyAWPSDWQzjwZed8tz07W6TTfEPwCORsOUyZ6zrwQJ+1T?=
 =?iso-8859-1?Q?R3U5t4HqHXOmBhjVE+hV3j1mtNbzDz7gUYLFop80Pd3ut/kX6LHdp8M0iV?=
 =?iso-8859-1?Q?yX6gEqgGpHzaDBlTK6YraC12Bb6AFa40zFyie+siQSruxyC/+Sz/doZVFM?=
 =?iso-8859-1?Q?SgPqZQsv88OX73W9MstjClSSmEk1f0HjrJ0/48q47KA6c6emCR4xm81yCr?=
 =?iso-8859-1?Q?5pPSwsnqvV94GpxH2HQB55XPI4F401/Pu59/N4M+MgFcJiiIkGzDa9dpgV?=
 =?iso-8859-1?Q?n4Q3SVxyX9qHQGMYLAQp7bOEUrYJ/3eMIoyy1lnWhvF7v6l3A9k2Zq3FxV?=
 =?iso-8859-1?Q?+mz9MjX5os4yvfZGV20plYXPQHk12YD/MRopQ+362EuDWEcSF1CNzqo8i8?=
 =?iso-8859-1?Q?sCsP5uvmR1Vyb/ZAmzIdlB0JhaXpuKQMFvQbMQzO/tFSIwapR2yzq0T0C8?=
 =?iso-8859-1?Q?cDLOY6Rzb3vy6AkJasZVTeXW9Ice9UphvW7UmGh1PiSKhebvk/EyygJCyo?=
 =?iso-8859-1?Q?l7twZWuNF7sKQiEjP+jD2VU+ifjheEDHoIuK3B73nru06Zy+z5z0nMeGG5?=
 =?iso-8859-1?Q?pSue0REUZ6BmYEPZ6EB+riL620vKF22yWq1eN+Ka4XP+3tyxs8plyK3oQX?=
 =?iso-8859-1?Q?gSQnmr1kLJIjAj3FtlMFjqVmQ/1O4kXu4KItJ6icZQ5hUemQMUeDe/gJDH?=
 =?iso-8859-1?Q?lid0HbEgVrfkVc+TG1LyvI3mZ0xcRH8QDUf1ULy59jAujzQqmb20tV6sMw?=
 =?iso-8859-1?Q?rXX0HFq8bi/tmGw1xvDFgwQranreFjcSqpYxdgbFYg/B3T2GPQKbI7Z+4O?=
 =?iso-8859-1?Q?3mgluSPisZlW8qE1x1yV08k0wcitK/5Xg80DIGA3jaDfcK5WqdpJrxZ31w?=
 =?iso-8859-1?Q?3LEEcfXb6Yl+LfNRrUMI+kgG/t4qMot3eJvrJ9NU7xIAsBs5ikThH9Bqfs?=
 =?iso-8859-1?Q?HTHMk5YVZPyYoDBZlC5AWh5sFY8g0JCYYbx08VPFaKVjyg15mPAR0u3dsL?=
 =?iso-8859-1?Q?6Lu2/xg6aCLE1PnIEryBbOoKY3omLBEqEJOKg1u7o6idihX+vNSuWkOBeO?=
 =?iso-8859-1?Q?xw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(19618925003)(6200100001)(33656002)(26005)(4270600006)(7116003)(38350700002)(38100700002)(9686003)(86362001)(55016003)(40160700002)(6862004)(8676002)(3480700007)(66476007)(66946007)(66556008)(508600001)(2906002)(186003)(558084003)(7366002)(7406005)(7416002)(7696005)(52116002)(8936002)(40180700001)(6666004)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QmdX6U0nl9zD4PZwWc8tBuGpBgbaB1t9Ixx73SV2QY0TKUu/xnS2A1Jgbz?=
 =?iso-8859-1?Q?WYxyXU0B2GOsmFxm7s98en5Y2G0+GApOsW3L7qt0ikKAbyAbycEM73PrK+?=
 =?iso-8859-1?Q?KiYGpFcklSwrPUdU5EKlBSzDUgkWV2r525HrRh9BdVa6oUJ/plLfBIxnFF?=
 =?iso-8859-1?Q?l7ZdJlQReWF+2YKDBJ0bAuaDYExKlcNvf+plkM3a8JLKFgpvQbwzcFY4qW?=
 =?iso-8859-1?Q?LNLSN/GTgSSwbev+nRCzyWrL1van5SuWXLIl/6/VWFNTgPvis3eI3NHv+9?=
 =?iso-8859-1?Q?m7CKMTHvMiHBaFeNk/aaF/vB8p0RN4+dwf1dFIIEAEHnNnAYK2V/oBL1kC?=
 =?iso-8859-1?Q?4dv/9PaGLUN2nPevkridRSU2VJtzA9mv06TJBb3j/5k5nYxBytG7HmxClR?=
 =?iso-8859-1?Q?r9BzpY292arvPwCZb/ZJ3TaHlq637sM7IQN+Lu3VrUXcvFiRp+hcIlPc65?=
 =?iso-8859-1?Q?yRS2ETnn+Ni9orruoMVtmo/Eg987d9q8ekLaRCxYzx3XMerpG2mfZX//vc?=
 =?iso-8859-1?Q?JKqvFU4nPXoBDMM1VUATmV9iIYVJ+yQUqPxl0/ZoZEJfxfPV6nxs2ZQ1//?=
 =?iso-8859-1?Q?I5N3rEeS3BT23Z5fwNN3YvHwR2jmiK63MBtWVaWhajEljmZiH+Yw9DimUR?=
 =?iso-8859-1?Q?Oy2QE7xhiOvZhFZHWlcnP0Xp++IR+e5eYKqYeulB+6L4bxo3xd06UJ4x/g?=
 =?iso-8859-1?Q?88FXlhzZQx+NtJbhsUcy+kLYCViw3MU35lLunw2+bvW15XYumFVOIPPhEo?=
 =?iso-8859-1?Q?PrZC1m2Bk1A8n6319ZISy6CHV6deAvlJI7oy3/GzVNrLEP1/41+z6jIPCC?=
 =?iso-8859-1?Q?O/UW4PY0RRucM2uZf2ZDOpU/Q9epUDxTZx9cw8iZ6+x1tFpMYAn1YB8o80?=
 =?iso-8859-1?Q?AcW0cTHlJx6CM+ihpVi5mu3WlE43pTPFmAn8YXFMFmSyvjW6rpgSzA1ZLT?=
 =?iso-8859-1?Q?/pw15OZLZGvWYqFfjjieTR1gE/mOlcAJHYVIfY9Ggj/8ruzbnqyY60jX2Q?=
 =?iso-8859-1?Q?iJkCQPuQp6TQtlPUZIVRvMQdyeler9ijS/NLUT5cVzhYLQl/bnZXx46ufq?=
 =?iso-8859-1?Q?ZrGp/kYfn/IT4+YMWooYwqWVhwrx0zVI5sVJjn81D+kH0piKC/G9wsPkHd?=
 =?iso-8859-1?Q?wc+DRaDWPl+Cm3860NLDoDg5K6gLDlCB+EE++AwvAtVaaIZI0ekreFTwpc?=
 =?iso-8859-1?Q?lNuQpllu8kJK3X+Jn3kEJBRlw/auSm3vDXmuJ/C7V8OiAI8eavxWDTpdQF?=
 =?iso-8859-1?Q?LIUttO9Ft9P2VxmN5uzC25OL+xSxlfqZtbAEAxWS21g9UcsUHGZHz60wee?=
 =?iso-8859-1?Q?9LeA8H3jN9/y24oVZdflc1NUqJWTRcgPPbDDN8KFoQNJMh4rQKfBu4sVcJ?=
 =?iso-8859-1?Q?tJ7GD8zCVWtZ7On6S7H73EIl1K+JLgm3eHWYzMA0faSy34i3F7x6UQ1LC+?=
 =?iso-8859-1?Q?RzU6UoLgGwbIbnLBz23ItK7hU5Aoch4BKpoGasTcZO/wKlmVAfFknRCQEH?=
 =?iso-8859-1?Q?jw3U1V90/gb3TK3O1Jdw2i6wcze+JuFKcm6w3xiz2LX3TJ9QwWemowpYjW?=
 =?iso-8859-1?Q?ULdbkH19sUsUAe0ZyOZKmX6gqS7bT9JYsGNh1Ld6Qfj8tZGXlFMEaspxPZ?=
 =?iso-8859-1?Q?uZpCbYtEXKtuFv9mVXpXIwlpwJE3FIFAPKG72sB4X7kKX8+4cc/DozfDyc?=
 =?iso-8859-1?Q?L9YDi9OuvD9Wj7Wtm0kvZxY76jaPP8LXLc89S1RdyRK18CBt4UhCGrHsA0?=
 =?iso-8859-1?Q?9MzA=3D=3D?=
X-OriginatorOrg: gientech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2fd228-075b-4dc8-8710-08da39141b97
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:19:35.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hTPvNkRVMmfXSjUaT6FZ5vK+kMuF9qsJyWSlh/57IGslT2A/oqBPA2OBWUNkjApsqF7xBaVtpw5N6B+dyfXr1AU00+/W3Sg0faWuXApIGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0877
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,DATE_IN_PAST_24_48,
        DKIM_INVALID,DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Can you do a job with me?
