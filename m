Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB1251E672
	for <lists+linux-pci@lfdr.de>; Sat,  7 May 2022 12:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243948AbiEGK3O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 May 2022 06:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237793AbiEGK3M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 May 2022 06:29:12 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBD8CCB
        for <linux-pci@vger.kernel.org>; Sat,  7 May 2022 03:25:23 -0700 (PDT)
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 247A9XPH015532;
        Sat, 7 May 2022 10:25:20 GMT
Received: from eur03-am5-obe.outbound.protection.outlook.com (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3fwprq80ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 May 2022 10:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUbYzhfJ+6BNo/bwKmaGig69lfLRzGXZy27vyqIX5c/odkkT0B9f2Lm26AcV3jRRAwaLhJCBLaoYIrlphCF3Gjmd0Jr+uInyPnXEXrRG7cpcw7Er6s7CK5Djc7Eab0yGmHjb6/Cd7nV4Bexn38Sn8U0t7inLDlc2F6ijNDpWuBSJ07q4XJrc7jiJhjpueXqaRs+U0QlWEsts3uRuVkEC5duOzV0O/MLMpOxXnDaOqc4VYAQ5ryKMdtuRpvxiGciFcnKea5RivrSX+ZwKBIQ2ztXmt1pHTOlOaYB1XbyZvr+4OiFKlsPeg25xMgXjeKo9Jj93I3PT4GcOlcLjlc+eMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtA8zbGgtlaDJY58jBaxXAgFHPKOOq+gWASuQooQiUA=;
 b=WpfcPPELJ1NRvxRKCgcdtiTmaJPIzin0wL2A9gZ3e51Fvikj0TBly+nBUkoytcX0UtFyJbhHItDeRMUxx2/ih47Bycx6x4CBnb//EdX98Yn13NLqO7phhNPua6vkmUXDMeFF1cGDmsCabrJ74L5nB3Zo9lSHEpW+9ogPC8vXH5lGPX65XPUQ0Xr8A12P3FQ05LDdGyelKhZi1JL2Crjb3QNGi/MY1VQBYkZF2SVWQUHVn2Nq06qN9vD22UHjHnHbAw+pyDeTGsPIUFZfdFD3L7emu4oLQ/p1+4lnj0u1tqjhys1iQg4QYOQ80zxYRrcaeOyR+7Z39eSslJi6D0GChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtA8zbGgtlaDJY58jBaxXAgFHPKOOq+gWASuQooQiUA=;
 b=fmYngUphwD/hpriRf7eCiEpCcgCyhOe1hct6cYhuBnpsYCIG2sFOPJRVZcv8RC/Lg+Vrwd6Wuc93UGiaWw/N7zhj4uJc3aByYPpOBFEPn3MA4gnE9BfuLKnd9xwf9FLVkpV8WYytsYaQ1qkbUrZldT4SXRfs+k1iO9BIgxs5mgS2Lj9TCNnoVZt2w1fqK4vlHMFSG83Ikesa5YuN4K8suiH9cODTiWyIhJe4Ykr/kACsNEapLivwU5B7UGODACVoaIwaRn/P0wfr7fR7zW/r7dHDw5QfJyqDAMbPmE1IvbgGsHpzaRulxBgf94LeuKXSKyncAk+kig9Y/k+CmxQzvA==
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com (2603:10a6:803:31::18)
 by VI1PR03MB3583.eurprd03.prod.outlook.com (2603:10a6:803:2b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 10:25:16 +0000
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::4534:2241:9a1:3937]) by VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::4534:2241:9a1:3937%6]) with mapi id 15.20.5206.027; Sat, 7 May 2022
 10:25:16 +0000
From:   Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: Write to srvio_numvfs triggers kernel panic
Thread-Topic: Write to srvio_numvfs triggers kernel panic
Thread-Index: AQHYX/D7w22LhOQ4BkKjl8Bb5V4dfa0STLQAgABYogCAAJOvgA==
Date:   Sat, 7 May 2022 10:25:16 +0000
Message-ID: <87levdljw3.fsf@epam.com>
References: <87a6bxm5vm.fsf@epam.com> <20220506201722.GA555374@bhelgaas>
 <20220507013436.GB63055@ziepe.ca>
In-Reply-To: <20220507013436.GB63055@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.6.5; emacs 27.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dc38226-659d-4d50-8a36-08da3013e13a
x-ms-traffictypediagnostic: VI1PR03MB3583:EE_
x-microsoft-antispam-prvs: <VI1PR03MB358397C0D03A5A7628FF5A46E6C49@VI1PR03MB3583.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t1MheqhyIMMVTrmcWEGlI/vm/DZry4NqdJpJW+Z7TkzoHLUJ8R/DMpnn+VmqiHlpINSRk4f4/4XBS4H8e8kgDBa6bzOZlK2CR3b5gCzO+HoodrtOU9S1GHL6wIrC3jE250ms4JWlZQGGnEFAIiwBdY7kR8d0LrCT5McP3pubU19a+A2FpmyCe454dTqvhpYZKVWLgOfi+TsI+S8Egu6fpywoH/x25dNLpq+Nbkk8VLeIZjJLuMr7u0VEbvkKpwNk9bKvO1pgjTSFT1MRmF9Ey3wL5/h3uZKeCiJZz8xP3ffZ7MinX7gelKoufXSWPLbnGy3yTO5eqbMt20dd+hK8C+tLSE0AT+/w3fcI7+j10qyhloe8K3hzE4r7/EsCJdXRlyPYHrNqdjLvEVlSlapoJu5lAFr6O8hwEDmagOLYxcTwtI/O5ZKRt3Gu+MWYr1/W3375yH2JEhfZunxCHodCstnN+PakZATFMyVibZA9R7KN7der1XmxIAY8fKtVlEYWBtLhWcymyCwSUwpmu7GhOate///7T86VxAqPZWlBPneVql+asXoz3Tq5arhd4rjIgJxd95wA7utVyP19o93NERZCmVbYUNVwh5Z71YAMza9IqkNKquT5/ugCozzr+7iy2akz7JkZ7/hSe4IiqIuN/Tv0EQKbFRuT3/ZdFi0qWT5BtPddv+4ZynkQCpAtsHkXLsYlYYpeG+OoPe2gfmDWCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3710.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6512007)(38100700002)(122000001)(38070700005)(66446008)(66476007)(64756008)(8676002)(66946007)(91956017)(4326008)(36756003)(45080400002)(66556008)(76116006)(83380400001)(6916009)(2906002)(186003)(6506007)(54906003)(86362001)(71200400001)(55236004)(2616005)(8936002)(5660300002)(508600001)(4744005)(316002)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?26gzqFTFyPs0whFTxNpGhntnHzXecMtbTy48MwyfDuoXUi/+Ut7356JWKP?=
 =?iso-8859-1?Q?RypzL0ppxF3VeetVEsLgQJOvIWQxjynzKo8LiCQYlMaEkyTLZ8kmpr1fxG?=
 =?iso-8859-1?Q?0SvLlsxRaYgMbgRiSsVTcvQ4ELG1RKd45xdLxVauwf1fx/e6tgHgzUyt1G?=
 =?iso-8859-1?Q?zLCXW4kcPe8LOBFURjblKh5lnirYXn0wJKg7TJ14iez8sKB9xpBIvtkR8R?=
 =?iso-8859-1?Q?EccNQGwvVwa0NXFHWDa8NIqkqWAwgnb6UoTwAaw2Y99QbWQ/DHrj8M8Heg?=
 =?iso-8859-1?Q?xyvsf464SkhKf1fNlpiFinSUTskQ5cDI/GjlBimCPhFPOk1aHbG6LuP9mm?=
 =?iso-8859-1?Q?hLZlwOb+mj3C6fJkpsMS+eVJheV0mkmU8vkScx1+UT0vt24TUwTb7Kva3z?=
 =?iso-8859-1?Q?VlLewSa2d+hagljs1uk+27hExT/ZXzL/7+Sdl03k9qqT4Xy/9+f4ymVqTh?=
 =?iso-8859-1?Q?2sPqWjUeLRMzuAEVrMIaQRlXp1fLLc0wreHzCWKnOr2WuW3kGVFCD5b+kE?=
 =?iso-8859-1?Q?TPWuxpKDVeolJ3X5R7mjFH/GmdyC0tAYvOVmT/GY5D7O9kZz/69biAELOG?=
 =?iso-8859-1?Q?2vmjxu9e7QREvIXv3+/aW9cSnimyb37IfZoGpgJrEGi7hmpCS7/t8xQbvJ?=
 =?iso-8859-1?Q?pcizWekVcO5swpDY4W0R00LRQ0Tf96R0nv5HfK9avLy/H0Fqf8qbHrM/fC?=
 =?iso-8859-1?Q?suOxVYQ8WCcLjc8x8hkJpRqab9/oUIkUVbgLiYOUDHOqHTUD+HdNgdpsl9?=
 =?iso-8859-1?Q?WFGDp9v1YdqiS+7Rid9Fva/3BWK/+gt+JvRl5l9w24stjEmb05Cu3Fqxjc?=
 =?iso-8859-1?Q?HlHznJR0R1sn4inbG6lSTav4b0H0pD5+y+Ju46iCXLMVHPg9T82hkhsbRJ?=
 =?iso-8859-1?Q?/MEHBa4f3TQzCfKeABLdykzBWXWju8KxzFO3xkXLQQBmHp8tSNXOu+sy/t?=
 =?iso-8859-1?Q?Hd9ycM8PMu0oV9f2L6wTJciyewaEdZWmtezZpBbFGmZPBlu8FsItJ2U1GC?=
 =?iso-8859-1?Q?1aCqO38l9QzwSLMxjSa2c7CiZBomNZpOt2no8OZa86VjSmFsrn1EnvLGNm?=
 =?iso-8859-1?Q?C4AI91k4fcxOJgQtTBeec/hNiWfXqZCb77XSMUYzrPi93ev1A9BQq6yNlv?=
 =?iso-8859-1?Q?AUH9YFR/xwPOVFWZ3DLuQ21cgUfLqiKVCmGPgo5Zg2jGHVKETx+iFOg0g9?=
 =?iso-8859-1?Q?S3iUU0U1RYmfAf/s4yGxSy6CFVRiKSb5wfA91QDk0hfgvfjneDmAEZUx/F?=
 =?iso-8859-1?Q?7oReP/uiEEC54p+ennOc/+mo25wsCJanW6Z+fjCFET0T//Yu8Fss8kk+wS?=
 =?iso-8859-1?Q?3OjbFq0kh1nqx8jZCKEKl5xUbW6h+ts6tSNjyOEFK00VPClxm9yu2BAXDo?=
 =?iso-8859-1?Q?637VgaQlRSovkGPmfNZDITrdEPG/tgDdymO6PxfPMZMwsQk761f7Ca0LCS?=
 =?iso-8859-1?Q?/P18jR2pg3CIKyAAYntbIKCAQUkncxwSRVddAQoqi9kcMTiv69zb/OwlMk?=
 =?iso-8859-1?Q?lhUE1EefXZSP5JtS/RV0G1fLtIgBzWKDGNM8hnd/fbjCGUqRa97Y56wzGS?=
 =?iso-8859-1?Q?c3HyPo18SWWHm52/9NLWy/7Knrm9WyN+T7GfENEvKuegrcCxwYYn3AfViQ?=
 =?iso-8859-1?Q?Xeg+GNP3Hm+Q8RaAN43xumx594UxuIP0CNhoKgIYYLMTaKnYaGntlHtf3l?=
 =?iso-8859-1?Q?4EQlvMjwpQ5CdeXWH/bjPfruwlbL3+pYxPx0hnDkVcVRhB7HN/bdobrnyQ?=
 =?iso-8859-1?Q?lm0gOZpkKBkwoClWD2vbQNbSLVe0wN3p8PILxgsNKWJoUO9F3vA+kg04tb?=
 =?iso-8859-1?Q?R6kuYMfXZKhxWowA59nN3CEdurEAYC8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3710.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc38226-659d-4d50-8a36-08da3013e13a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 10:25:16.7255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YR7ACqYa/ajhLUKO/u1lqKnYvyJ3w2sQg3alwVJWovpr1mBS6QwglR53wp/uohSumZMX0suzR/HBRgezsZ17oKHHqs72UzoyXbvO8fO5KxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB3583
X-Proofpoint-GUID: COMd3kw_7kdraZJ_Mx2DLCW9CWqHihkI
X-Proofpoint-ORIG-GUID: COMd3kw_7kdraZJ_Mx2DLCW9CWqHihkI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-07_02,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0 mlxlogscore=489
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205070070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Fri, May 06, 2022 at 03:17:22PM -0500, Bjorn Helgaas wrote:
>
>> > Modules linked in: xt_MASQUERADE iptable_nat nf_nat nf_conntrack nf_de=
frag_ipv6
>> > nf_defrag_ipv4 libcrc32c iptable_filter crct10dif_ce nvme nvme_core at=
24
>> > pci_endpoint_test bridge pdrv_genirq ip_tables x_tables ipv6
>> >  CPU: 3 PID: 287 Comm: sh Not tainted 5.10.41-lorc+ #233
>> >  Hardware name: XENVM-4.17 (DT)
>                 ^^^^^^^^^^^^^^^^^
>
>> So this means the VF must have an SR-IOV capability, which sounds a
>> little dubious.  From PCIe r6.0:
>
> Enabling SRIOV from within a VM is "exciting" - I would not be
> surprised if there was some wonky bugs here.

Well, yes. But in this case, this VM has direct access to the PCIe
controller. So it should not cause any troubles. I'll try baremetal
setup, though.=20


--=20
Volodymyr Babchuk at EPAM=
