Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B2F6A41E9
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 13:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjB0Moh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 07:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0Mog (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 07:44:36 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5841E5DF;
        Mon, 27 Feb 2023 04:44:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnnmaKQxFPdF4BRRlvqViorWb6whhdChe3K+zPkkIml5G3EHxh2zA+AhvCjYu+yQcJWPywcHTarV5f1tyMcTmpffk1g23vi2DN2QWXLIVo5Swg3nsIoRBRYqArqFYdLStOqdaFHG8M9fytvQRzeXIZLLbMGmDchmUWxXbAce53u4qmYdCLIWyDGZcwkQgW94z7H0a4tkRPltu/ApY4syt6f1K3PJ+1Nbyq4/qaD2eUOnibJ6RpoX/lTqq+AoZ6HNrbTsr5o7SMONeEHHUFgwiG0jfvATdQDlF6O6ykAdyXxeRvg1b23ltTO9HjBjqtxWk5tlbJ78TQzp1x0MFdBhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/f98C2FLEyuLWywX9dYG+79qxiU3gx9elwZfoOYXRg=;
 b=oFcwYcMksT+cuSWC35R99rC6gFLpR93LMfiatZLWKRgYtFlLtTkjeReu/JanXiOIMqBIfwEBPQuVWqXsYGkU2UR593j8hfrzKj3tAw+TOeSiGs7swThBYcYGE3+NaO0fZVp1hv//oCqhlLoIiI4o2nrZ85qHgmkJ1vJAf3l/EAJVt+IpHETcJZ5FXUl373awQO7uNsdDn/p7SiBSQpmXyvUX2lZXgrsyvi6xMg4O2kQpKjlXx3C5gQySXnLdcSpZ5wHBo6NI4tJdt7b7LOBsSqbEscxDaOnoxOkNvD1fWTStSd4mLb7E2TGmad0cXOsmtOHNZSKWgwh9/opGQ7++WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/f98C2FLEyuLWywX9dYG+79qxiU3gx9elwZfoOYXRg=;
 b=trQ/Y32pvfKY2UnTwcCqxgveehIwBPZT7kzlEIVAxWQDXMiCNyyBKrX7jR5HKW2qSb47hZvi4h2CkiHMXQOD4Yc07p9vJb05WT0tFK1amIfLxTV6NDYbZrYGipt+NiwSkstGoRCnzq9hJ7vJaHp3CSWHp9eYtMWyqW8uF6jmtGxlS5lhiNTK161lg6pPTUv/70Occg8ikWaH1aSeL0jUSEaVr1BITIbMB4BE6KBlZmx1CW3JP5C9M0PpOc5YSmxiyadwXtYe9XU7hWU2qgqW6X6ldD/Gc4zYHAzDiY/7YMJFe0lYfioYYZyuy96J82Y7VWu4PplIg+ScJV0soFbeyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Mon, 27 Feb 2023 12:44:30 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::6988:39d7:86a0:fa7b]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::6988:39d7:86a0:fa7b%6]) with mapi id 15.20.6134.027; Mon, 27 Feb 2023
 12:44:30 +0000
Date:   Mon, 27 Feb 2023 13:44:21 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        krzysztof.kozlowski@linaro.org, dmitry.osipenko@collabora.com,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        mmaddireddy@nvidia.com, kw@linux.com, bhelgaas@google.com,
        vidyas@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com,
        ishah@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v2 7/9] cpufreq: tegra194: add OPP support and set
 bandwidth
Message-ID: <Y/ylpaJLMOE6zY8C@orome>
References: <20230220140559.28289-1-sumitg@nvidia.com>
 <20230220140559.28289-8-sumitg@nvidia.com>
 <20230222040317.r2p6zlbumazymluc@vireshk-i7>
 <df054fae-5195-1ef8-c72e-e5afe8d901d3@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JhXF47xoD85VuFp4"
Content-Disposition: inline
In-Reply-To: <df054fae-5195-1ef8-c72e-e5afe8d901d3@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.9 (2022-11-12)
X-ClientProxiedBy: FR3P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::9) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 764317cd-9ce3-496c-6c9d-08db18c05e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBy8SJhO8xbdOBMvXla+RvVvaS6qjW5We1kili6iZb928YnNlHPhTkEWgrVVKlOOF8krHCqYArGxOt1vhWw90vBqDyKCY9aAFUPhbvyftlQcXouWxOS/BSHQKODUuZFrEgypv7J2e0nCrkIYYMORA3kYaJCtkZqgR5GddYvRCqK27sOXsUWultoG2gTWH5YrsVsUqbiSAcZoQ87Hy3jkLgYR4/894cbr6id1tfcslKqpsSvTKrz5BhwFhf/jPBmglVJDW3wbGkIhZilK+xAcEG2JcpeAJan3s2GgxBttt3aNanHnPgFV8g0hz6/Yy+m7bcymLybIAv+O+VTGw0S7bVS2DAYn+rJxrYnMmTqSG4B9p3EMSnVT2XvjI4Grv0q1ABc804xLNA/udkhVqMNY406iBiKEz+I9Pf813UbyxTzSWeGKZ5BejT8s6EYqEBTE7hVbOeKVBN0aJawv7FGA+NfBdnxcyuHHUWWi3iX2FVebyAkfbLaveONm+rxbxtNYc6JdVjzBh1Ub9/ibus1S6skrF4ulqCszPZY6mj7oUUzahss/Wur2P6+2qoUNa51qMLcsZHVG4eM+NNHnapfLRPxO1b63W5JFTo4hdJRDEKryN4b//3gyKpK7/59NGXqSeGBcPgd4c/KmPl8tgLvcnYRAKRmYZaWJbeDISlFZ0UxKjMh9k2xAe3yqU3f+ZOkQPeLXw8wj1rB5zLszqd5EQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199018)(33716001)(21480400003)(6486002)(86362001)(316002)(66476007)(66556008)(6666004)(107886003)(478600001)(6636002)(41300700001)(53546011)(8676002)(66946007)(4326008)(44144004)(6512007)(9686003)(6506007)(186003)(2906002)(38100700002)(6862004)(8936002)(66899018)(83380400001)(5660300002)(7416002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ReUa7MkLBvDbjKxNpF3sdo2/WYvVmqecq5x4Ras2Vu1R9YYu/RsYYvKk8587?=
 =?us-ascii?Q?CQN3zCXLp9B+JHDiSUtOsSaHky4DXIwvklXqE3/T3Z6NIzgDJoFLdi/9WlTI?=
 =?us-ascii?Q?7D2tKAlUQkpI9Y1bJuFazt9ssufs3xYVmISMbOmlayl3nJBnrOlg6ixZpem4?=
 =?us-ascii?Q?BoiryxHkzn9oqZz7GhYRUK68QXoccZL1gRA+TyrvbXv3nweNsfZUwjxe/Dye?=
 =?us-ascii?Q?OO2i8sB72FOGqQQ65p1RBiHnyX7BLyaprcfAUxGWemsypxjQqdGIVzAj95z3?=
 =?us-ascii?Q?LnjAO1RGM2gQJ6sRds2L0YXmbz+yuzFsapfQqVjKcuuBqsZrwQk8zGmGjpoT?=
 =?us-ascii?Q?q0pVYhqvGmnTIL61sHL6vzzEo7NMWYYqFGL/jiBeJRSNwOHuYIDhEFMAeJda?=
 =?us-ascii?Q?r0WIkEIDJhEcAHj07CHpNKOFG4hyG+zrDElfWsXDb70uTTKATBT00EuzUXg3?=
 =?us-ascii?Q?tjARYne/mleVh/O7xp9iciaNk8PgQluwrT3qPmt/kuU35rlAUZ48wV11CDad?=
 =?us-ascii?Q?TTwJaxbQD5AbVwD2nB1aMUEuOXtwr1I7mmvi9JEUQq0eUOlDnyceGOdEidIb?=
 =?us-ascii?Q?AobcY2g44apIM9ylhM/gfEgjgozaBoj4ZQgMNVU25Jk6eS+AxwIVNtdogGcv?=
 =?us-ascii?Q?35WRRjqQ9fTDIYeimbABEcCn23cvXeo8P9KfXLWg3o3dQD9Ow5zOOLOocFN2?=
 =?us-ascii?Q?lj4EhSLyiDeuxIdv3NmWolmshPdJbI7u/OEk8RtFSISSp/ASAvQEK4LCK4NG?=
 =?us-ascii?Q?9CvaE+hxGKAmTA06xBf21Mq4cswKU7gG3gVQwp9pxgi3UO001gCj8abofPxX?=
 =?us-ascii?Q?ixuCpSUFLzjzJgKIfW5kxwxbfV71SJtHZ9CkhQGCDjPWVfBy4Cls+uxGHwPf?=
 =?us-ascii?Q?fa/+9McbYgRCmjpnh+SI4wEGsHNsKQw35mI08zcPQ3ZHkqZslrxxwXUg7e4q?=
 =?us-ascii?Q?e+Jxehze439voJgW1k1WRtvw2J6FfLyvebVo663AoHRLNxcrcXDTxaY1i4Bu?=
 =?us-ascii?Q?LRelvx5xTBgA0hbuziZ6VmQ9PV26zVrO0d4utiy1SL7IzSq+fbE8LbojQ1SB?=
 =?us-ascii?Q?9KcZUqB5dPPKlBFH1Ee64MBv5bUl3616CyKIcUTTnkRHpV3njt1X8Rv1MqM5?=
 =?us-ascii?Q?5Twr9i3TTlQuUuhLqkNHXmCMOA9FS7pCLscDUuMQaFX3edn2HP3nyILiGaUl?=
 =?us-ascii?Q?kwuWYpHJq9EQioRluVTjjFCmDoqyF83rPe3emPHoN1JLclZYSaQkWXhz+pCc?=
 =?us-ascii?Q?Um6F5JYwPunFh2ClCRZJNTBkQasF3nAk6O2/FfiUeoyARYzAfvxijwLyZLje?=
 =?us-ascii?Q?HnWRLt0ZHzE12JG696p0X3/6WF38F7mc66bLwWvPNyvO9eAOtdMQGOZXaVOU?=
 =?us-ascii?Q?7ol6ZNXv6qm6DgjhJrKwFDFW8f2esvzVhuXvgUmQsQeIEY86uXk91wO5S2RD?=
 =?us-ascii?Q?Vis/ptG3d8RvyGmYg1+gJ6cds/IqAxILIS4i5QI8tJ3J1cz2dE6yTKS+HGz4?=
 =?us-ascii?Q?3HF5mxQHy3GO65T0mbdbdsPvYbsXUGTE2YaiwLszg8LGKiVPAPSsWXnZPb0s?=
 =?us-ascii?Q?Z8CtVEFMtAaZXIEoKdDPLo+whKj0ViGzv2UBt/crNceUmifqb4ooZJiCQ/o9?=
 =?us-ascii?Q?1OY1GeRFHuhy2fKGsxb15r/NVehuWMTUONxTjEeiBe8T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764317cd-9ce3-496c-6c9d-08db18c05e40
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 12:44:30.1030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: megVDuOT3616NrhnbTc96zJF4fV/W8F6SMYWmYqHLXZsiLhb2Mge3u7oxALpH9Y0RTwIi6OVSQfhynclOQfg0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--JhXF47xoD85VuFp4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2023 at 03:06:26PM +0530, Sumit Gupta wrote:
>=20
>=20
> On 22/02/23 09:33, Viresh Kumar wrote:
> > External email: Use caution opening links or attachments
> >=20
> >=20
> > On 20-02-23, 19:35, Sumit Gupta wrote:
> > > +static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsig=
ned long freq_khz)
> > > +{
> > > +     struct dev_pm_opp *opp;
> > > +     struct device *dev;
> > > +     int ret;
> > > +
> > > +     dev =3D get_cpu_device(policy->cpu);
> > > +     if (!dev)
> > > +             return -ENODEV;
> > > +
> > > +     opp =3D dev_pm_opp_find_freq_exact(dev, freq_khz * KHZ, true);
> > > +     if (IS_ERR(opp))
> > > +             return PTR_ERR(opp);
> > > +
> > > +     ret =3D dev_pm_opp_set_opp(dev, opp);
> > > +     dev_pm_opp_put(opp);
> >=20
> > What about dev_pm_opp_set_rate() instead ?
> >=20
> > > +     return ret;
> > > +}
> >=20
> > --
> > viresh
>=20
> Tried using it and got below crash. It seems to be coming because we don't
> have clocks property within CPU node for SoC's having BPMP-FW.
>=20
>  Unable to handle kernel NULL pointer dereference at virtual address
> 000000000000002e
>  ....
>  Call trace:
>   clk_round_rate+0x38/0xd8
>   dev_pm_opp_set_rate+0xe4/0x1a8
>   tegra194_cpufreq_set_target+0x74/0x88
>   __cpufreq_driver_target+0x154/0x250
>   cpufreq_online+0x7b4/0x9ac

Can you try to find out what exactly is happening here? The clock
framework should be able to deal with NULL clock pointers just fine.
Although, looking at the OPP table code, it seems like we don't use
clk_get_optional(), so opp_table->clk may end up being a pointer-
encoded error. Perhaps we need something like this:

--- >8 ---
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e87567dbe99f..d7baeb6ac697 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1397,6 +1397,7 @@ static struct opp_table *_update_opp_table_clk(struct=
 device *dev,
 		 * frequency in opp->rates and also parse the entries in DT.
 		 */
 		opp_table->clk_count =3D 1;
+		opp_table->clk =3D NULL;
=20
 		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
 		return opp_table;
--- >8 ---

Thierry

--JhXF47xoD85VuFp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmP8paIACgkQ3SOs138+
s6FQkA/9GQwfLDQT8afea52M7v0dEObVP95WqPe9eP8SGwPv8uE7zP9HKE0OSQT1
cR7m2FTf5b8ax4hkEU6Hs3QaIWEt0sGvMcdeUgav7EiKC8C0ZIG/JEPrfCh4uecC
fXZzUFw1TQIguTuF/nAPcME5RNHt6FoY5Et1mlmeGEG7PKYTTHgvGj07VHzcQM1V
P/+v/awn1VbpPJ+FCMvU9iidcYmz9Pf5YXYa8M7cWbLc/apepfx75rgnRI/TPjfK
yijURhsz88m9wrf8iPYgG9GElim5aCbYRU3DlRuyR0Az30PbyxNygHSGblpBNzNT
9Rqw8ziIzn/tkg8F3/wpvNdauuNoHDbDgCCXYunuv+9rLBW/A2RV1s2TKos4E1C1
61cuB3rMzYEZHEPXDn4ct8oazyu7HPZe9pZcLLkumOjE0t+1XyftqhIX30RLLTxL
67nkK9euJDfwiatToAHq6TU12429INYfAwOkIcpozzF2IqZ+MOlGkqnfCahIa7sz
Oe0YF8Abm9c25e2LzPYdRaNlhVDq0wJmKVkJAr/X2r4p9/n9eSK3ZWLEqkAmASZv
8V+SO2Nv1VOeKU6vNNI9ytpln0Jm4svBoeoEO9wltWqb1rgwX0VrmrJqmfEtEeIX
Z5drNetU+OEuz5SqJrLnEzv1rKHfdWksTFFbvTEdcXwjvfCrT8M=
=KaEv
-----END PGP SIGNATURE-----

--JhXF47xoD85VuFp4--
