Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C2B602979
	for <lists+linux-pci@lfdr.de>; Tue, 18 Oct 2022 12:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJRKiV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Oct 2022 06:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJRKiV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Oct 2022 06:38:21 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF152B632
        for <linux-pci@vger.kernel.org>; Tue, 18 Oct 2022 03:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEf7+uaMPQmLCQOqyu7CUK96NYTzWLncN0haWYuaWicn+pDKARs1bPjIhvjTQbrjD5YXWBpOMqu9eaFnYGdUmCQS7XE7INyLhQfF6eYr2AIb1voPZ8Xiqdjnk9ceeq0b+Q2mKDh76Jf60GVnvr9X0OVhXCj6EOFv4/MbSeVfu90flgeh/yFbCVJ5K0r44+JjM+sZOkdkcKFiiwnVVKO61bVTtkig9OUh186ZCmuYH0PCaoUhhh3C2FTyC7DjMwHnbpdBoAn3DFTOcn3F8aS1/5OZjWLLu8VfvnPIxgNDb7qH0/YHAqaCr1phqaU5NMXnfqsXDG7+Cbo+qsLdFVfcVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk9ubTMk1DmB9Ru4OYa8xZwvLQly3rtxxTj5IUSnzQ8=;
 b=VVkOjLOUN7wdxGvPtf6cPi1Y3xRC0MsDlZRCVBJhk8K2PUZsjdJ5jsSR7O3ONyUXzWea+8I5XCPfXno3k/iSoBt0c61FW26fIEXW/wFDDEFzanG+KVUQKpI2MZdmaqfdCPuGTJUhCBag9GIT4WxBH3vNj+GsB4xIhKPmt9wZck85bK07H9k1zyZRvyq/Xj/C7w55Mq1eOzmG8iwjlHsvHKmdbiv+pyeJGOIIJnE9fmCseGN+gVP2xT97A0zY4zr05gEjpTuIJvrTM1Z05uyGMvBlbz8hXU1A3HpAMlP15TRhbdPPJERw6mwbWtGr5PUTyXKNVzQbWOSeQTI/rrQLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk9ubTMk1DmB9Ru4OYa8xZwvLQly3rtxxTj5IUSnzQ8=;
 b=Kd+bpbU/hc0ZjvmyB1248DUm2gSouD8JqScs4H/q2PDw+7qwwEhXVGZUNXiGy9rstuhKhxFfWg1I3BIiBPpQmItexHW5LjAq6PouYNVBTazrR/czgHOK7E1OobEKHlJSQtmSt1xVQOONsn78zsP2Cl1c2+us8T84/sHOVGEptTbdTD8kG8b0P+dundlOebBLD8WLzDAqtJKvOHiA82m+vBn5rl9hdqronrphYWVnbxDNLaICUyfTPcgdySZAa/a+R3/wTo/xapNio0keatFrTd2/n92KEtzbzhwbE2CCYxDwZyhBTAeLjKtdxPbbl0f73Ew3EOXoXV13fcKJzRhHuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 10:38:17 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::774:7ac5:2a7e:4255]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::774:7ac5:2a7e:4255%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 10:38:17 +0000
Date:   Tue, 18 Oct 2022 12:38:11 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH] PCI: fix double put_device() in error case in
 pci_create_root_bus()
Message-ID: <Y06CE+xz2h6dBpC6@orome>
References: <20221018035134.2016891-1-yangyingliang@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dtpwRb0GG8RyHvu6"
Content-Disposition: inline
In-Reply-To: <20221018035134.2016891-1-yangyingliang@huawei.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.7 (2022-08-07)
X-ClientProxiedBy: FR3P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::23) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f178575-c947-4f4d-6578-08dab0f4de5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhcQltGRDk+HuoFlwmEMCxFpk4pIZZPcXE75Cid3Ua6XgSWiPnqJp1WykZuT7H4EVLATGn7xvvxHcztTpN3uerwkcDhVd5lUjTcmo26uWQ69OgVArd6sihn9rRBxbexcCZkW8jW84SqCXP7QJP1nR4FlmwvRdlBfvpB/jf+M7zmBSvUFoC6y1XPHMrgs7K94qs72uIs76Sb42tpvE4ATfynOSoOMpFBJLkn6WlZlpnPuA+G89JE7LEePVuxY0qbi0+SyiFjhG/Bs7IXtCGerbh90wiaYYaJyTgwAouC5uaGd1VQ8HN0/fTVtwp5ROC0fYeXCDWGcGUOTjXl5tOb0hbSjJI35sBaeWMg9c9IQgjma+Yw/kKbHRbAmwWUHBsrXwMvW4MLH1UAjq59aj+Sx0X6cNpCa0KbMeeS4NY8PGBtfJaMAmbJgZnHxvkYH730eyMa8nA6V3/K2JVE7gHb6za0lOtij7ssLdO6Bh9r+0bJGtJo7pMj5GZz9HDjUtzDKfjDCMZz/zuB8ql5Jer6ex/7UsYWVhW5iYkSoKmG5I/mBtx1IvswvKjCbbKAj1FvuJbdrscjxi7QQqEGo8nAvQJCek4mSNhLCqjCB3MksWENXCLsrW1mzc7BtckW8+C/XUBVySDFRCRSWs0PwnX1qHxcIWZpEmkHx/h8C1UaSO4FtSFHQzNOSFy1qb+OVVCG6r/HKc50KEz/+K1LsdP1JGbilLn4/jEF7CvvQTsDoruqBWTTYR3D80dNiKNQ7+ajX+Dgi0evVQkDmR2z+l3ie0Q6saF5maMuShzM/eAtnWhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199015)(186003)(21480400003)(83380400001)(5660300002)(86362001)(38100700002)(2906002)(33716001)(8936002)(4326008)(8676002)(6666004)(41300700001)(478600001)(9686003)(6512007)(44144004)(316002)(6506007)(66476007)(66946007)(66556008)(6916009)(6486002)(67856001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xVoWHp0F7+ihkJJYu9QJAD6fDvwmdTAdZeoFnH9ihsWy9L7qFchG1A6jF7V/?=
 =?us-ascii?Q?uduj1hK4l49TPJIIC06ctX6pS74icypyAs0wmFsHgyupoe0ub/QLvLE2+JS3?=
 =?us-ascii?Q?je0+c73QUFVJUoSAPiqW1hFrfWwIwfcReGJ61Y0tMYMRhAHlPXRLx4Ma51K+?=
 =?us-ascii?Q?SK/AZ8/l2GSpsO5x66u/rU2MAryq+vBiB0v9XXjxYNqmxEaosUyBwR+znNz3?=
 =?us-ascii?Q?3whLwtBi+eyFffQPw8rOkZxqv13GkglkbH4PxU++s3OxpSuJW/eocmZ1lAup?=
 =?us-ascii?Q?NFNrzwXo0AjoqOa32qFqASda2GvPSTZ/bE4PLyovPxnsFaMXeAAtgkvLZksq?=
 =?us-ascii?Q?I63WLrcYWpgqnzX/zqiFHg4ossay6AJrteTo+YYycxrIBJ7gp4Uxsm7ZeCEx?=
 =?us-ascii?Q?xd3bP0BEPvT4LWXR/HInDhx53fcfFry5YkjWhbiNskkIt/gtRJc+Rue9w4Q/?=
 =?us-ascii?Q?Fd55He1JrDJmYwAThQQta9JV57RZ11OmDMxUSi19aujX+8Uvpps5VSNUmmIu?=
 =?us-ascii?Q?4QrAjVeu7p/8RhsCmZ6CiVjKwrIOowBaAGXNDwft734+be2uJKa9UKjIHtfv?=
 =?us-ascii?Q?t0f7hPLjZ4tfXdsARq/yJmHfJ/CjJ/N00uNmYrL+zicEQAOxRGzj37FEOwMv?=
 =?us-ascii?Q?4LwfYvYKrfb1hkRZ7ZEcYPoH1twDes2u94+sgIRrOc7/yxIs1VAJMnfTevQZ?=
 =?us-ascii?Q?TLatAg8N9MM+IgVLwm4wVSy7p17wK918Ak2D68V6aYutoCBd6Lpe9ypt7MDr?=
 =?us-ascii?Q?Up7V6ND+n64Zd8mBGlEzyNekVpNaRD2X+HacQetrtUBXD9CNY4ujEOilbbEf?=
 =?us-ascii?Q?CtnrAyy3p2SupXHn6yqrvrnuFv4aw4zz2oaSC15MMVRH2nl5qNj5fbMpLtIT?=
 =?us-ascii?Q?ECDqufOdjNoTxIg76dCBarLZCEQxda6jyaBejg35pLU5gN6Zm+LzNWRF9GFZ?=
 =?us-ascii?Q?zg+/cUvYCvDVZtSY1cJGm+l1uTNWfE2krZk4EFx3n92Ywd5Yce0ohC7TjhE+?=
 =?us-ascii?Q?up3NycEQZs3XmG94USMPB3qcYuJlLTLFozE6W69VHGwf8QYulAW0iAT35mAT?=
 =?us-ascii?Q?2VqKiZgvX1i3ushLdwTo2bW5o3OVm2KvAqo5/MmiHnxaFtfAHvgSQ+zZbRbc?=
 =?us-ascii?Q?ay0cpt5ZtkDzsLR2QDgDCAPN6VfkPX21bM7lv7Cf3pb37HygNYKiw/h/8HMB?=
 =?us-ascii?Q?CnyFV/7cqC5GEp5YSAZzvytWrQf4jrgdV2jlXhyGhdQxEaZOb4aCZq+bCF/E?=
 =?us-ascii?Q?dGiEMNK6qAqlUZAyUUW0GZUNa8rjxoJw/nf32Q/yEPWez0VsU4Fu87Ef03l6?=
 =?us-ascii?Q?Ry5EafE5gyx9TV0N/Pa5e50g3DlXKYGVDoW0PoYTD0ouYOu3HiHhPVVvCgqa?=
 =?us-ascii?Q?nzAtf03AfVItmhBLnFQwRKqgDTwRegvx0+X54SQ7HjCC+cU+tmngdn53VA41?=
 =?us-ascii?Q?NjTX3K1ridGjihBfvb/FsWsMrATDIW4jxuLrfFEbUl0H6Hi6axSwsSzG1Rks?=
 =?us-ascii?Q?CKhtDZzHAdBrbc2YYfNByC5PdwoHMsyITpaTk/vIITJd4EmNloT891bxnmlF?=
 =?us-ascii?Q?oLbFAQnurjxfw/kb31nXxqkZnit46YWnmYv18kcFlSN0myFJa1qkoWnHN30P?=
 =?us-ascii?Q?ET1dY1g6fvSj7D9eqQNwc1MZevZjtBDk6YepS76gQIxq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f178575-c947-4f4d-6578-08dab0f4de5e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 10:38:17.6677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMU5R4WAddgs4amzcTxmveaUYI2/82kHZudI+NAq47WGoIhdnIWjWFtRzlwMEOOiGSJzPLXw7/QmyQi3DMtNiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--dtpwRb0GG8RyHvu6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 18, 2022 at 11:51:34AM +0800, Yang Yingliang wrote:
> If device_add() fails in pci_register_host_bridge(), the bridge device wi=
ll
> be put once, and it will be put again in error path of pci_create_root_bu=
s().
> Fix this by removing put_device() after device_add() is failed.
>=20
> Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pci/probe.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Seems fine. All callers, as far as I can tell, of this end up invoking
pci_free_host_bridge() which does the corresponding put_device() itself:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--dtpwRb0GG8RyHvu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNOghAACgkQ3SOs138+
s6EZWBAAqXQWYW0QQEhQTHKXbGkdTmJlfp8RCgvrfSXYETG5xIZgZ95bFv6ou8gy
GLlPv88c4yUQjzhp/fS55q6vzWJMNiBfvq7fMo99JN6XguxsLAG5GoGq14KhL30M
UNUpZM31+xmxBH2nWNHgw4nW0MBV6J0EdT7pm54otaXLUqYWw6JEeUO2/xuQqa83
oimAh1ZrutgPj/eM6fiCtw2QURnLKwH99Vz7+GuO4MCCr4xY0A80m2sbh1Oxje59
1WktabR+MJ64mYMpE4E30bF0HV184Gj2poPX/Kwk3VTHPxoIY8eX6EnENANTcy4J
ztxIqlOQ9tIdAdic1p1O5u8ghw4yQwIlARAkCvExtnuQMt7vUURgqwNihYaYTmMP
v5IEimYYC+St7FztRWLzyJmlR+TS9ktApI0FQU2MLZXqKGZk58XjfrTxxXsFFRWu
QiZKcm/2E06PdpmYc7q/Hawa5ZMsbCs3UOJ8x71ANr9/OVGuGxTqdUdn5gDKkEup
1ByC1x1/0W/CnGLP+L3sG7rKg8iwy6Tv+bqjYIccQ/Mfv9h2UZP0h5FLVHLnYTmQ
sSbt0zz76VGnHdz4iVpbrIfwmWy6GYuqRZI4tC5OdplZmbqR9axzArAdyfBDv/yQ
jQpX6oGH6Lt0rdh6krPqdogWFftDfYxfaByoENx/NJQ2YEx1Dnc=
=XJdE
-----END PGP SIGNATURE-----

--dtpwRb0GG8RyHvu6--
