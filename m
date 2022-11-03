Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60217617385
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 01:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKCA7o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 20:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKCA7n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 20:59:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456CE1124;
        Wed,  2 Nov 2022 17:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM77njvNAk8kbArVLVPxNq2WWjgoDcpX+XuR4hIk5cl4fd4b3A9gs8rWnj2mrXBaHP48X+DxxxeA+mk/CWfMryJ+h42FM2To+dRu25JP5uaOaQ84vytzrRSgjj3oGWqPmT8g+O9YkOVoS1mViL876lNyThiCrkdcDCnHvULgYDRoNYA50Uhfn2OHA8WT/p2aI6MrknbzTbJY9+PO9lilGpL9h53gTRr3/Tg/eyalCiyYg6/dbLqEigOgti6Ore5kgi0bzq+wmxWUhgp9MTnd28B14PkJXm5CZPX0Y6+NlGzY1YD1ryFqY1z4CpkItTW0osF9YRHWGsadxuaHiAH0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrICOEGB3TTp9QqL1kUmWDjzykjfL3ylSs7Ao1ylHUA=;
 b=mQT/ZxgVbe/geCw9rIvS4BIk7ob3V9NkhDdaZNxo6k/Z0tCxJFX1LUn7BMmqTq5vPkSqY2viBceCd10lZY0tc2zfJH7H6os3PzTxLSEBbaLi34SeUdgrBoPdtd7nyRlwIrsYMRjFp2KxRBJaP4uWI1bags1CdCIF5Hp4TeVo0oa+UqxH+02a2e9MPXaWJJqRxsJOnw4CB1CjRDwSQdpf5Zrh0zCljRclGrX/UdL3u1+ox93LDHliKf5r2lAh8cs2j2isPJPlfWVkgvByl4H1i/sOftsYXxOc7xvvouZwHE655KZ0UgC/TcLQJjAG73JHJuFc5bdXlzeRIzCDB6+Vdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrICOEGB3TTp9QqL1kUmWDjzykjfL3ylSs7Ao1ylHUA=;
 b=qzxZJz9OjwkIJD9zssdAw08BzwYJ7PLk/JrjbJYtLRLnTANJ/Atc6g293LeqoDHiE6kLhssufPnc64PpwfbICT+DLasuk8E9FGCFvd6xLhiA9XGATso8051CpYOGNsKvUuoKOm8OFTmdl5beeVErwPz4Z56Ej8E+X/+V4Sme9fk=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB7800.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Thu, 3 Nov
 2022 00:59:39 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%11]) with mapi id 15.20.5769.021; Thu, 3 Nov 2022
 00:59:39 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "mani@kernel.org" <mani@kernel.org>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kw@linux.com" <kw@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v16 0/7]  pci-epf-vntb clean up
Thread-Topic: [EXT] Re: [PATCH v16 0/7]  pci-epf-vntb clean up
Thread-Index: AQHY7sTfJLPzoIaIrEiiaRwl6bIQ7q4sQPoAgAAgBQA=
Date:   Thu, 3 Nov 2022 00:59:38 +0000
Message-ID: <HE1PR0401MB2331F40600929464A2BF629C88389@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221102141014.1025893-1-Frank.Li@nxp.com>
 <20221102230302.GA6394@bhelgaas>
In-Reply-To: <20221102230302.GA6394@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|AS8PR04MB7800:EE_
x-ms-office365-filtering-correlation-id: 5b3f7bac-c453-410b-a86a-08dabd36af1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bwoUTE1i1jB+Su5MC0MvmIipXh2qtfq/JykXtVpZnYHaE+kfXsA3FMu9WakaendNVFJPnxamymOGcqrquWhdMIWAV6O6/bxtNGuxmUbu6YAGTkvLh6iMZIBjfXEtzCfJM0QdMuoxBi8Y58belue7QaWXJKw+I8oYlWxve5uHAPLDvDAhUbbDSf2/JioCtR1xkOoAVLKyCRLj+mtzQIgg4Hnbi2HIFanSX/JHXMCEKxoEFcF6QwQ2sksHAP2mDG8mq9KDXP2ViC0NkBi3TyiUzB1MCFAgZIWjZdeM8ma6OlEHDSk5cdVs1MtNnJqu9eG3qWsY0Gt4vI2zLcIorBAg2yeWorWdJygGrSKh5o7qWC8j25RTvzERTCOrOH/KqZuvFXjGJtK/n774Qmg85ni7Dn42i9dXQmA0HGY6m5F3/V095wGMAzsdR+5dC8m32nemFSKcOvjmSbS4MtTJSl9PzlR9XfwLumjFlb8cauZqXOkoGsBDDTZG7sUOwHhJeoZCvsOKgR3PpeQfmSbNJiHIm6GHBTknGjoEl0JMwM0FLsXP6THuaudcWWCiF8Ji2u5BlP7T4m0XnxA8h3cDmbGozznKPZcLVXGL4GS1GEH3t1zfAsbGzDZ9GkgtYT0PttDd5az416nNHm8/BemKo2w5OZ3PA2bGdlifTJEcN4xgCbxzfUOB3uSKIIWmH+3KeeblPgaxeGyp6BAXh8UtdONC475uz9ToGi0s7tQE31mVBzZIcg2X6yRgsnBMrst3LdQCTPojAxdwrsO5NbU3Xs95fUNsuUu6hkWpdPYaZoC7FOI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199015)(6916009)(54906003)(26005)(316002)(8676002)(45080400002)(66446008)(76116006)(966005)(66476007)(66946007)(64756008)(66556008)(478600001)(55236004)(53546011)(4326008)(71200400001)(7696005)(6506007)(55016003)(9686003)(41300700001)(2906002)(7416002)(52536014)(186003)(5660300002)(44832011)(8936002)(83380400001)(86362001)(122000001)(33656002)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tm2Xh5CVek1j9LV9Tyz2WgrChEGPujp7I72Dx9Zwp5hu1spbCjgtsub2pjTv?=
 =?us-ascii?Q?QW6xSdfEVtQUhDqcibawhkFIjmcDm/9lrLiNRfyFv81quliRlXV8v7nyK+Mo?=
 =?us-ascii?Q?SvD/YgecghOsLT53hUC/guJDgwvyHbqYS5Rm7rynhcM7lokNSnz+IajzJcSF?=
 =?us-ascii?Q?E9DYq/QkBsPofyvQReROmZ57NpW8Yzu6YD2bh/NhKHacDrh3FBSzveMaa4U/?=
 =?us-ascii?Q?McEeE/pEXBEvWnhX6kNUIxvOKWioSKHi8qDLS8s6X6VlRIKO59ULZf+eVmpb?=
 =?us-ascii?Q?RsRVm5Xf84O+cAU12pE2Bl17yg4REoo50BoVdXpMv9I4VHgZALoSjswvucud?=
 =?us-ascii?Q?J0sftN8usU2ytDGmCXcrs+GMRcJ4l9LeukLObFpGZ2EvEJOZpYBa1PlbXN3X?=
 =?us-ascii?Q?DuM+r7wQs1XvbTyvuMGq4Dws//IqVIPEA/WrhVbZsuAU4pG1RDTtXIsLBNXK?=
 =?us-ascii?Q?eWTWZtcNGb+p3FVaQRAAhHwFjWNICAFeedZ4PEvQAjJQwT42KC8u79ikTKj6?=
 =?us-ascii?Q?TiPeOFYsliZsGY1UImFqyA4KW5Va8q89kfNpcbAyVqTa1QwkxFi8AJkhDSj/?=
 =?us-ascii?Q?Jq0KSS2g5pSxzIRWfvyMRabhxVDaePSIHLv0Qa3y0bYx+M4RcZZwjeOrtK2X?=
 =?us-ascii?Q?KglNcGoCxYk6pEWtHpE3+7USuTtWFWQe9zyJvf4s8PwpT59QAIQhbxowQ6wT?=
 =?us-ascii?Q?2wESANPbKiuswvWGDv7rf8e6W/zsa3zOqfoj5/lK29UypEZJ/Xt79ewchmm1?=
 =?us-ascii?Q?Lh4U8gkxzTsHfW8M2GsbmnFAdXhdGF5D1hWZRFluiqbU6cyNGAkSmu+wfLG/?=
 =?us-ascii?Q?d+HE296WeSy8+OWZ4GlKXAHneKET0a7eCpYAAlI2tnxmwfmuxrJfMmKo1X7V?=
 =?us-ascii?Q?Wqmu9f/yJo4Db5sF+pTybcsl4C3Cn2g0pB+85b6ZbUAR3tdgAg/gvgbrbYai?=
 =?us-ascii?Q?LGJDpUTjfsInnE20NexrX4S84cjgCK14uhf/g6Vql9ipnQTwj+jqJhX+9ETE?=
 =?us-ascii?Q?MHaCTZ5n5WPnWISJZFDY+LB5s9RtgrfkvrJLdZDP5iSaqq4gixOQuxDEmwY/?=
 =?us-ascii?Q?0mj/ZffeH6gW2/XNeAEznIrD/Q2HquEZaVwiN5uJeKT3+jrfidrzEZDVz1Y8?=
 =?us-ascii?Q?OhgTCRg3VMUGh4YmZ1mhvTb1lgl36hvyTVsR0BxBJr2v0e7A2GGdQk8Anun6?=
 =?us-ascii?Q?SRVwvUm8YZ5rJJzcDQbUgSLCh2mqrippt1TLp/95/cGXWgPub96H6v7kgpoH?=
 =?us-ascii?Q?OcLGY1IftF81KNNBh9oIPSA8f8+hndJscWegDDJQeqVi2ypX/0J7Elle/g7P?=
 =?us-ascii?Q?6g4LwQAgONqs7wvBTweI4RYbRUlmWZM8LsO82u9k4Y57HG6ge/xhjv3KtEIx?=
 =?us-ascii?Q?9W4XXFxG2nS5rFPKVgtty58oNBqGPauQOKZlOwy6EHE3/G91MkUkOFZWsqry?=
 =?us-ascii?Q?pO9C17zrkMqdkeBOSsn4K2mVmmwTQjn37/7Bhbn5C96prC/B3Pc+L9qLMKDF?=
 =?us-ascii?Q?MuA0URo061hVxlIBEtWJ1nAfOOJL9lcM5+fPYe73L1PwTuAb5Ou7aFUiC46G?=
 =?us-ascii?Q?JvztnNKdg2wVr4hHZ2ShlYrIJ2uBoFDfk7FK8+NN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3f7bac-c453-410b-a86a-08dabd36af1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 00:59:38.9783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3f8ImmKeAm+oCpU3MbOvmuW9tAIY6U6mkAAfNuKfJ1iTb9MPK1oBAtSltZ8YIsHSP9D/96I9QTAoTe+QTTM6ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7800
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, November 2, 2022 6:03 PM
> To: Frank Li <frank.li@nxp.com>
> Cc: mani@kernel.org; allenbh@gmail.com; bhelgaas@google.com;
> dave.jiang@intel.com; imx@lists.linux.dev; jdmason@kudzu.us;
> kw@linux.com; linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org;
> lpieralisi@kernel.org; ntb@lists.linux.dev
> Subject: [EXT] Re: [PATCH v16 0/7] pci-epf-vntb clean up
>=20
> Caution: EXT Email
>=20
> On Wed, Nov 02, 2022 at 10:10:07AM -0400, Frank Li wrote:
> > continue patch series
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> .spinics.net%2Flists%2Flinux-
> pci%2Fmsg130372.html&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7C01d
> f759917bd40de2a6a08dabd2668df%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C638030269909169306%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> 0%7C%7C%7C&amp;sdata=3Dejz4GV8zkQCqKY6fVhpS4Xh2yKmL1661pRdqpnOJ
> xp4%3D&amp;reserved=3D0
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> .spinics.net%2Flists%2Flinux-
> pci%2Fmsg130924.html&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7C01d
> f759917bd40de2a6a08dabd2668df%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C638030269909169306%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> 0%7C%7C%7C&amp;sdata=3DQhWY8%2F0FvNK1hvMM9JL34j5M9I9gu%2BgBt1
> JQEih0HrE%3D&amp;reserved=3D0
> >
> > Lorenzo suggest create new series. Version number continue from old one
> > Change from v15 to v16
> >   consistent subject
> >   Add () after pci_epc_mem_free_addr
>=20
> Don't forget these comments on your v15:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Fr%2F20221101172006.GA1264778%40bhelgaas&amp;data=3D05%7
> C01%7CFrank.Li%40nxp.com%7C01df759917bd40de2a6a08dabd2668df%7C68
> 6ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638030269909169306%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DGmi8t7jCrFXo
> 2LIxd7epeC7aOAlgaw7Xe51zLJq5gzQ%3D&amp;reserved=3D0

[Frank Li] I fixed all.  Just cover letter reused V15 one and forget update=
=20
Patch lists. The real patches subject should be updated.=20

