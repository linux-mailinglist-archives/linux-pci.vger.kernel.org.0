Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430054D9F73
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 16:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241515AbiCOP7m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 11:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiCOP7l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 11:59:41 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B407FF;
        Tue, 15 Mar 2022 08:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjawAqEBaczFsoTtQnBV+TUArobBmw06vA7FDjlWp4Y6qqaW8EBM6SOPN7n8j+0s3CCj82fls28l71RWKnapwFT5nXakK2AxnkLbrwjH/QXusmjUVvSp0jAlkYyithagAfEWUdpFQJ0IIDXOecYSl/lfG0v6JvZifMFxJqS8RFxt68Dt5Obh/7TM9xiHgYVoZuz0YnGfbBxRf+sbBt/3Vy/89mZ1Vu7JOysuJ4YKBgcqb742gbzJHWyVVW7CefX5ijzRiFRT7W3jba6G83kTFle9qcebJUvz78GUc3Y/szZT2ZdmnMvzrWbJ4yq0glzhMtdwOibelco7cUPphAqlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TO0lvzIZBzicXgHc4LRCpsW5J9KlioVbW7HSVlIyCY=;
 b=Hd8UUlljcTcLa4NFSrzNJpWK2TvACILIJumGc5UQH4nPudaQM/rr4qUpkVBL7AOdFVJhEWMLFfb9uV1InesdnmQB8FBOjuXJ14yjz2witQW7aKAyweIu5x+2Rrkxf/lEYlm1FKBJg+DKCZpLWR6L6EIUaNt4LLo4RJq8CNCvUXp7DH6VCzkU/usMy/DV4L9pAdRF5Vw4DvGYmrCFLtQckweFc5mxOMu1sKywPK7eGClhMlIYCw3Q3KiG71M/WciYrSt8QTKxAPiiCGhFhAUmNFyxAlqPNCWwfthuRpt7yYzYm2FX2F3E/qi7HoqstCeG0Oneasky1OMZsT5/leUAMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TO0lvzIZBzicXgHc4LRCpsW5J9KlioVbW7HSVlIyCY=;
 b=cwe2lMenmvSIhJj+7VJKbBI+W3RxpBod8k4bsFdZ/giCjL/RC1ums2KFFQK1gL3ckB05gFNQ7n3Tww6kdNFtKij6Qm5RCMwVsN8ZCslBtf2BdKHBXgd7ESe9043GLq3RSmfGfQj3UhXvVKgDxLaOwR+XJRF6a8D8Dc8JVLqLRyc=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL0PR12MB2548.namprd12.prod.outlook.com (2603:10b6:207:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 15:58:21 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 15:58:21 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Huang, Patrick" <Patrick.Huang@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] nvme-pci: Disable LTR for simple suspend
Thread-Topic: [PATCH] nvme-pci: Disable LTR for simple suspend
Thread-Index: AQHYN6s11lpv+m4M2EGlbRG9RhUBVazAC4mAgACPmDA=
Date:   Tue, 15 Mar 2022 15:58:21 +0000
Message-ID: <BL1PR12MB515720F8E10EAA9A34FB9AF0E2109@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220314135537.1565-1-mario.limonciello@amd.com>
 <20220315072233.GA2288@lst.de>
In-Reply-To: <20220315072233.GA2288@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-15T15:58:16Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=21227781-34d7-4a30-b37b-97ccb61c7088;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-15T15:58:19Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5a382613-4cb6-40d6-bab2-364c67d3586b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a15acb5-baef-4e56-456d-08da069ca127
x-ms-traffictypediagnostic: BL0PR12MB2548:EE_
x-microsoft-antispam-prvs: <BL0PR12MB2548C957B9C4A23F04E1EC3EE2109@BL0PR12MB2548.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vY1aouMYvCMlfOX5LNo9T4oEa+uyhsLvqPuKJM2wbRiryi7MLgdONyInQanoYYVQ6yXPybBONhNBlouTqTGclFulCWCdcEENEURjPY6YOPTFtdP9Nslg73KCf/UPPef5jvtHzxDvJYPUN0WQotjQc/k+qu69cbB8IzemEfLmn71lBFe2PDtfedOnUnsjGF8PbjretFyzdhieya4oJ6UexQrcd1dR517Sr0FTfT/ng+/fHiW+MkVVmHw6+AShV7M7LRhtp6iv20aqpmZN1KJC8Y4puLfheLSiW9dXcc/Cu3hUxTgGdwuOAYK0JLizfA+4s54WR/LBHN5ZMfem7r27QlkZkgkeSEojVAzZfR1Gy9Trn2uTSBP4y01XRgu88WhAeNqbkwrB9dtWoTFNOLtL0/AXKQ861k+ylyx7ruMY9VGP6ocJI1V3VHNfOdaHGSyoGEgi7qTiwQ7clLZGnpGxwRsJ82TyLCpET0avGQutrtkldn/XlWFGenJrXsG+Ios+3ZDBf/vFiE6GwNcJocxnkab3omhXAkZ0Aot31w8J6A6rDxEz8KSIV82MM/TzI8Mc4pGOPN+khJl1cBxLWAOcx8AM89p4zYjTgO2oJX0/5TcjaryofDNNmhU7/o+/u14M21qx4RzSnwWppDs/VH3K0eErNkH4XoRtVbxS91rv7NzT8vfWPbDR/e6u+v7V/QK2FBF63xHBL3dmC+q+oLt1Yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(83380400001)(6916009)(2906002)(316002)(54906003)(71200400001)(9686003)(7696005)(6506007)(186003)(508600001)(38100700002)(76116006)(66556008)(66946007)(66446008)(66476007)(86362001)(8936002)(52536014)(64756008)(8676002)(4326008)(5660300002)(38070700005)(33656002)(15650500001)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qCoOzGktr2RpYrpJDjRebBw0JMQj1agV78JYMdTxnTsebFUvAQ2MvOuEVwpi?=
 =?us-ascii?Q?H08aBVowi9pAyFTLf85MonqSYhUrujzhO7WAlWquag4bkzfYuQf5xS0d8jyO?=
 =?us-ascii?Q?QFNOIJyhaD3mGvKCgeC7uSHrk85k/zSUaGDEuLCv3PtvV/0o6TanuPhe9O5O?=
 =?us-ascii?Q?iOI/CAycf5M5//ojWxJGqUA8nPdbKfdJYJ8HSN9iTqx6VTtrg7rF4scjvUtX?=
 =?us-ascii?Q?Vi0v0wH/aHvbnzj9nxy23VSgqsuCX4/2R+kN7ifEiUBqw54CbLFGWC5alaNs?=
 =?us-ascii?Q?DfwGZepJd4AObJz4VgECBlNGvlNA+Ltrq06OGdKLBq38/+R2RwekLeyfUiGu?=
 =?us-ascii?Q?gQM4f67cAgAKWz3RVrwTxKspm7PWvD1kuKPqSvhiYnbKZSjMlKvahAdAxQIL?=
 =?us-ascii?Q?xDGTTzdlqqiXUhwalZrG5q/RipWiNIFlX0lfqtXHt2Y/abfB7yhx7phCeKJ5?=
 =?us-ascii?Q?n39i1PGoZUZa3o+3UNguCd7xCzeKi2hBPegenFCzBtzUyIpMmlkkKmMs6XCU?=
 =?us-ascii?Q?Vp4K2onWv+rHbDNkeOGWfHfuo/VUqqv5b6DBbJjXvD86QZAE4IFLQOOe7wab?=
 =?us-ascii?Q?tz3GLTuwqLnPm/CoqsSy7dxh3Z/JCgcBiFGqBzJesMcNjlX12N3v5xE3MKvU?=
 =?us-ascii?Q?hd5uS83EvfSln6/2muHPG6e5uF4znnXpp1nQgCtBGSsaRMXGrz+h7lfxJm46?=
 =?us-ascii?Q?k2zUDJd8b7YgVmapmp3CJZpZ2ZX/2jOHVN/uKhfBL4EANksF2OiaIw+kgZ02?=
 =?us-ascii?Q?24CwZYAsHf2l9S5giU/tIQ8kafGHVkX6A5nlN3Vprr9EP24xqMFh+3jTnKEc?=
 =?us-ascii?Q?YSej2HClSGqD6Nbr2d9abogSzCuApugs7DIVgeNVZvtpZnt60x/Ss5ImFC6k?=
 =?us-ascii?Q?6u6k+eHRxFH9vTFLc2Zdftf1qy2WQ7PwlUyqXJbMiuvg4k5wJrPf3AWZBQDB?=
 =?us-ascii?Q?4hny5MbRw+fLt8OymsHEN0UU3kgygZ60dgvAtMJJduyPlUPXR9MIK45xK9fj?=
 =?us-ascii?Q?A07sQhy9SvLBPPc5HNsvjXip4DunYlpO76S8oZLPvt57RFvohJIQobuKvNWQ?=
 =?us-ascii?Q?ZLaUI848vpa4D7TYF/pmIzdqPCXSnytq+DysYDjz5zKpoxi3KtvwicgUQzgI?=
 =?us-ascii?Q?JEO8lED3o0xJH0lFYm/BCbaJsjJ2p4lsAuV0Zyb/DtYV4ndYrKf71tIeyYzB?=
 =?us-ascii?Q?J94pQbwIbb1gNEgpXnx2mIPdmQLoZb4DJj5ap0/IbqQwmSqRRXGIS+Fie/Sv?=
 =?us-ascii?Q?MbgqXC1+Pbwzo/1IVokfb0D1rszaF7k7xDqutGE6rUiRSzo2qvPhcKzgmEvX?=
 =?us-ascii?Q?CCRCDpPVeO6mA39thttMKYMXjPH5J7ncDsETJ3BpmQC3k8ORxa8eMyRL1T90?=
 =?us-ascii?Q?cuCLV9wwuptrpI3Jcz5+h2kiiKejdPXGEv2Ju2to881FLlqfzUE1Qv6oLGf2?=
 =?us-ascii?Q?vEKifEOz8kMOzdjHIaEXatkH5C1Zs+2pOX5vk9w14hdv8/jPM32a81fFp0aw?=
 =?us-ascii?Q?TQUIcUkOhLU48r6EBIINO+KDY+u2Ll09Y1SE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a15acb5-baef-4e56-456d-08da069ca127
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 15:58:21.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrrfbOY5Ab0BKxoe8QnDQH9NrX+d2zPoHwRKdnJy2SKaqPKlEZRhuiFC82US6Yq2X16mPTHbuNoKynu8IwNVmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2548
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]



> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Tuesday, March 15, 2022 02:23
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>;
> Christoph Hellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>; open
> list:NVM EXPRESS DRIVER <linux-nvme@lists.infradead.org>; open list
> <linux-kernel@vger.kernel.org>; Huang, Patrick <Patrick.Huang@amd.com>;
> linux-pci@vger.kernel.org
> Subject: Re: [PATCH] nvme-pci: Disable LTR for simple suspend
>=20
> On Mon, Mar 14, 2022 at 08:55:37AM -0500, Mario Limonciello wrote:
> > Some drives from SSSTC are showing stability problems after s0i3
> > entry when the Linux kernel is in s2idle loop if LTR has been
> > enabled. This leads to failures to resume.
> >
> > This appears to be a firmware issue specific to SSSTC SSDs, but to
> > avoid this class of problem, disable LTR when going into s2idle and
> > simple suspend has been set.
>=20
> This seems like a giant hammer to do this for all NVMe devices,
> why not quirk the specific ones?
>=20

The thought process was to be defensive against any other drives
that have this firmware deficiency as well, but point taken.

Will rework it as a quirk.

> > +static void nvme_suspend_ltr(struct device *dev, bool disable)
> > +{
> > +	struct pci_dev *pdev =3D to_pci_dev(dev);
> > +	struct nvme_dev *ndev =3D pci_get_drvdata(pdev);
> > +
> > +	if (disable) {
> > +		u16 word;
> > +
> > +		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2,
> &word);
> > +		ndev->restore_ltr =3D word & PCI_EXP_DEVCTL2_LTR_EN;
> > +		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
> > +					   PCI_EXP_DEVCTL2_LTR_EN);
> > +	} else if (ndev->restore_ltr) {
> > +		pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
> > +					 PCI_EXP_DEVCTL2_LTR_EN);
> > +	}
> > +}
>=20
> The calling conventions of this function are rather strange by
> mixing up two very different things.
>=20
> I think two PCI-level helpers to disable LTR and return the status
> it ways in and to enable LTR would be really nice to have here.

If adding helper functions to PCI for this, it actually begs the argument
of whether this should just be a PCI quirk.  The LTR behavior is tied
to how it behaves in D3, not based on anything that the NVME driver
has done.

Unless you feel otherwise, I'll rework it as a PCI quirk.

>=20
> >  	if (ndev->last_ps =3D=3D U32_MAX ||
> >  	    nvme_set_power_state(ctrl, ndev->last_ps) !=3D 0)
> >  		goto reset;
> > @@ -3239,6 +3259,11 @@ static int nvme_suspend(struct device *dev)
> >
> >  	ndev->last_ps =3D U32_MAX;
> >
> > +	/* If using s2idle with simple suspend, disable LTR to avoid problems=
.
> */
>=20
> Overly long line here.
