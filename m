Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3F87A8883
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 17:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjITPgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Sep 2023 11:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbjITPgU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2023 11:36:20 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1FCC9
        for <linux-pci@vger.kernel.org>; Wed, 20 Sep 2023 08:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3tYThIog/Es1HWAM8NWsrwqfi3hmuhntn3nBqP9uVra+08mYo02w0L/sE+Ebp+9TdNJzBGArQaWKeu8ffKM1PmOPOQFn1VaoW0yqT2RM7k8qdpDvoy/DcehhUqMx9ouTcX5IzvCsqny0FJZ9mzPrWaFp+1gCXsoDCq4SKMQY5wNQaUl+MOdc3ciolrnZKlU+bhOy35VymPPqyEucaFeV4pkhX7G13mEBmJGYyTRbjzD2W3/W3uJ40hwkUBxMlsUIt8Zl65nCnGmwZb4Gzk11KSpdlbb7txfQPg43urC5Mlne7ZlnTJP69iquF1UEywtM+zivKoCPBvGBVnRBWqS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anNCTGcea7KuNlV4hk7LEZUkxOY5O0GqdrnVi8U+n38=;
 b=m2i7AbEDb4vXUfTKdnVV4yfENeWnurNhJYqsUqZjNMprUVDGlOhHijJfDBRB6b0bRNfAxiEb5BJzm2FZK4PsTmNgKHbzMzakpor59NuX67N/D+GBys/t5YrahjcJ/HRin0wUcpsF8gQwk55Sn8MR07+L3RM++vpzdofT1HFt+dQlOu7VbNE3Md2GGun3rJXQonZcj5EITrXCAGOI0NJnN/O/BkRG+V9SyomdkUWpyBuGnh9JYVvGyrtONiDIprW8sXfmm6T+pEFhkAAtkG72RWv6WAllJ3rrl9+XMjTcPrq7mV9wKV01a3+yQh99jxxj4MtRQXPffTpSh0yBCndsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sonifi.com; dmarc=pass action=none header.from=sonifi.com;
 dkim=pass header.d=sonifi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonifi.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anNCTGcea7KuNlV4hk7LEZUkxOY5O0GqdrnVi8U+n38=;
 b=NWC1fJboZWhyk2XfVuJQu1dVb7Hhh3kiUP/kUh3yX3e5Nkh1QltRcDK07JKKP/WFOT0mU/ZsBjb9eCTOtP9bPyB6/+z40Tzr0NyHxUbgx12BzMzaX2F/K7QXqpiPnVHvIJDBco9Q6IE2eVqu+11238tS9nrip0EC1QJx9ANITCM=
Received: from DM6PR16MB2844.namprd16.prod.outlook.com (2603:10b6:5:125::22)
 by CO6PR16MB4020.namprd16.prod.outlook.com (2603:10b6:303:a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 15:36:11 +0000
Received: from DM6PR16MB2844.namprd16.prod.outlook.com
 ([fe80::e388:4a68:f3b3:dafe]) by DM6PR16MB2844.namprd16.prod.outlook.com
 ([fe80::e388:4a68:f3b3:dafe%2]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 15:36:10 +0000
From:   "Schroeder, Chad" <CSchroeder@sonifi.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Schroeder, Chad" <CSchroeder@sonifi.com>
Subject: RE: PCIe device issue since v6.1.16
Thread-Topic: PCIe device issue since v6.1.16
Thread-Index: AdnrA833YItLbJ18RoeS78Ya55oDogABhDeAAAA8E2AAB4WogAAllm7Q
Date:   Wed, 20 Sep 2023 15:36:09 +0000
Message-ID: <DM6PR16MB2844D96B122B820099D3EC3BB1F9A@DM6PR16MB2844.namprd16.prod.outlook.com>
References: <DM6PR16MB2844903E34CAB910082DF019B1FAA@DM6PR16MB2844.namprd16.prod.outlook.com>
 <20230919145921.GA8609@wunner.de>
 <DM6PR16MB2844AC71B336A5AD50005221B1FAA@DM6PR16MB2844.namprd16.prod.outlook.com>
 <20230919184127.GA13587@wunner.de>
In-Reply-To: <20230919184127.GA13587@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sonifi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR16MB2844:EE_|CO6PR16MB4020:EE_
x-ms-office365-filtering-correlation-id: 9f422044-3600-4224-6191-08dbb9ef5018
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MaSuIfnx2ttYUy36X5otQ/rTjgjCAG1QMeqy0JWVsaC0akrXTIFFRFg8S8lbdw6t7UDV4Hmr+nvYCxUqRuqsNa/QF4XZIBbIA2WgpK4Ks1KQvgZadJHZdb1p75oPO+mpMiz4F2hVYw/o8mEEf9u37Pqc7EZaPxPGyE4BT5PQEt+PRA6LpZhmR/5L7/Y0Ows1V6qRnLDE2BmpxNF0uS3vZ9f/O1s4Q0JIq0iVZ+8WoeQZA+UWlwwbH4vfypTWdKMO3UoRn/DnIqTOf9hfj3fiW7uc6Q4vQWz8rYSfgvuu+FsrZ92rkVyUEWvKYK51GO5lG0JmJDcE5XqzGLvkTS0NqwgNBZZTip/W+j1JWtLgYAWDtq8XMjTNVZBAGs7X/fL6j3ZFsURBp0ZbekZ3d/rfifXRzv+aKOm/HfPum/lz7NryfeLCuoYzKapg5QXCZXu146R66bgjijHqmPnhQMm5WewP81rW+1lNu0/wAmKqHPqWmpt4D3oP0oYcSV3f5cd0zZ+gIovc9OCaelSW1YLf+r0MXNieQN8+4B7Vel3+bVIXx/8n4L978YUo2ZbLcI6dKLOsQfiepFMZt/C6Rqdchp1yMqdU0NrG+LE/Jns3yZIhpBMgNUwhkNHTjE9oNx9b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR16MB2844.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39850400004)(366004)(136003)(186009)(1800799009)(451199024)(55016003)(38100700002)(38070700005)(6506007)(7696005)(33656002)(122000001)(86362001)(2906002)(9686003)(83380400001)(71200400001)(478600001)(8676002)(8936002)(5660300002)(52536014)(6916009)(4326008)(66556008)(41300700001)(66946007)(54906003)(26005)(316002)(64756008)(66476007)(76116006)(66446008)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ssG3FgqWD39s9y3m20aZq4FwJZChGp3EOZFnGY9C6f0w5Mmda3puwYi0U2ki?=
 =?us-ascii?Q?DerFeLHXiUEqo26xeZ8SCTCJgsuaJ3XZ2mxA6gn1kRY2bxyfAS+5rSH48S4j?=
 =?us-ascii?Q?WV6Dm1jaRB5ltoLZ9cpKe76bt0ychril5SoveCUmzwa0yo/QxldGaTss20mT?=
 =?us-ascii?Q?kjZ9MOvhMa8RQXmaag9gHVpoJLwbk868C3vETpOVPkOiOIZhNnrwj89qtD3B?=
 =?us-ascii?Q?lJjZ+I6yFzazqaxLmbzE3VGd3YVBafwpI1VIwI1tsNNpvWTqyJW7Wwk0hB0S?=
 =?us-ascii?Q?pWNfrn7rqnNychCdnvdT6rqtLccPVZIxoQrS/cB3A2l9wBaRB2ML/B0MXvzH?=
 =?us-ascii?Q?hxbFFHW+8whitu4PrcqtDcYb3CsDLR31jepxrrkdGYMWWNh87y5M0+YMZk/0?=
 =?us-ascii?Q?O+ENU83dNdpP4sz4YESfukW3ePzA9MlZmcguoQ2PyakiKxkoKgoLHgaTvSIW?=
 =?us-ascii?Q?o2+fJqQQA9Vx1M2mD9ZeOqSmDxuZrX7zOjgZSkXEtxeJg2+g4U/JKIeF6j1H?=
 =?us-ascii?Q?iJOLw4shm2hTuCEasF4lmJ6Gdn3olipZ/Cbri/PmOTsQvOTjrcrBx3tX+aiK?=
 =?us-ascii?Q?SK9SAPmKFuDkNcwoQ/DmLEhg8GXlf6Xu09U3z+/1uyvF6ejqe3CFQPJMUrcq?=
 =?us-ascii?Q?PzyTsGWAc/2ElbGM79H4aQP+mdwxfGaibX80h3Lj272zYzeYuUPiYp7Spy64?=
 =?us-ascii?Q?jmlXa57KR8qEbyRsd3UTskhBhZ9rRJTiB4+Tg0Dyf55ETEQPTQrcNL3IIuvW?=
 =?us-ascii?Q?VoSwS0V4ShMkrXWNXp56gBIncsP88ziG09bU9yM2hY1uAnxq0qhuXc15PhU0?=
 =?us-ascii?Q?QHZ/mZvNMAQrdD5O1NHuNCuEE6r0Y8v5/hYbePcw5vwP+8IBDorVP/EpQ3yV?=
 =?us-ascii?Q?u9sRpyQ+j9zfyhDiuUqolDpmx6zQxzMJHpcuTpuNZg+oFa+rc5HtGHFysBRT?=
 =?us-ascii?Q?w7b1XvB8Ri0DOnNDcLUQZAe4Od1znHyZlWZMvgN0RjWgtE4HdDpyGoxEeQAb?=
 =?us-ascii?Q?X87WxxVd5tXkSM0tLdSuXweju324SvFzHCrq9MRteC4Lwn3VJAkz9GAfKIFg?=
 =?us-ascii?Q?ZhofB5yUxEZi4gpD4LwtRMpSOq8RFRiaMlcUqfc2NulAbZRpAOkWuts5YH9w?=
 =?us-ascii?Q?Lq0jWkE1zbuMruNtyK8JXoIueOyRmC0s1ADg+MH1QJaBJoCuy3e9aHPUzV1H?=
 =?us-ascii?Q?bgLyIwmscqv6QLqPVMiT0NvXGDAs7eQ5ytIqy36vosgDbTKMobL7PmrwntaV?=
 =?us-ascii?Q?XuV1lJCcrl4JtPAITLCOdZkjX77Vc2qx0GKP0iGpZxFj0O7RX7Bd1IRolPRM?=
 =?us-ascii?Q?T7D4ZtG3Q+3WTe37kpsWvLtrivrvig+lR1wtcadEwu/nXRZu5xNRSX8n6Lrq?=
 =?us-ascii?Q?+G/uVVjVbgAhjiJCRqqwIivGfMOB/xRWb8Kj565KPkFzyJbzW95d4UtoPiGS?=
 =?us-ascii?Q?+/3ERX8KU5G6KzRwSlpB2gWP8k+BeO7vmol7pky7b9LBjiWbl1SX9BrCs5kW?=
 =?us-ascii?Q?Q6exkec4O9R5H1acsU3U5pOCG92PjJntDOfJ9JpdT2q5M6sqBe27nCpbUxOs?=
 =?us-ascii?Q?NU1SLgfnabLRt+xEOZrpZ0+9tGX3hn0949Z3niMs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sonifi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR16MB2844.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f422044-3600-4224-6191-08dbb9ef5018
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 15:36:09.5028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d7d50e09-0988-4b46-977a-bbfbd3e792a4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/FJsI5CXi/Yr4IY5Fo+sG8raJdSsR17E+MKmScAOr13iHreBQKttfa0NkW+I4Ws9gSS0C5ZSziB2bjQ/zjplQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR16MB4020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Which leads me to believe that the longer delay before the first config
> space access required by this particular card is a quirk.  So I'm
> proposing the following patch:
>=20
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 20ac67d..3cbff71 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5993,3 +5993,9 @@ static void dpc_log_size(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31,
> dpc_log_size);
>  #endif
> +
> +static void pci_fixup_d3cold_delay_1sec(struct pci_dev *pdev)
> +{
> +       pdev->d3cold_delay =3D 1000;
> +}
> +DECLARE_PCI_FIXUP_FINAL(0x5555, 0x0004, pci_fixup_d3cold_delay_1sec);
>=20
>=20
> Could you test if applying this on top of v6.1.16 fixes the issue?
> (Apply with "patch -p1 < filename.patch" at the top of the kernel
> source tree.)
>=20
> Thanks,
>=20
> Lukas

I've applied the quirk patch to v6.5.4 and it does indeed elicit the same s=
uccessful result as the original ssleep delay.

The device and server are functioning as expected.
