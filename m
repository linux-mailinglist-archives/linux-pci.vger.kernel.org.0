Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27393797500
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 17:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjIGPmq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 11:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243734AbjIGP1p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 11:27:45 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0602.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F2F1BF;
        Thu,  7 Sep 2023 08:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB5r5pGk8K4fmUt3k47rvpXKCRzwje4GqhFrjJEpF72SHA3nZlwdk25h1kL2Sl776dOWlWyzYoYVyu3+JonFJlpEQyEB8y1RMUQhwqMN+DwCNYaqibcYX4Xj7KmgTJL8dFI2DstuWbjgnupywRna0Za8w0e7CWwiJENVt9H5ESoFuNLTIitN2RjcOF+2nka1kfpt0cLbUJ5PYc2VVeXRHKEA1mmWpYogHxCUlpW654wQD8dCngW91Hjhj6Yc+AFA32jCO929w/lI3SbF1VOPlGa2WmrUK4jW4DkG7bTdlu4bsct3BBVG9PxgcadtSnAbQ/WRfpKYwbKt1Vh/nSajXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY8XzdNiYboXAV1d8i5yP+GzvTbAaOMww832LVridIs=;
 b=VVu3PQOuk5UeuslojoyTld38X2zIqL99HbueTYkmjdYp5uzNJ+JnJiOxpNiB3W08B6rjos/IW/DTnh82iKstH0zqrvDgWQ62pO6B4mf8fOxfGnNTmjSXip/15dFIcUTO0k0nPebfb30NKUTK4SEn2rgjfzrZZBW57RySVgLi+LD9HT2/ee1/QobD3TYE1LGDPHGvsxloSLy2Mhv7Vq3Yp4l+9mV3QuGrRSHaiIFk++1ujUbe0qSOq6Hk6H0eErEajVQOAW/EC18Os0ntvCE9uIJOe/o4yhzVosS371oS0MXkaIr0IAbBqWNBDQP6rLL0KcE7LAAxA4Uz8vVjdzAnkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY8XzdNiYboXAV1d8i5yP+GzvTbAaOMww832LVridIs=;
 b=VCgn7rtYCecBzHkNGB/Op4yz7EizRpMNsZY6tWZ7mObyQgG/CWz8TS0oPMcpTcfHPRyRIoKuqi7gvvv7Gy1MNupOIJbMm/aiuQUt14IZsTY5tClZhCzCLB/XXlezUzSna0ddMwhAIvg+/3AGyZLtTTswZwVu32y2fb9/ePMNkkE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9064.eurprd04.prod.outlook.com (2603:10a6:20b:447::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 05:54:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 05:54:44 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
 which IDA
Thread-Topic: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
 which IDA
Thread-Index: AQHZzxhuyRkzZgDao0KEaKWaunEMhbAPAT5A
Date:   Thu, 7 Sep 2023 05:54:43 +0000
Message-ID: <DU0PR04MB94177C282FE6E37C46098A7388EEA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230815013744.45652-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230815013744.45652-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB9064:EE_
x-ms-office365-filtering-correlation-id: eb386b5e-9436-423b-bf4a-08dbaf66ef58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RQ9zzUA+82IX+X/OzbSQKAa7wsRzEIePMdNAQ/AEm1V2Ah3C/D3AHA6FGwKJ6HbpNjzCiZbIjCP0DLOpXJElq8hcgdUexWcliWs6NufBrxm6YSdCDpTTqqlkhVUFJWnGMtkBHpidbskk2R/Rl9IyVq5jtxk1ZT9Ff59COTtSAhe3UHSKFUiaLI/aAwRhuvFIGcevKu5PbPA5kOPIdZx2KLKUEoHlbqtuWW39FxrPDn7KGQUtgae+XBZ/do6YZY35Eua19oLtScZJ8eLWxuWITsXKyT2PagB2FyCVmYCS1jd+HarQrh9n03KZIKNqFM3R98NCWbD+oAC/H8HjBokyBjJluhZA9XjE02X60wNMXMYsjVycr6sM7SEgYjYJT/Dzh+U7e1YVjt6c9pb5s3zTS8w+stb5lMrUX4wwj2+cFiagueBMsbX1NN5mzYiaYCfUHnPpVpVuPOUQFYEwrJLi28qdrGY1hvzPhpzEG9R+xlKs7x5g05zque7CHq/wESGl7KkuluM8avQv3idOi3S56uwPTsfowpXjQI6ucMPfkgt63bJ0WVCRmxjjgzqt4Q8HPUZ/nlKoFGwltwNOF63zheZnTJ+Q0yCgdPLJn+/ViG9IQ1o+eGXx+RB8mVgtf7Xh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(376002)(346002)(186009)(451199024)(1800799009)(83380400001)(122000001)(478600001)(26005)(55016003)(7696005)(6506007)(71200400001)(9686003)(2906002)(4326008)(5660300002)(52536014)(8936002)(8676002)(33656002)(44832011)(54906003)(64756008)(316002)(66446008)(66476007)(66946007)(66556008)(76116006)(110136005)(41300700001)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fns1KpCDZADtOCaV9vdaoalzDAAIa57xi1UaWSjhCew343Gg8QzAgWGuVBcM?=
 =?us-ascii?Q?57K1+sSiaHZBvUEj/gx/vpeEGQH+CTx5a1yt1FmQnCQ7TyUhTRk1vYo5v8M9?=
 =?us-ascii?Q?zXE8/gcIelcxF9BeyjTXguJjmfnF7qFMNn8z3Hvj9RIlr05X2k7Yu36xIQrr?=
 =?us-ascii?Q?dciZT80RsipjejCg7O/kXw/K1XFhFW5D7yv9MATzbqQRKmV42xL/JONS3+QL?=
 =?us-ascii?Q?g6EbE6+wRVTgBunYiLwWcSmEMcwgvL3q3IzxXpUmvxzXdmvjh8joVse35yPE?=
 =?us-ascii?Q?Sb1IjLpZ71lIA3j15WADFvgwGziQ7eeW7X3yXbQp/fhh/dcK5zvjNfodcYD3?=
 =?us-ascii?Q?jJlO9YyqODTj7cN/HkLMhWbJEdbM8FROoXQo3cGn/nJM5m/sCQnykFvZQlPJ?=
 =?us-ascii?Q?zYMSahfqilHgSr1835t1Kb7uG3RztFIU6VLGu5LO2jE1267e0nQmH0t/Nhmm?=
 =?us-ascii?Q?S7nyOgJ8MdcTCRQow8TCMQaoAN/Ec/qgDFfH0kXlqPmqiaBZc9RRoa+Dnkrx?=
 =?us-ascii?Q?MY+BEmotW3zfMNEuhqWL4uhJllIFd/qFN8wDvV5+Sa5vgiYvv98LLFfeDdnC?=
 =?us-ascii?Q?CTSewavhbbysPaQnlrE2XqlBvEPBj2rYeioTCVoDrRQymGF2/pWEu67sXkrY?=
 =?us-ascii?Q?doHb5oui8OAIq/BfUwlzTHTBg40clZAsP3cbK606prYLzMKMTzmmiCD45wKL?=
 =?us-ascii?Q?HigqyOpBKe08PiDl+k6Rc5+jYaiHoDHqaCNYkY1LPGzPjQc/KeLN1BRWU77D?=
 =?us-ascii?Q?LI7Np4sifHIQjkux3C5CpFARBkzqjNVLH8WmHp9n7Q3RZugaSDcSlVDf06fq?=
 =?us-ascii?Q?ccRVfAi4rZf+1lbnKK7YLQ/bIyOOxwtCtWEpuTmP7Rly6WCvVbeygHGLuEyN?=
 =?us-ascii?Q?yCKq5xdPfO79QM5/svVaBHfPHwZjpSvBrxrELPtQeWivuTVU1yFqenhHEfv2?=
 =?us-ascii?Q?5PB+LtA7SjpWFU9bb4yItdvgxPd0n2HBaYKiXnKNspYXEb+9kn4wRfKV24JN?=
 =?us-ascii?Q?+70XMQnYP3+5sVuX/tzOjuGaid8wOJSzfDXsLrMA5OKomvpWptPKFpFh27wT?=
 =?us-ascii?Q?ie15gKzdj8QSC4SLdEdY+RbP7WVA8TLP8zVTQozaEI66rR/pjVXAy91+XMXR?=
 =?us-ascii?Q?Hfnxb0BOn3yDpfHybBOSQ+iNemFxsM8QL4mOONlQNhjpTV0q61uvttKiTba3?=
 =?us-ascii?Q?+v51Tz1SXxYDIHPNI5CMj5D8rFV27amfPQjUQ7vVV1Vj9eKSPuFtwXfzhu/Y?=
 =?us-ascii?Q?DKYvAcHlsAyriAQO28ui3OAkt3235lV29PGZkwluzNDgWQDkcC1XZIiI4Nu0?=
 =?us-ascii?Q?VTPOnNkWFfT+/Vb/zVvVTd7DK8Sw3jL/pUhWUsqO3gWP6hApVIYdUfW9xDBn?=
 =?us-ascii?Q?5VWyDg0pS4YT28Ve5ZqFpaRI8GtPJaOZUfMEC1ro1VnzCjFhE9qYL06NYGPJ?=
 =?us-ascii?Q?TWKBCh81JlnFYW4PigM5LYEwz3alxuFxtnHUsz9DkQ+qoMVntvMV0/uORhDz?=
 =?us-ascii?Q?pllaTwJq5kL7zyIDUEjbX9m17gY+IjOd5vTpsPmTYBZXcz/2umQcttJnWZ0/?=
 =?us-ascii?Q?x8FUBfVMcvwi6VofA2Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb386b5e-9436-423b-bf4a-08dbaf66ef58
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 05:54:43.9627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /M/jUo4Lu7aPKazpCfnQQEoW6+CvBp2RGI+Yvr+IUbeFT2YfCZkRjLy1ZNvaWpJNCxsfQ+tvB8zKNUwx/bp+aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9064
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> Subject: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
> which IDA

Gentle ping..

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> When PCI node was created using an overlay and the overlay is
> reverted/destroyed, the "linux,pci-domain" property no longer exists, so
> of_get_pci_domain_nr will return failure. Then
> of_pci_bus_release_domain_nr will actually use the dynamic IDA, even if
> the IDA was allocated in static IDA.
>=20
> Introduce a static_nr field in pci_bus to indicate whether the IDA is a
> dynamic or static in order to free the correct one.
>=20
> Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V2:
>  Update commit message
>  Move static_nr:1 to stay besides others :1 fields.
>=20
>  drivers/pci/pci.c   | 22 ++++++++++++++--------
>  include/linux/pci.h |  1 +
>  2 files changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index
> 60230da957e0..5c98502bcda6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6881,10 +6881,10 @@ static void
> of_pci_reserve_static_domain_nr(void)
>  	}
>  }
>=20
> -static int of_pci_bus_find_domain_nr(struct device *parent)
> +static int of_pci_bus_find_domain_nr(struct pci_bus *bus, struct device
> +*parent)
>  {
>  	static bool static_domains_reserved =3D false;
> -	int domain_nr;
> +	int domain_nr, ret;
>=20
>  	/* On the first call scan device tree for static allocations. */
>  	if (!static_domains_reserved) {
> @@ -6892,6 +6892,8 @@ static int of_pci_bus_find_domain_nr(struct
> device *parent)
>  		static_domains_reserved =3D true;
>  	}
>=20
> +	bus->static_nr =3D 0;
> +
>  	if (parent) {
>  		/*
>  		 * If domain is in DT, allocate it in static IDA.  This @@ -
> 6899,10 +6901,14 @@ static int of_pci_bus_find_domain_nr(struct device
> *parent)
>  		 * in DT.
>  		 */
>  		domain_nr =3D of_get_pci_domain_nr(parent->of_node);
> -		if (domain_nr >=3D 0)
> -			return ida_alloc_range(&pci_domain_nr_static_ida,
> -					       domain_nr, domain_nr,
> -					       GFP_KERNEL);
> +		if (domain_nr >=3D 0) {
> +			ret =3D ida_alloc_range(&pci_domain_nr_static_ida,
> +					      domain_nr, domain_nr,
> GFP_KERNEL);
> +			if (ret >=3D 0)
> +				bus->static_nr =3D 1;
> +
> +			return ret;
> +		}
>  	}
>=20
>  	/*
> @@ -6920,7 +6926,7 @@ static void of_pci_bus_release_domain_nr(struct
> pci_bus *bus, struct device *par
>  		return;
>=20
>  	/* Release domain from IDA where it was allocated. */
> -	if (of_get_pci_domain_nr(parent->of_node) =3D=3D bus->domain_nr)
> +	if (bus->static_nr)
>  		ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
>  	else
>  		ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
> @@ -6928,7 +6934,7 @@ static void of_pci_bus_release_domain_nr(struct
> pci_bus *bus, struct device *par
>=20
>  int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)  =
{
> -	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
> +	return acpi_disabled ? of_pci_bus_find_domain_nr(bus, parent) :
>  			       acpi_pci_bus_find_domain_nr(bus);  }
>=20
> diff --git a/include/linux/pci.h b/include/linux/pci.h index
> eeb2e6f6130f..222a1729ea7e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -677,6 +677,7 @@ struct pci_bus {
>  	struct bin_attribute	*legacy_mem;	/* Legacy mem */
>  	unsigned int		is_added:1;
>  	unsigned int		unsafe_warn:1;	/* warned about
> RW1C config write */
> +	unsigned int		static_nr:1;
>  };
>=20
>  #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
> --
> 2.37.1

