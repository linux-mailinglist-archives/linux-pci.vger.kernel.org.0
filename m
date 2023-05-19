Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427A2709EFD
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 20:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjESSTu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjESSTt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 14:19:49 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D0B139;
        Fri, 19 May 2023 11:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO2BE533BXPqkECD6IhYkbe/evTo+V/45ADYzGaJno7S9Jw1Yo3v9OEkNkkPsJoc0YvLAOyPhvqh2vCsj5F4H641P6xqFz5BcMvThwifzg+97HMl5gNRLMfOTxI6uDF62TTCueRoYAh0Kb2oiRHyMHMsvhnR3dhb5WlUy6kSwL5IoZcgbOolqvBNinjz4kAOiTcGV6C19BobkGeDgdFVOwdfX1J5hWr+mAIS0VpecY60Yzdu5C8pNbe86Wj8r/R+jI9x+N7dvbDTRdx19HT3aWitGVw1q6iI1l8QYnjomTkDpAhWTFgvUmAqYBkmL0oYqOwj6O2f5VSN4Q5Kq0k1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wC4kEaFlAoAM/G2jGMBadVCU4PahcHFpgcxEjF89u0o=;
 b=Q8N87mHCBDLU0UsT6Q0B0P02HzCVK9sbN56zjbMqn95/kjnnCFQYeAXxMJ1PxQPyJ2FjTIIleYfnKQWcQMmu0JvdfCMsmESs+w8gRoMmMperO958HAnWDLDOcTzk3BG6FqXy5m6xc+fabX13T7KMd3bxmWxIqxx8Qaz4wHUMzzch2zE/INMcllUmwXDH5WYzJmgz5rzTeWJwxzSibpnKaaFYrsmQ21On8c5xua2fe68jJjRd4iUu66/VcT3i1ol83qSDKhZFhh4/1TCUmDaY8s6KvCx1Ve6pEgV8bECnUEgEd5uXqoSA8pjLMzDJl2ag4q52y7ul4UHFZOe/w7D8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC4kEaFlAoAM/G2jGMBadVCU4PahcHFpgcxEjF89u0o=;
 b=Z1SMRN8lzl3TLHOXXsOWfB5A3FBRClaxjjOXw/b3DnsqqgA/Ad4EkDvKf9h8p7IuMbu96YXPIdGfuYV2RCoVYarYIQ8iRm6XWZixZkfS711WOhI164/yiY4gHCvtL112fZ6tIG5pFWusC3upUMmUgFgXKay/gNtDqBeJbrE4c+w=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8654.eurprd04.prod.outlook.com (2603:10a6:102:21d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 18:19:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 18:19:44 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>
CC:     "kishon@kernel.org" <kishon@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: RE: [EXT] [PATCH v4 4/7] PCI: endpoint: Add BME notifier support
Thread-Topic: [EXT] [PATCH v4 4/7] PCI: endpoint: Add BME notifier support
Thread-Index: AQHZimA1/HTZGCCvNkeTHIvD7zgRf69h5tGg
Date:   Fri, 19 May 2023 18:19:44 +0000
Message-ID: <AM6PR04MB483845CDCBDF5962C3F9D8F2887C9@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
 <20230519144215.25167-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20230519144215.25167-5-manivannan.sadhasivam@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|PAXPR04MB8654:EE_
x-ms-office365-filtering-correlation-id: 767757ce-1460-4a67-5b43-08db58959edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ml0QYoIh6DVkDmIYTPzc16dsveFg+8Y79B+9zEUu07kYfouTPkeQ4N8oJ0nm8JgxCF6eysclDiCXzku6vP16Bzspyy+yuV+0Qe8wtnsspyEy3iZShN77ipVv4zRvxSfZfoOo3Py0/QkTcrJnGVhTsf/9da0N/gt6GoCe2X/zrfd5Vc/R1mFCSwBzs5++nPn9Ma8Y5M+asut705buqmNYVTx06c4s4ye7oq+vp0he/wjtjRhVEDpI225ON4wnA8Pna0rfUS9O2kYBatxIv8P1+gg0sSyEho3yGGw96/WJzNm2m9xHC0iUpRi7DL2LD/HWw+X5OjE1v5ICSN4QDHJ5RbQsD4tpFBsLr7XNT1jo5XnlXPygnWpgwbbShXLFhtG75rmO6MJg9qpGVAXjgJ81MJWcJ84Z3+eyM2LvHqsDlLumWUdraewalznFpxj27IKjkt1zTQEzkVTGH2866bi9XU2Qg5rRwL3zREZy/o1XXqFfvfJyjC7tuR0ke4OJi01c0Icv9KcfbHozjFJD9sCevhHZ0aF188nVgPaFyVyDe81kZ4SADkhw9G2bDN7lWQ4UPB95+N+ntBr0Tq6A69VpGVZK9KKGY2CnHxgUVN9gqSk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(4744005)(6506007)(55016003)(9686003)(966005)(26005)(66946007)(55236004)(186003)(66476007)(5660300002)(83380400001)(64756008)(316002)(41300700001)(44832011)(4326008)(76116006)(66446008)(52536014)(8936002)(2906002)(8676002)(66556008)(110136005)(478600001)(7696005)(54906003)(71200400001)(86362001)(33656002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X4BZIO3wIQCEBs2WarKhbAQwQFUMSwgf1UyFFqVSOU8tSL6uXujPTjjdJvIg?=
 =?us-ascii?Q?LW5peuT7fl+ThW4azxwzYwsbXsSfmweqDGF5oywxtpeJ1HYL+hTp4Lx/QQ0T?=
 =?us-ascii?Q?TbNLhsKdcLlTml8m6eQIr0C/Wpiy5tlmm9WDUf2E7P89aPYhq3GC0ESxEgfn?=
 =?us-ascii?Q?gHD4BuECGGpEzff5PhvzcJrxdoeBSyW7xCuLLB0H6BzK5YLdJMttYp3OquSy?=
 =?us-ascii?Q?hTXVBfsmDwSxaBnU6SRHovt8dl+4yENxrS4OSK94eunfrD6zqzTFYxHotVUP?=
 =?us-ascii?Q?b6GzJgdYWG+hV4WPxilQVFf6TdbNfQPkrVHqFWprnvJkD27aGnr9cVIYOmok?=
 =?us-ascii?Q?D0dX5/u3ZEh+eC7bZRsZ/as4kesJoW4r1yZOnCeoMF7MA/WuASDw6cODHH9g?=
 =?us-ascii?Q?Cjhm70l/6b2n1lwGreFvy74z630yflKtl8n1LVeUOp6ezmXlDKZMYxRQm+j9?=
 =?us-ascii?Q?JXBb6ePwJFrzWpYXyu5zFEgMnv7XheBC6w7DKKLuVKz3C6sk8f/FlirtPed3?=
 =?us-ascii?Q?dPOLfVVhXuZ2D+aklMCcSvCXGSsy27PEIyugu7gkWKwh6okS0Q2ydcQcO4Zs?=
 =?us-ascii?Q?1n4Mc+4zS3LFPlHos2BxbzuaN8fO8DcL55nenLSfLLT4Pb34OW6WMe1GdYKb?=
 =?us-ascii?Q?+F4E5cojJAcxdegPfoti5F0g9Ii19Yy6Zg/uAVH8Bs+GufVBKpaxUTuOhNtq?=
 =?us-ascii?Q?s4YkMU5N05bttzRJCY5cwVSfq3ySPHmbE8EmAZoZRPOW7iRkvyyj0WpCT2fE?=
 =?us-ascii?Q?wb5CS8wfSGVHsJV5Ze8sQXw/PmxXqqG4XUqZgLvVhVNAZLFfkFVfyyTmMS+5?=
 =?us-ascii?Q?j9qpgszTWWC9EYKRPRa8zvb9pNU7200+ISEUXSKEuLm+nt98NvMMnzTAkXV5?=
 =?us-ascii?Q?kpVdjPJ/+GD8ong38x7/rQnubE0TbW/BERV3djTPpibMO+NbyIXVDAx2dncV?=
 =?us-ascii?Q?rgk2Ek0MtPas9pKeCFUCoW9DQJuClc9GjSItZwcSvPw/PURBMd86t9fce8ec?=
 =?us-ascii?Q?bcE1Sz9IBK3Iv6V10WkmjxOAA3Z/SBPq3rI7Hl0iM2GoYRTr602cDIHfEK++?=
 =?us-ascii?Q?B/gRCE8nWYKGA+9a6cWBElmSRpZ4JgnD8A22IP5BYUctiQpmBH2UW7cODBo9?=
 =?us-ascii?Q?mLj1pS7RM2xKYbNRSEtTulrAym40Rbromz9Q616nCkh2OOAJ7J41z927xYJB?=
 =?us-ascii?Q?tzlhr9cwM2A7i0Lq4QVRW0KKynvPVJxH6Mj5q0b1Dfq+XvfbPvgJX6N199yh?=
 =?us-ascii?Q?pKJpxVEW5iOEJhKqqWGbFv/t0uGbgqi6XSbYOVhyoVEbDzLS/QwQeEMF1nJC?=
 =?us-ascii?Q?8Gn4YPydO8xT6uAtH3i/an5YV7sTMf4FvwoJ6prpwLW45I6+wgpTRe7W+ufg?=
 =?us-ascii?Q?nTaaMGSLQL+dwOOvRYifrAoymo8/m41s0xULRPy5Lk/VRHvwEosS8UCIhx7x?=
 =?us-ascii?Q?vcO7n1dmV59TAI8jPLxO2W3Z8dyuvKhiQn1ll2Me5KD1I6w/vPTRlaVSKMo1?=
 =?us-ascii?Q?dXvuCN0r82V87/GZWiRiaMzE06vjEPF/RXWcV8lqgDOhlxyLyGH3BUPA1nC/?=
 =?us-ascii?Q?iQ2J00IJ9YluEf2UJrI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767757ce-1460-4a67-5b43-08db58959edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 18:19:44.1297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jif3pn9u8TsLjSpBjIgornef2aqHK8EvTLCdzeaRjO2pkAk9uv1bFJG4E6rpXYS43EGESskoaEF/lhKcFQaGvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8654
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> @@ -72,11 +72,13 @@ struct pci_epf_ops {
>   * @core_init: Callback for the EPC initialization complete event
>   * @link_up: Callback for the EPC link up event
>   * @link_down: Callback for the EPC link down event
> + * @bme: Callback for the EPC BME (Bus Master Enable) event
>   */
>  struct pci_epc_event_ops {
>         int (*core_init)(struct pci_epf *epf);
>         int (*link_up)(struct pci_epf *epf);
>         int (*link_down)(struct pci_epf *epf);
> +       int (*bme)(struct pci_epf *epf);

I posted a doorbell from host to EP at
https://lore.kernel.org/imx/20230426203436.1277307-2-Frank.Li@nxp.com/T/#u

Can we consider consolidate these notification to one function and distingu=
ished by
EVENT_ID in future?

Best regards
Frank Li

>  };
>=20
>  /**
> --
> 2.25.1

